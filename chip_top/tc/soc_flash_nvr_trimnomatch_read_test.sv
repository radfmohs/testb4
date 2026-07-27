/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_flash_nvr_trimnomatch_read_test.sv                                                   
// Project	: Nanochap ENS1P4                                  		        
// Description	: Testcase soc_flash_nvr_trimnomatch_read_test                                             
// Designer	: ophina@nanochap.com                                                                 
// Date		: 29-11-1623                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_flash_nvr_trimnomatch_read_test
`define TESTCFG soc_flash_nvr_trimnomatch_read_test_cfg

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // -----------------------------------------------
  // Adding your new varialbles in config test
  // -----------------------------------------------
  rand logic [7:0] flash_debug_status;
  rand logic [7:0] ana_trim_data[21];
  rand logic [7:0] exp_ana_trim[21];
  //------------------------------------------------------------------------------
  //---------------------------- SPI ---------------------------------------------
  rand logic [7:0] mask;
  rand logic [7:0] pad;
  rand logic [7:0] no_of_bytes;
  rand logic [7:0] rd_data;
  rand logic [7:0] rd_data_reg[];
  //------------------------------------------------------------------------------
  // -----------------------------------------------
  // End of decalration of new variables 
  // -----------------------------------------------

  function new (string name = "soc_flash_nvr_trimnomatch_read_test_cfg");
    super.new(name);    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // top_test_cfg.pads values
  constraint c_pad        { soft pad == 8'h00; }
  // top_test_cfg.mask values
  constraint c_mask        { soft mask == 8'hFF; }
  // top_test_cfg.disable_init_flash values
  constraint c_disable_init_flash     { soft disable_init_flash == 1'b1;}
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
    uvm_top.set_timeout(2s);
    top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);
  endfunction

  virtual task pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);

    super.pre_reset_phase(phase);

    assert(top_test_cfg.randomize());

    `DUT_IF.disable_init_flash = top_test_cfg.disable_init_flash;
 
    `SPI_SCB_EN = 1'b0;
    #50;
    $readmemh("./inf1_tagnomatch.hex", `FLASH_TOP.u_32k.inf1_mem);
    // ==================
    // Scoreboard enables
    // ==================

    phase.drop_objection(this);
  endtask : pre_reset_phase

  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_flash_nvr_trimnomatch_read_test start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ----------------------------------------------------------------------------------  
    `nnc_info("SOC_TEST",$sformatf("Simulation Begin!!!"),UVM_LOW);
    `nnc_info("SOC_TEST",$sformatf("flash nvr read function trim_tag not match"),UVM_LOW);
    wait(`RESETN);
    do_run;
    
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

  virtual task do_run;
    begin
        top_test_cfg.exp_ana_trim[0]  = 8'h00;
        top_test_cfg.exp_ana_trim[1]  = 8'h00;
        top_test_cfg.exp_ana_trim[2]  = 8'h00;
        top_test_cfg.exp_ana_trim[3]  = 8'h00;
        top_test_cfg.exp_ana_trim[4]  = 8'h00;
        top_test_cfg.exp_ana_trim[5]  = 8'h00;
        top_test_cfg.exp_ana_trim[6]  = 8'h00;
        top_test_cfg.exp_ana_trim[7]  = 8'h00;
        top_test_cfg.exp_ana_trim[8]  = 8'h00;
        top_test_cfg.exp_ana_trim[9]  = 8'h00;
        top_test_cfg.exp_ana_trim[10] = 8'h00;
        top_test_cfg.exp_ana_trim[11] = 8'h00;
        top_test_cfg.exp_ana_trim[12] = 8'h00;
        top_test_cfg.exp_ana_trim[13] = 8'h00;
        top_test_cfg.exp_ana_trim[14] = 8'h00;
        top_test_cfg.exp_ana_trim[15] = 8'h00;
        top_test_cfg.exp_ana_trim[16] = 8'h00;
        top_test_cfg.exp_ana_trim[17] = 8'h00;
        top_test_cfg.exp_ana_trim[18] = 8'h00;
        top_test_cfg.exp_ana_trim[19] = 8'h00;
        top_test_cfg.exp_ana_trim[20] = 8'h00;

        // Waiting for Flash asserted recall_done to program       
        //wait(`DUT_IF.flash_recall_done); 
                 
       top_test_cfg.flash_debug_status = 8'h00;

       //wait (!`SPI_TOP.FLASH_BUSY);
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       while (top_test_cfg.flash_debug_status[6] === 1) begin
	`RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       end
       `nnc_info("SOC_TEST",$sformatf("\tFlash busy = 0"),UVM_LOW);

       //wait (`SPI_TOP.TRIM_INVALID);
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       while (top_test_cfg.flash_debug_status[7] === 0) begin
	        `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       end
       `nnc_info("SOC_TEST",$sformatf("\tInvalid Trim detected!!!"),UVM_LOW);

       `RD_NORMAL_REG(`SOC_FLASH_DEBUG1,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       if(top_test_cfg.flash_debug_status != 8'h43) begin
            `nnc_error("SOC_TEST",$sformatf("\tERROR!!! Unexpected debug status!"));
       end

     //Read Ana Trim values stored in customer reserved space of NVR1
      ///-------------to read burst starting from the SOC_FLASH_TRIMDATA0 reg-------------------//
       top_test_cfg.no_of_bytes = 8'h0F;
       top_test_cfg.rd_data_reg = new[top_test_cfg.no_of_bytes];
       `RD_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA0, top_test_cfg.no_of_bytes, top_test_cfg.rd_data_reg);
       for(int i=0; i<top_test_cfg.no_of_bytes; i++) begin
	top_test_cfg.ana_trim_data[i] = top_test_cfg.rd_data_reg[(top_test_cfg.no_of_bytes-1)-i];
	`nnc_info("SOC_TEST",$sformatf("\tana trim data_%d: (0x%x)\n", i, top_test_cfg.ana_trim_data[i]),UVM_LOW);
        if(top_test_cfg.ana_trim_data[i] !== top_test_cfg.exp_ana_trim[i]) begin
          `nnc_error("SOC_TEST",$sformatf("\tERROR!!! UNEXPECTED ANA-TRIM%0d VALUE LOAD!!!", i));
        end
       end
      ///-------------to read burst starting from the SOC_FLASH_TRIMDATA15 reg-------------------//
       top_test_cfg.no_of_bytes = 8'h06;
       top_test_cfg.rd_data_reg = new[top_test_cfg.no_of_bytes];
       `RD_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA15, top_test_cfg.no_of_bytes, top_test_cfg.rd_data_reg);
       for(int i=0; i<top_test_cfg.no_of_bytes; i++) begin
	top_test_cfg.ana_trim_data[i] = top_test_cfg.rd_data_reg[(top_test_cfg.no_of_bytes-1)-i];
	`nnc_info("SOC_TEST",$sformatf("\tana trim data_%d: (0x%x)\n", i, top_test_cfg.ana_trim_data[i]),UVM_LOW);
        if(top_test_cfg.ana_trim_data[i] !== top_test_cfg.exp_ana_trim[i+15]) begin
          `nnc_error("SOC_TEST",$sformatf("\tERROR!!! UNEXPECTED SPARE-TRIM%0d VALUE LOAD!!!", i));
        end
       end
    end
  endtask
     
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME
