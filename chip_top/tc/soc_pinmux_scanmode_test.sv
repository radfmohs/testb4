/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_pinmux_scanmode_test.sv                                                   
// Project	: Nanochap ENS1P4                                  		        
// Description	: Testcase soc_pinmux_scanmode_test                                             
// Designer	: zhenghong.yu@nanochap.com                                                                
// Date		: 29-11-1623                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_pinmux_scanmode_test
`define TESTCFG soc_pinmux_scanmode_test_cfg

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

  function new (string name = "soc_pinmux_scanmode_test_cfg");
    super.new(name);
    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // testmode_sel[1:0] : 00-Normal mode, 01: Scanmode, 10: BIST mode, 11 atm0/1/2/3/4
  constraint c_testmode_sel { soft testmode_sel == 2'b01; }

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

    `DUT_IF.spimode_sel = top_test_cfg.spimode_sel;

    `SPI_SCB_EN = 1'b0;
    `ANALOG_SCOREBOARD_EN = 1'b0;

    // ==================
    // Scoreboard enables
    // ==================

    phase.drop_objection(this);
  endtask : pre_reset_phase

  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_pinmux_scanmode_test start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    // This is sample to write a data to Register
    `nnc_info("SCANMODE","Internal clock test",UVM_MEDIUM)    
    fork
      gen_clk;
    join_none
       
    do_run;
    //Runing by using external clock
    `nnc_info("SCANMODE","External clock test",UVM_MEDIUM)
            
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

  task gen_clk;    
    forever #10ns  scan_clk = ~scan_clk;
  endtask : gen_clk

  virtual task do_run;
    begin
`ifndef PRESCAN
    // select TEST_MODE, PAD: TESTMODE=0, DEBUG_MODE=3
    // Checking pin testmode
    `FLASH_BIST_MASTER_TOP.TESTMODE_SEL = `DUT_IF.testmode_sel;
    #10000;
    top_test_cfg.atm = {`ANA_TOP.D2A_ATM0, `ANA_TOP.D2A_ATM1, `ANA_TOP.D2A_ATM2, `ANA_TOP.D2A_ATM3, `ANA_TOP.D2A_ATM4, `ANA_TOP.D2A_ATM5, `ANA_TOP.D2A_ATM6, `ANA_TOP.D2A_ATM7, `ANA_TOP.D2A_ATM8, `ANA_TOP.D2A_ATM9, `ANA_TOP.D2A_ATM10, `ANA_TOP.D2A_ATM11};

    // Checking ATM
    if (top_test_cfg.atm !== 9'b0)
      begin
        `nnc_error("SCANMODE",$sformatf("ATM[0:8] = %b is not as expectation of ATM = %b", top_test_cfg.atm, 9'b0)); 
      end

`ifdef NETLIST 
    force `FLASH_TOP.u_32k.A = 0;
    force `FLASH_TOP.u_32k.DIN = 0;
`endif
    force `SOC_TB.IOBUF_PAD[6] = 0;
      
    force `SOC_TB.scan_rst_n=0;
    #100000;
    force `SOC_TB.scan_rst_n=1;
    #100000;

    // Checking pin scan clock
    for (int i=0; i < 100; i++) begin
      rand_bit = $random;
      force `SOC_TB.IOBUF_PAD[2] = rand_bit;
      #10000;
      if (`DIG_TOP.u_pinmux.scan_clk !== rand_bit) begin
        $display("[ERROR A][%d] `DIG_TOP.u_pinmux.scan_clk = %b is not as expectation of scan_clk = %b", i, `DIG_TOP.u_pinmux.scan_clk, `SOC_TB.IOBUF_PAD[2]);
      end
      release `SOC_TB.IOBUF_PAD[2];
    end
    force `SOC_TB.IOBUF_PAD[2] = scan_clk;

    // Checking pin scan rst
    for (int i=0; i < 100; i++) begin
      rand_bit = $random;
      force `SOC_TB.scan_rst_n = rand_bit;
      #10000;
`ifndef POST_LAYOUT
      if (`DIG_TOP.u_pinmux.scan_rst_n !== rand_bit) begin
        $display("[ERROR B][%d] `DIG_TOP.u_pinmux.scan_rst_n = %b is not as expectation of scan_rst_n = %b", i, `DIG_TOP.u_pinmux.scan_rst_n, `SOC_TB.scan_rst_n);
      end
`else
      if (`ALWAYSON_TOP.scan_rst_n !== rand_bit) begin
        $display("[ERROR C][%d] `ALWAYSON_TOP.scan_rst_n = %b is not as expectation of scan_rst_n = %b", i, `ALWAYSON_TOP.scan_rst_n, `SOC_TB.scan_rst_n);
      end
`endif
      release `SOC_TB.scan_rst_n;
    end

    // Checking pin scan en
    for (int i=0; i < 100; i++) begin
      rand_bit = $random;
      force `SOC_TB.IOBUF_PAD[3] = rand_bit;
      #10000;
      if (`DIG_TOP.u_pinmux.scan_en !== rand_bit) begin
        $display("[ERROR D][%d] `DIG_TOP.u_pinmux.scan_en = %b is not as expectation of scan_en = %b", i, `DIG_TOP.u_pinmux.scan_en, rand_bit);
      end
      release `SOC_TB.IOBUF_PAD[3];
    end
    force `SOC_TB.IOBUF_PAD[3] = 1;

    // Checking pin compression
    for (int i=0; i < 100; i++) begin
      rand_bit = $random;
      force `SOC_TB.IOBUF_PAD[6] = rand_bit;
      #10000;
      if (`DIG_TOP.u_pinmux.scan_compression_in !== rand_bit) begin
        $display("[ERROR E][%d] `DIG_TOP.u_pinmux.scan_compression_in = %b is not as expectation of rand_bit = %b", i, `DIG_TOP.u_pinmux.scan_compression_in,rand_bit);
      end
      release `SOC_TB.IOBUF_PAD[6];
    end
    force `SOC_TB.IOBUF_PAD[6] = 1'b0;

    // Checking pin scan out
    for (int i=0; i < 100; i++) begin
      rand_num[7:0] = $random;
      force `DIG_TOP.u_pinmux.scan_out = rand_num[7:0];
      #10000;
      if ({`SOC_TB.IOBUF_PAD[18:13], `SOC_TB.IOBUF_PAD[1:0]} !== rand_num[7:0]) begin
        `nnc_error("SCANMODE",$sformatf("[ERROR F][%d] {`SOC_TB.IOBUF_PAD[18:13], `SOC_TB.IOBUF_PAD[1:0]} = scan_out = %b is not as expectation of `DIG_TOP.u_pinmux.scan_out = %b", i, {`SOC_TB.IOBUF_PAD[18:13], `SOC_TB.IOBUF_PAD[1:0]}, `DIG_TOP.u_pinmux.scan_out));
      end
    end

    // Checking pin scan in
    for (int i=0; i < 100; i++) begin
      rand_num[7:0] = $random;
      force {`SOC_TB.IOBUF_PAD[10:7],`SOC_TB.IOBUF_PAD[12:11], `SOC_TB.IOBUF_PAD[5:4]} = rand_num[7:0];
      #10000;
      if (`DIG_TOP.u_pinmux.scan_in !== rand_num[7:0]) begin
        `nnc_error("SCANMODE",$sformatf("[ERROR E][%d] `DIG_TOP.u_pinmux.scan_in[7:0] = %b is not as expectation of scan_in = %b", i, `DIG_TOP.u_pinmux.scan_in, {`SOC_TB.IOBUF_PAD[10:7],`SOC_TB.IOBUF_PAD[12:11], `SOC_TB.IOBUF_PAD[5:4]}));
        if (`DIG_TOP.u_pinmux.scan_in !== `DIG_TOP.u_pinmux.scan_out) begin
          `nnc_error("SCANMODE",$sformatf("[ERROR E][%d] scan_in = %b is not as expectation of scan_out = %b", i, `DIG_TOP.u_pinmux.scan_in, `DIG_TOP.u_pinmux.scan_out));
        end
      end
      release {`SOC_TB.IOBUF_PAD[10:7],`SOC_TB.IOBUF_PAD[12:11], `SOC_TB.IOBUF_PAD[5:4]};
    end
    release `SOC_TB.IOBUF_PAD[2];
 
// Check all this for 19 GPIOs
`ifdef POSTSCAN
    if(`SOC_TOP.IOBUF_PU[2:0] !== 3'h0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of `SOC_TOP.IOBUF_PU[2:0] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_PU[2:0], 3'h0));
      end
`elsif POST_LAYOUT
    if(`SOC_TOP.IOBUF_PU_always_on[2:0] !== 3'h0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of `SOC_TOP.IOBUF_PU_always_on[2:0] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_PU_always_on[2:0], 3'h0));
      end
`else
    if(`SOC_TOP.IOBUF_PU[18:0] !== 19'h0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of `SOC_TOP.IOBUF_PU[18:0] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_PU[18:0], 19'h0));
      end

    if(({`SOC_TOP.IOBUF_PD[18:0]}) !== 0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`SOC_TOP.IOBUF_PD[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_PD[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OS[18:0]}) !== 0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`SOC_TOP.IOBUF_OS[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OS[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OD[18:0]}) !== 0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`SOC_TOP.IOBUF_OD[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OD[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_CS[18:0]}) !== 0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`SOC_TOP.IOBUF_CS[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_CS[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_SR[18:0]}) !== 19'h0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`SOC_TOP.IOBUF_SR[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_SR[18:0]}, 19'h0));
      end

    if(({`SOC_TOP.IOBUF_DR[18:0]}) !== 0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`SOC_TOP.IOBUF_DR[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_DR[18:0]}, 19'b0));
      end
`endif

// Checking wake up = 0
   `nnc_info("SCANMODE",$sformatf("Test is entering WakeUP is disable now, checking in this mode"), UVM_LOW);
   force `ANA_TOP.A2D_Wake_UP_i = 1'b0;
   #10000;

    if(({`SOC_TOP.IOBUF_IE_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_IE_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_IE_always_on[18:0]}, 19'b0));
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
        `nnc_error("SCANMODE",$sformatf("The value of `SOC_TOP.IOBUF_PU[2:0] = %b is not equal to expected value = %b", rand_num, 19'h0));
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
        `nnc_error("SCANMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_A_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
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
        `nnc_error("SCANMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OE_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
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
        `nnc_error("SCANMODE",$sformatf("The value of `SOC_TOP.IOBUF_PU[2:0] = %b is not equal to expected value = %b", rand_num, 19'h0));
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
        `nnc_error("SCANMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_A_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
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
        `nnc_error("SCANMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OE_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
      end
`else
    if(({`SOC_TOP.IOBUF_PU_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_PU_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_PU_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_A_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_A_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_A_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OE_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OE_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OE_always_on[18:0]}, 19'b0));
      end
`endif

`ifndef POSTSCAN
  `ifndef POST_LAYOUT
    if(({`SOC_TOP.IOBUF_PD_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_PD_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_PD_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OS_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OS_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OS_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OD_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OD_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OD_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_CS_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_CS_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_CS_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_SR_always_on[18:0]}) !== 19'h7ffff)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_SR_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_SR_always_on[18:0]}, 19'h7ffff));
      end

    if(({`SOC_TOP.IOBUF_DR_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("SCANMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_DR_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_DR_always_on[18:0]}, 19'b0));
      end
  `endif
`endif
   release `ANA_TOP.A2D_Wake_UP_i;

#3000; // 3ms
`endif
/*
    force `SOC_TB.IOBUF_PAD[3] = 1;

    force `SOC_TB.scan_rst_n=0;
    #100000;
    force `SOC_TB.scan_rst_n=1;
    #100000;

    force {`SOC_TB.IOBUF_PAD[10:7],`SOC_TB.IOBUF_PAD[12:11], `SOC_TB.IOBUF_PAD[5:4]} = 8'hFF;
    `nnc_info("SCANMODE",$sformatf("Sending START condition: %h", {`SOC_TB.IOBUF_PAD[10:7],`SOC_TB.IOBUF_PAD[12:11], `SOC_TB.IOBUF_PAD[5:4]}),UVM_LOW);
    #100000ns;
    `nnc_info("SCANMODE","Transfering now",UVM_LOW);
    for (integer k = 0; k<256; k++) begin 
      @(posedge `SOC_TB.IOBUF_PAD[2]); 
      force {`SOC_TB.IOBUF_PAD[10:7],`SOC_TB.IOBUF_PAD[12:11], `SOC_TB.IOBUF_PAD[5:4]} = $random; 
      data[k] = {`SOC_TB.IOBUF_PAD[10:7],`SOC_TB.IOBUF_PAD[12:11], `SOC_TB.IOBUF_PAD[5:4]};
      `nnc_info("SCANMODE",$sformatf("DATA {`SOC_TB.IOBUF_PAD[10:7],`SOC_TB.IOBUF_PAD[12:11], `SOC_TB.IOBUF_PAD[5:4]} = %h is sent to CHIP through scan_in_data", data[k]),UVM_LOW);
    end
    #100000ns;

    force {`SOC_TB.IOBUF_PAD[18:13],`SOC_TB.IOBUF_PAD[1:0]} = 8'h80;
    `nnc_info("SCANMODE",$sformatf("Sending STOP condition: %h", {`SOC_TB.IOBUF_PAD[18:13],`SOC_TB.IOBUF_PAD[1:0]}),UVM_LOW);
*/  
    end
  endtask  

  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME        
