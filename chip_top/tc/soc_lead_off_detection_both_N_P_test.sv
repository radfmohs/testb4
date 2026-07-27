/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_lead_off_detection_both_N_P_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_lead_off_detection_both_N_P_test                                             
// Designer	: shreeyal@nanochap.com                                                                 
// Date		: 20-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_lead_off_detection_both_N_P_test
`define TESTCFG soc_lead_off_detection_both_N_P_test_cfg

class `TESTCFG extends soc_base_lead_off_detection_test_cfg;

  `nnc_object_utils(`TESTCFG)

  function new (string name = "soc_lead_off_detection_both_N_P_test_cfg");
    super.new(name);
  endfunction: new

endclass : `TESTCFG

// ===============================================
// Main Testcase is defined
// -----------------------------------------------
class `TESTNAME extends soc_base_lead_off_detection_test;
   
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
    top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);
    both_n_p = 1;
    `nnc_info(get_full_name(), $sformatf(" both_n_p=%0d",both_n_p),UVM_LOW);
  endfunction

  virtual task pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);

    super.pre_reset_phase(phase);
    phase.drop_objection(this);
  endtask : pre_reset_phase

  // -----------------------------------------
  // Declare the main_phase task of your test
  // -----------------------------------------
  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);
    super.main_phase(phase);

    `nnc_info("SOC_TEST", "soc_lead_off_detection_both_N_P_test start", UVM_LOW)

    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    //`nnc_info(get_full_name(), $sformatf(" en_ac_dc_lead_off=%0d",top_test_cfg.en_ac_dc_lead_off),UVM_LOW);

    if(top_test_cfg.en_ac_dc_lead_off == `AC_DC_BOTH_DISABLE)begin
      fork
        do_run_for_ac_dc_both_disable();
        drive_A2D_LOFF_STATN_STATP_for_disable();
      join
    end
    else begin
      fork
        do_run();
        drive_A2D_LOFF_STATN_STATP();
      join
    end

    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    //#10000ns;
    `nnc_info("SOC_TEST", "soc_lead_off_detection_both_N_P_test end now", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ==================================================================================

    phase.drop_objection(this);
  endtask: main_phase

  task do_run;
    `nnc_info("SOC_TEST", "soc_lead_off_detect_test start", UVM_LOW)
  
    config_leadoff_regs();

    top_test_cfg.enable_check.trigger();
    `LEAD_OFF_SCB_EN = 1;
  endtask

  task drive_A2D_LOFF_STATN_STATP();
    lead_off_init ();
    top_test_cfg.enable_check.wait_trigger();

    // ===============================================
    // This is Leadoff DURATION Interrupt test
    // ===============================================
    // Test 1
    test_1();

    top_test_cfg.check_step = 1; 

    // Test 2
    test_2();
    top_test_cfg.check_step = 2; 

    // ===============================================
    // This is Leadoff SWITCH Interrupt test
    // ===============================================
    // Test 1
    test_3();
    top_test_cfg.check_step = 3; 

    // Test 2
      test_4();
    `LEAD_OFF_SCB_EN = 0;

  endtask : drive_A2D_LOFF_STATN_STATP

  // ------------------------------
  // Declare the report_phase task
  // ------------------------------
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction

endclass : `TESTNAME
