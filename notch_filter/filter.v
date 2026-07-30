module filter #(
    parameter integer NUM_SECTIONS       = 4,   // cascaded 2nd-order sections
    parameter integer DATA_WIDTH         = 16,  // filter_in / filter_out width
    parameter integer COEFF_WIDTH        = 16,  // coefficient width (scale, b1..b3, a2..a3)
    parameter integer COEFF_FRAC_BITS    = 14,  // coefficient fractional bits; also the internal round/rescale shift amount
    parameter integer STATE_GUARD_BITS   = 10,  // extra bits carried in each section's state/delay path (precision headroom)
    parameter integer ACC_GUARD_BITS     = 2,   // extra bits carried in the shared accumulator (overflow headroom)
    parameter integer CYCLES_PER_SECTION = 6,   // 1 multiply cycle each for: scale, a2, a3, b1, b2, b3


    parameter integer TOTAL_CYCLES = CYCLES_PER_SECTION * NUM_SECTIONS,
    parameter integer CNT_WIDTH    = (TOTAL_CYCLES <= 1) ? 1 : $clog2(TOTAL_CYCLES)

) (
    input  wire clk,
    input  wire clk_enable,
    input  wire reset,
    input  wire sign_en,
    input  wire bypass,
    output wire nf_data_valid,
    output wire [CNT_WIDTH-1:0] o_cnt,

    input  wire signed [COEFF_WIDTH*NUM_SECTIONS-1:0] scaleconst_flat,
    input  wire signed [COEFF_WIDTH*NUM_SECTIONS-1:0] coeff_b1_flat,
    input  wire signed [COEFF_WIDTH*NUM_SECTIONS-1:0] coeff_b2_flat,
    input  wire signed [COEFF_WIDTH*NUM_SECTIONS-1:0] coeff_b3_flat,
    input  wire signed [COEFF_WIDTH*NUM_SECTIONS-1:0] coeff_a2_flat,
    input  wire signed [COEFF_WIDTH*NUM_SECTIONS-1:0] coeff_a3_flat,

    input  wire signed [DATA_WIDTH-1:0] filter_in,
    output wire signed [DATA_WIDTH-1:0] filter_out
);

  localparam integer IN_WIDTH    = DATA_WIDTH + 1;
  localparam integer STATE_WIDTH = IN_WIDTH + STATE_GUARD_BITS;
  localparam integer PROD_WIDTH  = STATE_WIDTH + COEFF_WIDTH;
  localparam integer ACC_WIDTH   = PROD_WIDTH + ACC_GUARD_BITS;

  localparam integer SHIFT     = COEFF_FRAC_BITS;
  localparam integer STATE_WIN = STATE_WIDTH + SHIFT;
  localparam integer SECT_WIN  = COEFF_WIDTH + SHIFT;
  localparam integer OUT_WIN   = IN_WIDTH + SHIFT;

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

  reg signed [IN_WIDTH-1:0] input_register;

  always @ (posedge clk or negedge reset) begin : input_reg_process
    if (reset == 1'b0)
      input_register <= 0;
    else if (clk_enable == 1'b1)
      input_register <= ~sign_en
                         ? $signed({1'b0, filter_in}) - (1 <<< (DATA_WIDTH-1))
                         : {{2{filter_in[DATA_WIDTH-1]}}, filter_in[DATA_WIDTH-2:0]};
  end

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
//   else begin
//    section_idx_r <= {CNT_WIDTH{1'b0}};
//    local_step_r  <= 3'b0;
//   end
  end

  wire [CNT_WIDTH-1:0] section_idx = section_idx_r;
  wire [2:0]           local_step  = local_step_r;



//  wire [CNT_WIDTH-1:0] section_idx = cur_count / CYCLES_PER_SECTION;
//  wire [2:0]           local_step  = cur_count % CYCLES_PER_SECTION;

  wire is_first_cycle  = (cur_count == 0) & clk_enable;
  wire is_last_cycle   = (cur_count == TOTAL_CYCLES-1) & clk_enable;
  wire is_section_seed = (local_step == 3'd0) & clk_enable;
  wire is_state_update = (local_step == 3'd2) & clk_enable;
  wire is_restart_sum  = ((local_step == 3'd0) || (local_step == 3'd3)) & clk_enable;
  wire is_stage_output = (local_step == 3'd5) & clk_enable;

  wire signed [STATE_WIDTH-1:0] storage_typeconvert;
  wire signed [STATE_WIDTH-1:0] section_ipconvert;
  wire signed [STATE_WIDTH-1:0] section_opconvert;

  wire signed [STATE_WIDTH-1:0] delay_tap0      [0:NUM_SECTIONS-1];
  wire signed [STATE_WIDTH-1:0] delay_tap1      [0:NUM_SECTIONS-1];
  wire signed [STATE_WIDTH-1:0] storage_state   [0:NUM_SECTIONS-1];
  wire signed [STATE_WIDTH-1:0] stage_input     [0:NUM_SECTIONS-1];

  generate
    for (gi = 0; gi < NUM_SECTIONS; gi = gi + 1) begin : g_sections

      reg signed [STATE_WIDTH-1:0] delay_reg [0:1];
      reg signed [STATE_WIDTH-1:0] storage_reg;

      always @ (posedge clk or negedge reset) begin
        if (reset == 1'b0) begin
          delay_reg[0] <= {STATE_WIDTH{1'b0}};
          delay_reg[1] <= {STATE_WIDTH{1'b0}};
        end else if (is_first_cycle) begin
          delay_reg[1] <= delay_reg[0];
          delay_reg[0] <= storage_reg;
        end
      end

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

      if (gi == 0) begin : g_stage0_input
        // input_register is IN_WIDTH bits; sign-extend up to the wider
        // STATE_WIDTH used for all inter-section signals (see note above
        // g_sections about why inter-section signals are carried at
        // STATE_WIDTH rather than the narrower COEFF_WIDTH).
        assign stage_input[0] = $signed({{(STATE_WIDTH-IN_WIDTH){input_register[IN_WIDTH-1]}}, input_register});
      end else begin : g_stageN_input
        reg signed [STATE_WIDTH-1:0] prev_stage_out;
        wire prev_section_output_ready = (section_idx == gi-1) && is_stage_output;

        always @ (posedge clk or negedge reset) begin
          if (reset == 1'b0)
            prev_stage_out <= {STATE_WIDTH{1'b0}};
          else if (prev_section_output_ready)
            prev_stage_out <= section_opconvert;
        end

        assign stage_input[gi] = prev_stage_out;
      end

    end
  endgenerate

  // stage_input is already STATE_WIDTH-wide now (see FIX note above), so
  // no separate sign-extension step is needed before the multiplier --
  // this used to be required when stage_input was only COEFF_WIDTH wide.

  reg signed [STATE_WIDTH-1:0] mux_operand;
  reg signed [COEFF_WIDTH-1:0] mux_coeff;
  integer k;
  always @ (*) begin
    mux_operand = {STATE_WIDTH{1'b0}};
    mux_coeff   = {COEFF_WIDTH{1'b0}};
    for (k = 0; k < NUM_SECTIONS; k = k + 1) begin
      if (section_idx == k) begin
        case (local_step)
          3'd0: begin mux_operand = stage_input[k];     mux_coeff = scaleconst[k]; end
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

  wire subtract_this_term = (local_step == 3'd1) || (local_step == 3'd2);
  wire signed [ACC_WIDTH-1:0] signed_term = subtract_this_term ? prod_ext_neg : prod_ext;

  wire signed [ACC_WIDTH-1:0] seed_value =
      { {(ACC_WIDTH-STATE_WIDTH-SHIFT){section_ipconvert[STATE_WIDTH-1]}}, section_ipconvert, {SHIFT{1'b0}} };

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

  function automatic signed [ACC_WIDTH-1:0] round_and_shift;
    input signed [ACC_WIDTH-1:0] win;
    reg round_bit;
    reg [ACC_WIDTH-1:0] correction;
    begin
      round_bit  = win[SHIFT-1];
      correction = {{(ACC_WIDTH-SHIFT){1'b0}}, round_bit, {(SHIFT-1){~round_bit}}};
      round_and_shift = (win + correction) >>> SHIFT;
    end
  endfunction

  wire signed [ACC_WIDTH-1:0] storage_win    = {{(ACC_WIDTH-STATE_WIN){accum_next[STATE_WIN-1]}}, accum_next[STATE_WIN-1:0]};
  wire signed [ACC_WIDTH-1:0] storage_rounded = round_and_shift(storage_win);
  assign storage_typeconvert = storage_rounded[STATE_WIDTH-1:0];

  // FIX: section_ipconvert/section_opconvert used to be narrowed all the
  // way down to COEFF_WIDTH (16 bits) here, using the SECT_WIN window
  // (COEFF_WIDTH+SHIFT = 30 bits out of prod/accum_next's much wider
  // representation). That was an artificial bottleneck: the multiplier
  // doesn't need a COEFF_WIDTH-sized operand (mux_operand is STATE_WIDTH
  // bits regardless), so there was no hardware reason to narrow this far.
  // For a mild filter it never mattered (values never got close to the
  // 16-bit edge); for an aggressive high-Q design (e.g. a very deep,
  // narrow notch), intermediate per-section values can exceed what fits
  // in 16 bits, and this raw truncation would silently wrap instead of
  // clip. Using STATE_WIN/STATE_WIDTH instead (same window already used
  // for the state-update path, 41 bits instead of 30) gives 11 extra bits
  // (2048x) of headroom, at zero extra hardware cost, and is a strict
  // superset of the old behavior for any value that already fit in 16
  // bits -- i.e. bit-exact compatible with the original for every case
  // that worked before, while no longer silently wrapping for cases that
  // didn't.
  wire signed [ACC_WIDTH-1:0] prod_win        = {{(ACC_WIDTH-STATE_WIN){prod[STATE_WIN-1]}}, prod[STATE_WIN-1:0]};
  wire signed [ACC_WIDTH-1:0] section_ip_full = round_and_shift(prod_win);
  assign section_ipconvert = section_ip_full[STATE_WIDTH-1:0];

  wire signed [ACC_WIDTH-1:0] section_op_win  = {{(ACC_WIDTH-STATE_WIN){accum_next[STATE_WIN-1]}}, accum_next[STATE_WIN-1:0]};
  wire signed [ACC_WIDTH-1:0] section_op_full = round_and_shift(section_op_win);
  assign section_opconvert = section_op_full[STATE_WIDTH-1:0];

  wire signed [ACC_WIDTH-1:0] output_win =
      {{(ACC_WIDTH-OUT_WIN){accum_next[OUT_WIN-1]}}, accum_next[OUT_WIN-1:0]};
  wire signed [ACC_WIDTH-1:0] output_typeconvert = round_and_shift(output_win);

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
