/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/* File Name	: clkctrl_always_on.v                                                   */
/* Project	: BAF4P1                                                     */
/* Description	: clock control                                                         */
/* Designer	: Daniel Wang                                                               */
/* Date		: 05/28/2019                                                                */
/* Revision	:                                                                           */
/* R001 first draft                             05/28/2019                              */
/* R002 add scan_clk mux                        07/29/2019                              */
/* R003 remove sram_en/dflash_en                09/10/2019                              */
/* R004 updated by Mohsen Radfar for BAF4P1 	14/09/2022				*/
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
module clk_ctrl_always_on (
input  wire         wakeup_i, 		    //disabled (active high) when in low power mode (connects to the wake up pin)
input  wire         ext_clk_sel,            // external clk select
input  wire         ext_hfclk,              // external high frequency clk
input  wire         hfosc,                  // hfosc base clock input
input  wire         scan_clk,               // atpg clock
input  wire         atpg_en,                // atpg enable
//input  wire         fclk_dynen,             // fclk dynamic clock enable
output wire         hfosc_atpg             // hfosc after atpg mux
//output wire         fclk                   // fclk after clock switching
);

reg  [2:0]  pclk_div_cnt;
reg         i_pclken;
wire	      fclk_en;

wire        lfosc_atpg;
wire        hfosc_mux;
wire        lfosc_mux;
wire        scan_clk_and;

`ifdef FPGA
assign hfosc_mux = ext_clk_sel ? ext_hfclk : hfosc;
assign hfosc_atpg = hfosc_mux;
`else
// external clock select
CLKMX2X4M DNT_HFOSC_MUX (.A(hfosc), .B(ext_hfclk), .S0(ext_clk_sel & wakeup_i), .Y(hfosc_mux));
AND2X4M DNT_ATPG_AL_ON (.Y(scan_clk_and), .A(scan_clk), .B(wakeup_i)); //ISO cell for scan clock
// scan clock mux
CLKMX2X4M DNT_HFOSC_ATPG (.A(hfosc_mux), .B(scan_clk_and), .S0(atpg_en), .Y(hfosc_atpg));
`endif

endmodule

