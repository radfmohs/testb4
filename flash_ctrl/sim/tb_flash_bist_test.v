//TB
`timescale 1ns/1ps
`define flash_path tb_flash_bist_test.flash_ctrl_top_inst.u_32k
`define flash_bist_path ../../../../../verification/models/flash_bist_master/
`include "constants_BIS_FPFLE032K09DA.v"

module tb_flash_bist_test;

reg 		clk, rst_n,clk_wr;
reg 		unlock;
reg [31:0]     regs_FLASH_BADSECTOR0;
reg	       CHIP_FLASH_PORb;   
reg	       CHIP_FLASH_DPSTB;   
wire	       CHIP_FLASH_VPP;
reg            CHIP_FLASH_VREF;
reg   [1:0]    CHIP_HCLK_DIV;   
wire  [15:0]   DEBUG_FLASH;
reg      	 ATPG_EN; 
reg	[7:0] i2c_regs [63:0];
wire	[7:0] shadow_regs [63:0];

  reg  RESETb;
  reg  TCK;
  wire TDO;
  wire OEN;
  reg  TESTEN;
  reg  TDI;
  reg [1:0] BIST_TESTMODE;
  reg  [39:0] PDI;



assign CHIP_FLASH_VPP = 1'b1;

parameter	CLK_PERIOD = 1e9/300000;

flash_ctrl_top flash_ctrl_top_inst(
	        .TCK               (TCK),           
                .RESETb            (RESETb),
                .TDI               (TDI),
                .TESTEN            (TESTEN), 
                .TDO               (TDO),
                .OEN               (OEN),

		.clk			(clk),  

		.rst_n			(rst_n),  
   

	.flash_to_ana_trim0  (flash_to_ana_trim0), 
        .flash_to_ana_trim1  (flash_to_ana_trim1), 
        .flash_to_ana_trim2  (flash_to_ana_trim2),
        .flash_to_ana_trim3  (flash_to_ana_trim3),
        .flash_to_ana_trim4  (flash_to_ana_trim4),
        .flash_to_ana_trim5  (flash_to_ana_trim5),

.flash_to_ana_bgh_vtrim   (flash_to_ana_bgh_vtrim  ),  
.flash_to_ana_bgh_ctrl    (flash_to_ana_bgh_ctrl   ),
.flash_to_ana_bgl_vtrim   (flash_to_ana_bgl_vtrim  ),
.flash_to_ana_bgl_ctrl    (flash_to_ana_bgl_ctrl   ),
.flash_to_ana_ldo1v5_trim (flash_to_ana_ldo1v5_trim),
.flash_to_ana_dacbuf_trim (flash_to_ana_dacbuf_trim),
.flash_to_ana_osc_trim    (flash_to_ana_osc_trim),



		
                .CHIP_FLASH_PORb        (CHIP_FLASH_PORb),
                .CHIP_FLASH_DPSTB       (CHIP_FLASH_DPSTB),
                .CHIP_FLASH_VPP         (CHIP_FLASH_VPP),
                .CHIP_FLASH_VREF        (CHIP_FLASH_VREF),
//                .CHIP_HCLK_DIV          (CHIP_HCLK_DIV), 
		.DEBUG_FLASH            (DEBUG_FLASH),
	        .ATPG_EN                (ATPG_EN )    
);




initial begin
regs_FLASH_BADSECTOR0 = 32'h80000000;
CHIP_FLASH_PORb       = 1'b0;
CHIP_FLASH_DPSTB      = 1'b0;
CHIP_FLASH_VREF       = 1'b0;
CHIP_HCLK_DIV         = 1'b0;
BIST_TESTMODE         = 2'b00;
TCK                   = 1'b0;
  rst_n  =0;

ATPG_EN               = 1'b0;
#100
rst_n  =1;
CHIP_FLASH_PORb       = 1'b1;
#100
CHIP_FLASH_PORb       = 1'b0;
#100
CHIP_FLASH_PORb       = 1'b1;
BIST_TESTMODE         = 2'b01;


end

parameter TCK_period = 100;
  always #(TCK_period/2)  TCK = ~TCK;


initial
  begin

   
       $readmemh("../../../../../verification/models/flash_bist_master/stimulus/Main.txt", `flash_path.Main_mem);
       $readmemh("../../../../../verification/models/flash_bist_master/stimulus/RDN.txt",  `flash_path.RDN_mem);
       $readmemh("../../../../../verification/models/flash_bist_master/stimulus/inf0.txt", `flash_path.inf0_mem);
       $readmemh("../../../../../verification/models/flash_bist_master/stimulus/inf1.txt", `flash_path.inf1_mem); 
  
  reset;

 /****************Start 10M test********************/ 
//serial_test;
#50
prgm_main_10M(8'haa);
read_main_array_10M;
read_check(8'haa,`PGM_WR);
berase_10M;
prgm_main_CKB_10M(8'h0);
read_main_array_10M;
read_check(8'h0,`PGMCB_WR);
serase_main_10M;
prgm_diag_main_10M(8'h55);
read_main_array_10M;
read_check(8'h55,`PGMDIAG_WR);
prgm_RDN_10M(8'h5a);
read_RDN_10M;
read_check_rdn(8'h5a,`PGM_WR);
serase_RDN_10M;
prgm_ickb_RDN_10M(8'h0a);
read_RDN_10M;
read_check_rdn(8'h0a,`PGMICB_WR);
serase_1st_NVR_10M;
prgm_1st_NVR_ICB_10M(8'h0);
read_NVR_10M;
read_check_nvr(8'h0,`PGMICB_WR);
serase_1st_NVR_10M;
prgm_1st_NVR_10M(8'h0a);
read_NVR_10M;
read_check_nvr(8'h0a,`PGM_WR);

  $finish;
end

`include "../../../../../verification/models/flash_bist_master/basic_task.inc"


initial begin
	clk = 0;
	#1000
forever #(57.5)  clk = ~clk;
end

initial begin
$fsdbDumpfile("flash_ctrl.fsdb");
$fsdbDumpvars;
$fsdbDumpMDA;
end



endmodule
