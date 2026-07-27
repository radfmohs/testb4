/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_gpio_od_test.sv                                                   
// Project	: Nanochap BPS1                                  		        
// Description	: Testcase soc_pinmux_normalmode_test                                             
// Designer	: ddang@nanochap.com                                                                 
// Date		: 29-11-1623                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_gpio_od_test
`define TESTCFG soc_gpio_od_test_cfg

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

  function new (string name = "soc_gpio_od_test_cfg");
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
    #50us;
    do_run;
            
    phase.drop_objection(this);
  endtask: main_phase 
  
  virtual task do_run;
    logic [18:0] temp_data;
    begin
        force `SOC_TB.IOBUF_PAD[9:6] = 4'b0;
        //`DUT_IF.soc_resetn = 1'b0;
        //#1000ns;
        //`DUT_IF.soc_resetn = 1'b1;        
        #1000ns;

        for (int i=0; i < 100; i++) begin    
              
            GPIO_OD = 19'b0;

            #100ns;

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
                            
        end
    end
  endtask  

endclass : `TESTNAME
