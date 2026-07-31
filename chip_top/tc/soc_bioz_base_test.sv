/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_bioz_base_test.sv.sv                                                   
// Project	: Nanochap BAF4P1                                  		        
// Description	: Testcase soc_zmeas_base_test.sv                                             
// Designer	: vxmai@nanochap.com                                                                 
// Date		: 21-07-2026                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_bioz_base_test
`define TESTCFG soc_bioz_base_test_cfg

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // ===============================================
  // Adding your new varialbles in config test
  // -----------------------------------------------

  rand logic [7:0]  wr_data[256];
  rand int          no_of_bytes; 
  rand logic [7:0]  reg_addr;
  rand logic [7:0]  pads;
  rand logic [7:0]  mask;
  rand logic [7:0]  expected_data;
  logic [7:0]       rd_data_spi;
  rand logic [31:0] phase_inc;
  rand logic [31:0] phase_w;
  rand logic        bioz_en_state;

  // -----------------------------------------------
  // End of decalration of new variables 
  // ===============================================

  function new (string name = "soc_bioz_base_test_cfg");
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

//    virtual nnc_zmeas_freq_interface   zmeas_mon_if;
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
//        nnc_config_db #(virtual nnc_zmeas_freq_interface)::get(this, "*", "zmeas_mon_if", zmeas_mon_if);    
//        top_cfg.zmeas_freq_cfg.zmeas_freq_mon_en = 1;
    endfunction

    // -----------------------------------------
    // Declare the pre_reset_phase task 
    // -----------------------------------------
    virtual task pre_reset_phase(nnc_phase phase);
        phase.raise_objection(this);

        super.pre_reset_phase(phase);

        assert(top_test_cfg.randomize());

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

        `nnc_info("SOC_TEST", "soc_bioz_base_test start", UVM_LOW)

        #10000ns;
        `nnc_info("SOC_TEST", "soc_bioz_base_test end now", UVM_LOW)

        // ----------------------------------------------------------------------------------
        // End of adding test 
        // ==================================================================================

        phase.drop_objection(this);
    endtask: main_phase

    task bioz_state_change(bit state);
        `nnc_info("BIOZ STATE", $sformatf("Change Bioz state to: %b", state), UVM_NONE)
        `WR_NORMAL_REG(`SOC_BIOZ_CTRL, state, top_test_cfg.pads);
    endtask:bioz_state_change   

    task bioz_cal();

    endtask:bioz_cal 

    task unlock_trim_nvr0();
        if(`DUT_IF.ext_clk_en != 1)
        begin
            assert(top_test_cfg.randomize() with {ext_clk_en==1;});
            `nnc_info("Flash Unlock", "Begin to unlock flash to NVR0", UVM_NONE)
            //Step 1: Set FLASH_UNLOCK_PRO to 0xAA 
            `WR_NORMAL_REG(`SOC_FLASH_UNLOCK_PRO, 8'hAA, top_test_cfg.pads);
            //Step 2: Set FLASH_UNLOCK_NVR_PRO_BYTE00 to 0xAA
            `WR_NORMAL_REG(`SOC_FLASH_NVR_PRO_BYTE00, 8'hAA, top_test_cfg.pads);
            //Step 3: Set FLASH_UNLOCK_NVR_PRO_BYTE00 to 0xAA
            `WR_NORMAL_REG(`SOC_FLASH_NVR_PRO_BYTE01, 8'hAA, top_test_cfg.pads);
            //Step 4: Set Unlock bit [0] of FLASH_UNLOCK to 1'b1
            `WR_NORMAL_REG(`SOC_FLASH_UNLOCK, 8'b0000_0001, top_test_cfg.pads);
            //Step 5: Wait for FLASH_UNLOCK clear
            do
                begin
                    `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,top_test_cfg.rd_data_spi);
                    `nnc_info("Flash Unlock", $sformatf("Read Flash Unlock data: %b", top_test_cfg.rd_data_spi), UVM_NONE)
                end
            while(top_test_cfg.rd_data_spi[0] !== 0); 
            `nnc_info("Flash Unlock", " Unlock flash to NVR0 done", UVM_NONE)
            assert(top_test_cfg.randomize() with {ext_clk_en==0;});
        end
        else
        begin
            `nnc_info("Flash Unlock", "Begin to unlock flash to NVR0", UVM_NONE)
            //Step 1: Set FLASH_UNLOCK_PRO to 0xAA 
            `WR_NORMAL_REG(`SOC_FLASH_UNLOCK_PRO, 8'hAA, top_test_cfg.pads);
            //Step 2: Set FLASH_UNLOCK_NVR_PRO_BYTE00 to 0xAA
            `WR_NORMAL_REG(`SOC_FLASH_NVR_PRO_BYTE00, 8'hAA, top_test_cfg.pads);
            //Step 3: Set FLASH_UNLOCK_NVR_PRO_BYTE00 to 0xAA
            `WR_NORMAL_REG(`SOC_FLASH_NVR_PRO_BYTE01, 8'hAA, top_test_cfg.pads);
            //Step 4: Set Unlock bit [0] of FLASH_UNLOCK to 1'b1
            `WR_NORMAL_REG(`SOC_FLASH_UNLOCK, 8'b0000_0001, top_test_cfg.pads);
            //Step 5: Wait for FLASH_UNLOCK clear
            do
                begin
                    `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,top_test_cfg.rd_data_spi);
                    `nnc_info("Flash Unlock", $sformatf("Read Flash Unlock data: %b", top_test_cfg.rd_data_spi), UVM_NONE)
                end
            while(top_test_cfg.rd_data_spi[0] !== 0); 
            `nnc_info("Flash Unlock", " Unlock flash to NVR0 done", UVM_NONE)
        end
    endtask:unlock_trim_nvr0

    task set_ddsfreq(logic [31:0] phase_inc, logic [31:0] phase_offset, logic [31:0] phase_offset_c);
  //      zmeas_mon_if.phase_inc          = phase_inc;
  //      zmeas_mon_if.phase_offset       = phase_offset;
  //      zmeas_mon_if.phase_offset_c     = phase_offset_c;
    
        `nnc_info("Set phase", $sformatf("Starting to change phase with phase_inc: %8h, phase_offset: %8h, phase_offset_c: %8h", phase_inc, phase_offset, phase_offset_c), UVM_NONE);


  //      ->zmeas_mon_if.dds_set_start;
        `nnc_info("DDS - PHASE_INC", $sformatf("Writting into Phase INC 0 with value %b", phase_inc[7:0]), UVM_HIGH);      
        `WR_NORMAL_REG(`SOC_PHASE_INC_0, phase_inc[7:0], top_test_cfg.pads);
        
        `nnc_info("DDS - PHASE_INC", $sformatf("Writting into Phase INC 1 with value %b", phase_inc[15:8]), UVM_HIGH);      
        `WR_NORMAL_REG(`SOC_PHASE_INC_1, phase_inc[15:8], top_test_cfg.pads);
        
        `nnc_info("DDS - PHASE_INC", $sformatf("Writting into Phase INC 2 with value %b", phase_inc[23:16]), UVM_HIGH);      
        `WR_NORMAL_REG(`SOC_PHASE_INC_2, phase_inc[23:16], top_test_cfg.pads);
        
        `nnc_info("DDS - PHASE_INC", $sformatf("Writting into Phase INC 3 with value %b", phase_inc[31:24]), UVM_HIGH);      
        `WR_NORMAL_REG(`SOC_PHASE_INC_3, phase_inc[31:24], top_test_cfg.pads);
        
        `nnc_info("DDS - PHASE_OFFSET", $sformatf("Writting into Phase offset 0 with value %b", phase_offset[7:0]), UVM_HIGH);      
        `WR_NORMAL_REG(`SOC_PHASE_OFFSET_0, phase_offset[7:0], top_test_cfg.pads);
        
        `nnc_info("DDS - PHASE_OFFSET", $sformatf("Writting into Phase offset 1 with value %b", phase_offset[15:8]), UVM_HIGH);      
        `WR_NORMAL_REG(`SOC_PHASE_OFFSET_1, phase_offset[15:8], top_test_cfg.pads);
        
        `nnc_info("DDS - PHASE_OFFSET", $sformatf("Writting into Phase offset 2 with value %b", phase_offset[23:16]), UVM_HIGH);      
        `WR_NORMAL_REG(`SOC_PHASE_OFFSET_2, phase_offset[23:16], top_test_cfg.pads);
        
        `nnc_info("DDS - PHASE_OFFSET", $sformatf("Writting into Phase offset 3 with value %b", phase_offset[31:24]), UVM_HIGH);      
        `WR_NORMAL_REG(`SOC_PHASE_OFFSET_3, phase_offset[31:24], top_test_cfg.pads);
        
        `nnc_info("DDS - PHASE_OFFSET_C", $sformatf("Writting into Phase offset_c 0 with value %b", phase_offset_c[7:0]), UVM_HIGH);      
        `WR_NORMAL_REG(`SOC_PHASE_OFFSET_C_0, phase_offset_c[7:0], top_test_cfg.pads);
        
        `nnc_info("DDS - PHASE_OFFSET_C", $sformatf("Writting into Phase offset_c 1 with value %b", phase_offset_c[15:8]), UVM_HIGH);      
        `WR_NORMAL_REG(`SOC_PHASE_OFFSET_C_1, phase_offset_c[15:8], top_test_cfg.pads);
        
        `nnc_info("DDS - PHASE_OFFSET_C", $sformatf("Writting into Phase offset_c 2 with value %b", phase_offset_c[23:16]), UVM_HIGH);      
        `WR_NORMAL_REG(`SOC_PHASE_OFFSET_C_2, phase_offset_c[23:16], top_test_cfg.pads);
        
        `nnc_info("DDS - PHASE_OFFSET_C", $sformatf("Writting into Phase offset_c 3 with value %b", phase_offset_c[31:24]), UVM_HIGH);      
        `WR_NORMAL_REG(`SOC_PHASE_OFFSET_C_3, phase_offset_c[31:24], top_test_cfg.pads);

        bioz_state_change(1);

  //      ->zmeas_mon_if.dds_set_done;
        
        `nnc_info("Set phase", "Done changing", UVM_NONE);
    
    endtask:set_ddsfreq

  // ------------------------------
  // Declare the report_phase task
  // ------------------------------
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction

endclass : `TESTNAME

