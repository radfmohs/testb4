/*--------------------------------------------------------------------------------------
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_gpio_reg_test.sv                                                   
// Project	: Nanochap BPS1                                  		        
// Description	: Testcase soc_gpio_reg_test                                             
// Designer	: ddang@nanochap.com                                                                 
// Date		: 18-10-2023                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_gpio_reg_test
`define TESTCFG soc_gpio_reg_test_cfg

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // -----------------------------------------------
  // Adding your new varialbles in config test
  // -----------------------------------------------
  rand logic [7:0] rd_data;
  rand logic [7:0] no_of_bytes;
  rand logic [7:0] rd_data_reg[];
  rand logic [7:0] wr_data_reg[];
  rand logic [7:0] mask;
  rand logic [2:0] pu_ctrl;
  rand logic [0:0] pu_resetn;
  rand logic [1:0] pd_testmode;
  rand logic [7:0] init_value;
  rand logic [7:0] pads;

  // -----------------------------------------------
  // End of decalration of new variables 
  // -----------------------------------------------

  function new (string name = "soc_gpio_reg_test_cfg");
    super.new(name);
    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // testmode_sel[1:0] : 00-Normal mode, 01: Scanmode, 10: BIST mode, 11 atm0/1/2/3/4
  constraint c_testmode_sel { soft testmode_sel == 2'b00; }

  // chipmode_sel[1:0] : 2'b00-ADD0 to GND, 2'b01-ADD0 to V+, 2'b10-ADD0 to SDA, 2'b11-ADD0 to SCL 
  // constraint c_spimode_sel { spimode_sel == 2'b00; }

  constraint c_no_of_bytes { soft no_of_bytes == 2; }
  constraint c_pclk_sel    { soft pclk_sel inside {[0:3]};}

  // top_test_cfg.pads values
  constraint c_pads        { soft pads == 8'h00; }
  // top_test_cfg.mask values
  constraint c_mask        { soft mask == 8'hFF; }

  //constraint c_no_of_adc_dev1                    { soft no_of_adc_dev1 == 3'b010; }      // 8 channels as default
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

    `DUT_IF.testmode_sel = top_test_cfg.testmode_sel;

    // Set PCLK Clocks
    `DUT_IF.pclk_sel = top_test_cfg.pclk_sel;
    //`DUT_IF.no_of_adc_dev1 = top_test_cfg.no_of_adc_dev1;

    // ==================
    // Scoreboard enables
    // ==================
    `SPI_SCB_EN = 1'b0;

    phase.drop_objection(this);
  endtask : pre_reset_phase

  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_gpio_reg_test start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
`ifndef POSTLAYOUT    
// FIFO
top_test_cfg.init_value = `SOC_GPIO_PU_CTR_INIT;
`RD_RESET_CHK_NORMAL_REG(`SOC_GPIO_PU_CTR, top_test_cfg.init_value, top_test_cfg.pads); //GPIO_PU_CTRL

top_test_cfg.init_value = `SOC_GPIO_PU_RESETN_INIT;
`RD_RESET_CHK_NORMAL_REG(`SOC_GPIO_PU_RESETN, top_test_cfg.init_value, top_test_cfg.pads); //GPIO_PU_RESETn

top_test_cfg.init_value = `SOC_GPIO_PD_TESTMODE_INIT;
`RD_RESET_CHK_NORMAL_REG(`SOC_GPIO_PD_TESTMODE, top_test_cfg.init_value, top_test_cfg.pads); //SOC_GPIO_PD_TESTMODE

// Your block is here

// ------------------------
// Check READ/WRIRE ACCESS
// ------------------------
`WR_RD_CHK_NORMAL_REG(`SOC_GPIO_PU_CTR, 8'h03, top_test_cfg.pads, top_test_cfg.mask);
`RD_RESET_CHK_NORMAL_REG(`SOC_GPIO_PU_CTR, 8'h03, top_test_cfg.pads); //GPIO_PU_CTRL

// GPIO
for (int i = 0; i < 100; i++) begin
top_test_cfg.pu_ctrl = $random();
`WR_RD_CHK_NORMAL_REG(`SOC_GPIO_PU_CTR, top_test_cfg.pu_ctrl, top_test_cfg.pads, top_test_cfg.mask);

top_test_cfg.pu_resetn = $random();
`WR_RD_CHK_NORMAL_REG(`SOC_GPIO_PU_RESETN, top_test_cfg.pu_resetn, top_test_cfg.pads, top_test_cfg.mask);

top_test_cfg.pd_testmode = $random();
`WR_RD_CHK_NORMAL_REG(`SOC_GPIO_PD_TESTMODE, top_test_cfg.pd_testmode, top_test_cfg.pads, top_test_cfg.mask);
end

// GPIO
`RD_NORMAL_REG(`SOC_GPIO_PU_CTR, top_test_cfg.pads, top_test_cfg.rd_data);
`RD_NORMAL_REG(`SOC_GPIO_PU_RESETN, top_test_cfg.pads, top_test_cfg.rd_data);
`RD_NORMAL_REG(`SOC_GPIO_PD_TESTMODE, top_test_cfg.pads, top_test_cfg.rd_data); 

//------------------------burst mode write---------------------------------------//
`WR_BURST_NORMAL_REG(`SOC_GPIO_PU_CTR,8'h03,8'h00,top_test_cfg.wr_data_reg);

//------------------------burst mode read---------------------------------------//
top_test_cfg.no_of_bytes = 8'h03;
top_test_cfg.rd_data_reg = new[top_test_cfg.no_of_bytes];
`RD_BURST_NORMAL_REG(`SOC_GPIO_PU_CTR, top_test_cfg.no_of_bytes, top_test_cfg.rd_data_reg);
`endif
    `nnc_info("SOC_TEST", "soc_gpio_reg_test end now", UVM_LOW)
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------

    phase.drop_objection(this);
  endtask: main_phase

  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME
