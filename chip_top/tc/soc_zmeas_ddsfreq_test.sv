/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_zmeas_ddsfreq_test.sv                                                   
// Project	: Nanochap BAF4P1                                  		        
// Description	: Testcase soc_zmeas_ddsfreq_test                                             
// Designer	: ophina@nanochap.com                                                                 
// Date		: 06-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_zmeas_ddsfreq_test
`define TESTCFG soc_zmeas_ddsfreq_test_cfg

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
  rand logic       repeat_cal;
  rand logic [3:0] repeat_num;
  rand logic [7:0] settling_time;
  rand logic       int_en;
       logic [7:0] int_sts;
       logic [15:0] status;
       logic [31:0] zmeas_data;
  rand logic [1:0]  dds_wave_sel;        // 2'b00: sine, 2'b01: dc, 2'b10: square, 2'b11: ecg cal sine
  rand logic [9:0]  dc_data_val;
  rand logic [9:0]  sq_data_lval;
  rand logic [9:0]  sq_data_hval;
  rand logic [15:0] sq_wave_div;
  //------------------------------------------------------------------------------
  //---------------------------- SPI ---------------------------------------------
  rand logic [7:0] mask;
  rand logic [7:0] pads;
  rand logic [7:0] no_of_bytes;
  rand logic [7:0] wr_data[256];
  rand logic [7:0] rd_data;
  rand logic [7:0] rd_data_reg[];
  //---------------------------- FLASH -------------------------------------------
       logic [7:0] flash_debug_status;
  //------------------------------------------------------------------------------
  // -----------------------------------------------
  // End of decalration of new variables 
  // -----------------------------------------------

  function new (string name = "soc_zmeas_ddsfreq_test_cfg");
    super.new(name);    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // top_test_cfg.top_test_cfg.pads values
  constraint c_pads           { soft pads == 8'h00; }
  // top_test_cfg.top_test_cfg.mask values
  constraint c_mask           { soft mask == 8'hFF; }
  // top_test_cfg.top_test_cfg.settling_time values
  constraint c_settling_time  { soft settling_time == 8'h00; }
  // top_test_cfg.top_test_cfg.freq_val values
  constraint c_freq_val       { soft freq_val inside {[0:4]}; }
  // top_test_cfg.top_test_cfg.dds_wave_sel values
  constraint c_dds_wave_sel   { soft dds_wave_sel inside {[0:2]}; }
  // top_test_cfg.top_test_cfg.sq_data_lval values
  constraint c_sq_data_lval   { soft sq_data_lval inside {[0:400]}; }
  // top_test_cfg.top_test_cfg.sq_data_hval values
  constraint c_sq_data_hval   { soft sq_data_hval inside {[600:1023]}; }
  // top_test_cfg.top_test_cfg.sq_wave_div values
  constraint c_sq_wave_div    { soft sq_wave_div inside {[0:999]}; }//base clk is 1Khz

  constraint c_ext_clk_sel    { soft ext_clk_sel inside{[1:1]}; }
    
  constraint c_hfosc_variation        { soft hfosc_variation inside {[100:100]}; } // 90% - 110%
  // -----------------------------------------------
  // End of adding constraints of randomization
  // -----------------------------------------------  
endclass : `TESTCFG

class `TESTNAME extends soc_zmeas_base_test;

  `nnc_component_utils(`TESTNAME)

  `TESTCFG top_test_cfg;
   
  function new(string name, nnc_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(nnc_phase phase);
    super.build_phase(phase);
    uvm_top.set_timeout(2s);
    top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);
    // enable ZMEAS frequancy monitor
    top_cfg.zmeas_freq_cfg.zmeas_freq_mon_en = 1;
  endfunction

  virtual task pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);

    super.pre_reset_phase(phase);

    assert(top_test_cfg.randomize());
    
    `DUT_IF.zmeas_freq_val = top_test_cfg.freq_val;

    `DUT_IF.zmeas_dds_wave_sel = top_test_cfg.dds_wave_sel;

    `DUT_IF.dc_data_val = top_test_cfg.dc_data_val;

    `DUT_IF.sq_data_lval = top_test_cfg.sq_data_lval;

    `DUT_IF.sq_data_hval = top_test_cfg.sq_data_hval;

    `DUT_IF.sq_wave_div = top_test_cfg.sq_wave_div;
    
    // Select frequency for external clock - Required to unlock is ext_clk is 1MHz
    `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel;

    `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;

    // ==================
    // Scoreboard enables
    // ==================
    `SPI_SCB_EN = 1'b0;

    phase.drop_objection(this);
  endtask : pre_reset_phase

  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_zmeas_ddsfreq_test start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ----------------------------------------------------------------------------------  
    `nnc_info("SOC_TEST",$sformatf("Simulation Begin!!!"),UVM_LOW);
    `nnc_info("SOC_TEST",$sformatf("ZMEAS DDS output test"),UVM_LOW);
    do_run;
    
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

  virtual task do_run;
    begin

       top_test_cfg.wr_data[0] = 8'h01;
   //Enable ZMEAS
    ////------------- to write in to the SOC_ZMEAS_EN reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_EN, top_test_cfg.wr_data[0], top_test_cfg.pads);
       `WR_NORMAL_REG(`SOC_FLASH_UNLOCK_PRO, 8'hAA, top_test_cfg.pads);

    ///-------------to read from the SOC_ZMEAS_EN reg-------------------//
       `RD_NORMAL_REG(`SOC_ZMEAS_EN,top_test_cfg.pads,top_test_cfg.rd_data);

       //Check zmeas enabled
       if(top_test_cfg.rd_data[0] !== top_test_cfg.wr_data[0][0])
	  `nnc_error("SOC_TEST", "[ERROR][0] zmeas not enabled!")
       else
	   `nnc_info("SOC_TEST", "zmeas enabled!", UVM_LOW)
 
       if(top_test_cfg.dds_wave_sel === 2'b01) begin
	`nnc_info("SOC_TEST", "DDS wave type: DC", UVM_LOW)
	top_test_cfg.no_of_bytes = 8'h02;
        top_test_cfg.wr_data[1] = top_test_cfg.dc_data_val[7:0];
        top_test_cfg.wr_data[0] = {6'b0,top_test_cfg.dc_data_val[9:8]};
    //Set DC amplitude
    ///-------------to write burst starting from the SOC_DC_DATA_REG_0 reg-------------------//
	`WR_BURST_NORMAL_REG(`SOC_DC_DATA_REG_0, top_test_cfg.no_of_bytes, top_test_cfg.pads, top_test_cfg.wr_data);
       end
       else if(top_test_cfg.dds_wave_sel === 2'b10) begin
	`nnc_info("SOC_TEST", "DDS wave type: SQUARE", UVM_LOW)
        top_test_cfg.no_of_bytes = 8'h02;
        top_test_cfg.wr_data[1] = top_test_cfg.sq_wave_div[7:0];
        top_test_cfg.wr_data[0] = top_test_cfg.sq_wave_div[15:8];
    //Set Square wave frequency
    ///-------------to write burst starting from the SOC_SQU_CLK_DIV_0 reg-------------------//
	`WR_BURST_NORMAL_REG(`SOC_SQU_CLK_DIV_0, top_test_cfg.no_of_bytes, top_test_cfg.pads, top_test_cfg.wr_data);
     //Wait for flash busy to go low, when update trim via SPI
        top_test_cfg.flash_debug_status = 8'h00;
        `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.flash_debug_status);
        while (top_test_cfg.flash_debug_status[6] === 1) begin
      	`RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.flash_debug_status);
        end
        `nnc_info("SOC_TEST", "Flash reset done!", UVM_LOW)
	top_test_cfg.no_of_bytes = 8'h04;
        top_test_cfg.wr_data[3] = top_test_cfg.sq_data_hval[7:0];
        top_test_cfg.wr_data[2] = {6'b0,top_test_cfg.sq_data_hval[9:8]};
        top_test_cfg.wr_data[1] = top_test_cfg.sq_data_lval[7:0];
        top_test_cfg.wr_data[0] = {6'b0,top_test_cfg.sq_data_lval[9:8]};
    //Set Square wave high and low amplitudes
    ///-------------to write burst starting from the SOC_FLASH_TRIMDATA11 reg-------------------//
	`WR_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA11, top_test_cfg.no_of_bytes, top_test_cfg.pads, top_test_cfg.wr_data);
        //`WR_NORMAL_REG(`SOC_FLASH_UNLOCK, 8'b0000_1_0_0_1, top_test_cfg.pads);
        unlock_trim_nvr0();
       end
       else
	`nnc_info("SOC_TEST", "DDS wave type: SINE", UVM_LOW)

       top_test_cfg.wr_data[0] = {6'b0,top_test_cfg.dds_wave_sel};
    //Select dds output wave type
    ////------------- to write in to the SOC_DATA_TYPE_SEL reg--------------//
       `WR_NORMAL_REG(`SOC_DATA_TYPE_SEL, top_test_cfg.wr_data[0], top_test_cfg.pads);

       #1000;
       top_test_cfg.mode = `ZMEAS_NOOP;
       top_test_cfg.wr_data[0] = {top_test_cfg.mode,5'b0};
       `nnc_info("SOC_TEST", "no-operation mode", UVM_LOW)
    ////------------- to write in to the SOC_ZMEAS_REG_CTRL_1 reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_REG_CTRL_1, top_test_cfg.wr_data[0], top_test_cfg.pads);

       #1000;
       top_test_cfg.mode = `ZMEAS_INIT;
       top_test_cfg.wr_data[0] = {top_test_cfg.tx_gain_sel[1],top_test_cfg.calib,top_test_cfg.zmeas_analog_en,top_test_cfg.tx_gain_sel[0],1'b0,top_test_cfg.rx_pga_gain,2'b0};
       top_test_cfg.wr_data[1] = {top_test_cfg.mode,top_test_cfg.repeat_cal,4'b0};
       top_test_cfg.wr_data[2] = {top_test_cfg.settling_time[3:0],1'b0,top_test_cfg.freq_val};
       top_test_cfg.wr_data[3] = {top_test_cfg.repeat_num,top_test_cfg.settling_time[7:4]};
       
       `nnc_info("SOC_TEST", "init mode", UVM_LOW)
    ////------------- to write in to the SOC_ZMEAS_REG_CTRL_0 reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_REG_CTRL_0, top_test_cfg.wr_data[0], top_test_cfg.pads);

    ////------------- to write in to the SOC_ZMEAS_REG_CTRL_2 reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_REG_CTRL_2, top_test_cfg.wr_data[2], top_test_cfg.pads);

    ////------------- to write in to the SOC_ZMEAS_REG_CTRL_3 reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_REG_CTRL_3, top_test_cfg.wr_data[3], top_test_cfg.pads);

    ////------------- to write in to the SOC_ZMEAS_REG_CTRL_1 reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_REG_CTRL_1, top_test_cfg.wr_data[1], top_test_cfg.pads);

    //Wait for dds enable status
    ///-------------to read from the SOC_ZMEAS_REG_STATUS_0 reg-------------------//
       do
         `RD_NORMAL_REG(`SOC_ZMEAS_REG_STATUS_0,top_test_cfg.pads,top_test_cfg.status[7:0]);
       while(top_test_cfg.status[3] === 0);

       #1000;
    ///-------------to read from the SOC_ZMEAS_REG_STATUS_1 reg-------------------//
       `RD_NORMAL_REG(`SOC_ZMEAS_REG_STATUS_1,top_test_cfg.pads,top_test_cfg.status[15:8]);
       `nnc_info("SOC_TEST",$sformatf("zmeas dds enabled with freq_sel: (0x%x)", top_test_cfg.status[11:9]),UVM_LOW);

       `nnc_info("SOC_TEST", $sformatf("zmeas status is: (0x%x)",top_test_cfg.status),UVM_LOW)
       if(top_test_cfg.status[15:12] !== top_test_cfg.repeat_num)
         `nnc_error("SOC_TEST", "[ERROR][1] zmeas_status[15:12] is not expected!")
       if(top_test_cfg.status[11:9] !== top_test_cfg.freq_val)
         `nnc_error("SOC_TEST", "[ERROR][2] zmeas_status[11:9] is not expected!")
       if((top_test_cfg.status[8:7] !== {top_test_cfg.zmeas_analog_en,top_test_cfg.tx_gain_sel[0]}) || (top_test_cfg.status[8:7] !== {`ANA_TOP.D2A_Z_EN,`ANA_TOP.D2A_SW_Z_TX_GSEL[0]}))
         `nnc_error("SOC_TEST", "[ERROR][3] zmeas_status[8:7] is not expected!")
       if((top_test_cfg.status[6] !== top_test_cfg.calib) || (top_test_cfg.status[6] !== `ANA_TOP.D2A_SW_Z_CALMD))
         `nnc_error("SOC_TEST", "[ERROR][4] zmeas_status[6] is not expected!")
       if((top_test_cfg.status[5] !== top_test_cfg.rx_pga_gain) || (top_test_cfg.status[5] !== `ANA_TOP.D2A_SW_Z_RXGAIN))
         `nnc_error("SOC_TEST", "[ERROR][5] zmeas_status[5] is not expected!")
       if(top_test_cfg.status[4:3] !== 2'b01)//adc_en,dds_en
         `nnc_error("SOC_TEST", "[ERROR][6] zmeas_status[4:3] is not expected!")
       if(top_test_cfg.status[2:0] !== 0)//measurement will not be done as adc part is removed
         `nnc_error("SOC_TEST", "[ERROR][7] zmeas_status[2:0] is not expected!")

       #1ns;
    end
  endtask
     
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME
