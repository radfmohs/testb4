/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_spi_unlock_trim_flash_test.sv                                                   
// Project	: Nanochap BAF4P1                                  		        
// Description	: Testcase soc_spi_unlock_trim_flash_test                                             
// Designer	: shreeyal@nanochap.com                                                                 
// Date		: 12-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_spi_unlock_trim_flash_test
`define TESTCFG soc_spi_unlock_trim_flash_test_cfg

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
  logic [7:0] expected_data [256];
  logic [7:0]      rd_data[];

  // -----------------------------------------------
  // End of decalration of new variables 
  // ===============================================

  function new (string name = "soc_spi_unlock_trim_flash_test_cfg");
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
  constraint c_no_of_bytes { no_of_bytes == 21; }

  // pads values
  constraint c_pads        { soft pads == 8'h00; }

  // mask values
  constraint c_mask        { soft mask == 8'hff; }

  constraint c_disable_init_flash     { disable_init_flash == 1'b1;}
  constraint c_wake_up_en             { soft wake_up_en == 1'b1;}
  constraint c_wr_data               { wr_data[20] == 8'h5A;}


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

   `DUT_IF.disable_init_flash = top_test_cfg.disable_init_flash;
   
   `DUT_IF.wake_up_en = top_test_cfg.wake_up_en;
    

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
    logic [7:0]      rd_data;
    logic [7:0] rd_data_reg[];
    //---------------------------- FLASH -------------------------------------------
    logic [7:0] flash_debug_status;


     phase.raise_objection(this);

     `nnc_info("SOC_TEST", "soc_spi_unlock_trim_flash_test start", UVM_LOW)

     flash_debug_status = 8'h00;

     `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,flash_debug_status);
     while (flash_debug_status[6]) begin
      `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,flash_debug_status);
     end
     $display ($time,"\tFlash reset done");
     //#6ms;
     for (int i=0; i<256; i++) begin
       if (top_test_cfg.wr_data[i] == 8'h00) top_test_cfg.wr_data[i] = 8'h01;
     end
     // Write DATA to all TRIM registers
     `WR_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA0, top_test_cfg.no_of_bytes, top_test_cfg.pads,top_test_cfg.wr_data);

     // Read Data from Trim Registers
     rd_data_reg = new[top_test_cfg.no_of_bytes+1];
     `RD_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA0, top_test_cfg.no_of_bytes, rd_data_reg);

     // Compare the values 
     for(int i=0; i<top_test_cfg.no_of_bytes; i++) begin
      if(top_test_cfg.wr_data[i] !== rd_data_reg[i]) begin
       `nnc_error(get_full_name(), $sformatf("TRIM VALUE MISMATCH!!! wr_data[%d] = %h, rd_data_reg[%d]=%h", i, top_test_cfg.wr_data[i], i, rd_data_reg[i]));
      end
     end 

     foreach(top_test_cfg.expected_data[i])begin
       top_test_cfg.expected_data[i] = top_test_cfg.wr_data[i];
     end

     // Enable SPI_WRITE
     `WR_RD_CHK_NORMAL_REG(`SOC_FLASH_UNLOCK, 8'h02, top_test_cfg.pads,top_test_cfg.mask);

     top_test_cfg.no_of_bytes = 10;
     rd_data_reg = new[top_test_cfg.no_of_bytes+1];
     `RD_BURST_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM1, top_test_cfg.no_of_bytes, rd_data_reg);

     // Compare the values
     if(top_test_cfg.wr_data[19]!== rd_data_reg[9]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM1_REG = %h, SOC_ALWAYS_ON_ANA_TRIM1=%h", top_test_cfg.wr_data[19], rd_data_reg[9]));
     end

     if(top_test_cfg.wr_data[18] !== rd_data_reg[8]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM2_REG = %h, SOC_ALWAYS_ON_ANA_TRIM2=%h", top_test_cfg.wr_data[18], rd_data_reg[8]));
     end

     if(top_test_cfg.wr_data[17] !== rd_data_reg[7]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM3_REG = %h, SOC_ALWAYS_ON_ANA_TRIM3=%h", top_test_cfg.wr_data[17], rd_data_reg[7]));
     end

     if(top_test_cfg.wr_data[16] !== rd_data_reg[6]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM4_REG = %h, SOC_ALWAYS_ON_ANA_TRIM4=%h", top_test_cfg.wr_data[16], rd_data_reg[6]));
     end

     if(top_test_cfg.wr_data[15] !== rd_data_reg[5]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM5_REG = %h, SOC_ALWAYS_ON_ANA_TRIM5=%h", top_test_cfg.wr_data[15], rd_data_reg[5]));
     end

     if(top_test_cfg.wr_data[14] !== rd_data_reg[4]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM6_REG = %h, SOC_ALWAYS_ON_ANA_TRIM6=%h", top_test_cfg.wr_data[14], rd_data_reg[4]));
     end

     if(top_test_cfg.wr_data[13] !== rd_data_reg[3]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM7_REG = %h, SOC_ALWAYS_ON_ANA_TRIM7=%h", top_test_cfg.wr_data[12], rd_data_reg[3]));
     end

     if(top_test_cfg.wr_data[12] !== rd_data_reg[2]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM8_REG = %h, SOC_ALWAYS_ON_ANA_TRIM8=%h", top_test_cfg.wr_data[12], rd_data_reg[2]));
     end

     if(top_test_cfg.wr_data[11] !== rd_data_reg[1]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM9_REG = %h, SOC_ALWAYS_ON_ANA_TRIM9=%h", top_test_cfg.wr_data[11], rd_data_reg[1]));
     end

     if(top_test_cfg.wr_data[10] !== rd_data_reg[0]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM10_REG = %h, SOC_ALWAYS_ON_ANA_TRIM10=%h", top_test_cfg.wr_data[10], rd_data_reg[0]));
     end

    // Changing to use external clock
     assert(top_test_cfg.randomize() with {ext_clk_en==1;ext_clk_sel==2'b01;hfosc_variation == 100;});
     `DUT_IF.ext_clk_en =top_test_cfg.ext_clk_en;
     `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel; //1MHz
     `DUT_IF.hfosc_fixed_gnd_en = top_test_cfg.hfosc_fixed_gnd_en;
     `DUT_IF.ext_hfosc_fixed_gnd_en = top_test_cfg.ext_hfosc_fixed_gnd_en;
     `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;
     #10us;
       
 `ifndef NEW_BAF4P1
     // Write to set UNLOCK bit
     `WR_RD_CHK_NORMAL_REG(`SOC_FLASH_UNLOCK,8'h01,top_test_cfg.pads,top_test_cfg.mask);

     //wait (!`SPI_TOP.FLASH_BUSY);
     `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,flash_debug_status);
     while (flash_debug_status[6]) begin
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,flash_debug_status);
     end
 
     #5ms; 

    // changing to internal clock again
    assert(top_test_cfg.randomize() with {ext_clk_en==0;ext_clk_sel==2'b00;});
    `DUT_IF.ext_clk_en =top_test_cfg.ext_clk_en;
    `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel; //1MHz
    `DUT_IF.hfosc_fixed_gnd_en = top_test_cfg.hfosc_fixed_gnd_en;
    `DUT_IF.ext_hfosc_fixed_gnd_en = top_test_cfg.ext_hfosc_fixed_gnd_en;
    `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;

     $display ("\n Enter Low power mode");
     //force `ANA_TOP.PMU_SW.wakeup=0;
     `DUT_IF.wake_up_en = 0;
     #1000000
     //repeat(200) @(posedge `DUT_IF.sys_clk);

     $display ("\n Enter Active mode");
     //release `ANA_TOP.PMU_SW.wakeup; 
     `DUT_IF.wake_up_en = 1;

     wait(`RESETN);

     //wait (!`SPI_TOP.FLASH_BUSY);
     //spi_rd_single_reg(`SOC_FLASH_DEBUG2,pad,flash_debug_status);
     `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,flash_debug_status);
     while (flash_debug_status[6]) begin
      //spi_rd_single_reg(`SOC_FLASH_DEBUG2,pad,flash_debug_status);
      `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,flash_debug_status);
     end
     $display ("\tFlash reset done");

     ///Read Ana Trim values stored in customer reserved space of NVR2
     ///to read burst starting from the SOC_FLASH_TRIMDATA0 reg
     top_test_cfg.no_of_bytes = 21;
     rd_data_reg = new[top_test_cfg.no_of_bytes];
     `RD_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA0, top_test_cfg.no_of_bytes, rd_data_reg);

     // Compare the values 
     for(int i=0; i<top_test_cfg.no_of_bytes; i++) begin
      if(top_test_cfg.expected_data[i] !== rd_data_reg[i]) begin
       `nnc_error(get_full_name(), $sformatf("TRIM VALUE MISMATCH!!! top_test_cfg.expected_data[%d] = %h, rd_data_reg[%d]=%h", i, top_test_cfg.expected_data[i], i, rd_data_reg[i]));
      end
     end 

     top_test_cfg.no_of_bytes = 10;
     rd_data_reg = new[top_test_cfg.no_of_bytes+1];
     `RD_BURST_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM1, top_test_cfg.no_of_bytes, rd_data_reg);

     // Compare the values
     if(top_test_cfg.expected_data[19]!== rd_data_reg[9]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM1_REG = %h, SOC_ALWAYS_ON_ANA_TRIM1=%h", top_test_cfg.expected_data[19], rd_data_reg[9]));
     end

     if(top_test_cfg.expected_data[18] !== rd_data_reg[8]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM2_REG = %h, SOC_ALWAYS_ON_ANA_TRIM2=%h", top_test_cfg.expected_data[18], rd_data_reg[8]));
     end

     if(top_test_cfg.expected_data[17] !== rd_data_reg[7]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM3_REG = %h, SOC_ALWAYS_ON_ANA_TRIM3=%h", top_test_cfg.expected_data[17], rd_data_reg[7]));
     end

     if(top_test_cfg.expected_data[16] !== rd_data_reg[6]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM4_REG = %h, SOC_ALWAYS_ON_ANA_TRIM4=%h", top_test_cfg.expected_data[16], rd_data_reg[6]));
     end

     if(top_test_cfg.expected_data[15] !== rd_data_reg[5]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM5_REG = %h, SOC_ALWAYS_ON_ANA_TRIM5=%h", top_test_cfg.expected_data[15], rd_data_reg[5]));
     end

     if(top_test_cfg.expected_data[14] !== rd_data_reg[4]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM6_REG = %h, SOC_ALWAYS_ON_ANA_TRIM6=%h", top_test_cfg.expected_data[14], rd_data_reg[4]));
     end

     if(top_test_cfg.expected_data[13] !== rd_data_reg[3]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM7_REG = %h, SOC_ALWAYS_ON_ANA_TRIM7=%h", top_test_cfg.expected_data[12], rd_data_reg[3]));
     end

     if(top_test_cfg.expected_data[12] !== rd_data_reg[2]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM8_REG = %h, SOC_ALWAYS_ON_ANA_TRIM8=%h", top_test_cfg.expected_data[12], rd_data_reg[2]));
     end

     if(top_test_cfg.expected_data[11] !== rd_data_reg[1]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM9_REG = %h, SOC_ALWAYS_ON_ANA_TRIM9=%h", top_test_cfg.expected_data[11], rd_data_reg[1]));
     end

     if(top_test_cfg.expected_data[10] !== rd_data_reg[0]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM10_REG = %h, SOC_ALWAYS_ON_ANA_TRIM10=%h", top_test_cfg.expected_data[10], rd_data_reg[0]));
     end
`else
     // Write to set UNLOCK bit
     `WR_RD_CHK_NORMAL_REG(`SOC_FLASH_UNLOCK,8'h01,top_test_cfg.pads,top_test_cfg.mask);

     //wait (!`SPI_TOP.FLASH_BUSY);
     `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,flash_debug_status);
     while (flash_debug_status[6]) begin
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,flash_debug_status);
     end
 
     #5ms; 

    // changing to internal clock again
    assert(top_test_cfg.randomize() with {ext_clk_en==0;ext_clk_sel==2'b00;});
    `DUT_IF.ext_clk_en =top_test_cfg.ext_clk_en;
    `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel; //1MHz
    `DUT_IF.hfosc_fixed_gnd_en = top_test_cfg.hfosc_fixed_gnd_en;
    `DUT_IF.ext_hfosc_fixed_gnd_en = top_test_cfg.ext_hfosc_fixed_gnd_en;
    `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;

     $display ("\n Enter Low power mode");
     //force `ANA_TOP.PMU_SW.wakeup=0;
     `DUT_IF.wake_up_en = 0;
     #1000000
     //repeat(200) @(posedge `DUT_IF.sys_clk);

     $display ("\n Enter Active mode");
     //release `ANA_TOP.PMU_SW.wakeup; 
     `DUT_IF.wake_up_en = 1;

     wait(`RESETN);

     //wait (!`SPI_TOP.FLASH_BUSY);
     //spi_rd_single_reg(`SOC_FLASH_DEBUG2,pad,flash_debug_status);
     `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,flash_debug_status);
     while (flash_debug_status[6]) begin
      //spi_rd_single_reg(`SOC_FLASH_DEBUG2,pad,flash_debug_status);
      `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,flash_debug_status);
     end
     $display ("\tFlash reset done");

     ///Read Ana Trim values stored in customer reserved space of NVR2
     ///to read burst starting from the SOC_FLASH_TRIMDATA0 reg
     top_test_cfg.no_of_bytes = 21;
     rd_data_reg = new[top_test_cfg.no_of_bytes];
     `RD_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA0, top_test_cfg.no_of_bytes, rd_data_reg);

     // Compare the values 
     for(int i=0; i<top_test_cfg.no_of_bytes; i++) begin
      if(top_test_cfg.expected_data[i] === rd_data_reg[i]) begin
       `nnc_error(get_full_name(), $sformatf("TRIM VALUE MISMATCH!!! top_test_cfg.expected_data[%d] = %h, rd_data_reg[%d]=%h", i, top_test_cfg.expected_data[i], i, rd_data_reg[i]));
      end
     end 

     top_test_cfg.no_of_bytes = 10;
     rd_data_reg = new[top_test_cfg.no_of_bytes+1];
     `RD_BURST_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM1, top_test_cfg.no_of_bytes, rd_data_reg);

     // Compare the values
     if(top_test_cfg.expected_data[19] !== rd_data_reg[9]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM1_REG = %h, SOC_ALWAYS_ON_ANA_TRIM1=%h", top_test_cfg.expected_data[19], rd_data_reg[9]));
     end

     if(top_test_cfg.expected_data[18] !== rd_data_reg[8]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM2_REG = %h, SOC_ALWAYS_ON_ANA_TRIM2=%h", top_test_cfg.expected_data[18], rd_data_reg[8]));
     end

     if(top_test_cfg.expected_data[17] !== rd_data_reg[7]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM3_REG = %h, SOC_ALWAYS_ON_ANA_TRIM3=%h", top_test_cfg.expected_data[17], rd_data_reg[7]));
     end

     if(top_test_cfg.expected_data[16] !== rd_data_reg[6]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM4_REG = %h, SOC_ALWAYS_ON_ANA_TRIM4=%h", top_test_cfg.expected_data[16], rd_data_reg[6]));
     end

     if(top_test_cfg.expected_data[15] !== rd_data_reg[5]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM5_REG = %h, SOC_ALWAYS_ON_ANA_TRIM5=%h", top_test_cfg.expected_data[15], rd_data_reg[5]));
     end

     if(top_test_cfg.expected_data[14] !== rd_data_reg[4]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM6_REG = %h, SOC_ALWAYS_ON_ANA_TRIM6=%h", top_test_cfg.expected_data[14], rd_data_reg[4]));
     end

     if(top_test_cfg.expected_data[13] !== rd_data_reg[3]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM7_REG = %h, SOC_ALWAYS_ON_ANA_TRIM7=%h", top_test_cfg.expected_data[12], rd_data_reg[3]));
     end

     if(top_test_cfg.expected_data[12] !== rd_data_reg[2]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM8_REG = %h, SOC_ALWAYS_ON_ANA_TRIM8=%h", top_test_cfg.expected_data[12], rd_data_reg[2]));
     end

     if(top_test_cfg.expected_data[11] !== rd_data_reg[1]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM9_REG = %h, SOC_ALWAYS_ON_ANA_TRIM9=%h", top_test_cfg.expected_data[11], rd_data_reg[1]));
     end

     if(top_test_cfg.expected_data[10] !== rd_data_reg[0]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM10_REG = %h, SOC_ALWAYS_ON_ANA_TRIM10=%h", top_test_cfg.expected_data[10], rd_data_reg[0]));
     end

     top_test_cfg.no_of_bytes = 21;
     // Write DATA to all TRIM registers
     `WR_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA0, top_test_cfg.no_of_bytes, top_test_cfg.pads,top_test_cfg.wr_data);

     foreach(top_test_cfg.expected_data[i])begin
       top_test_cfg.expected_data[i] = top_test_cfg.wr_data[i];
     end

     // Correct KEY 
     // Changing to use external clock
     assert(top_test_cfg.randomize() with {ext_clk_en==1;ext_clk_sel==2'b01;hfosc_variation == 100;});
     `DUT_IF.ext_clk_en =top_test_cfg.ext_clk_en;
     `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel; //1MHz
     `DUT_IF.hfosc_fixed_gnd_en = top_test_cfg.hfosc_fixed_gnd_en;
     `DUT_IF.ext_hfosc_fixed_gnd_en = top_test_cfg.ext_hfosc_fixed_gnd_en;
     `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;
     #1000us;

     // Write to set UNLOCK bit
     `WR_NORMAL_REG(`SOC_FLASH_UNLOCK, 8'b10101_0_0_1, top_test_cfg.pads);

     //wait (!`SPI_TOP.FLASH_BUSY);
     `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,flash_debug_status);
     while (flash_debug_status[6]) begin
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,flash_debug_status);
     end

     `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,rd_data);

      while (rd_data[0] === 1) begin
       `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,rd_data);
      end
 
     #5ms; 

    // changing to internal clock again
    assert(top_test_cfg.randomize() with {ext_clk_en==0;ext_clk_sel==2'b00;});
    `DUT_IF.ext_clk_en =top_test_cfg.ext_clk_en;
    `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel; //1MHz
    `DUT_IF.hfosc_fixed_gnd_en = top_test_cfg.hfosc_fixed_gnd_en;
    `DUT_IF.ext_hfosc_fixed_gnd_en = top_test_cfg.ext_hfosc_fixed_gnd_en;
    `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;

     $display ("\n Enter Low power mode");
     //force `ANA_TOP.PMU_SW.wakeup=0;
     `DUT_IF.wake_up_en = 0;
     #1000000
     //repeat(200) @(posedge `DUT_IF.sys_clk);

     $display ("\n Enter Active mode");
     //release `ANA_TOP.PMU_SW.wakeup; 
     `DUT_IF.wake_up_en = 1;

     wait(`RESETN);

     //wait (!`SPI_TOP.FLASH_BUSY);
     //spi_rd_single_reg(`SOC_FLASH_DEBUG2,pad,flash_debug_status);
     `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,flash_debug_status);
     while (flash_debug_status[6]) begin
      //spi_rd_single_reg(`SOC_FLASH_DEBUG2,pad,flash_debug_status);
      `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,flash_debug_status);
     end
     $display ("\tFlash reset done");

     ///Read Ana Trim values stored in customer reserved space of NVR2
     ///to read burst starting from the SOC_FLASH_TRIMDATA0 reg
     top_test_cfg.no_of_bytes = 21;
     rd_data_reg = new[top_test_cfg.no_of_bytes];
     `RD_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA0, top_test_cfg.no_of_bytes, rd_data_reg);

     // Compare the values 
     for(int i=0; i<top_test_cfg.no_of_bytes; i++) begin
      if(top_test_cfg.expected_data[i] !== rd_data_reg[i]) begin
       `nnc_error(get_full_name(), $sformatf("TRIM VALUE MISMATCH!!! top_test_cfg.expected_data[%d] = %h, rd_data_reg[%d]=%h", i, top_test_cfg.expected_data[i], i, rd_data_reg[i]));
      end
     end 

     top_test_cfg.no_of_bytes = 10;
     rd_data_reg = new[top_test_cfg.no_of_bytes+1];
     `RD_BURST_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM1, top_test_cfg.no_of_bytes, rd_data_reg);

     // Compare the values
     if(top_test_cfg.expected_data[19] !== rd_data_reg[9]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM1_REG = %h, SOC_ALWAYS_ON_ANA_TRIM1=%h", top_test_cfg.expected_data[19], rd_data_reg[9]));
     end

     if(top_test_cfg.expected_data[18] !== rd_data_reg[8]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM2_REG = %h, SOC_ALWAYS_ON_ANA_TRIM2=%h", top_test_cfg.expected_data[18], rd_data_reg[8]));
     end

     if(top_test_cfg.expected_data[17] !== rd_data_reg[7]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM3_REG = %h, SOC_ALWAYS_ON_ANA_TRIM3=%h", top_test_cfg.expected_data[17], rd_data_reg[7]));
     end

     if(top_test_cfg.expected_data[16] !== rd_data_reg[6]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM4_REG = %h, SOC_ALWAYS_ON_ANA_TRIM4=%h", top_test_cfg.expected_data[16], rd_data_reg[6]));
     end

     if(top_test_cfg.expected_data[15] !== rd_data_reg[5]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM5_REG = %h, SOC_ALWAYS_ON_ANA_TRIM5=%h", top_test_cfg.expected_data[15], rd_data_reg[5]));
     end

     if(top_test_cfg.expected_data[14] !== rd_data_reg[4]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM6_REG = %h, SOC_ALWAYS_ON_ANA_TRIM6=%h", top_test_cfg.expected_data[14], rd_data_reg[4]));
     end

     if(top_test_cfg.expected_data[13] !== rd_data_reg[3]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM7_REG = %h, SOC_ALWAYS_ON_ANA_TRIM7=%h", top_test_cfg.expected_data[12], rd_data_reg[3]));
     end

     if(top_test_cfg.expected_data[12] !== rd_data_reg[2]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM8_REG = %h, SOC_ALWAYS_ON_ANA_TRIM8=%h", top_test_cfg.expected_data[12], rd_data_reg[2]));
     end

     if(top_test_cfg.expected_data[11] !== rd_data_reg[1]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM9_REG = %h, SOC_ALWAYS_ON_ANA_TRIM9=%h", top_test_cfg.expected_data[11], rd_data_reg[1]));
     end

     if(top_test_cfg.expected_data[10] !== rd_data_reg[0]) begin
       `nnc_error(get_full_name(), $sformatf("MISMATCH!!! SPI_FLASH_TRIM10_REG = %h, SOC_ALWAYS_ON_ANA_TRIM10=%h", top_test_cfg.expected_data[10], rd_data_reg[0]));
     end

`endif

    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    //#10000ns;
    `nnc_info("SOC_TEST", "soc_spi_unlock_trim_flash_test end now", UVM_LOW)

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
