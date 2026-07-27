/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_always_on_sys_ctrl_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_always_on_sys_ctrl_test                                             
// Designer	: pfwang@nanochap.com                                                                 
// Date		: 03-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_always_on_sys_ctrl_test
`define TESTCFG soc_always_on_sys_ctrl_test_cfg

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

  function new (string name = "soc_always_on_sys_ctrl_test_cfg");
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
   
reg [7:0]	rd_alwayson_clkctrl_reg;
reg [7:0]	rd_clkctrl_reg;
//reg [7:0]	rd_zmeas_en_reg;
//reg [7:0]	rd_imeas_en_reg;
int		error; 
logic [7:0] 	mask;
logic [7:0] 	pads;
logic [7:0] 	rd_flash_debug2_reg;
bit		flash_busy_status_bit;
bit		flash_erase_status_bit;
logic [7:0] 	rd_flash_debug1_reg;
logic [7:0] 	rd_flash_config_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA0_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA1_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA2_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA3_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA4_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA5_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA6_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA7_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA8_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA9_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA10_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA11_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA12_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA13_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA14_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA15_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA16_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA17_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA18_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA19_reg;
logic [7:0]     rd_SOC_FLASH_TRIMDATA20_reg;
logic [7:0] ana_buffer = 0;
logic [7:0] ana_ecg_ctrl1 = 8'b11;
logic [7:0] ana_ecg_ctrl2 = 8'b100;
logic [7:0] ana_dc_lead_off_ctrl = 8'b10000000;
logic [7:0] ana_tsc = 0;
logic [7:0] ana_ppg_led_sel = 0;
logic [7:0] ana_ppg_dac0_ctrl_reg0 = 0;
logic [7:0] ana_ppg_dac0_ctrl_reg1 = 0;
logic [7:0] ana_ppg_dac1_ctrl_reg0 = 0;
logic [7:0] ana_ppg_dac1_ctrl_reg1 = 0;
logic [7:0] ana_ppg_tia_idac = 0;
logic [7:0] ana_ppg_tia_gain = 0;
logic [7:0] ana_ppg_test_reg = 0;
logic [7:0] ana_ppg_led_en_reg = 0;
logic [7:0] ana_ppg_ctrl_reg = 0;               
logic [7:0] ana_bist = 0;
logic [7:0] ana_sdm_reg = 0;
logic [7:0] ana_lead_off_en = 0;

logic [7:0]     rd_dac2_din_0_reg;          
logic [7:0]     rd_dac2_din_1_reg;          
                   
logic [7:0]     rd_ALWAYS_ON_ANA_DAC2_DIN_0; //R2R_DAC2(debug register)                                 
logic [7:0]     rd_ALWAYS_ON_ANA_DAC2_DIN_1; //R2R_DAC2(debug register)
logic [7:0]     no_of_bytes;
reg [7:0]       ana_reg_data[32];
reg [7:0]       ana_reg_expd[32];
logic [7:0]     rd_data_reg[];
logic [7:0]     rd_debug_data_reg[];
 
logic [18:0]    o_IOBUF_IE;
logic [18:0]    o_IOBUF_CS;
logic [18:0]    o_IOBUF_PU;
logic [18:0]    o_IOBUF_SR;
logic [18:0]    o_IOBUF_DR;
logic [18:0]    o_IOBUF_A ;
logic [18:0]    o_IOBUF_OE;
logic [18:0]    o_IOBUF_OS;
logic [18:0]    o_IOBUF_OD;
logic [18:0]    o_IOBUF_PD;
logic [18:0]    o_IOBUF_Y;

logic [7:0]     rd_ALWAYS_ON_ANA_TRIM2;
logic [7:0]     rd_ALWAYS_ON_ANA_TRIM1;                                  
logic [7:0]     rd_ALWAYS_ON_ANA_TRIM3;
logic [7:0]     rd_ALWAYS_ON_ANA_TRIM4;





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

    `nnc_info("SOC_TEST", "soc_always_on_sys_ctrl_test start", UVM_LOW)

    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    
    // --------------------------------------------------------
    // This is an example RD_RESET_CHK_REG 
    // --------------------------------------------------------
   //`nnc_info("SOC_TEST - PART I", "STARTING TO CHECK THE RESET VALUE OF NORMAL REGISTERS", UVM_LOW)

   // assert(top_test_cfg.randomize() with {reg_addr == `SOC_CLK_CTRL_REG; expected_data == `SOC_CLK_CTRL_REG_INIT;});
   // `RD_RESET_CHK_NORMAL_REG(top_test_cfg.reg_addr, top_test_cfg.expected_data, top_test_cfg.pads);

   // // --------------------------------------------------------
   // // Part III: Checking the W/R values of all of normal registers by using `WR_RD_CHK_NORMAL_REG
   // // --------------------------------------------------------
   // `nnc_info("SOC_TEST - PART II", "STARTING TO CHECK THE R/W OF NORMAL REGISTERS", UVM_LOW)
   // assert(top_test_cfg.randomize() with {reg_addr == `SOC_FIFO_WR_PTR_REG; mask == 8'hff;});
   // ``WR_RD_CHK_NORMAL_REG(top_test_cfg.reg_addr, top_test_cfg.data[0], top_test_cfg.pads, top_test_cfg.mask);


    pads = 8'h00;
    mask = 8'hff;
  #1us;
  wait(`RESETN);

  // Run 256Khz
  `uvm_info("", "\t===========================================", UVM_LOW);
  `uvm_info("", "\tTEST1 - running in SPI = 256 Khz", UVM_LOW);
  //force `SPI_CLK_GEN.spi_clk_gen_sel[1:0] = 2'b00;
  do_run;

  //`uvm_info("", "\t===========================================", UVM_LOW);
  //`uvm_info("", "\tTEST2 - running in SPI = 1Mhz", UVM_LOW);
  //// Run 1Mhz 
  //force `SPI_CLK_GEN.spi_clk_gen_sel[1:0] = 2'b01;
  //do_run;

  //`uvm_info("", "\t===========================================", UVM_LOW);
  //`uvm_info("", "\tTEST3 - running in SPI = 500Khz", UVM_LOW);
  //// Run 500Khz
  //force `SPI_CLK_GEN.spi_clk_gen_sel[1:0] = 2'b10;
  //do_run;

  //`uvm_info("", "\t===========================================", UVM_LOW);
  //`uvm_info("", "\tTEST4 - running in SPI = 333Khz", UVM_LOW);
  //// Run 333Khz
  //force `SPI_CLK_GEN.spi_clk_gen_sel[1:0] = 2'b11;
  //do_run;

  #20us;

    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    #10000ns;
    `nnc_info("SOC_TEST", "soc_always_on_sys_ctrl_test end now", UVM_LOW)

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


//----------------------------------------------------------------------------------------//
//----------------------------------------------------------------------------------------//
//----------------------------------------------------------------------------------------//
//----------------------------------------------------------------------------------------//
//----------------------------------------------------------------------------------------//
//----------------------------------------------------------------------------------------//
//------------------------------start test------------------------------------------------//
//----------------------------------------------------------------------------------------//
task do_run ;			
  pads= 8'h00;
  mask= 8'hFF;
  error= 0;
  #1000;
  ana_reg_expd[0] = 8'h37;
  ana_reg_expd[1] = 8'h26;
  ana_reg_expd[2] = 8'h15;
  ana_reg_expd[3] = 8'h04;
  ana_reg_expd[4] = 8'h03;
  ana_reg_expd[5] = 8'h00;
  ana_reg_expd[6] = 8'h11;
  ana_reg_expd[7] = 8'h0f;

  `uvm_info("",  "\n*********From always_on_sys_ctrl_test*********", UVM_LOW);

   `uvm_info("",  "Wait for ALWAYSON_TOP.A2D_Wake_UP_i", UVM_LOW);
   wait(`ALWAYSON_TOP.A2D_Wake_UP_i); #100;
 
   `uvm_info("",  "Wait for ALWAYSON_TOP.A2D_VDDI_POR", UVM_LOW);
   wait(`ALWAYSON_TOP.A2D_VDDI_POR); #100;

   `uvm_info("",  "Wait for ALWAYSON_RST_CTRL.poresetn", UVM_LOW);
//`ifndef POSTLAYOUT_PG
   wait(`ALWAYSON_RST_CTRL.poresetn); 
//`else
//   wait(~`ALWAYSON_RST_CTRL.OUT0);   
//`endif
   #100; 

   `uvm_info("",  "Wait for ALWAYSON_TOP.poresetn_hf_sw_power", UVM_LOW);
   wait(`ALWAYSON_TOP.poresetn_hf_sw_power); #100;

   `uvm_info("",  "Wait for ALWAYSON_TOP.flash_reset_done", UVM_LOW);      
   wait(`ALWAYSON_TOP.flash_reset_done); #100;
  
  //call below task in sequence
  //1.
  do_run_sw_ext_resetn0_apply;
  do_run_sw_ext_resetn1_apply;
  `uvm_info("", "\t[ALWAYS ON INFO][1.2] Starting task do_run_check_default_io_signals", UVM_LOW); 
  #4000ns;
  do_run_check_default_io_signals;
  `uvm_info("", "\t[ALWAYS ON INFO][1.1] Starting task do_run_spi_read_default_debug_anac_regs_val", UVM_LOW); 
  do_run_spi_read_default_debug_anac_regs_val;
  //`uvm_info("", "\t[ALWAYS ON INFO][1.2] Starting task do_run_check_default_io_signals", UVM_LOW); 
  //#4000ns;
  //do_run_check_default_io_signals;

  `uvm_info("", "\t[ALWAYS ON INFO][1.3] Starting task do_run_spi_wr_rd_reg_val", UVM_LOW); 
  do_run_spi_wr_rd_reg_val;	

  `uvm_info("", "\t[ALWAYS ON INFO][1.4] Starting task do_run_spi_write", UVM_LOW); 				//call task
  do_run_spi_write;						//LOW to HIGH detection, write command works 

  `uvm_info("", "\t[ALWAYS ON INFO][1.5] Starting task do_run_spi_rd_debug_anac_reg_val", UVM_LOW); 	
  do_run_spi_rd_debug_anac_reg_val;

  //2.
  `uvm_info("", "\t[ALWAYS ON INFO][2.1] Starting task do_run_extclk1MZ", UVM_LOW); 
  do_run_extclk1MZ;
  `uvm_info("", "\t[ALWAYS ON INFO][2.2] Starting task do_run_spi_rd_debug_anac_reg_val", UVM_LOW); 
  do_run_spi_rd_debug_anac_reg_val; 

  //3.
  //reset ==0 (switchable domain)
  `uvm_info("", "\t[ALWAYS ON INFO][3.1] Starting task do_run_sw_wakeup0", UVM_LOW); 
  do_run_sw_wakeup0;						//spi_write goes LOW
  `uvm_info("", "\t[ALWAYS ON INFO][3.2] Starting task do_run_check_ana_reg_val", UVM_LOW); 
  do_run_check_ana_reg_val;
  `uvm_info("", "\t[ALWAYS ON INFO][3.3] Starting task do_run_check_io_lowpwr_mode", UVM_LOW); 
  do_run_check_io_lowpwr_mode;					//do_run_check_io_lowpwr_mode;
  
  `uvm_info("", "\t[ALWAYS ON INFO][3.4] Starting task do_run_sw_wakeup1", UVM_LOW); 
  do_run_sw_wakeup1; 
  `uvm_info("", "\t[ALWAYS ON INFO][3.5] Starting task do_run_spi_rd_debug_anac_reg_val", UVM_LOW); 
  do_run_spi_rd_debug_anac_reg_val;
  `uvm_info("", "\t[ALWAYS ON INFO][3.4] Starting task do_run_spi_write", UVM_LOW);
  do_run_spi_write;						//this command at this point will reset debug register values (it meant to configure new value)
  `uvm_info("", "\t[ALWAYS ON INFO][3.7] Starting task do_run_spi_read_default_debug_anac_regs_val", UVM_LOW); 
  do_run_spi_read_default_debug_anac_regs_val;			//do_run_read_default_reg_val;
  `uvm_info("", "\t[ALWAYS ON INFO][3.8] Starting task do_run_disable_spi_write", UVM_LOW); 
  do_run_disable_spi_write;					////LOW to HIGH detection, write command works
  `uvm_info("", "\t[ALWAYS ON INFO][3.9] Starting task do_run_spi_wr_rd_reg_val", UVM_LOW); 
  do_run_spi_wr_rd_reg_val;					//call task
  `uvm_info("", "\t[ALWAYS ON INFO][3.10] Starting task do_run_spi_write", UVM_LOW); 
  do_run_spi_write;
  
  //do_run_spi_burst_wr_reg;
  //do_run_spi_write;						////LOW to HIGH detection, write command works
  //do_run_spi_burst_rd_reg;
 // do_run_spi_burst_rd_debug_reg;
 
  //check IOCELL 
  //**********************************//
  `uvm_info("", "\t[ALWAYS ON INFO][3.11] Starting task do_run_disable_spi_write", UVM_LOW); 
  do_run_disable_spi_write;
  `uvm_info("", "\t[ALWAYS ON INFO][3.12] Starting task do_run_spi_wr_rd_reg_val", UVM_LOW); 
  do_run_spi_wr_rd_reg_val;					//call task
  `uvm_info("", "\t[ALWAYS ON INFO][3.13] Starting task do_run_spi_write", UVM_LOW); 
  do_run_spi_write;						//LOW to HIGH detection, write command works 
  `uvm_info("", "\t[ALWAYS ON INFO][3.14] Starting task do_run_spi_rd_debug_anac_reg_val", UVM_LOW); 
  do_run_spi_rd_debug_anac_reg_val;   						    
  //**********************************//

  //4.
  //External_resetn via IOPAD
  `uvm_info("", "\t[ALWAYS ON INFO][4.1] Starting task do_run_sw_`SOC_TB.ext_resetn0_apply", UVM_LOW); 
  do_run_sw_ext_resetn0_apply;
  `uvm_info("", "\t[ALWAYS ON INFO][4.2] Starting task do_run_check_ana_reg_val", UVM_LOW); 
  do_run_check_ana_reg_val;  
  
  `uvm_info("", "\t[ALWAYS ON INFO][4.3] Starting task do_run_sw_`SOC_TB.ext_resetn1_apply", UVM_LOW); 
  do_run_sw_ext_resetn1_apply;
  `uvm_info("", "\t[ALWAYS ON INFO][4.4] Starting task do_run_spi_rd_debug_anac_reg_val", UVM_LOW); 
  do_run_spi_rd_debug_anac_reg_val;
  `uvm_info("", "\t[ALWAYS ON INFO][4.5] Starting task do_run_spi_rd_reset_regs_val", UVM_LOW); 
  do_run_spi_rd_reset_regs_val; 
  `uvm_info("", "\t[ALWAYS ON INFO][4.6] Starting task do_run_spi_write", UVM_LOW); 
  do_run_spi_write;						//this command at this point will reset debug register values (it meant to configure new value) 
  `uvm_info("", "\t[ALWAYS ON INFO][4.7] Starting task do_run_spi_read_default_debug_anac_regs_val", UVM_LOW); 
  do_run_spi_read_default_debug_anac_regs_val;

  //**********************************//
  `uvm_info("", "\t[ALWAYS ON INFO][4.8] Starting task do_run_disable_spi_write", UVM_LOW); 
  do_run_disable_spi_write;
  `uvm_info("", "\t[ALWAYS ON INFO][4.9] Starting task do_run_spi_wr_rd_reg_val", UVM_LOW); 
  do_run_spi_wr_rd_reg_val;					//call task
  `uvm_info("", "\t[ALWAYS ON INFO][4.10] Starting task do_run_spi_write", UVM_LOW); 
  do_run_spi_write;						//LOW to HIGH detection, write command works 
  `uvm_info("", "\t[ALWAYS ON INFO][4.11] Starting task do_run_spi_rd_debug_anac_reg_val", UVM_LOW); 
  do_run_spi_rd_debug_anac_reg_val;   						    
  //**********************************//

  //5.
  `uvm_info("", "\t[ALWAYS ON INFO][5.1] Starting task do_run_always_on_reset0", UVM_LOW); 
  do_run_always_on_reset0;					//A2D_VDDI_POR=0, all debug_register ===>0
  `uvm_info("", "\t[ALWAYS ON INFO][5.2] Starting task do_run_configuered_spi_rd_regs_val", UVM_LOW); 
  ana_default_ao_reset;
  do_run_configuered_spi_rd_regs_val;
  `uvm_info("", "\t[ALWAYS ON INFO][5.3] Starting task do_run_alwayson_reset0_rd_debug_anac_regs_val", UVM_LOW); 
  do_run_alwayson_reset0_rd_debug_anac_regs_val; 

  `uvm_info("", "\t[ALWAYS ON INFO][5.4] Starting task do_run_always_on_reset1", UVM_LOW); 
  do_run_always_on_reset1;
  `uvm_info("", "\t[ALWAYS ON INFO][5.5] Starting task do_run_spi_rd_debug_anac_reg_val", UVM_LOW); 
  do_run_spi_rd_debug_anac_reg_val;

  //6.
  //alwyas on external reset 
  `uvm_info("", "\t[ALWAYS ON INFO][6.1] Starting task do_run_always_on_`SOC_TB.ext_resetn0", UVM_LOW); 
  do_run_always_on_ext_resetn0;
  `uvm_info("", "\t[ALWAYS ON INFO][6.2] Starting task do_run_configuered_spi_rd_regs_val", UVM_LOW); 
  do_run_configuered_spi_rd_regs_val;
  `uvm_info("", "\t[ALWAYS ON INFO][6.3] Starting task do_run_alwayson_reset0_rd_debug_anac_regs_val", UVM_LOW); 
  do_run_alwayson_reset0_rd_debug_anac_regs_val;

  `uvm_info("", "\t[ALWAYS ON INFO][6.4] Starting task do_run_always_on_`SOC_TB.ext_resetn1", UVM_LOW); 
  do_run_always_on_ext_resetn1;
  ana_default_ao_reset;
  `uvm_info("", "\t[ALWAYS ON INFO][6.5] Starting task do_run_spi_rd_debug_anac_reg_val", UVM_LOW); 
  do_run_spi_rd_debug_anac_reg_val;

  // external_RESET
  #2000000;
  //do_report(err_cnt,error);			//call task
endtask:do_run
//----------------------------------------------------------------------------------------//
//----------------------------------------------------------------------------------------//


task do_run_spi_read_default_debug_anac_regs_val;
begin
  
         
   //1.read trim values too
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA0,8'h00,rd_SOC_FLASH_TRIMDATA0_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA1,8'h00,rd_SOC_FLASH_TRIMDATA1_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA2,8'h00,rd_SOC_FLASH_TRIMDATA2_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA3,8'h00,rd_SOC_FLASH_TRIMDATA3_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA4,8'h00,rd_SOC_FLASH_TRIMDATA4_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA5,8'h00,rd_SOC_FLASH_TRIMDATA5_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA6,8'h00,rd_SOC_FLASH_TRIMDATA6_reg);   
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA7,8'h00,rd_SOC_FLASH_TRIMDATA7_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA8,8'h00,rd_SOC_FLASH_TRIMDATA8_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA9,8'h00,rd_SOC_FLASH_TRIMDATA9_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA10,8'h00,rd_SOC_FLASH_TRIMDATA10_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA11,8'h00,rd_SOC_FLASH_TRIMDATA11_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA12,8'h00,rd_SOC_FLASH_TRIMDATA12_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA13,8'h00,rd_SOC_FLASH_TRIMDATA13_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA14,8'h00,rd_SOC_FLASH_TRIMDATA14_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA15,8'h00,rd_SOC_FLASH_TRIMDATA15_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA16,8'h00,rd_SOC_FLASH_TRIMDATA16_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA17,8'h00,rd_SOC_FLASH_TRIMDATA17_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA18,8'h00,rd_SOC_FLASH_TRIMDATA18_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA19,8'h00,rd_SOC_FLASH_TRIMDATA19_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA20,8'h00,rd_SOC_FLASH_TRIMDATA20_reg);

   if(rd_SOC_FLASH_TRIMDATA0_reg   !== `SOC_FLASH_TRIMDATA0_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA0] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA0_reg, 8'h5a)); end
   if(rd_SOC_FLASH_TRIMDATA1_reg   !== `SOC_FLASH_TRIMDATA1_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA1] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA1_reg, 8'h10)); end
   if(rd_SOC_FLASH_TRIMDATA2_reg   !== `SOC_FLASH_TRIMDATA2_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA2] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA2_reg, 8'h40)); end
   if(rd_SOC_FLASH_TRIMDATA3_reg   !== `SOC_FLASH_TRIMDATA3_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA3] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA3_reg, 8'h02)); end
   if(rd_SOC_FLASH_TRIMDATA4_reg   !== `SOC_FLASH_TRIMDATA4_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA4] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA4_reg, 8'h20)); end
   if(rd_SOC_FLASH_TRIMDATA5_reg   !== `SOC_FLASH_TRIMDATA5_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA5] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA5_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA6_reg   !== `SOC_FLASH_TRIMDATA6_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA6] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA6_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA7_reg   !== `SOC_FLASH_TRIMDATA7_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA7] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA7_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA8_reg   !== `SOC_FLASH_TRIMDATA8_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA8] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA8_reg, 8'h04)); end
   if(rd_SOC_FLASH_TRIMDATA9_reg   !== `SOC_FLASH_TRIMDATA9_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA9] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA9_reg, 8'h04)); end
   if(rd_SOC_FLASH_TRIMDATA10_reg  !== `SOC_FLASH_TRIMDATA10_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA10] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA10_reg, 8'h01)); end
   if(rd_SOC_FLASH_TRIMDATA11_reg  !== `SOC_FLASH_TRIMDATA11_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA11] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA11_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA12_reg  !== `SOC_FLASH_TRIMDATA12_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA12] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA12_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA13_reg  !== `SOC_FLASH_TRIMDATA13_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA13] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA13_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA14_reg  !== `SOC_FLASH_TRIMDATA14_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA14] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA14_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA15_reg  !== `SOC_FLASH_TRIMDATA15_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA15] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA15_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA16_reg  !== `SOC_FLASH_TRIMDATA16_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA16] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA16_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA17_reg  !== `SOC_FLASH_TRIMDATA17_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA17] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA17_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA18_reg  !== `SOC_FLASH_TRIMDATA18_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA18] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA18_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA19_reg  !== `SOC_FLASH_TRIMDATA19_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA19] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA19_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA20_reg  !== `SOC_FLASH_TRIMDATA20_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA20] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA20_reg, 8'h00)); end


   if(`ANA_TOP.D2A_BGH_VTRIM[4:0]  !== 5'h10) begin `uvm_error("", $sformatf("\t[ERROR] [BGH VTRIM] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BGH_VTRIM[4:0], 5'h10)); end  
   if(`ANA_TOP.D2A_BGH_CTRIM[6:0] !== 7'h40) begin `uvm_error("", $sformatf("\t[ERROR] [BGH CTRIM] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BGH_CTRIM[6:0], 7'h40)); end 
   if(`ANA_TOP.D2A_LDO1V5_VTRIM[1:0] !== 2'h2) begin `uvm_error("", $sformatf("\t[ERROR] [LDO1V5_VRIM] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_LDO1V5_VTRIM[1:0], 2'h2)); end 
   if(`ANA_TOP.D2A_OSC_TRIM[5:0] !== 6'h20) begin `uvm_error("", $sformatf("\t[ERROR] [OSC_TRIM] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_OSC_TRIM[5:0], 6'h20)); end
   if(`ANA_TOP.D2A_SPARE_TRIM0 !== 8'h00) begin `uvm_error("", $sformatf("\t[ERROR] [D2A_SPARE_TRIM0] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_SPARE_TRIM0, 8'h00)); end 
   if(`ANA_TOP.D2A_SPARE_TRIM1 !== 8'h00) begin `uvm_error("", $sformatf("\t[ERROR] [D2A_SPARE_TRIM1] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_SPARE_TRIM1, 8'h00)); end
   if(`ANA_TOP.D2A_SPARE_TRIM2 !== 8'h00) begin `uvm_error("", $sformatf("\t[ERROR] [D2A_SPARE_TRIM2] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_SPARE_TRIM2, 8'h00)); end 
   if(`ANA_TOP.D2A_SPARE_TRIM3 !== 8'h00) begin `uvm_error("", $sformatf("\t[ERROR] [D2A_SPARE_TRIM3] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_SPARE_TRIM3, 8'h00)); end
   if(`ANA_TOP.D2A_SPARE_TRIM_SW0 !== 8'h00) begin `uvm_error("", $sformatf("\t[ERROR] [D2A_SPARE_TRIM_SW0] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_SPARE_TRIM_SW0, 8'h00)); end 
   //if(`ANA_TOP.D2A_SPARE_TRIM_SW1 !== 8'h00) begin `uvm_error("", $sformatf("\t[ERROR] [D2A_SPARE_TRIM_SW1] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_SPARE_TRIM_SW1, 8'h00)); end

// penging trim 11 12 13 14 15 


   //========================================================================================//
   // commented by ophina as it is removed in BAF4P1
   //========================================================================================//

    `RD_NORMAL_REG(`SOC_ANA_BIST, 8'h00, ana_bist);  
    if(ana_bist !== 8'd0) begin `uvm_error("", $sformatf("\t[ERROR] [ana_bist] The value read: %h is not as expected value: %h", ana_bist, 8'h0)); end  
    if(`ANA_TOP.D2A_BIST_EN !== 1'b0) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BIST_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BIST_EN, 1'h0)); end
    if(`ANA_TOP.D2A_BIST_ISEL[2:0] !== 3'b0) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BIST_ISEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BIST_ISEL[2:0], 3'h0)); end           

   //========================================================================================//
   // commented by ophina as it is removed in BAF4P1
   //========================================================================================//
                      
    `RD_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM1, 8'h00,    rd_ALWAYS_ON_ANA_TRIM2); 
    if(rd_ALWAYS_ON_ANA_TRIM2 !== 8'h10) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ALWAYS_ON_ANA_TRIM2] The value read: %h is not as expected value: %h", rd_ALWAYS_ON_ANA_TRIM2, 8'h10)); end 
       
    `RD_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM2, 8'h00,    rd_ALWAYS_ON_ANA_TRIM1);
    if(rd_ALWAYS_ON_ANA_TRIM1 !== 8'h40) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ALWAYS_ON_ANA_TRIM1] The value read: %h is not as expected value: %h", rd_ALWAYS_ON_ANA_TRIM1, 8'h40)); end 
         
    `RD_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM3, 8'h00, rd_ALWAYS_ON_ANA_TRIM3);
    if(rd_ALWAYS_ON_ANA_TRIM3 !== 8'h02) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ALWAYS_ON_ANA_TRIM3] The value read: %h is not as expected value: %h", rd_ALWAYS_ON_ANA_TRIM3, 8'h02)); end 
        
    `RD_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM4,8'h00,      rd_ALWAYS_ON_ANA_TRIM4);
    if(rd_ALWAYS_ON_ANA_TRIM4 !== 8'h20) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ALWAYS_ON_ANA_TRIM4] The value read: %h is not as expected value: %h", rd_ALWAYS_ON_ANA_TRIM4, 8'h20)); end  
end   
endtask 

task do_run_check_default_io_signals;
     
       
//IO CELLS
    `ifdef POSTSCAN
          o_IOBUF_Y = {
			`SOC_TOP.u_iopad_gpio_18_.Y,
		        `SOC_TOP.u_iopad_gpio_17_.Y,
			`SOC_TOP.u_iopad_gpio_16_.Y,
			`SOC_TOP.u_iopad_gpio_15_.Y,
			`SOC_TOP.u_iopad_gpio_14_.Y,
			`SOC_TOP.u_iopad_gpio_13_.Y,
			`SOC_TOP.u_iopad_gpio_12_.Y,
			`SOC_TOP.u_iopad_gpio_11_.Y,
			`SOC_TOP.u_iopad_gpio_10_.Y,
			`SOC_TOP.u_iopad_gpio_9_.Y,
			`SOC_TOP.u_iopad_gpio_8_.Y,
			`SOC_TOP.u_iopad_gpio_7_.Y,
			`SOC_TOP.u_iopad_gpio_6_.Y,
			`SOC_TOP.u_iopad_gpio_5_.Y,
			`SOC_TOP.u_iopad_gpio_4_.Y,
			`SOC_TOP.u_iopad_gpio_3_.Y,
			`SOC_TOP.u_iopad_gpio_2_.Y,
			`SOC_TOP.u_iopad_gpio_1_.Y,
			`SOC_TOP.u_iopad_gpio_0_.Y};

  	 o_IOBUF_IE = { 
			`SOC_TOP.u_iopad_gpio_18_.IE,
		        `SOC_TOP.u_iopad_gpio_17_.IE,
			`SOC_TOP.u_iopad_gpio_16_.IE,
			`SOC_TOP.u_iopad_gpio_15_.IE,
			`SOC_TOP.u_iopad_gpio_14_.IE,
			`SOC_TOP.u_iopad_gpio_13_.IE,
			`SOC_TOP.u_iopad_gpio_12_.IE,
			`SOC_TOP.u_iopad_gpio_11_.IE,
			`SOC_TOP.u_iopad_gpio_10_.IE,
			`SOC_TOP.u_iopad_gpio_9_.IE,
			`SOC_TOP.u_iopad_gpio_8_.IE,
			`SOC_TOP.u_iopad_gpio_7_.IE,
			`SOC_TOP.u_iopad_gpio_6_.IE,
			`SOC_TOP.u_iopad_gpio_5_.IE,
			`SOC_TOP.u_iopad_gpio_4_.IE,
			`SOC_TOP.u_iopad_gpio_3_.IE,
			`SOC_TOP.u_iopad_gpio_2_.IE,
			`SOC_TOP.u_iopad_gpio_1_.IE,
			`SOC_TOP.u_iopad_gpio_0_.IE};


 	 o_IOBUF_CS= {   
			`SOC_TOP.u_iopad_gpio_18_.CS,
		        `SOC_TOP.u_iopad_gpio_17_.CS,
			`SOC_TOP.u_iopad_gpio_16_.CS,
			`SOC_TOP.u_iopad_gpio_15_.CS,
			`SOC_TOP.u_iopad_gpio_14_.CS,
			`SOC_TOP.u_iopad_gpio_13_.CS,
			`SOC_TOP.u_iopad_gpio_12_.CS,
			`SOC_TOP.u_iopad_gpio_11_.CS,
			`SOC_TOP.u_iopad_gpio_10_.CS,
			`SOC_TOP.u_iopad_gpio_9_.CS,
			`SOC_TOP.u_iopad_gpio_8_.CS,
			`SOC_TOP.u_iopad_gpio_7_.CS,
			`SOC_TOP.u_iopad_gpio_6_.CS,
			`SOC_TOP.u_iopad_gpio_5_.CS,
			`SOC_TOP.u_iopad_gpio_4_.CS,
			`SOC_TOP.u_iopad_gpio_3_.CS,
			`SOC_TOP.u_iopad_gpio_2_.CS,
			`SOC_TOP.u_iopad_gpio_1_.CS,
			`SOC_TOP.u_iopad_gpio_0_.CS};

 	 o_IOBUF_PU= {   
			`SOC_TOP.u_iopad_gpio_18_.PU,
		        `SOC_TOP.u_iopad_gpio_17_.PU,
			`SOC_TOP.u_iopad_gpio_16_.PU,
			`SOC_TOP.u_iopad_gpio_15_.PU,
			`SOC_TOP.u_iopad_gpio_14_.PU,
			`SOC_TOP.u_iopad_gpio_13_.PU,
			`SOC_TOP.u_iopad_gpio_12_.PU,
			`SOC_TOP.u_iopad_gpio_11_.PU,
			`SOC_TOP.u_iopad_gpio_10_.PU,
			`SOC_TOP.u_iopad_gpio_9_.PU,
			`SOC_TOP.u_iopad_gpio_8_.PU,
			`SOC_TOP.u_iopad_gpio_7_.PU,
			`SOC_TOP.u_iopad_gpio_6_.PU,
			`SOC_TOP.u_iopad_gpio_5_.PU,
			`SOC_TOP.u_iopad_gpio_4_.PU,
			`SOC_TOP.u_iopad_gpio_3_.PU,
			`SOC_TOP.u_iopad_gpio_2_.PU,
			`SOC_TOP.u_iopad_gpio_1_.PU,
			`SOC_TOP.u_iopad_gpio_0_.PU};

 	 o_IOBUF_SR= {   
			`SOC_TOP.u_iopad_gpio_18_.SR,
		    `SOC_TOP.u_iopad_gpio_17_.SR,
			`SOC_TOP.u_iopad_gpio_16_.SR,
			`SOC_TOP.u_iopad_gpio_15_.SR,
			`SOC_TOP.u_iopad_gpio_14_.SR,
			`SOC_TOP.u_iopad_gpio_13_.SR,
			`SOC_TOP.u_iopad_gpio_12_.SR,
			`SOC_TOP.u_iopad_gpio_11_.SR,
			`SOC_TOP.u_iopad_gpio_10_.SR,
			`SOC_TOP.u_iopad_gpio_9_.SR,
			`SOC_TOP.u_iopad_gpio_8_.SR,
			`SOC_TOP.u_iopad_gpio_7_.SR,
			`SOC_TOP.u_iopad_gpio_6_.SR,
			`SOC_TOP.u_iopad_gpio_5_.SR,
			`SOC_TOP.u_iopad_gpio_4_.SR,
			`SOC_TOP.u_iopad_gpio_3_.SR,
			`SOC_TOP.u_iopad_gpio_2_.SR,
			`SOC_TOP.u_iopad_gpio_1_.SR,
			`SOC_TOP.u_iopad_gpio_0_.SR};

 	 o_IOBUF_DR= {   
			`SOC_TOP.u_iopad_gpio_18_.DR,
		        `SOC_TOP.u_iopad_gpio_17_.DR,
			`SOC_TOP.u_iopad_gpio_16_.DR,
			`SOC_TOP.u_iopad_gpio_15_.DR,
			`SOC_TOP.u_iopad_gpio_14_.DR,
			`SOC_TOP.u_iopad_gpio_13_.DR,
			`SOC_TOP.u_iopad_gpio_12_.DR,
			`SOC_TOP.u_iopad_gpio_11_.DR,
			`SOC_TOP.u_iopad_gpio_10_.DR,
			`SOC_TOP.u_iopad_gpio_9_.DR,
			`SOC_TOP.u_iopad_gpio_8_.DR,
			`SOC_TOP.u_iopad_gpio_7_.DR,
			`SOC_TOP.u_iopad_gpio_6_.DR,
			`SOC_TOP.u_iopad_gpio_5_.DR,
			`SOC_TOP.u_iopad_gpio_4_.DR,
			`SOC_TOP.u_iopad_gpio_3_.DR,
			`SOC_TOP.u_iopad_gpio_2_.DR,
			`SOC_TOP.u_iopad_gpio_1_.DR,
			`SOC_TOP.u_iopad_gpio_0_.DR};

 	 o_IOBUF_A = {   
			`SOC_TOP.u_iopad_gpio_18_.A,
		        `SOC_TOP.u_iopad_gpio_17_.A,
			`SOC_TOP.u_iopad_gpio_16_.A,
			`SOC_TOP.u_iopad_gpio_15_.A,
			`SOC_TOP.u_iopad_gpio_14_.A,
			`SOC_TOP.u_iopad_gpio_13_.A,
			`SOC_TOP.u_iopad_gpio_12_.A,
			`SOC_TOP.u_iopad_gpio_11_.A,
			`SOC_TOP.u_iopad_gpio_10_.A,
			`SOC_TOP.u_iopad_gpio_9_.A,
			`SOC_TOP.u_iopad_gpio_8_.A,
			`SOC_TOP.u_iopad_gpio_7_.A,
			`SOC_TOP.u_iopad_gpio_6_.A,
			`SOC_TOP.u_iopad_gpio_5_.A,
			`SOC_TOP.u_iopad_gpio_4_.A,
			`SOC_TOP.u_iopad_gpio_3_.A,
			`SOC_TOP.u_iopad_gpio_2_.A,
			`SOC_TOP.u_iopad_gpio_1_.A,
			`SOC_TOP.u_iopad_gpio_0_.A};

 	 o_IOBUF_OE= {   
			`SOC_TOP.u_iopad_gpio_18_.OE,
		        `SOC_TOP.u_iopad_gpio_17_.OE,
			`SOC_TOP.u_iopad_gpio_16_.OE,
			`SOC_TOP.u_iopad_gpio_15_.OE,
			`SOC_TOP.u_iopad_gpio_14_.OE,
			`SOC_TOP.u_iopad_gpio_13_.OE,
			`SOC_TOP.u_iopad_gpio_12_.OE,
			`SOC_TOP.u_iopad_gpio_11_.OE,
			`SOC_TOP.u_iopad_gpio_10_.OE,
			`SOC_TOP.u_iopad_gpio_9_.OE,
			`SOC_TOP.u_iopad_gpio_8_.OE,
			`SOC_TOP.u_iopad_gpio_7_.OE,
			`SOC_TOP.u_iopad_gpio_6_.OE,
			`SOC_TOP.u_iopad_gpio_5_.OE,
			`SOC_TOP.u_iopad_gpio_4_.OE,
			`SOC_TOP.u_iopad_gpio_3_.OE,
			`SOC_TOP.u_iopad_gpio_2_.OE,
			`SOC_TOP.u_iopad_gpio_1_.OE,
			`SOC_TOP.u_iopad_gpio_0_.OE};

 	 o_IOBUF_OS= {   
			`SOC_TOP.u_iopad_gpio_18_.OS,
		        `SOC_TOP.u_iopad_gpio_17_.OS,
			`SOC_TOP.u_iopad_gpio_16_.OS,
			`SOC_TOP.u_iopad_gpio_15_.OS,
			`SOC_TOP.u_iopad_gpio_14_.OS,
			`SOC_TOP.u_iopad_gpio_13_.OS,
			`SOC_TOP.u_iopad_gpio_12_.OS,
			`SOC_TOP.u_iopad_gpio_11_.OS,
			`SOC_TOP.u_iopad_gpio_10_.OS,
			`SOC_TOP.u_iopad_gpio_9_.OS,
			`SOC_TOP.u_iopad_gpio_8_.OS,
			`SOC_TOP.u_iopad_gpio_7_.OS,
			`SOC_TOP.u_iopad_gpio_6_.OS,
			`SOC_TOP.u_iopad_gpio_5_.OS,
			`SOC_TOP.u_iopad_gpio_4_.OS,
			`SOC_TOP.u_iopad_gpio_3_.OS,
			`SOC_TOP.u_iopad_gpio_2_.OS,
			`SOC_TOP.u_iopad_gpio_1_.OS,
			`SOC_TOP.u_iopad_gpio_0_.OS};

 	 o_IOBUF_OD= {   
			`SOC_TOP.u_iopad_gpio_18_.OD,
		        `SOC_TOP.u_iopad_gpio_17_.OD,
			`SOC_TOP.u_iopad_gpio_16_.OD,
			`SOC_TOP.u_iopad_gpio_15_.OD,
			`SOC_TOP.u_iopad_gpio_14_.OD,
			`SOC_TOP.u_iopad_gpio_13_.OD,
			`SOC_TOP.u_iopad_gpio_12_.OD,
			`SOC_TOP.u_iopad_gpio_11_.OD,
			`SOC_TOP.u_iopad_gpio_10_.OD,
			`SOC_TOP.u_iopad_gpio_9_.OD,
			`SOC_TOP.u_iopad_gpio_8_.OD,
			`SOC_TOP.u_iopad_gpio_7_.OD,
			`SOC_TOP.u_iopad_gpio_6_.OD,
			`SOC_TOP.u_iopad_gpio_5_.OD,
			`SOC_TOP.u_iopad_gpio_4_.OD,
			`SOC_TOP.u_iopad_gpio_3_.OD,
			`SOC_TOP.u_iopad_gpio_2_.OD,
			`SOC_TOP.u_iopad_gpio_1_.OD,
			`SOC_TOP.u_iopad_gpio_0_.OD};

 	 o_IOBUF_PD= {   
			`SOC_TOP.u_iopad_gpio_18_.PD,
		        `SOC_TOP.u_iopad_gpio_17_.PD,
			`SOC_TOP.u_iopad_gpio_16_.PD,
			`SOC_TOP.u_iopad_gpio_15_.PD,
			`SOC_TOP.u_iopad_gpio_14_.PD,
			`SOC_TOP.u_iopad_gpio_13_.PD,
			`SOC_TOP.u_iopad_gpio_12_.PD,
			`SOC_TOP.u_iopad_gpio_11_.PD,
			`SOC_TOP.u_iopad_gpio_10_.PD,
			`SOC_TOP.u_iopad_gpio_9_.PD,
			`SOC_TOP.u_iopad_gpio_8_.PD,
			`SOC_TOP.u_iopad_gpio_7_.PD,
			`SOC_TOP.u_iopad_gpio_6_.PD,
			`SOC_TOP.u_iopad_gpio_5_.PD,
			`SOC_TOP.u_iopad_gpio_4_.PD,
			`SOC_TOP.u_iopad_gpio_3_.PD,
			`SOC_TOP.u_iopad_gpio_2_.PD,
			`SOC_TOP.u_iopad_gpio_1_.PD,
			`SOC_TOP.u_iopad_gpio_0_.PD};

        if(o_IOBUF_IE !== 19'h0_0007) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_IE] The value read: %h is not as expected value: %h", o_IOBUF_IE, 19'h0_0007)); end
    	if(o_IOBUF_CS !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_CS] The value read: %h is not as expected value: %h", o_IOBUF_CS, 19'h0_0000)); end
       `ifdef POSTLAYOUT
    	if(o_IOBUF_PU !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_PU] The value read: %h is not as expected value: %h", o_IOBUF_PU, 19'h0_0000)); end// default PU of spi pins updated to 0 only in postlayout
       `else
    	if(o_IOBUF_PU !== 19'h0_0007) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_PU] The value read: %h is not as expected value: %h", o_IOBUF_PU, 19'h0_0007)); end
       `endif
    	if(o_IOBUF_SR !== 19'h7_FFFF) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_SR] The value read: %h is not as expected value: %h", o_IOBUF_SR, 19'h7_FFFF)); end
    	if(o_IOBUF_DR !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_DR] The value read: %h is not as expected value: %h", o_IOBUF_DR, 19'h0_0000)); end
    	if(o_IOBUF_A  !== 19'h0_0800) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_A]  The value read: %h is not as expected value: %h", o_IOBUF_A, 19'h0_0800)); end 
    	if(o_IOBUF_OE !== 19'h4_1810) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OE] The value read: %h is not as expected value: %h", o_IOBUF_OE, 19'h4_1810)); end
    	if(o_IOBUF_OS !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OS] The value read: %h is not as expected value: %h", o_IOBUF_OS, 19'h0_0000)); end
    	if(o_IOBUF_OD !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OD] The value read: %h is not as expected value: %h", o_IOBUF_OD, 19'h0_0000)); end
    	if(o_IOBUF_PD !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_PD] The value read: %h is not as expected value: %h", o_IOBUF_PD, 19'h0_0000)); end
        if(`SOC_TOP.u_iopad_testmode0.IE  !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.IE, 1'h1)); end
     	if(`SOC_TOP.u_iopad_testmode0.PD  !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.PD, 1'h1)); end
    	if(`SOC_TOP.u_iopad_testmode0.PU  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.PU, 1'h0)); end
	if(`SOC_TOP.u_iopad_testmode1.IE !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.IE, 1'h1)); end
    	if(`SOC_TOP.u_iopad_testmode1.PU !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.PU, 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.PD !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.PD, 1'h1)); end
	if(`SOC_TOP.u_iopad_exresetn.IE   !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.IE, 1'h1)); end
    	if(`SOC_TOP.u_iopad_exresetn.PD   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.PD, 1'h0)); end
    	if(`SOC_TOP.u_iopad_exresetn.PU   !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.PU, 1'h1)); end
	if(`SOC_TOP.u_iopad_testmode0.Y   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.Y, 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.Y  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.Y, 1'h0)); end
    	if(`SOC_TOP.u_iopad_exresetn.Y !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.Y, 1'h1)); end
        
    `else
        `ifdef BEHAVIORAL 
        if(`ALWAYSON_TOP.o_IOBUF_IE !== 19'h0_0007) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_IE] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_IE, 19'h0_0007)); end
    	if(`ALWAYSON_TOP.o_IOBUF_CS !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_CS] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_CS, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_PU !== 19'h0_0007) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_PU] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_PU, 19'h0_0007)); end
    	if(`ALWAYSON_TOP.o_IOBUF_SR !== 19'h7_FFFF) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_SR] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_SR, 19'h7_FFFF)); end
    	if(`ALWAYSON_TOP.o_IOBUF_DR !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_DR] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_DR, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_A  !== 19'h0_0800) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_A]  The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_A, 19'h0_0800)); end 
    	if(`ALWAYSON_TOP.o_IOBUF_OE !== 19'h4_1810) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OE] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_OE, 19'h4_1810)); end
    	if(`ALWAYSON_TOP.o_IOBUF_OS !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OS] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_OS, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_OD !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OD] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_OD, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_PD !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_PD] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_PD, 19'h0_0000)); end
        `else 
          o_IOBUF_Y = {
			`SOC_TOP.u_iopad_gpio_18_.Y,
		        `SOC_TOP.u_iopad_gpio_17_.Y,
			`SOC_TOP.u_iopad_gpio_16_.Y,
			`SOC_TOP.u_iopad_gpio_15_.Y,
			`SOC_TOP.u_iopad_gpio_14_.Y,
			`SOC_TOP.u_iopad_gpio_13_.Y,
			`SOC_TOP.u_iopad_gpio_12_.Y,
			`SOC_TOP.u_iopad_gpio_11_.Y,
			`SOC_TOP.u_iopad_gpio_10_.Y,
			`SOC_TOP.u_iopad_gpio_9_.Y,
			`SOC_TOP.u_iopad_gpio_8_.Y,
			`SOC_TOP.u_iopad_gpio_7_.Y,
			`SOC_TOP.u_iopad_gpio_6_.Y,
			`SOC_TOP.u_iopad_gpio_5_.Y,
			`SOC_TOP.u_iopad_gpio_4_.Y,
			`SOC_TOP.u_iopad_gpio_3_.Y,
			`SOC_TOP.u_iopad_gpio_2_.Y,
			`SOC_TOP.u_iopad_gpio_1_.Y,
			`SOC_TOP.u_iopad_gpio_0_.Y};

  	 o_IOBUF_IE = { 
			`SOC_TOP.u_iopad_gpio_18_.IE,
		        `SOC_TOP.u_iopad_gpio_17_.IE,
			`SOC_TOP.u_iopad_gpio_16_.IE,
			`SOC_TOP.u_iopad_gpio_15_.IE,
			`SOC_TOP.u_iopad_gpio_14_.IE,
			`SOC_TOP.u_iopad_gpio_13_.IE,
			`SOC_TOP.u_iopad_gpio_12_.IE,
			`SOC_TOP.u_iopad_gpio_11_.IE,
			`SOC_TOP.u_iopad_gpio_10_.IE,
			`SOC_TOP.u_iopad_gpio_9_.IE,
			`SOC_TOP.u_iopad_gpio_8_.IE,
			`SOC_TOP.u_iopad_gpio_7_.IE,
			`SOC_TOP.u_iopad_gpio_6_.IE,
			`SOC_TOP.u_iopad_gpio_5_.IE,
			`SOC_TOP.u_iopad_gpio_4_.IE,
			`SOC_TOP.u_iopad_gpio_3_.IE,
			`SOC_TOP.u_iopad_gpio_2_.IE,
			`SOC_TOP.u_iopad_gpio_1_.IE,
			`SOC_TOP.u_iopad_gpio_0_.IE};


 	 o_IOBUF_CS= {   
			`SOC_TOP.u_iopad_gpio_18_.CS,
		        `SOC_TOP.u_iopad_gpio_17_.CS,
			`SOC_TOP.u_iopad_gpio_16_.CS,
			`SOC_TOP.u_iopad_gpio_15_.CS,
			`SOC_TOP.u_iopad_gpio_14_.CS,
			`SOC_TOP.u_iopad_gpio_13_.CS,
			`SOC_TOP.u_iopad_gpio_12_.CS,
			`SOC_TOP.u_iopad_gpio_11_.CS,
			`SOC_TOP.u_iopad_gpio_10_.CS,
			`SOC_TOP.u_iopad_gpio_9_.CS,
			`SOC_TOP.u_iopad_gpio_8_.CS,
			`SOC_TOP.u_iopad_gpio_7_.CS,
			`SOC_TOP.u_iopad_gpio_6_.CS,
			`SOC_TOP.u_iopad_gpio_5_.CS,
			`SOC_TOP.u_iopad_gpio_4_.CS,
			`SOC_TOP.u_iopad_gpio_3_.CS,
			`SOC_TOP.u_iopad_gpio_2_.CS,
			`SOC_TOP.u_iopad_gpio_1_.CS,
			`SOC_TOP.u_iopad_gpio_0_.CS};

 	 o_IOBUF_PU= {   
			`SOC_TOP.u_iopad_gpio_18_.PU,
		        `SOC_TOP.u_iopad_gpio_17_.PU,
			`SOC_TOP.u_iopad_gpio_16_.PU,
			`SOC_TOP.u_iopad_gpio_15_.PU,
			`SOC_TOP.u_iopad_gpio_14_.PU,
			`SOC_TOP.u_iopad_gpio_13_.PU,
			`SOC_TOP.u_iopad_gpio_12_.PU,
			`SOC_TOP.u_iopad_gpio_11_.PU,
			`SOC_TOP.u_iopad_gpio_10_.PU,
			`SOC_TOP.u_iopad_gpio_9_.PU,
			`SOC_TOP.u_iopad_gpio_8_.PU,
			`SOC_TOP.u_iopad_gpio_7_.PU,
			`SOC_TOP.u_iopad_gpio_6_.PU,
			`SOC_TOP.u_iopad_gpio_5_.PU,
			`SOC_TOP.u_iopad_gpio_4_.PU,
			`SOC_TOP.u_iopad_gpio_3_.PU,
			`SOC_TOP.u_iopad_gpio_2_.PU,
			`SOC_TOP.u_iopad_gpio_1_.PU,
			`SOC_TOP.u_iopad_gpio_0_.PU};

 	 o_IOBUF_SR= {   
			`SOC_TOP.u_iopad_gpio_18_.SR,
		        `SOC_TOP.u_iopad_gpio_17_.SR,
			`SOC_TOP.u_iopad_gpio_16_.SR,
			`SOC_TOP.u_iopad_gpio_15_.SR,
			`SOC_TOP.u_iopad_gpio_14_.SR,
			`SOC_TOP.u_iopad_gpio_13_.SR,
			`SOC_TOP.u_iopad_gpio_12_.SR,
			`SOC_TOP.u_iopad_gpio_11_.SR,
			`SOC_TOP.u_iopad_gpio_10_.SR,
			`SOC_TOP.u_iopad_gpio_9_.SR,
			`SOC_TOP.u_iopad_gpio_8_.SR,
			`SOC_TOP.u_iopad_gpio_7_.SR,
			`SOC_TOP.u_iopad_gpio_6_.SR,
			`SOC_TOP.u_iopad_gpio_5_.SR,
			`SOC_TOP.u_iopad_gpio_4_.SR,
			`SOC_TOP.u_iopad_gpio_3_.SR,
			`SOC_TOP.u_iopad_gpio_2_.SR,
			`SOC_TOP.u_iopad_gpio_1_.SR,
			`SOC_TOP.u_iopad_gpio_0_.SR};

 	 o_IOBUF_DR= {   
			`SOC_TOP.u_iopad_gpio_18_.DR,
		        `SOC_TOP.u_iopad_gpio_17_.DR,
			`SOC_TOP.u_iopad_gpio_16_.DR,
			`SOC_TOP.u_iopad_gpio_15_.DR,
			`SOC_TOP.u_iopad_gpio_14_.DR,
			`SOC_TOP.u_iopad_gpio_13_.DR,
			`SOC_TOP.u_iopad_gpio_12_.DR,
			`SOC_TOP.u_iopad_gpio_11_.DR,
			`SOC_TOP.u_iopad_gpio_10_.DR,
			`SOC_TOP.u_iopad_gpio_9_.DR,
			`SOC_TOP.u_iopad_gpio_8_.DR,
			`SOC_TOP.u_iopad_gpio_7_.DR,
			`SOC_TOP.u_iopad_gpio_6_.DR,
			`SOC_TOP.u_iopad_gpio_5_.DR,
			`SOC_TOP.u_iopad_gpio_4_.DR,
			`SOC_TOP.u_iopad_gpio_3_.DR,
			`SOC_TOP.u_iopad_gpio_2_.DR,
			`SOC_TOP.u_iopad_gpio_1_.DR,
			`SOC_TOP.u_iopad_gpio_0_.DR};

 	 o_IOBUF_A = {   
			`SOC_TOP.u_iopad_gpio_18_.A,
		        `SOC_TOP.u_iopad_gpio_17_.A,
			`SOC_TOP.u_iopad_gpio_16_.A,
			`SOC_TOP.u_iopad_gpio_15_.A,
			`SOC_TOP.u_iopad_gpio_14_.A,
			`SOC_TOP.u_iopad_gpio_13_.A,
			`SOC_TOP.u_iopad_gpio_12_.A,
			`SOC_TOP.u_iopad_gpio_11_.A,
			`SOC_TOP.u_iopad_gpio_10_.A,
			`SOC_TOP.u_iopad_gpio_9_.A,
			`SOC_TOP.u_iopad_gpio_8_.A,
			`SOC_TOP.u_iopad_gpio_7_.A,
			`SOC_TOP.u_iopad_gpio_6_.A,
			`SOC_TOP.u_iopad_gpio_5_.A,
			`SOC_TOP.u_iopad_gpio_4_.A,
			`SOC_TOP.u_iopad_gpio_3_.A,
			`SOC_TOP.u_iopad_gpio_2_.A,
			`SOC_TOP.u_iopad_gpio_1_.A,
			`SOC_TOP.u_iopad_gpio_0_.A};

 	 o_IOBUF_OE= {   
			`SOC_TOP.u_iopad_gpio_18_.OE,
		        `SOC_TOP.u_iopad_gpio_17_.OE,
			`SOC_TOP.u_iopad_gpio_16_.OE,
			`SOC_TOP.u_iopad_gpio_15_.OE,
			`SOC_TOP.u_iopad_gpio_14_.OE,
			`SOC_TOP.u_iopad_gpio_13_.OE,
			`SOC_TOP.u_iopad_gpio_12_.OE,
			`SOC_TOP.u_iopad_gpio_11_.OE,
			`SOC_TOP.u_iopad_gpio_10_.OE,
			`SOC_TOP.u_iopad_gpio_9_.OE,
			`SOC_TOP.u_iopad_gpio_8_.OE,
			`SOC_TOP.u_iopad_gpio_7_.OE,
			`SOC_TOP.u_iopad_gpio_6_.OE,
			`SOC_TOP.u_iopad_gpio_5_.OE,
			`SOC_TOP.u_iopad_gpio_4_.OE,
			`SOC_TOP.u_iopad_gpio_3_.OE,
			`SOC_TOP.u_iopad_gpio_2_.OE,
			`SOC_TOP.u_iopad_gpio_1_.OE,
			`SOC_TOP.u_iopad_gpio_0_.OE};

 	 o_IOBUF_OS= {   
			`SOC_TOP.u_iopad_gpio_18_.OS,
		        `SOC_TOP.u_iopad_gpio_17_.OS,
			`SOC_TOP.u_iopad_gpio_16_.OS,
			`SOC_TOP.u_iopad_gpio_15_.OS,
			`SOC_TOP.u_iopad_gpio_14_.OS,
			`SOC_TOP.u_iopad_gpio_13_.OS,
			`SOC_TOP.u_iopad_gpio_12_.OS,
			`SOC_TOP.u_iopad_gpio_11_.OS,
			`SOC_TOP.u_iopad_gpio_10_.OS,
			`SOC_TOP.u_iopad_gpio_9_.OS,
			`SOC_TOP.u_iopad_gpio_8_.OS,
			`SOC_TOP.u_iopad_gpio_7_.OS,
			`SOC_TOP.u_iopad_gpio_6_.OS,
			`SOC_TOP.u_iopad_gpio_5_.OS,
			`SOC_TOP.u_iopad_gpio_4_.OS,
			`SOC_TOP.u_iopad_gpio_3_.OS,
			`SOC_TOP.u_iopad_gpio_2_.OS,
			`SOC_TOP.u_iopad_gpio_1_.OS,
			`SOC_TOP.u_iopad_gpio_0_.OS};

 	 o_IOBUF_OD= {   
			`SOC_TOP.u_iopad_gpio_18_.OD,
		        `SOC_TOP.u_iopad_gpio_17_.OD,
			`SOC_TOP.u_iopad_gpio_16_.OD,
			`SOC_TOP.u_iopad_gpio_15_.OD,
			`SOC_TOP.u_iopad_gpio_14_.OD,
			`SOC_TOP.u_iopad_gpio_13_.OD,
			`SOC_TOP.u_iopad_gpio_12_.OD,
			`SOC_TOP.u_iopad_gpio_11_.OD,
			`SOC_TOP.u_iopad_gpio_10_.OD,
			`SOC_TOP.u_iopad_gpio_9_.OD,
			`SOC_TOP.u_iopad_gpio_8_.OD,
			`SOC_TOP.u_iopad_gpio_7_.OD,
			`SOC_TOP.u_iopad_gpio_6_.OD,
			`SOC_TOP.u_iopad_gpio_5_.OD,
			`SOC_TOP.u_iopad_gpio_4_.OD,
			`SOC_TOP.u_iopad_gpio_3_.OD,
			`SOC_TOP.u_iopad_gpio_2_.OD,
			`SOC_TOP.u_iopad_gpio_1_.OD,
			`SOC_TOP.u_iopad_gpio_0_.OD};

 	 o_IOBUF_PD= {   
			`SOC_TOP.u_iopad_gpio_18_.PD,
		        `SOC_TOP.u_iopad_gpio_17_.PD,
			`SOC_TOP.u_iopad_gpio_16_.PD,
			`SOC_TOP.u_iopad_gpio_15_.PD,
			`SOC_TOP.u_iopad_gpio_14_.PD,
			`SOC_TOP.u_iopad_gpio_13_.PD,
			`SOC_TOP.u_iopad_gpio_12_.PD,
			`SOC_TOP.u_iopad_gpio_11_.PD,
			`SOC_TOP.u_iopad_gpio_10_.PD,
			`SOC_TOP.u_iopad_gpio_9_.PD,
			`SOC_TOP.u_iopad_gpio_8_.PD,
			`SOC_TOP.u_iopad_gpio_7_.PD,
			`SOC_TOP.u_iopad_gpio_6_.PD,
			`SOC_TOP.u_iopad_gpio_5_.PD,
			`SOC_TOP.u_iopad_gpio_4_.PD,
			`SOC_TOP.u_iopad_gpio_3_.PD,
			`SOC_TOP.u_iopad_gpio_2_.PD,
			`SOC_TOP.u_iopad_gpio_1_.PD,
			`SOC_TOP.u_iopad_gpio_0_.PD};

        /*if(o_IOBUF_IE !== 19'h0_0007) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_IE] The value read: %h is not as expected value: %h", o_IOBUF_IE, 19'h0_0007)); end
    	if(o_IOBUF_CS !== 19'hz_zzzz) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_CS] The value read: %h is not as expected value: %h", o_IOBUF_CS, 19'hz_zzzz)); end
    	if(o_IOBUF_PU !== {16'hzzzz, 3'h7}) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_PU] The value read: %h is not as expected value: %h", o_IOBUF_PU, {16'hzzzz, 3'h7})); end
    	if(o_IOBUF_SR !== 19'h7_FFFF) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_SR] The value read: %h is not as expected value: %h", o_IOBUF_SR, 19'h7_FFFF)); end
    	if(o_IOBUF_DR !== 19'hz_zzzz) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_DR] The value read: %h is not as expected value: %h", o_IOBUF_DR, 19'hz_zzzz)); end
    	if(o_IOBUF_A  !== 19'h0_0800) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_A]  The value read: %h is not as expected value: %h", o_IOBUF_A, 19'h0_0800)); end 
    	if(o_IOBUF_OE !== 19'h4_1810) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OE] The value read: %h is not as expected value: %h", o_IOBUF_OE, 19'h4_1810)); end
    	if(o_IOBUF_OS !== 19'hz_zzzz) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OS] The value read: %h is not as expected value: %h", o_IOBUF_OS, 19'hz_zzzz)); end
    	if(o_IOBUF_OD !== 19'hz_zzzz) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OD] The value read: %h is not as expected value: %h", o_IOBUF_OD, 19'hz_zzzz)); end
    	if(o_IOBUF_PD !== 19'hz_zzzz) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_PD] The value read: %h is not as expected value: %h", o_IOBUF_PD, 19'hz_zzzz)); end*/
        if(o_IOBUF_IE !== 19'h0_0007) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_IE] The value read: %h is not as expected value: %h", o_IOBUF_IE, 19'h0_0007)); end 
    	if(o_IOBUF_CS !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_CS] The value read: %h is not as expected value: %h", o_IOBUF_CS, 19'h0_0000)); end
    	if(o_IOBUF_PU !== 19'h0_0007) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_PU] The value read: %h is not as expected value: %h", o_IOBUF_PU, 19'h0_0007)); end
    	if(o_IOBUF_SR !== 19'h7_FFFF) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_SR] The value read: %h is not as expected value: %h", o_IOBUF_SR, 19'h7_FFFF)); end
    	if(o_IOBUF_DR !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_DR] The value read: %h is not as expected value: %h", o_IOBUF_DR, 19'h0_0000)); end
    	if(o_IOBUF_A  !== 19'h0_0800) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_A] The value read: %h is not as expected value: %h ", o_IOBUF_A, 19'h0_0800)); end 
    	if(o_IOBUF_OE !== 19'h4_1810) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OE] The value read: %h is not as expected value: %h", o_IOBUF_OE, 19'h4_1810)); end
    	if(o_IOBUF_OS !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OS] The value read: %h is not as expected value: %h", o_IOBUF_OS, 19'h0_0000)); end
    	if(o_IOBUF_OD !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OD] The value read: %h is not as expected value: %h", o_IOBUF_OD, 19'h0_0000)); end
    	if(o_IOBUF_PD !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_PD] The value read: %h is not as expected value: %h", o_IOBUF_PD, 19'h0_0000)); end

        if(`SOC_TOP.u_iopad_testmode0.IE  !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.IE, 1'h1)); end
     	if(`SOC_TOP.u_iopad_testmode0.PD  !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.PD, 1'h1)); end
    	if(`SOC_TOP.u_iopad_testmode0.PU  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.PU, 1'h0)); end
	if(`SOC_TOP.u_iopad_testmode1.IE !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.IE, 1'h1)); end
    	if(`SOC_TOP.u_iopad_testmode1.PU !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.PU, 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.PD !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.PD, 1'h1)); end
	if(`SOC_TOP.u_iopad_exresetn.IE   !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.IE, 1'h1)); end
    	if(`SOC_TOP.u_iopad_exresetn.PD   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.PD, 1'h0)); end
    	if(`SOC_TOP.u_iopad_exresetn.PU   !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.PU, 1'h1)); end
	if(`SOC_TOP.u_iopad_testmode0.Y   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.Y, 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.Y  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.Y, 1'h0)); end
    	if(`SOC_TOP.u_iopad_exresetn.Y !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.Y, 1'h1)); end
        `endif
    `endif

        if(`SOC_TOP.u_iopad_testmode0.IE  !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.IE, 1'h1)); end
     	if(`SOC_TOP.u_iopad_testmode0.PD  !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.PD, 1'h1)); end
    	if(`SOC_TOP.u_iopad_testmode0.PU  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.PU, 1'h0)); end
	if(`SOC_TOP.u_iopad_testmode1.IE !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.IE, 1'h1)); end
    	if(`SOC_TOP.u_iopad_testmode1.PU !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.PU, 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.PD !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.PD, 1'h1)); end
	if(`SOC_TOP.u_iopad_exresetn.IE   !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.IE, 1'h1)); end
    	if(`SOC_TOP.u_iopad_exresetn.PD   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.PD, 1'h0)); end
    	if(`SOC_TOP.u_iopad_exresetn.PU   !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.PU, 1'h1)); end
	if(`SOC_TOP.u_iopad_testmode0.Y   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.Y, 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.Y  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.Y, 1'h0)); end
    	if(`SOC_TOP.u_iopad_exresetn.Y !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.Y, 1'h1)); end
endtask

//================================================================================================//
//================================================================================================//
//================================================================================================//
//================================================================================================//

task do_run_spi_wr_rd_reg_val;

    #2000;
    //1. 
    `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b10,3'b000,3'b011},pads,mask); 
    `RD_NORMAL_REG(`SOC_CLK_CTRL_REG, 8'h00, rd_alwayson_clkctrl_reg);
    if(rd_alwayson_clkctrl_reg !== 8'h83) begin `uvm_error("", $sformatf("\t[ERROR] [SOC_CLK_CTRL_REG] The value read: %h is not as expected value: %h", rd_alwayson_clkctrl_reg, 8'h83)); end

    //========================================================================================//
    // commented by ophina as it is removed in BAF4P1
    //========================================================================================//
    //11.

    //========================================================================================//

    //21.          
    `WR_RD_CHK_NORMAL_REG(`SOC_ANA_BUFFER, {4'h1,4'h7}, pads, mask );
    `RD_NORMAL_REG(`SOC_ANA_BUFFER, 8'h00, ana_buffer);  
    if(ana_buffer !== 8'h17) begin `uvm_error("", $sformatf("\t[ERROR] [ana_bist] The value read: %h is not as expected value: %h", ana_buffer, 8'h17)); end

    //21.          
    `WR_RD_CHK_NORMAL_REG(`SOC_ANA_ECG_CTRL1, {4'hF,4'hF}, pads, mask );
    `RD_NORMAL_REG(`SOC_ANA_ECG_CTRL1, 8'h00, ana_ecg_ctrl1);  
    if(ana_ecg_ctrl1 !== 8'hFF) begin `uvm_error("", $sformatf("\t[ERROR] [ana_bist] The value read: %h is not as expected value: %h",ana_ecg_ctrl1, 8'hff)); end

    //21.          
    `WR_RD_CHK_NORMAL_REG(`SOC_ANA_ECG_CTRL2, {4'h7,4'hF}, pads, mask );
    `RD_NORMAL_REG(`SOC_ANA_ECG_CTRL2, 8'h00, ana_ecg_ctrl2);  
    if(ana_ecg_ctrl2 !== 8'h7F) begin `uvm_error("", $sformatf("\t[ERROR] [ana_bist] The value read: %h is not as expected value: %h", ana_ecg_ctrl2, 8'h7f)); end

    //21.          
    `WR_RD_CHK_NORMAL_REG(`SOC_ANA_LEAD_OFF, {4'h0,4'h3}, pads, mask );
    `RD_NORMAL_REG(`SOC_ANA_LEAD_OFF, 8'h00, ana_dc_lead_off_ctrl);  
    if(ana_dc_lead_off_ctrl !== 8'h03) begin `uvm_error("", $sformatf("\t[ERROR] [ana_bist] The value read: %h is not as expected value: %h", ana_dc_lead_off_ctrl, 8'h03)); end


    //21.          
    `WR_RD_CHK_NORMAL_REG(`SOC_ANA_BIST, {4'h0,4'hF}, pads, mask );
    `RD_NORMAL_REG(`SOC_ANA_BIST, 8'h00, ana_bist);  
    if(ana_bist !== 8'hF) begin `uvm_error("", $sformatf("\t[ERROR] [ana_bist] The value read: %h is not as expected value: %h", ana_bist, 8'hf)); end 

    `WR_RD_CHK_NORMAL_REG(`SOC_ANA_LEAD_OFF_EN, {4'h0,4'h3}, pads, mask );
    `RD_NORMAL_REG(`SOC_ANA_LEAD_OFF_EN, 8'h00, ana_lead_off_en);  
    if(ana_lead_off_en !== 8'h3) begin `uvm_error("", $sformatf("\t[ERROR] [ana_bist] The value read: %h is not as expected value: %h", ana_lead_off_en, 8'h3)); end 


    //========================================================================================//
    // commented by ophina as it is removed in BAF4P1
    //========================================================================================//

   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA0,8'h00,rd_SOC_FLASH_TRIMDATA0_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA1,8'h00,rd_SOC_FLASH_TRIMDATA1_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA2,8'h00,rd_SOC_FLASH_TRIMDATA2_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA3,8'h00,rd_SOC_FLASH_TRIMDATA3_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA4,8'h00,rd_SOC_FLASH_TRIMDATA4_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA5,8'h00,rd_SOC_FLASH_TRIMDATA5_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA6,8'h00,rd_SOC_FLASH_TRIMDATA6_reg);   
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA7,8'h00,rd_SOC_FLASH_TRIMDATA7_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA8,8'h00,rd_SOC_FLASH_TRIMDATA8_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA9,8'h00,rd_SOC_FLASH_TRIMDATA9_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA10,8'h00,rd_SOC_FLASH_TRIMDATA10_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA11,8'h00,rd_SOC_FLASH_TRIMDATA11_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA12,8'h00,rd_SOC_FLASH_TRIMDATA12_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA13,8'h00,rd_SOC_FLASH_TRIMDATA13_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA14,8'h00,rd_SOC_FLASH_TRIMDATA14_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA15,8'h00,rd_SOC_FLASH_TRIMDATA15_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA16,8'h00,rd_SOC_FLASH_TRIMDATA16_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA17,8'h00,rd_SOC_FLASH_TRIMDATA17_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA18,8'h00,rd_SOC_FLASH_TRIMDATA18_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA19,8'h00,rd_SOC_FLASH_TRIMDATA19_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA20,8'h00,rd_SOC_FLASH_TRIMDATA20_reg);
   if(rd_SOC_FLASH_TRIMDATA0_reg   !== `SOC_FLASH_TRIMDATA0_RELOAD_INIT  ) begin `uvm_error("", $sformatf("\t[ERROR] [rd_SOC_FLASH_TRIMDATA0_reg] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA0_reg, 8'h5a)); end
   if(rd_SOC_FLASH_TRIMDATA1_reg   !== `SOC_FLASH_TRIMDATA1_RELOAD_INIT  ) begin `uvm_error("", $sformatf("\t[ERROR] [rd_SOC_FLASH_TRIMDATA1_reg] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA1_reg, 8'h10)); end
   if(rd_SOC_FLASH_TRIMDATA2_reg   !== `SOC_FLASH_TRIMDATA2_RELOAD_INIT  ) begin `uvm_error("", $sformatf("\t[ERROR] [rd_SOC_FLASH_TRIMDATA2_reg] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA2_reg, 8'h40)); end
   if(rd_SOC_FLASH_TRIMDATA3_reg   !== `SOC_FLASH_TRIMDATA3_RELOAD_INIT  ) begin `uvm_error("", $sformatf("\t[ERROR] [rd_SOC_FLASH_TRIMDATA3_reg] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA3_reg, 8'h02)); end
   if(rd_SOC_FLASH_TRIMDATA4_reg   !== `SOC_FLASH_TRIMDATA4_RELOAD_INIT  ) begin `uvm_error("", $sformatf("\t[ERROR] [rd_SOC_FLASH_TRIMDATA4_reg] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA4_reg, 8'h20)); end
   if(rd_SOC_FLASH_TRIMDATA5_reg   !== `SOC_FLASH_TRIMDATA5_RELOAD_INIT  ) begin `uvm_error("", $sformatf("\t[ERROR] [rd_SOC_FLASH_TRIMDATA5_reg] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA5_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA6_reg   !== `SOC_FLASH_TRIMDATA6_INIT  ) begin `uvm_error("", $sformatf("\t[ERROR] [rd_SOC_FLASH_TRIMDATA6_reg] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA6_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA7_reg   !== `SOC_FLASH_TRIMDATA7_INIT  ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA7] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA7_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA8_reg   !== `SOC_FLASH_TRIMDATA8_RELOAD_INIT  ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA8] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA8_reg, 8'h04)); end
   if(rd_SOC_FLASH_TRIMDATA9_reg   !== `SOC_FLASH_TRIMDATA9_RELOAD_INIT  ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA9] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA9_reg, 8'h04)); end
   if(rd_SOC_FLASH_TRIMDATA10_reg  !== `SOC_FLASH_TRIMDATA10_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA10] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA10_reg, 8'h01)); end            
   if(rd_SOC_FLASH_TRIMDATA11_reg  !== `SOC_FLASH_TRIMDATA11_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA11] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA11_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA12_reg  !== `SOC_FLASH_TRIMDATA12_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA12] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA12_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA13_reg  !== `SOC_FLASH_TRIMDATA13_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA13] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA13_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA14_reg  !== `SOC_FLASH_TRIMDATA14_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA14] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA14_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA15_reg  !== `SOC_FLASH_TRIMDATA15_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA15] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA15_reg, 8'h00)); end           
   if(rd_SOC_FLASH_TRIMDATA16_reg  !== `SOC_FLASH_TRIMDATA16_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA16] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA16_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA17_reg  !== `SOC_FLASH_TRIMDATA17_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA17] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA17_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA18_reg  !== `SOC_FLASH_TRIMDATA18_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA18] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA18_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA19_reg  !== `SOC_FLASH_TRIMDATA19_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA19] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA19_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA20_reg  !== `SOC_FLASH_TRIMDATA20_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA20] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA20_reg, 8'h00)); end
endtask


task do_run_spi_write;
//*******************************************************************************************//
//*******************************************************************************************//

    `uvm_info("",  "\nSet spi write", UVM_LOW);  	
    `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b0, 1'b0,3'b000,3'b000},pads,mask);
    `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b1, 1'b0,3'b000,3'b000},pads,mask);
    `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b0, 1'b0,3'b000,3'b000},pads,mask);
    `RD_NORMAL_REG(`SOC_CLK_CTRL_REG, 8'h00, rd_clkctrl_reg);
    if(rd_clkctrl_reg !== 8'h00) begin `uvm_error("", $sformatf("\t[ERROR] [rd_clkctrl_reg] The value read: %h is not as expected value: %h", rd_clkctrl_reg, 8'h00)); end
//*******************************************************************************************//
//*******************************************************************************************//
endtask

task do_run_disable_spi_write;
     `uvm_info("",  "\nDisable spi write", UVM_LOW);  	
    `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b0, 1'b0,3'b000,3'b000},pads,mask);
    `RD_NORMAL_REG(`SOC_CLK_CTRL_REG, 8'h00, rd_clkctrl_reg);
    if(rd_clkctrl_reg !== 8'h00) begin `uvm_error("", $sformatf("\t[ERROR] [rd_clkctrl_reg] The value read: %h is not as expected value: %h", rd_clkctrl_reg, 8'h0)); end
 

endtask

task do_run_spi_rd_debug_anac_reg_val;

    `RD_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM1, 8'h00,    rd_ALWAYS_ON_ANA_TRIM2); 
    if(rd_ALWAYS_ON_ANA_TRIM2 !== 8'h10) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ALWAYS_ON_ANA_TRIM2] The value read: %h is not as expected value: %h", rd_ALWAYS_ON_ANA_TRIM2, 8'h10)); end
       
    `RD_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM2, 8'h00,    rd_ALWAYS_ON_ANA_TRIM1);
    if(rd_ALWAYS_ON_ANA_TRIM1 !== 8'h40) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ALWAYS_ON_ANA_TRIM1] The value read: %h is not as expected value: %h", rd_ALWAYS_ON_ANA_TRIM1, 8'h40)); end
           
    //`RD_NORMAL_REG(`ALWAYS_ON_ANA_BGL_VTRIM_DEBUG, 8'h00,    rd_ALWAYS_ON_ANA_BGL_VTRIM_DEBUG);// commented by ophina as it is removed in BAF4P1
    //if(rd_ALWAYS_ON_ANA_BGL_VTRIM_DEBUG !== 8'h10) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ALWAYS_ON_ANA_BGL_VTRIM_DEBUG] The value read: %h is not as expected value: %h", rd_ALWAYS_ON_ANA_BGL_VTRIM_DEBUG, 8'h10)); end 
          
    //`RD_NORMAL_REG(`ALWAYS_ON_ANA_BGL_CTRIM_DEBUG, 8'h00,    rd_ALWAYS_ON_ANA_BGL_CTRIM_DEBUG);// commented by ophina as it is removed in BAF4P1
    //if(rd_ALWAYS_ON_ANA_BGL_CTRIM_DEBUG !== 8'h40) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ALWAYS_ON_ANA_BGL_CTRIM_DEBUG] The value read: %h is not as expected value: %h", rd_ALWAYS_ON_ANA_BGL_CTRIM_DEBUG, 8'h40)); end  
         
    `RD_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM3, 8'h00, rd_ALWAYS_ON_ANA_TRIM3);
    if(rd_ALWAYS_ON_ANA_TRIM3 !== 8'h02) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ALWAYS_ON_ANA_TRIM3] The value read: %h is not as expected value: %h", rd_ALWAYS_ON_ANA_TRIM3, 8'h02)); end
        
    //`RD_NORMAL_REG(`ALWAYS_ON_ANA_DAC_BUF_TRIM_DEBUG, 8'h00, rd_ALWAYS_ON_ANA_DAC_BUF_TRIM_DEBUG);// commented by ophina as it is removed in BAF4P1
    //if(rd_ALWAYS_ON_ANA_DAC_BUF_TRIM_DEBUG !== 8'h02) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ALWAYS_ON_ANA_DAC_BUF_TRIM_DEBUG] The value read: %h is not as expected value: %h", rd_ALWAYS_ON_ANA_DAC_BUF_TRIM_DEBUG, 8'h02)); end
        
    `RD_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM4,8'h00,      rd_ALWAYS_ON_ANA_TRIM4);
    if(rd_ALWAYS_ON_ANA_TRIM4 !== 8'h20) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ALWAYS_ON_ANA_TRIM4] The value read: %h is not as expected value: %h", rd_ALWAYS_ON_ANA_TRIM4, 8'h20)); end   
   
   
   //if(`ANA_TOP.D2A_BGL_CTRIM[6:0] !== 7'h40) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BGL_CTRIM[6:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BGL_CTRIM[6:0], 7'h40)); end// commented by ophina   
   if(`ANA_TOP.D2A_BGH_VTRIM[4:0]  !== 5'h10) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BGH_VTRIM[4:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BGH_VTRIM[4:0], 5'h10)); end
   //if(`ANA_TOP.D2A_BGL_VTRIM[4:0] !== 5'h10) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BGL_VTRIM[4:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BGL_VTRIM[4:0], 5'h10)); end// commented by ophina 
   if(`ANA_TOP.D2A_BGH_CTRIM[6:0] !== 7'h40) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BGH_CTRIM[6:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BGH_CTRIM[6:0], 7'h40)); end
   //if(`ANA_TOP.D2A_DAC_BUF_TRIM[1:0] !== 2'h2) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_DAC_BUF_TRIM[1:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_DAC_BUF_TRIM[1:0], 2'h2)); end// commented by ophina
   if(`ANA_TOP.D2A_LDO1V5_VTRIM[1:0] !== 2'h2) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_LDO1V5_VTRIM[1:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_LDO1V5_VTRIM[1:0], 2'h2)); end
   if(`ANA_TOP.D2A_OSC_TRIM[5:0] !== 6'h20) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_OSC_TRIM[5:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_OSC_TRIM[5:0], 6'h20)); end

    //1.
    //`RD_NORMAL_REG(`SOC_CLK_CTRL_REG_DEBUG,8'h00,rd_alwayson_clkctrl_debug_reg);// commented by ophina as it is removed in BAF4P1
    //if(rd_alwayson_clkctrl_debug_reg !== 8'd3 ) begin `uvm_error("", $sformatf("\t[ERROR] [rd_alwayson_clkctrl_debug_reg] The value read: %h is not as expected value: %h", rd_alwayson_clkctrl_debug_reg, 8'h3)); end
    //if(`ANA_TOP.D2A_CPCLK[2:0]  !== 3'd3 ) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CPCLK[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CPCLK[2:0], 2'h3)); end

    //========================================================================================//
    // commented by ophina as it is removed in BAF4P1
    //========================================================================================//
/*    
    //2.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH1_WE1_0_DEBUG, 8'h00, rd_ANA_IMEAS_CH1_WE1_0_DEBUG);
    if(rd_ANA_IMEAS_CH1_WE1_0_DEBUG !== 8'h3F) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ANA_IMEAS_CH1_WE1_0_DEBUG] The value read: %h is not as expected value: %h", rd_ANA_IMEAS_CH1_WE1_0_DEBUG, 8'h3f)); end      
    if(`ANA_TOP.D2A_CH1_WE1_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE1_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE1_EN, 1'h1)); end 
    if(`ANA_TOP.D2A_CH1_WE1_DDA_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE1_DDA_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE1_DDA_EN, 1'h1)); end
    if(`ANA_TOP.D2A_CH1_WE1_RFB_SEL[3:0] !== 4'hF) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE1_RFB_SEL[3:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE1_RFB_SEL[3:0], 4'hf)); end 

    //3.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH1_WE1_1_DEBUG, 8'h00, rd_ANA_IMEAS_CH1_WE1_1_DEBUG); 
    if(rd_ANA_IMEAS_CH1_WE1_1_DEBUG !== 8'h3F) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ANA_IMEAS_CH1_WE1_1_DEBUG] The value read: %h is not as expected value: %h", rd_ANA_IMEAS_CH1_WE1_1_DEBUG, 8'h3f)); end
    if(`ANA_TOP.D2A_CH1_WE1_ROUT_SEL[2:0]  !== 3'h7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE1_ROUT_SEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE1_ROUT_SEL[2:0], 3'h7)); end
    if(`ANA_TOP.D2A_CH1_WE1_VGAIN_SEL[2:0] !== 3'd7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE1_VGAIN_SEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE1_VGAIN_SEL[2:0], 3'd7)); end

    //4.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH1_WE2_0_DEBUG, 8'h00, rd_ANA_IMEAS_CH1_WE2_0_DEBUG); 
    if(rd_ANA_IMEAS_CH1_WE2_0_DEBUG !== 8'h3F) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ANA_IMEAS_CH1_WE2_0_DEBUG] The value read: %h is not as expected value: %h", rd_ANA_IMEAS_CH1_WE2_0_DEBUG, 8'h3f)); end
    if(`ANA_TOP.D2A_CH1_WE2_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE2_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE2_EN, 1'h1)); end
    if(`ANA_TOP.D2A_CH1_WE2_DDA_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE2_DDA_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE2_DDA_EN, 1'h1)); end
    if(`ANA_TOP.D2A_CH1_WE2_RFB_SEL[3:0] !== 4'hF) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE2_RFB_SEL[3:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE2_RFB_SEL[3:0], 4'hf)); end
    
    //5.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH1_WE2_1_DEBUG, 8'h00, rd_ANA_IMEAS_CH1_WE2_1_DEBUG);
    if(rd_ANA_IMEAS_CH1_WE2_1_DEBUG !== 8'h3F) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ANA_IMEAS_CH1_WE2_1_DEBUG] The value read: %h is not as expected value: %h", rd_ANA_IMEAS_CH1_WE2_1_DEBUG, 8'h3f)); end
    if(`ANA_TOP.D2A_CH1_WE2_ROUT_SEL[2:0] !== 3'd7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE2_ROUT_SEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE2_ROUT_SEL[2:0], 3'h7)); end
    if(`ANA_TOP.D2A_CH1_WE2_VGAIN_SEL[2:0] !== 3'd7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE2_VGAIN_SEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE2_VGAIN_SEL[2:0], 3'h7)); end 

    //6.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH1_RCE_ROUTSEL_DEBUG, 8'h00, rd_ANA_IMEAS_CH1_RCE_ROUTSEL_DEBUG);
    if(rd_ANA_IMEAS_CH1_RCE_ROUTSEL_DEBUG !== 8'hF) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ANA_IMEAS_CH1_RCE_ROUTSEL_DEBUG] The value read: %h is not as expected value: %h", rd_ANA_IMEAS_CH1_RCE_ROUTSEL_DEBUG, 8'hf)); end
    if(`ANA_TOP.D2A_CH1_RCE_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_RCE_EN ] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_RCE_EN , 1'h1)); end
    if(`ANA_TOP.D2A_CH1_CE_ROUT_SEL[2:0] !== 3'd7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_CE_ROUT_SEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_CE_ROUT_SEL[2:0], 3'h7)); end 
    
    //7. 
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH1_WE_DAC_EN_DEBUG, 8'h00, rd_ANA_IMEAS_CH1_WE_DAC_EN_DEBUG);
    if(rd_ANA_IMEAS_CH1_WE_DAC_EN_DEBUG !== 8'h1) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ANA_IMEAS_CH1_WE_DAC_EN_DEBUG] The value read: %h is not as expected value: %h", rd_ANA_IMEAS_CH1_WE_DAC_EN_DEBUG, 8'h1)); end    
    if(`ANA_TOP.D2A_CH1_WE_DAC_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE_DAC_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE_DAC_EN, 1'h1)); end    
    
    //8.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH1_DINWE_0_DEBUG, 8'h00, rd_ANA_IMEAS_CH1_DINWE_0_DEBUG);
    if(rd_ANA_IMEAS_CH1_DINWE_0_DEBUG !== 8'hFF) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ANA_IMEAS_CH1_DINWE_0_DEBUG] The value read: %h is not as expected value: %h", rd_ANA_IMEAS_CH1_DINWE_0_DEBUG, 8'hff)); end    
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH1_DINWE_1_DEBUG, 8'h00, rd_ANA_IMEAS_CH1_DINWE_1_DEBUG);
    if(rd_ANA_IMEAS_CH1_DINWE_1_DEBUG !== 8'h3) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ANA_IMEAS_CH1_DINWE_1_DEBUG] The value read: %h is not as expected value: %h", rd_ANA_IMEAS_CH1_DINWE_1_DEBUG, 8'h3)); end   
    if(`ANA_TOP.D2A_CH1_DINWE[9:0] !== 10'h3FF) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_DINWE[9:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_DINWE[9:0], 10'h3ff)); end
 
    //9.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH1_RCE_DAC_EN_DEBUG, 8'h00, rd_ANA_IMEAS_CH1_RCE_DAC_EN_DEBUG);
    if(rd_ANA_IMEAS_CH1_RCE_DAC_EN_DEBUG !== 8'h1) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ANA_IMEAS_CH1_RCE_DAC_EN_DEBUG] The value read: %h is not as expected value: %h", rd_ANA_IMEAS_CH1_RCE_DAC_EN_DEBUG, 8'h1)); end
    if(`ANA_TOP.D2A_CH1_RCE_DAC_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_RCE_DAC_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_RCE_DAC_EN, 1'h1)); end
   
    //10.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH1_DINRCE_0_DEBUG, 8'h00, rd_ANA_IMEAS_CH1_DINRCE_0_DEBUG);
    if(rd_ANA_IMEAS_CH1_DINRCE_0_DEBUG !== 8'hFF) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ANA_IMEAS_CH1_DINRCE_0_DEBUG] The value read: %h is not as expected value: %h", rd_ANA_IMEAS_CH1_DINRCE_0_DEBUG, 8'hff)); end    
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH1_DINRCE_1_DEBUG, 8'h00, rd_ANA_IMEAS_CH1_DINRCE_1_DEBUG);
    if(rd_ANA_IMEAS_CH1_DINRCE_1_DEBUG !== 8'h3) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ANA_IMEAS_CH1_DINRCE_1_DEBUG] The value read: %h is not as expected value: %h", rd_ANA_IMEAS_CH1_DINRCE_1_DEBUG, 8'h3)); end  
    if(`ANA_TOP.D2A_CH1_DINRCE[9:0] !== 12'h3FF) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_DINRCE[9:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_DINRCE[9:0], 10'h3ff)); end
 
    //11.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH2_WE1_0_DEBUG, 8'h00, rd_ANA_IMEAS_CH2_WE1_0_DEBUG);
    if(rd_ANA_IMEAS_CH2_WE1_0_DEBUG !== 8'h3F) error++;
    if(`ANA_TOP.CH2_WE1_EN !== 1'd1) error++; 
    if(`ANA_TOP.CH2_WE1_DDA_EN!== 1'd1) error++;
    if(`ANA_TOP.CH2_WE1_RFB_SEL[3:0] !== 4'hF) error++; 
     
    //12.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH2_WE1_1_DEBUG, 8'h00, rd_ANA_IMEAS_CH2_WE1_1_DEBUG);
    if(rd_ANA_IMEAS_CH2_WE1_1_DEBUG !== 8'h3F) error++;      
    if(`ANA_TOP.CH2_WE1_ROUT_SEL[2:0]  !== 3'h7) error++;
    if(`ANA_TOP.CH2_WE1_VGAIN_SEL[2:0] !== 3'h7) error++;
  
    //13.    
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH2_WE2_0_DEBUG, 8'h00, rd_ANA_IMEAS_CH2_WE2_0_DEBUG);
    if(rd_ANA_IMEAS_CH2_WE2_0_DEBUG !== 8'h3F) error++;
    if(`ANA_TOP.CH2_WE2_EN !== 1'd1) error++;
    if(`ANA_TOP.CH2_WE2_DDA_EN !== 1'd1) error++;
    if(`ANA_TOP.CH2_WE2_RFB_SEL[3:0] !== 4'hF) error++;
   
    //14.    
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH2_WE2_1_DEBUG, 8'h00, rd_ANA_IMEAS_CH2_WE2_1_DEBUG);
    if(rd_ANA_IMEAS_CH2_WE2_1_DEBUG !== 8'h3F) error++;    
    if(`ANA_TOP.CH2_WE2_ROUT_SEL[2:0] !== 3'h7) error++;
    if(`ANA_TOP.CH2_WE2_VGAIN_SEL[2:0] !== 3'h7) error++; 
 
    //15. 
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH2_RCE_ROUTSEL_DEBUG, 8'h00, rd_ANA_IMEAS_CH2_RCE_ROUTSEL_DEBUG);
    if(rd_ANA_IMEAS_CH2_RCE_ROUTSEL_DEBUG !== 8'hF) error++;
    if(`ANA_TOP.CH2_RCE_EN !== 1'd1) error++;
    if(`ANA_TOP.CH2_CE_ROUT_SEL[2:0] !== 3'h7) error++; 

    //16.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH2_WE_DAC_EN_DEBUG, 8'h00, rd_ANA_IMEAS_CH2_WE_DAC_EN_DEBUG);
    if(rd_ANA_IMEAS_CH2_WE_DAC_EN_DEBUG !== 8'h1) error++;
    if(`ANA_TOP.CH2_WE_DAC_EN !== 1'd1) error++;

    //17.    
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH2_DINWE_0_DEBUG, 8'h00, rd_ANA_IMEAS_CH2_DINWE_0_DEBUG);
    if(rd_ANA_IMEAS_CH2_DINWE_0_DEBUG !== 8'hFF) error++;
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH2_DINWE_1_DEBUG, 8'h00, rd_ANA_IMEAS_CH2_DINWE_1_DEBUG);
    if(rd_ANA_IMEAS_CH2_DINWE_1_DEBUG !== 8'hF) error++;
    if(`ANA_TOP.CH2_DINWE[11:0] !== 12'hFFF) error++;
   
    //18.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH2_RCE_DAC_EN_DEBUG, 8'h00, rd_ANA_IMEAS_CH2_RCE_DAC_EN_DEBUG);
    if(rd_ANA_IMEAS_CH2_RCE_DAC_EN_DEBUG !== 8'h1) error++;
    if(`ANA_TOP.CH2_RCE_DAC_EN !== 1'd1) error++;

    //19.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH2_DINRCE_0_DEBUG, 8'h00, rd_ANA_IMEAS_CH2_DINRCE_0_DEBUG);
    if(rd_ANA_IMEAS_CH2_DINRCE_0_DEBUG !== 8'hFF) error++;

    `RD_NORMAL_REG(`ALWAYS_ON_ANA_IMEAS_CH2_DINRCE_1_DEBUG, 8'h00, rd_ANA_IMEAS_CH2_DINRCE_1_DEBUG);
    if(rd_ANA_IMEAS_CH2_DINRCE_1_DEBUG !== 8'hF) error++;
    if(`ANA_TOP.CH2_DINRCE[11:0] !== 12'hFFF) error++;

    //20. 
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_PMU_DEBUG, 8'h00, rd_ANA_PMU_DEBUG);
    if(rd_ANA_PMU_DEBUG !== 8'h3) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ANA_PMU_DEBUG] The value read: %h is not as expected value: %h", rd_ANA_PMU_DEBUG, 8'h3)); end
    if(`ANA_TOP.D2A_BG_BUF_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BG_BUF_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BG_BUF_EN, 1'h1)); end
    if(`ANA_TOP.D2A_DAC_BUF_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_DAC_BUF_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_DAC_BUF_EN, 1'h1)); end

    //21.           
    `RD_NORMAL_REG(`ALWAYS_ON_SOC_ANA_BIST_DEBUG, 8'h00, rd_SOC_ANA_BIST_DEBUG);
    if(rd_SOC_ANA_BIST_DEBUG !== 8'hF) begin `uvm_error("", $sformatf("\t[ERROR] [rd_SOC_ANA_BIST_DEBUG] The value read: %h is not as expected value: %h", rd_SOC_ANA_BIST_DEBUG, 8'hf)); end
    if(`ANA_TOP.D2A_BIST_EN !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BIST_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BIST_EN, 1'h1)); end
    if(`ANA_TOP.D2A_BIST_ISEL[2:0] !== 3'h7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BIST_ISEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BIST_ISEL[2:0], 3'h7)); end
       
    //22.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_DDA_DEBUG, 8'h00, rd_ANA_DDA_DEBUG);
    if(rd_ANA_DDA_DEBUG !== 8'hF) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ANA_DDA_DEBUG] The value read: %h is not as expected value: %h", rd_ANA_DDA_DEBUG, 8'hf)); end
    if(`ANA_TOP.D2A_DDA_EN !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_DDA_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_DDA_EN, 1'h1)); end
    if(`ANA_TOP.D2A_DDA_GSEL[2:0] !== 3'h7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_DDA_GSEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_DDA_GSEL[2:0], 3'h7)); end
    
    //23.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_ELE_DEBUG, 8'h00, rd_ANA_ELE_DEBUG);
    if(rd_ANA_ELE_DEBUG !== 8'hF) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ANA_ELE_DEBUG] The value read: %h is not as expected value: %h", rd_ANA_ELE_DEBUG, 8'hf)); end
    if(`ANA_TOP.D2A_ELE_BUF_EN !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_ELE_BUF_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_ELE_BUF_EN, 1'h1)); end
    if(`ANA_TOP.D2A_ELE_BUF_ISEL[2:0] !==3'h7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_ELE_BUF_ISEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_ELE_BUF_ISEL[2:0], 3'h7)); end

    //========================================================================================//

    //24.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_DAC1_EN_DEBUG, 8'h00, rd_ANA_DAC1_EN_DEBUG);
    if(rd_ANA_DAC1_EN_DEBUG !== 8'h1) error++;   
    if(`ANA_TOP.R2R_DAC1_EN !== 1'b1) error++;

    //25.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_DAC1_DIN_0_DEBUG, 8'h00, rd_ANA_DAC1_DIN_0_DEBUG);
    if(rd_ANA_DAC1_DIN_0_DEBUG !== 8'hFF) error++;       
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_DAC1_DIN_1_DEBUG, 8'h00, rd_ANA_DAC1_DIN_1_DEBUG);
    if(rd_ANA_DAC1_DIN_1_DEBUG !== 8'hF) error++;
    if(`ANA_TOP.R2R_DAC1_DIN[11:0] !== 12'hFFF) error++;
   
    //26.
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_DAC2_EN_DEBUG, 8'h00, rd_ANA_DAC2_EN_DEBUG);
    if(rd_ANA_DAC2_EN_DEBUG !== 8'h1) error++;
    if(`ANA_TOP.R2R_DAC2_EN !== 1'b1) error++;

    //27.          
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_DAC2_DIN_0, 8'h00, rd_ALWAYS_ON_ANA_DAC2_DIN_0);
    if(rd_ALWAYS_ON_ANA_DAC2_DIN_0 !== 8'hFF) error++;             
    `RD_NORMAL_REG(`ALWAYS_ON_ANA_DAC2_DIN_1, 8'h00, rd_ALWAYS_ON_ANA_DAC2_DIN_1);                 
    if(rd_ALWAYS_ON_ANA_DAC2_DIN_1 !== 8'hF) error++;
    if(`ANA_TOP.R2R_DAC2_DIN[11:0] !== 12'hFFF) error++;*/
endtask

task do_run_extclk1MZ;
   `uvm_info("",  "\n set ext_clk_sel=1", UVM_LOW);  
   `uvm_info("",  "\n test will run 1MHZ now on", UVM_LOW);
   force `ANA_TOP.A2D_external_en_I_internal = 1'b1;
   #20000;   
   if(`ALWAYSON_TOP.A2D_external_en_I !== 1'b1);
       // enable to fix 1'b0 to internal clk
    `DUT_IF.hfosc_fixed_gnd_en = 1'b1;

    // enable to fix 1'b0 to ext clk
    `DUT_IF.ext_hfosc_fixed_gnd_en = 1'b0;
endtask

task do_run_sw_wakeup0;
   //in order to set PORESETN==>0
   //set anlog signals wake ==>0
   `uvm_info("",  "\n set wakeup=0 ", UVM_LOW);
   `uvm_info("",  "\n wakeup==0 :reset switchable domain ", UVM_LOW);
   //force `ANA_TOP.A2D_Wake_UP_i = 1'b0;
   force `ANA_TOP.PMU_SW.wakeup=0;
   #21234;
   if(`ALWAYSON_TOP.A2D_VDDI_POR !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_VDDI_POR] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_VDDI_POR, 1'h1)); end
   if(`ALWAYSON_TOP.A2D_external_RESET !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_external_RESET] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_external_RESET, 1'h1)); end
  `ifdef POSTLAYOUT_PG 
   if(`ALWAYSON_TOP.scan_rst_n !== 1'bx) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.scan_rst_n] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.scan_rst_n, 1'hx)); end
   if(`ALWAYSON_TOP.poresetn_hf_sw_power !== 1'bx) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.poresetn_hf_sw_power] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.poresetn_hf_sw_power, 1'hx)); end
   if(`ALWAYSON_TOP.flash_reset_done !== 1'bx) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.flash_reset_done] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.flash_reset_done, 1'hx)); end
  `elsif POSTSCAN_PG
   if(`ALWAYSON_TOP.scan_rst_n !== 1'bx) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.scan_rst_n] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.scan_rst_n, 1'hx)); end
   if(`ALWAYSON_TOP.poresetn_hf_sw_power !== 1'bx) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.poresetn_hf_sw_power] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.poresetn_hf_sw_power, 1'hx)); end
   if(`ALWAYSON_TOP.flash_reset_done !== 1'bx) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.flash_reset_done] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.flash_reset_done, 1'hx)); end
  `else
   if(`ALWAYSON_TOP.scan_rst_n !== 1'b0) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.scan_rst_n] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.scan_rst_n, 1'h0)); end
   if(`ALWAYSON_TOP.poresetn_hf_sw_power !== 1'b0) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.poresetn_hf_sw_power] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.poresetn_hf_sw_power, 1'h0)); end
   if(`ALWAYSON_TOP.flash_reset_done !== 1'b0) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.flash_reset_done] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.flash_reset_done, 1'h0)); end
  `endif
   #20000;

endtask

task do_run_sw_wakeup1;
    #200000;
   //in order to set PORESETN==>1
   //set anlog signals wake ==>1
   `uvm_info("",  "\n set wakeup=1 ", UVM_LOW);
   `uvm_info("",  "\n wakeup==1 :reset switchable domain ", UVM_LOW);
   //release `ANA_TOP.A2D_Wake_UP_i;
   release `ANA_TOP.PMU_SW.wakeup;
   #212345;
   if(`ALWAYSON_TOP.A2D_VDDI_POR !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_VDDI_POR] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_VDDI_POR, 1'h1)); end
   if(`ALWAYSON_TOP.A2D_external_RESET !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_external_RESET] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_external_RESET, 1'h1)); end
   if(`ALWAYSON_TOP.scan_rst_n !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.scan_rst_n] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.scan_rst_n, 1'h1)); end
   wait(`ALWAYSON_TOP.poresetn_hf_sw_power == 1'b1);
   if(`ALWAYSON_TOP.poresetn_hf_sw_power !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.poresetn_hf_sw_power] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.poresetn_hf_sw_power, 1'h1)); end
   wait(`ALWAYSON_TOP.flash_reset_done == 1'b1);
   if(`ALWAYSON_TOP.flash_reset_done !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.flash_reset_done] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.flash_reset_done, 1'h1)); end
   #20000;

endtask


task do_run_check_io_lowpwr_mode;
//IO CELLS

    `ifdef BEHAVIORAL
        if(`ALWAYSON_TOP.o_IOBUF_IE !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_IE] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_IE, 19'h0_0000)); end 
    	if(`ALWAYSON_TOP.o_IOBUF_CS !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_CS] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_CS, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_PU !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_PU] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_PU, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_SR !== 19'h7_FFFF) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_SR] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_SR, 19'h7_FFFF)); end
    	if(`ALWAYSON_TOP.o_IOBUF_DR !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_DR] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_DR, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_A  !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_A] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_A, 19'h0_0000)); end 
    	if(`ALWAYSON_TOP.o_IOBUF_OE !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_OE] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_OE, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_OS !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_OS] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_OS, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_OD !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_OD] The value read: %h is not as expected value: %h",`ALWAYSON_TOP.o_IOBUF_OD, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_PD !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_PD] The value read: %h is not as expected value: %h",`ALWAYSON_TOP.o_IOBUF_PD, 19'h0_0000)); end
        if(`SOC_TOP.u_iopad_testmode0.IE  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.IE, 1'h0)); end 
     	if(`SOC_TOP.u_iopad_testmode0.PD  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.PD, 1'h0)); end 
    	if(`SOC_TOP.u_iopad_testmode0.PU  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.PU, 1'h0)); end 
	if(`SOC_TOP.u_iopad_testmode1.IE !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.IE, 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.PU !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.PU ] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.PU , 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.PD !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.PD, 1'h0)); end
	if(`SOC_TOP.u_iopad_exresetn.IE   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.IE, 1'h0)); end
    	if(`SOC_TOP.u_iopad_exresetn.PD   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.PD, 1'h0)); end 
    	if(`SOC_TOP.u_iopad_exresetn.PU   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.PU, 1'h0)); end
	if(`SOC_TOP.u_iopad_testmode0.Y   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.Y, 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.Y  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.Y, 1'h0)); end
    	if(`SOC_TOP.u_iopad_exresetn.Y !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.Y, 1'h0)); end 	

    `else /*POSTSCAN*/

          o_IOBUF_Y = {
			`SOC_TOP.u_iopad_gpio_18_.Y,
		        `SOC_TOP.u_iopad_gpio_17_.Y,
			`SOC_TOP.u_iopad_gpio_16_.Y,
			`SOC_TOP.u_iopad_gpio_15_.Y,
			`SOC_TOP.u_iopad_gpio_14_.Y,
			`SOC_TOP.u_iopad_gpio_13_.Y,
			`SOC_TOP.u_iopad_gpio_12_.Y,
			`SOC_TOP.u_iopad_gpio_11_.Y,
			`SOC_TOP.u_iopad_gpio_10_.Y,
			`SOC_TOP.u_iopad_gpio_9_.Y,
			`SOC_TOP.u_iopad_gpio_8_.Y,
			`SOC_TOP.u_iopad_gpio_7_.Y,
			`SOC_TOP.u_iopad_gpio_6_.Y,
			`SOC_TOP.u_iopad_gpio_5_.Y,
			`SOC_TOP.u_iopad_gpio_4_.Y,
			`SOC_TOP.u_iopad_gpio_3_.Y,
			`SOC_TOP.u_iopad_gpio_2_.Y,
			`SOC_TOP.u_iopad_gpio_1_.Y,
			`SOC_TOP.u_iopad_gpio_0_.Y};

  	 o_IOBUF_IE = { 
			`SOC_TOP.u_iopad_gpio_18_.IE,
		        `SOC_TOP.u_iopad_gpio_17_.IE,
			`SOC_TOP.u_iopad_gpio_16_.IE,
			`SOC_TOP.u_iopad_gpio_15_.IE,
			`SOC_TOP.u_iopad_gpio_14_.IE,
			`SOC_TOP.u_iopad_gpio_13_.IE,
			`SOC_TOP.u_iopad_gpio_12_.IE,
			`SOC_TOP.u_iopad_gpio_11_.IE,
			`SOC_TOP.u_iopad_gpio_10_.IE,
			`SOC_TOP.u_iopad_gpio_9_.IE,
			`SOC_TOP.u_iopad_gpio_8_.IE,
			`SOC_TOP.u_iopad_gpio_7_.IE,
			`SOC_TOP.u_iopad_gpio_6_.IE,
			`SOC_TOP.u_iopad_gpio_5_.IE,
			`SOC_TOP.u_iopad_gpio_4_.IE,
			`SOC_TOP.u_iopad_gpio_3_.IE,
			`SOC_TOP.u_iopad_gpio_2_.IE,
			`SOC_TOP.u_iopad_gpio_1_.IE,
			`SOC_TOP.u_iopad_gpio_0_.IE};


 	 o_IOBUF_CS= {   
			`SOC_TOP.u_iopad_gpio_18_.CS,
		        `SOC_TOP.u_iopad_gpio_17_.CS,
			`SOC_TOP.u_iopad_gpio_16_.CS,
			`SOC_TOP.u_iopad_gpio_15_.CS,
			`SOC_TOP.u_iopad_gpio_14_.CS,
			`SOC_TOP.u_iopad_gpio_13_.CS,
			`SOC_TOP.u_iopad_gpio_12_.CS,
			`SOC_TOP.u_iopad_gpio_11_.CS,
			`SOC_TOP.u_iopad_gpio_10_.CS,
			`SOC_TOP.u_iopad_gpio_9_.CS,
			`SOC_TOP.u_iopad_gpio_8_.CS,
			`SOC_TOP.u_iopad_gpio_7_.CS,
			`SOC_TOP.u_iopad_gpio_6_.CS,
			`SOC_TOP.u_iopad_gpio_5_.CS,
			`SOC_TOP.u_iopad_gpio_4_.CS,
			`SOC_TOP.u_iopad_gpio_3_.CS,
			`SOC_TOP.u_iopad_gpio_2_.CS,
			`SOC_TOP.u_iopad_gpio_1_.CS,
			`SOC_TOP.u_iopad_gpio_0_.CS};

 	 o_IOBUF_PU= {   
			`SOC_TOP.u_iopad_gpio_18_.PU,
		        `SOC_TOP.u_iopad_gpio_17_.PU,
			`SOC_TOP.u_iopad_gpio_16_.PU,
			`SOC_TOP.u_iopad_gpio_15_.PU,
			`SOC_TOP.u_iopad_gpio_14_.PU,
			`SOC_TOP.u_iopad_gpio_13_.PU,
			`SOC_TOP.u_iopad_gpio_12_.PU,
			`SOC_TOP.u_iopad_gpio_11_.PU,
			`SOC_TOP.u_iopad_gpio_10_.PU,
			`SOC_TOP.u_iopad_gpio_9_.PU,
			`SOC_TOP.u_iopad_gpio_8_.PU,
			`SOC_TOP.u_iopad_gpio_7_.PU,
			`SOC_TOP.u_iopad_gpio_6_.PU,
			`SOC_TOP.u_iopad_gpio_5_.PU,
			`SOC_TOP.u_iopad_gpio_4_.PU,
			`SOC_TOP.u_iopad_gpio_3_.PU,
			`SOC_TOP.u_iopad_gpio_2_.PU,
			`SOC_TOP.u_iopad_gpio_1_.PU,
			`SOC_TOP.u_iopad_gpio_0_.PU};

 	 o_IOBUF_SR= {   
			`SOC_TOP.u_iopad_gpio_18_.SR,
		        `SOC_TOP.u_iopad_gpio_17_.SR,
			`SOC_TOP.u_iopad_gpio_16_.SR,
			`SOC_TOP.u_iopad_gpio_15_.SR,
			`SOC_TOP.u_iopad_gpio_14_.SR,
			`SOC_TOP.u_iopad_gpio_13_.SR,
			`SOC_TOP.u_iopad_gpio_12_.SR,
			`SOC_TOP.u_iopad_gpio_11_.SR,
			`SOC_TOP.u_iopad_gpio_10_.SR,
			`SOC_TOP.u_iopad_gpio_9_.SR,
			`SOC_TOP.u_iopad_gpio_8_.SR,
			`SOC_TOP.u_iopad_gpio_7_.SR,
			`SOC_TOP.u_iopad_gpio_6_.SR,
			`SOC_TOP.u_iopad_gpio_5_.SR,
			`SOC_TOP.u_iopad_gpio_4_.SR,
			`SOC_TOP.u_iopad_gpio_3_.SR,
			`SOC_TOP.u_iopad_gpio_2_.SR,
			`SOC_TOP.u_iopad_gpio_1_.SR,
			`SOC_TOP.u_iopad_gpio_0_.SR};

 	 o_IOBUF_DR= {   
			`SOC_TOP.u_iopad_gpio_18_.DR,
		        `SOC_TOP.u_iopad_gpio_17_.DR,
			`SOC_TOP.u_iopad_gpio_16_.DR,
			`SOC_TOP.u_iopad_gpio_15_.DR,
			`SOC_TOP.u_iopad_gpio_14_.DR,
			`SOC_TOP.u_iopad_gpio_13_.DR,
			`SOC_TOP.u_iopad_gpio_12_.DR,
			`SOC_TOP.u_iopad_gpio_11_.DR,
			`SOC_TOP.u_iopad_gpio_10_.DR,
			`SOC_TOP.u_iopad_gpio_9_.DR,
			`SOC_TOP.u_iopad_gpio_8_.DR,
			`SOC_TOP.u_iopad_gpio_7_.DR,
			`SOC_TOP.u_iopad_gpio_6_.DR,
			`SOC_TOP.u_iopad_gpio_5_.DR,
			`SOC_TOP.u_iopad_gpio_4_.DR,
			`SOC_TOP.u_iopad_gpio_3_.DR,
			`SOC_TOP.u_iopad_gpio_2_.DR,
			`SOC_TOP.u_iopad_gpio_1_.DR,
			`SOC_TOP.u_iopad_gpio_0_.DR};

 	 o_IOBUF_A = {   
			`SOC_TOP.u_iopad_gpio_18_.A,
		        `SOC_TOP.u_iopad_gpio_17_.A,
			`SOC_TOP.u_iopad_gpio_16_.A,
			`SOC_TOP.u_iopad_gpio_15_.A,
			`SOC_TOP.u_iopad_gpio_14_.A,
			`SOC_TOP.u_iopad_gpio_13_.A,
			`SOC_TOP.u_iopad_gpio_12_.A,
			`SOC_TOP.u_iopad_gpio_11_.A,
			`SOC_TOP.u_iopad_gpio_10_.A,
			`SOC_TOP.u_iopad_gpio_9_.A,
			`SOC_TOP.u_iopad_gpio_8_.A,
			`SOC_TOP.u_iopad_gpio_7_.A,
			`SOC_TOP.u_iopad_gpio_6_.A,
			`SOC_TOP.u_iopad_gpio_5_.A,
			`SOC_TOP.u_iopad_gpio_4_.A,
			`SOC_TOP.u_iopad_gpio_3_.A,
			`SOC_TOP.u_iopad_gpio_2_.A,
			`SOC_TOP.u_iopad_gpio_1_.A,
			`SOC_TOP.u_iopad_gpio_0_.A};

 	 o_IOBUF_OE= {   
			`SOC_TOP.u_iopad_gpio_18_.OE,
		        `SOC_TOP.u_iopad_gpio_17_.OE,
			`SOC_TOP.u_iopad_gpio_16_.OE,
			`SOC_TOP.u_iopad_gpio_15_.OE,
			`SOC_TOP.u_iopad_gpio_14_.OE,
			`SOC_TOP.u_iopad_gpio_13_.OE,
			`SOC_TOP.u_iopad_gpio_12_.OE,
			`SOC_TOP.u_iopad_gpio_11_.OE,
			`SOC_TOP.u_iopad_gpio_10_.OE,
			`SOC_TOP.u_iopad_gpio_9_.OE,
			`SOC_TOP.u_iopad_gpio_8_.OE,
			`SOC_TOP.u_iopad_gpio_7_.OE,
			`SOC_TOP.u_iopad_gpio_6_.OE,
			`SOC_TOP.u_iopad_gpio_5_.OE,
			`SOC_TOP.u_iopad_gpio_4_.OE,
			`SOC_TOP.u_iopad_gpio_3_.OE,
			`SOC_TOP.u_iopad_gpio_2_.OE,
			`SOC_TOP.u_iopad_gpio_1_.OE,
			`SOC_TOP.u_iopad_gpio_0_.OE};

 	 o_IOBUF_OS= {   
			`SOC_TOP.u_iopad_gpio_18_.OS,
		        `SOC_TOP.u_iopad_gpio_17_.OS,
			`SOC_TOP.u_iopad_gpio_16_.OS,
			`SOC_TOP.u_iopad_gpio_15_.OS,
			`SOC_TOP.u_iopad_gpio_14_.OS,
			`SOC_TOP.u_iopad_gpio_13_.OS,
			`SOC_TOP.u_iopad_gpio_12_.OS,
			`SOC_TOP.u_iopad_gpio_11_.OS,
			`SOC_TOP.u_iopad_gpio_10_.OS,
			`SOC_TOP.u_iopad_gpio_9_.OS,
			`SOC_TOP.u_iopad_gpio_8_.OS,
			`SOC_TOP.u_iopad_gpio_7_.OS,
			`SOC_TOP.u_iopad_gpio_6_.OS,
			`SOC_TOP.u_iopad_gpio_5_.OS,
			`SOC_TOP.u_iopad_gpio_4_.OS,
			`SOC_TOP.u_iopad_gpio_3_.OS,
			`SOC_TOP.u_iopad_gpio_2_.OS,
			`SOC_TOP.u_iopad_gpio_1_.OS,
			`SOC_TOP.u_iopad_gpio_0_.OS};

 	 o_IOBUF_OD= {   
			`SOC_TOP.u_iopad_gpio_18_.OD,
		        `SOC_TOP.u_iopad_gpio_17_.OD,
			`SOC_TOP.u_iopad_gpio_16_.OD,
			`SOC_TOP.u_iopad_gpio_15_.OD,
			`SOC_TOP.u_iopad_gpio_14_.OD,
			`SOC_TOP.u_iopad_gpio_13_.OD,
			`SOC_TOP.u_iopad_gpio_12_.OD,
			`SOC_TOP.u_iopad_gpio_11_.OD,
			`SOC_TOP.u_iopad_gpio_10_.OD,
			`SOC_TOP.u_iopad_gpio_9_.OD,
			`SOC_TOP.u_iopad_gpio_8_.OD,
			`SOC_TOP.u_iopad_gpio_7_.OD,
			`SOC_TOP.u_iopad_gpio_6_.OD,
			`SOC_TOP.u_iopad_gpio_5_.OD,
			`SOC_TOP.u_iopad_gpio_4_.OD,
			`SOC_TOP.u_iopad_gpio_3_.OD,
			`SOC_TOP.u_iopad_gpio_2_.OD,
			`SOC_TOP.u_iopad_gpio_1_.OD,
			`SOC_TOP.u_iopad_gpio_0_.OD};

 	 o_IOBUF_PD= {   
			`SOC_TOP.u_iopad_gpio_18_.PD,
		        `SOC_TOP.u_iopad_gpio_17_.PD,
			`SOC_TOP.u_iopad_gpio_16_.PD,
			`SOC_TOP.u_iopad_gpio_15_.PD,
			`SOC_TOP.u_iopad_gpio_14_.PD,
			`SOC_TOP.u_iopad_gpio_13_.PD,
			`SOC_TOP.u_iopad_gpio_12_.PD,
			`SOC_TOP.u_iopad_gpio_11_.PD,
			`SOC_TOP.u_iopad_gpio_10_.PD,
			`SOC_TOP.u_iopad_gpio_9_.PD,
			`SOC_TOP.u_iopad_gpio_8_.PD,
			`SOC_TOP.u_iopad_gpio_7_.PD,
			`SOC_TOP.u_iopad_gpio_6_.PD,
			`SOC_TOP.u_iopad_gpio_5_.PD,
			`SOC_TOP.u_iopad_gpio_4_.PD,
			`SOC_TOP.u_iopad_gpio_3_.PD,
			`SOC_TOP.u_iopad_gpio_2_.PD,
			`SOC_TOP.u_iopad_gpio_1_.PD,
			`SOC_TOP.u_iopad_gpio_0_.PD};

        if(o_IOBUF_IE !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_IE] The value read: %h is not as expected value: %h", o_IOBUF_IE, 19'h0_0000)); end 
    	if(o_IOBUF_CS !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_CS] The value read: %h is not as expected value: %h", o_IOBUF_CS, 19'h0_0000)); end
    	if(o_IOBUF_PU !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_PU] The value read: %h is not as expected value: %h", o_IOBUF_PU, 19'h0_0000)); end
    	if(o_IOBUF_SR !== 19'h7_FFFF) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_SR] The value read: %h is not as expected value: %h", o_IOBUF_SR, 19'h7_FFFF)); end
    	if(o_IOBUF_DR !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_DR] The value read: %h is not as expected value: %h", o_IOBUF_DR, 19'h0_0000)); end
    	if(o_IOBUF_A  !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_A] The value read: %h is not as expected value: %h", o_IOBUF_A, 19'h0_0000)); end 
    	if(o_IOBUF_OE !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OE] The value read: %h is not as expected value: %h", o_IOBUF_OE, 19'h0_0000)); end
    	if(o_IOBUF_OS !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OS] The value read: %h is not as expected value: %h", o_IOBUF_OS, 19'h0_0000)); end
    	if(o_IOBUF_OD !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OD] The value read: %h is not as expected value: %h", o_IOBUF_OD, 19'h0_0000)); end
    	if(o_IOBUF_PD !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_PD] The value read: %h is not as expected value: %h", o_IOBUF_PD, 19'h0_0000)); end


        if(`SOC_TOP.u_iopad_testmode0.IE  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.IE, 1'h0)); end 
     	if(`SOC_TOP.u_iopad_testmode0.PD  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.PD, 1'h0)); end 
    	if(`SOC_TOP.u_iopad_testmode0.PU  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.PU, 1'h0)); end 
	if(`SOC_TOP.u_iopad_testmode1.IE !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.IE, 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.PU !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.PU ] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.PU , 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.PD !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.PD, 1'h0)); end
	if(`SOC_TOP.u_iopad_exresetn.IE   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.IE, 1'h0)); end
    	if(`SOC_TOP.u_iopad_exresetn.PD   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.PD, 1'h0)); end 
    	if(`SOC_TOP.u_iopad_exresetn.PU   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.PU, 1'h0)); end
	if(`SOC_TOP.u_iopad_testmode0.Y   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.Y, 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.Y  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.Y, 1'h0)); end
    	if(`SOC_TOP.u_iopad_exresetn.Y !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.Y, 1'h0)); end 	
    	
   /*`else 
      `ifdef POST_LAYOUT
          o_IOBUF_Y = {
			`SOC_TOP.u_iopad_gpio_18_.Y,
		        `SOC_TOP.u_iopad_gpio_17_.Y,
			`SOC_TOP.u_iopad_gpio_16_.Y,
			`SOC_TOP.u_iopad_gpio_15_.Y,
			`SOC_TOP.u_iopad_gpio_14_.Y,
			`SOC_TOP.u_iopad_gpio_13_.Y,
			`SOC_TOP.u_iopad_gpio_12_.Y,
			`SOC_TOP.u_iopad_gpio_11_.Y,
			`SOC_TOP.u_iopad_gpio_10_.Y,
			`SOC_TOP.u_iopad_gpio_9_.Y,
			`SOC_TOP.u_iopad_gpio_8_.Y,
			`SOC_TOP.u_iopad_gpio_7_.Y,
			`SOC_TOP.u_iopad_gpio_6_.Y,
			`SOC_TOP.u_iopad_gpio_5_.Y,
			`SOC_TOP.u_iopad_gpio_4_.Y,
			`SOC_TOP.u_iopad_gpio_3_.Y,
			`SOC_TOP.u_iopad_gpio_2_.Y,
			`SOC_TOP.u_iopad_gpio_1_.Y,
			`SOC_TOP.u_iopad_gpio_0_.Y};

  	 o_IOBUF_IE = { 
			`SOC_TOP.u_iopad_gpio_18_.IE,
		        `SOC_TOP.u_iopad_gpio_17_.IE,
			`SOC_TOP.u_iopad_gpio_16_.IE,
			`SOC_TOP.u_iopad_gpio_15_.IE,
			`SOC_TOP.u_iopad_gpio_14_.IE,
			`SOC_TOP.u_iopad_gpio_13_.IE,
			`SOC_TOP.u_iopad_gpio_12_.IE,
			`SOC_TOP.u_iopad_gpio_11_.IE,
			`SOC_TOP.u_iopad_gpio_10_.IE,
			`SOC_TOP.u_iopad_gpio_9_.IE,
			`SOC_TOP.u_iopad_gpio_8_.IE,
			`SOC_TOP.u_iopad_gpio_7_.IE,
			`SOC_TOP.u_iopad_gpio_6_.IE,
			`SOC_TOP.u_iopad_gpio_5_.IE,
			`SOC_TOP.u_iopad_gpio_4_.IE,
			`SOC_TOP.u_iopad_gpio_3_.IE,
			`SOC_TOP.u_iopad_gpio_2_.IE,
			`SOC_TOP.u_iopad_gpio_1_.IE,
			`SOC_TOP.u_iopad_gpio_0_.IE};


 	 o_IOBUF_CS= {   
			`SOC_TOP.u_iopad_gpio_18_.CS,
		        `SOC_TOP.u_iopad_gpio_17_.CS,
			`SOC_TOP.u_iopad_gpio_16_.CS,
			`SOC_TOP.u_iopad_gpio_15_.CS,
			`SOC_TOP.u_iopad_gpio_14_.CS,
			`SOC_TOP.u_iopad_gpio_13_.CS,
			`SOC_TOP.u_iopad_gpio_12_.CS,
			`SOC_TOP.u_iopad_gpio_11_.CS,
			`SOC_TOP.u_iopad_gpio_10_.CS,
			`SOC_TOP.u_iopad_gpio_9_.CS,
			`SOC_TOP.u_iopad_gpio_8_.CS,
			`SOC_TOP.u_iopad_gpio_7_.CS,
			`SOC_TOP.u_iopad_gpio_6_.CS,
			`SOC_TOP.u_iopad_gpio_5_.CS,
			`SOC_TOP.u_iopad_gpio_4_.CS,
			`SOC_TOP.u_iopad_gpio_3_.CS,
			`SOC_TOP.u_iopad_gpio_2_.CS,
			`SOC_TOP.u_iopad_gpio_1_.CS,
			`SOC_TOP.u_iopad_gpio_0_.CS};

 	 o_IOBUF_PU= {   
			`SOC_TOP.u_iopad_gpio_18_.PU,
		        `SOC_TOP.u_iopad_gpio_17_.PU,
			`SOC_TOP.u_iopad_gpio_16_.PU,
			`SOC_TOP.u_iopad_gpio_15_.PU,
			`SOC_TOP.u_iopad_gpio_14_.PU,
			`SOC_TOP.u_iopad_gpio_13_.PU,
			`SOC_TOP.u_iopad_gpio_12_.PU,
			`SOC_TOP.u_iopad_gpio_11_.PU,
			`SOC_TOP.u_iopad_gpio_10_.PU,
			`SOC_TOP.u_iopad_gpio_9_.PU,
			`SOC_TOP.u_iopad_gpio_8_.PU,
			`SOC_TOP.u_iopad_gpio_7_.PU,
			`SOC_TOP.u_iopad_gpio_6_.PU,
			`SOC_TOP.u_iopad_gpio_5_.PU,
			`SOC_TOP.u_iopad_gpio_4_.PU,
			`SOC_TOP.u_iopad_gpio_3_.PU,
			`SOC_TOP.u_iopad_gpio_2_.PU,
			`SOC_TOP.u_iopad_gpio_1_.PU,
			`SOC_TOP.u_iopad_gpio_0_.PU};

 	 o_IOBUF_SR= {   
			`SOC_TOP.u_iopad_gpio_18_.SR,
		        `SOC_TOP.u_iopad_gpio_17_.SR,
			`SOC_TOP.u_iopad_gpio_16_.SR,
			`SOC_TOP.u_iopad_gpio_15_.SR,
			`SOC_TOP.u_iopad_gpio_14_.SR,
			`SOC_TOP.u_iopad_gpio_13_.SR,
			`SOC_TOP.u_iopad_gpio_12_.SR,
			`SOC_TOP.u_iopad_gpio_11_.SR,
			`SOC_TOP.u_iopad_gpio_10_.SR,
			`SOC_TOP.u_iopad_gpio_9_.SR,
			`SOC_TOP.u_iopad_gpio_8_.SR,
			`SOC_TOP.u_iopad_gpio_7_.SR,
			`SOC_TOP.u_iopad_gpio_6_.SR,
			`SOC_TOP.u_iopad_gpio_5_.SR,
			`SOC_TOP.u_iopad_gpio_4_.SR,
			`SOC_TOP.u_iopad_gpio_3_.SR,
			`SOC_TOP.u_iopad_gpio_2_.SR,
			`SOC_TOP.u_iopad_gpio_1_.SR,
			`SOC_TOP.u_iopad_gpio_0_.SR};

 	 o_IOBUF_DR= {   
			`SOC_TOP.u_iopad_gpio_18_.DR,
		        `SOC_TOP.u_iopad_gpio_17_.DR,
			`SOC_TOP.u_iopad_gpio_16_.DR,
			`SOC_TOP.u_iopad_gpio_15_.DR,
			`SOC_TOP.u_iopad_gpio_14_.DR,
			`SOC_TOP.u_iopad_gpio_13_.DR,
			`SOC_TOP.u_iopad_gpio_12_.DR,
			`SOC_TOP.u_iopad_gpio_11_.DR,
			`SOC_TOP.u_iopad_gpio_10_.DR,
			`SOC_TOP.u_iopad_gpio_9_.DR,
			`SOC_TOP.u_iopad_gpio_8_.DR,
			`SOC_TOP.u_iopad_gpio_7_.DR,
			`SOC_TOP.u_iopad_gpio_6_.DR,
			`SOC_TOP.u_iopad_gpio_5_.DR,
			`SOC_TOP.u_iopad_gpio_4_.DR,
			`SOC_TOP.u_iopad_gpio_3_.DR,
			`SOC_TOP.u_iopad_gpio_2_.DR,
			`SOC_TOP.u_iopad_gpio_1_.DR,
			`SOC_TOP.u_iopad_gpio_0_.DR};

 	 o_IOBUF_A = {   
			`SOC_TOP.u_iopad_gpio_18_.A,
		        `SOC_TOP.u_iopad_gpio_17_.A,
			`SOC_TOP.u_iopad_gpio_16_.A,
			`SOC_TOP.u_iopad_gpio_15_.A,
			`SOC_TOP.u_iopad_gpio_14_.A,
			`SOC_TOP.u_iopad_gpio_13_.A,
			`SOC_TOP.u_iopad_gpio_12_.A,
			`SOC_TOP.u_iopad_gpio_11_.A,
			`SOC_TOP.u_iopad_gpio_10_.A,
			`SOC_TOP.u_iopad_gpio_9_.A,
			`SOC_TOP.u_iopad_gpio_8_.A,
			`SOC_TOP.u_iopad_gpio_7_.A,
			`SOC_TOP.u_iopad_gpio_6_.A,
			`SOC_TOP.u_iopad_gpio_5_.A,
			`SOC_TOP.u_iopad_gpio_4_.A,
			`SOC_TOP.u_iopad_gpio_3_.A,
			`SOC_TOP.u_iopad_gpio_2_.A,
			`SOC_TOP.u_iopad_gpio_1_.A,
			`SOC_TOP.u_iopad_gpio_0_.A};

 	 o_IOBUF_OE= {   
			`SOC_TOP.u_iopad_gpio_18_.OE,
		        `SOC_TOP.u_iopad_gpio_17_.OE,
			`SOC_TOP.u_iopad_gpio_16_.OE,
			`SOC_TOP.u_iopad_gpio_15_.OE,
			`SOC_TOP.u_iopad_gpio_14_.OE,
			`SOC_TOP.u_iopad_gpio_13_.OE,
			`SOC_TOP.u_iopad_gpio_12_.OE,
			`SOC_TOP.u_iopad_gpio_11_.OE,
			`SOC_TOP.u_iopad_gpio_10_.OE,
			`SOC_TOP.u_iopad_gpio_9_.OE,
			`SOC_TOP.u_iopad_gpio_8_.OE,
			`SOC_TOP.u_iopad_gpio_7_.OE,
			`SOC_TOP.u_iopad_gpio_6_.OE,
			`SOC_TOP.u_iopad_gpio_5_.OE,
			`SOC_TOP.u_iopad_gpio_4_.OE,
			`SOC_TOP.u_iopad_gpio_3_.OE,
			`SOC_TOP.u_iopad_gpio_2_.OE,
			`SOC_TOP.u_iopad_gpio_1_.OE,
			`SOC_TOP.u_iopad_gpio_0_.OE};

 	 o_IOBUF_OS= {   
			`SOC_TOP.u_iopad_gpio_18_.OS,
		        `SOC_TOP.u_iopad_gpio_17_.OS,
			`SOC_TOP.u_iopad_gpio_16_.OS,
			`SOC_TOP.u_iopad_gpio_15_.OS,
			`SOC_TOP.u_iopad_gpio_14_.OS,
			`SOC_TOP.u_iopad_gpio_13_.OS,
			`SOC_TOP.u_iopad_gpio_12_.OS,
			`SOC_TOP.u_iopad_gpio_11_.OS,
			`SOC_TOP.u_iopad_gpio_10_.OS,
			`SOC_TOP.u_iopad_gpio_9_.OS,
			`SOC_TOP.u_iopad_gpio_8_.OS,
			`SOC_TOP.u_iopad_gpio_7_.OS,
			`SOC_TOP.u_iopad_gpio_6_.OS,
			`SOC_TOP.u_iopad_gpio_5_.OS,
			`SOC_TOP.u_iopad_gpio_4_.OS,
			`SOC_TOP.u_iopad_gpio_3_.OS,
			`SOC_TOP.u_iopad_gpio_2_.OS,
			`SOC_TOP.u_iopad_gpio_1_.OS,
			`SOC_TOP.u_iopad_gpio_0_.OS};

 	 o_IOBUF_OD= {   
			`SOC_TOP.u_iopad_gpio_18_.OD,
		        `SOC_TOP.u_iopad_gpio_17_.OD,
			`SOC_TOP.u_iopad_gpio_16_.OD,
			`SOC_TOP.u_iopad_gpio_15_.OD,
			`SOC_TOP.u_iopad_gpio_14_.OD,
			`SOC_TOP.u_iopad_gpio_13_.OD,
			`SOC_TOP.u_iopad_gpio_12_.OD,
			`SOC_TOP.u_iopad_gpio_11_.OD,
			`SOC_TOP.u_iopad_gpio_10_.OD,
			`SOC_TOP.u_iopad_gpio_9_.OD,
			`SOC_TOP.u_iopad_gpio_8_.OD,
			`SOC_TOP.u_iopad_gpio_7_.OD,
			`SOC_TOP.u_iopad_gpio_6_.OD,
			`SOC_TOP.u_iopad_gpio_5_.OD,
			`SOC_TOP.u_iopad_gpio_4_.OD,
			`SOC_TOP.u_iopad_gpio_3_.OD,
			`SOC_TOP.u_iopad_gpio_2_.OD,
			`SOC_TOP.u_iopad_gpio_1_.OD,
			`SOC_TOP.u_iopad_gpio_0_.OD};

 	 o_IOBUF_PD= {   
			`SOC_TOP.u_iopad_gpio_18_.PD,
		        `SOC_TOP.u_iopad_gpio_17_.PD,
			`SOC_TOP.u_iopad_gpio_16_.PD,
			`SOC_TOP.u_iopad_gpio_15_.PD,
			`SOC_TOP.u_iopad_gpio_14_.PD,
			`SOC_TOP.u_iopad_gpio_13_.PD,
			`SOC_TOP.u_iopad_gpio_12_.PD,
			`SOC_TOP.u_iopad_gpio_11_.PD,
			`SOC_TOP.u_iopad_gpio_10_.PD,
			`SOC_TOP.u_iopad_gpio_9_.PD,
			`SOC_TOP.u_iopad_gpio_8_.PD,
			`SOC_TOP.u_iopad_gpio_7_.PD,
			`SOC_TOP.u_iopad_gpio_6_.PD,
			`SOC_TOP.u_iopad_gpio_5_.PD,
			`SOC_TOP.u_iopad_gpio_4_.PD,
			`SOC_TOP.u_iopad_gpio_3_.PD,
			`SOC_TOP.u_iopad_gpio_2_.PD,
			`SOC_TOP.u_iopad_gpio_1_.PD,
			`SOC_TOP.u_iopad_gpio_0_.PD};

        if(o_IOBUF_IE !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_IE] The value read: %h is not as expected value: %h", o_IOBUF_IE, 19'h0_0000)); end 
    	if(o_IOBUF_CS !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_CS] The value read: %h is not as expected value: %h", o_IOBUF_CS, 19'h0_0000)); end
    	if(o_IOBUF_PU !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_PU] The value read: %h is not as expected value: %h", o_IOBUF_PU, 19'h0_0000)); end
    	if(o_IOBUF_SR !== 19'h7_FFFF) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_SR] The value read: %h is not as expected value: %h", o_IOBUF_SR, 19'h7_FFFF)); end
    	if(o_IOBUF_DR !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_DR] The value read: %h is not as expected value: %h", o_IOBUF_DR, 19'h0_0000)); end
    	if(o_IOBUF_A  !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_A] The value read: %h is not as expected value: %h", o_IOBUF_A, 19'h0_0000)); end 
    	if(o_IOBUF_OE !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OE] The value read: %h is not as expected value: %h", o_IOBUF_OE, 19'h0_0000)); end
    	if(o_IOBUF_OS !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OS] The value read: %h is not as expected value: %h", o_IOBUF_OS, 19'h0_0000)); end
    	if(o_IOBUF_OD !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_OD] The value read: %h is not as expected value: %h", o_IOBUF_OD, 19'h0_0000)); end
    	if(o_IOBUF_PD !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [o_IOBUF_PD] The value read: %h is not as expected value: %h", o_IOBUF_PD, 19'h0_0000)); end
        if(`SOC_TOP.u_iopad_testmode0.IE  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.IE, 1'h0)); end 
     	if(`SOC_TOP.u_iopad_testmode0.PD  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.PD, 1'h0)); end 
    	if(`SOC_TOP.u_iopad_testmode0.PU  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.PU, 1'h0)); end 
	if(`SOC_TOP.u_iopad_testmode1.IE !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.IE, 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.PU !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.PU ] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.PU , 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.PD !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.PD, 1'h0)); end
	if(`SOC_TOP.u_iopad_exresetn.IE   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.IE, 1'h0)); end
    	if(`SOC_TOP.u_iopad_exresetn.PD   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.PD, 1'h0)); end 
    	if(`SOC_TOP.u_iopad_exresetn.PU   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.PU, 1'h0)); end
	if(`SOC_TOP.u_iopad_testmode0.Y   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.Y, 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.Y  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.Y, 1'h0)); end
    	if(`SOC_TOP.u_iopad_exresetn.Y !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.Y, 1'h0)); end 	
      `else        
        if(`ALWAYSON_TOP.o_IOBUF_IE !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_IE] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_IE, 19'h0_0000)); end 
    	if(`ALWAYSON_TOP.o_IOBUF_CS !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_CS] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_CS, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_PU !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_PU] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_PU, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_SR !== 19'h7_FFFF) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_SR] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_SR, 19'h7_FFFF)); end
    	if(`ALWAYSON_TOP.o_IOBUF_DR !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_DR] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_DR, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_A  !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_A] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_A, 19'h0_0000)); end 
    	if(`ALWAYSON_TOP.o_IOBUF_OE !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_OE] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_OE, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_OS !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_OS] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_IOBUF_OS, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_OD !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_OD] The value read: %h is not as expected value: %h",`ALWAYSON_TOP.o_IOBUF_OD, 19'h0_0000)); end
    	if(`ALWAYSON_TOP.o_IOBUF_PD !== 19'h0_0000) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_IOBUF_PD] The value read: %h is not as expected value: %h",`ALWAYSON_TOP.o_IOBUF_PD, 19'h0_0000)); end
        if(`SOC_TOP.u_iopad_testmode0.IE  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.IE, 1'h0)); end 
     	if(`SOC_TOP.u_iopad_testmode0.PD  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.PD, 1'h0)); end 
    	if(`SOC_TOP.u_iopad_testmode0.PU  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.PU, 1'h0)); end 
	if(`SOC_TOP.u_iopad_testmode1.IE !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.IE, 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.PU !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.PU ] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.PU , 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.PD !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.PD, 1'h0)); end
	if(`SOC_TOP.u_iopad_exresetn.IE   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.IE] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.IE, 1'h0)); end
    	if(`SOC_TOP.u_iopad_exresetn.PD   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.PD] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.PD, 1'h0)); end 
    	if(`SOC_TOP.u_iopad_exresetn.PU   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.PU] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.PU, 1'h0)); end
	if(`SOC_TOP.u_iopad_testmode0.Y   !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode0.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode0.Y, 1'h0)); end
    	if(`SOC_TOP.u_iopad_testmode1.Y  !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_testmode1.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_testmode1.Y, 1'h0)); end
    	if(`SOC_TOP.u_iopad_exresetn.Y !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR] [`SOC_TOP.u_iopad_exresetn.Y] The value read: %h is not as expected value: %h", `SOC_TOP.u_iopad_exresetn.Y, 1'h0)); end 	
   `endif     */	
`endif 
endtask

task do_run_check_ana_reg_val;
    //========================================================================================//
    // commented by ophina as it is removed in BAF4P1
    //========================================================================================//
/*
    //1.
     if(`ANA_TOP.D2A_CPCLK[2:0]  !== 3'd3 ) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CPCLK[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CPCLK[2:0], 3'h3)); end
    
    //2.      
    if(`ANA_TOP.D2A_CH1_WE1_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE1_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE1_EN, 1'h1)); end 
    if(`ANA_TOP.D2A_CH1_WE1_DDA_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE1_DDA_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE1_DDA_EN, 1'h1)); end
    if(`ANA_TOP.D2A_CH1_WE1_RFB_SEL[3:0] !== 4'hF) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE1_RFB_SEL[3:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE1_RFB_SEL[3:0], 4'hf)); end 

    //3.  
    if(`ANA_TOP.D2A_CH1_WE1_ROUT_SEL[2:0]  !== 3'h7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE1_ROUT_SEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE1_ROUT_SEL[2:0], 3'h7)); end
    if(`ANA_TOP.D2A_CH1_WE1_VGAIN_SEL[2:0] !== 3'd7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE1_VGAIN_SEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE1_VGAIN_SEL[2:0], 3'h7)); end

    //4.
    if(`ANA_TOP.D2A_CH1_WE2_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE2_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE2_EN, 1'h1)); end
    if(`ANA_TOP.D2A_CH1_WE2_DDA_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE2_DDA_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE2_DDA_EN, 1'h1)); end
    if(`ANA_TOP.D2A_CH1_WE2_RFB_SEL[3:0] !== 4'hF) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE2_RFB_SEL[3:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE2_RFB_SEL[3:0], 4'hf)); end
    
    //5.
    if(`ANA_TOP.D2A_CH1_WE2_ROUT_SEL[2:0] !== 3'd7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE2_ROUT_SEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE2_ROUT_SEL[2:0], 3'h7)); end
    if(`ANA_TOP.D2A_CH1_WE2_VGAIN_SEL[2:0] !== 3'd7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE2_VGAIN_SEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE2_VGAIN_SEL[2:0], 3'h7)); end 

    //6.
    if(`ANA_TOP.D2A_CH1_RCE_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_RCE_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_RCE_EN, 1'h1)); end
    if(`ANA_TOP.D2A_CH1_CE_ROUT_SEL[2:0] !== 3'd7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_CE_ROUT_SEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_CE_ROUT_SEL[2:0], 3'h7)); end 
    
    //7.     
    if(`ANA_TOP.D2A_CH1_WE_DAC_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_WE_DAC_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_WE_DAC_EN, 1'h1)); end    
    
    //8.   
    if(`ANA_TOP.D2A_CH1_DINWE[9:0] !== 12'h3FF) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_DINWE[9:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_DINWE[9:0], 12'h3FF)); end
 
    //9.
    if(`ANA_TOP.D2A_CH1_RCE_DAC_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_RCE_DAC_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_RCE_DAC_EN, 1'h1)); end
   
    //10.  
    if(`ANA_TOP.D2A_CH1_DINRCE[9:0] !== 12'h3FF) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_CH1_DINRCE[9:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_CH1_DINRCE[9:0], 12'h3ff)); end
*/ 
    //11.
    /*if(`ANA_TOP.CH2_WE1_EN !== 1'd1) error++; 
    if(`ANA_TOP.CH2_WE1_DDA_EN!== 1'd1) error++;
    if(`ANA_TOP.CH2_WE1_RFB_SEL[3:0] !== 4'hF) error++;*/ 
     
    //12.      
    /*if(`ANA_TOP.CH2_WE1_ROUT_SEL[2:0]  !== 3'h7) error++;
    if(`ANA_TOP.CH2_WE1_VGAIN_SEL[2:0] !== 3'h7) error++;*/
  
    //13.    
    /*if(`ANA_TOP.CH2_WE2_EN !== 1'd1) error++;
    if(`ANA_TOP.CH2_WE2_DDA_EN !== 1'd1) error++;
    if(`ANA_TOP.CH2_WE2_RFB_SEL[3:0] !== 4'hF) error++;*/
   
    //14.       
    /*if(`ANA_TOP.CH2_WE2_ROUT_SEL[2:0] !== 3'h7) error++;
    if(`ANA_TOP.CH2_WE2_VGAIN_SEL[2:0] !== 3'h7) error++; */
 
    //15. 
    /*if(`ANA_TOP.CH2_RCE_EN !== 1'd1) error++;
    if(`ANA_TOP.CH2_CE_ROUT_SEL[2:0] !== 3'h7) error++;*/ 

    //16.
    /*if(`ANA_TOP.CH2_WE_DAC_EN !== 1'd1) error++;*/

    //17.    
    /*if(`ANA_TOP.CH2_DINWE[11:0] !== 12'hFFF) error++;*/
   
    //18.
    /*if(`ANA_TOP.CH2_RCE_DAC_EN !== 1'd1) error++;*/

    //19.
    /*if(`ANA_TOP.CH2_DINRCE[11:0] !== 12'hFFF) error++;*/
/*
    //20. 
    if(`ANA_TOP.D2A_BG_BUF_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BG_BUF_EN ] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BG_BUF_EN , 1'h1)); end
    if(`ANA_TOP.D2A_DAC_BUF_EN !== 1'd1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_DAC_BUF_EN ] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_DAC_BUF_EN , 1'h1)); end
*/
    //========================================================================================//

    //21.          
    if(`ANA_TOP.D2A_BIST_EN !== 1'h1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BIST_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BIST_EN, 1'h1)); end
    if(`ANA_TOP.D2A_BIST_ISEL[2:0] !== 3'h7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BIST_ISEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BIST_ISEL[2:0], 3'h7)); end;

    //========================================================================================//
    // commented by ophina as it is removed in BAF4P1
    //========================================================================================//
/*   
    //22.       
    if(`ANA_TOP.D2A_DDA_EN !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_DDA_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_DDA_EN, 1'h1)); end
    if(`ANA_TOP.D2A_DDA_GSEL[2:0] !== 3'h7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_DDA_GSEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_DDA_GSEL[2:0], 3'h7)); end
    
    //23.          
    if(`ANA_TOP.D2A_ELE_BUF_EN !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_ELE_BUF_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_ELE_BUF_EN, 1'h1)); end
    if(`ANA_TOP.D2A_ELE_BUF_ISEL[2:0] !==3'h7) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_ELE_BUF_ISEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_ELE_BUF_ISEL[2:0], 7'h7)); end
*/
    //========================================================================================//
    //24.
    /*if(`ANA_TOP.R2R_DAC1_EN !== 1'b1) error++;*/

    //25.
    /*if(`ANA_TOP.R2R_DAC1_DIN[11:0] !== 12'hFFF) error++;*/
   
    //26.
    /*if(`ANA_TOP.R2R_DAC2_EN !== 1'b1) error++;*/

    //27.          
    /*if(`ANA_TOP.R2R_DAC2_DIN[11:0] !== 12'hFFF) error++;*/
    //
    //if(`ANA_TOP.D2A_BGL_CTRIM[6:0] !== 7'h40) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BGL_CTRIM[6:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BGL_CTRIM[6:0], 7'h40)); end   
    if(`ANA_TOP.D2A_BGH_VTRIM[4:0]  !== 5'h10) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BGH_VTRIM[4:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BGH_VTRIM[4:0], 5'h10)); end
    //if(`ANA_TOP.D2A_BGL_VTRIM[4:0] !== 5'h10) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BGL_VTRIM[4:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BGL_VTRIM[4:0], 5'h10)); end 
    if(`ANA_TOP.D2A_BGH_CTRIM[6:0] !== 7'h40) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BGH_CTRIM[6:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BGH_CTRIM[6:0], 7'h40)); end
    //if(`ANA_TOP.D2A_DAC_BUF_TRIM[1:0] !== 2'h2) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_DAC_BUF_TRIM[1:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_DAC_BUF_TRIM[1:0], 2'h2)); end
    if(`ANA_TOP.D2A_LDO1V5_VTRIM[1:0] !== 2'h2) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_LDO1V5_VTRIM[1:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_LDO1V5_VTRIM[1:0], 2'h2)); end
    if(`ANA_TOP.D2A_OSC_TRIM[5:0] !== 6'h20) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_OSC_TRIM[5:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_OSC_TRIM[5:0], 6'h20)); end

endtask
/*
task do_run_spi_burst_wr_reg; 
  // Write burst transfer with values (randomized in SPI Master Model) to Register
  // spi_wr_burst_reg(addr, no_of_bytes, pads);
  no_of_bytes = 8'h8;
  #2000;
    //1. 
    `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b00,3'b000,3'b100},pads,mask); 
    `RD_NORMAL_REG(`SOC_CLK_CTRL_REG, 8'h00, rd_alwayson_clkctrl_reg);
    if(rd_alwayson_clkctrl_reg !== 8'h4) begin `uvm_error("", $sformatf("\t[ERROR] [rd_alwayson_clkctrl_reg] The value read: %h is not as expected value: %h", rd_alwayson_clkctrl_reg, 8'h4)); end
    //2.
    spi_wr_burst_reg(`ANA_IMEAS_CH1_WE1_0, no_of_bytes, pads);
    spi_wr_burst_reg(`ANA_IMEAS_CH1_RCE_DAC_EN, no_of_bytes, pads); 
    //spi_wr_burst_reg(`ANA_IMEAS_CH2_WE_DAC_EN, no_of_bytes, pads);
    spi_wr_burst_reg(`ANA_PGA, no_of_bytes, pads);
    //3.
    `WR_RD_CHK_NORMAL_REG(`ANA_PMU, {6'h0,2'h2}, pads, mask);
    `RD_NORMAL_REG(`ANA_PMU,8'h00,rd_ana_pmu0_reg);   //bg_buffer_en 
    if(rd_ana_pmu0_reg !== 8'h2) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ana_pmu0_reg] The value read: %h is not as expected value: %h", rd_ana_pmu0_reg, 8'h2)); end
endtask

task do_run_spi_burst_rd_reg;
     #20000;
     no_of_bytes = 8'd32;
     rd_data_reg = new[no_of_bytes];
      
     spi_rd_burst_reg(`ANA_IMEAS_CH1_WE1_0, no_of_bytes, rd_data_reg);
     #200000;
     for(int i=0; i<no_of_bytes; i++) begin
        ana_reg_data[i] = rd_data_reg[(no_of_bytes-1)-i];
        //`uvm_info("",  $time,"\tana reg data_%d: (0x%x)\n", i, ana_reg_data[i], UVM_LOW);
        if(ana_reg_data[i] != ana_reg_expd[i]) begin
          begin `uvm_error("", $sformatf("\t[ERROR] [ana_reg_data[i]] The value read: %h is not as expected value: %h", ana_reg_data[i], ana_reg_expd[i])); end
          `uvm_info("",  $time,"\tERROR READ%0d!!! ALWAYS ON SPI WRITE FAILED!!!", i, UVM_LOW);
        end
        #20000;
     end
endtask

task do_run_spi_burst_rd_debug_reg;
 
      #20000;
      no_of_bytes = 8'd33;
      rd_debug_data_reg = new[no_of_bytes];
      spi_rd_burst_reg(`SOC_CLK_CTRL_REG_DEBUG, no_of_bytes, rd_data_reg);
endtask
*/
task do_run_sw_ext_resetn0_apply;

     #20000;
     //if(`SOC_TB.ext_resetn !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [rd_ALWAYS_ON_ANA_TRIM2] The value read: %h is not as expected value: %h", rd_ALWAYS_ON_ANA_TRIM2, 8'h10)); end
     `uvm_info("", "\tset SW_`SOC_TB.ext_resetn==0", UVM_LOW);
     force `SOC_TB.iopad_resetn = 1'b0;
     #200000;
     if(`ANA_TOP.A2D_Wake_UP_i !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.A2D_Wake_UP_i ] The value read: %h is not as expected value: %h", `ANA_TOP.A2D_Wake_UP_i , 1'h1)); end
     if(`ALWAYSON_TOP.o_iopad_resetn_y !== 1'b0) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_iopad_resetn_y] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_iopad_resetn_y, 1'h0)); end
     if(`ALWAYSON_TOP.A2D_VDDI_POR !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_VDDI_POR] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_VDDI_POR, 1'h1)); end
     if(`ALWAYSON_TOP.A2D_external_RESET !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_external_RESET] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_external_RESET, 1'h1)); end
     if(`ALWAYSON_TOP.scan_rst_n !== 1'b0) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.scan_rst_n] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.scan_rst_n, 1'h0)); end
     if(`ALWAYSON_TOP.poresetn_hf_sw_power !== 1'b0) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.poresetn_hf_sw_power] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.poresetn_hf_sw_power, 1'h0)); end
     if(`ALWAYSON_TOP.flash_reset_done !== 1'b0) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.flash_reset_done] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.flash_reset_done, 1'h0)); end
     #200000;
endtask

task do_run_sw_ext_resetn1_apply;

    #200000;
   `uvm_info("",  "\n set SW_`SOC_TB.ext_resetn==1 ", UVM_LOW);
   force `SOC_TB.iopad_resetn = 1'b1;  //release `SOC_TB.ext_resetn;
   #200000;
   if(`ANA_TOP.A2D_Wake_UP_i !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.A2D_Wake_UP_i] The value read: %h is not as expected value: %h", `ANA_TOP.A2D_Wake_UP_i, 1'h1)); end
   if(`ALWAYSON_TOP.o_iopad_resetn_y !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_iopad_resetn_y] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_iopad_resetn_y, 1'h1)); end
   if(`ALWAYSON_TOP.A2D_VDDI_POR !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_VDDI_POR] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_VDDI_POR, 1'h1)); end
   if(`ALWAYSON_TOP.A2D_external_RESET !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_external_RESET ] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_external_RESET , 1'h1)); end
   if(`ALWAYSON_TOP.scan_rst_n !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.scan_rst_n] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.scan_rst_n, 1'h1)); end
   wait(`ALWAYSON_TOP.poresetn_hf_sw_power == 1'b1);
   if(`ALWAYSON_TOP.poresetn_hf_sw_power !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.poresetn_hf_sw_power] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.poresetn_hf_sw_power, 1'h1)); end
   wait(`ALWAYSON_TOP.flash_reset_done == 1'b1);
   if(`ALWAYSON_TOP.flash_reset_done !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.flash_reset_done] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.flash_reset_done, 1'h1)); end
   #20000;
endtask

task do_run_spi_rd_reset_regs_val;
 
 //1.read trim values too
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA0,8'h00,rd_SOC_FLASH_TRIMDATA0_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA1,8'h00,rd_SOC_FLASH_TRIMDATA1_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA2,8'h00,rd_SOC_FLASH_TRIMDATA2_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA3,8'h00,rd_SOC_FLASH_TRIMDATA3_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA4,8'h00,rd_SOC_FLASH_TRIMDATA4_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA5,8'h00,rd_SOC_FLASH_TRIMDATA5_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA6,8'h00,rd_SOC_FLASH_TRIMDATA6_reg);   
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA7,8'h00,rd_SOC_FLASH_TRIMDATA7_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA8,8'h00,rd_SOC_FLASH_TRIMDATA8_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA9,8'h00,rd_SOC_FLASH_TRIMDATA9_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA10,8'h00,rd_SOC_FLASH_TRIMDATA10_reg);   
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA11,8'h00,rd_SOC_FLASH_TRIMDATA11_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA12,8'h00,rd_SOC_FLASH_TRIMDATA12_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA13,8'h00,rd_SOC_FLASH_TRIMDATA13_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA14,8'h00,rd_SOC_FLASH_TRIMDATA14_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA15,8'h00,rd_SOC_FLASH_TRIMDATA15_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA16,8'h00,rd_SOC_FLASH_TRIMDATA16_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA17,8'h00,rd_SOC_FLASH_TRIMDATA17_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA18,8'h00,rd_SOC_FLASH_TRIMDATA18_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA19,8'h00,rd_SOC_FLASH_TRIMDATA19_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA20,8'h00,rd_SOC_FLASH_TRIMDATA20_reg);
   if(rd_SOC_FLASH_TRIMDATA0_reg   !==  `SOC_FLASH_TRIMDATA0_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [rd_SOC_FLASH_TRIMDATA0_reg] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA0_reg, 8'h5a)); end
   if(rd_SOC_FLASH_TRIMDATA1_reg   !==  `SOC_FLASH_TRIMDATA1_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [rd_SOC_FLASH_TRIMDATA1_reg] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA1_reg, 8'h10)); end
   if(rd_SOC_FLASH_TRIMDATA2_reg   !==  `SOC_FLASH_TRIMDATA2_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [rd_SOC_FLASH_TRIMDATA2_reg] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA2_reg, 8'h40)); end
   if(rd_SOC_FLASH_TRIMDATA3_reg   !==  `SOC_FLASH_TRIMDATA3_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [rd_SOC_FLASH_TRIMDATA3_reg] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA3_reg, 8'h02)); end
   if(rd_SOC_FLASH_TRIMDATA4_reg   !==  `SOC_FLASH_TRIMDATA4_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [rd_SOC_FLASH_TRIMDATA4_reg] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA4_reg, 8'h20)); end
   if(rd_SOC_FLASH_TRIMDATA5_reg   !==  `SOC_FLASH_TRIMDATA5_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [rd_SOC_FLASH_TRIMDATA5_reg] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA5_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA6_reg   !==  `SOC_FLASH_TRIMDATA6_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [rd_SOC_FLASH_TRIMDATA6_reg] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA6_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA7_reg   !==  `SOC_FLASH_TRIMDATA7_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA7] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA7_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA8_reg   !==  `SOC_FLASH_TRIMDATA8_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA8] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA8_reg, 8'h04)); end
   if(rd_SOC_FLASH_TRIMDATA9_reg   !==  `SOC_FLASH_TRIMDATA9_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA9] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA9_reg, 8'h04)); end
   if(rd_SOC_FLASH_TRIMDATA10_reg  !== `SOC_FLASH_TRIMDATA10_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA10] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA10_reg, 8'h01)); end   
   if(rd_SOC_FLASH_TRIMDATA11_reg  !== `SOC_FLASH_TRIMDATA11_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA11] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA11_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA12_reg  !== `SOC_FLASH_TRIMDATA12_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA12] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA12_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA13_reg  !== `SOC_FLASH_TRIMDATA13_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA13] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA13_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA14_reg  !== `SOC_FLASH_TRIMDATA14_RELOAD_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA14] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA14_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA15_reg  !== `SOC_FLASH_TRIMDATA15_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA15] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA15_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA16_reg  !== `SOC_FLASH_TRIMDATA16_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA16] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA16_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA17_reg  !== `SOC_FLASH_TRIMDATA17_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA17] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA17_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA18_reg  !== `SOC_FLASH_TRIMDATA18_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA18] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA18_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA19_reg  !== `SOC_FLASH_TRIMDATA19_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA19] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA19_reg, 8'h00)); end
   if(rd_SOC_FLASH_TRIMDATA20_reg  !== `SOC_FLASH_TRIMDATA20_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [TRIM DATA20] The value read: %h is not as expected value: %h", rd_SOC_FLASH_TRIMDATA20_reg, 8'h00)); end
   //2.
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_alwayson_clkctrl_reg);
   if(rd_alwayson_clkctrl_reg  !== `SOC_CLK_CTRL_REG_INIT ) begin `uvm_error("", $sformatf("\t[ERROR] [SOC_CLK_CTRL_REG] The value read: %h is not as expected value: %h", rd_alwayson_clkctrl_reg, `SOC_CLK_CTRL_REG_INIT)); end   //pending to check with Xin
 

    

   //21
   /*`RD_NORMAL_REG(`ANA_IMEAS_CH2_DINRCE_0,8'h00, rd_imeas_ch2_dinrce_0_reg);   //8bits 
   `RD_NORMAL_REG(`ANA_IMEAS_CH2_DINRCE_1,8'h00, rd_imeas_ch2_dinrce_1_reg);   //4 bits
   if(rd_imeas_ch2_dinrce_0_reg !== 8'd0) error++;   
   if(rd_imeas_ch2_dinrce_1_reg !== 8'd0) error++;*/ 
          
   //========================================================================================//     
   
    
   //========================================================================================//
    `RD_NORMAL_REG(`SOC_ANA_BIST, 8'h00, ana_bist);  
    if(ana_bist !== 8'd0) begin `uvm_error("", $sformatf("\t[ERROR] [ana_bist] The value read: %h is not as expected value: %h", ana_bist, 8'h0)); end   
                  
    //========================================================================================//
    // commented by ophina as it is removed in BAF4P1
    //========================================================================================//
                               
endtask 

task do_run_always_on_reset0;

      #20000;
      `uvm_info("", "\tSet ALWAYS_ON_RESETN==0", UVM_LOW); 
      force `ANA_TOP.A2D_VDDI_POR =1'b0;
      //force `ANA_TOP.A2D_SW_POWER_POR =1'b0;
      #20000;
      if(`ANA_TOP.A2D_VDDI_POR !==1'b0) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.A2D_VDDI_POR] The value read: %h is not as expected value: %h", `ANA_TOP.A2D_VDDI_POR, 1'h0)); end
      if(`ANA_TOP.A2D_Wake_UP_i !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.A2D_Wake_UP_i] The value read: %h is not as expected value: %h", `ANA_TOP.A2D_Wake_UP_i, 1'h1)); end
      if(`ALWAYSON_TOP.o_iopad_resetn_y !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_iopad_resetn_y] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_iopad_resetn_y, 1'h1)); end
      if(`ALWAYSON_TOP.A2D_VDDI_POR !== 1'b0) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_VDDI_POR] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_VDDI_POR, 1'h0)); end
      if(`ALWAYSON_TOP.A2D_external_RESET !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_external_RESET] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_external_RESET, 1'h1)); end
      if(`ALWAYSON_TOP.scan_rst_n !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_external_RESET] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_external_RESET, 1'h1)); end
      if(`ALWAYSON_TOP.poresetn_hf_sw_power !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.poresetn_hf_sw_power] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.poresetn_hf_sw_power, 1'h1)); end
      if(`ALWAYSON_TOP.flash_reset_done !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.flash_reset_done] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.flash_reset_done, 1'h1)); end
      #200000;

endtask

task do_run_always_on_reset1;

     #20000;
      `uvm_info("", "\tSet ALWAYS_ON_RESETN==1", UVM_LOW); 
      force `ANA_TOP.A2D_VDDI_POR =1'b1;
      //force `ANA_TOP.A2D_SW_POWER_POR =1'b1;
      #20000;
      if(`ANA_TOP.A2D_VDDI_POR !==1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.A2D_VDDI_POR] The value read: %h is not as expected value: %h", `ANA_TOP.A2D_VDDI_POR, 1'h1)); end
      if(`ANA_TOP.A2D_Wake_UP_i !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.A2D_Wake_UP_i] The value read: %h is not as expected value: %h", `ANA_TOP.A2D_Wake_UP_i, 1'h1)); end
      if(`ALWAYSON_TOP.o_iopad_resetn_y !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_iopad_resetn_y] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_iopad_resetn_y, 1'h1)); end
      if(`ALWAYSON_TOP.A2D_VDDI_POR !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_VDDI_POR] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_VDDI_POR, 1'h1)); end
      if(`ALWAYSON_TOP.A2D_external_RESET !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_external_RESET] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_external_RESET, 1'h1)); end
      if(`ALWAYSON_TOP.scan_rst_n !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_external_RESET] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_external_RESET, 1'h1)); end
      if(`ALWAYSON_TOP.poresetn_hf_sw_power !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.poresetn_hf_sw_power] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.poresetn_hf_sw_power, 1'h1)); end
      if(`ALWAYSON_TOP.flash_reset_done !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.flash_reset_done] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.flash_reset_done, 1'h1)); end
      #200000;

endtask


task do_run_configuered_spi_rd_regs_val;   

#2000;
    //1. 
     
    `RD_NORMAL_REG(`SOC_CLK_CTRL_REG, 8'h00, rd_alwayson_clkctrl_reg);
    if(rd_alwayson_clkctrl_reg !== 8'h00) begin `uvm_error("", $sformatf("\t[ERROR] [rd_alwayson_clkctrl_reg] The value read: %h is not as expected value: %h", rd_alwayson_clkctrl_reg, 8'h00)); end

    //========================================================================================//
    // commented by ophina as it is removed in BAF4P1
    //========================================================================================//


    //========================================================================================//

    //21.          
    `RD_NORMAL_REG(`SOC_ANA_BIST, 8'h00, ana_bist);  
    if(ana_bist !== 8'hF) begin `uvm_error("", $sformatf("\t[ERROR] [ana_bist] The value read: %h is not as expected value: %h", ana_bist, 8'hf)); end   

    //========================================================================================//
    // commented by ophina as it is removed in BAF4P1
    //========================================================================================//

endtask

task do_run_alwayson_reset0_rd_debug_anac_regs_val;
    
 //1.read trim values too
   
   if(`ANA_TOP.D2A_BGH_VTRIM[4:0]  !== 5'h10) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BGH_VTRIM[4:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BGH_VTRIM[4:0], 5'h10)); end
   if(`ANA_TOP.D2A_BGH_CTRIM[6:0] !== 7'h40) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BGH_CTRIM[6:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BGH_CTRIM[6:0], 7'h40)); end
   if(`ANA_TOP.D2A_LDO1V5_VTRIM[1:0] !== 2'h2) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_LDO1V5_VTRIM[1:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_LDO1V5_VTRIM[1:0], 2'h2)); end
   if(`ANA_TOP.D2A_OSC_TRIM[5:0] !== 6'h20) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_OSC_TRIM[5:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_OSC_TRIM[5:0], 6'h20)); end

 
    
  //========================================================================================//
    if(`ANA_TOP.D2A_BIST_EN !== 1'b0) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BIST_EN] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BIST_EN, 1'h0)); end
    if(`ANA_TOP.D2A_BIST_ISEL[2:0] !== 3'b0) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.D2A_BIST_ISEL[2:0]] The value read: %h is not as expected value: %h", `ANA_TOP.D2A_BIST_ISEL[2:0], 3'h0)); end           
endtask



task do_run_always_on_ext_resetn0;
   
      #20000;
      `uvm_info("", "\tSet ALWAYS_ON_`SOC_TB.ext_resetn==0", UVM_LOW); 
      force `ANA_TOP.A2D_external_RESET =1'b0;
      //force  `SOC_TB.ext_resetn =1'b0;
      #20000;
      if(`ANA_TOP.A2D_external_RESET !==1'b0) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.A2D_external_RESET] The value read: %h is not as expected value: %h", `ANA_TOP.A2D_external_RESET, 1'h0)); end
      if(`ANA_TOP.A2D_VDDI_POR !==1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.A2D_VDDI_POR] The value read: %h is not as expected value: %h", `ANA_TOP.A2D_VDDI_POR, 1'h1)); end
      if(`ANA_TOP.A2D_Wake_UP_i !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.A2D_Wake_UP_i] The value read: %h is not as expected value: %h", `ANA_TOP.A2D_Wake_UP_i, 1'h1)); end
      if(`ALWAYSON_TOP.o_iopad_resetn_y !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_iopad_resetn_y] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_iopad_resetn_y, 1'h1)); end
      if(`ALWAYSON_TOP.A2D_VDDI_POR !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_VDDI_POR] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_VDDI_POR, 1'h1)); end
      if(`ALWAYSON_TOP.A2D_external_RESET !== 1'b0) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_external_RESET] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_external_RESET, 1'h0)); end
      if(`ALWAYSON_TOP.scan_rst_n !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_external_RESET] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_external_RESET, 1'h1)); end
      if(`ALWAYSON_TOP.poresetn_hf_sw_power !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.poresetn_hf_sw_power] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.poresetn_hf_sw_power, 1'h1)); end
      if(`ALWAYSON_TOP.flash_reset_done !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.flash_reset_done] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.flash_reset_done, 1'h1)); end
      #200000;
endtask

task do_run_always_on_ext_resetn1;

     #20000;
      `uvm_info("", "\tSet ALWAYS_ON_`SOC_TB.ext_resetn==1", UVM_LOW); 
      force `ANA_TOP.A2D_external_RESET =1'b1;
      //force  `SOC_TB.ext_resetn =1'b1;
      #20000;
      if(`ANA_TOP.A2D_external_RESET !==1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.A2D_external_RESET] The value read: %h is not as expected value: %h", `ANA_TOP.A2D_external_RESET, 1'h1)); end
      if(`ANA_TOP.A2D_VDDI_POR !==1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.A2D_VDDI_POR] The value read: %h is not as expected value: %h", `ANA_TOP.A2D_VDDI_POR, 1'h1)); end
      if(`ANA_TOP.A2D_Wake_UP_i !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ANA_TOP.A2D_Wake_UP_i] The value read: %h is not as expected value: %h", `ANA_TOP.A2D_Wake_UP_i, 1'h1)); end
      if(`ALWAYSON_TOP.o_iopad_resetn_y !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.o_iopad_resetn_y] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.o_iopad_resetn_y, 1'h1)); end
      if(`ALWAYSON_TOP.A2D_VDDI_POR !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_VDDI_POR] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_VDDI_POR, 1'h1)); end
      if(`ALWAYSON_TOP.A2D_external_RESET !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_external_RESET] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_external_RESET, 1'h1)); end
      if(`ALWAYSON_TOP.scan_rst_n !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.A2D_external_RESET] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.A2D_external_RESET, 1'h1)); end
      if(`ALWAYSON_TOP.poresetn_hf_sw_power !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.poresetn_hf_sw_power] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.poresetn_hf_sw_power, 1'h1)); end
      if(`ALWAYSON_TOP.flash_reset_done !== 1'b1) begin `uvm_error("", $sformatf("\t[ERROR] [`ALWAYSON_TOP.flash_reset_done] The value read: %h is not as expected value: %h", `ALWAYSON_TOP.flash_reset_done, 1'h1)); end
      #200000;
      `uvm_info("", "\tEnd of task do_run_always_on_`SOC_TB.ext_resetn1", UVM_LOW);
endtask


task ana_default_ao_reset;
    if(`ANA_TOP.D2A_RLD_EN        !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_RLD_EN             Default value error!!!  "/*, `ANA_TOP.D2A_RLD_EN          , 1'h0*/)); end 
    if(`ANA_TOP.D2A_VCM1P5_BUF_EN     !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_VCM1P5_BUF_EN          Default value error!!!  "/*, `ANA_TOP.D2A_VCM1P5_BUF_EN       , 1'h0*/)); end
    if(`ANA_TOP.D2A_BG1P2_BUF_EN      !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_BG1P2_BUF_EN           Default value error!!!  "/*, `ANA_TOP.D2A_BG1P2_BUF_EN        , 1'h0*/)); end
    if(`ANA_TOP.D2A_ECG_PGA_EN        !== 1'h1) begin `uvm_error("", $sformatf("[ERROR]  D2A_ECG_PGA_EN             Default value error!!!  "/*, `ANA_TOP.D2A_ECG_PGA_EN          , 1'h1*/)); end
    if(`ANA_TOP.D2A_ECG_LPF_EN        !== 1'h1) begin `uvm_error("", $sformatf("[ERROR]  D2A_ECG_LPF_EN             Default value error!!!  "/*, `ANA_TOP.D2A_ECG_LPF_EN          , 1'h1*/)); end
    if(`ANA_TOP.D2A_ECG_PGA_GSEL      !== 3'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_ECG_PGA_GSEL           Default value error!!!  "/*, `ANA_TOP.D2A_ECG_PGA_GSEL        , 3'h0*/)); end 
    if(`ANA_TOP.D2A_ECG_DDA_GSEL      !== 3'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_ECG_DDA_GSEL           Default value error!!!  "/*, `ANA_TOP.D2A_ECG_DDA_GSEL        , 3'h0*/)); end
    if(`ANA_TOP.D2A_ECG_DDA_ISEL      !== 2'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_ECG_DDA_ISEL           Default value error!!!  "/*, `ANA_TOP.D2A_ECG_DDA_ISEL        , 2'h0*/)); end
    if(`ANA_TOP.D2A_ECG_DDACHOP_EN    !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_ECG_DDACHOP_EN         Default value error!!!  "/*, `ANA_TOP.D2A_ECG_DDACHOP_EN      , 1'h0*/)); end 
    if(`ANA_TOP.D2A_ECG_DDA_EN        !== 1'h1) begin `uvm_error("", $sformatf("[ERROR]  D2A_ECG_DDA_EN             Default value error!!!  "/*, `ANA_TOP.D2A_ECG_DDA_EN          , 1'h1*/)); end
    if(`ANA_TOP.D2A_ECG_DDA_CLKSEL    !== 2'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_ECG_DDA_CLKSEL         Default value error!!!  "/*, `ANA_TOP.D2A_ECG_DDA_CLKSEL      , 2'h0*/)); end
    if(`ANA_TOP.D2A_DCLEADOFF_RMODE_EN!== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_DCLEADOFF_RMODE_EN     Default value error!!!  "/*, `ANA_TOP.D2A_DCLEADOFF_RMODE_EN  , 1'h0*/)); end
    if(`ANA_TOP.D2A_DCLEADOFF_VINFLIP !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_DCLEADOFF_VINFLIP      Default value error!!!  "/*, `ANA_TOP.D2A_DCLEADOFF_VINFLIP   , 1'h0*/)); end
    //if(`ANA_TOP.D2A_DCLEADOFF_ISEL    !== 2'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_DCLEADOFF_ISEL         Default value error!!!  "/*, `ANA_TOP.D2A_DCLEADOFF_ISEL      , 2'h0*/)); end 
    //if(`ANA_TOP.D2A_DCLEADOFF_COMP_TH !== 3'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_DCLEADOFF_COMP_TH      Default value error!!!  "/*, `ANA_TOP.D2A_DCLEADOFF_COMP_TH   , 3'h0*/)); end
    //if(`ANA_TOP.D2A_DCLEADOFF_EN      !== 1'h1) begin `uvm_error("", $sformatf("[ERROR]  D2A_DCLEADOFF_EN           Default value error!!!  "/*, `ANA_TOP.D2A_DCLEADOFF_EN        , 1'h1*/)); end
    if(`ANA_TOP.D2A_TSC_OUT_SEL       !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_TSC_OUT_SEL            Default value error!!!  "/*, `ANA_TOP.D2A_TSC_OUT_SEL         , 1'h0*/)); end
    if(`ANA_TOP.D2A_TSC_BJT_SEL       !== 3'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_TSC_BJT_SEL            Default value error!!!  "/*, `ANA_TOP.D2A_TSC_BJT_SEL         , 3'h0*/)); end
    if(`ANA_TOP.D2A_TSC_EN            !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_TSC_EN                 Default value error!!!  "/*, `ANA_TOP.D2A_TSC_EN              , 1'h0*/)); end 
    if(`ANA_TOP.D2A_TSC_INA_GSEL      !== 3'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_TSC_INA_GSEL           Default value error!!!  "/*, `ANA_TOP.D2A_TSC_INA_GSEL        , 3'h0*/)); end
    if(`ANA_TOP.D2A_LEDDAC_SEL        !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_LEDDAC_SEL             Default value error!!!  "/*, `ANA_TOP.D2A_LEDDAC_SEL          , 1'h0*/)); end 
    if(`ANA_TOP.D2A_LEDSEL            !== 2'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_LEDSEL                 Default value error!!!  "/*, `ANA_TOP.D2A_LEDSEL              , 2'h0*/)); end
    if(`ANA_TOP.D2A_PPGDAC0_VSEL[7:0] !== 8'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_PPGDAC0_VSEL[7:0]      Default value error!!!  "/*, `ANA_TOP.D2A_PPGDAC0_VSEL[7:0]   , 8'h0*/)); end 
    if(`ANA_TOP.D2A_PPGDAC0_VSEL[11:8]!== 4'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_PPGDAC0_VSEL[11:8]     Default value error!!!  "/*, `ANA_TOP.D2A_PPGDAC0_VSEL[11:8]  , 4'h0*/)); end
    if(`ANA_TOP.D2A_PPGDAC0_EN        !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_PPGDAC0_EN             Default value error!!!  "/*, `ANA_TOP.D2A_PPGDAC0_EN          , 1'h0*/)); end 
    if(`ANA_TOP.D2A_PPGDAC1_VSEL[7:0] !== 8'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_PPGDAC1_VSEL[7:0]      Default value error!!!  "/*, `ANA_TOP.D2A_PPGDAC1_VSEL[7:0]   , 8'h0*/)); end
    if(`ANA_TOP.D2A_PPGDAC1_VSEL[11:8]!== 4'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_PPGDAC1_VSEL[11:8]     Default value error!!!  "/*, `ANA_TOP.D2A_PPGDAC1_VSEL[11:8]  , 4'h0*/)); end
    if(`ANA_TOP.D2A_PPGDAC1_EN        !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_PPGDAC1_EN             Default value error!!!  "/*, `ANA_TOP.D2A_PPGDAC1_EN          , 1'h0*/)); end
    if(`ANA_TOP.D2A_TIA_IDAC          !== 8'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_TIA_IDAC               Default value error!!!  "/*, `ANA_TOP.D2A_TIA_IDAC            , 8'h0*/)); end
    if(`ANA_TOP.D2A_TIA_GAIN          !== 4'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_TIA_GAIN               Default value error!!!  "/*, `ANA_TOP.D2A_TIA_GAIN            , 4'h0*/)); end 
    if(`ANA_TOP.D2A_PPG_TEST_OUT      !== 2'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_PPG_TEST_OUT           Default value error!!!  "/*, `ANA_TOP.D2A_PPG_TEST_OUT        , 2'h0*/)); end
    if(`ANA_TOP.D2A_PPG_TEST_IN       !== 2'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_PPG_TEST_IN            Default value error!!!  "/*, `ANA_TOP.D2A_PPG_TEST_IN         , 2'h0*/)); end 
    if(`ANA_TOP.D2A_PDVREF_SEL        !== 2'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_PDVREF_SEL             Default value error!!!  "/*, `ANA_TOP.D2A_PDVREF_SEL          , 2'h0*/)); end
    if(`ANA_TOP.D2A_LED_STANDBYEN     !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_LED_STANDBYEN          Default value error!!!  "/*, `ANA_TOP.D2A_LED_STANDBYEN       , 1'h0*/)); end 
    if(`ANA_TOP.D2A_EN_PPG_AF         !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_EN_PPG_AF              Default value error!!!  "/*, `ANA_TOP.D2A_EN_PPG_AF           , 1'h0*/)); end
    if(`ANA_TOP.D2A_EN_PPG_SH         !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_EN_PPG_SH              Default value error!!!  "/*, `ANA_TOP.D2A_EN_PPG_SH           , 1'h0*/)); end
    if(`ANA_TOP.D2A_EN_PPG_BUFFER     !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_EN_PPG_BUFFER          Default value error!!!  "/*, `ANA_TOP.D2A_EN_PPG_BUFFER       , 1'h0*/)); end 
    if(`ANA_TOP.D2A_EN_TIA_VREFBUFFER !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_EN_TIA_VREFBUFFER      Default value error!!!  "/*, `ANA_TOP.D2A_EN_TIA_VREFBUFFER   , 1'h0*/)); end
    if(`ANA_TOP.D2A_EN_PPGDAC_BUFFER  !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_EN_PPGDAC_BUFFER       Default value error!!!  "/*, `ANA_TOP.D2A_EN_PPGDAC_BUFFER    , 1'h0*/)); end
    if(`ANA_TOP.D2A_PPG_SH_CK         !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_PPG_SH_CK              Default value error!!!  "/*, `ANA_TOP.D2A_PPG_SH_CK           , 1'h0*/)); end
    if(`ANA_TOP.D2A_EN_TIA            !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_EN_TIA                 Default value error!!!  "/*, `ANA_TOP.D2A_EN_TIA              , 1'h0*/)); end
    if(`ANA_TOP.D2A_LED_EN            !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_LED_EN                 Default value error!!!  "/*, `ANA_TOP.D2A_LED_EN              , 1'h0*/)); end         
    if(`ANA_TOP.D2A_BIST_ISEL         !== 4'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_BIST_ISEL              Default value error!!!  "/*, `ANA_TOP.D2A_BIST_ISEL           , 4'h0*/)); end         
    if(`ANA_TOP.D2A_BIST_EN           !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_BIST_EN                Default value error!!!  "/*, `ANA_TOP.D2A_BIST_EN             , 1'h0*/)); end         
    if(`ANA_TOP.D2A_SDM_BIAS          !== 2'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_SDM_BIAS               Default value error!!!  "/*, `ANA_TOP.D2A_SDM_BIAD            , 2'h0*/)); end         
    if(`ANA_TOP.D2A_SDM_EN            !== 1'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_SDM_EN                 Default value error!!!  "/*, `ANA_TOP.D2A_SDM_EN              , 1'h0*/)); end
    if({`ANA_TOP.D2A_ACLEADOFF_EN, `ANA_TOP.D2A_DCLEADOFF_EN}    !== 2'h0) begin `uvm_error("", $sformatf("[ERROR]  D2A_LEADOFF_EN             Default value error!!!  "/*, `ANA_TOP.D2A_LEADOFF_EN          , 1'h1*/)); end
    //if(`ANA_TOP.D2A_SDM_CLK           !== 1'h0) begin `uvm_error("", $sformatf("\t[ERROR]  D2A_SDM_CLK                Default value error!!!  \n"/*, `ANA_TOP.D2A_SDM_CLK             , 1'h0*/)); end         
    //if(`ANA_TOP.D2A_SDM_VIN_SEL       !== 3'h0) begin `uvm_error("", $sformatf("\t[ERROR]  D2A_SDM_VIN_SEL            Default value error!!!  \n"/*, `ANA_TOP.D2A_SDM_VIN_SEL         , 3'h0*/)); end
endtask











endclass : `TESTNAME
