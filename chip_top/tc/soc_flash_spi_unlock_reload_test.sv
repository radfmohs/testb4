/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_flash_spi_unlock_reload_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_flash_spi_unlock_reload_test                                             
// Designer	: thnguyen@nanochap.com                                                                 
// Date		: 30-07-2026                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_flash_spi_unlock_reload_test
`define TESTCFG soc_flash_spi_unlock_reload_test_cfg

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

  // -----------------------------------------------
  // End of decalration of new variables 
  // ===============================================

  function new (string name = "soc_flash_spi_unlock_reload_test_cfg");
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
    uvm_top.set_timeout(2s);
    top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);
  endfunction

  // -----------------------------------------
  // Declare the pre_reset_phase task 
  // -----------------------------------------
  virtual task pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);

    super.pre_reset_phase(phase);

    assert(top_test_cfg.randomize());

    `DUT_IF.testmode_sel = top_test_cfg.testmode_sel;

    `DUT_IF.spimode_sel = top_test_cfg.spimode_sel;

    `SPI_SCB_EN = 1'b0;
    `ANALOG_SCOREBOARD_EN = 1'b0;

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

    `nnc_info("SOC_TEST", "soc_flash_spi_unlock_reload_test start", UVM_LOW)

    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    

   wait(`DIG_TOP.FLASH_Reset_Done);

   // set trim_reg from SPI from 0x00 to 0x1F of Flash Address
   assert(top_test_cfg.randomize() with { reg_addr == `SOC_FLASH_TRIMDATA0; no_of_bytes == `MAX_TRIM_REG_NUM; data[`MAX_TRIM_REG_NUM-1][7:0] == 8'h5a;});
   `WR_BURST_NORMAL_REG(top_test_cfg.reg_addr, top_test_cfg.no_of_bytes, top_test_cfg.pads, top_test_cfg.data);


    //set unlock 

    assert(top_test_cfg.randomize() with { reg_addr == `SOC_FLASH_UNLOCK_PRO; no_of_bytes == 1; data[0] == 8'hAA;});
    `WR_BURST_NORMAL_REG(top_test_cfg.reg_addr, top_test_cfg.no_of_bytes, top_test_cfg.pads, top_test_cfg.data);

    assert(top_test_cfg.randomize() with { reg_addr == `SOC_FLASH_NVR_PRO_BYTE00; no_of_bytes == 1; data[0] == 8'hAA;});
    `WR_BURST_NORMAL_REG(top_test_cfg.reg_addr, top_test_cfg.no_of_bytes, top_test_cfg.pads, top_test_cfg.data);

    assert(top_test_cfg.randomize() with { reg_addr == `SOC_FLASH_NVR_PRO_BYTE01; no_of_bytes == 1; data[0] == 8'hAA;});
    `WR_BURST_NORMAL_REG(top_test_cfg.reg_addr, top_test_cfg.no_of_bytes, top_test_cfg.pads, top_test_cfg.data);
/*
    assert(top_test_cfg.randomize() with {ext_clk_en==1;ext_clk_sel==2'b11; hfosc_variation == 100;});
     `DUT_IF.ext_clk_en =top_test_cfg.ext_clk_en;
     `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel; //1MHz
     `DUT_IF.hfosc_fixed_gnd_en = top_test_cfg.hfosc_fixed_gnd_en;
     `DUT_IF.ext_hfosc_fixed_gnd_en = top_test_cfg.ext_hfosc_fixed_gnd_en;
     `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;

    #10us;
*/
    assert(top_test_cfg.randomize() with { reg_addr == `SOC_FLASH_UNLOCK; no_of_bytes == 1; data[0] == 8'b0000_0001;});
    `WR_BURST_NORMAL_REG(top_test_cfg.reg_addr, top_test_cfg.no_of_bytes, top_test_cfg.pads, top_test_cfg.data);

    //wait program done
    do begin
        assert(top_test_cfg.randomize() with { reg_addr == `SOC_FLASH_UNLOCK; no_of_bytes == 1;});
        `RD_BURST_NORMAL_REG(top_test_cfg.reg_addr, top_test_cfg.no_of_bytes, top_test_cfg.rd_data);
        `nnc_info("SOC_TEST", $sformatf("UNLOCK %b",top_test_cfg.rd_data[0][0]), NNC_LOW);
    end while (top_test_cfg.rd_data[0][0] !== 1'b0);




    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    #10000ns;
    `nnc_info("SOC_TEST", "soc_flash_spi_unlock_reload_test end now", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ==================================================================================

    phase.drop_objection(this);
  endtask: main_phase

  // ------------------------------
  // Declare the report_phase task
  // ------------------------------
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction

endclass : `TESTNAME
