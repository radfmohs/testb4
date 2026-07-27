/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_zmeas_repeat_test.sv                                                   
// Project	: Nanochap BAF4P1                                  		        
// Description	: Testcase soc_zmeas_repeat_test                                             
// Designer	: ophina@nanochap.com                                                                 
// Date		: 06-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_zmeas_repeat_test
`define TESTCFG soc_zmeas_repeat_test_cfg

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
  rand  bit [1:0]   zmeas_freq_sel;        // 2'b00: 1Khz, 2'b01: 2Khz, 2'b10: 4Khz, 2'b11: No readmem
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

  function new (string name = "soc_zmeas_repeat_test_cfg");
    super.new(name);    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // top_test_cfg.top_test_cfg.pads values
  constraint c_pads           { soft pads == 8'h00; }
  // top_test_cfg.top_test_cfg.mask values
  constraint c_mask           { soft mask == 8'hFF; }
  // top_test_cfg.top_test_cfg.repeat_cal values
  constraint c_repeat_cal     { soft repeat_cal == 1'b1; }//repeat enabled
  // top_test_cfg.top_test_cfg.repeat_num values
  constraint c_repeat_num     { soft repeat_num inside {`ZMEAS_REG_NUMBER_OF_REPEAT_CYCLE_VAL_2, `ZMEAS_REG_NUMBER_OF_REPEAT_CYCLE_VAL_4}; }
  // top_test_cfg.top_test_cfg.settling_time values
  constraint c_settling_time  { soft settling_time inside {[8'h00:8'h0F]}; }
  // top_test_cfg.top_test_cfg.int_en values
  constraint c_int_en         { soft int_en == 1'b1; }//interrupt enabled
  // top_test_cfg.top_test_cfg.freq_val values
  constraint c_freq_val       { soft freq_val == `ZMEAS_REG_FREQ_VAL_2KHZ; }//freq_val=2KHz
  // top_test_cfg.top_test_cfg.zmeas_freq_sel values
  constraint c_zmeas_freq_sel { soft zmeas_freq_sel == 2'b01; }//freq_val=2KHz

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
    uvm_top.set_timeout(2s);
    top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);
  endfunction

  virtual task pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);

    super.pre_reset_phase(phase);

    assert(top_test_cfg.randomize());

    `DUT_IF.zmeas_freq_sel = top_test_cfg.zmeas_freq_sel;
    // ==================
    // Scoreboard enables
    // ==================
    `SPI_SCB_EN = 1'b0;

    phase.drop_objection(this);
  endtask : pre_reset_phase

  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_zmeas_repeat_test start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ----------------------------------------------------------------------------------  
    `nnc_info("SOC_TEST",$sformatf("Simulation Begin!!!"),UVM_LOW);
    `nnc_info("SOC_TEST",$sformatf("ZMEAS test with repeat calculation"),UVM_LOW);
    do_run;
    
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

  virtual task do_run;
    begin

       top_test_cfg.wr_data[0] = 8'h00;
    //Set zmeas mclk div
    ////------------- to write in to the SOC_MCLK_DIV_REG reg--------------//
       `WR_NORMAL_REG(`SOC_MCLK_DIV_REG, top_test_cfg.wr_data[0], top_test_cfg.pads);//set adc_clk 256KHz
 
       top_test_cfg.wr_data[0] = 8'h01;
   //Enable ZMEAS
    ////------------- to write in to the SOC_ZMEAS_EN reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_EN, top_test_cfg.wr_data[0], top_test_cfg.pads);

    ///-------------to read from the SOC_ZMEAS_EN reg-------------------//
       `RD_NORMAL_REG(`SOC_ZMEAS_EN,top_test_cfg.pads,top_test_cfg.rd_data);

       //Check zmeas enabled
       if(top_test_cfg.rd_data[0] !== top_test_cfg.wr_data[0][0])
	  `nnc_error("SOC_TEST", "[ERROR][0] zmeas not enabled!")
       else
	   `nnc_info("SOC_TEST", "zmeas enabled!", UVM_LOW)

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

       #1000;
       top_test_cfg.mode = `ZMEAS_CALC;
       top_test_cfg.wr_data[0] = {top_test_cfg.mode,top_test_cfg.repeat_cal,1'b0,top_test_cfg.int_en,2'b0};
       `nnc_info("SOC_TEST", "calc mode", UVM_LOW)
       `nnc_info("SOC_TEST", "Enable zmeas interrupt", UVM_LOW)
     ////------------- to write in to the SOC_ZMEAS_REG_CTRL_1 reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_REG_CTRL_1, top_test_cfg.wr_data[0], top_test_cfg.pads);

    //Wait for zmeas interrupt
       wait(`SOC_TB.IOBUF_PAD[4] === 1'b1);
    ///-------------to read from the SOC_ZMEAS_INT reg-------------------//
       `RD_NORMAL_REG(`SOC_ZMEAS_INT,top_test_cfg.pads,top_test_cfg.int_sts);

    //Check int status
       if(top_test_cfg.int_sts[0] !== 1'b1)
	  `nnc_error("SOC_TEST", "[ERROR][1] zmeas interrupt failed!")
       else
	  `nnc_info("SOC_TEST", "zmeas interrupt occurred!", UVM_LOW)

    ///-------------to read from the SOC_ZMEAS_REG_STATUS_0 reg-------------------//
       `RD_NORMAL_REG(`SOC_ZMEAS_REG_STATUS_0,top_test_cfg.pads,top_test_cfg.status[7:0]);

    ///-------------to read from the SOC_ZMEAS_REG_STATUS_1 reg-------------------//
       `RD_NORMAL_REG(`SOC_ZMEAS_REG_STATUS_1,top_test_cfg.pads,top_test_cfg.status[15:8]);

       `nnc_info("SOC_TEST", $sformatf("zmeas status is: (0x%x)",top_test_cfg.status),UVM_LOW)
       if(top_test_cfg.status[15:12] !== top_test_cfg.repeat_num)
         `nnc_error("SOC_TEST", "[ERROR][2] zmeas_status[15:12] is not expected!")
       if(top_test_cfg.status[11:9] !== top_test_cfg.freq_val)
         `nnc_error("SOC_TEST", "[ERROR][3] zmeas_status[11:9] is not expected!")
       if((top_test_cfg.status[8:7] !== {top_test_cfg.zmeas_analog_en,top_test_cfg.tx_gain_sel[0]}) || (top_test_cfg.status[8:7] !== {`ANA_TOP.D2A_SW_Z_EN,`ANA_TOP.D2A_SW_Z_TX_GSEL[0]}))
         `nnc_error("SOC_TEST", "[ERROR][4] zmeas_status[8:7] is not expected!")
       if((top_test_cfg.status[6] !== top_test_cfg.calib) || (top_test_cfg.status[6] !== `ANA_TOP.D2A_SW_Z_CALMD))
         `nnc_error("SOC_TEST", "[ERROR][5] zmeas_status[6] is not expected!")
       if((top_test_cfg.status[5] !== top_test_cfg.rx_pga_gain) || (top_test_cfg.status[5] !== `ANA_TOP.D2A_SW_Z_RXGAIN))
         `nnc_error("SOC_TEST", "[ERROR][6] zmeas_status[5] is not expected!")
       if(top_test_cfg.status[4:3] !== 2'b0)//adc_en,dds_en
         `nnc_error("SOC_TEST", "[ERROR][7] zmeas_status[4:3] is not expected!")
       if(top_test_cfg.status[2:0] !== 7) //measurement is done
         `nnc_error("SOC_TEST", "[ERROR][8] zmeas_status[2:0] is not expected!")

    ///-------------to read burst starting from the SOC_ZMEAS_REG_DATAOUT_0 reg-------------------//
       top_test_cfg.no_of_bytes = 8'h04;
       top_test_cfg.rd_data_reg = new[top_test_cfg.no_of_bytes];
       `RD_BURST_NORMAL_REG(`SOC_ZMEAS_REG_DATAOUT_0, top_test_cfg.no_of_bytes, top_test_cfg.rd_data_reg);
       
       top_test_cfg.zmeas_data[7:0]   = top_test_cfg.rd_data_reg[3];
       top_test_cfg.zmeas_data[15:8]  = top_test_cfg.rd_data_reg[2];
       top_test_cfg.zmeas_data[23:16] = top_test_cfg.rd_data_reg[1];
       top_test_cfg.zmeas_data[31:24] = top_test_cfg.rd_data_reg[0]; 

       `nnc_info("SOC_TEST", $sformatf("zmeas data is: (0x%x)",top_test_cfg.zmeas_data),UVM_LOW)
       if(top_test_cfg.zmeas_data !== 32'hfbb30670)
         `nnc_error("SOC_TEST", "[ERROR][9] ZMEAS DATA INCORRECT!")
       
     ////------------- to write in to the SOC_ZMEAS_INT reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_INT, top_test_cfg.int_sts, top_test_cfg.pads);

     ///-------------to read from the SOC_ZMEAS_INT reg-------------------//
       `RD_NORMAL_REG(`SOC_ZMEAS_INT,top_test_cfg.pads,top_test_cfg.int_sts);

    //Check int status
       if(top_test_cfg.int_sts[0] !== 1'b0)
           `nnc_error("SOC_TEST", "[ERROR][10] zmeas interrupt not cleared!")
       else
	   `nnc_info("SOC_TEST", "zmeas interrupt cleared!", UVM_LOW)
            
    end
  endtask
     
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME
