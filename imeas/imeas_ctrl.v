/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/* File Name	: imeas_ctrl.v                                                           */
/* Project	: Nanochap Glucose Chip                                                     */
/* Description	: IMEAS Control module                                                  */
/* Designer	: Daniel Wang                                                               */
/* Date		: 05/21/2019                                                                */
/* Revision	: R001 first draft                                                          */
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
`timescale 1ns/1ps

module imeas_ctrl(
//xin add 24 May 2024
input  wire 	    ppg_mode,
input  wire         filter0_en,
input  wire         filter1_en,

input  wire 	    old_group_mode_in,
//output wire 	    old_group_mode,
input  wire [11:0]  active_channel_num, //[3:0] chnA,[7:4] chnB, [11:8] chnC
input  adc_clk,
input  cic_rst_n,
input  wire         pclk,
input  wire         preset_n,
input  wire         sd16eoc_sync,
input  wire  [15:0] sd16cic_data,
input  wire         sd16rst,
input  wire  [1:0]  chmod,
input  wire  [3:0]  chnum,
input  wire  [7:0]  rst_val,
input  wire         nf_en,
input  wire         nf_int,


output wire  [15:0] ch0data,
output wire  [15:0] ch1data,
output wire  [15:0] ch2data,
output wire   ch0data_en_n,
output wire   ch1data_en_n,
output wire   ch2data_en_n,
output wire  [3:0]  chnum_out,
output reg   [2:0]  ch_cnt_reg,
output wire         cic_rst,

input  wire         format_sel,
input  wire [15:0]  threshold_hi,
input  wire [15:0]  threshold_lo,

output wire         int_alarm_set,
output wire         int_set0,
output wire         int_set1,
output wire         int_set
);

wire          sd16eoc_pos; 
wire          grp_mod;
reg           sd16eoc_sync_d1;
reg  [15:0]   ch0data_reg;
reg  [15:0]   ch1data_reg;
reg  [15:0]   ch2data_reg;
reg     ch0data_en_reg;
reg     ch1data_en_reg;
reg     ch2data_en_reg;
reg  [7:0]    rst_cnt;
wire          hw_rst;
reg           cic_rst_reg;
reg  [2:0]    ch_cnt;
reg  [3:0]    chnum_reg;


always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    sd16eoc_sync_d1 <= 1'b0;
  else
    sd16eoc_sync_d1 <= sd16eoc_sync;
end

assign sd16eoc_pos = sd16eoc_sync & ~sd16eoc_sync_d1; //1t pusle of sd16eoc posedge 

//group convesion mode
assign grp_mod = (chmod == 2'b10);
//assign old_group_mode=grp_mod & old_group_mode_in;


//cic filter reset count plus after eoc
always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    rst_cnt <= 8'h0;
  else if (rst_cnt == rst_val)
    rst_cnt <= 8'h0;
  else if (grp_mod & sd16eoc_pos | (rst_cnt!=8'h0))
    rst_cnt <= rst_cnt + 8'h1;
  else
    rst_cnt <= rst_cnt;
end

//assign hw_rst = (rst_cnt != 8'h0);
assign hw_rst = old_group_mode_in ? (rst_cnt != 8'h0) : 1'b0;

//and of sw reset, output to cic filter  
always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    cic_rst_reg <= 1'b0;
  else
    cic_rst_reg <= sd16rst | hw_rst;
end

assign cic_rst = cic_rst_reg;

//channel count plus after eoc
always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    ch_cnt <= 3'b000;
  else if (~grp_mod | sd16eoc_pos & (ch_cnt == 3'b010))
  //else if (~grp_mod | sd16eoc_pos & (ppg_mode ? (ch_cnt == 3'b001) : (ch_cnt == 3'b010)))
    ch_cnt <= 3'b000;
  else if (grp_mod & sd16eoc_pos)
    ch_cnt <= ch_cnt + 3'b001;
  else
    ch_cnt <= ch_cnt;
end

reg flg_ch_chg;
always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
	flg_ch_chg <= 1'b0;
  else if (grp_mod & sd16eoc_pos)
	flg_ch_chg <= ~flg_ch_chg;
end

reg flg_ch_chg_d1;
always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
	flg_ch_chg_d1 <= 1'b0;
  else
	flg_ch_chg_d1 <= flg_ch_chg;
end

//channal number select 
always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    chnum_reg <= 4'b0;
  else
    //chnum_reg <= grp_mod ? {1'b0,ch_cnt} : chnum;
    chnum_reg <= grp_mod ? ((ch_cnt == 3'h0) ? active_channel_num[3:0] :
			    (ch_cnt == 3'h1) ? active_channel_num[7:4] :
					       active_channel_num[11:8] 
			   )
			 : chnum;
end

reg flg_ch_chg_d2;
reg flg_ch_chg_d3;
reg flg_ch_chg_d4;
always @ (posedge adc_clk or negedge cic_rst_n) begin
  if (~cic_rst_n) begin
	flg_ch_chg_d2 <= 1'b0;
	flg_ch_chg_d3 <= 1'b0;
	flg_ch_chg_d4 <= 1'b0;
  end else begin
	flg_ch_chg_d2 <= flg_ch_chg_d1;
	flg_ch_chg_d3 <= flg_ch_chg_d2;
	flg_ch_chg_d4 <= flg_ch_chg_d3;
  end
end
wire pos_flg_ch_chg = flg_ch_chg_d3 ^ flg_ch_chg_d4; 
reg [3:0] chnum_reg_d1;
always @ (posedge adc_clk or negedge cic_rst_n) begin
  if (~cic_rst_n) begin 
	chnum_reg_d1 <=  4'b0;
	ch_cnt_reg <=  3'b0;
  end else if(old_group_mode_in ? 1'b1 : pos_flg_ch_chg) begin
	chnum_reg_d1 <=  chnum_reg;
	ch_cnt_reg <=  ch_cnt;
  end
end

reg flg_first_chnum;
always @ (posedge adc_clk or negedge cic_rst_n) begin
  if (~cic_rst_n)  
	flg_first_chnum <=  1'b1;
  else if(old_group_mode_in ? 1'b1 : pos_flg_ch_chg)
	flg_first_chnum <=  1'b0;
end
//assign chnum_out = chnum_reg_d1;
assign chnum_out = (~grp_mod) ? chnum : 
		   (flg_first_chnum ? active_channel_num[3:0] : chnum_reg_d1);

//interrupt set, 1T pulse
//assign int_set = grp_mod ? (sd16eoc_pos & (ch_cnt == 3'b010)) : sd16eoc_pos;
assign int_set = nf_en? nf_int : ppg_mode ? sd16eoc_pos : grp_mod ? (sd16eoc_pos & (ch_cnt == 3'b010)) : sd16eoc_pos;
//assign int_set = grp_mod ? (sd16eoc_pos & (ppg_mode ? (ch_cnt == 3'b001) : (ch_cnt == 3'b010))) : sd16eoc_pos;
assign int_set0 = ppg_mode ? (filter0_en & sd16eoc_pos) : 1'b0;
assign int_set1 = ppg_mode ? (filter1_en & sd16eoc_pos) : 1'b0;

wire bigger_than_threshold_hi  = format_sel? sd16cic_data > threshold_hi : $signed(sd16cic_data) > $signed(threshold_hi);
wire smaller_than_threshold_lo = format_sel? sd16cic_data < threshold_lo : $signed(sd16cic_data) < $signed(threshold_lo);

assign int_alarm_set =  sd16eoc_pos & (bigger_than_threshold_hi
				       | smaller_than_threshold_lo);

//channel 0 data 
always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    ch0data_reg <= 16'h0;
  //else if ((~grp_mod | ch_cnt==3'b000) & sd16eoc_pos)
  else if ((ppg_mode ? filter0_en : (~grp_mod | ch_cnt==3'b000)) & sd16eoc_pos)
    ch0data_reg <= sd16cic_data;
  else
    ch0data_reg <= ch0data_reg;
end

always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    ch0data_en_reg <= 1'b0;
  //else if ((~grp_mod | ch_cnt==3'b000) & sd16eoc_pos)
  else if ((ppg_mode ? filter0_en : (~grp_mod | ch_cnt==3'b000)) & sd16eoc_pos)
    ch0data_en_reg <= 1'b1;
  else
    ch0data_en_reg <= 1'b0;
end

//channel 1 data 
always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    ch1data_reg <= 16'h0;
  //else if (grp_mod & ch_cnt==3'b001 & sd16eoc_pos)
  else if ((ppg_mode ? filter1_en : (grp_mod & ch_cnt==3'b001)) & sd16eoc_pos)
    ch1data_reg <= sd16cic_data;
  else
    ch1data_reg <= ch1data_reg;
end

always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    ch1data_en_reg <= 1'b0;
  //else if (grp_mod & ch_cnt==3'b001 & sd16eoc_pos)
  else if ((ppg_mode ? filter1_en : (grp_mod & ch_cnt==3'b001)) & sd16eoc_pos)
    ch1data_en_reg <= 1'b1;
  else
    ch1data_en_reg <= 1'b0;
end


//channel 2 data 
always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    ch2data_reg <= 16'h0;
  else if (grp_mod & ch_cnt==3'b010 & sd16eoc_pos)
    ch2data_reg <= sd16cic_data;
  else
    ch2data_reg <= ch2data_reg;
end

always @ (posedge pclk or negedge preset_n) begin
  if (~preset_n)
    ch2data_en_reg <= 1'b0;
  else if (grp_mod & ch_cnt==3'b010 & sd16eoc_pos)
    ch2data_en_reg <= 1'b1;
  else
    ch2data_en_reg <= 1'b0;
end


assign ch0data = ch0data_reg;
assign ch1data = ch1data_reg;
assign ch2data = ch2data_reg;
assign ch0data_en_n = ~ch0data_en_reg;
assign ch1data_en_n = ~ch1data_en_reg;
assign ch2data_en_n = ~ch2data_en_reg;

endmodule
