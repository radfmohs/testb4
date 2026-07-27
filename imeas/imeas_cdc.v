/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/* File Name	: imeas_cdc.v                                                           */
/* Project	: Nanochap Glucose Chip                                                     */
/* Description	: IMEAS CDC                                                             */
/* Designer	: Daniel Wang                                                               */
/* Date		: 05/21/2019                                                                */
/* Revision	: R001 first draft                                                          */
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
module imeas_cdc(
input  wire  pclk,
input  wire  adc_clk,
input  wire  preset_n,
input  wire  atpg_en,
input  wire  sd16eoc,
input  wire  cic_rst,
//add option to restart when turn on the filter
input  wire  D2A_PPG_SH_CK,
input  wire  ppg_mode,
input  wire  restart,

input  wire  filter0_en,
input  wire  filter1_en,
output reg  filter0_en_sync_pclk,
output reg  filter1_en_sync_pclk,
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

wire  filter0_en_sync_pclk_bak;
wire  filter1_en_sync_pclk_bak;
reg  filter0_en_sync_pclk_bak_d1;
reg  filter1_en_sync_pclk_bak_d1;
common_sync_bit u_filter0_sync(
.async_in(filter0_en),
.clk(pclk),
.rst_(preset_n),
.sync_out(filter0_en_sync_pclk_bak)
);

common_sync_bit u_filter1_sync(
.async_in(filter1_en),
.clk(pclk),
.rst_(preset_n),
.sync_out(filter1_en_sync_pclk_bak)
);

always @ (posedge pclk or negedge preset_n) begin
	if (~preset_n) begin
		filter0_en_sync_pclk <= 1'b0;
		filter1_en_sync_pclk <= 1'b0;
		filter0_en_sync_pclk_bak_d1 <= 1'b0;		
		filter1_en_sync_pclk_bak_d1 <= 1'b0;		
	end else  begin
		filter0_en_sync_pclk_bak_d1 <= filter0_en_sync_pclk_bak;		
		filter1_en_sync_pclk_bak_d1 <= filter1_en_sync_pclk_bak;		
		filter0_en_sync_pclk <= filter0_en_sync_pclk_bak_d1;		
		filter1_en_sync_pclk <= filter1_en_sync_pclk_bak_d1;		
	end
end


wire  D2A_PPG_SH_CK_sync;
reg   D2A_PPG_SH_CK_sync_d1;
common_sync_bit u_ppg_sh_ck_sync(
.async_in(D2A_PPG_SH_CK),
.clk(pclk),
.rst_(preset_n),
.sync_out(D2A_PPG_SH_CK_sync)
);
always @ (posedge pclk or negedge preset_n) begin
	if (~preset_n) 
		D2A_PPG_SH_CK_sync_d1 <= 1'b0;
 	else	
		D2A_PPG_SH_CK_sync_d1 <= D2A_PPG_SH_CK_sync;
end

wire D2A_PPG_SH_CK_neg;
assign D2A_PPG_SH_CK_neg = D2A_PPG_SH_CK_sync_d1 & (~D2A_PPG_SH_CK_sync);


wire restart_pulse;
assign restart_pulse = (ppg_mode & restart) ? D2A_PPG_SH_CK_neg : 1'b0;
//assign restart_pulse = (ppg_mode & 1) ? D2A_PPG_SH_CK_neg : 1'b0; //for debug

//assign cic_rst_atpg_n = atpg_en ? preset_n : (preset_n & ~cic_rst);
assign cic_rst_atpg_n = atpg_en ? preset_n : (preset_n & (~cic_rst) & (~restart_pulse));



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
