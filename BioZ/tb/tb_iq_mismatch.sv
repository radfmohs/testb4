`timescale 1ns/1ps
//--------------------------------------------------------------------------------------
// tb_iq_mismatch.sv
//
// Standalone testbench for BioZ/iq_mismatch_correction.sv.
//
// NOTE ON SYSTEM CONTEXT: this block is NOT instantiated anywhere in the
// current design (see BioZ/tb/../REVIEW.md). It matches exactly the
// "IQ Mismatch Mitigation" calibration stage described in
// Bioimpedance_IQ_Demod_SysAna.docx (gain/phase mismatch correction applied
// after the ADC, before magnitude/phase extraction), so it is tested here on
// its own merits as a standalone, reusable block.
//--------------------------------------------------------------------------------------
module tb_iq_mismatch;

    localparam integer IN_W       = 20;
    localparam integer OUT_W      = 20;
    localparam integer COEFF_W    = 18;
    localparam integer COEFF_FRAC = 16;
    localparam real    ONE_Q      = 65536.0; // 2^COEFF_FRAC = 1.0 in Q2.16

    reg                          clk;
    reg                          rst;
    reg                          in_valid;
    reg                          unsigned_data_input;
    reg  signed [IN_W-1:0]       i_in_in, q_in_in;
    reg  signed [IN_W-1:0]       i_offset, q_offset;
    reg  signed [COEFF_W-1:0]    coeff_a, coeff_b, coeff_c, coeff_d;

    wire signed [OUT_W-1:0]      i_out, q_out;
    wire                         out_valid, overflow;

    integer fd;
    integer vec_id;
    string  vec_name;

    iq_mismatch_correction #(
        .IN_W(IN_W), .OUT_W(OUT_W), .COEFF_W(COEFF_W), .COEFF_FRAC(COEFF_FRAC)
    ) dut (
        .clk(clk), .rst(rst), .in_valid(in_valid),
        .unsigned_data_input(unsigned_data_input),
        .i_in_in(i_in_in), .q_in_in(q_in_in),
        .i_offset(i_offset), .q_offset(q_offset),
        .coeff_a(coeff_a), .coeff_b(coeff_b), .coeff_c(coeff_c), .coeff_d(coeff_d),
        .i_out(i_out), .q_out(q_out),
        .out_valid(out_valid), .overflow(overflow)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk; // 100MHz, arbitrary (block is a pure combinational/1-stage-pipe DSP datapath)

    always @(posedge clk) begin
        #1;
        $fwrite(fd, "%0d,%0d,%s,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d\n",
            $time, vec_id, vec_name,
            rst, in_valid, unsigned_data_input,
            i_in_in, q_in_in, i_offset, q_offset,
            coeff_a, coeff_b, coeff_c, coeff_d,
            i_out, q_out, out_valid, overflow);
    end

    function automatic signed [COEFF_W-1:0] q16(input real r);
        q16 = $rtoi(r * ONE_Q + (r >= 0 ? 0.5 : -0.5));
    endfunction

    task automatic drive(
        input integer id, input string name_,
        input reg r_rst, input reg r_valid, input reg r_uns,
        input reg signed [IN_W-1:0] r_i, input reg signed [IN_W-1:0] r_q,
        input reg signed [IN_W-1:0] r_io, input reg signed [IN_W-1:0] r_qo,
        input reg signed [COEFF_W-1:0] r_a, input reg signed [COEFF_W-1:0] r_b,
        input reg signed [COEFF_W-1:0] r_c, input reg signed [COEFF_W-1:0] r_d);
        @(negedge clk);
        vec_id = id; vec_name = name_;
        rst = r_rst; in_valid = r_valid; unsigned_data_input = r_uns;
        i_in_in = r_i; q_in_in = r_q; i_offset = r_io; q_offset = r_qo;
        coeff_a = r_a; coeff_b = r_b; coeff_c = r_c; coeff_d = r_d;
    endtask

    integer i;
    integer seed;
    reg signed [IN_W-1:0] rnd_i, rnd_q, rnd_io, rnd_qo;
    reg signed [COEFF_W-1:0] rnd_a, rnd_b, rnd_c, rnd_d;

    initial begin
        fd = $fopen("iq_mismatch_samples.csv", "w");
        $fwrite(fd, "time,vec_id,vec_name,rst,in_valid,unsigned_data_input,i_in_in,q_in_in,i_offset,q_offset,coeff_a,coeff_b,coeff_c,coeff_d,i_out,q_out,out_valid,overflow\n");
        seed = 32'hC0FFEE;

        // ---- V0: reset ----
        drive(0, "reset", 1'b1, 1'b0, 1'b0, 20'sd0, 20'sd0, 20'sd0, 20'sd0, q16(1.0), q16(0.0), q16(0.0), q16(1.0));
        repeat (5) @(posedge clk);
        drive(0, "reset", 1'b0, 1'b0, 1'b0, 20'sd0, 20'sd0, 20'sd0, 20'sd0, q16(1.0), q16(0.0), q16(0.0), q16(1.0));
        repeat (2) @(posedge clk);

        // ---- V1: identity passthrough sweep (a=1,d=1,b=c=0, no offset) ----
        for (i = -4; i <= 4; i = i + 1) begin
            drive(1, "identity", 1'b0, 1'b1, 1'b0,
                  (i * 20'sd50000), (-i * 20'sd30000), 20'sd0, 20'sd0,
                  q16(1.0), q16(0.0), q16(0.0), q16(1.0));
            @(posedge clk);
        end
        drive(1, "identity", 1'b0, 1'b0, 1'b0, 20'sd0, 20'sd0, 20'sd0, 20'sd0, q16(1.0), q16(0.0), q16(0.0), q16(1.0));
        repeat (3) @(posedge clk);

        // ---- V2: DC-offset removal (identity gain, nonzero offsets) ----
        drive(2, "offset_removal", 1'b0, 1'b1, 1'b0, 20'sd123456, -20'sd98765, 20'sd50000, -20'sd20000,
              q16(1.0), q16(0.0), q16(0.0), q16(1.0));
        @(posedge clk);
        drive(2, "offset_removal", 1'b0, 1'b0, 1'b0, 20'sd0, 20'sd0, 20'sd0, 20'sd0, q16(1.0), q16(0.0), q16(0.0), q16(1.0));
        repeat (3) @(posedge clk);

        // ---- V3: pure gain correction (a=d=0.909 ~ 1/1.1, undo a 10% gain error) ----
        drive(3, "gain_only", 1'b0, 1'b1, 1'b0, 20'sd110000, -20'sd55000, 20'sd0, 20'sd0,
              q16(0.909091), q16(0.0), q16(0.0), q16(0.909091));
        @(posedge clk);
        drive(3, "gain_only", 1'b0, 1'b0, 1'b0, 20'sd0, 20'sd0, 20'sd0, 20'sd0, q16(1.0), q16(0.0), q16(0.0), q16(1.0));
        repeat (3) @(posedge clk);

        // ---- V4: gain+phase mismatch correction (docx numerical example) ----
        // True (R,X) = (100, 2) scaled x1000 -> ideal (I,Q) = (100000, 2000).
        // Forward-model a realistic analog mismatch: 1% gain error + 1 deg
        // phase error mixed onto the Q channel (matches the doc's resistive
        // cross-talk derivation), then verify the inverse correction matrix
        // recovers (I,Q) close to ideal.
        begin
            real true_i, true_q, meas_i, meas_q, theta_rad;
            real m_gain, m_a, m_b, m_c, m_d;
            real inv_det, c_a, c_b, c_c, c_d;
            true_i = 100000.0;
            true_q = 2000.0;
            m_gain = 0.01;      // 1% gain mismatch on Q
            theta_rad = 1.0 * 3.14159265358979 / 180.0; // 1 degree phase error

            // forward mismatch matrix (small-angle LO model from the doc):
            // I' =  I*cos(theta/2)      - Q*sin(theta/2)
            // Q' =  I*sin(theta/2)*(1+g) + Q*cos(theta/2)*(1+g)
            m_a = $cos(theta_rad / 2.0);
            m_b = -$sin(theta_rad / 2.0);
            m_c = $sin(theta_rad / 2.0) * (1.0 + m_gain);
            m_d = $cos(theta_rad / 2.0) * (1.0 + m_gain);

            meas_i = m_a * true_i + m_b * true_q;
            meas_q = m_c * true_i + m_d * true_q;

            // correction matrix = inverse of forward mismatch matrix
            inv_det = 1.0 / (m_a * m_d - m_b * m_c);
            c_a =  m_d * inv_det;
            c_b = -m_b * inv_det;
            c_c = -m_c * inv_det;
            c_d =  m_a * inv_det;

            drive(4, "gain_phase_mismatch_correction", 1'b0, 1'b1, 1'b0,
                  $rtoi(meas_i), $rtoi(meas_q), 20'sd0, 20'sd0,
                  q16(c_a), q16(c_b), q16(c_c), q16(c_d));
            @(posedge clk);
        end
        drive(4, "gain_phase_mismatch_correction", 1'b0, 1'b0, 1'b0, 20'sd0, 20'sd0, 20'sd0, 20'sd0, q16(1.0), q16(0.0), q16(0.0), q16(1.0));
        repeat (3) @(posedge clk);

        // ---- V5: saturation / overflow ----
        // NOTE: COEFF_W=18 with COEFF_FRAC=16 leaves only 2 integer bits, so
        // the representable coefficient range is [-2.0, +1.999985]. Use a
        // large-but-legal gain (1.9) together with near-full-scale inputs to
        // force genuine OUTPUT saturation without overflowing the
        // coefficient encoding itself.
        drive(5, "saturation", 1'b0, 1'b1, 1'b0, 20'sd524287, -20'sd524288, 20'sd0, 20'sd0,
              q16(1.9), q16(0.0), q16(0.0), q16(1.9));
        @(posedge clk);
        drive(5, "saturation", 1'b0, 1'b0, 1'b0, 20'sd0, 20'sd0, 20'sd0, 20'sd0, q16(1.0), q16(0.0), q16(0.0), q16(1.0));
        repeat (3) @(posedge clk);

        // ---- V6: unsigned_data_input passthrough (offset-binary domain) ----
        for (i = 0; i <= 8; i = i + 1) begin
            drive(6, "unsigned_mode", 1'b0, 1'b1, 1'b1,
                  (i * 20'sd131072), (20'sd524288 - i * 20'sd65536), 20'sd0, 20'sd0,
                  q16(1.0), q16(0.0), q16(0.0), q16(1.0));
            @(posedge clk);
        end
        drive(6, "unsigned_mode", 1'b0, 1'b0, 1'b0, 20'sd0, 20'sd0, 20'sd0, 20'sd0, q16(1.0), q16(0.0), q16(0.0), q16(1.0));
        repeat (3) @(posedge clk);

        // ---- V7: randomized regression (bursts + gaps in in_valid) ----
        for (i = 0; i < 500; i = i + 1) begin
            rnd_i  = $random(seed) % (1 <<< (IN_W - 1));
            rnd_q  = $random(seed) % (1 <<< (IN_W - 1));
            rnd_io = $random(seed) % (1 <<< (IN_W - 3));
            rnd_qo = $random(seed) % (1 <<< (IN_W - 3));
            rnd_a  = $random(seed) % (1 <<< (COEFF_FRAC + 2));
            rnd_b  = $random(seed) % (1 <<< (COEFF_FRAC - 1));
            rnd_c  = $random(seed) % (1 <<< (COEFF_FRAC - 1));
            rnd_d  = $random(seed) % (1 <<< (COEFF_FRAC + 2));
            drive(7, "random_regression", 1'b0, ($random(seed) % 4) != 0, ($random(seed) % 2),
                  rnd_i, rnd_q, rnd_io, rnd_qo, rnd_a, rnd_b, rnd_c, rnd_d);
            @(posedge clk);
        end
        drive(7, "random_regression", 1'b0, 1'b0, 1'b0, 20'sd0, 20'sd0, 20'sd0, 20'sd0, q16(1.0), q16(0.0), q16(0.0), q16(1.0));
        repeat (3) @(posedge clk);

        $fclose(fd);
        $display("[tb_iq_mismatch] Simulation complete. Log written to iq_mismatch_samples.csv");
        $finish;
    end

    initial begin
        #(1_000_000);
        $display("[tb_iq_mismatch] ERROR: watchdog timeout");
        $fclose(fd);
        $finish;
    end

endmodule
