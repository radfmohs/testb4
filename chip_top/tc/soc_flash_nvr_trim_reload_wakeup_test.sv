/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_flash_nvr_trim_reload_wakeup_test.sv                                                   
// Project	: Nanochap ENS1P4                                  		        
// Description	: Testcase soc_flash_nvr_trim_reload_wakeup_test                                             
// Designer	: ophina@nanochap.com                                                                 
// Date		: 29-11-1623                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_flash_nvr_trim_reload_wakeup_test
`define TESTCFG soc_flash_nvr_trim_reload_wakeup_test_cfg

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // -----------------------------------------------
  // Adding your new varialbles in config test
  // -----------------------------------------------
  rand logic [7:0] flash_debug_status;
  rand logic [7:0] ana_trim_data[21];
  rand logic [7:0] exp_ana_trim[21];
  rand logic [7:0] config_data[8];

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

  function new (string name = "soc_flash_nvr_trim_reload_wakeup_test_cfg");
    super.new(name);    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // top_test_cfg.pads values
  constraint c_pad        { soft pad == 8'h00; }
  // top_test_cfg.mask values
  constraint c_mask        { soft mask == 8'hFF; }
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
 
    `SPI_SCB_EN = 1'b0;

    // ==================
    // Scoreboard enables
    // ==================

    phase.drop_objection(this);
  endtask : pre_reset_phase

  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_flash_nvr_trim_reload_wakeup_test start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ----------------------------------------------------------------------------------  
    `nnc_info("SOC_TEST",$sformatf("Simulation Begin!!!"),UVM_LOW);
    `nnc_info("SOC_TEST",$sformatf("flash ana-trim reload on wakeup test"),UVM_LOW);
    wait(`RESETN);
    do_run;
    
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

  virtual task do_run;
    begin
        top_test_cfg.exp_ana_trim[0]  = `SOC_FLASH_TRIMDATA0_RELOAD_INIT;
        top_test_cfg.exp_ana_trim[1]  = `SOC_FLASH_TRIMDATA1_RELOAD_INIT;
        top_test_cfg.exp_ana_trim[2]  = `SOC_FLASH_TRIMDATA2_RELOAD_INIT;
        top_test_cfg.exp_ana_trim[3]  = `SOC_FLASH_TRIMDATA3_RELOAD_INIT;
        top_test_cfg.exp_ana_trim[4]  = `SOC_FLASH_TRIMDATA4_RELOAD_INIT;
        top_test_cfg.exp_ana_trim[5]  = `SOC_FLASH_TRIMDATA5_RELOAD_INIT;
        top_test_cfg.exp_ana_trim[6]  = `SOC_FLASH_TRIMDATA6_RELOAD_INIT;
        top_test_cfg.exp_ana_trim[7]  = `SOC_FLASH_TRIMDATA7_RELOAD_INIT;
        top_test_cfg.exp_ana_trim[8]  = `SOC_FLASH_TRIMDATA8_RELOAD_INIT;
        top_test_cfg.exp_ana_trim[9]  = `SOC_FLASH_TRIMDATA9_RELOAD_INIT;
        top_test_cfg.exp_ana_trim[10] = `SOC_FLASH_TRIMDATA10_RELOAD_INIT;
        top_test_cfg.exp_ana_trim[11] = `SOC_FLASH_TRIMDATA11_RELOAD_INIT;
        top_test_cfg.exp_ana_trim[12] = `SOC_FLASH_TRIMDATA12_RELOAD_INIT;
        top_test_cfg.exp_ana_trim[13] = `SOC_FLASH_TRIMDATA13_RELOAD_INIT;
        top_test_cfg.exp_ana_trim[14] = `SOC_FLASH_TRIMDATA14_RELOAD_INIT;
        top_test_cfg.exp_ana_trim[15] = `SOC_FLASH_TRIMDATA15_INIT;
        top_test_cfg.exp_ana_trim[16] = `SOC_FLASH_TRIMDATA16_INIT;
        top_test_cfg.exp_ana_trim[17] = `SOC_FLASH_TRIMDATA17_INIT;
        top_test_cfg.exp_ana_trim[18] = `SOC_FLASH_TRIMDATA18_INIT;
        top_test_cfg.exp_ana_trim[19] = `SOC_FLASH_TRIMDATA19_INIT;
        top_test_cfg.exp_ana_trim[20] = `SOC_FLASH_TRIMDATA20_INIT;

        // Waiting for Flash asserted recall_done to program       
        wait(`DUT_IF.flash_recall_done); 
                 
       top_test_cfg.flash_debug_status = 8'h00;
        //wait (!`SPI_TOP.FLASH_CONFEN);
        //`RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
        //while (top_test_cfg.flash_debug_status[0]===0) begin
	    //    `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
        //end
        //`nnc_info("SOC_TEST",$sformatf("\tFlash conf set start"),UVM_LOW);
        //while (top_test_cfg.flash_debug_status[0]===1) begin
	    //    `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
        //end
        `nnc_info("SOC_TEST",$sformatf("\tFlash conf set done"),UVM_LOW);

       for(int i=0; i<=7; i++) begin
        top_test_cfg.config_data[i] = `SOC_TOP.u_top_dig.flash_ctrl_top_inst.u_32k.fuse_reg[i];
        `nnc_info("SOC_TEST",$sformatf("\tconfig_reg data_%d: (0x%x)\n", i, top_test_cfg.config_data[i]),UVM_LOW);
        if(top_test_cfg.config_data[i] != (8'h10+i)) begin
         `nnc_error("SOC_TEST",$sformatf("\tERROR!!! CONFIG DATA MISMATCH!!!"));
        end
       end

       //wait (!`SPI_TOP.FLASH_BUSY);
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       while (top_test_cfg.flash_debug_status[6] === 1) begin
	`RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       end
       `nnc_info("SOC_TEST",$sformatf("\tFlash reset done!"),UVM_LOW);

     //Read Ana Trim values stored in customer reserved space of NVR1
      ///-------------to read burst starting from the SOC_FLASH_TRIMDATA0 reg-------------------//
       top_test_cfg.no_of_bytes = 8'h0F;
       top_test_cfg.rd_data_reg = new[top_test_cfg.no_of_bytes];
       `RD_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA0, top_test_cfg.no_of_bytes, top_test_cfg.rd_data_reg);
       for(int i=0; i<top_test_cfg.no_of_bytes; i++) begin
	top_test_cfg.ana_trim_data[i] = top_test_cfg.rd_data_reg[(top_test_cfg.no_of_bytes-1)-i];
	`nnc_info("SOC_TEST",$sformatf("\tana trim data_%d: (0x%x)\n", i, top_test_cfg.ana_trim_data[i]),UVM_LOW);
        if(top_test_cfg.ana_trim_data[i] !== top_test_cfg.exp_ana_trim[i]) begin
          `nnc_error("SOC_TEST",$sformatf("\tERROR!!! ANA-TRIM%0d VALUE MISMATCH!!!", i));
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
          `nnc_error("SOC_TEST",$sformatf("\tERROR!!! SPARE-TRIM%0d VALUE MISMATCH!!!", i));
        end
       end

       `nnc_info("SOC_TEST",$sformatf("\n Enter Low power mode"),UVM_LOW);
       force `ANA_TOP.PMU_SW.wakeup=0;
       #1000000
       `nnc_info("SOC_TEST",$sformatf("\n Enter Active mode"),UVM_LOW);
       release `ANA_TOP.PMU_SW.wakeup;

       wait(`RESETN);

      //wait (!`SPI_TOP.FLASH_BUSY);
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       while (top_test_cfg.flash_debug_status[6] === 1) begin
	`RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       end
       `nnc_info("SOC_TEST",$sformatf("\tFlash reset done!"),UVM_LOW);

     //Read Ana Trim values stored in customer reserved space of NVR1
      ///-------------to read burst starting from the SOC_FLASH_TRIMDATA0 reg-------------------//
       top_test_cfg.no_of_bytes = 8'h0F;
       top_test_cfg.rd_data_reg = new[top_test_cfg.no_of_bytes];
       `RD_BURST_NORMAL_REG(`SOC_FLASH_TRIMDATA0, top_test_cfg.no_of_bytes, top_test_cfg.rd_data_reg);
       for(int i=0; i<top_test_cfg.no_of_bytes; i++) begin
	top_test_cfg.ana_trim_data[i] = top_test_cfg.rd_data_reg[(top_test_cfg.no_of_bytes-1)-i];
	`nnc_info("SOC_TEST",$sformatf("\tana trim data_%d: (0x%x)\n", i, top_test_cfg.ana_trim_data[i]),UVM_LOW);
        if(top_test_cfg.ana_trim_data[i] !== top_test_cfg.exp_ana_trim[i]) begin
          `nnc_error("SOC_TEST",$sformatf("\tERROR!!! ANA-TRIM%0d VALUE MISMATCH!!!", i));
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
          `nnc_error("SOC_TEST",$sformatf("\tERROR!!! SPARE-TRIM%0d VALUE MISMATCH!!!", i));
        end
       end
    end
  endtask
     
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME
