/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/* File Name	: common_clock_gate.v                                                   */
/* Project	: Nanochap Glucose Chip                                                     */
/* Description	: clock gate cells                                                      */
/* Designer	: Daniel Wang                                                               */
/* Date		: 05/17/2019                                                                */
/* Revision	: R001 first draft                                                          */
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
module ppg_common_clock_gate    #(
parameter CLKGATE_PRESENT = 1)
(
input  wire clk,
input  wire enable,
input  wire bypass,
output wire gated_clk 
);

wire i_gated_clk;

assign gated_clk = (CLKGATE_PRESENT==1) ? i_gated_clk : clk;

`ifdef SYNTHESIS
TLATNTSCAX8M DNT_ICG_CELL (
.CK   (clk),
.E    (enable),
.SE   (bypass),
.ECK  (i_gated_clk)
);
`else
reg    CLKEN;
always @ (enable or bypass or clk) begin
    if (~clk)
        CLKEN = enable | bypass;
end
assign i_gated_clk = CLKEN & clk;
`endif
endmodule

