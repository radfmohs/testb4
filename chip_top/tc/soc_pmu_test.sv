/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_pmu_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_pmu_test                                             
// Designer	: pfwang@nanochap.com                                                                 
// Date		: 11-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_pmu_test
`define TESTCFG soc_pmu_test_cfg

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

  function new (string name = "soc_pmu_test_cfg");
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
  reg [7:0]	rd_alwayson_clkctrl_reg;
  reg [7:0]	rd_clkctrl_reg;
  reg [7:0]	rd_pmu_reg0;
  //reg [7:0]	rd_zmeas_en_reg;
  //reg [7:0]	rd_imeas_en_reg;
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
  logic [7:0]     rd_flash_trimdata16_reg;
  logic [7:0]     rd_flash_trimdata17_reg;
  logic [7:0]     rd_flash_trimdata18_reg;
  logic [7:0]     rd_flash_trimdata19_reg;
  logic [7:0]     rd_flash_trimdata20_reg;

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

    `nnc_info("SOC_TEST", "soc_pmu_test start", UVM_LOW)

    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    
    // --------------------------------------------------------
    // This is an example RD_RESET_CHK_REG 
    // --------------------------------------------------------
    pads = 8'h00;
    mask = 8'hff;
    #1us;
    wait(`RESETN);

    do_run;


    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    #10000ns;
    `nnc_info("SOC_TEST", "soc_pmu_test end now", UVM_LOW)

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
  
   `uvm_info("SOC_TEST", "\n*********From always_on_sys_ctrl_test*********", UVM_LOW);

   
   //if(`ALWAYSON_CLK_CTRL.dc_dc_en  !=1'b1) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   //if(`ALWAYSON_CLK_CTRL.fclk_dynen !=1'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   //if(`ALWAYSON_CLK_CTRL.dc_clk_div[1:0] !=2'h3) begin  `uvm_error("SOC_TEST", "Error at here: "); end

   /*if(`PMU_CTRL_TOP.pmuenable !=1'b1)  begin  `uvm_error("SOC_TEST", "Error at here: "); end
   if(`PMU_CTRL_TOP.hresetreq !=1'b0)  begin  `uvm_error("SOC_TEST", "Error at here: "); end
   if(`PMU_CTRL_TOP.sleepdeep !=1'b0)  begin  `uvm_error("SOC_TEST", "Error at here: "); end
   if(`PMU_CTRL_TOP.flash_dpstb_en !=1'b0)  begin  `uvm_error("SOC_TEST", "Error at here: "); end


   if(`CLK_CTRL_TOP.zmeas_en != 1'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   if(`CLK_CTRL_TOP.imeas_en != 1'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   //if(`CLK_CTRL_TOP.pmu_fclk_en != 1'b1) begin  `uvm_error("SOC_TEST", "Error at here: "); end   //pmu state is IDLE
   if(`CLK_CTRL_TOP.fclk_dynen != 1'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   if(`CLK_CTRL_TOP.pclk_div != 2'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   if(`CLK_CTRL_TOP.iclk_div != 3'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end*/

    //by default flck will be generating even before reset 
    //(if pmu state is in IDLE then after reset pmu_fclk_en goes HIGH automatically)
     
   `uvm_info("SOC_TEST", "Wait for PMU PORESETN_HF", UVM_LOW);   
   wait(`PMU_CTRL_TOP.poresetn_hf); 
   wait(`RESETN); 
   //-------------to read from the ALWAYS_ON CLK_CTRL reg-------------------//
   /*`uvm_info("SOC_TEST", "\nTo READ REG's", UVM_LOW);
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_clkctrl_reg); 		  //bit[0] fclk_dynen
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_alwayson_clkctrl_reg);  //bit[0] dc_dc_en
   `RD_NORMAL_REG(`SOC_PMU_REG0,8'h00,rd_pmu_reg0);
   if(rd_pmu_reg0 != 8'd1 ) begin  `uvm_error("SOC_TEST", "Error at here: "); end        
   //`uvm_info("SOC_TEST", "READ ALWAYS ON SOC_CLK_CTRL_REG == 8'b%b", rd_clkctrl_reg, UVM_LOW);  
   if(rd_alwayson_clkctrl_reg  != 8'd0 ) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   if(rd_clkctrl_reg != 8'd0 ) begin  `uvm_error("SOC_TEST", "Error at here: "); end*/

   //if(`ALWAYSON_CLK_CTRL.dc_dc_en  != 1'b1) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   //if(`ALWAYSON_CLK_CTRL.fclk_dynen != 1'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   //if(`ALWAYSON_CLK_CTRL.dc_clk_div[1:0] != 2'h3) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   /*if(`CLK_CTRL_TOP.zmeas_en != 1'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   if(`CLK_CTRL_TOP.imeas_en != 1'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   if(`CLK_CTRL_TOP.pmu_fclk_en != 1'b1) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   if(`CLK_CTRL_TOP.fclk_dynen != 1'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   if(`CLK_CTRL_TOP.pclk_div != 2'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   if(`CLK_CTRL_TOP.iclk_div != 3'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end*/
   //------------------------------------------------------------------//

   //------------------------------------------------------------------//
   //to generate zmeas_pclk, zmeas_mclk
   `uvm_info("SOC_TEST", "\nEnable zmeas_en", UVM_LOW);
   `WR_RD_CHK_NORMAL_REG(`SOC_ZMEAS_EN,{2'b0,3'b000,3'b001},pads,mask);
   //to generate imeas_pclk, imeas_adc_clk,imeas_dig_adc_clk
   `uvm_info("SOC_TEST", "\nEnable Imeas_en", UVM_LOW);
   `WR_RD_CHK_NORMAL_REG(`SOC_IMEAS_EN,{2'b0,3'b000,3'b001},pads,mask);
   //set fclk_dyen=1 so fclk will be generating based on pmu_fclk_en and pclk_div=2'b01, 
   `uvm_info("SOC_TEST", "\nset clk_ctrl_reg", UVM_LOW);
   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b000,2'b01,1'b1},pads,mask);  //clk_ctrl_reg[7:0] = {2'd0, iclk_div,pclk_div,fclk_dynen}
 
   #20000;
   //disable pmu_enable(by default pmu_enable =1) and try to enter deepsleep
   `WR_RD_CHK_NORMAL_REG(`SOC_PMU_REG0,{4'b0,1'b0,1'b0,1'b1,1'b0},pads,mask); //{1'b0, 1'b0, 1'b0, 1'b0, flash_standby, hreset_req, sleepdeep, pmuenable}
   wait (~`PMU_CTRL_TOP.pmuenable);
   `RD_NORMAL_REG(`SOC_PMU_REG0,8'h00,rd_pmu_reg0);
   if(rd_pmu_reg0 != 8'd2 ) begin  `uvm_error("SOC_TEST", "Error 0 at here: "); end
   //if(`PMU_CTRL_TOP.pmu_dpslp !=0) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   #20000;

   `uvm_info("SOC_TEST", "\nTo Enable DC_DC_EN", UVM_LOW);
   `uvm_info("SOC_TEST", "\nTo set dc_clk_div value as 2'b01", UVM_LOW);  	
   //`WR_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h03,pads);
   `WR_RD_CHK_NORMAL_REG(`SOC_CLK_CTRL_REG,{2'b0,3'b000,3'b011},pads,mask); //pclk/zmeas_pclk/imeas_pclk ==7812.5ns(128KHZ) & zmeas_mclk/imeas_dig_adc_clk=7812.5ns(128KHZ)   
   `RD_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h00,rd_alwayson_clkctrl_reg);              
   //`uvm_info("SOC_TEST", "READ ALWAYS ON SOC_CLK_CTRL_REG == 8'b%b", rd_clkctrl_reg, UVM_LOW);  
   /*if(rd_alwayson_clkctrl_reg  != 8'd3 ) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   if(`ALWAYSON_CLK_CTRL.dc_dc_en  !=1'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   if(`ALWAYSON_CLK_CTRL.fclk_dynen !=1'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   if(`ALWAYSON_CLK_CTRL.dc_clk_div[1:0] !=2'h0) begin  `uvm_error("SOC_TEST", "Error at here: "); end*/   //check on latest rtl
    
 
   //
   `uvm_info("SOC_TEST", "\nset deesleep bit and pmu enable bit of pmu_reg0", UVM_LOW);
   `WR_RD_CHK_NORMAL_REG(`SOC_PMU_REG0,{4'b0,1'b0,1'b0,1'b1,1'b1},pads,mask);
   `RD_NORMAL_REG(`SOC_PMU_REG0,8'h00,rd_pmu_reg0);
   if(rd_pmu_reg0 != 8'd3 ) begin  `uvm_error("SOC_TEST", "Error 1 at here: "); end 
   if(`PMU_CTRL_TOP.pmuenable !=1'b1)  begin  `uvm_error("SOC_TEST", "Error 2 at here: "); end
   if(`PMU_CTRL_TOP.hresetreq !=1'b0)  begin  `uvm_error("SOC_TEST", "Error 3 at here: "); end
   if(`PMU_CTRL_TOP.sleepdeep !=1'b1)  begin  `uvm_error("SOC_TEST", "Error 4 at here: "); end
   if(`PMU_CTRL_TOP.flash_dpstb_en !=1'b0)  begin  `uvm_error("SOC_TEST", "Error 5 at here: "); end
   
  //check output
   if(`PMU_CTRL_TOP.pmu_fclk_en !=1'b0)  begin  `uvm_error("SOC_TEST", "Error 6 at here: "); end
   //if(`PMU_CTRL_TOP.pmu_dpslp !=1'b1) begin  `uvm_error("SOC_TEST", "Error at here: "); end 
   #20000;

   //
   `uvm_info("SOC_TEST", "\nset system reset request bit of pmu_reg0", UVM_LOW);
   `WR_NORMAL_REG(`SOC_PMU_REG0,{4'b0,1'b0,1'b1,1'b1,1'b1},pads);
   //wait(~`PMU_CTRL_TOP.pmu_dpslp);
   //if(`PMU_CTRL_TOP.pmu_dpslp !=1'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   wait(`PMU_CTRL_TOP.pmu_fclk_en);	
   if(`PMU_CTRL_TOP.pmu_fclk_en !=1'b1)  begin  `uvm_error("SOC_TEST", "Error 7 at here: "); end
	                                                                                               
   if(`CLK_CTRL_TOP.zmeas_en  != 1'b1) begin  `uvm_error("SOC_TEST", "Error 8 at here: "); end  
   if(`CLK_CTRL_TOP.imeas_en  != 1'b1) begin  `uvm_error("SOC_TEST", "Error 9 at here: "); end  
   `RD_NORMAL_REG(`SOC_PMU_REG0,8'h00,rd_pmu_reg0);                                                 
   if(rd_pmu_reg0 != 8'd7 ) begin  `uvm_error("SOC_TEST", "Error 10 at here: "); end            
   #200000;                                                                                        
   
    
    //Pmu state goes to deepsleep mode again
   `uvm_info("SOC_TEST", "\nKeep deepsleep bit remain HIGH & Set reset request bit LOW of pmu_reg0", UVM_LOW);
   `uvm_info("SOC_TEST", "\nset flash deepsleep standby bit of pmu_reg0", UVM_LOW);
   `WR_NORMAL_REG(`SOC_PMU_REG0,{4'b0,1'b1,1'b0,1'b1,1'b1},pads);
   //wait(`PMU_CTRL_TOP.pmu_dpslp);	
   //if(`PMU_CTRL_TOP.pmu_dpslp !=1'b1) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   #10000;
   if(`PMU_CTRL_TOP.flash_dpstb !=1'b1) begin  `uvm_error("SOC_TEST", "Error 11 at here:  at time = "); end
   wait(~`PMU_CTRL_TOP.pmu_fclk_en);	
   if(`PMU_CTRL_TOP.pmu_fclk_en !=1'b0)  begin  `uvm_error("SOC_TEST", "Error 12 at here: "); end

   if(`CLK_CTRL_TOP.zmeas_en  != 1'b1) begin  `uvm_error("SOC_TEST", "Error 13 at here: "); end
   if(`CLK_CTRL_TOP.imeas_en  != 1'b1) begin  `uvm_error("SOC_TEST", "Error 14 at here: "); end 
   `RD_NORMAL_REG(`SOC_PMU_REG0,8'h00,rd_pmu_reg0);
   if(rd_pmu_reg0 != 8'hB ) begin  `uvm_error("SOC_TEST", "Error 15 at here: "); end  

   if(`FLASH_TOP.trim_read[0]  != `SOC_FLASH_TRIMDATA0_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "Error 16 at here: "); end
   if(`FLASH_TOP.trim_read[1]  != `SOC_FLASH_TRIMDATA1_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "Error 17 at here: "); end
   if(`FLASH_TOP.trim_read[2]  != `SOC_FLASH_TRIMDATA2_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "Error 18 at here: "); end
   if(`FLASH_TOP.trim_read[3]  != `SOC_FLASH_TRIMDATA3_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "Error 19 at here: "); end
   if(`FLASH_TOP.trim_read[4]  != `SOC_FLASH_TRIMDATA4_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "Error 20 at here: "); end
   if(`FLASH_TOP.trim_read[5]  != `SOC_FLASH_TRIMDATA5_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "Error 21 at here: "); end
   if(`FLASH_TOP.trim_read[6]  != `SOC_FLASH_TRIMDATA6_INIT ) begin  `uvm_error("SOC_TEST", "Error 22 at here: "); end	 
   if(`FLASH_TOP.trim_read[7]  != `SOC_FLASH_TRIMDATA7_INIT ) begin  `uvm_error("SOC_TEST", "Error 27 at here: "); end
   if(`FLASH_TOP.trim_read[8]  != `SOC_FLASH_TRIMDATA8_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "Error 28 at here: "); end
   if(`FLASH_TOP.trim_read[9]  != `SOC_FLASH_TRIMDATA9_RELOAD_INIT ) begin  `uvm_error("SOC_TEST", "Error 29 at here: "); end
   if(`FLASH_TOP.trim_read[10] != `SOC_FLASH_TRIMDATA10_RELOAD_INIT) begin  `uvm_error("SOC_TEST", "Error 30 at here: "); end
   if(`FLASH_TOP.trim_read[11] != `SOC_FLASH_TRIMDATA11_RELOAD_INIT) begin  `uvm_error("SOC_TEST", "Error 31 at here: "); end
   if(`FLASH_TOP.trim_read[12] != `SOC_FLASH_TRIMDATA12_RELOAD_INIT) begin  `uvm_error("SOC_TEST", "Error 32 at here: "); end
   if(`FLASH_TOP.trim_read[13] != `SOC_FLASH_TRIMDATA13_RELOAD_INIT) begin  `uvm_error("SOC_TEST", "Error 33 at here: "); end
   if(`FLASH_TOP.trim_read[14] != `SOC_FLASH_TRIMDATA14_RELOAD_INIT) begin  `uvm_error("SOC_TEST", "Error 34 at here: "); end
   if(`FLASH_TOP.trim_read[15] != `SOC_FLASH_TRIMDATA15_INIT) begin  `uvm_error("SOC_TEST", "Error 35 at here: "); end                            
   if(`FLASH_TOP.trim_read[16] != `SOC_FLASH_TRIMDATA16_INIT) begin  `uvm_error("SOC_TEST", "Error 31 at here: "); end
   if(`FLASH_TOP.trim_read[17] != `SOC_FLASH_TRIMDATA17_INIT) begin  `uvm_error("SOC_TEST", "Error 32 at here: "); end
   if(`FLASH_TOP.trim_read[18] != `SOC_FLASH_TRIMDATA18_INIT) begin  `uvm_error("SOC_TEST", "Error 33 at here: "); end
   if(`FLASH_TOP.trim_read[19] != `SOC_FLASH_TRIMDATA19_INIT) begin  `uvm_error("SOC_TEST", "Error 34 at here: "); end
   if(`FLASH_TOP.trim_read[20] != `SOC_FLASH_TRIMDATA20_INIT) begin  `uvm_error("SOC_TEST", "Error 35 at here: "); end
   #200000; 

  //to come out of sleep deep set reset request 
   `uvm_info("SOC_TEST", "\nset system reset request bit HIGH and set sleepdeep=0 of pmu_reg0", UVM_LOW);
   `uvm_info("SOC_TEST", "\ncheck flash deepsleep standby bit goes LOW", UVM_LOW);
   `WR_NORMAL_REG(`SOC_PMU_REG0,{4'b0,1'b1,1'b1,1'b0,1'b1},pads);
   //wait(~`PMU_CTRL_TOP.pmu_dpslp);	
   //if(`PMU_CTRL_TOP.pmu_dpslp !=1'b0) begin  `uvm_error("SOC_TEST", "Error at here: "); end
   #10000;
   if(`PMU_CTRL_TOP.flash_dpstb !=1'b0) begin  `uvm_error("SOC_TEST", "Error 23 at here:  at time = "); end
   wait(`PMU_CTRL_TOP.pmu_fclk_en);	
   if(`PMU_CTRL_TOP.pmu_fclk_en !=1'b1)  begin  `uvm_error("SOC_TEST", "Error 24 at here: "); end
	
   if(`CLK_CTRL_TOP.zmeas_en  != 1'b1) begin  `uvm_error("SOC_TEST", "Error 25 at here: "); end
   if(`CLK_CTRL_TOP.imeas_en  != 1'b1) begin  `uvm_error("SOC_TEST", "Error 26 at here: "); end  
   `RD_NORMAL_REG(`SOC_PMU_REG0,8'h00,rd_pmu_reg0);
   //if(rd_pmu_reg0 != 8'hD ) begin  `uvm_error("SOC_TEST", "Error at here: "); end     
   #200000;


   //to come out of sleep deep set reset request 
   `uvm_info("SOC_TEST", "\nset reset request bit, PMU Enable to LOW ", UVM_LOW);
   `uvm_info("SOC_TEST", "\nKeep flash deepsleep standby bit HIGH", UVM_LOW);
   `WR_NORMAL_REG(`SOC_PMU_REG0,{4'b0,1'b1,1'b0,1'b0,1'b0},pads);  
end
endtask


endclass : `TESTNAME
