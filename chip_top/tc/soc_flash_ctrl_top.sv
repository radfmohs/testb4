/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_flash_ctrl_top.sv                                                   
// Project	: Nanochap ENS1P4                                  		        
// Description	: Testcase soc_flash_ctrl_top                                             
// Designer	: ddang@nanochap.com                                                                 
// Date		: 29-11-1623                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_flash_ctrl_top
`define TESTCFG soc_flash_ctrl_top_cfg

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // -----------------------------------------------
  // Adding your new varialbles in config test
  // -----------------------------------------------
  rand logic [7:0] 	rd_flash_debug2_reg;
  rand bit		flash_busy_status_bit;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA0_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA1_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA2_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA3_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA4_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA5_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA6_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA7_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA8_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA9_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA10_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA11_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA12_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA13_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA14_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA15_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA16_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA17_reg;    
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA18_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA19_reg;
  rand logic [7:0]     rd_SOC_FLASH_TRIMDATA20_reg;
  //------------------------------------------------------------------------------
  // -----------------------------------------------
  // End of decalration of new variables 
  // -----------------------------------------------

  function new (string name = "soc_flash_ctrl_top_cfg");
    super.new(name);    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
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

    `nnc_info("SOC_TEST", "soc_flash_ctrl_top start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ----------------------------------------------------------------------------------  
    `nnc_info("SOC_TEST",$sformatf("Simulation Begin!!!"),UVM_LOW);
    `nnc_info("SOC_TEST",$sformatf("flash deepsleep test"),UVM_LOW);
    wait(`RESETN);
    do_run;
    
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

  virtual task do_run;
    begin

        // Waiting for Flash asserted recall_done to program       
        wait(`DUT_IF.flash_recall_done); 
        
        wait(`RESETN);
        #1000000
        #1000000
        force `ANA_TOP.PMU_SW.wakeup=0;
        #10000
        force `ANA_TOP.PMU_SW.wakeup=1;
        wait(`RESETN);
        wait(`HF_RESETN);
        `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,8'h00,top_test_cfg.rd_flash_debug2_reg); 		//by this time assumes flash_busy went HIGH
        top_test_cfg.flash_busy_status_bit = top_test_cfg.rd_flash_debug2_reg[6];
        while(top_test_cfg.flash_busy_status_bit)begin
	        `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,8'h00,top_test_cfg.rd_flash_debug2_reg);
	        top_test_cfg.flash_busy_status_bit = top_test_cfg.rd_flash_debug2_reg[6];
        end

        //read trim values too
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA0,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA0_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA1,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA1_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA2,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA2_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA3,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA3_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA4,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA4_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA5,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA5_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA6,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA6_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA7,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA7_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA8,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA8_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA9,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA9_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA10,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA10_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA11,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA11_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA12,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA12_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA13,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA13_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA14,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA14_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA15,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA15_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA16,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA16_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA17,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA17_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA18,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA18_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA19,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA19_reg);
        `RD_NORMAL_REG(`SOC_FLASH_TRIMDATA20,8'h00,top_test_cfg.rd_SOC_FLASH_TRIMDATA20_reg);        
        
           
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA0_reg[7:0]  != `SOC_FLASH_TRIMDATA0_RELOAD_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM0 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA0_reg));
        end
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA1_reg[7:0]  != `SOC_FLASH_TRIMDATA1_RELOAD_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM1 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA1_reg));
        end
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA2_reg[7:0]  != `SOC_FLASH_TRIMDATA2_RELOAD_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM2 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA2_reg));
        end
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA3_reg[7:0]  != `SOC_FLASH_TRIMDATA3_RELOAD_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM3 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA3_reg));
        end             
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA4_reg[7:0]  != `SOC_FLASH_TRIMDATA4_RELOAD_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM4 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA4_reg));
        end             
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA5_reg[7:0]  != `SOC_FLASH_TRIMDATA5_RELOAD_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM5 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA5_reg));
        end             
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA6_reg[7:0]  != `SOC_FLASH_TRIMDATA6_RELOAD_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM6 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA6_reg));
        end            
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA7_reg[7:0]  != `SOC_FLASH_TRIMDATA7_RELOAD_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM7 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA7_reg));
        end             
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA8_reg[7:0]  != `SOC_FLASH_TRIMDATA8_RELOAD_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM8 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA8_reg));
        end            
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA9_reg[7:0]  != `SOC_FLASH_TRIMDATA9_RELOAD_INIT )begin 
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM9 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA9_reg));
        end            
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA10_reg[7:0] != `SOC_FLASH_TRIMDATA10_RELOAD_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM10 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA10_reg));            
        end             
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA11_reg[7:0] != `SOC_FLASH_TRIMDATA11_RELOAD_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM11 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA11_reg));            
        end
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA12_reg[7:0] != `SOC_FLASH_TRIMDATA12_RELOAD_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM12 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA12_reg));            
        end
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA13_reg[7:0] != `SOC_FLASH_TRIMDATA13_RELOAD_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM13 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA13_reg));            
        end
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA14_reg[7:0] != `SOC_FLASH_TRIMDATA14_RELOAD_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM14 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA14_reg));            
        end             
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA15_reg[7:0] != `SOC_FLASH_TRIMDATA15_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM15 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA15_reg));            
        end
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA16_reg[7:0] != `SOC_FLASH_TRIMDATA16_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM16 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA16_reg));            
        end
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA17_reg[7:0] != `SOC_FLASH_TRIMDATA17_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM17 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA17_reg));            
        end
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA18_reg[7:0] != `SOC_FLASH_TRIMDATA18_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM18 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA18_reg));            
        end             
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA19_reg[7:0] != `SOC_FLASH_TRIMDATA19_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM19 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA19_reg));            
        end
        if(top_test_cfg.rd_SOC_FLASH_TRIMDATA20_reg[7:0] != `SOC_FLASH_TRIMDATA20_INIT )begin
            `nnc_error("SOC_TEST",$sformatf("ERROR READ FLASH-TRIM20 : %0h!!!", top_test_cfg.rd_SOC_FLASH_TRIMDATA20_reg));            
        end

    end
  endtask
     
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME
