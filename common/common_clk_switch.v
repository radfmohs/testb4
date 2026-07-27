/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/* File Name	: common_sync_bit.v                                                     */
/* Project	: Nanochap Glucose Chip                                                     */
/* Description	: glitch free clock switch                                              */
/* Designer	: Daniel Wang                                                               */
/* Date		: 08/13/2019                                                                */
/* Revision	: R001 first draft                                                          */
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
module common_clk_switch (
input  wire     clk_a,
input  wire     clk_b,
input  wire     rst_n_a,
input  wire     rst_n_b, 
input  wire     sel_b,
input  wire     atpg_en,
output wire     clk_out
); 

// internal signals
reg sync1_en_a;
reg sync2_en_a;
reg sync1_en_b;
reg sync2_en_b;

wire en_a_async_in = ~sel_b & ~sync2_en_b;
wire en_b_async_in =  sel_b & ~sync2_en_a;

// synchronizer
always @ (posedge clk_a or negedge rst_n_a) begin
	if (~rst_n_a) begin
        sync1_en_a <= 1'b0;
        sync2_en_a <= 1'b0;
    end else begin 
        sync1_en_a <= en_a_async_in;
        sync2_en_a <= sync1_en_a;
    end
end

// synchronizer
always @ (posedge clk_b or negedge rst_n_b) begin
	if (~rst_n_b) begin
        sync1_en_b <= 1'b0;
        sync2_en_b <= 1'b0;
    end else begin 
        sync1_en_b <= en_b_async_in;
        sync2_en_b <= sync1_en_b;
    end
end

// The clock gate of clk_b must be gated in testmode
// This aviods that two test clocks (from clk_a and clk_b) rise at the same time
wire gated_en_b = sync2_en_b & ~atpg_en;

common_clock_gate DNT_CKLATCH_A (.clk(clk_a), .enable(sync2_en_a), .bypass(atpg_en), .gated_clk(gated_clk_a));
common_clock_gate DNT_CKLATCH_B (.clk(clk_b), .enable(gated_en_b), .bypass(1'b0), .gated_clk(gated_clk_b));

// clk_out
assign clk_out = gated_clk_a | gated_clk_b;

endmodule

