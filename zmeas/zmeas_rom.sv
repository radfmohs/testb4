////////
// Design     : bwd_ctrl
// Dependency : None
// Description: accept address from fwd and bwd data path and provide
//            : sine/cosine values
// Testbech   : 
// Rev        : 1.0 :  21April2019 : 
// Rev        : 5.0 :  7june2019 : ROM model changed to via_hdf from hhgrace_arm
//            : 6.0 : 9aug: reverted to M31 rom
//            : 7.0 : 21aug: bist bypass
//            : 8.0 : 30aug : another ROM 512by10 for DFT calcl
//            : 9.0 : 19sep: changed rom memory to BK4 due to floorplan
//            requirements from top
// Company    : Nanochap
// Author     : RS
// Notes      : for ROM interface. fwd freq is 2MHz , bwd freq is 250KHz 
//            : every 8th cycle of 250KHz, fwd path will miss access to ROM.
//            : because ROM is shared between fwd and bwd data path: ok with
//            : SA
//            : ON Aug 29: Ref: SA: above is not ok for16khz and 32khz. 
//            : He has not designed his DAC for snr more than 50db. 
//            : So added one mroe rom
// TODO       : 1] clock gate rom clk allow only if dds_en=1 or adc_enable=1           
//            : 2] Possibility of ROM on AHB and run uc @40/32MHz???? instead
//            : of handling ROM inside zmeas_digital block
////////

`include "zmeas_parameters.vh"

module zmeas_rom(
	//inputs from clkrst
	input nrst,
        input romclk,	//mclk changed to 4mhz because dds no longer operates on 16mhz
	//inputs from fwd and bwd path
        input [`SINROMDFT_ADDRS_WIDTH - 1:0] addrs_in_bwd,
	input [`SINROM_ADDRS_WIDTH - 1:0] addrs_in_fwd,
        //outputs
	`ifdef FPGA
	output wire [9:0] rom_data_out_dac,  
	output wire [9:0] rom_data_out_bwdctrl  
	`else
	output reg [9:0] rom_data_out_dac,  
	output reg [9:0] rom_data_out_bwdctrl  
	`endif
);

       
	`ifdef FPGA
	wire [9:0] rom_data_out_dds;
	wire [9:0] rom_data_out_dft;
	ram_4096_dds u_ram_4096_dds(
		.BRAM_PORTA_0_addr(addrs_in_fwd),
		.BRAM_PORTA_0_clk(romclk),
		.BRAM_PORTA_0_din(10'b0),
		.BRAM_PORTA_0_dout(rom_data_out_dds),
		.BRAM_PORTA_0_en(1'b1)
		//BRAM_PORTA_0_we
		);
	ram_256_dft u_ram_256_dft(
                .BRAM_PORTA_0_addr(addrs_in_bwd[7:0]),
                .BRAM_PORTA_0_clk(romclk),
                .BRAM_PORTA_0_din(10'b0),
                .BRAM_PORTA_0_dout(rom_data_out_dft),
                .BRAM_PORTA_0_en(1'b1)
                //BRAM_PORTA_0_we
                 );
                

	assign		rom_data_out_dac = rom_data_out_dds;
	assign		rom_data_out_bwdctrl = rom_data_out_dft;

	`else 
        //wires
	wire [9:0] rom_data_out_dds;
	wire [9:0] rom_data_out_dft;
	//xin removed 27Jun2024
	//wire [9:0] QDFT [256-1:0];
	wire [9:0] QDDS [512-1:0];
	
	//seq
	always @(posedge romclk or negedge nrst) begin
		if(!nrst) begin
			rom_data_out_dac <= 0;
			rom_data_out_bwdctrl <= 0;
		end
		else begin
			rom_data_out_dac <= rom_data_out_dds;
			rom_data_out_bwdctrl <= rom_data_out_dft;
		end //nrst
	end //always
	
	//instantiate rom ip here
	//M31HDCR100NL130P_4096X10CM16BK4 u_rom_diff_hdf_dds (.CEN(0), .A(addrs_in_fwd), .CLK(romclk), .Q(rom_data_out_dds), .MSE(0), .MS(0)); //hhgrace
	assign rom_data_out_dds = QDDS[512-1 - addrs_in_fwd];
	//M31HDCR100NL130P_512X10CM16BK1 u_rom_diff_hdf_dft (.CEN(0), .A(addrs_in_bwd), .CLK(romclk), .Q(rom_data_out_dft), .MSE(0), .MS(0)); //hhgrace
	//xin removed 27Jun2024 because we don't use dft in this version
	//assign rom_data_out_dft = QDFT[256-1 - addrs_in_bwd];
	assign rom_data_out_dft = 10'b0;

	//ROMs replaced by hard coded LUTs:
	//xin removed 27Jun2024
	//assign QDFT = '{`include "../../verification/models/hhg_rom/dft_rom.txt"};
	assign QDDS = '{`include "../../verification/models/hhg_rom/dds_rom.txt"};
	`endif	

endmodule
