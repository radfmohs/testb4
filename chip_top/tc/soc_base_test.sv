/*--------------------------------------------------------------------------------------
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_base_test.sv                                                   
// Project	: Nanochap SOC                                  		        
// Description	: Testcase soc_base_test is base test class of SOC                                           
// Designer	: ddang@nanochap.com                                                                 
// Date		: 18-03-2024                                                                    
// Revision	: 0.1                                 
--------------------------------------------------------------------------------------*/
`ifndef SOC_BASE_TEST__SV
`define SOC_BASE_TEST__SV

 import nnc_uvm_pkg::*;
 `include "nnc_uvm_methodology.svh"

`define TESTNAME soc_base_test
`define TESTCFG soc_base_test_cfg

`include "soc_register_defines.svh"
  
`define SET_CFG_REG(REG) \
  top_test_cfg.reg_normal[`REG] = { \
    `REG, \
    `INIT_``REG, \
    `MASK_``REG, \
    `ACCESS_``REG \
  };

`define PGMCB_WR     4'b0010
`define PGMCB_WR32   4'b1000
`define PGMICB_WR    4'b0011
`define PGMICB_WR32  4'b1001


`define KEY_TRIM    5'b10101
`define KEY_SPI     5'b01010
`define KEY_COEFFI  5'b01110

`define SCALECONST1_FS125        16'b0111001000010010  
`define COEF_B1_SESSION1_FS125   16'b0100000000000000  
`define COEF_B2_SESSION1_FS125   16'b0110011110010000  
`define COEF_B3_SESSION1_FS125   16'b0100000000000000  
`define COEF_A2_SESSION1_FS125   16'b0101001001000010  
`define COEF_A3_SESSION1_FS125   16'b0011000011111111  
`define SCALECONST2_FS125        16'b0111001000010010  
`define COEF_B1_SESSION2_FS125   16'b0100000000000000  
`define COEF_B2_SESSION2_FS125   16'b0110011110010000  
`define COEF_B3_SESSION2_FS125   16'b0100000000000000  
`define COEF_A2_SESSION2_FS125   16'b0110010101010111  
`define COEF_A3_SESSION2_FS125   16'b0011010011000100  

`define SCALECONST1_FS250        16'b0111100100000011   // Verified
`define COEF_B1_SESSION1_FS250   16'b0100000000000000  
`define COEF_B2_SESSION1_FS250   16'b1101100001101100  
`define COEF_B3_SESSION1_FS250   16'b0100000000000000  
`define COEF_A2_SESSION1_FS250   16'b1110000100101001  
`define COEF_A3_SESSION1_FS250   16'b0011100100010110  
`define SCALECONST2_FS250        16'b0111100100000011  
`define COEF_B1_SESSION2_FS250   16'b0100000000000000  
`define COEF_B2_SESSION2_FS250   16'b1101100001101100  
`define COEF_B3_SESSION2_FS250   16'b0100000000000000  
`define COEF_A2_SESSION2_FS250   16'b1101010000011110  
`define COEF_A3_SESSION2_FS250   16'b0011100101010010  

`define SCALECONST1_FS500        16'b0111110001101101   // Verified
`define COEF_B1_SESSION1_FS500   16'b0100000000000000  
`define COEF_B2_SESSION1_FS500   16'b1001100001110011  
`define COEF_B3_SESSION1_FS500   16'b0100000000000000  
`define COEF_A2_SESSION1_FS500   16'b1001110110010000  
`define COEF_A3_SESSION1_FS500   16'b0011110001011000  
`define SCALECONST2_FS500        16'b0111110001101101  
`define COEF_B1_SESSION2_FS500   16'b0100000000000000  
`define COEF_B2_SESSION2_FS500   16'b1001100001110011  
`define COEF_B3_SESSION2_FS500   16'b0100000000000000  
`define COEF_A2_SESSION2_FS500   16'b1001100100110001  
`define COEF_A3_SESSION2_FS500   16'b0011110010011100  

`define SCALECONST1_FS1000       16'b0111111000110100   // Verified
`define COEF_B1_SESSION1_FS1000  16'b0100000000000000  
`define COEF_B2_SESSION1_FS1000  16'b1000011001000100  
`define COEF_B3_SESSION1_FS1000  16'b0100000000000000  
`define COEF_A2_SESSION1_FS1000  16'b1000100010011100  
`define COEF_A3_SESSION1_FS1000  16'b0011111000100100  
`define SCALECONST2_FS1000       16'b0111111000110100  
`define COEF_B1_SESSION2_FS1000  16'b0100000000000000  
`define COEF_B2_SESSION2_FS1000  16'b1000011001000100  
`define COEF_B3_SESSION2_FS1000  16'b0100000000000000  
`define COEF_A2_SESSION2_FS1000  16'b1000011101011100  
`define COEF_A3_SESSION2_FS1000  16'b0011111001001011  

`define SCALECONST1         `SCALECONST1_FS500            
`define COEF_B1_SESSION1    `COEF_B1_SESSION1_FS500
`define COEF_B2_SESSION1    `COEF_B2_SESSION1_FS500
`define COEF_B3_SESSION1    `COEF_B3_SESSION1_FS500
`define COEF_A2_SESSION1    `COEF_A2_SESSION1_FS500
`define COEF_A3_SESSION1    `COEF_A3_SESSION1_FS500
`define SCALECONST2         `SCALECONST2_FS500
`define COEF_B1_SESSION2    `COEF_B1_SESSION2_FS500
`define COEF_B2_SESSION2    `COEF_B2_SESSION2_FS500
`define COEF_B3_SESSION2    `COEF_B3_SESSION2_FS500
`define COEF_A2_SESSION2    `COEF_A2_SESSION2_FS500
`define COEF_A3_SESSION2    `COEF_A3_SESSION2_FS500

   typedef enum { PIN, CMD }           start_src_t;

class `TESTCFG extends nnc_object;

   `nnc_object_utils(`TESTCFG)

    rand  integer        rand_num;

    rand logic [7:0]     data[256];
    rand int             no_of_bytes; 

    rand  bit [1:0]      testmode_sel;
    rand  bit [1:0]      spimode_sel; 
    rand  bit [1:0]      altf_sel; 
    rand  bit            wait_reset_en;
    rand  bit [1:0]      pclk_sel;              // f(pclk) = 256Khz/(2^pclk_sel)
    rand  bit [2:0]      iclk_sel;              // f(iclk) = 256Khz/(2^iclk_sel)
    rand  bit [7:0]      mclk_sel;              // f(mclk) = 256Khz/(mclk_sel+1)
    rand  bit [15:0]     spi_sclk_freq;         // unit is Khz (1Khz to 16.000Khz)
    rand  bit [6:0]      spi_clk_jitter;        // unut is percentage (0-100)
    rand  bit [6:0]      spi_sclk_jitter;       // unut is percentage (0-100)

    rand  bit		 fault_stuck0_clk_en;	// 1: internal 32KHZ and 300KHZ will be LOW (can used when we set ext_clk_en) 	

    logic [7:0]          clk_data[];

    rand  bit	         ext_clk_en;            // 1: using external clock and 0: using Internal clock
    rand  bit [2:0]      ext_clk_sel;           // 0: 8192Khz, 1: 8000Khz; 2: ...Khz; 3: 1Mhz

    rand  logic  [6:0]   hfosc_jitter;
    rand  logic  [6:0]   hfosc_variation;

    rand  bit            hfosc_fixed_gnd_en; 
    rand  bit            ext_hfosc_fixed_gnd_en;

    rand  bit [15:0]     tcssc;                 // min is 400ns
    rand  bit [15:0]     tsccs;                 // min is 400ns
    rand  bit [15:0]     tcsh;                  // min is 500ns
    rand  bit [6:0]      tdist;                 // min is 10ns - percentage from 0 -> 100
    rand  bit [6:0]      tch;                   // percentage from 0 -> 100

    rand  bit [15:0]     flash_bist_freq;               // unit is Khz (1Khz to 20.000Khz)
    rand  bit            config_in_base_test_en;        // 0: Enable config clock in base test 1: disable config in base test

    rand  bit [2:0]      wg_drv_sel;		//to select among 8 wavegen drivers
    rand  logic [31:0]   hlf_wave_per;          //half wave period setting of waveform
    rand  bit            dont_check_conf_first_en;

    rand  bit [1:0]      A2D_comp_sel;		//select the A2D_comp for lead_off_detection

    rand logic [1:0]     OTP_SEL = 0;
    rand logic [6:0]     ADDR = 0;

    randc logic [1:0]    TCK_SEL;
    rand logic [4:0]     ctrl_bit;
    rand logic           SRL;
    rand logic [7:0]     data_in;
    rand int             tPGM , tPGM_RC;
    rand int             vpp_pos_cnt, vpp_neg_cnt;
    rand int             vpp_pos_cnt_mult, vpp_neg_cnt_mult;
    rand int             vpp_width, vpp_width_mult;
    rand bit             bist_vpp_pin_en;       //control vpp by bist_vpp_en or timing
    rand bit             disable_init_flash;
    rand bit             imeas_sb_en;
    rand bit             imeas_ppg_en;
    rand bit             imeas_bio_en;
    rand bit             wake_up_en;
    rand bit             imeas_24Hz_in;

    rand bit   [1:0]     zmeas_freq_sel;        // zmeas adc freq sel (2'b00: 1Khz, 2'b01: 2Khz, 2'b10: 4Khz, 2'b11: No readmem)
    rand bit   [2:0]     zmeas_freq_val;        // zmeas dds freq sel  (For mclk 256Khz; 3'b001: 500hz, 3'b010: 1Khz, 3'b011: 2Khz, 3'b100: 4Khz, 3'b000: No freq)
    rand bit   [1:0]     zmeas_dds_wave_sel;    // zmeas dds wave type (2'b00: sine, 2'b01: dc, 2'b10: square, 2'b11: sine)
    rand logic [9:0]     dc_data_val;
    rand logic [9:0]     sq_data_lval;
    rand logic [9:0]     sq_data_hval;
    rand logic [15:0]    sq_wave_div;
    rand logic [3:0]     shr_man_val;
    rand bit             shr_man_en;
    rand bit             flash_check_conf_first_disable;

    rand logic           imeas_sin_gen_en; 
    rand logic [14:0]    imeas_sin_amp;
    rand logic [14:0]    imeas_out_diff_amp;
    rand logic [14:0]    filter_gain;
    rand logic [14:0]    imeas_sin_expected_freq; // Create wavegen with expected freqency
    rand logic [14:0]    imeas_sin_offset;
    rand logic [19:0]    imeas_sampling_rate;
    rand logic [19:0]    imeas_sin_freq;

    rand logic [2:0]     imeas_cic_rate;
    rand logic [31:0]    imeas_adc_freq;
    rand logic [15:0]    imeas_osr;
    rand logic [31:0]    imeas_samp_rate;

    rand logic [1:0]     imeas_input_format;
    rand bit             imeas_rtl_bypass_en;
    rand bit             disable_step_check;
    rand logic [1:0]     filter_gain_mult;
    rand logic [21:0]    gpio_pu_en;      // 21: RESET [20:19]: TESTMODE[1:0], [18:0]: GPI0 
    rand logic [21:0]    gpio_pd_en;      // 21: RESET [20:19]: TESTMODE[1:0], [18:0]: GPI0

    // ======================================================================================
    // reg_normal[i] struture 
    // [39:32]: Register Address
    // [31:24]: Initial value of register
    // [23:16]:  Maskable bits (Write Accessible bits)
    // [15:3]: Reserved bits
    // [2]  : Enable checker : 1: Enable, 0: Disable
    // [1:0]: Type of access: 0: RW1C, 1: Write Only, 2: Read Only, 3: RW, 2'bxx: reserved 
    // ======================================================================================
    logic [39:0]         reg_normal[`NORMAL_REG_NUM]; 

    function new (string name = "soc_base_test_cfg");
      super.new(name);
    endfunction: new

    constraint c_gpio_pu_en             { soft gpio_pu_en == 22'b1_00_000_0000_0000_0000_0000; }
    constraint c_gpio_pd_en             { soft gpio_pd_en == 22'b0_11_000_0000_0000_0000_0000; }

    constraint c_disable_step_check     { soft disable_step_check == 1'b0; }
    constraint c_imeas_rtl_bypass_en    { soft imeas_rtl_bypass_en == 1'b0; }
    constraint c_imeas_sin_gen_en       { soft imeas_sin_gen_en == 1'b0; }
    constraint c_imeas_out_diff_amp     { soft imeas_out_diff_amp == 10; }
    constraint c_filter_gain            { soft filter_gain == 1; } // Unit of 1
    constraint c_imeas_sin_expected_freq{ soft imeas_sin_expected_freq inside {[1:1000]}; }
    constraint c_imeas_sin_amp          { soft imeas_sin_amp inside {[1:15'h3FFF]};} 
    constraint c_filter_gain_mult       { (imeas_sin_amp < 15'h1000) -> filter_gain_mult inside {[0:3]};
                                         ((imeas_sin_amp < 15'h2000) && (imeas_sin_amp > 15'h0fff)) -> filter_gain_mult inside {0, 1, 3};
                                         ((imeas_sin_amp < 15'h4000) && (imeas_sin_amp > 15'h1fff)) -> filter_gain_mult inside {0, 3};
                                        }
    constraint c_imeas_sin_offset       { solve filter_gain_mult before imeas_sin_offset; 
                                          solve imeas_sin_amp before imeas_sin_offset; 
                                          imeas_sin_offset > 0; 
                                          ((filter_gain_mult == 0) || (filter_gain_mult == 3)) -> imeas_sin_offset < 16'h7FFF - imeas_sin_amp;
                                          (filter_gain_mult == 1) -> imeas_sin_offset < (16'h7FFF - imeas_sin_amp*2)/2;
                                          (filter_gain_mult == 2) -> imeas_sin_offset < (16'h7FFF - imeas_sin_amp*4)/4;
}

    constraint c_imeas_cic_rate         { soft imeas_cic_rate == 3'b001; }

    constraint c_imeas_osr              { solve imeas_cic_rate before imeas_osr ; imeas_osr == (8 * (2**imeas_cic_rate)); }

    constraint c_imeas_adc_freq         { solve iclk_sel before imeas_adc_freq; 
                                          imeas_adc_freq == (8000/(2**(iclk_sel))); }

    constraint c_imeas_samp_rate        { solve imeas_adc_freq before imeas_samp_rate; 
                                          solve imeas_osr before imeas_samp_rate; 
                                          imeas_samp_rate == ((imeas_adc_freq * 1000) / imeas_osr); } // Khz

    constraint c_imeas_sampling_rate    { solve imeas_sin_expected_freq before imeas_sampling_rate; imeas_sampling_rate == (1000000/imeas_sin_expected_freq); }
    //constraint c_imeas_sin_freq       { solve imeas_sampling_rate before imeas_sin_freq; imeas_sin_freq < imeas_sampling_rate / 2; }
    constraint c_imeas_sin_freq         { imeas_sin_freq == 1; }
    constraint c_imeas_input_format     { soft imeas_input_format == 2'b10; }

    constraint c_flash_check_conf_first_disable { soft flash_check_conf_first_disable == 1'b0; }
    constraint c_wake_up_en             { soft wake_up_en == 1'b1; }
    constraint c_disable_init_flash     { soft disable_init_flash == 1'b0; }
    constraint c_imeas_sb_en            { soft imeas_sb_en == 1'b0; }
    constraint c_imeas_ppg_en           { soft imeas_ppg_en == 1'b0; }
    constraint c_imeas_bio_en           { soft imeas_bio_en == 1'b0; }
    constraint c_imeas_24Hz_in          { soft imeas_24Hz_in == 1'b0; }
    constraint c_zmeas_freq_sel         { soft zmeas_freq_sel == 2'b00; }
    constraint c_zmeas_freq_val         { soft zmeas_freq_val == 3'b000; }
    constraint c_zmeas_dds_wave_sel     { soft zmeas_dds_wave_sel == 2'b00; }
    constraint c_dc_data_val            { soft dc_data_val == 10'h100; }
    constraint c_sq_data_lval           { soft sq_data_lval == 10'h0; }
    constraint c_sq_data_hval           { soft sq_data_hval == 10'h100; }
    constraint c_sq_wave_div            { soft sq_wave_div == 16'h000f; }
    constraint c_shr_man_val            { soft shr_man_val == 4'h0; }
    constraint c_shr_man_en             { soft shr_man_en == 1'b0; }

    constraint c_altf_sel               { soft altf_sel inside {[0:0]}; } 
    constraint c_wait_reset_en          { soft wait_reset_en == 1'b1;}
    constraint c_spimode_sel            { soft spimode_sel inside {[0:0]};}        // ; cpol=0 & cpha = 0; cpol=0 & cpha = 1; cpol=1 & cpha = 2; cpol=1 & cpha = 3
    constraint c_testmode_sel           { soft testmode_sel == 2'b00;}

    constraint c_config_in_base_test_en { soft config_in_base_test_en == 1'b1; }

`ifndef MIXSIM
    constraint c_ext_clk_en             { soft ext_clk_en inside {[0:1]};}
`else
    constraint c_ext_clk_en             { soft ext_clk_en == 0;}
`endif
    constraint c_ext_clk_sel            { soft ext_clk_sel == 2'b00; } 

    constraint c_hfosc_jitter           { soft hfosc_jitter inside {[1:5]};}        // 1* - 5%
    constraint c_hfosc_variation        { soft hfosc_variation inside {[90:110]}; } // 90% - 110%

    constraint c_hfosc_fixed_gnd_en     { soft hfosc_fixed_gnd_en == ext_clk_en; }
    constraint c_ext_hfosc_fixed_gnd_en { soft ext_hfosc_fixed_gnd_en == !ext_clk_en; }

    constraint c_spi_sclk_jitter        { soft spi_sclk_jitter inside {[1:5]};}     // 1%-5%

    constraint c_spi_clk_jitter         { soft spi_clk_jitter inside {[1:5]};}

    constraint c_pclk_sel               { soft pclk_sel inside {[0:3]};}
                                        // 0: 256Khz, 1: 128Khz, 2: 64Khz, 3: 32Khz
                                          
    constraint c_iclk_sel               { (pclk_sel == 2'b00) -> iclk_sel inside {[0:7]};
                                          (pclk_sel == 2'b01) -> iclk_sel inside {[1:7]};
                                          (pclk_sel == 2'b10) -> iclk_sel inside {[2:7]};
                                          (pclk_sel == 2'b11) -> iclk_sel inside {[3:7]};}

    constraint c_mclk_sel               { (pclk_sel == 2'b00) -> mclk_sel inside {[0:255]};
                                          (pclk_sel == 2'b01) -> mclk_sel inside {[1:255]};
                                          (pclk_sel == 2'b10) -> mclk_sel inside {[3:255]};
                                          (pclk_sel == 2'b11) -> mclk_sel inside {[7:255]};
                                        }

    constraint c_spi_sclk_freq          { solve pclk_sel before spi_sclk_freq; spi_sclk_freq inside {[/* 256/(2**pclk_sel) */ 10 : 4*256/(2**pclk_sel)]};                                      
                                        }

    constraint c_flash_bist_freq        { soft flash_bist_freq == 10000;} // 10Mhz

    constraint c_tch                    { solve spi_sclk_freq before tch;
                                          tch inside {[40:60]};
                                          tch <= (100 - spi_sclk_freq/500);
                                          tch >= spi_sclk_freq/500; }      // percent : tch >= 400ns, tCL >= 400ns

    constraint c_tcsh                   { solve tch before tcsh; solve spi_sclk_freq before tcsh; tcsh <= 4000; tcsh >= 500;
                                          (tch >= 50) -> tcsh > 100*tch/spi_sclk_freq;
                                          (tch <  50) -> tcsh > 100*(100 - tch)/spi_sclk_freq;
                                        }   // ~tCSPW (Min 400ns)

//    constraint c_tcssc                  { soft tcssc    inside {[400:4000]};}   // ~tCSSO (Min 400ns)
//    constraint c_tsccs                  { soft tsccs    inside {[400:4000]};}   // ~tCSH1 (Min 400ns)
    constraint c_tsccs                  { solve tch before tsccs; solve spi_sclk_freq before tsccs; tsccs <= 4000; tsccs >= 400;
                                          (tch >= 50) -> tsccs > 100*tch/spi_sclk_freq;
                                          (tch <  50) -> tsccs > 100*(100 - tch)/spi_sclk_freq;
                                        }   // ~tCSH1 (Min 400ns)


//    constraint c_tcsh                   { soft tcsh     inside {[500:4000]};}   // ~tCSPW (Min 500ns)
    constraint c_tdist                  { soft tdist    inside {[0:0]};}        // percent : tdist * (Period_SCK/2 - 10):
//    constraint c_tch                    { soft tch      inside {[40:60]};}      // percent : tch = tch * Period_SCK:

    constraint c_fault_stuck0_clk_en    { soft fault_stuck0_clk_en == 1'b0;} // 1: internal 32KHZ and 300KHZ will be LOW (can used when we set ext_clk_en)

    constraint c_wg_drv_sel             { soft wg_drv_sel == 0;}

    constraint c_hlf_wave_per           { soft hlf_wave_per == 0;}

    constraint c_dont_check_conf_first_en { soft dont_check_conf_first_en == 0; }// Using for Flash BIST

    constraint c_A2D_comp_sel           { soft A2D_comp_sel == 0;}

    constraint c_ctrl_bit   { ctrl_bit[0] == SRL;}
    constraint c_OTP_SEL    { OTP_SEL == 0;}

    constraint c_tPGM       {TCK_SEL == 2'b00 -> tPGM == 325;
                             TCK_SEL == 2'b01 -> tPGM == 3250;
                             TCK_SEL == 2'b10 -> tPGM == 6500;
                             TCK_SEL == 2'b11 -> tPGM == 10400;}
    constraint c_tPGM_RC    {TCK_SEL == 2'b00 -> tPGM_RC == 12;
                             TCK_SEL == 2'b01 -> tPGM_RC == 120;
                             TCK_SEL == 2'b10 -> tPGM_RC == 240;
                             TCK_SEL == 2'b11 -> tPGM_RC == 384;}  

    constraint c_vpp_pos_cnt      {vpp_pos_cnt inside {[4:24]};}
    constraint c_vpp_neg_cnt      {vpp_neg_cnt inside {[27+tPGM:42+tPGM]};}
    constraint c_vpp_pos_cnt_mult {vpp_pos_cnt_mult inside {[4:24]};}
    constraint c_vpp_neg_cnt_mult {vpp_neg_cnt_mult inside {[24+(tPGM+3)*128:24+(tPGM+3)*128+18]};}
    constraint c_no_of_bytes      { soft no_of_bytes == 2; }
    constraint c_vpp_width        {vpp_width == (vpp_neg_cnt - vpp_pos_cnt);}
    constraint c_vpp_width_mult   {vpp_width_mult == (vpp_neg_cnt_mult - vpp_pos_cnt_mult);}

endclass : `TESTCFG

class `TESTNAME extends nnc_test;

  `nnc_component_utils(`TESTNAME)

  soc_env                   top_env;
  soc_chip_cfg              top_cfg;
  `TESTCFG                  top_test_cfg;

  nnc_report_server         server;

  function new(string name = "soc_base_test", nnc_component parent=null);
    super.new(name,parent);
  endfunction: new

  extern virtual function void build_phase(nnc_phase phase);
  extern function void end_of_elaboration_phase(nnc_phase phase);
  extern virtual task pre_reset_phase(nnc_phase phase);
  extern virtual task reset_phase(nnc_phase phase);
  extern virtual task pre_main_phase(nnc_phase phase);
  extern virtual task main_phase(nnc_phase phase);
  extern virtual function void report_phase(nnc_phase phase) ;

endclass : `TESTNAME

function void `TESTNAME::build_phase(nnc_phase phase);	
  
  phase.raise_objection(this);

  super.build_phase(phase);

  `nnc_info ("build_phase", "Entered test...", NNC_HIGH)

  `nnc_top.set_timeout(2s);
  
  // nnc top config
  top_cfg = soc_chip_cfg::type_id::create("top_cfg", this);

  top_env = soc_env::type_id::create("top_env", this);

  nnc_config_db#(soc_chip_cfg)::set(this, "top_env", "top_cfg", this.top_cfg);

  top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);

  nnc_config_db#(nnc_object_wrapper)::set(this, "top_env.top_sqr.main_phase", "default_sequence", null);

  `SET_CFG_REG(`REG0);
  `SET_CFG_REG(`REG1);
  `SET_CFG_REG(`REG2);
  `SET_CFG_REG(`REG3);
  `SET_CFG_REG(`REG4);
  `SET_CFG_REG(`REG5);
  `SET_CFG_REG(`REG6);
  `SET_CFG_REG(`REG7);
  `SET_CFG_REG(`REG8);
  `SET_CFG_REG(`REG9);
  `SET_CFG_REG(`REG10);
  `SET_CFG_REG(`REG11);
  `SET_CFG_REG(`REG12);
  `SET_CFG_REG(`REG13);
  `SET_CFG_REG(`REG14);
  `SET_CFG_REG(`REG15);
  `SET_CFG_REG(`REG16);
  `SET_CFG_REG(`REG17);
  `SET_CFG_REG(`REG18);
  `SET_CFG_REG(`REG19);
  `SET_CFG_REG(`REG20);
  `SET_CFG_REG(`REG21);
  `SET_CFG_REG(`REG22);
  `SET_CFG_REG(`REG23);
  `SET_CFG_REG(`REG24);
  `SET_CFG_REG(`REG25);
  `SET_CFG_REG(`REG26);
  `SET_CFG_REG(`REG27);
  `SET_CFG_REG(`REG28);
  `SET_CFG_REG(`REG29);
  `SET_CFG_REG(`REG30);
  `SET_CFG_REG(`REG31);
  `SET_CFG_REG(`REG32);
  `SET_CFG_REG(`REG33);
  `SET_CFG_REG(`REG34);
  `SET_CFG_REG(`REG35);
  `SET_CFG_REG(`REG36);
  `SET_CFG_REG(`REG37);
  `SET_CFG_REG(`REG38);
  `SET_CFG_REG(`REG39);
  `SET_CFG_REG(`REG40);
  `SET_CFG_REG(`REG41);
  `SET_CFG_REG(`REG42);
  `SET_CFG_REG(`REG43);
  `SET_CFG_REG(`REG44);
  `SET_CFG_REG(`REG45);
  `SET_CFG_REG(`REG46);
  `SET_CFG_REG(`REG47);
  `SET_CFG_REG(`REG48);
  `SET_CFG_REG(`REG49);
  `SET_CFG_REG(`REG50);
  `SET_CFG_REG(`REG51);
  `SET_CFG_REG(`REG52);
  `SET_CFG_REG(`REG53);
  `SET_CFG_REG(`REG54);
  `SET_CFG_REG(`REG55);
  `SET_CFG_REG(`REG56);
  `SET_CFG_REG(`REG57);
  `SET_CFG_REG(`REG58); 
  `SET_CFG_REG(`REG59);
  `SET_CFG_REG(`REG60);
  `SET_CFG_REG(`REG61);
  `SET_CFG_REG(`REG62);
  `SET_CFG_REG(`REG63);
  `SET_CFG_REG(`REG64);
  `SET_CFG_REG(`REG65);
  `SET_CFG_REG(`REG66);
  `SET_CFG_REG(`REG67);
  `SET_CFG_REG(`REG68);
  `SET_CFG_REG(`REG69);
  `SET_CFG_REG(`REG70);
  `SET_CFG_REG(`REG71);
  `SET_CFG_REG(`REG72);
  `SET_CFG_REG(`REG73);
  `SET_CFG_REG(`REG74);
  `SET_CFG_REG(`REG75);
  `SET_CFG_REG(`REG76);
  `SET_CFG_REG(`REG77);
  `SET_CFG_REG(`REG78);
  `SET_CFG_REG(`REG79);
  `SET_CFG_REG(`REG80);
  `SET_CFG_REG(`REG81);
  `SET_CFG_REG(`REG82);
  `SET_CFG_REG(`REG83);
  `SET_CFG_REG(`REG84);
  `SET_CFG_REG(`REG85);
  `SET_CFG_REG(`REG86);
  `SET_CFG_REG(`REG87);
  `SET_CFG_REG(`REG88);
  `SET_CFG_REG(`REG89);
  `SET_CFG_REG(`REG90);
  `SET_CFG_REG(`REG91);
  `SET_CFG_REG(`REG92);
  `SET_CFG_REG(`REG93);
  `SET_CFG_REG(`REG94);
  `SET_CFG_REG(`REG95);
  `SET_CFG_REG(`REG96);
  `SET_CFG_REG(`REG97);
  `SET_CFG_REG(`REG98);
  `SET_CFG_REG(`REG99);
  `SET_CFG_REG(`REG100);
  `SET_CFG_REG(`REG101);
  `SET_CFG_REG(`REG102);
  `SET_CFG_REG(`REG103);
  `SET_CFG_REG(`REG104);
  `SET_CFG_REG(`REG105);
  `SET_CFG_REG(`REG106);
  `SET_CFG_REG(`REG107);
  `SET_CFG_REG(`REG108);
  `SET_CFG_REG(`REG109);
  `SET_CFG_REG(`REG110);
  `SET_CFG_REG(`REG111);
  `SET_CFG_REG(`REG112);
  `SET_CFG_REG(`REG113);
  `SET_CFG_REG(`REG114);
  `SET_CFG_REG(`REG115);
  `SET_CFG_REG(`REG116);
  `SET_CFG_REG(`REG117);
  `SET_CFG_REG(`REG118);
  `SET_CFG_REG(`REG119);
  `SET_CFG_REG(`REG120);
  `SET_CFG_REG(`REG121);
  `SET_CFG_REG(`REG122);
  `SET_CFG_REG(`REG123);
  `SET_CFG_REG(`REG124);
  `SET_CFG_REG(`REG125);
  `SET_CFG_REG(`REG126);
  `SET_CFG_REG(`REG127);
  `SET_CFG_REG(`REG128);
  `SET_CFG_REG(`REG129);
  `SET_CFG_REG(`REG130);
  `SET_CFG_REG(`REG131);
  `SET_CFG_REG(`REG132);
  `SET_CFG_REG(`REG133);
  `SET_CFG_REG(`REG134);
  `SET_CFG_REG(`REG135);
  `SET_CFG_REG(`REG136);
  `SET_CFG_REG(`REG137);
  `SET_CFG_REG(`REG138);
  `SET_CFG_REG(`REG139);
  `SET_CFG_REG(`REG140);
  `SET_CFG_REG(`REG141);
  `SET_CFG_REG(`REG142);
  `SET_CFG_REG(`REG143);
  `SET_CFG_REG(`REG144);
  `SET_CFG_REG(`REG145);
  `SET_CFG_REG(`REG146);
  `SET_CFG_REG(`REG147);
  `SET_CFG_REG(`REG148);
  `SET_CFG_REG(`REG149);
  `SET_CFG_REG(`REG150);
  `SET_CFG_REG(`REG151);
  `SET_CFG_REG(`REG152);
  `SET_CFG_REG(`REG153);
  `SET_CFG_REG(`REG154);
  `SET_CFG_REG(`REG155);
  `SET_CFG_REG(`REG156);
  `SET_CFG_REG(`REG157);
  `SET_CFG_REG(`REG158); 
  `SET_CFG_REG(`REG159);
  `SET_CFG_REG(`REG160);
  `SET_CFG_REG(`REG161);
  `SET_CFG_REG(`REG162);
  `SET_CFG_REG(`REG163);
  `SET_CFG_REG(`REG164);
  `SET_CFG_REG(`REG165);
  `SET_CFG_REG(`REG166);
  `SET_CFG_REG(`REG167);
  `SET_CFG_REG(`REG168);
  `SET_CFG_REG(`REG169);
  `SET_CFG_REG(`REG170);
  `SET_CFG_REG(`REG171);
  `SET_CFG_REG(`REG172);
  `SET_CFG_REG(`REG173);
  `SET_CFG_REG(`REG174);
  `SET_CFG_REG(`REG175);
  `SET_CFG_REG(`REG176);
  `SET_CFG_REG(`REG177);
  `SET_CFG_REG(`REG178);
  `SET_CFG_REG(`REG179);

  `nnc_info ("build_phase", "Exiting...", NNC_HIGH)
  phase.drop_objection(this);

endfunction : build_phase
  
function void `TESTNAME::end_of_elaboration_phase(nnc_phase phase);

  phase.raise_objection(this);
  `nnc_info("end_of_elaboration_phase", "Entered...",NNC_HIGH);

  super.end_of_elaboration_phase(phase);
  `nnc_top.print_topology();

  `nnc_info("end_of_elaboration_phase", "Exiting...",NNC_HIGH)
  phase.drop_objection(this);

endfunction

task `TESTNAME::pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);
  
    super.pre_reset_phase(phase); 
    `SPI_SCB_EN = 1'b1;

    /*
    `DUT_IF.print_msg_disable = 0;

    // Disable scoreboard of eeprom
    `EEPROM_SCOREBOARD_EN = 1'b0;
    */
    // Enable scoreboard of analog
    `ANALOG_SCOREBOARD_EN = 1'b1;
    // Enable checker of ao_top
    `ALWAYSON_CHECK_EN    = 1'b1;
    `FILTER_POINT_TO_POINT_SB_EN = 1'b0;
    `FILTER_PEAK_TO_PEAK_SB_EN = 1'b0;
    `FILTER_OFFSET_SB_EN = 1'b0;

    assert(top_test_cfg.randomize());

    // Enable reset waiting
    `DUT_IF.wait_reset_en = top_test_cfg.wait_reset_en;

    // Set PCLK Clocks
    `DUT_IF.pclk_sel = top_test_cfg.pclk_sel;
    `DUT_IF.iclk_sel = top_test_cfg.iclk_sel;

    // Set SCLK clock
    `DUT_IF.spi_sclk_freq = top_test_cfg.spi_sclk_freq;

    // Set Flash BIST clock
    `DUT_IF.flash_bist_freq = top_test_cfg.flash_bist_freq;

    // Select Polarity of CLK 
    `DUT_IF.spimode_sel = top_test_cfg.spimode_sel;

    // Select Operation mode for SOC 
    `DUT_IF.testmode_sel = top_test_cfg.testmode_sel;

    // Select ALTF mode for SOC PIN Configuration 
    `DUT_IF.altf_sel = top_test_cfg.altf_sel;

    // Set Jitter for PCLK 
    `DUT_IF.spi_clk_jitter = top_test_cfg.spi_clk_jitter;

    // Set Jitter for SCK
    `DUT_IF.spi_sclk_jitter  = top_test_cfg.spi_sclk_jitter;

    // Select internal/external clock sources
    `DUT_IF.ext_clk_en = top_test_cfg.ext_clk_en;			// 1: external EXT_300KHZ and EXT_32KHZ will be driven to SOC from model

    // Select frequency for external clock
    `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel;

    // 256 Khz jitter clock for both internal/external clock
    `DUT_IF.hfosc_jitter = top_test_cfg.hfosc_jitter; 

    `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;

    // enable to fix 1'b0 to internal clk
    `DUT_IF.hfosc_fixed_gnd_en = top_test_cfg.hfosc_fixed_gnd_en;

    // enable to fix 1'b0 to ext clk
    `DUT_IF.ext_hfosc_fixed_gnd_en = top_test_cfg.ext_hfosc_fixed_gnd_en;

    `DUT_IF.fault_stuck0_clk_en = top_test_cfg.fault_stuck0_clk_en;     // 1: internal 32KHZ and 300KHZ will be LOW (can used when we set ext_clk_en)

    `DUT_IF.tcssc    = top_test_cfg.tcssc;
    `DUT_IF.tsccs    = top_test_cfg.tsccs;
    `DUT_IF.tcsh     = top_test_cfg.tcsh;
    `DUT_IF.tdist    = top_test_cfg.tdist;  
    `DUT_IF.tch      = top_test_cfg.tch; 

    `DUT_IF.config_in_base_test_en = top_test_cfg.config_in_base_test_en;

    `DUT_IF.wg_drv_sel = top_test_cfg.wg_drv_sel;

    `DUT_IF.hlf_wave_per = top_test_cfg.hlf_wave_per;

    `DUT_IF.dont_check_conf_first_en = top_test_cfg.dont_check_conf_first_en;

    `DUT_IF.A2D_comp_sel = top_test_cfg.A2D_comp_sel;

    `DUT_IF.altf_gpio_sel = 2'b00;

    `DUT_IF.TCK_SEL = top_test_cfg.TCK_SEL;

    `DUT_IF.bist_vpp_pin_en = top_test_cfg.bist_vpp_pin_en;

    `DUT_IF.disable_init_flash = top_test_cfg.disable_init_flash;

    `DUT_IF.zmeas_freq_sel = top_test_cfg.zmeas_freq_sel;

    `DUT_IF.zmeas_freq_val = top_test_cfg.zmeas_freq_val;

    `DUT_IF.zmeas_dds_wave_sel = top_test_cfg.zmeas_dds_wave_sel;

    `DUT_IF.dc_data_val = top_test_cfg.dc_data_val;

    `DUT_IF.sq_data_lval = top_test_cfg.sq_data_lval;

    `DUT_IF.sq_data_hval = top_test_cfg.sq_data_hval;

    `DUT_IF.sq_wave_div = top_test_cfg.sq_wave_div;

    `DUT_IF.shr_man_val = top_test_cfg.shr_man_val;

    `DUT_IF.shr_man_en = top_test_cfg.shr_man_en;

    `DUT_IF.imeas_sb_en = top_test_cfg.imeas_sb_en;

    `DUT_IF.imeas_ppg_en = top_test_cfg.imeas_ppg_en;

    `DUT_IF.imeas_bio_en = top_test_cfg.imeas_bio_en;

    `DUT_IF.imeas_24Hz_in = top_test_cfg.imeas_24Hz_in;

    `DUT_IF.wake_up_en = top_test_cfg.wake_up_en;

    `DUT_IF.mclk_sel = top_test_cfg.mclk_sel;

    `DUT_IF.flash_check_conf_first_disable = top_test_cfg.flash_check_conf_first_disable;

    `DUT_IF.imeas_sin_gen_en = top_test_cfg.imeas_sin_gen_en;

    `DUT_IF.imeas_sin_amp = top_test_cfg.imeas_sin_amp;

    `DUT_IF.imeas_sin_offset = top_test_cfg.imeas_sin_offset;

    `DUT_IF.imeas_sampling_rate = top_test_cfg.imeas_sampling_rate;

    `DUT_IF.imeas_sin_freq = top_test_cfg.imeas_sin_freq;

    `DUT_IF.imeas_cic_rate = top_test_cfg.imeas_cic_rate;

    `DUT_IF.imeas_adc_freq = top_test_cfg.imeas_adc_freq;

    `DUT_IF.imeas_osr = top_test_cfg.imeas_osr;

    `DUT_IF.imeas_samp_rate = top_test_cfg.imeas_samp_rate;

    `DUT_IF.imeas_input_format = top_test_cfg.imeas_input_format;

    `DUT_IF.imeas_out_diff_amp = top_test_cfg.imeas_out_diff_amp;

    `DUT_IF.filter_gain = top_test_cfg.filter_gain;

    `DUT_IF.imeas_sin_expected_freq = top_test_cfg.imeas_sin_expected_freq; 

    `DUT_IF.imeas_rtl_bypass_en = top_test_cfg.imeas_rtl_bypass_en;

    `DUT_IF.disable_step_check = top_test_cfg.disable_step_check;

    `DUT_IF.filter_gain_mult = top_test_cfg.filter_gain_mult;

    `DUT_IF.gpio_pu_en = top_test_cfg.gpio_pu_en;
    `DUT_IF.gpio_pd_en = top_test_cfg.gpio_pd_en;

    phase.drop_objection(this);
endtask : pre_reset_phase

task `TESTNAME::reset_phase(nnc_phase phase);
    phase.raise_objection(this);
    super.reset_phase(phase);
/*
    if (`DUT_IF.altf_sel !== 2'b00) begin      
       assert(top_test_cfg.randomize() with { testmode_sel == 2'b10; ADDR == 8'h00; data_in == 8'h5A; });
       // Change to Bist mode for SOC
       `DUT_IF.testmode_sel = top_test_cfg.testmode_sel;
        #150us;
        `EPROM_BIST_MASTER_VIP.set_freq_sel(top_test_cfg.TCK_SEL);   //2'b00->1M  ;  2'b01->10M ;  2'b10 -> 20M ;  2'b11 -> 32M
        top_test_cfg.TCK_SEL.rand_mode(0);

       `nnc_info("SOC_TEST", "[EPROM BIST MASTER][0] Sending Reset Command to EPROM", NNC_LOW);
       `EPROM_BIST_MASTER_VIP.reset;
       `nnc_info("SOC_TEST", "[EPROM BIST MASTER] Complete successully this phase", NNC_LOW);

       // Program OTP
       `EPROM_BIST_MASTER_VIP.single_program_eprom(top_test_cfg.ADDR, top_test_cfg.data_in, top_test_cfg.OTP_SEL);
       assert(top_test_cfg.randomize() with { ADDR == 8'h0A; data_in == {6'h0, `DUT_IF.altf_sel}; });
       `EPROM_BIST_MASTER_VIP.single_program_eprom(top_test_cfg.ADDR, top_test_cfg.data_in, top_test_cfg.OTP_SEL);

       `nnc_info("SOC_TEST", "[EPROM BIST MASTER][0] Sending Reset Command to EPROM", NNC_LOW);
       `EPROM_BIST_MASTER_VIP.reset;
       `nnc_info("SOC_TEST", "[EPROM BIST MASTER] Complete successully this phase", NNC_LOW);
       
       assert(top_test_cfg.randomize() with { testmode_sel == 2'b00;} );
       // Change to Normal mode for SOC
       `DUT_IF.testmode_sel = top_test_cfg.testmode_sel;  
     
       `nnc_info("SOC_TEST", "Apply Reset via pin", NNC_LOW)
       `SOC_TB.ext_resetn=1'b0;
       #10us;
       `SOC_TB.ext_resetn=1'b1;
       #100us;      
       //`RD_NORMAL_REG(`SOC_EEPROM_DEBUG_1_REG, 0, top_test_cfg.data[0]);
       //while (top_test_cfg.data[0][5] != 0) `RD_NORMAL_REG(`SOC_EEPROM_DEBUG_1_REG, 0, top_test_cfg.data[0]);
       `DUT_IF.altf_gpio_sel = `DUT_IF.altf_sel;

    end
*/
    if (`DUT_IF.testmode_sel === 2'b00) begin

     // fork
      if (`DUT_IF.wait_reset_en) begin
        `nnc_info("TOP", "Waiting for reset operation completely", NNC_LOW)
         wait(`DUT_IF.soc_resetn); // SOC Reset
        `nnc_info(get_type_name(), "Reset is done", NNC_MEDIUM)
        #1000ns;
      end
 
      if (`DUT_IF.config_in_base_test_en === 1'b1) begin 
        if (`DUT_IF.pclk_sel !== 2'b00  || `DUT_IF.iclk_sel !== 3'b010) begin
          top_test_cfg.no_of_bytes = 8'h0;
          top_test_cfg.data[0] = {2'b0,`DUT_IF.iclk_sel, `DUT_IF.pclk_sel, 1'b0};
          `nnc_info("SOC_TEST", "Single Writing to CLK_CTRL Register", NNC_LOW)
          //`WR_WAVEGEN_REG(top_test_cfg.reg_addr, top_test_cfg.wr_data[0], top_test_cfg.pads);
          `WR_NORMAL_REG(`SOC_CLK_CTRL_REG, top_test_cfg.data[0], 8'h00);
        end
        if (`DUT_IF.mclk_sel !== `SOC_MCLK_DIV_REG_INIT) begin
          top_test_cfg.no_of_bytes = 8'h0;
          top_test_cfg.data[0] = `DUT_IF.mclk_sel;
          `nnc_info("SOC_TEST", "Single Writing to a MCLK_DIV Register", NNC_LOW)
          `WR_NORMAL_REG(`SOC_MCLK_DIV_REG, top_test_cfg.data[0], 8'h00);
        end
      end

    end
    else
      if (`DUT_IF.wait_reset_en) begin
        `nnc_info("TOP", "Waiting for reset operation completely", NNC_LOW)
        wait(`DUT_IF.resetn);// SPIS Reset
        `nnc_info(get_type_name(), "Reset is done", NNC_MEDIUM)
      end
    `DUT_IF.print_msg_disable = 1;

    phase.drop_objection(this);
endtask : reset_phase
/*
task `TESTNAME::post_reset_phase(nnc_phase phase);
    phase.raise_objection(this);
    phase.drop_objection(this);
endtask : post_reset_phase
*/
task `TESTNAME::pre_main_phase(nnc_phase phase);
    phase.raise_objection(this);
    super.pre_main_phase(phase);

    // Disable scoreboard of SPIS
   `ifndef BEHAVIORAL 
  //  `SPIS_SCOREBOARD_EN = 1'b0;
   `endif

    `nnc_info ("pre_main_phase", "Exiting...", NNC_HIGH)
    phase.drop_objection(this);
endtask

task `TESTNAME::main_phase(nnc_phase phase);

  phase.raise_objection(this);
  super.main_phase(phase);
  `nnc_info("main_phase", "Entered...",NNC_HIGH);
/*
  fork
    begin
      #300ms;
      `nnc_info ("main_phase", "timeout...", NNC_LOW)
      $finish;
    end
  join_none
*/
  `nnc_info ("main_phase", "Exiting...", NNC_HIGH)
  phase.drop_objection(this);

endtask

function void `TESTNAME::report_phase(nnc_phase phase);
 
  nnc_report_server report;
 
  phase.raise_objection(this);

  super.report_phase(phase);

  `nnc_info("report_phase", "Entered...", NNC_HIGH)

  report = nnc_report_server::get_server();

  if (top_env.top_sqr.dut_if.err_cnt != 0)
    `nnc_error("TEST", $sformatf("ERROR is happened during the test simulation with no of err_cnt = %d", top_env.top_sqr.dut_if.err_cnt))
    
  if((report.get_severity_count(NNC_ERROR) == 0) && (report.get_severity_count(NNC_FATAL) == 0)) begin
      $display("\n\n");
      $display("\t                    _____________________________________                    ");
      $display("\t                   /                                     \                   ");
      $display("\t ////////////////////.          TEST PASSED            ./////////////////////");
      $display("\t                   \_____________________________________/                   ");
  end
  else begin
      $display("\n");
      $display("\t                          _________________________                          ");
      $display("\t                         X                         X                         ");
      $display("\t///////////////////XXXXXX       TEST FAILED         XXXXXX///////////////////");
      $display("\t                         X_________________________X                         ");
      $display("\n");
  end
      $display("\n");
      $display("                              Summary                                        ");
      $display("-----------------------------------------------------------------------------");
      $display("   NNC_FATAL Count   :  %3d",report.get_severity_count(NNC_FATAL));
      $display("   NNC_ERROR Count   :  %3d",report.get_severity_count(NNC_ERROR));
      $display("   NNC_WARNING Count :  %3d",report.get_severity_count(NNC_WARNING));
      $display("   NNC_INFO  Count   :  %3d",report.get_severity_count(NNC_INFO));
   phase.drop_objection(this);

endfunction

// Register class
class nnc_register;
  string name;
  logic [7:0] address;
  logic [7:0] default_value;
  logic [7:0] mask_value;
  logic [7:0] access;
  logic [7:0] pads;
  //logic wavegen_reg;

  function new(string name, logic[7:0] address, logic[7:0] default_value, logic[7:0] mask_value, logic[7:0] access/*, logic wavegen_reg*/);
    this.name = name;
    this.address = address;
    this.default_value = default_value;
    this.mask_value = mask_value;
    this.access = access;
    //this.wavegen_reg = wavegen_reg;
    this.pads = 'h0;
    `nnc_info("SOC_TEST", $sformatf("create nnc_register for addr %0h", address),UVM_LOW);
  endfunction

  // Read method
  task read_init();
    // Read data from address
    if(^address !== 1'bx)begin
      /*if(wavegen_reg)begin
	`nnc_info("SOC_TEST", $sformatf("read_init :: wavegen reg address %0h", address),UVM_LOW);
        //`RD_RESET_CHK_WAVEGEN_REG(address, default_value, pads);
      end
      else */begin
	`nnc_info("SOC_TEST", $sformatf("read_init :: normal reg address %0h", address),UVM_LOW);
        `RD_RESET_CHK_NORMAL_REG(address, default_value, pads);
      end
    end
    else begin
      `nnc_info("SOC_TEST", $sformatf("Register do not exist for read_init:: address %0h", address),UVM_DEBUG);
    end
  endtask

  // Write method
  task write_read(input bit[7:0] wr_data);
    // Perform write access 
    if(^address !== 1'bx)begin
      if (access === 1) begin //WO - write only
        /*if(wavegen_reg) begin
	  `nnc_info("SOC_TEST", $sformatf("write_read WO :: wavegen reg address %0h", address),UVM_LOW);
          //`WR_WAVEGEN_REG(address, wr_data, pads);
        end
        else */begin
	  `nnc_info("SOC_TEST", $sformatf("write_read WO :: normal reg address %0h", address),UVM_LOW);
          `WR_NORMAL_REG(address, wr_data, pads);
        end
      end
      if (access === 3) begin //WR - write and read
        /*if(wavegen_reg)begin
	  `nnc_info("SOC_TEST", $sformatf("write_read WR :: wavegen reg address %0h", address),UVM_LOW);
          //`WR_RD_CHK_WAVEGEN_REG(address, wr_data, pads, mask_value);
        end
        else */begin
	  `nnc_info("SOC_TEST", $sformatf("write_read WR :: normal reg address %0h", address),UVM_LOW);
          `WR_RD_CHK_NORMAL_REG(address, wr_data, pads, mask_value);
        end
      end
      else begin
      // error for writing in read only register 
      end
    end
    else begin
      `nnc_info("SOC_TEST", $sformatf("Register do not exist for write_read:: address %0h", address),UVM_DEBUG);
    end
  endtask

  task check_reserved_regs(input logic [7:0]reserved_addr,input bit[7:0] wr_data);
    logic [7:0] rd_data;
    /*if(wavegen_reg)begin
      //`nnc_info("SOC_TEST", $sformatf("check_reserved_regs WR :: wavegen reg address %0h", reserved_addr),UVM_LOW);
      //`WR_WAVEGEN_REG(reserved_addr, wr_data, pads);
      //`RD_WAVEGEN_REG(reserved_addr, pads, rd_data);
      //if(rd_data !== 8'h0)`nnc_error("TEST", $sformatf("check_reserved_regs WR :: for wavegen reg reserved addr =%0h , read_data=%0h exp=8'h0",reserved_addr,rd_data))
    end
    else*/ begin
      `nnc_info("SOC_TEST", $sformatf("check_reserved_regs WR :: normal reg address %0h", reserved_addr),UVM_LOW);
      `WR_NORMAL_REG(reserved_addr, wr_data, pads);
      `RD_NORMAL_REG(reserved_addr, pads, rd_data);
      if(rd_data !== 8'h0)`nnc_error("TEST", $sformatf("check_reserved_regs WR :: for normal reg reserved addr =%0h , read_data=%0h exp=8'h0",reserved_addr,rd_data))
    end
  endtask
endclass
`endif

