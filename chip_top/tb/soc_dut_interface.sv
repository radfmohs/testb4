/*--------------------------------------------------------------------------------------
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_dut_interface.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: SOC DUT Interface                                        
// Designer	: ddang@nanochap.com                                                                 
// Date		: 16-10-2023                                                                    
// Revision	: 0.1                                 
--------------------------------------------------------------------------------------*/
`ifndef SOC_DUT_INTERFACE
`define SOC_DUT_INTERFACE

interface dut_interface();

  //////////////////////////////////////////////////////////////
  // signals to be connected to DUT
  //////////////////////////////////////////////////////////////

  // inputs of DUT
  wire  resetn;
  wire  soc_resetn; 

  // inout
  `ifndef FPGA

  `else

  `endif

  logic [39:0] reg_normal[`NORMAL_REG_NUM];

//---------------------------------------
// GPIO
//---------------------------------------
  wire  alert;

  bit IOBUF_PAD_PULL_HIGH;
  bit assertion_on;
// bus signals
  bit [1:0]    testmode_sel;
  bit [1:0]    spimode_sel;
  bit [1:0]    altf_sel;
  bit [1:0]    altf_gpio_sel; 
  bit [18:0]   iopad_gpio;
  logic [1:0]  TCK_SEL;

  logic [1:0]  pclk_sel;
  logic [2:0]  iclk_sel;
  logic [15:0] spi_sclk_freq;         // unit is Khz (1Khz to 16.000Khz)
  logic [6:0]  spi_clk_jitter;        // unut is percentage (0-100)
  logic [6:0]  spi_sclk_jitter;       // unut is percentage (0-100)

  logic [15:0] tcssc;   
  logic [15:0] tsccs;                 // min is 17ns
  logic [15:0] tcsh;                  // min is 2 tcks (1/spi_clk)
  logic [6:0]  tdist;                 // min is 10ns
  logic [6:0]  tch;

  integer      err_cnt;
  logic        print_msg_disable;

  bit	       fault_stuck0_clk_en;   // 1: internal 32KHZ and 300KHZ will be LOW (can used when we set ext_clk_en)	

  bit 	       ext_clk_en;	      // 1: external driven to ENS3 from external clock
  logic [1:0]  ext_clk_sel;   

  logic [6:0]  hfosc_jitter;
  logic [6:0]  hfosc_variation;
  logic        hfosc_fixed_gnd_en;
  logic        ext_hfosc_fixed_gnd_en;

  logic [15:0] flash_bist_freq;
  bit          config_in_base_test_en;


  bit   [2:0]  wg_drv_sel;	      //to select among 8 wavegen drivers
  logic [31:0] hlf_wave_per;          //half wave period setting of waveform

  bit          dont_check_conf_first_en;

  bit           sys_clk;
  bit           wait_reset_en;

  bit   [1:0]  A2D_comp_sel;	      //select the A2D_comp for lead_off_detection
  bit          bist_vpp_pin_en;       //control vpp by bist_vpp_en or timing

  bit          imeas_chdata_en_n;
  bit   [17:0] imeas_chdata;
  bit          fifo_full;
  bit   [7:0]  fifo_config_a;

  bit          disable_init_flash;
  bit          flash_recall_done;

  bit [15:0]   ch0_data;//imeas
  bit [15:0]   ch1_data;//imeas
  bit [15:0]   ch2_data;//imeas
  bit [15:0]   ch0_data_max;//imeas
  bit [15:0]   ch0_data_min;//imeas
  bit [15:0]   ch0_data_delta;//imeas
  bit          alarm_sts;//imeas
  bit          imeas_ppg_en;
  bit          imeas_bio_en;
  bit          imeas_sb_en;
  bit          imeas_24Hz_in;

  bit          wake_up_en; 

  bit [7:0]    mclk_sel;

  //BIOZ
  bit [1:0]    zmeas_freq_sel;        // zmeas adc freq sel  (2'b00: 1Khz, 2'b01: 2Khz, 2'b10: 4Khz, 2'b11: No readmem)
  bit [2:0]    zmeas_freq_val;        // zmeas dds freq sel  (For mclk 256Khz; 3'b001: 500hz, 3'b010: 1Khz, 3'b011: 2Khz, 3'b100: 4Khz, 3'b000: No freq)
  bit [1:0]    zmeas_dds_wave_sel;    // zmeas dds wave type (2'b00: sine, 2'b01: dc, 2'b10: square, 2'b11: sine)

  logic             mon_bioz_en;
  logic   [31:0]    mon_phase_inc;
  logic   [31:0]    mon_phase_offset;
  logic   [31:0]    mon_phase_offset_c;
  logic   [31:0]    mon_dc_data;
  logic   [31:0]    mon_dc_data_c;

  logic   [31:0]    mon_data_type_sel;

  logic   [9:0]     mon_sin_unsigned;
  logic   [9:0]     mon_cos_unsigned;
  logic             mon_i_square;
  logic             mon_q_square;
  logic   [32:0]    mon_phase_acc;
/*
  logic             bioz_rst_reg;
  logic             bioz_en = 1'b1;
  logic             bioz_rst_reg;
  logic   [31:0]    phase_inc = 32'h0666_6666;
  logic   [31:0]    phase_offset = 32'h0;
  logic   [31:0]    phase_offset_c = 32'h0;
  logic   [32:0]    f_out  = 0;
  
  logic   [1:0]     iq_input_format;
  logic   [5:0]     rst_val;

  logic   [3:0]     iq_cic_rate;
  logic             iq_chmod;
  logic             iq_format_sel;
  logic             iq_sd16rst;
  logic             iq_int_en;

  logic   [3:0]     iq_iclk_div;
  logic             iq_adc_clk_inv;
*/
  bit [9:0]    dc_data_val;
  bit [9:0]    sq_data_lval;
  bit [9:0]    sq_data_hval;
  bit [15:0]   sq_wave_div;
  bit [3:0]    shr_man_val;
  bit          shr_man_en;
  bit          LEAD_OFF_STATN;
  bit          LEAD_OFF_STATP;
  bit          LEAD_AC_OFF_STATN;
  bit          LEAD_AC_OFF_STATP;

  bit [7:0]    A2D_SPARE_TRIM_SW0;
  bit [1:0]    en_ac_dc_lead_off;        // 0:disable, 1:DC enable, 2:AC enable, 3:AC and DC both enable
  bit          leadoff_high_low_active;  // 0:high active, 1:low active
  bit  [1:0]   switch_duration_sel;      // 0:switch & duration, 1:switch only, 2:duration only, 3:switch & duration
  bit [15:0] leadoff_duration_tgt;
  bit [7:0]  leadoff_switch_tgt;



  logic [15:0] ch0_cic_arr[128];
  logic [15:0] ch1_cic_arr[128];
  logic [1:0]  filter_sel[128];//00: filter0;  01: filter1

  bit          flash_check_conf_first_disable;

 logic [15:0] scaleconst1 ;
 logic [15:0] coeff_b1_section1 ;
 logic [15:0] coeff_b2_section1 ;
 logic [15:0] coeff_b3_section1 ;
 logic [15:0] coeff_a2_section1 ;
 logic [15:0] coeff_a3_section1 ;
 
 logic [15:0] scaleconst2 ;
 logic [15:0] coeff_b1_section2 ;
 logic [15:0] coeff_b2_section2 ;
 logic [15:0] coeff_b3_section2 ;
 logic [15:0] coeff_a2_section2 ;
 logic [15:0] coeff_a3_section2 ;

 logic [15:0] scaleconst3 ;
 logic [15:0] coeff_b1_section3 ;
 logic [15:0] coeff_b2_section3 ;
 logic [15:0] coeff_b3_section3 ;
 logic [15:0] coeff_a2_section3 ;
 logic [15:0] coeff_a3_section3 ;

 logic [15:0] scaleconst4 ;
 logic [15:0] coeff_b1_section4 ;
 logic [15:0] coeff_b2_section4 ;
 logic [15:0] coeff_b3_section4 ;
 logic [15:0] coeff_a2_section4 ;
 logic [15:0] coeff_a3_section4 ;

 logic sign_en;

 logic [14:0] imeas_sin_amp;
 logic [14:0] imeas_sin_offset;
 logic [19:0] imeas_sampling_rate;
 logic [19:0] imeas_sin_freq;
 logic        imeas_sin_gen_en;
 logic [2:0]  imeas_cic_rate;
 logic [1:0]  imeas_input_format;
 logic [14:0] imeas_out_diff_amp;
 logic [14:0] filter_gain;
 logic [14:0] imeas_sin_expected_freq; // Create wavegen with expected freqency
 logic        imeas_rtl_bypass_en;
 logic        disable_step_check;

 logic [31:0] counter;
 logic [1:0]  filter_gain_mult;
 logic [11:0] OSR;
 logic [21:0] gpio_pu_en;      // [20:19]: TESTMODE[1:0], [18:0]: GPI0 
 logic [21:0] gpio_pd_en;      // [20:19]: TESTMODE[1:0], [18:0]: GPI0

endinterface: dut_interface

`endif

