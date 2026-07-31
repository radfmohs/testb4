/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/* File Name	: iq_reg.v                                                           */
/* Project	: Nanochap Glucose Chip                                                     */
/* Description	: IMEAS register                                                        */
/* Designer	: Daniel Wang                                                               */
/* Date		: 05/21/2019                                                                */
/* Revision	: R001 first draft                                                          */
/* Revision	: R002 changed altogether by Mohsen Radfar to conennect to SPI rahter than ahb   */
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/

module iq_reg(
input  wire        pclk,        // pclk 
input  wire        preset_n,    // Reset
input  wire	   atpg_en, //in scan mode

input  wire [15:0] reg_ctrl,

input  wire	   int_clr,
input  wire        int_set,     // interrupt 1T pulse
output reg         int_sts,

output wire [1:0]  iq_input_format,
output wire [3:0]  cic_rate,
output wire        chmod,
output wire        format_sel,
output wire        sd16rst,
output wire [5:0]  rst_val,

output wire        iq_int // interrupt
);

wire          int_en;


assign int_en       = reg_ctrl[0];
assign sd16rst 	    = reg_ctrl[1];
assign format_sel   = reg_ctrl[2];
assign chmod        = reg_ctrl[3];
assign cic_rate     = reg_ctrl[7:4];

assign iq_input_format = reg_ctrl[15:14];
assign rst_val 	    = reg_ctrl[13:8];

//interrupt generate
//wire iq_int_rstn = atpg_en ? preset_n: preset_n & (~int_clr);
wire iq_int_rstn_bak = atpg_en ? preset_n: preset_n & (~int_clr);
wire iq_int_rstn; 
common_rst_sync u_iq_int_rstn_sync(
.RSTINn    (iq_int_rstn_bak),
.RSTREQ    (1'b0),
.CLK       (pclk),
.SE        (atpg_en),
.RSTBYPASS (atpg_en),
.RSTOUTn   (iq_int_rstn)
);
//always @(posedge pclk or negedge preset_n) begin
always @(posedge pclk or negedge iq_int_rstn) begin
  //if (~preset_n)
  if (~iq_int_rstn)
    int_sts <= 1'b0;
  //else if (int_clr)
  //  int_sts <= 1'b0;
  else if (int_set)
    int_sts <= 1'b1;
  else
    int_sts <= int_sts;
end


wire int_sts_final;
assign int_sts_final =  int_sts;


assign iq_int = (int_sts_final & int_en); 


endmodule
