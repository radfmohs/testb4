// =============================================================================
// notch_filter_cascade.v
//
// Parameterized, time-multiplexed cascaded 2nd-order-section (biquad) IIR
// filter. Behaviourally equivalent to the MATLAB Filter Design HDL Coder
// output it replaces (module "filter"), for the default parameters below
// (NUM_SECTIONS=4, DATA_WIDTH=16, COEFF_WIDTH=16, COEFF_FRAC_BITS=14).
//
// WHAT CHANGED VS. THE ORIGINAL GENERATED CODE
// ---------------------------------------------
// The original file hand-duplicated everything per section: 4 sets of
// delay/storage/prev-stage registers, a 24-entry one-hot phase decoder, and
// two 24-way case-mux trees, all written with literal 5-bit constants and
// literal bit-slice widths (e.g. [40:0], [29:0], >>>14, 5'b10111...).
// Adding a 5th section or changing a bit width meant hand-editing all of
// that in several places and getting every magic number right.
//
// Here, NUM_SECTIONS and the datapath widths are real parameters. All
// per-section state is built once with a `generate` loop, coefficients are
// passed as arrays, and the schedule (which section/coefficient/register is
// active on which clock cycle) is derived arithmetically from NUM_SECTIONS
// instead of being spelled out as 24 named "phase_N" signals.
//
// NOTE ON NUMERIC RE-VERIFICATION
// ---------------------------------------------
// The internal guard/accumulator bit widths (STATE_GUARD_BITS,
// ACC_GUARD_BITS) reproduce the exact bit growth MATLAB's HDL Coder chose
// for THIS filter's coefficient range. They are now parameters rather than
// buried literals, but if you change NUM_SECTIONS, DATA_WIDTH, or
// COEFF_WIDTH for a *different* filter design, re-run MATLAB's fixed-point
// range analysis (or re-simulate against a floating point reference) to
// confirm these guard-bit counts still avoid overflow before trusting the
// numerics. Structurally the module will still work for any NUM_SECTIONS.
// =============================================================================

module filter #(
    parameter integer NUM_SECTIONS       = 4,   // cascaded 2nd-order sections
    parameter integer DATA_WIDTH         = 16,  // filter_in / filter_out width
    parameter integer COEFF_WIDTH        = 16,  // coefficient width (scale, b1..b3, a2..a3)
    parameter integer COEFF_FRAC_BITS    = 14,  // coefficient fractional bits; also the internal round/rescale shift amount
    parameter integer STATE_GUARD_BITS   = 10,  // extra bits carried in each section's state/delay path (precision headroom)
    parameter integer ACC_GUARD_BITS     = 2,   // extra bits carried in the shared accumulator (overflow headroom)
    parameter integer CYCLES_PER_SECTION = 6,   // 1 multiply cycle each for: scale, a2, a3, b1, b2, b3

    // These two must be declared here (in the parameter port list), not as
    // localparams in the module body, because CNT_WIDTH is used below in
    // the port list itself -- and a port's width must be known before the
    // body is elaborated. VCS enforces this ordering strictly; some
    // simulators (e.g. Icarus) are more lenient about it.
    localparam integer TOTAL_CYCLES = CYCLES_PER_SECTION * NUM_SECTIONS,
    localparam integer CNT_WIDTH    = (TOTAL_CYCLES <= 1) ? 1 : $clog2(TOTAL_CYCLES)
) (
    input  wire clk,
    input  wire clk_enable,
    input  wire reset,
    input  wire sign_en,
    input  wire bypass,
    output wire nf_data_valid,
    output wire [CNT_WIDTH-1:0] o_cnt,

    // Coefficients, flattened so the port list works in plain Verilog-2001
    // without needing SystemVerilog unpacked-array ports. Section i lives at
    // bits [COEFF_WIDTH*(i+1)-1 : COEFF_WIDTH*i], i = 0 .. NUM_SECTIONS-1.
    input  wire signed [COEFF_WIDTH*NUM_SECTIONS-1:0] scaleconst_flat,
    input  wire signed [COEFF_WIDTH*NUM_SECTIONS-1:0] coeff_b1_flat,
    input  wire signed [COEFF_WIDTH*NUM_SECTIONS-1:0] coeff_b2_flat,
    input  wire signed [COEFF_WIDTH*NUM_SECTIONS-1:0] coeff_b3_flat,
    input  wire signed [COEFF_WIDTH*NUM_SECTIONS-1:0] coeff_a2_flat,
    input  wire signed [COEFF_WIDTH*NUM_SECTIONS-1:0] coeff_a3_flat,

    input  wire signed [DATA_WIDTH-1:0] filter_in,   // sfix(DATA_WIDTH+1)_En(COEFF_FRAC_BITS+2) style, offset/twos-comp per sign_en
    output wire signed [DATA_WIDTH-1:0] filter_out
);

  // ---------------------------------------------------------------------
  // Derived widths & schedule constants. Everything below is computed
  // from the parameters above -- there should be no other magic numbers
  // in this file. If you need a different bit-growth strategy, change a
  // parameter, not an expression.
  // ---------------------------------------------------------------------
  localparam integer IN_WIDTH    = DATA_WIDTH + 1;                // internal sample width (adds the sign/offset bit)
  localparam integer STATE_WIDTH = IN_WIDTH + STATE_GUARD_BITS;   // section delay-line / state register width
  localparam integer PROD_WIDTH  = STATE_WIDTH + COEFF_WIDTH;     // multiplier output width
  localparam integer ACC_WIDTH   = PROD_WIDTH + ACC_GUARD_BITS;   // shared accumulator width

  localparam integer SHIFT     = COEFF_FRAC_BITS;                 // round/rescale shift amount
  localparam integer STATE_WIN = STATE_WIDTH + SHIFT;             // window rounded down to STATE_WIDTH
  localparam integer SECT_WIN  = COEFF_WIDTH + SHIFT;             // window rounded down to COEFF_WIDTH (per-section input scaling)
  localparam integer OUT_WIN   = IN_WIDTH + SHIFT;                // window rounded down to IN_WIDTH

  // ---------------------------------------------------------------------
  // Unpack the flattened coefficient buses into per-section arrays. This
  // is the one and only place that knows about the flat-bus encoding.
  // ---------------------------------------------------------------------
  wire signed [COEFF_WIDTH-1:0] scaleconst [0:NUM_SECTIONS-1];
  wire signed [COEFF_WIDTH-1:0] coeff_b1   [0:NUM_SECTIONS-1];
  wire signed [COEFF_WIDTH-1:0] coeff_b2   [0:NUM_SECTIONS-1];
  wire signed [COEFF_WIDTH-1:0] coeff_b3   [0:NUM_SECTIONS-1];
  wire signed [COEFF_WIDTH-1:0] coeff_a2   [0:NUM_SECTIONS-1];
  wire signed [COEFF_WIDTH-1:0] coeff_a3   [0:NUM_SECTIONS-1];

  genvar gi;
  generate
    for (gi = 0; gi < NUM_SECTIONS; gi = gi + 1) begin : g_unpack_coeffs
      assign scaleconst[gi] = scaleconst_flat[COEFF_WIDTH*(gi+1)-1 : COEFF_WIDTH*gi];
      assign coeff_b1[gi]   = coeff_b1_flat  [COEFF_WIDTH*(gi+1)-1 : COEFF_WIDTH*gi];
      assign coeff_b2[gi]   = coeff_b2_flat  [COEFF_WIDTH*(gi+1)-1 : COEFF_WIDTH*gi];
      assign coeff_b3[gi]   = coeff_b3_flat  [COEFF_WIDTH*(gi+1)-1 : COEFF_WIDTH*gi];
      assign coeff_a2[gi]   = coeff_a2_flat  [COEFF_WIDTH*(gi+1)-1 : COEFF_WIDTH*gi];
      assign coeff_a3[gi]   = coeff_a3_flat  [COEFF_WIDTH*(gi+1)-1 : COEFF_WIDTH*gi];
    end
  endgenerate

  // ---------------------------------------------------------------------
  // Sample input register: converts external format (offset binary or
  // two's complement, per sign_en) to an internal signed sample.
  // ---------------------------------------------------------------------
  reg signed [IN_WIDTH-1:0] input_register;

  always @ (posedge clk or negedge reset) begin : input_reg_process
    if (reset == 1'b0)
      input_register <= 0;
    else if (clk_enable == 1'b1)
      input_register <= ~sign_en
                         ? $signed({1'b0, filter_in}) - (1 <<< (DATA_WIDTH-1))
                         : {{2{filter_in[DATA_WIDTH-1]}}, filter_in[DATA_WIDTH-2:0]};
  end

  // ---------------------------------------------------------------------
  // Master schedule counter: counts 0 .. TOTAL_CYCLES-1, one tick per
  // multiply-accumulate step. Replaces the 24-way one-hot "phase_N" wires
  // with two small arithmetic quantities that scale with NUM_SECTIONS:
  //   section_idx = which section is currently active
  //   local_step  = which of the 6 steps within that section (0..5):
  //                 0=scale  1=a2  2=a3  3=b1  4=b2  5=b3
  // ---------------------------------------------------------------------
  reg [CNT_WIDTH-1:0] cur_count;

  always @ (posedge clk or negedge reset) begin : Counter_process
    if (reset == 1'b0)
      cur_count <= 0;
    else if (clk_enable == 1'b1)
      cur_count <= (cur_count >= TOTAL_CYCLES-1) ? {CNT_WIDTH{1'b0}} : cur_count + 1'b1;
  end



reg [CNT_WIDTH-1:0] section_idx_r;
reg [2:0]           local_step_r;

  always @ (posedge clk or negedge reset) begin : schedule_process
   if (reset == 1'b0)begin
    section_idx_r <= {CNT_WIDTH{1'b0}};
    local_step_r  <= 3'b0;
   end
   else if (clk_enable == 1'b1)begin
	   if(cur_count >= TOTAL_CYCLES-1) begin
              section_idx_r <= {CNT_WIDTH{1'b0}};
              local_step_r  <= 3'b0;
           end
	   else if(local_step_r == (CYCLES_PER_SECTION-1)) begin
              section_idx_r <= section_idx_r + 1'b1;
              local_step_r  <= 3'b0;
           end
	   else begin
              local_step_r  <= local_step_r + 1'b1;
           end
   end
   else begin
    section_idx_r <= {CNT_WIDTH{1'b0}};
    local_step_r  <= 3'b0;
   end
  end

  wire [CNT_WIDTH-1:0] section_idx = section_idx_r;
  wire [2:0]           local_step  = local_step_r;



//  wire [CNT_WIDTH-1:0] section_idx = cur_count / CYCLES_PER_SECTION;
//  wire [2:0]           local_step  = cur_count % CYCLES_PER_SECTION;

  wire is_first_cycle  = (cur_count == 0) & clk_enable;                          // start of the whole sample (delay-line shift)
  wire is_last_cycle   = (cur_count == TOTAL_CYCLES-1) & clk_enable;             // end of the whole sample (output capture)
  wire is_section_seed = (local_step == 3'd0) & clk_enable;                      // step 0: seed accumulator with scale*input
  wire is_state_update = (local_step == 3'd2) & clk_enable;                      // step 2: state = scale*x - a2*z1 - a3*z2 (rounded)
  wire is_restart_sum  = ((local_step == 3'd0) || (local_step == 3'd3)) & clk_enable; // accumulator restarts at steps 0 and 3
  wire is_stage_output = (local_step == 3'd5) & clk_enable;                      // step 5: this section's filtered output is ready

  // ---------------------------------------------------------------------
  // Per-section state: 2-tap delay line, feedback "state" register, and
  // (for all but the last section) the register that pipes this section's
  // output into the next section's input. Built once via `generate`
  // instead of being copy-pasted per section.
  // ---------------------------------------------------------------------
  wire signed [STATE_WIDTH-1:0] storage_typeconvert; // rounded state update, shared by all sections (time-multiplexed)
  wire signed [COEFF_WIDTH-1:0] section_ipconvert;   // rounded scale*input, shared by all sections
  wire signed [COEFF_WIDTH-1:0] section_opconvert;   // rounded section output, shared by all sections

  wire signed [STATE_WIDTH-1:0] delay_tap0      [0:NUM_SECTIONS-1]; // z1
  wire signed [STATE_WIDTH-1:0] delay_tap1      [0:NUM_SECTIONS-1]; // z2
  wire signed [STATE_WIDTH-1:0] storage_state   [0:NUM_SECTIONS-1];
  wire signed [COEFF_WIDTH-1:0] stage_input     [0:NUM_SECTIONS-1]; // this section's x[n] (external input for section 0, previous section's output otherwise)

  generate
    for (gi = 0; gi < NUM_SECTIONS; gi = gi + 1) begin : g_sections

      reg signed [STATE_WIDTH-1:0] delay_reg [0:1];
      reg signed [STATE_WIDTH-1:0] storage_reg;

      // 2-tap delay line: shifts once per whole sample (all sections move
      // in lock-step at cur_count == 0), matching the original schedule.
      always @ (posedge clk or negedge reset) begin
        if (reset == 1'b0) begin
          delay_reg[0] <= {STATE_WIDTH{1'b0}};
          delay_reg[1] <= {STATE_WIDTH{1'b0}};
        end else if (is_first_cycle) begin
          delay_reg[1] <= delay_reg[0];
          delay_reg[0] <= storage_reg;
        end
      end

      // Feedback state register: captures the rounded scale*x - a2*z1 - a3*z2
      // result at this section's local step 2.
      wire section_active     = (section_idx == gi);
      wire this_state_update  = section_active && is_state_update;

      always @ (posedge clk or negedge reset) begin
        if (reset == 1'b0)
          storage_reg <= {STATE_WIDTH{1'b0}};
        else if (this_state_update)
          storage_reg <= storage_typeconvert;
      end

      assign delay_tap0[gi]    = delay_reg[0];
      assign delay_tap1[gi]    = delay_reg[1];
      assign storage_state[gi] = storage_reg;

      // Stage input: section 0 reads the external sample; every later
      // section reads the previous section's rounded, registered output.
      if (gi == 0) begin : g_stage0_input
        assign stage_input[0] = input_register;
      end else begin : g_stageN_input
        reg signed [COEFF_WIDTH-1:0] prev_stage_out;
        wire prev_section_output_ready = (section_idx == gi-1) && is_stage_output;

        always @ (posedge clk or negedge reset) begin
          if (reset == 1'b0)
            prev_stage_out <= {COEFF_WIDTH{1'b0}};
          else if (prev_section_output_ready)
            prev_stage_out <= section_opconvert;
        end

        assign stage_input[gi] = prev_stage_out;
      end

    end
  endgenerate

  // ---------------------------------------------------------------------
  // Shared, time-multiplexed multiply/accumulate datapath. One multiplier
  // is reused for every (section, coefficient) pair over TOTAL_CYCLES
  // cycles -- this part of the architecture (folding factor = 1 mult) is
  // unchanged from the original; only the *scheduling* around it is
  // generalized.
  // ---------------------------------------------------------------------

  // Sign-extend each section's stage input / delay taps / stored state up
  // to the common STATE_WIDTH used by the multiplier, exactly like the
  // original *_cast wires (one assignment per case instead of per section).
  wire signed [STATE_WIDTH-1:0] stage_input_ext [0:NUM_SECTIONS-1];
  generate
    for (gi = 0; gi < NUM_SECTIONS; gi = gi + 1) begin : g_stage_input_ext
      assign stage_input_ext[gi] =
          $signed({{(STATE_WIDTH-COEFF_WIDTH){stage_input[gi][COEFF_WIDTH-1]}}, stage_input[gi]});
    end
  endgenerate

  // Operand mux: for the active section, pick {input, z1, z2, state, z1, z2}
  // according to local_step (0..5). This single case replaces the original
  // per-value hand-written 24-entry ?: chain.
  reg signed [STATE_WIDTH-1:0] mux_operand;
  reg signed [COEFF_WIDTH-1:0] mux_coeff;
  integer k;
  always @ (*) begin
    mux_operand = {STATE_WIDTH{1'b0}};
    mux_coeff   = {COEFF_WIDTH{1'b0}};
    for (k = 0; k < NUM_SECTIONS; k = k + 1) begin
      if (section_idx == k) begin
        case (local_step)
          3'd0: begin mux_operand = stage_input_ext[k]; mux_coeff = scaleconst[k]; end
          3'd1: begin mux_operand = delay_tap0[k];       mux_coeff = coeff_a2[k];   end
          3'd2: begin mux_operand = delay_tap1[k];       mux_coeff = coeff_a3[k];   end
          3'd3: begin mux_operand = storage_state[k];    mux_coeff = coeff_b1[k];   end
          3'd4: begin mux_operand = delay_tap0[k];       mux_coeff = coeff_b2[k];   end
          default: begin mux_operand = delay_tap1[k];    mux_coeff = coeff_b3[k];   end
        endcase
      end
    end
  end

  wire signed [PROD_WIDTH-1:0] prod = mux_operand * mux_coeff;
  wire signed [ACC_WIDTH-1:0]  prod_ext     = $signed({{(ACC_WIDTH-PROD_WIDTH){prod[PROD_WIDTH-1]}}, prod});
  wire signed [ACC_WIDTH-1:0]  prod_ext_neg = (prod_ext == {1'b1, {(ACC_WIDTH-1){1'b0}}}) ? prod_ext : -prod_ext;

  // a2/a3 terms subtract from the running sum (local_step 1,2); everything
  // else adds.
  wire subtract_this_term = (local_step == 3'd1) || (local_step == 3'd2);
  wire signed [ACC_WIDTH-1:0] signed_term = subtract_this_term ? prod_ext_neg : prod_ext;

  // Build the "seed" value used at local_step 0 (scale*x, rescaled back up
  // into the accumulator's fixed point position) exactly as the original
  // sectionipconvert_cast did.
  wire signed [ACC_WIDTH-1:0] seed_value =
      { {(ACC_WIDTH-COEFF_WIDTH-SHIFT){section_ipconvert[COEFF_WIDTH-1]}}, section_ipconvert, {SHIFT{1'b0}} };

  reg signed [ACC_WIDTH-1:0] accum_reg;
  wire signed [ACC_WIDTH-1:0] accum_running = accum_reg + signed_term;
  wire signed [ACC_WIDTH-1:0] accum_seeded  = is_section_seed ? seed_value : signed_term;
  wire signed [ACC_WIDTH-1:0] accum_next    = is_restart_sum ? accum_seeded : accum_running;

  always @ (posedge clk or negedge reset) begin : accumulator_reg_process
    if (reset == 1'b0)
      accum_reg <= {ACC_WIDTH{1'b0}};
    else if (clk_enable == 1'b1)
      accum_reg <= accum_next;
  end

  // ---------------------------------------------------------------------
  // Rounding + rescale helper. Reproduces the original's
  // "(win + round_bit) >>> SHIFT" pattern, parameterized by window width.
  // round_bit = win[SHIFT-1]; correction = {round_bit, ~round_bit x(SHIFT-1)}
  // (this specific complement trick is what the original coder emitted --
  // it rounds to nearest with ties handled without a mean bias).
  // ---------------------------------------------------------------------
  function automatic signed [ACC_WIDTH-1:0] round_and_shift;
    input signed [ACC_WIDTH-1:0] win; // caller must sign-extend/slice to the correct window before calling
    reg round_bit;
    reg [ACC_WIDTH-1:0] correction;
    begin
      round_bit  = win[SHIFT-1];
      correction = {{(ACC_WIDTH-SHIFT){1'b0}}, round_bit, {(SHIFT-1){~round_bit}}};
      round_and_shift = (win + correction) >>> SHIFT;
    end
  endfunction

  // State update: round(scale*x - a2*z1 - a3*z2) down to STATE_WIDTH.
  wire signed [ACC_WIDTH-1:0] storage_win    = {{(ACC_WIDTH-STATE_WIN){accum_next[STATE_WIN-1]}}, accum_next[STATE_WIN-1:0]};
  wire signed [ACC_WIDTH-1:0] storage_rounded = round_and_shift(storage_win);
  assign storage_typeconvert = storage_rounded[STATE_WIDTH-1:0];

  // Per-section scaled input: round(scale*x) down to COEFF_WIDTH, used as
  // the accumulator seed for this section.
  wire signed [ACC_WIDTH-1:0] prod_win        = {{(ACC_WIDTH-SECT_WIN){prod[SECT_WIN-1]}}, prod[SECT_WIN-1:0]};
  wire signed [ACC_WIDTH-1:0] section_ip_full = round_and_shift(prod_win);
  assign section_ipconvert = section_ip_full[COEFF_WIDTH-1:0];

  // Section output: round(final accumulated sum) down to COEFF_WIDTH, fed
  // to the next section (or, for the last section, further rounded below
  // to IN_WIDTH for filter_out).
  wire signed [ACC_WIDTH-1:0] section_op_win  = {{(ACC_WIDTH-SECT_WIN){accum_next[SECT_WIN-1]}}, accum_next[SECT_WIN-1:0]};
  wire signed [ACC_WIDTH-1:0] section_op_full = round_and_shift(section_op_win);
  assign section_opconvert = section_op_full[COEFF_WIDTH-1:0];

  wire signed [ACC_WIDTH-1:0] output_win =
      {{(ACC_WIDTH-OUT_WIN){accum_next[OUT_WIN-1]}}, accum_next[OUT_WIN-1:0]};
  wire signed [ACC_WIDTH-1:0] output_typeconvert = round_and_shift(output_win);

  // ---------------------------------------------------------------------
  // Output register + saturation, only latched at the very last cycle of
  // the whole cascade.
  // ---------------------------------------------------------------------
  reg signed [IN_WIDTH-1:0] output_register;

  always @ (posedge clk or negedge reset) begin : Output_Register_process
    if (reset == 1'b0)
      output_register <= 0;
    else if (is_last_cycle)
      output_register <= output_typeconvert[IN_WIDTH-1:0];
  end

  wire [DATA_WIDTH-1:0] output_saturated =
      (output_register[IN_WIDTH-1:IN_WIDTH-2] == 2'b10) ? {1'b1, {(DATA_WIDTH-1){1'b0}}} :
      (output_register[IN_WIDTH-1:IN_WIDTH-2] == 2'b01) ? {1'b0, {(DATA_WIDTH-1){1'b1}}} :
                                                            output_register[DATA_WIDTH-1:0];

  assign filter_out = bypass ? filter_in
                              : (~sign_en ? output_saturated + (1 <<< (DATA_WIDTH-1))
                                          : output_saturated);

  assign nf_data_valid = is_last_cycle && clk_enable;
  assign o_cnt          = cur_count;

endmodule
