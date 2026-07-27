/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_flash_nvr_bistwrite_trim_reload_wakeup_test.sv                                                   
// Project	: Nanochap ENS1P4                                  		        
// Description	: Testcase soc_flash_nvr_bistwrite_trim_reload_wakeup_test                                             
// Designer	: ophina@nanochap.com                                                                 
// Date		: 29-11-1623                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_flash_nvr_bistwrite_trim_reload_wakeup_test
`define TESTCFG soc_flash_nvr_bistwrite_trim_reload_wakeup_test_cfg

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

  function new (string name = "soc_flash_nvr_bistwrite_trim_reload_wakeup_test_cfg");
    super.new(name);    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // top_test_cfg.pads values
  constraint c_pad        { soft pad == 8'h00; }
  // top_test_cfg.mask values
  constraint c_mask        { soft mask == 8'hFF; }
  // top_test_cfg.exp_ana_trim values
  constraint c_exp_ana_trim { exp_ana_trim[0] == 8'h5A; }//valid trim
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
 
    `SPI_SCB_EN = 1'b0;

    // ==================
    // Scoreboard enables
    // ==================

    phase.drop_objection(this);
  endtask : pre_reset_phase

  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_flash_nvr_bistwrite_trim_reload_wakeup_test start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ----------------------------------------------------------------------------------  
    `nnc_info("SOC_TEST",$sformatf("Simulation Begin!!!"),UVM_LOW);
    `nnc_info("SOC_TEST",$sformatf("flash bist-write ana-trim reload on wakeup test"),UVM_LOW);
    wait(`RESETN);
    do_run;
    
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

  virtual task do_run;
    begin
/*    
        top_test_cfg.exp_ana_trim[0]  = 8'h5A;//valid trim
        top_test_cfg.exp_ana_trim[1]  = 8'h19;
        top_test_cfg.exp_ana_trim[2]  = 8'h45;
        top_test_cfg.exp_ana_trim[3]  = 8'h03;
        top_test_cfg.exp_ana_trim[4]  = 8'h27;
        top_test_cfg.exp_ana_trim[5]  = 8'h10;
        top_test_cfg.exp_ana_trim[6]  = 8'h11;
        top_test_cfg.exp_ana_trim[7]  = 8'h22;
        top_test_cfg.exp_ana_trim[8]  = 8'h33;
        top_test_cfg.exp_ana_trim[9]  = 8'h44; 
        top_test_cfg.exp_ana_trim[10] = 8'h55;
        top_test_cfg.exp_ana_trim[11] = 8'h66;
        top_test_cfg.exp_ana_trim[12] = 8'h77;
        top_test_cfg.exp_ana_trim[13] = 8'h88;
        top_test_cfg.exp_ana_trim[14] = 8'h99;
        top_test_cfg.exp_ana_trim[15] = 8'hAA;// spare
        top_test_cfg.exp_ana_trim[16] = 8'hBB;// spare
        top_test_cfg.exp_ana_trim[17] = 8'hCC;// spare
        top_test_cfg.exp_ana_trim[18] = 8'hDD;// spare
        top_test_cfg.exp_ana_trim[19] = 8'hEE;// spare
        top_test_cfg.exp_ana_trim[20] = 8'hFF;// spare
*/
       // Waiting for Flash asserted recall_done to program       
       wait(`DUT_IF.flash_recall_done); 

       `nnc_info("SOC_TEST",$sformatf("\n BISTMODE: Write Ana-Trim values to NVR1"),UVM_LOW);
       `FLASH_BIST_MASTER_TOP.TESTMODE_SEL = 2'b10;
 
       `nnc_info("SOC_TEST",$sformatf("[FLASH BIST MASTER][0] Sending Reset Command to Flash at Time"),UVM_LOW);
       `FLASH_BIST_MASTER_TOP.reset;
       `nnc_info("SOC_TEST",$sformatf("[FLASH BIST MASTER] Complete successully this phase at Time"),UVM_LOW); 

       @(posedge `FLASH_BIST_MASTER_TOP.TCK);

       `nnc_info("SOC_TEST",$sformatf("[FLASH BIST MASTER][1] Sending Serial Erase Command to to erase NVR of Flash at Time"),UVM_LOW);
       `FLASH_BIST_MASTER_TOP.serase_1st_NVR_10M;
       `nnc_info("SOC_TEST",$sformatf("[FLASH BIST MASTER] Complete successully this phase at Time"),UVM_LOW);

       for (int i=0; i < 21;  i++) begin
         `nnc_info("SOC_TEST",$sformatf("[FLASH BIST MASTER][2] Sending Program Command to program NVR ADDR: %h with DATA: %h, at time", i, top_test_cfg.exp_ana_trim[i]),UVM_LOW);
         `FLASH_BIST_MASTER_TOP.prgm_word_NVR_10M(i, top_test_cfg.exp_ana_trim[i]);
          `nnc_info("SOC_TEST",$sformatf("[FLASH BIST MASTER] Complete successully this phase at Time"),UVM_LOW);
       end

        for (int j=0; j < 21;  j++) begin
         `nnc_info("SOC_TEST",$sformatf("[FLASH BIST MASTER][2] Sending Read Command to read NVR addr:%h of Flash", j),UVM_LOW);
         `FLASH_BIST_MASTER_TOP.read_nvr_word_10M(j, top_test_cfg.rd_data);

         if (top_test_cfg.rd_data !== top_test_cfg.exp_ana_trim[j]) begin
           `nnc_error("SOC_TEST",$sformatf("\tERROR WR_DATA:%0d is not equal RD_DATA:%d", top_test_cfg.exp_ana_trim[j], top_test_cfg.rd_data));
         end

         `nnc_info("SOC_TEST",$sformatf("[FLASH BIST MASTER] Complete successully this phase at Time"),UVM_LOW);
       end

       `nnc_info("SOC_TEST",$sformatf("\n Enter NORMAL MODE"),UVM_LOW);
       `FLASH_BIST_MASTER_TOP.TESTMODE_SEL = 2'b00;

       `nnc_info("SOC_TEST",$sformatf("\n ALWAYS_ON VDD is OFF"),UVM_LOW);
       force `ANA_TOP.VDD_DIG_AO=0;
       #100000;
       `nnc_info("SOC_TEST",$sformatf("\n ALWAYS_ON VDD is ON"),UVM_LOW);
       release `ANA_TOP.VDD_DIG_AO;
       `nnc_info("SOC_TEST",$sformatf("\n Wait for RESET Always-ON domain"),UVM_LOW);
       #1000;
//`ifndef POSTLAYOUT_PG
       wait(`ALWAYSON_RESETN);
//`else
//       wait(!`ALWAYSON_RST_CTRL.OUT0);
//`endif
       `nnc_info("SOC_TEST",$sformatf("\n RESET Switchable domain"),UVM_LOW);
       #10000
       `SOC_TB.ext_resetn=0;
       #100000
       `SOC_TB.ext_resetn=1;

       wait(`RESETN);

       top_test_cfg.flash_debug_status = 8'h00;
       //wait (`SPI_TOP.FLASH_CONFEN);
       //`RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       //while (top_test_cfg.flash_debug_status[0]===0) begin
	   //     `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       //end
       //`nnc_info("SOC_TEST",$sformatf("\tFlash conf set start"),UVM_LOW);
       //wait (!`SPI_TOP.FLASH_CONFEN);
       //while (top_test_cfg.flash_debug_status[0]===1) begin
	   //     `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       //end
       //`nnc_info("SOC_TEST",$sformatf("\tFlash conf set done"),UVM_LOW);
 
       //wait (!`SPI_TOP.FLASH_BUSY);
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       while (top_test_cfg.flash_debug_status[6] === 1) begin
	        `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       end
       `nnc_info("SOC_TEST",$sformatf("\tFlash reset done!"),UVM_LOW);

       //check (!`SPI_TOP.TRIM_INVALID);
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       if(top_test_cfg.flash_debug_status[7]) begin
            `nnc_error("SOC_TEST",$sformatf("\tERROR!!! Unexpected trim invalid detected!!!"));
       end

       //check config data
       for(int i=0; i<=7; i++) begin
            top_test_cfg.config_data[i] = `SOC_TOP.u_top_dig.flash_ctrl_top_inst.u_32k.fuse_reg[i];
            `nnc_info("SOC_TEST",$sformatf("\tconfig_reg data_%d: (0x%x)\n", i, top_test_cfg.config_data[i]),UVM_LOW);
            if(top_test_cfg.config_data[i] != (8'h10+i)) begin
                `nnc_error("SOC_TEST",$sformatf("\tERROR!!! CONFIG DATA MISMATCH!!!"));
            end
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

       //Read Ana Trim values from Always_ON debug registers
       top_test_cfg.no_of_bytes = 8'h0A;
       top_test_cfg.rd_data_reg = new[top_test_cfg.no_of_bytes];
       ///-------------to read burst starting from the SOC_ALWAYS_ON_ANA_TRIM1 reg-------------------//
       `RD_BURST_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM1, top_test_cfg.no_of_bytes, top_test_cfg.rd_data_reg);
       for(int i=0; i<top_test_cfg.no_of_bytes; i++) begin
	        top_test_cfg.ana_trim_data[i] = top_test_cfg.rd_data_reg[(top_test_cfg.no_of_bytes-1)-i];
	        `nnc_info("SOC_TEST",$sformatf("\talways_on ana trim data_%d: (0x%x)\n", i, top_test_cfg.ana_trim_data[i]),UVM_LOW);
	        if(top_test_cfg.ana_trim_data[i] !== top_test_cfg.exp_ana_trim[i+1]) begin
                `nnc_error("SOC_TEST",$sformatf("\tERROR READ ANA-TRIM%0d!!! ALWAYS ON LOAD FROM FLASH FAILED!!!", i));
            end
       end

       `nnc_info("SOC_TEST",$sformatf("\n Enter Low power mode"),UVM_LOW);
       force `ANA_TOP.PMU_SW.wakeup=0;
       #1000000
       `nnc_info("SOC_TEST",$sformatf("\n Enter Active mode"),UVM_LOW);
       release `ANA_TOP.PMU_SW.wakeup;

       @(posedge `RESETN);

       top_test_cfg.flash_debug_status = 8'h00;
        
        //wait (!`SPI_TOP.FLASH_BUSY);
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       while (top_test_cfg.flash_debug_status[6] === 1) begin
	        `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       end
       `nnc_info("SOC_TEST",$sformatf("\tFlash reset done!"),UVM_LOW);

       //check (!`SPI_TOP.TRIM_INVALID);
       `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pad,top_test_cfg.flash_debug_status);
       if(top_test_cfg.flash_debug_status[7]) begin
            `nnc_error("SOC_TEST",$sformatf("\tERROR!!! Unexpected trim invalid detected!!!"));
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

       //Read Ana Trim values from Always_ON debug registers
       top_test_cfg.no_of_bytes = 8'h0A;
       top_test_cfg.rd_data_reg = new[top_test_cfg.no_of_bytes];
       ///-------------to read burst starting from the SOC_ALWAYS_ON_ANA_TRIM1 reg-------------------//
       `RD_BURST_NORMAL_REG(`SOC_ALWAYS_ON_ANA_TRIM1, top_test_cfg.no_of_bytes, top_test_cfg.rd_data_reg);
       for(int i=0; i<top_test_cfg.no_of_bytes; i++) begin
	        top_test_cfg.ana_trim_data[i] = top_test_cfg.rd_data_reg[(top_test_cfg.no_of_bytes-1)-i];
	        `nnc_info("SOC_TEST",$sformatf("\talways_on ana trim data_%d: (0x%x)\n", i, top_test_cfg.ana_trim_data[i]),UVM_LOW);
	        if(top_test_cfg.ana_trim_data[i] !== top_test_cfg.exp_ana_trim[i+1]) begin
                `nnc_error("SOC_TEST",$sformatf("\tERROR READ ANA-TRIM%0d!!! ALWAYS ON LOAD FROM FLASH FAILED!!!", i));
            end
       end
    end
  endtask
     
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME
