//============================================================================== 
// ----------------------------------------------------------------------------- 
//  Nanochap Electronics Copyright (C) 2014. ALL RIGHTS RESERVED. 
// ----------------------------------------------------------------------------- 
// Module name     : flash_rw_fsm.v
// Description     : deal with the signals that come from FSM
//                   generate the signals which will go to flash IP
// ----------------------------------------------------------------------------- 
// Revision History: 
// ----------------------------------------------------------------------------- 
// Revision       Date(xxxx-xx-xx)     Author             Description 
// ----------------------------------------------------------------------------- 
//   1.0          2024-10-22           Zhen Cao           Initial version 
//   1.1          2024-11-19           Daniel Dang        Changed format 
// ----------------------------------------------------------------------------- 
//==============================================================================

module flash_rw_outdrv(
    
   input wire	     clk,
   input wire	     resetn,

   //----------------------------------------------
   // Interface from rw_fsm
   //----------------------------------------------
   input wire           drvh_FLASH_CEb,
   input wire           drvh_FLASH_WEb,
   input wire           drvh_FLASH_PROG,
   input wire           drvh_FLASH_PROG2,
   input wire           drvh_FLASH_ERASE,
   input wire           drvh_FLASH_CHIP,
   input wire           drvh_FLASH_por,
//   input wire           drvh_FLASH_DPSTB,

   input wire           drvl_FLASH_CEb,
   input wire           drvl_FLASH_WEb,
   input wire           drvl_FLASH_PROG,
   input wire           drvl_FLASH_PROG2,
   input wire           drvl_FLASH_ERASE,
   input wire           drvl_FLASH_CHIP,
//   input wire           drvl_FLASH_DPSTB,

//   input wire           drvh_FLASH_BYTE0,  //drvh for byte[1:0]
//   input wire           drvh_FLASH_BYTE1,

//   input wire           drvl_FLASH_BYTE0,  //drvl for byte[1:0]
//   input wire           drvl_FLASH_BYTE1,

   input wire 	        drvl_pbusy_out,
   input wire 	        drvh_pbusy_out,
   
   input wire 	        drvl_pdone_out,
   input wire 	        drvh_pdone_out,

   input wire           drvh_FLASH_CONFEN,     
   input wire           drvl_FLASH_CONFEN,  

   input wire	        rd_FLASH_CEb,	  //registered CEb, OEb from rw_fsm
   input wire	        rd_FLASH_OEb,

   input wire	        PGRD_muxselect,   //Mux select to choose WR/RD



   //----------------------------------------------
   // Signals taken directly from WCTRL Registers
   //----------------------------------------------
   //input wire           vread0,
   //input wire           vread1,

//   input wire   [13:0]  wr_FLASH_ADDR,	//WRITE ADD from write regs
//   input wire   [31:0]  wr_FLASH_WDATA,	//WRITE DATA from write regs
   input wire         flash_nvr_in,   
   
   output wire  	     pbusy_out,		//pbusy out to wr ctl reg status
   output wire  	     pdone_out,		//pdone out to wr ctl reg status

   //----------------------------------------------
   // Interface to FLASH IP -- drives FLASH IP
   //----------------------------------------------
   output wire          FLASH_NVR,       // to flash
   output wire          FLASH_CEb,
   output wire          FLASH_WEb,
   output wire          FLASH_PROG,
   output wire          FLASH_PROG2,
   output wire          FLASH_ERASE,
   output wire          FLASH_CHIP,
   output wire          FLASH_OEb,
   output wire          FLASH_PORb,
   output wire          FLASH_CONFEN
//   output wire          FLASH_PORb,
//   output wire          FLASH_VREAD1,
//   output wire          FLASH_VREAD0,
//   output wire          FLASH_TMEN,
//   output wire   [13:0] FLASH_ADDR,
//   output wire   [31:0] FLASH_WDATA,
//   output wire          FLASH_DPSTB,
//   output wire    [1:0] FLASH_BYTE


);


     //----------------------------------------------
     // Internal wires
     //----------------------------------------------
     
     wire wr_FLASH_CEb;
     wire wr_FLASH_WEb;
     wire wr_FLASH_PROG;
     wire wr_FLASH_PROG2;
     wire wr_FLASH_ERASE;
     wire wr_FLASH_CHIP;
//     wire wr_FLASH_BYTE0;
//     wire wr_FLASH_BYTE1;
     wire FLASH_por;
     wire wr_FLASH_CONFEN;     
     
     //----------------------------------------------
     // Registers to drive toggling signals for WRITE
     //----------------------------------------------
     
     outdrv_reg #(
     .INITVAL(1'b1)	
     ) 
     u_flash_ceb_reg (
       .clk	(clk),
       .resetn	(resetn),
       .drvh	(drvh_FLASH_CEb),
       .drvl	(drvl_FLASH_CEb),
       .outreg	(wr_FLASH_CEb)
     );
     
     outdrv_reg #(
     .INITVAL(1'b1)	
     ) 
     u_flash_web_reg (
       .clk	(clk),
       .resetn	(resetn),
       .drvh	(drvh_FLASH_WEb),
       .drvl	(drvl_FLASH_WEb),
       .outreg	(wr_FLASH_WEb)
     );
     
     outdrv_reg u_flash_prog_reg (
       .clk	(clk),
       .resetn	(resetn),
       .drvh	(drvh_FLASH_PROG),
       .drvl	(drvl_FLASH_PROG),
       .outreg	(wr_FLASH_PROG)
     );
     
     outdrv_reg u_flash_prog2_reg (
       .clk	(clk),
       .resetn	(resetn),
       .drvh	(drvh_FLASH_PROG2),
       .drvl	(drvl_FLASH_PROG2),
       .outreg	(wr_FLASH_PROG2)
     );
     
     
     outdrv_reg u_flash_erase_reg (
       .clk	(clk),
       .resetn	(resetn),
       .drvh	(drvh_FLASH_ERASE),
       .drvl	(drvl_FLASH_ERASE),
       .outreg	(wr_FLASH_ERASE)
     );
     
     outdrv_reg u_flash_chip_reg (
       .clk	(clk),
       .resetn	(resetn),
       .drvh	(drvh_FLASH_CHIP),
       .drvl	(drvl_FLASH_CHIP),
       .outreg	(wr_FLASH_CHIP)
     );
     
/*     outdrv_reg uflash_byte0_reg (
       .clk	(clk),
       .resetn	(resetn),
       .drvh	(drvh_FLASH_BYTE0),
       .drvl	(drvl_FLASH_BYTE0),
       .outreg	(wr_FLASH_BYTE0)
     );
     
     outdrv_reg uflash_byte1_reg (
       .clk	(clk),
       .resetn	(resetn),
       .drvh	(drvh_FLASH_BYTE1),
       .drvl	(drvl_FLASH_BYTE1),
       .outreg	(wr_FLASH_BYTE1)
     );
*/   
     // Drive status to registers
     
     outdrv_reg u_pbusy_out_reg (
       .clk	(clk),
       .resetn	(resetn),
       .drvh	(drvh_pbusy_out),
       .drvl	(drvl_pbusy_out),
       .outreg	(pbusy_out)
     );
     
     outdrv_reg u_pdone_out_reg (
       .clk	(clk),
       .resetn	(resetn),
       .drvh	(drvh_pdone_out),
       .drvl	(drvl_pdone_out),
       .outreg	(pdone_out)
     );
     
 
     outdrv_reg u_flash_por (
       .clk	(clk),
       .resetn	(resetn),
       .drvh	(drvh_FLASH_por),
       .drvl	(1'b0),
       .outreg	(FLASH_por)
     );

     outdrv_reg u_flash_confen_reg (
    .clk	(clk),
    .resetn	(resetn),
    .drvh	(drvh_FLASH_CONFEN),
    .drvl	(drvl_FLASH_CONFEN),
    .outreg	(wr_FLASH_CONFEN)
     );     

     //----------------------------------------------
     // Output Muxing between RD/WR operations
     //----------------------------------------------
     
     assign FLASH_NVR        = flash_nvr_in;     
     assign FLASH_CEb        = (PGRD_muxselect) ? wr_FLASH_CEb   : rd_FLASH_CEb;  
     assign FLASH_WEb        = (PGRD_muxselect) ? wr_FLASH_WEb   : {1'b1};        
     assign FLASH_PROG       = (PGRD_muxselect) ? wr_FLASH_PROG  : {1'b0};       
     assign FLASH_PROG2      = (PGRD_muxselect) ? wr_FLASH_PROG2 : {1'b0};        
     assign FLASH_ERASE      = (PGRD_muxselect) ? wr_FLASH_ERASE : {1'b0};       
     assign FLASH_CHIP       = (PGRD_muxselect) ? wr_FLASH_CHIP  : {1'b0};       
     assign FLASH_OEb        = (PGRD_muxselect) ? {1'b1}         : rd_FLASH_OEb;  
//     assign FLASH_VREAD1     = {1'b0};
//     assign FLASH_VREAD0     = {1'b0};
//     assign FLASH_TMEN       = {1'b0};
//     assign FLASH_ADDR       =  wr_FLASH_ADDR;     
//     assign FLASH_WDATA      = wr_FLASH_WDATA;
//     assign FLASH_BYTE[0]    = (PGRD_muxselect) ? wr_FLASH_BYTE0 : {1'b0};
//     assign FLASH_BYTE[1]    = (PGRD_muxselect) ? wr_FLASH_BYTE1 : {1'b0};
     assign FLASH_PORb      = FLASH_por;
     assign FLASH_CONFEN     = (PGRD_muxselect) ? wr_FLASH_CONFEN: {1'b0};        

endmodule
