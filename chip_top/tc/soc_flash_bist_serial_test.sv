/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_flash_bist_serial_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_flash_bist_serial_test                                             
// Designer	: pfwang@nanochap.com                                                                 
// Date		: 07-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_flash_bist_serial_test
`define TESTCFG soc_flash_bist_serial_test_cfg

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

  function new (string name = "soc_flash_bist_serial_test_cfg");
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


    `DUT_IF.disable_init_flash = 1'b0;
      
    // -------------------
    // Scoreboard enables
    // -------------------
    `FLASH_SCOREBOARD_EN = 1;
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

    `nnc_info("SOC_TEST", "soc_flash_bist_serial_test start", UVM_LOW)

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
    `nnc_info("SOC_TEST", "soc_flash_bist_serial_test end now", UVM_LOW)

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
/*
`define S_CEB             0  
`define S_OEB             1 
`define S_WEB             2  
`define S_PROG            3  
`define S_PROG2           4  
`define S_ERASE           5  
`define S_BLOCK           6  
`define S_CHIP            7 
`define S_CONFEN          8
`define S_NVR             9
`define S_TMEN           10
`define S_VREAD1          11
`define S_VREAD0          12
`define S_RDN            13
`define S_DEEPPD         14
`define S_VMON1          15
`define S_VMON2          16
`define S_A           31:17
`define S_DIN         39:32
`define S_MS          43:40
`define S_FREQ        45:44
`define S_Tprog_conf  47:46   // to select differnent program time
`define S_Terase_conf 49:48   // to select differnent erase time 

// modes
`define PGMSER_RD_WR 4'b0000
`define PGM_WR       4'b0001
`define PGMCB_WR     4'b0010
`define PGMICB_WR    4'b0011
`define PGMDIAG_WR   4'b0100
`define PGM_RD       4'b0101
`define PGM_SERASE    4'b0110
`define PGM_BERASE   4'b1011
`define PGM_WR32     4'b0111   
`define PGMCB_WR32   4'b1000
`define PGMICB_WR32  4'b1001
`define PGM_WR_WORD  4'b1100
`define PGM_RD_WORD  4'b1101
`define PGM_RDCK     4'b1110
*/
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
// functional mode
// ----------------
// PDI[39:0] = {DIN[7:0], A[14:0], control_bits[13:0], WEb_OEb_CEb};
// control_bits[13:0] = { vmon[2:1], deeppd, RDN, vread[0:1],tmen, nvr, confen, chip, block, erase, prog2, prog };
// In test mode
// -------------
// assign test_data_from_TDI[49] = {Tprog_erase_conf[3:0], Freq_select[2:0], mode_select[3:0], DIN[7:0], A[14:0], control_bits[13:0], WEb_OEb_CEb};
// Tprog_erase_conf[3:0] = {t_erase[1:0], t_prog[1:0]};
// mode_select[3:0] = {msd, msc, msb, msa}
// control_bits[13:0] = { vmon[2:1], deeppd, RDN, vread[0:1],tmen, nvr, confen, chip, block, erase, prog2, prog };

 /****************Start 10M test********************/ 
`uvm_info("", "[FLASH BIST MASTER][0] Sending Reset Command to Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.reset;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

`uvm_info("", "[FLASH BIST MASTER][1] Sending Reset Command to init values  of Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.init_flash_with_values;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

@(posedge `FLASH_BIST_MASTER_TOP.TCK);

`uvm_info("", "[FLASH BIST MASTER][2] Sending Serial Test Command to Flash", UVM_LOW);
`FLASH_BIST_MASTER_TOP.serial_test;
`uvm_info("", "[FLASH BIST MASTER] Complete successully this phase", UVM_LOW);

end
endtask

endclass : `TESTNAME
