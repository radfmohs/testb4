/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_flash_bist_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_flash_bist_test                                             
// Designer	: pfwang@nanochap.com                                                                 
// Date		: 07-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_flash_bist_test
`define TESTCFG soc_flash_bist_test_cfg

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

  // -----------------------------------------------
  // End of decalration of new variables 
  // ===============================================

  function new (string name = "soc_flash_bist_test_cfg");
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

    assert(top_test_cfg.randomize());

    `DUT_IF.testmode_sel = top_test_cfg.testmode_sel;

    `DUT_IF.spimode_sel = top_test_cfg.spimode_sel;


    `DUT_IF.disable_init_flash = 1'b1;
      
    // -------------------
    // Scoreboard enables
    // -------------------
    `FLASH_SCOREBOARD_EN = 0;
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

    `nnc_info("SOC_TEST", "soc_flash_bist_test start", UVM_LOW)

    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    

    #1000;
    wait(`RESETN);


    wait(`DUT_IF.flash_recall_done);
      
    do_run;

    #20000000;
  

    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    #10000ns;
    `nnc_info("SOC_TEST", "soc_flash_bist_test end now", UVM_LOW)

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



task do_run;
begin

`FLASH_BIST_MASTER_TOP.TESTMODE_SEL = 2'b10;

force `ANA_TOP.A2D_OSC_OUT = 1'bx;
force `ANA_TOP.A2D_SDM_OUT = 1'bx;
force `ANA_TOP.A2D_SW_POWER_POR = 1'bx;
force `ANA_TOP.A2D_VDDI_POR = 1'bx;
//force `ANA_TOP.A2D_SW_Z_ADC_EOC = 1'bx;
force `ANA_TOP.A2D_external_RESET = 1'bx;
force `ANA_TOP.A2D_external_clock_I = 1'bx;
force `ANA_TOP.A2D_external_en_I = 1'bx;
force `ANA_TOP.A2D_Wake_UP_i = 1'b1;

//wire [49:0] test_data_from_TDI;
//assign test_data_from_TDI = {Tprog_erase_conf, Freq_select, mode_select, DIN, A, control_bits, WEb_OEb_CEb};

 /****************Start 10M test********************/ 

`uvm_info("", "[FLASH BIST MASTER][0] Sending Reset Command to Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.reset;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

`uvm_info("", "[FLASH BIST MASTER][1] Sending Reset Command to init values of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.init_flash_with_values;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

#1us;

//`uvm_info("", "[FLASH BIST MASTER][2] Sending Serial Test Command to Flash", UVM_LOW);
//`FLASH_BIST_MASTER_TOP.serial_test;
//`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

#1us;
`FLASH_SCOREBOARD_EN = 1;

`uvm_info("", "[FLASH BIST MASTER][3] Sending Program Command to program Main of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.prgm_main_10M(8'haa);
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

#1s;

`uvm_info("", "[FLASH BIST MASTER][4] Sending Read Command to read Main of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.read_main_array_10M;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

`uvm_info("", "[FLASH BIST MASTER][5] Sending Read Command to read and check Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.read_check(8'haa,`PGM_WR);
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

`uvm_info("", "[FLASH BIST MASTER][6] Sending Erase Command to erase at Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.berase_10M;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

#4ms;

`uvm_info("", "[FLASH BIST MASTER][7] Sending Program Command to program CKB of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.prgm_main_CKB_10M(8'h0);
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

#1s;

`uvm_info("", "[FLASH BIST MASTER][7] Sending Read Command to read Main of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.read_main_array_10M;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

`uvm_info("", "[FLASH BIST MASTER][8] Sending Read Command to read and check of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.read_check(8'h0,`PGMCB_WR);
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

`uvm_info("", "[FLASH BIST MASTER][9] Sending Serial Erase Command to erase Main of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.serase_main_10M;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

#4ms;

`uvm_info("", "[FLASH BIST MASTER][10] Sending Program Command to program Diag Main of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.prgm_diag_main_10M(8'h55);
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

#1s;

`uvm_info("", "[FLASH BIST MASTER][11] Sending Read Command to read main array of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.read_main_array_10M;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

`uvm_info("", "[FLASH BIST MASTER][12] Sending Read Command to read and check of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.read_check(8'h55,`PGMDIAG_WR);
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

`uvm_info("", "[FLASH BIST MASTER][13] Sending Program Command to program RDN of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.prgm_RDN_10M(8'h5a);
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

#1s;

`uvm_info("", "[FLASH BIST MASTER][14] Sending Read Command to read RDN of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.read_RDN_10M;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

`uvm_info("", "[FLASH BIST MASTER][15] Sending Read Command to read and check RDN of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.read_check_rdn(8'h5a,`PGM_WR);
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

`uvm_info("", "[FLASH BIST MASTER][16] Sending Serial Erase Command to to erase RDN of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.serase_RDN_10M;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

#4ms;

`uvm_info("", "[FLASH BIST MASTER][17] Sending Program Command to program ICKB RDN of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.prgm_ickb_RDN_10M(8'h0a);
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

#1ms;

`uvm_info("", "[FLASH BIST MASTER][18] Sending Read Command to read RDN of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.read_RDN_10M;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

`uvm_info("", "[FLASH BIST MASTER][19] Sending Read Command to read and check RDN of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.read_check_rdn(8'h0a,`PGMICB_WR);
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

`uvm_info("", "[FLASH BIST MASTER][20] Sending Serial Erase Command to to erase NVR of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.serase_1st_NVR_10M;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

#4ms;

`uvm_info("", "[FLASH BIST MASTER][21] Sending Program Command to program NVR ICB of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.prgm_1st_NVR_ICB_10M(8'h0);
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

#1s;

`uvm_info("", "[FLASH BIST MASTER][22] Sending Read Command to read NVR of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.read_NVR_10M;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

`uvm_info("", "[FLASH BIST MASTER][23] Sending Read Command to Read and Check NVR of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.read_check_nvr(8'h0,`PGMICB_WR);
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

`uvm_info("", "[FLASH BIST MASTER][24] Sending Serial Erase Command to to erase NVR of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.serase_1st_NVR_10M;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

#4ms;

`uvm_info("", "[FLASH BIST MASTER][25] Sending Program Command to program NVR of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.prgm_1st_NVR_10M(8'h0a);
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

#2s;

`uvm_info("", "[FLASH BIST MASTER][26] Sending Read Command to read NVR of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.read_NVR_10M;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

`uvm_info("", "[FLASH BIST MASTER][27] Sending Read Command to Read and Check NVR of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.read_check_nvr(8'h0a,`PGM_WR);
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

end
endtask

endclass : `TESTNAME
