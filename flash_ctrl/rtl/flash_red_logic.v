//============================================================================== 
// ----------------------------------------------------------------------------- 
//  Nanochap Electronics Copyright (C) 2014. ALL RIGHTS RESERVED. 
// ----------------------------------------------------------------------------- 
// Module name     : flash_red_logic.v
// Description     : use redundancy sector to repair the bad sector of main array
// ----------------------------------------------------------------------------- 
// Revision History: 
// ----------------------------------------------------------------------------- 
// Revision       Date(xxxx-xx-xx)     Author             Description 
// ----------------------------------------------------------------------------- 
//   1.0          2024-10-22           Zhen Cao           Initial version 
//   1.1          2024-11-19           Daniel Dang        Changed format 
// ----------------------------------------------------------------------------- 
//==============================================================================

module flash_red_logic (
 // --------------------------------------------------------------------------
 // Port Definitions
 // --------------------------------------------------------------------------
 input  wire   [5:0]  ADDR_SECTOR_IN,             //Sector Address  
 input  wire  [7:0]  NVR_BADSECTOR_WORD0,  	  //NVR RED address 0
// input  wire  [7:0]  NVR_BADSECTOR_WORD1,  	  //NVR RED address 1
// input  wire  [7:0]  NVR_BADSECTOR_WORD2,  	  //NVR RED address 2
// input  wire  [7:0]  NVR_BADSECTOR_WORD3,  	  //NVR RED address 3
// input  wire  [7:0]  NVR_BADSECTOR_WORD4,  	  //NVR RED address 4
// input  wire  [7:0]  NVR_BADSECTOR_WORD5,  	  //NVR RED address 5
// input  wire  [7:0]  NVR_BADSECTOR_WORD6,  	  //NVR RED address 6
// input  wire  [7:0]  NVR_BADSECTOR_WORD7,  	  //NVR RED address 7
 
 input  wire          NVR_SELECT_IN,  	          //Input from NVR Select

 output wire   [5:0]  ADDR_SECTOR_OUT,
 output wire          RED_ENABLE_OUT

);

 // Indicates which bad sector was matched
// wire  [5:0] sector_match;
 wire sector_match;

 // Qualifies the replacement address 
 wire  [5:0] qual_repaired_red_sector0;
// wire  [6:0] qual_repaired_red_sector1;
// wire  [6:0] qual_repaired_red_sector2;
// wire  [6:0] qual_repaired_red_sector3;
// wire  [6:0] qual_repaired_red_sector4;
// wire  [6:0] qual_repaired_red_sector5;
// wire  [6:0] qual_repaired_red_sector6;
// wire  [6:0] qual_repaired_red_sector7;
 
 // Final replaced address
 wire  [5:0] sector_addr_replaced;
 
 // --------------------------------------------------------------------------
 // Redundancy Sector Addresses
 // Match 0 takes Sector 0 and so on
 // --------------------------------------------------------------------------
//  localparam REPAIRED_ADDR_RED_SECTOR0             = {3{1'b0}};
//  localparam REPAIRED_ADDR_RED_SECTOR1             = {3{1'b0}};
//  localparam REPAIRED_ADDR_RED_SECTOR2             = {3{1'b0}};
//  localparam REPAIRED_ADDR_RED_SECTOR3             = {3{1'b0}};
//  localparam REPAIRED_ADDR_RED_SECTOR4             = {3{1'b0}};
//  localparam REPAIRED_ADDR_RED_SECTOR5             = {3{1'b0}};
//  localparam REPAIRED_ADDR_RED_SECTOR6             = {3{1'b0}};
//  localparam REPAIRED_ADDR_RED_SECTOR7             = {3{1'b0}};

 // --------------------------------------------------------------------------
 // Match status generation
 // --------------------------------------------------------------------------
assign sector_match = ((ADDR_SECTOR_IN==NVR_BADSECTOR_WORD0[5:0])&(~NVR_BADSECTOR_WORD0[7]));
 /*
 assign sector_match[7:0] = {
                            ((ADDR_SECTOR_IN==NVR_BADSECTOR_WORD7[6:0])&(~NVR_BADSECTOR_WORD7[7])),
                            ((ADDR_SECTOR_IN==NVR_BADSECTOR_WORD6[6:0])&(~NVR_BADSECTOR_WORD6[7])),
                            ((ADDR_SECTOR_IN==NVR_BADSECTOR_WORD5[6:0])&(~NVR_BADSECTOR_WORD5[7])),
                            ((ADDR_SECTOR_IN==NVR_BADSECTOR_WORD4[6:0])&(~NVR_BADSECTOR_WORD4[7])),
                            ((ADDR_SECTOR_IN==NVR_BADSECTOR_WORD3[6:0])&(~NVR_BADSECTOR_WORD3[7])),
                            ((ADDR_SECTOR_IN==NVR_BADSECTOR_WORD2[6:0])&(~NVR_BADSECTOR_WORD2[7])),
                            ((ADDR_SECTOR_IN==NVR_BADSECTOR_WORD1[6:0])&(~NVR_BADSECTOR_WORD1[7])),
                            ((ADDR_SECTOR_IN==NVR_BADSECTOR_WORD0[6:0])&(~NVR_BADSECTOR_WORD0[7]))
                             };
*/
 // --------------------------------------------------------------------------
 // ADDR qualifying and ORing
 // --------------------------------------------------------------------------
 assign qual_repaired_red_sector0 = {6{sector_match}};

// assign qual_repaired_red_sector0 = {REPAIRED_ADDR_RED_SECTOR0,4'h0} & {7{sector_match[0]}};
// assign qual_repaired_red_sector1 = {REPAIRED_ADDR_RED_SECTOR1,4'h1} & {7{sector_match[1]}};
// assign qual_repaired_red_sector2 = {REPAIRED_ADDR_RED_SECTOR2,4'h2} & {7{sector_match[2]}};
// assign qual_repaired_red_sector3 = {REPAIRED_ADDR_RED_SECTOR3,4'h3} & {7{sector_match[3]}};
// assign qual_repaired_red_sector4 = {REPAIRED_ADDR_RED_SECTOR4,4'h4} & {7{sector_match[4]}};
// assign qual_repaired_red_sector5 = {REPAIRED_ADDR_RED_SECTOR5,4'h5} & {7{sector_match[5]}};
// assign qual_repaired_red_sector6 = {REPAIRED_ADDR_RED_SECTOR6,4'h6} & {7{sector_match[6]}};
// assign qual_repaired_red_sector7 = {REPAIRED_ADDR_RED_SECTOR7,4'h7} & {7{sector_match[7]}};

 // Only one will match; the reset will be zero
 assign sector_addr_replaced = qual_repaired_red_sector0 /*|
                               qual_repaired_red_sector1 |
                               qual_repaired_red_sector2 |
                               qual_repaired_red_sector3 |
                               qual_repaired_red_sector4 |
                               qual_repaired_red_sector5 |
                               qual_repaired_red_sector6 |
                               qual_repaired_red_sector7*/ ;
 
 // --------------------------------------------------------------------------
 // Final mux replacement
 // --------------------------------------------------------------------------

 // If no match take the initial address other wise take the replaced address
 // Bypass replacement if NVR is being accessed -- 
 // do no activate RED if NVR is selected
 
 assign RED_ENABLE_OUT  = (~NVR_SELECT_IN) & sector_match;	//Reduction OR
 assign ADDR_SECTOR_OUT = (RED_ENABLE_OUT) ? sector_addr_replaced : ADDR_SECTOR_IN;
 

endmodule
