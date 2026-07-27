/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_spi_fifo_imeas_continuous_mode_disable_tag_1mhz_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_spi_fifo_imeas_continuous_mode_disable_tag_1mhz_test                                             
// Designer	: shreeyal@nanochap.com                                                                 
// Date		: 05-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_spi_fifo_imeas_continuous_mode_disable_tag_1mhz_test
`define TESTCFG soc_spi_fifo_imeas_continuous_mode_disable_tag_1mhz_test_cfg

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
  logic [`SOC_FIFO_ADDR-1:0] rd_counter = 0;
  logic [19:0] rd_data_imeas2fifo;
  logic [7:0] rd_data_reg[];
  logic [15:0] rd_data_fifo[];
  logic [17:0] rd_data_fifo_reg;
  logic status_bit;


  // -----------------------------------------------
  // End of decalration of new variables 
  // ===============================================

  function new (string name = "soc_spi_fifo_imeas_continuous_mode_disable_tag_1mhz_test_cfg");
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

  //constraint c_spi_sclk_freq          { soft spi_sclk_freq inside {[2000:2000]};}
   constraint c_pclk_sel               { pclk_sel == 0;}


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
    logic [`SOC_FIFO_ADDR-1:0] rd_counter = 0;
    logic [19:0] rd_data_imeas2fifo;
    logic [7:0] rd_data_reg[];
    logic [15:0] rd_data_fifo[];
    logic [17:0] rd_data_fifo_reg;
    logic [23:0] rd_data_fifo_tags[];

    logic status_bit;
    int         no_of_bytes; 
    int loop1;
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_spi_fifo_imeas_continuous_mode_disable_tag_1mhz_test start", UVM_LOW)

    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    
//$display("[DEBUG] - STEP 1");
`nnc_info(get_full_name(), $sformatf("[DEBUG] - STEP 1"),UVM_MEDIUM);
// Enable IMEAS
`RD_NORMAL_REG(`SOC_IMEAS_EN,top_test_cfg.pads,rd_data);
rd_data[0] = 1'b1;
wr_data = rd_data;
`WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads,top_test_cfg.mask);

// Set coversion mode to select continuous mode channel conversion
`RD_NORMAL_REG(`SOC_IMEAS_MODE_REG,top_test_cfg.pads,rd_data);
rd_data[1:0] = 2'b01;
wr_data = rd_data;
`WR_NORMAL_REG(`SOC_IMEAS_MODE_REG, wr_data, top_test_cfg.pads);

// Enable interrupt
`RD_NORMAL_REG(`SOC_IMEAS_REG_CTRL_0,top_test_cfg.pads,rd_data);
rd_data[0] = 1'b1;
wr_data = rd_data;
`WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_REG_CTRL_0,wr_data,top_test_cfg.pads,top_test_cfg.mask);

// SD16OFF , SD16SLP , SD16RST  to 0
`RD_NORMAL_REG(`SOC_IMEAS_REG_SEQ,top_test_cfg.pads,rd_data);
rd_data[2:0] = 3'b000;
wr_data = rd_data;
`WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_REG_SEQ,wr_data,top_test_cfg.pads,top_test_cfg.mask);


//$display("[DEBUG] - STEP 2");
`nnc_info(get_full_name(), $sformatf("[DEBUG] - STEP 2"),UVM_MEDIUM);
// ----------------------------------------
// TEST with NO TAGs
// ----------------------------------------
// Read status of empty
`RD_NORMAL_REG(`SOC_FIFO_STATUS_REG,top_test_cfg.pads,rd_data);

// Check: rd_data[7]- err = 0, d_data[6]- a_empty=1, d_data[5]- a_full=0, d_data[4]- empty=1, d_data[3]- full=0
if (rd_data[7:3] !== 5'b01010) begin
  //  $display("[ERROR][0] - STATUS REGISTER is WRONG = %h", rd_data);
    `nnc_error("STATUS REGISTER is WRONG = %h",rd_data);

end

status_bit = rd_data[4];

// Read Pointer must be 0
`RD_NORMAL_REG(`SOC_FIFO_RD_PTR_REG,top_test_cfg.pads,rd_data);
if (rd_data != 8'h00) begin
   // $display("[ERROR][1] FIFO_READ_POINTER is CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t ", rd_data, 8'h00, $time);
    `nnc_error("FIFO_READ_POINTER is CURRENT VALUE=%h != EXPECTED VALUE=%h = 'h00",rd_data);

end

//$display("[DEBUG] - STEP 3");
`nnc_info(get_full_name(), $sformatf("[DEBUG] - STEP 3"),UVM_MEDIUM);

`ifndef POSTLAYOUT_PG
loop1 = 3;
`else
loop1 = 1;
`endif

for (int i = 0; i < loop1; i++) begin
  `nnc_info("FIFO", $sformatf("current imeas2fifo_mem_cnt= %0d, waiting for %0d elements receive on IMEAS interface ",top_cfg.imeas2fifo_mem_cnt,`SOC_FIFO_SIZE*(i+1)),UVM_LOW);
  wait(top_cfg.imeas2fifo_mem_cnt === `SOC_FIFO_SIZE*(i+1));
  `nnc_info("FIFO", $sformatf("wait done for %0d elements on IMEAS interface ",`SOC_FIFO_SIZE*(i+1)),UVM_LOW);

  // Disble IMEAS
  wr_data = 8'h00; 
  `WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads,top_test_cfg.mask);

 repeat (`SOC_FIFO_SIZE) begin
  // wait FIFO almost full
  `RD_NORMAL_REG(`SOC_FIFO_STATUS_REG,top_test_cfg.pads,rd_data);
  while (!rd_data[5]) begin
    `RD_NORMAL_REG(`SOC_FIFO_STATUS_REG,top_test_cfg.pads,rd_data);
  end
  // Read through FIFO_DATA_REG to get the values of DATA in registers
  no_of_bytes = 2;
  rd_data_reg = new[no_of_bytes];
  `RD_BURST_NORMAL_REG(`SOC_FIFO_DATA_REG1, no_of_bytes, rd_data_reg);

  // Get TAGs from Status register
  `RD_NORMAL_REG(`SOC_FIFO_STATUS_REG,top_test_cfg.pads,rd_data);

  // Checking group mode
  if (rd_data[1:0] !== 3'b11) begin
    //$display("[ERROR][2] IMEAS is not in GROUP mode with TAG = %h", rd_data[1:0]);
    `nnc_error("IMEAS is not in GROUP mode with TAG = %h",rd_data[1:0]);

  end

  rd_data_fifo_reg = {rd_data[1:0], rd_data_reg[1], rd_data_reg[0]};

  if (rd_data_fifo_reg !== `SPI_IF_EXP_DATA) begin
   // $display("[ERROR][3] DATA from IMEAS is received at SPI Master through READ REGISTER is VALUE=%h != EXPECTED VALUE=%h", rd_data_fifo_reg, `SPI_IF_EXP_DATA);
    `nnc_error(get_full_name(), $sformatf("DATA from IMEAS is received at SPI Master through READ REGISTER is VALUE=%h != EXPECTED VALUE=%h", rd_data_fifo_reg, `SPI_IF_EXP_DATA));

  end
  else
    $display("[SPI INFO] DATA from IMEAS is received at SPI Master through READ REGISTER is VALUE=%h and Expected Value =%h At time = %t", rd_data_fifo_reg, `SPI_IF_EXP_DATA, $time);

  // Read a burst from FIFO
  top_test_cfg.no_of_elements = 1;
  rd_data_fifo = new[top_test_cfg.no_of_elements];
  `RD_BURST_FIFO_NO_TAG(top_test_cfg.no_of_elements, rd_data_fifo); 

  // Expected read pointer 
  rd_counter = rd_counter + top_test_cfg.no_of_elements;
  repeat(2) @(posedge `DUT_IF.sys_clk);

  // Checking FIFO RD POINTER
  `RD_NORMAL_REG(`SOC_FIFO_RD_PTR_REG,top_test_cfg.pads,rd_data);
  // Checking Read pointer must be not 0
  if (rd_data !== rd_counter) begin
    //$display("[ERROR][4] FIFO_READ_POINTER is CURRENT VALUE=%h != EXPECTED VALUE=%h at TIME = %t ", rd_data, rd_counter, $time);
    `nnc_error(get_full_name(), $sformatf("FIFO_READ_POINTER is CURRENT VALUE=%h != EXPECTED VALUE=%h", rd_data, rd_counter));

  end

  // Compare DATA read in registers and from FIFO data bus
  for (int i = 0; i < top_test_cfg.no_of_elements; i++) begin
    if (rd_data_fifo_reg[15:0] !== rd_data_fifo[i]) begin
      //$display("[ERROR][5] READ DATA from FIFO Register Element-%d: %h is NOT EQUAL to THE VALUE READ DIRECT from FIFO: %h", i, rd_data_fifo_reg[15:0], rd_data_fifo[i]);
      `nnc_error(get_full_name(), $sformatf("READ DATA from FIFO Register Element-%d: %h is NOT EQUAL to THE VALUE READ DIRECT from FIFO: %h", i, rd_data_fifo_reg[17:0], rd_data_fifo_tags[top_test_cfg.no_of_elements - 1 - i][17:0]));

    end
  end

/*
  // Extract from FIFO
  rd_data_imeas2fifo = top_cfg.imeas2fifo_data_mem.pop_front();
  // Compare DATA read in registers and from FIFO data bus
  for (int i = 0; i < top_test_cfg.no_of_elements; i++) begin
    if (rd_data_imeas2fifo[15:0] !== rd_data_fifo[i]) begin
     // $display("[ERROR][6] READ DATA from FIFO Register Element-%d: %h is NOT EQUAL to THE VALUE from IMEAS to FIFO: %h", i, rd_data_imeas2fifo[15:0], rd_data_fifo[i]);
      `nnc_error(get_full_name(), $sformatf("READ DATA from FIFO Element-%d: %h is NOT EQUAL to THE VALUE from IMEAS to FIFO: %h", i, rd_data_fifo_tags[top_test_cfg.no_of_elements - 1 - i][17:0], rd_data_imeas2fifo[17:0]));

    end
  end*/
 end

  // Enable IMEAS
  wr_data = 8'h01; 
  `WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads,top_test_cfg.mask);
end

for (int i=10; i < 3; i++) begin

  `nnc_info("FIFO", $sformatf("current imeas2fifo_mem_cnt= %0d, waiting for %0d elements receive on IMEAS interface ",top_cfg.imeas2fifo_mem_cnt,`SOC_FIFO_SIZE*(i+1)),UVM_LOW);
  wait(top_cfg.imeas2fifo_mem_cnt === `SOC_FIFO_SIZE*(i+1));
  `nnc_info("FIFO", $sformatf("wait done for %0d elements on IMEAS interface ",`SOC_FIFO_SIZE*(i+1)),UVM_LOW);

  // Disble IMEAS
  wr_data = 8'h00; 
  `WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads,top_test_cfg.mask);

  // wait FIFO almost full
  `RD_NORMAL_REG(`SOC_FIFO_STATUS_REG,top_test_cfg.pads,rd_data);
  while (!rd_data[5]) begin
    `RD_NORMAL_REG(`SOC_FIFO_STATUS_REG,top_test_cfg.pads,rd_data);
  end
/*
 // Read a large burst from FIFO
  top_test_cfg.no_of_elements = `SOC_FIFO_SIZE;
  rd_data_fifo = new[top_test_cfg.no_of_elements];
  `RD_BURST_FIFO_NO_TAG(top_test_cfg.no_of_elements, rd_data_fifo);
  
  // Compare DATA read in registers and from FIFO data bus
  for (int i = 0; i < top_test_cfg.no_of_elements; i++) begin
      // Extract from FIFO
    rd_data_imeas2fifo = top_cfg.imeas2fifo_data_mem.pop_front();
    if (rd_data_imeas2fifo[15:0] !== rd_data_fifo[top_test_cfg.no_of_elements - 1 - i]) begin
     // $display("[ERROR][7] READ DATA from FIFO Register Element-%d: %h is NOT EQUAL to THE VALUE from IMEAS to FIFO: %h", i, rd_data_fifo[top_test_cfg.no_of_elements - 1 - i], rd_data_imeas2fifo[15:0]);
      `nnc_error(get_full_name(), $sformatf("READ DATA from FIFO Element-%d: %h is NOT EQUAL to THE VALUE from IMEAS to FIFO: %h", i, rd_data_fifo_tags[top_test_cfg.no_of_elements - 1 - i][17:0], rd_data_imeas2fifo[17:0]));

    end
  end */

  // Get TAGs from Status register
  `RD_NORMAL_REG(`SOC_FIFO_STATUS_REG,top_test_cfg.pads,rd_data);

  // Enable IMEAS
  wr_data = 8'h01; 
  `WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_EN,wr_data,top_test_cfg.pads,top_test_cfg.mask);
end


    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    //#10000ns;
    `nnc_info("SOC_TEST", "soc_spi_fifo_imeas_continuous_mode_disable_tag_1mhz_test end now", UVM_LOW)

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
