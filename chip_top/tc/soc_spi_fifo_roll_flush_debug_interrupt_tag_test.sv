/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_spi_fifo_roll_flush_debug_interrupt_tag_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_spi_fifo_roll_flush_debug_interrupt_tag_test                                             
// Designer	: shreeyal@nanochap.com                                                                 
// Date		: 05-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_spi_fifo_roll_flush_debug_interrupt_tag_test
`define TESTCFG soc_spi_fifo_roll_flush_debug_interrupt_tag_test_cfg

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

  integer     no_of_elements;
  integer     no_of_elements_with_tags = 0;
  logic [7:0] rd_data_reg[];
  logic [15:0] rd_data_fifo[];
  logic [17:0] rd_data_fifo_reg;
  logic status_bit;


  // -----------------------------------------------
  // End of decalration of new variables 
  // ===============================================

  function new (string name = "soc_spi_fifo_roll_flush_debug_interrupt_tag_test_cfg");
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

  // for single mode, SPI clk should be 256 min as it should be enough to run with imeas , updated as Xin suggested (after the issue seen in regr - 28/8/24)
  constraint c_spi_sclk_freq          { solve pclk_sel before spi_sclk_freq; spi_sclk_freq inside {[256/(2**pclk_sel)*4 : 256/(2**pclk_sel)*4]};}

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
    uvm_top.set_timeout(80s);
    top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);
    top_cfg.soc_fifo_monitor_en = 1;
    top_cfg.soc_fifo_compare_en = 0;
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

    `DUT_IF.pclk_sel = top_test_cfg.pclk_sel;

    `DUT_IF.spi_clk_jitter = top_test_cfg.spi_clk_jitter;

    `DUT_IF.spi_sclk_jitter = top_test_cfg.spi_sclk_jitter;

    `DUT_IF.spi_sclk_freq = top_test_cfg.spi_sclk_freq;

    `DUT_IF.iclk_sel = top_test_cfg.iclk_sel;

    `DUT_IF.mclk_sel = top_test_cfg.mclk_sel;
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
    bit [7:0] wr_data;
    bit [7:0] rd_data; 
    logic [7:0] rd_data_reg[];
    logic [15:0] rd_data_fifo[];
    logic [17:0] rd_data_fifo_reg;
    logic [23:0] rd_data_fifo_tag[];
    logic status_bit;
    int         no_of_bytes; 
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_spi_fifo_roll_flush_debug_interrupt_tag_test start", UVM_LOW)

    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    


// ---------------------------------------------------------------------
// Step 1 - Checking interrupt at the begining from Status register
// ---------------------------------------------------------------------
// Read status of empty
`RD_NORMAL_REG(`SOC_FIFO_STATUS_REG,top_test_cfg.pads,rd_data);

// Check: rd_data[7]- err = 0, d_data[6]- a_empty=1, d_data[5]- a_full=0, d_data[4]- empty=1, d_data[3]- full=0
if (rd_data[7:3] != 5'b01010) begin
    //$display("[ERROR][TEST][0] STATUS REGISTER is WRONG = %h", rd_data);
    `nnc_error("STATUS REGISTER is WRONG = %h",rd_data);
end
$display("[INFO] STEP 1 Checking is DONE");
// ---------------------------------------------------------------------
// Step 2 - Checking interrupt empty output to PIN;
// ---------------------------------------------------------------------
// Interrupt pin is de-asserted
wait(!`FIFO_TOP.fifo_intr);

// Enable Empty Interrupt Output
wr_data = 8'h10; // Enable bit 4
`WR_NORMAL_REG(`SOC_FIFO_CONFIG_3_REG, wr_data, top_test_cfg.pads);

// Interrupt pin is asserted
wait(`FIFO_TOP.fifo_intr);
$display("[INFO] FIFO is EMPTY is output to FIFO INTR PIN at TIME: %t", $time);
$display("[INFO] STEP 2 Checking is DONE");
// ---------------------------------------------------------------------
// Step 3 - Set configuration for IMEAS to send DATA to FIFO
// ---------------------------------------------------------------------
// Enable IMEAS
wr_data = 8'h01; 
`WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads,top_test_cfg.mask);

// Set coversion mode to select single mode channel conversion
wr_data = 8'h00;
`WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_MODE_REG,wr_data,top_test_cfg.pads,top_test_cfg.mask);

// Enable interrupt
wr_data = 8'h01;
`WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_REG_CTRL_0, wr_data, top_test_cfg.pads, top_test_cfg.mask);

// SD16OFF , SD16SLP , SD16RST  to 0
wr_data = 8'h00;
top_test_cfg.mask= 8'h07;
`WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_REG_SEQ,wr_data,top_test_cfg.pads,top_test_cfg.mask);

// DATA will be come and FIFO is not empty
wait(top_cfg.imeas2fifo_mem_cnt == 2);

// Clear empty interrupt 
wr_data = 8'h10; // Enable bit 4
`WR_NORMAL_REG(`SOC_FIFO_STATUS_REG,wr_data, top_test_cfg.pads);
wait(!`FIFO_TOP.fifo_empty);

$display("[INFO] STEP 3 Checking is DONE");
// ---------------------------------------------------------------------
// Step 4 - Stop IMEAS to check interrupt EMPTY
// ---------------------------------------------------------------------
// Diable IMEAS
wr_data = 8'h00; 
`WR_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads);

$display("[INFO] STEP 4 Checking is DONE");
// ---------------------------------------------------------------------
// Step 5 - Check interupt Clear for EMPTY
// ---------------------------------------------------------------------
// Write 1 to clear this bit (fifo_intr will change 1 -> 0)
wr_data = 8'h10; // Enable bit 4
`WR_NORMAL_REG(`SOC_FIFO_STATUS_REG, wr_data, top_test_cfg.pads);

// Clear successfully interrupt to 0
wait(!`FIFO_TOP.fifo_intr);
$display("[INFO] FIFO INTR status is cleared succesfully at TIME: %t", $time);

// Disable Empty Interrupt Output
wr_data = 8'h00; // Enable bit 4
`WR_NORMAL_REG(`SOC_FIFO_CONFIG_3_REG, wr_data, top_test_cfg.pads);

$display("[INFO] STEP 5 Checking is DONE");
// ---------------------------------------------------------------------
// Step 6 - Checking Almost Empty Interrupt
// ---------------------------------------------------------------------
// Interrupt pin is de-asserted
wait(!`FIFO_TOP.fifo_intr);

// Enable Empty Interrupt Output - Enable bit 6 A_EMPTY_INT_EN
wr_data = 8'h40; 
`WR_NORMAL_REG(`SOC_FIFO_CONFIG_3_REG, wr_data, top_test_cfg.pads);

// Interrupt pin is de-asserted
wait(`FIFO_TOP.fifo_intr);

// Clear almost empty interrupt 
wr_data = 8'h40; // Enable bit 4
`WR_NORMAL_REG(`SOC_FIFO_STATUS_REG,wr_data, top_test_cfg.pads);

// Interrupt pin is asserted again
wait(`FIFO_TOP.fifo_intr);

$display("[INFO] STEP 6 Checking is DONE");
// ---------------------------------------------------------------------
// Step 7 - Continue sending DATA to element (8'h40), almost empty is gone
// ---------------------------------------------------------------------
// Enable IMEAS
wr_data = 8'h01; 
`WR_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads);

wait(top_cfg.imeas2fifo_mem_cnt === 8'h40);

// Disbale IMEAS
wr_data = 8'h00; 
`WR_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads);

$display("[INFO] STEP 7 Checking is DONE");
// ---------------------------------------------------------------------
// Step 8 -Checking clear function of almost empty
// ---------------------------------------------------------------------
wait(`FIFO_TOP.fifo_intr);
wr_data = 8'h40; 
`WR_NORMAL_REG(`SOC_FIFO_STATUS_REG,wr_data,top_test_cfg.pads);

wait(!`FIFO_TOP.fifo_intr);

$display("[INFO] STEP 8 Checking is DONE");
// ---------------------------------------------------------------------
// Step 9 - Checking Almost Full Interrupt not happen
// ---------------------------------------------------------------------
// Interrupt pin is de-asserted
wait(!`FIFO_TOP.fifo_intr);

// Enable Almost Full Interrupt Output - Enable bit 4 A_ALMOST_INT_EN
wr_data = 8'h20; 
`WR_NORMAL_REG(`SOC_FIFO_CONFIG_3_REG, wr_data, top_test_cfg.pads);

$display("[INFO] STEP 9 Checking is DONE");
// ---------------------------------------------------------------------
// Step 10 - Continue sending DATA to element (8'h5F), almost full is assert
// ---------------------------------------------------------------------
// Enable IMEAS
wr_data = 8'h01; 
`WR_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads);

wait(top_cfg.imeas2fifo_mem_cnt === 8'h5F);

// Disbale IMEAS
wr_data = 8'h00; 
`WR_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads);

$display("[INFO] STEP 10 Checking is DONE");
// ---------------------------------------------------------------------
// Step 11 -Checking clear function of almost full
// ---------------------------------------------------------------------
wait(`FIFO_TOP.fifo_intr);

// Set Almost Full Level to 8'h60 so that local interrupt is de-asserted
wr_data = 8'h60; // Defaulf of A_FULL_LEVEF is 8'h5F
`WR_NORMAL_REG(`SOC_FIFO_CONFIG_1_REG, wr_data, top_test_cfg.pads);

wr_data = 8'h20; 
`WR_NORMAL_REG(`SOC_FIFO_STATUS_REG,wr_data,top_test_cfg.pads);

wait(!`FIFO_TOP.fifo_intr);

$display("[INFO] STEP 11 Checking is DONE");
// ---------------------------------------------------------------------
// Step 12 - Checking Full Interrupt not happen
// ---------------------------------------------------------------------
// Interrupt pin is de-asserted
wait(!`FIFO_TOP.fifo_intr);

// Enable Almost Full Interrupt Output - Enable bit 4 A_ALMOST_INT_EN
wr_data = 8'h08; 
`WR_NORMAL_REG(`SOC_FIFO_CONFIG_3_REG, wr_data, top_test_cfg.pads);

$display("[INFO] STEP 12 Checking is DONE");
// ---------------------------------------------------------------------
// Step 13 - Continue sending DATA to element (8'h80), almost full is assert
// ---------------------------------------------------------------------
// Enable IMEAS
wr_data = 8'h01; 
`WR_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads);

`nnc_info("FIFO", $sformatf("current imeas2fifo_mem_cnt= %0d, waiting for %0d elements receive on IMEAS interface ",top_cfg.imeas2fifo_mem_cnt,`SOC_FIFO_SIZE),UVM_LOW);
wait(top_cfg.imeas2fifo_mem_cnt === `SOC_FIFO_SIZE);
`nnc_info("FIFO", $sformatf("wait done for %0d elements on IMEAS interface ",`SOC_FIFO_SIZE),UVM_LOW);

// Disbale IMEAS
wr_data = 8'h00; 
`WR_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads);

$display("[INFO] STEP 13 Checking is DONE");
// ---------------------------------------------------------------------
// Step 14 -Checking clear function of full
// ---------------------------------------------------------------------
wait(`FIFO_TOP.fifo_intr);

// Start reading FIFO without tag so that FIFO is not full anymore
  top_test_cfg.no_of_elements = 2;
  rd_data_fifo = new[top_test_cfg.no_of_elements];
  `RD_BURST_FIFO_NO_TAG(top_test_cfg.no_of_elements, rd_data_fifo);

// Clear status bit
wr_data = 8'h08; 
`WR_NORMAL_REG(`SOC_FIFO_STATUS_REG,wr_data,top_test_cfg.pads);

// Interrupt must be de-asserted
wait(!`FIFO_TOP.fifo_intr);

// Diable Full Interrupt Enable 
wr_data = 8'h00; 
`WR_NORMAL_REG(`SOC_FIFO_CONFIG_3_REG, wr_data, top_test_cfg.pads);

$display("[INFO] STEP 14 Checking is DONE");
// ---------------------------------------------------------------------
// Step 15 - Coninue sending data to FIFO full again and Checking Status register 
// ---------------------------------------------------------------------
wr_data = 8'h01; 
`WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads,top_test_cfg.mask);
$display("[INFO] - IMEAS is enable again at TIME: %t", $time);

wait(`FIFO_TOP.fifo_full);
// `RD_NORMAL_REG(`SOC_FIFO_STATUS_REG,top_test_cfg.pads,rd_data);
// while (!rd_data[3]) begin
// `RD_NORMAL_REG(`SOC_FIFO_STATUS_REG,top_test_cfg.pads,rd_data);
// end 
$display("[INFO] - FIFO is FULL at TIME: %t", $time);

// Disable IMEAS to stop sending DATA to FIFO when FIFO is FULL
wr_data = 8'h00; 
`WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads,top_test_cfg.mask);
$display("[INFO] - IMEAS is disable at TIME: %t", $time);

// Check FULL Status in status register
`RD_NORMAL_REG(`SOC_FIFO_STATUS_REG,top_test_cfg.pads,rd_data);
if (rd_data[7:3] !== 5'b00101) begin
  //$display("[ERROR][TEST][1] FIFO STATUS REGISTER[7:3] is not EXPECTED - CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t", rd_data[7:3], 5'b00101, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO STATUS REGISTER[7:3] is not EXPECTED - CURRENT VALUE=%h != EXPECTED VALUE=%h", rd_data[7:3], 5'b00101));
end

$display("[INFO] STEP 15 Checking is DONE");
// ---------------------------------------------------------------------
// Step 16 - Checking Fifo Data Counter and FIFO OVF COUNTER
// ---------------------------------------------------------------------
// Reading DATA counter
// Checking function of fifo_data_cnt and fifo_ovf_cnt at FIFO is FULL
no_of_bytes = 2;
rd_data_reg = new[no_of_bytes];
`RD_BURST_NORMAL_REG(`SOC_FIFO_COUNTER_1_REG, no_of_bytes, rd_data_reg);

if ({rd_data_reg[1][7],rd_data_reg[0]} !== `SOC_FIFO_SIZE) begin
  //$display("[ERROR][TEST][2] FIFO_DATA_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t ", {rd_data_reg[1][7],rd_data_reg[0]}, `SOC_FIFO_SIZE, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_DATA_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h", {rd_data_reg[1][7],rd_data_reg[0]}, `SOC_FIFO_SIZE));
end

// There is no lost DATA and checking this register
if (rd_data_reg[1][6:0] !== 7'h00) begin
  //$display("[ERROR][TEST][3] FIFO_OVF_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t", rd_data_reg[1][6:0], 7'h00, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_OVF_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h", rd_data_reg[1][6:0], 7'h00));
end

$display("[INFO] STEP 16 Checking is DONE");
// ---------------------------------------------------------------------
// Step 17 - Checking FIFO WR/RD Pointer
// ---------------------------------------------------------------------
// Checking FIFO WR POINTER when FIFO is FULL
`RD_NORMAL_REG(`SOC_FIFO_WR_PTR_REG,top_test_cfg.pads,rd_data);
if (rd_data !== 8'h02) begin // Write 256+2 elements to FIFO (because read step 14)
  //$display("[ERROR][TEST][4] FIFO_WRITE_POINTER is CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t ", rd_data, 8'h02, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_WRITE_POINTER is CURRENT VALUE=%h != EXPECTED VALUE=%h", rd_data, 8'h02));
end

// Checking FIFO RD POINTER when FIFO is FULL
`RD_NORMAL_REG(`SOC_FIFO_RD_PTR_REG,top_test_cfg.pads,rd_data);
if (rd_data !== 8'h02) begin // Read 2 elements at step 14
  //$display("[ERROR][TEST][5] FIFO_READ_POINTER is CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t ", rd_data, 8'h02, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_READ_POINTER is CURRENT VALUE=%h != EXPECTED VALUE=%h", rd_data, 8'h02));
end

$display("[INFO] STEP 17 Checking is DONE");
// ---------------------------------------------------------------------
// Step 18 - Continue send data when FIFO is full to generate FIFO error
// ---------------------------------------------------------------------
// Enable IMEAS to continuous sending DATA to FIFO when FIFO is FULL
wr_data = 8'h01; 
`WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads,top_test_cfg.mask);
$display("[INFO] - IMEAS is enable again at TIME: %t", $time);

// IMEAS sends DATA to FIFO completely
@(negedge `IMEAS_TOP.chdata_en_n);
@(posedge `IMEAS_TOP.chdata_en_n);

wr_data = 8'h00;
`WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads,top_test_cfg.mask);
$display("[INFO] - IMEAS is disable at TIME: %t", $time);

// Checking FIFO WR POINTER when FIFO is FULL (will not allowed to write to FIFO (protected THE WRITE when FULL)
`RD_NORMAL_REG(`SOC_FIFO_WR_PTR_REG,top_test_cfg.pads,rd_data);
if (rd_data !== 8'h02) begin
  //$display("[ERROR][TEST][6] FIFO_WRITE_POINTER is CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t ", rd_data, 8'h02, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_WRITE_POINTER is CURRENT VALUE=%h != EXPECTED VALUE=%h", rd_data, 8'h02));
end

$display("[INFO] STEP 18 Checking is DONE");
// ---------------------------------------------------------------------
// Step 19 - FIFO Error happen
// ---------------------------------------------------------------------
// Checking FIFO Error happen
`RD_NORMAL_REG(`SOC_FIFO_STATUS_REG,top_test_cfg.pads,rd_data);
// Check: rd_data[7]- err = 0, d_data[6]- a_empty=1, d_data[5]- a_full=0, d_data[4]- empty=1, d_data[3]- full=0
if (rd_data[7] !== 1'b1) begin
    //$display("[ERROR][TEST][7] FIFO Error is not occured in STATUS REGISTER value = %h at TIME = %t", rd_data, $time);
    `nnc_error(get_full_name(), $sformatf("FIFO Error is not occured in STATUS REGISTER value = %h ", rd_data));
end

// Checking DATA COUNT and DATA LOST
`RD_BURST_NORMAL_REG(`SOC_FIFO_COUNTER_1_REG, no_of_bytes, rd_data_reg);

if ({rd_data_reg[1][7],rd_data_reg[0]} !== `SOC_FIFO_SIZE) begin
  //$display("[ERROR][TEST][8] FIFO_DATA_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t", {rd_data_reg[1][7],rd_data_reg[0]}, `SOC_FIFO_SIZE, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_DATA_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h", {rd_data_reg[1][7],rd_data_reg[0]}, `SOC_FIFO_SIZE));
end

// There are lost DATA and checking this register
if (rd_data_reg[1][6:0] === 7'h00) begin
  //$display("[ERROR][TEST][9] FIFO_OVF_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t", rd_data_reg[1][6:0], 7'h00, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_OVF_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h ", rd_data_reg[1][6:0], 7'h00));
end

$display("[INFO] STEP 19 Checking is DONE");
// ---------------------------------------------------------------------
// Step 20 - Checking Error Fifo Interrupt Pin to not happen
// ---------------------------------------------------------------------
// Interrupt pin is de-asserted
wait(!`FIFO_TOP.fifo_intr);

// Enable Error Interrupt Output - Enable bit 7 ERROR_INT_EN
wr_data = 8'h80; 
`WR_NORMAL_REG(`SOC_FIFO_CONFIG_3_REG, wr_data, top_test_cfg.pads);

// Interrupt asser here
wait(`FIFO_TOP.fifo_intr);

$display("[INFO] STEP 20 Checking is DONE");
// ---------------------------------------------------------------------
// Step 21 -Checking clear function of full
// ---------------------------------------------------------------------

// Start reading FIFO without tag so that FIFO is not full anymore (read 2 elements)
  top_test_cfg.no_of_elements = 2;
  rd_data_fifo = new[top_test_cfg.no_of_elements];
  `RD_BURST_FIFO_NO_TAG(top_test_cfg.no_of_elements, rd_data_fifo);

// Clear status bit
wr_data = 8'h80; 
`WR_NORMAL_REG(`SOC_FIFO_STATUS_REG,wr_data,top_test_cfg.pads);

// Disble Error Interrupt Output - Clear bit 7 A_ALMOST_INT_EN
wr_data = 8'h00; 
`WR_NORMAL_REG(`SOC_FIFO_CONFIG_3_REG, wr_data, top_test_cfg.pads);

// Interrupt must be de-asserted
wait(!`FIFO_TOP.fifo_intr);

$display("[INFO] STEP 21 Checking is DONE");
// ---------------------------------------------------------------------
// Step 22 -ROLL ENABLE function 
// ---------------------------------------------------------------------

// Writing 2 elements to FIFO for FULL

// Enable IMEAS to continuous sending DATA to FIFO when FIFO is FULL
wr_data = 8'h01;
`WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads,top_test_cfg.mask);
$display("[INFO] - IMEAS is enable again at TIME: %t", $time);

// IMEAS sends DATA to FIFO completely (get 2 elements)
repeat(2) begin
  @(negedge `IMEAS_TOP.chdata_en_n);
  @(posedge `IMEAS_TOP.chdata_en_n);
end

// Disable IMEAS when FIFO is full now
wr_data = 8'h00;
`WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads,top_test_cfg.mask);
$display("[INFO] - IMEAS is disbale again at TIME: %t", $time);

// Enable ROLL_EN for FIFO
wr_data = 8'h02;
`WR_RD_CHK_NORMAL_REG(`SOC_FIFO_CONFIG_3_REG,wr_data,top_test_cfg.pads,top_test_cfg.mask);
$display("[INFO] - FIFO is setting to ROLL_EN at TIME: %t", $time);

// Enable IMEAS to continuous sending DATA to FIFO when FIFO is FULL
wr_data = 8'h01;
`WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads,top_test_cfg.mask);
$display("[INFO] - IMEAS is enable again at TIME: %t", $time);

// IMEAS sends DATA to FIFO completely (get 1 element)
repeat(1) begin
  @(negedge `IMEAS_TOP.chdata_en_n);
  @(posedge `IMEAS_TOP.chdata_en_n);
end

// Disable IMEAS
wr_data = 8'h00;
`WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads,top_test_cfg.mask);
$display("[INFO] - IMEAS is disbale again at TIME: %t", $time);

// Get Write Pointer from Register
`RD_NORMAL_REG(`SOC_FIFO_WR_PTR_REG,top_test_cfg.pads,rd_data);
if (rd_data === 8'h02) begin
  //$display("[ERROR][TEST][10] FIFO_WRITE_POINTER is not as our expectation CURRENT VALUE=%h == EXPECTED VALUE=%h at TIME = %t", rd_data, 8'h02, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_WRITE_POINTER is not as our expectation CURRENT VALUE=%h == EXPECTED VALUE=%h", rd_data, 8'h02));
end

// Get Read Pointer from Register
`RD_NORMAL_REG(`SOC_FIFO_RD_PTR_REG,top_test_cfg.pads,rd_data);
if (rd_data !== 8'h04) begin // Reading 2 elements at Step 21
  //$display("[ERROR][TEST][11] FIFO_READ_POINTER is CURRENT VALUE=%h != EXPECTED VALUE=%h At time = %t ", rd_data, 8'h04, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_READ_POINTER is CURRENT VALUE=%h != EXPECTED VALUE=%h", rd_data, 8'h04));
end

// Checking DATA COUNT and DATA LOST
`RD_BURST_NORMAL_REG(`SOC_FIFO_COUNTER_1_REG, no_of_bytes, rd_data_reg);

if ({rd_data_reg[1][7],rd_data_reg[0]} !== `SOC_FIFO_SIZE) begin
  //$display("[ERROR][TEST][12] FIFO_DATA_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t", {rd_data_reg[1][7],rd_data_reg[0]}, `SOC_FIFO_SIZE, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_DATA_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h", {rd_data_reg[1][7],rd_data_reg[0]}, `SOC_FIFO_SIZE));
end

// There are lost DATA and checking this register
if (rd_data_reg[1][6:0] === 7'h00) begin
  //$display("[ERROR][TEST][13] FIFO_OVF_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t", rd_data_reg[1][6:0], 7'h00, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_OVF_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h", rd_data_reg[1][6:0], 7'h00));
end

$display("[INFO] STEP 22 Checking is DONE");
// ---------------------------------------------------------------------
// Step 23 -Reading FIFO and check FIFO_OVF_CNT and FIFO_DATA_CNT
// ---------------------------------------------------------------------
// Start reading FIFO without TAG
  top_test_cfg.no_of_elements = 128;
  rd_data_fifo = new[top_test_cfg.no_of_elements];
  `RD_BURST_FIFO_NO_TAG(top_test_cfg.no_of_elements, rd_data_fifo);

//-------- enable tag_out------
  wr_data = 8'h04;
  `WR_RD_CHK_NORMAL_REG(`SOC_FIFO_CONFIG_3_REG,wr_data,top_test_cfg.pads,top_test_cfg.mask);

// Start reading FIFO with TAG
  top_test_cfg.no_of_elements_with_tags = 128;
  rd_data_fifo_tag = new[top_test_cfg.no_of_elements_with_tags];
  `RD_BURST_FIFO_TAG(top_test_cfg.no_of_elements_with_tags, rd_data_fifo_tag);

// FIFO_OVF_CNT will be reset to 0 when having reading
`RD_BURST_NORMAL_REG(`SOC_FIFO_COUNTER_1_REG, no_of_bytes, rd_data_reg);

if ({rd_data_reg[1][7],rd_data_reg[0]} !== (9'h100 - top_test_cfg.no_of_elements - top_test_cfg.no_of_elements_with_tags)) begin
  //$display("[ERROR][TEST][14] FIFO_DATA_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t", {rd_data_reg[1][7],rd_data_reg[0]}, (9'h100 - top_test_cfg.no_of_elements - top_test_cfg.no_of_elements_with_tags), $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_DATA_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h", {rd_data_reg[1][7],rd_data_reg[0]}, (9'h100 - top_test_cfg.no_of_elements - top_test_cfg.no_of_elements_with_tags)));
end

// There are lost DATA and checking this register
if (rd_data_reg[1][6:0] !== 7'h00) begin
  //$display("[ERROR][TEST][15] FIFO_OVF_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t", rd_data_reg[1][6:0], 7'h00, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_OVF_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h ", rd_data_reg[1][6:0], 7'h00));
end

$display("[INFO] STEP 23 Checking is DONE");
// ---------------------------------------------------------------------
// Step 24 -Check FLSH ENABLE function
// ---------------------------------------------------------------------
// Stop ROLL and enable flush
wr_data = 8'h01;
`WR_NORMAL_REG(`SOC_FIFO_CONFIG_3_REG, wr_data, top_test_cfg.pads);

// Clear FIFO_ERR_STS by write 1 to status register
// wr_data = 8'h80;
// `WR_NORMAL_REG(`SOC_FIFO_STATUS_REG, wr_data, top_test_cfg.pads);

`RD_NORMAL_REG(`SOC_FIFO_STATUS_REG,top_test_cfg.pads,rd_data);
// Check: rd_data[7]- err = 0, d_data[6]- a_empty=1, d_data[5]- a_full=0, d_data[4]- empty=1, d_data[3]- full=0
if (rd_data[7:3] !== 5'b01010) begin
    //$display("[ERROR][TEST][16] STATUS REGISTER[7:3] value = %h is not RESET to %h at TIME = %t", rd_data[7:3], 5'b01010, $time);
  `nnc_error(get_full_name(), $sformatf("STATUS REGISTER[7:3] value = %h is not RESET to %h", rd_data[7:3], 5'b01010));
end

// FIFO_OVF_CNT will be reset to 0 when having reading
`RD_BURST_NORMAL_REG(`SOC_FIFO_COUNTER_1_REG, no_of_bytes, rd_data_reg);

if ({rd_data_reg[1][7],rd_data_reg[0]} !== 9'h000) begin
  //$display("[ERROR][TEST][17] FIFO_DATA_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t", {rd_data_reg[1][7],rd_data_reg[0]}, 9'h000, $time);
  `nnc_error(get_full_name(), $sformatf("STATUS REGISTER[7:3] value = %h is not RESET to %h", rd_data[7:3], 5'b01010));
end

// There are lost DATA and checking this register
if (rd_data_reg[1][6:0] !== 7'h00) begin
  //$display("[ERROR][TEST][18] FIFO_OVF_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t", rd_data_reg[1][6:0], 7'h00, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_OVF_COUNT is CURRENT VALUE=%h != EXPECTED VALUE=%h", rd_data_reg[1][6:0], 7'h00));
end

// Get Write Pointer from Register
`RD_NORMAL_REG(`SOC_FIFO_WR_PTR_REG,top_test_cfg.pads,rd_data);
if (rd_data !== 8'h00) begin
  //$display("[ERROR][TEST][19] FIFO_WRITE_POINTER is not as our expectation CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t", rd_data, 8'hFF, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_WRITE_POINTER is not as our expectation CURRENT VALUE=%h != EXPECTED VALUE=%h", rd_data, 8'hFF));
end

// Get Read Pointer from Register
`RD_NORMAL_REG(`SOC_FIFO_RD_PTR_REG,top_test_cfg.pads,rd_data);
if (rd_data !== 8'h00) begin
  //$display("[ERROR][TEST][20] FIFO_READ_POINTER is CURRENT VALUE=%h != EXPECTED VALUE=%h At time = %t ", rd_data, 8'h00, $time);
  `nnc_error(get_full_name(), $sformatf("FIFO_READ_POINTER is CURRENT VALUE=%h != EXPECTED VALUE=%h", rd_data, 8'h00));
end

$display("[INFO] STEP 24 Checking is DONE");
// ---------------------------------------------------------------------
// Step 25 -Disable ROLL and Flash
// ---------------------------------------------------------------------
// Stop ROLL and disable flush
wr_data = 8'h00;
`WR_RD_CHK_NORMAL_REG(`SOC_FIFO_CONFIG_3_REG, wr_data, top_test_cfg.pads, top_test_cfg.mask);

    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    //#10000ns;
    `nnc_info("SOC_TEST", "soc_spi_fifo_roll_flush_debug_interrupt_tag_test end now", UVM_LOW)

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
