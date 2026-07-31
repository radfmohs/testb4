/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/* File Name	: iq_cdc.v                                                           */
/* Project	: Nanochap Glucose Chip                                                     */
/* Description	: IMEAS CDC                                                             */
/* Designer	: Daniel Wang                                                               */
/* Date		: 05/21/2019                                                                */
/* Revision	: R001 first draft                                                          */
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
module iq_cdc(
input  wire  pclk,
input  wire  adc_clk,
input  wire  preset_n,
input  wire  atpg_en,
input  wire  sd16eoc,
input  wire  cic_rst,

output wire  sd16eoc_sync,
output wire  cic_rst_n
);

wire cic_rst_atpg_n;

common_sync_bit u_sd16eoc_sync(
.async_in(sd16eoc),
.clk(pclk),
.rst_(preset_n),
.sync_out(sd16eoc_sync)
);


assign cic_rst_atpg_n = atpg_en ? preset_n : (preset_n & (~cic_rst));



common_rst_sync u_cic_rst_sync(
.RSTINn    (cic_rst_atpg_n),
.RSTREQ    (1'b0),
.CLK       (adc_clk),
.SE        (atpg_en),
.RSTBYPASS (atpg_en),
.RSTOUTn   (cic_rst_n)
);

//assign cic_rst_n = cic_rst_atpg_n;

endmodule
