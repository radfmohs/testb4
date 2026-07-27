/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_gpio_pd_test.sv                                                   
// Project	: Nanochap BPS1                                  		        
// Description	: Testcase soc_pinmux_normalmode_test                                             
// Designer	: ddang@nanochap.com                                                                 
// Date		: 29-11-1623                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_gpio_pd_test
`define TESTCFG soc_gpio_pd_test_cfg

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

  function new (string name = "soc_gpio_pd_test_cfg");
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

        for (int i=0; i < 100; i++) begin    
            force `DIG_TOP.spi_top_u.spi_reg_u.gpio_pd_testmode[1:0] = 2'h3;

            GPIO_PD = 19'b0;

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

            if ({`SOC_TOP.u_iopad_testmode1.PD, `SOC_TOP.u_iopad_testmode0.PD} !== `DIG_TOP.spi_top_u.spi_reg_u.gpio_pd_testmode[1:0]) begin
                `nnc_error("SOC TEST",$sformatf("{`SOC_TOP.u_iopad_testmode1.PD, `SOC_TOP.u_iopad_testmode0.PD} = %h is not as expectation of TESTMODE[1:0] = %h", {`SOC_TOP.u_iopad_testmode1.PD, `SOC_TOP.u_iopad_testmode0.PD}, `DIG_TOP.spi_top_u.spi_reg_u.gpio_pd_testmode[1:0]));   
            end                
                           
        end
    end
  endtask  

endclass : `TESTNAME
