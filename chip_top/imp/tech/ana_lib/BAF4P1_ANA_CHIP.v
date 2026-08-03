
// Library - IS_BAF4P1, Cell - BAF4P1_ANA_CHIP, View - schematic
// LAST TIME SAVED: Jul  4 18:13:12 2024
// NETLIST TIME: Jul  4 18:13:38 2024
`timescale 1ns / 1ns 

module BAF4P1_ANA_CHIP ( 
`ifdef FPGA
	clk_in1,
`endif
     A2D_ACLEADOFF_STATN, A2D_ACLEADOFF_STATP,
     A2D_LOFF_STATN, A2D_LOFF_STATP, A2D_OSC_OUT, A2D_SDM_OUT,
     A2D_SPARE_TRIM_SW0, A2D_SW_POWER_POR, A2D_VDDI_POR,
     A2D_Wake_UP_i, A2D_external_RESET, A2D_external_clock_I,
     A2D_external_en_I, POC, DVDD1P5_ANA, VDDIO, VDD_DIG_AFSW,
     VDD_DIG_AO, VDD_DIG_SW, VDD_DIG_ZMEASURE, VREF0P8, VSS1, VSS2,
     VSSIO1, VSSIO2, VSS_DIG_AO, D2A_2ELECTRODE_EN, D2A_ACLEADOFF_CLK,
     D2A_ACLEADOFF_EN, 
     D2A_ACLEADOFF_ISEL_TRIM, 
     D2A_ACLEADOFF_VTHNSEL_TRIM, 
     D2A_ACLEADOFF_VTHPSEL_TRIM, D2A_ATM0, D2A_ATM1, D2A_ATM2,
     D2A_ATM3, D2A_ATM4, D2A_ATM5, D2A_ATM6, D2A_ATM7, D2A_ATM8,
     D2A_ATM9, D2A_ATM10, D2A_ATM11, D2A_ATM12, D2A_BG1P2_BUF_EN,
     D2A_BGH_CTRIM, 
     D2A_BGH_VTRIM, D2A_BIST_EN, D2A_BIST_ISEL,
     D2A_DCLEADOFF_COMP_TH_TRIM, 
     D2A_DCLEADOFF_EN, 
     D2A_DCLEADOFF_ISEL_TRIM, D2A_DCLEADOFF_RMODE_EN,
     D2A_DCLEADOFF_VINFLIP, D2A_ECGCAL_EN, D2A_ECGCAL_VSEL_TRIM,
     D2A_ECG_DDACHOP_EN, D2A_ECG_DDA_CLKSEL, D2A_ECG_DDA_EN,
     D2A_ECG_DDA_GSEL, D2A_ECG_DDA_ISEL, D2A_ECG_LPF_EN,
     D2A_ECG_PGA_EN, D2A_ECG_PGA_GSEL, D2A_EN_PPGDAC_BUFFER,
     D2A_EN_PPG_AF, D2A_EN_PPG_BUFFER, D2A_EN_PPG_SH, D2A_EN_TIA,
     D2A_EN_TIA_VREFBUFFER,
     D2A_LDO1V5_VTRIM, D2A_LEDDAC_SEL, D2A_LEDSEL,
     D2A_LED_EN, D2A_LED_STANDBYEN, 
     D2A_OSC_ISEL_TRIM, D2A_OSC_TRIM,
     D2A_PDVREF_SEL, D2A_PPGDAC0_EN, D2A_PPGDAC0_VSEL,
     D2A_PPGDAC1_EN, D2A_PPGDAC1_VSEL, D2A_PPG_SH_CK,
     D2A_PPG_TEST_IN, D2A_PPG_TEST_OUT, D2A_RLD_CHOP_EN,
     D2A_RLD_CLK64K, D2A_RLD_EN, D2A_SDM_BIAS, D2A_SDM_CLK,
     D2A_SDM_EN, D2A_SDM_VIN_SEL, D2A_SPARE_TRIM0,
     D2A_SPARE_TRIM1, D2A_SPARE_TRIM2, D2A_SPARE_TRIM3,
     D2A_SPARE_TRIM_SW0, D2A_SPARE_TRIM_SW1, D2A_SW_Z_CALMD,
     D2A_SW_Z_CLK256K, D2A_SW_Z_DDS, D2A_SW_Z_RXGAIN,
     D2A_SW_Z_TX_GSEL, D2A_TIA_GAIN, D2A_TIA_IDAC,
     D2A_TSC_BJT_SEL, D2A_TSC_EN, 

     D2A_TSC_INA_EN,
D2A_TSC_INA_GSEL,
     D2A_TSC_OUT_SEL, D2A_VCM1P5_BUF_EN, D2A_Z_EN );

`ifdef FPGA
        input clk_in1;
`endif
input  	D2A_2ELECTRODE_EN;
input   D2A_ECGCAL_EN;
input   D2A_ACLEADOFF_CLK;
//input D2A_OSC_ISEL_TRIM;
input [7:0]	D2A_OSC_ISEL_TRIM;

output  A2D_LOFF_STATN;
output  A2D_LOFF_STATP;
output  A2D_ACLEADOFF_STATN;
output  A2D_ACLEADOFF_STATP;
output  A2D_OSC_OUT;
output  A2D_SDM_OUT;
output  A2D_SW_POWER_POR;
output  A2D_VDDI_POR;
output  A2D_Wake_UP_i;
//output  A2D_SW_Z_ADC_EOC;
output  A2D_external_RESET;
output  A2D_external_clock_I;
output  A2D_external_en_I; 

/*
inout  ATEST_PAD, AVDD3P_AFSW, AVDD3P_ANA, AVDD3P_PMU, AVDD3P_SDM,
     AVSS3P_ANA, AVSS3P_PMU, AVSS3P_SDM, AVSS_LED, BUFFER_OUT, CHIP_EN,
     DVDD1P5_AFSW, DVDD1P5_ANA, DVDD1P5_AO, DVDD1P5_SW,
     DVDD1P5_ZMEASURE, DVSS, DVSS1P5_AO, GREEN0, GREEN1, INFRED,
     LDO1P5_OUT, LED_STATUS, PDN, PDP, RED, RESET, RLDINV, RLDOUT,
     VBAT3P, VBG1P2_OUT, 5, VDDIO, VINM_LPF, VINM_PGA, VINP_LPF,
     VINP_PGA, VINSDM, VIN_DDA, VIPSDM, VIP_DDA, VOUTN_LPF, VOUTN_PGA,
     VOUTP_LPF, VOUTP_PGA, VREF0P8, VREF1P2_SDM, VSS_IO, WAKE_UP,
     Z_RFB_NOM, Z_RFB_TEST, Z_VIN_CAL_NOM, Z_VIN_CAL_TEST,
     Z_VIN_MEAS_NOM, Z_VIN_MEAS_TEST, Z_VIN_NOM, Z_VIN_TEST,
     Z_VOUT_NOM, Z_VOUT_TEST, external_EN, external_clock;
*/

inout  POC;

inout  DVDD1P5_ANA;
//output wire   VDD_DIG_AO;
//output wire   VDD_DIG_AFSW;
//input  VDD_DIG_SW;
//input  VDD_DIG_ZMEASURE;
inout  VDD_DIG_AO;
inout  VDD_DIG_AFSW;
inout  VDD_DIG_SW;
inout  VDD_DIG_ZMEASURE;

inout	VSS1;
inout	VSS2;
 
inout  VSS_DIG_AO;
//inout  VSS_DIG_SW;
inout  VDDIO;
inout  VSSIO1;
inout  VSSIO2;


inout  VREF0P8;
//inout  Z_RFB;
//inout  Z_VIN_CAL;
//inout  Z_VIN_MEAS;
//inout  Z_VIN;
//inout  Z_VOUT;



input  D2A_ATM0;
input  D2A_ATM1;
input  D2A_ATM2;
input  D2A_ATM3;
input  D2A_ATM4;
input  D2A_ATM5;
input  D2A_ATM6;
input  D2A_ATM7;
input  D2A_ATM8;
input  D2A_ATM9;
input  D2A_ATM10;
input  D2A_ATM11;
input  D2A_ATM12;

input  D2A_BG1P2_BUF_EN;
input  D2A_VCM1P5_BUF_EN;
input  D2A_BIST_EN;
//input [1:0]  D2A_LEADOFF_EN;
input  D2A_DCLEADOFF_EN;
input  D2A_ACLEADOFF_EN;
input  D2A_DCLEADOFF_RMODE_EN;
input  D2A_DCLEADOFF_VINFLIP;
input  D2A_ECG_DDACHOP_EN;
input  D2A_ECG_DDA_EN;
input  D2A_ECG_LPF_EN;
input  D2A_ECG_PGA_EN;
input  D2A_EN_PPGDAC_BUFFER;
input  D2A_EN_PPG_AF;
input  D2A_EN_PPG_BUFFER;
input  D2A_EN_PPG_SH;
input  D2A_EN_TIA;
input  D2A_EN_TIA_VREFBUFFER;
input  D2A_LEDDAC_SEL;
input  D2A_LED_EN;
input  D2A_LED_STANDBYEN;
input  D2A_PPGDAC0_EN;
input  D2A_PPGDAC1_EN;
input  D2A_PPG_SH_CK;
//input  D2A_RLD_AMP_EN;
input	D2A_RLD_EN;
input	D2A_RLD_CHOP_EN;
input	D2A_RLD_CLK64K;

input  D2A_SDM_CLK;
input  D2A_SDM_EN;
//input  D2A_SW_Z_ADC_EN;
//input  D2A_SW_Z_ADC_SAMPLE;
input  D2A_SW_Z_CALMD;
input  D2A_SW_Z_CLK256K;
//input  D2A_SW_Z_EN;
input  D2A_Z_EN;
input  D2A_SW_Z_RXGAIN;
input  D2A_TSC_EN;
input  D2A_TSC_INA_EN;
input  D2A_TSC_OUT_SEL;

//output [9:0]  A2D_SW_Z_ADC_D;
output [7:0]  A2D_SPARE_TRIM_SW0;

input [2:0]  D2A_ECG_PGA_GSEL;
input [1:0]  D2A_ECG_DDA_CLKSEL;
input [1:0]  D2A_PDVREF_SEL;
input [2:0]  D2A_SDM_VIN_SEL;
input [1:0]  D2A_LEDSEL;
input [1:0]  D2A_SW_Z_TX_GSEL;
input [7:0]  D2A_LDO1V5_VTRIM;
input [1:0]  D2A_ECG_DDA_ISEL;
input [1:0]  D2A_SDM_BIAS;
input [9:0]  D2A_SW_Z_DDS;
input [1:0]  D2A_PPG_TEST_OUT;
input [11:0]  D2A_PPGDAC1_VSEL;
input [7:0]  D2A_TIA_IDAC;
input [3:0]  D2A_TIA_GAIN;
input [2:0]  D2A_TSC_INA_GSEL;
input [1:0]  D2A_PPG_TEST_IN;
//input [2:0]  D2A_DCLEADOFF_ISEL_TRIM;
input [7:0]  D2A_DCLEADOFF_ISEL_TRIM;
//input [2:0]  D2A_ACLEADOFF_VTHNSEL_TRIM;
//input [2:0]  D2A_ACLEADOFF_VTHPSEL_TRIM;
input [7:0]  D2A_ACLEADOFF_VTHNSEL_TRIM;
input [7:0]  D2A_ACLEADOFF_VTHPSEL_TRIM;

input [2:0]  D2A_TSC_BJT_SEL;
input [11:0]  D2A_PPGDAC0_VSEL;
//input [2:0]  D2A_DCLEADOFF_COMP_TH_TRIM;
input [7:0]  D2A_DCLEADOFF_COMP_TH_TRIM;

input [7:0]  D2A_OSC_TRIM;
input [7:0]  D2A_BGH_CTRIM;
input [7:0]  D2A_BGH_VTRIM;
input [2:0]  D2A_BIST_ISEL;
input [2:0]  D2A_ECG_DDA_GSEL;
//input [1:0]  D2A_ACLEADOFF_ISEL_TRIM;
input [7:0]  D2A_ACLEADOFF_ISEL_TRIM;

input [7:0]  D2A_SPARE_TRIM0;
input [7:0]  D2A_SPARE_TRIM1;
input [7:0]  D2A_SPARE_TRIM2;
input [7:0]  D2A_SPARE_TRIM3;
input [7:0]  D2A_SPARE_TRIM_SW0;
input [7:0]  D2A_SPARE_TRIM_SW1;
input [9:0]  D2A_ECGCAL_VSEL_TRIM;

wire A2D_OSC_OUT_bak;
//assign A2D_OSC_OUT = A2D_Wake_UP_i & A2D_OSC_OUT_bak;
assign A2D_OSC_OUT =  A2D_OSC_OUT_bak;

`ifdef ATPG_PATTERNS
initial begin
	//provided externally. analog should be off during scan test
	force VDD_DIG_AO = 1'b1;
	force VDD_DIG_SW = 1'b1;
	force VDD_DIG_AFSW = 1'b1;
	force VSS_DIG_AO = 1'b0;
	//force VSS_DIG_SW = 1'b0;
	//force VSSIO1 = 1'b0;
	//force VSSIO2 = 1'b0;
	force POC = 1'b1;

	force A2D_OSC_OUT = 1'bx;
	force A2D_SDM_OUT = 1'bx;
	force A2D_Wake_UP_i = 1'b1;
	force A2D_external_clock_I = 1'bx;
end

`else

wire A2D_external_en_I_internal;
assign  A2D_external_en_I = A2D_external_en_I_internal;

// Temporily fixed by Daniel - Xin should review
//assign POC = 1'b1;

// Buses in the design
wire wakeup;

`ifndef ATPG_SIM
wire VDD_DIG_SW_tmp;
assign (pull1,pull0) A2D_SPARE_TRIM_SW0[7] = (VDD_DIG_AO === 1'b1) ? 1'b0 : 1'bx;
assign (pull1,pull0) A2D_SPARE_TRIM_SW0[6] = (VDD_DIG_AO === 1'b1) ? 1'b0 : 1'bx;
assign (pull1,pull0) A2D_SPARE_TRIM_SW0[5] = (VDD_DIG_AO === 1'b1) ? 1'b0 : 1'bx;
assign (pull1,pull0) A2D_SPARE_TRIM_SW0[4] = (VDD_DIG_AO === 1'b1) ? 1'b0 : 1'bx;
assign (pull1,pull0) A2D_SPARE_TRIM_SW0[3] = (VDD_DIG_AO === 1'b1) ? 1'b0 : 1'bx;
assign (pull1,pull0) A2D_SPARE_TRIM_SW0[2] = (VDD_DIG_AO === 1'b1) ? 1'b0 : 1'bx;
assign (pull1,pull0) A2D_SPARE_TRIM_SW0[1] = (VDD_DIG_AO === 1'b1) ? 1'b0 : 1'bx;
assign (pull1,pull0) A2D_SPARE_TRIM_SW0[0] = (VDD_DIG_AO === 1'b1) ? 1'b0 : 1'bx;
assign (pull1,pull0) A2D_LOFF_STATN = '0;
assign (pull1,pull0) A2D_LOFF_STATP = '0;
assign (pull1,pull0) A2D_ACLEADOFF_STATN = '0;
assign (pull1,pull0) A2D_ACLEADOFF_STATP = '0;
assign (pull1,pull0) A2D_external_en_I = '0; 
assign (pull1,pull0) A2D_external_RESET = '1;
//change to & logic
//assign A2D_Wake_UP_i = A2D_SW_POWER_POR;
assign A2D_Wake_UP_i = A2D_SW_POWER_POR & wakeup;
//assign (pull1,pull0) VDD_DIG_AO = '1; 
//assign (pull1,pull0) VDD_DIG_SW = VDD_DIG_SW_tmp; 
//assign (pull1,pull0) VDDIO = '1; 
assign  VDD_DIG_AO = '1; 
//assign  VDD_DIG_SW = VDD_DIG_SW_tmp; 
assign  VDD_DIG_AFSW = VDD_DIG_SW_tmp; 
assign  VDDIO = '1; 
// --------------------------------------------------------
 // Instantiate OSC
 // --------------------------------------------------------
`ifdef FPGA
wire m8_clk;
wire por_resetn_pll;
bms3_pllfpga u_bms3_pllfpga(
.clk_in1(clk_in1),
.clk_out1(m8_clk),
.locked(por_resetn_pll)
//.m8_clk(m8_clk),
//.por_resetn(por_resetn_pll)
);

reg[4:0] clk_256k_cnt;
always @(posedge m8_clk or negedge por_resetn_pll) begin
	if(~por_resetn_pll)
		clk_256k_cnt <= 5'b0;
	else if(clk_256k_cnt == 15)
		clk_256k_cnt <= 5'b0;
	else
		clk_256k_cnt <= clk_256k_cnt + 1;
end

reg k256_clk;
always @(posedge m8_clk or negedge por_resetn_pll) begin
	if(~por_resetn_pll)
		k256_clk <= 1'b0;
	else if(clk_256k_cnt == 15)	
		k256_clk <= ~k256_clk;
end
assign A2D_OSC_OUT = k256_clk;
assign A2D_external_clock_I = k256_clk;
`else
 wire [10:0]  hfosc_rcal ;
 osc_analog OSC (
    //.hfosc                 (  hfosc                   ),
    .wakeup(wakeup),
    .hfosc                 (  A2D_OSC_OUT_bak                   ),
    .hfosc_rcal            (  hfosc_rcal              )
  );
`endif
 // --------------------------------------------------------
 // Instantiate PMU
 // --------------------------------------------------------

`ifdef FPGA
 assign A2D_SW_POWER_POR = por_resetn_pll;
 assign A2D_VDDI_POR = por_resetn_pll;
`else
 pmu_analog PMU_SW (
    .VDD_SW(VDD_DIG_SW_tmp),
    .VDD_AO(VDD_DIG_AO),
    .wakeup(wakeup),
     .POC(POC),
    .por_resetn            (  A2D_SW_POWER_POR              ),
    .cp_en                 (                     ),
    .bat_off               (                   )
  );  

 pmu_analog_always_on PMU_ALW_ON (
    .VDD(VDD_DIG_AO),
    .por_resetn            (  A2D_VDDI_POR    )
  ); 
`endif

 // --------------------------------------------------------------------------------
 // zmeas analog
 // --------------------------------------------------------------------------------
`ifdef VERILOG_ENV 
zmeas_analog  #(
  `ifdef FREQ4K
  .file_adc("../../../verification/models/analog/zmeas_analog/stimulus/ADC_Freq_4KHz_ZmeasRC_50kohm_RFB_20kohm_values.txt")          //values for 4khz
  `elsif FREQ1K
  .file_adc("../../../verification/models/analog/zmeas_analog/stimulus/ADC_Freq_0.9766KHz_ZmeasRC_22.3607Kohm_RFB_20Kohm_values.txt")//values for 1khz
  `else//FREQ2K
  .file_adc("../../../verification/models/analog/zmeas_analog/stimulus/ADC_Freq_2KHz_ZmeasRC_50kohm_RFB_20kohm_values.txt")          //values for 2khz
  `endif
 )
`else
zmeas_analog #(
  .file_adc1("../../../verification/models/analog/zmeas_analog/stimulus/ADC_Freq_0.9766KHz_ZmeasRC_22.3607Kohm_RFB_20Kohm_values.txt"),
  .file_adc2("../../../verification/models/analog/zmeas_analog/stimulus/ADC_Freq_2KHz_ZmeasRC_50kohm_RFB_20kohm_values.txt"),
  .file_adc3("../../../verification/models/analog/zmeas_analog/stimulus/ADC_Freq_4KHz_ZmeasRC_50kohm_RFB_20kohm_values.txt")
 )
`endif
  u_zmeas_analog (
	.clk(D2A_SW_Z_CLK256K),
	.nrst(A2D_SW_POWER_POR),
	//.adc_sample(zmeas_adc_sample),
	//.adc_sample(D2A_SW_Z_ADC_SAMPLE),
	.adc_sample(1'b0),
	//.adc_enable(D2A_SW_Z_ADC_EN),
	.adc_enable(1'b0),
	`ifdef FPGA
	`else
/*
	  .Z_RFB_NOM(Z_RFB),
          .Z_VIN_NOM(Z_VIN),
          .Z_VIN_CAL_NOM(Z_VIN_CAL),
          .Z_VIN_MEAS_NOM(Z_VIN_MEAS),
          .Z_VOUT_NOM(Z_VOUT),
*/
	  .Z_RFB_NOM(),
          .Z_VIN_NOM(),
          .Z_VIN_CAL_NOM(),
          .Z_VIN_MEAS_NOM(),
          .Z_VOUT_NOM(),

          .ATM0(D2A_ATM0),
          .ATM1(D2A_ATM1),
          .ATM2(D2A_ATM2),
          .ATM3(D2A_ATM3),
          .ATM4(D2A_ATM4),
          .ATM5(D2A_ATM5),
          .ATM6(D2A_ATM6),
          .ATM7(D2A_ATM7),
          .ATM8(D2A_ATM8),
	`endif	

	//.adc_eoc(zmeas_adc_eoc),
	//.adc_eoc(A2D_SW_Z_ADC_EOC),
	.adc_eoc(),
	//.adc_in(zmeas_adc_din)
	//.adc_in(A2D_SW_Z_ADC_D)
	.adc_in()
  );

 // --------------------------------------------------------------------------------
 // imeas analog
 // --------------------------------------------------------------------------------
`ifdef ZMEAS_DDS_TO_IMEAS
 dds10bit_to_1bitsdm 
  u_dds10bit_to_1bitsdm(
	.zmeas_dds_out(D2A_SW_Z_DDS),
        .adc_clk(D2A_SDM_CLK),
        .nrst(A2D_SW_POWER_POR),
        .imeas_adc_in(A2D_SDM_OUT)
  );
`else
 imeas_analog #( 
 .file_adc0("../../../verification/models/analog/imeas_analog/stimulus/dB0.dat"),
 .file_adc1("../../../verification/models/analog/imeas_analog/stimulus/dB1.dat"),
 .file_adc2("../../../verification/models/analog/imeas_analog/stimulus/dB2.dat"),
 .file_adc3("../../../verification/models/analog/imeas_analog/stimulus/dB3.dat"),
 .file_adc4("../../../verification/models/analog/imeas_analog/stimulus/dB4.dat"),
 .file_adc5("../../../verification/models/analog/imeas_analog/stimulus/dB5.dat"),
 .file_adc6("../../../verification/models/analog/imeas_analog/stimulus/dB6.dat"),
 .file_adc7("../../../verification/models/analog/imeas_analog/stimulus/dB7.dat"),
 .file_adc8("../../../verification/models/analog/imeas_analog/stimulus/dB8.dat"),
 .file_adc24Hz("../../../verification/models/analog/imeas_analog/stimulus/SDM_24Hz.dat")
 )  
  u_imeas_analog(
	//.chnum(imeas_chnum),
	.chnum({1'b0,D2A_SDM_VIN_SEL}),
        //.adc_clk(imeas_adc_clk),
        .adc_clk(D2A_SDM_CLK),
        .nrst(A2D_SW_POWER_POR),
        //.imeas_sd16off(imeas_sd16off),
        //.imeas_sd16slp(imeas_sd16slp),
        //.imeas_adc_in(imeas_adc_din)
        .imeas_adc_in(A2D_SDM_OUT)
  );
`endif
 // --------------------------------------------------------------------------------
 // NIRS_PPG
 // --------------------------------------------------------------------------------
 ppg_nirs_model u_ppg_nirs_model
 (
  .DVDD(),
  .AVDD(),
  .DVSS(),
  .AVSS(), 
  .PDIN(),
  .D2A_NIRS_RESET_SW(), 
  .D2A_NIRS_IPD_SW(), // SW1
  .D2A_NIRS_IIN_SW(), 
  .D2A_NIRS_IIN_MIRROR(),
  .D2A_NIRS_IREFC_TRIM(),
  .D2A_NIRS_CFRATE_TRIM(),
  .D2A_NIRS_IDAC(), 
  .D2A_NIRS_TEST_EN(),
  .D2A_NIRS_EN(),
  .D2A_NIRS_IDAC_EN(),  
  .IBIAS_1U(),
  .IBIAS_65N(),
  .IBIAS_N_1U(),
  .VREF_1P2(),
  .CLK_NIRS_1P8(),
  .CLKCHOP_1P8(),
  .D2A_NIRS_CHOPPER_EN(),  
  .A2D_NIRS_IREFCOARSE(), 
  .A2D_NIRS_IREFFINE(),
  .IREFCOARSE_TEST(),
  .IREFFINE_TEST(),
  .IDAC_TEST()
);
 // --------------------------------------------------------------------------------
 // External HF_CLK
 // --------------------------------------------------------------------------------
`ifdef FPGA
`else
  ext_hfosc u_ext_hfosc (
    .ext_hfclk                 (A2D_external_clock_I),
    .ext_hfclk_sel             (A2D_external_en_I)
  );
`endif
`endif
`endif
endmodule
