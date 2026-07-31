`timescale 1ns/1ps
//--------------------------------------------------------------------------------------
// tb_bioz_iq_loop.sv
//
// End-to-end, standalone integration testbench connecting the two BioZ digital
// halves that are NOT connected to each other anywhere in the real chip today
// (see BioZ/REVIEW.md section 4):
//
//     BioZ.sv (DDS excitation + commutating-mixer references)
//        --> [simple behavioral analog model: body impedance + chopper mixer
//             + baseband LPF + 1st-order sigma-delta ADC, all in `real`]  -->
//     iq_filter_wrapper.v (iq_reg/iq_cdc/iq_ctrl/iq_cic -- the real, synthesizable
//        digital receive/decimation RTL, unmodified)
//
// Goal: prove that, if these two blocks WERE wired together through a plausible
// analog front end, the whole DDS -> analog -> ADC -> CIC loop actually
// reconstructs the programmed body resistance (R) on the I channel and
// reactance (X) on the Q channel.
//
// The analog model is intentionally simple (single-pole baseband LPF, 1st-order
// sigma-delta modulator, frequency-flat R+jX load) -- it is NOT a claim about the
// real analog design, just enough physics (Ohm's law at the DDS's own exact
// excitation frequency, using its own quadrature references) to drive the real
// iq_cic RTL with a realistic, correlated bitstream and check the two blocks
// are digitally compatible end-to-end.
//
// Correctness is checked two ways by the companion Python scripts:
//   1) BIT-EXACT: the exact sequence of `chdata_I`/`chdata_Q` values emitted by
//      the real iq_filter_wrapper RTL must match an independent, cycle-accurate
//      Python port of iq_cic.v run over the exact same logged ADC bitstream
//      (see iq_cic_golden_model.py).
//   2) ENGINEERING: after each scenario settles, the averaged, descaled I/Q
//      output must reconstruct the R/X values programmed into the analog model,
//      demonstrating the two blocks work together as a system (see loop_check.py).
//--------------------------------------------------------------------------------------
module tb_bioz_iq_loop;

    localparam integer PHASE_W = 32;

    // ---- DDS / pclk domain: 4 MHz, per README/module name ----
    localparam real DDS_CLK_FREQ_HZ = 4_000_000.0;
    localparam real DDS_CLK_PERIOD_NS = 1.0e9 / DDS_CLK_FREQ_HZ; // 250ns

    // ---- ADC bit-clock domain: 250 kHz, consistent with the "adc working
    // clock, divider of 256kHz" comment in iq_filter.v / iq_filter_wrapper.v ----
    localparam real ADC_CLK_FREQ_HZ = 250_000.0;
    localparam real ADC_CLK_PERIOD_NS = 1.0e9 / ADC_CLK_FREQ_HZ; // 4000ns
    localparam real ADC_CLK_PHASE_NS  = 125.0; // offset so its edges never land on a DDS edge

    // single-pole baseband LPF ahead of the ADC (~ the docx's "LPF: DC to 4Hz"
    // stage, made a bit wider here just so a handful of milliseconds is enough
    // to settle in simulation). Small-angle discrete approximation of
    // alpha = 1 - exp(-2*pi*Fc*Ts), valid since Fc*Ts << 1 here.
    localparam real LPF_FC_HZ = 200.0;
    localparam real ALPHA_LPF = 2.0 * 3.14159265358979323846 * LPF_FC_HZ / DDS_CLK_FREQ_HZ;

    function automatic [31:0] f2p(input real f_hz);
        f2p = $rtoi(f_hz * (2.0**32) / DDS_CLK_FREQ_HZ + 0.5);
    endfunction

    // ------------------------------------------------------------------
    // Clocks / reset
    // ------------------------------------------------------------------
    reg clk;      // 4MHz: drives BioZ DDS and doubles as iq_filter_wrapper's pclk
    reg adc_clk;  // 250kHz: the simulated ADC serial-bit clock
    reg resetn;   // single global async-assert reset for both halves

    initial clk = 1'b0;
    always #(DDS_CLK_PERIOD_NS/2.0) clk = ~clk;

    initial begin
        adc_clk = 1'b0;
        #(ADC_CLK_PHASE_NS);
        forever #(ADC_CLK_PERIOD_NS/2.0) adc_clk = ~adc_clk;
    end

    // ------------------------------------------------------------------
    // DDS / excitation (BioZ.sv, unmodified RTL)
    // ------------------------------------------------------------------
    reg  [PHASE_W-1:0]  phase_inc;
    wire unsigned [9:0] sin_unsigned, cos_unsigned;
    wire                 i_square, q_square;
    wire [PHASE_W:0]     phase_acc;

    BioZ #(
        .PHASE_W(PHASE_W)
    ) u_biozdds (
        .clk            (clk),
        .resetn         (resetn),
        .enable         (1'b1),
        .DITHER_EN      (1'b0),
        .DITHER_SEED    (16'hACE1),
        .phase_inc      (phase_inc),
        .phase_offset   (32'h0),
        .phase_offset_c (32'h0),
        .sin_unsigned   (sin_unsigned),
        .cos_unsigned   (cos_unsigned),
        .data_type_sel  (2'b00),
        .dc_data        (10'd0),
        .dc_data_c      (10'd0),
        .i_square       (i_square),
        .q_square       (q_square),
        .phase_acc      (phase_acc)
    );

    // ------------------------------------------------------------------
    // Simple behavioral analog model:
    //   body impedance (frequency-flat R+jX) -> commutating chopper mixer
    //   (driven by the DDS's own i_square/q_square) -> single-pole baseband
    //   LPF -> 1st-order sigma-delta ADC (one instance per channel)
    // ------------------------------------------------------------------
    real R_norm, X_norm;               // programmed "body" R/X, normalized to +/-1 DAC full scale
    real s_norm, c_norm;                // normalized quadrature DDS references
    real v_sense;                       // V = I*Z, evaluated using the DDS's own sin/cos
    real i_mix, q_mix;                  // after commutating (chopper) mixer
    real lpf_i, lpf_q;                  // after baseband LPF (state)

    always @(posedge clk) begin
        if (!resetn) begin
            lpf_i <= 0.0;
            lpf_q <= 0.0;
        end else begin
            // Ohm's law V=I*Z at the DDS's own excitation frequency, expressed
            // directly via its own quadrature (sin/cos) references -- exact for
            // a single-tone excitation into a frequency-flat R+jX load.
            s_norm  = ($itor(sin_unsigned) - 511.5) / 511.5;
            c_norm  = ($itor(cos_unsigned) - 511.5) / 511.5;
            v_sense = s_norm * R_norm + c_norm * X_norm;

            // commutating (chopper) demodulator, switched by the DDS's own
            // 0 deg / 90 deg mixer references
            i_mix = i_square ? v_sense : -v_sense;
            q_mix = q_square ? v_sense : -v_sense;

            // single-pole baseband LPF ahead of the ADC (rejects the 2x-fexc
            // mixing image so the much-slower ADC sample clock below doesn't alias it)
            lpf_i <= lpf_i + ALPHA_LPF * (i_mix - lpf_i);
            lpf_q <= lpf_q + ALPHA_LPF * (q_mix - lpf_q);
        end
    end

    // 1st-order sigma-delta modulators (one per channel), sampled at adc_clk.
    // bit=1 feeds back +1, bit=0 feeds back -1 (matches iq_input_format=2'b10
    // in iq_reg.v: filter_in=1 -> +1, filter_in=0 -> -1).
    real integ_i, integ_q;
    reg  bit_i, bit_q;

    always @(posedge adc_clk or negedge resetn) begin : ds_mod
        real integ_new_i, integ_new_q;
        if (!resetn) begin
            integ_i <= 0.0; bit_i <= 1'b0;
            integ_q <= 0.0; bit_q <= 1'b0;
        end else begin
            integ_new_i = integ_i + (lpf_i - (bit_i ? 1.0 : -1.0));
            integ_new_q = integ_q + (lpf_q - (bit_q ? 1.0 : -1.0));
            integ_i <= integ_new_i;
            integ_q <= integ_new_q;
            bit_i   <= (integ_new_i >= 0.0);
            bit_q   <= (integ_new_q >= 0.0);
        end
    end

    // ------------------------------------------------------------------
    // Real digital receive-path RTL under test: iq_filter_wrapper
    // (iq_reg + iq_cdc + iq_ctrl + iq_cic x2, unmodified)
    // ------------------------------------------------------------------
    localparam [1:0] IQ_INPUT_FORMAT = 2'b10; // filter_in=1 -> +1, filter_in=0 -> -1
    localparam [3:0] CIC_RATE_SEL    = 4'b0011; // decimate by 256
    localparam       CHMOD           = 1'b0;    // free-running, no per-cycle reset
    localparam       FORMAT_SEL      = 1'b0;    // raw two's-complement output
    localparam       SD16RST         = 1'b0;
    localparam [5:0] RST_VAL         = 6'b0;
    localparam       INT_EN          = 1'b0;

    wire [15:0] reg_ctrl_bus = {IQ_INPUT_FORMAT, RST_VAL, CIC_RATE_SEL, CHMOD, FORMAT_SEL, SD16RST, INT_EN};
    wire [3:0]  cic_rate_unused;
    wire        chdata_en_n_I, chdata_en_n_Q;
    wire [19:0] chdata_I, chdata_Q;
    wire        iq_int_I, iq_int_sts_I, iq_int_Q, iq_int_sts_Q;

    iq_filter_wrapper u_iq_filter_wrapper (
        .pclk            (clk),
        .adc_clk         (adc_clk),
        .presetn         (resetn),
        .atpg_en         (1'b0),
        .scan_en         (1'b0),
        .cic_rate        (cic_rate_unused),

        .int_clr         (1'b0),
        .int_length_slct (1'b0),
        .reg_ctrl        (reg_ctrl_bus),

        .chdata_en_n_I   (chdata_en_n_I),
        .chdata_I        (chdata_I),
        .chdata_en_n_Q   (chdata_en_n_Q),
        .chdata_Q        (chdata_Q),

        .iq_int_I        (iq_int_I),
        .iq_int_sts_I    (iq_int_sts_I),
        .iq_int_Q        (iq_int_Q),
        .iq_int_sts_Q    (iq_int_sts_Q),

        .iq_adc_din_I    (bit_i),
        .iq_adc_din_Q    (bit_q)
    );

    // ------------------------------------------------------------------
    // Logging
    // ------------------------------------------------------------------
    integer fd_bits;
    integer fd_chdata;
    integer scenario_id;
    string  scenario_name;
    real    scenario_r_norm, scenario_x_norm;
    real    scenario_freq_hz;

    // one row per ADC-clock cycle: the exact bitstream driving iq_cic
    always @(posedge adc_clk) begin
        #1;
        $fwrite(fd_bits, "%0d,%0d,%s,%0d,%0d,%0d\n",
            $time, scenario_id, scenario_name, resetn, bit_i, bit_q);
    end

    // one row per valid decimated output sample (pclk domain)
    always @(posedge clk) begin
        #1;
        if (!chdata_en_n_I) begin
            $fwrite(fd_chdata, "%0d,%0d,%s,%0.6f,%0.6f,%0.1f,%0h,%0h\n",
                $time, scenario_id, scenario_name, scenario_r_norm, scenario_x_norm,
                scenario_freq_hz, chdata_I, chdata_Q);
        end
    end

    task automatic set_scenario(
        input integer id, input string name_,
        input real f_hz, input real r_norm, input real x_norm);
        @(negedge clk);
        scenario_id     = id;
        scenario_name   = name_;
        scenario_freq_hz = f_hz;
        scenario_r_norm = r_norm;
        scenario_x_norm = x_norm;
        phase_inc       = f2p(f_hz);
        R_norm          = r_norm;
        X_norm          = x_norm;
    endtask

    task automatic hold_dds_cycles(input integer n);
        repeat (n) @(posedge clk);
    endtask

    // settle (flush the 3-stage CIC's group delay + LPF transient) then
    // collect several decimated output samples per scenario
    localparam integer SETTLE_ADC_CYCLES = 8 * 256;  // 8 decimation windows
    localparam integer MEASURE_ADC_CYCLES = 16 * 256; // 16 more decimation windows
    localparam integer DDS_CYCLES_PER_ADC_CYCLE = 16; // 4MHz / 250kHz

    initial begin
        fd_bits = $fopen("iq_bits.csv", "w");
        $fwrite(fd_bits, "time,scenario_id,scenario_name,resetn,bit_i,bit_q\n");

        fd_chdata = $fopen("iq_chdata.csv", "w");
        $fwrite(fd_chdata, "time,scenario_id,scenario_name,r_norm,x_norm,freq_hz,chdata_I,chdata_Q\n");

        scenario_id      = -1;
        scenario_name    = "reset";
        scenario_r_norm  = 0.0;
        scenario_x_norm  = 0.0;
        scenario_freq_hz = 0.0;
        phase_inc        = 32'h0;
        R_norm           = 0.0;
        X_norm           = 0.0;

        resetn = 1'b0;
        hold_dds_cycles(40);
        resetn = 1'b1;
        hold_dds_cycles(40);

        // ---- S0: pure resistive load @ 100kHz -> expect I large, Q ~0 ----
        set_scenario(0, "pure_R_100kHz", 100_000.0, 0.60, 0.0);
        hold_dds_cycles((SETTLE_ADC_CYCLES + MEASURE_ADC_CYCLES) * DDS_CYCLES_PER_ADC_CYCLE);

        // ---- S1: pure reactive load @ 100kHz -> expect I ~0, Q large ----
        set_scenario(1, "pure_X_100kHz", 100_000.0, 0.0, 0.60);
        hold_dds_cycles((SETTLE_ADC_CYCLES + MEASURE_ADC_CYCLES) * DDS_CYCLES_PER_ADC_CYCLE);

        // ---- S2: mixed R+X @ 100kHz, comparable to a real body's R>>X ratio ----
        set_scenario(2, "mixed_RX_100kHz", 100_000.0, 0.50, 0.15);
        hold_dds_cycles((SETTLE_ADC_CYCLES + MEASURE_ADC_CYCLES) * DDS_CYCLES_PER_ADC_CYCLE);

        // ---- S3: same R+X, different excitation frequency -> since this
        // idealized model's load is frequency-flat, reconstructed R/X should
        // be unchanged, showing the loop works across the excitation range too ----
        set_scenario(3, "mixed_RX_50kHz", 50_000.0, 0.50, 0.15);
        hold_dds_cycles((SETTLE_ADC_CYCLES + MEASURE_ADC_CYCLES) * DDS_CYCLES_PER_ADC_CYCLE);

        // drain: a small margin so the last decimation event's fixed CDC/
        // announcement pipeline latency (a couple of adc_clk cycles plus a
        // few pclk synchronizer stages) has time to reach chdata before
        // $finish.
        hold_dds_cycles(2 * 256 * DDS_CYCLES_PER_ADC_CYCLE);

        $fclose(fd_bits);
        $fclose(fd_chdata);
        $display("[tb_bioz_iq_loop] Simulation complete. Logs: iq_bits.csv, iq_chdata.csv");
        $finish;
    end

    // watchdog
    initial begin
        #(500_000_000); // 500ms sim-time ceiling
        $display("[tb_bioz_iq_loop] ERROR: watchdog timeout");
        $fclose(fd_bits);
        $fclose(fd_chdata);
        $finish;
    end

endmodule
