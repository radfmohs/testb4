/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_sysc_clkdiv_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_sysc_clkdiv_test                                             
// Designer	: pfwang@nanochap.com                                                                 
// Date		: 11-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_sysc_clkdiv_test
`define TESTCFG soc_sysc_clkdiv_test_cfg

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // ===============================================
  // Adding your new varialbles in config test
  // -----------------------------------------------

  rand logic [7:0] wr_data[256];
  rand int         no_of_bytes; 
  rand logic [7:0] reg_addr;
  rand logic [7:0] pads;
  rand logic [7:0] mask;
  rand logic [7:0] expected_data;
  logic [7:0]      rd_data[];

  rand logic [7:0] clk_ctrl_reg;  //h40
  rand logic [7:0] leadoff_clk_reg;  //h3a
  //rand logic [7:0] acb  ;//h3b
  rand logic [7:0] zmeas_en, imeas_en;
  rand logic [7:0] mclk_div_reg;
  rand logic [15:0] checkclk_div_reg;
  rand logic [7:0] pmu_reg;
  rand logic [7:0] rld_clk_reg;
  // -----------------------------------------------
  // End of decalration of new variables 
  // ===============================================

  function new (string name = "soc_sysc_clkdiv_test_cfg");
    super.new(name);
    
  endfunction: new

  // ===============================================
  // Adding constraints of randomization
  // -----------------------------------------------

  // testmode_sel[1:0] : 00-Normal mode, 01: Scanmode, 10: BIST mode, 11 atm0/1/2/3/4
  constraint c_testmode_sel { soft testmode_sel == 2'b00; }

  // spimode_sel[1:0] :  
  constraint c_spimode_sel { spimode_sel == 2'b00; }

  // No of bytes in a burst
  constraint c_no_of_bytes { soft no_of_bytes == 2; }

  // pads values
  constraint c_pads        { soft pads == 8'h00; }

  // mask values
  constraint c_mask        { soft mask == 8'hff; }

  constraint c_clk_reg     {clk_ctrl_reg[5:0] == {iclk_sel, pclk_sel, 1'b0};}

  constraint c_checkclk_reg {checkclk_div_reg inside {[0:100]};}

  constraint C_pmu_reg     {pmu_reg[1:0] == 2'b01;}
  // -----------------------------------------------
  // End of adding constraints of randomization
  // ===============================================

endclass : `TESTCFG

// ===============================================
// Main Testcase is defined
// -----------------------------------------------
class `TESTNAME extends soc_base_test;
   
  `nnc_component_utils(`TESTNAME)

  `TESTCFG top_test_cfg;

  // -----------------------------------------
  // Declare the new function 
  // -----------------------------------------
  function new(string name, nnc_component parent);
    super.new(name, parent);
  endfunction

  // -----------------------------------------
  // Declare the build_phase function 
  // -----------------------------------------
  virtual function void build_phase(nnc_phase phase);
    super.build_phase(phase);
    uvm_top.set_timeout(20s);
    top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);
  endfunction

  // -----------------------------------------
  // Declare the pre_reset_phase task 
  // -----------------------------------------
  virtual task pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);

    super.pre_reset_phase(phase);

    assert(top_test_cfg.randomize() with {hfosc_jitter == 1'b0; hfosc_variation == 100;} );

    `DUT_IF.testmode_sel = top_test_cfg.testmode_sel;

    `DUT_IF.spimode_sel = top_test_cfg.spimode_sel;
    
    `DUT_IF.hfosc_jitter = top_test_cfg.hfosc_jitter;

    `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;
    // -------------------
    // Scoreboard enables
    // -------------------
    // `FLASH_SCOREBOARD_EN = 1;
    // `SPIM_SCOREBOARD_EN = 1;
    // `ANALOG_SCOREBOARD_EN = 1;
    // `IMEAS_SCOREBOARD_EN = 1;
    // `CLKRST_SCOREBOARD_EN = 1;

    phase.drop_objection(this);
  endtask : pre_reset_phase

  // -----------------------------------------
  // Declare the main_phase task of your test
  // -----------------------------------------
  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_sysc_clkdiv_test start", UVM_LOW)

    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    
    // --------------------------------------------------------
    // This is an example RD_RESET_CHK_REG 
    // --------------------------------------------------------
    repeat(5) begin
    assert(top_test_cfg.randomize());
    `WR_NORMAL_REG(`SOC_IMEAS_EN, top_test_cfg.imeas_en, top_test_cfg.pads);
    `WR_NORMAL_REG(`SOC_ZMEAS_EN, top_test_cfg.zmeas_en, top_test_cfg.pads);
    `WR_NORMAL_REG(`SOC_CLK_CTRL_REG, top_test_cfg.clk_ctrl_reg, top_test_cfg.pads);
    `WR_NORMAL_REG(`SOC_LEADOFF_CLK_REG, top_test_cfg.leadoff_clk_reg, top_test_cfg.pads);
    `WR_NORMAL_REG(`SOC_MCLK_DIV_REG, top_test_cfg.mclk_div_reg, top_test_cfg.pads);
    `WR_NORMAL_REG(`SOC_CHECK_CLK_DIV_LO_REG, top_test_cfg.checkclk_div_reg[7:0], top_test_cfg.pads);
    `WR_NORMAL_REG(`SOC_CHECK_CLK_DIV_HI_REG, top_test_cfg.checkclk_div_reg[15:8], top_test_cfg.pads);
    `WR_NORMAL_REG(`SOC_PMU_REG0, top_test_cfg.pmu_reg, top_test_cfg.pads);     
    `WR_NORMAL_REG(`SOC_RLD_CLK_REG, top_test_cfg.rld_clk_reg, top_test_cfg.pads);
    //`WR_NORMAL_REG(`SOC_LEADOFF_CLK_REG,top_test_cfg.leadoff_clk_reg,top_test_cfg.pads);
    assert(`SYS_CTRL_CFG.randomize() with{clk_cfg_reg == top_test_cfg.clk_ctrl_reg; leadoff_clk_reg == top_test_cfg.leadoff_clk_reg; imeas_en == top_test_cfg.imeas_en[0]; zmeas_en == top_test_cfg.zmeas_en[0]; mclk_div_reg==top_test_cfg.mclk_div_reg; checkclk_div_reg==top_test_cfg.checkclk_div_reg; pmu_reg == top_test_cfg.pmu_reg; rld_clk_sel == top_test_cfg.rld_clk_reg[1:0];});


    `CLKDIV_CHECK_EN = 1'b1;
    
    #2000ms;
    `CLKDIV_CHECK_EN = 1'b0;    
    #10ms;
    end
    
    //`RD_NORMAL_REG(i, top_test_cfg.pads, rd_data_after_wr);
    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    #10000ns;
    `nnc_info("SOC_TEST", "soc_sysc_clkdiv_test end now", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ==================================================================================

    phase.drop_objection(this);
  endtask: main_phase


    task do_run;
    



    endtask:do_run





  // ------------------------------
  // Declare the report_phase task
  // ------------------------------
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction

endclass : `TESTNAME
