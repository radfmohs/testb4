/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_spi_nvr_flash_test.sv                                                   
// Project	: Nanochap BAF4P1                                  		        
// Description	: Testcase soc_spi_nvr_flash_test                                             
// Designer	: shreeyal@nanochap.com                                                                 
// Date		: 28-05-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_spi_nvr_flash_test
`define TESTCFG soc_spi_nvr_flash_test_cfg

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // ===============================================
  // Adding your new varialbles in config test
  // -----------------------------------------------

  //rand logic [7:0] wr_data[256];
  rand logic [7:0] wr_data;
  rand int         no_of_bytes; 
  rand logic [7:0] reg_addr;
  rand logic [7:0] pads;
  rand logic [7:0] mask;
  rand logic [7:0] expected_data;
  logic [7:0]      rd_data;
  logic [7:0] rd_data_reg[];
  logic [7:0] flash_debug_status;

  // -----------------------------------------------
  // End of decalration of new variables 
  // ===============================================

  function new (string name = "soc_spi_nvr_flash_test_cfg");
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

  // do not config in base test pre reset phase 
  constraint c_config_in_base_test_en { soft config_in_base_test_en == 1'b0; }

  constraint c_disable_init_flash     { soft disable_init_flash == 1'b1; }

  //constraint c_pclk_sel               { soft pclk_sel inside {[0:0]};}

  //constraint c_spi_sclk_freq          { spi_sclk_freq == 1024;}

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
    uvm_top.set_timeout(35s);
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

    `DUT_IF.config_in_base_test_en = top_test_cfg.config_in_base_test_en;

    `DUT_IF.disable_init_flash = top_test_cfg.disable_init_flash;

    //`DUT_IF.pclk_sel = top_test_cfg.pclk_sel;
    // Set SCLK clock
    //`DUT_IF.spi_sclk_freq = top_test_cfg.spi_sclk_freq;
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

    `nnc_info("SOC_TEST", "soc_spi_nvr_flash_test start", UVM_LOW)

    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    
    // --------------------------------------------------------
    // This is an example RD_RESET_CHK_REG 
    // --------------------------------------------------------

   `nnc_info("SOC_TEST - PART I", "No Matching with Key", UVM_LOW)
    check_nvr1_flash(5'b10000, 256);

   `nnc_info("SOC_TEST - PART II", "Matching with Key", UVM_LOW)
   
    // Writiong to NVR1 - key_spi (0x100-0x1ff)
    check_nvr1_flash(`KEY_SPI, 256); 

    //**********************Prepare for TRIM area - key_trim ***********************

    top_test_cfg.flash_debug_status = 8'h00;
    `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.flash_debug_status);
    while (top_test_cfg.flash_debug_status[6] === 1) begin
      `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.flash_debug_status);
    end

    `WR_NORMAL_REG(`SOC_FLASH_TRIMDATA0, 'h5A, top_test_cfg.pads);

     assert(top_test_cfg.randomize() with {ext_clk_en==1;ext_clk_sel==3; hfosc_variation == 100;});
     `DUT_IF.ext_clk_en =top_test_cfg.ext_clk_en;
     `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel; //1MHz
     `DUT_IF.hfosc_fixed_gnd_en = top_test_cfg.hfosc_fixed_gnd_en;
     `DUT_IF.ext_hfosc_fixed_gnd_en = top_test_cfg.ext_hfosc_fixed_gnd_en;
     `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;
     #10us;

     // Enable SPI_WRITE
    top_test_cfg.flash_debug_status = 8'h00;
    `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.flash_debug_status);
    while (top_test_cfg.flash_debug_status[6] === 1) begin
      `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.flash_debug_status);
    end

    `WR_NORMAL_REG(`SOC_FLASH_UNLOCK, {`KEY_TRIM, 3'b001}, top_test_cfg.pads);

    // wait for to flash load complete
    top_test_cfg.rd_data = 8'h00;
    `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,top_test_cfg.rd_data);
    while (top_test_cfg.rd_data[0] === 1) begin
     `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,top_test_cfg.rd_data);
    end

    //**************************************************************************************

    check_imeas_filter_coeff_connectivity(`KEY_COEFFI);

    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    `nnc_info("SOC_TEST", "soc_spi_nvr_flash_test end now", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ==================================================================================

    phase.drop_objection(this);
  endtask: main_phase

  task check_nvr1_flash();
 
    input [4:0] spi_key; 
    input [8:0] no_of_address; 

    bit [7:0] wr_data;
    logic [7:0] rd_data;
    logic [7:0] addr;
    bit [7:0] wr_data_array[256];

    `nnc_info(get_full_name(), $sformatf(" ****** spi_key=%0b *******",spi_key),UVM_LOW);

    top_test_cfg.flash_debug_status = 8'h00;
    `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.flash_debug_status);
    while (top_test_cfg.flash_debug_status[6] === 1) begin
      `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.flash_debug_status);
    end

     assert(top_test_cfg.randomize() with {ext_clk_en==1;ext_clk_sel==3; hfosc_variation == 100;});
     `DUT_IF.ext_clk_en =top_test_cfg.ext_clk_en;
     `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel; //1MHz
     `DUT_IF.hfosc_fixed_gnd_en = top_test_cfg.hfosc_fixed_gnd_en;
     `DUT_IF.ext_hfosc_fixed_gnd_en = top_test_cfg.ext_hfosc_fixed_gnd_en;
     `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;
     #10us;

    `nnc_info(get_full_name(), $sformatf(" ****** Writing to nvr1 with external clock*******"),UVM_LOW);
    for(int i =0 ; i< no_of_address;i++)begin
      wr_data = $urandom_range(255,1);  //can not be 0
      wr_data_array[i] = wr_data;
      addr = i;

      // write addr
      `WR_NORMAL_REG(`SOC_FLASH_ADDR, addr, top_test_cfg.pads);
      // write data
      `WR_NORMAL_REG(`SOC_FLASH_DATA, wr_data, top_test_cfg.pads);
      // write unlock reg bit 0 
      `WR_NORMAL_REG(`SOC_FLASH_UNLOCK, {spi_key, 3'b001}, top_test_cfg.pads);

      // Wait for unlock bit to be deasserted
      top_test_cfg.rd_data = 8'h00;
      `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,top_test_cfg.rd_data);
      if (spi_key === 5'b01010) begin
        while (top_test_cfg.rd_data[0] === 1) begin
         `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,top_test_cfg.rd_data);
        end
      end
      else #10us;
    end

    `nnc_info(get_full_name(), $sformatf(" ****** reading to nvr1 with external clock*******"),UVM_LOW);
    for(int i =0 ; i< no_of_address;i++)begin
      addr = i;
     
      // write addr
      `WR_NORMAL_REG(`SOC_FLASH_ADDR, addr, top_test_cfg.pads); 
      // write unlock reg bit 2
      `WR_NORMAL_REG(`SOC_FLASH_UNLOCK, {spi_key, 3'b100}, top_test_cfg.pads);
      // wait for 1us, write bit 2 to 0
      #1us;
      `WR_NORMAL_REG(`SOC_FLASH_UNLOCK, {spi_key, 3'b000}, top_test_cfg.pads);
      // read data from reg and compare
      `RD_NORMAL_REG(`SOC_FLASH_EME_DATA, top_test_cfg.pads, rd_data);
      if (spi_key === 5'b01010) begin
        if(rd_data !== wr_data_array[i])begin
          `nnc_error(get_full_name(), $sformatf(" check_nvr1_flash in extrenal clock: WR AND RD VALUE SHOULD MATCH!!! i=%0h, addr=%0h, wr_data = %0h, rd_data=%0h", i,addr, wr_data_array[i], rd_data));
        end
      end else begin
        if(rd_data === wr_data_array[i])begin
          `nnc_error(get_full_name(), $sformatf(" check_nvr1_flash in extrenal clock: WR AND RD VALUE SHOULD NOT MATCH!!! i=%0h, addr=%0h, wr_data = %0h, rd_data=%0h", i,addr, wr_data_array[i], rd_data));
        end
      end
    end

    #5ms; 

    `DUT_IF.wake_up_en = 0;
    #1000;

    // changing to internal clock again
    assert(top_test_cfg.randomize() with {ext_clk_en==0; ext_clk_sel==2'b00;});
    `DUT_IF.ext_clk_en =top_test_cfg.ext_clk_en;
    `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel;
    `DUT_IF.hfosc_fixed_gnd_en = top_test_cfg.hfosc_fixed_gnd_en;
    `DUT_IF.ext_hfosc_fixed_gnd_en = top_test_cfg.ext_hfosc_fixed_gnd_en;
    `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;

    //`DUT_IF.wake_up_en = 0;
    #1000000
    //repeat(200) @(posedge `DUT_IF.sys_clk);

    $display ("\n Enter Active mode");
    `DUT_IF.wake_up_en = 1;

    wait(`RESETN);

    top_test_cfg.flash_debug_status = 8'h00;
    `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.flash_debug_status);
    while (top_test_cfg.flash_debug_status[6] === 1) begin
    `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.flash_debug_status);
    end

    `nnc_info(get_full_name(), $sformatf(" ****** reading to nvr1 with internal clock*******"),UVM_LOW);
    for(int i =0 ; i< no_of_address;i++)begin
      addr = i;
      // write addr
      `WR_NORMAL_REG(`SOC_FLASH_ADDR, addr, top_test_cfg.pads);

      // write unlock reg bit 2
      `WR_NORMAL_REG(`SOC_FLASH_UNLOCK, {spi_key, 3'b100}, top_test_cfg.pads);
      // wait for 1us, write bit 2 to 0
      #1us;
      `WR_NORMAL_REG(`SOC_FLASH_UNLOCK, {spi_key, 3'b000}, top_test_cfg.pads);
      // read data from reg and compare
      `RD_NORMAL_REG(`SOC_FLASH_EME_DATA, top_test_cfg.pads, rd_data);
      if (spi_key === 5'b01010) begin
        if(rd_data !== wr_data_array[i])begin
          `nnc_error(get_full_name(), $sformatf(" check_nvr1_flash in internal clock : WR AND RD VALUE SHOULD MATCH!!! i=%0h, addr=%0h, wr_data_array = %0h, rd_data=%0h", i,addr, wr_data_array[i], rd_data));
        end
      end else begin
        if(rd_data === wr_data_array[i])begin
          `nnc_error(get_full_name(), $sformatf(" check_nvr1_flash in internal clock : WR AND RD VALUE SHOULD NOT MATCH!!! i=%0h, addr=%0h, wr_data_array = %0h, rd_data=%0h", i,addr, wr_data_array[i], rd_data));
        end
      end
    end

  endtask : check_nvr1_flash

  task check_imeas_filter_coeff_connectivity(input [4:0] key_coeff);
    bit [7:0] addr;
 
    bit [7:0] wr_data;
    bit [7:0] rd_data;
    bit [15:0] temp_rd_data;
    logic [15:0] rd_data_reg[$];


    // **********************Prepare for coefficients - key cofficient ************************
    `nnc_info(get_full_name(), $sformatf(" ****** Writing to filter coeff with external clock*******"),UVM_LOW);
    for(int i = 0; i< 'h30;i++)begin
      wr_data = $urandom_range(255,1);  //can not be 0
      addr = i;
      `nnc_info(get_full_name(), $sformatf(" ****** wr_data=%0h , addr=%0h*******",wr_data,addr),UVM_DEBUG);

      // write addr
      `WR_NORMAL_REG(`SOC_FLASH_ADDR, addr, top_test_cfg.pads);
      // write data
      `WR_NORMAL_REG(`SOC_FLASH_DATA, wr_data, top_test_cfg.pads);
      // write unlock reg bit 0 
      `WR_NORMAL_REG(`SOC_FLASH_UNLOCK, {key_coeff, 3'b001}, top_test_cfg.pads);

      // Wait for unlock bit to be deasserted
      top_test_cfg.rd_data = 8'h00;
      `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,top_test_cfg.rd_data);
      if (key_coeff === `KEY_COEFFI) begin
        while (top_test_cfg.rd_data[0] === 1) begin
         `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,top_test_cfg.rd_data);
        end
      end
      else #10us;
    end

    `nnc_info(get_full_name(), $sformatf(" ****** Reading to filter coeff with external clock*******"),UVM_LOW);
    for(int i = 0; i< 'h30;i++)begin
      addr = i;
      // write addr
      `WR_NORMAL_REG(`SOC_FLASH_ADDR, addr, top_test_cfg.pads);

      // write unlock reg bit 2
      `WR_NORMAL_REG(`SOC_FLASH_UNLOCK, {key_coeff, 3'b100}, top_test_cfg.pads);
      // wait for 1us, write bit 2 to 0
      #1us;
      `WR_NORMAL_REG(`SOC_FLASH_UNLOCK, {key_coeff, 3'b000}, top_test_cfg.pads);
      // read data from reg and compare
      `RD_NORMAL_REG(`SOC_FLASH_EME_DATA, top_test_cfg.pads, rd_data);
	`nnc_info(get_full_name(), $sformatf(" ****** addr = %0h addr/2=%0d rd_data=%0h*******",addr,addr%2,rd_data),UVM_DEBUG);
      if(addr%2 === 0) temp_rd_data[8:0] = rd_data;
      if(addr%2 !== 0) begin
        temp_rd_data[15:8] = rd_data; 
        rd_data_reg.push_back(temp_rd_data);
	`nnc_info(get_full_name(), $sformatf(" ****** addr = %0h temp_rd_data=%0h *******",addr,temp_rd_data),UVM_DEBUG);
        temp_rd_data = 0;
      end
    end
    //**************************************************************************************************

    `nnc_info(get_full_name(), $sformatf(" ****** will check default values of coeff , before flash reload ******* "),UVM_LOW);
    if(`DUT_IF.scaleconst1 != `SCALECONST1) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , scaleconst1=%0h", `SCALECONST1, `DUT_IF.scaleconst1));
    end

`ifdef BEHAVIORAL
    if(`DUT_IF.coeff_b1_section1 != `COEF_B1_SESSION1) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b1_section1=%0h", `COEF_B1_SESSION1, `DUT_IF.coeff_b1_section1));
    end
`endif
    if(`DUT_IF.coeff_b2_section1 != `COEF_B2_SESSION1) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b2_section1=%0h", `COEF_B2_SESSION1, `DUT_IF.coeff_b2_section1));
    end

`ifdef BEHAVIORAL
    if(`DUT_IF.coeff_b3_section1 != `COEF_B3_SESSION1) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b3_section1=%0h", `COEF_B3_SESSION1, `DUT_IF.coeff_b3_section1));
    end
`endif

    if(`DUT_IF.coeff_a2_section1 != `COEF_A2_SESSION1) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a2_section1=%0h", `COEF_A2_SESSION1, `DUT_IF.coeff_a2_section1));
    end

    if(`DUT_IF.coeff_a3_section1 != `COEF_A3_SESSION1) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a3_section1=%0h", `COEF_A3_SESSION1, `DUT_IF.coeff_a3_section1));
    end

    if(`DUT_IF.scaleconst2 != `SCALECONST2) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , scaleconst2=%0h", `SCALECONST2, `DUT_IF.scaleconst2));
    end

`ifdef BEHAVIORAL
    if(`DUT_IF.coeff_b1_section2 != `COEF_B1_SESSION2) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b1_section2=%0h", `COEF_B1_SESSION2, `DUT_IF.coeff_b1_section2));
    end
`endif

    if(`DUT_IF.coeff_b2_section2 != `COEF_B2_SESSION2) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b2_section2=%0h", `COEF_B2_SESSION2, `DUT_IF.coeff_b2_section2));
    end

`ifdef BEHAVIORAL
    if(`DUT_IF.coeff_b3_section2 != `COEF_B3_SESSION2) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b3_section2=%0h", `COEF_B3_SESSION2, `DUT_IF.coeff_b3_section2));
    end
`endif

    if(`DUT_IF.coeff_a2_section2 != `COEF_A2_SESSION2) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a2_section2=%0h", `COEF_A2_SESSION2, `DUT_IF.coeff_a2_section2));
    end

    if(`DUT_IF.coeff_a3_section2 != `COEF_A3_SESSION2) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a3_section2=%0h", `COEF_A3_SESSION2, `DUT_IF.coeff_a3_section2));
    end
/*
    if(`DUT_IF.scaleconst3 != `SCALECONST3) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , scaleconst3=%0h", `SCALECONST3, `DUT_IF.scaleconst3));
    end

    if(`DUT_IF.coeff_b1_section3 != `COEF_B1_SESSION3) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b1_section3=%0h", `COEF_B1_SESSION3, `DUT_IF.coeff_b1_section3));
    end

    if(`DUT_IF.coeff_b2_section3 != `COEF_B2_SESSION3) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b2_section3=%0h", `COEF_B2_SESSION3, `DUT_IF.coeff_b2_section3));
    end

    if(`DUT_IF.coeff_b3_section3 != `COEF_B3_SESSION3) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b3_section3=%0h", `COEF_B3_SESSION3, `DUT_IF.coeff_b3_section3));
    end

    if(`DUT_IF.coeff_a2_section3 != `COEF_A2_SESSION3) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a2_section3=%0h", `COEF_A2_SESSION3, `DUT_IF.coeff_a2_section3));
    end

    if(`DUT_IF.coeff_a3_section3 != `COEF_A3_SESSION3) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a3_section3=%0h", `COEF_A3_SESSION3, `DUT_IF.coeff_a3_section3));
    end

    if(`DUT_IF.scaleconst4 != `SCALECONST4) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , scaleconst4=%0h", `SCALECONST4, `DUT_IF.scaleconst4));
    end

    if(`DUT_IF.coeff_b1_section4 != `COEF_B1_SESSION4) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b1_section4=%0h", `COEF_B1_SESSION4, `DUT_IF.coeff_b1_section4));
    end

    if(`DUT_IF.coeff_b2_section4 != `COEF_B2_SESSION4) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b2_section4=%0h", `COEF_B2_SESSION4, `DUT_IF.coeff_b2_section4));
    end

    if(`DUT_IF.coeff_b3_section4 != `COEF_B3_SESSION4) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b3_section4=%0h", `COEF_B3_SESSION4, `DUT_IF.coeff_b3_section4));
    end

    if(`DUT_IF.coeff_a2_section4 != `COEF_A2_SESSION4) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a2_section4=%0h", `COEF_A2_SESSION4, `DUT_IF.coeff_a2_section4));
    end

    if(`DUT_IF.coeff_a3_section4 != `COEF_A3_SESSION4) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a3_section4=%0h", `COEF_A3_SESSION4, `DUT_IF.coeff_a3_section4));
    end
*/
    //***************Enable reload by doing reset***********************************

    // changing to internal clock again
    assert(top_test_cfg.randomize() with {ext_clk_en==0;ext_clk_sel==2'b00;});
    `DUT_IF.ext_clk_en =top_test_cfg.ext_clk_en;
    `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel; //1MHz
    `DUT_IF.hfosc_fixed_gnd_en = top_test_cfg.hfosc_fixed_gnd_en;
    `DUT_IF.ext_hfosc_fixed_gnd_en = top_test_cfg.ext_hfosc_fixed_gnd_en;
    `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;

    $display ("\n Enter Low power mode");
    `DUT_IF.wake_up_en = 0;
    #1000000
    //repeat(200) @(posedge `DUT_IF.sys_clk);

    $display ("\n Enter Active mode");
    `DUT_IF.wake_up_en = 1;

    wait(`RESETN);

    top_test_cfg.flash_debug_status = 8'h00;
    `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.flash_debug_status);
    while (top_test_cfg.flash_debug_status[6] === 1) begin
      `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.flash_debug_status);
    end
    //*********************************************************************************

    // *************************** Checking cofficients on Filters **************************************************** 

    `nnc_info(get_full_name(), $sformatf(" ****** will check rd values of coeff , after flash relaod *******"),UVM_LOW);

    if(`DUT_IF.scaleconst1 != rd_data_reg[0]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , scaleconst1=%0h", rd_data_reg[0], `DUT_IF.scaleconst1));
    end

`ifdef BEHAVIORAL
    if(`DUT_IF.coeff_b1_section1 != rd_data_reg[1]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b1_section1=%0h", rd_data_reg[1], `DUT_IF.coeff_b1_section1));
    end
`endif

    if(`DUT_IF.coeff_b2_section1 != rd_data_reg[2]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b2_section1=%0h", rd_data_reg[2], `DUT_IF.coeff_b2_section1));
    end

`ifdef BEHAVIORAL
    if(`DUT_IF.coeff_b3_section1 != rd_data_reg[3]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b3_section1=%0h", rd_data_reg[3], `DUT_IF.coeff_b3_section1));
    end
`endif

    if(`DUT_IF.coeff_a2_section1 != rd_data_reg[4]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a2_section1=%0h", rd_data_reg[4], `DUT_IF.coeff_a2_section1));
    end

    if(`DUT_IF.coeff_a3_section1 != rd_data_reg[5]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a3_section1=%0h", rd_data_reg[5], `DUT_IF.coeff_a3_section1));
    end

    if(`DUT_IF.scaleconst2 != rd_data_reg[6]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , scaleconst2=%0h", rd_data_reg[6], `DUT_IF.scaleconst2));
    end

`ifdef BEHAVIORAL
    if(`DUT_IF.coeff_b1_section2 != rd_data_reg[7]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b1_section2=%0h", rd_data_reg[7], `DUT_IF.coeff_b1_section2));
    end
`endif

    if(`DUT_IF.coeff_b2_section2 != rd_data_reg[8]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b2_section2=%0h", rd_data_reg[8], `DUT_IF.coeff_b2_section2));
    end

`ifdef BEHAVIORAL
    if(`DUT_IF.coeff_b3_section2 != rd_data_reg[9]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b3_section2=%0h", rd_data_reg[9], `DUT_IF.coeff_b3_section2));
    end
`endif

    if(`DUT_IF.coeff_a2_section2 != rd_data_reg[10]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a2_section2=%0h", rd_data_reg[10], `DUT_IF.coeff_a2_section2));
    end

    if(`DUT_IF.coeff_a3_section2 != rd_data_reg[11]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a3_section2=%0h", rd_data_reg[11], `DUT_IF.coeff_a3_section2));
    end
/*
    if(`DUT_IF.scaleconst3 != rd_data_reg[12]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , scaleconst3=%0h", rd_data_reg[12], `DUT_IF.scaleconst3));
    end

    if(`DUT_IF.coeff_b1_section3 != rd_data_reg[13]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b1_section3=%0h", rd_data_reg[13], `DUT_IF.coeff_b1_section3));
    end

    if(`DUT_IF.coeff_b2_section3 != rd_data_reg[14]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b2_section3=%0h", rd_data_reg[14], `DUT_IF.coeff_b2_section3));
    end

    if(`DUT_IF.coeff_b3_section3 != rd_data_reg[15]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b3_section3=%0h", rd_data_reg[15], `DUT_IF.coeff_b3_section3));
    end

    if(`DUT_IF.coeff_a2_section3 != rd_data_reg[16]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a2_section3=%0h", rd_data_reg[16], `DUT_IF.coeff_a2_section3));
    end

    if(`DUT_IF.coeff_a3_section3 != rd_data_reg[17]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a3_section3=%0h", rd_data_reg[17], `DUT_IF.coeff_a3_section3));
    end

    if(`DUT_IF.scaleconst4 != rd_data_reg[18]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , scaleconst4=%0h", rd_data_reg[18], `DUT_IF.scaleconst4));
    end

    if(`DUT_IF.coeff_b1_section4 != rd_data_reg[19]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b1_section4=%0h", rd_data_reg[19], `DUT_IF.coeff_b1_section4));
    end

    if(`DUT_IF.coeff_b2_section4 != rd_data_reg[20]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b2_section4=%0h", rd_data_reg[20], `DUT_IF.coeff_b2_section4));
    end

    if(`DUT_IF.coeff_b3_section4 != rd_data_reg[21]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_b3_section4=%0h", rd_data_reg[21], `DUT_IF.coeff_b3_section4));
    end

    if(`DUT_IF.coeff_a2_section4 != rd_data_reg[22]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a2_section4=%0h", rd_data_reg[22], `DUT_IF.coeff_a2_section4));
    end

    if(`DUT_IF.coeff_a3_section4 != rd_data_reg[23]) begin
      `nnc_error(get_full_name(), $sformatf(" check_imeas_filter_coeff_connectivity MISMATCH : exp rd data=%0h , coeff_a3_section4=%0h", rd_data_reg[23], `DUT_IF.coeff_a3_section4));
    end
*/
    //*********************************************************************************
  endtask : check_imeas_filter_coeff_connectivity

  // ------------------------------
  // Declare the report_phase task
  // ------------------------------
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction

endclass : `TESTNAME
