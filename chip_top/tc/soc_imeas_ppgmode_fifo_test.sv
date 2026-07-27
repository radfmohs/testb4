/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_imeas_ppgmode_fifo_test.sv                                                   
// Project	: Nanochap BAF4P1                                  		        
// Description	: Testcase soc_imeas_ppgmode_fifo_test                                             
// Designer	: ophina@nanochap.com                                                                 
// Date		: 06-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_imeas_ppgmode_fifo_test
`define TESTCFG soc_imeas_ppgmode_fifo_test_cfg

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // -----------------------------------------------
  // Adding your new varialbles in config test
  // -----------------------------------------------
  rand logic [2:0]  cic_rate;
  rand logic [1:0]  imeas_input_format;
  rand logic [1:0]  ch_mode;
  rand logic        format_sel;
  rand logic [3:0]  ch_num;
  rand logic        int_en;
  rand logic [7:0]  fifo_sts;              
  rand logic [7:0]  ch0_len;
  rand logic [7:0]  ch1_len;
       logic [15:0] ch0_cic_arr[128];
       logic [15:0] ch1_cic_arr[128];
       logic [1:0]  filter_sel[128];//00: filter0;  01: filter1
  integer    cnt = 0;

  //------------------------------------------------------------------------------
  //---------------------------- SPI ---------------------------------------------
  rand logic [7:0] mask;
  rand logic [7:0] pads;
  rand logic [7:0] no_of_bytes;
  rand logic [7:0] no_of_elements;  
  rand logic [7:0] wr_data[256];
  rand logic [7:0] rd_data;
  rand logic [7:0] rd_data_reg[];
  rand logic [15:0] rd_data_fifo[];  
  
  //------------------------------------------------------------------------------
  // -----------------------------------------------
  // End of decalration of new variables 
  // -----------------------------------------------

  function new (string name = "soc_imeas_ppgmode_fifo_test_cfg");
    super.new(name);    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // top_test_cfg.top_test_cfg.pads values
  constraint c_pads           { soft pads == 8'h00; }
  // top_test_cfg.top_test_cfg.mask values
  constraint c_mask           { soft mask == 8'hFF; }
  // top_test_cfg.top_test_cfg.ch_mode values
  constraint c_ch_mode        { soft ch_mode == 1; }//single channel continous mode
  // top_test_cfg.top_test_cfg.ch_num values
  constraint c_ch_num         { soft ch_num inside {[0:0]}; }
  // top_test_cfg.top_test_cfg.format_sel values
  constraint c_format_sel     { soft format_sel == 0; }
  // top_test_cfg.top_test_cfg.int_en values
  constraint c_int_en         { soft int_en == 1'b0; }//interrupt enabled
  // top_test_cfg.top_test_cfg.cic_rate values
  constraint c_cic_rate       { soft cic_rate inside {[2:2]}; }
  // top_test_cfg.top_test_cfg.ch0_len values
  constraint c_ch0_len         { soft ch0_len == 8'b0; }
  // top_test_cfg.top_test_cfg.ch1_len values  
  constraint c_ch1_len         { soft ch1_len == 8'b0; }
  // top_test_cfg.top_test_cfg.fifo_sts values  
  constraint c_fifo_sts         { soft fifo_sts == 8'b0; }
  // top_test_cfg.top_test_cfg.imeas_ppg_en values
  constraint c_imeas_ppg_en   { soft imeas_ppg_en == 1'b1; }
  // -----------------------------------------------
  // End of adding constraints of randomization
  // -----------------------------------------------  
endclass : `TESTCFG

class `TESTNAME extends soc_base_test;

  `nnc_component_utils(`TESTNAME)

  `TESTCFG top_test_cfg;
   
  function new(string name, nnc_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(nnc_phase phase);
    super.build_phase(phase);
    uvm_top.set_timeout(10s);
    top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);
  endfunction

  virtual task pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);

    super.pre_reset_phase(phase);

    assert(top_test_cfg.randomize());
    `DUT_IF.imeas_ppg_en = top_test_cfg.imeas_ppg_en;
    // ==================
    // Scoreboard enables
    // ==================
    `SPI_SCB_EN = 1'b0;
    `ANALOG_SCOREBOARD_EN = 1'b0;

    phase.drop_objection(this);
  endtask : pre_reset_phase

  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_imeas_ppgmode_fifo_test start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ----------------------------------------------------------------------------------  
    `nnc_info("SOC_TEST",$sformatf("Simulation Begin!!!"),UVM_LOW);
    `nnc_info("SOC_TEST",$sformatf("Imeas single channel ppg mode fifo test"),UVM_LOW);
    fork
      collect_data();
    join_none
    do_run();
    
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

  virtual task do_run;
    begin
    
      force `SOC_TB.u_imeas_ch0_refmodel.ADCDec.decIA.Din = `ANA_TOP.A2D_SDM_OUT;//only ch0 & ch1 considered in this test
      force `SOC_TB.u_imeas_ch1_refmodel.ADCDec.decIA.Din = `ANA_TOP.A2D_SDM_OUT;//only ch0 & ch1 considered in this test

      top_test_cfg.wr_data[0] = 8'h18;
      //Set imeas clk div
      ////------------- to write in to the SOC_CLK_CTRL_REG reg--------------//
      `WR_NORMAL_REG(`SOC_CLK_CTRL_REG, top_test_cfg.wr_data[0], top_test_cfg.pads);//set adc_clk 16KHz

      //Enable IMEAS
      ////------------- to write in to the SOC_IMEAS_EN reg--------------//
      top_test_cfg.wr_data[0] = 8'h01;    
      `WR_NORMAL_REG(`SOC_IMEAS_EN,top_test_cfg.wr_data[0],top_test_cfg.pads);
      ///-------------to read from the SOC_IMEAS_EN reg-------------------//
      `RD_NORMAL_REG(`SOC_IMEAS_EN,top_test_cfg.pads,top_test_cfg.rd_data);

      //Check imeas enabled
      if(top_test_cfg.rd_data[0] !== top_test_cfg.wr_data[0][0])
	  `nnc_error("SOC_TEST", "[ERROR][0] imeas not enabled!")
      else
	  `nnc_info("SOC_TEST", "imeas enabled!", UVM_LOW)
       #1000;

      top_test_cfg.wr_data[0] = {6'b0,top_test_cfg.imeas_input_format};
      `nnc_info("SOC_TEST", $sformatf("imeas input format: (0x%x)",top_test_cfg.imeas_input_format),UVM_LOW)
      //Set IMEAS input format
      ////------------- to write in to the SOC_IMEAS_INPUT_FORMAT reg--------------//
      `WR_NORMAL_REG(`SOC_IMEAS_INPUT_FORMAT, top_test_cfg.wr_data[0], top_test_cfg.pads);
   
      `nnc_info("SOC_TEST", "Configure Imeas!", UVM_LOW)
      `nnc_info("SOC_TEST",$sformatf("CIC_RATE: %d", (32 * 2**top_test_cfg.cic_rate)),UVM_LOW)
      `nnc_info("SOC_TEST", "Enable imeas interrupt!", UVM_LOW)
      ////------------- to write in to the SOC_IMEAS_REG_CTRL_0 reg--------------// 
      top_test_cfg.wr_data[0] = {1'b1,top_test_cfg.cic_rate,3'b0,top_test_cfg.int_en};
      `WR_NORMAL_REG(`SOC_IMEAS_REG_CTRL_0,top_test_cfg.wr_data[0],top_test_cfg.pads);//ppg_mode bit[7] = 1

      #1000;
      `nnc_info("SOC_TEST", "Configure Channel!", UVM_LOW)
      ////------------- to write in to the SOC_IMEAS_MODE_REG reg--------------//     
      top_test_cfg.wr_data[0] = {top_test_cfg.ch_num,1'b0,top_test_cfg.format_sel,top_test_cfg.ch_mode};
      ////------------- to write in to the SOC_IMEAS_MODE_REG reg--------------//
      `WR_NORMAL_REG(`SOC_IMEAS_MODE_REG, top_test_cfg.wr_data[0], top_test_cfg.pads);

      #1000;
      `nnc_info("SOC_TEST", "-Enable fifo_full interrupt", UVM_LOW)
      ////------------- to write in to the SOC_FIFO_CONFIG_3_REG reg--------------//
      top_test_cfg.wr_data[0] = 8'h08;
      `WR_NORMAL_REG(`SOC_FIFO_CONFIG_3_REG, top_test_cfg.wr_data[0], top_test_cfg.pads);

       #1000;
       top_test_cfg.wr_data[0] = 8'h01;
       `nnc_info("SOC_TEST", "Config LED ON time!", UVM_LOW)
     ////------------- to write in to the SOC_PPG_LED_TIME_SEL reg--------------//
       `WR_NORMAL_REG(`SOC_PPG_LED_TIME_SEL, top_test_cfg.wr_data[0], top_test_cfg.pads);

       #1000;
       top_test_cfg.wr_data[0] = 8'h0A;
       `nnc_info("SOC_TEST", "Config LED frequency!", UVM_LOW)
     ////------------- to write in to the SOC_PPG_LED_FREQ_SEL reg--------------//
       `WR_NORMAL_REG(`SOC_PPG_LED_FREQ_SEL, top_test_cfg.wr_data[0], top_test_cfg.pads);

       #1000;
      `nnc_info("SOC_TEST", "-Enable PPG LED FSM", UVM_LOW)
      ////------------- to write in to the SOC_PPG_CTRL_1_REG reg--------------//
      top_test_cfg.wr_data[0] = 8'h01;
      `WR_NORMAL_REG(`SOC_PPG_CTRL_1_REG, top_test_cfg.wr_data[0], top_test_cfg.pads);

      `nnc_info("SOC_TEST", "-Start measure", UVM_LOW)
      ////------------- to write in to the SOC_IMEAS_REG_SEQ, reg--------------//
      top_test_cfg.wr_data[0] = 8'h00;
      `WR_NORMAL_REG(`SOC_IMEAS_REG_SEQ, top_test_cfg.wr_data[0], top_test_cfg.pads);

      //Wait for imeas interrupt
      wait(`SOC_TB.IOBUF_PAD[4] === 1'b1);

      `nnc_info("SOC_TEST", "-Stop filter", UVM_LOW)
      ////------------- to write in to the SOC_IMEAS_REG_SEQ, reg--------------//
      top_test_cfg.wr_data[0] = 8'h04;
      `WR_NORMAL_REG(`SOC_IMEAS_REG_SEQ, top_test_cfg.wr_data[0], top_test_cfg.pads);
      
      top_test_cfg.ch0_len = 0;
      top_test_cfg.ch1_len = 0;      
      ///-------------to read burst fifo data & status reg-------------------//
      for(int i = 0; i < 128; i++) begin
        // Get TAGs from Status register
        `RD_NORMAL_REG(`SOC_FIFO_STATUS_REG,top_test_cfg.pads,top_test_cfg.fifo_sts);
  	    // Read a burst from FIFO
  	    top_test_cfg.no_of_elements = 1;
  	    top_test_cfg.rd_data_fifo = new[top_test_cfg.no_of_elements];   
        `RD_BURST_FIFO_NO_TAG(top_test_cfg.no_of_elements,top_test_cfg.rd_data_fifo); 

  	    // Get TAGs from Status register
  	    // spi_rd_single_reg(`SOC_FIFO_STATUS_REG,pads,fifo_sts); 

        if(top_test_cfg.filter_sel[i] === 0) begin
  	    // Checking channel 0 tag
	        if(top_test_cfg.fifo_sts[1:0] !== 2'b00) begin
    	   	    `nnc_error("SOC_TEST",$sformatf("[ERROR][1] IMEAS channel 0 TAG obtained = %h, TAG expected = %h, i %d", top_test_cfg.fifo_sts[1:0],top_test_cfg.filter_sel[i],i));
	        end
	    // Checking channel 0 data
	        if(top_test_cfg.rd_data_fifo[0] !== top_test_cfg.ch0_cic_arr[top_test_cfg.ch0_len]) begin
    	   	    `nnc_error("SOC_TEST",$sformatf("[ERROR][2] IMEAS channel 0 DATA obtained = %h, DATA expected = %h, i %d", top_test_cfg.rd_data_fifo[0], top_test_cfg.ch0_cic_arr[top_test_cfg.ch0_len],i));
	        end
	        top_test_cfg.ch0_len = top_test_cfg.ch0_len + 1;
  	    end 
        else begin
  	    // Checking channel 1 tag
	        if(top_test_cfg.fifo_sts[1:0] !== 2'b01) begin
    	   	    `nnc_error("SOC_TEST",$sformatf("[ERROR][3] IMEAS channel 1 TAG obtained = %h, TAG expected = %h, i %d", top_test_cfg.fifo_sts[1:0],top_test_cfg.filter_sel[i],i));
	        end
    	// Checking channel 1 data
	        if(top_test_cfg.rd_data_fifo[0] !== top_test_cfg.ch1_cic_arr[top_test_cfg.ch1_len]) begin
    	   	    `nnc_error("SOC_TEST",$sformatf("[ERROR][4] IMEAS channel 1 DATA obtained = %h, DATA expected = %h, i %d", top_test_cfg.rd_data_fifo[0], top_test_cfg.ch1_cic_arr[top_test_cfg.ch1_len],i));
	        end
	        top_test_cfg.ch1_len = top_test_cfg.ch1_len + 1;
  	    end     
      end    
    end
  endtask

  task collect_data();
    forever begin
      @(posedge `IMEAS_TOP.chdata_en_n);
`ifdef POWER_PINS
      #50;
`else
      #1;
`endif
      if(!`ANA_TOP.D2A_PPG_SH_CK&&!`SOC_TB.IOBUF_PAD[18] || `ANA_TOP.D2A_PPG_SH_CK&&`SOC_TB.IOBUF_PAD[18]) begin
         top_test_cfg.ch0_cic_arr[top_test_cfg.ch0_len] = `IMEAS_TOP.ch0data;
         `DUT_IF.ch0_cic_arr[top_test_cfg.ch0_len] = top_test_cfg.ch0_cic_arr[top_test_cfg.ch0_len];
         top_test_cfg.filter_sel[top_test_cfg.cnt] = 2'b00;
         `DUT_IF.filter_sel[top_test_cfg.cnt] = top_test_cfg.filter_sel[top_test_cfg.cnt];
         top_test_cfg.ch0_len = top_test_cfg.ch0_len + 1;
         if(`IMEAS_TOP.u_imeas_cic_0.eoc_out/*sd16eoc_0*/ === 0) begin
       	    `nnc_error("SOC_TEST",$sformatf("Unexpected IMEAS channel 0 data en!!!"));
         end
      end
      if(!`ANA_TOP.D2A_PPG_SH_CK&&`SOC_TB.IOBUF_PAD[18] || `ANA_TOP.D2A_PPG_SH_CK&&!`SOC_TB.IOBUF_PAD[18]) begin
         top_test_cfg.ch1_cic_arr[top_test_cfg.ch1_len] = `IMEAS_TOP.ch1data;
         `DUT_IF.ch1_cic_arr[top_test_cfg.ch1_len] = top_test_cfg.ch1_cic_arr[top_test_cfg.ch1_len];
         top_test_cfg.filter_sel[top_test_cfg.cnt] = 2'b01;
         `DUT_IF.filter_sel[top_test_cfg.cnt] = top_test_cfg.filter_sel[top_test_cfg.cnt];
         top_test_cfg.ch1_len = top_test_cfg.ch1_len + 1;
         if(`IMEAS_TOP.sd16eoc_1 === 0) begin
       	    `nnc_error("SOC_TEST",$sformatf("Unexpected IMEAS channel 1 data en!!!"));
         end
      end
      top_test_cfg.cnt = top_test_cfg.cnt + 1;
    end
  endtask
      
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME
