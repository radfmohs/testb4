/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_zmeas_to_imeas_bio_electricity_test.sv                                                   
// Project	: Nanochap BAF4P1                                  		        
// Description	: Testcase soc_zmeas_to_imeas_bio_electricity_test                                             
// Designer	: ophina@nanochap.com                                                                 
// Date		: 06-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_zmeas_to_imeas_bio_electricity_test
`define TESTCFG soc_zmeas_to_imeas_bio_electricity_test_cfg

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // -----------------------------------------------
  // Adding your new varialbles in config test
  // -----------------------------------------------
  logic [2:0] mode;
  rand logic [2:0] freq_val;
  rand logic [1:0] tx_gain_sel;
  rand logic       rx_pga_gain;
  rand logic       calib;
  rand logic       zmeas_analog_en;
  rand logic [1:0]  dds_wave_sel;        // 2'b00: sine, 2'b01: dc, 2'b10: square, 2'b11: ecg cal sine
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

  function new (string name = "soc_zmeas_to_imeas_bio_electricity_test_cfg");
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
  constraint c_spi_sclk_freq  { soft spi_sclk_freq inside {[256 : 256/(2**pclk_sel)*4]}; }
  // top_test_cfg.top_test_cfg.iclk_sel values
  constraint c_iclk_sel       { soft iclk_sel == 0; }
  // top_test_cfg.top_test_cfg.mclk_sel values
  constraint c_mclk_sel       { soft mclk_sel == `SOC_MCLK_DIV_REG_INIT; }
  // top_test_cfg.top_test_cfg.freq_val values
  constraint c_freq_val       { soft freq_val inside {[1:1]}; }
  // top_test_cfg.top_test_cfg.dds_wave_sel values
  constraint c_dds_wave_sel   { soft dds_wave_sel inside {[0:0]}; }
  // top_test_cfg.top_test_cfg.ch_mode values
  constraint c_ch_mode        { soft ch_mode == `IMEAS_CHA_MODE_SINGLE; }//single channel mode
  // top_test_cfg.top_test_cfg.ch_num values
  constraint c_ch_num         { soft ch_num inside {[0:0]}; }
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
  constraint c_cic_rate       { soft cic_rate inside {[1:1]}; }
  // top_test_cfg.top_test_cfg.checkclk_div_reg values
  constraint c_checkclk_reg   { checkclk_div_reg inside {49,61,124,249,499,999}; }

  // -----------------------------------------------
  // End of adding constraints of randomization
  // -----------------------------------------------  
endclass : `TESTCFG

class `TESTNAME extends soc_base_test;

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
    `DUT_IF.pclk_sel = top_test_cfg.pclk_sel;

    `DUT_IF.iclk_sel = top_test_cfg.iclk_sel;

    `DUT_IF.mclk_sel = top_test_cfg.mclk_sel;

    `DUT_IF.spi_sclk_freq = top_test_cfg.spi_sclk_freq;

    `DUT_IF.imeas_cic_rate = top_test_cfg.cic_rate;

    `DUT_IF.imeas_input_format = top_test_cfg.imeas_input_format;

    // ==================
    // Scoreboard enables
    // ==================
    `SPI_SCB_EN = 1'b0;
    `DUT_IF.imeas_sb_en = 1'b1;
    `DUT_IF.imeas_bio_en = 1'b1;

    phase.drop_objection(this);
  endtask : pre_reset_phase

  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_zmeas_to_imeas_bio_electricity_test start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ----------------------------------------------------------------------------------  
    `nnc_info("SOC_TEST",$sformatf("Simulation Begin!!!"),UVM_LOW);
    `nnc_info("SOC_TEST",$sformatf("Imeas single channel bio-electricity flow test"),UVM_LOW);
    do_run;
    
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

  virtual task do_run;
    begin

      force `SOC_TB.u_imeas_ch0_refmodel.ADCDec.decIA.Din = `ANA_TOP.A2D_SDM_OUT;//only ch0 considered in this test

   //Set check_clk_div
    ////------------- to write in to the SOC_CHECK_CLK_DIV_LO_REG reg--------------//
      `WR_NORMAL_REG(`SOC_CHECK_CLK_DIV_LO_REG, top_test_cfg.checkclk_div_reg[7:0], top_test_cfg.pads);
    ////------------- to write in to the SOC_CHECK_CLK_DIV_HI_REG reg--------------//
      `WR_NORMAL_REG(`SOC_CHECK_CLK_DIV_HI_REG, top_test_cfg.checkclk_div_reg[15:8], top_test_cfg.pads);

       top_test_cfg.wr_data[0] = 8'h01;
   //Enable ZMEAS
    ////------------- to write in to the SOC_ZMEAS_EN reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_EN, top_test_cfg.wr_data[0], top_test_cfg.pads);
   //Enable IMEAS
    ////------------- to write in to the SOC_IMEAS_EN reg--------------//
       `WR_NORMAL_REG(`SOC_IMEAS_EN, top_test_cfg.wr_data[0], top_test_cfg.pads);

       top_test_cfg.wr_data[0] = {6'b0,top_test_cfg.dds_wave_sel};
    //Select dds output wave type
    ////------------- to write in to the SOC_DATA_TYPE_SEL reg--------------//
       `WR_NORMAL_REG(`SOC_DATA_TYPE_SEL, top_test_cfg.wr_data[0], top_test_cfg.pads);

       top_test_cfg.wr_data[0] = {6'b0,top_test_cfg.imeas_input_format};
       `nnc_info("SOC_TEST", $sformatf("imeas input format: (0x%x)",top_test_cfg.imeas_input_format),UVM_LOW)
    //Set IMEAS input format
    ////------------- to write in to the SOC_IMEAS_INPUT_FORMAT reg--------------//
       `WR_NORMAL_REG(`SOC_IMEAS_INPUT_FORMAT, top_test_cfg.wr_data[0], top_test_cfg.pads);

       `nnc_info("SOC_TEST", "Configure Imeas!", UVM_LOW)
       `nnc_info("SOC_TEST",$sformatf("CIC_RATE: %d", (32 * 2**top_test_cfg.cic_rate)),UVM_LOW)
       `nnc_info("SOC_TEST", "Enable imeas bio interrupt!", UVM_LOW)
       top_test_cfg.wr_data[0] = {top_test_cfg.ppg_mode,top_test_cfg.cic_rate,1'b0,top_test_cfg.bio_int_en,top_test_cfg.restart_en,top_test_cfg.int_en};
    ////------------- to write in to the SOC_IMEAS_REG_CTRL_0 reg--------------//
       `WR_NORMAL_REG(`SOC_IMEAS_REG_CTRL_0, top_test_cfg.wr_data[0], top_test_cfg.pads);

       `nnc_info("SOC_TEST", "Configure Channel!", UVM_LOW)
       top_test_cfg.wr_data[0] = {top_test_cfg.ch_num,1'b0,top_test_cfg.format_sel,top_test_cfg.ch_mode};
     ////------------- to write in to the SOC_IMEAS_MODE_REG reg--------------//
       `WR_NORMAL_REG(`SOC_IMEAS_MODE_REG, top_test_cfg.wr_data[0], top_test_cfg.pads);

       top_test_cfg.mode = `ZMEAS_NOOP;
       top_test_cfg.wr_data[0] = {top_test_cfg.mode,5'b0};
       `nnc_info("SOC_TEST", "zmeas no-operation mode", UVM_LOW)
       ////------------- to write in to the SOC_ZMEAS_REG_CTRL_1 reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_REG_CTRL_1, top_test_cfg.wr_data[0], top_test_cfg.pads);

       #1000;
       top_test_cfg.mode = `ZMEAS_INIT;
       top_test_cfg.wr_data[0] = {top_test_cfg.tx_gain_sel[1],top_test_cfg.calib,top_test_cfg.zmeas_analog_en,top_test_cfg.tx_gain_sel[0],1'b0,top_test_cfg.rx_pga_gain,2'b0};
       top_test_cfg.wr_data[1] = {top_test_cfg.mode,5'b0};
       top_test_cfg.wr_data[2] = {5'b0,top_test_cfg.freq_val};
       
       `nnc_info("SOC_TEST", "zmeas init mode to start DDS", UVM_LOW)
    ////------------- to write in to the SOC_ZMEAS_REG_CTRL_0 reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_REG_CTRL_0, top_test_cfg.wr_data[0], top_test_cfg.pads);

    ////------------- to write in to the SOC_ZMEAS_REG_CTRL_2 reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_REG_CTRL_2, top_test_cfg.wr_data[2], top_test_cfg.pads);

    ////------------- to write in to the SOC_ZMEAS_REG_CTRL_1 reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_REG_CTRL_1, top_test_cfg.wr_data[1], top_test_cfg.pads);

       top_test_cfg.wr_data[0] = 8'h00;
       `nnc_info("SOC_TEST", "imeas start measure!", UVM_LOW)
     ////------------- to write in to the SOC_IMEAS_REG_SEQ, reg--------------//
       `WR_NORMAL_REG(`SOC_IMEAS_REG_SEQ, top_test_cfg.wr_data[0], top_test_cfg.pads);

       top_test_cfg.no_of_bytes = 8'h06;
       top_test_cfg.rd_data_reg = new[top_test_cfg.no_of_bytes];

    repeat(1) begin
    //Wait for imeas interrupt
       wait(`SOC_TB.IOBUF_PAD[4] === 1'b1);
    ///-------------to read from the SOC_IMEAS_STATUS reg-------------------//
       `RD_NORMAL_REG(`SOC_IMEAS_STATUS,top_test_cfg.pads,top_test_cfg.int_sts);
       
    //Check int status
       if(top_test_cfg.int_sts[3] !== 1'b1)
	  `nnc_error("SOC_TEST", "[ERROR][3] imeas bio interrupt failed!")
       else
	  `nnc_info("SOC_TEST", "imeas bio interrupt occurred!", UVM_LOW)

    ///-------------to read burst starting from the SOC_IMEAS_CH0DATA_MAX_0 reg-------------------//
       `RD_BURST_NORMAL_REG(`SOC_IMEAS_CH0DATA_MAX_0, top_test_cfg.no_of_bytes, top_test_cfg.rd_data_reg);

       `DUT_IF.ch0_data_max[7:0]   = top_test_cfg.rd_data_reg[5];
       `DUT_IF.ch0_data_max[15:8]  = top_test_cfg.rd_data_reg[4];
       `DUT_IF.ch0_data_min[7:0]   = top_test_cfg.rd_data_reg[3];
       `DUT_IF.ch0_data_min[15:8]  = top_test_cfg.rd_data_reg[2];
       `DUT_IF.ch0_data_delta[7:0] = top_test_cfg.rd_data_reg[1];
       `DUT_IF.ch0_data_delta[15:8]= top_test_cfg.rd_data_reg[0];

    ////------------- to write in to the SOC_IMEAS_STATUS reg--------------//
       `WR_NORMAL_REG(`SOC_IMEAS_STATUS, top_test_cfg.int_sts, top_test_cfg.pads);

     ///-------------to read from the SOC_IMEAS_STATUS reg-------------------//
       `RD_NORMAL_REG(`SOC_IMEAS_STATUS,top_test_cfg.pads,top_test_cfg.int_sts);

    //Check int status
       if(top_test_cfg.int_sts[3] !== 1'b0)
           `nnc_error("SOC_TEST", "[ERROR][4] imeas bio interrupt not cleared!")
       else
	   `nnc_info("SOC_TEST", "imeas bio interrupt cleared!", UVM_LOW)
    //end of repeat loop
    end

       top_test_cfg.wr_data[0] = 8'h04;
       `nnc_info("SOC_TEST", "Stop filter!", UVM_LOW)
    ////------------- to write in to the SOC_IMEAS_REG_SEQ, reg--------------//
       `WR_NORMAL_REG(`SOC_IMEAS_REG_SEQ, top_test_cfg.wr_data[0], top_test_cfg.pads);

   end
  endtask
     
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME
