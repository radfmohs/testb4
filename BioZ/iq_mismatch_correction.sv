`timescale 1ns/1ps

// 2x2 IQ mismatch correction.
//
// Place this block after analog-IQ ADC sampling / digital LPF, and before the
// calibrated impedance calculation.
//
// It implements:
//
//   i0 = i_in - i_offset
//   q0 = q_in - q_offset
//
//   i_corr = a*i0 + b*q0
//   q_corr = c*i0 + d*q0
//
// Coefficients are signed fixed point Q*.COEFF_FRAC.
// With defaults COEFF_W=18 and COEFF_FRAC=16:
//
//   1.0  = 18'sd65536
//   0.0  = 18'sd0
//   -0.1 ~= -18'sd6554
//
// Identity correction:
//
//   a = 1.0, b = 0.0
//   c = 0.0, d = 1.0
// unsigned_data_input:
// if input signed data, then output signed data
// if input unsigned data, then output unsigned data
module iq_mismatch_correction #(
    parameter integer IN_W       = 20,
    parameter integer OUT_W      = 20,
    parameter integer COEFF_W    = 18,
    parameter integer COEFF_FRAC = 16
) (
    input  wire                         clk,
    input  wire                         rst,
    input  wire                         in_valid,

    input  wire 			unsigned_data_input,

    input  wire signed [IN_W-1:0]       i_in_in,
    input  wire signed [IN_W-1:0]       q_in_in,
    input  wire signed [IN_W-1:0]       i_offset,
    input  wire signed [IN_W-1:0]       q_offset,

    input  wire signed [COEFF_W-1:0]    coeff_a,
    input  wire signed [COEFF_W-1:0]    coeff_b,
    input  wire signed [COEFF_W-1:0]    coeff_c,
    input  wire signed [COEFF_W-1:0]    coeff_d,

    output wire  signed [OUT_W-1:0]      i_out,
    output wire  signed [OUT_W-1:0]      q_out,
    output reg                          out_valid,
    output reg                          overflow
);

    localparam integer CENTER_W = IN_W + 1;
    localparam integer PROD_W   = CENTER_W + COEFF_W;
    localparam integer SUM_W    = PROD_W + 1;

    localparam signed [OUT_W-1:0] OUT_MAX = {1'b0, {OUT_W-1{1'b1}}};
    localparam signed [OUT_W-1:0] OUT_MIN = {1'b1, {OUT_W-1{1'b0}}};

    localparam signed [SUM_W-1:0] OUT_MAX_EXT =
        {{(SUM_W-OUT_W){1'b0}}, OUT_MAX};

    localparam signed [SUM_W-1:0] OUT_MIN_EXT =
        {{(SUM_W-OUT_W){1'b1}}, OUT_MIN};

    localparam signed [SUM_W-1:0] ROUND_HALF =
        {{(SUM_W-COEFF_FRAC){1'b0}}, 1'b1, {(COEFF_FRAC-1){1'b0}}};

    wire signed [IN_W-1:0]       i_in;
    wire signed [IN_W-1:0]       q_in;


wire signed [IN_W:0] i_in_in_ext = {i_in_in[IN_W-1], i_in_in};
wire signed [IN_W:0] q_in_in_ext = {q_in_in[IN_W-1], q_in_in};

    wire signed [IN_W:0]       i_in_bak;
    wire signed [IN_W:0]       q_in_bak;
assign i_in_bak = i_in_in_ext + $signed({1'b0,1'b1,{(IN_W-1){1'b0}}});
assign q_in_bak = q_in_in_ext + $signed({1'b0,1'b1,{(IN_W-1){1'b0}}});
assign i_in = unsigned_data_input ? i_in_bak[IN_W-1:0] : i_in_in;
assign q_in = unsigned_data_input ? q_in_bak[IN_W-1:0] : q_in_in;


    wire signed [CENTER_W-1:0] i_centered =
        {i_in[IN_W-1], i_in} - {i_offset[IN_W-1], i_offset};

    wire signed [CENTER_W-1:0] q_centered =
        {q_in[IN_W-1], q_in} - {q_offset[IN_W-1], q_offset};

    wire signed [PROD_W-1:0] prod_ai = $signed(coeff_a) * $signed(i_centered);
    wire signed [PROD_W-1:0] prod_bq = $signed(coeff_b) * $signed(q_centered);
    wire signed [PROD_W-1:0] prod_ci = $signed(coeff_c) * $signed(i_centered);
    wire signed [PROD_W-1:0] prod_dq = $signed(coeff_d) * $signed(q_centered);

    wire signed [SUM_W-1:0] i_sum =
        {prod_ai[PROD_W-1], prod_ai} + {prod_bq[PROD_W-1], prod_bq};

    wire signed [SUM_W-1:0] q_sum =
        {prod_ci[PROD_W-1], prod_ci} + {prod_dq[PROD_W-1], prod_dq};

    // Add half an LSB before the arithmetic shift. This gives round-to-nearest
    // behavior while preserving exact integer-scaled negative values.
    wire signed [SUM_W-1:0] i_rounded = i_sum + ROUND_HALF;
    wire signed [SUM_W-1:0] q_rounded = q_sum + ROUND_HALF;

    wire signed [SUM_W-1:0] i_shifted = i_rounded >>> COEFF_FRAC;
    wire signed [SUM_W-1:0] q_shifted = q_rounded >>> COEFF_FRAC;

    wire i_overflow = (i_shifted > OUT_MAX_EXT) || (i_shifted < OUT_MIN_EXT);
    wire q_overflow = (q_shifted > OUT_MAX_EXT) || (q_shifted < OUT_MIN_EXT);

    wire signed [OUT_W-1:0] i_saturated =
        (i_shifted > OUT_MAX_EXT) ? OUT_MAX :
        (i_shifted < OUT_MIN_EXT) ? OUT_MIN :
        i_shifted[OUT_W-1:0];

    wire signed [OUT_W-1:0] q_saturated =
        (q_shifted > OUT_MAX_EXT) ? OUT_MAX :
        (q_shifted < OUT_MIN_EXT) ? OUT_MIN :
        q_shifted[OUT_W-1:0];

    reg  signed [OUT_W-1:0]      i_out_out;
    reg  signed [OUT_W-1:0]      q_out_out;
    always @(posedge clk) begin
        if (rst) begin
            i_out_out <= {OUT_W{1'b0}};
            q_out_out <= {OUT_W{1'b0}};
            out_valid <= 1'b0;
            overflow  <= 1'b0;
        end else begin
            out_valid <= in_valid;

            if (in_valid) begin
                i_out_out <= i_saturated;
                q_out_out <= q_saturated;
                overflow  <= i_overflow || q_overflow;
            end
        end
    end


wire signed [IN_W:0] i_out_out_ext = {i_out_out[IN_W-1], i_out_out};
wire signed [IN_W:0] q_out_out_ext = {q_out_out[IN_W-1], q_out_out};

    wire signed [IN_W:0]       i_out_bak;
    wire signed [IN_W:0]       q_out_bak;
assign i_out_bak = i_out_out_ext + $signed({1'b0,1'b1,{(IN_W-1){1'b0}}});
assign q_out_bak = q_out_out_ext + $signed({1'b0,1'b1,{(IN_W-1){1'b0}}});
assign i_out = unsigned_data_input ? i_out_bak[IN_W-1:0] : i_out_out;
assign q_out = unsigned_data_input ? q_out_bak[IN_W-1:0] : q_out_out;

endmodule




