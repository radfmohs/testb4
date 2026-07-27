//============================================================================== 
// ----------------------------------------------------------------------------- 
//  Nanochap Electronics Copyright (C) 2014. ALL RIGHTS RESERVED. 
// ----------------------------------------------------------------------------- 
// Module name     : flash_clkcnt.v
// Description     : BMS6P1 Flash Clock Counter
// ----------------------------------------------------------------------------- 
// Revision History: 
// ----------------------------------------------------------------------------- 
// Revision       Date(xxxx-xx-xx)     Author             Description 
// ----------------------------------------------------------------------------- 
//   1.0          2024-10-22           Zhen Cao           Initial version 
//   1.1          2024-11-19           Daniel Dang        Changed format 
// ----------------------------------------------------------------------------- 
//==============================================================================

module flash_clkcnt #(
// --------------------------------------------------------------------------
// Parameters
// --------------------------------------------------------------------------
  parameter TIMER_BITS = 20)(		// Count parameter widths
  // PROGRAM Clock Counts
  input  wire            ext_clk_sel,

  output reg  [TIMER_BITS-1:0]	PROGRAM_Tnvs,
  output reg  [TIMER_BITS-1:0]	PROGRAM_Tpgs,
  output reg  [TIMER_BITS-1:0]	PROGRAM_Tpgh,
  output reg  [TIMER_BITS-1:0]	PROGRAM_Tprog,
  output reg  [TIMER_BITS-1:0]	PROGRAM_Tads,
  output reg  [TIMER_BITS-1:0]	PROGRAM_Tadh,
  output reg  [TIMER_BITS-1:0]	PROGRAM_Trcv,

  // ERASE Sector/Chip  Clock Counts
  output reg  [TIMER_BITS-1:0] ERASE_Tnvs,
  output reg  [TIMER_BITS-1:0] ERASE_SECTOR_Terase,
  output reg  [TIMER_BITS-1:0] ERASE_CHIP_Terase,
  output reg  [TIMER_BITS-1:0] ERASE_Trcv
 
  );


assign  PROGRAM_Tnvs		=	20'd7;	
assign  PROGRAM_Tpgs		=	20'd3;
assign  PROGRAM_Tpgh		=	20'd2;
assign  PROGRAM_Tprog		=	20'd7;
assign  PROGRAM_Tads		=	20'd2;
assign  PROGRAM_Tadh		=	20'd2;
assign  PROGRAM_Trcv		=	20'd6;


assign  ERASE_Tnvs	        =	ext_clk_sel? 20'd7      : 20'd3;
assign  ERASE_SECTOR_Terase	=       ext_clk_sel? 20'd4500   : 20'd1154;
assign  ERASE_CHIP_Terase	=       ext_clk_sel? 20'd35000  : 20'd8975;
assign  ERASE_Trcv		=	ext_clk_sel? 20'd55     : 20'd20;

endmodule
