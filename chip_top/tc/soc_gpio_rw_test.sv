/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_gpio_rw_test.sv                                                   
// Project	: Nanochap BPS1                                  		        
// Description	: Testcase soc_pinmux_normalmode_test                                             
// Designer	: ddang@nanochap.com                                                                 
// Date		: 29-11-1623                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_gpio_rw_test
`define TESTCFG soc_gpio_rw_test_cfg

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
  
  // -----------------------------------------------
  // End of decalration of new variables 
  // -----------------------------------------------

  function new (string name = "soc_gpio_rw_test_cfg");
    super.new(name);
    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // testmode_sel[1:0] : 00-Normal mode, 01: Scanmode, 10: BIST mode, 11 atm0/1/2/3/4
  constraint c_testmode_sel { soft testmode_sel == 2'b00; }

  constraint c_no_of_bytes { soft no_of_bytes == 2; }
  // -----------------------------------------------
  // End of adding constraints of randomization
  // -----------------------------------------------

endclass : `TESTCFG

class `TESTNAME extends soc_base_test;

  static bit SCLK = 0;
  static logic [20:0] rand_num;
  logic [18:0] GPIO_PD;
  logic [18:0] GPIO_PU;
  logic [18:0] GPIO_CS;
  logic [18:0] GPIO_SR;
  logic [18:0] GPIO_DR;
  logic [18:0] GPIO_OS;
  logic [18:0] GPIO_OD;

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

    
    phase.drop_objection(this);
  endtask : pre_reset_phase  

  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);

    fork
      gen_SCLK;
    join_none

    #50us;
    do_run;
            
    phase.drop_objection(this);
  endtask: main_phase 
    
  task gen_SCLK;    
    forever #100ns  SCLK = ~SCLK;
  endtask : gen_SCLK  

  virtual task do_run;

    logic [18:0] temp_data;

    begin
        force `SOC_TB.IOBUF_PAD[9:6] = 4'b0;
        //force `SOC_TB.iopad_resetn = 1'b0;
        //#1000ns;
        //force `SOC_TB.iopad_resetn = 1'b1;
        #1000ns;

// ==============================
// Check initial value
// ==============================
`ifdef POSTLAYOUT
            temp_data = {`SOC_TOP.u_iopad_gpio_18_.PD, 
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
                `SOC_TOP.u_iopad_gpio_7_.PD,
                `SOC_TOP.u_iopad_gpio_6_.PD,
                `SOC_TOP.u_iopad_gpio_5_.PD,
                `SOC_TOP.u_iopad_gpio_4_.PD,
                `SOC_TOP.u_iopad_gpio_3_.PD,
                `SOC_TOP.u_iopad_gpio_2_.PD,
                `SOC_TOP.u_iopad_gpio_1_.PD,
                `SOC_TOP.u_iopad_gpio_0_.PD};
`else
            temp_data = `DIG_TOP.u_gpio.o_baf4p1_IOBUF_PD[18:0];
`endif   
                    
            if(temp_data !== 19'h0)begin
                `nnc_error("SOC TEST",$sformatf("o_baf4p1_IOBUF_PD = %h is not as expectation of GPIO_PD = %h",temp_data, 19'h0));
            end                 
            else  `nnc_info("SOC TEST",$sformatf("o_baf4p1_IOBUF_PD = %h is not as expectation of GPIO_PD = %h",temp_data, 19'h0),UVM_MEDIUM);

            if ({`SOC_TOP.u_iopad_testmode1.PD, `SOC_TOP.u_iopad_testmode0.PD} !== 2'b11) begin
                `nnc_error("SOC TEST",$sformatf("{`SOC_TOP.u_iopad_testmode1.PD, `SOC_TOP.u_iopad_testmode0.PD} = %h is not as expectation of TESTMODE[1:0] = %h", {`SOC_TOP.u_iopad_testmode1.PD, `SOC_TOP.u_iopad_testmode0.PD}, 2'b11));   
            end 

`ifdef POSTLAYOUT
            temp_data = {`SOC_TOP.u_iopad_gpio_18_.PU, 
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
                `SOC_TOP.u_iopad_gpio_7_.PU,
                `SOC_TOP.u_iopad_gpio_6_.PU,
                `SOC_TOP.u_iopad_gpio_5_.PU,
                `SOC_TOP.u_iopad_gpio_4_.PU,
                `SOC_TOP.u_iopad_gpio_3_.PU,
                `SOC_TOP.u_iopad_gpio_2_.PU,
                `SOC_TOP.u_iopad_gpio_1_.PU,
                `SOC_TOP.u_iopad_gpio_0_.PU};
`else
            temp_data = `DIG_TOP.u_gpio.o_baf4p1_IOBUF_PU[18:0];
`endif      

            if(temp_data !== `SOC_GPIO_PU_CTR_INIT)begin
                `nnc_error("SOC TEST",$sformatf("o_baf4p1_IOBUF_PU = %h is not as expectation of GPIO_PU = %h",temp_data, `SOC_GPIO_PU_CTR_INIT));
            end                 
            else  `nnc_info("SOC TEST",$sformatf("o_baf4p1_IOBUF_PU = %h is not as expectation of GPIO_PU = %h",temp_data, `SOC_GPIO_PU_CTR_INIT),UVM_MEDIUM);   

            if(`SOC_TOP.u_iopad_exresetn.PU !== 1'b1) begin
                `nnc_error("SOC TEST",$sformatf("`SOC_TOP.u_iopad_exresetn.PU = %h is not as expectation of GPIO_PU = %h", `SOC_TOP.u_iopad_exresetn.PU, 1'b1));
            end
            else  `nnc_info("SOC TEST",$sformatf("`SOC_TOP.u_iopad_exresetn.PU = %h is not as expectation of GPIO_PU = %h", `SOC_TOP.u_iopad_exresetn.PU, 1'b1),UVM_MEDIUM);

// ==============================
// Check connectivities
// ==============================
        for (int i=0; i < 100; i++) begin    
            force `DIG_TOP.spi_top_u.spi_reg_u.gpio_pu_ctrl[2:0] = 3'h7;
            force `DIG_TOP.spi_top_u.spi_reg_u.gpio_pd_testmode[1:0] = 2'h3;

            GPIO_PD = 19'b0;

            GPIO_PU = {16'b0, `DIG_TOP.spi_top_u.spi_reg_u.gpio_pu_ctrl[2:0]};

            GPIO_CS = 19'b0;

            GPIO_SR = 19'h7_ffff;

            GPIO_DR = 19'b0;

            GPIO_OS = 19'b0;

            GPIO_OD = 19'b0;

            #100ns;    

`ifdef POSTLAYOUT
            temp_data = {`SOC_TOP.u_iopad_gpio_18_.PD, 
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
                `SOC_TOP.u_iopad_gpio_7_.PD,
                `SOC_TOP.u_iopad_gpio_6_.PD,
                `SOC_TOP.u_iopad_gpio_5_.PD,
                `SOC_TOP.u_iopad_gpio_4_.PD,
                `SOC_TOP.u_iopad_gpio_3_.PD,
                `SOC_TOP.u_iopad_gpio_2_.PD,
                `SOC_TOP.u_iopad_gpio_1_.PD,
                `SOC_TOP.u_iopad_gpio_0_.PD};
`else
            temp_data = `DIG_TOP.u_gpio.o_baf4p1_IOBUF_PD[18:0];
`endif   
                    
            if(temp_data !== GPIO_PD)begin
                `nnc_error("SOC TEST",$sformatf("o_baf4p1_IOBUF_PD = %h is not as expectation of GPIO_PD = %h",temp_data, GPIO_PD));
            end                 
            else  `nnc_info("SOC TEST",$sformatf("o_baf4p1_IOBUF_PD = %h is not as expectation of GPIO_PD = %h",temp_data, GPIO_PD),UVM_MEDIUM);

            if ({`SOC_TOP.u_iopad_testmode1.PD, `SOC_TOP.u_iopad_testmode0.PD} !== `DIG_TOP.spi_top_u.spi_reg_u.gpio_pd_testmode[1:0]) begin
                `nnc_error("SOC TEST",$sformatf("{`SOC_TOP.u_iopad_testmode1.PD, `SOC_TOP.u_iopad_testmode0.PD} = %h is not as expectation of TESTMODE[1:0] = %h", {`SOC_TOP.u_iopad_testmode1.PD, `SOC_TOP.u_iopad_testmode0.PD}, `DIG_TOP.spi_top_u.spi_reg_u.gpio_pd_testmode[1:0]));   
            end 

`ifdef POSTLAYOUT
            temp_data = {`SOC_TOP.u_iopad_gpio_18_.PU, 
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
                `SOC_TOP.u_iopad_gpio_7_.PU,
                `SOC_TOP.u_iopad_gpio_6_.PU,
                `SOC_TOP.u_iopad_gpio_5_.PU,
                `SOC_TOP.u_iopad_gpio_4_.PU,
                `SOC_TOP.u_iopad_gpio_3_.PU,
                `SOC_TOP.u_iopad_gpio_2_.PU,
                `SOC_TOP.u_iopad_gpio_1_.PU,
                `SOC_TOP.u_iopad_gpio_0_.PU};
`else
            temp_data = `DIG_TOP.u_gpio.o_baf4p1_IOBUF_PU[18:0];
`endif      

            if(temp_data !== GPIO_PU)begin
                `nnc_error("SOC TEST",$sformatf("o_baf4p1_IOBUF_PU = %h is not as expectation of GPIO_PU = %h",temp_data, GPIO_PU));
            end                 
            else  `nnc_info("SOC TEST",$sformatf("o_baf4p1_IOBUF_PU = %h is not as expectation of GPIO_PU = %h",temp_data, GPIO_PU),UVM_MEDIUM);    

`ifdef POSTLAYOUT
            temp_data = {`SOC_TOP.u_iopad_gpio_18_.CS, 
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
                `SOC_TOP.u_iopad_gpio_7_.CS,
                `SOC_TOP.u_iopad_gpio_6_.CS,
                `SOC_TOP.u_iopad_gpio_5_.CS,
                `SOC_TOP.u_iopad_gpio_4_.CS,
                `SOC_TOP.u_iopad_gpio_3_.CS,
                `SOC_TOP.u_iopad_gpio_2_.CS,
                `SOC_TOP.u_iopad_gpio_1_.CS,
                `SOC_TOP.u_iopad_gpio_0_.CS};
`else
            temp_data = `DIG_TOP.u_gpio.o_baf4p1_IOBUF_CS[18:0];
`endif 

            if(temp_data !== GPIO_CS)begin
                `nnc_error("SOC TEST",$sformatf("o_baf4p1_IOBUF_CS = %h is not as expectation of GPIO_CS = %h",temp_data, GPIO_CS));
            end                 
            else  `nnc_info("SOC TEST",$sformatf("o_baf4p1_IOBUF_CS = %h is not as expectation of GPIO_CS = %h",temp_data, GPIO_CS),UVM_MEDIUM);

`ifdef POSTLAYOUT
            temp_data = {`SOC_TOP.u_iopad_gpio_18_.SR, 
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
                `SOC_TOP.u_iopad_gpio_7_.SR,
                `SOC_TOP.u_iopad_gpio_6_.SR,
                `SOC_TOP.u_iopad_gpio_5_.SR,
                `SOC_TOP.u_iopad_gpio_4_.SR,
                `SOC_TOP.u_iopad_gpio_3_.SR,
                `SOC_TOP.u_iopad_gpio_2_.SR,
                `SOC_TOP.u_iopad_gpio_1_.SR,
                `SOC_TOP.u_iopad_gpio_0_.SR};
`else
            temp_data = `DIG_TOP.u_gpio.o_baf4p1_IOBUF_SR[18:0];
`endif 

            if(temp_data !== GPIO_SR)begin
                `nnc_error("SOC TEST",$sformatf("o_baf4p1_IOBUF_SR = %h is not as expectation of GPIO_SR = %h",temp_data, GPIO_SR));
            end 
            else  `nnc_info("SOC TEST",$sformatf("o_baf4p1_IOBUF_SR = %h is not as expectation of GPIO_SR = %h",temp_data, GPIO_SR),UVM_MEDIUM);

`ifdef POSTLAYOUT
            temp_data = {`SOC_TOP.u_iopad_gpio_18_.DR, 
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
                `SOC_TOP.u_iopad_gpio_7_.DR,
                `SOC_TOP.u_iopad_gpio_6_.DR,
                `SOC_TOP.u_iopad_gpio_5_.DR,
                `SOC_TOP.u_iopad_gpio_4_.DR,
                `SOC_TOP.u_iopad_gpio_3_.DR,
                `SOC_TOP.u_iopad_gpio_2_.DR,
                `SOC_TOP.u_iopad_gpio_1_.DR,
                `SOC_TOP.u_iopad_gpio_0_.DR};
`else
            temp_data = `DIG_TOP.u_gpio.o_baf4p1_IOBUF_DR[18:0];
`endif 

            if(temp_data !== GPIO_DR)begin
                `nnc_error("SOC TEST",$sformatf("o_baf4p1_IOBUF_DR = %h is not as expectation of GPIO_DR = %h",temp_data, GPIO_DR));
            end 
            else  `nnc_info("SOC TEST",$sformatf("o_baf4p1_IOBUF_DR = %h is not as expectation of GPIO_DR = %h",temp_data, GPIO_DR),UVM_MEDIUM);

`ifdef POSTLAYOUT
            temp_data = {`SOC_TOP.u_iopad_gpio_18_.OS, 
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
                `SOC_TOP.u_iopad_gpio_7_.OS,
                `SOC_TOP.u_iopad_gpio_6_.OS,
                `SOC_TOP.u_iopad_gpio_5_.OS,
                `SOC_TOP.u_iopad_gpio_4_.OS,
                `SOC_TOP.u_iopad_gpio_3_.OS,
                `SOC_TOP.u_iopad_gpio_2_.OS,
                `SOC_TOP.u_iopad_gpio_1_.OS,
                `SOC_TOP.u_iopad_gpio_0_.OS};
`else
            temp_data = `DIG_TOP.u_gpio.o_baf4p1_IOBUF_OS[18:0];
`endif 

            if(temp_data !== GPIO_OS)begin
                `nnc_error("SOC TEST",$sformatf("o_baf4p1_IOBUF_OS = %h is not as expectation of GPIO_OS = %h",temp_data, GPIO_OS));
            end 
            else  `nnc_info("SOC TEST",$sformatf("o_baf4p1_IOBUF_OS = %h is not as expectation of GPIO_OS = %h",temp_data, GPIO_OS),UVM_MEDIUM);

`ifdef POSTLAYOUT
            temp_data = {`SOC_TOP.u_iopad_gpio_18_.OD, 
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
                `SOC_TOP.u_iopad_gpio_7_.OD,
                `SOC_TOP.u_iopad_gpio_6_.OD,
                `SOC_TOP.u_iopad_gpio_5_.OD,
                `SOC_TOP.u_iopad_gpio_4_.OD,
                `SOC_TOP.u_iopad_gpio_3_.OD,
                `SOC_TOP.u_iopad_gpio_2_.OD,
                `SOC_TOP.u_iopad_gpio_1_.OD,
                `SOC_TOP.u_iopad_gpio_0_.OD};
`else
            temp_data = `DIG_TOP.u_gpio.o_baf4p1_IOBUF_OD[18:0];
`endif     

            if(temp_data !== GPIO_OD)begin
                `nnc_error("SOC TEST",$sformatf("o_baf4p1_IOBUF_OD = %h is not as expectation of GPIO_OD = %h",temp_data, GPIO_OD));
            end
            else  `nnc_info("SOC TEST",$sformatf("o_baf4p1_IOBUF_OD = %h is not as expectation of GPIO_OD = %h",temp_data, GPIO_OD),UVM_MEDIUM);
                                         
        end
    end
  endtask  

endclass : `TESTNAME
