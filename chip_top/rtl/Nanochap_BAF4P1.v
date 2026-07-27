/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/* File Name	: Nanochap_BAF4P1.v                                                        */
/* Project	: */
/* Description	: top chip module                                                       */
/* Designer	: */
/* Date		: */
// 0.1          7/2022  Mohsen Radfar 
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
 `timescale 1 ns /  1ps

module Nanochap_BAF4P1  (
  // digital power ground pads
  `ifdef FPGA 
  input   wire        clk_in1,
  inout	  wire [18:0] IOBUF_PAD
  `else
  inout	  wire        VPP,
  inout   wire        flash_ref,
  inout   wire        VDDIO,
  inout   wire 	      VSSIO,
  inout   wire 	      VDD_DIG_SW,

  //removed 31Oct2022 by Xin	
  inout   wire 	      DVDD_1P5_ANA,
  //inout   wire 	DVSS_1P5_ANA,
  inout   wire 	      VDD_DIG_AO,
  inout   wire 	      VSS_DIG_SW,
  inout   wire 	      VSS_DIG_AO,
  inout   wire        VDD_DIG_AFSW,

  /*
  inout   wire    vpp_flash,
  inout   wire    flash_ref,
  inout   wire    vdd_io,
  inout   wire    vddi,		//vdd_dig,
  inout   wire    vssi,		//vss_dig,
  inout   wire    vdd,	
  inout   wire    vss_io,

  // analog power ground pads
  inout   wire    vddia,
  inout   wire    vssia,
  */	
  // digital data/clk pads
  inout	wire [18:0]   IOBUF_PAD,
  //inout	wire [15:0] IOBUF_P, 


  //added by supriya
  input	wire iopad_testmode0,
  input	wire iopad_testmode1,
  input	wire iopad_resetn		
  `endif
);



// with OSC
//wire        hfosc;
wire        A2D_OSC_OUT;
// with PMU
//wire        por_resetn;
//wire	    por_resetn_always_on;
wire A2D_SW_POWER_POR;    //??? //V
wire A2D_VDDI_POR;  //V
// with imeas
wire        imeas_adc_clk;
wire        imeas_cal_en;
wire [1:0]  imeas_pga_gain;
wire        imeas_sd16off;
wire        imeas_sd16slp;
wire        imeas_gubias_en;
wire [1:0]  imeas_rebias_dac;
wire [5:0]  imeas_webias_dac;         
// with zmeas
//wire [9:0]  zmeas_adc_din;
//wire        zmeas_adc_eoc;
//wire        zmeas_adc_sample;
/*
wire [9:0]  A2D_Z_ADC_D;
wire        A2D_Z_ADC_EOC;
wire        D2A_Z_ADC_SAMPLE;
*/
wire        zmeas_adc_clk;
wire        zmeas_adc_enable;
wire        zmeas_meas_cal;
wire [1:0]  zmeas_vol_range;
wire        zmeas_pga_gain;
wire        zmeas_power_en;
wire [9:0]  zmeas_rom_data;  

//wires for IO cell from sw domain to always on
wire [18:0] IOBUF_IE;
wire [18:0] IOBUF_CS;
wire [18:0] IOBUF_PU;
wire [18:0] IOBUF_SR;
wire [18:0] IOBUF_DR;
wire [18:0] IOBUF_A;
wire [18:0] IOBUF_OE;
wire [18:0] IOBUF_OS;
wire [18:0] IOBUF_OD;
wire [18:0] IOBUF_PD;
wire [18:0] IOBUF_Y;
wire        IO_testmode0_PD;
wire        IO_testmode1_PD;
wire        IO_exresetn_PU;

//
wire [18:0] IOBUF_YA;		//Supriya: check with Mohsen
wire POC;			//Supriya: checked with Mohsen, coming from analog
//wire IOBUF_POC;			//Supriya: checked with Mohsen, coming from analog

//
wire iopad_testmode0_en_y;
wire iopad_testmode1_en_y;
wire iopad_resetn_y;

//wires for IO cell from always on
wire [18:0] IOBUF_IE_always_on;
wire [18:0] IOBUF_CS_always_on;
wire [18:0] IOBUF_PU_always_on;
wire [18:0] IOBUF_SR_always_on;
wire [18:0] IOBUF_DR_always_on;
wire [18:0] IOBUF_A_always_on;
wire [18:0] IOBUF_OE_always_on;
wire [18:0] IOBUF_OS_always_on;
wire [18:0] IOBUF_OD_always_on;
wire [18:0] IOBUF_PD_always_on;
wire [18:0] IOBUF_Y_always_on;

wire	IOBUF_IE_testmode0_always_on;
wire	IOBUF_PU_testmode0_always_on;
wire	IOBUF_PD_testmode0_always_on;
wire	iopad_testmode0_en_y_always_on;

wire	IOBUF_IE_testmode1_always_on;
wire	IOBUF_PU_testmode1_always_on;
wire	IOBUF_PD_testmode1_always_on;
wire	iopad_testmode1_en_y_always_on;

wire	IOBUF_IE_resetn_always_on;
wire	IOBUF_PU_resetn_always_on;
wire	IOBUF_PD_resetn_always_on;
wire	iopad_resetn_y_always_on;

`ifdef FPGA
fpga_behavior u_fpga_hehavior(
.iopad_testmode0_en_y(iopad_testmode0_en_y_always_on),
.iopad_testmode1_en_y (iopad_testmode1_en_y_always_on),
.iopad_resetn_y(iopad_resetn_y_always_on),

.IOBUF_PAD(IOBUF_PAD),
.IOBUF_A(IOBUF_A_always_on),
.IOBUF_OE(IOBUF_OE_always_on),
.IOBUF_Y(IOBUF_Y_always_on)
);
`endif

//wire [2:0] D2A_CPCLK;
//always on
wire [2:0] 	dc_clk_div_spi;
wire		poresetn_hf;
wire		spi_write;
//wire		ext_clk_sel;
//wire		ext_hfclk;
wire	A2D_external_en_I; //from analog IO cells
wire	A2D_external_clock_I; //external clock from analog IO cells

wire		scan_clk;
wire		scan_rst_n;
//wire		ext_reset_always_on;
wire		A2D_external_RESET;
//wire		wakeup;
wire		A2D_Wake_UP_i;
wire		vdd_switchable;

wire atpg_en_sw;
wire atpg_en;
wire scan_en_sw;
wire scan_en;

wire [7:0] flash_to_ana_trim1; 
wire [7:0] flash_to_ana_trim2;  
wire [7:0] flash_to_ana_trim3;
wire [7:0] flash_to_ana_trim4;
wire [7:0] flash_to_ana_trim5;
wire [7:0] flash_to_ana_trim6;
wire [7:0] flash_to_ana_trim7;
wire [7:0] flash_to_ana_trim8;
wire [7:0] flash_to_ana_trim9;
wire [7:0] flash_to_ana_trim10;
wire [7:0] d2a_SW_spare0_from_flash;
wire [7:0] d2a_SW_spare1_from_flash;
wire [7:0] d2a_AO_spare0_from_flash;
wire [7:0] d2a_AO_spare1_from_flash;
wire [7:0] d2a_AO_spare2_from_flash;
wire [7:0] d2a_AO_spare3_from_flash;

wire [7:0] trim1_always_on;
wire [7:0] trim2_always_on;
wire [7:0] trim3_always_on;
wire [7:0] trim4_always_on;
wire [7:0] trim5_always_on;
wire [7:0] trim6_always_on;
wire [7:0] trim7_always_on;
wire [7:0] trim8_always_on;
wire [7:0] trim9_always_on;
wire [7:0] trim10_always_on;
wire [7:0] trim11_always_on;
wire [7:0] trim12_always_on;
wire [7:0] trim13_always_on;
wire [7:0] trim14_always_on;


//wire       CHIP_FLASH_VREF;
wire       VREF0P8;

//analog i/p
wire       BG1P2_BUF_EN;
//wire       DAC_BUF_EN;

wire VCM1P5_BUF_EN;     
wire RLD_AMP_EN;        

//ECG
wire ECG_PGA_EN;        
wire ECG_LPF_EN;         
wire [2:0] ECG_PGA_GSEL;      
wire [1:0] ECG_DDA_CLKSEL;    
wire ECG_DDA_EN;        
wire [2:0] ECG_DDA_GSEL;      
wire ECG_DDACHOP_EN;     
wire [1:0] ECG_DDA_ISEL;      
wire       RLD_CLK64K;
wire       ACLEADOFF_CLK;
wire       ECG_ELECTRODE_EN;
wire       ECGCAL_EN;
wire       RLD_CHOP_EN; 
wire [9:0] ECGCAL_VSEL_TRIM;

//DC_LEAD_OFF
wire DC_LEAD_OFF_RMODE_EN;      
wire DC_LEAD_OFF_VIN_FLIP;   
wire DC_LEAD_OFF_EN; 

//ACLEAD_OFF
wire ACLEADOFF_EN;

wire       D2A_TSC_EN;
//wire       D2A_TSC_AMP_EN;
wire [2:0] D2A_TSC_BJT_SEL;
wire [2:0] D2A_TSC_INA_GSEL;
wire       D2A_TSC_OUT_SEL;
wire       D2A_TSC_INA_EN;
wire       TSC_EN;
wire       TSC_AMP_EN;
wire [2:0] TSC_BJT_SEL;
wire [2:0] TSC_INA_GSEL;
wire       TSC_OUT_SEL;
wire       TSC_INA_EN;
//Peripheral
wire       BIST_EN;
wire [2:0] BIST_ISEL;
//wire       DDA_EN;
//wire [2:0] DDA_GSEL;
//wire       D2A_PGA_EN;
//wire [2:0] D2A_PGA_VIN_SEL;
//wire [1:0] D2A_PGA_GSEL;
//wire       ELE_BUF_EN;
//wire [2:0] ELE_BUF_ISEL;
/*wire       R2R_DAC1_EN;
wire [11:0]R2R_DAC1_DIN;
wire       R2R_DAC2_EN;
wire [11:0]R2R_DAC2_DIN;*/
/*
wire        imeas_adc_din;
wire [2:0]  imeas_chnum;
wire       SDM_EN;
wire        SDM_CLK;
*/
wire        A2D_SDM_OUT;
wire [2:0]  D2A_SDM_VIN_SEL; 
wire        D2A_SDM_EN; 
wire        D2A_SDM_CLK;
wire [1:0]  D2A_SDM_BIAS;
wire        SDM_EN; 
wire        SDM_CLK;
wire [2:0]  SDM_VIN_SEL;
wire [1:0]  SDM_BIAS;
/*
wire [3:0]  D2A_Z_SEL1V5;  //1:0, config_output_voltage_range[1:0]
//2:measure_calibrate
//3. pga_gain
wire        D2A_Z_ADC_EN;   //from SPI, then select 2 source, then output to ana
wire        Z_DAC_EN;   //from SPI, directly go to ana
wire        D2A_Z_SYS_CLK;  //adc_clk
wire [9:0]  D2A_Z_DDS;  //rom
*/

wire        D2A_ATM0,ATM0;
wire        D2A_ATM1,ATM1;
wire        D2A_ATM2,ATM2;
wire        D2A_ATM3,ATM3;
wire        D2A_ATM4,ATM4;
wire        D2A_ATM5,ATM5;
wire        D2A_ATM6,ATM6;
wire        D2A_ATM7,ATM7;
wire        D2A_ATM8,ATM8;
wire        D2A_ATM9,ATM9;
wire        D2A_ATM10,ATM10;
wire        D2A_ATM11,ATM11;
wire        D2A_ATM12,ATM12;

//analog registers value from alwasy on
wire D2A_BG1P2_BUF_EN;
//wire D2A_DAC_BUF_EN;

wire D2A_VCM1P5_BUF_EN;     
wire D2A_RLD_AMP_EN;        

//ECG
wire D2A_ECG_PGA_EN;        
wire D2A_ECG_LPF_EN;         
wire [2:0] D2A_ECG_PGA_GSEL;      
wire [1:0] D2A_ECG_DDA_CLKSEL;    
wire D2A_ECG_DDA_EN;        
wire [2:0] D2A_ECG_DDA_GSEL;      
wire D2A_ECG_DDACHOP_EN;     
wire [1:0] D2A_ECG_DDA_ISEL;   
wire       D2A_2ELECTRODE_EN;       
wire       D2A_ECGCAL_EN;
wire       D2A_RLD_CHOP_EN;
wire       D2A_RLD_CLK64K;
wire       D2A_ACLEADOFF_CLK;
wire [9:0] D2A_ECGCAL_VSEL_TRIM;

//DC_LEAD_OFF
wire D2A_DC_LEAD_OFF_RMODE_EN;      
wire D2A_DC_LEAD_OFF_VIN_FLIP;   
wire D2A_DC_LEAD_OFF_EN; 

//ACLEADOFF
wire D2A_AC_LEAD_OFF_EN;
wire  [7:0] TIA_IDAC;
wire        LEDDAC_SEL; 
wire  [1:0] LEDSEL;         
wire        LED_STANDBYEN;
wire        LED_EN;
wire        EN_PPG_AF;
wire        PPG_SH_CK;
wire        EN_PPG_SH;
wire        EN_TIA;
wire        EN_TIA_VREFBUFFER;
wire  [3:0] TIA_GAIN;
wire        EN_PPG_BUFFER;
wire        EN_PPGDAC_BUFFER;
wire  [11:0] PPGDAC0_VSEL;
wire         PPGDAC0_EN;
wire  [11:0] PPGDAC1_VSEL;
wire         PPGDAC1_EN;
wire  [1:0]  PPG_TEST_OUT;
wire  [1:0]  PPG_TEST_IN;
wire  [1:0]  PDVREF_SEL;

wire        D2A_EN_PPG_AF        ; 
wire        D2A_EN_PPG_BUFFER    ; 
wire        D2A_EN_PPG_SH        ; 
wire        D2A_EN_TIA           ; 
wire        D2A_EN_TIA_VREFBUFFER;
wire        D2A_LEDDAC_SEL       ; 
wire  [1:0] D2A_LEDSEL           ; 
wire        D2A_LED_EN           ; 
wire        D2A_LED_STANDBYEN    ; 
wire  [1:0] D2A_PDVREF_SEL       ; 
wire        D2A_PPG_SH_CK        ; 
wire  [1:0] D2A_PPG_TEST_IN      ; 
wire  [1:0] D2A_PPG_TEST_OUT     ; 
wire  [3:0] D2A_TIA_GAIN         ; 
wire  [7:0] D2A_TIA_IDAC         ; 
wire        D2A_EN_PPGDAC_BUFFER ; 
wire [11:0] D2A_PPGDAC0_VSEL     ; 
wire        D2A_PPGDAC0_EN       ; 
wire [11:0] D2A_PPGDAC1_VSEL     ; 
wire        D2A_PPGDAC1_EN       ; 

wire D2A_BIST_EN;
wire [2:0]  D2A_BIST_ISEL;
//wire D2A_DDA_EN;
//wire [2:0] D2A_DDA_GSEL;
//wire D2A_ELE_BUF_EN;
//wire [2:0] D2A_ELE_BUF_SEL;

wire [1:0]  	D2A_SW_Z_TX_GSEL;
wire 		D2A_SW_Z_CALMD;
wire 		D2A_SW_Z_CLK256K;
wire [9:0]	D2A_SW_Z_DDS;
wire		D2A_SW_Z_RXGAIN;
//wire		D2A_SW_Z_EN;
wire		D2A_Z_EN;
wire            Z_EN;

wire		D2A_SW_Z_ADC_EN;
wire		D2A_SW_Z_ADC_SAMPLE;
wire [9:0]	A2D_SW_Z_ADC_D;
wire 		    A2D_SW_Z_ADC_EOC;
wire [7:0]  A2D_SPARE_0;
wire        A2D_LOFF_STATN; 
wire        A2D_LOFF_STATP; 
wire        A2D_ACLEADOFF_STATN; 
wire        A2D_ACLEADOFF_STATP; 
//wire       PGA_EN;
//wire [2:0] PGA_VIN_SEL;
//wire [1:0] PGA_GSEL;

/*
wire      r2r_dac1_en_always_on;
wire [11:0]r2r_dac1_din_always_on;
wire       r2r_dac2_en_always_on;
wire [11:0]r2r_dac2_din_always_on; */

wire       flash_reset_done;

//instantiations:
top_dig_always_on top_dig_always_on_inst (
  //.wakeup(wakeup), //from analog
  .A2D_Wake_UP_i(A2D_Wake_UP_i), //from analog
  //.hfosc(hfosc), //from analog 256 KHz OSC
  .A2D_OSC_OUT(A2D_OSC_OUT), //from analog 256 KHz OSC
  //.ext_resetn(ext_reset_always_on),
  .A2D_external_RESET(A2D_external_RESET),
  //.por_resetn_always_on(por_resetn_always_on),
  .A2D_VDDI_POR(A2D_VDDI_POR),
  .A2D_SW_POWER_POR(A2D_SW_POWER_POR),

  .scan_clk(scan_clk),
  .atpg_en_in(atpg_en), // atpg_en goes back into always on
  .atpg_en_sw(atpg_en_sw), //input from pin mux from io cell
  .atpg_en_out(atpg_en), //coming out from always on. used for hookup in dft script, after hookup in dft script, atpg_en goes evrywhere, also goes back to always on
  .scan_en_in(scan_en), // scan_en goes back into always on
  .scan_en_sw(scan_en_sw), //input from pin mux from io cell
  .scan_en_out(scan_en), //coming out from always on. used for hookup in dft script, after hookup in dft script, scan_en goes evrywhere, also goes back to always on
  .scan_rst_n(scan_rst_n),

  .poresetn_hf_sw_power(poresetn_hf), //SW_POWER_POR from analog top
  .spi_write(spi_write), //from SPI
  .flash_reset_done(flash_reset_done),//from flash controller

  //.ext_clk_sel(ext_clk_sel), //from analog IO cells
  //.ext_hfclk(ext_hfclk), //external clock from analog IO cells
  .A2D_external_en_I(A2D_external_en_I), //from analog IO cells
  .A2D_external_clock_I(A2D_external_clock_I), //external clock from analog IO cells

  //registers from SPI  
  //.dc_dc_en_spi(dc_dc_en_spi),
  //.fclk_dynen_spi(fclk_dynen_spi),
  //	.d2a_cpclk(dc_clk_div_spi), //input [2:0] dc_clk_div_spi

  .bg1p2_buf_en(BG1P2_BUF_EN),
  //	.dac_buf_en(DAC_BUF_EN),

  .vcm1p5_buf_en(VCM1P5_BUF_EN),     
  .rld_amp_en(RLD_AMP_EN),    


  //ECG
  .ecg_pga_en(ECG_PGA_EN),        
  .ecg_lpf_en(ECG_LPF_EN),         
  .ecg_pga_gsel(ECG_PGA_GSEL),      
  .ecg_dda_clksel(ECG_DDA_CLKSEL),    
  .ecg_dda_en(ECG_DDA_EN),        
  .ecg_dda_gsel(ECG_DDA_GSEL),      
  .ecg_ddachop_en(ECG_DDACHOP_EN),     
  .ecg_dda_isel(ECG_DDA_ISEL),     
  .RLD_CLK64K           (RLD_CLK64K),
  .ACLEADOFF_CLK        (ACLEADOFF_CLK),
  .Z_EN                 (Z_EN),
  .RLD_CHOP_EN          (RLD_CHOP_EN),
  .ECGCAL_EN            (ECGCAL_EN),
  .ECG_ELECTRODE_EN     (ECG_ELECTRODE_EN),
  .ECGCAL_VSEL_TRIM     (ECGCAL_VSEL_TRIM),

  .D2A_RLD_CLK64K       (D2A_RLD_CLK64K), 
  .D2A_ACLEADOFF_CLK    (D2A_ACLEADOFF_CLK),
  .D2A_Z_EN             (D2A_Z_EN),
  .D2A_RLD_CHOP_EN      (D2A_RLD_CHOP_EN),
  .D2A_2ELECTRODE_EN    (D2A_2ELECTRODE_EN),
  .D2A_ECGCAL_EN        (D2A_ECGCAL_EN),
  .D2A_ECGCAL_VSEL_TRIM (D2A_ECGCAL_VSEL_TRIM),

  //DC_LEAD_OFF
  .dc_lead_off_rmode_en(DC_LEAD_OFF_RMODE_EN),      
  .dc_lead_off_vin_flip(DC_LEAD_OFF_VIN_FLIP),   
  .dc_lead_off_en(DC_LEAD_OFF_EN),

  //AC_LEAD_OFF
  .ac_lead_off_en(ACLEADOFF_EN),

  //registers from peripheral
  .bist_en(BIST_EN),
  .bist_isel(BIST_ISEL),
  //	.dda_en(DDA_EN),
  //	.dda_gsel(DDA_GSEL),
  //	.ele_buf_en(ELE_BUF_EN),
  //	.ele_buf_sel(ELE_BUF_ISEL),
  /*.r2r_dac1_en(R2R_DAC1_EN),
  .r2r_dac1_din(R2R_DAC1_DIN),
  .r2r_dac2_en(R2R_DAC2_EN),
  .r2r_dac2_din(R2R_DAC2_DIN),*/

  //registers from flash
  .flash_trim1(flash_to_ana_trim1),
  .flash_trim2(flash_to_ana_trim2),
  .flash_trim3(flash_to_ana_trim3), 
  .flash_trim4(flash_to_ana_trim4),
  .flash_trim5(flash_to_ana_trim5), //OSC_SEL
  .flash_trim6(flash_to_ana_trim6), //DCLEADOFF_COMP_TH
  .flash_trim7(flash_to_ana_trim7), //DCLEADOFF_ISEL
  .flash_trim8(flash_to_ana_trim8), //ACLEADOFF_VTHNSEL
  .flash_trim9(flash_to_ana_trim9), //ACLEADOFF_VTHPSEL
  .flash_trim10(flash_to_ana_trim10),//ACLEADOFF_ISE
  .flash_trim11(d2a_AO_spare0_from_flash),
  .flash_trim12(d2a_AO_spare1_from_flash),
  .flash_trim13(d2a_AO_spare2_from_flash),
  .flash_trim14(d2a_AO_spare3_from_flash),

  //registers to analog top
  //.dc_dc_en_always_on(dc_dc_en_always_on),	
  //.fclk_dynen_always_on(fclk_dynen_always_on),
  //.D2A_CPCLK(D2A_CPCLK), //output [2:0] dc_clk_div_always_on

  //flash controller part
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
  .trim14_always_on(trim14_always_on),

  .D2A_BG1P2_BUF_EN(D2A_BG1P2_BUF_EN),
  //	.D2A_DAC_BUF_EN(D2A_DAC_BUF_EN), 

  .d2a_vcm1p5_buf_en(D2A_VCM1P5_BUF_EN),     
  .d2a_rld_amp_en(D2A_RLD_AMP_EN), 
  .d2a_ecg_pga_en(D2A_ECG_PGA_EN),        
  .d2a_ecg_lpf_en(D2A_ECG_LPF_EN),         
  .d2a_ecg_pga_gsel(D2A_ECG_PGA_GSEL),      
  .d2a_ecg_dda_clksel(D2A_ECG_DDA_CLKSEL),    
  .d2a_ecg_dda_en(D2A_ECG_DDA_EN),        
  .d2a_ecg_dda_gsel(D2A_ECG_DDA_GSEL),      
  .d2a_ecg_ddachop_en(D2A_ECG_DDACHOP_EN),     
  .d2a_ecg_dda_isel(D2A_ECG_DDA_ISEL),       

  //DC_LEAD_OFF
  .d2a_dc_lead_off_rmode_en(D2A_DC_LEAD_OFF_RMODE_EN),      
  .d2a_dc_lead_off_vin_flip(D2A_DC_LEAD_OFF_VIN_FLIP),   
  .d2a_dc_lead_off_en(D2A_DC_LEAD_OFF_EN),

  //AC_LEAD_OFF
  .d2a_ac_lead_off_en(D2A_AC_LEAD_OFF_EN),

  .D2A_BIST_EN(D2A_BIST_EN),
  .D2A_BIST_ISEL(D2A_BIST_ISEL),
  //	.D2A_DDA_EN(D2A_DDA_EN),
  //	.D2A_DDA_GSEL(D2A_DDA_GSEL),
  //	.D2A_ELE_BUF_EN(D2A_ELE_BUF_EN),
  //	.D2A_ELE_BUF_SEL(D2A_ELE_BUF_SEL),
  /*.r2r_dac1_en_always_on(r2r_dac1_en_always_on),
  .r2r_dac1_din_always_on(r2r_dac1_din_always_on),
  .r2r_dac2_en_always_on(r2r_dac2_en_always_on),
  .r2r_dac2_din_always_on(r2r_dac2_din_always_on),*/

  //bypassing pinmux io config during low power mode
  //pinmux to always on connections
  .i_IOBUF_IE(IOBUF_IE),
  .i_IOBUF_CS(IOBUF_CS),
  .i_IOBUF_PU(IOBUF_PU),
  .i_IOBUF_SR(IOBUF_SR),
  .i_IOBUF_DR(IOBUF_DR),
  .i_IOBUF_A(IOBUF_A),
  .i_IOBUF_OE(IOBUF_OE),
  .i_IOBUF_OS(IOBUF_OS),
  .i_IOBUF_OD(IOBUF_OD),
  .i_IOBUF_PD(IOBUF_PD),
  .o_IOBUF_Y(IOBUF_Y),
  .i_IO_testmode0_PD(IO_testmode0_PD),
  .i_IO_testmode1_PD(IO_testmode1_PD),
  .i_IO_exresetn_PU(IO_exresetn_PU),

  .o_iopad_testmode0_en_y(iopad_testmode0_en_y),
  .o_iopad_testmode1_en_y(iopad_testmode1_en_y),
  .o_iopad_resetn_y(iopad_resetn_y),

  //SDM
  .i_D2A_SDM_EN               (SDM_EN),
  .i_D2A_SDM_CLK              (SDM_CLK),
  .i_D2A_SDM_VIN_SEL          (SDM_VIN_SEL),
  .i_D2A_SDM_BIAS             (SDM_BIAS),
  .o_D2A_SDM_EN_AO            (D2A_SDM_EN),
  .o_D2A_SDM_CLK_AO           (D2A_SDM_CLK),
  .o_D2A_SDM_VIN_SEL_AO       (D2A_SDM_VIN_SEL),
  .o_D2A_SDM_BIAS_AO          (D2A_SDM_BIAS),

  //TSC
  .i_D2A_TSC_INA_GSEL         (TSC_INA_GSEL),
  .i_D2A_TSC_EN               (TSC_EN),
  .i_D2A_TSC_BJT_SEL          (TSC_BJT_SEL),
  .i_D2A_TSC_OUT_SEL          (TSC_OUT_SEL),
  .i_D2A_TSC_INA_EN           (TSC_INA_EN),

  .o_D2A_TSC_INA_GSEL_AO      (D2A_TSC_INA_GSEL),
  .o_D2A_TSC_EN_AO            (D2A_TSC_EN),
  .o_D2A_TSC_BJT_SEL_AO       (D2A_TSC_BJT_SEL),
  .o_D2A_TSC_OUT_SEL_AO       (D2A_TSC_OUT_SEL),
  .o_D2A_TSC_INA_EN_AO        (D2A_TSC_INA_EN),

  //PPG
  .i_D2A_EN_PPG_AF            (EN_PPG_AF        ),
  .i_D2A_EN_PPG_BUFFER        (EN_PPG_BUFFER    ),
  .i_D2A_EN_PPG_SH            (EN_PPG_SH        ),
  .i_D2A_EN_TIA               (EN_TIA           ),
  .i_D2A_EN_TIA_VREFBUFFER    (EN_TIA_VREFBUFFER),
  .i_D2A_LEDDAC_SEL           (LEDDAC_SEL       ),
  .i_D2A_LEDSEL               (LEDSEL           ),
  .i_D2A_LED_EN               (LED_EN           ),
  .i_D2A_LED_STANDBYEN        (LED_STANDBYEN    ),
  .i_D2A_PDVREF_SEL           (PDVREF_SEL       ),
  .i_D2A_PPG_SH_CK            (PPG_SH_CK        ),
  .i_D2A_PPG_TEST_IN          (PPG_TEST_IN      ),
  .i_D2A_PPG_TEST_OUT         (PPG_TEST_OUT     ),
  .i_D2A_TIA_GAIN             (TIA_GAIN         ),
  .i_D2A_TIA_IDAC             (TIA_IDAC         ),
  .i_D2A_PPGDAC0_EN           (PPGDAC0_EN       ),
  .i_D2A_PPGDAC0_VSEL         (PPGDAC0_VSEL     ),
  .i_D2A_PPGDAC1_EN           (PPGDAC1_EN       ),
  .i_D2A_PPGDAC1_VSEL         (PPGDAC1_VSEL     ),
  .i_D2A_EN_PPGDAC_BUFFER     (EN_PPGDAC_BUFFER ),
  .o_D2A_EN_PPG_AF_AO         (D2A_EN_PPG_AF       ),
  .o_D2A_EN_PPG_BUFFER_AO     (D2A_EN_PPG_BUFFER   ),
  .o_D2A_EN_PPG_SH_AO         (D2A_EN_PPG_SH       ),
  .o_D2A_EN_TIA_AO            (D2A_EN_TIA          ),
  .o_D2A_EN_TIA_VREFBUFFER_AO (D2A_EN_TIA_VREFBUFFER),
  .o_D2A_LEDDAC_SEL_AO        (D2A_LEDDAC_SEL       ),
  .o_D2A_LEDSEL_AO            (D2A_LEDSEL           ),
  .o_D2A_LED_EN_AO            (D2A_LED_EN           ),
  .o_D2A_LED_STANDBYEN_AO     (D2A_LED_STANDBYEN    ),
  .o_D2A_PDVREF_SEL_AO        (D2A_PDVREF_SEL       ),
  .o_D2A_PPG_SH_CK_AO         (D2A_PPG_SH_CK        ),
  .o_D2A_PPG_TEST_IN_AO       (D2A_PPG_TEST_IN      ),
  .o_D2A_PPG_TEST_OUT_AO      (D2A_PPG_TEST_OUT     ),
  .o_D2A_TIA_GAIN_AO          (D2A_TIA_GAIN         ),
  .o_D2A_TIA_IDAC_AO          (D2A_TIA_IDAC         ),
  .o_D2A_PPGDAC0_EN_AO        (D2A_PPGDAC0_EN       ),
  .o_D2A_PPGDAC0_VSEL_AO      (D2A_PPGDAC0_VSEL     ),
  .o_D2A_PPGDAC1_EN_AO        (D2A_PPGDAC1_EN       ),
  .o_D2A_PPGDAC1_VSEL_AO      (D2A_PPGDAC1_VSEL     ),
  .o_D2A_EN_PPGDAC_BUFFER_AO  (D2A_EN_PPGDAC_BUFFER ),

  //ATM
  .i_D2A_ATM0                 (ATM0),
  .i_D2A_ATM1                 (ATM1),
  .i_D2A_ATM2                 (ATM2),
  .i_D2A_ATM3                 (ATM3),
  .i_D2A_ATM4                 (ATM4),
  .i_D2A_ATM5                 (ATM5),
  .i_D2A_ATM6                 (ATM6),
  .i_D2A_ATM7                 (ATM7),
  .i_D2A_ATM8                 (ATM8),
  .i_D2A_ATM9                 (ATM9),
  .i_D2A_ATM10                (ATM10),
  .i_D2A_ATM11                (ATM11),
  .i_D2A_ATM12                (ATM12),
  .o_D2A_ATM0_AO              (D2A_ATM0),
  .o_D2A_ATM1_AO              (D2A_ATM1),
  .o_D2A_ATM2_AO              (D2A_ATM2),
  .o_D2A_ATM3_AO              (D2A_ATM3),
  .o_D2A_ATM4_AO              (D2A_ATM4),
  .o_D2A_ATM5_AO              (D2A_ATM5),
  .o_D2A_ATM6_AO              (D2A_ATM6),
  .o_D2A_ATM7_AO              (D2A_ATM7),
  .o_D2A_ATM8_AO              (D2A_ATM8),
  .o_D2A_ATM9_AO              (D2A_ATM9),
  .o_D2A_ATM10_AO             (D2A_ATM10),
  .o_D2A_ATM11_AO             (D2A_ATM11),
  .o_D2A_ATM12_AO             (D2A_ATM12),

  //always on to io cell connections
  .o_IOBUF_IE(IOBUF_IE_always_on),
  .o_IOBUF_CS(IOBUF_CS_always_on),
  .o_IOBUF_PU(IOBUF_PU_always_on),
  .o_IOBUF_SR(IOBUF_SR_always_on),
  .o_IOBUF_DR(IOBUF_DR_always_on),
  .o_IOBUF_A(IOBUF_A_always_on),
  .o_IOBUF_OE(IOBUF_OE_always_on),
  .o_IOBUF_OS(IOBUF_OS_always_on),
  .o_IOBUF_OD(IOBUF_OD_always_on),
  .o_IOBUF_PD(IOBUF_PD_always_on),	
  .i_IOBUF_Y(IOBUF_Y_always_on),

  .o_IOBUF_IE_testmode0(IOBUF_IE_testmode0_always_on),
  .o_IOBUF_PU_testmode0(IOBUF_PU_testmode0_always_on),
  .o_IOBUF_PD_testmode0(IOBUF_PD_testmode0_always_on),
  .i_iopad_testmode0_en_y(iopad_testmode0_en_y_always_on),

  .o_IOBUF_IE_testmode1(IOBUF_IE_testmode1_always_on),
  .o_IOBUF_PU_testmode1(IOBUF_PU_testmode1_always_on),
  .o_IOBUF_PD_testmode1(IOBUF_PD_testmode1_always_on),
  .i_iopad_testmode1_en_y(iopad_testmode1_en_y_always_on),

  .o_IOBUF_IE_resetn(IOBUF_IE_resetn_always_on),
  .o_IOBUF_PU_resetn(IOBUF_PU_resetn_always_on),
  .o_IOBUF_PD_resetn(IOBUF_PD_resetn_always_on),
  .i_iopad_resetn_y(iopad_resetn_y_always_on)

  //.vddi(VDD_DIG_AO), //always on digital
  //.vssi(VSS_DIG_AO) 
);

// instaniate top_dig
//wire D2A_ACLEADOFF_CLK;

top_dig u_top_dig (
  // with OSC
  //.hfosc(hfosc),
  .AO2D_DC_LEAD_OFF_EN(D2A_DC_LEAD_OFF_EN),//V
  .AO2D_AC_LEAD_OFF_EN(D2A_AC_LEAD_OFF_EN),  
  .D2A_ACLEADOFF_CLK(ACLEADOFF_CLK),// 
  .D2A_RLD_CLK64K(RLD_CLK64K),// 

  .A2D_OSC_OUT(A2D_OSC_OUT),

  .A2D_external_en_I(A2D_external_en_I), //from analog IO cells
  .A2D_external_clock_I(A2D_external_clock_I), //external clock from analog IO cells
  //.ext_hfclk(ext_hfclk),
  //.ext_clk_sel(ext_clk_sel),

  //To/From always on
  .scan_clk(scan_clk),
  .atpg_en(atpg_en), //going back to top dig after & with wakup_i
  .atpg_en_sw(atpg_en_sw), //coming from sw domain pin mux (io cell)
  .scan_en(scan_en), //going back to top dig after & with wakup_i
  .scan_en_sw(scan_en_sw), //coming from sw domain pin mux (io cell)
  .scan_rst_n(scan_rst_n),
  .poresetn_hf(poresetn_hf), //from switchable digital POR time out
  .spi_write(spi_write), //from spi
  //	.o_dc_clk_div_spi(dc_clk_div_spi), //output [2:0] dc_clk_div_spi

  //	.D2A_CPCLK(D2A_CPCLK), //input [2:0] dc_clk_div_always_on

  // with PMU
  //.por_resetn(por_resetn),
  .A2D_SW_POWER_POR(A2D_SW_POWER_POR),

  /*
  .imeas_cal_en(imeas_cal_en),
  .imeas_pga_gain(imeas_pga_gain),
  .imeas_sd16off(imeas_sd16off),
  .imeas_sd16slp(imeas_sd16slp),
  .imeas_gubias_en(imeas_gubias_en),
  .imeas_rebias_dac(imeas_rebias_dac),
  .imeas_webias_dac(imeas_webias_dac),
  */

  // with zmeas
  .D2A_SW_Z_TX_GSEL	(D2A_SW_Z_TX_GSEL),
  .D2A_SW_Z_CALMD		(D2A_SW_Z_CALMD),
  .D2A_SW_Z_CLK256K	(D2A_SW_Z_CLK256K),
  .D2A_SW_Z_DDS		(D2A_SW_Z_DDS),
  .D2A_SW_Z_RXGAIN	(D2A_SW_Z_RXGAIN),
  .D2A_Z_EN		(Z_EN),
  //.D2A_SW_Z_ADC_EN	(D2A_SW_Z_ADC_EN),
  //.D2A_SW_Z_ADC_SAMPLE	(D2A_SW_Z_ADC_SAMPLE),
/*
  .A2D_SW_Z_ADC_D		(A2D_SW_Z_ADC_D),
  .A2D_SW_Z_ADC_EOC	(A2D_SW_Z_ADC_EOC),
*/
//.A2D_SW_Z_ADC_D		(10'b0),
//.A2D_SW_Z_ADC_EOC	(1'b0),

  .A2D_SPARE_0 (A2D_SPARE_0),

  .A2D_LOFF_STATN   (A2D_LOFF_STATN),
  .A2D_LOFF_STATP   (A2D_LOFF_STATP),
  .A2D_ACLEADOFF_STATN (A2D_ACLEADOFF_STATN), 
  .A2D_ACLEADOFF_STATP (A2D_ACLEADOFF_STATP), 

  /*
  .D2A_Z_SEL1V5(D2A_Z_SEL1V5),  //1:0, config_output_voltage_range[1:0]
  //2:measure_calibrate
  //3. pga_gain
  .D2A_Z_ADC_EN(D2A_Z_ADC_EN),   //from SPI, then select 2 source, then output to ana
  //.Z_DAC_EN(Z_DAC_EN),   //from SPI, directly go to ana
  .D2A_Z_SYS_CLK(D2A_Z_SYS_CLK),  //adc_clk
  .D2A_Z_DDS(D2A_Z_DDS),  //rom
  .D2A_Z_ADC_SAMPLE(D2A_Z_ADC_SAMPLE),
  .A2D_Z_ADC_D(A2D_Z_ADC_D),
  .A2D_Z_ADC_EOC(A2D_Z_ADC_EOC),
  */
  //.zmeas_adc_din(zmeas_adc_din),
  //.zmeas_adc_eoc(zmeas_adc_eoc),
  //.zmeas_adc_sample(zmeas_adc_sample),
  /*
  .zmeas_adc_clk(zmeas_adc_clk),
  .zmeas_adc_enable(zmeas_adc_enable),
  .zmeas_meas_cal(zmeas_meas_cal),
  .zmeas_vol_range(zmeas_vol_range),
  .zmeas_pga_gain(zmeas_pga_gain),
  .zmeas_power_en(zmeas_power_en),
  .zmeas_rom_data(zmeas_rom_data),
  */
  //io_buf_config
  .o_baf4p1_IOBUF_IE    (IOBUF_IE),
  .o_baf4p1_IOBUF_CS    (IOBUF_CS),
  .o_baf4p1_IOBUF_PU    (IOBUF_PU),
  .o_baf4p1_IOBUF_SR    (IOBUF_SR),
  .o_baf4p1_IOBUF_DR    (IOBUF_DR),
  .o_baf4p1_IOBUF_A     (IOBUF_A),
  .o_baf4p1_IOBUF_OE    (IOBUF_OE),
  .o_baf4p1_IOBUF_OS    (IOBUF_OS),
  .o_baf4p1_IOBUF_OD    (IOBUF_OD),
  .o_baf4p1_IOBUF_PD    (IOBUF_PD),
  .i_baf4p1_IOBUF_Y     (IOBUF_Y),
  .o_IO_testmode0_PD  (IO_testmode0_PD),
  .o_IO_testmode1_PD  (IO_testmode1_PD),
  .o_IO_exresetn_PU   (IO_exresetn_PU),
  .iopad_testmode0_en_y(iopad_testmode0_en_y),
  .iopad_testmode1_en_y(iopad_testmode1_en_y),
  .iopad_resetn_y(iopad_resetn_y),
  //trim
  .FLASH_Reset_Done(flash_reset_done),
  .flash_to_ana_trim1     (flash_to_ana_trim1),  
  .flash_to_ana_trim2     (flash_to_ana_trim2),
  .flash_to_ana_trim3     (flash_to_ana_trim3),
  .flash_to_ana_trim4     (flash_to_ana_trim4),
  .flash_to_ana_trim5     (flash_to_ana_trim5),
  .flash_to_ana_trim6     (flash_to_ana_trim6),
  .flash_to_ana_trim7     (flash_to_ana_trim7),
  .flash_to_ana_trim8     (flash_to_ana_trim8),
  .flash_to_ana_trim9     (flash_to_ana_trim9),
  .flash_to_ana_trim10    (flash_to_ana_trim10),
  .d2a_SW_spare0_from_flash (d2a_SW_spare0_from_flash),
  .d2a_SW_spare1_from_flash (d2a_SW_spare1_from_flash),
  .d2a_AO_spare0_from_flash (d2a_AO_spare0_from_flash), 
  .d2a_AO_spare1_from_flash (d2a_AO_spare1_from_flash), 
  .d2a_AO_spare2_from_flash (d2a_AO_spare2_from_flash), 
  .d2a_AO_spare3_from_flash (d2a_AO_spare3_from_flash),
  
  .VREF0P8          (VREF0P8),

  // power ground 
  //.vdd_switchable(VDD_DIG), //switchable digital
  .vpp_flash(VPP), //vpp for flash
  //.vssi(VSS_DIG_SW),
  //analog register outputs
  //ana_pmu
  .o_BG1P2_BUF_EN(BG1P2_BUF_EN),
  //	.o_DAC_BUF_EN(DAC_BUF_EN),

  .VCM1P5_BUF_EN(VCM1P5_BUF_EN),     
  .RLD_AMP_EN(RLD_AMP_EN),        
  //ECG
  .ECG_PGA_EN       (ECG_PGA_EN),        
  .ECG_LPF_EN       (ECG_LPF_EN),         
  .ECG_PGA_GSEL     (ECG_PGA_GSEL),      
  .ECG_DDA_CLKSEL   (ECG_DDA_CLKSEL),    
  .ECG_DDA_EN       (ECG_DDA_EN),        
  .ECG_DDA_GSEL     (ECG_DDA_GSEL),      
  .ECG_DDACHOP_EN   (ECG_DDACHOP_EN),     
  .ECG_DDA_ISEL     (ECG_DDA_ISEL), 
  .ECG_ELECTRODE_EN (ECG_ELECTRODE_EN),
  .ECGCAL_EN        (ECGCAL_EN),
  .RLD_CHOP_EN      (RLD_CHOP_EN),
  .ECGCAL_VSEL      (ECGCAL_VSEL_TRIM),

  //PPG
  .D2A_TIA_IDAC              (TIA_IDAC),    
  .D2A_LEDDAC_SEL            (LEDDAC_SEL),      
  .D2A_LEDSEL                (LEDSEL),           
  .D2A_LED_STANDBYEN         (LED_STANDBYEN),  
  .D2A_LED_EN                (LED_EN),         
  .D2A_EN_PPG_AF             (EN_PPG_AF),       
  .D2A_PPG_SH_CK             (PPG_SH_CK),        
  .D2A_EN_PPG_SH             (EN_PPG_SH),       
  .D2A_EN_TIA                (EN_TIA),       
  .D2A_EN_TIA_VREFBUFFER     (EN_TIA_VREFBUFFER),    
  .D2A_TIA_GAIN              (TIA_GAIN),
  .D2A_EN_PPG_BUFFER         (EN_PPG_BUFFER),
  .D2A_EN_PPGDAC_BUFFER      (EN_PPGDAC_BUFFER),   
  .D2A_PPG_DAC0_VSEL         (PPGDAC0_VSEL),
  .D2A_PPG_DAC0_EN           (PPGDAC0_EN),
  .D2A_PPG_DAC1_VSEL         (PPGDAC1_VSEL),
  .D2A_PPG_DAC1_EN           (PPGDAC1_EN),
  .D2A_PPG_TEST_OUT          (PPG_TEST_OUT),
  .D2A_PPG_TEST_IN           (PPG_TEST_IN),
  .D2A_PPG_PDV_REF_SEL       (PDVREF_SEL),

  //DC_LEAD_OFF
  .DC_LEAD_OFF_RMODE_EN(DC_LEAD_OFF_RMODE_EN),      
  .DC_LEAD_OFF_VIN_FLIP(DC_LEAD_OFF_VIN_FLIP),   
  .DC_LEAD_OFF_EN(DC_LEAD_OFF_EN),  
  
  //ACLEADOFF
  .ACLEADOFF_EN(ACLEADOFF_EN),

  //ana_tsc
  .D2A_TSC_EN(TSC_EN),
  //	.D2A_TSC_AMP_EN(TSC_AMP_EN),
  .D2A_TSC_BJT_SEL(TSC_BJT_SEL),
  .D2A_TSC_INA_GSEL(TSC_INA_GSEL),
  .D2A_TSC_OUT_SEL(TSC_OUT_SEL),
  .D2A_TSC_INA_EN(TSC_INA_EN),
 
  //Peripheral
  .o_BIST_EN(BIST_EN),
  .o_BIST_ISEL(BIST_ISEL),
  //.o_DDA_EN(DDA_EN),
  //.o_DDA_GSEL(DDA_GSEL),

  //	.D2A_PGA_EN(D2A_PGA_EN),
  //	.D2A_PGA_VIN_SEL(D2A_PGA_VIN_SEL),
  //	.D2A_PGA_GSEL(D2A_PGA_GSEL),
  //	.o_ELE_BUF_EN(ELE_BUF_EN),
  //	.o_ELE_BUF_ISEL(ELE_BUF_ISEL),
  //	//.o_R2R_DAC1_EN(R2R_DAC1_EN),
  //.o_R2R_DAC1_DIN(R2R_DAC1_DIN),
  //.o_R2R_DAC2_EN(R2R_DAC2_EN),
  //.o_R2R_DAC2_DIN(R2R_DAC2_DIN),
  // with imeas
  .A2D_SDM_OUT(A2D_SDM_OUT),
  //.imeas_adc_clk(imeas_adc_clk),
  .D2A_SDM_VIN_SEL(SDM_VIN_SEL),
  .D2A_SDM_EN(SDM_EN),
  //.D2A_SDM_CHOP_EN(), 
  .D2A_SDM_CLK(SDM_CLK),
  .D2A_SDM_BIAS(SDM_BIAS),

  .D2A_ATM0   (ATM0),
  .D2A_ATM1   (ATM1),
  .D2A_ATM2   (ATM2),
  .D2A_ATM3   (ATM3),
  .D2A_ATM4   (ATM4),
  .D2A_ATM5   (ATM5),
  .D2A_ATM6   (ATM6),
  .D2A_ATM7   (ATM7),
  .D2A_ATM8   (ATM8),
  .D2A_ATM9   (ATM9),
  .D2A_ATM10  (ATM10),
  .D2A_ATM11  (ATM11),
  .D2A_ATM12  (ATM12),

  //analog reg values from always on

  //.D2A_BG_BUF_EN(D2A_BG_BUF_EN),
  //.D2A_DAC_BUF_EN(D2A_DAC_BUF_EN), 

  //.D2A_BIST_EN(D2A_BIST_EN),
  //.D2A_BIST_ISEL(D2A_BIST_ISEL),
  //	.D2A_DDA_EN(D2A_DDA_EN),
  //	.D2A_DDA_GSEL(D2A_DDA_GSEL),
  //	.D2A_ELE_BUF_EN(D2A_ELE_BUF_EN),
  //	.D2A_ELE_BUF_SEL(D2A_ELE_BUF_SEL),

  /*  .r2r_dac1_en_always_on(r2r_dac1_en_always_on),
  .r2r_dac1_din_always_on(r2r_dac1_din_always_on),
  .r2r_dac2_en_always_on(r2r_dac2_en_always_on),
  .r2r_dac2_din_always_on(r2r_dac2_din_always_on) */

  .trim1_always_on(trim1_always_on),
  .trim2_always_on(trim2_always_on),
  .trim3_always_on(trim3_always_on),
  .trim4_always_on(trim4_always_on), 
  .trim5_always_on(trim5_always_on), 
  .trim6_always_on(trim6_always_on), 
  .trim7_always_on(trim7_always_on), 
  .trim8_always_on(trim8_always_on), 
  .trim9_always_on(trim9_always_on), 
  .trim10_always_on(trim10_always_on)

); 

`ifdef FPGA
`else
//added by supriya
//    ******Other pads******
//Cutcell: Power break cell
/* remove cut by xin because cut in analog side
RCMCU_PLPWBK u_iopad_cutcell0(
	.POC		(POC)			//come from analog model
);
*/

//DVSS 
//to SW_POWER
RCMCU_PLVDDI u_iopad_plvddi0(
	.vddi		(VDD_DIG_AFSW),	 	//this is for backup solution connect to sw_power				
	.POC		(POC),			//come from analog model
	.vssi		(VSS_DIG_SW)				//for switchable domain
);

//new add 31Oct by Xin
RCMCU_PLVDDI u_iopad_plvddi1(
	.vddi		(VDD_DIG_SW),	 	//this is for backup solution connect to sw_power				
	.POC		(POC),			//come from analog model
	.vssi		(VSS_DIG_SW)				//for switchable domain
);

//VDDIO: high V of the I/O
RCMCU_PLVDDH u_iopad_plvddh(
	.vddh		(VDDIO),		
	.POC		(POC)				//come from analog model
);

//VSSIO:High GND of the I/O
RCMCU_PLVSSH u_iopad_plvssh_0(
	.vssh		(VSSIO),  			//this is for IO Ring Power
	.POC		(POC)			//come from analog model
);

RCMCU_PLVSSH u_iopad_plvssh_1(
	.vssh		(VSSIO),  			//this is for IO Ring Power
	.POC		(POC)			//come from analog model
);

RCMCU_PLVSS u_iopad_plvss(
	.gnd		(VSS_DIG_AO),
	.POC		(POC)
);


/*
RCMCU_PLVSS u_iopad_plvss_sw_0(
	.gnd		(VSS_DIG_SW),
	.POC		(POC)
);

RCMCU_PLVSS u_iopad_plvss_sw_1(
	.gnd		(VSS_DIG_SW),
	.POC		(POC)
);
*/

//??? xin
/*
RCMCU_PLVDDI u_iopad_plvddi1(
	.vddi		(vddi),				//This is for digital always on domain, come from PAD, TODO: pending to be connected to analog top			
	.POC		(POC),			//come from analog model
	.vssi		(vssi)				//TODO: Pending to be connected to analog top
);
*/

//DVDD15:to always on digital 1.5V ?
RCMCU_PLVDD u_iopad_plvdd(
	.vdd		(VDD_DIG_AO),  				//Not for internal use(For low voltage1.5 for IO Ring)
	.POC		(POC)			//come from analog model
);

//AVDD15: to always on analog 1.5V
//AVSS:to always on analog GND 
RCMCU_PLVDDHIS u_iopad_plvddhi(
	.vddhis		(DVDD_1P5_ANA),			//TODO: Pending to be connected to analog top
//	.vsshis		(DVSS_1P5_ANA),   	 		//TODO: Pending to be connected to analog top
	.POC		(POC)			//come from analog model
);

//for Flash 0.8V voltage in_out
RCMCU_PLAR u_iopad_plar(
        .P(flash_ref),					//goes to top pinlist
        .POC(POC),
        .YA(VREF0P8)				//goes to flash
);

RCMCU_PLBMUX u_iopad_gpio[18:0] (
  .Y              (IOBUF_Y_always_on),   
  .P              (IOBUF_PAD[18:0]),
  .YA             (IOBUF_YA[18:0]), 
  .A              (IOBUF_A_always_on),
  .IE		(IOBUF_IE_always_on),
  .OS             (IOBUF_OS_always_on),
  .PD             (IOBUF_PD_always_on),
  .OD             (IOBUF_OD_always_on),
  .PU             (IOBUF_PU_always_on),
  .CS             (IOBUF_CS_always_on),
  .OE		(IOBUF_OE_always_on),
  .DR		(IOBUF_DR_always_on),
  .SR		(IOBUF_SR_always_on),
  .POC		(POC)			//IOBUF_POC,come from analog model	
);

//External resetn
RCMCU_PLBMUX u_iopad_exresetn(
  .Y              (iopad_resetn_y_always_on),  	 
  .P              (iopad_resetn),		
  .YA             (), 
  .A              (1'b0),
  .IE		(IOBUF_IE_resetn_always_on),
  .OS             (1'b0),
  .PD             (IOBUF_PD_resetn_always_on),
  .OD             (1'b0),
  .PU             (IOBUF_PU_resetn_always_on),
  .CS             (1'b0),					//Done
  .OE		(1'b0),
  .DR		(1'b0),
  .SR		(1'b1),
  .POC		(POC)				//come from analog model
);

//testmode0
RCMCU_PLBMUX u_iopad_testmode0 (
  .Y              (iopad_testmode0_en_y_always_on),  	
  .P              (iopad_testmode0),		
  .YA             (), 
  .A              (1'b0),
  .IE		(IOBUF_IE_testmode0_always_on),
  .OS             (1'b0),
  .PD             (IOBUF_PD_testmode0_always_on),
  .OD             (1'b0),
  .PU             (IOBUF_PU_testmode0_always_on),
  .CS             (1'b0),					//Done
  .OE		(1'b0),
  .DR		(1'b0),
  .SR		(1'b1),
  .POC		(POC)				//come from analog model
);

//testmode1
RCMCU_PLBMUX u_iopad_testmode1 (
  .Y              (iopad_testmode1_en_y_always_on),  	 
  .P              (iopad_testmode1),		
  .YA             (), 
  .A              (1'b0),
  .IE		(IOBUF_IE_testmode1_always_on),
  .OS             (1'b0),
  .PD             (IOBUF_PD_testmode1_always_on),
  .OD             (1'b0),
  .PU             (IOBUF_PU_testmode1_always_on),
  .CS             (1'b0),				//Done
  .OE		(1'b0),
  .DR		(1'b0),
  .SR		(1'b1),
  .POC		(POC)				//come from analog model
);



//VPP:For Flash test
RCMCU_PLVPP u_iopad_plvpp(
	.VPP		(VPP),				//HIGH Voltage for Flash testing
	.TM0		(),			
	.POC		(POC)
);

/* remove cut by xin because cut in analog side
//cut cell
RCMCU_PLPWBK u_iopad_cutcell1(
	.POC		(POC)				//come from analog model	
);
*/
`endif
  

BAF4P1_ANA_CHIP u_top_ana( 
  `ifdef FPGA
  .clk_in1(clk_in1),	
  `endif
  .A2D_external_en_I(A2D_external_en_I), //V from analog IO cells
  .A2D_external_clock_I(A2D_external_clock_I), //V external clock from analog IO cells
  .A2D_external_RESET(A2D_external_RESET),  //V

  .A2D_OSC_OUT(A2D_OSC_OUT),   //V 
  .POC(POC),    //V not pad, wire connect to poc of PAD //
  .A2D_VDDI_POR(A2D_VDDI_POR),  //V
  .A2D_SW_POWER_POR(A2D_SW_POWER_POR),    //V

  //.A2D_SW_Z_ADC_D(A2D_Z_ADC_D), //
  //.A2D_SW_Z_ADC_EOC(A2D_Z_ADC_EOC),  //
  //.D2A_SW_Z_DDS(D2A_Z_DDS),   //
  //.D2A_SW_Z_ADC_EN(D2A_Z_ADC_EN), // 
  //.D2A_SW_Z_ADC_SAMPLE(D2A_Z_ADC_SAMPLE),// 
  //.D2A_SW_Z_SEL1V5(D2A_Z_SEL1V5),  // 
  //.D2A_SW_Z_SYS_CLK(D2A_Z_SYS_CLK),

  .D2A_SW_Z_TX_GSEL	(D2A_SW_Z_TX_GSEL),//V
  .D2A_SW_Z_CALMD		(D2A_SW_Z_CALMD), //V
  .D2A_SW_Z_CLK256K	(D2A_SW_Z_CLK256K), //V
  .D2A_SW_Z_DDS		(D2A_SW_Z_DDS),//V
  .D2A_SW_Z_RXGAIN	(D2A_SW_Z_RXGAIN), //V
  .D2A_Z_EN		(D2A_Z_EN), //V
/*
  .D2A_SW_Z_ADC_EN	(D2A_SW_Z_ADC_EN), //V
  .D2A_SW_Z_ADC_SAMPLE	(D2A_SW_Z_ADC_SAMPLE), //V
  .A2D_SW_Z_ADC_D		(A2D_SW_Z_ADC_D), //V
  .A2D_SW_Z_ADC_EOC	(A2D_SW_Z_ADC_EOC),  //V
*/
  .A2D_LOFF_STATN(A2D_LOFF_STATN),   //V
  .A2D_LOFF_STATP(A2D_LOFF_STATP),   //V
  .A2D_ACLEADOFF_STATN (A2D_ACLEADOFF_STATN), 
  .A2D_ACLEADOFF_STATP (A2D_ACLEADOFF_STATP), 
  .D2A_BG1P2_BUF_EN(D2A_BG1P2_BUF_EN), //V
  .D2A_VCM1P5_BUF_EN(D2A_VCM1P5_BUF_EN), //V

  .VREF0P8(VREF0P8),  //V

  .A2D_Wake_UP_i(A2D_Wake_UP_i), //V

  .D2A_BGH_VTRIM(trim1_always_on),  //V
  .D2A_BGH_CTRIM(trim2_always_on),  //V
  .D2A_OSC_ISEL_TRIM(trim5_always_on),
  //.D2A_BG_BUF_EN(D2A_BG_BUF_EN), //
  .D2A_BIST_EN(D2A_BIST_EN),//V
  .D2A_BIST_ISEL(D2A_BIST_ISEL),//V 
  //.D2A_LEADOFF_EN(D2A_DC_LEAD_OFF_EN),//V 
  .D2A_DCLEADOFF_EN(D2A_DC_LEAD_OFF_EN),//V 
  .D2A_ACLEADOFF_EN(D2A_AC_LEAD_OFF_EN),//V 

  .D2A_ACLEADOFF_CLK(D2A_ACLEADOFF_CLK),// 
  .D2A_DCLEADOFF_RMODE_EN(D2A_DC_LEAD_OFF_RMODE_EN),//V 
  .D2A_DCLEADOFF_VINFLIP(D2A_DC_LEAD_OFF_VIN_FLIP),//V 
  .D2A_DCLEADOFF_ISEL_TRIM(trim7_always_on), //V 
  .D2A_DCLEADOFF_COMP_TH_TRIM(trim6_always_on),//V 

  .D2A_ACLEADOFF_ISEL_TRIM(trim10_always_on),
  .D2A_ACLEADOFF_VTHNSEL_TRIM(trim8_always_on),
  .D2A_ACLEADOFF_VTHPSEL_TRIM(trim9_always_on),
  .D2A_2ELECTRODE_EN(D2A_2ELECTRODE_EN),
  .D2A_ECGCAL_EN(D2A_ECGCAL_EN),
  .D2A_ECGCAL_VSEL_TRIM(D2A_ECGCAL_VSEL_TRIM), //D2A_SW_Z_DDS),
  //.D2A_ECGCAL_VSEL_TRIM(), //D2A_SW_Z_DDS),

  .D2A_ECG_DDACHOP_EN(D2A_ECG_DDACHOP_EN),   //V
  .D2A_ECG_DDA_EN(D2A_ECG_DDA_EN),   //V
  .D2A_ECG_LPF_EN(D2A_ECG_LPF_EN),   //V
  .D2A_ECG_PGA_EN(D2A_ECG_PGA_EN),//V 
  .D2A_ECG_DDA_GSEL(D2A_ECG_DDA_GSEL),   //V
  .D2A_ECG_DDA_ISEL(D2A_ECG_DDA_ISEL),   //V
  .D2A_ECG_DDA_CLKSEL(D2A_ECG_DDA_CLKSEL),   //V
  .D2A_ECG_PGA_GSEL(D2A_ECG_PGA_GSEL),//V 

  .D2A_EN_PPGDAC_BUFFER(D2A_EN_PPGDAC_BUFFER),//V
  .D2A_EN_PPG_AF       (D2A_EN_PPG_AF),//V
  .D2A_EN_PPG_BUFFER   (D2A_EN_PPG_BUFFER),//V
  .D2A_EN_PPG_SH       (D2A_EN_PPG_SH),//V
  .D2A_PPGDAC0_EN      (D2A_PPGDAC0_EN),//V
  .D2A_PPGDAC1_EN      (D2A_PPGDAC1_EN),//V
  .D2A_PPG_SH_CK       (D2A_PPG_SH_CK),//V
  .D2A_PPG_TEST_OUT    (D2A_PPG_TEST_OUT),//V
  .D2A_PPG_TEST_IN     (D2A_PPG_TEST_IN),//V
  .D2A_PPGDAC0_VSEL    (D2A_PPGDAC0_VSEL),//V
  .D2A_PPGDAC1_VSEL    (D2A_PPGDAC1_VSEL),//V

  //.D2A_RLD_AMP_EN(D2A_RLD_AMP_EN),//V 
  .D2A_RLD_EN(D2A_RLD_AMP_EN),//V 

  .D2A_RLD_CHOP_EN(D2A_RLD_CHOP_EN),
  .D2A_RLD_CLK64K(D2A_RLD_CLK64K),


  .D2A_PDVREF_SEL(D2A_PDVREF_SEL),   //V

  .D2A_EN_TIA(D2A_EN_TIA),//V 
  .D2A_EN_TIA_VREFBUFFER(D2A_EN_TIA_VREFBUFFER),//V 
  .D2A_TIA_IDAC(D2A_TIA_IDAC),//V 
  .D2A_TIA_GAIN(D2A_TIA_GAIN),//V 

  .D2A_LEDSEL(D2A_LEDSEL),//V 
  .D2A_LEDDAC_SEL(D2A_LEDDAC_SEL),//V 
  .D2A_LED_EN(D2A_LED_EN),//V 
  .D2A_LED_STANDBYEN(D2A_LED_STANDBYEN),//V 

  .D2A_LDO1V5_VTRIM(trim3_always_on), //V
  .D2A_OSC_TRIM(trim4_always_on),  //V
  
  .D2A_SPARE_TRIM0(trim11_always_on),
  .D2A_SPARE_TRIM1(trim12_always_on),
  .D2A_SPARE_TRIM2(trim13_always_on),
  .D2A_SPARE_TRIM3(trim14_always_on),
  .D2A_SPARE_TRIM_SW0(d2a_SW_spare0_from_flash),
  .D2A_SPARE_TRIM_SW1(d2a_SW_spare1_from_flash),
  .A2D_SPARE_TRIM_SW0(A2D_SPARE_0),

  .A2D_SDM_OUT(A2D_SDM_OUT),  //V
  .D2A_SDM_CLK(D2A_SDM_CLK),   //V
  .D2A_SDM_EN(D2A_SDM_EN),    //V
  .D2A_SDM_VIN_SEL(D2A_SDM_VIN_SEL),  //V
  .D2A_SDM_BIAS(D2A_SDM_BIAS),   //V

  .D2A_TSC_OUT_SEL(D2A_TSC_OUT_SEL),   //V
  .D2A_TSC_BJT_SEL(D2A_TSC_BJT_SEL),//V
  .D2A_TSC_EN(D2A_TSC_EN),   // //V
  .D2A_TSC_INA_GSEL(D2A_TSC_INA_GSEL),   // //V
  .D2A_TSC_INA_EN(D2A_TSC_INA_EN),

//Neil requirement
   .VSS1(VSS_DIG_AO),
   .VSS2(VSS_DIG_AO),

  .VDDIO(VDDIO),   //V
  .VSSIO1(VSSIO),   //V
  .VSSIO2(VSSIO),   //V
  .VDD_DIG_SW(VDD_DIG_SW),   //V
  .DVDD1P5_ANA(DVDD_1P5_ANA),   //V
  .VDD_DIG_AO(VDD_DIG_AO),   //V
  .VSS_DIG_AO(VSS_DIG_AO),   //V
  //.VSS_DIG_SW(VSS_DIG_SW),   //V
  .VDD_DIG_AFSW(VDD_DIG_AFSW),   //V
  .VDD_DIG_ZMEASURE(VDD_DIG_SW),   //V

/*
  .Z_RFB(IOBUF_YA[10]),  //V 
  .Z_VIN(IOBUF_YA[9]),  //V 
  .Z_VIN_CAL(IOBUF_YA[7]),  //V
  .Z_VIN_MEAS(IOBUF_YA[8]),   //V
  .Z_VOUT(IOBUF_YA[6]),   //V
*/

  .D2A_ATM0(D2A_ATM0),   //V
  .D2A_ATM1(D2A_ATM1),   //V
  .D2A_ATM2(D2A_ATM2),   //V
  .D2A_ATM3(D2A_ATM3),   //V
  .D2A_ATM4(D2A_ATM4),   //V
  .D2A_ATM5(D2A_ATM5),   //V
  .D2A_ATM6(D2A_ATM6),  //V
  .D2A_ATM7(D2A_ATM7),   //V
  .D2A_ATM8(D2A_ATM8), //V
  .D2A_ATM9(D2A_ATM9), //V
  .D2A_ATM10(D2A_ATM10), //V
  .D2A_ATM11(D2A_ATM11), //V
  .D2A_ATM12(D2A_ATM12)

 );  //

endmodule
