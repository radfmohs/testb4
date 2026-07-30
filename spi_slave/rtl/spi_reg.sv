//------------------------------------------------------------------------------
// Nanochap Pty Ltd (c) 2021
//
// Module Name : spi_reg
// Description : register block contains config and status registers 
//------------------------------------------------------------------------------
// Revision History
//------------------------------------------------------------------------------
// Revision     Date        Author
//------------------------------------------------------------------------------
// 0.1          20/05/2024  Jayanthi 
// Initial Rev
//------------------------------------------------------------------------------

//I-MEAS registers

`define  IMEAS_REG_CTRL_0 	8'h01
`define  IMEAS_REG_CTRL_1 	8'h02 //this is used in ECG CAL inside zmeas
`define  IMEAS_CH_MODE 		8'h03
`define  IMEAS_INT 		8'h04
`define  IMEAS_REG_SEQ 		8'h05
`define  IMEAS_REG_RSTVAL 	8'h06
`define  IMEAS_CH0DATA_0 	8'h07
`define  IMEAS_CH0DATA_1 	8'h08
`define  IMEAS_CH1DATA_0 	8'h09
`define  IMEAS_CH1DATA_1 	8'h0A
`define  IMEAS_CH2DATA_0 	8'h0B
`define  IMEAS_CH2DATA_1 	8'h0C
`define  IMEAS_GRP_CTL 	        8'h0D
`define  IMEAS_CHA_NUM_LO       8'h0E
`define  IMEAS_CHA_NUM_HI       8'h0F
`define  IMEAS_ALARM_INT 		8'h10
`define  IMEAS_ALARM_INT_EN 		8'h11
`define  IMEAS_THRESHOLD_HI_0 		8'h12
`define  IMEAS_THRESHOLD_HI_1 		8'h13
`define  IMEAS_THRESHOLD_LO_0 		8'h14
`define  IMEAS_THRESHOLD_LO_1 		8'h15
`define  IMEAS_INPUT_FORMAT 		8'h16
`define  IMEAS_EN 	                8'h17
`define  IMEAS_CH0DATA_MAX_0            8'h18
`define  IMEAS_CH0DATA_MAX_1            8'h19
`define  IMEAS_CH0DATA_MIN_0            8'h1A
`define  IMEAS_CH0DATA_MIN_1            8'h1B
`define  IMEAS_CH0DATA_DELTA_0          8'h1C
`define  IMEAS_CH0DATA_DELTA_1          8'h1D

`define  NOTCH_FILTER_EN 	        8'h1E

`define  LEADOFF_INT 		        8'h1F

//z-meas registers

`define  ZMEAS_REG_CTRL_0 	8'h20
`define  ZMEAS_REG_CTRL_1 	8'h21
`define  ZMEAS_REG_CTRL_2 	8'h22
`define  ZMEAS_REG_CTRL_3 	8'h23
`define  ZMEAS_REG_STATUS_0 	8'h24
`define  ZMEAS_REG_STATUS_1 	8'h25
`define  ZMEAS_REG_DATAOUT_0 	8'h26
`define  ZMEAS_REG_DATAOUT_1 	8'h27
`define  ZMEAS_REG_DATAOUT_2 	8'h28
`define  ZMEAS_REG_DATAOUT_3 	8'h29

`define  ZMEAS_ADC_ROM_REG_0 	8'h2A //24
`define  ZMEAS_ADC_ROM_REG_1 	8'h2B
`define  ZMEAS_ADC_ROM_REG_2 	8'h2C
`define  ZMEAS_ADC_ROM_REG_3 	8'h2D
`define  ZMEAS_SUMMATION_OFFSET_FORREAL_0 	8'h2E
`define  ZMEAS_SUMMATION_OFFSET_FORREAL_1 	8'h2F
`define  ZMEAS_SUMMATION_OFFSET_FORREAL_2 	8'h30
`define  ZMEAS_SUMMATION_OFFSET_FORREAL_3 	8'h31
`define  ZMEAS_SUMMATION_REAL_0 	8'h32
`define  ZMEAS_SUMMATION_REAL_1 	8'h33
`define  ZMEAS_SUMMATION_REAL_2 	8'h34
`define  ZMEAS_SUMMATION_REAL_3 	8'h35
`define  ZMEAS_SUMMATION_IMAG_0 	8'h36
`define  ZMEAS_SUMMATION_IMAG_1 	8'h37
`define  ZMEAS_SUMMATION_IMAG_2 	8'h38
`define  ZMEAS_SUMMATION_IMAG_3 	8'h39
`define  ZMEAS_SUMMATION_SHIFT_0 	8'h3A
`define  ZMEAS_SUMMATION_SHIFT_1 	8'h3B
`define  ZMEAS_SUMMATION_SHIFT_2 	8'h3C
`define  ZMEAS_SUMMATION_SHIFT_3 	8'h3D
`define  ZMEAS_INT 			8'h3E
`define  ZMEAS_ADC_INT 			8'h3F
`define  ZMEAS_EN 	        	8'h40
`define  ZMEAS_SYNC_EN 	                8'h41

`define ANA_Z_ADC_DAC_EN               8'h42
`define ANA_Z_ADC_DAC_EN_SEL           8'h43



//system control registers
`define  RLD_CLK_REG 	       		8'h49
`define  LEADOFF_CLK_REG 	       	8'h4A
`define  MCLK_DIV 	        	8'h4B
`define  CHECK_CLK_DIV_HI 	       	8'h4C
`define  CHECK_CLK_DIV_LO 	       	8'h4D
`define  CLK_CTRL_REG                   8'h4E
`define  PMU_REG0		        8'h4F 



//FLASH registers
`define  FLASH_DEBUG1                    8'h50
`define  FLASH_DEBUG2                    8'h51

`define  FLASH_TRIMDATA0                 8'h52 
`define  FLASH_TRIMDATA1                 8'h53
`define  FLASH_TRIMDATA2                 8'h54
`define  FLASH_TRIMDATA3                 8'h55 
`define  FLASH_TRIMDATA4                 8'h56     //1 extra trim 

//FLASH spare Registers
`define FLASH_TRIMDATA5                 8'h57
`define FLASH_TRIMDATA6                 8'h58
`define FLASH_TRIMDATA7                 8'h59
`define FLASH_TRIMDATA8                 8'h5A
`define FLASH_TRIMDATA9                 8'h5B

`define  FLASH_TRIMDATA10                8'h5C 
`define  FLASH_TRIMDATA11                8'h5D 
`define  FLASH_TRIMDATA12                8'h5E  
`define  FLASH_TRIMDATA13                8'h5F  
`define  FLASH_TRIMDATA14                8'h60 

`define  FLASH_TRIMDATA15                8'h61   //AO_spare0
`define  FLASH_TRIMDATA16                8'h62   //AO_SPARE1
`define  FLASH_TRIMDATA17                8'h63   //AO_SPARE2
`define  FLASH_TRIMDATA18                8'h64   //AO_SPARE3
`define  FLASH_TRIMDATA19                8'h65   //SW_SPARE1
`define  FLASH_TRIMDATA20                8'h66   //SW_SPARE1



//FLASH UNLOCK
 `define FLASH_UNLOCK                    8'h67
 `define FLASH_CTRL                      8'h68
 `define FLASH_DATA00                    8'h69
 `define FLASH_ADDR00                    8'h6A
 `define FLASH_ADDR01                    8'h6B
 `define FLASH_EME_DATA00                8'h6C  
 `define FLASH_RDN_ADDR                  8'h6D            
 `define FLASH_NVR_PRO_BYTE00            8'h6E
 `define FLASH_NVR_PRO_BYTE01            8'h6F
 `define FLASH_UNLOCK_PRO                8'h70


//ppg registers
 `define  PPG_REG_CTRL_1               8'h72
 `define  PPG_LED_TIME_SEL             8'H73
 `define  PPG_LED_FREQ_SEL             8'H74
 `define  PPG_LED_STATUS               8'H75

//bio electric 
`define	DATA_TYPE_SEL      	      8'h76	
`define DC_DATA_REG_0      	      8'h77	
`define DC_DATA_REG_1                 8'h78		   
`define DC_DATA_REG_C_0      	      8'h79	
`define DC_DATA_REG_C_1               8'h7A		   

/*
`define SQU_DATA_L_0       	      8'h79	   
`define SQU_DATA_L_1       	      8'h7A  
`define SQU_DATA_H_0                  8'h7B 		   
`define SQU_DATA_H_1                  8'h7C
*/
//`define SQU_CLK_DIV_0                 8'h79		
//`define SQU_CLK_DIV_1                 8'h7A	

//new added by Xin 26Mar2026 for programmable LEDon/freq
`define LED_ON_L                 8'h7B	
`define LED_ON_H                 8'h7C	
`define LED_FREQ_L                 8'h7D	
`define LED_FREQ_H                 8'h7E	



//FIFO Registers
`define  FIFO_WR_PTR_REG              8'h80
`define  FIFO_RD_PTR_REG              8'h81
`define  FIFO_COUNTER_1_REG           8'h82
`define  FIFO_COUNTER_2_REG           8'h83
`define  FIFO_CONFIG_1_REG            8'h84
`define  FIFO_CONFIG_2_REG            8'h85
`define  FIFO_CONFIG_3_REG            8'h86
`define  FIFO_STATUS_REG              8'h87
`define  FIFO_DATA_REG1               8'h88
`define  FIFO_DATA_REG2		      8'h89

//GPIO
`define  GPIO_PU_CTRL                 8'h90
`define  GPIO_PU_RESETn               8'h91
`define  GPIO_PD_TESTMODE             8'h92

//Lead off
`define LEADOFF_CTRL       		      8'h93	
`define LEADOFF_TGT_0      		      8'h94
`define LEADOFF_TGT_1      		      8'h95
`define LEADOFF_SWITCH_TGT 		      8'h96

`define NF_UNSTABLE_TIME_0             8'h97
`define NF_UNSTABLE_TIME_1             8'h98







		    

 
// `define  PPG_REG_CTRL_0            8'H85
// `define  PPG_TIA_GAIN              8'H86
 
	

 

 

//note :- to do for BAF4P1
//add analog_BUFFER registers
//no need of analog z-meas & sdm few Registers (has a statemachine in analog)
//add Aanlog ECG Registers
//add Analog lead_off
//add Analog TSC
//add Analog PPG/LED registers
//add analog BIST registers



//ANALOG REGISTERS

//BUFFER Registers
 `define ANA_TSC_1   	               8'h9f
 `define ANA_BUFFER                  8'hA0
//ECG Registers
 `define ANA_ECG_CTRL_1              8'hA1
 `define ANA_ECG_CTRL_2              8'hA2
//LEAD_OFF Rgisters
`define ANA_DC_LEAD_OFF_CTRL         8'hA3  //
//TSC Registres
`define ANA_TSC 	                   8'hA4
//PPG/LED Registers
 `define ANA_PPG_LED_SEL             8'hA5
 `define ANA_PPG_DAC0_CTRL_REG0      8'hA6
 `define ANA_PPG_DAC0_CTRL_REG1      8'hA7
 `define ANA_PPG_DAC1_CTRL_REG0      8'hA8
 `define ANA_PPG_DAC1_CTRL_REG1      8'hA9
 `define ANA_PPG_TIA_IDAC            8'hAA
 `define ANA_PPG_TIA_GAIN            8'hAB
 `define ANA_PPG_TEST_REG            8'hAC
 `define ANA_PPG_LED_EN_REG          8'hAD
 `define ANA_PPG_CTRL_REG            8'hAE

 //SDM
  `define ANA_SDM_REG               8'hAF

 //BIST
 `define ANA_BIST                   8'hB0  
 
 `define ANA_LEAD_OFF_EN            8'hB1 

//A2D_SPARE REGISTERS
 `define A2D_SPARE_REG0             8'hB2
 `define A2D_LOFF_STATN             8'hB3         
 `define A2D_LOFF_STATP             8'HB4         
 `define A2D_ACLEADOFF_STATN        8'HB5         
 `define A2D_ACLEADOFF_STATP        8'HB6 





//ALWAYS_ON_DEBUG REGISTRES
  //TRIM Values between  from Analog

`define ALWAYS_ON_ANA_TRIM1           8'hC0   //bgh_vtrim
`define ALWAYS_ON_ANA_TRIM2           8'hC1   //bgh_ctrim
`define ALWAYS_ON_ANA_TRIM3           8'hC2   //ldol15
`define ALWAYS_ON_ANA_TRIM4           8'hC3   
`define ALWAYS_ON_ANA_TRIM5           8'hC4   
`define ALWAYS_ON_ANA_TRIM6           8'hC5   
`define ALWAYS_ON_ANA_TRIM7           8'hC6   
`define ALWAYS_ON_ANA_TRIM8           8'hC7   
`define ALWAYS_ON_ANA_TRIM9           8'hC8   
`define ALWAYS_ON_ANA_TRIM10          8'hC9   

//device status 
`define DEVICE_INT_STATUS_0            8'hd0
`define DEVICE_INT_STATUS_1	       8'hd1

 
`define PHASE_INC_0            8'hE0
`define PHASE_INC_1            8'hE1
`define PHASE_INC_2            8'hE2
`define PHASE_INC_3            8'hE3
`define PHASE_OFFSET_0            8'hE4
`define PHASE_OFFSET_1            8'hE5
`define PHASE_OFFSET_2            8'hE6
`define PHASE_OFFSET_3            8'hE7
`define PHASE_OFFSET_C_0            8'hE8
`define PHASE_OFFSET_C_1            8'hE9
`define PHASE_OFFSET_C_2            8'hEA
`define PHASE_OFFSET_C_3            8'hEB
`define BIOZ_CTRL                 8'hEC

`define BIOZ_FILTER_CTRL_0          8'hED
`define BIOZ_FILTER_CTRL_1          8'hEE
`define BIOZ_FILTER_CTRL_2          8'hEF

`define DEBUG_MODE_TYPE                 8'hF0

`define INT_CTRL                  8'hF3

	                

`timescale 1ns/1ps

module spi_reg #(
	parameter ADDR_WIDTH = 8,
	parameter DATA_WIDTH = 8,
	parameter NO_TRIM_REGS = 21
)(
       spi2flash.master         spi2flash,
       spi2imeas.master         spi2imeas,

	//--inputs----
	input                  i_clk,
	input                  i_rst_n,
	input		       atpg_en,
	input [ADDR_WIDTH-1:0] i_addr,
	input                  i_wr,
	input                  i_rd,
	input [DATA_WIDTH-1:0] i_wr_data  ,
        input                  i_addr_vld_for_int_clr,
        input                  i_burst_cmd,
        input [ADDR_WIDTH-1:0] i_pre_addr,
        
	//--outputs---
	output [DATA_WIDTH-1:0] o_rd_data, 

output  wire [31:0]   phase_inc,
output  wire [31:0]   phase_offset,
output  wire [31:0]   phase_offset_c,
output  wire Bioz_en,
output  wire Bioz_reset_reg,
output  wire [15:0] iq_reg_ctrl,
output  wire [3:0]  iq_iclk_div, 
output  wire        iq_adc_clk_inv,
        
output wire [1:0]   data_type_sel,    //00 is sinwave, 01: DC, 10: square wave, 11: sinwave
output wire [9:0]   dc_data,    
output wire [9:0]   dc_data_c,    
/*
output wire [9:0]   square_data_l,    
output wire [9:0]   square_data_h,    
*/
//output wire [15:0]  square_clk_div,

     
     //system outputs
	//inputs from other blocks
       

      

    //z-meas
       	input  wire[15:0]  i_zmeas_reg_status,
	input  wire[31:0]  i_zmeas_reg_dataout,
	input wire [9:0]   i_zmeas_xn_data,
	input wire [9:0]   i_zmeas_sine_for_dft,
	input wire [9:0]   i_zmeas_cosine_for_dft,
	input wire[28:0]   i_zmeas_summation_offset_forreal,
	input wire[28:0]   i_zmeas_summation_real,
	input wire[28:0]   i_zmeas_summation_imag,
	input wire[16:0]   i_zmeas_shiftedreal_inter,
	input wire[11:0]   i_zmeas_dft_cnt,
	input wire         i_reg_zmeas_int,
	input wire         i_reg_zmeas_adc_int,

        output wire         o_config_zmeas_ctrl_reg,   
        output wire         o_meas_sync_en,
        output wire         o_zmeas_en,
        output wire         o_zmeas_phase_dither_en,
	output reg          o_zmeas_int_clr,
	output reg          o_zmeas_adc_int_clr,
	output wire[31:0]   o_zmeas_reg_ctrl,

     //clk_ctrl
	output  wire 	     SDM_CLK_GPIO_pha_sel,
	output  wire  [1:0]  acleadoff_clk_sel,
	output  reg   [1:0]  rld_clk_reg,
	output  wire         o_fclk_dynen,
	output  wire  [1:0]  o_pclk_div,
	output  wire  [2:0]  o_iclk_div,
	output  wire  [7:0]  o_mclk_div,
	output  wire  [15:0]  o_checking_clk_div,
        output  wire         o_imeas_adc_inv,
        output  wire         o_always_on_spi_write,

	output wire        o_adc_en_sel  ,
	output wire        o_Z_ADC_EN_SPI, 


   //to always on
    //    output wire        o_fclk_dynen_flash,
    //    output wire        o_dc_dc_en_flash, 
     //   output wire [2:0]  o_dc_clk_div_flash,

   //from always on
    //    input              i_fclk_dynen_always_on,   //input From always on block for always_on_clk_ctrl_debug_register
    //    input              i_dc_dc_en_always_on,     //input From always on block for always_on_clk_ctrl_debug_register
    //    input  [2:0]       i_dc_clk_div_always_on,   //input From always on block for always_on_clk_ctrl_debug_register
       
  //PMU
        output wire 	   bio_disable,
        output wire 	   ppg_ctrl_disable,
	output  wire       o_pmuenable,            // pmu enable
	output  wire       o_hresetreq,            // system reset request
	output  wire       o_sleepdeep,            // system enters deep-sleep state
	output  wire       o_flash_dpstb_en,        // flash deep power down standby mode enable 
        output  wire       o_fifo_disable,
     //   output  wire       o_fclk_sleep_en,

  //FIFO
       input wire  [6:0]  i_fifo_rd_ptr,
       input wire  [6:0]  i_fifo_wr_ptr,
       input wire         i_fifo_a_empty,
       input wire         i_fifo_empty,
       input wire         i_fifo_a_full,
   
       input wire         i_fifo_full,
       input wire         i_fifo_error,
       input wire  [7:0]  i_fifo_data_cnt,
       input wire  [6:0]  i_fifo_ovf_cnt,
       input wire  [17:0] i_rd_fifo_data,
       output      [7:0]  o_fifo_config3,
       output wire [7:0]  o_fifo_a_full_level,
       output wire [7:0]  o_fifo_a_empty_level,

       output reg        o_fifo_full_sts_clr,
       output reg        o_fifo_empty_sts_clr,
       output reg        o_fifo_a_full_sts_clr,
       output reg        o_fifo_a_empty_sts_clr,
       output reg        o_fifo_a_error_sts_clr,

//PPG
   //   output reg   [7:0] o_ppg_TIA_IDAC,  
      output wire         o_ppg_enable, 
      output wire         o_ppg_IDAC_LED_SEL,
      output wire   [2:0] o_ppg_mode_sel,
    //  output reg   [3:0] o_ppg_TIA_GAIN,
      output wire   [3:0] o_ppg_LED_TIME_SEL,
      output wire   [3:0] o_ppg_LED_FREQ_SEL,
      output wire         o_PPG_SYNC_BYPASS,
      input  wire         i_ppg_LED_STATUS,

//new added by Xin 26Mar2026
      output wire         o_PPG_LED_PROG_SEL,
 	output reg   [13:0] led_on,
 	output reg   [13:0] led_freq,
 
     //analog register outputs
    //ana_buffer
      output wire       o_BG1P2_BUF_EN,     
      output wire       o_VCM1P5_BUF_EN,
      output wire       o_RLD_AMP_EN,
      output wire       o_RLD_CHOP_EN,
      output wire       o_ECG_ELECTRODE_EN,

    //ECG
     output wire        o_ECG_PGA_EN,
     output wire        o_ECG_LPF_EN,
     output wire  [2:0] o_ECG_PGA_GSEL, 
     output wire  [1:0] o_ECG_DDA_CLKSEL,
     output wire        o_ECG_DDA_EN,
     output wire  [2:0] o_ECG_DDA_GSEL,
     output wire        o_ECG_DDACHOP_EN,
     output wire  [1:0] o_ECG_DDA_ISEL,
     output wire        o_ECG_CAL_EN,
     
   
 //DC_LEAD_OFF
    output wire         o_DC_LEAD_OFF_RMODE_EN,      
    output wire         o_DC_LEAD_OFF_VIN_FLIP,
  //output wire  [1:0]  o_DC_LEAD_OFF_ISEL,  
  //output wire  [2:0]  o_DC_LEAD_OFF_COMP_TH_EN,
    output wire  [1:0]  o_LEAD_OFF_EN,

//TSC
   output wire         o_TSC_OUT_SEL,
   output wire  [2:0]  o_TSC_BJT_SEL,
   output wire         o_TSC_EN,
   output wire  [2:0]  o_TSC_INA_GEL, 
   output wire         o_TSC_INA_EN,

 //ANA_PPG
   output wire         o_PPG_DAC_BUFFER_EN,
   output wire  [11:0] o_PPG_DAC0_VSEL,
   output wire         o_PPG_DAC0_EN,
   output wire  [11:0] o_PPG_DAC1_VSEL,
   output wire         o_PPG_DAC1_EN,
   output wire  [7:0]  o_PPG_TIA_IDAC,
   output wire  [3:0]  o_PPG_TIA_GAIN,
   output wire  [1:0]  o_PPG_TEST_OUT,
   output wire  [1:0]  o_PPG_TEST_IN,
   output wire         o_PPG_SH_CK,
   output wire  [1:0]  o_PPG_PDV_REF_SEL,
   //output wire         o_PPG_LED_STATUS,
   output wire         o_PPG_LED_STANDBYEN,
    output wire         o_PPG_LED_EN,
   output wire  [1:0]  o_PPG_LED_SEL,
   output wire         o_PPG_LED_DAC_SEL,
   output wire         o_PPG_TIA_VREF_BUFFER_EN,
   output wire         o_PPG_TIA_EN,
   output wire         o_PPG_SH_EN,
   output wire         o_PPG_BUFFER_EN,
   output wire         o_PPG_AF_EN,

//ANA_SDM
 //  output wire  [2:0] o_SDM_VIN_SEL,
 //  output wire        o_SDM_CLK,
   output wire        o_SDM_EN,
   output wire   [1:0] o_SDM_BIAS,
   
//ANA_BIST
    output wire  [2:0] o_BIST_ISEL,        
    output wire        o_BIST_EN,

//A2D_SPARE
   input wire [7:0] i_A2D_SPARE_0,
   input wire       i_A2D_LOFF_STATN,         
   input wire       i_A2D_LOFF_STATP,         
   input wire       i_A2D_ACLEADOFF_STATN,         
   input wire       i_A2D_ACLEADOFF_STATP, 

//gpio
  output wire [2:0] gpio_pu_ctrl,
  output wire       gpio_pu_resetn,
  output wire [1:0] gpio_pd_testmode,

//trim from always on
/*
 input wire [4:0] trim1_always_on, //bgh_vtrim_always_on,
 input wire [6:0] trim2_always_on, //bgh_ctrim_always_on,
 input wire [1:0] trim3_always_on, //ldo1v5_trim_always_on,
 input wire [5:0] trim4_always_on  //osc_trim_always_on
*/
 input wire [7:0]   trim1_always_on, // bgh_vtrim_always_on,
 input wire [7:0]   trim2_always_on, // bgh_ctrim_always_on,
 input wire [7:0]   trim3_always_on, // ldo1v5_trim_always_on,
 input wire [7:0]   trim4_always_on, // osc_trim_always_on
 input wire [7:0]   trim5_always_on,
 input wire [7:0]   trim6_always_on,
 input wire [7:0]   trim7_always_on,
 input wire [7:0]   trim8_always_on,
 input wire [7:0]   trim9_always_on,
 input wire [7:0]   trim10_always_on 


   

  );


//----- registers * internalsignal declaration---//
reg [7:0]  reg_rd_data;
reg         zmeas_en;
reg         zmeas_phase_dither_en;
reg         meas_sync_en;

 reg [1:0]   data_type_sel_reg;    //00 is sinwave, 01: DC, others: sinwave
 reg [7:0]   dc_data_reg_0;    
 reg [1:0]   dc_data_reg_1;    
 reg [7:0]   dc_data_reg_c_0;    
 reg [1:0]   dc_data_reg_c_1;    

 reg [7:0]   phase_inc_0;    
 reg [7:0]   phase_inc_1;    
 reg [7:0]   phase_inc_2;    
 reg [7:0]   phase_inc_3;    
 reg [7:0]   phase_offset_0;    
 reg [7:0]   phase_offset_1;    
 reg [7:0]   phase_offset_2;    
 reg [7:0]   phase_offset_3;    
 reg [7:0]   phase_offset_c_0;    
 reg [7:0]   phase_offset_c_1;    
 reg [7:0]   phase_offset_c_2;    
 reg [7:0]   phase_offset_c_3;    
 reg [7:0]   bioz_ctrl;    
 reg [7:0]   bioz_filter_ctrl_0;    
 reg [7:0]   bioz_filter_ctrl_1;    
 reg [7:0]   bioz_filter_ctrl_2;    


/*
 reg [7:0]   square_data_l_reg_0;    
 reg [1:0]   square_data_l_reg_1;    
 reg [7:0]   square_data_h_reg_0;    
 reg [1:0]   square_data_h_reg_1;    
*/
 //reg [7:0]  square_clk_div_0;
// reg [7:0]  square_clk_div_1;

 assign  data_type_sel = data_type_sel_reg;    //00 is sinwave, 01: DC, others: sinwave
 assign  dc_data   = {dc_data_reg_1,dc_data_reg_0};    
 assign  dc_data_c = {dc_data_reg_c_1,dc_data_reg_c_0};    


assign phase_inc = {phase_inc_3,phase_inc_2,phase_inc_1,phase_inc_0};    
assign phase_offset = {phase_offset_3,phase_offset_2,phase_offset_1,phase_offset_0};    
assign phase_offset_c = {phase_offset_c_3,phase_offset_c_2,phase_offset_c_1,phase_offset_c_0};    
assign Bioz_en = bioz_ctrl[0];
assign Bioz_reset_reg = bioz_ctrl[1];
assign iq_reg_ctrl = {bioz_filter_ctrl_1,bioz_filter_ctrl_0};
assign iq_iclk_div = bioz_filter_ctrl_2[3:0];
assign iq_adc_clk_inv = bioz_filter_ctrl_2[4];
/*
 assign  square_data_l = {square_data_l_reg_1,square_data_l_reg_0};    
 assign  square_data_h = {square_data_h_reg_1,square_data_h_reg_0};    
*/
// assign  square_clk_div = {square_clk_div_1,square_clk_div_0};


//imeas interrupt signals
 wire zmeas_int_clr_reg;
 wire zmeas_adc_int_clr_reg;


reg ana_z_adc_dac_en;
reg ana_z_adc_dac_en_sel; //0 is privious enable, 1 is register control enable
assign       o_adc_en_sel          = ana_z_adc_dac_en_sel;
assign       o_Z_ADC_EN_SPI        = ana_z_adc_dac_en;

//zmeas
 reg[7:0] zmeas_reg_ctrl_0;    
 reg[7:0] zmeas_reg_ctrl_1;    
 reg[7:0] zmeas_reg_ctrl_2;    
 reg[7:0] zmeas_reg_ctrl_3;    

 
//clk_ctr_reg
reg [7:0]  clk_ctrl_reg;
reg [2:0]  leadoff_clk_reg;
assign acleadoff_clk_sel = leadoff_clk_reg[1:0];
assign 	     SDM_CLK_GPIO_pha_sel = leadoff_clk_reg[2];

reg [7:0]  mclk_div_reg;
assign  o_mclk_div = mclk_div_reg; 
//assign  o_mclk_div = 1;  //debug

reg [7:0]  checking_clk_div_reg_lo;
reg [7:0]  checking_clk_div_reg_hi;
assign  o_checking_clk_div = {checking_clk_div_reg_hi,checking_clk_div_reg_lo}; 

//fifo regsiters
reg [7:0]  reg_fifo_config_1;
reg [7:0]  reg_fifo_config_2;
reg [7:0]  reg_fifo_config_3;

wire  fifo_full_sts_clr;
wire  fifo_empty_sts_clr;
wire  fifo_a_full_sts_clr;
wire  fifo_a_empty_sts_clr;
wire  fifo_a_error_sts_clr;

reg [1:0] int_ctrl_reg;

//pmu
reg [6:0] pmu_reg0;

//flash
//reg   [7:0] flash_config;
//wire [15:0] DEBUG_FLASH_sync;
wire        FLASH_busy_sync;
wire        FLASH_Reset_Done_sync;

wire         reg_reg_zmeas_adc_int;

//always_on_clk_ctrl
//reg[7:0]  always_on_clk_ctrl_reg ;



 
//analog registers 
 
//ana i-meas ch1
 reg [5:0]  ana_imeas_ch1_we1_0;
 reg [5:0]  ana_imeas_ch1_we1_1;
 reg [5:0]  ana_imeas_ch1_we2_0;
 reg [5:0]  ana_imeas_ch1_we2_1;
 reg [3:0]  ana_imeas_ch1_rce_routsel;
 reg        ana_imeas_ch1_we_dac_en;
 reg[7:0]   ana_imeas_ch1_dinwe_0;
 reg[1:0]   ana_imeas_ch1_dinwe_1;
 reg        ana_imeas_ch1_rce_dac_en;
 reg [7:0]  ana_imeas_ch1_dinrce_0;
 reg [1:0]  ana_imeas_ch1_dinrce_1;


 
////////----imeas &zmeas interrupts------/////

assign   zmeas_int_clr_reg      = (i_addr[ADDR_WIDTH-1:0] == `ZMEAS_INT) &  i_wr & i_wr_data[0] ;
//assign   zmeas_adc_int_clr_reg  = (i_addr[ADDR_WIDTH-1:0] == `ZMEAS_ADC_INT) &  i_wr & i_wr_data[0] ;
assign   zmeas_adc_int_clr_reg  =  ((i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_ADC_ROM_REG_0 ||i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_ADC_ROM_REG_1 ||i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_ADC_ROM_REG_2 || i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_ADC_ROM_REG_3
                                   ||i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_OFFSET_FORREAL_0 ||i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_OFFSET_FORREAL_1 ||i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_OFFSET_FORREAL_2 || i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_OFFSET_FORREAL_3
                                   || i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_REAL_0 || i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_REAL_1 || i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_REAL_2 || i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_REAL_3
                                   ||i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_IMAG_0 || i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_IMAG_1 || i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_IMAG_2 || i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_IMAG_3 
                                   || i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_SHIFT_0 || i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_SHIFT_1 || i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_SHIFT_2 || i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_SUMMATION_SHIFT_3)
                                    &&  !i_wr  && reg_reg_zmeas_adc_int && i_addr_vld_for_int_clr && (~(i_burst_cmd & i_pre_addr[ADDR_WIDTH-1:0] ==`ZMEAS_REG_DATAOUT_3 & i_addr[ADDR_WIDTH-1:0] ==`ZMEAS_ADC_ROM_REG_0)));   //clear adc_int if any of the z-meas debug registers are read


wire   config_zmeas_ctrl0  = (i_addr[ADDR_WIDTH-1:0] == `ZMEAS_REG_CTRL_0) &  i_wr ;
wire   config_zmeas_ctrl1  = (i_addr[ADDR_WIDTH-1:0] == `ZMEAS_REG_CTRL_1) &  i_wr ;
wire   config_zmeas_ctrl2  = (i_addr[ADDR_WIDTH-1:0] == `ZMEAS_REG_CTRL_2) &  i_wr ;
wire   config_zmeas_ctrl3  = (i_addr[ADDR_WIDTH-1:0] == `ZMEAS_REG_CTRL_3) &  i_wr ;

reg config_zmeas_ctrl_reg;
always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)
	config_zmeas_ctrl_reg <= 1'b0;
  else if (config_zmeas_ctrl0 | config_zmeas_ctrl1 |
	  config_zmeas_ctrl2  | config_zmeas_ctrl3)
	config_zmeas_ctrl_reg <= ~config_zmeas_ctrl_reg;
end

assign o_config_zmeas_ctrl_reg =config_zmeas_ctrl_reg;



//assign o_zmeas_int_clr     = zmeas_int_clr_reg;
always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)
    o_zmeas_int_clr <= 1'b0;
 else
  o_zmeas_int_clr <= zmeas_int_clr_reg;
end

//assign o_zmeas_adc_int_clr = zmeas_adc_int_clr_reg;
always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)
    o_zmeas_adc_int_clr <= 1'b0;
 else
  o_zmeas_adc_int_clr <= zmeas_adc_int_clr_reg;
end




//--------------------------------------------//
//FIFO Interrupt clear
//--------------------------------------------//

assign fifo_full_sts_clr    = (i_addr[ADDR_WIDTH-1:0] == `FIFO_STATUS_REG) &  i_wr & i_wr_data[3] ;
assign fifo_empty_sts_clr   = (i_addr[ADDR_WIDTH-1:0] == `FIFO_STATUS_REG) &  i_wr & i_wr_data[4] ;
assign fifo_a_full_sts_clr  = (i_addr[ADDR_WIDTH-1:0] == `FIFO_STATUS_REG) &  i_wr & i_wr_data[5] ;
assign fifo_a_empty_sts_clr = (i_addr[ADDR_WIDTH-1:0] == `FIFO_STATUS_REG) &  i_wr & i_wr_data[6] ;
assign fifo_a_error_sts_clr = (i_addr[ADDR_WIDTH-1:0] == `FIFO_STATUS_REG) &  i_wr & i_wr_data[7] ;

//assign o_fifo_full_sts_clr    = fifo_full_sts_clr;
//assign o_fifo_empty_sts_clr   = fifo_empty_sts_clr;
//assign o_fifo_a_full_sts_clr  = fifo_a_full_sts_clr;
//assign o_fifo_a_empty_sts_clr = fifo_a_empty_sts_clr;
//assign o_fifo_a_error_sts_clr = fifo_a_error_sts_clr;

always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n) begin
    o_fifo_full_sts_clr    <= 1'b0;
    o_fifo_empty_sts_clr   <= 1'b0;
    o_fifo_a_full_sts_clr  <= 1'b0;
    o_fifo_a_empty_sts_clr <= 1'b0;
    o_fifo_a_error_sts_clr <= 1'b0;
 end
 else begin
    o_fifo_full_sts_clr    <= fifo_full_sts_clr;
    o_fifo_empty_sts_clr   <= fifo_empty_sts_clr;
    o_fifo_a_full_sts_clr  <= fifo_a_full_sts_clr;
    o_fifo_a_empty_sts_clr <= fifo_a_empty_sts_clr;
    o_fifo_a_error_sts_clr <= fifo_a_error_sts_clr;
 end
end


//------------------------------------------------------------------------------------
//------------------------------------config register write---------------------------
//------------------------------------------------------------------------------------


  
// reg   [7:0] reg_ppg_ctrl_0;
 reg   [6:0] reg_ppg_ctrl_1;
// reg   [3:0] reg_ppg_TIA_GAIN;
 reg   [3:0] reg_ppg_LED_TIME_SEL;
 reg   [3:0] reg_ppg_LED_FREQ_SEL;

 //reg   [13:0] led_on;
 //reg   [13:0] led_freq;

 //analog registers
 reg [4:0] ana_buffer;
 reg [7:0] ana_ecg_ctrl_1;
 reg [6:0] ana_ecg_ctrl_2;
 reg [1:0] ana_dc_lead_off_ctrl;
 reg [1:0] ana_lead_off_en;
 reg [7:0] ana_tsc;
 reg       ana_tsc_1;
 reg [2:0] ana_ppg_led_sel_reg;
 reg [7:0] ana_ppg_dac0_ctrl_reg0;
 reg [4:0] ana_ppg_dac0_ctrl_reg1;
 reg [7:0] ana_ppg_dac1_ctrl_reg0;
 reg [4:0] ana_ppg_dac1_ctrl_reg1;
 reg [7:0] ana_ppg_tia_idac;
 reg [3:0] ana_ppg_tia_gain;
 reg [5:0] ana_ppg_test_reg;
 reg [5:0] ana_ppg_led_en_reg;
 reg [2:0] ana_ppg_ctrl_reg;
 reg [3:0] ana_bist;
 reg [2:0] ana_sdm_reg;

 
always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)begin
   //i_meas    
     zmeas_en              <= 1'b0;
     zmeas_phase_dither_en <= 1'b0; 
     meas_sync_en          <= 1'b1; 

    data_type_sel_reg <= 2'b0;    //00 is sinwave, 01: DC, others: sinwave
    dc_data_reg_0 <= 8'h0;    
    dc_data_reg_1 <= 2'h1;    
    dc_data_reg_c_0 <= 8'h0;    
    dc_data_reg_c_1 <= 2'h1;    

 phase_inc_0 <= 8'h66;    
 phase_inc_1 <= 8'h66;    
 phase_inc_2 <= 8'h66;    
 phase_inc_3 <= 8'h06;    
 phase_offset_0 <= 8'h0;    
 phase_offset_1 <= 8'h0;    
 phase_offset_2 <= 8'h0;    
 phase_offset_3 <= 8'h0;    
 phase_offset_c_0 <= 8'h0;    
 phase_offset_c_1 <= 8'h0;    
 phase_offset_c_2 <= 8'h0;    
 phase_offset_c_3 <= 8'h0;    
 bioz_ctrl <= 8'h1;    
 bioz_filter_ctrl_0 <= 8'h05;    
 bioz_filter_ctrl_1 <= 8'h45;    
 bioz_filter_ctrl_2 <= 8'h0;    

/*
    square_data_l_reg_0 <= 8'h0;    
    square_data_l_reg_1 <= 2'h0;    
    square_data_h_reg_0 <= 8'h0;    
    square_data_h_reg_1 <= 2'h1;    
*/
   // square_clk_div_0 <= 8'hf;
   // square_clk_div_1 <= 8'h0;
   
  //zmeas ctrl
      zmeas_reg_ctrl_0    <=8'h00;    
      zmeas_reg_ctrl_1    <=8'h00;    
      zmeas_reg_ctrl_2    <=8'h01;    
      zmeas_reg_ctrl_3    <=8'h00;
     
   //pmu ctrl
     pmu_reg0             <= 7'b000_0001;  

  //flash
    //  flash_config        <= 8'h00;

  //clk_ctrl
     //clk_ctrl_reg         <= 8'h00; 
     clk_ctrl_reg         <= 8'h10; 
     //leadoff_clk_reg     <= 3'b001; 
     leadoff_clk_reg     <= 3'b010; 
     rld_clk_reg         <= 2'b00; 

     //mclk_div_reg        <= 8'h13; 
     mclk_div_reg        <= 8'h0; 
     checking_clk_div_reg_lo        <= 8'he7; 
     checking_clk_div_reg_hi        <= 8'h3; 

 //alwasy on
     //always_on_clk_ctrl_reg <= 8'h00;

  //fifo config reg
   reg_fifo_config_1      <= 8'h5F;
   reg_fifo_config_2      <= 8'h1F;
   reg_fifo_config_3      <= 8'h00;

  //PPG
   //  reg_ppg_ctrl_0          <= 8'h0;
     reg_ppg_ctrl_1          <= 7'h0;
     //reg_ppg_TIA_GAIN        <= 4'h0; 
     reg_ppg_LED_TIME_SEL    <= 4'h0;
     reg_ppg_LED_FREQ_SEL    <= 4'h0;

 	led_on   <= 14'd0;
 	led_freq   <= 14'd0;

 
   //analog_regsiters
     ana_buffer               <= 5'h0;
     ana_ecg_ctrl_1           <= 8'h3;
     ana_ecg_ctrl_2           <= 7'h04;
     ana_dc_lead_off_ctrl     <= 2'B0; 
     ana_lead_off_en          <= 2'h0;
     ana_tsc                  <= 8'h0;   
     ana_tsc_1                <= 1'b0;   
 
   //ana_ppg
    ana_ppg_led_sel_reg      <= 3'b0;
    ana_ppg_dac0_ctrl_reg0   <= 8'h0;
    ana_ppg_dac0_ctrl_reg1   <= 5'h0;
    ana_ppg_dac1_ctrl_reg0   <= 8'h0;
    ana_ppg_dac1_ctrl_reg1   <= 5'h0;
    ana_ppg_tia_idac         <= 8'h0;
    ana_ppg_tia_gain         <= 4'h0;
    ana_ppg_test_reg         <= 6'h0;
    ana_ppg_led_en_reg       <= 6'h0;
    ana_ppg_ctrl_reg         <= 3'h0;
    ana_bist                 <= 4'h0;
    ana_sdm_reg              <= 3'h0;

     ana_z_adc_dac_en         <= 1'h0;
  ana_z_adc_dac_en_sel     <= 1'h0;

  end
  else begin
      case(i_addr[ADDR_WIDTH-1:0])   	
 
        //imeas
   
           //imeas ctrl
            `ZMEAS_EN           : {zmeas_phase_dither_en,zmeas_en}  <= i_wr ? i_wr_data[1:0] : {zmeas_phase_dither_en, zmeas_en};
            `ZMEAS_SYNC_EN       : meas_sync_en              <= i_wr ? i_wr_data[0]   : meas_sync_en;  

	    `DATA_TYPE_SEL      : data_type_sel_reg 	    <= i_wr ? i_wr_data[1:0]   : data_type_sel_reg;    //00 is sinwave, 01: DC, 10: square wave, 11: sinwave
    	    `DC_DATA_REG_0      : dc_data_reg_0 	    <= i_wr ? i_wr_data[7:0]   : dc_data_reg_0;    
    	    `DC_DATA_REG_1      : dc_data_reg_1 	    <= i_wr ? i_wr_data[1:0]   : dc_data_reg_1;    
    	    `DC_DATA_REG_C_0      : dc_data_reg_c_0 	    <= i_wr ? i_wr_data[7:0]   : dc_data_reg_c_0;    
    	    `DC_DATA_REG_C_1      : dc_data_reg_c_1 	    <= i_wr ? i_wr_data[1:0]   : dc_data_reg_c_1;    

 `PHASE_INC_0      : phase_inc_0 <= i_wr ? i_wr_data[7:0]   : phase_inc_0;    
 `PHASE_INC_1      : phase_inc_1 <= i_wr ? i_wr_data[7:0]   : phase_inc_1;    
 `PHASE_INC_2      : phase_inc_2 <= i_wr ? i_wr_data[7:0]   : phase_inc_2;    
 `PHASE_INC_3      : phase_inc_3 <= i_wr ? i_wr_data[7:0]   : phase_inc_3;    
 `PHASE_OFFSET_0   : phase_offset_0 <= i_wr ? i_wr_data[7:0]   : phase_offset_0;    
 `PHASE_OFFSET_1   : phase_offset_1 <= i_wr ? i_wr_data[7:0]   : phase_offset_1;    
 `PHASE_OFFSET_2   : phase_offset_2 <= i_wr ? i_wr_data[7:0]   : phase_offset_2;    
 `PHASE_OFFSET_3   : phase_offset_3 <= i_wr ? i_wr_data[7:0]   : phase_offset_3;    
 `PHASE_OFFSET_C_0   : phase_offset_c_0 <= i_wr ? i_wr_data[7:0]   : phase_offset_c_0;    
 `PHASE_OFFSET_C_1   : phase_offset_c_1 <= i_wr ? i_wr_data[7:0]   : phase_offset_c_1;    
 `PHASE_OFFSET_C_2   : phase_offset_c_2 <= i_wr ? i_wr_data[7:0]   : phase_offset_c_2;    
 `PHASE_OFFSET_C_3   : phase_offset_c_3 <= i_wr ? i_wr_data[7:0]   : phase_offset_c_3;    
 `BIOZ_CTRL        : bioz_ctrl      <= i_wr ? i_wr_data[7:0]   : bioz_ctrl;    
`BIOZ_FILTER_CTRL_0  :   bioz_filter_ctrl_0      <= i_wr ? i_wr_data[7:0]   : bioz_filter_ctrl_0;      
`BIOZ_FILTER_CTRL_1  :   bioz_filter_ctrl_1      <= i_wr ? i_wr_data[7:0]   : bioz_filter_ctrl_1;        
`BIOZ_FILTER_CTRL_2  :   bioz_filter_ctrl_2      <= i_wr ? i_wr_data[7:0]   : bioz_filter_ctrl_2;         




/*
    	    `SQU_DATA_L_0       : square_data_l_reg_0 	    <= i_wr ? i_wr_data[7:0]   : square_data_l_reg_0;    
    	    `SQU_DATA_L_1       : square_data_l_reg_1 	    <= i_wr ? i_wr_data[1:0]   : square_data_l_reg_1;    
    	    `SQU_DATA_H_0       : square_data_h_reg_0 	    <= i_wr ? i_wr_data[7:0]   : square_data_h_reg_0;    
    	    `SQU_DATA_H_1       : square_data_h_reg_1 	    <= i_wr ? i_wr_data[1:0]   : square_data_h_reg_1;    
*/

    	    //`SQU_CLK_DIV_0      : square_clk_div_0 	    <= i_wr ? i_wr_data[7:0]   : square_clk_div_0;
    	    //`SQU_CLK_DIV_1      : square_clk_div_1 	    <= i_wr ? i_wr_data[7:0]   : square_clk_div_1;

     //zmeas ctrl
          `ZMEAS_REG_CTRL_0    :  zmeas_reg_ctrl_0          <= i_wr ? {i_wr_data[7:4],1'b0,i_wr_data[2],1'b0,i_wr_data[0] }:  zmeas_reg_ctrl_0  ;
	  `ZMEAS_REG_CTRL_1    :  zmeas_reg_ctrl_1          <= i_wr ? {i_wr_data[7:4],1'b0,i_wr_data[2],1'b0,i_wr_data[0]} :  zmeas_reg_ctrl_1; 
	  `ZMEAS_REG_CTRL_2    :  zmeas_reg_ctrl_2          <= i_wr ? {i_wr_data[7:4],1'b0,i_wr_data[2:0]} :  zmeas_reg_ctrl_2; 
	  `ZMEAS_REG_CTRL_3    :  zmeas_reg_ctrl_3          <= i_wr ? i_wr_data[7:0] :  zmeas_reg_ctrl_3; 
    //pmu
            `PMU_REG0          : pmu_reg0                   <= i_wr ?  i_wr_data[6:0] : pmu_reg0[6:0];
    //flash
//	    `FLASH_CONFIG      :flash_config                <= i_wr ?  i_wr_data[7:0] : flash_config;
    //clk_ctrl  
            `CLK_CTRL_REG      : clk_ctrl_reg               <=  i_wr ?  i_wr_data[7:0] :clk_ctrl_reg;
            `LEADOFF_CLK_REG   : leadoff_clk_reg            <=  i_wr ?  i_wr_data[2:0] :leadoff_clk_reg;
            `RLD_CLK_REG       : rld_clk_reg            <=  i_wr ?  i_wr_data[1:0] : rld_clk_reg;
            `MCLK_DIV          : mclk_div_reg               <=  i_wr ?  i_wr_data[7:0] :mclk_div_reg;
            `CHECK_CLK_DIV_LO          : checking_clk_div_reg_lo               <=  i_wr ?  i_wr_data[7:0] :checking_clk_div_reg_lo;
            `CHECK_CLK_DIV_HI          : checking_clk_div_reg_hi               <=  i_wr ?  i_wr_data[7:0] :checking_clk_div_reg_hi[7:0];
   //alwasy on
       //    `ALWAYS_ON_CLK_CTRL :always_on_clk_ctrl_reg      <=  i_wr ?  i_wr_data[7:0] :always_on_clk_ctrl_reg;
    
     //FIFO
            `FIFO_CONFIG_1_REG  :  reg_fifo_config_1        <= i_wr ? i_wr_data[7:0] : reg_fifo_config_1;
            `FIFO_CONFIG_2_REG  :  reg_fifo_config_2        <= i_wr ? i_wr_data[7:0] : reg_fifo_config_2;
            `FIFO_CONFIG_3_REG  :  reg_fifo_config_3        <= i_wr ? i_wr_data[7:0] : reg_fifo_config_3;  //with,fifo_error_en[7], tag en[bit[2]]


    //PPG
      //     `PPG_REG_CTRL_0      :  reg_ppg_ctrl_0            <= i_wr ? i_wr_data[7:0] : reg_ppg_ctrl_0;
           `PPG_REG_CTRL_1      :  reg_ppg_ctrl_1            <= i_wr ? i_wr_data[6:0] : reg_ppg_ctrl_1 ; //{reg_ppg_mode_sel[2:0],reg_ppg_IDAC_LED_SEL,reg_ppg_enable};
         //`  `PPG_TIA_GAIN    	:  reg_ppg_TIA_GAIN          <= i_wr ? i_wr_data[3:0] : reg_ppg_TIA_GAIN;
           `PPG_LED_TIME_SEL	:  reg_ppg_LED_TIME_SEL      <= i_wr ? i_wr_data[3:0] : reg_ppg_LED_TIME_SEL;
           `PPG_LED_FREQ_SEL    :  reg_ppg_LED_FREQ_SEL      <= i_wr ? i_wr_data[3:0] : reg_ppg_LED_FREQ_SEL;

	`LED_ON_L               :  led_on[7:0]   <= i_wr ? i_wr_data[7:0] : led_on[7:0]; 
	`LED_ON_H               :  led_on[13:8]  <= i_wr ? i_wr_data[5:0] : led_on[13:8]; 
	`LED_FREQ_L             :  led_freq[7:0]   <= i_wr ? i_wr_data[7:0] : led_freq[7:0];	
	`LED_FREQ_H             :  led_freq[13:8]  <= i_wr ? i_wr_data[5:0] : led_freq[13:8]; 	
	                
    //ANALOG Registers
    
        
        `ANA_BUFFER             :  ana_buffer                <= i_wr ? i_wr_data[4:0] : ana_buffer; 
        `ANA_ECG_CTRL_1         :  ana_ecg_ctrl_1            <= i_wr ? i_wr_data[7:0] : ana_ecg_ctrl_1;
        `ANA_ECG_CTRL_2         :  ana_ecg_ctrl_2            <= i_wr ? i_wr_data[6:0] : ana_ecg_ctrl_2;
        `ANA_DC_LEAD_OFF_CTRL   :  ana_dc_lead_off_ctrl      <= i_wr ? i_wr_data[1:0] : ana_dc_lead_off_ctrl;
        `ANA_LEAD_OFF_EN        :  ana_lead_off_en           <= i_wr ? i_wr_data[1:0] : ana_lead_off_en;
        `ANA_TSC                :  ana_tsc                   <= i_wr ? i_wr_data[7:0] : ana_tsc;
        `ANA_TSC_1              :  ana_tsc_1                 <= i_wr ? i_wr_data[0]   : ana_tsc_1;
        `ANA_PPG_LED_SEL        :  ana_ppg_led_sel_reg       <= i_wr ? i_wr_data[2:0] : ana_ppg_led_sel_reg;
        `ANA_PPG_DAC0_CTRL_REG0 :  ana_ppg_dac0_ctrl_reg0    <= i_wr ? i_wr_data[7:0] : ana_ppg_dac0_ctrl_reg0;
        `ANA_PPG_DAC0_CTRL_REG1 :  ana_ppg_dac0_ctrl_reg1    <= i_wr ? i_wr_data[4:0] : ana_ppg_dac0_ctrl_reg1;
        `ANA_PPG_DAC1_CTRL_REG0 :  ana_ppg_dac1_ctrl_reg0    <= i_wr ? i_wr_data[7:0] : ana_ppg_dac1_ctrl_reg0;
        `ANA_PPG_DAC1_CTRL_REG1 :  ana_ppg_dac1_ctrl_reg1    <= i_wr ? i_wr_data[4:0] : ana_ppg_dac1_ctrl_reg1; 
        `ANA_PPG_TIA_IDAC       :  ana_ppg_tia_idac          <= i_wr ? i_wr_data[7:0] : ana_ppg_tia_idac;
        `ANA_PPG_TIA_GAIN       :  ana_ppg_tia_gain          <= i_wr ? i_wr_data[3:0] : ana_ppg_tia_gain;
        `ANA_PPG_TEST_REG       :  ana_ppg_test_reg          <= i_wr ? i_wr_data[5:0] : ana_ppg_test_reg;
        `ANA_PPG_LED_EN_REG     :  ana_ppg_led_en_reg        <= i_wr ? i_wr_data[5:0] : ana_ppg_led_en_reg;
        `ANA_PPG_CTRL_REG       :  ana_ppg_ctrl_reg          <= i_wr ? i_wr_data[2:0] : ana_ppg_ctrl_reg;
        `ANA_BIST	        :  ana_bist                  <= i_wr ? i_wr_data[3:0] : ana_bist;
        `ANA_SDM_REG            :  ana_sdm_reg               <= i_wr ? i_wr_data[2:0] : ana_sdm_reg;
        `ANA_Z_ADC_DAC_EN             :  ana_z_adc_dac_en           <= i_wr ? i_wr_data[0] : ana_z_adc_dac_en;
	 `ANA_Z_ADC_DAC_EN_SEL         :  ana_z_adc_dac_en_sel       <= i_wr ? i_wr_data[0] : ana_z_adc_dac_en_sel;
	
 
   
         //  default :  begin  
         //            end
  endcase  
   
  end
end

assign o_meas_sync_en       = meas_sync_en;

//pum register output 
//assign {o_fifo_disable,o_flash_dpstb_en, o_hresetreq, o_sleepdeep, o_pmuenable} = pmu_reg0[4:0];
//assign {ppg_ctrl_disable,o_fifo_disable,o_flash_dpstb_en, o_hresetreq, o_sleepdeep, o_pmuenable} = pmu_reg0[5:0];
assign {bio_disable,ppg_ctrl_disable,o_fifo_disable,o_flash_dpstb_en, o_hresetreq, o_sleepdeep, o_pmuenable} = pmu_reg0[6:0];


//flash reg out


//zmeas register output
assign o_zmeas_en = zmeas_en;
assign o_zmeas_phase_dither_en = zmeas_phase_dither_en;
assign o_zmeas_reg_ctrl={zmeas_reg_ctrl_3,zmeas_reg_ctrl_2,zmeas_reg_ctrl_1,zmeas_reg_ctrl_0};

//clk_ctrl register output
assign  o_fclk_dynen          = clk_ctrl_reg[0];
assign  o_pclk_div            = clk_ctrl_reg[2:1];
assign  o_iclk_div            = clk_ctrl_reg[5:3];
assign  o_imeas_adc_inv       = clk_ctrl_reg[6];
assign  o_always_on_spi_write = clk_ctrl_reg[7];


//active channel num output

//outputs to flash
//assign  o_fclk_dynen_flash = clk_ctrl_reg[0];
//assign  o_dc_dc_en_flash   = always_on_clk_ctrl_reg[0] ; 
//assign  o_dc_clk_div_flash = always_on_clk_ctrl_reg [2:0];   //goes to analog as [D2A_CPCLK<2:0>]


//fifo register out
assign        o_fifo_a_full_level  = reg_fifo_config_1;
assign        o_fifo_a_empty_level = reg_fifo_config_2;
assign        o_fifo_config3       = reg_fifo_config_3;



//INST FLASH
wire [7:0] flash_rd_data;
spi_reg_flash#(
.ADDR_WIDTH  (ADDR_WIDTH),
.DATA_WIDTH  (DATA_WIDTH),
.NO_TRIM_REGS(NO_TRIM_REGS)
) u_spi_reg_flash(
.spi2flash(spi2flash),
.i_clk(i_clk),
.i_rst_n(i_rst_n),
.i_addr(i_addr),
.i_wr(i_wr),
.i_wr_data(i_wr_data),
.o_rd_data(flash_rd_data)

);

//INST FLASH
wire         reg_imeas_int_sts;
wire         reg_imeas_int_sts0;
wire         reg_imeas_int_sts1;
wire         reg_imeas_bio_int_sts;
wire         reg_imeas_int_alarm_sts;
wire  	     int_sts_switch;
wire  	     int_sts_duration;

wire [7:0] imeas_rd_data;
spi_reg_imeas#(
.ADDR_WIDTH  (ADDR_WIDTH),
.DATA_WIDTH  (DATA_WIDTH)
) u_spi_reg_imeas(
.spi2imeas(spi2imeas),
.i_clk(i_clk),
.i_rst_n(i_rst_n),
.i_addr(i_addr),
.i_wr(i_wr),
.i_rd(i_rd),
.i_wr_data(i_wr_data),
.int_ctrl_reg(int_ctrl_reg),
.reg_imeas_int_sts(reg_imeas_int_sts),
.reg_imeas_int_sts0(reg_imeas_int_sts0),
.reg_imeas_int_sts1(reg_imeas_int_sts1),
.reg_imeas_bio_int_sts(reg_imeas_bio_int_sts),
.reg_imeas_int_alarm_sts(reg_imeas_int_alarm_sts),
.int_sts_switch(int_sts_switch),
.int_sts_duration(int_sts_duration),

.o_rd_data(imeas_rd_data)

);




///////////////////////////
//io pad control register
///////////////////////////
reg [2:0] pu_ctrl;
reg       pu_resetn;
reg [1:0] pd_testmode;

assign gpio_pu_ctrl     =  pu_ctrl;
assign gpio_pu_resetn   =  pu_resetn;
assign gpio_pd_testmode =  pd_testmode;

always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)begin
     pu_ctrl  		<= 3'b111; 
     pu_resetn  	<= 1'b1;
     pd_testmode        <= 2'b11; 
  end
  else begin
    case (i_addr[ADDR_WIDTH-1:0])
     `GPIO_PU_CTRL   	: pu_ctrl  	  <= i_wr ? i_wr_data[2:0] : pu_ctrl;	  
     `GPIO_PU_RESETn   	: pu_resetn  	  <= i_wr ? i_wr_data[0]   : pu_resetn;
     `GPIO_PD_TESTMODE  : pd_testmode     <= i_wr ? i_wr_data[1:0] : pd_testmode;   
     endcase
  end
end






///////////////////////////
//int control register
///////////////////////////


always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)begin
     int_ctrl_reg <= 2'b0;
  end
  else if ((i_addr[ADDR_WIDTH-1:0] == `INT_CTRL) & i_wr)begin
     int_ctrl_reg <= i_wr_data[1:0];
  end
end


//---------------------------------------------------------------------------------//
//-------------------------Read Data synchroniours---------------------------------//
//---------------------------------------------------------------------------------//

/////////bit syn for the Fifo signals

//
//wire [7:0] flash_data_spi_sync;
//common_sync_bit    
// #(
//.RST_VAL(0))
// u_flash_data_spi_sync [7:0](
//       .clk(i_clk),
//       .rst_(i_rst_n),
//       .async_in(flash_data_spi),
//       .sync_out(flash_data_spi_sync)
//       );




//rd_ptr
wire [6:0] fifo_rd_ptr_sync;
common_sync_bit    
 #(
.RST_VAL(0))
 u_fifo_rd_ptr_sync [6:0](
       .clk(i_clk),
       .rst_(i_rst_n),
       .async_in(i_fifo_rd_ptr),
       .sync_out(fifo_rd_ptr_sync)
       );

//wr_ptr
wire [6:0] fifo_wr_ptr_sync;
common_sync_bit  
 #(
.RST_VAL(0))
 u_fifo_wr_ptr_sync [6:0](
       .clk(i_clk),
       .rst_(i_rst_n),
       .async_in(i_fifo_wr_ptr),
       .sync_out(fifo_wr_ptr_sync)
       );

//fifo_a_empty
wire fifo_a_empty_sync;
common_sync_bit  //common_bit_sync 
 #(
.RST_VAL(0))
 u_fifo_a_empty_sync (
       .clk(i_clk),
       .rst_(i_rst_n),
       .async_in(i_fifo_a_empty),
       .sync_out(fifo_a_empty_sync)
       );


//fifo_empty
wire  fifo_empty_sync;
common_sync_bit  //common_bit_sync 
 #(
.RST_VAL(0))
 u_fifo_empty_sync (
       .clk(i_clk),
       .rst_(i_rst_n),
       .async_in(i_fifo_empty),
       .sync_out(fifo_empty_sync)
       );

//fifo_a_full
wire  fifo_a_full_sync;
common_sync_bit  //common_bit_sync 
 #(
.RST_VAL(0))
 u_fifo_a_full_sync (
       .clk(i_clk),
       .rst_(i_rst_n),
       .async_in(i_fifo_a_full),
       .sync_out(fifo_a_full_sync)
       );

//fifo_full
wire  fifo_full_sync;
common_sync_bit  //common_bit_sync 
 #(
.RST_VAL(0))
 u_fifo_full_sync (
       .clk(i_clk),
       .rst_(i_rst_n),
       .async_in(i_fifo_full),
       .sync_out(fifo_full_sync)
       );


//fifo_data
wire [17:0] rd_fifo_data_sync;
assign rd_fifo_data_sync = i_rd_fifo_data; 
/*
//fifo_data
wire [17:0] rd_fifo_data_sync;
common_sync_bit  //common_bit_sync 
 #(
.RST_VAL(0))
 u_rd_fifo_data_sync [17:0](
       .clk(i_clk),
       .rst_(i_rst_n),
      .async_in(i_rd_fifo_data), //16'h18877), 
     //   .async_in(18'h8877), 
       .sync_out(rd_fifo_data_sync)   //fifo_rd_data
       );
*/

//fifo_error
wire  fifo_error_sync;
common_sync_bit   //common_bit_sync 
 #(
.RST_VAL(0))
 u_fifo_error_sync (
       .clk(i_clk),
       .rst_(i_rst_n),
       .async_in(i_fifo_error),
       .sync_out(fifo_error_sync)
       );

//fifo_data_cnt

wire [7:0] fifo_data_cnt_sync;
common_sync_bit   //common_bit_sync 
 #(
.RST_VAL(0))
 u_fifo_data_cnt_sync [7:0] (
       .clk(i_clk),
       .rst_(i_rst_n),
       .async_in(i_fifo_data_cnt),
       .sync_out(fifo_data_cnt_sync)
       );

wire  [6:0] fifo_ovf_cnt_sync;
common_sync_bit   //common_bit_sync 
 #(
.RST_VAL(0))
 u_fifo_ovf_cnt_sync [6:0] (
       .clk(i_clk),
       .rst_(i_rst_n),
       .async_in(i_fifo_ovf_cnt),
       .sync_out(fifo_ovf_cnt_sync)
       );



//local reg of i/z measure inputs

//i-meas

  //wire[15:0] ch0data_max_final;
  //wire[15:0] ch0data_min_final;
  //wire[15:0] ch0data_delta_final;

 //z-meas

wire [15:0]  reg_zmeas_reg_status;
wire [31:0]  reg_zmeas_reg_dataout;

wire [9:0]   reg_zmeas_xn_data;
wire [9:0]   reg_zmeas_sine_for_dft;
wire [9:0]   reg_zmeas_cosine_for_dft;
wire [28:0]  reg_zmeas_summation_offset_forreal;
wire [28:0]  reg_zmeas_summation_real;
wire [28:0]  reg_zmeas_summation_imag;

wire [16:0]  reg_zmeas_shiftedreal_inter;
wire [11:0]  reg_zmeas_dft_cnt;
wire         reg_reg_zmeas_int;


/*
/// synchronize the inputs from i & z measurments
//i_imeas_int_sts
  common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_imeas_int_sts (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_imeas_int_sts),
       .sync_out(reg_imeas_int_sts)
       );

  common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_imeas_int_sts0 (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_imeas_int_sts0),
       .sync_out(reg_imeas_int_sts0)
       );

  common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_imeas_int_sts1 (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_imeas_int_sts1),
       .sync_out(reg_imeas_int_sts1)
       );

  common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_imeas_bio_int_sts (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_imeas_bio_int_sts),
       .sync_out(reg_imeas_bio_int_sts)
       );



  common_sync_bit   //common_bit_sync
 #(
.RST_VAL(0))
 u_imeas_int_alarm_sts (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_imeas_int_alarm_sts),
       .sync_out(reg_imeas_int_alarm_sts)
       );


//i_imeas_ch0data
 common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_imeas_ch0data [15:0] (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_imeas_ch0data),
       .sync_out(reg_imeas_ch0data)
       );

//i_imeas_ch1data
 common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_imeas_ch1data [15:0] (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_imeas_ch1data),
       .sync_out(reg_imeas_ch1data)
       );

//i_imeas_ch2data
 common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_imeas_ch2data [15:0] (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_imeas_ch2data),
       .sync_out(reg_imeas_ch2data)
       );

//i_zmeas_reg_status
 common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_zmeas_reg_status [15:0] (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_zmeas_reg_status),
       .sync_out(reg_zmeas_reg_status)
       );

//i_zmeas_reg_dataout
 common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_zmeas_reg_dataout [31:0] (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_zmeas_reg_dataout),
       .sync_out(reg_zmeas_reg_dataout)
  );

//i_zmeas_xn_data[9:0]
common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_zmeas_xn_data [9:0](
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_zmeas_xn_data),
       .sync_out(reg_zmeas_xn_data)
  );

//i_zmeas_sine_for_dft
common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_zmeas_sine_for_dft [9:0] (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_zmeas_sine_for_dft),
       .sync_out(reg_zmeas_sine_for_dft)
  );

//i_zmeas_cosine_for_dft
common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_zmeas_cosine_for_dft[9:0] (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_zmeas_cosine_for_dft),
       .sync_out(reg_zmeas_cosine_for_dft)
  );

//i_zmeas_summation_offset_forreal
common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_zmeas_summation_offset_forreal[28:0] (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_zmeas_summation_offset_forreal),
       .sync_out(reg_zmeas_summation_offset_forreal)
  );

//i_i_zmeas_summation_real
common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_zmeas_summation_real[28:0] (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_zmeas_summation_real),
       .sync_out(reg_zmeas_summation_real)
  );

//i_zmeas_summation_imag
common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_zmeas_summation_imag[28:0] (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_zmeas_summation_imag),
       .sync_out(reg_zmeas_summation_imag)
  );

//i_zmeas_shiftedreal_inter
common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_zmeas_shiftedreal_inter[16:0] (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_zmeas_shiftedreal_inter),
       .sync_out(reg_zmeas_shiftedreal_inter)
  );

//i_zmeas_dft_cnt
common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_zmeas_dft_cnt[11:0] (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_zmeas_dft_cnt),
       .sync_out(reg_zmeas_dft_cnt)
  );

//i_reg_zmeas_int
common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_reg_zmeas_int (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_reg_zmeas_int),
       .sync_out(reg_reg_zmeas_int)
  );

//i_reg_zmeas_adc_int
common_sync_bit   //common_bit_sync   
 #(
.RST_VAL(0))
 u_reg_zmeas_adc_int (
       .clk(i_clk),            //spi_clk
       .rst_(i_rst_n),
       .async_in(i_reg_zmeas_adc_int),
       .sync_out(reg_reg_zmeas_adc_int)
  );
*/

/// synchronize the inputs from i & z measurments
//i_imeas_int_sts

assign reg_zmeas_reg_status = i_zmeas_reg_status;

assign reg_zmeas_reg_dataout = i_zmeas_reg_dataout;

assign reg_zmeas_xn_data = i_zmeas_xn_data;

assign reg_zmeas_sine_for_dft = i_zmeas_sine_for_dft;

assign reg_zmeas_cosine_for_dft = i_zmeas_cosine_for_dft;

assign reg_zmeas_summation_offset_forreal = i_zmeas_summation_offset_forreal;

assign reg_zmeas_summation_real = i_zmeas_summation_real;

assign reg_zmeas_summation_imag = i_zmeas_summation_imag;

assign reg_zmeas_shiftedreal_inter = i_zmeas_shiftedreal_inter;

assign reg_zmeas_dft_cnt = i_zmeas_dft_cnt;

assign reg_reg_zmeas_int = i_reg_zmeas_int;

assign reg_reg_zmeas_adc_int = i_reg_zmeas_adc_int;



wire[31:0] reg_zmeas_adc_rom_wire = {2'b00, reg_zmeas_xn_data[9:0],reg_zmeas_sine_for_dft[9:0], reg_zmeas_cosine_for_dft[9:0]};
wire[31:0] zmeas_summation_shift = {3'b0,reg_zmeas_shiftedreal_inter,reg_zmeas_dft_cnt};




//------------------------------------------------------------------------------------
//--------------------Register Read---------------------------------------------------
//------------------------------------------------------------------------------------




always @ (posedge i_clk or negedge i_rst_n) begin
//always @ (*) begin
   if (!i_rst_n)
        reg_rd_data <= 8'b0;
   else if(!i_wr) begin
      case(i_addr[ADDR_WIDTH-1:0])
       


            //Z-Meas
	       `DATA_TYPE_SEL      		:  reg_rd_data <= {6'b0,data_type_sel_reg}; 
    	       `DC_DATA_REG_0      		:  reg_rd_data <= dc_data_reg_0 ;	    
    	       `DC_DATA_REG_1      		:  reg_rd_data <= {6'b0,dc_data_reg_1} ;        
    	       `DC_DATA_REG_C_0      		:  reg_rd_data <= dc_data_reg_c_0 ;	    
    	       `DC_DATA_REG_C_1      		:  reg_rd_data <= {6'b0,dc_data_reg_c_1} ;        
 `PHASE_INC_0      :  reg_rd_data <= phase_inc_0;    
 `PHASE_INC_1      :  reg_rd_data <= phase_inc_1;    
 `PHASE_INC_2      :  reg_rd_data <= phase_inc_2;    
 `PHASE_INC_3      :  reg_rd_data <= phase_inc_3;    
 `PHASE_OFFSET_0   :  reg_rd_data <= phase_offset_0;    
 `PHASE_OFFSET_1   :  reg_rd_data <= phase_offset_1;    
 `PHASE_OFFSET_2   :  reg_rd_data <= phase_offset_2;    
 `PHASE_OFFSET_3   :  reg_rd_data <= phase_offset_3;    
 `PHASE_OFFSET_C_0   :  reg_rd_data <= phase_offset_c_0;    
 `PHASE_OFFSET_C_1   :  reg_rd_data <= phase_offset_c_1;    
 `PHASE_OFFSET_C_2   :  reg_rd_data <= phase_offset_c_2;    
 `PHASE_OFFSET_C_3   :  reg_rd_data <= phase_offset_c_3;    
 `BIOZ_CTRL        :  reg_rd_data <= bioz_ctrl;    
`BIOZ_FILTER_CTRL_0  :  reg_rd_data <=  bioz_filter_ctrl_0 ;      
`BIOZ_FILTER_CTRL_1  :  reg_rd_data <=  bioz_filter_ctrl_1 ;        
`BIOZ_FILTER_CTRL_2  :  reg_rd_data <=  bioz_filter_ctrl_2 ;         

/*
    	       `SQU_DATA_L_0       		:  reg_rd_data <= square_data_l_reg_0; 	        
    	       `SQU_DATA_L_1       		:  reg_rd_data <= {6'b0,square_data_l_reg_1};    
    	       `SQU_DATA_H_0       		:  reg_rd_data <= square_data_h_reg_0; 	        
    	       `SQU_DATA_H_1       		:  reg_rd_data <= {6'b0,square_data_h_reg_1};    
*/
    	       //`SQU_CLK_DIV_0      		:  reg_rd_data <= square_clk_div_0 ;	    
    	       //`SQU_CLK_DIV_1      		:  reg_rd_data <= square_clk_div_1 ;	    


	  	`ZMEAS_REG_CTRL_0                 :   reg_rd_data <=  zmeas_reg_ctrl_0; 
		`ZMEAS_REG_CTRL_1                 :   reg_rd_data <=  zmeas_reg_ctrl_1; 
		`ZMEAS_REG_CTRL_2                 :   reg_rd_data <=  zmeas_reg_ctrl_2; 
		`ZMEAS_REG_CTRL_3                 :   reg_rd_data <=  zmeas_reg_ctrl_3; 
       		`ZMEAS_EN                         :   reg_rd_data <= {6'b0, zmeas_phase_dither_en, zmeas_en};   
         	`ZMEAS_SYNC_EN                     :    reg_rd_data <= {7'b0,meas_sync_en};   

		`ZMEAS_REG_STATUS_0   	          :   reg_rd_data <=  reg_zmeas_reg_status[7:0] ; 
		`ZMEAS_REG_STATUS_1   	          :   reg_rd_data <=  reg_zmeas_reg_status[15:8]; 
		`ZMEAS_REG_DATAOUT_0  	          :   reg_rd_data <=  reg_zmeas_reg_dataout[7:0]; 
		`ZMEAS_REG_DATAOUT_1              :   reg_rd_data <=  reg_zmeas_reg_dataout[15:8]; 
		`ZMEAS_REG_DATAOUT_2  	          :   reg_rd_data <=  reg_zmeas_reg_dataout[23:16]; 
		`ZMEAS_REG_DATAOUT_3              :   reg_rd_data <=  reg_zmeas_reg_dataout[31:24]; 
		`ZMEAS_ADC_ROM_REG_0              :   reg_rd_data <=reg_zmeas_adc_rom_wire[7:0]; 
		`ZMEAS_ADC_ROM_REG_1              :   reg_rd_data <=reg_zmeas_adc_rom_wire[15:8]; 
		`ZMEAS_ADC_ROM_REG_2  	          :   reg_rd_data <=reg_zmeas_adc_rom_wire[23:16]; 
		`ZMEAS_ADC_ROM_REG_3  	          :   reg_rd_data <=reg_zmeas_adc_rom_wire[31:24]; 
		`ZMEAS_SUMMATION_OFFSET_FORREAL_0 :   reg_rd_data <=reg_zmeas_summation_offset_forreal[7:0];  
		`ZMEAS_SUMMATION_OFFSET_FORREAL_1 :   reg_rd_data <=reg_zmeas_summation_offset_forreal[15:8]; 
		`ZMEAS_SUMMATION_OFFSET_FORREAL_2 :   reg_rd_data <=reg_zmeas_summation_offset_forreal[23:16]; 
		`ZMEAS_SUMMATION_OFFSET_FORREAL_3 :   reg_rd_data <={3'b0, reg_zmeas_summation_offset_forreal[28:24]}; 
		`ZMEAS_SUMMATION_REAL_0	          :   reg_rd_data <=reg_zmeas_summation_real[7:0]; 
		`ZMEAS_SUMMATION_REAL_1	          :   reg_rd_data <=reg_zmeas_summation_real[15:8]; 
		`ZMEAS_SUMMATION_REAL_2           :   reg_rd_data <= reg_zmeas_summation_real[23:16]; 
		`ZMEAS_SUMMATION_REAL_3           :   reg_rd_data <= {3'b0,reg_zmeas_summation_real[28:24]};
		`ZMEAS_SUMMATION_IMAG_0           :   reg_rd_data <=  reg_zmeas_summation_imag[7:0]; 
		`ZMEAS_SUMMATION_IMAG_1           :   reg_rd_data <=  reg_zmeas_summation_imag [15:8]; 
		`ZMEAS_SUMMATION_IMAG_2           :   reg_rd_data <=  reg_zmeas_summation_imag [23:16]; 
		`ZMEAS_SUMMATION_IMAG_3           :   reg_rd_data <=  {3'b0,reg_zmeas_summation_imag[28:24]}; 
		`ZMEAS_SUMMATION_SHIFT_0          :   reg_rd_data <=   zmeas_summation_shift[7:0]; 
		`ZMEAS_SUMMATION_SHIFT_1          :   reg_rd_data <=   zmeas_summation_shift[15:8]; 
		`ZMEAS_SUMMATION_SHIFT_2          :   reg_rd_data <=   zmeas_summation_shift[23:16]; 
		`ZMEAS_SUMMATION_SHIFT_3          :   reg_rd_data <=   zmeas_summation_shift [31:24]; 
		`ZMEAS_INT     	                  :   reg_rd_data <=   {7'b0,reg_reg_zmeas_int};  
		`ZMEAS_ADC_INT 		          :   reg_rd_data <=   {7'b0,reg_reg_zmeas_adc_int};  
             //clk_ctrl
		`CLK_CTRL_REG                     :   reg_rd_data <= clk_ctrl_reg;   //{2'b00,flash_to_clk_ctrl}; 
                `LEADOFF_CLK_REG   		  :   reg_rd_data <= {5'b0,leadoff_clk_reg}; 
                `RLD_CLK_REG       		  :   reg_rd_data <= {6'b0,rld_clk_reg};
		`MCLK_DIV                         :   reg_rd_data <= {mclk_div_reg};   
            `CHECK_CLK_DIV_LO          		  : reg_rd_data <= checking_clk_div_reg_lo; 
            //`CHECK_CLK_DIV_HI          		  : reg_rd_data <= {6'b0,checking_clk_div_reg_hi}; 
            `CHECK_CLK_DIV_HI          		  : reg_rd_data <= {checking_clk_div_reg_hi}; 
             //pmu   
		`PMU_REG0	                  :   reg_rd_data <= {1'b0,pmu_reg0[6:0]};     
             //ALWAYS_ON
              //    `ALWAYS_ON_CLK_CTRL             :   reg_rd_data <= always_on_clk_ctrl_reg; 
  
                 
             //FIFO
                `FIFO_WR_PTR_REG                  :    reg_rd_data <=  {1'b0, fifo_wr_ptr_sync};              //reg_fifo_wr_ptr;
                `FIFO_RD_PTR_REG                  :    reg_rd_data <=  {1'b0, fifo_rd_ptr_sync};              //reg_fifo_rd_ptr;
                `FIFO_COUNTER_1_REG               :    reg_rd_data <=  {1'b0, fifo_ovf_cnt_sync};             //reg_fifo_counter_1;
                `FIFO_COUNTER_2_REG               :    reg_rd_data <=  fifo_data_cnt_sync[7:0];               //reg_fifo_counter_2;
                `FIFO_CONFIG_1_REG                :    reg_rd_data <=  reg_fifo_config_1;
                `FIFO_CONFIG_2_REG                :    reg_rd_data <=  reg_fifo_config_2;
                `FIFO_CONFIG_3_REG                :    reg_rd_data <=  reg_fifo_config_3;
                `FIFO_STATUS_REG                  :    reg_rd_data <=  {fifo_error_sync,fifo_a_empty_sync,fifo_a_full_sync,fifo_empty_sync,fifo_full_sync,1'b0,rd_fifo_data_sync[17],rd_fifo_data_sync[16]}; 
                `FIFO_DATA_REG1                   :    reg_rd_data <=  rd_fifo_data_sync[15:8];  // reg_fifo_data_msb[7:0];
                `FIFO_DATA_REG2                   :    reg_rd_data <=  rd_fifo_data_sync[7:0];    //reg_fifo_data_lsb[7:0];
                

          //PPG
         //      `PPG_REG_CTRL_0      :  reg_rd_data <=   reg_ppg_ctrl_0; //reg_ppg_TIA_IDAC;
             //  `PPG_REG_CTRL_1      :  reg_rd_data <=  {3'b0,reg_ppg_mode_sel[2:0],reg_ppg_IDAC_LED_SEL,reg_ppg_enable}; //reg_ppg_IDAC_LED_SEL
               `PPG_REG_CTRL_1      :  reg_rd_data <=  {1'b0,reg_ppg_ctrl_1[6:0]}; //reg_ppg_IDAC_LED_SEL[4:0]};
          //     `PPG_TIA_GAIN        :  reg_rd_data <=  {4'b0,reg_ppg_TIA_GAIN[3:0]};
               `PPG_LED_TIME_SEL    :  reg_rd_data <=  {4'b0,reg_ppg_LED_TIME_SEL[3:0]};
               `PPG_LED_FREQ_SEL    :  reg_rd_data <=  {4'b0,reg_ppg_LED_FREQ_SEL[3:0]};
               `PPG_LED_STATUS      :  reg_rd_data <=  {7'b0,i_ppg_LED_STATUS}; 

	`LED_ON_L               :  reg_rd_data <= led_on[7:0]   ; 
	`LED_ON_H               :  reg_rd_data <= {2'b0,led_on[13:8]}  ; 
	`LED_FREQ_L             :  reg_rd_data <= led_freq[7:0] ;	
	`LED_FREQ_H             :  reg_rd_data <= {2'b0,led_freq[13:8]}; 	
   
 
          //Analog
                 `ANA_BUFFER                     :  reg_rd_data    <= {3'b0,ana_buffer};
                 `ANA_ECG_CTRL_1                 :  reg_rd_data    <= ana_ecg_ctrl_1;
                 `ANA_ECG_CTRL_2		 :  reg_rd_data    <= {1'b0,ana_ecg_ctrl_2};
                 `ANA_DC_LEAD_OFF_CTRL           :  reg_rd_data    <= {6'b0,ana_dc_lead_off_ctrl};
                 `ANA_LEAD_OFF_EN                :  reg_rd_data    <= {6'b0,ana_lead_off_en};
                 `ANA_TSC                        :  reg_rd_data    <= ana_tsc;	
                 `ANA_TSC_1                      :  reg_rd_data    <= {7'b0,ana_tsc_1};	
                 `ANA_PPG_LED_SEL                :  reg_rd_data    <= {5'b0,ana_ppg_led_sel_reg};
                 `ANA_PPG_DAC0_CTRL_REG0         :  reg_rd_data    <= ana_ppg_dac0_ctrl_reg0;
                 `ANA_PPG_DAC0_CTRL_REG1         :  reg_rd_data    <= {3'B0,ana_ppg_dac0_ctrl_reg1};
                 `ANA_PPG_DAC1_CTRL_REG0         :  reg_rd_data    <= ana_ppg_dac1_ctrl_reg0;
                 `ANA_PPG_DAC1_CTRL_REG1         :  reg_rd_data    <= {3'B0,ana_ppg_dac1_ctrl_reg1};
                 `ANA_PPG_TIA_IDAC               :  reg_rd_data    <= ana_ppg_tia_idac;
                 `ANA_PPG_TIA_GAIN               :  reg_rd_data    <= {4'b0,ana_ppg_tia_gain};
                 `ANA_PPG_TEST_REG               :  reg_rd_data    <= {2'b0,ana_ppg_test_reg};
                 `ANA_PPG_LED_EN_REG             :  reg_rd_data    <= {2'b0,ana_ppg_led_en_reg};             
                 `ANA_PPG_CTRL_REG               :  reg_rd_data    <= {5'b0,ana_ppg_ctrl_reg};
                 `ANA_BIST	                 :  reg_rd_data    <= {4'b0,ana_bist};
                 `ANA_SDM_REG                    :  reg_rd_data    <= {5'b0,ana_sdm_reg};
          

		 `ANA_Z_ADC_DAC_EN               :  reg_rd_data               <= {7'b0,ana_z_adc_dac_en};
                 `ANA_Z_ADC_DAC_EN_SEL           :  reg_rd_data               <= {7'b0,ana_z_adc_dac_en_sel};

          //device interrupt status

                 //`DEVICE_INT_STATUS_0           :  reg_rd_data     <={6'b0,reg_reg_zmeas_int,reg_reg_zmeas_adc_int};
                 //`DEVICE_INT_STATUS_0           :  reg_rd_data     <={3'b0,reg_imeas_bio_int_sts,reg_imeas_int_sts1,reg_imeas_int_sts0,reg_reg_zmeas_int,reg_reg_zmeas_adc_int};
                 `DEVICE_INT_STATUS_0           :  reg_rd_data     <={1'b0,int_sts_switch,int_sts_duration,reg_imeas_bio_int_sts,reg_imeas_int_sts1,reg_imeas_int_sts0,reg_reg_zmeas_int,reg_reg_zmeas_adc_int};
                 `DEVICE_INT_STATUS_1           :  reg_rd_data     <={1'b0,reg_imeas_int_sts,reg_imeas_int_alarm_sts,fifo_error_sync,fifo_a_empty_sync,fifo_a_full_sync,fifo_empty_sync,fifo_full_sync};

             
 
         //from always_on for debug         
         
             `ALWAYS_ON_ANA_TRIM1                :   reg_rd_data     <={trim1_always_on}; //{3'b0,bgh_vtrim_always_on};
             `ALWAYS_ON_ANA_TRIM2                :   reg_rd_data     <={trim2_always_on}; //{1'b0,bgh_ctrim_always_on};
             `ALWAYS_ON_ANA_TRIM3                :   reg_rd_data     <={trim3_always_on}; //{6'b0,ldo1v5_trim_always_on};
             `ALWAYS_ON_ANA_TRIM4                :   reg_rd_data     <={trim4_always_on}; //{2'b0,osc_trim_always_on};
             `ALWAYS_ON_ANA_TRIM5                :   reg_rd_data     <={trim5_always_on}; 
             `ALWAYS_ON_ANA_TRIM6                :   reg_rd_data     <={trim6_always_on}; 
             `ALWAYS_ON_ANA_TRIM7                :   reg_rd_data     <={trim7_always_on}; 
             `ALWAYS_ON_ANA_TRIM8                :   reg_rd_data     <={trim8_always_on}; 
             `ALWAYS_ON_ANA_TRIM9                :   reg_rd_data     <={trim9_always_on}; 
             `ALWAYS_ON_ANA_TRIM10               :   reg_rd_data     <={trim10_always_on};

      //A2D_SPARE
            `A2D_SPARE_REG0                       : reg_rd_data  <= i_A2D_SPARE_0;
            `A2D_LOFF_STATN                       : reg_rd_data  <= i_A2D_LOFF_STATN;         
            `A2D_LOFF_STATP                       : reg_rd_data  <= i_A2D_LOFF_STATP;         
            `A2D_ACLEADOFF_STATN                  : reg_rd_data  <= i_A2D_ACLEADOFF_STATN;         
            `A2D_ACLEADOFF_STATP                  : reg_rd_data  <= i_A2D_ACLEADOFF_STATP;

             //I/O PAD REGISTERS
             `GPIO_PU_CTRL                               :   reg_rd_data     <= {5'b0, pu_ctrl};				  	   
             `GPIO_PU_RESETn                             :   reg_rd_data     <= {7'b0, pu_resetn};                                 	 
             `GPIO_PD_TESTMODE                           :   reg_rd_data     <= {6'b0, pd_testmode};   

             `INT_CTRL                                   :   reg_rd_data     <= {6'b0, int_ctrl_reg};




            	default   		                 :  reg_rd_data     <= 8'b0;
      endcase      
   end
   else
      reg_rd_data <= reg_rd_data;  //or 8'b0 =>rd_data=0 when not reading
 end

assign o_rd_data =reg_rd_data | flash_rd_data | imeas_rd_data;


///PPG_OUTPUT  (digital_PPG)
//  assign         o_ppg_TIA_IDAC     = reg_ppg_ctrl_0;  
  assign         o_ppg_enable       = reg_ppg_ctrl_1[0]; 
  assign         o_ppg_IDAC_LED_SEL = reg_ppg_ctrl_1[1];
  assign         o_ppg_mode_sel     = reg_ppg_ctrl_1[4:2];
  assign         o_PPG_SYNC_BYPASS  = reg_ppg_ctrl_1[5];
  assign         o_PPG_LED_PROG_SEL  = reg_ppg_ctrl_1[6];

//  assign         o_ppg_TIA_GAIN     = reg_ppg_TIA_GAIN[3:0]; 
  assign         o_ppg_LED_TIME_SEL = reg_ppg_LED_TIME_SEL[3:0];
  assign         o_ppg_LED_FREQ_SEL = reg_ppg_LED_FREQ_SEL[3:0];



//Ananlog Outputs


//analog_buffer
assign       o_ECG_ELECTRODE_EN     = ana_buffer[4]; //ana_ecg_ctrl_2[7];
assign       o_RLD_CHOP_EN	    = ana_buffer[3];
assign       o_RLD_AMP_EN           = ana_buffer[2];
assign       o_BG1P2_BUF_EN         = ana_buffer[1];     
assign       o_VCM1P5_BUF_EN        = ana_buffer[0];


//analog_ECG
 assign        o_ECG_PGA_EN        =ana_ecg_ctrl_1[0];
 assign        o_ECG_LPF_EN        =ana_ecg_ctrl_1[1];
 assign        o_ECG_PGA_GSEL      =ana_ecg_ctrl_1[4:2];
 assign        o_ECG_DDA_GSEL      =ana_ecg_ctrl_1[7:5];
 
 assign        o_ECG_DDA_CLKSEL    =ana_ecg_ctrl_2[1:0];
 assign        o_ECG_DDA_EN        =ana_ecg_ctrl_2[2];
 assign        o_ECG_DDACHOP_EN    =ana_ecg_ctrl_2[3];
 assign        o_ECG_DDA_ISEL      =ana_ecg_ctrl_2[5:4];
 assign        o_ECG_CAL_EN        =ana_ecg_ctrl_2[6];
// assign        o_ECG_ELECTRODE_EN  =ana_ecg_ctrl_2[7];

//analog_LEAD_OFF
  assign        o_DC_LEAD_OFF_RMODE_EN  = ana_dc_lead_off_ctrl[0];      
  assign        o_DC_LEAD_OFF_VIN_FLIP  = ana_dc_lead_off_ctrl[1];
//assign        o_DC_LEAD_OFF_ISEL      = ana_dc_lead_off_ctrl[3:2];
//assign        o_DC_LEAD_OFF_COMP_TH_EN =ana_dc_lead_off_ctrl[6:4];

  assign        o_LEAD_OFF_EN            =ana_lead_off_en[1:0];

//analog_TSC 
  assign         o_TSC_OUT_SEL          = ana_tsc[0];
  assign         o_TSC_BJT_SEL          = ana_tsc[3:1];
  assign         o_TSC_EN               = ana_tsc[4];
  assign         o_TSC_INA_GEL          = ana_tsc[7:5];

  assign         o_TSC_INA_EN           = ana_tsc_1;

//analog_PPG
  assign        o_PPG_DAC0_VSEL        ={ana_ppg_dac0_ctrl_reg1[3:0],ana_ppg_dac0_ctrl_reg0[7:0]};
  assign        o_PPG_DAC0_EN          = ana_ppg_dac0_ctrl_reg1[4];
  assign        o_PPG_DAC1_VSEL        = {ana_ppg_dac1_ctrl_reg1[3:0],ana_ppg_dac1_ctrl_reg0[7:0]}; ;
  assign        o_PPG_DAC1_EN          = ana_ppg_dac1_ctrl_reg1[4];
  assign        o_PPG_TIA_IDAC         = ana_ppg_tia_idac[7:0];
  assign        o_PPG_TIA_GAIN         = ana_ppg_tia_gain[3:0];

  
  assign        o_PPG_TEST_OUT         = ana_ppg_test_reg[1:0];
  assign        o_PPG_TEST_IN         = ana_ppg_test_reg[3:2];
//  assign        o_PPG_SH_CK            = ana_ppg_test_reg[4];      
  assign        o_PPG_PDV_REF_SEL      = ana_ppg_test_reg[5:4];

  

  assign       o_PPG_LED_STANDBYEN     = ana_ppg_led_en_reg[0];
  assign       o_PPG_AF_EN             = ana_ppg_led_en_reg[1];
  assign       o_PPG_SH_EN             = ana_ppg_led_en_reg[2];
  assign       o_PPG_BUFFER_EN         = ana_ppg_led_en_reg[3];
  assign       o_PPG_TIA_VREF_BUFFER_EN= ana_ppg_led_en_reg[4];
  assign       o_PPG_DAC_BUFFER_EN     = ana_ppg_led_en_reg[5];

  assign       o_PPG_LED_SEL           = ana_ppg_led_sel_reg[2:1];
  assign       o_PPG_LED_DAC_SEL       = ana_ppg_led_sel_reg[0];


  assign        o_PPG_LED_EN            =ana_ppg_ctrl_reg[2];
  assign        o_PPG_TIA_EN            =ana_ppg_ctrl_reg[1];
  assign        o_PPG_SH_CK             =ana_ppg_ctrl_reg[0];

//ANA_SDM
//  assign       o_SDM_VIN_SEL           = ana_sdm_reg[6:4];
//  assign       o_SDM_CLK               = ana_sdm_reg[3];
  assign       o_SDM_EN                = ana_sdm_reg[2];
  assign       o_SDM_BIAS              = ana_sdm_reg[1:0];


 
  //ANA_BIST
  assign        o_BIST_ISEL             =ana_bist[2:0];        
  assign        o_BIST_EN               =ana_bist[3];



 endmodule






/*
`define ANA_IMEAS_CH2_WE1_0             8'H5E
`define ANA_IMEAS_CH2_WE1_1             8'H5F
`define ANA_IMEAS_CH2_WE2_0             8'h60
`define ANA_IMEAS_CH2_WE2_1             8'h61
`define ANA_IMEAS_CH2_RCE_ROUTSEL       8'h62
`define ANA_IMEAS_CH2_WE_DAC_EN         8'h63
`define ANA_IMEAS_CH2_DINWE_0           8'h64
`define ANA_IMEAS_CH2_DINWE_1           8'h65
`define ANA_IMEAS_CH2_RCE_DAC_EN        8'h66
`define ANA_IMEAS_CH2_DINRCE_0          8'h67
`define ANA_IMEAS_CH2_DINRCE_1          8'h68

`define ANA_BIST                       8'h69
`define ANA_DDA                        8'h6A
`define ANA_PGA                        8'h6B
`define ANA_ELE                        8'h6C
`define ANA_DAC1_EN                    8'h6D
`define ANA_DAC1_DIN_0                 8'h6E
`define ANA_DAC1_DIN_1                 8'h6F
`define ANA_DAC2_EN                    8'h70
`define ANA_DAC2_DIN_0                 8'h71
`define ANA_DAC2_DIN_1                 8'h72
`define ANA_SDM                        8'h73


//xin add 2/Oct/2022
`define ANA_Z_ADC_DAC_EN               8'h74
`define ANA_Z_ADC_DAC_EN_SEL           8'h75

//device status 
`define DEVICE_INT_STATUS_0           8'H76
`define DEVICE_INT_STATUS_1	      8'H77

//Analog debug regsiters
`define  ALWAYS_ON_CLK_CTRL_DEBUG                 8'h78

`define ALWAYS_ON_ANA_IMEAS_CH1_WE1_0_DEBUG       8'H79
`define ALWAYS_ON_ANA_IMEAS_CH1_WE1_1_DEBUG       8'H7A
`define ALWAYS_ON_ANA_IMEAS_CH1_WE2_0_DEBUG       8'h7B
`define ALWAYS_ON_ANA_IMEAS_CH1_WE2_1_DEBUG       8'h7C
`define ALWAYS_ON_ANA_IMEAS_CH1_RCE_ROUTSEL_DEBUG 8'h7D
`define ALWAYS_ON_ANA_IMEAS_CH1_WE_DAC_EN_DEBUG   8'h7E
`define ALWAYS_ON_ANA_IMEAS_CH1_DINWE_0_DEBUG     8'h7F
`define ALWAYS_ON_ANA_IMEAS_CH1_DINWE_1_DEBUG     8'h80
`define ALWAYS_ON_ANA_IMEAS_CH1_RCE_DAC_EN_DEBUG  8'h81
`define ALWAYS_ON_ANA_IMEAS_CH1_DINRCE_0_DEBUG    8'h82
`define ALWAYS_ON_ANA_IMEAS_CH1_DINRCE_1_DEBUG    8'h83

`define ALWAYS_ON_ANA_IMEAS_CH2_WE1_0_DEBUG       8'H84
`define ALWAYS_ON_ANA_IMEAS_CH2_WE1_1_DEBUG       8'H85
`define ALWAYS_ON_ANA_IMEAS_CH2_WE2_0_DEBUG       8'h86
`define ALWAYS_ON_ANA_IMEAS_CH2_WE2_1_DEBUG       8'h87
`define ALWAYS_ON_ANA_IMEAS_CH2_RCE_ROUTSEL_DEBUG 8'h88
`define ALWAYS_ON_ANA_IMEAS_CH2_WE_DAC_EN_DEBUG   8'h89
`define ALWAYS_ON_ANA_IMEAS_CH2_DINWE_0_DEBUG     8'h8A
`define ALWAYS_ON_ANA_IMEAS_CH2_DINWE_1_DEBUG     8'h8B
`define ALWAYS_ON_ANA_IMEAS_CH2_RCE_DAC_EN_DEBUG  8'h8C
`define ALWAYS_ON_ANA_IMEAS_CH2_DINRCE_0_DEBUG    8'h8D
`define ALWAYS_ON_ANA_IMEAS_CH2_DINRCE_1_DEBUG    8'h8E

`define ALWAYS_ON_ANA_PMU_DEBUG                   8'h8F


`define ALWAYS_ON_ANA_BIST_DEBUG                 8'h90
`define ALWAYS_ON_ANA_DDA_DEBUG                  8'h91
`define ALWAYS_ON_ANA_ELE_DEBUG                  8'H92
`define ALWAYS_ON_ANA_DAC1_EN_DEBUG              8'h93
`define ALWAYS_ON_ANA_DAC1_DIN_0_DEBUG           8'h94
`define ALWAYS_ON_ANA_DAC1_DIN_1_DEBUG           8'H95
`define ALWAYS_ON_ANA_DAC2_EN_DEBUG              8'H96
`define ALWAYS_ON_ANA_DAC2_DIN_0                 8'H97
`define ALWAYS_ON_ANA_DAC2_DIN_1                 8'H98
*/

