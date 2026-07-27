`timescale 1ns / 1ps
`include "zmeas_parameters.vh"
//==============================================================================
// Nanochap Pty Ltd (c) 2019
// 
// Module Name : DDS_PHACC
// Description : Phase Accumulator for DDS 
//
//==============================================================================
// Revision History
//==============================================================================
// Revision	Date/Time			Author	
//==============================================================================
// 0.0		Mon Apr 15 13:18:43 AEST 2019	eugeenc	
// Initial Rev
//
// 0.1		Wed May  1 12:30:00 AEST 2019	eugeenc	
// Updated freq_phjmp logic, added ce generation logic
//
// 0.2		Tue May 14 17:30:00 AEST 2019	eugeenc	
// Added in clock dividers to clock DDS at 2Mhz
// Added in CE generator
//
// 0.3		Fri May 17 10:58:00 AEST 2019	eugeenc	
// Feed 4M clock as pclk; updated clock dividers
// Simplified CE generator
//
// 0.4         Aug 19: clk2m_atpg RS
// 0.5         Sep 17 generated CLK4M_invert for dds_ce  RS

// 0.6		Tue  17 10:58:00 AEST 2019	eugeenc	
// Changed CLK2M to wire; added CLK2M_pre as reg
// Manually divide down CLK4M into CLK2M_pre; then use DFFRQX4M to resample
// CLK2M_pre to produce CLK2M (wire) to drive existing logic
//==============================================================================

module dds_phacc 
 (
  input  wire			mclk,	
  input  wire 			presetn,	//APB reset
  input  wire 			dds_en,		//Enable from top
  input  wire [`PHJMP_BITS-1:0]	freq_phjmp,	//Phase jump count

  //output to SINE ROM
  output reg  [`DDS_PHACC_BITS-1:0] 	dds_phase_add	//Output phase bits to ROM
);

// FSM States  
localparam  STATE_START = 1'b0;
localparam  STATE_COUNT = 1'b1;

//------------------------------------------------------------------------------
//  internal signals
//------------------------------------------------------------------------------

 reg	[`PHJMP_BITS-1:0]	freq_phjmp_reg;
 reg				dds_state;

 //------------------------------------------------------------------------------
// module logic start
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// State machine for Address Generation
//------------------------------------------------------------------------------

// Register Phacc jump value
 always @(posedge mclk or negedge presetn)
   begin
     if (~presetn)
       begin
         freq_phjmp_reg 	<= {`PHJMP_BITS{1'b0}};
	 dds_phase_add 		<= {`DDS_PHACC_BITS{1'b0}};
	 dds_state	 	<= STATE_START;
       end

     else
       begin
         if (dds_state == STATE_START) 	
           begin
             if (dds_en)	
               begin
                 freq_phjmp_reg <= freq_phjmp;
                 dds_state      <= STATE_COUNT;
               end
             else
               begin
                 dds_state     <= STATE_START;
                 dds_phase_add <= {`DDS_PHACC_BITS{1'b0}};
               end
           end
          
         else if (dds_state == STATE_COUNT)
           begin
             if (dds_en)
               begin
                 dds_phase_add <= dds_phase_add + freq_phjmp_reg;
                 dds_state     <= STATE_COUNT;
               end
             else
               begin
                 dds_phase_add <= {`DDS_PHACC_BITS{1'b0}};
                 dds_state     <= STATE_START;
               end
           end
       end   
   end


//------------------------------------------------------------------------------
// Generate CE for ROM interfacing
// Phase shift 2M clock by 90 degress as CE
// This provides a CE_B window of 250ns for the ROM operation to complete
// EG - I'm not sure how STA handles this
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// module logic end
//------------------------------------------------------------------------------
 
endmodule
