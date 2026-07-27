/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_pinmux_normalmode_test.sv                                                   
// Project	: Nanochap ens1p4                                  		        
// Description	: Testcase soc_pinmux_normalmode_test                                             
// Designer	: zhenghong.yu@nanochap.com                                                                 
// Date		: 14-04-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_pinmux_normalmode_test
`define TESTCFG soc_pinmux_normalmode_test_cfg

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
  logic [8:0]   atm;
  
  // -----------------------------------------------
  // End of decalration of new variables 
  // -----------------------------------------------

  function new (string name = "soc_pinmux_normalmode_test_cfg");
    super.new(name);
    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // testmode_sel[1:0] : 00-Normal mode, 01: Scanmode, 10: BIST mode, 11 atm0/1/2/3/4
  constraint c_testmode_sel { soft testmode_sel == 2'b00; }

  constraint c_no_of_bytes  { soft no_of_bytes == 2; }

  // -----------------------------------------------
  // End of adding constraints of randomization
  // -----------------------------------------------

endclass : `TESTCFG

class `TESTNAME extends soc_base_test;
    static bit rand_bit;   
    static logic [20:0] rand_num;
    static bit SCLK = 0;
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

    // ==================
    // Scoreboard enables
    // ==================
    `SPI_SCB_EN = 1'b0;
    `ANALOG_SCOREBOARD_EN = 1'b0;

    phase.drop_objection(this);
  endtask : pre_reset_phase

  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_pinmux_normalmode_test start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    // This is sample to write a data to Register
    fork
      gen_SCLK;
    join_none
    #1000ns;
    
    `nnc_info("PINMUX","Internal clock test",UVM_LOW)
    do_run;
    
    //`nnc_info("ATM8","External clock test", UVM_MEDIUM)    
    //force `ANA_TOP.A2D_external_en_I=1;
    //do_run;
            
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

  task gen_SCLK;    
    forever #100ns  SCLK = ~SCLK;
  endtask : gen_SCLK

  virtual task do_run;
    begin
`ifndef PRESCAN

    // select TEST_MODE, PAD: TESTMODE=0, DEBUG_MODE=3
    // Checking pin testmode
    force `SOC_TB.TESTMODE = 2'b00;    
    #10000;
    top_test_cfg.atm = {`ANA_TOP.D2A_ATM0, `ANA_TOP.D2A_ATM1, `ANA_TOP.D2A_ATM2, `ANA_TOP.D2A_ATM3, `ANA_TOP.D2A_ATM4, `ANA_TOP.D2A_ATM5, `ANA_TOP.D2A_ATM6, `ANA_TOP.D2A_ATM7, `ANA_TOP.D2A_ATM8, `ANA_TOP.D2A_ATM9, `ANA_TOP.D2A_ATM10, `ANA_TOP.D2A_ATM11};
    // Checking ATM
    if (top_test_cfg.atm !== 12'b0)
      begin
        `nnc_error("NORMALMODE",$sformatf("ATM[0:11] = %b is not as expectation of ATM = %b", top_test_cfg.atm, 11'b0)); 
      end

    // Checking pin `SOC_TB.IOBUF_PAD[0]: i_cs_n
    for (int i=0; i < 100; i++) begin
      rand_num[0] = $random;
      force `SOC_TB.IOBUF_PAD[0] = rand_num[0];
      #10000;
      if (`SPI_TOP.i_cs_n !== rand_num[0]) begin
        `nnc_error("NORMALMODE",$sformatf("[ERROR][%d] `SPI_TOP.i_cs_n = %b is not as expectation of i_cs_n = %b", i, `SPI_TOP.i_cs_n, rand_num[0]));
      end
      release `SOC_TB.IOBUF_PAD[0];
      #10000;
    end

    // Checking pin `SOC_TB.IOBUF_PAD[1]: SDI
    for (int i=0; i < 100; i++) begin
      rand_num[0] = $random;
      force `SOC_TB.IOBUF_PAD[1] = rand_num[0];
      #10000;
      if (`SPI_TOP.i_mosi !== rand_num[0]) begin
        `nnc_error("NORMALMODE",$sformatf("[ERROR][%d] `SPI_TOP.i_mosi = %b is not as expectation of i_mosi = %b", i, `SPI_TOP.i_mosi, rand_num[0]));
      end
      release `SOC_TB.IOBUF_PAD[1];
      #10000;
    end

    // Checking pin `SOC_TB.IOBUF_PAD[2]: i_sclk
    for (int i=0; i < 100; i++) begin
      rand_num[0] = $random;
      force `SOC_TB.IOBUF_PAD[2] = rand_num[0];
      #10000;
      if (`SPI_TOP.i_sclk !== rand_num[0]) begin
        `nnc_error("NORMALMODE",$sformatf("[ERROR][%d] `SPI_TOP.i_sclk = %b is not as expectation of i_sclk = %b", i, `SPI_TOP.i_sclk, rand_num[0]));
      end
      release `SOC_TB.IOBUF_PAD[2];
      #10000;
    end

    // Checking pin `SOC_TB.IOBUF_PAD[3]: SDO
    for (int i=0; i < 100; i++) begin
      rand_num[0] = $random;
      force `SPI_TOP.o_miso = rand_num[0];
      force `SPI_TOP.i_cs_n = 1'b0;
      #10000;
      if (`SOC_TB.IOBUF_PAD[3] !== rand_num[0]) begin
        `nnc_error("NORMALMODE",$sformatf("[ERROR][%d] `SOC_TB.IOBUF_PAD[3]:miso_w = %b is not as expectation of o_miso = %b", i, `SOC_TB.IOBUF_PAD[3], rand_num[0]));
      end
      release `SPI_TOP.o_miso;
      release `SPI_TOP.i_cs_n;
      #10000;
    end

    // Checking pin `SOC_TB.IOBUF_PAD[4]: INTB
    for (int i=0; i < 100; i++) begin
      rand_num[0] = $random;
      force `FIFO_TOP.fifo_intr = rand_num[0];
      force `DIG_TOP.u_pinmux.imeas_int = 1'b0;
      force `DIG_TOP.u_pinmux.zmeas_int = 1'b0;
      force `DIG_TOP.u_pinmux.zmeas_adc_int = 1'b0;
      #10000;
      if (`SOC_TB.IOBUF_PAD[4] !== rand_num[0]) begin
        `nnc_error("NORMALMODE",$sformatf("[ERROR][%d] `SOC_TB.IOBUF_PAD[4]: INTB = %b is not as expectation of fifo_intr = %b", i, `SOC_TB.IOBUF_PAD[4], rand_num[0]));
      end
      release `DIG_TOP.u_pinmux.fifo_intr;
      release `DIG_TOP.u_pinmux.imeas_int;
      release `DIG_TOP.u_pinmux.zmeas_int;
      release `DIG_TOP.u_pinmux.zmeas_adc_int;
      #10000;
    end
/*
    // Checking pin iopad_resetn
    if((`SOC_TB.ext_resetn) !== 1'b1)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of intial extenal reset is asserted at the beginning = %b", `SOC_TB.ext_resetn));
      end
    wait(`RESETN);
    wait(`HF_RESETN);

    #20000;

    force `SOC_TB.ext_resetn = 0;
    wait(~`RST_CTRL_TOP.poresetn);
    wait(~`RST_CTRL_TOP.poresetn_hf);
    wait(~`RST_CTRL_TOP.presetn);
    wait(`RST_CTRL_TOP.flash_por_resetn);
    wait(~`RST_CTRL_TOP.flash_bist_resetn_atpg);

    if((`RST_CTRL_TOP.poresetn) !== 1'b0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("poresetn is not asserted as expectation = %b", `RST_CTRL_TOP.poresetn));
      end

    if((`RST_CTRL_TOP.poresetn_hf) !== 1'b0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("poresetn_hf is not asserted as expectation = %b", `RST_CTRL_TOP.poresetn_hf));
      end

    if((`RST_CTRL_TOP.presetn) !== 1'b0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("presetn is not asserted as expectation = %b", `RST_CTRL_TOP.presetn));
      end

    if((`RST_CTRL_TOP.flash_por_resetn) !== 1'b1)
      begin 
        `nnc_error("NORMALMODE",$sformatf("flash_por_resetn is asserted, not as expectation = %b", `RST_CTRL_TOP.flash_por_resetn));
      end

    if((`RST_CTRL_TOP.flash_bist_resetn_atpg) !== 1'b0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("flash_bist_resetn_atpg is not asserted as expectation = %b", `RST_CTRL_TOP.flash_bist_resetn_atpg));
      end

    #20000;
    release `SOC_TB.ext_resetn;
*/
    rand_num[18:0] = $random;
    force `SOC_TB.IOBUF_PAD[18:6] = rand_num[18:6];
    #10000;
// Checking 5 pins of analog
    if(({`SOC_TOP.IOBUF_IE[10:6]}) !== 0) 
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of IOBUF_IE[10:6] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_IE[10:6], 5'b0));
      end

`ifdef POSTSCAN
   rand_num= {
           `SOC_TOP.u_iopad_gpio_10_.OE,
           `SOC_TOP.u_iopad_gpio_9_.OE,
           `SOC_TOP.u_iopad_gpio_8_.OE,
           `SOC_TOP.u_iopad_gpio_7_.OE,
           `SOC_TOP.u_iopad_gpio_6_.OE};
    if((rand_num) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of IOBUF_OE[10:6] = %b is not equal to expected value = %b", rand_num, 5'b0));
      end
   rand_num= {
           `SOC_TOP.u_iopad_gpio_10_.A,
           `SOC_TOP.u_iopad_gpio_9_.A,
           `SOC_TOP.u_iopad_gpio_8_.A,
           `SOC_TOP.u_iopad_gpio_7_.A,
           `SOC_TOP.u_iopad_gpio_6_.A};
    if((rand_num) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of IOBUF_A[10:6] = %b is not equal to expected value = %b", rand_num, 5'b0));
      end
`elsif POST_LAYOUT
   rand_num= {
           `SOC_TOP.u_iopad_gpio_10_.OE,
           `SOC_TOP.u_iopad_gpio_9_.OE,
           `SOC_TOP.u_iopad_gpio_8_.OE,
           `SOC_TOP.u_iopad_gpio_7_.OE,
           `SOC_TOP.u_iopad_gpio_6_.OE};
    if((rand_num) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of IOBUF_OE[10:6] = %b is not equal to expected value = %b", rand_num, 5'b0));
      end
   rand_num= {
           `SOC_TOP.u_iopad_gpio_10_.A,
           `SOC_TOP.u_iopad_gpio_9_.A,
           `SOC_TOP.u_iopad_gpio_8_.A,
           `SOC_TOP.u_iopad_gpio_7_.A,
           `SOC_TOP.u_iopad_gpio_6_.A};
    if((rand_num) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of IOBUF_A[10:6] = %b is not equal to expected value = %b", rand_num, 5'b0));
      end
`else
    if(({`SOC_TOP.IOBUF_OE[10:6]}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of IOBUF_OE[10:6] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_OE[10:6], 5'b0));
      end

    if(({`SOC_TOP.IOBUF_A[10:6] }) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of IOBUF_A[10:6] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_A[10:6], 5'b0));
      end
`endif

`ifndef POSTSCAN
    if(({`SOC_TOP.IOBUF_Y[10:6]})  !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of IOBUF_Y[10:6] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_Y[10:6], 5'b0));
      end

    if(({`SOC_TOP.IOBUF_YA[10:6]}) !== `SOC_TB.IOBUF_PAD[10:6]) 
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of IOBUF_YA[10:6] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_YA[10:6], `SOC_TB.IOBUF_PAD[10:6]));
      end
`endif

// Checking unused PINs GPIO[18:11]
    if(({`SOC_TOP.IOBUF_IE[18:11]}) !== 0) 
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`SOC_TOP.IOBUF_IE[18:11]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_IE[18:11]}, 8'b0));
      end
`ifdef POSTSCAN
    if(({`SOC_TOP.IOBUF_OE[18:12], `SOC_TOP.u_iopad_gpio_11_.OE}) !== 8'b10000011)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`SOC_TOP.IOBUF_OE[18:11]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OE[18:12], `SOC_TOP.u_iopad_gpio_11_.OE}, 8'b0));
      end

    if(({`SOC_TOP.IOBUF_A[18:12], `SOC_TOP.u_iopad_gpio_11_.A}) !== 8'b00000001)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`SOC_TOP.IOBUF_A[18:11]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_A[18:12], `SOC_TOP.u_iopad_gpio_11_.A}, 8'b0));
      end
`elsif POST_LAYOUT
    if(({`SOC_TOP.IOBUF_OE[18:12], `SOC_TOP.u_iopad_gpio_11_.OE}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`SOC_TOP.IOBUF_OE[18:11]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OE[18:12], `SOC_TOP.u_iopad_gpio_11_.OE}, 8'b0));
      end

    if(({`SOC_TOP.IOBUF_A[18:12], `SOC_TOP.u_iopad_gpio_11_.A}) !== 8'b0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`SOC_TOP.IOBUF_A[18:11]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_A[18:12], `SOC_TOP.u_iopad_gpio_11_.A}, 8'b0));
      end
`else
    if(({`SOC_TOP.IOBUF_OE[18:11]}) !== 8'b10000011)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`SOC_TOP.IOBUF_OE[18:11]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OE[18:11]}, 8'b10000011));
      end

    if(({`SOC_TOP.IOBUF_A[18:11]}) !== 8'b00000001)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`SOC_TOP.IOBUF_A[18:11]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_A[18:11]}, 8'b00000001));
      end
`endif

    if(({`SOC_TOP.IOBUF_Y[18:11]})  !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`SOC_TOP.IOBUF_Y[18:11]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_Y[18:11]}, 8'b0));
      end

    //if(({`SOC_TOP.IOBUF_YA[18:11]}) !== 8'bzzzz_zzzz)
    //  begin 
    //    err_cnt++;
    //    `nnc_error("[ERROR][10] The value of {`SOC_TOP.IOBUF_YA[18:11]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_YA[18:11]}, 8'bzzzz_zzzz);
    //  end
    release `SOC_TB.IOBUF_PAD[18:6];

// Check all this for 19 GPIOs
`ifdef POSTLAYOUT
    if(`SOC_TOP.IOBUF_PU_always_on[2:0] !== 3'h0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of `SOC_TOP.IOBUF_PU_always_on[2:0] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_PU_always_on[2:0], 3'h0));
      end
`elsif POSTSCAN
    if(`SOC_TOP.IOBUF_PU[2:0] !== 3'h7)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of `SOC_TOP.IOBUF_PU[2:0] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_PU[2:0], 3'h7));
      end
`else
    if(`SOC_TOP.IOBUF_PU[18:0] !== 19'h7)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of `SOC_TOP.IOBUF_PU[18:0] = %b is not equal to expected value = %b", `SOC_TOP.IOBUF_PU[18:0], 19'h7));
      end

    if(({`SOC_TOP.IOBUF_PD[18:0]}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`SOC_TOP.IOBUF_PD[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_PD[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OS[18:0]}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`SOC_TOP.IOBUF_OS[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OS[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OD[18:0]}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`SOC_TOP.IOBUF_OD[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OD[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_CS[18:0]}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`SOC_TOP.IOBUF_CS[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_CS[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_SR[18:0]}) !== 19'h7ffff)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`SOC_TOP.IOBUF_SR[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_SR[18:0]}, 19'h7ffff));
      end

    if(({`SOC_TOP.IOBUF_DR[18:0]}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`SOC_TOP.IOBUF_DR[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_DR[18:0]}, 19'b0));
      end
`endif

// Checking wake up = 0
   `nnc_info("NORMALMODE",$sformatf("Test is entering WakeUP is disable now, checking in this mode"),UVM_LOW);
   force `ANA_TOP.A2D_Wake_UP_i = 1'b0;
   #1000000;
 
    if(({`SOC_TOP.IOBUF_IE_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_IE_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_IE_always_on[18:0]}, 19'b0));
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
        `nnc_error("NORMALMODE",$sformatf("The value of `SOC_TOP.IOBUF_PU[2:0] = %b is not equal to expected value = %b", rand_num, 19'h0));
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
        `nnc_error("NORMALMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_A_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
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
        `nnc_error("NORMALMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OE_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
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
        `nnc_error("NORMALMODE",$sformatf("The value of `SOC_TOP.IOBUF_PU[2:0] = %b is not equal to expected value = %b", rand_num, 19'h0));
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
        `nnc_error("NORMALMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_A_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
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
        `nnc_error("NORMALMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OE_always_on[18:0]} = %b is not equal to expected value = %b", rand_num, 19'b0));
      end
`else
    if(({`SOC_TOP.IOBUF_PU_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_PU_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_PU_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_A_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_A_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_A_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OE_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OE_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OE_always_on[18:0]}, 19'b0));
      end
`endif

`ifndef POSTSCAN
  `ifndef POST_LAYOUT
    if(({`SOC_TOP.IOBUF_PD_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_PD_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_PD_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OS_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OS_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OS_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_OD_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_OD_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_OD_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_CS_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_CS_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_CS_always_on[18:0]}, 19'b0));
      end

    if(({`SOC_TOP.IOBUF_SR_always_on[18:0]}) !== 19'h7ffff)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_SR_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_SR_always_on[18:0]}, 19'h7ffff));
      end

    if(({`SOC_TOP.IOBUF_DR_always_on[18:0]}) !== 0)
      begin 
        `nnc_error("NORMALMODE",$sformatf("The value of {`ANA_TOP.Wake_UP_i = 1'b0 - `SOC_TOP.IOBUF_DR_always_on[18:0]} = %b is not equal to expected value = %b", {`SOC_TOP.IOBUF_DR_always_on[18:0]}, 19'b0));
      end
  `endif
`endif

   //release `ANA_TOP.A2D_Wake_UP_i;

#3000000; // 3ms

`endif
    end
  endtask  

  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME
