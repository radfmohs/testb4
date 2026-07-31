
module BioZ #(
    parameter integer PHASE_W = 32
) (
   input  wire        clk,                          // PCLK 
   input  wire        resetn,                       // Reset
   input  wire                    enable,

//dithering feature
   input  wire		 	  DITHER_EN,
   input  wire [15:0]  		  DITHER_SEED,  

   input  wire [PHASE_W-1:0]      phase_inc,
   input  wire [PHASE_W-1:0]      phase_offset,  //if don't start from 0
   input  wire [PHASE_W-1:0]      phase_offset_c,  //if don't start from 0
   output wire unsigned [9:0]     sin_unsigned,
   output wire unsigned [9:0]     cos_unsigned, 
   input  wire [1:0]   		  data_type_sel,    //00 is sinwave, 01: DC, others: sinwave
   input  wire unsigned [9:0]     dc_data,    
   input  wire unsigned [9:0]     dc_data_c,    
   output wire 		   	  i_square,
   output wire 		   	  q_square,
   output wire [PHASE_W:0]        phase_acc    //incase want to use fout freq
);

    localparam integer DITHER_W = 8;

   wire unsigned [9:0]     sin_unsigned_bak;
   wire unsigned [9:0]     cos_unsigned_bak; 
   assign    sin_unsigned = (data_type_sel == 2'b00) ? sin_unsigned_bak : 
			    (data_type_sel == 2'b01) ? dc_data   : sin_unsigned_bak;
   assign    cos_unsigned = (data_type_sel == 2'b00) ? cos_unsigned_bak : 
			    (data_type_sel == 2'b01) ? dc_data_c : cos_unsigned_bak; 

dds_sincos_10b_lut128_4m #(
    .PHASE_W(32),
    .DITHER_W(DITHER_W)
) u_dds_sincos_10b_lut128_4m(
    .clk(clk),
    .rstn(resetn),
    .enable(enable),
    .DITHER_EN(DITHER_EN),
    .DITHER_SEED(DITHER_SEED),  
    .phase_inc(phase_inc),
    .phase_offset(phase_offset),  //if don't start from 0
    .phase_offset_c(phase_offset_c),  //if don't start from 0
    .sin_unsigned(sin_unsigned_bak),
    .cos_unsigned(cos_unsigned_bak),
    .i_square(i_square),
    .q_square(q_square),
    .phase_acc(phase_acc)    //incase want to use this fout
     );
   
endmodule 
