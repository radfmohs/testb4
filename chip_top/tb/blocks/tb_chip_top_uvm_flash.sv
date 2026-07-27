/*--------------------------------------------------------------------------------------*/
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
// --------------------------------------------------------------------------------------
// Project      : Nanochap ENS3
// File         : tb_chip_top_uvm_eprom.sv
// Description  : Nand Flash TB 
// Designer     : Daniel Dang
// Date         : 22/11/2023
// Revision     : 0.1
/*--------------------------------------------------------------------------------------*/

`define FLASH_SCOREBOARD_EN          top_cfg.flash_cfg.nnc_flash_scoreboard_en

// Initilization for Flash
initial
begin
  #10;
  $display("Initializing Flash BLOCK inf1 for Flash");
  $readmemh("../../../logical/flash_ctrl/sim/inf1.hex", `FLASH_TOP.u_32k.inf1_mem);
  $readmemh("../../../logical/flash_ctrl/sim/inf1.hex", flash_bist_if.inf1_mem);
  if (dut_vif.disable_init_flash === 1'b0) begin
    $display("Initializing Flash BLOCK inf0 for Flash");
    $readmemh("../../../logical/flash_ctrl/sim/inf0.hex", `FLASH_TOP.u_32k.inf0_mem);
  end

  // any change during the tests
  while (1) begin
    @(negedge dut_vif.disable_init_flash);
    $display("Initializing Flash BLOCK inf0 for Flash");
    $readmemh("../../../logical/flash_ctrl/sim/inf0.hex", `FLASH_TOP.u_32k.inf0_mem); 
  end

end

assign dut_vif.flash_recall_done = `FLASH_TOP.u_32k.recall_done;
assign `FLASH_TOP.u_32k.check_conf_first_disable  = dut_vif.flash_check_conf_first_disable;

// --------------------------------------------------------------------------------
// EPROM BIST MODEL
// --------------------------------------------------------------------------------
flash_bist_master u_flash_bist_master (
	.TDO(TDO),                     //output from bist design
	.BIST_TESTMODE(),              //output from bist design
	.TCK(TCK),                     //input to bist design      	       
	.RESETb(RESETb),               //input to bist design
	.TESTEN(TESTEN),               //input to bist design
	.STROBE(),                     //input to bist design
	.TDI(TDI),                     //input to bist design
	.TESTMODE_SEL(TESTMODE)        //input to bist design
);

// --------------------------------------------------------------------------------
// FLASH BIST interface connection 
// --------------------------------------------------------------------------------
nnc_flash_bist_interface        flash_bist_if();

assign flash_bist_if.TDO			 =  TDO;
assign flash_bist_if.TCK			 =  TCK;
assign flash_bist_if.RESETb                      =  RESETb; 
assign flash_bist_if.TESTEN                      =  TESTEN;     
assign flash_bist_if.TDI                         =  TDI;     
assign flash_bist_if.TESTMODE_SEL                =  TESTMODE;     
assign flash_bist_if.dont_check_conf_first_en    =  dut_vif.dont_check_conf_first_en; 
//assign flash_bist_if.BIST_TESTMODE             =  BIST_TESTMODE;  

// --------------------------------------------------------------------------------
// FLASH IP interface connection 
// --------------------------------------------------------------------------------
nnc_flash_interface             flash_ip_if();

`ifdef FPGA
`else

assign #1 flash_ip_if.ADD    =    `FLASH_IP.A      ; 
assign #1 flash_ip_if.DIN    =    `FLASH_IP.DIN    ;   
assign #1 flash_ip_if.DOUT   =    `FLASH_IP.DOUT   ;   
assign #1 flash_ip_if.NVR    =    `FLASH_IP.NVR    ;   
assign #1 flash_ip_if.CEb    =    `FLASH_IP.CEb    ;   
assign #1 flash_ip_if.WEb    =    `FLASH_IP.WEb    ;   
assign #1 flash_ip_if.PROG   =    `FLASH_IP.PROG   ;   
assign #1 flash_ip_if.PROG2  =    `FLASH_IP.PROG2  ;   
assign #1 flash_ip_if.ERASE  =    `FLASH_IP.ERASE  ;   
assign #1 flash_ip_if.BLOCK  =    `FLASH_IP.BLOCK  ;   
assign #1 flash_ip_if.CONFEN =    `FLASH_IP.CONFEN ;   
assign #1 flash_ip_if.CHIP   =    `FLASH_IP.CHIP   ;   
assign #1 flash_ip_if.OEb    =    `FLASH_IP.OEb    ;   
assign #1 flash_ip_if.PORb   =    `FLASH_IP.PORb   ;   
assign #1 flash_ip_if.VREAD0 =    `FLASH_IP.VREAD0 ;   
assign #1 flash_ip_if.VREAD1 =    `FLASH_IP.VREAD1 ;   
assign #1 flash_ip_if.TMEN   =    `FLASH_IP.TMEN   ;   
assign #1 flash_ip_if.VMON1  =    `FLASH_IP.VMON1  ;   
assign #1 flash_ip_if.VMON2  =    `FLASH_IP.VMON2  ;   
assign #1 flash_ip_if.DEEPPD =    `FLASH_IP.DEEPPD ;   

`endif


initial begin
    nnc_config_db#(virtual nnc_flash_bist_interface)::set(uvm_root::get(), "uvm_test_top.top_env.flash_env.*", "flash_bist_if", flash_bist_if);
    nnc_config_db#(virtual nnc_flash_interface)::set(uvm_root::get(), "uvm_test_top.top_env.flash_env.*", "flash_ip_if", flash_ip_if);
end


