//------------------------------------------------------------------------------
// Nanochap Pty Ltd (c) 2021
//
// Module Name : baf4p1_dig_top
// Description : Top level block containing BAF4P1 digital sub-blocks 
//------------------------------------------------------------------------------
// Revision History
//------------------------------------------------------------------------------
// Revision     Date        Author
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------

`timescale 1 ns /  1ps

// FIFO SIZE
`define FIFO_SIZE 128
`define FIFO_ADDR (`FIFO_SIZE/16 - 1)

module top_dig( 
	// with OSC
	//input  wire         hfosc,                      // osc base clock input
	input  wire         AO2D_DC_LEAD_OFF_EN,//V 
        input  wire         AO2D_AC_LEAD_OFF_EN,
	input  wire         A2D_OSC_OUT,                      // osc base clock input
	//input  wire         ext_clk_sel, //from analog IO cells
	//input  wire         ext_hfclk, //external clock from analog IO cells
	input  wire         A2D_external_en_I, //from analog IO cells
	input  wire         A2D_external_clock_I, //external clock from analog IO cells

	input  wire         atpg_en,
	input  wire         scan_en,   //Tri add
	// with PMU
	//input  wire         por_resetn,                 // power on reset, low active
	input  wire         A2D_SW_POWER_POR,                 // power on reset, low active
	// To/From always on
	output wire         scan_clk,
	output wire	    scan_rst_n,
	output wire         atpg_en_sw,
	output wire         scan_en_sw,  //Tri add
	output wire         poresetn_hf, //from switchable digital POR time out //global reset after sync by hfclk
	output wire         spi_write, //from spi
//	output wire  [2:0]  o_dc_clk_div_spi, 
	//input wire  [2:0]   dc_clk_div_always_on, 
//	input wire  [2:0]   D2A_CPCLK, 
	//io_buf_config
	output wire [18:0]                    o_baf4p1_IOBUF_IE,
	output wire [18:0]                    o_baf4p1_IOBUF_CS,
	output wire [18:0]                    o_baf4p1_IOBUF_PU,
	output wire [18:0]                    o_baf4p1_IOBUF_SR,
	output wire [18:0]                    o_baf4p1_IOBUF_DR,
	output wire [18:0]                    o_baf4p1_IOBUF_A,
	output wire [18:0]                    o_baf4p1_IOBUF_OE,
	output wire [18:0]                    o_baf4p1_IOBUF_OS,
	output wire [18:0]                    o_baf4p1_IOBUF_OD,
	output wire [18:0]                    o_baf4p1_IOBUF_PD,
	input  wire [18:0]                    i_baf4p1_IOBUF_Y,	
	output wire                           o_IO_testmode0_PD, 
	output wire                           o_IO_testmode1_PD,
	output wire                           o_IO_exresetn_PU,

	input  wire      		                  iopad_testmode0_en_y,
	input  wire 			                    iopad_testmode1_en_y,
	input  wire 			                    iopad_resetn_y,

   	//input  wire    A2D_LOFF_STATN,
   	//input  wire    A2D_LOFF_STATP,
	output wire 	D2A_ACLEADOFF_CLK,
	output wire 	D2A_RLD_CLK64K,

	// with zmeas
	//input  wire [9 :0]  zmeas_adc_din,              // zmeas: SARADC 10b data
	//input  wire         zmeas_adc_eoc,              // zmeas: end of conversion signal from SARADC
	/*
	input  wire [9 :0]  A2D_Z_ADC_D,              // zmeas: SARADC 10b data
	input  wire         A2D_Z_ADC_EOC,              // zmeas: end of conversion signal from SARADC
	*/
	//output wire         zmeas_adc_sample,           // zmeas: sample signal to SARADC
	//trim
	output wire       FLASH_Reset_Done,
	output wire [7:0] flash_to_ana_trim1,  
	output wire [7:0] flash_to_ana_trim2,   
	output wire [7:0] flash_to_ana_trim3,
	output wire [7:0] flash_to_ana_trim4,
	output wire [7:0] flash_to_ana_trim5,
	output wire [7:0] flash_to_ana_trim6,
	output wire [7:0] flash_to_ana_trim7,
	output wire [7:0] flash_to_ana_trim8,
  output wire [7:0] flash_to_ana_trim9,
  output wire [7:0] flash_to_ana_trim10,
	output wire [7:0] d2a_SW_spare0_from_flash,
	output wire [7:0] d2a_SW_spare1_from_flash,
	output wire [7:0] d2a_AO_spare0_from_flash,
	output wire [7:0] d2a_AO_spare1_from_flash,
	output wire [7:0] d2a_AO_spare2_from_flash,
	output wire [7:0] d2a_AO_spare3_from_flash,
        
       

	//input   wire       CHIP_FLASH_VREF,
	input   wire       VREF0P8,
	// power ground
	//inout  wire	    vdd_switchable, //switchable digital power
	inout  wire	    vpp_flash, //vpp for flash
	//inout  wire	    vssi,

	//analog register outputs
	//ana_pmu
	output wire       o_BG1P2_BUF_EN,
//	output wire       o_DAC_BUF_EN,

	output wire VCM1P5_BUF_EN,     
	output wire RLD_AMP_EN,        
	//ECG
	output wire ECG_PGA_EN,        
	output wire ECG_LPF_EN,         
	output wire [2:0] ECG_PGA_GSEL,      
	output wire [1:0] ECG_DDA_CLKSEL,    
	output wire ECG_DDA_EN,        
	output wire [2:0] ECG_DDA_GSEL,      
	output wire ECG_DDACHOP_EN,     
	output wire [1:0] ECG_DDA_ISEL,  
  output wire [9:0] ECGCAL_VSEL,
  output wire       ECGCAL_EN,
  output wire       ECG_ELECTRODE_EN,
  output wire       RLD_CHOP_EN,

  //PPG
  output wire  [7:0] D2A_TIA_IDAC,        
  output wire	       D2A_LEDDAC_SEL,       
  output wire  [1:0] D2A_LEDSEL,           
  output wire	       D2A_LED_STANDBYEN,    
  output wire	       D2A_LED_EN,           
  output wire	       D2A_EN_PPG_AF,        
  output wire	       D2A_PPG_SH_CK,        
  output wire	       D2A_EN_PPG_SH,        
  output wire	       D2A_EN_TIA ,          
  output wire	       D2A_EN_TIA_VREFBUFFER,        	                                    
  output wire  [3:0] D2A_TIA_GAIN,
  output wire        D2A_EN_PPG_BUFFER,
  output wire        D2A_EN_PPGDAC_BUFFER,     
  output wire [11:0] D2A_PPG_DAC0_VSEL,
  output wire        D2A_PPG_DAC0_EN,
  output wire [11:0] D2A_PPG_DAC1_VSEL,
  output wire        D2A_PPG_DAC1_EN,
  output wire  [1:0] D2A_PPG_TEST_OUT,
  output wire  [1:0] D2A_PPG_TEST_IN,
  output wire  [1:0] D2A_PPG_PDV_REF_SEL,

  //DC_LEAD_OFF
  output wire DC_LEAD_OFF_RMODE_EN,      

  output wire DC_LEAD_OFF_VIN_FLIP,    
  output wire DC_LEAD_OFF_EN,

  //ACLEADOFF
  output wire       ACLEADOFF_EN,

  //ana_tsc
  output wire       D2A_TSC_EN,
  //	output wire       D2A_TSC_AMP_EN,
  output wire [2:0] D2A_TSC_BJT_SEL,
  output wire [2:0] D2A_TSC_INA_GSEL,
  output wire       D2A_TSC_OUT_SEL,
  output wire       D2A_TSC_INA_EN,

  //Peripheral
  output wire       o_BIST_EN,
  output wire [2:0] o_BIST_ISEL,
  //output wire       o_DDA_EN,
  //	output wire [2:0] o_DDA_GSEL,
  //	output wire       D2A_PGA_EN,
  //	output wire [2:0] D2A_PGA_VIN_SEL,
  //	output wire [1:0] D2A_PGA_GSEL,
  //	output wire       o_ELE_BUF_EN,
  //	output wire [2:0] o_ELE_BUF_ISEL,
  //output wire       o_R2R_DAC1_EN,
  //output wire [11:0]o_R2R_DAC1_DIN,
  //output wire       o_R2R_DAC2_EN,
  //output wire [11:0]o_R2R_DAC2_DIN,
  // with imeas
  /*
  input  wire         imeas_adc_din,              // imeas: ADC serial data input
  output wire [2:0]     o_SDM_VIN_SEL,
  output wire       o_SDM_EN,
  output wire       o_SDM_CHOP_EN, 
  output wire        SDM_CLK,
  */
  input 	     A2D_SDM_OUT  ,
  output [2:0] D2A_SDM_VIN_SEL,
  output 	     D2A_SDM_EN,    //V
  //output       D2A_SDM_CHOP_EN,  //V
  output 	     D2A_SDM_CLK,   //V
  output [1:0] D2A_SDM_BIAS,
  //xin add 2/oct/2022
  //for zmeas analog
  /*
  output wire [3:0]  Z_SEL1V5,  //1:0, config_output_voltage_range[1:0]
  //2:measure_calibrate
  //3. pga_gain
  output wire        o_Z_ADC_EN,   //from SPI, then select 2 source, then output to ana
  output wire        Z_SYS_CLK,  //adc_clk
  output wire [9:0]  DDS,  //rom 
  */
  output wire [1:0]  	D2A_SW_Z_TX_GSEL,
  output wire 		D2A_SW_Z_CALMD,
  output wire 		D2A_SW_Z_CLK256K,
  output wire [9:0]	D2A_SW_Z_DDS,
  output wire		D2A_SW_Z_RXGAIN,
  //output wire		D2A_SW_Z_EN,
  output wire		D2A_Z_EN,
//  output wire		D2A_SW_Z_ADC_EN,
//  output wire		D2A_SW_Z_ADC_SAMPLE,
//  input  wire [9:0]	A2D_SW_Z_ADC_D,
//  input  wire 		A2D_SW_Z_ADC_EOC,
  input  wire [7:0]  A2D_SPARE_0,

  input  wire       A2D_LOFF_STATN,         
  input  wire       A2D_LOFF_STATP,         
  input  wire       A2D_ACLEADOFF_STATN,         
  input  wire       A2D_ACLEADOFF_STATP,         
  /*
  input  wire [9 :0]  A2D_Z_ADC_D,              // zmeas: SARADC 10b data
  input  wire         A2D_Z_ADC_EOC,              // zmeas: end of conversion signal from SARADC
  output wire [3:0]  D2A_Z_SEL1V5,  //1:0, config_output_voltage_range[1:0]
  //2:measure_calibrate
  //3. pga_gain
  output wire        D2A_Z_ADC_EN,   //from SPI, then select 2 source, then output to ana
  output wire        D2A_Z_SYS_CLK,  //adc_clk
  output wire [9:0]  D2A_Z_DDS,  //rom 
  output wire        D2A_Z_ADC_SAMPLE,  //sample 
  */

  output wire	     D2A_ATM0,	
  output wire	     D2A_ATM1,
  output wire	     D2A_ATM2,
  output wire	     D2A_ATM3,
  output wire	     D2A_ATM4,
  output wire	     D2A_ATM5,
  output wire	     D2A_ATM6,
  output wire	     D2A_ATM7,
  output wire	     D2A_ATM8,
  output wire	     D2A_ATM9,
  output wire	     D2A_ATM10,
  output wire	     D2A_ATM11,
  output wire      D2A_ATM12,

	//analog registers value from alwasy on

	//input wire D2A_BG_BUF_EN,
//	input wire D2A_DAC_BUF_EN,

	input wire [7:0] trim1_always_on,
	input wire [7:0] trim2_always_on,
	input wire [7:0] trim3_always_on,
	input wire [7:0] trim4_always_on,
	input wire [7:0] trim5_always_on,
	input wire [7:0] trim6_always_on,
	input wire [7:0] trim7_always_on,
	input wire [7:0] trim8_always_on,
	input wire [7:0] trim9_always_on,
	input wire [7:0] trim10_always_on
   
);

parameter NO_TRIM_REGS = 21; //the number of trims

flash2imeas flash2imeas();
spi2flash #(.TRIM_NUMBER(NO_TRIM_REGS))   spi2flash();
spi2imeas   spi2imeas();

wire         ext_clk_sel; //from analog IO cells
wire         ext_hfclk; //external clock from analog IO cells
assign  ext_clk_sel=     A2D_external_en_I; //from analog IO cells
assign  ext_hfclk =      A2D_external_clock_I; //external clock from analog IO cells

wire         hfosc;                      // osc base clock input
assign  hfosc =         A2D_OSC_OUT;                      // osc base clock input
wire         por_resetn;                 // power on reset, low active
assign por_resetn=   A2D_SW_POWER_POR;                 // power on reset, low active
wire       CHIP_FLASH_VREF;
assign     CHIP_FLASH_VREF = VREF0P8;

//wire       o_PGA_EN;
//wire [2:0] o_PGA_VIN_SEL;
//wire [1:0] o_PGA_GSEL;
////assign D2A_PGA_EN = o_PGA_EN;
//assign D2A_PGA_VIN_SEL = o_PGA_VIN_SEL;
//assign D2A_PGA_GSEL = o_PGA_GSEL;


wire       imeas_adc_din;              // imeas: ADC serial data input
wire [2:0] o_SDM_VIN_SEL;
wire       o_SDM_EN;
//wire       o_SDM_CHOP_EN; 
wire        SDM_CLK;
wire        SDM_CLK_GPIO;
wire        SDM_VIN_SEL;
wire [1:0]  o_SDM_BIAS;
assign imeas_adc_din=      A2D_SDM_OUT  ;
assign D2A_SDM_VIN_SEL = o_SDM_VIN_SEL;
assign D2A_SDM_EN = o_SDM_EN;    //V
//assign D2A_SDM_CHOP_EN = o_SDM_CHOP_EN;  //V
assign D2A_SDM_CLK = SDM_CLK;   //V
assign D2A_SDM_BIAS = o_SDM_BIAS;


wire       o_TSC_EN;
//wire       o_TSC_AMP_EN;
wire [2:0] o_TSC_BJT_SEL;
wire [2:0] o_TSC_INA_GSEL;
wire       o_TSC_OUT_SEL;
wire       o_TSC_INA_EN;

assign D2A_TSC_EN = o_TSC_EN;
//assign D2A_TSC_AMP_EN = o_TSC_AMP_EN;
assign D2A_TSC_BJT_SEL  = o_TSC_BJT_SEL;
assign D2A_TSC_INA_GSEL = o_TSC_INA_GSEL;
assign D2A_TSC_OUT_SEL  = o_TSC_OUT_SEL;
assign D2A_TSC_INA_EN   = o_TSC_INA_EN;

/*
wire [3:0]  Z_SEL1V5;  //1:0, config_output_voltage_range[1:0]
//2:measure_calibrate
//3. pga_gain
wire        o_Z_ADC_EN;   //from SPI, then select 2 source, then output to ana
wire        Z_SYS_CLK;  //adc_clk
wire [9:0]  DDS;  //rom 
wire         zmeas_adc_sample;           // zmeas: sample signal to SARADC
wire [9 :0]  zmeas_adc_din;              // zmeas: SARADC 10b data
wire         zmeas_adc_eoc;              // zmeas: end of conversion signal from SARADC

assign D2A_Z_SEL1V5 = Z_SEL1V5;  //1:0, config_output_voltage_range[1:0]
//2:measure_calibrate
//3. pga_gain
assign D2A_Z_ADC_EN = o_Z_ADC_EN;   //from SPI, then select 2 source, then output to ana
assign D2A_Z_SYS_CLK = Z_SYS_CLK;  //adc_clk
assign D2A_Z_DDS = DDS;  //rom 
assign D2A_Z_ADC_SAMPLE = zmeas_adc_sample;  //sample 
assign zmeas_adc_din = A2D_Z_ADC_D;              // zmeas: SARADC 10b data
assign zmeas_adc_eoc = A2D_Z_ADC_EOC;              // zmeas: end of conversion signal from SARADC
*/	


//wire  [2:0]   dc_clk_div_always_on; 
//assign 	     dc_clk_div_always_on = D2A_CPCLK;
wire	     ATM0;	
wire	     ATM1;
wire	     ATM2;
wire	     ATM3;
wire	     ATM4;
wire	     ATM5;
wire	     ATM6;
wire	     ATM7;
wire	     ATM8;
wire	     ATM9;
wire	     ATM10;
wire	     ATM11;
wire       ATM12;
assign	     D2A_ATM0   = ATM0;	
assign	     D2A_ATM1   = ATM1;
assign	     D2A_ATM2   = ATM2;
assign	     D2A_ATM3   = ATM3;
assign	     D2A_ATM4   = ATM4;
assign	     D2A_ATM5   = ATM5;
assign	     D2A_ATM6   = ATM6;
assign	     D2A_ATM7   = ATM7;
assign	     D2A_ATM8   = ATM8;
assign	     D2A_ATM9   = ATM9;
assign	     D2A_ATM10  = ATM10;
assign	     D2A_ATM11  = ATM11;
assign       D2A_ATM12  = ATM12;

//wire      bg_buf_en_always_on;   //
//wire      dac_buf_en_always_on;   //
wire      imeas_ch1_we1_en_always_on; //
//wire      bist_en_always_on; //
//wire[2:0] bist_isel_always_on;
//wire      dda_en_always_on;
//wire[2:0] dda_gsel_always_on;
// wire      PGA_EN;
// wire[2:0] PGA_VIN_SEL;
// wire[1:0] PGA_GSEL;

//wire     ele_buf_en_always_on;
//wire [2:0] ele_buf_sel_always_on;

/*       r2r_dac1_en_always_on;
[11:0]r2r_dac1_din_always_on;
r2r_dac2_en_always_on;
[11:0]r2r_dac2_din_always_on; */

//
//assign      bg_buf_en_always_on= D2A_BG_BUF_EN;   //

//assign      dac_buf_en_always_on= D2A_DAC_BUF_EN;   //
//assign      bist_en_always_on= D2A_BIST_EN; //
//assign bist_isel_always_on= D2A_BIST_ISEL;
//assign      dda_en_always_on= D2A_DDA_EN;
//assign dda_gsel_always_on= D2A_DDA_GSEL;
// assign      PGA_EN= ;
// assign PGA_VIN_SEL= ;
// assign PGA_GSEL= ;

//assign     ele_buf_en_always_on= D2A_ELE_BUF_EN;
//assign  ele_buf_sel_always_on= D2A_ELE_BUF_SEL;

// imeas: channel number select
wire [3 :0]  imeas_chnum;
wire        o_Z_ADC_EN_SPI;
wire        o_adc_en_sel  ;
wire 	     adc_en_sel;   //0 is state machine, 1 is register control
wire 	     dac_en_sel;   //0 is state machine, 1 is register control

wire		cs_n, miso, mosi, sclk;

// internal wire
// with zmeas
wire [1:0]   data_type_sel;    //00 is sinwave, 01: DC, others: sinwave
wire [9:0]   dc_data;    
wire [9:0]   dc_data_c;    
wire [9:0]   square_data;    

wire [9:0]   square_data_l;    
wire [9:0]   square_data_h;    

//wire [15:0]  square_clk_div;

wire        zmeas_pclk;
wire        zmeas_mclk;
wire        zmeas_int;
wire        zmeas_adc_int;

   wire		D2A_SW_Z_ADC_EN;
   wire		D2A_SW_Z_ADC_SAMPLE;

wire [1:0]  D2A_SW_Z_TX_GSEL_REG;
wire 		    D2A_SW_Z_CALMD_REG;
wire 		    D2A_SW_Z_CLK256K_REG;
wire [9:0]	D2A_SW_Z_DDS_REG;
wire		    D2A_SW_Z_RXGAIN_REG;
//wire		    D2A_SW_Z_EN_REG;
wire		    D2A_Z_EN_REG;
wire		    D2A_SW_Z_ADC_EN_REG;
wire		    D2A_SW_Z_ADC_SAMPLE_REG;

assign      D2A_SW_Z_RXGAIN = D2A_SW_Z_RXGAIN_REG;

// with imeas
wire        imeas_dig_adc_clk;
wire        iq_dig_adc_clk;
wire        iq_adc_clk;
wire LED_STATUS;

wire bio_disable;
wire ppg_ctrl_disable;
wire ppg_ctrl_en;
wire bio_enable;
wire ppg_ctrl_fclk;

wire         hfosc_atpg;       // hfosc after atpg mux
wire         fclk;             // hf free-running clock

//flash bist
wire         flash_bist_resetn;    // flash bist reset
wire         flash_bist_en;        // flash bist enable
wire         flash_bist_tck;       // flash bist TCK
wire         flash_bist_tck_atpg;  // flash bist TCK after atpg mux
wire         flash_bist_tdi;
wire         flash_bist_oen;
wire         flash_bist_tdo;

//from Flash
wire       regs_flash_dslp;
wire [7:0] d2a_trim11_from_flash; //flash_to_ana_trim11;
wire [7:0] d2a_trim12_from_flash; //flash_to_ana_trim12;
wire [7:0] d2a_trim13_from_flash; //flash_to_ana_trim13;
wire [7:0] d2a_trim14_from_flash; //flash_to_ana_trim14;

assign d2a_trim11_from_flash = spi2flash.trim_read[11];
assign d2a_trim12_from_flash = spi2flash.trim_read[12];
assign d2a_trim13_from_flash = spi2flash.trim_read[13];
assign d2a_trim14_from_flash = spi2flash.trim_read[14];

assign d2a_AO_spare0_from_flash = spi2flash.trim_read[15];
assign d2a_AO_spare1_from_flash = spi2flash.trim_read[16];
assign d2a_AO_spare2_from_flash = spi2flash.trim_read[17];
assign d2a_AO_spare3_from_flash = spi2flash.trim_read[18];

assign d2a_SW_spare0_from_flash = spi2flash.trim_read[19];
assign d2a_SW_spare1_from_flash = spi2flash.trim_read[20];

assign FLASH_Reset_Done         = spi2flash.sd2s[2];

// wire	     scan_en;
// wire	     scan_en_sw;
wire	[7:0]	scan_in;
wire	[7:0]	scan_out;
wire        scan_compression_in;

wire         pmu_fclk_en;          // sclk enable when in idle state
wire         flash_por_resetn; 	// flash por reset
wire	     presetn;
wire	     poresetn;
wire	     ext_resetn;
wire [15:0] iq_reg_ctrl;
wire [3:0]  iq_iclk_div; 
wire        iq_adc_clk_inv;

wire 	    Bioz_reset_reg;
wire 	    Bioz_resetn;

wire  meas_sync_en;
wire  config_zmeas_ctrl_reg;
wire         zmeas_en;
wire         Bioz_en;
wire         Bioz_en_sync;
wire         zmeas_phase_dither_en;
wire         fclk_dynen;

wire   [1:0] pclk_div;
wire   [2:0] iclk_div;
wire   [7:0] mclk_div;
wire   [15:0] checking_clk_div;
wire    check_pulse_pclk;
wire	     imeas_adc_inv; //1 bit from spi to clk ctrl 
wire	     pclk;

wire         m1k_reg_atpg;
//wire         A2D_LOFF_STATN;
//wire         A2D_LOFF_STATP;
wire         leadoff_det_en;
wire [1:0]   leadoff_type_sel_reg;    //00: N&P all, 01: N only, 10: P only, 11: N&P all
wire [1:0]   switch_duration_sel;    
wire    leadoff_active;    
wire [7:0]   leadoff_tgt_0;
wire [7:0]   leadoff_tgt_1;
wire [7:0]   leadoff_switch_tgt;
wire         leadoff_int_en;
wire	     imeas_pclk;
wire	     iq_pclk;
wire	     hresetreq;

wire	     flash_bist_resetn_atpg;
wire         pmuenable;
wire         sleepdeep;    // to pmu
wire 	     o_fifo_disable;
wire        flash_fclk;

wire		flash_dpstb_en;
wire		flash_dpstb;


wire zmeas_int_clr;
wire zmeas_adc_int_clr;
wire[31:0] zmeas_reg_ctrl;
wire[31:0] zmeas_reg_dataout;
wire[9:0] zmeas_xn_data;
wire[9:0] zmeas_sine_for_dft;
wire[9:0] zmeas_cosine_for_dft;
wire[28:0] zmeas_summation_offset_forreal;
wire[28:0] zmeas_summation_real;
wire[28:0] zmeas_summation_imag;
wire[16:0] zmeas_shiftedreal_inter;
wire[11:0] zmeas_dft_cnt;
wire reg_zmeas_int;
wire reg_zmeas_adc_int;

wire[15:0] zmeas_reg_status;

//fifo connection wires
wire        fifo_pclk;
wire [7:0]  fifo_a_empty_level;
wire [7:0]  fifo_a_full_level;
wire        fifo_rd_req_n;
wire        fifo_half_full;

wire        fifo_a_empty;
wire        fifo_a_full;
wire        fifo_empty;
wire        fifo_full;
wire        fifo_error;
wire        fifo_intr;
wire [`FIFO_ADDR-1:0]  fifo_rd_pntr;
wire [`FIFO_ADDR-1:0]  fifo_wr_pntr;
wire [`FIFO_ADDR:0]  fifo_data_cnt;
wire [`FIFO_ADDR-1:0]  fifo_ovf_cnt;
wire [17:0] fifo_data_o;
wire [7:0]  fifo_config3;

wire       fifo_full_sts_clr;
wire       fifo_empty_sts_clr;
wire       fifo_a_full_sts_clr;
wire       fifo_a_empty_sts_clr;
wire       fifo_a_error_sts_clr;  

//DC_LEAD_OFF
wire        DC_LEAD_OFF_RMODE_EN_REG;      
wire        DC_LEAD_OFF_VIN_FLIP_REG;   
wire [1:0]  LEAD_OFF_EN_REG;  // 0:DC -- 1:AC 

//AC_LEAD_OFF
wire        ACLEADOFF_CLK_REG;
wire        D2A_RLD_CLK64K_REG;

//ECG
wire        ECG_PGA_EN_REG;        
wire        ECG_LPF_EN_REG;         
wire [2:0]  ECG_PGA_GSEL_REG;      
wire [1:0]  ECG_DDA_CLKSEL_REG;    
wire        ECG_DDA_EN_REG;        
wire [2:0]  ECG_DDA_GSEL_REG;      
wire        ECG_DDACHOP_EN_REG;     
wire [1:0]  ECG_DDA_ISEL_REG; 
wire        ECG_CAL_EN_REG;  
wire [9:0]	D2A_ECGCAL_VSEL_TRIM_REG;
wire        ECG_ELECTRODE_EN_REG;

wire       RLD_CHOP_EN_REG;



//PPG
wire [7:0]  D2A_TIA_IDAC_REG;        
wire	      D2A_LEDDAC_SEL_REG;       
wire [1:0]  D2A_LEDSEL_REG;           
wire	      D2A_LED_STANDBYEN_REG;    
wire	      D2A_LED_EN_REG;           
wire	      D2A_EN_PPG_AF_REG;        
wire	      D2A_PPG_SH_CK_REG;        
wire	      D2A_EN_PPG_SH_REG;        
wire	      D2A_EN_TIA_REG;    
wire	      D2A_EN_TIA_VREFBUFFER_REG;        	                                    
wire [3:0]  D2A_TIA_GAIN_REG;
wire        D2A_EN_PPG_BUFFER_REG;
wire        D2A_EN_PPGDAC_BUFFER_REG;     
wire  [11:0] PPG_DAC0_VSEL;
wire         PPG_DAC0_EN;
wire  [11:0] PPG_DAC1_VSEL;
wire         PPG_DAC1_EN;
wire  [1:0]  PPG_TEST_OUT;
wire  [1:0]  PPG_TEST_IN;
wire  [1:0]  PPG_PDV_REF_SEL;


//new added by Xin 26Mar2026
        wire          PPG_LED_PROG_SEL;
 	wire   [13:0] led_on;
 	wire   [13:0] led_freq;

//wire   [7:0]ppg_TIA_IDAC;  
wire        ppg_enable; 
wire        ppg_IDAC_LED_SEL;
wire  [2:0] ppg_mode_sel;
wire        ppg_SYNC_BYPASS;
//wire  [3:0] ppg_TIA_GAIN;
wire  [3:0] ppg_LED_TIME_SEL;
wire  [3:0] ppg_LED_FREQ_SEL;
wire  [7:0] spi_to_ppg_TIA_IDAC; 
wire  [3:0] spi_to_ppg_TIA_GAIN;
wire       spi_to_ppg_LEDDAC_SEL       ;
wire [1:0] spi_to_ppg_LEDSEL           ;
wire       spi_to_ppg_LED_STANDBYEN    ;
//wire       spi_to_ppg_SYNC_BYPASS  ; 
wire       spi_to_ppg_LED_EN           ;
wire       spi_to_ppg_EN_PPG_AF        ;
wire       spi_to_ppg_PPG_SH_CK        ;
wire       spi_to_ppg_EN_PPG_SH        ;
wire       spi_to_ppg_EN_TIA           ;
wire       spi_to_ppg_EN_TIA_VREFBUFFER;
wire       spi_to_ppg_EN_PPG_BUFFER    ;
wire       spi_to_ppg_EN_PPGDAC_BUFFER ;

wire  [11:0] spi_to_ppg_PPG_DAC0_VSEL;
wire         spi_to_ppg_PPG_DAC0_EN;
wire  [11:0] spi_to_ppg_PPG_DAC1_VSEL;
wire         spi_to_ppg_PPG_DAC1_EN;
wire  [1:0]  spi_to_ppg_PPG_TEST_OUT;
wire  [1:0]  spi_to_ppg_PPG_TEST_IN;
wire  [1:0]  spi_to_ppg_PPG_PDV_REF_SEL;


wire       ppg_EN_PPG_BUFFER    ;
wire       ppg_LED_EN           ;
wire [1:0] ppg_LEDSEL           ;
wire       ppg_LEDDAC_SEL       ;
wire       ppg_LED_STANDBYEN    ;

wire       imeas_int;
wire       imeas_int_alarm;



wire [17:0] imeas_chdata;
wire imeas_chdata_en_n;
wire [2:0] PGA_VIN_SEL;
wire [1:0] PGA_GSEL;
wire [2:0] DDA_GSEL;

wire        RLD_EN_REG;
wire        BG1P2_BUF_EN_REG;
wire        VCM1P5_BUF_EN_REG;
wire        DDA_EN;		
wire        PGA_EN;
wire        SDM_EN;
wire [1:0]  SDM_BIAS;
//wire
//wire SDM_CHOP_EN;
//wire [1:0] dacbuf_trim;
wire R2R_DAC1_EN;
wire [11:0] R2R_DAC1_DIN;
wire R2R_DAC2_EN;
wire [11:0] R2R_DAC2_DIN;
//wire [5:0] osc_trim;
wire [2:0] dc_clk_div_spi;
wire 	   BIST_EN;
//wire [2:0] BIST_ISEL;
//wire [6:0] bgh_ctrl;
//wire [4:0] bgh_vtrim;
//wire [1:0] ldo1v5_trim;
wire TSC_EN;	
wire [2:0] TSC_GSEL;
wire TSC_OUT_SEL;
wire TSC_INA_EN;
wire [2:0] TSC_BJT_SEL;	                                 
wire [9:0]  zmeas_DDS;		 
wire imeas_adc_clk;	
wire Z_ADC_EN;
wire [2:0]  gpio_pu_ctrl;
wire        gpio_pu_resetn;
wire [1:0]  gpio_pd_testmode;

wire notch_filter_enable;
wire nf_pclk;

gpio u_gpio (
  .i_gpio_pu_ctrl     (gpio_pu_ctrl),
  .i_gpio_pu_resetn   (gpio_pu_resetn),
  .i_gpio_pd_testmode (gpio_pd_testmode),
  .i_scan_mode        (atpg_en_sw),

  .o_baf4p1_IOBUF_CS    (o_baf4p1_IOBUF_CS),
  .o_baf4p1_IOBUF_SR    (o_baf4p1_IOBUF_SR),
  .o_baf4p1_IOBUF_DR    (o_baf4p1_IOBUF_DR),
  .o_baf4p1_IOBUF_PU    (o_baf4p1_IOBUF_PU),
  .o_baf4p1_IOBUF_PD    (o_baf4p1_IOBUF_PD),
  .o_baf4p1_IOBUF_OS    (o_baf4p1_IOBUF_OS),
  .o_baf4p1_IOBUF_OD    (o_baf4p1_IOBUF_OD),

  .o_IO_testmode0_PD  (o_IO_testmode0_PD),
  .o_IO_testmode1_PD  (o_IO_testmode1_PD),
  .o_IO_exresetn_PU   (o_IO_exresetn_PU)
);

pinmux u_pinmux (
  .o_baf4p1_IOBUF_IE(o_baf4p1_IOBUF_IE),
  .o_baf4p1_IOBUF_A (o_baf4p1_IOBUF_A),	
  .o_baf4p1_IOBUF_OE(o_baf4p1_IOBUF_OE),
  .i_baf4p1_IOBUF_Y (i_baf4p1_IOBUF_Y),

  .sclk         (sclk),
  .cs_n         (cs_n),
  .mosi         (mosi),
  .miso         (miso),
  .i_LED_STATUS (LED_STATUS),

  .atpg_en              (atpg_en_sw),
  .scan_rst_n           (scan_rst_n),
  .scan_clk             (scan_clk),
  .scan_en              (scan_en_sw),   //Tri change
  .scan_in              (scan_in),
  .scan_out             (scan_out),
  .scan_compression_in  (scan_compression_in),

  .flash_bist_en    (flash_bist_en),      //to flash
  .flash_bist_resetn(flash_bist_resetn),  //output from pinmux
  .flash_bist_tck   (flash_bist_tck),     //to flash
  .flash_bist_tdi   (flash_bist_tdi),     //to flash
  .flash_bist_oen   (flash_bist_oen),     //to flash
  .flash_bist_tdo   (flash_bist_tdo),     //to flash

  .iopad_testmode0_en_y (iopad_testmode0_en_y),
  .iopad_testmode1_en_y (iopad_testmode1_en_y),
  .iopad_resetn_y       (iopad_resetn_y),

  .zmeas_int      (zmeas_int),
  .zmeas_adc_int  (zmeas_adc_int),
  .imeas_int      (imeas_int),
  .imeas_int_alarm(imeas_int_alarm),
  .fifo_intr      (fifo_intr),

  .imeas_adc_clk  (imeas_adc_clk),	
  .SDM_CLK_GPIO   (SDM_CLK_GPIO),
  .pin_rstn       (ext_resetn), //output from pinmux
  //.SDM_OUT        (SDM_OUT),

  .ATM0   (ATM0),
  .ATM1   (ATM1),
  .ATM2   (ATM2),
  .ATM3   (ATM3),
  .ATM4   (ATM4),
  .ATM5   (ATM5),
  .ATM6   (ATM6),
  .ATM7   (ATM7),
  .ATM8   (ATM8),
  .ATM9   (ATM9),
  .ATM10  (ATM10),
  .ATM11  (ATM11),
  .ATM12  (ATM12),

  //ATM0 - test mode 2 - DONE
  .DCLEADOFF_COMP_TH      (flash_to_ana_trim6),  //DCLEADOFF_COMP_TH
  .DCLEADOFF_ISEL         (flash_to_ana_trim7),     //DCLEADOFF_ISEL
  .DCLEADOFF_VINFLIP      (DC_LEAD_OFF_VIN_FLIP),
  .DCLEADOFF_EN           (DC_LEAD_OFF_EN),
  .DCLEADOFF_RMODE_EN     (DC_LEAD_OFF_RMODE_EN),
  .LOFF_STATN             (A2D_LOFF_STATN),
  .LOFF_STATP             (A2D_LOFF_STATP),

  .DCLEADOFF_COMP_TH_REG  (spi2flash.trim_read[6]),
  .DCLEADOFF_ISEL_REG     (spi2flash.trim_read[7]),
  .DCLEADOFF_VINFLIP_REG  (DC_LEAD_OFF_VIN_FLIP_REG),
  .DCLEADOFF_EN_REG       (LEAD_OFF_EN_REG[0]),
  .DCLEADOFF_RMODE_EN_REG (DC_LEAD_OFF_RMODE_EN_REG),

  //ATM1 - test mode 3 
  .PPGDAC1_VSEL         (D2A_PPG_DAC1_VSEL),
  .PPGDAC1_EN           (D2A_PPG_DAC1_EN),
  .EN_PPGDAC_BUFFER     (D2A_EN_PPGDAC_BUFFER),
  .LED_EN               (D2A_LED_EN),
  .LED_SEL              (D2A_LEDSEL),
  .LEDDAC_SEL           (D2A_LEDDAC_SEL),
  .LED_STANDBYEN        (D2A_LED_STANDBYEN),

  .PPGDAC1_VSEL_REG     (PPG_DAC1_VSEL),
  .PPGDAC1_EN_REG       (PPG_DAC1_EN),
  .EN_PPGDAC_BUFFER_REG (D2A_EN_PPGDAC_BUFFER_REG),
  .LED_EN_REG           (D2A_LED_EN_REG),
  .LED_SEL_REG          (D2A_LEDSEL_REG),
  .LEDDAC_SEL_REG       (D2A_LEDDAC_SEL_REG),
  .LED_STANDBYEN_REG    (D2A_LED_STANDBYEN_REG),

  //ATM2 - test mode 4 - DONE
  .SDA_VIN_SEL      (o_SDM_VIN_SEL),
  .SDM_EN           (o_SDM_EN),
  .SDM_CLK          (SDM_CLK),
  .SDM_BIAS         (o_SDM_BIAS),
  .BG1P2_BUF_EN     (o_BG1P2_BUF_EN),
  .imeas_adc_din    (imeas_adc_din),	//SDM_OUT, imeas_adc_din

  .SDA_VIN_SEL_REG  (imeas_chnum[2:0]),
  .SDM_EN_REG       (SDM_EN),
  .SDM_BIAS_REG     (SDM_BIAS),
  .BG1P2_BUF_EN_REG (BG1P2_BUF_EN_REG),

  //ATM3 - test mode 5 - DONE
  .DDA_EN         (ECG_DDA_EN),
  .PGA_EN         (ECG_PGA_EN),
  .LPF_EN         (ECG_LPF_EN),
  .DDACHOP_EN     (ECG_DDACHOP_EN),
  .DDA_CLKSEL     (ECG_DDA_CLKSEL),
  .PGA_SEL        (ECG_PGA_GSEL),
  .DDA_GSEL       (ECG_DDA_GSEL),
  .DDA_ISEL       (ECG_DDA_ISEL),
  .VCM1P5_BUF_EN  (VCM1P5_BUF_EN),

  .DDA_EN_REG         (ECG_DDA_EN_REG),
  .PGA_EN_REG         (ECG_PGA_EN_REG),
  .LPF_EN_REG         (ECG_LPF_EN_REG),
  .DDACHOP_EN_REG     (ECG_DDACHOP_EN_REG),
  .DDA_CLKSEL_REG     (ECG_DDA_CLKSEL_REG),
  .PGA_SEL_REG        (ECG_PGA_GSEL_REG),
  .DDA_GSEL_REG       (ECG_DDA_GSEL_REG),
  .DDA_ISEL_REG       (ECG_DDA_ISEL_REG),
  .VCM1P5_BUF_EN_REG  (VCM1P5_BUF_EN_REG),

  //ATM4 - test mode 6
  .TIA_GAIN               (D2A_TIA_GAIN),
  .PPG_SH_CK              (D2A_PPG_SH_CK),
  .TIA_IDAC               (D2A_TIA_IDAC),
  .EN_TIA                 (D2A_EN_TIA),
  .EN_PPG_SH              (D2A_EN_PPG_SH),
  .EN_PPG_AF              (D2A_EN_PPG_AF),
  .EN_PPG_BUFFER          (D2A_EN_PPG_BUFFER),
  .EN_TIA_VREFBUFFER      (D2A_EN_TIA_VREFBUFFER),
  .PDVREF_SEL             (D2A_PPG_PDV_REF_SEL),
  .PPG_TEST_IN            (D2A_PPG_TEST_IN),
  .PPG_TEST_OUT           (D2A_PPG_TEST_OUT),

  .TIA_GAIN_REG           (D2A_TIA_GAIN_REG),
  .PPG_SH_CK_REG          (D2A_PPG_SH_CK_REG),
  .TIA_IDAC_REG           (D2A_TIA_IDAC_REG),
  .EN_TIA_REG             (D2A_EN_TIA_REG),
  .EN_PPG_SH_REG          (D2A_EN_PPG_SH_REG),
  .EN_PPG_AF_REG          (D2A_EN_PPG_AF_REG),
  .EN_PPG_BUFFER_REG      (D2A_EN_PPG_BUFFER_REG),
  .EN_TIA_VREFBUFFER_REG  (D2A_EN_TIA_VREFBUFFER_REG),
  .PDVREF_SEL_REG         (PPG_PDV_REF_SEL),
  .PPG_TEST_IN_REG        (PPG_TEST_IN),
  .PPG_TEST_OUT_REG       (PPG_TEST_OUT),

  //ATM5 - test mode 7 -DONE
  .BGH_VTRIM        (flash_to_ana_trim1),
  .BGH_CTRIM        (flash_to_ana_trim2),
  .LDO1V5_VTRIM     (flash_to_ana_trim3),
  .BIST_EN          (o_BIST_EN),

  .BGH_VTRIM_REG    (spi2flash.trim_read[1]),
  .BGH_CTRIM_REG    (spi2flash.trim_read[2]),
  .LDO1V5_VTRIM_REG (spi2flash.trim_read[3]),
  .BIST_EN_REG      (BIST_EN),

  //ATM6 - test mode 8 - T_Sensor - DONE
  .TSC_BJT_SEL      (o_TSC_BJT_SEL),
  .TSC_OUT_SEL      (o_TSC_OUT_SEL),
  .TSC_EN           (o_TSC_EN),
  .TSC_INA_GSEL     (o_TSC_INA_GSEL),
  .TSC_INA_EN       (o_TSC_INA_EN),

  .TSC_BJT_SEL_REG  (TSC_BJT_SEL),
  .TSC_OUT_SEL_REG  (TSC_OUT_SEL),
  .TSC_EN_REG       (TSC_EN),
  .TSC_INA_GSEL_REG (TSC_GSEL),
  .TSC_INA_EN_REG   (TSC_INA_EN),

  //ATM7 - test mode 9 - DONE
  .DDS            (D2A_SW_Z_DDS),
  .Z_TX_GSEL      (D2A_SW_Z_TX_GSEL),
  .Z_EN           (D2A_Z_EN),
  .Z_CLK256K      (D2A_SW_Z_CLK256K),
  .Z_CALMD        (D2A_SW_Z_CALMD),

  .DDS_REG        (D2A_SW_Z_DDS_REG),
  .Z_TX_GSEL_REG  (D2A_SW_Z_TX_GSEL_REG),
  .Z_EN_REG       (D2A_Z_EN_REG),
  .Z_CLK256K_REG  (D2A_SW_Z_CLK256K_REG),
  .Z_CALMD_REG    (D2A_SW_Z_CALMD_REG),

  //ATM8 - test mode 10 - DONE
  .ECGCAL_VSEL      (ECGCAL_VSEL),
  .ECGCAL_EN        (ECGCAL_EN),
                 
  .ECGCAL_VSEL_REG  (D2A_ECGCAL_VSEL_TRIM_REG),
  .ECGCAL_EN_REG    (ECG_CAL_EN_REG),

  //ATM9 - test mode 11
  .RLD_CHOP_EN      (RLD_CHOP_EN),
  .ELECTRODE_EN     (ECG_ELECTRODE_EN),
  .RLD_CLK64K       (D2A_RLD_CLK64K),
  .RLD_EN           (RLD_AMP_EN),
                     
  .RLD_CHOP_EN_REG  (RLD_CHOP_EN_REG),
  .ELECTRODE_EN_REG (ECG_ELECTRODE_EN_REG),
  .RLD_CLK64K_REG   (D2A_RLD_CLK64K_REG),
  .RLD_EN_REG       (RLD_EN_REG),

  //ATM10 - test mode 12 - DONE
  .OSC_TRIM           (flash_to_ana_trim4),
  .OSC_ISEL_TRIM      (flash_to_ana_trim5), //D2A_OSC_ISEL_TRIM
  .OSC_OUT            (hfosc),
  .OSC_TRIM_REG       (spi2flash.trim_read[4]),
  .OSC_ISEL_TRIM_REG  (spi2flash.trim_read[5]),

  //ATM11 - test mode 13
  .PPGDAC0_VSEL     (D2A_PPG_DAC0_VSEL),
  .PPGDAC0_EN       (D2A_PPG_DAC0_EN),

  .PPGDAC0_VSEL_REG (PPG_DAC0_VSEL),
  .PPGDAC0_EN_REG   (PPG_DAC0_EN),

  //ATM12 - test mode 14
  .ACLEADOFF_VTHNSEL_TRIM     (flash_to_ana_trim8),
  .ACLEADOFF_VTHPSEL_TRIM     (flash_to_ana_trim9),
  .ACLEADOFF_CLK              (D2A_ACLEADOFF_CLK),
  .ACLEADOFF_EN               (ACLEADOFF_EN),
  .ACLEADOFF_ISEL_TRIM        (flash_to_ana_trim10),
  .ACLEADOFF_STATN            (A2D_ACLEADOFF_STATN),
  .ACLEADOFF_STATP            (A2D_ACLEADOFF_STATP),
                         
  .ACLEADOFF_VTHNSEL_TRIM_REG (spi2flash.trim_read[8]),
  .ACLEADOFF_VTHPSEL_TRIM_REG (spi2flash.trim_read[9]),
  .ACLEADOFF_CLK_REG          (ACLEADOFF_CLK_REG),
  .ACLEADOFF_EN_REG           (LEAD_OFF_EN_REG[1]),
  .ACLEADOFF_ISEL_TRIM_REG    (spi2flash.trim_read[10])

  /*
  .PGA_VIN_SEL(o_PGA_VIN_SEL),					
  .DAC_BUF_TRIM(flash_to_ana_dacbuf_trim),
  .D2A_CPCLK(o_dc_clk_div_spi),						//pending
  .BIST_ISEL(o_BIST_ISEL),   
  .BGL_CTRIM(flash_to_ana_bgl_ctrl),
  .BGL_VTRIM(flash_to_ana_bgl_vtrim),
  .TSC_GSEL(o_TSC_GSEL),
  .Z_ADC_EOC(zmeas_adc_eoc),						//pending

  .SDM_CHOP_EN_REG(SDM_CHOP_EN),
  .DAC_BUF_TRIM_REG(dacbuf_trim),
  .D2A_CPCLK_REG(dc_clk_div_spi),             
  .BIST_ISEL_REG(BIST_ISEL),
  .BGL_CTRIM_REG(bgl_ctrl),
  .BGL_VTRIM_REG(bgl_vtrim),
  .TSC_GSEL_REG(TSC_GSEL),
  */

);  

wire Bioz_mclk;

wire  SDM_CLK_GPIO_pha_sel;
wire [1:0] acleadoff_clk_sel;
wire [1:0] rld_clk_reg;
wire [2:0]  cic_rate;
wire [3:0]  cic_rate_iq;

assign square_data_l = {d2a_trim14_from_flash[1:0],d2a_trim13_from_flash};
assign square_data_h = {d2a_trim12_from_flash[1:0],d2a_trim11_from_flash};

clk_ctrl clk_ctrl_inst
(
   .D2A_ACLEADOFF_CLK(ACLEADOFF_CLK_REG),
   .D2A_RLD_CLK64K(D2A_RLD_CLK64K_REG),
   //.cic_rate(cic_rate),
   .SDM_CLK_GPIO_pha_sel(SDM_CLK_GPIO_pha_sel),
   .SDM_CLK_GPIO (SDM_CLK_GPIO),
   .acleadoff_clk_sel(acleadoff_clk_sel),
   .rld_clk_reg(rld_clk_reg),
   .ppg_ctrl_en(ppg_ctrl_en),
   .bio_enable(bio_enable),
   .ppg_ctrl_fclk(ppg_ctrl_fclk),

  .data_type_sel(data_type_sel),    //00 is sinwave, 01: DC, 10: square wave, 11: sinwave
  .square_data(square_data),        //output 
  .square_data_h(square_data_h),    //input
  .square_data_l(square_data_l),    //input

  //.square_clk_div(square_clk_div), //from SPI //input  wire  [9:0]  checking_clk_div

   .m1k_reg_atpg(m1k_reg_atpg),

  .poresetn(poresetn),
  .ext_clk_sel(ext_clk_sel),
  .ext_hfclk(ext_hfclk),
  .hfosc(hfosc),
  .flash_bist_tck(flash_bist_tck),
  .scan_clk(scan_clk),
  .atpg_en(atpg_en),
  .scan_en(scan_en),  //Tri add
  .o_fifo_disable(o_fifo_disable),
  .dpstb_en(flash_dpstb_en & regs_flash_dslp), //from SPI
  .Bioz_en(Bioz_en), //from SPI
  .Bioz_en_sync(Bioz_en_sync), //
  .imeas_en(spi2imeas.o_imeas_en), //from SPI
  .pmu_fclk_en(pmu_fclk_en),
  .fclk_dynen(fclk_dynen), //from SPI //input  wire fclk_dynen

.iq_iclk_div(iq_iclk_div), 
.iq_adc_clk_inv(iq_adc_clk_inv),

  .pclk_div(pclk_div), //from SPI //input  wire  [1:0]  pclk_div
  .iclk_div(iclk_div), //from SPI //input  wire  [2:0]  iclk_div
  .mclk_div(mclk_div), //from SPI //input  wire  [2:0]  mclk_div
  //.mclk_div(0), //from SPI //input  wire  [2:0]  mclk_div
  .checking_clk_div(checking_clk_div), //from SPI //input  wire  [9:0]  checking_clk_div
  .check_pulse_pclk(check_pulse_pclk), //
  .imeas_adc_inv(imeas_adc_inv), //1 bit from spi to clk ctrl
  .hfosc_atpg(hfosc_atpg),
  .flash_bist_tck_atpg(flash_bist_tck_atpg), //to flash
  .fclk(fclk),
  .pclk(pclk),
  .fifo_pclk(fifo_pclk),
  .flash_fclk(flash_fclk),
  .notch_filter_enable(notch_filter_enable),
  .nf_pclk(nf_pclk),

  //.zmeas_pclk(zmeas_pclk),
  .imeas_pclk(imeas_pclk),
  .iq_pclk(iq_pclk),
  .Bioz_mclk(Bioz_mclk),

//these 3 will be removed
  .zmeas_pclk(zmeas_pclk),
  .zmeas_en(Bioz_en), //from SPI
  .zmeas_mclk(zmeas_mclk),

  .iq_adc_clk(iq_adc_clk),
  .iq_dig_adc_clk(iq_dig_adc_clk),
  .imeas_adc_clk(imeas_adc_clk),
  .imeas_dig_adc_clk(imeas_dig_adc_clk)
);

reset_ctrl rst_ctrl_inst
(
  .por_resetn(por_resetn),
  .ext_resetn(ext_resetn),
  .flash_bist_resetn(flash_bist_resetn),
  .scan_rst_n(scan_rst_n),
  .atpg_en(atpg_en),
  .flash_bist_en(flash_bist_en),
  .hfosc_atpg(hfosc_atpg),
  .fclk(fclk),
  .pclk(pclk),
.Bioz_reset_reg(Bioz_reset_reg),
.Bioz_resetn(Bioz_resetn),

  .poresetn(poresetn),
  .poresetn_hf(poresetn_hf),
  .presetn(presetn),
  .flash_por_resetn(flash_por_resetn),
  .flash_bist_resetn_atpg(flash_bist_resetn_atpg) //connect to Flash for bist resetn
);

// instantiate pmu
pmu u_pmu (
.ppg_ctrl_disable(ppg_ctrl_disable),
  .bio_disable(bio_disable),
  .bio_enable(bio_enable),
.ppg_ctrl_en(ppg_ctrl_en),

  .poresetn_hf(poresetn_hf),
  .hfosc_atpg(hfosc_atpg),
  .atpg_en(atpg_en),
  .pmuenable(pmuenable), //From SPI
  .hresetreq(hresetreq), //can connect to SPI as a reset request
  .sleepdeep(sleepdeep), //From SPI
  .flash_dpstb_en(flash_dpstb_en), //from SPI
  .flash_por_resetn(flash_por_resetn),
  .pmu_fclk_en(pmu_fclk_en),
  .flash_dpstb(flash_dpstb) //to flash
);
wire [31:0]   phase_inc;
wire [31:0]   phase_offset;
wire [31:0]   phase_offset_c;

wire	 	   DITHER_EN;
wire [15:0]  	   DITHER_SEED;  

 BioZ #(
    .PHASE_W(32)
) BioZ(
   .clk(Bioz_mclk),                          // CLK
   .resetn(Bioz_resetn),                       // Reset
   .enable(Bioz_en_sync),
   .DITHER_EN(DITHER_EN),
   .DITHER_SEED(DITHER_SEED),  
   //.phase_inc(32'h0666_6666),
   //.phase_offset(0),  //if don't start from 0
   .phase_inc(phase_inc),
   .phase_offset(phase_offset),  //if don't start from 0
   .phase_offset_c(phase_offset_c),  //if don't start from 0
  .data_type_sel(data_type_sel),    //00 is sinwave, 01: DC, others: sinwave
  .dc_data(dc_data),    
  .dc_data_c(dc_data_c),    
   .sin_unsigned(), //connect to D2A_BIOZ_TX_IDAC_DIN<9:0>
   .cos_unsigned(), // dont need to connect
   .i_square(), //Connect to D2A_BIOZ_RX_MIXER_SQR0
   .q_square(), //Connect to D2A_BIOZ_RX_MIXER_SQR90
   .phase_acc()    //incase want to use fout freq
);




iq_filter_wrapper u_iq_filter_wrapper(

  // clock and reset

  .pclk(iq_pclk),
  .adc_clk(iq_dig_adc_clk), //SDM_CLK,imeas_dig_adc_clk
  .cic_rate(cic_rate_iq),
  // with analog
  //.reg_ctrl(),
  .reg_ctrl(iq_reg_ctrl),

  .presetn(Bioz_resetn),
  // atpg enable
  .atpg_en(atpg_en),
  .scan_en(scan_en),  //Tri add
  
  .iq_adc_din_I(imeas_adc_din),	//SDM_OUT, from analog ,should connect to IADC
  .iq_adc_din_Q(imeas_adc_din),	//SDM_OUT, from analog ,should connect to QADC
  .iq_int_I(),
  .iq_int_Q(),
  .iq_int_sts_I(),
  .iq_int_sts_Q(),
  .int_clr(),
  .int_length_slct(spi2imeas.int_length),
  .chdata_I(),//output wire   [19:0]
  .chdata_en_n_I(), //output wire   [19:0]
  .chdata_Q(),//output wire   [19:0]
  .chdata_en_n_Q() //output wire   [19:0]


);

imeas u_imeas(

  .flash2imeas(flash2imeas),	
  .spi2imeas(spi2imeas),	
  // clock and reset
  //.led_status(LED_STATUS),    //connect to ppg controller
  .LED_STATUS(LED_STATUS),    //connect to ppg controller
  .D2A_PPG_SH_CK(D2A_PPG_SH_CK),    //connect to ppg controller

.cic_rate(cic_rate),
  .check_pulse_pclk(check_pulse_pclk), //

   .m1k_reg_atpg(m1k_reg_atpg),
    .D2A_ACLEADOFF_EN(AO2D_AC_LEAD_OFF_EN),
    .D2A_DCLEADOFF_EN(AO2D_DC_LEAD_OFF_EN),
  .A2D_ACLEADOFF_STATN (A2D_ACLEADOFF_STATN), 
  .A2D_ACLEADOFF_STATP (A2D_ACLEADOFF_STATP), 
   .A2D_LOFF_STATN(A2D_LOFF_STATN),
   .A2D_LOFF_STATP(A2D_LOFF_STATP),
  .notch_filter_enable(notch_filter_enable),
  .nf_pclk(nf_pclk),

  .pclk(imeas_pclk),
  .adc_clk(imeas_dig_adc_clk), //SDM_CLK,imeas_dig_adc_clk
  .presetn(presetn),
  //
  .imeas_int      (imeas_int),
  .imeas_int_alarm(imeas_int_alarm),

  .chdata(imeas_chdata),//output wire   [15:0]
  .chdata_en_n(imeas_chdata_en_n),//output wire   [15:0]


  // atpg enable
  .atpg_en(atpg_en),
  .scan_en(scan_en),  //Tri add
  // with analog
  .imeas_adc_din(imeas_adc_din),	//SDM_OUT, imeas_adc_din
  .imeas_chnum(imeas_chnum)
);


// FLASH CTRL TOP//BIST TEST MODE//
flash_ctrl_top #(
.NO_I2C_REGS(NO_TRIM_REGS)
) flash_ctrl_top_inst(
  .spi2flash       (spi2flash),
  .flash2imeas     (flash2imeas),
  .TCK               (flash_bist_tck_atpg),           
  .RESETb            (flash_bist_resetn_atpg),
  .TDI               (flash_bist_tdi),
  .TESTEN            (flash_bist_en), 
  .TDO               (flash_bist_tdo),
  .OEN               (flash_bist_oen),

  .clk		     (flash_fclk),  
  .rst_n             (poresetn),
  .ext_clk_sel       (ext_clk_sel),
  .atm_unlock        (0),
  .analog_test_mode  (0),
  .atm_mode          (0),
  .atm_data          (0),
  .regs_flash_dslp   (regs_flash_dslp),



//  .CHIP_FLASH_PORb        (flash_por_resetn),
  .CHIP_FLASH_DPSTB       (flash_dpstb),
  .CHIP_FLASH_VPP         (vpp_flash),
  .CHIP_FLASH_VREF        (CHIP_FLASH_VREF),
  .ATPG_EN                (atpg_en)    
);

//SPI to be modified to connect to i and z meas blocks
spi_top #(
.ADDR_WIDTH(8),
.DATA_WIDTH(8),
.NO_TRIM_REGS(NO_TRIM_REGS)
) spi_top_u (
  .spi2flash(spi2flash),
  .spi2imeas(spi2imeas),	
	

  .SCANMODE(atpg_en),
  .i_scanclk(scan_clk),             
  .i_rst_n(presetn),
  .i_sclk(sclk),             // sclk clock for the spi-slave controller and reg block 
  .i_cs_n(cs_n),
  .i_mosi(mosi),
  .o_miso(miso),

.iq_reg_ctrl(iq_reg_ctrl),
.iq_iclk_div(iq_iclk_div), 
.iq_adc_clk_inv(iq_adc_clk_inv),
   .phase_inc(phase_inc),
   .phase_offset(phase_offset),  //if don't start from 0
   .phase_offset_c(phase_offset_c),  //if don't start from 0
   .DITHER_EN(DITHER_EN),
   .DITHER_SEED(DITHER_SEED),  
.Bioz_reset_reg(Bioz_reset_reg),
   .Bioz_en(Bioz_en),
  .data_type_sel(data_type_sel),    //00 is sinwave, 01: DC, 10: square wave, 11: sinwave
  .dc_data(dc_data),    
  .dc_data_c(dc_data_c),    
/*
  .square_data_h(square_data_h),    
  .square_data_l(square_data_l),    
*/
  //.square_clk_div(square_clk_div), //from SPI //input  wire  [9:0]  square_clk_div

  .ppg_ctrl_disable(ppg_ctrl_disable),
  .bio_disable(bio_disable),

  .meas_sync_en(meas_sync_en),
  .config_zmeas_ctrl_reg(config_zmeas_ctrl_reg),
  //.zmeas_en(Bioz_en), //from SPI
  .zmeas_phase_dither_en(zmeas_phase_dither_en),//from SPI 

  .zmeas_int_clr(zmeas_int_clr),//input wire 
  .zmeas_adc_int_clr(zmeas_adc_int_clr),//input wire 
  .zmeas_reg_ctrl(zmeas_reg_ctrl),//input  wire [31:0]
  .zmeas_reg_status(zmeas_reg_status),
  .zmeas_reg_dataout(zmeas_reg_dataout),

  .zmeas_xn_data(zmeas_xn_data),
  .zmeas_sine_for_dft(zmeas_sine_for_dft),
  .zmeas_cosine_for_dft(zmeas_cosine_for_dft),
  .zmeas_summation_offset_forreal(zmeas_summation_offset_forreal),
  .zmeas_summation_real(zmeas_summation_real),
  .zmeas_summation_imag(zmeas_summation_imag),
  .zmeas_shiftedreal_inter(zmeas_shiftedreal_inter),
  .zmeas_dft_cnt(zmeas_dft_cnt),
  .reg_zmeas_int(reg_zmeas_int),
  .reg_zmeas_adc_int(reg_zmeas_adc_int),

.SDM_CLK_GPIO_pha_sel(SDM_CLK_GPIO_pha_sel),
.acleadoff_clk_sel(acleadoff_clk_sel),
.rld_clk_reg(rld_clk_reg),
  .fclk_dynen(fclk_dynen),
  .pclk_div(pclk_div),
  .iclk_div(iclk_div),
  .mclk_div(mclk_div), 
  .checking_clk_div(checking_clk_div), //from SPI //input  wire  [9:0]  checking_clk_div
  .imeas_adc_inv(imeas_adc_inv),
  .o_always_on_spi_write(spi_write),

  //GPIO
  .gpio_pu_ctrl(gpio_pu_ctrl),          	  
  .gpio_pu_resetn(gpio_pu_resetn),                  
  .gpio_pd_testmode(gpio_pd_testmode),   

  .pmuenable(pmuenable),            // pmu enable
  .hresetreq(hresetreq),            // system reset request
  .sleepdeep(sleepdeep),            // system enters deep-sleep state
  .flash_dpstb_en(flash_dpstb_en),  // flash deep power down standby mode enable
  .o_fifo_disable(o_fifo_disable),

  //PPG
 // .o_ppg_TIA_IDAC(ppg_TIA_IDAC),  
  .o_ppg_enable(ppg_enable), 
  .o_ppg_IDAC_LED_SEL(ppg_IDAC_LED_SEL),
  .o_ppg_mode_sel(ppg_mode_sel),
  .o_PPG_SYNC_BYPASS(ppg_SYNC_BYPASS),
 // .o_ppg_TIA_GAIN(ppg_TIA_GAIN),
  .o_ppg_LED_TIME_SEL(ppg_LED_TIME_SEL),
  .o_ppg_LED_FREQ_SEL(ppg_LED_FREQ_SEL),
//
//new added by Xin 26Mar2026
         .o_PPG_LED_PROG_SEL(PPG_LED_PROG_SEL),
 	 .led_on(led_on),
 	 .led_freq(led_freq),

  //FIFO
  .i_fifo_rd_ptr   (fifo_rd_pntr),    
  .i_fifo_wr_ptr   (fifo_wr_pntr),   
  .i_fifo_a_empty  (fifo_a_empty),    
  .i_fifo_empty    (fifo_empty),      
  .i_fifo_a_full   (fifo_a_full),    
  .i_fifo_full     (fifo_full),       
  .i_fifo_error    (fifo_error),     
  .i_fifo_data_cnt (fifo_data_cnt), 
  .i_fifo_ovf_cnt  (fifo_ovf_cnt),


  .o_fifo_config3(fifo_config3), 
  .o_fifo_a_full_level(fifo_a_full_level) , 
  .o_fifo_a_empty_level(fifo_a_empty_level),    

  //SPI_new_i/o
  .i_fifo_rd_data  (fifo_data_o ),
  .o_fifo_rd_req_n (fifo_rd_req_n),
  // .o_fifo_data_rd_done( ), //fifo_data_rd_done) 

  .o_fifo_full_sts_clr(fifo_full_sts_clr),
  .o_fifo_empty_sts_clr(fifo_empty_sts_clr),
  .o_fifo_a_full_sts_clr(fifo_a_full_sts_clr),
  .o_fifo_a_empty_sts_clr(fifo_a_empty_sts_clr),
  .o_fifo_a_error_sts_clr(fifo_a_error_sts_clr),

  //analog register outputs

  //ana_buffer
  .o_BG1P2_BUF_EN(BG1P2_BUF_EN_REG),      //(BG1P2_BUF_EN),   AO  
  .o_VCM1P5_BUF_EN(VCM1P5_BUF_EN_REG),     //(VCM1P5_BUF_EN), AO
  .o_RLD_AMP_EN(RLD_EN_REG),        //(BG1P2_BUF_EN), AO
  .o_RLD_CHOP_EN(RLD_CHOP_EN_REG),
  //ECG
  .o_ECG_PGA_EN(ECG_PGA_EN_REG),         //(ECG_PGA_EN), AO
  .o_ECG_LPF_EN(ECG_LPF_EN_REG),         //(ECG_LPF_EN), AO
  .o_ECG_PGA_GSEL(ECG_PGA_GSEL_REG),       //(ECG_PGA_GSEL),  AO
  .o_ECG_DDA_CLKSEL(ECG_DDA_CLKSEL_REG),     //(ECG_DDA_CLKSEL), AO
  .o_ECG_DDA_EN(ECG_DDA_EN_REG),         //(ECG_DDA_EN), AO
  .o_ECG_DDA_GSEL(ECG_DDA_GSEL_REG),       //o_ECG_DDA_GSEL), AO
  .o_ECG_DDACHOP_EN(ECG_DDACHOP_EN_REG),     //o_ECG_DDACHOP_EN), AO
  .o_ECG_DDA_ISEL(ECG_DDA_ISEL_REG),       //o_ECG_DDA_ISEL), AO
  .o_ECG_CAL_EN(ECG_CAL_EN_REG),
  .o_ECG_ELECTRODE_EN(ECG_ELECTRODE_EN_REG),

  //DC_LEAD_OFF
  .o_DC_LEAD_OFF_RMODE_EN(DC_LEAD_OFF_RMODE_EN_REG),   //o_DC_LEAD_OFF_RMODE_EN),   AO    
  .o_DC_LEAD_OFF_VIN_FLIP(DC_LEAD_OFF_VIN_FLIP_REG),   //o_DC_LEAD_OFF_VIN_FLIP), AO
//.o_DC_LEAD_OFF_ISEL(DC_LEAD_OFF_ISEL_REG),       //o_DC_LEAD_OFF_ISEL), AO
//.o_DC_LEAD_OFF_COMP_TH_EN(DC_LEAD_OFF_COMP_TH_REG), //o_DC_LEAD_OFF_COMP_TH_EN), AO
  .o_LEAD_OFF_EN(LEAD_OFF_EN_REG),         //o_DC_LEAD_OFF_EN), AO

  //TSC
  .o_TSC_OUT_SEL(TSC_OUT_SEL),             //o_BG1P2_BUF_EN),
  .o_TSC_BJT_SEL(TSC_BJT_SEL),             //o_BG1P2_BUF_EN),
  .o_TSC_EN(TSC_EN),                  //o_BG1P2_BUF_EN),
  .o_TSC_INA_GEL(TSC_GSEL),             //o_BG1P2_BUF_EN), 
  .o_TSC_INA_EN(TSC_INA_EN),

  //ANA_PPG
  .o_PPG_DAC_BUFFER_EN(spi_to_ppg_EN_PPGDAC_BUFFER),       //o_PPG_DAC_BUFFER_EN),
  .o_PPG_DAC0_VSEL(spi_to_ppg_PPG_DAC0_VSEL),           //o_PPG_DAC0_VSEL),
  .o_PPG_DAC0_EN(spi_to_ppg_PPG_DAC0_EN),             //o_PPG_DAC0_EN),
  .o_PPG_DAC1_VSEL(spi_to_ppg_PPG_DAC1_VSEL),           //o_PPG_DAC1_VSEL),
  .o_PPG_DAC1_EN(spi_to_ppg_PPG_DAC1_EN),             //o_PPG_DAC1_EN),
  .o_PPG_TIA_IDAC(spi_to_ppg_TIA_IDAC),            //o_PPG_TIA_IDAC),
  .o_PPG_TIA_GAIN(spi_to_ppg_TIA_GAIN),            //o_PPG_TIA_GAIN),
  .o_PPG_TEST_OUT(spi_to_ppg_PPG_TEST_OUT),            //o_PPG_TEST_OUT),
  .o_PPG_TEST_IN(spi_to_ppg_PPG_TEST_IN),            //o_PPG_TESET_IN),
  .o_PPG_SH_CK(spi_to_ppg_PPG_SH_CK),               //o_PPG_SH_CK),
  .o_PPG_PDV_REF_SEL(spi_to_ppg_PPG_PDV_REF_SEL),         // o_PPG_PDV_REF_SEL),
  //.o_PPG_LED_STATUS(),          //o_PPG_LED_STATUS),
  .o_PPG_LED_STANDBYEN(spi_to_ppg_LED_STANDBYEN),       //o_PPG_LED_STANDBYEN),
  .o_PPG_LED_EN(spi_to_ppg_LED_EN),              //o_PPG_LED_EN),
  .o_PPG_LED_SEL(spi_to_ppg_LEDSEL),             //o_PPG_LED_SEL),
  .o_PPG_LED_DAC_SEL(spi_to_ppg_LEDDAC_SEL),         //o_PPG_LED_DAC_SEL),
  .o_PPG_TIA_VREF_BUFFER_EN(spi_to_ppg_EN_TIA_VREFBUFFER),  //o_PPG_TIA_VREF_BUFFER_EN),
  .o_PPG_TIA_EN(spi_to_ppg_EN_TIA),              //o_PPG_TIA_EN),
  .o_PPG_SH_EN(spi_to_ppg_EN_PPG_SH),               //o_PPG_SH_EN),
  .o_PPG_BUFFER_EN(spi_to_ppg_EN_PPG_BUFFER),           //o_PPG_BUFFER_EN),
  .o_PPG_AF_EN(spi_to_ppg_EN_PPG_AF),               //o_PPG_AF_EN),
 
   //ANA_SDM
    //.o_SDM_VIN_SEL(SDM_VIN_SEL),
   // .o_SDM_CLK(SDM_CLK),
    .o_SDM_EN(SDM_EN),        
    .o_SDM_BIAS(SDM_BIAS),

    .o_Z_ADC_EN_SPI(o_Z_ADC_EN_SPI),
    .o_adc_en_sel  (o_adc_en_sel),

  //ANA_BIST
  .o_BIST_ISEL(o_BIST_ISEL),              //o_BIST_ISEL),        
  .o_BIST_EN(BIST_EN),                //o_BIST_EN),

  //ANA_SPARE
  .i_A2D_SPARE_0(A2D_SPARE_0),
  
  .i_A2D_LOFF_STATN(A2D_LOFF_STATN),         
  .i_A2D_LOFF_STATP(A2D_LOFF_STATP),         
  .i_A2D_ACLEADOFF_STATN(A2D_ACLEADOFF_STATN),         
  .i_A2D_ACLEADOFF_STATP(A2D_ACLEADOFF_STATP),
  

  //PPG_LED_STATUS
   .i_ppg_LED_STATUS (LED_STATUS),

  //DEBUG REGSISTERS from always_on      

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
 


  /*

  //ana_pmu
  .o_BG_BUF_EN(o_BG_BUF_EN),
  .o_DAC_BUF_EN(o_DAC_BUF_EN),
  //ana_tsc
  .o_TSC_EN(TSC_EN),
  .o_TSC_AMP_EN(o_TSC_AMP_EN),
  .o_TSC_BJT_SEL(TSC_BJT_SEL),
  .o_TSC_GSEL(TSC_GSEL),
  .o_TSC_OUT_SEL(TSC_OUT_SEL),
  
  //Peripheral
  .o_BIST_EN(o_BIST_EN),
  .o_BIST_ISEL(BIST_ISEL),
  .o_DDA_EN(DDA_EN),
  .o_DDA_GSEL(DDA_GSEL),
  .o_PGA_EN(PGA_EN),
  .o_PGA_VIN_SEL(PGA_VIN_SEL),
  .o_PGA_GSEL(PGA_GSEL),
  .o_ELE_BUF_EN(o_ELE_BUF_EN),
  .o_ELE_BUF_ISEL(o_ELE_BUF_ISEL),

  .o_SDM_EN(SDM_EN),
  .o_SDM_CHOP_EN(SDM_CHOP_EN),

  //xin add 2/oct/2022
  .o_Z_ADC_EN_SPI(o_Z_ADC_EN_SPI),
  //	.o_Z_DAC_EN_SPI(o_Z_DAC_EN_SPI),
  .o_adc_en_sel  (o_adc_en_sel),
  //	.o_dac_en_sel  (o_dac_en_sel),

  //analog reg values from always on
  .bg_buf_en_always_on(bg_buf_en_always_on),
  .dac_buf_en_always_on(dac_buf_en_always_on), 

  .bist_en_always_on(bist_en_always_on),
  .bist_isel_always_on(bist_isel_always_on),
  .dda_en_always_on(dda_en_always_on),
  .dda_gsel_always_on(dda_gsel_always_on),
  .ele_buf_en_always_on(ele_buf_en_always_on),
  .ele_buf_sel_always_on(ele_buf_sel_always_on),

  .bgh_vtrim_always_on(bgh_vtrim_always_on),
  .bgh_ctrim_always_on(bgh_ctrim_always_on),
  .ldo1v5_trim_always_on(ldo1v5_trim_always_on),
  .dac_buf_trim_always_on(dac_buf_trim_always_on),
  .osc_trim_always_on(osc_trim_always_on) 
  */ 

); 


nc_fifo_top
    #(.FIFO_WIDTH(18), .FIFO_DEPTH(`FIFO_SIZE), .FIFO_ERROR_MODE(0), .FIFO_RESET_MODE(0), .FIFO_ADDR_WIDTH(`FIFO_ADDR))
fifo_top (
  // clock and reset 
  //.clk(pclk),
  .clk(fifo_pclk),
  .rst_n(presetn),
  .atpg_en(atpg_en),
  .scan_en(scan_en),

  // FiFO configuration inputs
  .fifo_config_a(fifo_config3),

  .fifo_a_empty_level_a(fifo_a_empty_level),
  .fifo_a_full_level_a(fifo_a_full_level),

  .fifo_full_sts_clr_a(fifo_full_sts_clr),
  .fifo_empty_sts_clr_a(fifo_empty_sts_clr),
  .fifo_a_full_sts_clr_a(fifo_a_full_sts_clr),
  .fifo_a_empty_sts_clr_a(fifo_a_empty_sts_clr),
  .fifo_error_sts_clr_a(fifo_a_error_sts_clr),

  // Read/Write Interface
  .fifo_wr_req_n(imeas_chdata_en_n), //fifo_wr_req_n),
  .fifo_rd_req_n(fifo_rd_req_n),
  .fifo_data_i(imeas_chdata), //fifo_data_i),

  .fifo_data_o(fifo_data_o),

  // FIFO Status Outputs
  .fifo_half_full(fifo_half_full),
  .fifo_a_empty(fifo_a_empty),
  .fifo_a_full(fifo_a_full),
  .fifo_empty(fifo_empty),
  .fifo_full(fifo_full),
  .fifo_error(fifo_error),
  .fifo_intr(fifo_intr),
  .fifo_rd_pntr(fifo_rd_pntr),
  .fifo_wr_pntr(fifo_wr_pntr),
  .fifo_data_cnt(fifo_data_cnt),
  .fifo_ovf_cnt(fifo_ovf_cnt)
);

////instance
ppg_controller u_ppg_controller(

  //.OSC_256K                  (fclk), // freq is 256k
  .OSC_256K                  (ppg_ctrl_fclk), // freq is 256k
  .rst_n                     (poresetn),    // reset 
  .scan_en                   (scan_en),
  .ppg_TIA_IDAC              (spi_to_ppg_TIA_IDAC), //ppg_TIA_IDAC), //8-bit TIA IDAC
  .ppg_enable                (ppg_enable),   //ppg controller enable
  .ppg_IDAC_LED_SEL          (ppg_IDAC_LED_SEL), // two 8-bit TIA IDAC registers select; two 4-bit TIA_GAIN registers select;
  .ppg_Mode_sel              (ppg_mode_sel),   //3-bit mode select
  .ppg_TIA_GAIN              (spi_to_ppg_TIA_GAIN), //ppg_TIA_GAIN),   //4-bit TIA_GAIN                     //digital_ppg_ctrl_reg
  .ppg_led_time_sel          (ppg_LED_TIME_SEL), //the time of led enable is 1; 4 bits
  .ppg_led_Freq_sel          (ppg_LED_FREQ_SEL), //the period of led; 4 bits
//
//new added by Xin 26Mar2026
         .PPG_LED_PROG_SEL(PPG_LED_PROG_SEL),
 	 .led_on(led_on),
 	 .led_freq(led_freq),

  .sync_by_pass                     (ppg_SYNC_BYPASS),
  .spi_to_ppg_TIA_IDAC              (spi_to_ppg_TIA_IDAC         ),
  .spi_to_ppg_LEDDAC_SEL            (spi_to_ppg_LEDDAC_SEL       ),//1 bit,defalut 0
  .spi_to_ppg_LEDSEL                (spi_to_ppg_LEDSEL           ),//2 bit,defalut 0
  .spi_to_ppg_LED_STANDBYEN         (spi_to_ppg_LED_STANDBYEN    ),//1 bit,defalut 0
  .spi_to_ppg_LED_EN                (spi_to_ppg_LED_EN           ),//1 bit,defalut 0
  .spi_to_ppg_EN_PPG_AF             (spi_to_ppg_EN_PPG_AF        ),//1 bit,defalut 0
  .spi_to_ppg_PPG_SH_CK             (spi_to_ppg_PPG_SH_CK        ),//1 bit,defalut 0
  .spi_to_ppg_EN_PPG_SH             (spi_to_ppg_EN_PPG_SH        ),//1 bit,defalut 0
  .spi_to_ppg_EN_TIA                (spi_to_ppg_EN_TIA           ),//1 bit,defalut 0
  .spi_to_ppg_EN_TIA_VREFBUFFER     (spi_to_ppg_EN_TIA_VREFBUFFER),//1 bit,defalut 0
  .spi_to_ppg_TIA_GAIN              (spi_to_ppg_TIA_GAIN         ),                    //analog_ppg_reg
  .spi_to_ppg_EN_PPG_BUFFER         (spi_to_ppg_EN_PPG_BUFFER    ),//1 bit,defalut 0
  .spi_to_ppg_EN_PPGDAC_BUFFER      (spi_to_ppg_EN_PPGDAC_BUFFER ),//1 bit,defalut 0
  .spi_to_ppg_PPG_DAC0_VSEL         (spi_to_ppg_PPG_DAC0_VSEL  ),
  .spi_to_ppg_PPG_DAC0_EN           (spi_to_ppg_PPG_DAC0_EN    ),  
  .spi_to_ppg_PPG_DAC1_VSEL         (spi_to_ppg_PPG_DAC1_VSEL  ),
  .spi_to_ppg_PPG_DAC1_EN           (spi_to_ppg_PPG_DAC1_EN    ),
  .spi_to_ppg_PPG_TEST_OUT          (spi_to_ppg_PPG_TEST_OUT   ),
  .spi_to_ppg_PPG_TEST_IN           (spi_to_ppg_PPG_TEST_IN    ),
  .spi_to_ppg_PPG_PDV_REF_SEL       (spi_to_ppg_PPG_PDV_REF_SEL),
  
  .PPG_DAC0_VSEL             (PPG_DAC0_VSEL  ),
  .PPG_DAC0_EN               (PPG_DAC0_EN    ),
  .PPG_DAC1_VSEL             (PPG_DAC1_VSEL  ),
  .PPG_DAC1_EN               (PPG_DAC1_EN    ),
  .PPG_TEST_OUT              (PPG_TEST_OUT   ),
  .PPG_TEST_IN               (PPG_TEST_IN    ),
  .PPG_PDV_REF_SEL           (PPG_PDV_REF_SEL),

  .D2A_TIA_IDAC              (D2A_TIA_IDAC_REG),    
  .D2A_LEDDAC_SEL            (D2A_LEDDAC_SEL_REG),      
  .D2A_LEDSEL                (D2A_LEDSEL_REG),           
  .D2A_LED_STANDBYEN         (D2A_LED_STANDBYEN_REG),  
  .D2A_LED_EN                (D2A_LED_EN_REG),         
  .D2A_EN_PPG_AF             (D2A_EN_PPG_AF_REG),       
  .D2A_PPG_SH_CK             (D2A_PPG_SH_CK_REG),        
  .D2A_EN_PPG_SH             (D2A_EN_PPG_SH_REG),       
  .D2A_EN_TIA                (D2A_EN_TIA_REG),       
  .D2A_EN_TIA_VREFBUFFER     (D2A_EN_TIA_VREFBUFFER_REG),    
  .D2A_TIA_GAIN              (D2A_TIA_GAIN_REG),
  .D2A_EN_PPG_BUFFER         (D2A_EN_PPG_BUFFER_REG),
  .D2A_EN_PPGDAC_BUFFER      (D2A_EN_PPGDAC_BUFFER_REG),
  //.LED_STATUS                (LED_STATUS) 
  .LED_STATUS                (LED_STATUS)  


);
endmodule
