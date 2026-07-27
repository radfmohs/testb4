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

reg            spi_regs_wrcmd;
reg [7:0]      spi_to_flash_data0;
reg [7:0]      spi_to_flash_data1;
reg [7:0]      spi_to_flash_data2;
reg [7:0]      spi_to_flash_data3;
reg [7:0]      spi_to_flash_data4;
reg [7:0]      spi_to_flash_data5;
reg [7:0]      spi_to_flash_data6;
reg [7:0]      spi_to_flash_data7;

wire [7:0] flash_to_ana_trim0; 
wire [7:0] flash_to_ana_trim1; 
wire [7:0] flash_to_ana_trim2;
wire [7:0] flash_to_ana_trim3;
wire [7:0] flash_to_ana_trim4;
wire [7:0] flash_to_ana_trim5;
wire [7:0] flash_to_ana_trim6;
wire [7:0] flash_to_ana_trim7;
                               
wire [7:0] flash_to_ana_value0;
wire [7:0] flash_to_ana_value1;
wire [7:0] flash_to_ana_value2;
wire [7:0] flash_to_ana_value3;
wire [7:0] flash_to_ana_value4;
wire [7:0] flash_to_ana_value5;
wire [7:0] flash_to_ana_value6;
wire [7:0] flash_to_ana_value7;


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
		.clk_wr                 (clk_wr),
		.rst_n			(rst_n),  
		.unlock			(unlock),

                .spi_regs_wrcmd(spi_regs_wrcmd),
                .spi_to_flash_data0(spi_to_flash_data0),
                .spi_to_flash_data1(spi_to_flash_data1),
                .spi_to_flash_data2(spi_to_flash_data2),
                .spi_to_flash_data3(spi_to_flash_data3),
                .spi_to_flash_data4(spi_to_flash_data4),
                .spi_to_flash_data5(spi_to_flash_data5),
                .spi_to_flash_data6(spi_to_flash_data6),
                .spi_to_flash_data7(spi_to_flash_data7),


		.flash_to_ana_trim0  (flash_to_ana_trim0), 
                .flash_to_ana_trim1  (flash_to_ana_trim1), 
                .flash_to_ana_trim2  (flash_to_ana_trim2),
                .flash_to_ana_trim3  (flash_to_ana_trim3),
                .flash_to_ana_trim4  (flash_to_ana_trim4),
                .flash_to_ana_trim5  (flash_to_ana_trim5),
                .flash_to_ana_trim6  (flash_to_ana_trim6),
                .flash_to_ana_trim7  (flash_to_ana_trim7),
                .flash_to_ana_value0(flash_to_ana_value0), 
                .flash_to_ana_value1(flash_to_ana_value1),
                .flash_to_ana_value2(flash_to_ana_value2),
                .flash_to_ana_value3(flash_to_ana_value3), 
                .flash_to_ana_value4(flash_to_ana_value4),
                .flash_to_ana_value5(flash_to_ana_value5),
                .flash_to_ana_value6(flash_to_ana_value6), 

                .CHIP_FLASH_PORb        (CHIP_FLASH_PORb),
                .CHIP_FLASH_DPSTB       (CHIP_FLASH_DPSTB),
                .CHIP_FLASH_VPP         (CHIP_FLASH_VPP),
                .CHIP_FLASH_VREF        (CHIP_FLASH_VREF),
//                .CHIP_HCLK_DIV          (CHIP_HCLK_DIV), 
		.DEBUG_FLASH            (DEBUG_FLASH),
	        .ATPG_EN                (ATPG_EN )    
);

initial begin
	spi_regs_wrcmd     = 0;
	spi_to_flash_data0 = 8'h01; 
	spi_to_flash_data1 = 8'h02;
	spi_to_flash_data2 = 8'h04;
	spi_to_flash_data3 = 8'h08;
	spi_to_flash_data4 = 8'h10;
	spi_to_flash_data5 = 8'h20;
	spi_to_flash_data6 = 8'h40;
	spi_to_flash_data7 = 8'h80;
        clk_wr             = 0;

end



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
BIST_TESTMODE         = 2'b01;


end

parameter TCK_period = 100;
  always #(TCK_period/2)  TCK = ~TCK;


integer k;  
reg [14:0] addr;
reg [7:0]  data;

initial
begin	
addr = 15'h0000;
data = 8'h00;
reset_signal;
reset;
#50
#100000
for(k=0;k<64-1;k=k+1)begin
prgm_main_word(addr,data);
#100000
addr = addr + 1'b1;
data = data + 1'b1;
end

#10000
k = 0;
addr = 8'h00;
data = 8'h00;
#10000

for(k=0;k<64-1;k=k+1)begin
read_main_word(addr);
#100000
addr = addr + 1'b1;
data = data + 1'b1;
end

#10000
k = 0;
addr = 8'h00;
data = 8'h00;
#10000

for(k=0;k<64-1;k=k+1)begin
read_check(data,4'hc);
#100000
addr = addr + 1'b1;
data = data + 1'b1;
end

#1000000;
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
