//TB

`timescale 1ns/10ps

module tb_flash_ctrl_top;

reg 		fclk, poresetn,clk_wr;
reg 		unlock;

reg [31:0]     regs_FLASH_BADSECTOR0;
 
 reg	       CHIP_FLASH_PORb;   
reg	       CHIP_FLASH_DPSTB;   
wire	       CHIP_FLASH_VPP;
reg            CHIP_FLASH_VREF;
reg   [1:0]    CHIP_HCLK_DIV;

   
wire  [15:0]   DEBUG_FLASH;
reg      	 ATPG_EN; 
 reg	[7:0] i2c_regs [9:0];
 wire	[7:0] shadow_regs [9:0];
 wire	[7:0] trim_regs [9:0];

  reg  RESETb;
  reg  TCK;
  wire TDO;
  wire OEN;
  reg  TESTEN;
  reg  TDI;
  reg [1:0] BIST_TESTMODE;
  reg  [39:0] PDI;

reg       spi_regs_wrcmd;
reg [7:0] d2a_trim0_to_flash; 
reg [7:0] d2a_trim1_to_flash; 
reg [7:0] d2a_trim2_to_flash;
reg [7:0] d2a_trim3_to_flash;
reg [7:0] d2a_trim4_to_flash;
reg [7:0] d2a_trim5_to_flash;
reg [7:0] d2a_trim6_to_flash;
reg [7:0] d2a_trim8_to_flash;
reg [7:0] d2a_trim9_to_flash;
reg [7:0] d2a_trim10_to_flash;
reg [7:0] d2a_trim11_to_flash;
reg [7:0] d2a_trim12_to_flash;
reg [7:0] d2a_trim13_to_flash;
reg [7:0] d2a_trim14_to_flash;
reg [7:0] d2a_trim15_to_flash;
reg [7:0] d2a_alt_fun_to_flash;

wire [7:0] d2a_trim0_from_flash; 
wire [7:0] d2a_trim1_from_flash; 
wire [7:0] d2a_trim2_from_flash;
wire [7:0] d2a_trim3_from_flash;
wire [7:0] d2a_trim4_from_flash;
wire [7:0] d2a_trim5_from_flash;
wire [7:0] d2a_trim6_from_flash;
wire [7:0] d2a_trim8_from_flash;
wire [7:0] d2a_trim9_from_flash;
wire [7:0] d2a_alt_fun_from_flash;
wire [7:0] d2a_trim10_from_flash;
wire [7:0] d2a_trim11_from_flash;
wire [7:0] d2a_trim12_from_flash;
wire [7:0] d2a_trim13_from_flash;
wire [7:0] d2a_trim14_from_flash;
wire [7:0] d2a_trim15_from_flash;


wire enable_reload2;

assign CHIP_FLASH_VPP = 1'b1;

parameter	CLK_PERIOD = 1e9/300000;


// FLASH CTRL TOP//BIST TEST MODE//
flash_ctrl_top flash_ctrl_top_inst(
	.TCK               (flash_bist_tck_atpg),           
	.RESETb            (flash_bist_resetn_atpg),
	.TDI               (flash_bist_tdi),
	.TESTEN            (0), 
	.TDO               (flash_bist_tdo),
	.OEN               (flash_bist_oen),
 
        .spi_regs_wrcmd      (spi_regs_wrcmd),
	.unlock              (unlock),
	.flash_to_ana_trim0  (d2a_trim0_from_flash) , //flash_to_ana_trim0), 
	.flash_to_ana_trim1  (d2a_trim1_from_flash), //flash_to_ana_trim1), 
	.flash_to_ana_trim2  (d2a_trim2_from_flash), //flash_to_ana_trim2),
	.flash_to_ana_trim3  (d2a_trim3_from_flash), //flash_to_ana_trim3),
	.flash_to_ana_trim4  (d2a_trim4_from_flash), //flash_to_ana_trim4),
	.flash_to_ana_trim5  (d2a_trim5_from_flash), //flash_to_ana_trim5),
	.flash_to_ana_trim6  (d2a_trim6_from_flash), //flash_to_ana_trim6),
//	.flash_to_ana_trim7  (d2a_alt_fun_from_flash), //flash_to_ana_trim6),
//	.flash_to_ana_trim8  (d2a_trim8_from_flash), //flash_to_ana_trim6),
//	.flash_to_ana_trim9  (d2a_trim9_from_flash), //flash_to_ana_trim6),
//	.flash_to_ana_trim10 (d2a_trim10_from_flash), //flash_to_ana_trim6),
//	.flash_to_ana_trim11  (d2a_trim11_from_flash), //flash_to_ana_trim6),
//	.flash_to_ana_trim12  (d2a_trim12_from_flash), //flash_to_ana_trim6),
//	.flash_to_ana_trim13  (d2a_trim13_from_flash), //flash_to_ana_trim6),
//	.flash_to_ana_trim14  (d2a_trim14_from_flash), //flash_to_ana_trim6),
//	.flash_to_ana_trim15  (d2a_trim15_from_flash), //flash_to_ana_trim6),
	.flash_to_ana_bgh_vtrim   (),  
	.flash_to_ana_bgh_ctrl    (),
//	.flash_to_ana_bgl_vtrim   (),
//	.flash_to_ana_bgl_ctrl    (),
	.flash_to_ana_ldo1v5_trim (),
//	.flash_to_ana_dacbuf_trim (),
	.flash_to_ana_osc_trim    (),

        .spi_to_flash_data0(d2a_trim0_to_flash),
        .spi_to_flash_data1(d2a_trim1_to_flash),
        .spi_to_flash_data2(d2a_trim2_to_flash),
        .spi_to_flash_data3(d2a_trim3_to_flash),
        .spi_to_flash_data4(d2a_trim4_to_flash),
        .spi_to_flash_data5(d2a_trim5_to_flash),
        .spi_to_flash_data6(d2a_trim6_to_flash),
//        .spi_to_flash_data7(d2a_alt_fun_to_flash), 
//        .spi_to_flash_data8(d2a_trim8_to_flash),
//        .spi_to_flash_data9(d2a_trim9_to_flash),
//        .spi_to_flash_data10(d2a_trim10_to_flash),
//        .spi_to_flash_data11(d2a_trim11_to_flash),
//        .spi_to_flash_data12(d2a_trim12_to_flash),
//        .spi_to_flash_data13(d2a_trim13_to_flash),
//        .spi_to_flash_data14(d2a_trim14_to_flash),
//        .spi_to_flash_data15(d2a_trim15_to_flash),

	.FLASH_Reset_Done       (FLASH_Reset_Done), 	
	.clk			(clk_wr),//(fclk),  
	.rst_n			(poresetn),  
	.CHIP_FLASH_PORb        (CHIP_FLASH_PORb),
	.CHIP_FLASH_DPSTB       (CHIP_FLASH_DPSTB),
	.CHIP_FLASH_VPP         (1'b1),
	.CHIP_FLASH_VREF        (CHIP_FLASH_VREF),
	.DEBUG_FLASH            (DEBUG_FLASH),
	.enable_reload2         (FLASH_BUSY),
	.ATPG_EN                (ATPG_EN)    
);


initial begin
d2a_trim0_to_flash = 8'h5a; 
d2a_trim1_to_flash = 8'h06;
d2a_trim2_to_flash = 8'h06;
d2a_trim3_to_flash = 8'h06;
d2a_trim4_to_flash = 8'h16;
d2a_trim5_to_flash = 8'h26;
d2a_trim6_to_flash = 8'h46;
d2a_trim8_to_flash = 8'h86;
d2a_trim9_to_flash = 8'h86;
d2a_alt_fun_to_flash = 8'h86;
d2a_trim10_to_flash = 8'h87;
d2a_trim11_to_flash = 8'h88;
d2a_trim12_to_flash = 8'h89;
d2a_trim13_to_flash = 8'h8a;
d2a_trim14_to_flash = 8'h8b;
d2a_trim15_to_flash = 8'h8c;

end

parameter TCK_period = 100;

initial begin
regs_FLASH_BADSECTOR0 = 32'h80000000;
CHIP_FLASH_PORb       = 1'b0;
CHIP_FLASH_DPSTB      = 1'b0;
CHIP_FLASH_VREF       = 1'b0;
CHIP_HCLK_DIV         = 1'b0;
BIST_TESTMODE         = 2'b00;
TCK                   = 1'b0; 
ATPG_EN               = 1'b0;

#1000
CHIP_FLASH_PORb       = 1'b1;
#1000
CHIP_FLASH_PORb       = 1'b0;

#920
CHIP_FLASH_PORb       = 1'b1;


forever #(TCK_period/2)  TCK = ~TCK;

end

//parameter TCK_period = 100;
//  always #(TCK_period/2)  TCK = ~TCK;

initial
begin
	$display("Initializing EEPROM BLOCK with 128 bytes");
        $readmemh("flash.hex",tb_flash_ctrl_top.flash_ctrl_top_inst.u_32k.Main_mem); 
        $readmemh("inf1.hex", tb_flash_ctrl_top.flash_ctrl_top_inst.u_32k.inf1_mem);
	$readmemh("inf0.hex", tb_flash_ctrl_top.flash_ctrl_top_inst.u_32k.inf0_mem); 

	poresetn = 1'b0;
	unlock = 0;
	spi_regs_wrcmd =0;
		reset;
		#70
	 serase_1st_NVR_10M;
	#(200*CLK_PERIOD/2);
                reset;
	poresetn = 1'b1; //Reading EEPROM starts after reset

	#(1600*CLK_PERIOD/2)
        spi_regs_wrcmd =1;
        #10000
	spi_regs_wrcmd =0;
	unlock = 1; //Programming EEPROM with i2c_regs values
	#(800*CLK_PERIOD/2)
	#10000000
        poresetn = 1'b0;
	unlock = 0;
	#1000
	poresetn = 1'b1;
	#10000000
	$finish();
end

initial begin
	clk_wr = 0;
	#1000
forever #(500)  clk_wr = ~clk_wr;
end
initial begin
	fclk = 0;
	#1000
forever #(1958)  fclk = ~fclk;
end

`include "../../../verification/models/flash_bist_master/basic_task.inc"

initial begin
$fsdbDumpfile("flash_ctrl.fsdb");
$fsdbDumpvars;
$fsdbDumpMDA;
end



endmodule
