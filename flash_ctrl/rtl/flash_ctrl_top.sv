//============================================================================== 
// ----------------------------------------------------------------------------- 
//  Nanochap Electronics Copyright (C) 2014. ALL RIGHTS RESERVED. 
// ----------------------------------------------------------------------------- 
// Module name     : flash_ctrl_top.v
// Description     : BMS6P1 Flash Controller Top
// ----------------------------------------------------------------------------- 
// Revision History: 
// ----------------------------------------------------------------------------- 
// Revision       Date(xxxx-xx-xx)     Author             Description 
// ----------------------------------------------------------------------------- 
//   1.0          2024-10-22           Zhen Cao           Initial version 
//   1.1          2024-11-19           Daniel Dang        Changed format 
// ----------------------------------------------------------------------------- 
//==============================================================================
module flash_ctrl_top	#(
 // --------------------------------------------------------------------------
 // Parameter Declarations
 // --------------------------------------------------------------------------
parameter NO_I2C_REGS = 21,
parameter COEFFI_DATA = 28,
parameter ATM_MDOE    = 10,
parameter ATM_DATA    = 8
)(
  flash2imeas.master       flash2imeas,
  spi2flash.slave      spi2flash,
  //JTAG Related Pins
  input wire 	       TCK, 
  input wire	       RESETb, 
  input wire	       TDI, 
  input wire	       TESTEN, 

  output wire	       TDO, 
  output wire	       OEN,

  // input wire            scan_mode,
  input wire             clk,
  // input wire             clk_wr,
  input wire             rst_n,
  input  wire            ext_clk_sel ,

  input  wire                atm_unlock,
  input  wire                analog_test_mode,
  input  wire [ATM_MDOE-1:0]   atm_mode,           
  input  wire [ATM_DATA-1:0]   atm_data,

  output wire                regs_flash_dslp,


//  output  wire	      CHIP_FLASH_PORb,    // FLASH PORb -- Active low     
  input  wire	      CHIP_FLASH_DPSTB,   //DeepSleep input from FullChip
  inout  wire	      CHIP_FLASH_VPP,     // FLASH VPP -- Analog pad
  inout  wire	      CHIP_FLASH_VREF,
  input wire       	 ATPG_EN
 );


flash_bist     flash_bist();

////spi-flash////
wire       flash_regload_flg;
wire  [15:0]  DEBUG_FLASH;     
wire [7:0]    flash_data_spi;
wire [7:0]    spi_data_all;
wire [14:0]    spi_addr_all;
wire  [7:0]    rnd_regs;
wire           regs_FLASH_PORb;
wire spi_wr_sync;
//assign CHIP_FLASH_PORb = regs_FLASH_PORb;
wire FLASH_Reset_Done;
wire unlock,spi_rd_command,spi_wr_command,spi_regs_wrcmd;
wire wr_working,enable_reload2;
wire spi_ser,spi_cer;
wire spi_nvr/*,write_word,write_hword,write_u_hword,write_l_hword*/;
//wire [2:0] flash_rnd_slct;
wire ext_clk_sel_atpg;
wire flash_debug_mode0;
wire flash_debug_mode1;

wire [7:0] trim_regs[NO_I2C_REGS + COEFFI_DATA-1:0];

wire [7:0] spi_regs[NO_I2C_REGS-1:0];
wire [7:0] trim_read[NO_I2C_REGS-1:0];

wire         [7:0] FLASH_RDATA1;

assign ext_clk_sel_atpg = ATPG_EN ? 1'b0 : ext_clk_sel;

assign spi_data_all        = spi2flash.bd2f[0];
assign spi_addr_all        = {spi2flash.bd2f[2][6:0],spi2flash.bd2f[1][7:0]};

assign unlock              = spi2flash.sd2f[0];
assign spi_rd_command      = spi2flash.sd2f[1];
assign spi_wr_command      = spi2flash.sd2f[2];
assign spi_ser             = spi2flash.sd2f[3];
assign spi_cer             = spi2flash.sd2f[4];
assign spi_nvr             = spi2flash.sd2f[5];
assign spi_regs_wrcmd      = spi2flash.sd2f[6];
assign flash_debug_mode0   = spi2flash.sd2f[7];
assign flash_debug_mode1   = spi2flash.sd2f[8];


assign spi2flash.bd2s[0] = DEBUG_FLASH[7:0];
assign spi2flash.bd2s[1] = DEBUG_FLASH[15:8];
assign spi2flash.bd2s[2] = flash_debug_mode0? trim_regs[spi_addr_all[7:0]] :  flash_data_spi[7:0]; 
assign spi2flash.bd2s[3] = rnd_regs; 

assign spi2flash.sd2s[0] = wr_working; 
assign spi2flash.sd2s[1] = enable_reload2; 
assign spi2flash.sd2s[2] = (FLASH_Reset_Done & ~spi_wr_sync) | spi_wr_sync; 
//end

assign spi_regs            = spi2flash.trim;

assign spi2flash.trim_read = trim_read;







////bist////
wire [7:0] BIST_FLASH_RDATA;
wire [7:0] FLASH_RDATA_dft;
assign flash_bist.BIST_FLASH_RDATA = FLASH_RDATA_dft;



//wire trim_read_en_ack_sync;
              
wire	       regs_FLASH_CEb;
wire           regs_FLASH_WEb;
wire	       regs_FLASH_PROG;
wire           regs_FLASH_PROG2;
//wire [1:0]     regs_FLASH_BYTE;
wire	       regs_FLASH_OEb;
wire [5:0]     regs_FLASH_ADDR;
wire           regs_FLASH_ERASE;
wire           regs_FLASH_CHIP;
wire           regs_FLASH_RDN;
wire           regs_FLASH_CONFEN;
//wire           regs_FLASH_VREAD1;
//wire           regs_FLASH_VREAD0;
//wire           regs_FLASH_TMEN;


wire [7:0]   regs_FLASH_WDATA;
//wire [31:0]   regs_FLASH_WDATA1;
wire         regs_FLASH_NVR;
wire [14:0]  flash_inf_adr;
wire         flash_ser_en;
wire         flash_cer_en;

wire         flash_inf_blk_ser_set_en;
wire         flash_inf_blk_cer_set_en;
wire         flash_en;
wire         flash_inf_rw;
wire         spi_ser_sync;
wire         spi_cer_sync;
wire         spi_nvr_sync;
//wire         write_word_sync;
//wire         write_hword_sync;
//wire         write_u_hword_sync;
//wire         write_l_hword_sync;
wire         spi_wr_command_sync;
wire         unlock_sync;
wire         spi_rd_command_sync;
wire         nvr2_trim_tag;
wire         confen_valid; 
wire         flash_debug_mode1_sync;

wire [7:0] default_value_coeff[COEFFI_DATA-1:0];
wire [7:0] default_value_trim [NO_I2C_REGS-1:0];
 
wire [7:0]   flash_data_otp;
//Output from 2:1 Mux into FLASH IP
wire          FLASH_NVR;         // to flash
wire          FLASH_CEb;         //final CEb to FLASH
wire          FLASH_CEb_preatpg; //pre ATPG gate CEb
wire          FLASH_CEb_prebist; //pre BIST gate CEb
wire          FLASH_WEb;
wire          FLASH_PROG;
wire          FLASH_PROG2;
//wire [1:0]    FLASH_BYTE;
wire          FLASH_ERASE;
wire          FLASH_CHIP;
wire          FLASH_OEb;	    
wire          FLASH_VREAD1;
wire          FLASH_VREAD0;
wire          FLASH_TMEN;
wire   [14:0] FLASH_ADDR;
wire   [7:0] FLASH_WDATA;
wire   [7:0] FLASH_RDATA;
wire          FLASH_DPSTB;   
wire          FLASH_RDN;
wire          FLASH_BLOCK;
wire          FLASH_CONFEN;
wire          FLASH_VMON1;
wire          FLASH_VMON2;

wire   [7:0] regs_confen_data;
wire          FLASH_DPSTB_prebist; 
wire          FLASH_PORb;
wire          rd_spi;
wire          atm_unlock_sync;
wire          analog_test_mode_sync;
wire          trim_invalid_reload;
wire          key_word_flash_sync;

wire          reload_rnd;
wire          regs_FLASH_NVR_temp;
wire          rd_addr_add;

wire          status_pdone;
wire          status_pbusy;

wire  [6:0]   cunter;
wire          reload_trim;
wire          flash_inf_blk_rd_set_en;
wire          flash_inf_blk_wd_set_en;
wire          flash_ip_por_resetn;

//---------------------------------------------------
// Assign signals to DEBUG_FLASH ports
//---------------------------------------------------

assign DEBUG_FLASH[15]     = status_pdone;
assign DEBUG_FLASH[14]     = status_pbusy;
assign DEBUG_FLASH[13]     = wr_working;
assign DEBUG_FLASH[12]     = trim_invalid_reload;
assign DEBUG_FLASH[11]     = !reload_trim;
assign DEBUG_FLASH[10]     = FLASH_TMEN;
assign DEBUG_FLASH[9]     = FLASH_DPSTB;
assign DEBUG_FLASH[8]     = FLASH_NVR;
BUFX2M DNT_POR ( .A(regs_FLASH_PORb), .Y(DEBUG_FLASH[7]) );  
assign DEBUG_FLASH[6]     = FLASH_OEb;
assign DEBUG_FLASH[5]     = FLASH_CHIP;
assign DEBUG_FLASH[4]     = FLASH_ERASE;
assign DEBUG_FLASH[3]     = FLASH_PROG2;
assign DEBUG_FLASH[2]     = FLASH_PROG;
assign DEBUG_FLASH[1]     = FLASH_WEb;
assign DEBUG_FLASH[0]     = FLASH_CEb;

//wire [13:0] flash_inf_adr_trim;
//assign flash_inf_adr_trim = (flash_inf_adr < NO_I2C_REGS)? flash_inf_adr : 14'd0;

assign regs_FLASH_WDATA = spi_wr_command_sync? flash_data_otp : confen_valid? regs_confen_data : (cunter < NO_I2C_REGS)? analog_test_mode_sync? trim_regs[cunter] : spi_regs[cunter] : 8'h00;
//---------------------------------------------------
// Testmode 2:1 Muxing between func/BIST  and chip/BIST
//---------------------------------------------------

// Muxing between func/BIST paths
assign FLASH_NVR              = TESTEN ? flash_bist.BIST_FLASH_NVR    : regs_FLASH_NVR_temp;
MX2X4M DNT_WE_0_ ( .A(regs_FLASH_WEb), .B(flash_bist.BIST_FLASH_WEb), .S0(TESTEN), .Y(FLASH_WEb) );
assign FLASH_PROG             = TESTEN ? flash_bist.BIST_FLASH_PROG   : regs_FLASH_PROG;
assign FLASH_PROG2            = TESTEN ? flash_bist.BIST_FLASH_PROG2  : regs_FLASH_PROG2;
//assign FLASH_BYTE             = TESTEN ? flash_bist.BIST_FLASH_BYTE   : regs_FLASH_BYTE;
assign FLASH_ERASE            = TESTEN ? flash_bist.BIST_FLASH_ERASE  : regs_FLASH_ERASE;
assign FLASH_CHIP             = TESTEN ? flash_bist.BIST_FLASH_CHIP   : regs_FLASH_CHIP;
MX2X4M DNT_OE_0_ ( .A(regs_FLASH_OEb), .B(flash_bist.BIST_FLASH_OEb), .S0(TESTEN), .Y(FLASH_OEb) );
assign FLASH_VREAD1           = TESTEN ? flash_bist.BIST_FLASH_VREAD1 :  1'b0;
assign FLASH_VREAD0           = TESTEN ? flash_bist.BIST_FLASH_VREAD0 :  1'b0;
assign FLASH_TMEN             = TESTEN ? flash_bist.BIST_FLASH_TMEN   :  1'b0;
assign FLASH_ADDR             = TESTEN ? flash_bist.BIST_FLASH_ADDR   : {regs_FLASH_ADDR,flash_inf_adr[8:0]};
assign FLASH_WDATA            = TESTEN ? flash_bist.BIST_FLASH_WDATA  : regs_FLASH_WDATA;

assign FLASH_RDN              = TESTEN ? flash_bist.BIST_FLASH_RDN    : regs_FLASH_RDN; 
assign FLASH_BLOCK            = TESTEN ? flash_bist.BIST_FLASH_BLOCK  : 1'b0;
assign FLASH_CONFEN           = TESTEN ? flash_bist.BIST_FLASH_CONFEN : regs_FLASH_CONFEN;
assign FLASH_VMON1            = TESTEN ? flash_bist.BIST_FLASH_VMON1  : 1'b0;
assign FLASH_VMON2            = TESTEN ? flash_bist.BIST_FLASH_VMON2  : 1'b0;

MX2X4M DNT_PROB_ ( .A(regs_FLASH_PORb), .B(flash_bist.RESETb), .S0(TESTEN), .Y(FLASH_PORb) );

//Final FLASH_CEb is gated off to high with ATPG_EN
assign FLASH_CEb		   = ATPG_EN                               ? {1'b1}	     : FLASH_CEb_preatpg;
MX2X4M DNT_CE_0_ ( .A(FLASH_CEb_prebist), .B(flash_bist.BIST_FLASH_CEb), .S0(TESTEN), .Y(FLASH_CEb_preatpg) );


//Final FLASH_CEb is gated off to high when other FLASH Selected during BIST
assign FLASH_CEb_prebist      = TESTEN ? {1'b1}          : regs_FLASH_CEb; 

// Muxing between chip/BIST paths
assign FLASH_DPSTB            = TESTEN                          ? flash_bist.BIST_FLASH_DPSTB: FLASH_DPSTB_prebist;

// Final FLASH_DPSTB  is gated off to low when other FLASH Selected during BIST
assign FLASH_DPSTB_prebist    = TESTEN ? {1'b0}          : regs_flash_dslp; 
assign  BIST_FLASH_RDATA      = TESTEN ? FLASH_RDATA  : {8{1'b0}};

/////scan mode////
wire FLASH_CEb_dft;
wire FLASH_PORb_dft;
wire FLASH_NVR_dft;
wire FLASH_WEb_dft;
wire FLASH_PROG_dft;
wire FLASH_PROG2_dft;
//wire [1:0] FLASH_BYTE_dft;

wire FLASH_ERASE_dft;
wire FLASH_CHIP_dft;
wire FLASH_OEb_dft;
wire FLASH_VREAD1_dft;
wire FLASH_VREAD0_dft;
wire FLASH_TMEN_dft;
wire FLASH_DPSTB_dft;
wire FLASH_RDN_dft;
wire FLASH_BLOCK_dft;
wire FLASH_CONFEN_dft;
wire FLASH_VMON1_dft;
wire FLASH_VMON2_dft;


wire [7:0] dft_data;
reg  [7:0] dft_data_r;
assign FLASH_CEb_dft     = ATPG_EN ? 1'b1 : FLASH_CEb;
assign FLASH_PORb_dft    = ATPG_EN ? 1'b1 : FLASH_PORb;
assign FLASH_NVR_dft     = ATPG_EN ? 1'b0 : FLASH_NVR;
assign FLASH_WEb_dft     = ATPG_EN ? 1'b1 : FLASH_WEb;
assign FLASH_PROG_dft    = ATPG_EN ? 1'b0 : FLASH_PROG;
assign FLASH_PROG2_dft   = ATPG_EN ? 1'b0 : FLASH_PROG2;
//assign FLASH_BYTE_dft    = ATPG_EN ? 2'b0 : FLASH_BYTE;
assign FLASH_ERASE_dft   = ATPG_EN ? 1'b0 : FLASH_ERASE;
assign FLASH_CHIP_dft    = ATPG_EN ? 1'b0 : FLASH_CHIP;
assign FLASH_OEb_dft     = ATPG_EN ? 1'b1 : FLASH_OEb;
assign FLASH_VREAD1_dft  = ATPG_EN ? 1'b0 : FLASH_VREAD1;
assign FLASH_VREAD0_dft  = ATPG_EN ? 1'b0 : FLASH_VREAD0;
assign FLASH_TMEN_dft    = ATPG_EN ? 1'b0 : FLASH_TMEN;
assign FLASH_DPSTB_dft   = ATPG_EN ? 1'b1 : FLASH_DPSTB;
assign FLASH_RDN_dft     = ATPG_EN ? 1'b0 : FLASH_RDN;
assign FLASH_BLOCK_dft   = ATPG_EN ? 1'b0 : FLASH_BLOCK;
assign FLASH_CONFEN_dft  = ATPG_EN ? 1'b0 : FLASH_CONFEN;
assign FLASH_VMON1_dft   = ATPG_EN ? 1'b0 : FLASH_VMON1;
assign FLASH_VMON2_dft   = ATPG_EN ? 1'b0 : FLASH_VMON2;

assign dft_data          = FLASH_WDATA^{FLASH_NVR,FLASH_WEb,FLASH_PROG,FLASH_PROG2,FLASH_ERASE,FLASH_OEb,FLASH_CONFEN,FLASH_DPSTB};

assign FLASH_RDATA_dft = ATPG_EN ? dft_data_r : BIST_FLASH_RDATA;
assign  FLASH_RDATA1          = ATPG_EN ? dft_data_r : TESTEN ? {8{1'b0}}    : FLASH_RDATA;

always @ (posedge clk or negedge rst_n)
    if (~rst_n) dft_data_r <= 8'h00;
    else if (ATPG_EN)  dft_data_r <= dft_data;


//---------------------------------------------------
// Instantiate trim/value register
//---------------------------------------------------	
flash_trim_value #(
.NO_I2C_REGS(NO_I2C_REGS),
.COEFFI_DATA(COEFFI_DATA)
)  u_flash_trim_value(
.clk(clk),
.rst_n(rst_n),
.flash_regload_flg(flash_regload_flg),  
.spi_regs_wrcmd(spi_regs_wrcmd),
.spi_ser(spi_ser),
.spi_cer(spi_cer),
.spi_nvr(spi_nvr),
//.write_word(write_word),
//.write_hword(write_hword),
//.write_u_hword(write_u_hword),
//.write_l_hword(write_l_hword), 
.spi_wr_command(spi_wr_command), 
.unlock_en(unlock),
.spi_rd_command(spi_rd_command),
.flash_debug_mode1(flash_debug_mode1),
.spi_wr_sync(spi_wr_sync),
//.trim_read_en_ack(trim_read_en_ack_sync),
//.trim_read_en_ack_sync(trim_read_en_ack_sync),

.spi_ser_sync(spi_ser_sync),
.spi_cer_sync(spi_cer_sync),
.spi_nvr_sync(spi_nvr_sync),
.flash_debug_mode1_sync(flash_debug_mode1_sync),
.default_value_coeff(default_value_coeff),
.default_value_trim(default_value_trim),
//.write_word_sync(write_word_sync),
//.write_hword_sync(write_hword_sync),
//.write_u_hword_sync(write_u_hword_sync),
//.write_l_hword_sync(write_l_hword_sync), 
.spi_wr_command_sync(spi_wr_command_sync), 
.unlock_sync(unlock_sync),
.spi_rd_command_sync(spi_rd_command_sync),
.trim_read(trim_read),
.trim_regs(trim_regs),
.nf_coeff(flash2imeas.nf_coeff),
.atm_unlock_sync   (atm_unlock_sync),
.analog_test_mode_sync  (analog_test_mode_sync),
.analog_test_mode  (analog_test_mode),
.unlock_gpio       (atm_unlock),

.FLASH_Reset_Done  (FLASH_Reset_Done)
);


//---------------------------------------------------
// Instantiate flash register
//---------------------------------------------------		
flash_regs#(
.NO_I2C_REGS(NO_I2C_REGS),
.ATM_MDOE(ATM_MDOE),
.ATM_DATA(ATM_DATA)
) u_flash_regs (
.rst_n 				(rst_n),
.clk 				(clk),
.flash_inf_blk_rd_set_en 	(flash_inf_blk_rd_set_en),
.flash_inf_blk_wd_set_en 	(flash_inf_blk_wd_set_en),
.flash_ser_en              (flash_ser_en),
.flash_cer_en              (flash_cer_en),
.flash_inf_blk_ser_set_en  (flash_inf_blk_ser_set_en),
.flash_inf_blk_cer_set_en  (flash_inf_blk_cer_set_en),
.flash_ip_por_resetn       (flash_ip_por_resetn),
.spi_data_all(spi_data_all),
.spi_addr_all(spi_addr_all),
.flash_data_spi(flash_data_spi),
.flash_data_otp(flash_data_otp),
.regs_confen_data(regs_confen_data),
.nvr2_trim_tag             (nvr2_trim_tag),
.confen_valid              (confen_valid),
.atm_unlock                (atm_unlock_sync),
.analog_test_mode          (analog_test_mode_sync),
.atm_mode                  (atm_mode),
.atm_data                  (atm_data),
.spi_wr_command(spi_wr_command_sync), 
.unlock(unlock_sync),
.spi_rd_command(spi_rd_command_sync),
.flash_debug_mode1(flash_debug_mode1_sync),

.cunter       (cunter),
.wr_working   (wr_working),
.rd_addr_add  (rd_addr_add),
.spi_wr(spi_wr_sync),
.spi_ser(spi_ser_sync),
.spi_cer(spi_cer_sync),
.spi_nvr(spi_nvr_sync),
.default_value_coeff(default_value_coeff),
.default_value_trim(default_value_trim),
.spi_regs 			(spi_regs),
.trim_regs                      (trim_regs),
.flash_regload_flg              (flash_regload_flg),
.trim_invalid_reload            (trim_invalid_reload),
.flash_dout 			(FLASH_RDATA1),
.flash_addr 			(flash_inf_adr),
.reload_trim                    (reload_trim),
.rd_spi                         (rd_spi),
.flash_en 			(flash_en),
.rnd_regs                       (rnd_regs),
.reload_rnd                     (reload_rnd),
.flash_inf_rw 		        (flash_inf_rw),
.flash_nvr                      (regs_FLASH_NVR),    
.enable_reload2                 (enable_reload2)
//.wr_start                      ( wr_start)
);

//---------------------------------------------------
// Instantiate Sub-Modules
//---------------------------------------------------

flash_rw_ctrl u_flash_rw_ctrl
(
.clk                            (clk),
.rst_n                          (rst_n),
.ext_clk_sel                    (ext_clk_sel_atpg),
.flash_dslp                     (CHIP_FLASH_DPSTB),
.flash_inf_blk_rd_set_en 	(flash_inf_blk_rd_set_en),
.flash_inf_blk_wd_set_en 	(flash_inf_blk_wd_set_en),
//.flash_inf_blk_ao_rd_set_en     (flash_inf_blk_ao_rd_set_en),
.flash_ip_por_resetn       (flash_ip_por_resetn),
.flash_ser_en              (flash_ser_en),
.flash_cer_en              (flash_cer_en),
.flash_inf_blk_ser_set_en  (flash_inf_blk_ser_set_en),
.flash_inf_blk_cer_set_en  (flash_inf_blk_cer_set_en),
.flash_en 			(flash_en),
.flash_inf_rw 		        (flash_inf_rw),
.reload_trim                    (reload_trim),
.nvr2_trim_tag                  (nvr2_trim_tag),
.confen_valid                   (confen_valid),
.rd_spi                         (rd_spi),
.reload_rnd                     (reload_rnd),
.flash_inf_adr                  (flash_inf_adr[14:9]		),
//.flash_inf_wdata                (spi_regs[flash_inf_adr]	),
.rnd_regs                       (rnd_regs),
.flash_nvr_in                   (regs_FLASH_NVR),
//.trim_read_en_ack               (trim_read_en_ack_sync),
//.write_word                (write_word_sync),
//.write_hword               (write_hword_sync),
//.write_u_hword             (write_u_hword_sync),
//.write_l_hword             (write_l_hword_sync),  
.status_pdone              (status_pdone),
.status_pbusy              (status_pbusy),
.rd_addr_add               (rd_addr_add),
// Interface to FLASH IP
.FLASH_NVR(regs_FLASH_NVR_temp),
.FLASH_CEb(regs_FLASH_CEb),
.FLASH_WEb(regs_FLASH_WEb),
.FLASH_PROG(regs_FLASH_PROG),
.FLASH_PROG2(regs_FLASH_PROG2),
.FLASH_ERASE(regs_FLASH_ERASE),
.FLASH_CHIP(regs_FLASH_CHIP),
.FLASH_OEb(regs_FLASH_OEb),
.FLASH_PORb(regs_FLASH_PORb),
.FLASH_RDN(regs_FLASH_RDN),
.FLASH_CONFEN(regs_FLASH_CONFEN),

.flash_dslp_ip(regs_flash_dslp),   
//.FLASH_VREAD1(regs_FLASH_VREAD1),
//.FLASH_VREAD0(regs_FLASH_VREAD0),
//.FLASH_TMEN(regs_FLASH_TMEN),
.FLASH_ADDR(regs_FLASH_ADDR)
//.FLASH_WDATA(regs_FLASH_WDATA1),
//.FLASH_BYTE(regs_FLASH_BYTE)


);
 

BIS_FPFLE032K09DA u_BIS_016K29DE (
.flash_bist       (flash_bist),

 .TCK               (TCK),           
 .RESETb            (RESETb),
 .TDI               (TDI),
 .TESTEN            (TESTEN), 
 .TDO               (TDO),
 .OEN               (OEN)

);


`ifdef FPGA
ram_32k u_32k (
.BRAM_PORTA_0_addr(FLASH_ADDR),
.BRAM_PORTA_0_clk(clk),
.BRAM_PORTA_0_din(8'b0),
.BRAM_PORTA_0_dout(FLASH_RDATA),
.BRAM_PORTA_0_en(~(FLASH_CEb | FLASH_OEb))
);
`else

FPFLE032K09DA u_32k
(
.A(FLASH_ADDR),
.DIN(FLASH_WDATA),
.DOUT(FLASH_RDATA),
.RDN(FLASH_RDN_dft),
.NVR(FLASH_NVR_dft),
.CEb(FLASH_CEb_dft),
.WEb(FLASH_WEb_dft),
.PROG(FLASH_PROG_dft),
.PROG2(FLASH_PROG2_dft),
.ERASE(FLASH_ERASE_dft),
.BLOCK(FLASH_BLOCK_dft),
.CHIP(FLASH_CHIP_dft),
.OEb(FLASH_OEb_dft),
.CONFEN(FLASH_CONFEN_dft),
.DEEPPD(FLASH_DPSTB_dft),

.PORb(FLASH_PORb_dft),
.VREAD1(FLASH_VREAD1_dft),
.VREAD0(FLASH_VREAD0_dft),
.TMEN(FLASH_TMEN_dft),
.VMON1(FLASH_VMON1_dft), 
.VMON2(FLASH_VMON2_dft), 
.VREF(CHIP_FLASH_VREF),  
`ifdef UPF_SIM
 .vdd(VDD),
 .gnd(VSS),
`endif

.TM0VPP(CHIP_FLASH_VPP)
);

`endif



endmodule
