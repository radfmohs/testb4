/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_ppg_controller_test.sv                                                   
// Project	: Nanochap BMS3P1                                  		        
// Description	: Testcase soc_ppg_controller_test                                             
// Designer	: ddang@nanochap.com                                                                 
// Date		: 13-03-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_ppg_controller_test
`define TESTCFG soc_ppg_controller_test_cfg

class `TESTCFG extends nnc_object;

    `nnc_object_utils(`TESTCFG)
  // ===============================================
  // Adding your new varialbles in config test
  // -----------------------------------------------

    rand logic [7:0] wr_data[256];
    rand logic [7:0] expected_data;
    logic      [7:0] rd_data[];
    rand bit   [7:0] delay;
    bit        [2:0] state;
    randc logic [3:0]   freq_ctrl;  // LED flashing period: 0 : 10ms; 1: 20ms
    randc logic         IDAC_LEDSEL;// 0 : idrg1 ; 1: idrg2;
    randc logic         sig_sel;    // 0 : FSM OFF 1: FSM ON
    randc logic [2:0]   mode_sel;   // 0  1  2  3  4  5  6  7 //value
    randc logic [3:0]   on_time_sel;  
    randc logic [3:0]   TIA_GAIN[2];
    randc logic [7:0]   TIA_IDAC[2];

    rand  logic [7:0]  ppg_reg_ctrl0 ;
    rand  logic [7:0]  ppg_reg_ctrl1 ;
    rand  logic [7:0]  ppg_tia_gain ;
    rand  logic [7:0]  ppg_led_time_sel ;
    rand  logic [7:0]  ppg_led_freq_sel ;
    rand  logic        EN_PPG_AF           ;
    rand  logic        EN_PPG_BUFFER       ;
    rand  logic        EN_PPGDAC_BUFFER    ;
    rand  logic        EN_PPG_SH           ;
    rand  logic        EN_TIA              ;
    //rand  logic        TIA_GAIN            ;
    rand  logic        EN_TIA_BUFFER       ;
    //rand  logic        TIA_IDAC            ;
    rand  logic        PPG_SH_CK           ;
    rand  logic        LED_STANDBY         ;
    rand  logic        LED_EN              ;
    rand  logic [1:0]  LEDSEL[2]              ;
    rand  logic        LED_STATUS          ;    
    rand  logic        D2A_LEDDAC_SEL      ;    

    rand  logic [7:0]  ana_ppg_led_sel;
    rand  logic [7:0]  ana_ppg_led_en_reg;   
    rand  logic [7:0]  ana_ppg_ctrl_reg;

    rand  logic        sync_en      ;


  // -----------------------------------------------
  // End of decalration of new variables 
  // ===============================================

  //function new (string name = "soc_ppg_controller_test_cfg");
  //  super.new(name);
  //endfunction: new

  // ===============================================
  // Adding constraints of randomization
  // -----------------------------------------------

    // Selecting Mux0/1
    // constraint c_sig_sel { soft sig_sel inside {0, 1}; }

    // Mux0 is enabled 
     constraint c_ppg_reg_ctrl0       { ppg_reg_ctrl0         == TIA_IDAC[0];} // Using for Flash BIST
     constraint c_ppg_reg_ctrl1       { ppg_reg_ctrl1[5:0]    == {sync_en, mode_sel, IDAC_LEDSEL, sig_sel};}
     constraint c_ppg_tia_gain        { ppg_tia_gain[3:0]     == TIA_GAIN[0];} 
     constraint c_ppg_led_time_sel    { ppg_led_time_sel[3:0] == on_time_sel;}
     constraint c_ppg_led_freq_sel    { ppg_led_freq_sel[3:0] == freq_ctrl;}
     constraint c_delay {  delay > 100; }

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
    integer		error; 
    logic [7:0] 	mask;
    logic [7:0] 	pads;  
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
    uvm_top.set_timeout(100s);
    top_test_cfg = `TESTCFG::type_id::create("top_test_cfg",   this);
  endfunction

  // -----------------------------------------
  // Declare the pre_reset_phase task 
  // -----------------------------------------
  virtual task pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);

    super.pre_reset_phase(phase);

    assert(top_test_cfg.randomize());

    //`DUT_IF.pclk_sel = top_test_cfg.pclk_sel;
    //`DUT_IF.freq_ctrl = top_test_cfg.freq_ctrl;    // LED flashing period: 0 : 10ms; 1: 20ms
    //`DUT_IF.IDAC_LEDSEL = top_test_cfg.IDAC_LEDSEL;// 0 : idrg1 ; 1: idrg2;
    //`DUT_IF.sig_sel = top_test_cfg.sig_sel;        // 0 : FSM OFF 1: FSM ON
    //`DUT_IF.mode_sel = top_test_cfg.mode_sel;      // 0  1  2  3  4  5  6  7 //value
    //`DUT_IF.LED1SEL = top_test_cfg.LED1SEL;
    //`DUT_IF.LED2SEL = top_test_cfg.LED2SEL;

    `ANALOG_SCOREBOARD_EN = 1'b0;
    // -------------------
    // Scoreboard enables
    // -------------------
    // `CLKRST_SCOREBOARD_EN = 1;

    phase.drop_objection(this);
  endtask : pre_reset_phase

  // -----------------------------------------
  // Declare the main_phase task of your test
  // -----------------------------------------

  virtual task main_phase(nnc_phase phase);
    phase.raise_objection(this);
    super.main_phase(phase);
    force `ANA_TOP.u_ext_hfosc.ext_hfosc_jitter = 0;
    force `ANA_TOP.OSC.hfosc_jitter = 0;
    #1us;
    wait(`RESETN);

    // Run 256Khz
    $display("===========================================");
    do_run(top_test_cfg);
    #20us;
    phase.drop_objection(this);
  endtask



  task do_run(`TESTCFG top_test_cfg);

    $display("SOC_TEST   soc_ppg_controller_test start   UVM_LOW");

    `WR_NORMAL_REG(`SOC_PMU_REG0, 8'b0010_0001, pads);
    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    `PPG_SCOREBOARD_EN = 0;
    repeat (10) begin

    // --------------------------------------------------------
    // This is MUX0  //sig_sel = 0;
    // --------------------------------------------------------
    repeat (1) begin
        `WR_NORMAL_REG(`SOC_PMU_REG0, 8'b0000_0001, pads);
        `PPG_SCOREBOARD_EN = 1;
        assert(top_test_cfg.randomize() with {sig_sel == 1'b0; IDAC_LEDSEL == 1'b0; sync_en == soc_top_tb.ppg_vif.sync_en;});
        `uvm_info("SOC_TEST",   "Enable MUX0 for testing",   UVM_LOW);
        //`ENABLE_MUX0();
        mux0(top_test_cfg);
        `WR_NORMAL_REG(`SOC_PMU_REG0, 8'b0010_0001, pads);
        `PPG_SCOREBOARD_EN = 0;
        #200us;
    end 
    #10000ns;


    // --------------------------------------------------------
    // This is MUX1 //sig_sel = 1; fsm_spi_sel = 1;
    // --------------------------------------------------------
    //    assert(top_test_cfg.randomize() with {sig_sel == 1'b0; IDAC_LEDSEL == 1'b0;/* TIA_IDAC == 8'h00; LED1SEL == 2'b0; LED2SEL == 2'b0; */ });
    //    $display("SOC_TEST   Enable MUX0 for testing   UVM_LOW");
    //    //`ENABLE_MUX0();
    //    mux0(top_test_cfg);

    //baf4p1_top_tb.iopad_resetn = 1;

    #20us;
    `WR_NORMAL_REG(`SOC_PMU_REG0, 8'b0000_0001, pads);
    `PPG_SCOREBOARD_EN = 1;
    //assert(top_test_cfg.randomize() with {sig_sel == 1'b1; IDAC_LEDSEL == 1'b1; /* TIA_IDAC == 8'h00; mode_sel == 3'b0; IDAC_LEDSEL == 1'b1; freq_ctrl == 1'b0; */});
    
        $display("SOC_TEST   Enable MUX1 for testing   UVM_LOW");
        //`ENABLE_MUX1();
        mux1(top_test_cfg);
        
        #200000ns;
    //    assert(top_test_cfg.randomize() with {sig_sel == 1'b1; IDAC_LEDSEL == 1'b0; mode_sel == `DUT_IF.mode_sel; freq_ctrl == `DUT_IF.freq_ctrl;  on_time_sel == `DUT_IF.on_time_sel; });
    //    mux1(top_test_cfg);

        #(top_test_cfg.delay*(1e6));
        top_test_cfg.state++;
        if(top_test_cfg.state !== 0) 
`ifndef POSTLAYOUT_PG
          wait((`PPG_TOP.u_ppg_fsm.cur_state === top_test_cfg.state));
`else
          wait(({`PPG_TOP.u_ppg_fsm.cur_state_reg_2_.Q, `PPG_TOP.u_ppg_fsm.cur_state_reg_1_.Q, `PPG_TOP.u_ppg_fsm.cur_state_reg_0_.Q} === top_test_cfg.state)); 
`endif
        #100ns;    
        assert(top_test_cfg.randomize() with {sig_sel == 1'b0; IDAC_LEDSEL == 1'b0; sync_en == soc_top_tb.ppg_vif.sync_en;});
        `WR_NORMAL_REG(`SOC_PPG_CTRL_1_REG, top_test_cfg.ppg_reg_ctrl1, pads);
        `WR_NORMAL_REG(`SOC_PMU_REG0, 8'b0010_0001, pads);
        `PPG_SCOREBOARD_EN = 0;
        #100us;
    // --------------------------------------------------------
    // This is MUX2  //sig_sel = 1; fsm_spi_sel = 0;  
    // --------------------------------------------------------
    //baf4p1_top_tb.iopad_resetn = 0;
    //repeat (100) begin
    //    assert(top_test_cfg.randomize() with {sig_sel == 1'b1;  });
    //    $display("SOC_TEST   Enable MUX0 for testing   UVM_LOW");
    //    //`ENABLE_MUX0();
    //    mux0(top_test_cfg);
    //    #200us;
    //end 

    end
    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    #10000ns;
    $display("SOC_TEST   soc_ppg_controller_test end now   UVM_LOW");

    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ==================================================================================

  endtask: do_run

task mux0(`TESTCFG cfg);
  `WR_NORMAL_REG(`SOC_PPG_CTRL_1_REG, cfg.ppg_reg_ctrl1, pads);
  repeat(5) begin
  fork
    begin
      `WR_NORMAL_REG(`SOC_ANA_PPG_TIA_GAIN, cfg.TIA_GAIN[0], pads);
      `WR_NORMAL_REG(`SOC_ANA_PPG_TIA_IDAC, cfg.TIA_IDAC[0], pads);    
      `WR_NORMAL_REG(`SOC_ANA_PPG_LED_SEL, {5'h1f, cfg.LEDSEL[0], 1'b1}, pads);
      `WR_NORMAL_REG(`SOC_ANA_PPG_LED_EN,{2'b11, 6'b111111},pads);
      #20us;
      `WR_NORMAL_REG(`SOC_ANA_PPG_CTRL,{5'h1f, 3'b111},pads);
      get_on_time(cfg.on_time_sel);
      `WR_NORMAL_REG(`SOC_ANA_PPG_CTRL,{5'h1f, 3'b110},pads);
      #4us;
      `WR_NORMAL_REG(`SOC_ANA_PPG_LED_EN,{2'b11, 6'b111110},pads);
      `WR_NORMAL_REG(`SOC_ANA_PPG_CTRL,{5'h1f, 3'b000},pads);
    end
    get_freq(cfg.freq_ctrl); 
  join
  fork
    begin
      `WR_NORMAL_REG(`SOC_ANA_PPG_TIA_GAIN, cfg.TIA_GAIN[1], pads);
      `WR_NORMAL_REG(`SOC_ANA_PPG_TIA_IDAC, cfg.TIA_IDAC[1], pads);    
      `WR_NORMAL_REG(`SOC_ANA_PPG_LED_SEL, {5'h1f, cfg.LEDSEL[1], 1'b0}, pads);
      `WR_NORMAL_REG(`SOC_ANA_PPG_LED_EN,{2'b11, 6'b111111},pads);
      #20us;
      `WR_NORMAL_REG(`SOC_ANA_PPG_CTRL,{5'h1f, 3'b111},pads);
      get_on_time(cfg.on_time_sel);
      `WR_NORMAL_REG(`SOC_ANA_PPG_CTRL,{5'h1f, 3'b110},pads);
      #4us;
      `WR_NORMAL_REG(`SOC_ANA_PPG_LED_EN,{2'b11, 6'b111110},pads);
      `WR_NORMAL_REG(`SOC_ANA_PPG_CTRL,{5'h1f, 3'b000},pads);
    end
    get_freq(cfg.freq_ctrl); 
  join
  end
endtask

task mux1(`TESTCFG cfg);
  begin
    assert(cfg.randomize() with {sig_sel == 1'b0; IDAC_LEDSEL == 1'b0; });
    `WR_NORMAL_REG(`SOC_ANA_PPG_TIA_IDAC, cfg.ppg_reg_ctrl0, pads);
    `WR_NORMAL_REG(`SOC_ANA_PPG_TIA_GAIN, cfg.ppg_tia_gain, pads);
    `WR_NORMAL_REG(`SOC_PPG_LED_TIME_SEL, cfg.ppg_led_time_sel, pads);    
    `WR_NORMAL_REG(`SOC_PPG_LED_FREQ_SEL, cfg.ppg_led_freq_sel, pads);
    assert(cfg.randomize() with {sig_sel == 1'b0; IDAC_LEDSEL == 1'b1; sync_en == soc_top_tb.ppg_vif.sync_en;});
    `WR_NORMAL_REG(`SOC_PPG_CTRL_1_REG, cfg.ppg_reg_ctrl1, pads);
    `WR_NORMAL_REG(`SOC_ANA_PPG_TIA_GAIN, cfg.ppg_reg_ctrl0, pads);
    `WR_NORMAL_REG(`SOC_ANA_PPG_TIA_GAIN, cfg.ppg_tia_gain, pads);
    assert(cfg.randomize() with {sig_sel == 1'b1; IDAC_LEDSEL == 1'b0; });
    `WR_NORMAL_REG(`SOC_PPG_CTRL_1_REG, cfg.ppg_reg_ctrl1, pads);
  end
endtask

task get_freq(bit [3:0] freq_ctrl);
   case(freq_ctrl)
   4'b0000:  #10ms;
   4'b0001:  #12ms;
   4'b0010:  #14ms;
   4'b0011:  #16ms;
   4'b0100:  #18ms;
   4'b0101:  #20ms;
   4'b0110:  #22ms;
   4'b0111:  #24ms;
   4'b1000:  #26ms;
   4'b1001:  #28ms;
   4'b1010:  #30ms;
   4'b1011:  #32ms;
   4'b1100:  #34ms;
   4'b1101:  #36ms;
   4'b1110:  #38ms;
   4'b1111:  #40ms;
   default:  #10ms;
   endcase
endtask

task get_on_time(bit[3:0] on_time_sel);
    case(on_time_sel)
    4'b0000:  #((125-4)*1e3);
    4'b0001:  #((150-4)*1e3);
    4'b0010:  #((175-4)*1e3);
    4'b0011:  #((200-4)*1e3);
    4'b0100:  #((225-4)*1e3);
    4'b0101:  #((250-4)*1e3);
    4'b0110:  #((275-4)*1e3);
    4'b0111:  #((300-4)*1e3);
    4'b1000:  #((325-4)*1e3);
    4'b1001:  #((350-4)*1e3);
    4'b1010:  #((375-4)*1e3);
    4'b1011:  #((400-4)*1e3);
    4'b1100:  #((425-4)*1e3);
    4'b1101:  #((450-4)*1e3);
    4'b1110:  #((475-4)*1e3);
    4'b1111:  #((500-4)*1e3);
    default:  #((125-4)*1e3);
    endcase
endtask

  // ------------------------------
  // Declare the report_phase task
  // ------------------------------
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction



endclass


