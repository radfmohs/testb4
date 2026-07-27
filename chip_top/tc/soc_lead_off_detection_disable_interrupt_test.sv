/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_lead_off_detection_disable_interrupt_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_lead_off_detection_disable_interrupt_test                                             
// Designer	: shreeyal@nanochap.com                                                                 
// Date		: 20-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_lead_off_detection_disable_interrupt_test
`define TESTCFG soc_lead_off_detection_disable_interrupt_test_cfg

class `TESTCFG extends soc_base_lead_off_detection_test_cfg;

  `nnc_object_utils(`TESTCFG)

  function new (string name = "soc_lead_off_detection_disable_interrupt_test_cfg");
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
    disable_intr = 1;
    `nnc_info(get_full_name(), $sformatf(" disable_intr=%0d",disable_intr),UVM_LOW);
  endfunction

  // -----------------------------------------
  // Declare the pre_reset_phase task 
  // -----------------------------------------
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

    `nnc_info("SOC_TEST", "soc_lead_off_detection_disable_interrupt_test start", UVM_LOW)

    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    
    fork
      do_run_for_disable_intr();
      drive_A2D_LOFF_STATN_STATP_for_disable();
    join
    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    //#10000ns;
    `nnc_info("SOC_TEST", "soc_lead_off_detection_disable_interrupt_test end now", UVM_LOW)

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
