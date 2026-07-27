//============================================================================== 
// ----------------------------------------------------------------------------- 
//  Nanochap Electronics Copyright (C) 2014. ALL RIGHTS RESERVED. 
// ----------------------------------------------------------------------------- 
// Module name     : flash_rw_ctrl.v
// Description     : Read/Write Control,includes redundacy/read/write/erase
// ----------------------------------------------------------------------------- 
// Revision History: 
// ----------------------------------------------------------------------------- 
// Revision       Date(xxxx-xx-xx)     Author             Description 
// ----------------------------------------------------------------------------- 
//   1.0          2024-10-22           Zhen Cao           Initial version 
//   1.1          2024-11-19           Daniel Dang        Changed format 
// ----------------------------------------------------------------------------- 
//==============================================================================

module flash_rw_ctrl #(
// --------------------------------------------------------------------------
// Parameter Declarations
// --------------------------------------------------------------------------  
  parameter TIMER_BITS = 20
)
 (
 // --------------------------------------------------------------------------
 // Port Definitions
 // --------------------------------------------------------------------------

 
 input  wire        clk,      // system bus clock
 input  wire        rst_n,   // system bus reset
 input  wire        ext_clk_sel ,
 input wire         flash_en,
 input wire         flash_inf_rw,
 input wire         flash_nvr_in,
 input wire         flash_ser_en,
 input wire         flash_cer_en, 
// input wire         write_word,
// input wire         write_hword,
// input wire         write_u_hword,
// input wire         write_l_hword,
 input wire  [5:0] flash_inf_adr,
// input wire  [7:0]  flash_inf_wdata,
 input wire         reload_trim,
 input wire         rd_spi,
 input wire         reload_rnd,
 input  wire [7:0]  rnd_regs,
// input wire         trim_read_en_ack,
 input wire         flash_dslp,
 
 input wire           nvr2_trim_tag,
 input wire           confen_valid,

 output wire        flash_dslp_ip,
 output wire        flash_inf_blk_rd_set_en,
 output wire        flash_inf_blk_wd_set_en,
 output wire        flash_inf_blk_ser_set_en,
 output wire        flash_inf_blk_cer_set_en, 
// output wire        flash_inf_blk_ao_rd_set_en, 
 output wire        flash_ip_por_resetn,
 output wire        rd_addr_add,
 output wire        status_pdone,
 output wire        status_pbusy,
 //Signals to/From FLASH Block
 output wire          FLASH_NVR,	// to flash
 output wire          FLASH_CEb,
 output wire          FLASH_WEb,
 output wire          FLASH_PROG,
 output wire          FLASH_PROG2,
 output wire          FLASH_ERASE,
 output wire          FLASH_CHIP,
 output wire          FLASH_RDN,
 output wire          FLASH_CONFEN,
 output wire          FLASH_OEb,
 output wire          FLASH_PORb,
// output wire          FLASH_VREAD1,
// output wire          FLASH_VREAD0,
// output wire            FLASH_TMEN,
 output wire   [5:0] FLASH_ADDR
// output wire   [31:0]   FLASH_WDATA,
// output wire    [1:0]   FLASH_BYTE

 ); 

   //-----------------------------------
   // clkcount to rw_fsm interface
   //-----------------------------------
//   wire [TIMER_BITS-1:0] PROGRAM_Tnvs;
//   wire [TIMER_BITS-1:0] PROGRAM_Tpgs;
//   wire [TIMER_BITS-1:0] PROGRAM_Tpgh;
//   wire [TIMER_BITS-1:0] PROGRAM_Tprog;
//   wire [TIMER_BITS-1:0] PROGRAM_Tads;
//   wire [TIMER_BITS-1:0] PROGRAM_Tadh;
//   wire [TIMER_BITS-1:0] PROGRAM_Trcv;
//   wire [TIMER_BITS-1:0] ERASE_Tnvs;
//   wire [TIMER_BITS-1:0] ERASE_SECTOR_Terase;
//   wire [TIMER_BITS-1:0] ERASE_CHIP_Terase;
//   wire [TIMER_BITS-1:0] ERASE_Trcv;


   //-----------------------------------
   // rw_fsm to outdrv interface
   //-----------------------------------
   wire        PGRD_muxselect_outdrv;
   wire        rd_FLASH_CEb_outdrv;
   wire        rd_FLASH_OEb_outdrv;
   wire        drvh_FLASH_CEb_outdrv;
   wire        drvh_FLASH_WEb_outdrv;
   wire        drvh_FLASH_PROG_outdrv;
   wire        drvh_FLASH_PROG2_outdrv;
   wire        drvh_FLASH_ERASE_outdrv;
   wire        drvh_FLASH_CHIP_outdrv;
   wire        drvh_FLASH_por_outdrv;

   wire        drvl_FLASH_CEb_outdrv;
   wire        drvl_FLASH_WEb_outdrv;
   wire        drvl_FLASH_PROG_outdrv;
   wire        drvl_FLASH_PROG2_outdrv;
   wire        drvl_FLASH_ERASE_outdrv;
   wire        drvl_FLASH_CHIP_outdrv;

//   wire        drvh_FLASH_BYTE0_outdrv;
//   wire        drvh_FLASH_BYTE1_outdrv;

//   wire        drvl_FLASH_BYTE0_outdrv;
//   wire        drvl_FLASH_BYTE1_outdrv;

   wire        drvh_pbusy_out_outdrv;
   wire        drvl_pbusy_out_outdrv;
   
   wire        drvh_pdone_out_outdrv;
   wire        drvl_pdone_out_outdrv;

   wire        drvh_FLASH_CONFEN_outdrv;
   wire        drvl_FLASH_CONFEN_outdrv;

   wire [5:0]  flash_addr_sector_postred;
   wire        red_enable;



assign FLASH_ADDR = flash_addr_sector_postred;
assign FLASH_RDN  = red_enable;

// ----------------------------------------------------------
// Instantiate Sub-Modules
// ----------------------------------------------------------


//   flash_clkcnt#(.TIMER_BITS(TIMER_BITS)) u_ahb_flash_clkcnt
//   (
//
//     .ext_clk_sel(ext_clk_sel),	   
//     .PROGRAM_Tnvs(PROGRAM_Tnvs),
//     .PROGRAM_Tpgs(PROGRAM_Tpgs),
//     .PROGRAM_Tpgh(PROGRAM_Tpgh),
//     .PROGRAM_Tprog(PROGRAM_Tprog),
//     .PROGRAM_Tads(PROGRAM_Tads),
//     .PROGRAM_Tadh(PROGRAM_Tadh),
//     .PROGRAM_Trcv(PROGRAM_Trcv),
//     .ERASE_Tnvs(ERASE_Tnvs),
//     .ERASE_SECTOR_Terase(ERASE_SECTOR_Terase),
//     .ERASE_CHIP_Terase(ERASE_CHIP_Terase),
//     .ERASE_Trcv(ERASE_Trcv)
//   );

   flash_rw_fsm #(.TIMER_BITS(TIMER_BITS)) u_flash_rw_fsm
   (
   //Clock and reset
     .clk(clk),
     .resetn(rst_n),
     .ext_clk_sel(ext_clk_sel),
     .flash_inf_blk_rd_set_en 	(flash_inf_blk_rd_set_en),
     .flash_inf_blk_wd_set_en 	(flash_inf_blk_wd_set_en),
//     .flash_inf_blk_ao_rd_set_en(flash_inf_blk_ao_rd_set_en),
     .flash_ip_por_resetn       (flash_ip_por_resetn),
     .flash_ser_en              (flash_ser_en),
     .flash_cer_en              (flash_cer_en),
  //   .write_word                (write_word),
  //   .write_hword               (write_hword),
  //   .write_u_hword             (write_u_hword),
  //   .write_l_hword             (write_l_hword),     
     .flash_inf_blk_ser_set_en  (flash_inf_blk_ser_set_en),
     .flash_inf_blk_cer_set_en  (flash_inf_blk_cer_set_en),     
     .flash_en 			(flash_en),
     .flash_inf_rw 		(flash_inf_rw),
     .reload_trim               (reload_trim),
//     .trim_read_en_ack          (trim_read_en_ack),
     .rd_spi                    (rd_spi),
     .reload_rnd                (reload_rnd),
     .flash_dslp                (flash_dslp),  
     .flash_dslp_ip             (flash_dslp_ip),   
     .nvr2_trim_tag             (nvr2_trim_tag),
     .confen_valid              (confen_valid),
     .rd_addr_add               (rd_addr_add),
//   //Timer Constants
//     .PROGRAM_Tnvs(PROGRAM_Tnvs),
//     .PROGRAM_Tpgs(PROGRAM_Tpgs),
//     .PROGRAM_Tpgh(PROGRAM_Tpgh),
//     .PROGRAM_Tprog(PROGRAM_Tprog),
//     .PROGRAM_Tads(PROGRAM_Tads),
//     .PROGRAM_Tadh(PROGRAM_Tadh),
//     .PROGRAM_Trcv(PROGRAM_Trcv),
//     .ERASE_Tnvs(ERASE_Tnvs),
//     .ERASE_SECTOR_Terase(ERASE_SECTOR_Terase),
//     .ERASE_CHIP_Terase(ERASE_CHIP_Terase),
//     .ERASE_Trcv(ERASE_Trcv),
   //Interface signals to OUTDRV
     .PGRD_muxselect(PGRD_muxselect_outdrv),  //Mux select to choose WR/RD
     .rd_FLASH_CEb(rd_FLASH_CEb_outdrv),      //registered CEb, OEb 
     .rd_FLASH_OEb(rd_FLASH_OEb_outdrv),

     .drvh_FLASH_CEb(drvh_FLASH_CEb_outdrv),
     .drvh_FLASH_WEb(drvh_FLASH_WEb_outdrv),
     .drvh_FLASH_PROG(drvh_FLASH_PROG_outdrv),
     .drvh_FLASH_PROG2(drvh_FLASH_PROG2_outdrv),
     .drvh_FLASH_ERASE(drvh_FLASH_ERASE_outdrv),
     .drvh_FLASH_CHIP(drvh_FLASH_CHIP_outdrv),
     .drvh_FLASH_por(drvh_FLASH_por_outdrv),

     .drvl_FLASH_CEb(drvl_FLASH_CEb_outdrv),
     .drvl_FLASH_WEb(drvl_FLASH_WEb_outdrv),
     .drvl_FLASH_PROG(drvl_FLASH_PROG_outdrv),
     .drvl_FLASH_PROG2(drvl_FLASH_PROG2_outdrv),
     .drvl_FLASH_ERASE(drvl_FLASH_ERASE_outdrv),
     .drvl_FLASH_CHIP(drvl_FLASH_CHIP_outdrv),

     .drvh_FLASH_CONFEN(drvh_FLASH_CONFEN_outdrv),
     .drvl_FLASH_CONFEN(drvl_FLASH_CONFEN_outdrv),

//     .drvh_FLASH_BYTE0(drvh_FLASH_BYTE0_outdrv),  //drvh for byte[1:0]
//     .drvh_FLASH_BYTE1(drvh_FLASH_BYTE1_outdrv),

//     .drvl_FLASH_BYTE0(drvl_FLASH_BYTE0_outdrv),  //drvl for byte[1:0]
//     .drvl_FLASH_BYTE1(drvl_FLASH_BYTE1_outdrv),
     
     .drvh_pdone_out(drvh_pdone_out_outdrv),
     .drvl_pdone_out(drvl_pdone_out_outdrv),

     .drvh_pbusy_out(drvh_pbusy_out_outdrv),
     .drvl_pbusy_out(drvl_pbusy_out_outdrv)

   //Drive Internal next_state (non-reg) to be registered on FLASH_STATUS
   //Signal to load shadow registers
  
   );

   flash_rw_outdrv     u_flash_rw_outdrv
   (
      .clk(clk),
      .resetn(rst_n),
     // Interface from rw_fsm 
      .drvh_FLASH_CEb(drvh_FLASH_CEb_outdrv),
      .drvh_FLASH_WEb(drvh_FLASH_WEb_outdrv),
      .drvh_FLASH_PROG(drvh_FLASH_PROG_outdrv),
      .drvh_FLASH_PROG2(drvh_FLASH_PROG2_outdrv),
      .drvh_FLASH_ERASE(drvh_FLASH_ERASE_outdrv),
      .drvh_FLASH_CHIP(drvh_FLASH_CHIP_outdrv),
      .drvh_FLASH_por(drvh_FLASH_por_outdrv),

      .drvl_FLASH_CEb(drvl_FLASH_CEb_outdrv),
      .drvl_FLASH_WEb(drvl_FLASH_WEb_outdrv),
      .drvl_FLASH_PROG(drvl_FLASH_PROG_outdrv),
      .drvl_FLASH_PROG2(drvl_FLASH_PROG2_outdrv),
      .drvl_FLASH_ERASE(drvl_FLASH_ERASE_outdrv),
      .drvl_FLASH_CHIP(drvl_FLASH_CHIP_outdrv),

     .drvh_FLASH_CONFEN(drvh_FLASH_CONFEN_outdrv),
     .drvl_FLASH_CONFEN(drvl_FLASH_CONFEN_outdrv),

//      .drvh_FLASH_BYTE0(drvh_FLASH_BYTE0_outdrv),  //drvh for byte[1:0]
//      .drvh_FLASH_BYTE1(drvh_FLASH_BYTE1_outdrv),

//      .drvl_FLASH_BYTE0(drvl_FLASH_BYTE0_outdrv),  //drvl for byte[1:0]
//      .drvl_FLASH_BYTE1(drvl_FLASH_BYTE1_outdrv),
      
      .drvh_pdone_out(drvh_pdone_out_outdrv),
      .drvl_pdone_out(drvl_pdone_out_outdrv),

      .drvh_pbusy_out(drvh_pbusy_out_outdrv),
      .drvl_pbusy_out(drvl_pbusy_out_outdrv),

      .rd_FLASH_CEb(rd_FLASH_CEb_outdrv),      //registered CEb, OEb 
      .rd_FLASH_OEb(rd_FLASH_OEb_outdrv),
      .PGRD_muxselect(PGRD_muxselect_outdrv),     //READ data to rw_fsm
    //Signals to/from WCTRL Registers
//      .wr_FLASH_ADDR(flash_inf_adr),            //Take only 14 bits
//      .wr_FLASH_WDATA({24'h1,flash_inf_wdata}),
      .flash_nvr_in(flash_nvr_in),
      .pbusy_out(status_pbusy),                 //pbusy out to wr status 
      .pdone_out(status_pdone),                 //pdone out to wr status 
    //Interface to FLASH IP
      .FLASH_NVR(FLASH_NVR),			//fan this out to flash_red_logic
      .FLASH_CEb(FLASH_CEb),
      .FLASH_WEb(FLASH_WEb),
      .FLASH_PROG(FLASH_PROG),
      .FLASH_PROG2(FLASH_PROG2),
      .FLASH_ERASE(FLASH_ERASE),
      .FLASH_CHIP(FLASH_CHIP),
      .FLASH_CONFEN(FLASH_CONFEN),
      .FLASH_OEb(FLASH_OEb),
      .FLASH_PORb(FLASH_PORb)
//      .FLASH_VREAD1(FLASH_VREAD1),
//      .FLASH_VREAD0(FLASH_VREAD0),
//      .FLASH_TMEN(FLASH_TMEN),
//      .FLASH_ADDR({flash_addr_red,flash_addr_sector_prered,flash_addr_rowword}),
//      .FLASH_ADDR(flash_addr_temp),
//      .FLASH_WDATA(FLASH_WDATA),
//      .FLASH_BYTE(FLASH_BYTE)
    );



   // New redundancy repair block aded in V1.6 to fix yield concerns
   flash_red_logic   u_flash_red_logic (
    .ADDR_SECTOR_IN(flash_inf_adr),
    .NVR_SELECT_IN(FLASH_NVR),
    .NVR_BADSECTOR_WORD0(rnd_regs),         
//    .NVR_BADSECTOR_WORD1(rnd_regs[1]),         
//    .NVR_BADSECTOR_WORD2(rnd_regs[2]),        
//    .NVR_BADSECTOR_WORD3(rnd_regs[3]),       
//    .NVR_BADSECTOR_WORD4(rnd_regs[4]),      
//    .NVR_BADSECTOR_WORD5(rnd_regs[5]),     
//    .NVR_BADSECTOR_WORD6(rnd_regs[6]),    
//    .NVR_BADSECTOR_WORD7(rnd_regs[7]),   
    .ADDR_SECTOR_OUT(flash_addr_sector_postred),
    .RED_ENABLE_OUT(red_enable)
   );    

endmodule
