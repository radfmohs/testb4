//------------------------------------------------------------------------------
// Nanochap Pty Ltd (c) 2021
//
// Module Name : reset_ctrl
// Description : simple reset selection MUX 
//------------------------------------------------------------------------------
// Revision History
//------------------------------------------------------------------------------
// Revision     Date        Author
//------------------------------------------------------------------------------
// 0.1          4/11/2021  Mohsen Radfar 
// Initial Rev
//------------------------------------------------------------------------------

module reset_ctrl (
input  wire         por_resetn,                 // Power on reset, low active
input  wire         ext_resetn,                 // External reset, low active
input  wire         flash_bist_resetn,          // flash bist reset
input  wire         scan_rst_n,                 // Scan Reset
input  wire         atpg_en,                    // ATPG enable (for DFT)
input  wire         flash_bist_en,              // flash bist mode 
input  wire         hfosc_atpg,                 // hfosc base clock input
input  wire         fclk,                       // fclk after clock switch
input  wire         pclk,                       // APB clock
input  wire 	      Bioz_reset_reg,
output wire 	      Bioz_resetn,
output wire         poresetn,                   // Connect to poresetn of CORTEXM0INTEGRATION
output wire         poresetn_hf,                // hfclk poresetn
output wire         presetn,                    // Connect to presetn of CORTEXM0INTEGRATION
output wire         flash_por_resetn,           // flash por reset that will early 1ms than system por reset 
output wire         flash_bist_resetn_atpg      // flash bist reset after atpg mux
);

wire global_rstn;

reg [15:0]  por_cnt;
wire        por_tmout;
reg         por_tmout_resetn;
wire        flash_por_tmout;
reg         flash_por_tmout_resetn;

wire        por_resetn_atpg;
wire        global_rstn_atpg;

// flash_bist_reset atpg mux
assign flash_bist_resetn_atpg = atpg_en ? scan_rst_n : flash_bist_resetn;

// por reset atpg mux
assign por_resetn_atpg = atpg_en ? scan_rst_n : por_resetn;

`ifdef FAST_SIM
assign por_tmout        = (por_cnt==16'h000f);
assign flash_por_tmout  = (por_cnt==16'h000a); 
`else
assign por_tmout        = (por_cnt==16'h0100);
assign flash_por_tmout  = (por_cnt==16'h00c0);  
`endif

// POR delay to ensure clock stable
always @(posedge hfosc_atpg or negedge por_resetn_atpg) begin
    if (~por_resetn_atpg)
        por_cnt <= 16'b0;
    else if (~por_tmout)
        por_cnt <= por_cnt + 1'b1;
    else
        por_cnt <= por_cnt;
end

// system por delay 1ms 
always @(posedge hfosc_atpg or negedge por_resetn_atpg) begin
    if (~por_resetn_atpg)
        por_tmout_resetn <= 1'b0;
    else if (por_tmout)
        por_tmout_resetn <= 1'b1;
    else
        por_tmout_resetn <= por_tmout_resetn;
end

// flash por delay 14ms, as flash can work after flash por 10us 
always @(posedge hfosc_atpg or negedge por_resetn_atpg) begin
    if (~por_resetn_atpg)
        flash_por_tmout_resetn <= 1'b0;
    else if (flash_por_tmout)
        flash_por_tmout_resetn <= 1'b1;
    else
        flash_por_tmout_resetn <= flash_por_tmout_resetn;
end

assign flash_por_resetn = (flash_bist_en | atpg_en) ? por_resetn_atpg : flash_por_tmout_resetn;

// Global reset
assign global_rstn = por_tmout_resetn & ext_resetn;
// Global reset atpg mux
//assign global_rstn_atpg = atpg_en ? scan_rst_n : global_rstn;
MX2X4M DNT_MX2 (.A(global_rstn), .B(scan_rst_n), .S0(atpg_en), .Y(global_rstn_atpg));

wire Bioz_reset_reg_bak;
assign Bioz_reset_reg_bak = (!Bioz_reset_reg) & global_rstn_atpg;
MX2X4M DNT_MX2_BIOZ (.A(Bioz_reset_reg_bak), .B(scan_rst_n), .S0(atpg_en), .Y(Bioz_resetn));
// --------------------
// Reset synchronisers
// --------------------
common_rst_sync u_poresetn_hf_sync(
.RSTINn    (global_rstn_atpg),
.RSTREQ    (1'b0),
.CLK       (hfosc_atpg),
.SE        (atpg_en),
.RSTBYPASS (atpg_en),
.RSTOUTn   (poresetn_hf)
);

// fclk domain poresetn sync  
common_rst_sync u_poresetn_sync(
.RSTINn    (global_rstn_atpg),
.RSTREQ    (1'b0),
.CLK       (fclk),
.SE        (atpg_en),
.RSTBYPASS (atpg_en),
.RSTOUTn   (poresetn)
);

// pclk domain poresetn sync  
common_rst_sync u_presetn_sync(
.RSTINn    (global_rstn_atpg),
.RSTREQ    (1'b0),
.CLK       (pclk),
.SE        (atpg_en),
.RSTBYPASS (atpg_en),
.RSTOUTn   (presetn)
);

endmodule


