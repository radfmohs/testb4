/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_spi_wr_trim_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_spi_wr_trim_test                                             
// Designer	: pfwang@nanochap.com                                                                 
// Date		: 26-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_spi_wr_trim_test
`define TESTCFG soc_spi_wr_trim_test_cfg

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
  logic [7:0]      flash_rdata[256];
  rand logic [7:0] flash_wdata[256];

  rand logic [7:0] wr_trim[20:0]; 
  logic [7:0] rd_trim[19:0] = '{default: 8'hff};
  logic [7:0] rd_trim_debug[9:0] = '{default: 8'hff};

  // -----------------------------------------------
  // End of decalration of new variables 
  // ===============================================

  function new (string name = "soc_spi_wr_trim_test_cfg");
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
    uvm_top.set_timeout(10s);
    top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);
  endfunction

  // -----------------------------------------
  // Declare the pre_reset_phase task 
  // -----------------------------------------
  virtual task pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);

    super.pre_reset_phase(phase);

    assert(top_test_cfg.randomize() with {disable_init_flash == 1'b1; wake_up_en == 1'b1; hfosc_variation == 100;});

    `DUT_IF.testmode_sel = top_test_cfg.testmode_sel;

    `DUT_IF.spimode_sel = top_test_cfg.spimode_sel;
     
    `DUT_IF.disable_init_flash = top_test_cfg.disable_init_flash;

    `DUT_IF.wake_up_en = top_test_cfg.wake_up_en;

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

    `nnc_info("SOC_TEST", "soc_spi_wr_trim_test start", UVM_LOW)

    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
     #2ms;
     assert(top_test_cfg.randomize() with {no_of_bytes == 21; wr_trim[0] == 8'h5a;}); 
     `WR_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA0, top_test_cfg.no_of_bytes, top_test_cfg.pads,top_test_cfg.wr_trim);
     top_test_cfg.wr_trim.rand_mode(0);

     // Changing to use external clock
     assert(top_test_cfg.randomize() with {ext_clk_en==1;ext_clk_sel==2'b01;});
     `DUT_IF.ext_clk_en =top_test_cfg.ext_clk_en;
     `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel; //1MHz
     `DUT_IF.hfosc_fixed_gnd_en = top_test_cfg.hfosc_fixed_gnd_en;
     `DUT_IF.ext_hfosc_fixed_gnd_en = top_test_cfg.ext_hfosc_fixed_gnd_en;
     #10us;

     // Write to set UNLOCK bit
     `WR_NORMAL_REG(`SOC_FLASH_UNLOCK,{5'b10101, 3'b001},top_test_cfg.pads);    
     //wait (!`SPI_TOP.FLASH_BUSY);
     do begin
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.rd_data[0]);
     end while (top_test_cfg.rd_data[0][6]);

     #10ms;


     `RD_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA1, 20, top_test_cfg.rd_trim);
     foreach(top_test_cfg.rd_trim[i]) begin
        if(top_test_cfg.rd_trim[i] !== top_test_cfg.wr_trim[i+1])
        `nnc_error("SOC_TEST", $sformatf("rd_trim%0d error !!! rd = %8h, wd = %8h",(i+1), top_test_cfg.rd_trim[i], top_test_cfg.wr_trim[i+1]))
        else  `nnc_info("SOC_TEST", $sformatf("rd_trim%0d == wd_trim%0d !!! rd = %8h, wd = %8h",(i+1), (i+1), top_test_cfg.rd_trim[i], top_test_cfg.wr_trim[i+1]), UVM_LOW);
     end

`ifdef  NEW_BAF4P1
     `WR_NORMAL_REG(`SOC_FLASH_UNLOCK,8'h00,top_test_cfg.pads);
     assert(top_test_cfg.randomize());
     top_test_cfg.flash_wdata.rand_mode(0);
     for(int i=0; i<256; i++) begin
        `WR_NORMAL_REG(`SOC_FLASH_ADDR, i, top_test_cfg.pads);
        `WR_NORMAL_REG(`SOC_FLASH_DATA, top_test_cfg.flash_wdata[i], top_test_cfg.pads);
        `WR_NORMAL_REG(`SOC_FLASH_UNLOCK,{5'b01010, 3'b001},top_test_cfg.pads);
        do begin
        `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,top_test_cfg.rd_data[0]);
        end while (top_test_cfg.rd_data[0] === 1);
     end
`endif
    



     `nnc_info("SOC_TEST", "Enter Low power mode", UVM_LOW)
     `DUT_IF.wake_up_en = 0;
     #1000000

     `nnc_info("SOC_TEST", "Enter Active mode", UVM_LOW)
     `DUT_IF.wake_up_en = 1;

     wait(`RESETN);

     //wait (!`SPI_TOP.FLASH_BUSY);
     do begin
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.rd_data[0]);
     end while (top_test_cfg.rd_data[0][0]); 
    `nnc_info("SOC_TEST", "Flash conf done", UVM_LOW)

     do begin
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.rd_data[0]);
     end while (top_test_cfg.rd_data[0][6]); 
    `nnc_info("SOC_TEST", "Flash reset done", UVM_LOW)
    #2000us;


     `RD_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA1, 20, top_test_cfg.rd_trim);
     foreach(top_test_cfg.rd_trim[i]) begin
        if(top_test_cfg.rd_trim[i] !== top_test_cfg.wr_trim[i+1])
        `nnc_error("SOC_TEST", $sformatf("rd_trim%0d error !!! rd = %8h, wd = %8h",(i+1), top_test_cfg.rd_trim[i], top_test_cfg.wr_trim[i+1]))
        else  `nnc_info("SOC_TEST", $sformatf("rd_trim%0d == wd_trim%0d !!! rd = %8h, wd = %8h",(i+1), (i+1), top_test_cfg.rd_trim[i], top_test_cfg.wr_trim[i+1]), UVM_LOW);
     end

     `RD_BURST_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM1, 10, top_test_cfg.rd_trim_debug);
     foreach(top_test_cfg.rd_trim_debug[i]) begin
        if(top_test_cfg.rd_trim_debug[i] !== top_test_cfg.wr_trim[i+1])
        `nnc_error("SOC_TEST", $sformatf("rd_trim%0d_debug error !!! rd = %8h, wd = %8h",(i+1), top_test_cfg.rd_trim_debug[i], top_test_cfg.wr_trim[i+1]))
        else  `nnc_info("SOC_TEST", $sformatf("rd_trim%0d_debug == wd_trim%0d !!! rd = %8h, wd = %8h",(i+1), (i+1), top_test_cfg.rd_trim_debug[i], top_test_cfg.wr_trim[i+1]), UVM_LOW);
     end     
     
     top_test_cfg.wr_trim.rand_mode(1);
     assert(top_test_cfg.randomize() with {no_of_bytes == 21; wr_trim[0] == 8'h5a;}); 
     `WR_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA0, top_test_cfg.no_of_bytes, top_test_cfg.pads,top_test_cfg.wr_trim);
     top_test_cfg.wr_trim.rand_mode(0);     
     
     
     //spi_wr 0 -> 1 -> 0 
     `WR_NORMAL_REG(`SOC_FLASH_UNLOCK,8'h2,top_test_cfg.pads);      
     `WR_NORMAL_REG(`SOC_FLASH_UNLOCK,8'h0,top_test_cfg.pads);

     //#200us;
     `RD_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA1, 20, top_test_cfg.rd_trim);
     foreach(top_test_cfg.rd_trim[i]) begin
        if(top_test_cfg.rd_trim[i] !== top_test_cfg.wr_trim[i+1])
        `nnc_error("SOC_TEST", $sformatf("rd_trim%0d error !!! rd = %8h, wd = %8h",(i+1), top_test_cfg.rd_trim[i], top_test_cfg.wr_trim[i+1]))
        else  `nnc_info("SOC_TEST", $sformatf("rd_trim%0d == wd_trim%0d !!! rd = %8h, wd = %8h",(i+1), (i+1), top_test_cfg.rd_trim[i], top_test_cfg.wr_trim[i+1]), UVM_LOW);
     end

     `RD_BURST_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM1, 10, top_test_cfg.rd_trim_debug);
     foreach(top_test_cfg.rd_trim_debug[i]) begin
        if(top_test_cfg.rd_trim_debug[i] !== top_test_cfg.wr_trim[i+1])
        `nnc_error("SOC_TEST", $sformatf("rd_trim%0d_debug error !!! rd = %8h, wd = %8h",(i+1), top_test_cfg.rd_trim_debug[i], top_test_cfg.wr_trim[i+1]))
        else  `nnc_info("SOC_TEST", $sformatf("rd_trim%0d_debug == wd_trim%0d !!! rd = %8h, wd = %8h",(i+1), (i+1), top_test_cfg.rd_trim_debug[i], top_test_cfg.wr_trim[i+1]), UVM_LOW);
     end   


`ifdef NEW_BAF4P1
     `WR_NORMAL_REG(`SOC_FLASH_UNLOCK,8'h00,top_test_cfg.pads);
     for(int i=0; i<256; i++) begin
        `WR_NORMAL_REG(`SOC_FLASH_ADDR, i, top_test_cfg.pads);
        `WR_NORMAL_REG(`SOC_FLASH_UNLOCK,{5'b01010, 3'b000},top_test_cfg.pads);
        `WR_NORMAL_REG(`SOC_FLASH_UNLOCK,{5'b01010, 3'b100},top_test_cfg.pads);
        #1us;
        `WR_NORMAL_REG(`SOC_FLASH_UNLOCK,8'h00,top_test_cfg.pads);
        `RD_NORMAL_REG(`SOC_FLASH_EME_DATA,top_test_cfg.pads,top_test_cfg.flash_rdata[i]);
        if(top_test_cfg.flash_rdata[i] !== top_test_cfg.flash_wdata[i]) `nnc_error("SOC_TEST", $sformatf("flash_rdata 8'h%8h  !==   flash_wdata 8'h%8h,  addr 9'h%9h", top_test_cfg.flash_rdata[i], top_test_cfg.flash_wdata[i], i+8'hff));
     end
`endif





     #100us;

    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    #10000ns;
    `nnc_info("SOC_TEST", "soc_spi_wr_trim_test end now", UVM_LOW)

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
