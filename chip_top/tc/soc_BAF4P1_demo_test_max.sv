/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_BAF4P1_demo_test_max.sv                                                   
// Project	: Nanochap ENS1p4                                  		        
// Description	: Testcase soc_BAF4P1_demo_test_max                                             
// Designer	: pfwang@nanochap.com                                                                 
// Date		: 11-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_BAF4P1_demo_test_max
`define TESTCFG soc_BAF4P1_demo_test_max_cfg

`ifndef BEHAVIORAL
`define GPIO18 u_iopad_gpio_18_
`define GPIO17 u_iopad_gpio_17_
`define GPIO16 u_iopad_gpio_16_
`define GPIO15 u_iopad_gpio_15_
`define GPIO14 u_iopad_gpio_14_
`define GPIO13 u_iopad_gpio_13_
`define GPIO12 u_iopad_gpio_12_
`define GPIO11 u_iopad_gpio_11_
`define GPIO10 u_iopad_gpio_10_
`define GPIO9  u_iopad_gpio_9_
`define GPIO8  u_iopad_gpio_8_
`define GPIO7  u_iopad_gpio_7_
`define GPIO6  u_iopad_gpio_6_
`define GPIO5  u_iopad_gpio_5_
`define GPIO4  u_iopad_gpio_4_
`define GPIO3  u_iopad_gpio_3_
`define GPIO2  u_iopad_gpio_2_
`define GPIO1  u_iopad_gpio_1_
`define GPIO0  u_iopad_gpio_0_
`else
`define GPIO18 u_iopad_gpio[18]
`define GPIO17 u_iopad_gpio[17]
`define GPIO16 u_iopad_gpio[16]
`define GPIO15 u_iopad_gpio[15]
`define GPIO14 u_iopad_gpio[14]
`define GPIO13 u_iopad_gpio[13]
`define GPIO12 u_iopad_gpio[12]
`define GPIO11 u_iopad_gpio[11]
`define GPIO10 u_iopad_gpio[10]
`define GPIO9  u_iopad_gpio[9]
`define GPIO8  u_iopad_gpio[8]
`define GPIO7  u_iopad_gpio[7]
`define GPIO6  u_iopad_gpio[6]
`define GPIO5  u_iopad_gpio[5]
`define GPIO4  u_iopad_gpio[4]
`define GPIO3  u_iopad_gpio[3]
`define GPIO2  u_iopad_gpio[2]
`define GPIO1  u_iopad_gpio[1]
`define GPIO0  u_iopad_gpio[0]
`endif

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
  rand logic [7:0] exp_trim[20];
  rand logic [7:0] exp_ao_ana[6];
  logic [7:0]      rd_data[];

  // -----------------------------------------------
  // End of decalration of new variables 
  // ===============================================

  function new (string name = "soc_BAF4P1_demo_test_max_cfg");
    super.new(name);
    
  endfunction: new

  // ===============================================
  // Adding constraints of randomization
  // -----------------------------------------------

  // testmode_sel[1:0] : 00-Normal mode, 01: Scanmode, 10: BIST mode, 11 atm0/1/2/3/4
  constraint c_testmode_sel   { soft testmode_sel == 2'b00; }

  // spimode_sel[1:0] :  
  constraint c_spimode_sel    { spimode_sel == 2'b00; }

  // No of bytes in a burst
  constraint c_no_of_bytes    { soft no_of_bytes == 2; }

  // pads values
  constraint c_pads           { soft pads == 8'h00; }

  // mask values
  constraint c_mask           { soft mask == 8'hff; }

  // pclk_sel
  constraint c_pclk_sel       { soft pclk_sel == 0; }//256Khz pclk

  // spi_sclk_freq
  constraint c_spi_sclk_freq  { soft spi_sclk_freq == 1024; }//1Mhz SPI max clk

  // iclk_sel
  constraint c_iclk_sel       { soft iclk_sel == 7; }//1Khz imeas adc clk

  // mclk_sel
  constraint c_mclk_sel       { soft mclk_sel == 255; }//1Khz zmeas adc clk

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
  //---------------------------- FLASH -------------------------------------------
  logic [7:0] flash_debug_status;
  //reg [4:0] err_cnt; (used err_cnt as global variable from TB and get error from checker)
  reg [7:0] ana_trim_data[21];
  reg [7:0] exp_ana_trim[21];
  reg [7:0] config_data[8];
  //------------------------------------------------------------------------------
  //---------------------------- SPI ---------------------------------------------
  logic [7:0] mask;
  logic [7:0] pad;
  logic [7:0] no_of_bytes;
  logic [7:0] rd_data;
  logic [7:0] rd_data_reg[];
  //------------------------------------------------------------------------------
  //---------------------------- ANALOG ------------------------------------------
  reg [7:0] ana_tsc0;
  reg [7:0] ana_tsc1;
  reg [1:0] chno;
  reg [7:0] ana_reg_data[6];
  reg [7:0] ana_reg_expd[6];
  reg [18:0] exp_io_values[11];
  bit       enter_LP;
  //------------------------------------------------------------------------------
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
    uvm_top.set_timeout(5s);
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

    `DUT_IF.pclk_sel = top_test_cfg.pclk_sel;

    `DUT_IF.iclk_sel = top_test_cfg.iclk_sel;

    `DUT_IF.mclk_sel = top_test_cfg.mclk_sel;

    `DUT_IF.spi_sclk_freq = top_test_cfg.spi_sclk_freq;

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

    `nnc_info("SOC_TEST", "soc_BAF4P1_demo_test_max start", UVM_LOW)

    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    
    `uvm_info("SOC_TEST", "\tSimulation Begin!!!\n", UVM_LOW);
    `uvm_info("SOC_TEST", "\tBAF4P1 demo test\n", UVM_LOW);
    `ifdef MIX_SIG
    `uvm_info("SOC_TEST", "Re-Initializing EEPROM BLOCK inf0", UVM_LOW);
    $readmemh("../rtl/flash_ctrl/sim/inf0_ff.hex", `FLASH_TOP.u_32k.inf0_mem);
    `endif
    wait(`RESETN);

    wait(`DUT_IF.flash_recall_done);
    do_run;
    `uvm_info("SOC_TEST", "\tSimulation End!!!\n", UVM_LOW);


    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    #10000ns;
    `nnc_info("SOC_TEST", "soc_BAF4P1_demo_test_max end now", UVM_LOW)

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

task do_ana_load;
begin

       //`uvm_info("SOC_TEST", "\t****** Set ALWAYS_ON_CLK_CTRL register ******\n", UVM_LOW);
    //Set D2A_CPCLK
    ////------------- to write in to the ALWAYS_ON_CLK_CTRL reg--------------//
       //`WR_NORMAL_REG(`ALWAYS_ON_CLK_CTRL,ana_reg_expd[0],pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_BUFFER register ******\n", UVM_LOW);
    //Set VCM1P5_BUF_EN, BG1P2_BUF_EN, RLD_EN, RLD_CHOP_EN, ECG_ELECTRODE_EN
    ////------------- to write in to the SOC_ANA_BUFFER reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_BUFFER,ana_reg_expd[0],pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_ECG_CTRL1 register ******\n", UVM_LOW);
    //Set ECG_PGA_EN, ECG_LPF_EN, ECG_PGA_GSEL, ECG_DDA_GSEL
    ////------------- to write in to the SOC_ANA_ECG_CTRL1 reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_ECG_CTRL1,ana_reg_expd[1],pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_ECG_CTRL2 register ******\n", UVM_LOW);
    //Set ECG_DDA_CLKSEL, ECG_DDA_EN, ECG_DDACHOP_EN, ECG_DDA_ISEL, ECG_CAL_EN
    ////------------- to write in to the SOC_ANA_ECG_CTRL2 reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_ECG_CTRL2,ana_reg_expd[2],pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_LEAD_OFF_CTRL register ******\n", UVM_LOW);
    //Set DC_LEAD_OFF_RMODE_EN, DC_LEAD_OFF_VIN_FLIP
    ////------------- to write in to the SOC_ANA_LEAD_OFF reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_LEAD_OFF,ana_reg_expd[3],pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_LEAD_OFF_EN register ******\n", UVM_LOW);
    //Set DC_ECG_LEAD_OFF_EN, AC_ECG_LEAD_OFF_EN
    ////------------- to write in to the SOC_ANA_LEAD_OFF_EN reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_LEAD_OFF_EN,ana_reg_expd[4],pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_TSC register ******\n", UVM_LOW);//Not going to always ON shadow, only signals buffered using wakeup
    //Set TSC_EN, TSC_BJT_SEL, TSC_INA_GSEL, TSC_OUT_SEL
    ////------------- to write in to the SOC_ANA_TSC reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_TSC,8'hFF,pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_TSC1 register ******\n", UVM_LOW);//Not going to always ON shadow, only signals buffered using wakeup
    //Set TSC_INA_EN
    ////------------- to write in to the SOC_ANA_TSC1 reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_TSC_1,8'hFF,pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_PPG_LED_SEL register ******\n", UVM_LOW);//Not going to always ON shadow, only signals buffered using wakeup
    //Set PPG_LED_SEL, PPG_LED_DAC_SEL
    ////------------- to write in to the SOC_ANA_PPG_LED_SEL reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_PPG_LED_SEL,8'hFF,pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_PPG_DAC0_CTRL_REG0 register ******\n", UVM_LOW);//Not going to always ON shadow, only signals buffered using wakeup
    //Set PPG_DAC0_VSEL[7:0]
    ////------------- to write in to the SOC_ANA_PPG_DAC0_CTRL_REG0 reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_PPG_DAC0_CTRL_REG0,8'hFF,pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_PPG_DAC0_CTRL_REG1 register ******\n", UVM_LOW);//Not going to always ON shadow, only signals buffered using wakeup
    //Set PPG_DAC0_VSEL[11:8], PPG_DAC0_EN
    ////------------- to write in to the SOC_ANA_PPG_DAC0_CTRL_REG1 reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_PPG_DAC0_CTRL_REG1,8'hFF,pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_PPG_DAC1_CTRL_REG0 register ******\n", UVM_LOW);//Not going to always ON shadow, only signals buffered using wakeup
    //Set PPG_DAC1_VSEL[7:0]
    ////------------- to write in to the SOC_ANA_PPG_DAC1_CTRL_REG0 reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_PPG_DAC1_CTRL_REG0,8'hFF,pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_PPG_DAC1_CTRL_REG1 register ******\n", UVM_LOW);//Not going to always ON shadow, only signals buffered using wakeup
    //Set PPG_DAC1_VSEL[11:8], PPG_DAC1_EN
    ////------------- to write in to the SOC_ANA_PPG_DAC1_CTRL_REG1 reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_PPG_DAC1_CTRL_REG1,8'hFF,pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_PPG_TIA_IDAC register ******\n", UVM_LOW);//Not going to always ON shadow, only signals buffered using wakeup
    //Set PPG_TIA_IDAC
    ////------------- to write in to the SOC_ANA_PPG_TIA_IDAC reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_PPG_TIA_IDAC,8'hFF,pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_PPG_TIA_GAIN register ******\n", UVM_LOW);//Not going to always ON shadow, only signals buffered using wakeup
    //Set PPG_TIA_GAIN
    ////------------- to write in to the SOC_ANA_PPG_TIA_GAIN reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_PPG_TIA_GAIN,8'hFF,pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_PPG_TEST register ******\n", UVM_LOW);//Not going to always ON shadow, only signals buffered using wakeup
    //Set PPG_TEST_OUT, PPG_TEST_IN, PPG_PDV_REF_SEL
    ////------------- to write in to the SOC_ANA_PPG_TEST reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_PPG_TEST,8'hFF,pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_PPG_LED_EN register ******\n", UVM_LOW);//Not going to always ON shadow, only signals buffered using wakeup
    //Set PPG_DAC_BUFFER_EN, PPG_TIA_VREF_BUFFER_EN, PPG_BUFFER_EN, PPG_SH_EN, PPG_AF_EN, PPG_LED_STANDBYEN
    ////------------- to write in to the SOC_ANA_PPG_LED_EN reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_PPG_LED_EN,8'hFF,pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_PPG_CTRL register ******\n", UVM_LOW);//Not going to always ON shadow, only signals buffered using wakeup
    //Set PPG_LED_EN, PPG_TIA_EN, PPG_SH_CK
    ////------------- to write in to the SOC_ANA_PPG_CTRL reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_PPG_CTRL,8'hFF,pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_SDM register ******\n", UVM_LOW);//Not going to always ON shadow, only signals buffered using wakeup
    //Set SDM_EN, SDM_BIAS
    ////------------- to write in to the SOC_ANA_SDM reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_SDM,8'hFF,pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_ZMEAS_REG_CTRL register ******\n", UVM_LOW);//Not going to always ON
    //Set D2A_SW_Z_TX_GSEL, D2A_SW_Z_CALMD, D2A_SW_Z_RXGAIN, D2A_Z_EN
    ////Enable ZMEAS
    ////------------- to write in to the SOC_ZMEAS_EN reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_EN,8'h01,pad);
    ////------------- to write in to the SOC_ZMEAS_REG_CTRL_0 reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_REG_CTRL_0,8'hF4,pad);
    ////------------- to write in to the SOC_ZMEAS_REG_CTRL_1 reg--------------//
       `WR_NORMAL_REG(`SOC_ZMEAS_REG_CTRL_1,8'h20,pad);

       `uvm_info("SOC_TEST", "\t****** Set SOC_IMEAS_MODE_REG register ******\n", UVM_LOW);//Not going to always ON
    //Set D2A_SDM_VIN_SEL
    ////------------- to write in to the SOC_IMEAS_MODE_REG reg--------------//
       `WR_NORMAL_REG(`SOC_IMEAS_MODE_REG,8'hFF,pad);
/*
       `uvm_info("SOC_TEST", "\t****** Set ANA_TSC1 register ******\n", UVM_LOW);//Not going to always ON
    //Set TSC_AMP_EN
    ////------------- to write in to the ANA_TSC_1 reg--------------//
       `WR_NORMAL_REG(`ANA_TSC_1,8'hFF,pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_PGA register ******\n", UVM_LOW);//Not going to always ON
    //Set PGA_EN, PGA_VIN_SEL, PGA_GSEL
    ////------------- to write in to the ANA_PGA reg--------------//
       `WR_NORMAL_REG(`ANA_PGA,8'hFF,pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_SDM register ******\n", UVM_LOW);//Not going to always ON
    //Set SDM_EN, SDM_CHOP_EN
    ////------------- to write in to the ANA_SDM reg--------------//
       `WR_NORMAL_REG(`ANA_SDM,8'hFF,pad);

    for(chno = 0; chno < 1; chno++) begin//remove CH2

       `uvm_info("SOC_TEST", "\t****** Set ANA_IMEAS_CH%0d_WE1_0 register ******\n",chno+1, UVM_LOW);
    //Set CH1_WE1_EN, CH1_WE1_DDA_EN, CH1_WE1_RFB_SEL
    ////------------- to write in to the ANA_IMEAS_CH1_WE1_0 reg--------------//
       `WR_NORMAL_REG((`ANA_IMEAS_CH1_WE1_0+(chno*11)),ana_reg_expd[1+(chno*11)],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_IMEAS_CH%0d_WE1_1 register ******\n",chno+1, UVM_LOW);
    //Set CH1_WE1_ROUT_SEL, CH1_WE1_VGAIN_SEL
    ////------------- to write in to the ANA_IMEAS_CH1_WE1_1 reg--------------//
       `WR_NORMAL_REG((`ANA_IMEAS_CH1_WE1_1+(chno*11)),ana_reg_expd[2+(chno*11)],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_IMEAS_CH%0d_WE2_0 register ******\n",chno+1, UVM_LOW);
    //Set CH1_WE2_EN, CH1_WE2_DDA_EN, CH1_WE2_RFB_SEL
    ////------------- to write in to the ANA_IMEAS_CH1_WE2_0 reg--------------//
       `WR_NORMAL_REG((`ANA_IMEAS_CH1_WE2_0+(chno*11)),ana_reg_expd[3+(chno*11)],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_IMEAS_CH%0d_WE2_1 register ******\n",chno+1, UVM_LOW);
    //Set CH1_WE2_ROUT_SEL, CH1_WE2_VGAIN_SEL
    ////------------- to write in to the ANA_IMEAS_CH1_WE2_1 reg--------------//
       `WR_NORMAL_REG((`ANA_IMEAS_CH1_WE2_1+(chno*11)),ana_reg_expd[4+(chno*11)],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_IMEAS_CH%0d_RCE_ROUTSEL register ******\n",chno+1, UVM_LOW);
    //Set CH1_RCE_EN, CH1_CE_ROUT_SEL
    ////------------- to write in to the ANA_IMEAS_CH1_RCE_ROUTSEL reg--------------//
       `WR_NORMAL_REG((`ANA_IMEAS_CH1_RCE_ROUTSEL+(chno*11)),ana_reg_expd[5+(chno*11)],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_IMEAS_CH%0d_WE_DAC_EN register ******\n",chno+1, UVM_LOW);
    //Set CH1_WE_DAC_EN
    ////------------- to write in to the ANA_IMEAS_CH1_WE_DAC_EN reg--------------//
       `WR_NORMAL_REG((`ANA_IMEAS_CH1_WE_DAC_EN+(chno*11)),ana_reg_expd[6+(chno*11)],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_IMEAS_CH%0d_DINWE_0 register ******\n",chno+1, UVM_LOW);
    //Set CH1_DINWE
    ////------------- to write in to the ANA_IMEAS_CH1_DINWE_0 reg--------------//
       `WR_NORMAL_REG((`ANA_IMEAS_CH1_DINWE_0+(chno*11)),ana_reg_expd[7+(chno*11)],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_IMEAS_CH%0d_DINWE_1 register ******\n",chno+1, UVM_LOW);
    //Set CH1_DINWE
    ////------------- to write in to the ANA_IMEAS_CH1_DINWE_1 reg--------------//
       `WR_NORMAL_REG((`ANA_IMEAS_CH1_DINWE_1+(chno*11)),ana_reg_expd[8+(chno*11)],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_IMEAS_CH%0d_RCE_DAC_EN register ******\n",chno+1, UVM_LOW);
    //Set CH1_RCE_DAC_EN
    ////------------- to write in to the ANA_IMEAS_CH1_RCE_DAC_EN reg--------------//
       `WR_NORMAL_REG((`ANA_IMEAS_CH1_RCE_DAC_EN+(chno*11)),ana_reg_expd[9+(chno*11)],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_IMEAS_CH%0d_DINRCE_0 register ******\n",chno+1, UVM_LOW);
    //Set CH1_DINRCE
    ////------------- to write in to the ANA_IMEAS_CH1_DINRCE_0 reg--------------//
       `WR_NORMAL_REG((`ANA_IMEAS_CH1_DINRCE_0+(chno*11)),ana_reg_expd[10+(chno*11)],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_IMEAS_CH%0d_DINRCE_1 register ******\n",chno+1, UVM_LOW);
    //Set CH1_DINRCE
    ////------------- to write in to the ANA_IMEAS_CH1_DINRCE_1 reg--------------//
       `WR_NORMAL_REG((`ANA_IMEAS_CH1_DINRCE_1+(chno*11)),ana_reg_expd[11+(chno*11)],pad);
     //repeat loop for CH2
     end

       `uvm_info("SOC_TEST", "\t****** Set ANA_PMU register ******\n", UVM_LOW);
   //Set BG_BUF_EN, DAC_BUF_EN
    ////------------- to write in to the ANA_PMU reg--------------//
       `WR_NORMAL_REG(`ANA_PMU,ana_reg_expd[12],pad);
*/
       `uvm_info("SOC_TEST", "\t****** Set SOC_ANA_BIST register ******\n", UVM_LOW);
    //Set BIST_EN, BIST_ISEL
    ////------------- to write in to the SOC_ANA_BIST reg--------------//
       `WR_NORMAL_REG(`SOC_ANA_BIST,ana_reg_expd[5],pad);
/*
       `uvm_info("SOC_TEST", "\t****** Set ANA_DDA register ******\n", UVM_LOW);
    //Set DDA_EN, DDA_GSEL
    ////------------- to write in to the ANA_DDA reg--------------//
       `WR_NORMAL_REG(`ANA_DDA,ana_reg_expd[14],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_ELE register ******\n", UVM_LOW);
    //Set ELE_BUF_EN, ELE_BUF_ISEL
    ////------------- to write in to the ANA_ELE reg--------------//
       `WR_NORMAL_REG(`ANA_ELE,ana_reg_expd[15],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_DAC1_EN register ******\n", UVM_LOW);
    //Set R2R_DAC1_EN
    ////------------- to write in to the ANA_DAC1_EN reg--------------//
       `WR_NORMAL_REG(`ANA_DAC1_EN,ana_reg_expd[27],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_DAC1_DIN_0 register ******\n", UVM_LOW);
    //Set R2R_DAC1_DIN
    ////------------- to write in to the ANA_DAC1_DIN_0 reg--------------//
       `WR_NORMAL_REG(`ANA_DAC1_DIN_0,ana_reg_expd[28],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_DAC1_DIN_1 register ******\n", UVM_LOW);
    //Set R2R_DAC1_DIN
    ////------------- to write in to the ANA_DAC1_DIN_1 reg--------------//
       `WR_NORMAL_REG(`ANA_DAC1_DIN_1,ana_reg_expd[29],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_DAC2_EN register ******\n", UVM_LOW);
    //Set R2R_DAC2_EN
    ////------------- to write in to the ANA_DAC2_EN reg--------------//
       `WR_NORMAL_REG(`ANA_DAC2_EN,ana_reg_expd[30],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_DAC2_DIN_0 register ******\n", UVM_LOW);
    //Set R2R_DAC2_DIN
    ////------------- to write in to the ANA_DAC2_DIN_0 reg--------------//
       `WR_NORMAL_REG(`ANA_DAC2_DIN_0,ana_reg_expd[31],pad);

       `uvm_info("SOC_TEST", "\t****** Set ANA_DAC2_DIN_1 register ******\n", UVM_LOW);
    //Set R2R_DAC2_DIN
    ////------------- to write in to the ANA_DAC2_DIN_1 reg--------------//
       `WR_NORMAL_REG(`ANA_DAC2_DIN_1,ana_reg_expd[32],pad);*/
end
endtask

task do_always_on_ana_read;
begin
       `uvm_info("SOC_TEST", "\t****** Read Always ON ANA registers ******\n", UVM_LOW); 
       pad= 8'h00;
       mask= 8'hFF;
       no_of_bytes = 8'h0A;
       rd_data_reg = new[no_of_bytes];
/*       ana_reg_data = '{16{'0}};//clear ana_reg_data
       //Read Always ON Ana registers
      ///-------------to read burst starting from the ALWAYS_ON_CLK_CTRL_DEBUG reg-------------------//
       `RD_BURST_NORMAL_REG(`ALWAYS_ON_CLK_CTRL_DEBUG, no_of_bytes, rd_data_reg);
       for(int i=0; i<(no_of_bytes-7); i++) begin
	ana_reg_data[i] = rd_data_reg[(no_of_bytes-1)-i];
	//`uvm_info("SOC_TEST", $sformatf("\tana reg data_%d: (0x%x)\n", i, ana_reg_data[i], UVM_LOW);
        if(ana_reg_data[i] !== ana_reg_expd[i]) begin
          
          `uvm_error("SOC_TEST", "\tERROR READ ANA-REG%0d!!! ALWAYS ON SPI WRITE FAILED!!!", i);
        end
       end*/
       //Read Always ON trim debug registers
       ///-------------to read burst starting from the SOC_ALWAYS_ON_ANA_TRIM1 reg-------------------//
       `RD_BURST_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM1, no_of_bytes, rd_data_reg);
       for(int i=0; i<no_of_bytes; i++) begin
	ana_trim_data[i] = rd_data_reg[(no_of_bytes-1)-i];
	//`uvm_info("SOC_TEST", $sformatf("\tana_trim_data_%d: (0x%x)\n", i, ana_trim_data[i], UVM_LOW);	
	if(ana_trim_data[i] !== exp_ana_trim[i+1]) begin
          
          `uvm_error("SOC_TEST", $sformatf("\tERROR READ ANA-TRIM%0d!!! ALWAYS ON LOAD FROM FLASH FAILED!!!", i));
        end
       end
end
endtask

task do_run;
begin
   
       pad= 8'h00;
       mask= 8'hFF;

       fork
           CONFIG_SEL;
           check_ana;
           check_trim;
           check_no_leakage;
       join_none
          pad= 8'h00;
          mask= 8'hFF;
       //exp ana trim
       exp_ana_trim[0]  = 8'h5A;
       exp_ana_trim[1]  = top_test_cfg.exp_trim[0];
       exp_ana_trim[2]  = top_test_cfg.exp_trim[1];
       exp_ana_trim[3]  = top_test_cfg.exp_trim[2];
       exp_ana_trim[4]  = top_test_cfg.exp_trim[3];
       exp_ana_trim[5]  = top_test_cfg.exp_trim[4];
       exp_ana_trim[6]  = top_test_cfg.exp_trim[5];
       exp_ana_trim[7]  = top_test_cfg.exp_trim[6];
       exp_ana_trim[8]  = top_test_cfg.exp_trim[7];
       exp_ana_trim[9]  = top_test_cfg.exp_trim[8];
       exp_ana_trim[10] = top_test_cfg.exp_trim[9];
       exp_ana_trim[11] = top_test_cfg.exp_trim[10];
       exp_ana_trim[12] = top_test_cfg.exp_trim[11];
       exp_ana_trim[13] = top_test_cfg.exp_trim[12];
       exp_ana_trim[14] = top_test_cfg.exp_trim[13];
       exp_ana_trim[15] = top_test_cfg.exp_trim[14];
       exp_ana_trim[16] = top_test_cfg.exp_trim[15];
       exp_ana_trim[17] = top_test_cfg.exp_trim[16];
       exp_ana_trim[18] = top_test_cfg.exp_trim[17];
       exp_ana_trim[19] = top_test_cfg.exp_trim[18];
       exp_ana_trim[20] = top_test_cfg.exp_trim[19];
       //exp ana reg
       ana_reg_expd[0]  = top_test_cfg.exp_ao_ana[0];//ana_buffer
       ana_reg_expd[1]  = top_test_cfg.exp_ao_ana[1];//ana_ecg_ctrl_1
       ana_reg_expd[2]  = top_test_cfg.exp_ao_ana[2];//ana_ecg_ctrl_2
       ana_reg_expd[3]  = top_test_cfg.exp_ao_ana[3];//ana_lead_off_ctrl
       ana_reg_expd[4]  = top_test_cfg.exp_ao_ana[4];//ana_lead_off_en
       ana_reg_expd[5]  = top_test_cfg.exp_ao_ana[5];//ana_bist
       //exp io during lpm
       exp_io_values[0] = 19'h0_0000;
       exp_io_values[1] = 19'h0_0000;
       exp_io_values[2] = 19'h0_0000;
       exp_io_values[3] = 19'h7_ffff;
       exp_io_values[4] = 19'h0_0000;
       exp_io_values[5] = 19'h0_0000;
       exp_io_values[6] = 19'h0_0000;
       exp_io_values[7] = 19'h0_0000;
       exp_io_values[8] = 19'h0_0000;
       exp_io_values[9] = 19'h0_0000;
       exp_io_values[10]= 19'h0_0000;

       #10us;
       `uvm_info("SOC_TEST", "\n ALWAYS_ON VDD is OFF", UVM_LOW);
       force `ANA_TOP.VDD_DIG_AO=0;

       #10us;
       `uvm_info("SOC_TEST", "\n BISTMODE: Write Ana-Trim values to NVR1\n", UVM_LOW);
       `FLASH_BIST_MASTER_TOP.TESTMODE_SEL = 2'b10;

       force `ANA_TOP.A2D_OSC_OUT = 1'bx;
       force `ANA_TOP.A2D_SDM_OUT = 1'bx;
       //force `ANA_TOP.A2D_SW_POWER_POR = 1'b1;
       force `ANA_TOP.A2D_VDDI_POR = 1'bx;
       force `ANA_TOP.A2D_external_RESET = 1'bx;
       force `ANA_TOP.A2D_external_clock_I = 1'bx;
       force `ANA_TOP.A2D_external_en_I = 1'bx;
       //force `ANA_TOP.A2D_Wake_UP_i = 1'b1;

       #100us;
       `uvm_info("SOC_TEST", "\n ALWAYS_ON VDD is ON", UVM_LOW);
       release `ANA_TOP.VDD_DIG_AO;

       #10us;
       `uvm_info("SOC_TEST", "[FLASH BIST MASTER][0] Sending Reset Command to Flash at Time: ",  UVM_LOW);
       `FLASH_BIST_MASTER_TOP.reset;
       `uvm_info("SOC_TEST", "[FLASH BIST MASTER] Complete successully this phase at Time: ",  UVM_LOW);

       @(posedge `FLASH_BIST_MASTER_TOP.TCK);

`ifndef MIX_SIG
       `uvm_info("SOC_TEST", "[FLASH BIST MASTER][1] Sending Serial Erase Command to to erase NVR of Flash at Time: ",  UVM_LOW);
       `FLASH_BIST_MASTER_TOP.serase_1st_NVR_10M;
       `uvm_info("SOC_TEST", "[FLASH BIST MASTER] Complete successully this phase at Time: ",  UVM_LOW);
`endif

       for (int i=0; i < 21;  i++) begin
         $display("[FLASH BIST MASTER][2] Sending Program Command to program NVR ADDR: %h with DATA: %h, at time:%t", i, exp_ana_trim[i], $time);
         `FLASH_BIST_MASTER_TOP.prgm_word_NVR_10M(i, exp_ana_trim[i]);
          $display("[FLASH BIST MASTER] Complete successully this phase at Time: %t", $time);
       end

       release `ANA_TOP.A2D_OSC_OUT;
       release `ANA_TOP.A2D_SDM_OUT;
       //release `ANA_TOP.A2D_SW_POWER_POR;
       release `ANA_TOP.A2D_VDDI_POR;
       release `ANA_TOP.A2D_external_RESET;
       release `ANA_TOP.A2D_external_clock_I;
       release `ANA_TOP.A2D_external_en_I;
       //release `ANA_TOP.A2D_Wake_UP_i;
       `FLASH_BIST_MASTER_TOP.RESETb = 0;
 
       #10us;
       `uvm_info("SOC_TEST", "\n ALWAYS_ON VDD is OFF", UVM_LOW);
       force `ANA_TOP.VDD_DIG_AO=0;

       #10us;
       `uvm_info("SOC_TEST", "\n Enter NORMAL MODE", UVM_LOW);
       `FLASH_BIST_MASTER_TOP.TESTMODE_SEL = 2'b00;

       #100us;
       `uvm_info("SOC_TEST", "\n ALWAYS_ON VDD is ON", UVM_LOW);
       release `ANA_TOP.VDD_DIG_AO;

       `uvm_info("SOC_TEST", "\n Wait for RESET Always-ON domain", UVM_LOW);
//`ifndef POSTLAYOUT_PG
       wait(`ALWAYSON_RESETN);
//`else
//       wait(!`ALWAYSON_RST_CTRL.OUT0);
//`endif
       `uvm_info("SOC_TEST", "\n RESET Switchable domain", UVM_LOW);
       #10000
       force `SOC_TB.iopad_resetn=0;
       #100000
       force `SOC_TB.iopad_resetn=1;

       wait(`RESETN);

       flash_debug_status = 8'h00;
       //wait (`SPI_TOP.FLASH_CONFEN);
       //`RD_NORMAL_REG(`SOC_FLASH_DEBUG2,pad,flash_debug_status);
       //while (flash_debug_status[0]===0) begin
	//`RD_NORMAL_REG(`SOC_FLASH_DEBUG2,pad,flash_debug_status);
       //end
       //`uvm_info("SOC_TEST", "\tFlash conf set start", UVM_LOW);
       //wait (!`SPI_TOP.FLASH_CONFEN);
       //while (flash_debug_status[0]===1) begin
	//`RD_NORMAL_REG(`SOC_FLASH_DEBUG2,pad,flash_debug_status);
       //end
       //`uvm_info("SOC_TEST", "\tFlash conf set done", UVM_LOW);

 
       //wait (!`SPI_TOP.FLASH_BUSY);
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,pad,flash_debug_status);
       while (flash_debug_status[6] === 1) begin
	`RD_NORMAL_REG(`SOC_FLASH_DEBUG2,pad,flash_debug_status);
       end
       `uvm_info("SOC_TEST", "\tFlash reset done!", UVM_LOW);

       //check config data
       for(int i=0; i<=7; i++) begin
        config_data[i] = `DIG_TOP.flash_ctrl_top_inst.u_32k.fuse_reg[i];
        `uvm_info("SOC_TEST", $sformatf("\tconfig_reg data_%d: (0x%x)\n", i, config_data[i]), UVM_LOW);
        if(config_data[i] != (8'h10+i)) begin
         
         `uvm_error("SOC_TEST", "\tERROR!!! CONFIG DATA MISMATCH!!!");
        end
       end

     //Read Ana Trim values stored in customer reserved space of NVR1
      ///-------------to read burst starting from the SOC_FLASH_TRIMDATA0 reg-------------------//
       no_of_bytes = 8'h0F;
       rd_data_reg = new[no_of_bytes];
       `RD_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA0, no_of_bytes, rd_data_reg);
       for(int i=0; i<no_of_bytes; i++) begin
	ana_trim_data[i] = rd_data_reg[(no_of_bytes-1)-i];
	`uvm_info("SOC_TEST", $sformatf("\tana trim data_%d: (0x%x)\n", i, ana_trim_data[i]), UVM_LOW);
        if(ana_trim_data[i] !== exp_ana_trim[i]) begin
          
          `uvm_error("SOC_TEST", "\tERROR!!! ANA-TRIM VALUE MISMATCH!!!");
        end
       end
      ///-------------to read burst starting from the SOC_FLASH_TRIMDATA15 reg-------------------//
       no_of_bytes = 8'h06;
       rd_data_reg = new[no_of_bytes];
       `RD_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA15, no_of_bytes, rd_data_reg);
       for(int i=0; i<no_of_bytes; i++) begin
	ana_trim_data[i] = rd_data_reg[(no_of_bytes-1)-i];
	`uvm_info("SOC_TEST", $sformatf("\tana trim data_%d: (0x%x)\n", i, ana_trim_data[i]), UVM_LOW);
        if(ana_trim_data[i] !== exp_ana_trim[i+15]) begin
          
          `uvm_error("SOC_TEST", "\tERROR!!! SPARE-TRIM VALUE MISMATCH!!!");
        end
       end

       do_ana_load;

       `uvm_info("SOC_TEST", "\t****** Set always on SPI write ******\n", UVM_LOW);
    //Set always_on_spi_write
    ////------------- to write in to the SOC_CLK_CTRL_REG reg--------------//
       `WR_NORMAL_REG(`SOC_CLK_CTRL_REG,8'h80,pad);

       do_always_on_ana_read;
       #100000;

       enter_LP = 1'b1;
       `uvm_info("SOC_TEST", "\n Enter Low power mode", UVM_LOW);
       `include "../tc/demo_test_force.inc"
       `uvm_info("SOC_TEST", "\n Enter Active mode", UVM_LOW);
 
       @(posedge `RESETN);

       flash_debug_status = 8'h00;
       
       //wait (!`SPI_TOP.FLASH_BUSY);
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,pad,flash_debug_status);
       while (flash_debug_status[6] === 1) begin
	`RD_NORMAL_REG(`SOC_FLASH_DEBUG2,pad,flash_debug_status);
       end
       `uvm_info("SOC_TEST", "\tFlash reset done!", UVM_LOW);

     //Read Ana Trim values stored in customer reserved space of NVR1
      ///-------------to read burst starting from the SOC_FLASH_TRIMDATA0 reg-------------------//
       no_of_bytes = 8'h0F;
       rd_data_reg = new[no_of_bytes];
       `RD_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA0, no_of_bytes, rd_data_reg);
       for(int i=0; i<no_of_bytes; i++) begin
	ana_trim_data[i] = rd_data_reg[(no_of_bytes-1)-i];
	`uvm_info("SOC_TEST", $sformatf("\tana trim data_%d: (0x%x)\n", i, ana_trim_data[i]), UVM_LOW);
        if(ana_trim_data[i] !== exp_ana_trim[i]) begin
          
          `uvm_error("SOC_TEST", "\tERROR!!! TRIM VALUE MISMATCH AFTER WAKEUP!!!");
        end
       end
      ///-------------to read burst starting from the SOC_FLASH_TRIMDATA15 reg-------------------//
       no_of_bytes = 8'h06;
       rd_data_reg = new[no_of_bytes];
       `RD_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA15, no_of_bytes, rd_data_reg);
       for(int i=0; i<no_of_bytes; i++) begin
	ana_trim_data[i] = rd_data_reg[(no_of_bytes-1)-i];
	`uvm_info("SOC_TEST", $sformatf("\tana trim data_%d: (0x%x)\n", i, ana_trim_data[i]), UVM_LOW);
        if(ana_trim_data[i] !== exp_ana_trim[i+15]) begin
          
          `uvm_error("SOC_TEST", "\tERROR!!! TRIM VALUE MISMATCH AFTER WAKEUP!!!");
        end
       end

       do_always_on_ana_read;
       #1000000;
end
endtask:do_run

task CONFIG_SEL;
    while (1) begin
        @(`FLASH_TOP.u_32k.CONFEN); #1;
        if(`FLASH_TOP.u_32k.CONFEN != 0) `uvm_info("SOC_TEST", "\tCONFEN set!", UVM_LOW);
    end
endtask:CONFIG_SEL

task check_trim; 
wait(`SOC_TB.TESTMODE===2'b10);
//wait to enter NORMAL MODE
wait(`SOC_TB.TESTMODE===2'b00);
@ (posedge `SOC_TOP.flash_reset_done);
@ (posedge `SOC_TB.BAF4P1_CLK);
@ (posedge `SOC_TB.BAF4P1_CLK);
@ (posedge `SOC_TB.BAF4P1_CLK);
while (1)
begin
@ (posedge `SOC_TB.BAF4P1_CLK);
if(exp_ana_trim[1] !== (`ANA_TOP.D2A_BGH_VTRIM)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_BGH_VTRIM not match!");
end
if(exp_ana_trim[2] !== (`ANA_TOP.D2A_BGH_CTRIM)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_BGH_CTRIM not match!");
end
if(exp_ana_trim[3] !== (`ANA_TOP.D2A_LDO1V5_VTRIM)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_LDO1V5_VTRIM not match!");
end
if(exp_ana_trim[4] !== (`ANA_TOP.D2A_OSC_TRIM)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_OSC_TRIM not match!");
end
if(exp_ana_trim[5] !== (`ANA_TOP.D2A_OSC_ISEL_TRIM)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_OSC_ISEL_TRIM not match!");
end
if(exp_ana_trim[6] !== (`ANA_TOP.D2A_DCLEADOFF_COMP_TH_TRIM)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_DCLEADOFF_COMP_TH_TRIM not match!");
end
if(exp_ana_trim[7] !== (`ANA_TOP.D2A_DCLEADOFF_ISEL_TRIM)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_DCLEADOFF_ISEL_TRIM not match!");
end
if(exp_ana_trim[8] !== (`ANA_TOP.D2A_ACLEADOFF_VTHNSEL_TRIM)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ACLEADOFF_VTHNSEL_TRIM not match!");
end
if(exp_ana_trim[9] !== (`ANA_TOP.D2A_ACLEADOFF_VTHPSEL_TRIM)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ACLEADOFF_VTHPSEL_TRIM not match!");
end
if(exp_ana_trim[10] !== (`ANA_TOP.D2A_ACLEADOFF_ISEL_TRIM)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ACLEADOFF_ISEL_TRIM not match!");
end
if(exp_ana_trim[15] !== (`ANA_TOP.D2A_SPARE_TRIM0)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_SPARE_TRIM0 not match!");
end
if(exp_ana_trim[16] !== (`ANA_TOP.D2A_SPARE_TRIM1)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_SPARE_TRIM1 not match!");
end
if(exp_ana_trim[17] !== (`ANA_TOP.D2A_SPARE_TRIM2)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_SPARE_TRIM2 not match!");
end
if(exp_ana_trim[18] !== (`ANA_TOP.D2A_SPARE_TRIM3)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_SPARE_TRIM3 not match!");
end
end
endtask:check_trim

task check_ana;
wait(`SOC_TOP.spi_write===1'b1);
@ (posedge `SOC_TB.BAF4P1_CLK);
@ (posedge `SOC_TB.BAF4P1_CLK);
@ (posedge `SOC_TB.BAF4P1_CLK);
forever @( posedge `SOC_TB.BAF4P1_CLK) begin
if(ana_reg_expd[0][0] !== (`ANA_TOP.D2A_VCM1P5_BUF_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_VCM1P5_BUF_EN not match!");
end
if(ana_reg_expd[0][1] !== (`ANA_TOP.D2A_BG1P2_BUF_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_BG1P2_BUF_EN not match!");
end
if(ana_reg_expd[0][2] !== (`ANA_TOP.D2A_RLD_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_RLD_EN not match!");
end
if(ana_reg_expd[0][3] !== (`ANA_TOP.D2A_RLD_CHOP_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_RLD_CHOP_EN not match!");
end
if(ana_reg_expd[0][4] !== (`ANA_TOP.D2A_2ELECTRODE_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_2ELECTRODE_EN not match!");
end
if(ana_reg_expd[1][0] !== (`ANA_TOP.D2A_ECG_PGA_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ECG_PGA_EN not match!");
end
if(ana_reg_expd[1][1] !== (`ANA_TOP.D2A_ECG_LPF_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ECG_LPF_EN not match!");
end
if(ana_reg_expd[1][4:2] !== (`ANA_TOP.D2A_ECG_PGA_GSEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ECG_PGA_GSEL not match!");
end
if(ana_reg_expd[1][7:5] !== (`ANA_TOP.D2A_ECG_DDA_GSEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ECG_DDA_GSEL not match!");
end
if(ana_reg_expd[2][1:0] !== (`ANA_TOP.D2A_ECG_DDA_CLKSEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ECG_DDA_CLKSEL not match!");
end
if(ana_reg_expd[2][2] !== (`ANA_TOP.D2A_ECG_DDA_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ECG_DDA_EN not match!");
end
if(ana_reg_expd[2][3] !== (`ANA_TOP.D2A_ECG_DDACHOP_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ECG_DDACHOP_EN not match!");
end
if(ana_reg_expd[2][5:4] !== (`ANA_TOP.D2A_ECG_DDA_ISEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ECG_DDA_ISEL not match!");
end
if(ana_reg_expd[2][6] !== (`ANA_TOP.D2A_ECGCAL_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ECGCAL_EN not match!");
end
if(ana_reg_expd[3][0] !== (`ANA_TOP.D2A_DCLEADOFF_RMODE_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_DCLEADOFF_RMODE_EN not match!");
end
if(ana_reg_expd[3][1] !== (`ANA_TOP.D2A_DCLEADOFF_VINFLIP)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_DCLEADOFF_VINFLIP not match!");
end
if(ana_reg_expd[4][1:0] !== ({`ANA_TOP.D2A_ACLEADOFF_EN, `ANA_TOP.D2A_DCLEADOFF_EN})) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_LEADOFF_EN not match!");
end
if(ana_reg_expd[5][3] !== (`ANA_TOP.D2A_BIST_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_BIST_EN not match!");
end
if(ana_reg_expd[5][2:0] !== (`ANA_TOP.D2A_BIST_ISEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_BIST_ISEL not match!");
end
end
endtask:check_ana

task check_no_leakage;
while (1)
begin
wait ((`ANA_TOP.A2D_Wake_UP_i === 0) && (enter_LP === 1));
#10ns;
if((`ANA_TOP.A2D_Wake_UP_i === 0) && (enter_LP === 1)) begin
//ANA_TSC
if(`ANA_TOP.D2A_TSC_EN !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_TSC_EN not expected during LPM!");
	
end
if(`ANA_TOP.D2A_TSC_OUT_SEL !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_TSC_OUT_SEL not expected during LPM!");
	
end
if(`ANA_TOP.D2A_TSC_INA_GSEL !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_TSC_INA_GSEL not expected during LPM!");
	
end
if(`ANA_TOP.D2A_TSC_BJT_SEL !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_TSC_BJT_SEL not expected during LPM!");
	
end
//ANA_TSC1
if(`ANA_TOP.D2A_TSC_INA_EN !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_TSC_INA_EN not expected during LPM!");
	
end
//ANA_PPG_LED_SEL
if(`ANA_TOP.D2A_LEDSEL !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_LEDSEL not expected during LPM!");
	
end
if(`ANA_TOP.D2A_LEDDAC_SEL !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_LEDDAC_SEL not expected during LPM!");
	
end
//ANA_PPG_DAC0_CTRL_REG
if(`ANA_TOP.D2A_PPGDAC0_EN !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_PPGDAC0_EN not expected during LPM!");
	
end
if(`ANA_TOP.D2A_PPGDAC0_VSEL !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_PPGDAC0_VSEL not expected during LPM!");
	
end
//ANA_PPG_DAC1_CTRL_REG
if(`ANA_TOP.D2A_PPGDAC1_EN !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_PPGDAC1_EN not expected during LPM!");
	
end
if(`ANA_TOP.D2A_PPGDAC1_VSEL !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_PPGDAC1_VSEL not expected during LPM!");
	
end
//ANA_PPG_TIA_IDAC
if(`ANA_TOP.D2A_TIA_IDAC !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_TIA_IDAC not expected during LPM!");
	
end
//ANA_PPG_TIA_GAIN
if(`ANA_TOP.D2A_TIA_GAIN !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_TIA_GAIN not expected during LPM!");
	
end
//ANA_PPG_TEST_REG
if(`ANA_TOP.D2A_PDVREF_SEL !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_PDVREF_SEL not expected during LPM!");
	
end
if(`ANA_TOP.D2A_PPG_TEST_IN !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_PPG_TEST_IN not expected during LPM!");
	
end
if(`ANA_TOP.D2A_PPG_TEST_OUT !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_PPG_TEST_OUT not expected during LPM!");
	
end
//ANA_PPG_LED_EN_REG
if(`ANA_TOP.D2A_EN_PPGDAC_BUFFER !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_EN_PPGDAC_BUFFER not expected during LPM!");
	
end
if(`ANA_TOP.D2A_EN_TIA_VREFBUFFER !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_EN_TIA_VREFBUFFER not expected during LPM!");
	
end
if(`ANA_TOP.D2A_EN_PPG_BUFFER !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_EN_PPG_BUFFER not expected during LPM!");
	
end
if(`ANA_TOP.D2A_EN_PPG_SH !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_EN_PPG_SH not expected during LPM!");
	
end
if(`ANA_TOP.D2A_EN_PPG_AF !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_EN_PPG_AF not expected during LPM!");
	
end
if(`ANA_TOP.D2A_LED_STANDBYEN !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_LED_STANDBYEN not expected during LPM!");
	
end
//ANA_PPG_CTRL_REG
if(`ANA_TOP.D2A_LED_EN !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_LED_EN not expected during LPM!");
	
end
if(`ANA_TOP.D2A_EN_TIA !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_EN_TIA not expected during LPM!");
	
end
if(`ANA_TOP.D2A_PPG_SH_CK !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_PPG_SH_CK not expected during LPM!");
	
end
//ANA_SDM_REG
if(`ANA_TOP.D2A_SDM_EN !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_SDM_EN not expected during LPM!");
	
end
if(`ANA_TOP.D2A_SDM_BIAS !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_SDM_BIAS not expected during LPM!");
	
end
if(`ANA_TOP.D2A_SDM_CLK !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_SDM_CLK not expected during LPM!");
	
end
if(`ANA_TOP.D2A_SDM_VIN_SEL !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_SDM_VIN_SEL not expected during LPM!");
	
end
//ANA_ZMEAS_EN
if(`ANA_TOP.D2A_Z_EN !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_Z_EN not expected during LPM!");
	
end
//ECGCAL_VSEL_TRIM
if(`ANA_TOP.D2A_ECGCAL_VSEL_TRIM !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ECGCAL_VSEL_TRIM not expected during LPM!");
	
end
//ACLEADOFF_CLK
if(`ANA_TOP.D2A_ACLEADOFF_CLK !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ACLEADOFF_CLK not expected during LPM!");
	
end
//RLD_CLK
if(`ANA_TOP.D2A_RLD_CLK64K !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_RLD_CLK64K not expected during LPM!");
	
end
//ATM
if({`ANA_TOP.D2A_ATM12,
    `ANA_TOP.D2A_ATM11,
    `ANA_TOP.D2A_ATM10,
    `ANA_TOP.D2A_ATM9,
    `ANA_TOP.D2A_ATM8,
    `ANA_TOP.D2A_ATM7,
    `ANA_TOP.D2A_ATM6,
    `ANA_TOP.D2A_ATM5,
    `ANA_TOP.D2A_ATM4,
    `ANA_TOP.D2A_ATM3,
    `ANA_TOP.D2A_ATM2,
    `ANA_TOP.D2A_ATM1,
    `ANA_TOP.D2A_ATM0} !== 0)  begin
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ATM not expected during LPM!");
	
end
//IO cell
if({`SOC_TOP.`GPIO18.IE,
    `SOC_TOP.`GPIO17.IE,
    `SOC_TOP.`GPIO16.IE,
    `SOC_TOP.`GPIO15.IE,
    `SOC_TOP.`GPIO14.IE,
    `SOC_TOP.`GPIO13.IE,
    `SOC_TOP.`GPIO12.IE,
    `SOC_TOP.`GPIO11.IE,
    `SOC_TOP.`GPIO10.IE,
    `SOC_TOP.`GPIO9.IE,
    `SOC_TOP.`GPIO8.IE,
    `SOC_TOP.`GPIO7.IE,
    `SOC_TOP.`GPIO6.IE,
    `SOC_TOP.`GPIO5.IE,
    `SOC_TOP.`GPIO4.IE,
    `SOC_TOP.`GPIO3.IE,
    `SOC_TOP.`GPIO2.IE,
    `SOC_TOP.`GPIO1.IE,
    `SOC_TOP.`GPIO0.IE}					!== exp_io_values[0]) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_IE not expected during LPM!");
	
end
if({`SOC_TOP.`GPIO18.CS,
    `SOC_TOP.`GPIO17.CS,
    `SOC_TOP.`GPIO16.CS,
    `SOC_TOP.`GPIO15.CS,
    `SOC_TOP.`GPIO14.CS,
    `SOC_TOP.`GPIO13.CS,
    `SOC_TOP.`GPIO12.CS,
    `SOC_TOP.`GPIO11.CS,
    `SOC_TOP.`GPIO10.CS,
    `SOC_TOP.`GPIO9.CS,
    `SOC_TOP.`GPIO8.CS,
    `SOC_TOP.`GPIO7.CS,
    `SOC_TOP.`GPIO6.CS,
    `SOC_TOP.`GPIO5.CS,
    `SOC_TOP.`GPIO4.CS,
    `SOC_TOP.`GPIO3.CS,
    `SOC_TOP.`GPIO2.CS,
    `SOC_TOP.`GPIO1.CS,
    `SOC_TOP.`GPIO0.CS} 					!== exp_io_values[1]) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_CS not expected during LPM!");
	
end
if({`SOC_TOP.`GPIO18.PU,
    `SOC_TOP.`GPIO17.PU,
    `SOC_TOP.`GPIO16.PU,
    `SOC_TOP.`GPIO15.PU,
    `SOC_TOP.`GPIO14.PU,
    `SOC_TOP.`GPIO13.PU,
    `SOC_TOP.`GPIO12.PU,
    `SOC_TOP.`GPIO11.PU,
    `SOC_TOP.`GPIO10.PU,
    `SOC_TOP.`GPIO9.PU,
    `SOC_TOP.`GPIO8.PU,
    `SOC_TOP.`GPIO7.PU,
    `SOC_TOP.`GPIO6.PU,
    `SOC_TOP.`GPIO5.PU,
    `SOC_TOP.`GPIO4.PU,
    `SOC_TOP.`GPIO3.PU,
    `SOC_TOP.`GPIO2.PU,
    `SOC_TOP.`GPIO1.PU,
    `SOC_TOP.`GPIO0.PU}					!== exp_io_values[2]) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_PU not expected during LPM!");
	
end
if({`SOC_TOP.`GPIO18.SR,
    `SOC_TOP.`GPIO17.SR,
    `SOC_TOP.`GPIO16.SR,
    `SOC_TOP.`GPIO15.SR,
    `SOC_TOP.`GPIO14.SR,
    `SOC_TOP.`GPIO13.SR,
    `SOC_TOP.`GPIO12.SR,
    `SOC_TOP.`GPIO11.SR,
    `SOC_TOP.`GPIO10.SR,
    `SOC_TOP.`GPIO9.SR,
    `SOC_TOP.`GPIO8.SR,
    `SOC_TOP.`GPIO7.SR,
    `SOC_TOP.`GPIO6.SR,
    `SOC_TOP.`GPIO5.SR,
    `SOC_TOP.`GPIO4.SR,
    `SOC_TOP.`GPIO3.SR,
    `SOC_TOP.`GPIO2.SR,
    `SOC_TOP.`GPIO1.SR,
    `SOC_TOP.`GPIO0.SR}					!== exp_io_values[3]) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_SR not expected during LPM!");
	
end
if({`SOC_TOP.`GPIO18.DR,
    `SOC_TOP.`GPIO17.DR,
    `SOC_TOP.`GPIO16.DR,
    `SOC_TOP.`GPIO15.DR,
    `SOC_TOP.`GPIO14.DR,
    `SOC_TOP.`GPIO13.DR,
    `SOC_TOP.`GPIO12.DR,
    `SOC_TOP.`GPIO11.DR,
    `SOC_TOP.`GPIO10.DR,
    `SOC_TOP.`GPIO9.DR,
    `SOC_TOP.`GPIO8.DR,
    `SOC_TOP.`GPIO7.DR,
    `SOC_TOP.`GPIO6.DR,
    `SOC_TOP.`GPIO5.DR,
    `SOC_TOP.`GPIO4.DR,
    `SOC_TOP.`GPIO3.DR,
    `SOC_TOP.`GPIO2.DR,
    `SOC_TOP.`GPIO1.DR,
    `SOC_TOP.`GPIO0.DR}					!== exp_io_values[4]) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_DR not expected during LPM!");
	
end
if({`SOC_TOP.`GPIO18.A,
    `SOC_TOP.`GPIO17.A,
    `SOC_TOP.`GPIO16.A,
    `SOC_TOP.`GPIO15.A,
    `SOC_TOP.`GPIO14.A,
    `SOC_TOP.`GPIO13.A,
    `SOC_TOP.`GPIO12.A,
    `SOC_TOP.`GPIO11.A,
    `SOC_TOP.`GPIO10.A,
    `SOC_TOP.`GPIO9.A,
    `SOC_TOP.`GPIO8.A,
    `SOC_TOP.`GPIO7.A,
    `SOC_TOP.`GPIO6.A,
    `SOC_TOP.`GPIO5.A,
    `SOC_TOP.`GPIO4.A,
    `SOC_TOP.`GPIO3.A,
    `SOC_TOP.`GPIO2.A,
    `SOC_TOP.`GPIO1.A,
    `SOC_TOP.`GPIO0.A}						!== exp_io_values[5]) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_A not expected during LPM!");
	
end
if({`SOC_TOP.`GPIO18.OE,
    `SOC_TOP.`GPIO17.OE,
    `SOC_TOP.`GPIO16.OE,
    `SOC_TOP.`GPIO15.OE,
    `SOC_TOP.`GPIO14.OE,
    `SOC_TOP.`GPIO13.OE,
    `SOC_TOP.`GPIO12.OE,
    `SOC_TOP.`GPIO11.OE,
    `SOC_TOP.`GPIO10.OE,
    `SOC_TOP.`GPIO9.OE,
    `SOC_TOP.`GPIO8.OE,
    `SOC_TOP.`GPIO7.OE,
    `SOC_TOP.`GPIO6.OE,
    `SOC_TOP.`GPIO5.OE,
    `SOC_TOP.`GPIO4.OE,
    `SOC_TOP.`GPIO3.OE,
    `SOC_TOP.`GPIO2.OE,
    `SOC_TOP.`GPIO1.OE,
    `SOC_TOP.`GPIO0.OE} 					!== exp_io_values[6]) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_OE not expected during LPM!");
	
end
if({`SOC_TOP.`GPIO18.OS,
    `SOC_TOP.`GPIO17.OS,
    `SOC_TOP.`GPIO16.OS,
    `SOC_TOP.`GPIO15.OS,
    `SOC_TOP.`GPIO14.OS,
    `SOC_TOP.`GPIO13.OS,
    `SOC_TOP.`GPIO12.OS,
    `SOC_TOP.`GPIO11.OS,
    `SOC_TOP.`GPIO10.OS,
    `SOC_TOP.`GPIO9.OS,
    `SOC_TOP.`GPIO8.OS,
    `SOC_TOP.`GPIO7.OS,
    `SOC_TOP.`GPIO6.OS,
    `SOC_TOP.`GPIO5.OS,
    `SOC_TOP.`GPIO4.OS,
    `SOC_TOP.`GPIO3.OS,
    `SOC_TOP.`GPIO2.OS,
    `SOC_TOP.`GPIO1.OS,
    `SOC_TOP.`GPIO0.OS} 					!== exp_io_values[7]) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_OS not expected during LPM!");
	
end
if({`SOC_TOP.`GPIO18.OD,
    `SOC_TOP.`GPIO17.OD,
    `SOC_TOP.`GPIO16.OD,
    `SOC_TOP.`GPIO15.OD,
    `SOC_TOP.`GPIO14.OD,
    `SOC_TOP.`GPIO13.OD,
    `SOC_TOP.`GPIO12.OD,
    `SOC_TOP.`GPIO11.OD,
    `SOC_TOP.`GPIO10.OD,
    `SOC_TOP.`GPIO9.OD,
    `SOC_TOP.`GPIO8.OD,
    `SOC_TOP.`GPIO7.OD,
    `SOC_TOP.`GPIO6.OD,
    `SOC_TOP.`GPIO5.OD,
    `SOC_TOP.`GPIO4.OD,
    `SOC_TOP.`GPIO3.OD,
    `SOC_TOP.`GPIO2.OD,
    `SOC_TOP.`GPIO1.OD,
    `SOC_TOP.`GPIO0.OD}					!== exp_io_values[8]) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_OD not expected during LPM!");
	
end
if({`SOC_TOP.`GPIO18.PD,
    `SOC_TOP.`GPIO17.PD,
    `SOC_TOP.`GPIO16.PD,
    `SOC_TOP.`GPIO15.PD,
    `SOC_TOP.`GPIO14.PD,
    `SOC_TOP.`GPIO13.PD,
    `SOC_TOP.`GPIO12.PD,
    `SOC_TOP.`GPIO11.PD,
    `SOC_TOP.`GPIO10.PD,
    `SOC_TOP.`GPIO9.PD,
    `SOC_TOP.`GPIO8.PD,
    `SOC_TOP.`GPIO7.PD,
    `SOC_TOP.`GPIO6.PD,
    `SOC_TOP.`GPIO5.PD,
    `SOC_TOP.`GPIO4.PD,
    `SOC_TOP.`GPIO3.PD,
    `SOC_TOP.`GPIO2.PD,
    `SOC_TOP.`GPIO1.PD,
    `SOC_TOP.`GPIO0.PD}					!== exp_io_values[9]) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_PD not expected during LPM!");
	
end
if({`SOC_TOP.`GPIO18.Y,
    `SOC_TOP.`GPIO17.Y,
    `SOC_TOP.`GPIO16.Y,
    `SOC_TOP.`GPIO15.Y,
    `SOC_TOP.`GPIO14.Y,
    `SOC_TOP.`GPIO13.Y,
    `SOC_TOP.`GPIO12.Y,
    `SOC_TOP.`GPIO11.Y,
    `SOC_TOP.`GPIO10.Y,
    `SOC_TOP.`GPIO9.Y,
    `SOC_TOP.`GPIO8.Y,
    `SOC_TOP.`GPIO7.Y,
    `SOC_TOP.`GPIO6.Y,
    `SOC_TOP.`GPIO5.Y,
    `SOC_TOP.`GPIO4.Y,
    `SOC_TOP.`GPIO3.Y,
    `SOC_TOP.`GPIO2.Y,
    `SOC_TOP.`GPIO1.Y,
    `SOC_TOP.`GPIO0.Y}						!== exp_io_values[10]) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_Y not expected during LPM!");
	
end

if(`ALWAYSON_TOP.o_IOBUF_IE_testmode0			!== 1'b0) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_IE_testmode0 not expected during LPM!");
	
end
//if(`ALWAYSON_TOP.o_IOBUF_PU_testmode0 			!== 1'b0) begin
//	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_PU_testmode0 not expected during LPM!");//not required as always tied to 1'b0 irrespective of wakeup
//	
//end
if(`ALWAYSON_TOP.o_IOBUF_PD_testmode0			!== 1'b0) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_PD_testmode0 not expected during LPM!");
	
end
if(`ALWAYSON_TOP.o_iopad_testmode0_en_y			!== 1'b0) begin
	`uvm_error("SOC_TEST", "\tERROR!!!iopad_testmode0_en_y not expected during LPM!");
	
end

if(`ALWAYSON_TOP.o_IOBUF_IE_testmode1 			!== 1'b0) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_IE_testmode1 not expected during LPM!");
	
end
//if(`ALWAYSON_TOP.o_IOBUF_PU_testmode1 			!== 1'b0) begin
//	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_PU_testmode1 not expected during LPM!");//not required as always tied to 1'b0 irrespective of wakeup
//	
//end
if(`ALWAYSON_TOP.o_IOBUF_PD_testmode1			!== 1'b0) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_PD_testmode1 not expected during LPM!");
	
end
if(`ALWAYSON_TOP.o_iopad_testmode1_en_y			!== 1'b0) begin
	`uvm_error("SOC_TEST", "\tERROR!!!iopad_testmode1_en_y not expected during LPM!");
	
end
 
if(`ALWAYSON_TOP.o_IOBUF_IE_resetn 			!== 1'b0) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_IE_resetn not expected during LPM!");
	
end
if(`ALWAYSON_TOP.o_IOBUF_PU_resetn			!== 1'b0) begin
	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_PU_resetn not expected during LPM!");
	
end
//if(`ALWAYSON_TOP.o_IOBUF_PD_resetn 			!== 1'b0) begin
//	`uvm_error("SOC_TEST", "\tERROR!!!IOBUF_PD_resetn not expected during LPM!");//not required as always tied to 1'b0 irrespective of wakeup
//	
//end
if(`ALWAYSON_TOP.o_iopad_resetn_y 			!== 1'b0) begin
	`uvm_error("SOC_TEST", "\tERROR!!!iopad_resetn_y not expected during LPM!");
	
end
end

/*if(ana_reg_expd[0][2:0] !== (`SOC_TOP.D2A_CPCLK)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CPCLK not match!");
end
//if(chno==0) begin
if(ana_reg_expd[1][0] !== (`SOC_TOP.D2A_CH1_WE1_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_WE1_EN not match!");
end
if(ana_reg_expd[1][1] !== (`SOC_TOP.D2A_CH1_WE1_DDA_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_WE1_DDA_EN not match!");
end
if(ana_reg_expd[1][5:2] !== (`SOC_TOP.D2A_CH1_WE1_RFB_SEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_WE1_RFB_SEL not match!");
end
if(ana_reg_expd[2][2:0] !== (`SOC_TOP.D2A_CH1_WE1_ROUT_SEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_WE1_ROUT_SEL not match!");
end
if(ana_reg_expd[2][5:3] !== (`SOC_TOP.D2A_CH1_WE1_VGAIN_SEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_WE1_VGAIN_SEL not match!");
end
if(ana_reg_expd[3][0] !== (`SOC_TOP.D2A_CH1_WE2_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_WE2_EN not match!");
end
if(ana_reg_expd[3][1] !== (`SOC_TOP.D2A_CH1_WE2_DDA_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_WE2_DDA_EN not match!");
end
if(ana_reg_expd[3][5:2] !== (`SOC_TOP.D2A_CH1_WE2_RFB_SEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_WE2_RFB_SEL not match!");
end
if(ana_reg_expd[4][2:0] !== (`SOC_TOP.D2A_CH1_WE2_ROUT_SEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_WE2_ROUT_SEL not match!");
end
if(ana_reg_expd[4][5:3] !== (`SOC_TOP.D2A_CH1_WE2_VGAIN_SEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_WE2_VGAIN_SEL not match!");
end
if(ana_reg_expd[5][0] !== (`SOC_TOP.D2A_CH1_RCE_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_RCE_EN not match!");
end
if(ana_reg_expd[5][3:1] !== (`SOC_TOP.D2A_CH1_CE_ROUT_SEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_CE_ROUT_SEL not match!");
end
if(ana_reg_expd[6][0] !== (`SOC_TOP.D2A_CH1_WE_DAC_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_WE_DAC_EN not match!");
end
if({ana_reg_expd[8],ana_reg_expd[7]} !== (`SOC_TOP.D2A_CH1_DINWE)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_DINWE not match!");
end
if(ana_reg_expd[9][0] !== (`SOC_TOP.D2A_CH1_RCE_DAC_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_RCE_DAC_EN not match!");
end
if({ana_reg_expd[11],ana_reg_expd[10]} !== (`SOC_TOP.D2A_CH1_DINRCE)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_CH1_DINRCE not match!");
end*/
/*end
else if(chno==1) begin
if(ana_reg_expd[12][0] !== (`ANA_TOP.CH2_WE1_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_WE1_EN not match!");
end
if(ana_reg_expd[12][1] !== (`ANA_TOP.CH2_WE1_DDA_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_WE1_DDA_EN not match!");
end
if(ana_reg_expd[12][5:2] !== (`ANA_TOP.CH2_WE1_RFB_SEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_WE1_RFB_SEL not match!");
end
if(ana_reg_expd[13][2:0] !== (`ANA_TOP.CH2_WE1_ROUT_SEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_WE1_ROUT_SEL not match!");
end
if(ana_reg_expd[13][5:3] !== (`ANA_TOP.CH2_WE1_VGAIN_SEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_WE1_VGAIN_SEL not match!");
end
if(ana_reg_expd[14][0] !== (`ANA_TOP.CH2_WE2_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_WE2_EN not match!");
end
if(ana_reg_expd[14][1] !== (`ANA_TOP.CH2_WE2_DDA_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_WE2_DDA_EN not match!");
end
if(ana_reg_expd[14][5:2] !== (`ANA_TOP.CH2_WE2_RFB_SEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_WE2_RFB_SEL not match!");
end
if(ana_reg_expd[15][2:0] !== (`ANA_TOP.CH2_WE2_ROUT_SEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_WE2_ROUT_SEL not match!");
end
if(ana_reg_expd[15][5:3] !== (`ANA_TOP.CH2_WE2_VGAIN_SEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_WE2_VGAIN_SEL not match!");
end
if(ana_reg_expd[16][0] !== (`ANA_TOP.CH2_RCE_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_RCE_EN not match!");
end
if(ana_reg_expd[16][3:1] !== (`ANA_TOP.CH2_CE_ROUT_SEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_CE_ROUT_SEL not match!");
end
if(ana_reg_expd[17][0] !== (`ANA_TOP.CH2_WE_DAC_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_WE_DAC_EN not match!");
end
if({ana_reg_expd[19],ana_reg_expd[18]} !== (`ANA_TOP.CH2_DINWE)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_DINWE not match!");
end
if(ana_reg_expd[20][0] !== (`ANA_TOP.CH2_RCE_DAC_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_RCE_DAC_EN not match!");
end
if({ana_reg_expd[22],ana_reg_expd[21]} !== (`ANA_TOP.CH2_DINRCE)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!CH2_DINRCE not match!");
end
end*/
/*if(ana_reg_expd[12][0] !== (`SOC_TOP.D2A_BG_BUF_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_BG_BUF_EN not match!");
end
if(ana_reg_expd[12][1] !== (`SOC_TOP.D2A_DAC_BUF_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_DAC_BUF_EN not match!");
end
if(ana_reg_expd[14][0] !== (`SOC_TOP.D2A_DDA_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_DDA_EN not match!");
end
if(ana_reg_expd[14][3:1] !== (`SOC_TOP.D2A_DDA_GSEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_DDA_GSEL not match!");
end
if(ana_reg_expd[15][0] !== (`SOC_TOP.D2A_ELE_BUF_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ELE_BUF_EN not match!");
end
if(ana_reg_expd[15][3:1] !== (`SOC_TOP.D2A_ELE_BUF_SEL)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!D2A_ELE_BUF_ISEL not match!");
end
if(ana_reg_expd[27][0] !== (`ANA_TOP.R2R_DAC1_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!R2R_DAC1_EN not match!");
end
if({ana_reg_expd[29],ana_reg_expd[28]} !== (`ANA_TOP.R2R_DAC1_DIN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!R2R_DAC1_DIN not match!");
end
if(ana_reg_expd[30][0] !== (`ANA_TOP.R2R_DAC2_EN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!R2R_DAC2_EN not match!");
end
if({ana_reg_expd[32],ana_reg_expd[31]} !== (`ANA_TOP.R2R_DAC2_DIN)) begin
	
	`uvm_error("SOC_TEST", "\tERROR!!!R2R_DAC2_DIN not match!");
end*/
end
endtask:check_no_leakage


endclass : `TESTNAME
