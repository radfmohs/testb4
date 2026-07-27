//------------------------------------------------------------------------------
// Nanochap Pty Ltd (c) 2021
//
// Module Name : always_on_dig
// Description : This block is a separate digital block for PNR 
//------------------------------------------------------------------------------
// Revision History
//------------------------------------------------------------------------------
// Revision     Date        Author
//------------------------------------------------------------------------------
//	0.1     14/9/2022   Mohsen Radfar

//------------------------------------------------------------------------------

`timescale 1 ns /  1ps

module top_dig_always_on ( 
	
	//input wakeup, //from analog
	input A2D_Wake_UP_i, //from analog
	//input hfosc, //from analog 256 KHz OSC
	input A2D_OSC_OUT, //from analog 256 KHz OSC
	//input por_resetn_always_on, //from analog
	input A2D_VDDI_POR, //from analog
	input A2D_SW_POWER_POR, //from analog directly. must be always on
	//input ext_resetn, //from pin mux
	input A2D_external_RESET, //from pin mux

	input scan_clk,
	input atpg_en_sw,
	input atpg_en_in,
	output atpg_en_out,
	input scan_en_sw,   //Tri add
	input scan_en_in,   //Tri add
	output scan_en_out, //Tri add
	input scan_rst_n,

	input poresetn_hf_sw_power, //from switchable digital POR time out
	input spi_write, //from spi
	input flash_reset_done,
	//input ext_clk_sel, //from analog IO cells
	//input ext_hfclk, //external clock from analog IO cells
	input A2D_external_en_I, //from analog IO cells
	input A2D_external_clock_I, //external clock from analog IO cells

	//registers input
//	input [2:0] d2a_cpclk,

	input bg1p2_buf_en,
//	input dac_buf_en,

	input wire vcm1p5_buf_en,     
	input wire rld_amp_en,        
	//ecg
	input wire ecg_pga_en,        
	input wire ecg_lpf_en,         
	input wire [2:0] ecg_pga_gsel,      
	input wire [1:0] ecg_dda_clksel,    
	input wire ecg_dda_en,        
	input wire [2:0] ecg_dda_gsel,      
	input wire ecg_ddachop_en,     
	input wire [1:0] ecg_dda_isel,       

	//dc_lead_off
	input wire dc_lead_off_rmode_en,      
	input wire dc_lead_off_vin_flip,   
	input wire       dc_lead_off_en,    

  //ac_lead_off
  input wire       ac_lead_off_en,

	input bist_en,
	input [2:0]  bist_isel,
	//input dda_en,
	//input [2:0] dda_gsel,
	//input ele_buf_en,
	//input [2:0] ele_buf_sel,
	/*input r2r_dac1_en,
	input [11:0] r2r_dac1_din,
	input r2r_dac2_en,
	input [11:0] r2r_dac2_din,*/

	input [7:0] flash_trim1,
	input [7:0] flash_trim2,
	input [7:0] flash_trim3,
	input [7:0] flash_trim4,
	input [7:0] flash_trim5,
	input [7:0] flash_trim6,
	input [7:0] flash_trim7,
	input [7:0] flash_trim8,
	input [7:0] flash_trim9,
	input [7:0] flash_trim10,
	input [7:0] flash_trim11,
	input [7:0] flash_trim12,
	input [7:0] flash_trim13,
	input [7:0] flash_trim14,
	
	//registers output
	//output wire [2:0] D2A_CPCLK,

	output wire D2A_BG1P2_BUF_EN,
//	output wire D2A_DAC_BUF_EN,

	output wire d2a_vcm1p5_buf_en,     
	output wire d2a_rld_amp_en,        
	//ecg
	output wire d2a_ecg_pga_en,        
	output wire d2a_ecg_lpf_en,         
	output wire [2:0] d2a_ecg_pga_gsel,      
	output wire [1:0] d2a_ecg_dda_clksel,    
	output wire d2a_ecg_dda_en,        
	output wire [2:0] d2a_ecg_dda_gsel,      
	output wire d2a_ecg_ddachop_en,     
	output wire [1:0] d2a_ecg_dda_isel,       

	//dc_lead_off
	output wire d2a_dc_lead_off_rmode_en,      
	output wire d2a_dc_lead_off_vin_flip,   
	output wire       d2a_dc_lead_off_en,

  //ac_lead_off
  output wire       d2a_ac_lead_off_en,

	output wire       D2A_BIST_EN,
	output wire [2:0] D2A_BIST_ISEL,
	//output wire       D2A_DDA_EN,
	//output wire [2:0] D2A_DDA_GSEL,
	//output wire       D2A_ELE_BUF_EN,
	//output wire [2:0] D2A_ELE_BUF_SEL,
	/*output wire D2A_R2R_DAC1_EN,
	output wire [11:0] D2A_R2R_DAC1_DIN,
	output wire D2A_R2R_DAC2_EN,
	output wire [11:0] D2A_R2R_DAC2_DIN,*/

	output wire [7:0] trim1_always_on,
	output wire [7:0] trim2_always_on,
	output wire [7:0] trim3_always_on,
	output wire [7:0] trim4_always_on,
	output wire [7:0] trim5_always_on,
	output wire [7:0] trim6_always_on,
	output wire [7:0] trim7_always_on,
	output wire [7:0] trim8_always_on,
	output wire [7:0] trim9_always_on,
	output wire [7:0] trim10_always_on,
	output wire [7:0] trim11_always_on,
	output wire [7:0] trim12_always_on,
	output wire [7:0] trim13_always_on,
	output wire [7:0] trim14_always_on,

	//sw domain pinmux to always on connections
	input  wire [18:0]  i_IOBUF_IE,
	input  wire [18:0]  i_IOBUF_CS,
	input  wire [18:0]  i_IOBUF_PU,
	input  wire [18:0]  i_IOBUF_SR,
	input  wire [18:0]  i_IOBUF_DR,
	input  wire [18:0]  i_IOBUF_A,
	input  wire [18:0]  i_IOBUF_OE,
	input  wire [18:0]  i_IOBUF_OS,
	input  wire [18:0]  i_IOBUF_OD,
	input  wire [18:0]  i_IOBUF_PD,
	output wire [18:0]  o_IOBUF_Y,

	output wire 		    o_iopad_testmode0_en_y,
	output wire 		    o_iopad_testmode1_en_y,
	output wire		      o_iopad_resetn_y,

  //SDM
  input  wire         i_D2A_SDM_EN,
  input  wire         i_D2A_SDM_CLK,
  input  wire  [2:0]  i_D2A_SDM_VIN_SEL,
  input  wire  [1:0]  i_D2A_SDM_BIAS,
  output wire         o_D2A_SDM_EN_AO,
  output wire         o_D2A_SDM_CLK_AO,
  output wire  [2:0]  o_D2A_SDM_VIN_SEL_AO,
  output wire  [1:0]  o_D2A_SDM_BIAS_AO,

  //TSC
  input  wire  [2:0]  i_D2A_TSC_INA_GSEL,
  input  wire         i_D2A_TSC_EN,
  input  wire  [2:0]  i_D2A_TSC_BJT_SEL,
  input  wire         i_D2A_TSC_OUT_SEL,
  input  wire         i_D2A_TSC_INA_EN,
  output wire  [2:0]  o_D2A_TSC_INA_GSEL_AO,
  output wire         o_D2A_TSC_EN_AO,
  output wire  [2:0]  o_D2A_TSC_BJT_SEL_AO,
  output wire         o_D2A_TSC_OUT_SEL_AO,
  output wire         o_D2A_TSC_INA_EN_AO,

  //PPG
  input  wire         i_D2A_EN_PPG_AF,
  input  wire         i_D2A_EN_PPG_BUFFER,
  input  wire         i_D2A_EN_PPG_SH,
  input  wire         i_D2A_EN_TIA,
  input  wire         i_D2A_EN_TIA_VREFBUFFER,
  input  wire         i_D2A_LEDDAC_SEL,
  input  wire  [1:0]  i_D2A_LEDSEL,
  input  wire         i_D2A_LED_EN,
  input  wire         i_D2A_LED_STANDBYEN,
  input  wire  [1:0]  i_D2A_PDVREF_SEL,
  input  wire         i_D2A_PPG_SH_CK,
  input  wire  [1:0]  i_D2A_PPG_TEST_IN,
  input  wire  [1:0]  i_D2A_PPG_TEST_OUT,
  input  wire  [3:0]  i_D2A_TIA_GAIN,
  input  wire  [7:0]  i_D2A_TIA_IDAC,
  input  wire         i_D2A_PPGDAC0_EN,
  input  wire [11:0]  i_D2A_PPGDAC0_VSEL,
  input  wire         i_D2A_PPGDAC1_EN,
  input  wire [11:0]  i_D2A_PPGDAC1_VSEL,
  input  wire         i_D2A_EN_PPGDAC_BUFFER,
  output wire         o_D2A_EN_PPG_AF_AO,
  output wire         o_D2A_EN_PPG_BUFFER_AO,
  output wire         o_D2A_EN_PPG_SH_AO,
  output wire         o_D2A_EN_TIA_AO,
  output wire         o_D2A_EN_TIA_VREFBUFFER_AO,
  output wire         o_D2A_LEDDAC_SEL_AO,
  output wire  [1:0]  o_D2A_LEDSEL_AO,
  output wire         o_D2A_LED_EN_AO,
  output wire         o_D2A_LED_STANDBYEN_AO,
  output wire  [1:0]  o_D2A_PDVREF_SEL_AO,
  output wire         o_D2A_PPG_SH_CK_AO,
  output wire  [1:0]  o_D2A_PPG_TEST_IN_AO,
  output wire  [1:0]  o_D2A_PPG_TEST_OUT_AO,
  output wire  [3:0]  o_D2A_TIA_GAIN_AO,
  output wire  [7:0]  o_D2A_TIA_IDAC_AO,
  output wire         o_D2A_PPGDAC0_EN_AO,
  output wire [11:0]  o_D2A_PPGDAC0_VSEL_AO,
  output wire         o_D2A_PPGDAC1_EN_AO,
  output wire [11:0]  o_D2A_PPGDAC1_VSEL_AO,
  output wire         o_D2A_EN_PPGDAC_BUFFER_AO,

  //ECG
  input  wire         ECG_ELECTRODE_EN,
  input  wire         ECGCAL_EN,
  input  wire         RLD_CHOP_EN,
  input  wire         RLD_CLK64K,
  input wire          ACLEADOFF_CLK,
  input wire          Z_EN,
  input  wire  [9:0]  ECGCAL_VSEL_TRIM,
  output wire         D2A_2ELECTRODE_EN,
  output wire         D2A_ECGCAL_EN,
  output wire         D2A_RLD_CHOP_EN,
  output wire         D2A_RLD_CLK64K,
  output wire         D2A_ACLEADOFF_CLK,
  output wire         D2A_Z_EN,
  output wire  [9:0]  D2A_ECGCAL_VSEL_TRIM,

  //ATM
  input  wire         i_D2A_ATM0,
  input  wire         i_D2A_ATM1,
  input  wire         i_D2A_ATM2,
  input  wire         i_D2A_ATM3,
  input  wire         i_D2A_ATM4,
  input  wire         i_D2A_ATM5,
  input  wire         i_D2A_ATM6,
  input  wire         i_D2A_ATM7,
  input  wire         i_D2A_ATM8,
  input  wire         i_D2A_ATM9,
  input  wire         i_D2A_ATM10,
  input  wire         i_D2A_ATM11,
  input  wire         i_D2A_ATM12,
  
  output wire         o_D2A_ATM0_AO,
  output wire         o_D2A_ATM1_AO,
  output wire         o_D2A_ATM2_AO,
  output wire         o_D2A_ATM3_AO,
  output wire         o_D2A_ATM4_AO,
  output wire         o_D2A_ATM5_AO,
  output wire         o_D2A_ATM6_AO,
  output wire         o_D2A_ATM7_AO,
  output wire         o_D2A_ATM8_AO,
  output wire         o_D2A_ATM9_AO,
  output wire         o_D2A_ATM10_AO, 
  output wire         o_D2A_ATM11_AO, 
  output wire         o_D2A_ATM12_AO, 

	//always on to io cells connections
	output wire [18:0]  o_IOBUF_IE,
	output wire [18:0]  o_IOBUF_CS,
	output wire [18:0]  o_IOBUF_PU,
	output wire [18:0]  o_IOBUF_SR,
	output wire [18:0]  o_IOBUF_DR,
	output wire [18:0]  o_IOBUF_A,
	output wire [18:0]  o_IOBUF_OE,
	output wire [18:0]  o_IOBUF_OS,
	output wire [18:0]  o_IOBUF_OD,
	output wire [18:0]  o_IOBUF_PD,
	input  wire [18:0]  i_IOBUF_Y,
	input  wire         i_IO_testmode0_PD,
	input  wire         i_IO_testmode1_PD,
	input  wire         i_IO_exresetn_PU,

	output wire 			  o_IOBUF_IE_testmode0,
	output wire 			  o_IOBUF_PU_testmode0,
	output wire 			  o_IOBUF_PD_testmode0,
	input  wire 			  i_iopad_testmode0_en_y,

	output wire 			  o_IOBUF_IE_testmode1,
	output wire 			  o_IOBUF_PU_testmode1,
	output wire 			  o_IOBUF_PD_testmode1,
	input  wire 			  i_iopad_testmode1_en_y,

	output wire 			  o_IOBUF_IE_resetn,
	output wire 			  o_IOBUF_PU_resetn,
	output wire 			  o_IOBUF_PD_resetn,
	input  wire 			  i_iopad_resetn_y

	//inout 	vddi, //always on digital power
	//input	vssi 

);
wire ext_clk_sel; //from analog IO cells
wire ext_hfclk; //external clock from analog IO cells
assign ext_clk_sel = A2D_external_en_I; //from analog IO cells
assign ext_hfclk = A2D_external_clock_I; //external clock from analog IO cells

wire ext_resetn; //from pin mux
assign ext_resetn =  A2D_external_RESET; //from pin mux

wire hfosc; //from analog 256 KHz OSC
assign hfosc =  A2D_OSC_OUT; //from analog 256 KHz OSC

wire por_resetn_always_on; //from analog
assign por_resetn_always_on= A2D_VDDI_POR; //from analog
wire sw_por;
assign sw_por = A2D_SW_POWER_POR;
wire wakeup_tmp, wakeup; //from analog
//assign wakeup = A2D_Wake_UP_i;	
//wire [2:0] d2a_cpclk_always_on;
wire wakeup_done;//generated after analog wakeup and counting

wire bg1p2_buf_en_always_on;
//wire dac_buf_en_always_on;

wire bist_en_always_on;
wire [2:0]  bist_isel_always_on;
//wire dda_en_always_on;
//wire [2:0] dda_gsel_always_on;
//wire ele_buf_en_always_on;
//wire [2:0] ele_buf_sel_always_on;
/* wire r2r_dac1_en_always_on;
wire [11:0] r2r_dac1_din_always_on;
wire r2r_dac2_en_always_on;
wire [11:0] r2r_dac2_din_always_on;*/

//assign D2A_CPCLK	=	d2a_cpclk_always_on;

assign D2A_BG1P2_BUF_EN	=	bg1p2_buf_en_always_on;
//assign D2A_DAC_BUF_EN	=	dac_buf_en_always_on;

assign D2A_BIST_EN		=	bist_en_always_on;
assign D2A_BIST_ISEL	=	bist_isel_always_on;
//assign D2A_DDA_EN		=	dda_en_always_on;
//assign D2A_DDA_GSEL	=	dda_gsel_always_on;
//assign D2A_ELE_BUF_EN		=	ele_buf_en_always_on;
//assign D2A_ELE_BUF_SEL	=	ele_buf_sel_always_on;

wire		hfosc_atpg;
wire		poresetn;
wire    poresetn_hf_sw_power_buf;
wire    atpg_en_sw_tmp, scan_en_sw_tmp;

AND2X4M DNT_ATPG_AL_ON_TMP (.Y(atpg_en_sw_tmp), .A(atpg_en_sw), .B(wakeup_done)); 
AND2X4M DNT_ATPG_AL_ON (.Y(atpg_en_out), .A(atpg_en_sw_tmp), .B(A2D_Wake_UP_i)); 
AND2X4M DNT_SCAN_EN_AL_ON_TMP (.Y(scan_en_sw_tmp), .A(scan_en_sw), .B(wakeup_done)); 
AND2X4M DNT_SCAN_EN_AL_ON (.Y(scan_en_out), .A(scan_en_sw_tmp), .B(A2D_Wake_UP_i)); 
INVXLM DNT_WAKEUP_INV0 (.Y(wakeup_tmp), .A(A2D_Wake_UP_i));
INVXLM DNT_WAKEUP_INV1 (.Y(wakeup), .A(wakeup_tmp));
AND2X4M DNT_SW_POR (.Y(poresetn_hf_sw_power_buf), .A(poresetn_hf_sw_power), .B(A2D_Wake_UP_i));

shadow_regs_always_on shadow_regs_always_on_inst
(
  .poresetn(poresetn), //POR reset of always on domain
  .atpg_en(atpg_en_in),
  .scan_en(scan_en_in),  //Tri add
  .iopad_testmode0_en_y(i_iopad_testmode0_en_y),
  .iopad_testmode1_en_y(i_iopad_testmode1_en_y),
  .hfosc_atpg(hfosc_atpg), //clock of always on domain
  .wakeup_done(wakeup_done), //disabled (active high) when in low power mode (connects to the wake up pin)
  .poresetn_hf_sw_power(poresetn_hf_sw_power_buf), //por signal (after por timer) from switchable domain
  .spi_write(spi_write), //load registers from spi
  .flash_reset_done(flash_reset_done),

  //input from spi registers
  //	.d2a_cpclk_spi(d2a_cpclk),

  .bg1p2_buf_en_spi(bg1p2_buf_en),
  //  .dac_buf_en_spi(dac_buf_en),

  .vcm1p5_buf_en_spi(vcm1p5_buf_en),     
  .rld_amp_en_spi(rld_amp_en),        
  //ecg
  .ecg_pga_en_spi(ecg_pga_en),        
  .ecg_lpf_en_spi(ecg_lpf_en),         
  .ecg_pga_gsel_spi(ecg_pga_gsel),      
  .ecg_dda_clksel_spi(ecg_dda_clksel),    
  .ecg_dda_en_spi(ecg_dda_en),        
  .ecg_dda_gsel_spi(ecg_dda_gsel),      
  .ecg_ddachop_en_spi(ecg_ddachop_en),     
  .ecg_dda_isel_spi(ecg_dda_isel),     
  .ecg_2electrode_en_spi (ECG_ELECTRODE_EN),
  .ecg_cal_en_spi        (ECGCAL_EN),
  .ecg_rld_chop_en_spi   (RLD_CHOP_EN),

  //dc_lead_off
  .dc_lead_off_rmode_en_spi(dc_lead_off_rmode_en),      
  .dc_lead_off_vin_flip_spi(dc_lead_off_vin_flip),   
  .dc_lead_off_en_spi(dc_lead_off_en), 
  
  .ac_lead_off_en_spi(ac_lead_off_en), 

  .bist_en_spi(bist_en),
  .bist_isel_spi(bist_isel),
  //.dda_en_spi(dda_en),
  //.dda_gsel_spi(dda_gsel),
  //.ele_buf_en_spi(ele_buf_en),
  //.ele_buf_sel_spi(ele_buf_sel),
  /*.r2r_dac1_en_spi(r2r_dac1_en),
  .r2r_dac1_din_spi(r2r_dac1_din),
  .r2r_dac2_en_spi(r2r_dac2_en),
  .r2r_dac2_din_spi(r2r_dac2_din),*/

  .flash_trim1_spi(flash_trim1),
  .flash_trim2_spi(flash_trim2),
  .flash_trim3_spi(flash_trim3),
  .flash_trim4_spi(flash_trim4),
  .flash_trim5_spi(flash_trim5),
  .flash_trim6_spi(flash_trim6),
  .flash_trim7_spi(flash_trim7),
  .flash_trim8_spi(flash_trim8),
  .flash_trim9_spi(flash_trim9),
  .flash_trim10_spi(flash_trim10),
  .flash_trim11_spi(flash_trim11),
  .flash_trim12_spi(flash_trim12),
  .flash_trim13_spi(flash_trim13),
  .flash_trim14_spi(flash_trim14),

  //output to always on 
  //.dc_clk_div(dc_clk_div_always_on), //from SPI reg//input  wire  [1:0]  dc_clk_div
  //	.d2a_cpclk(d2a_cpclk_always_on),

  .bg1p2_buf_en(bg1p2_buf_en_always_on),
  //      .dac_buf_en(dac_buf_en_always_on),

  .vcm1p5_buf_en(d2a_vcm1p5_buf_en),     
  .rld_amp_en(d2a_rld_amp_en),        
  //ecg
  .ecg_pga_en(d2a_ecg_pga_en),        
  .ecg_lpf_en(d2a_ecg_lpf_en),         
  .ecg_pga_gsel(d2a_ecg_pga_gsel),      
  .ecg_dda_clksel(d2a_ecg_dda_clksel),    
  .ecg_dda_en(d2a_ecg_dda_en),        
  .ecg_dda_gsel(d2a_ecg_dda_gsel),      
  .ecg_ddachop_en(d2a_ecg_ddachop_en),     
  .ecg_dda_isel(d2a_ecg_dda_isel),      
  .ecg_2electrode_en  (D2A_2ELECTRODE_EN),
  .ecg_cal_en         (D2A_ECGCAL_EN),
  .ecg_rld_chop_en    (D2A_RLD_CHOP_EN) ,

  //dc_lead_off
  .dc_lead_off_rmode_en(d2a_dc_lead_off_rmode_en),      
  .dc_lead_off_vin_flip(d2a_dc_lead_off_vin_flip),   
  .dc_lead_off_en(d2a_dc_lead_off_en),


  //ac_lead_off
  .ac_lead_off_en(d2a_ac_lead_off_en),

  .bist_en(bist_en_always_on),
  .bist_isel(bist_isel_always_on),
  //.dda_en(dda_en_always_on),
  //.dda_gsel(dda_gsel_always_on),
  //.ele_buf_en(ele_buf_en_always_on),
  //.ele_buf_sel(ele_buf_sel_always_on),
  /*.r2r_dac1_en(r2r_dac1_en_always_on),
  .r2r_dac1_din(r2r_dac1_din_always_on),
  .r2r_dac2_en(r2r_dac2_en_always_on),
  .r2r_dac2_din(r2r_dac2_din_always_on),*/

  .trim1_always_on(trim1_always_on),
  .trim2_always_on(trim2_always_on),
  .trim3_always_on(trim3_always_on),
  .trim4_always_on(trim4_always_on),
  .trim5_always_on(trim5_always_on),
  .trim6_always_on(trim6_always_on),
  .trim7_always_on(trim7_always_on),
  .trim8_always_on(trim8_always_on),
  .trim9_always_on(trim9_always_on),
  .trim10_always_on(trim10_always_on),
  .trim11_always_on(trim11_always_on),
  .trim12_always_on(trim12_always_on),
  .trim13_always_on(trim13_always_on),
  .trim14_always_on(trim14_always_on)
);

pinmux_always_on pinmux_always_on_inst
(
	.wakeup(wakeup),
	//bypassing pinmux io config during low power mode
	//pinmux to always on connections
	.i_IOBUF_IE         (i_IOBUF_IE),
	.i_IOBUF_CS         (i_IOBUF_CS),
	.i_IOBUF_PU         (i_IOBUF_PU),
	.i_IOBUF_SR         (i_IOBUF_SR),
	.i_IOBUF_DR         (i_IOBUF_DR),
	.i_IOBUF_A          (i_IOBUF_A),
	.i_IOBUF_OE         (i_IOBUF_OE),
	.i_IOBUF_OS         (i_IOBUF_OS),
	.i_IOBUF_OD         (i_IOBUF_OD),
	.i_IOBUF_PD         (i_IOBUF_PD),
	.o_IOBUF_Y          (o_IOBUF_Y),
	.i_IO_testmode0_PD  (i_IO_testmode0_PD),
	.i_IO_testmode1_PD  (i_IO_testmode1_PD),
	.i_IO_exresetn_PU   (i_IO_exresetn_PU),

	.o_iopad_testmode0_en_y (o_iopad_testmode0_en_y),
	.o_iopad_testmode1_en_y (o_iopad_testmode1_en_y),
	.o_iopad_resetn_y       (o_iopad_resetn_y),

	//always on to io cell connections
	.o_IOBUF_IE(o_IOBUF_IE),
	.o_IOBUF_CS(o_IOBUF_CS),
	.o_IOBUF_PU(o_IOBUF_PU),
	.o_IOBUF_SR(o_IOBUF_SR),
	.o_IOBUF_DR(o_IOBUF_DR),
	.o_IOBUF_A(o_IOBUF_A),
	.o_IOBUF_OE(o_IOBUF_OE),
	.o_IOBUF_OS(o_IOBUF_OS),
	.o_IOBUF_OD(o_IOBUF_OD),
	.o_IOBUF_PD(o_IOBUF_PD),	
	.i_IOBUF_Y(i_IOBUF_Y),

	.o_IOBUF_IE_testmode0(o_IOBUF_IE_testmode0),
	.o_IOBUF_PU_testmode0(o_IOBUF_PU_testmode0),
	.o_IOBUF_PD_testmode0(o_IOBUF_PD_testmode0),
	.i_iopad_testmode0_en_y(i_iopad_testmode0_en_y),

	.o_IOBUF_IE_testmode1(o_IOBUF_IE_testmode1),
	.o_IOBUF_PU_testmode1(o_IOBUF_PU_testmode1),
	.o_IOBUF_PD_testmode1(o_IOBUF_PD_testmode1),
	.i_iopad_testmode1_en_y(i_iopad_testmode1_en_y),

	.o_IOBUF_IE_resetn(o_IOBUF_IE_resetn),
	.o_IOBUF_PU_resetn(o_IOBUF_PU_resetn),
	.o_IOBUF_PD_resetn(o_IOBUF_PD_resetn),
	.i_iopad_resetn_y(i_iopad_resetn_y),

  //SDM
  .i_D2A_SDM_EN           (i_D2A_SDM_EN),
  .i_D2A_SDM_CLK          (i_D2A_SDM_CLK),
  .i_D2A_SDM_VIN_SEL      (i_D2A_SDM_VIN_SEL),
  .i_D2A_SDM_BIAS         (i_D2A_SDM_BIAS),
  .o_D2A_SDM_EN_AO        (o_D2A_SDM_EN_AO),
  .o_D2A_SDM_CLK_AO       (o_D2A_SDM_CLK_AO),
  .o_D2A_SDM_VIN_SEL_AO   (o_D2A_SDM_VIN_SEL_AO),
  .o_D2A_SDM_BIAS_AO      (o_D2A_SDM_BIAS_AO),

  //TSC
  .i_D2A_TSC_INA_GSEL     (i_D2A_TSC_INA_GSEL),
  .i_D2A_TSC_EN           (i_D2A_TSC_EN),
  .i_D2A_TSC_BJT_SEL      (i_D2A_TSC_BJT_SEL),
  .i_D2A_TSC_OUT_SEL      (i_D2A_TSC_OUT_SEL),
  .i_D2A_TSC_INA_EN       (i_D2A_TSC_INA_EN),
  .o_D2A_TSC_INA_GSEL_AO  (o_D2A_TSC_INA_GSEL_AO),
  .o_D2A_TSC_EN_AO        (o_D2A_TSC_EN_AO),
  .o_D2A_TSC_BJT_SEL_AO   (o_D2A_TSC_BJT_SEL_AO),
  .o_D2A_TSC_OUT_SEL_AO   (o_D2A_TSC_OUT_SEL_AO),
  .o_D2A_TSC_INA_EN_AO    (o_D2A_TSC_INA_EN_AO),

  //PPG
  .i_D2A_EN_PPG_AF            (i_D2A_EN_PPG_AF),
  .i_D2A_EN_PPG_BUFFER        (i_D2A_EN_PPG_BUFFER),
  .i_D2A_EN_PPG_SH            (i_D2A_EN_PPG_SH),
  .i_D2A_EN_TIA               (i_D2A_EN_TIA),
  .i_D2A_EN_TIA_VREFBUFFER    (i_D2A_EN_TIA_VREFBUFFER),
  .i_D2A_LEDDAC_SEL           (i_D2A_LEDDAC_SEL),
  .i_D2A_LEDSEL               (i_D2A_LEDSEL),
  .i_D2A_LED_EN               (i_D2A_LED_EN),
  .i_D2A_LED_STANDBYEN        (i_D2A_LED_STANDBYEN),
  .i_D2A_PDVREF_SEL           (i_D2A_PDVREF_SEL),
  .i_D2A_PPG_SH_CK            (i_D2A_PPG_SH_CK),
  .i_D2A_PPG_TEST_IN          (i_D2A_PPG_TEST_IN),
  .i_D2A_PPG_TEST_OUT         (i_D2A_PPG_TEST_OUT),
  .i_D2A_TIA_GAIN             (i_D2A_TIA_GAIN),
  .i_D2A_TIA_IDAC             (i_D2A_TIA_IDAC),
  .i_D2A_PPGDAC0_EN           (i_D2A_PPGDAC0_EN),
  .i_D2A_PPGDAC0_VSEL         (i_D2A_PPGDAC0_VSEL),
  .i_D2A_PPGDAC1_EN           (i_D2A_PPGDAC1_EN),
  .i_D2A_PPGDAC1_VSEL         (i_D2A_PPGDAC1_VSEL),
  .i_D2A_EN_PPGDAC_BUFFER     (i_D2A_EN_PPGDAC_BUFFER),
  .o_D2A_EN_PPG_AF_AO         (o_D2A_EN_PPG_AF_AO),
  .o_D2A_EN_PPG_BUFFER_AO     (o_D2A_EN_PPG_BUFFER_AO),
  .o_D2A_EN_PPG_SH_AO         (o_D2A_EN_PPG_SH_AO),
  .o_D2A_EN_TIA_AO            (o_D2A_EN_TIA_AO),
  .o_D2A_EN_TIA_VREFBUFFER_AO (o_D2A_EN_TIA_VREFBUFFER_AO),
  .o_D2A_LEDDAC_SEL_AO        (o_D2A_LEDDAC_SEL_AO),
  .o_D2A_LEDSEL_AO            (o_D2A_LEDSEL_AO),
  .o_D2A_LED_EN_AO            (o_D2A_LED_EN_AO),
  .o_D2A_LED_STANDBYEN_AO     (o_D2A_LED_STANDBYEN_AO),
  .o_D2A_PDVREF_SEL_AO        (o_D2A_PDVREF_SEL_AO),
  .o_D2A_PPG_SH_CK_AO         (o_D2A_PPG_SH_CK_AO),
  .o_D2A_PPG_TEST_IN_AO       (o_D2A_PPG_TEST_IN_AO),
  .o_D2A_PPG_TEST_OUT_AO      (o_D2A_PPG_TEST_OUT_AO),
  .o_D2A_TIA_GAIN_AO          (o_D2A_TIA_GAIN_AO),
  .o_D2A_TIA_IDAC_AO          (o_D2A_TIA_IDAC_AO),
  .o_D2A_PPGDAC0_EN_AO        (o_D2A_PPGDAC0_EN_AO),
  .o_D2A_PPGDAC0_VSEL_AO      (o_D2A_PPGDAC0_VSEL_AO),
  .o_D2A_PPGDAC1_EN_AO        (o_D2A_PPGDAC1_EN_AO),
  .o_D2A_PPGDAC1_VSEL_AO      (o_D2A_PPGDAC1_VSEL_AO),
  .o_D2A_EN_PPGDAC_BUFFER_AO  (o_D2A_EN_PPGDAC_BUFFER_AO),

  //ECG
  .i_D2A_RLD_CLK64K           (RLD_CLK64K),
  .i_D2A_ACLEADOFF_CLK        (ACLEADOFF_CLK),
  .i_D2A_Z_EN                 (Z_EN),
  .i_D2A_ECGCAL_VSEL_TRIM     (ECGCAL_VSEL_TRIM),
  .o_D2A_RLD_CLK64K           (D2A_RLD_CLK64K),
  .o_D2A_ACLEADOFF_CLK        (D2A_ACLEADOFF_CLK),
  .o_D2A_Z_EN	              (D2A_Z_EN),
  .o_D2A_ECGCAL_VSEL_TRIM     (D2A_ECGCAL_VSEL_TRIM),

  //ATM
  .i_D2A_ATM0     (i_D2A_ATM0),
  .i_D2A_ATM1     (i_D2A_ATM1),
  .i_D2A_ATM2     (i_D2A_ATM2),
  .i_D2A_ATM3     (i_D2A_ATM3),
  .i_D2A_ATM4     (i_D2A_ATM4),
  .i_D2A_ATM5     (i_D2A_ATM5),
  .i_D2A_ATM6     (i_D2A_ATM6),
  .i_D2A_ATM7     (i_D2A_ATM7),
  .i_D2A_ATM8     (i_D2A_ATM8),
  .i_D2A_ATM9     (i_D2A_ATM9),
  .i_D2A_ATM10    (i_D2A_ATM10),
  .i_D2A_ATM11    (i_D2A_ATM11),
  .i_D2A_ATM12    (i_D2A_ATM12),
  .o_D2A_ATM0_AO  (o_D2A_ATM0_AO),
  .o_D2A_ATM1_AO  (o_D2A_ATM1_AO),
  .o_D2A_ATM2_AO  (o_D2A_ATM2_AO),
  .o_D2A_ATM3_AO  (o_D2A_ATM3_AO),
  .o_D2A_ATM4_AO  (o_D2A_ATM4_AO),
  .o_D2A_ATM5_AO  (o_D2A_ATM5_AO),
  .o_D2A_ATM6_AO  (o_D2A_ATM6_AO),
  .o_D2A_ATM7_AO  (o_D2A_ATM7_AO),
  .o_D2A_ATM8_AO  (o_D2A_ATM8_AO),
  .o_D2A_ATM9_AO  (o_D2A_ATM9_AO),
  .o_D2A_ATM10_AO (o_D2A_ATM10_AO),
  .o_D2A_ATM11_AO (o_D2A_ATM11_AO),
  .o_D2A_ATM12_AO (o_D2A_ATM12_AO)

);

clk_ctrl_always_on clk_ctrl_always_on_inst
(
	.wakeup_i(wakeup),
	.ext_clk_sel(ext_clk_sel),
	.ext_hfclk(ext_hfclk),
	.hfosc(hfosc),
	.scan_clk(scan_clk),
	.atpg_en(atpg_en_in),
	.hfosc_atpg(hfosc_atpg)
);

reset_ctrl_always_on reset_ctrl_always_on_inst
(
	.iopad_testmode0_en_y(i_iopad_testmode0_en_y),
	.iopad_testmode1_en_y(i_iopad_testmode1_en_y),
	.por_resetn(por_resetn_always_on),
	.sw_por(sw_por), //sw por coming from analog
	.wakeup_i(wakeup),
	.ext_resetn(ext_resetn),
	.scan_rst_n(scan_rst_n),
	.atpg_en(atpg_en_in),
	.hfosc_atpg(hfosc_atpg),
	.poresetn(poresetn),
	.wakeup_done(wakeup_done)
);

endmodule
