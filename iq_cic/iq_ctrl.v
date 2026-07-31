/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/* File Name	: iq_ctrl.v                                                           */
/* Project	: Nanochap Glucose Chip                                                     */
/* Description	: IMEAS Control module                                                  */
/* Designer	: Daniel Wang                                                               */
/* Date		: 05/21/2019                                                                */
/* Revision	: R001 first draft                                                          */
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
`timescale 1ns/1ps

module iq_ctrl(


input  adc_clk,
input  cic_rst_n,
input  wire         pclk,
input  wire         preset_n,
input  wire         sd16eoc_sync,
input  wire  [19:0] sd16cic_data,
input  wire         sd16rst,
input  wire    	    chmod,
input  wire  [5:0]  rst_val,


output wire  [19:0] ch0data,
output wire   	    ch0data_en_n,
output wire         cic_rst,

input  wire         format_sel,

output wire         int_set
);

wire          sd16eoc_pos; 
wire          rst_per_cycle;
reg           sd16eoc_sync_d1;
reg  [19:0]   ch0data_reg;
reg     ch0data_en_reg;
reg  [5:0]    rst_cnt;
wire          hw_rst;
reg           cic_rst_reg;


always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    sd16eoc_sync_d1 <= 1'b0;
  else
    sd16eoc_sync_d1 <= sd16eoc_sync;
end

assign sd16eoc_pos = sd16eoc_sync & ~sd16eoc_sync_d1; //1t pusle of sd16eoc posedge 

//group convesion mode
assign rst_per_cycle = chmod ;


//cic filter reset count plus after eoc
always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    rst_cnt <= 6'h0;
  else if (rst_cnt == rst_val)
    rst_cnt <= 6'h0;
  else if (rst_per_cycle & sd16eoc_pos | (rst_cnt!=6'h0))
    rst_cnt <= rst_cnt + 6'h1;
  else
    rst_cnt <= rst_cnt;
end

assign hw_rst = rst_per_cycle ? (rst_cnt != 6'h0) : 1'b0;

//and of sw reset, output to cic filter  
always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    cic_rst_reg <= 1'b0;
  else
    cic_rst_reg <= sd16rst | hw_rst;
end

assign cic_rst = cic_rst_reg;


assign int_set = sd16eoc_pos;


//channel 0 data 
always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    ch0data_reg <= 20'h0;
  else if (sd16eoc_pos)
    ch0data_reg <= sd16cic_data;
  else
    ch0data_reg <= ch0data_reg;
end

always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    ch0data_en_reg <= 1'b0;
  else if (sd16eoc_pos)
    ch0data_en_reg <= 1'b1;
  else
    ch0data_en_reg <= 1'b0;
end


assign ch0data = ch0data_reg;
assign ch0data_en_n = ~ch0data_en_reg;

endmodule
