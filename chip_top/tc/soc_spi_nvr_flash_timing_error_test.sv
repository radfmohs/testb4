/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_spi_nvr_flash_timing_error_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_spi_nvr_flash_timing_error_test                                             
// Designer	: pfwang@nanochap.com                                                                 
// Date		: 25-07-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_spi_nvr_flash_timing_error_test
`define TESTCFG soc_spi_nvr_flash_timing_error_test_cfg

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

  function new (string name = "soc_spi_nvr_flash_timing_error_test_cfg");
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
    uvm_top.set_timeout(3s);
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

    `nnc_info("SOC_TEST", "soc_spi_nvr_flash_timing_error_test start", UVM_LOW)

    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    
    // --------------------------------------------------------
    // This is an example RD_RESET_CHK_REG 
    // --------------------------------------------------------
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


     `WR_RD_CHK_NORMAL_REG(`SOC_FLASH_UNLOCK,8'h00,top_test_cfg.pads,top_test_cfg.mask);
     assert(top_test_cfg.randomize());
     top_test_cfg.flash_wdata.rand_mode(0);

     for(int i=0; i<10; i++) begin
        `WR_NORMAL_REG(`SOC_FLASH_ADDR, i, top_test_cfg.pads);
        `WR_NORMAL_REG(`SOC_FLASH_DATA, top_test_cfg.flash_wdata[i], top_test_cfg.pads);
        `WR_NORMAL_REG(`SOC_FLASH_UNLOCK,{5'b01010, 3'b001},top_test_cfg.pads);
        do begin
        `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,top_test_cfg.rd_data[0]);
        end while (top_test_cfg.rd_data[0] === 1);
     end

        `WR_NORMAL_REG(`SOC_FLASH_ADDR, 10, top_test_cfg.pads);
        `WR_NORMAL_REG(`SOC_FLASH_DATA, top_test_cfg.flash_wdata[10], top_test_cfg.pads);
        fork
        `WR_NORMAL_REG(`SOC_FLASH_UNLOCK,{5'b01010, 3'b001},top_test_cfg.pads);
        join_none
        force `FLASH_TOP.u_flash_regs.unlock = 0;
        //@(posedge `FLASH_TOP.u_flash_regs.key_word_flash);
        
        @(posedge `FLASH_TOP.clk);
        #20ns;
        release `FLASH_TOP.u_flash_regs.unlock;

        //fork
        //begin
        //#1000us;
        //`nnc_fatal("SOC_TEST", "Waiting for clearing unlock timeout !!!");  
        //end
        //join_none     
           
        #1000us;
        do begin
        `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,top_test_cfg.rd_data[0]);
        end while (top_test_cfg.rd_data[0] === 1);

     `WR_NORMAL_REG(`SOC_FLASH_UNLOCK,8'h00,top_test_cfg.pads);
     for(int i=0; i<10; i++) begin
        `WR_NORMAL_REG(`SOC_FLASH_ADDR, i, top_test_cfg.pads);
        `WR_NORMAL_REG(`SOC_FLASH_UNLOCK,{5'b01010, 3'b100},top_test_cfg.pads);
        #1us;
        `WR_NORMAL_REG(`SOC_FLASH_UNLOCK,8'h00,top_test_cfg.pads);
        `RD_NORMAL_REG(`SOC_FLASH_EME_DATA,top_test_cfg.pads,top_test_cfg.flash_rdata[i]);
        if(top_test_cfg.flash_rdata[i] !== top_test_cfg.flash_wdata[i]) `nnc_error("SOC_TEST", $sformatf("flash_rdata 8'h%8h  !==   flash_wdata 8'h%8h,  addr 9'h%9h", top_test_cfg.flash_rdata[i], top_test_cfg.flash_wdata[i], i+8'hff));
     end

     #10us;   

    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    #10000ns;
    `nnc_info("SOC_TEST", "soc_spi_nvr_flash_timing_error_test end now", UVM_LOW)

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
