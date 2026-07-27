/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_analog_register_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_analog_register_test                                             
// Designer	: pfwang@nanochap.com                                                                 
// Date		: 04-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_analog_register_test
`define TESTCFG soc_analog_register_test_cfg

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

  function new (string name = "soc_analog_register_test_cfg");
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

    logic [7:0] mask;
    logic [7:0] pad;
    logic [7:0] no_of_bytes;
    logic [7:0] rd_data_reg[];
    //------------------------------------------------------------------------------
    //---------------------------- ANALOG ---------------------------------------------
    logic [7:0] ana_buffer = 0;
    logic [7:0] ana_ecg_ctrl1 = 8'b11;
    logic [7:0] ana_ecg_ctrl2 = 8'b100;
    logic [7:0] ana_dc_lead_off_ctrl = 8'b10000000;
    logic [7:0] ana_tsc = 0;
    logic [7:0] ana_tsc_1 = 0;
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
    logic [7:0] ana_zmeas_adcen;
    logic [7:0] ana_dc_clk_div;
    logic [1:0] chno;
    bit   [7:0] wdata;
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

    `nnc_info("SOC_TEST", "soc_analog_register_test start", UVM_LOW)

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
   // // Part III: Checking the W/R values of all of normal registers by using WR_RD_CHK_NORMAL_REG
   // // --------------------------------------------------------
   // `nnc_info("SOC_TEST - PART II", "STARTING TO CHECK THE R/W OF NORMAL REGISTERS", UVM_LOW)
   // assert(top_test_cfg.randomize() with {reg_addr == `SOC_FIFO_WR_PTR_REG; mask == 8'hff;});
   // `WR_RD_CHK_NORMAL_REG(top_test_cfg.reg_addr, top_test_cfg.data[0], top_test_cfg.pads, top_test_cfg.mask);

    $display($time,"\tSimulation Begin!!!\n");
    $display($time,"\tAnalog Control Register test\n");
    #1us;
    wait(`RESETN);
    fork:ana_checker_
    ana_checker;
    join_none
    // Run 256Khz
    $display("===========================================");
    //$display("TEST1 - running in SPI = 256 Khz");
    //force `SPI_CLK_GEN.spi_clk_gen_sel[1:0] = 2'b00;
    do_run;

    //$display("===========================================");
    //$display("TEST2 - running in SPI = 1Mhz");
    //// Run 1Mhz 
    //force `SPI_CLK_GEN.spi_clk_gen_sel[1:0] = 2'b01;
    //do_run;

    //$display("===========================================");
    //$display("TEST3 - running in SPI = 500Khz");
    //// Run 500Khz
    //force `SPI_CLK_GEN.spi_clk_gen_sel[1:0] = 2'b10;
    //do_run;

    //$display("===========================================");
    //$display("TEST4 - running in SPI = 333Khz");
    //// Run 333Khz
    //force `SPI_CLK_GEN.spi_clk_gen_sel[1:0] = 2'b11;
    //do_run;

    #20us;
    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    #10000ns;
    `nnc_info("SOC_TEST", "soc_analog_register_test end now", UVM_LOW)
    disable ana_checker_;
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
   
       pad= 8'h00;
       mask= 8'hFF;
       //err_cnt = 0;

    reg_test("ANA_BUFFER          ", `SOC_ANA_BUFFER          , 8'b0001_1111, ana_buffer          , 1);
    reg_test("ANA_ECG_CTRL_1      ", `SOC_ANA_ECG_CTRL1      , 8'b1111_1111, ana_ecg_ctrl1       , 1);
    reg_test("ANA_ECG_CTRL_2      ", `SOC_ANA_ECG_CTRL2      , 8'b0111_1111, ana_ecg_ctrl2       , 1);
    reg_test("ANA_DC_LEAD_OFF_CTRL", `SOC_ANA_LEAD_OFF      , 8'b0000_0011, ana_dc_lead_off_ctrl, 1);
    reg_test("ANA_TSC             ", `SOC_ANA_TSC             , 8'b1111_1111, ana_tsc             , );
    reg_test("ANA_TSC_1           ", `SOC_ANA_TSC_1         , 8'b0000_0001,   ana_tsc_1             , );
    reg_test("ANA_PPG_LED_SEL     ", `SOC_ANA_PPG_LED_SEL , 8'b0000_0111,  ana_ppg_led_sel    , );

    reg_test("ANA_PPG_DAC0_CTRL_REG0", `SOC_ANA_PPG_DAC0_CTRL_REG0, 8'b1111_1111, ana_ppg_dac0_ctrl_reg0, );
    reg_test("ANA_PPG_DAC0_CTRL_REG1", `SOC_ANA_PPG_DAC0_CTRL_REG1, 8'b0001_1111, ana_ppg_dac0_ctrl_reg1, );
    reg_test("ANA_PPG_DAC1_CTRL_REG0", `SOC_ANA_PPG_DAC1_CTRL_REG0, 8'b1111_1111, ana_ppg_dac1_ctrl_reg0, );
    
    reg_test("ANA_PPG_DAC1_CTRL_REG1", `SOC_ANA_PPG_DAC1_CTRL_REG1, 8'b0001_1111, ana_ppg_dac1_ctrl_reg1, );
    reg_test("ANA_PPG_TIA_IDAC"   , `SOC_ANA_PPG_TIA_IDAC  , 8'b1111_1111, ana_ppg_tia_idac  , );
    reg_test("ANA_PPG_TIA_GAIN"   , `SOC_ANA_PPG_TIA_GAIN  , 8'b0000_1111, ana_ppg_tia_gain  , );
    reg_test("ANA_PPG_TEST_REG"   , `SOC_ANA_PPG_TEST  , 8'b0011_1111, ana_ppg_test_reg  , );
    reg_test("ANA_PPG_LED_EN_REG ", `SOC_ANA_PPG_LED_EN, 8'b0011_1111, ana_ppg_led_en_reg, );
    reg_test("ANA_PPG_CTRL_REG  " , `SOC_ANA_PPG_CTRL  , 8'b0000_0111, ana_ppg_ctrl_reg  , );  
    reg_test("ANA_BIST          " , `SOC_ANA_BIST          , 8'b0000_1111, ana_bist          , 1);
    reg_test("ANA_SDM           " , `SOC_ANA_SDM       , 8'b0000_0111, ana_sdm_reg       , );
    reg_test("ANA_LEAD_OFF_EN           " , `SOC_ANA_LEAD_OFF_EN       , 8'b0000_0011,  ana_lead_off_en      , 1);

  end
endtask

task ana_checker;
while (1) begin
 @ (ana_buffer,
ana_ecg_ctrl1,
ana_ecg_ctrl2,
ana_dc_lead_off_ctrl,
ana_tsc,
ana_tsc_1,
ana_ppg_led_sel,
ana_ppg_dac0_ctrl_reg0,
ana_ppg_dac0_ctrl_reg1,
ana_ppg_dac1_ctrl_reg0,
ana_ppg_dac1_ctrl_reg1,
ana_ppg_tia_idac,
ana_ppg_tia_gain,
ana_ppg_test_reg,
ana_ppg_led_en_reg,
ana_ppg_ctrl_reg,        
ana_sdm_reg,
ana_bist,
ana_lead_off_en)
#1;
//compare_data(ana_buffer[4]              ,   `ANA_TOP.D2A_2ELECTRODE_EN                ,"D2A_2ELECTRODE_EN             " );
//compare_data(ana_buffer[3]              ,   `ANA_TOP.D2A_RLD_CHOP_EN                  ,"D2A_RLD_CHOP_EN             " );
compare_data(ana_buffer[2]              ,   `ANA_TOP.D2A_RLD_EN                       ,"RLD_EN             " );                 
compare_data(ana_buffer[0]              ,   `ANA_TOP.D2A_VCM1P5_BUF_EN                ,"VCM1P5_BUF_EN          " );                
compare_data(ana_buffer[1]              ,   `ANA_TOP.D2A_BG1P2_BUF_EN                 ,"BG1P2_BUF_EN           " );                
                                                                                                                         
compare_data(ana_ecg_ctrl1[0]           ,   `ANA_TOP.D2A_ECG_PGA_EN                   ,"ECG_PGA_EN             " );                
compare_data(ana_ecg_ctrl1[1]           ,   `ANA_TOP.D2A_ECG_LPF_EN                   ,"ECG_LPF_EN             " );                
compare_data(ana_ecg_ctrl1[4:2]         ,   `ANA_TOP.D2A_ECG_PGA_GSEL                 ,"ECG_PGA_GSEL           " );                
compare_data(ana_ecg_ctrl1[7:5]         ,   `ANA_TOP.D2A_ECG_DDA_GSEL                 ,"ECG_DDA_GSEL           " );
                                                                                                                        

//compare_data(ana_ecg_ctrl2[6]           ,   `ANA_TOP.D2A_ECGCAL_EN                    ,"D2A_ECGCAL_EN           " );  
compare_data(ana_ecg_ctrl2[5:4]         ,   `ANA_TOP.D2A_ECG_DDA_ISEL                 ,"ECG_DDA_ISEL           " );                
compare_data(ana_ecg_ctrl2[3]           ,   `ANA_TOP.D2A_ECG_DDACHOP_EN              ,"ECG_DDA_CHOP_EN        " );                
compare_data(ana_ecg_ctrl2[2],              `ANA_TOP.D2A_ECG_DDA_EN                   ,"ECG_DDA_EN             " );                
compare_data(ana_ecg_ctrl2[1:0]         ,   `ANA_TOP.D2A_ECG_DDA_CLKSEL               ,"ECG_DDA_CLKSEL         " );                
                                                                                                                         
compare_data(ana_dc_lead_off_ctrl[0],       `ANA_TOP.D2A_DCLEADOFF_RMODE_EN         ,"DC_LEAD_OFF_RMODE_EN   " );                
compare_data(ana_dc_lead_off_ctrl[1],       `ANA_TOP.D2A_DCLEADOFF_VINFLIP         ,"DC_LEAD_OFF_VIN_FLIP   " );                
//compare_data(ana_dc_lead_off_ctrl[3:2],     `ANA_TOP.D2A_DCLEADOFF_ISEL             ,"DC_LEAD_OFF_ISEL       " );                
//compare_data(ana_dc_lead_off_ctrl[6:4],     `ANA_TOP.D2A_DCLEADOFF_COMP_TH       ,"DC_LEAD_OFF_CHOP_TH_EN " );                
//compare_data(ana_dc_lead_off_ctrl[7],       `ANA_TOP.D2A_DCLEADOFF_EN               ,"DC_LEAD_OFF_EN         " );                
                                                                                                                         
compare_data(ana_tsc[0],                    `ANA_TOP.D2A_TSC_OUT_SEL                  ,"TSC_OUT_SEL            " );                
compare_data(ana_tsc[3:1],                  `ANA_TOP.D2A_TSC_BJT_SEL                  ,"TSC_BJT_SEL            " );                
compare_data(ana_tsc[4],                    `ANA_TOP.D2A_TSC_EN                       ,"TSC_EN                 " );                
compare_data(ana_tsc[7:5],                  `ANA_TOP.D2A_TSC_INA_GSEL                 ,"TSC_INA_GSEL            " );                
                                                                                                                         
compare_data(ana_tsc_1[0],                  `ANA_TOP.D2A_TSC_INA_EN                   ,"D2A_TSC_INA_EN          " );                                                                                                                         
compare_data(ana_ppg_led_sel[0],            `ANA_TOP.D2A_LEDDAC_SEL              ,"PPG_LED_DAC_SEL        " );                
compare_data(ana_ppg_led_sel[2:1],          `ANA_TOP.D2A_LEDSEL                  ,"PPG_LED_SEL            " );                

compare_data(ana_ppg_dac0_ctrl_reg0[7:0],   `ANA_TOP.D2A_PPGDAC0_VSEL[7:0]           ,"PPG_DAC0_VSEL[7:0]     " );                
                                                                                                                        
compare_data(ana_ppg_dac0_ctrl_reg1[3:0],   `ANA_TOP.D2A_PPGDAC0_VSEL[11:8]          ,"PPG_DAC0_VSEL[11:8]    " );                
compare_data(ana_ppg_dac0_ctrl_reg1[4],     `ANA_TOP.D2A_PPGDAC0_EN                  ,"PPG_DAC0_EN            " );                
                                                                                               
compare_data(ana_ppg_dac1_ctrl_reg0[7:0],   `ANA_TOP.D2A_PPGDAC1_VSEL[7:0]           ,"PPG_DAC1_VSEL[7:0]     " );                
                                                                                           
compare_data(ana_ppg_dac1_ctrl_reg1[3:0],   `ANA_TOP.D2A_PPGDAC1_VSEL[11:8]          ,"PPG_DAC1_VSEL[11:8]    " );                
compare_data(ana_ppg_dac1_ctrl_reg1[4],     `ANA_TOP.D2A_PPGDAC1_EN                  ,"PPG_DAC1_EN            " );                
                                                                                            
compare_data(ana_ppg_tia_idac[7:0],         `ANA_TOP.D2A_TIA_IDAC                 ,"PPG_TIA_IDAC           " );                
                                                                                                  
compare_data(ana_ppg_tia_gain[3:0],         `ANA_TOP.D2A_TIA_GAIN                 ,"PPG_TIA_GAIN           " );                
                                                                                           
compare_data(ana_ppg_test_reg[1:0],         `ANA_TOP.D2A_PPG_TEST_OUT                 ,"PPG_TEST_OUT           " );                
compare_data(ana_ppg_test_reg[3:2],         `ANA_TOP.D2A_PPG_TEST_IN                  ,"PPG_TEST_IN            " );                
compare_data(ana_ppg_test_reg[5:4],         `ANA_TOP.D2A_PDVREF_SEL              ,"PPG_PDV_REF_SEL        " );                                                                                                

compare_data(ana_ppg_led_en_reg[0],         `ANA_TOP.D2A_LED_STANDBYEN            ,"PPG_LED_STANDBYEN      " );                
compare_data(ana_ppg_led_en_reg[1],         `ANA_TOP.D2A_EN_PPG_AF                    ,"PPG_AF_EN              " );                
compare_data(ana_ppg_led_en_reg[2],         `ANA_TOP.D2A_EN_PPG_SH                    ,"PPG_SH_EN              " );                
compare_data(ana_ppg_led_en_reg[3],         `ANA_TOP.D2A_EN_PPG_BUFFER                ,"PPG_BUFFER_EN          " );                
compare_data(ana_ppg_led_en_reg[4],         `ANA_TOP.D2A_EN_TIA_VREFBUFFER       ,"PPG_TIA_VREF_BUFFER_EN " );                
compare_data(ana_ppg_led_en_reg[5],         `ANA_TOP.D2A_EN_PPGDAC_BUFFER            ,"PPG_DAC_BUFFER_EN      " );                                    
                                                                                              
compare_data(ana_ppg_ctrl_reg[0],           `ANA_TOP.D2A_PPG_SH_CK                    ,"PPG_SH_CK              " );                
compare_data(ana_ppg_ctrl_reg[1],           `ANA_TOP.D2A_EN_TIA                   ,"PPG_TIA_EN             " );                
compare_data(ana_ppg_ctrl_reg[2],           `ANA_TOP.D2A_LED_EN                   ,"PPG_LED_EN             " );
//                                                                                             
compare_data(ana_bist[2:0],                 `ANA_TOP.D2A_BIST_ISEL                    ,"BIST_ISEL              " );                
compare_data(ana_bist[3],                   `ANA_TOP.D2A_BIST_EN                      ,"BIST_EN                " );                

compare_data(ana_sdm_reg[1:0],              `ANA_TOP.D2A_SDM_BIAS                     ,"SDM_BIAS              " );                
compare_data(ana_sdm_reg[2],                `ANA_TOP.D2A_SDM_EN                       ,"SDM_EN                " );

compare_data(ana_lead_off_en[1:0],          {`ANA_TOP.D2A_ACLEADOFF_EN, `ANA_TOP.D2A_DCLEADOFF_EN}               ,"D2A_LEADOFF_EN"     );
//compare_data(ana_sdm_reg[3],                `ANA_TOP.D2A_SDM_CLK                     ,"SDM_CLK              " );                
//compare_data(ana_sdm_reg[6:4],              `ANA_TOP.D2A_SDM_VIN_SEL                   ,"SDM_VIN_SEL                " );
end
endtask


task reg_test(string reg_name="", bit[7:0] reg_add, bit_sel,ref reg [7:0] rdata, input bit ao=0);
       `uvm_info("", $sformatf("\t****** Test %s register ******\n",reg_name), UVM_LOW);
    ////------------- to write in to the * reg--------------//
       wdata = $random;
       `WR_NORMAL_REG(reg_add, wdata, pad);
       if(ao==1) begin
       `WR_NORMAL_REG(`SOC_CLK_CTRL_REG,8'b00010000,pad);
       `WR_NORMAL_REG(`SOC_CLK_CTRL_REG,8'b10010000,pad);
       end
    ///-------------to read from the * reg-------------------//
       `RD_NORMAL_REG(reg_add,pad,rdata);

       //Check read data
       if(rdata !== (wdata & bit_sel)) begin
	  //err_cnt++;
	  `uvm_error("", $sformatf("\t[ERROR] %s read not expected!\n", reg_name));
       end

    //Clear *REG 
    ////------------- to write in to the ANA_PGA reg--------------//
       `WR_NORMAL_REG(reg_add,8'h00,pad);
       if(ao==1) begin
       `WR_NORMAL_REG(`SOC_CLK_CTRL_REG,8'b00010000,pad);
       `WR_NORMAL_REG(`SOC_CLK_CTRL_REG,8'b10010000,pad);
       end
    ///-------------to read from the ANA_PGA reg-------------------//
       `RD_NORMAL_REG(reg_add,pad,rdata);

       //Check read data
       if(rdata !== 8'h00) begin
	  //err_cnt++;
	  `uvm_error("", $sformatf("\t[ERROR] %s read not expected!\n", reg_name));
       end
endtask

task compare_data(bit [7:0] reg_rdata, ana_data, string ana_name);
if(reg_rdata !== ana_data) begin
	//err_cnt++;
	`uvm_error("", $sformatf("\tERROR!!! %s not match!", ana_name));
end
endtask


endclass : `TESTNAME
