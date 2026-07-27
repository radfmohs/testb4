/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_pinmux_bistmode_test.sv                                                   
// Project	: Nanochap ENS1P4                                  		        
// Description	: Testcase soc_pinmux_bistmode_test                                             
// Designer	: ddang@nanochap.com                                                                 
// Date		: 29-11-1623                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_pinmux_bistmode_test
`define TESTCFG soc_pinmux_bistmode_test_cfg

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // -----------------------------------------------
  // Adding your new varialbles in config test
  // -----------------------------------------------
  rand logic [7:0] data[256];
  rand int         no_of_bytes; 
  rand logic [7:0] reg_addr;
  rand logic [7:0] cmd;  
  logic [7:0] read_data[];
  logic [8:0] atm;
  
  // -----------------------------------------------
  // End of decalration of new variables 
  // -----------------------------------------------

  function new (string name = "soc_pinmux_bistmode_test_cfg");
    super.new(name);
    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // testmode_sel[1:0] : 00-Normal mode, 01: Scanmode, 10: BIST mode, 11 atm0/1/2/3/4
  constraint c_testmode_sel { soft testmode_sel == 2'b10; }
  
  // No of bytes in a burst
  constraint c_no_of_bytes { soft no_of_bytes == 2; }
  // -----------------------------------------------
  // End of adding constraints of randomization
  // -----------------------------------------------

endclass : `TESTCFG

class `TESTNAME extends soc_base_test;
    static bit rand_bit;   
    static logic [20:0] rand_num;
    static bit scan_clk = 0;
    logic [7:0] data [0:255];   

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

    `nnc_info("SOC_TEST", "soc_pinmux_bistmode_test start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    // This is sample to write a data to Register
    `nnc_info("BISTMODE","Internal clock test",UVM_MEDIUM) 

    fork
      gen_clk;
    join_none
       
    do_run;
            
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

  task gen_clk;    
    forever #100ns  scan_clk = ~scan_clk;
  endtask : gen_clk

  virtual task do_run;
    begin
`ifndef PRESCAN
    // select TEST_MODE, PAD: TESTMODE=0, DEBUG_MODE=3
    // Checking pin testmode
    force `SOC_TB.TESTMODE = 2'b10;
    #10000;
    top_test_cfg.atm = {`ANA_TOP.D2A_ATM0, `ANA_TOP.D2A_ATM1, `ANA_TOP.D2A_ATM2, `ANA_TOP.D2A_ATM3, `ANA_TOP.D2A_ATM4, `ANA_TOP.D2A_ATM5, `ANA_TOP.D2A_ATM6, `ANA_TOP.D2A_ATM7, `ANA_TOP.D2A_ATM8, `ANA_TOP.D2A_ATM9, `ANA_TOP.D2A_ATM10, `ANA_TOP.D2A_ATM11};

    // Checking ATM
    if (top_test_cfg.atm !== 12'b0)
      begin
        `nnc_error("BISTMODE",$sformatf("ATM[0:8] = %b is not as expectation of ATM = %b", top_test_cfg.atm, 9'b0)); 
      end

    // Checking pin `SOC_TB.RESETb
    for (int i=0; i < 100; i++) begin
      rand_bit = $random;
      force `SOC_TB.RESETb = rand_bit;
      #10000;
      if (`FLASH_TOP.RESETb !== rand_bit) begin
        `nnc_error("BISTMODE",$sformatf("[ERROR][%d] `FLASH_TOP.RESETb = %b is not as expectation of `SOC_TB.RESETb = %b", i, `FLASH_TOP.RESETb, `SOC_TB.RESETb));
      end
      release `SOC_TB.RESETb;
    end

    // Checking pin TCK
    for (int i=0; i < 100; i++) begin
      rand_bit = $random;
      force `SOC_TB.TCK = rand_bit;
      #10000;
      if (`FLASH_TOP.TCK !== rand_bit) begin
        `nnc_error("BISTMODE",$sformatf("[ERROR][%d] `FLASH_TOP.TCK = %b is not as expectation of `SOC_TB.TCK = %b", i, `FLASH_TOP.TCK, `SOC_TB.TCK));
      end
      release `SOC_TB.TCK;
    end

    // Checking pin TDI
    for (int i=0; i < 100; i++) begin
      rand_bit = $random;
      force `SOC_TB.TDI = rand_bit;
      #10000;
      if (`FLASH_TOP.TDI !== rand_bit) begin
        `nnc_error("BISTMODE",$sformatf("[ERROR][%d] `FLASH_TOP.TDI = %b is not as expectation of `SOC_TB.TDI = %b", i, `FLASH_TOP.TDI, `SOC_TB.TDI));
      end
      release `SOC_TB.TDI;
    end

    // Checking pin TDO
    for (int i=0; i < 100; i++) begin
      rand_bit = $random;
      force `FLASH_TOP.OEN = 1'b0;
      force `FLASH_TOP.TDO = rand_bit;
      #10000;
      if (`SOC_TB.TDO !== rand_bit) begin
        `nnc_error("BISTMODE",$sformatf("[ERROR][%d] IOBUF_PAD[4] = %b is not as expectation of `FLASH_TOP.TDO = %b", i, `SOC_TB.TDO, `FLASH_TOP.TDO));
      end
      release `FLASH_TOP.TDO;
      release `FLASH_TOP.OEN;
    end

    force `SOC_TB.IOBUF_PAD[18:6] = $random;
    #10000;
// Checking unused PINs GPIO[18:6], GPIO[1:0]
    if(({`SOC_TOP.IOBUF_IE[18:6], `SOC_TOP.IOBUF_IE[1:0]}) !== {9'h0, 4'b0000, 2'b10}) 
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`SOC_TOP.IOBUF_IE[18:6], `SOC_TOP.IOBUF_IE[1:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_IE[18:6], `SOC_TOP.IOBUF_IE[1:0]}, {9'h0, 4'b0000, 2'b10}));
      end

`ifdef POSTSCAN
     rand_num = {
           `SOC_TOP.u_iopad_gpio_11_.OE,
           `SOC_TOP.u_iopad_gpio_10_.OE,
           `SOC_TOP.u_iopad_gpio_9_.OE,
           `SOC_TOP.u_iopad_gpio_8_.OE,
           `SOC_TOP.u_iopad_gpio_7_.OE,
           `SOC_TOP.u_iopad_gpio_6_.OE};
    if(({`SOC_TOP.IOBUF_OE[18:12], rand_num[5:0], `SOC_TOP.IOBUF_OE[1:0]}) !== 0)
      begin  
        `nnc_error("BISTMODE",$sformatf("The value of {`SOC_TOP.IOBUF_OE[18:6], `SOC_TOP.IOBUF_OE[1:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OE[18:12], rand_num[5:0], `SOC_TOP.IOBUF_OE[1:0]}, 15'b0));
      end

    rand_num = {
           `SOC_TOP.u_iopad_gpio_11_.A,
           `SOC_TOP.u_iopad_gpio_10_.A,
           `SOC_TOP.u_iopad_gpio_9_.A,
           `SOC_TOP.u_iopad_gpio_8_.A,
           `SOC_TOP.u_iopad_gpio_7_.A,
           `SOC_TOP.u_iopad_gpio_6_.A};
    if(({`SOC_TOP.IOBUF_A[18:12], rand_num[5:0], `SOC_TOP.IOBUF_A[1:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`SOC_TOP.IOBUF_A[18:6], SOC_TOP.IOBUF_A[1:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_A[18:12], rand_num[5:0], `SOC_TOP.IOBUF_A[1:0]}, 15'b0));
      end
`elsif POST_LAYOUT
     rand_num = {
           `SOC_TOP.u_iopad_gpio_11_.OE,
           `SOC_TOP.u_iopad_gpio_10_.OE,
           `SOC_TOP.u_iopad_gpio_9_.OE,
           `SOC_TOP.u_iopad_gpio_8_.OE,
           `SOC_TOP.u_iopad_gpio_7_.OE,
           `SOC_TOP.u_iopad_gpio_6_.OE};
    if(({`SOC_TOP.IOBUF_OE[18:12], rand_num[5:0], `SOC_TOP.IOBUF_OE[1:0]}) !== 0)
      begin  
        `nnc_error("BISTMODE",$sformatf("The value of {`SOC_TOP.IOBUF_OE[18:6], `SOC_TOP.IOBUF_OE[1:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OE[18:12], rand_num[5:0], `SOC_TOP.IOBUF_OE[1:0]}, 15'b0));
      end

    rand_num = {
           `SOC_TOP.u_iopad_gpio_11_.A,
           `SOC_TOP.u_iopad_gpio_10_.A,
           `SOC_TOP.u_iopad_gpio_9_.A,
           `SOC_TOP.u_iopad_gpio_8_.A,
           `SOC_TOP.u_iopad_gpio_7_.A,
           `SOC_TOP.u_iopad_gpio_6_.A};
    if(({`SOC_TOP.IOBUF_A[18:12], rand_num[5:0], `SOC_TOP.IOBUF_A[1:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`SOC_TOP.IOBUF_A[18:6], SOC_TOP.IOBUF_A[1:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_A[18:12], rand_num[5:0], `SOC_TOP.IOBUF_A[1:0]}, 15'b0));
      end
`else
    if(({`SOC_TOP.IOBUF_OE[18:6], `SOC_TOP.IOBUF_OE[1:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`SOC_TOP.IOBUF_OE[18:6], `SOC_TOP.IOBUF_OE[1:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OE[18:6], `SOC_TOP.IOBUF_OE[1:0]}, 15'b0));
      end

    if(({`SOC_TOP.IOBUF_A[18:6], `SOC_TOP.IOBUF_A[1:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`SOC_TOP.IOBUF_A[18:6], SOC_TOP.IOBUF_A[1:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_A[18:6], `SOC_TOP.IOBUF_A[1:0]}, 15'b0));
      end
`endif

    if(({`SOC_TOP.IOBUF_Y[18:6], `SOC_TOP.IOBUF_Y[1:0]})  !== {9'h0, 4'b0000, 2'b00})
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`SOC_TOP.IOBUF_Y[18:6], `SOC_TOP.IOBUF_Y[1:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_Y[18:6], `SOC_TOP.IOBUF_Y[1:0]}, {9'h0, 4'b0000, 2'b00}));
      end

    //if(({`SOC_TOP.IOBUF_YA[18:6], `SOC_TOP.IOBUF_YA[1:0]})  !== 15'bzzz_zzzz_zzzz_zzzz)
    //  begin 
    //    err_cnt++;
    //    `nnc_error("[ERROR][16] The value of {`SOC_TOP.IOBUF_YA[18:6], `SOC_TOP.IOBUF_YA[1:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_YA[18:6], `SOC_TOP.IOBUF_YA[1:0]}, 15'bzzz_zzzz_zzzz_zzzz);
    //  end

// Check all this for 19 GPIOs
`ifdef POSTLAYOUT
    if(`SOC_TOP.IOBUF_PU_always_on[2:0] !== 3'h0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of `SOC_TOP.IOBUF_PU_always_on[2:0] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_PU_always_on[2:0], 3'h0));
      end
`elsif POSTSCAN
    if(`SOC_TOP.IOBUF_PU[2:0] !== 3'h7)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of `SOC_TOP.IOBUF_PU[2:0] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_PU[2:0], 3'h7));
      end
`else
    if(`SOC_TOP.IOBUF_PU[18:0] !== 19'h7)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of `SOC_TOP.IOBUF_PU[18:0] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_PU[18:0], 19'h7));
      end

    if(({`SOC_TOP.IOBUF_PD[18:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`SOC_TOP.IOBUF_PD[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_PD[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OS[18:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`SOC_TOP.IOBUF_OS[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OS[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OD[18:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`SOC_TOP.IOBUF_OD[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OD[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_CS[18:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`SOC_TOP.IOBUF_CS[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_CS[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_SR[18:0]}) !== 19'h7ffff)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`SOC_TOP.IOBUF_SR[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_SR[18:0]}, 19'h7ffff));
      end

    if(({`SOC_TOP.IOBUF_DR[18:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`SOC_TOP.IOBUF_DR[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_DR[18:0]}, 19'b0));
      end
`endif

// Checking wake up = 0
   `nnc_info("BISTMODE","Test is entering WakeUP is disable now, checking in this mode",UVM_LOW);
   force `ANA_TOP.A2D_Wake_UP_i = 1'b0;
   #10000;

    if(({`SOC_TOP.IOBUF_IE_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_IE_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_IE_always_on[18:0]}, 19'b0));
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
        `nnc_error("BISTMODE",$sformatf("The value of `SOC_TOP.IOBUF_PU[2:0] = %b is not equal to expected value = %b", rand_num, 19'h0));
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
        `nnc_error("BISTMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_A_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
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
        `nnc_error("BISTMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OE_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
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
        `nnc_error("BISTMODE",$sformatf("The value of `SOC_TOP.IOBUF_PU[2:0] = %b is not equal to expected value = %b", rand_num, 19'h0));
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
        `nnc_error("BISTMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_A_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
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
        `nnc_error("BISTMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OE_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
      end
`else
    if(({`SOC_TOP.IOBUF_PU_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_PU_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_PU_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_A_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_A_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_A_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OE_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OE_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OE_always_on[18:0]}, 19'b0));
      end
`endif

`ifndef POSTSCAN
  `ifndef POST_LAYOUT
    if(({`SOC_TOP.IOBUF_PD_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_PD_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_PD_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OS_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OS_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OS_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OD_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OD_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OD_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_CS_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_CS_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_CS_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_SR_always_on[18:0]}) !== 19'h7ffff)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_SR_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_SR_always_on[18:0]}, 19'h7ffff));
      end

    if(({`SOC_TOP.IOBUF_DR_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("BISTMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_DR_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_DR_always_on[18:0]}, 19'b0));
      end
  `endif
`endif

   release `ANA_TOP.A2D_Wake_UP_i;

#3000000; // 3ms    
`endif
    end
  endtask  

  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME

