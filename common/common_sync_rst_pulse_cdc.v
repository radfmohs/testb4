//============================================================================== 
// ----------------------------------------------------------------------------- 
//  Nanochap Electronics Copyright (C) 2014. ALL RIGHTS RESERVED. 
// ----------------------------------------------------------------------------- 
// Filename        : common_sync_rst_pulse_cdc.v
// Description     : convert pulse between two clock domains with sync reset
// ----------------------------------------------------------------------------- 
// Revision History: 
// ----------------------------------------------------------------------------- 
// Revision       Date(xxxx-xx-xx)     Author             Description 
// ----------------------------------------------------------------------------- 
//   1.0          2024-12-16           Zhen Cao           First Release 
// ----------------------------------------------------------------------------- 
//==============================================================================

module common_sync_rst_pulse_cdc(
input wire  aclk,       //source clock
input wire  bclk,       //destination clock
input wire  arst_,      //source reset
input wire  brst_,      //destination reset
//input wire  atpg_en,  //Reset by pass
input wire  a_pulse,    //source pulse
output wire b_pulse     //destination pulse after cdc
); 

reg apulse_start, bpulse_pre, bpulse_start, bpulse_done, acyc_done_pre, acyc_done,acyc_done_post;
wire receive_bpulse;

always @ (posedge aclk or negedge arst_) begin
	if(~arst_)
		apulse_start	<= 1'b0;
	else if(a_pulse)
		apulse_start	<= 1'b1;
	else if(receive_bpulse)
		apulse_start	<= 1'b0;		
end

always @ (posedge bclk or negedge brst_) begin
	if(~brst_) begin
		bpulse_pre	<= 1'b0;
		bpulse_start	<= 1'b0;
		bpulse_done	<= 1'b0;
	end else begin
		bpulse_pre 	<= apulse_start;
		bpulse_start	<= bpulse_pre;
		bpulse_done	<= bpulse_start;
	end
end

assign b_pulse = bpulse_start & ~bpulse_done;

always @ (posedge aclk or negedge arst_) begin
	if(~arst_) begin
		acyc_done_pre	<= 1'b0;
		acyc_done	<= 1'b0;
		acyc_done_post	<= 1'b0;		
	end else begin
		acyc_done_pre	<= bpulse_start;
		acyc_done	<= acyc_done_pre;
		acyc_done_post	<= acyc_done;
	end
end

assign receive_bpulse = acyc_done & ~acyc_done_post;

endmodule
