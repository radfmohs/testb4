//------------------------------------------------------------------------------
// Nanochap Pty Ltd (c) 2021
//
// Module Name : always_on_reset_ctrl
// Description : simple reset selection MUX for always on BMS Dig
//------------------------------------------------------------------------------
// Revision History
//------------------------------------------------------------------------------
// Revision     Date        Author
//------------------------------------------------------------------------------
// 0.1          4/11/2021  Mohsen Radfar 
// Initial Rev
//------------------------------------------------------------------------------

module reset_ctrl_always_on (
input  wire         por_resetn,                 // Power on reset, low active
input  wire 	      iopad_testmode0_en_y,
input  wire 	      iopad_testmode1_en_y,
input  wire	        wakeup_i,
input  wire	        sw_por,			//always on A2D SW POR directly from analog
input  wire         ext_resetn,                 // External reset, low active
input  wire         scan_rst_n,                 // Scan Reset
input  wire         atpg_en,                    // ATPG enable (for DFT)
input  wire         hfosc_atpg,                 // hfosc base clock input
output wire         poresetn,                   // Connect to poresetn of clk ctrl
output wire	        wakeup_done			// wake up done after timer (NOT SCANABLE)
);

wire        global_rstn;

reg [3:0]   por_cnt;
wire        por_tmout;
reg         por_tmout_resetn;

wire        por_resetn_atpg;
wire	      scan_rst_n_and;

reg [6:0]   sw_por_cnt;
wire        sw_por_tmout;
reg         sw_por_tmout_resetn;
wire	      sw_por_resetn;
wire	      sw_por_resetn_atpg;
wire	sw_por_resetn_bak_atpg;
wire        por_resetn_sync;
assign scan_rst_n_and = wakeup_i & scan_rst_n; //prevent leakage by ISO cell
assign por_resetn_atpg = atpg_en ? scan_rst_n_and : por_resetn;

common_rst_sync u_por_resetn_sync (
.CLK(hfosc_atpg),
.RSTBYPASS(atpg_en),
.RSTREQ(1'b0),
.RSTINn(por_resetn_atpg),
.RSTOUTn(por_resetn_sync));

assign por_tmout        = (por_cnt>=4'b1100); //12 * 1/256KHz = 46.875 us

// POR delay to ensure clock stable
always @(posedge hfosc_atpg or negedge por_resetn_sync) begin
    if (~por_resetn_sync)
        por_cnt <= 4'b0;
    else if (~por_tmout)
        por_cnt <= por_cnt + 1'b1;
    else
        por_cnt <= por_cnt;
end

// system por delay 1ms 
always @(posedge hfosc_atpg or negedge por_resetn_sync) begin
    if (~por_resetn_sync)
        por_tmout_resetn <= 1'b0;
    else if (por_tmout)
        por_tmout_resetn <= 1'b1;
    else
        por_tmout_resetn <= por_tmout_resetn;
end

// Global reset
assign  global_rstn = wakeup_i ? por_tmout_resetn & ext_resetn : por_tmout_resetn;
// Global reset atpg mux
wire    scan_test_en;
assign  scan_test_en = {iopad_testmode1_en_y & wakeup_i,iopad_testmode0_en_y & wakeup_i} == 2'b01;
assign  poresetn = scan_test_en ? scan_rst_n_and : global_rstn;

wire sw_por_resetn_bak;
assign sw_por_resetn_bak = wakeup_i & ext_resetn & sw_por; //reset after wake up to 0; release after sw_por to 1
assign sw_por_resetn_bak_atpg = atpg_en ? scan_rst_n_and : sw_por_resetn_bak;
//xin add for removing rec/rem
common_rst_sync u_sw_por_resetn_sync (
.CLK(hfosc_atpg),
.RSTBYPASS(atpg_en),
.RSTREQ(1'b0),
.RSTINn(sw_por_resetn_bak_atpg),
.RSTOUTn(sw_por_resetn)
);

assign sw_por_resetn_atpg = scan_test_en ? scan_rst_n_and : sw_por_resetn;

assign sw_por_tmout = (sw_por_cnt>=7'b100_1100); //76 * 1/256KHz = 296.875 us; OSC needs 250us to be stable after wakeup

always @(posedge hfosc_atpg or negedge sw_por_resetn_atpg) begin 
    if (~sw_por_resetn_atpg)
        sw_por_cnt <= 7'b0;
    else if (~sw_por_tmout)
        sw_por_cnt <= sw_por_cnt + 1'b1;
    else
        sw_por_cnt <= sw_por_cnt;
end

always @(posedge hfosc_atpg or negedge sw_por_resetn_atpg) begin
    if (~sw_por_resetn_atpg)
        sw_por_tmout_resetn <= 1'b0;
    else if (sw_por_tmout)
        sw_por_tmout_resetn <= 1'b1;
    else
        sw_por_tmout_resetn <= sw_por_tmout_resetn;
end

assign wakeup_done = scan_test_en ? 1'b1 : sw_por_tmout_resetn;
endmodule


