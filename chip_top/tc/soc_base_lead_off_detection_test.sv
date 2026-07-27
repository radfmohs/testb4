/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_base_lead_off_detection_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_base_lead_off_detection_test                                             
// Designer	: shreeyal@nanochap.com                                                                 
// Date		: 01-07-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_base_lead_off_detection_test
`define TESTCFG soc_base_lead_off_detection_test_cfg

`define AC_DC_BOTH_DISABLE   2'b00
`define DC_ENABLE            2'b01
`define AC_ENABLE            2'b10
`define AC_DC_BOTH_ENABLE    2'b11

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // ===============================================
  // Adding your new varialbles in config test
  // -----------------------------------------------

  rand logic [7:0] wr_data[256];
  rand int         no_of_bytes; 
  rand logic [7:0] pads;
  rand logic [7:0] mask;
  rand logic [7:0] expected_data;
  logic [7:0]      rd_data[];
  logic [1:0] check_step = 0;
  uvm_event enable_check;
  bit test_end;

  rand logic [1:0] en_ac_dc_lead_off;
  // -----------------------------------------------
  // End of decalration of new variables 
  // ===============================================

  function new (string name = "soc_base_lead_off_detection_test_cfg");
    super.new(name);
    enable_check = new();
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

  constraint c_en_ac_dc_lead_off        { soft en_ac_dc_lead_off inside {[0:3]}; } // 0:disable, 1:DC enable, 2:AC enable, 3:AC and DC both enable
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
    logic [7:0] wr_data;
    logic [7:0] reg_addr;
    logic [7:0] rd_data;
    logic [7:0] wr_data_leadoff_tgt_low;
    logic [7:0] wr_data_leadoff_tgt_high;
    bit both_n_p = 0;
    bit only_n = 0;
    bit only_p = 0;
    bit disable_intr = 0;

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
    uvm_top.set_timeout(4s);
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

    // make sure to enable both lead off for disable intr check case
    if(disable_intr) top_test_cfg.en_ac_dc_lead_off = 2'b11;
   
    `DUT_IF.en_ac_dc_lead_off = top_test_cfg.en_ac_dc_lead_off;
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

    `nnc_info("SOC_TEST", "soc_base_lead_off_detection_test start", UVM_LOW)
    `nnc_info(get_full_name(), $sformatf(" en_ac_dc_lead_off=%0d",top_test_cfg.en_ac_dc_lead_off),UVM_LOW);

    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    //#10000ns;
    `nnc_info("SOC_TEST", "soc_base_lead_off_detection_test end now", UVM_LOW)

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

  task config_leadoff_regs();
    `nnc_info("SOC_TEST", "soc_lead_off_detect_test start", UVM_LOW)
    `nnc_info(get_full_name(), $sformatf(" en_ac_dc_lead_off=%0d",top_test_cfg.en_ac_dc_lead_off),UVM_LOW);
    `nnc_info(get_full_name(), $sformatf(" both_n_p=%0d, only_n=%0d, only_p=%0d, disable_intr=%0d ",both_n_p,only_n,only_p,disable_intr),UVM_LOW);
  
    // ==================================================================================
    // Please add your code of your test here
    // ----------------------------------------------------------------------------------
  
    // --------------------------------------------------------
    // Write to SOC_IMEAS_EN
    // --------------------------------------------------------
    reg_addr = `SOC_IMEAS_EN; 
    wr_data = 8'h01; // enable IMEAS
    `WR_NORMAL_REG(reg_addr, wr_data, top_test_cfg.pads);
  
    // --------------------------------------------------------
    // Write to SOC_LEADOFF_CLK_REG
    // bit[2]: SDM CLK sent to ext GPIO: 0: imeas_adc_clk. 1: !imeas_adc_clk
    // bit[1:0] - 0: 128K, 1: 64K(default), 2: 32K, 3: 16K
    // --------------------------------------------------------
    reg_addr = `SOC_LEADOFF_CLK_REG; 
    wr_data  = 8'h01;
    `WR_NORMAL_REG(reg_addr, wr_data, top_test_cfg.pads);
  
    // --------------------------------------------------------
    // Write to SOC_LEADOFF_CTRL 
    // bit[3]: leadoff interrupt enable 0: (default)
    // bit[2]: leadoff detection enable 0: (default)
    // bit[1:0]: leadoff type selector 0(default),3: N&P, 1: N, 2P
    // --------------------------------------------------------
    reg_addr = `SOC_LEADOFF_CTRL; 
    if(both_n_p) wr_data = 8'h0C; 
    else if(only_n) wr_data = 8'h0D;
    else if(only_p) wr_data = 8'h0E;
    else if(disable_intr) wr_data = 8'h04;
    else wr_data = 8'h08; // leadoff_detection_en is OFF
    `WR_NORMAL_REG(reg_addr, wr_data, top_test_cfg.pads);
  
    // --------------------------------------------------------
    // Write to SOC_LEADOFF_TGT_0 - low-byte threshold 0xFF (default)
    // --------------------------------------------------------
    reg_addr = `SOC_LEADOFF_TGT_0; 
    wr_data = 8'h10;
    wr_data_leadoff_tgt_low = wr_data;
    `WR_NORMAL_REG(reg_addr, wr_data, top_test_cfg.pads);
  
    // --------------------------------------------------------
    // Write to SOC_LEADOFF_TGT_1 - high-byte threshold 0x00 (default)
    // --------------------------------------------------------
    reg_addr = `SOC_LEADOFF_TGT_1; 
    //wr_data  = 8'h00;
    wr_data  = $urandom_range(8'h01,8'h0);
    wr_data_leadoff_tgt_high = wr_data;
    `WR_NORMAL_REG(reg_addr, wr_data, top_test_cfg.pads);
  
    // --------------------------------------------------------
    // Write to SOC_LEADOFF_SWITCH_TGT 0x3F (Default)
    // --------------------------------------------------------
    reg_addr = `SOC_LEADOFF_SWITCH_TGT; 
    wr_data = 8'h2F;
    `WR_NORMAL_REG(reg_addr, wr_data, top_test_cfg.pads);
  
    // --------------------------------------------------------
    // Write to SOC_ANA_LEAD_OFF_EN
    // --------------------------------------------------------
    reg_addr = `SOC_ANA_LEAD_OFF_EN; 
    wr_data = top_test_cfg.en_ac_dc_lead_off; 
    `WR_NORMAL_REG(reg_addr, wr_data, top_test_cfg.pads);
  
    // --------------------------------------------------------
    // --------------------------------------------------------
    // Write to `SOC_CLK_CTRL_REG to set spi_write_ao
    // --------------------------------------------------------
    reg_addr = `SOC_CLK_CTRL_REG;
    `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
       
    wr_data = 8'h80 | rd_data; // release reset lead off detection
    `WR_NORMAL_REG(reg_addr, wr_data, top_test_cfg.pads); 
  
  endtask : config_leadoff_regs

  task do_run_for_ac_dc_both_disable;
 
      config_leadoff_regs();
 
      top_test_cfg.enable_check.trigger();
      `LEAD_OFF_SCB_EN = 1;
  
      // ====================================  
      // Stimulus of test 1 is done
      // ==================================== 
  
  	// --------------------------------------------------------
      	// Write to SOC_IMEAS_STATUS 
          // [7:6]: 2'b0
          // 5: int_sts_switch
          // 4: int_sts_duration
          // 3: reg_imeas_bio_int_sts
          // 2: reg_imeas_int_sts1
          // 1: reg_imeas_int_sts0
          // 0: reg_imeas_int_sts
      	// --------------------------------------------------------
  
          wait(`IMEAS_TOP.A2D_LOFF_STATN === 1'b0);
  
     	reg_addr = `SOC_IMEAS_STATUS; 
          `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
          if (rd_data[4] === 1) begin
  	   `nnc_error(get_full_name(), $sformatf("ERROR for STATP unexpected duration status is asserted that is"));
          end
  
          // Reading for checking to clear
          reg_addr = `SOC_DEVICE_INT_STATUS_0;
          `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
          if (rd_data[5] === 1) begin
  	   `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading duration status in SOC_DEVICE_INT_STATUS_0"));
          end
  
      `nnc_info(get_full_name(), $sformatf("[TEST 1] Duration Interrupt for STATN is DONE"),UVM_LOW);
      // ==================================== 
      // Stimulus of test 1 is done
      // ==================================== 
  
  	// --------------------------------------------------------
      	// Write to SOC_IMEAS_STATUS 
          // [7:6]: 2'b0
          // 5: int_sts_switch
          // 4: int_sts_duration
          // 3: reg_imeas_bio_int_sts
          // 2: reg_imeas_int_sts1
          // 1: reg_imeas_int_sts0
          // 0: reg_imeas_int_sts
      	// --------------------------------------------------------
  
          wait(`DUT_IF.LEAD_OFF_STATP === 1'b0);
  
     	reg_addr = `SOC_IMEAS_STATUS; 
          `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
          if (rd_data[4] === 1) begin
  	   `nnc_error(get_full_name(), $sformatf("ERROR for STATP unexpected duration status is asserted that is"));
          end
  
          // Reading for checking to clear
          reg_addr = `SOC_DEVICE_INT_STATUS_0;
          `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
          if (rd_data[5] === 1) begin
  	   `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading duration status in SOC_DEVICE_INT_STATUS_0"));
          end
  
      `nnc_info(get_full_name(), $sformatf("[TEST 2] Duration Interrupt for STATP is DONE"),UVM_LOW);
      // ==================================== 
      // Stimulus of test 2 is done
      // ==================================== 
  
  	// --------------------------------------------------------
      	// Write to SOC_IMEAS_STATUS 
          // [7:6]: 2'b0
          // 5: int_sts_switch
          // 4: int_sts_duration
          // 3: reg_imeas_bio_int_sts
          // 2: reg_imeas_int_sts1
          // 1: reg_imeas_int_sts0
          // 0: reg_imeas_int_sts
      	// --------------------------------------------------------
  
          wait(top_test_cfg.check_step === 2'b01);
  
     	reg_addr = `SOC_IMEAS_STATUS; 
          `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
          if (rd_data[5] === 1) begin
  	   `nnc_error(get_full_name(), $sformatf("ERROR for STATP unexpected switch status is asserted that is"));
          end
  
          // Reading for checking to clear
          reg_addr = `SOC_DEVICE_INT_STATUS_0;
          `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
          if (rd_data[6] === 1) begin
  	   `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading switch status in SOC_DEVICE_INT_STATUS_0"));
          end
  
      `nnc_info(get_full_name(), $sformatf("[TEST 3] Duration Interrupt for STATP is DONE"),UVM_LOW);
      // ==================================== 
      // Stimulus of test 3 is done
      // ==================================== 
  
  	// --------------------------------------------------------
      	// Write to SOC_IMEAS_STATUS 
          // [7:6]: 2'b0
          // 5: int_sts_switch
          // 4: int_sts_duration
          // 3: reg_imeas_bio_int_sts
          // 2: reg_imeas_int_sts1
          // 1: reg_imeas_int_sts0
          // 0: reg_imeas_int_sts
      	// --------------------------------------------------------
  
          wait(top_test_cfg.check_step === 2'b10);
  
     	reg_addr = `SOC_IMEAS_STATUS; 
          `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
          if (rd_data[5] === 1) begin
  	   `nnc_error(get_full_name(), $sformatf("ERROR for STATP unexpected switch status is asserted that is "));
          end
  
          // Reading for checking to clear
          reg_addr = `SOC_DEVICE_INT_STATUS_0;
          `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
          if (rd_data[6] === 1) begin
  	   `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading switch status in SOC_DEVICE_INT_STATUS_0"));
          end
  
      `nnc_info(get_full_name(), $sformatf("[TEST 4] Duration Interrupt for STATP is DONE"),UVM_LOW);
      // ==================================== 
      // Stimulus of test 3 is done
      // ==================================== 
  endtask : do_run_for_ac_dc_both_disable

  task drive_A2D_LOFF_STATN_STATP_for_disable();

    lead_off_init ();
    top_test_cfg.enable_check.wait_trigger();

    // ===============================================
    // This is Leadoff DURATION Interrupt test
    // ===============================================
    // Test 1
    test_1();

    // Test 2
    test_2();

    // ===============================================
    // This is Leadoff SWITCH Interrupt test
    // ===============================================
    // Test 1
    test_3();
    top_test_cfg.check_step = 1;

    // Test 2
    test_4();
    top_test_cfg.check_step = 2;

    `LEAD_OFF_SCB_EN = 0;
  endtask : drive_A2D_LOFF_STATN_STATP_for_disable

  task do_run_for_disable_intr;
    logic [7:0] wr_data;
    logic [7:0] reg_addr;
    logic [7:0] rd_data;
  
    `nnc_info("SOC_TEST", "soc_lead_off_detect_test start", UVM_LOW)
    `nnc_info(get_full_name(), $sformatf(" en_ac_dc_lead_off=%0d",top_test_cfg.en_ac_dc_lead_off),UVM_LOW);
  
    config_leadoff_regs();

    top_test_cfg.enable_check.trigger();
    `LEAD_OFF_SCB_EN = 1;
  
    // ====================================  
    // Stimulus of test 1 is done
    // ==================================== 
    //wait(test_no==2'b01);
  
      // --------------------------------------------------------
    	// Write to SOC_IMEAS_STATUS 
        // [7:6]: 2'b0
        // 5: int_sts_switch
        // 4: int_sts_duration
        // 3: reg_imeas_bio_int_sts
        // 2: reg_imeas_int_sts1
        // 1: reg_imeas_int_sts0
        // 0: reg_imeas_int_sts
    	// --------------------------------------------------------
      reg_addr = `SOC_IMEAS_STATUS; 
        wr_data  = 8'h10; //make sure clear bit is cleared first
  
    	//@(posedge `SOC_TB.INTB);
  
        `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        while (rd_data[4] !== 1) begin
           `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        end
  
        // Reading for checking to clear
        reg_addr = `SOC_DEVICE_INT_STATUS_0;
        `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        if (rd_data[5] !== 1) begin
	   `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading duration status in SOC_DEVICE_INT_STATUS_0"));
        end
       
        #10000ns;
        if (`SOC_TB.INTB === 1'b1) begin
	  `nnc_error(get_full_name(), $sformatf("ERROR is happened when INTB is ouputted unexpectedly"));
        end
  
      // `nnc_info("SOC_TEST", "An interrupt happenned ...", UVM_LOW)
      // --------------------------------------------------------
    	// Write to SOC_IMEAS_STATUS
    	// --------------------------------------------------------
      reg_addr = `SOC_IMEAS_STATUS; 
        wr_data = 8'h01; // release reset lead off detection
        `WR_NORMAL_REG(reg_addr, wr_data, top_test_cfg.pads);
  
        // Reading for checking to clear
        `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        if (rd_data[4] !== 0) begin
	   `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading duration status"));
        end
    
    //$display("[TEST 1] Duration Interrupt for STATP is DONE");  
    `nnc_info(get_full_name(), $sformatf("[TEST 1] Duration Interrupt for STATP is DONE"),UVM_LOW);
    // ==================================== 
    // Stimulus of test 1 is done
    // ==================================== 
    //wait(test_no==2'b10);
  
      // --------------------------------------------------------
    	// Write to SOC_IMEAS_STATUS 
        // [7:6]: 2'b0
        // 5: int_sts_switch
        // 4: int_sts_duration
        // 3: reg_imeas_bio_int_sts
        // 2: reg_imeas_int_sts1
        // 1: reg_imeas_int_sts0
        // 0: reg_imeas_int_sts
    	// --------------------------------------------------------
      reg_addr = `SOC_IMEAS_STATUS; 
        wr_data  = 8'h10; //make sure clear bit is cleared first
  
    	//@(posedge `SOC_TB.INTB);
  
        `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        while (rd_data[4] !== 1) begin
           `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        end
  
        // Reading for checking to clear
        reg_addr = `SOC_DEVICE_INT_STATUS_0;
        `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        if (rd_data[5] !== 1) begin
	   `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading duration status in SOC_DEVICE_INT_STATUS_0"));
        end
       
        #10000ns;
        if (`SOC_TB.INTB === 1'b1) begin
	  `nnc_error(get_full_name(), $sformatf("ERROR is happened when INTB is ouputted unexpectedly"));
        end
  
      // `nnc_info("SOC_TEST", "An interrupt happenned ...", UVM_LOW)
      // --------------------------------------------------------
    	// Write to SOC_IMEAS_STATUS
    	// --------------------------------------------------------
      reg_addr = `SOC_IMEAS_STATUS; 
        wr_data = 8'h01; // release reset lead off detection
        `WR_NORMAL_REG(reg_addr, wr_data, top_test_cfg.pads);
  
        // Reading for checking to clear
        `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        if (rd_data[4] !== 0) begin
	   `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading duration status"));
        end
  
    //$display("[TEST 2] Duration Interrupt for STATP is DONE"); 
    `nnc_info(get_full_name(), $sformatf("[TEST 2] Duration Interrupt for STATP is DONE"),UVM_LOW);
    // ==================================== 
    // Stimulus of test 2 is done
    // ==================================== 
  
    //wait(test_no==2'b10);
  
      // --------------------------------------------------------
    	// Write to SOC_IMEAS_STATUS 
        // [7:6]: 2'b0
        // 5: int_sts_switch
        // 4: int_sts_duration
        // 3: reg_imeas_bio_int_sts
        // 2: reg_imeas_int_sts1
        // 1: reg_imeas_int_sts0
        // 0: reg_imeas_int_sts
    	// --------------------------------------------------------
      reg_addr = `SOC_IMEAS_STATUS; 
        wr_data  = 8'h10; //make sure clear bit is cleared first
  
    	//@(posedge `SOC_TB.INTB);
  
        `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        while (rd_data[5] !== 1) begin
           `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        end
  
        // Reading for checking to clear
        reg_addr = `SOC_DEVICE_INT_STATUS_0;
        `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        if (rd_data[6] !== 1) begin
	   `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading switch status in SOC_DEVICE_INT_STATUS_0"));
        end
       
        #10000ns;
        if (`SOC_TB.INTB === 1'b1) begin
	  `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading switch status in SOC_DEVICE_INT_STATUS_0"));
        end
      // `nnc_info("SOC_TEST", "An interrupt happenned ...", UVM_LOW)
      // --------------------------------------------------------
    	// Write to SOC_IMEAS_STATUS
    	// --------------------------------------------------------
      reg_addr = `SOC_IMEAS_STATUS; 
        wr_data = 8'h01; // release reset lead off detection
        `WR_NORMAL_REG(reg_addr, wr_data, top_test_cfg.pads);
  
        // Reading for checking to clear
        `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        if (rd_data[5] !== 0) begin
	   `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading switch status"));
        end
  
    //$display("[TEST 3] Switch Interrupt for STATN is DONE"); 
    `nnc_info(get_full_name(), $sformatf("[TEST 3] Duration Interrupt for STATP is DONE"),UVM_LOW);
    // ==================================== 
    // Stimulus of test 3 is done
    // ==================================== 
  
    //wait(test_no==2'b10);
  
      // --------------------------------------------------------
    	// Write to SOC_IMEAS_STATUS 
        // [7:6]: 2'b0
        // 5: int_sts_switch
        // 4: int_sts_duration
        // 3: reg_imeas_bio_int_sts
        // 2: reg_imeas_int_sts1
        // 1: reg_imeas_int_sts0
        // 0: reg_imeas_int_sts
    	// --------------------------------------------------------
      reg_addr = `SOC_IMEAS_STATUS; 
        wr_data  = 8'h10; //make sure clear bit is cleared first
  
    	//@(posedge `SOC_TB.INTB);
  
        `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        while (rd_data[5] !== 1) begin
           `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        end
  
        // Reading for checking to clear
        reg_addr = `SOC_DEVICE_INT_STATUS_0;
        `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        if (rd_data[6] !== 1) begin
	   `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading switch status in SOC_DEVICE_INT_STATUS_0"));
        end
       
        #10000ns;
        if (`SOC_TB.INTB === 1'b1) begin
	   `nnc_error(get_full_name(), $sformatf("ERROR is happened when INTB is ouputted unexpectedly"));
        end
  
      // `nnc_info("SOC_TEST", "An interrupt happenned ...", UVM_LOW)
      // --------------------------------------------------------
    	// Write to SOC_IMEAS_STATUS
    	// --------------------------------------------------------
      reg_addr = `SOC_IMEAS_STATUS; 
        wr_data = 8'h01; // release reset lead off detection
        `WR_NORMAL_REG(reg_addr, wr_data, top_test_cfg.pads);
  
        // Reading for checking to clear
        `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
        if (rd_data[5] !== 0) begin
	   `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading switch status"));
        end
  
    //$display("[TEST 4] Switch Interrupt for STATP is DONE"); 
    `nnc_info(get_full_name(), $sformatf("[TEST 4] Duration Interrupt for STATP is DONE"),UVM_LOW);
    // ==================================== 
    // Stimulus of test 3 is done
    // ==================================== 
  endtask : do_run_for_disable_intr
 
  task test_1();
    `nnc_info(get_full_name(), $sformatf("[TEST 1] starting"),UVM_LOW);
    #7.8125ms; // 64 Hz
    if(top_test_cfg.en_ac_dc_lead_off !== `AC_ENABLE)begin //DC or AC-DC both enable
      if(both_n_p || only_n)begin
        fork
          get_and_clear_lead_off_duration_int();
        join_none
      end
      if(only_p)begin
        fork
          check_no_duration_intr();
        join_none
      end
      `DUT_IF.LEAD_OFF_STATN = 1'b1;
      //if(wr_data_leadoff_tgt_high != 8'h0)#400ms; else #20ms;
      if(wr_data_leadoff_tgt_high != 8'h0) #(({wr_data_leadoff_tgt_high,wr_data_leadoff_tgt_low} + 6)*1.5*1000000);
      else #(({wr_data_leadoff_tgt_high,wr_data_leadoff_tgt_low} + 6)*1000000);
      `DUT_IF.LEAD_OFF_STATN = 1'b0;
    end
    #7.8125ms; // 64 Hz
    if(top_test_cfg.en_ac_dc_lead_off !== `DC_ENABLE)begin //AC or AC-DC both enable
      if(both_n_p || only_n)begin
        fork
	  get_and_clear_lead_off_duration_int();
        join_none
      end

      `DUT_IF.LEAD_AC_OFF_STATN = 1'b1;
      //#20ms;
      //if(wr_data_leadoff_tgt_high != 8'h0) #400ms; else #20ms;
      if(wr_data_leadoff_tgt_high != 8'h0) #(({wr_data_leadoff_tgt_high,wr_data_leadoff_tgt_low} + 6)*1.5*1000000);
      else #(({wr_data_leadoff_tgt_high,wr_data_leadoff_tgt_low} + 6)*1000000);
      `DUT_IF.LEAD_AC_OFF_STATN = 1'b0;
    end
    `nnc_info(get_full_name(), $sformatf("[TEST 1] Duration Interrupt for STATN is DONE"),UVM_LOW);
  endtask :test_1

  task test_2();
    `nnc_info(get_full_name(), $sformatf("[TEST 2] starting"),UVM_LOW);
    #7.8125ms; // 64 Hz
    if(top_test_cfg.en_ac_dc_lead_off !== `AC_ENABLE)begin //DC or AC-DC both enable
      if(both_n_p || only_p)begin
        fork
          get_and_clear_lead_off_duration_int();
        join_none
      end
      if(only_n)begin
        fork
          check_no_duration_intr();
        join_none
      end
      `DUT_IF.LEAD_OFF_STATP = 1'b1;
      //#20ms;
      //if(wr_data_leadoff_tgt_high != 8'h0) #400ms; else #20ms;
      if(wr_data_leadoff_tgt_high != 8'h0) #(({wr_data_leadoff_tgt_high,wr_data_leadoff_tgt_low} + 6)*1.5*1000000);
      else #(({wr_data_leadoff_tgt_high,wr_data_leadoff_tgt_low} + 6)*1000000);
      `DUT_IF.LEAD_OFF_STATP = 1'b0;
    end
    #7.8125ms; // 64 Hz
    if(top_test_cfg.en_ac_dc_lead_off !== `DC_ENABLE)begin //AC or AC-DC both enable
      if(both_n_p || only_p)begin
        fork
	  get_and_clear_lead_off_duration_int();
        join_none
      end

      `DUT_IF.LEAD_AC_OFF_STATP = 1'b1;
      //#20ms;
      //if(wr_data_leadoff_tgt_high != 8'h0) #400ms; else #20ms;
      if(wr_data_leadoff_tgt_high != 8'h0) #(({wr_data_leadoff_tgt_high,wr_data_leadoff_tgt_low} + 6)*1.5*1000000);
      else #(({wr_data_leadoff_tgt_high,wr_data_leadoff_tgt_low} + 6)*1000000);
      `DUT_IF.LEAD_AC_OFF_STATP = 1'b0;
    end
    `nnc_info(get_full_name(), $sformatf("[TEST 2] Duration Interrupt for STATP is DONE"),UVM_LOW);

  endtask :test_2

  task test_3();
    `nnc_info(get_full_name(), $sformatf("[TEST 3] starting"),UVM_LOW);
    if(top_test_cfg.en_ac_dc_lead_off !== `AC_ENABLE && (both_n_p || only_n))begin
      fork
        get_and_clear_lead_off_switch_int();
      join_none
    end
    if(top_test_cfg.en_ac_dc_lead_off !== `AC_ENABLE && only_p)begin
      fork
        check_no_switch_intr();
      join_none
    end
    repeat (60) begin
      #1ms; // 64 Hz
      if(top_test_cfg.en_ac_dc_lead_off !== `AC_ENABLE)begin //DC or AC-DC both enable
        `DUT_IF.LEAD_OFF_STATN = 1'b1;
        #1ms;
        `DUT_IF.LEAD_OFF_STATN = 1'b0;
      end
    end
    if(top_test_cfg.en_ac_dc_lead_off !== `DC_ENABLE && (both_n_p || only_n))begin
      fork
        get_and_clear_lead_off_switch_int();
      join_none
    end
    repeat (60) begin
      #1ms; // 64 Hz
      if(top_test_cfg.en_ac_dc_lead_off !== `DC_ENABLE)begin //AC or AC-DC both enable
        `DUT_IF.LEAD_AC_OFF_STATN = 1'b1;
        #1ms;
        `DUT_IF.LEAD_AC_OFF_STATN = 1'b0;
      end
    end

    `nnc_info(get_full_name(), $sformatf("[TEST 3] Switch Interrupt for STATN is DONE"),UVM_LOW);
  endtask :test_3

  task test_4();
    `nnc_info(get_full_name(), $sformatf("[TEST 4] starting"),UVM_LOW);
    if(top_test_cfg.en_ac_dc_lead_off !== `AC_ENABLE && (both_n_p || only_p))begin
      fork
        get_and_clear_lead_off_switch_int();
      join_none
    end
    if(top_test_cfg.en_ac_dc_lead_off !== `AC_ENABLE && only_n)begin
      fork
        check_no_switch_intr();
      join_none
    end
    repeat (60) begin
      #1ms; // 64 Hz
      if(top_test_cfg.en_ac_dc_lead_off !== `AC_ENABLE)begin //DC or AC-DC both enable
        `DUT_IF.LEAD_OFF_STATP = 1'b1;
        #1ms;
        `DUT_IF.LEAD_OFF_STATP = 1'b0;
      end
    end
    if(top_test_cfg.en_ac_dc_lead_off !== `DC_ENABLE && (both_n_p || only_p))begin
      fork
        get_and_clear_lead_off_switch_int();
      join_none
    end
    repeat (60) begin
      #1ms; // 64 Hz
      if(top_test_cfg.en_ac_dc_lead_off !== `DC_ENABLE)begin //AC or AC-DC both enable
        `DUT_IF.LEAD_AC_OFF_STATP = 1'b1;
        #1ms;
        `DUT_IF.LEAD_AC_OFF_STATP = 1'b0;
      end
    end

    `nnc_info(get_full_name(), $sformatf("[TEST 4] Switch Interrupt for STATP is DONE"),UVM_LOW);
  endtask :test_4

  task lead_off_init();
    if(top_test_cfg.en_ac_dc_lead_off !== `AC_ENABLE)begin //DC or AC-DC both enable
      `DUT_IF.LEAD_OFF_STATN = 1'b0;
      `DUT_IF.LEAD_OFF_STATP = 1'b0;
    end
    if(top_test_cfg.en_ac_dc_lead_off !== `DC_ENABLE)begin //AC or AC-DC both enable
      `DUT_IF.LEAD_AC_OFF_STATN = 1'b0;
      `DUT_IF.LEAD_AC_OFF_STATP = 1'b0;
    end
    `nnc_info(get_full_name(), $sformatf("lead_off_init is done "),UVM_LOW);
  endtask :lead_off_init

  task get_and_clear_lead_off_duration_int();
    `nnc_info(get_full_name(), $sformatf(" wait for lead off duration intr inside get_and_clear_lead_off_duration_int task"),UVM_LOW);
    @(posedge `SOC_TB.INTB);
  
    reg_addr = `SOC_IMEAS_STATUS; 
    `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
    if (rd_data[4] !== 1) begin
       `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading duration status"));
    end

   // Reading for checking to clear
   reg_addr = `SOC_DEVICE_INT_STATUS_0;
   `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
   if (rd_data[5] !== 1) begin
      `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading duration status in SOC_DEVICE_INT_STATUS_0"));
   end

   // `nnc_info("SOC_TEST", "An interrupt happenned ...", UVM_LOW)
   // --------------------------------------------------------
   // Write to SOC_IMEAS_STATUS
   // --------------------------------------------------------
    reg_addr = `SOC_IMEAS_STATUS;
    wr_data = 8'h01; // release reset lead off detection
    `WR_NORMAL_REG(reg_addr, wr_data, top_test_cfg.pads);
  
    // Reading for checking to clear
    `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
    if (rd_data[4] !== 0) begin
       `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading duration status"));
    end
    
    ////`nnc_info(get_full_name(), $sformatf("[TEST 1] Duration Interrupt for STATP is DONE"),UVM_LOW);
    `nnc_info(get_full_name(), $sformatf(" wait done for lead off duration intr inside get_and_clear_lead_off_duration_int task"),UVM_LOW);
  endtask : get_and_clear_lead_off_duration_int

  task get_and_clear_lead_off_switch_int();
    `nnc_info(get_full_name(), $sformatf(" wait for lead off switch intr inside get_and_clear_lead_off_switch_int task"),UVM_LOW);
    @(posedge `SOC_TB.INTB);
  
    reg_addr = `SOC_IMEAS_STATUS; 
    `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
    if (rd_data[5] !== 1) begin
       `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading switch status"));
    end

    // Reading for checking to clear
    reg_addr = `SOC_DEVICE_INT_STATUS_0;
    `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
    if (rd_data[6] !== 1) begin
       `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading switch status in SOC_DEVICE_INT_STATUS_0"));
    end

    // `nnc_info("SOC_TEST", "An interrupt happenned ...", UVM_LOW)
    // --------------------------------------------------------
    // Write to SOC_IMEAS_STATUS
    // --------------------------------------------------------
    reg_addr = `SOC_IMEAS_STATUS;
    wr_data = 8'h01; // release reset lead off detection
    `WR_NORMAL_REG(reg_addr, wr_data, top_test_cfg.pads);
  
    // Reading for checking to clear
    `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
    if (rd_data[5] !== 0) begin
       `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading switch status"));
    end
  
    //`nnc_info(get_full_name(), $sformatf("[TEST 3] Duration Interrupt for STATP is DONE"),UVM_LOW);
    `nnc_info(get_full_name(), $sformatf(" wait done for lead off switch intr inside get_and_clear_lead_off_switch_int task"),UVM_LOW);
  endtask : get_and_clear_lead_off_switch_int

  task check_no_duration_intr();
    `nnc_info(get_full_name(), $sformatf(" wait inside check_no_duration_intr task"),UVM_LOW);
    wait(`DUT_IF.LEAD_OFF_STATN === 1'b0);

    reg_addr = `SOC_IMEAS_STATUS; 
    `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
    if (rd_data[4] === 1) begin
       `nnc_error(get_full_name(), $sformatf("ERROR for STATN unexpected duration status is asserted that is "));
    end

    // Reading for checking to clear
    reg_addr = `SOC_DEVICE_INT_STATUS_0;
    `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
    if (rd_data[5] === 1) begin
       `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading duration status in SOC_DEVICE_INT_STATUS_0"));
    end
    `nnc_info(get_full_name(), $sformatf(" wait done inside check_no_duration_intr task"),UVM_LOW);

  endtask : check_no_duration_intr

  task check_no_switch_intr();
    `nnc_info(get_full_name(), $sformatf(" wait inside check_no_switch_intr task"),UVM_LOW);
    wait(top_test_cfg.check_step === 2'b01);

    reg_addr = `SOC_IMEAS_STATUS; 
    `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
    if (rd_data[5] === 1) begin
       `nnc_error(get_full_name(), $sformatf("ERROR for STATN unexpected switch status is asserted that is "));
    end

    // Reading for checking to clear
    reg_addr = `SOC_DEVICE_INT_STATUS_0;
    `RD_NORMAL_REG(reg_addr, top_test_cfg.pads, rd_data);
    if (rd_data[6] === 1) begin
       `nnc_error(get_full_name(), $sformatf("ERROR is happened when reading switch status in SOC_DEVICE_INT_STATUS_0"));
    end
    `nnc_info(get_full_name(), $sformatf(" wait done inside check_no_switch_intr task"),UVM_LOW);
  endtask : check_no_switch_intr

endclass : `TESTNAME

