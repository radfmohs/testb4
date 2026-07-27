/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/* File Name	: imeas_reg.v                                                           */
/* Project	: Nanochap Glucose Chip                                                     */
/* Description	: IMEAS register                                                        */
/* Designer	: Daniel Wang                                                               */
/* Date		: 05/21/2019                                                                */
/* Revision	: R001 first draft                                                          */
/* Revision	: R002 changed altogether by Mohsen Radfar to conennect to SPI rahter than ahb   */
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/

module imeas_reg(
input  wire        pclk,        // pclk 
input  wire        preset_n,    // Reset
input  wire	   atpg_en, //in scan mode

input  wire [15:0] reg_ctrl,
input  wire [7:0]  reg_ch,
input  wire [2:0]  reg_seq,
input  wire [7:0]  reg_rstval,

input  wire	   int_clr,
input  wire        int_set,     // interrupt 1T pulse
input  wire        int_set0,     // interrupt 1T pulse
input  wire        int_set1,     // interrupt 1T pulse
output reg         int_sts,
output reg         int_sts0,
output reg         int_sts1,
output wire         bio_int_sts,

input  wire  leadoff_int_en,
input  wire hit_tgt_switch_loff_statn,
input  wire hit_tgt_duration_loff_statn,
output  reg int_sts_switch_loff_statn,
output  reg int_sts_duration_loff_statn,
input  wire hit_tgt_switch_loff_statp,
input  wire hit_tgt_duration_loff_statp,
output  reg int_sts_switch_loff_statp,
output  reg int_sts_duration_loff_statp,

input  wire hit_tgt_switch_acloff_statn,
input  wire hit_tgt_duration_acloff_statn,
output  reg int_sts_switch_acloff_statn,
output  reg int_sts_duration_acloff_statn,
input  wire hit_tgt_switch_acloff_statp,
input  wire hit_tgt_duration_acloff_statp,
output  reg int_sts_switch_acloff_statp,
output  reg int_sts_duration_acloff_statp,


input  wire        wrong_data,
input  wire 	   check_pulse_pclk,
input  wire	   int_alarm_en,
input  wire	   int_alarm_clr,
input  wire        int_alarm_set,     // interrupt 1T pulse
output reg         int_alarm_sts,

//removed as the new pin list
/*
output wire [5:0]  webias_dac,
output wire [1:0]  rebias_dac,
output wire        gubias_en,
output wire        cal_en,
output wire [1:0]  pga_gain,
*/
//xin add 24 May 2024 for led_status cowork
output wire        ppg_mode,
output wire        restart,

output wire [2:0]  cic_rate,
output wire [1:0]  chmod,
output wire        chrsv,
output wire        format_sel,
output wire [3:0]  chnum,
//output wire        sd16off,
//output wire        sd16slp,
output wire        sd16rst,
output wire [7:0]  rst_val,

output wire        imeas_int_alarm, // interrupt
output wire        imeas_int // interrupt
);

wire          int_en;
wire          int_bio_en;

reg   [31:0]  read_data;

assign int_en       = reg_ctrl[0];
//assign cal_en       = reg_ctrl[1];
//assign pga_gain     = reg_ctrl[3:2];
assign cic_rate     = reg_ctrl[6:4];
//assign gubias_en    = reg_ctrl[7];
//assign rebias_dac   = reg_ctrl[9:8];
//assign webias_dac   = reg_ctrl[15:10];
assign        ppg_mode = reg_ctrl[7];
assign        restart = reg_ctrl[1];
assign        int_bio_en = reg_ctrl[2];

assign chmod        = reg_ch[1:0];
assign format_sel   = reg_ch[2];
assign chrsv        = reg_ch[3];
assign chnum        = reg_ch[7:4];

//assign sd16off = reg_seq[0];
//assign sd16slp = reg_seq[1];
assign sd16rst = reg_seq[2];

assign rst_val = reg_rstval;

//interrupt generate
//wire imeas_int_rstn = atpg_en ? preset_n: preset_n & (~int_clr);
wire imeas_int_rstn_bak = atpg_en ? preset_n: preset_n & (~int_clr);
wire imeas_int_rstn; 
common_rst_sync u_imeas_int_rstn_sync(
.RSTINn    (imeas_int_rstn_bak),
.RSTREQ    (1'b0),
.CLK       (pclk),
.SE        (atpg_en),
.RSTBYPASS (atpg_en),
.RSTOUTn   (imeas_int_rstn)
);
//always @(posedge pclk or negedge preset_n) begin
always @(posedge pclk or negedge imeas_int_rstn) begin
  //if (~preset_n)
  if (~imeas_int_rstn)
    int_sts <= 1'b0;
  //else if (int_clr)
  //  int_sts <= 1'b0;
  else if (int_set)
    int_sts <= 1'b1;
  else
    int_sts <= int_sts;
end


always @(posedge pclk or negedge imeas_int_rstn) begin
  if (~imeas_int_rstn)
    int_sts0 <= 1'b0;
  else if (int_set0)
    int_sts0 <= 1'b1;
  else
    int_sts0 <= int_sts0;
end

always @(posedge pclk or negedge imeas_int_rstn) begin
  if (~imeas_int_rstn)
    int_sts1 <= 1'b0;
  else if (int_set1)
    int_sts1 <= 1'b1;
  else
    int_sts1 <= int_sts1;
end

wire int_sts_final;
assign int_sts_final = ppg_mode ? (int_sts0 | int_sts1) : int_sts;

reg int_bio_sts;
always @(posedge pclk or negedge imeas_int_rstn) begin
  if (~imeas_int_rstn)
    int_bio_sts <= 1'b0;
  else if (check_pulse_pclk & (~wrong_data))
    int_bio_sts <= 1'b1;
  else
    int_bio_sts <= int_bio_sts;
end
assign         bio_int_sts = int_bio_sts;

//reg int_sts_switch;
always @(posedge pclk or negedge imeas_int_rstn) begin
  if (~imeas_int_rstn)
    int_sts_switch_loff_statn <= 1'b0;
  else if (hit_tgt_switch_loff_statn)
    int_sts_switch_loff_statn <= 1'b1;
  else
    int_sts_switch_loff_statn <= int_sts_switch_loff_statn;
end

//reg int_sts_duration;
always @(posedge pclk or negedge imeas_int_rstn) begin
  if (~imeas_int_rstn)
    int_sts_duration_loff_statn <= 1'b0;
  else if (hit_tgt_duration_loff_statn)
    int_sts_duration_loff_statn <= 1'b1;
  else
    int_sts_duration_loff_statn <= int_sts_duration_loff_statn;
end


//reg int_sts_switch;
always @(posedge pclk or negedge imeas_int_rstn) begin
  if (~imeas_int_rstn)
    int_sts_switch_loff_statp <= 1'b0;
  else if (hit_tgt_switch_loff_statp)
    int_sts_switch_loff_statp <= 1'b1;
  else
    int_sts_switch_loff_statp <= int_sts_switch_loff_statp;
end

//reg int_sts_duration;
always @(posedge pclk or negedge imeas_int_rstn) begin
  if (~imeas_int_rstn)
    int_sts_duration_loff_statp <= 1'b0;
  else if (hit_tgt_duration_loff_statp)
    int_sts_duration_loff_statp <= 1'b1;
  else
    int_sts_duration_loff_statp <= int_sts_duration_loff_statp;
end


//reg int_sts_switch;
always @(posedge pclk or negedge imeas_int_rstn) begin
  if (~imeas_int_rstn)
    int_sts_switch_acloff_statn <= 1'b0;
  else if (hit_tgt_switch_acloff_statn)
    int_sts_switch_acloff_statn <= 1'b1;
  else
    int_sts_switch_acloff_statn <= int_sts_switch_acloff_statn;
end

//reg int_sts_duration;
always @(posedge pclk or negedge imeas_int_rstn) begin
  if (~imeas_int_rstn)
    int_sts_duration_acloff_statn <= 1'b0;
  else if (hit_tgt_duration_acloff_statn)
    int_sts_duration_acloff_statn <= 1'b1;
  else
    int_sts_duration_acloff_statn <= int_sts_duration_acloff_statn;
end


//reg int_sts_switch;
always @(posedge pclk or negedge imeas_int_rstn) begin
  if (~imeas_int_rstn)
    int_sts_switch_acloff_statp <= 1'b0;
  else if (hit_tgt_switch_acloff_statp)
    int_sts_switch_acloff_statp <= 1'b1;
  else
    int_sts_switch_acloff_statp <= int_sts_switch_acloff_statp;
end

//reg int_sts_duration;
always @(posedge pclk or negedge imeas_int_rstn) begin
  if (~imeas_int_rstn)
    int_sts_duration_acloff_statp <= 1'b0;
  else if (hit_tgt_duration_acloff_statp)
    int_sts_duration_acloff_statp <= 1'b1;
  else
    int_sts_duration_acloff_statp <= int_sts_duration_acloff_statp;
end



//assign imeas_int = int_sts & int_en;
//assign imeas_int = int_sts_final & int_en;
//assign imeas_int = (int_sts_final & int_en) | (int_bio_sts & int_bio_en);
assign imeas_int = (int_sts_final & int_en) | (int_bio_sts & int_bio_en) | (((int_sts_switch_loff_statn|int_sts_duration_loff_statn) |
									     (int_sts_switch_loff_statp|int_sts_duration_loff_statp) |
									     (int_sts_switch_acloff_statn|int_sts_duration_acloff_statn) |
									     (int_sts_switch_acloff_statp|int_sts_duration_acloff_statp) ) & leadoff_int_en);

//alarm int
//wire imeas_int_alarm_rstn = atpg_en ? preset_n : preset_n & (~int_alarm_clr);
wire imeas_int_alarm_rstn_bak = atpg_en ? preset_n : preset_n & (~int_alarm_clr);
wire imeas_int_alarm_rstn;
common_rst_sync u_imeas_int_alarm_rstn_sync(
.RSTINn    (imeas_int_alarm_rstn_bak),
.RSTREQ    (1'b0),
.CLK       (pclk),
.SE        (atpg_en),
.RSTBYPASS (atpg_en),
.RSTOUTn   (imeas_int_alarm_rstn)
);
always @(posedge pclk or negedge imeas_int_alarm_rstn) begin
    if (~imeas_int_alarm_rstn)
        int_alarm_sts <= 1'b0;
    else if (int_alarm_set)
        int_alarm_sts <= 1'b1;
    else
        int_alarm_sts <= int_alarm_sts;
end
 
assign imeas_int_alarm = int_alarm_sts & int_alarm_en;
  


endmodule
