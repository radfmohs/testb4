`timescale 1ns/1ps
//--------------------------------------------------------------------------------------
// tb_bioz_dds.sv
//
// Standalone, self-contained testbench for the BioZ excitation/DDS block.
// Compiles ONLY the RTL required by the hierarchy rooted at:
//     Nanochap_BAF4P1.v -> top_dig.sv -> BioZ.sv -> dds_sincos_10b_lut128_4m.sv
//
// This TB does NOT check correctness itself (that is done by the companion
// Python golden-model, see analyze_bioz.py / bioz_golden_model.py). Instead it
// drives a sequence of documented scenarios (per README.md section 1.22-1.24)
// and dumps every clock-cycle's inputs+outputs to a CSV file so that a
// bit-exact reference model can replay the same stimulus and flag any
// mismatch, plus derive frequency/quadrature/spectral metrics.
//--------------------------------------------------------------------------------------
module tb_bioz_dds;

    localparam integer PHASE_W   = 32;
    localparam real    CLK_FREQ  = 4_000_000.0; // per README: nominal 4MHz DDS clock
    localparam real    CLK_PERIOD_NS = 1.0e9 / CLK_FREQ; // 250ns

    // frequency -> phase_inc helper (README formula: phase_inc = round(f*2^32/f_clk))
    function automatic [31:0] f2p(input real f_hz);
        f2p = $rtoi(f_hz * (2.0**32) / CLK_FREQ + 0.5);
    endfunction

    reg                  clk;
    reg                  resetn;
    reg                  enable;
    reg                  DITHER_EN;
    reg  [15:0]          DITHER_SEED;
    reg  [PHASE_W-1:0]   phase_inc;
    reg  [PHASE_W-1:0]   phase_offset;
    reg  [PHASE_W-1:0]   phase_offset_c;
    reg  [1:0]           data_type_sel;
    reg  unsigned [9:0]  dc_data;
    reg  unsigned [9:0]  dc_data_c;

    wire unsigned [9:0]  sin_unsigned;
    wire unsigned [9:0]  cos_unsigned;
    wire                 i_square;
    wire                 q_square;
    wire [PHASE_W:0]     phase_acc;

    integer              fd;
    integer              scenario_id;
    string               scenario_name;

    BioZ #(
        .PHASE_W(PHASE_W)
    ) dut (
        .clk            (clk),
        .resetn         (resetn),
        .enable         (enable),
        .DITHER_EN      (DITHER_EN),
        .DITHER_SEED    (DITHER_SEED),
        .phase_inc      (phase_inc),
        .phase_offset   (phase_offset),
        .phase_offset_c (phase_offset_c),
        .sin_unsigned   (sin_unsigned),
        .cos_unsigned   (cos_unsigned),
        .data_type_sel  (data_type_sel),
        .dc_data        (dc_data),
        .dc_data_c      (dc_data_c),
        .i_square       (i_square),
        .q_square       (q_square),
        .phase_acc      (phase_acc)
    );

    // clock generation
    initial clk = 1'b0;
    always #(CLK_PERIOD_NS/2.0) clk = ~clk;

    // per-cycle logger: samples shortly after each posedge, i.e. AFTER the DUT
    // registers have updated for this edge, while stimulus (only ever changed
    // at negedge) has been stable for the whole preceding cycle.
    always @(posedge clk) begin
        #1;
        $fwrite(fd,
            "%0d,%0d,%s,%0d,%0d,%0d,%0d,%0h,%0h,%0h,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0h\n",
            $time, scenario_id, scenario_name,
            resetn, enable, DITHER_EN, DITHER_SEED,
            phase_inc, phase_offset, phase_offset_c,
            data_type_sel, dc_data, dc_data_c,
            sin_unsigned, cos_unsigned, i_square, q_square, phase_acc);
    end

    task automatic hold_cycles(input integer n);
        repeat (n) @(posedge clk);
    endtask

    // change stimulus mid-low-phase so it is stable well before next posedge
    task automatic set_stim(
        input integer id, input string name_,
        input reg r_resetn, input reg r_enable,
        input reg r_dither_en, input reg [15:0] r_dither_seed,
        input reg [31:0] r_phase_inc, input reg [31:0] r_phase_offset, input reg [31:0] r_phase_offset_c,
        input reg [1:0] r_dtsel, input reg [9:0] r_dc, input reg [9:0] r_dcc);
        @(negedge clk);
        scenario_id     = id;
        scenario_name   = name_;
        resetn          = r_resetn;
        enable          = r_enable;
        DITHER_EN       = r_dither_en;
        DITHER_SEED     = r_dither_seed;
        phase_inc       = r_phase_inc;
        phase_offset    = r_phase_offset;
        phase_offset_c  = r_phase_offset_c;
        data_type_sel   = r_dtsel;
        dc_data         = r_dc;
        dc_data_c       = r_dcc;
    endtask

    initial begin
        fd = $fopen("bioz_samples.csv", "w");
        $fwrite(fd, "time,scenario_id,scenario_name,resetn,enable,dither_en,dither_seed,phase_inc,phase_offset,phase_offset_c,data_type_sel,dc_data,dc_data_c,sin_unsigned,cos_unsigned,i_square,q_square,phase_acc\n");

        // ---- S0: reset / disabled sanity ----
        set_stim(0, "reset_disabled", 1'b0, 1'b0, 1'b0, 16'hACE1, 32'h0, 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(10);
        set_stim(0, "reset_disabled", 1'b1, 1'b0, 1'b0, 16'hACE1, 32'h0, 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(10);

        // ---- S1..S5: README frequency table sweep, no dither, no offsets ----
        set_stim(1, "freq_1kHz",   1'b1, 1'b1, 1'b0, 16'hACE1, f2p(1_000.0),   32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(4096);

        set_stim(2, "freq_10kHz",  1'b1, 1'b0, 1'b0, 16'hACE1, 32'h0, 32'h0, 32'h0, 2'b00, 10'd0, 10'd0); // brief disable between scenarios to re-sync phase_acc=0
        hold_cycles(4);
        set_stim(2, "freq_10kHz",  1'b1, 1'b1, 1'b0, 16'hACE1, f2p(10_000.0),  32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(4096);

        set_stim(3, "freq_50kHz",  1'b1, 1'b0, 1'b0, 16'hACE1, 32'h0, 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(4);
        set_stim(3, "freq_50kHz",  1'b1, 1'b1, 1'b0, 16'hACE1, f2p(50_000.0),  32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(4096);

        set_stim(4, "freq_100kHz", 1'b1, 1'b0, 1'b0, 16'hACE1, 32'h0, 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(4);
        set_stim(4, "freq_100kHz", 1'b1, 1'b1, 1'b0, 16'hACE1, f2p(100_000.0), 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(4096);

        set_stim(5, "freq_400kHz", 1'b1, 1'b0, 1'b0, 16'hACE1, 32'h0, 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(4);
        set_stim(5, "freq_400kHz", 1'b1, 1'b1, 1'b0, 16'hACE1, f2p(400_000.0), 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(4096);

        // ---- S6: independent phase_offset on I vs phase_offset_c on Q @ 100kHz ----
        set_stim(6, "phase_offset_90deg", 1'b1, 1'b0, 1'b0, 16'hACE1, 32'h0, 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(4);
        set_stim(6, "phase_offset_90deg", 1'b1, 1'b1, 1'b0, 16'hACE1, f2p(100_000.0), 32'h4000_0000, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(4096);

        // ---- S7: dithering enabled @ 100kHz (compare spectral purity vs S4) ----
        set_stim(7, "dither_100kHz", 1'b1, 1'b0, 1'b0, 16'hACE1, 32'h0, 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(4);
        set_stim(7, "dither_100kHz", 1'b1, 1'b1, 1'b1, 16'hBEEF, f2p(100_000.0), 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(8192);

        // ---- S8: DC mode passthrough (data_type_sel = 2'b01) ----
        set_stim(8, "dc_mode", 1'b1, 1'b0, 1'b0, 16'hACE1, 32'h0, 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(4);
        set_stim(8, "dc_mode", 1'b1, 1'b1, 1'b0, 16'hACE1, f2p(100_000.0), 32'h0, 32'h0, 2'b01, 10'd300, 10'd700);
        hold_cycles(200);

        // ---- S9: data_type_sel = 2'b10 ("square wave" per top_dig/README comment) ----
        set_stim(9, "sel_10_undocumented", 1'b1, 1'b0, 1'b0, 16'hACE1, 32'h0, 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(4);
        set_stim(9, "sel_10_undocumented", 1'b1, 1'b1, 1'b0, 16'hACE1, f2p(100_000.0), 32'h0, 32'h0, 2'b10, 10'd300, 10'd700);
        hold_cycles(400);

        // ---- S10: data_type_sel = 2'b11 ----
        set_stim(10, "sel_11", 1'b1, 1'b1, 1'b0, 16'hACE1, f2p(100_000.0), 32'h0, 32'h0, 2'b11, 10'd300, 10'd700);
        hold_cycles(400);

        // ---- S11: mid-run enable toggling (glitch/re-sync behaviour) ----
        set_stim(11, "enable_toggle", 1'b1, 1'b1, 1'b0, 16'hACE1, f2p(50_000.0), 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(200);
        set_stim(11, "enable_toggle", 1'b1, 1'b0, 1'b0, 16'hACE1, f2p(50_000.0), 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(50);
        set_stim(11, "enable_toggle", 1'b1, 1'b1, 1'b0, 16'hACE1, f2p(50_000.0), 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(300);

        // ---- S12: DITHER_SEED = 0 special case (must fall back to 16'hACE1 per RTL) ----
        set_stim(12, "dither_seed_zero", 1'b1, 1'b0, 1'b1, 16'h0000, f2p(100_000.0), 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(4);
        set_stim(12, "dither_seed_zero", 1'b1, 1'b1, 1'b1, 16'h0000, f2p(100_000.0), 32'h0, 32'h0, 2'b00, 10'd0, 10'd0);
        hold_cycles(300);

        $fclose(fd);
        $display("[tb_bioz_dds] Simulation complete. Log written to bioz_samples.csv");
        $finish;
    end

    // watchdog
    initial begin
        #(200_000_000); // 200ms sim-time ceiling
        $display("[tb_bioz_dds] ERROR: watchdog timeout");
        $fclose(fd);
        $finish;
    end

endmodule
