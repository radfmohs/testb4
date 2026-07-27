/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_imeas_bio_electricity_filter_test_extended_50hz.sv                                                   
// Project	: Nanochap BAF4P1                                  		        
// Description	: Testcase soc_imeas_bio_electricity_filter_test_extended_50hz                                             
// Designer	: shreeyal@nanochap.com                                                                 
// Date		: 02-08-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_imeas_bio_electricity_filter_test_extended_50hz
`define TESTCFG soc_imeas_bio_electricity_filter_test_extended_50hz_cfg

class `TESTCFG extends soc_imeas_bio_electricity_filter_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // -----------------------------------------------
  // Adding your new varialbles in config test
  // -----------------------------------------------
  rand logic [2:0] cic_rate;
  rand logic [1:0] imeas_input_format;
  rand logic [1:0] ch_mode;
  rand logic       format_sel;
  rand logic [3:0] ch_num;
  rand logic       int_en;
  rand logic       restart_en;
  rand logic       bio_int_en;
  rand logic       ppg_mode;
  rand logic [15:0] checkclk_div_reg;
       logic [7:0] int_sts;
  //------------------------------------------------------------------------------
  //---------------------------- SPI ---------------------------------------------
  rand logic [7:0] mask;
  rand logic [7:0] pads;
  rand logic [7:0] no_of_bytes;
  rand logic [7:0] wr_data[256];
  rand logic [7:0] rd_data;
  rand logic [7:0] rd_data_reg[];
  //------------------------------------------------------------------------------
  // -----------------------------------------------
  // End of decalration of new variables 
  // -----------------------------------------------

  function new (string name = "soc_imeas_bio_electricity_filter_test_extended_50hz_cfg");
    super.new(name);    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // top_test_cfg.top_test_cfg.pads values
  constraint c_pads           { soft pads == 8'h00; }
  // top_test_cfg.top_test_cfg.mask values
  constraint c_mask           { soft mask == 8'hFF; }
  // top_test_cfg.top_test_cfg.pclk_sel values
  constraint c_pclk_sel       { soft pclk_sel == 0; }
  // top_test_cfg.top_test_cfg.iclk_sel values
  constraint c_iclk_sel       { soft iclk_sel == 0; }
  // top_test_cfg.top_test_cfg.ch_mode values
  constraint c_ch_mode        { soft ch_mode == `IMEAS_CHA_MODE_SINGLE; }//single channel mode
  // top_test_cfg.top_test_cfg.ch_num values
  constraint c_ch_num         { soft ch_num inside {[0:7]}; }
  // top_test_cfg.top_test_cfg.format_sel values
  constraint c_format_sel     { soft format_sel == `IMEAS_CHA_FORMAT_SIGNED; }
  // top_test_cfg.top_test_cfg.int_en values
  constraint c_int_en         { soft int_en == 1'b0; }//eoc interrupt disabled
  // top_test_cfg.top_test_cfg.bio_int_en values
  constraint c_bio_int_en     { soft bio_int_en == 1'b1; }//bio interrupt enabled
  // top_test_cfg.top_test_cfg.restart_en values
  constraint c_restart_en     { soft restart_en == 1'b0; }//restart disabled
  // top_test_cfg.top_test_cfg.ppg_mode values
  constraint c_ppg_mode       { soft ppg_mode == 1'b0; }//ppg mode disabled
  // top_test_cfg.top_test_cfg.cic_rate values
  constraint c_cic_rate       { soft cic_rate inside {[2:5]}; }//constraint to 256 OSR, so that the sample rate is 500Hz
  // top_test_cfg.top_test_cfg.checkclk_div_reg values
  constraint c_checkclk_reg   { checkclk_div_reg inside {49,61,124,249,499,999}; }
  // top_test_cfg.top_test_cfg.imeas_sin_gen_en values
  constraint c_imeas_sin_gen_en  { soft imeas_sin_gen_en == 1'b1; }

  constraint c_disable_step_check     { soft disable_step_check == 1'b1; }

  //constraint c_imeas_sin_amp          { soft imeas_sin_amp == 15'h7FFF; }
  //constraint c_imeas_sin_offset       { imeas_sin_offset == 0;}
  //constraint c_imeas_sampling_rate    { imeas_sampling_rate == 20000; }
  //constraint c_imeas_sin_freq         { imeas_sin_freq == 1; }
  constraint c_imeas_sin_expected_freq{ soft imeas_sin_expected_freq inside {[50:50]}; }


  constraint c_imeas_rtl_bypass_en    { imeas_rtl_bypass_en == 1'b1; }
  // -----------------------------------------------
  // End of adding constraints of randomization
  // -----------------------------------------------  
endclass : `TESTCFG

class `TESTNAME extends soc_imeas_bio_electricity_filter_test;

  `nnc_component_utils(`TESTNAME)

  `TESTCFG top_test_cfg;
   
  function new(string name, nnc_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(nnc_phase phase);
    super.build_phase(phase);
    uvm_top.set_timeout(10s);
    top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);
  endfunction

  virtual task pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);

    super.pre_reset_phase(phase);

    assert(top_test_cfg.randomize());
    //assert(top_test_cfg.randomize() with { imeas_sin_expected_freq inside {[50:50]}; imeas_sin_expected_freq < 256000/(4 * 2**(iclk_sel+1+cic_rate+5)); });

    `DUT_IF.pclk_sel = top_test_cfg.pclk_sel;
    `DUT_IF.iclk_sel = top_test_cfg.iclk_sel;
    `DUT_IF.mclk_sel = top_test_cfg.mclk_sel;
    `DUT_IF.spi_sclk_freq = top_test_cfg.spi_sclk_freq;
    `DUT_IF.imeas_cic_rate = top_test_cfg.cic_rate;

    `DUT_IF.imeas_sin_gen_en = top_test_cfg.imeas_sin_gen_en;

    //`DUT_IF.imeas_sin_amp = top_test_cfg.imeas_sin_amp;

    //`DUT_IF.imeas_sin_offset = top_test_cfg.imeas_sin_offset;

    `DUT_IF.imeas_sin_expected_freq = top_test_cfg.imeas_sin_expected_freq;

    `DUT_IF.imeas_sampling_rate = top_test_cfg.imeas_sampling_rate;

    `DUT_IF.imeas_sin_freq = top_test_cfg.imeas_sin_freq;

    `DUT_IF.imeas_rtl_bypass_en = top_test_cfg.imeas_rtl_bypass_en;

    `DUT_IF.disable_step_check = top_test_cfg.disable_step_check;
    // ==================
    // Scoreboard enables
    // ==================
    `SPI_SCB_EN = 1'b0;
    `DUT_IF.imeas_sb_en = 1'b0;
    `DUT_IF.imeas_bio_en = 1'b0;

    `FILTER_POINT_TO_POINT_SB_EN = 0;
    `FILTER_PEAK_TO_PEAK_SB_EN = 1;

    phase.drop_objection(this);
  endtask : pre_reset_phase

  virtual task main_phase(uvm_phase phase);
    super.main_phase(phase);
    phase.raise_objection(this);

    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

     
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME
