/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_pinmux_debugmode_atm5_test.sv                                                   
// Project	: Nanochap  BAF4P1                                  		        
// Description	: Testcase soc_pinmux_debugmode_atm5_test                                             
// Designer	: zhenghong.yu@nanochap.com(zion)                                                                
// Date		: 29-11-1623                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_pinmux_debugmode_atm5_test
`define TESTCFG soc_pinmux_debugmode_atm5_test_cfg

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // -----------------------------------------------
  // Adding your new varialbles in config test
  // -----------------------------------------------
  logic [12:0]  atm;
 
  // -----------------------------------------------
  // End of decalration of new variables 
  // -----------------------------------------------

  function new (string name = "soc_pinmux_debugmode_atm5_test_cfg");
    super.new(name);
    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // testmode_sel[1:0] : 00-Normal mode, 01: Scanmode, 10: BIST mode, 11 atm0/1/2/3/4
  constraint c_testmode_sel { soft testmode_sel == 2'b11; }

  // -----------------------------------------------
  // End of adding constraints of randomization
  // -----------------------------------------------

endclass : `TESTCFG

class `TESTNAME extends soc_base_test;
  static bit rand_bit;   
  static logic [20:0] rand_num;
  logic [6:0]  D2A_BGH_CTRIM;
  logic [4:0]  D2A_BGH_VTRIM;
  logic [1:0]  D2A_LDO1V5_VTRIM;   
  `nnc_component_utils(`TESTNAME)

  `TESTCFG top_test_cfg;
  
  function new(string name, nnc_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(nnc_phase phase);
    super.build_phase(phase);
    uvm_top.set_timeout(2s);
    top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);
  endfunction

  virtual task pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);

    super.pre_reset_phase(phase);

    assert(top_test_cfg.randomize());

    `DUT_IF.testmode_sel = top_test_cfg.testmode_sel;

    `SPI_SCB_EN = 1'b0;
    `ANALOG_SCOREBOARD_EN = 1'b0;

    // ==================
    // Scoreboard enables
    // ==================

    phase.drop_objection(this);
  endtask : pre_reset_phase

  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_pinmux_debugmode_atm5_test start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    // This is sample to write a data to Register

    do_run;       
            
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

  virtual task do_run;
`ifndef PRESCAN
    begin
`ifndef FPGA
    // select TEST_MODE, PAD: TEST_MODE0=0, TEST_MODE1=1
    // Checking pin testmode
    force `SOC_TB.TESTMODE = 2'b11;
    force `SOC_TB.IOBUF_PAD[9:6] = 4'b0110;  
      
    #10000;

    top_test_cfg.atm = {`ANA_TOP.D2A_ATM0, `ANA_TOP.D2A_ATM1, `ANA_TOP.D2A_ATM2, `ANA_TOP.D2A_ATM3, `ANA_TOP.D2A_ATM4, `ANA_TOP.D2A_ATM5, `ANA_TOP.D2A_ATM6, `ANA_TOP.D2A_ATM7, `ANA_TOP.D2A_ATM8,`ANA_TOP.D2A_ATM9, `ANA_TOP.D2A_ATM10, `ANA_TOP.D2A_ATM11, `ANA_TOP.D2A_ATM12};
    // Checking ATM
    if (top_test_cfg.atm !== (13'b1_0000_0000_0000 >> `SOC_TB.IOBUF_PAD[9:6]-1))
      begin
        `nnc_error("ATM5",$sformatf("ATM[0:12] = %b is not as expectation of ATM = %b", top_test_cfg.atm, (13'b1_0000_0000_0000 >> `SOC_TB.IOBUF_PAD[9:6]-1))); 
      end

    if (`ANA_TOP.D2A_BIST_EN !== 1'b0)
      `nnc_error("ATM5",$sformatf("[ERROR] ANA_TOP.D2A_BIST_EN = %b is not as expectation 1'b0", `ANA_TOP.D2A_BIST_EN));

    if (`ANA_TOP.D2A_ECGCAL_EN !== 1'b0)
      `nnc_error("ATM5",$sformatf("[ERROR] ANA_TOP.D2A_ECGCAL_EN = %b is not as expectation 1'b0", `ANA_TOP.D2A_ECGCAL_EN));


    // Checking pin D2A_BGH_CTRIM
    for (int i=0; i < 100; i++) begin
      force {`SOC_TB.IOBUF_PAD[3],`SOC_TB.IOBUF_PAD[2],`SOC_TB.IOBUF_PAD[1],`SOC_TB.IOBUF_PAD[0],`SOC_TB.IOBUF_PAD[5],`SOC_TB.IOBUF_PAD[4],`SOC_TB.IOBUF_PAD[18]} = $random;
      D2A_BGH_CTRIM = {`SOC_TB.IOBUF_PAD[3],`SOC_TB.IOBUF_PAD[2],`SOC_TB.IOBUF_PAD[1],`SOC_TB.IOBUF_PAD[0],`SOC_TB.IOBUF_PAD[5],`SOC_TB.IOBUF_PAD[4],`SOC_TB.IOBUF_PAD[18]};                
      #50000;
      rand_num[6:0] = D2A_BGH_CTRIM;
      if (`ANA_TOP.D2A_BGH_CTRIM !== rand_num[6:0]) begin
        `nnc_error("ATM5",$sformatf("[ERROR][%d] D2A_BGH_CTRIM = %b is not as expectation of rand_num[6:0] = %b", i, `ANA_TOP.D2A_BGH_CTRIM , rand_num[6:0]));
      end
      release {`SOC_TB.IOBUF_PAD[3],`SOC_TB.IOBUF_PAD[2],`SOC_TB.IOBUF_PAD[1],`SOC_TB.IOBUF_PAD[0],`SOC_TB.IOBUF_PAD[5],`SOC_TB.IOBUF_PAD[4],`SOC_TB.IOBUF_PAD[18]};
      #10000;
    end

    // Checking pin D2A_BGH_VTRIM
    for (int i=0; i < 100; i++) begin
      force {`SOC_TB.IOBUF_PAD[14],`SOC_TB.IOBUF_PAD[13],`SOC_TB.IOBUF_PAD[12],`SOC_TB.IOBUF_PAD[11],`SOC_TB.IOBUF_PAD[10]} = $random;
      D2A_BGH_VTRIM = {`SOC_TB.IOBUF_PAD[14],`SOC_TB.IOBUF_PAD[13],`SOC_TB.IOBUF_PAD[12],`SOC_TB.IOBUF_PAD[11],`SOC_TB.IOBUF_PAD[10]};                
      #10000;
      rand_num[4:0] = D2A_BGH_VTRIM;
      D2A_BGH_VTRIM = {`SOC_TB.IOBUF_PAD[14],`SOC_TB.IOBUF_PAD[13],`SOC_TB.IOBUF_PAD[12],`SOC_TB.IOBUF_PAD[11],`SOC_TB.IOBUF_PAD[10]};          
      if (`ANA_TOP.D2A_BGH_VTRIM !== rand_num[4:0]) begin
        `nnc_error("ATM5",$sformatf("[ERROR][%d] D2A_BGH_VTRIM = %b is not as expectation of rand_num[4:0] = %b", i, `ANA_TOP.D2A_BGH_VTRIM , rand_num[4:0]));
      end
      release {`SOC_TB.IOBUF_PAD[14],`SOC_TB.IOBUF_PAD[13],`SOC_TB.IOBUF_PAD[12],`SOC_TB.IOBUF_PAD[11],`SOC_TB.IOBUF_PAD[10]};
      #10000;
    end

    // Checking pin D2A_LDO1V5_VTRIM
    for (int i=0; i < 100; i++) begin
      force {`SOC_TB.IOBUF_PAD[16],`SOC_TB.IOBUF_PAD[15]} = $random;
      D2A_LDO1V5_VTRIM = {`SOC_TB.IOBUF_PAD[16],`SOC_TB.IOBUF_PAD[15]};                
      #10000;
      rand_num[1:0] = D2A_LDO1V5_VTRIM;
      if (`ANA_TOP.D2A_LDO1V5_VTRIM !== rand_num[1:0]) begin
        `nnc_error("ATM5",$sformatf("[ERROR][%d] D2A_LDO1V5_VTRIM = %b is not as expectation of rand_num[1:0] = %b", i, `ANA_TOP.D2A_LDO1V5_VTRIM , rand_num[1:0]));
      end
      release {`SOC_TB.IOBUF_PAD[16],`SOC_TB.IOBUF_PAD[15]};
      #10000;
    end

    // Checking pin D2A_VCM1P5_BUF_EN 
    for (int i=0; i < 100; i++) begin
      force `SOC_TB.IOBUF_PAD[17] = $random;
      #10000;
      rand_bit = `SOC_TB.IOBUF_PAD[17];  
      if (`ANA_TOP.D2A_VCM1P5_BUF_EN !== rand_bit) begin
        `nnc_error("ATM9",$sformatf("[ERROR][%d] D2A_VCM1P5_BUF_EN = %b is not as expectation of rand_bit = %b", i, `ANA_TOP.D2A_VCM1P5_BUF_EN , rand_bit));
      end
      release `SOC_TB.IOBUF_PAD[17];
      #10000;
    end

// Check all this for 19 GPIOs
`ifdef POSTLAYOUT
    if(`SOC_TOP.IOBUF_PU_always_on[2:0] !== 3'h0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of `SOC_TOP.IOBUF_PU_always_on[2:0] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_PU_always_on[2:0], 3'h0));
      end
`elsif POSTSCAN
    if(`SOC_TOP.IOBUF_PU[2:0] !== 3'h7)
      begin 
        `nnc_error("ATM0",$sformatf("The value of `SOC_TOP.IOBUF_PU[2:0] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_PU[2:0], 3'h7));
      end
`else
    if(`SOC_TOP.IOBUF_PU[18:0] !== 19'h7)
      begin 
        `nnc_error("ATM0",$sformatf("The value of `SOC_TOP.IOBUF_PU[18:0] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_PU[18:0], 19'h7));
      end

    if(({`SOC_TOP.IOBUF_PD[18:0]}) !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of {`SOC_TOP.IOBUF_PD[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_PD[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OS[18:0]}) !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of {`SOC_TOP.IOBUF_OS[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OS[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OD[18:0]}) !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of {`SOC_TOP.IOBUF_OD[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OD[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_CS[18:0]}) !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of {`SOC_TOP.IOBUF_CS[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_CS[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_SR[18:0]}) !== 19'h7ffff)
      begin 
        `nnc_error("ATM0",$sformatf("The value of {`SOC_TOP.IOBUF_SR[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_SR[18:0]}, 19'h7ffff));
      end

    if(({`SOC_TOP.IOBUF_DR[18:0]}) !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of {`SOC_TOP.IOBUF_DR[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_DR[18:0]}, 19'b0));
      end
`endif

// Checking wake up = 0
   `nnc_info("ATM0","Test is entering WakeUP is disable now, checking in this mode",UVM_LOW);
   force `ANA_TOP.A2D_Wake_UP_i = 1'b0;
   #10000;

    if(({`SOC_TOP.IOBUF_IE_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_IE_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_IE_always_on[18:0]}, 19'b0));
      end

`ifdef POSTSCAN
 rand_num = {`SOC_TOP.u_iopad_gpio_18_.PU,
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
    if(rand_num !== 19'h0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of `SOC_TOP.IOBUF_PU[2:0] = %b is not equal to expected value = %b", rand_num, 19'h0));
      end
 rand_num = {`SOC_TOP.u_iopad_gpio_18_.A,
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
    if(rand_num !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_A_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
      end

 rand_num = {`SOC_TOP.u_iopad_gpio_18_.OE,
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
    if(rand_num !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OE_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
      end
`elsif POST_LAYOUT
rand_num = {`SOC_TOP.u_iopad_gpio_18_.PU,
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
    if(rand_num !== 19'h0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of `SOC_TOP.IOBUF_PU[2:0] = %b is not equal to expected value = %b", rand_num, 19'h0));
      end
 rand_num = {`SOC_TOP.u_iopad_gpio_18_.A,
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
    if(rand_num !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_A_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
      end

 rand_num = {`SOC_TOP.u_iopad_gpio_18_.OE,
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
    if(rand_num !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OE_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
      end
`else
    if(({`SOC_TOP.IOBUF_PU_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_PU_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_PU_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_A_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_A_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_A_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OE_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OE_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OE_always_on[18:0]}, 19'b0));
      end
`endif

`ifndef POSTSCAN
  `ifndef POST_LAYOUT
    if(({`SOC_TOP.IOBUF_PD_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("[ERROR][16] The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_PD_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_PD_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OS_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("[ERROR][17] The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OS_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OS_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OD_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("[ERROR][18] The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OD_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OD_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_CS_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("[ERROR][19] The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_CS_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_CS_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_SR_always_on[18:0]}) !== 19'h7ffff)
      begin 
        `nnc_error("ATM0",$sformatf("[ERROR][20] The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_SR_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_SR_always_on[18:0]}, 19'h7ffff));
      end

    if(({`SOC_TOP.IOBUF_DR_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("ATM0",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_DR_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_DR_always_on[18:0]}, 19'b0));
      end
  `endif
`endif

   release `ANA_TOP.A2D_Wake_UP_i;

#3000000; // 3ms
        	    
`endif
    end
`endif      
  endtask  

  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME

