/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_clk_ctrl_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_clk_ctrl_test                                             
// Designer	: pfwang@nanochap.com                                                                 
// Date		: 11-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_clk_ctrl_test
`define TESTCFG soc_clk_ctrl_test_cfg

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

  function new (string name = "soc_clk_ctrl_test_cfg");
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
    reg   [7:0]	rd_clkctrl_reg;
    reg   [7:0]	rd_zmeas_en_reg;
    reg   [7:0]	rd_imeas_en_reg;
    integer		error; 
    logic [7:0] 	mask;
    logic [7:0] 	pads;
    logic [7:0] 	rd_flash_debug2_reg;
    bit		flash_busy_status_bit;
    bit		flash_erase_status_bit;
    logic [7:0] 	rd_flash_debug1_reg;
    logic [7:0] 	rd_flash_config_reg;
    logic [7:0]     rd_flash_trimdata0_reg;
    logic [7:0]     rd_flash_trimdata1_reg;
    logic [7:0]     rd_flash_trimdata2_reg;
    logic [7:0]     rd_flash_trimdata3_reg;
    logic [7:0]     rd_flash_trimdata4_reg;
    logic [7:0]     rd_flash_trimdata5_reg;
    logic [7:0]     rd_flash_trimdata6_reg;
    logic [7:0]     rd_flash_trimdata7_reg;
    logic [7:0]     rd_flash_trimdata8_reg;
    logic [7:0]     rd_flash_trimdata9_reg;
    logic [7:0]     rd_flash_trimdata10_reg;
    logic [7:0]     rd_flash_trimdata11_reg;
    logic [7:0]     rd_flash_trimdata12_reg;
    logic [7:0]     rd_flash_trimdata13_reg;
    logic [7:0]     rd_flash_trimdata14_reg;
    logic [7:0]     rd_flash_trimdata15_reg;
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

    `nnc_info("SOC_TEST", "soc_clk_ctrl_test start", UVM_LOW)

    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    
    // --------------------------------------------------------
    // This is an example RD_RESET_CHK_REG 
    // --------------------------------------------------------
    error=0;
    pads = 8'h00;
    mask = 8'hff;
    #1us;
    wait(`RESETN);

    do_run;


    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    #10000ns;
    `nnc_info("SOC_TEST", "soc_clk_ctrl_test end now", UVM_LOW)

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
  `uvm_info("SOC_TEST", "\n*********From clk_ctrl_testcases*********", UVM_LOW);
  pads= 8'h00;
  mask= 8'hFF;
  //#1000;
  wait(`RESETN);
  wait(`HF_RESETN);
  `uvm_info("SOC_TEST", "Wait for PRESETn and HF_RESETN Done", UVM_LOW);
  `uvm_info("SOC_TEST", "To set zmeas_en", UVM_LOW);
  `WR_NORMAL_REG(`SOC_ZMEAS_EN,8'b01,pads);	//`WR_NORMAL_REG(addr, wr_data, pads); :: //pclk, zmeas_pclk and zmea_mclk=7812.5ns(128KHZ)
  `uvm_info("SOC_TEST", "To set imeas_en", UVM_LOW);   
  `WR_NORMAL_REG(`SOC_IMEAS_EN,8'b01,pads);

  do_run_default_conf;
  run_pclk_conf;
  run_pclk_imeasadcclk_conf0;		//generate pclk/imeas_pclk/zmeas_pclk (for different pclk divider value) , zmeas_mclk=256KHZ, imeas_dig_adc_clk (based on diffrent iclk_div value)
  //run_pclk_imeasclk_conf1;
  //run_pclk_imeasclk_conf2;
  //run_pclk_imeasclk_conf3;
  //run_pclk_imeasclk_conf4;	
  extclk1MZ;
  check_wakeup;
  check_iopad_resetn;  
  #2000000;
endtask
//----------------------------------------------------------------------------------------//
//----------------------------------------------------------------------------------------//


//----------------------------------------------------------------------------------------//
//----------------------------------------------------------------------------------------//
task do_run_default_conf;
begin
    
/*
   //1. wait fot spi_busy transition from HIGH -> LOW
   `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,pads,rd_flash_debug2_reg); 		//by this time assumes flash_busy went HIGH
   flash_busy_status_bit = rd_flash_debug2_reg[6];
   while(flash_busy_status_bit)begin
	`RD_NORMAL_REG(`SOC_FLASH_DEBUG2,pads,rd_flash_debug2_reg);
	flash_busy_status_bit = rd_flash_debug2_reg[6];
   end
*/
     
   //------------- to write in to the CLK_CTRL,SOC_ZMEAS_EN,SOC_IMEAS_EN Reg's--------------// 	
   `uvm_info("SOC_TEST", "By default pclk divider value= 2'b00 & iclk divider value=3'b000", UVM_LOW);
    	//imeas_pclk and imeas_dig_adc_clk=7812.5ns(128KHZ)
   
   //to read from the CLK_CTRL reg//
   `uvm_info("SOC_TEST", "\nTo READ REG's", UVM_LOW); 
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   `RD_NORMAL_REG(`SOC_ZMEAS_EN,8'h00,rd_zmeas_en_reg);
   `RD_NORMAL_REG(`SOC_IMEAS_EN,8'h00,rd_imeas_en_reg);	     
      
   //`uvm_info("SOC_TEST", "READ SOC_CLK_CTRL_REG == 8'b%b", rd_clkctrl_reg, UVM_LOW);
   //`uvm_info("SOC_TEST", "READ SOC_ZMEAS_EN_REG == 8'b%b", rd_zmeas_en_reg, UVM_LOW);
   //`uvm_info("SOC_TEST", "READ SOC_IMEAS_EN_REG == 8'b%b", rd_imeas_en_reg, UVM_LOW);   
   if(rd_clkctrl_reg  != {2'b0,`DUT_IF.iclk_sel, `DUT_IF.pclk_sel, 1'b0} ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_zmeas_en_reg != 8'b1 )  begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_imeas_en_reg != 8'd1 )  begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
end
endtask
//------------------------------------------------------------------//


//------------------------------------------------------------------//
task run_pclk_conf;
   //`uvm_info("SOC_TEST", "\nTo set diffrent pclk divider value's", UVM_LOW);
   //clk_ctrl reg has to configured (through FLASH using SPI WR command) so
   //First configure clk_ctrl_reg
   `uvm_info("SOC_TEST", "\nTo set pclk divider value as 2'b01", UVM_LOW);	//SOC_CLK_CTRL_REG[7:0] = {o_always_on_spi_write[7],o_imeas_adc_inv[6],o_iclk_div[5:3],o_pclk_div[2:1],fclk_dynen[0]}  	
   //`WR_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h03,pads);
   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b000,3'b011},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==7812.5ns(128KHZ) & zmeas_mclk =3906.25ns(256KHZ) & imeas_dig_adc_clk=7812.5ns(128KHZ)    
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   if(rd_clkctrl_reg  != 8'd3 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   #2000;
   
   `uvm_info("SOC_TEST", "\nTo set pclk divider value as 2'b10", UVM_LOW);   
   //`WR_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h05,pads);    
   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b000,3'b101},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==15625ns(64KHZ) & zmeas_mclk =3906.25ns(256KHZ) & imeas_dig_adc_clk=7812.5ns(128KHZ)   
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   if(rd_clkctrl_reg  != 8'd5 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   #2000;      
 
   `uvm_info("SOC_TEST", "\nTo set pclk divider value as 2'b11", UVM_LOW);   
   //`WR_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h07,pads);
   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b000,3'b111},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==31250ns(32KHZ) & zmeas_mclk =3906.25ns(256KHZ) & imeas_dig_adc_clk=7812.5ns(128KHZ)
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   if(rd_clkctrl_reg  != 8'd7 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 			
   #2000;
endtask
//------------------------------------------------------------------//
		

//------------------------------------------------------------------//
task run_pclk_imeasadcclk_conf0;
  #2000;
  `uvm_info("SOC_TEST", "\nTo set diffrent iclk divider value's", UVM_LOW);
  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b00", UVM_LOW); 			
  `uvm_info("SOC_TEST", " To set iclk divider value as 3'b001", UVM_LOW); 
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b001,2'b00,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==3906.25ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=15625ns(64KHZ)   
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'd8 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #2000; 

  //2.clk_ctrl reg has to configured (through FLASH using SPI WR command)
  //3.In order to load register value to FLASH controller: set FLASG_CONFIG[7:0](bit[1] - wrcmd bit to 1)
  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b01", UVM_LOW); 
  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b010", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b010,2'b01,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==7812.5ns(128KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=31250ns(32KHZ)
  //`WR_RD_CHK_NORMAL_REG(`FLASH_CONFIG,{6'b0, 1'b1, 1'b0},pads,mask); 
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h12 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #2000;

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b011", UVM_LOW);
  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b10", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b011,2'b10,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==15625ns(64KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=62500ns(16KHZ)
  //`WR_RD_CHK_NORMAL_REG(`FLASH_CONFIG,{6'b0, 1'b1, 1'b0},pads,mask);
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h1C ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #2000;
 
  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b11", UVM_LOW);
  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b100", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b100,2'b11,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==31250ns(32KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=125000ns(8KHZ)
  //`WR_RD_CHK_NORMAL_REG(`FLASH_CONFIG,{6'b0, 1'b1, 1'b0},pads,mask);
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h26 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(10)
  #20000;

  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b00", UVM_LOW);
  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b101", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b101,2'b0,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==3906.25ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=250000ns(4KHZ)
  //`WR_RD_CHK_NORMAL_REG(`FLASH_CONFIG,{6'b0, 1'b1, 1'b0},pads,mask);
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h28 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(10)
  #300000;

  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b01", UVM_LOW);
  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b110", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b110,2'b01,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==7812.5ns(128KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=500000ns(2KHZ)
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h32 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
  repeat(10)
  #200000;

  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b10", UVM_LOW);
  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b111", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b111,2'b10,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==15625ns(64KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=1000000ns(1KHZ)
    `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h3C ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(10)
  #300000;

  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b11", UVM_LOW);
  `uvm_info("SOC_TEST", " To set iclk divider value as 2'b00", UVM_LOW);  
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b000,2'b11,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==31250ns(32KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=7812.5ns(128KHZ) & =1000000ns(1KHZ)
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h6 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #2000; 
endtask
//------------------------------------------------------------------//

//------------------------------------------------------------------//
task run_pclk_imeasclk_conf1;
  #2000;
  //`uvm_info("SOC_TEST", "\nTo set diffrent iclk divider value's", UVM_LOW);
  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b01", UVM_LOW); 			
  `uvm_info("SOC_TEST", " To set iclk divider value as 3'b001", UVM_LOW); 
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b001,2'b01,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==7812.5ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=15625ns(64KHZ)
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'hA ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #2000; 

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b010", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b010,2'b01,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==7812.5ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=31250ns(32KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h12 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #2000;

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b011", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b011,2'b01,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==7812.5ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=62500ns(16KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h1A ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #20000;

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b100", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b100,2'b01,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==7812.5ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=125000ns(8KHZ)
    `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h22 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #200000;

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b101", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b101,2'b01,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==7812.5ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=250000ns(4KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h2A ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(2);
  #2000000;

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b110", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b110,2'b01,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==7812.5ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=500000ns(2KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h32 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(8);
  #2000000;

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b111", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b111,2'b01,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==7812.5ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=1000000ns(1KHZ)   
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h3A ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(8)
  #400000;
  
  `uvm_info("SOC_TEST", " To set iclk divider value as 2'b00", UVM_LOW);  
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b000,2'b01,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==3906.25ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) imeas_dig_adc_clk=1000000ns(1KHZ) 
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h2 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(2);
  #20000; 
endtask
//------------------------------------------------------------------//

//------------------------------------------------------------------//
task run_pclk_imeasclk_conf2;
  #2000;
  //`uvm_info("SOC_TEST", "\nTo set diffrent iclk divider value's", UVM_LOW);
  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b10", UVM_LOW); 			
  `uvm_info("SOC_TEST", " To set iclk divider value as 3'b001", UVM_LOW); 
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b001,2'b10,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==15625ns(64KHZ) & zmeas_mclk==3906.25ns(256KHZ) & imeas_dig_adc_clk=15625ns(64KHZ)
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'hC ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #2000; 

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b010", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b010,2'b10,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==15625ns(64KHZ) & zmeas_mclk==3906.25ns(256KHZ) & imeas_dig_adc_clk=31250ns(32KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h14 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #2000;

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b011", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b011,2'b10,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==15625ns(64KHZ) & zmeas_mclk==3906.25ns(256KHZ)& imeas_dig_adc_clk=62500ns(16KHZ) 
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h1C ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #2000;

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b100", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b100,2'b10,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==15625ns(64KHZ) & zmeas_mclk==3906.25ns(256KHZ)& imeas_dig_adc_clk=125000ns(8KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h24 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #200000;

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b101", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b101,2'b10,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==15625ns(64KHZ) & zmeas_mclk==3906.25ns(256KHZ) & imeas_dig_adc_clk=250000ns(4KHZ) 
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h2C ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(10)
  #200000;

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b110", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b110,2'b10,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==15625ns(64KHZ) & zmeas_mclk==3906.25ns(256KHZ)& imeas_dig_adc_clk=500000ns(2KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h34 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(10)
  #200000;

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b111", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b111,2'b10,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==15625ns(64KHZ) & zmeas_mclk==3906.25ns(256KHZ)& imeas_dig_adc_clk=1000000ns(1KHZ)   
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h3C ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(4)
  #800000;

  `uvm_info("SOC_TEST", " To set iclk divider value as 2'b00", UVM_LOW);  
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b000,2'b10,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==15625ns(64KHZ) & zmeas_mclk==3906.25ns(256KHZ) & imeas_dig_adc_clk==7812.5(128KHZ) 
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h4 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(2);
  #200000; 
endtask 
//------------------------------------------------------------------//


//------------------------------------------------------------------//
task run_pclk_imeasclk_conf3;
  #2000;
  //`uvm_info("SOC_TEST", "\nTo set diffrent iclk divider value's", UVM_LOW);
  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b11", UVM_LOW); 			
  `uvm_info("SOC_TEST", " To set iclk divider value as 3'b001", UVM_LOW); 
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b001,2'b11,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==31250ns(32KHZ) & zmeas_mclk== 3906.25ns(256KHZ) & imeas_dig_adc_clk=15625ns(64KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'hE ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #2000;
 
  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b010", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b010,2'b11,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==31250ns(32KHZ) & zmeas_mclk== 3906.25ns(256KHZ) & imeas_dig_adc_clk=31250ns(32KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h16 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #2000;

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b011", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b011,2'b11,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==31250ns(32KHZ) & zmeas_mclk== 3906.25ns(256KHZ) & imeas_dig_adc_clk=62500ns(16KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h1E ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #20000;

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b100", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b100,2'b11,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==31250ns(32KHZ) & zmeas_mclk== 3906.25ns(256KHZ) & imeas_dig_adc_clk=125000ns(8KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h26 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #200000;
  
  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b101", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b101,2'b11,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==31250ns(32KHZ) & zmeas_mclk== 3906.25ns(256KHZ) & imeas_dig_adc_clk=250000ns(4KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h2E ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(4)
  #200000;

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b110", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b110,2'b11,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==31250ns(32KHZ) & zmeas_mclk== 3906.25ns(256KHZ) & imeas_dig_adc_clk=500000ns(2KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h36 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(8)
  #200000;

  `uvm_info("SOC_TEST", "To set iclk divider value as 3'b111", UVM_LOW);
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b111,2'b11,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==31250ns(32KHZ) & zmeas_mclk== 3906.25ns(256KHZ) & imeas_dig_adc_clk=1000000ns(1KHZ)   
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h3E ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(10)
  #400000;

  `uvm_info("SOC_TEST", " To set iclk divider value as 2'b00", UVM_LOW);  
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b000,2'b11,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==31250ns(32KHZ) & zmeas_mclk== 3906.25ns(256KHZ) & imeas_dig_adc_clk=7812.5ns(128KHZ) 
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h6 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(2);
  #200000;
endtask
//------------------------------------------------------------------//

//------------------------------------------------------------------//
task run_pclk_imeasclk_conf4;
  #2000;
  //`uvm_info("SOC_TEST", "\nTo set diffrent iclk divider value's", UVM_LOW);
  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b00", UVM_LOW); 			
  `uvm_info("SOC_TEST", " To set iclk divider value as 3'b010", UVM_LOW); 
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b010,2'b00,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==3906.25ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=31250ns(32KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #2000;

  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b00", UVM_LOW); 			
  `uvm_info("SOC_TEST", " To set iclk divider value as 3'b011", UVM_LOW); 
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b011,2'b00,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==3906.25ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=62500ns(16KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h18 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #2000;

  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b00", UVM_LOW); 			
  `uvm_info("SOC_TEST", " To set iclk divider value as 3'b100", UVM_LOW); 
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b100,2'b00,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==3906.25ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=125000ns(8KHZ) 
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h20 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  #200000;

  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b00", UVM_LOW); 			
  `uvm_info("SOC_TEST", " To set iclk divider value as 3'b101", UVM_LOW); 
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b101,2'b00,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==3906.25ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=250000ns(4KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h28 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(4)
  #200000;

  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b00", UVM_LOW); 			
  `uvm_info("SOC_TEST", " To set iclk divider value as 3'b110", UVM_LOW); 
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b110,2'b00,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==3906.25ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=500000ns(2KHZ)  
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h30 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(10)
  #200000;

  `uvm_info("SOC_TEST", "Set pclk divider value as 2'b00", UVM_LOW); 			
  `uvm_info("SOC_TEST", " To set iclk divider value as 3'b111", UVM_LOW); 
  `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b111,2'b00,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==3906.25ns(256KHZ) & zmeas_mclk=3906.25ns(256KHZ) & imeas_dig_adc_clk=100000ns(1KHZ)
  `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
  if(rd_clkctrl_reg  != 8'h38 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
  repeat(8)
  #400000;
endtask
//------------------------------------------------------------------//




//---------------------------------------------------------------------------------//
task extclk1MZ;
   //1.serase if flash data is not ff,then power off/on ,check whether serase correctly
   //2.write data to clk_div reg
   //In order to load register value to FLASH controller: set FLASG_CONFIG[7:0](bit[1] - wrcmd bit to 1)
   //3.write 02 to flash_config reg  (clk_ctrl reg has to be configured (through FLASH using SPI i.e FLASH_WR command) 
   //write FLASH_CONFIG_REG //the value is 8'h01((bit[0] - unlock bit to 1)):unlock becomes high,and the data in shadow reg is wtitten to flash IP automatically
   //4.write 01 to flash_config reg
   //5.power off/on,check whether the previous loaded data is written into flash

   //considering previously set pclk_div and iclk_div value 
   //`WR_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h05,pads); 
   //skipping below three steps since it's done in previous task so
   //1.wait for FLASH_BUSY to LOW
   //2.clk_ctrl reg has to be configured (through FLASH using SPI WR command)
   //3.In order to load register value to FLASH controller: set FLASG_CONFIG[7:0](bit[1] - wrcmd bit to 1)
   //`WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b000,3'b101},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==15625ns(64KHZ) & zmeas_mclk/imeas_dig_adc_clk=7812.5ns(128KHZ)
   //`WR_RD_CHK_NORMAL_REG(`FLASH_CONFIG,{6'b0, 1'b1, 1'b0},pads,mask);
   //NOTE:  
   //attention:before write data into flash,please erase nvr1 first,or modify the inf0.hex in top tb,make the data is ff   
   //erase can be done by modifying inf0_mem.hex file to 'hFF or through BIST
   //'hFF : indicates memory been erased
   //$readmemh("../sim/erase_nvr1.hex", `DIG_TOP.flash_ctrl_top_inst.u_32k.inf0_mem);


   `uvm_info("SOC_TEST", "\n set ext_clk_sel=1", UVM_LOW);  
   `uvm_info("SOC_TEST", "\n test will run 1MHZ now on", UVM_LOW);
   force `ANA_TOP.u_ext_hfosc.ext_hfclk_sel = 1'b1;
   `DUT_IF.ext_hfosc_fixed_gnd_en = 1'b0;
   `DUT_IF.hfosc_fixed_gnd_en = 1'b1;
   #2000;   

   //`WR_NORMAL_REG(8'h40,8'h01,8'h00);
   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b0,1'b1,3'b000,2'b00,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==1000ns(1MHZ) & zmeas_mclk=1000ns(1MHZ) & imeas_dig_adc_clk=2000ns(0.5MHZ)
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   if(rd_clkctrl_reg  != 8'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   #2000;

   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b0,1'b1,3'b010,2'b10,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==4000ns(0.25MHZ) & zmeas_mclk=1000ns(1MHZ) & imeas_dig_adc_clk=8000ns(0.125MHZ)
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   if(rd_clkctrl_reg  != 8'h54 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   #2000;

   
   //`WR_NORMAL_REG(8'h40,8'h01,8'h00);
   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b0,1'b1,3'b000,2'b00,1'b0},pads,mask);//pclk/zmeas_pclk/imeas_pclk ==1000ns(1MHZ) & zmeas_mclk=1000ns(1MHZ) & imeas_dig_adc_clk=2000ns(0.5MHZ)
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   if(rd_clkctrl_reg  != 8'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   #2000;


   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b0,1'b1,3'b011,2'b11,1'b0},pads,mask);//pclk/zmeas_pclk/imeas_pclk ==8000ns(0.125MHZ) & zmeas_mclk=1000ns(1MHZ) & imeas_dig_adc_clk=16000ns(0.0625MHZ)
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   //if(rd_clkctrl_reg  != 8'h5E ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   #2000;

   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b0,1'b1,3'b000,2'b00,1'b0},pads,mask);//pclk/zmeas_pclk/imeas_pclk ==1000ns(1MHZ) & zmeas_mclk=1000ns(1MHZ) & imeas_dig_adc_clk=2000ns(0.5MHZ)
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   //if(rd_clkctrl_reg  != 8'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   #2000;

   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b0,1'b1,3'b100,2'b00,1'b0},pads,mask);//pclk/zmeas_pclk/imeas_pclk ==1000ns(1MHZ) & zmeas_mclk=1000ns(1MHZ) & imeas_dig_adc_clk=32000ns(0.03125MHZ)
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   if(rd_clkctrl_reg  != 8'h60 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   #2000;

   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b0,1'b1,3'b000,2'b00,1'b0},pads,mask);//pclk/zmeas_pclk/imeas_pclk ==1000ns(1MHZ) & zmeas_mclk=1000ns(1MHZ) & imeas_dig_adc_clk=2000ns(0.5MHZ)
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   if(rd_clkctrl_reg  != 8'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   #2000;

   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b0,1'b1,3'b101,2'b00,1'b0},pads,mask);//pclk/zmeas_pclk/imeas_pclk ==1000ns(1MHZ) & zmeas_mclk=1000ns(1MHZ) & imeas_dig_adc_clk=64000ns(15.625KHZ)
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   if(rd_clkctrl_reg  != 8'h68 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   #2000;

   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b0,1'b1,3'b000,2'b00,1'b0},pads,mask);//pclk/zmeas_pclk/imeas_pclk ==1000ns(1MHZ) & zmeas_mclk=1000ns(1MHZ) & imeas_dig_adc_clk=2000ns(0.5MHZ)
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   if(rd_clkctrl_reg  != 8'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   #2000;

   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b0,1'b1,3'b110,2'b00,1'b0},pads,mask);//pclk/zmeas_pclk/imeas_pclk ==1000ns(1MHZ) & zmeas_mclk=1000ns(1MHZ) & imeas_dig_adc_clk=128000ns(7.8125KHZ)
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   if(rd_clkctrl_reg  != 8'h70 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   #2000;

   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b0,1'b1,3'b000,2'b00,1'b0},pads,mask);//pclk/zmeas_pclk/imeas_pclk ==1000ns(1MHZ) & zmeas_mclk=1000ns(1MHZ) & imeas_dig_adc_clk=2000ns(0.5MHZ)
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   if(rd_clkctrl_reg  != 8'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   #2000;

   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{1'b0,1'b1,3'b111,2'b00,1'b0},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==1000ns(1MHZ) & zmeas_mclk=1000ns(1MHZ) & imeas_dig_adc_clk=256000s(3.90625KHZ)
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   if(rd_clkctrl_reg  != 8'h78 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   #2000;

   //read trim values too
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA0,8'h00,rd_flash_trimdata0_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA1,8'h00,rd_flash_trimdata1_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA2,8'h00,rd_flash_trimdata2_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA3,8'h00,rd_flash_trimdata3_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA4,8'h00,rd_flash_trimdata4_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA5,8'h00,rd_flash_trimdata5_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA6,8'h00,rd_flash_trimdata6_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA7,8'h00,rd_flash_trimdata7_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA8,8'h00,rd_flash_trimdata8_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA9,8'h00,rd_flash_trimdata9_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA10,8'h00,rd_flash_trimdata10_reg);   
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA11,8'h00,rd_flash_trimdata11_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA12,8'h00,rd_flash_trimdata12_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA13,8'h00,rd_flash_trimdata13_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA14,8'h00,rd_flash_trimdata14_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA15,8'h00,rd_flash_trimdata15_reg);
   
   if(rd_flash_trimdata0_reg  != `SOC_FLASH_TRIMDATA0_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata1_reg  != `SOC_FLASH_TRIMDATA1_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata2_reg  != `SOC_FLASH_TRIMDATA2_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata3_reg  != `SOC_FLASH_TRIMDATA3_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata4_reg  != `SOC_FLASH_TRIMDATA4_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata5_reg  != `SOC_FLASH_TRIMDATA5_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata6_reg  != `SOC_FLASH_TRIMDATA6_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata7_reg  != `SOC_FLASH_TRIMDATA7_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata8_reg  != `SOC_FLASH_TRIMDATA8_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata9_reg  != `SOC_FLASH_TRIMDATA9_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata10_reg  !=`SOC_FLASH_TRIMDATA10_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata11_reg  !=`SOC_FLASH_TRIMDATA11_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata12_reg  !=`SOC_FLASH_TRIMDATA12_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata13_reg  !=`SOC_FLASH_TRIMDATA13_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata14_reg  !=`SOC_FLASH_TRIMDATA14_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata15_reg  !=`SOC_FLASH_TRIMDATA15_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
endtask
//---------------------------------------------------------------------------------//

task check_wakeup;
   //in order to set PORESETN==>0
   //set anlog signals wake ==>0
   `uvm_info("SOC_TEST", "\n set wakeup=0 ", UVM_LOW);
   `uvm_info("SOC_TEST", "\n wakeup==0 :reset switchable domain ", UVM_LOW);
   //force `ANA_TOP.A2D_Wake_UP_i = 1'b0;
   force `ANA_TOP.PMU_SW.wakeup=0;
   #20000;

   if(`DIG_TOP.A2D_SW_POWER_POR  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.poresetn_hf  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.poresetn  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.iopad_resetn_y  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_por_resetn != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_bist_resetn_atpg != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.FLASH_Reset_Done  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_to_ana_trim1 != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_to_ana_trim2 != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`DIG_TOP.flash_to_ana_bgl_vtrim != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`DIG_TOP.flash_to_ana_bgl_ctrl != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_to_ana_trim3 != 2'h2 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`DIG_TOP.flash_to_ana_trim4 != 2'h02 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_to_ana_trim4 != 6'h20 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`CLK_CTRL_TOP.pmu_fclk_en  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.imeas_en  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.zmeas_en  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.pclk_div  != 2'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.iclk_div  != 3'h2 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.imeas_adc_inv  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end

   //if(`ANA_TOP.D2A_OSC_TRIM[5:0]!= 6'h20 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_BGH_CTRIM[6:0] != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`ANA_TOP.D2A_BGL_CTRIM[6:0] != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_BGH_VTRIM[4:0] != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_BGL_VTRIM[4:0] != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_DAC_BUF_TRIM[1:0] != 2'h02 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_LDO1V5_VTRIM[1:0] != 2'h02 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end

   #2000000;
   `uvm_info("SOC_TEST", "\n set wakeup=1 ", UVM_LOW);
   //release `ANA_TOP.A2D_Wake_UP_i; 
   release `ANA_TOP.PMU_SW.wakeup;      
   `uvm_info("SOC_TEST", "\n wait for switchable reset come back ", UVM_LOW);
   wait(`RESETN);
   wait(`HF_RESETN);
   wait(`DIG_TOP.FLASH_Reset_Done);
   #20000;

   if(`DIG_TOP.A2D_SW_POWER_POR  != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.poresetn_hf  != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.poresetn  != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.iopad_resetn_y  != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_por_resetn != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   if(`DIG_TOP.flash_bist_resetn_atpg != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.FLASH_Reset_Done  != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end   
   if(`DIG_TOP.flash_to_ana_trim1 != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_to_ana_trim2 != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`DIG_TOP.flash_to_ana_bgl_vtrim != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`DIG_TOP.flash_to_ana_bgl_ctrl != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_to_ana_trim3 != 2'h2 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`DIG_TOP.flash_to_ana_dacbuf_trim != 2'h02 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_to_ana_trim4 != 6'h20 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`ANA_TOP.D2A_OSC_TRIM[5:0]!= 6'h20 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_BGH_CTRIM[6:0] != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`ANA_TOP.D2A_BGL_CTRIM[6:0] != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_BGH_VTRIM[4:0] != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_BGL_VTRIM[4:0] != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_DAC_BUF_TRIM[1:0] != 2'h02 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_LDO1V5_VTRIM[1:0] != 2'h02 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end


   //OR
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA0,8'h00,rd_flash_trimdata0_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA1,8'h00,rd_flash_trimdata1_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA2,8'h00,rd_flash_trimdata2_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA3,8'h00,rd_flash_trimdata3_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA4,8'h00,rd_flash_trimdata4_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA5,8'h00,rd_flash_trimdata5_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA6,8'h00,rd_flash_trimdata6_reg);      
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA7,8'h00,rd_flash_trimdata7_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA8,8'h00,rd_flash_trimdata8_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA9,8'h00,rd_flash_trimdata9_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA10,8'h00,rd_flash_trimdata10_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA11,8'h00,rd_flash_trimdata11_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA12,8'h00,rd_flash_trimdata12_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA13,8'h00,rd_flash_trimdata13_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA14,8'h00,rd_flash_trimdata14_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA15,8'h00,rd_flash_trimdata15_reg);
   if(rd_flash_trimdata0_reg  != `SOC_FLASH_TRIMDATA0_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata1_reg  != `SOC_FLASH_TRIMDATA1_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata2_reg  != `SOC_FLASH_TRIMDATA2_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata3_reg  != `SOC_FLASH_TRIMDATA3_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata4_reg  != `SOC_FLASH_TRIMDATA4_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata5_reg  != `SOC_FLASH_TRIMDATA5_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata6_reg  != `SOC_FLASH_TRIMDATA6_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata7_reg  != `SOC_FLASH_TRIMDATA7_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata8_reg  != `SOC_FLASH_TRIMDATA8_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata9_reg  != `SOC_FLASH_TRIMDATA9_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata10_reg  !=`SOC_FLASH_TRIMDATA10_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata11_reg  !=`SOC_FLASH_TRIMDATA11_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata12_reg  !=`SOC_FLASH_TRIMDATA12_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata13_reg  !=`SOC_FLASH_TRIMDATA13_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata14_reg  !=`SOC_FLASH_TRIMDATA14_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata15_reg  !=`SOC_FLASH_TRIMDATA15_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end

   if(`CLK_CTRL_TOP.pmu_fclk_en  != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.imeas_en  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.zmeas_en  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.pclk_div  != 2'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.iclk_div  != 3'h2 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.imeas_adc_inv  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end

   `uvm_info("SOC_TEST", "To set zmeas_en", UVM_LOW);
   `WR_NORMAL_REG(`SOC_ZMEAS_EN,8'b01,pads);	//`WR_NORMAL_REG(addr, wr_data, pads); :: //pclk, zmeas_pclk and zmea_mclk=7812.5ns(128KHZ)
   `uvm_info("SOC_TEST", "To set imeas_en", UVM_LOW);   
   `WR_NORMAL_REG(`SOC_IMEAS_EN,8'b01,pads);
   `uvm_info("SOC_TEST", "\nTo READ REG's", UVM_LOW); 
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   `RD_NORMAL_REG(`SOC_ZMEAS_EN,8'h00,rd_zmeas_en_reg);
   `RD_NORMAL_REG(`SOC_IMEAS_EN,8'h00,rd_imeas_en_reg);	     
      
   //`uvm_info("SOC_TEST", "READ SOC_CLK_CTRL_REG == 8'b%b", rd_clkctrl_reg, UVM_LOW);
   //`uvm_info("SOC_TEST", "READ SOC_ZMEAS_EN_REG == 8'b%b", rd_zmeas_en_reg, UVM_LOW);
   //`uvm_info("SOC_TEST", "READ SOC_IMEAS_EN_REG == 8'b%b", rd_imeas_en_reg, UVM_LOW);   
   if(rd_clkctrl_reg  != 8'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_zmeas_en_reg != 8'b1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_imeas_en_reg != 8'd1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   #2000;
endtask
//---------------------------------------------------------------------------------//

task check_iopad_resetn;
   #2000000;
   //in order to set PORESETN==>0
   //set anlog signals wake ==>0
   `uvm_info("SOC_TEST", "\n set iopad_resetn=0 ", UVM_LOW);
   `uvm_info("SOC_TEST", "\n iopad_resetn==0 :reset switchable domain ", UVM_LOW);
   if(`SOC_TB.iopad_resetn != 1'b1)  begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   
   force `SOC_TB.iopad_resetn = 1'b0;

   #200000;

   if(`DIG_TOP.A2D_SW_POWER_POR  != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.poresetn_hf  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.poresetn  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.iopad_resetn_y  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   /*if(`DIG_TOP.flash_por_resetn != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end*/
   if(`DIG_TOP.flash_bist_resetn_atpg != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.FLASH_Reset_Done  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_to_ana_trim1 != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_to_ana_trim2 != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`DIG_TOP.flash_to_ana_bgl_vtrim != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`DIG_TOP.flash_to_ana_bgl_ctrl != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_to_ana_trim3 != 2'h2 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`DIG_TOP.flash_to_ana_dacbuf_trim != 2'h02 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_to_ana_trim4 != 6'h20 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`CLK_CTRL_TOP.pmu_fclk_en  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.imeas_en  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.zmeas_en  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.pclk_div  != 2'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.iclk_div  != 3'h2 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.imeas_adc_inv  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end

   //if(`ANA_TOP.D2A_OSC_TRIM[5:0]!= 6'h20 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_BGH_CTRIM[6:0] != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`ANA_TOP.D2A_BGL_CTRIM[6:0] != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_BGH_VTRIM[4:0] != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_BGL_VTRIM[4:0] != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_DAC_BUF_TRIM[1:0] != 2'h02 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_LDO1V5_VTRIM[1:0] != 2'h02 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end

   #2000000;
   `uvm_info("SOC_TEST", "\n iopad_resetn=1 ", UVM_LOW);
   force `SOC_TB.iopad_resetn = 1'b1; 
         
   `uvm_info("SOC_TEST", "\n wait for switchable reset come back ", UVM_LOW);
   wait(`RESETN);
   wait(`HF_RESETN);
   wait(`DIG_TOP.FLASH_Reset_Done);
   #20000;

   if(`DIG_TOP.A2D_SW_POWER_POR  != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.poresetn_hf  != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.poresetn  != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.iopad_resetn_y  != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_por_resetn != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
  if(`DIG_TOP.flash_bist_resetn_atpg != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.FLASH_Reset_Done  != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end   
   if(`DIG_TOP.flash_to_ana_trim1 != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_to_ana_trim2 != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`DIG_TOP.flash_to_ana_bgl_vtrim != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`DIG_TOP.flash_to_ana_bgl_ctrl != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_to_ana_trim3 != 2'h2 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`DIG_TOP.flash_to_ana_dacbuf_trim != 2'h02 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`DIG_TOP.flash_to_ana_trim4 != 6'h20 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`ANA_TOP.D2A_OSC_TRIM[5:0]!= 6'h20 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_BGH_CTRIM[6:0] != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   //if(`ANA_TOP.D2A_BGL_CTRIM[6:0] != 7'h40 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_BGH_VTRIM[4:0] != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_BGL_VTRIM[4:0] != 5'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_DAC_BUF_TRIM[1:0] != 2'h02 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end 
   //if(`ANA_TOP.D2A_LDO1V5_VTRIM[1:0] != 2'h02 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end


   //OR
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA0,8'h00,rd_flash_trimdata0_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA1,8'h00,rd_flash_trimdata1_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA2,8'h00,rd_flash_trimdata2_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA3,8'h00,rd_flash_trimdata3_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA4,8'h00,rd_flash_trimdata4_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA5,8'h00,rd_flash_trimdata5_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA6,8'h00,rd_flash_trimdata6_reg);      
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA7,8'h00,rd_flash_trimdata7_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA8,8'h00,rd_flash_trimdata8_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA9,8'h00,rd_flash_trimdata9_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA10,8'h00,rd_flash_trimdata10_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA11,8'h00,rd_flash_trimdata11_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA12,8'h00,rd_flash_trimdata12_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA13,8'h00,rd_flash_trimdata13_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA14,8'h00,rd_flash_trimdata14_reg);
   `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA15,8'h00,rd_flash_trimdata15_reg);
   if(rd_flash_trimdata0_reg  != `SOC_FLASH_TRIMDATA0_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata1_reg  != `SOC_FLASH_TRIMDATA1_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata2_reg  != `SOC_FLASH_TRIMDATA2_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata3_reg  != `SOC_FLASH_TRIMDATA3_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata4_reg  != `SOC_FLASH_TRIMDATA4_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata5_reg  != `SOC_FLASH_TRIMDATA5_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata6_reg  != `SOC_FLASH_TRIMDATA6_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata7_reg  != `SOC_FLASH_TRIMDATA7_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata8_reg  != `SOC_FLASH_TRIMDATA8_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata9_reg  != `SOC_FLASH_TRIMDATA9_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata10_reg  !=`SOC_FLASH_TRIMDATA10_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata11_reg  !=`SOC_FLASH_TRIMDATA11_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata12_reg  !=`SOC_FLASH_TRIMDATA12_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata13_reg  !=`SOC_FLASH_TRIMDATA13_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata14_reg  !=`SOC_FLASH_TRIMDATA14_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_flash_trimdata15_reg  !=`SOC_FLASH_TRIMDATA15_INIT ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end

   if(`CLK_CTRL_TOP.pmu_fclk_en  != 1'h1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.imeas_en  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.zmeas_en  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.pclk_div  != 2'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.iclk_div  != 3'h2 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(`CLK_CTRL_TOP.imeas_adc_inv  != 1'h0 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end

   `uvm_info("SOC_TEST", "To set zmeas_en", UVM_LOW);
   `WR_NORMAL_REG(`SOC_ZMEAS_EN,8'b01,pads);	//`WR_NORMAL_REG(addr, wr_data, pads); :: //pclk, zmeas_pclk and zmea_mclk=7812.5ns(128KHZ)
   `uvm_info("SOC_TEST", "To set imeas_en", UVM_LOW);   
   `WR_NORMAL_REG(`SOC_IMEAS_EN,8'b01,pads);
   `uvm_info("SOC_TEST", "\nTo READ REG's", UVM_LOW); 
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg);
   `RD_NORMAL_REG(`SOC_ZMEAS_EN,8'h00,rd_zmeas_en_reg);
   `RD_NORMAL_REG(`SOC_IMEAS_EN,8'h00,rd_imeas_en_reg);	     
      
   //`uvm_info("SOC_TEST", "READ SOC_CLK_CTRL_REG == 8'b%b", rd_clkctrl_reg, UVM_LOW);
   //`uvm_info("SOC_TEST", "READ SOC_ZMEAS_EN_REG == 8'b%b", rd_zmeas_en_reg, UVM_LOW);
   //`uvm_info("SOC_TEST", "READ SOC_IMEAS_EN_REG == 8'b%b", rd_imeas_en_reg, UVM_LOW);   
   if(rd_clkctrl_reg  != 8'h10 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_zmeas_en_reg != 8'b1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   if(rd_imeas_en_reg != 8'd1 ) begin  `uvm_error("SOC_TEST", "\terror!!!!"); end
   #200000;
endtask
//---------------------------------------------------------------------------------//


//include flash bist master model tasks
//`include "../../../verification/models/flash_bist_master/basic_task.inc"

//------------------------------------------------------------------//
//------------------------------------------------------------------//
//------------------------------------------------------------------//
//------------------------------------------------------------------//

//task stop_transc;
//   //finish transaction (master pull up the chip select)
//   `uvm_info("SOC_TEST", "stop spi transcation", UVM_LOW);
//
//   cs_n_r = 1;						        //active high chip select (to finish the  trsnaction)
//   mosi_r = 1'bz;						//when no transction mosi_r is high impedence
//
//endtask
//
//
//task start_transc;
//   `uvm_info("SOC_TEST", "start spi transcation", UVM_LOW);
//   @(posedge sclk_r);
//   cs_n_r = 0;            					//  active low chip select (to start trsnaction)	 	
//
//endtask


//set zmeas_en to generate MCLK=4MHZ for ZMEAS
//Zmeas_enable[0] = 1 
task zmeas_en;
input [7:0] zmeas_enable;
	//master_write(8'h80,`SOC_ZMEAS_EN,zmeas_enable,8'h00);			//enable zmeas_en  (macros are define in spi_reg design) 
	`WR_NORMAL_REG(`SOC_ZMEAS_EN,zmeas_enable,8'h00);  	 
endtask

//set imeas_en to generate imeas_adc_clk(it's generating based on LFCLK=1KHZ)
//imeas_enable[0] = 1 
task imeas_en;
input [7:0] imeas_enable;
	//master_write(8'h80,`SOC_IMEAS_EN,imeas_enable,8'h00);			//enable Imeas_en  (macros are define in spi_reg design)
	`WR_NORMAL_REG(`SOC_IMEAS_EN,imeas_enable,8'h00);			
endtask


//set fclk_dyen to generate fclk 
//if we don't set "fclk_dyen" by default fclk will be generated when pmu is in idle state
//set pclk divider value
//set iclk divider value : to get imeas adc clk
//data[0]   == fclk_dyen (0/1)
//data[2:1] == pclk_div (00/01/10/11)
//data[5:3] == iclk_div (000/001/010/011/100/101/110/111)
 task config_clkctrl_reg;
input [7:0] data;
	//master_write(8'h80,`SOC_CLK_CTRL_REG,data,8'h00);	 	//enable fclk_dyen (macros are define in spi_reg design)
	`WR_NORMAL_REG(`SOC_CLK_CTRL_REG,data,8'h00);
endtask



endclass : `TESTNAME
