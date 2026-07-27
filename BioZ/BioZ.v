
module BioZ #(
    parameter integer PHASE_W = 32
) (
   input  wire        clk,                          // PCLK 
   input  wire        resetn,                       // Reset
   input  wire                    enable,
   input  wire [PHASE_W-1:0]      phase_inc,
   input  wire [PHASE_W-1:0]      phase_offset,  //if don't start from 0
   output wire unsigned [9:0]     sin_unsigned,
   output wire unsigned [9:0]     cos_unsigned, 
   output wire 		   	  i_square,
   output wire 		   	  q_square,
   output wire [PHASE_W:0]      phase_acc    //incase want to use fout freq
);

dds_sincos_10b_lut128_4m #(
    .PHASE_W(32)
) u_dds_sincos_10b_lut128_4m(
    .clk(clk),
    .rstn(resetn),
    .enable(enable),
    .phase_inc(phase_inc),
    .phase_offset(phase_offset),  //if don't start from 0
    .sin_unsigned(sin_unsigned),
    .cos_unsigned(cos_unsigned),
    .i_square(i_square),
    .q_square(q_square),
    .phase_acc(phase_acc)    //incase want to use this fout
     );
   
endmodule 
