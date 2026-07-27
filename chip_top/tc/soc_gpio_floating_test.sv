`define TESTNAME soc_gpio_floating_test
`define TESTCFG soc_gpio_floating_test_cfg

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // -----------------------------------------------
  // Adding your new varialbles in config test
  // -----------------------------------------------
  rand logic [7:0] rd_data;
  rand logic [7:0] no_of_bytes;
  rand logic [7:0] rd_data_reg[];
  rand logic [7:0] wr_data_reg[];
  rand logic [7:0] mask;
  rand logic [2:0] pu_ctrl;
  rand logic [0:0] pu_resetn;
  rand logic [1:0] pd_testmode;
  rand logic [7:0] init_value;
  rand logic [7:0] pads;  
  // -----------------------------------------------
  // End of decalration of new variables 
  // -----------------------------------------------

  function new (string name = "soc_gpio_floating_test_cfg");
    super.new(name);
    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // testmode_sel[1:0] : 00-Normal mode, 01: Scanmode, 10: BIST mode, 11 atm0/1/2/3/4
  constraint c_testmode_sel { soft testmode_sel == 2'b00; }

  // chipmode_sel[1:0] : 2'b00-ADD0 to GND, 2'b01-ADD0 to V+, 2'b10-ADD0 to SDA, 2'b11-ADD0 to SCL 
  // constraint c_spimode_sel { spimode_sel == 2'b00; }

  constraint c_no_of_bytes { soft no_of_bytes == 2; }
  constraint c_pclk_sel    { soft pclk_sel inside {[0:3]};}

  // top_test_cfg.pads values
  constraint c_pads        { soft pads == 8'h00; }
  // top_test_cfg.mask values
  constraint c_mask        { soft mask == 8'hFF; }

  // -----------------------------------------------
  // End of adding constraints of randomization
  // -----------------------------------------------

endclass : `TESTCFG

class `TESTNAME extends soc_base_test;
    static bit rand_bit;   
    static logic [20:0] rand_num;

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

    `nnc_info("SOC_TEST", "soc_gpio_floating_test start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    // This is sample to write a data to Register
    `nnc_info("BISTMODE","Internal clock test",UVM_MEDIUM) 

    do_run;
            
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

  virtual task do_run;
    begin
`ifdef POSTLAYOUT    
      `nnc_info("SOC_TEST", "soc_gpio_floating_test start", UVM_LOW)

      force soc_top_tb.iopad_resetn = 0;
      #100000ns;   
      release soc_top_tb.iopad_resetn;
      #1000us;
    
      if (`SOC_TOP.IOBUF_PAD[2:0] !== 3'b111) begin
        `nnc_error("BISTMODE",$sformatf("IOBUF_PAD[2:0] = %b is not as expectation = %b",`SOC_TOP.IOBUF_PAD[2:0], 3'b111));
      end

      if (`SOC_TB.ext_resetn !== 1'b1) begin
        `nnc_error("BISTMODE",$sformatf("ext_resetn = %b is not as expectation = %b",`SOC_TB.ext_resetn, 1'b1));
      end

      if (`SOC_TB.TESTMODE[1:0] !== 2'b00) begin
        `nnc_error("BISTMODE",$sformatf("TESTMODE[1:0] = %b is not as expectation = %b",`SOC_TB.TESTMODE[1:0], 2'b00));
      end
     
   
      #1000ns;   
      // CHECK DEFAULT VALUE IN DEFAULT OPTION ENABLE
      force soc_top_tb.iopad_resetn = 0;
      #100000ns;   
      release soc_top_tb.iopad_resetn;
      #1000us;
      
      top_test_cfg.init_value = 8'h0;
      `WR_NORMAL_REG(`SOC_GPIO_PU_CTR, top_test_cfg.init_value, top_test_cfg.pads); //GPIO_PU_CTRL

      top_test_cfg.init_value = 8'h0;
      `WR_NORMAL_REG(`SOC_GPIO_PU_RESETN, top_test_cfg.init_value, top_test_cfg.pads); //GPIO_PU_RESETn

      top_test_cfg.init_value = 8'h0;
      `WR_NORMAL_REG(`SOC_GPIO_PD_TESTMODE, top_test_cfg.init_value, top_test_cfg.pads); //SOC_GPIO_PD_TESTMODE 

      if (`SOC_TOP.IOBUF_PAD[2:0] !== 3'bzzz) begin
        `nnc_error("BISTMODE",$sformatf("IOBUF_PAD[2:0] = %b is not as expectation = %b",`SOC_TOP.IOBUF_PAD[2:0], 3'bzzz));
      end

      if (`SOC_TB.ext_resetn !== 1'bz) begin
        `nnc_error("BISTMODE",$sformatf("ext_resetn = %b is not as expectation = %b",`SOC_TB.ext_resetn, 1'bz));
      end

      if (`SOC_TB.TESTMODE[1:0] !== 2'bzz) begin
        `nnc_error("BISTMODE",$sformatf("TESTMODE[1:0] = %b is not as expectation = %b",`SOC_TB.TESTMODE[1:0], 2'bzz));
      end
`endif     
    end
  endtask  

  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME

