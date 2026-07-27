`timescale 1ns / 1ps
//==============================================================================
// Nanochap Pty Ltd (c) 2019
// 
// Module Name : lfsr_12bit
// Description : dithering for spurious peak supression
// polynominal : x^12+x^11+x^8+x^6+1
//==============================================================================
// Revision History
//==============================================================================
// Revision	Date/Time			Author	
//==============================================================================

module lfsr_12bit
 (
  input  wire 			clk,		
  input  wire 			resetn,
  input  wire                   phase_dither_en,
  output reg  [11:0] 	        lfsr_out
 );

 always@(posedge clk or negedge resetn)
 begin
   if(~resetn)
     lfsr_out <= 12'b111111111111;
   else if(phase_dither_en)
   begin
     lfsr_out[0]  <= lfsr_out[11];
     lfsr_out[1]  <= lfsr_out[0];
     lfsr_out[2]  <= lfsr_out[1];
     lfsr_out[3]  <= lfsr_out[2];
     lfsr_out[4]  <= lfsr_out[3];
     lfsr_out[5]  <= lfsr_out[4];
     lfsr_out[6]  <= lfsr_out[11] ^ lfsr_out[5];
     lfsr_out[7]  <= lfsr_out[6];
     lfsr_out[8]  <= lfsr_out[11] ^ lfsr_out[7];
     lfsr_out[9]  <= lfsr_out[8];
     lfsr_out[10] <= lfsr_out[9];
     lfsr_out[11] <= lfsr_out[11] ^ lfsr_out[10];
   end
   else
     lfsr_out <= 12'b111111111111;
 end  
 
endmodule
