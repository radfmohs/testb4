//  ====================================================================
//
//  Copyright (c) 2015-2016 HHGrace Semiconductor Manufacturing Corporation.
//  All Rights Reserved.
//  Forwarding or copying of this document, in any medium, in whole or
//  in part, or disclosure of its contents, to other than an authorized
//  recipient, is strictly prohibited.
//
//  ====================================================================
//
// File Name   : BIS_FPFLE032K09DA.v   
// version     : 0.0
// date        : Jan 28,2015
// description : top module for the eFlash self test  
// support     : 8621-51818888 ext. 83344
// Revision    :  0.0    priliminary verion
//  ===================================================================


//**********************************************************************
//  PORTS
//                 TDO     : Serial test data output
//                 DO      : Normal mode output,width is 8
//                 PDI     : Normal mode input,width is 40
//                 TDI     : Serial test data input
//                 TESTEN  : Serial test enable
//                 TCK     : TCK
//                 PORb    : Power on reset for the Flash
//                 TM0VPP  : High voltage Access, anlog test port
//                 OEN     : Output enable pin which will be instantiate with bidirectional pad output control pin   
//                 VREF    : Voltage reference for flash IP  
//
//**********************************************************************

//  ====================================================================
//  Notes        
//  
// 1. synthsis using Design compiler, STA using PrimeTime
//    
// 2. Functional verified with VCS. 
//    
// 3. For the details of this module's application,an attached datasheet  
//    can be referred to.
//    
//  ====================================================================

//`include "./constants_BIS_FPFLE032K09DA.v"

`timescale 1ns/10ps

  module BIS_FPFLE032K09DA (  
   // --------------------------------------------------------------------------
 // Port Definitions
 // --------------------------------------------------------------------------
 //JTAG Related Pins
  flash_bist.master     flash_bist,
 input wire 	       TCK, 
 input wire	       RESETb, 
 input wire	       TDI, 
 input wire	       TESTEN, 
 
 output wire	       TDO, 
 output wire	       OEN


  );
           

 // --------------------------------------------------------------------------
 // Parameters for Selectors
 // --------------------------------------------------------------------------
//    localparam  NONESEL = 2'b00;
//    localparam  FLASH1SEL = 2'b01;
//    localparam  FLASH2SEL = 2'b10;
//    localparam  BOTHSEL = 2'b11;

 // --------------------------------------------------------------------------
 // Internal Wires
 // --------------------------------------------------------------------------
//    wire   [1:0]  BIST_FLASH_BYTE;
    // Assign all zeroes as this functional input is not used
    // This is an internal func/BIST path embedded in the BIST
    wire [39:0] PDI;
    assign PDI = {{37{1'b0}},3'b111};	
   
    // Dangling Port for DO -- not used
    wire [7:0] DO;

    // Always combi case output to BIST 
    // Parallel to Serial Input
    reg [7:0] IP2ST;

    // Serial to Parallel BIST OUTPUT to FLASH
    wire [39:0] ST2IP;
    
    wire  STROBE;
    wire  BUSY;
    wire  TDI_en;
    wire  TDI_valid;
 // --------------------------------------------------------------------------
 // Generate Logic for BIST FLASHSEL1/2
 // Generate Logic for Rdata selection into IP2ST
 // --------------------------------------------------------------------------

 always @ (*)

   begin 
     case (TESTEN) 	// TESTEN on 
      1'b1 :
        begin
                IP2ST          = flash_bist.BIST_FLASH_RDATA;

/*		
          case (BIST_TESTMODE)
            NONESEL :			// Both Userpath ; IP2ST all 0s
              begin
                BIST_FLASHSEL1 = 1'b0;
                BIST_FLASHSEL2 = 1'b0;
                IP2ST          = {8{1'b0}};
              end

            FLASH1SEL :
              begin		       // Drive BIST signals to FLASH1; IP2ST from FLASH1
                BIST_FLASHSEL1 = 1'b1;
                BIST_FLASHSEL2 = 1'b0;
                IP2ST          = BIST_FLASH_RDATA1;
              end
  
            FLASH2SEL :		      // Drive BIST signals to FLASH2; IP2ST from FLASH2
              begin
                BIST_FLASHSEL1 = 1'b0;
                BIST_FLASHSEL2 = 1'b1;
                IP2ST          = BIST_FLASH_RDATA2;
              end
    
            BOTHSEL :		     // Drive BIST Signals to FLASH1 and 2; IP2ST all 0's
              begin
                BIST_FLASHSEL1 = 1'b1;
                BIST_FLASHSEL2 = 1'b1;
                IP2ST          = {8{1'b0}};
              end

            default :
              begin
                BIST_FLASHSEL1 = 1'bx;
                BIST_FLASHSEL2 = 1'bx;
                IP2ST          = {8{1'bx}};
              end
          endcase
*/	
        end

      1'b0 :		// TESTEN off --- user path
        begin 
          IP2ST          = {8{1'b0}};
        end

      default :
        begin
          IP2ST          = {8{1'b0}};
        end
      endcase

   end

 // --------------------------------------------------------------------------
 // OUTPUT TO FLASH
 // Assign Parallel Outputs to respective BIST Output Ports
 // Bit loccations derived from constant file
 // --------------------------------------------------------------------------

  assign flash_bist.BIST_FLASH_ADDR   =  ST2IP[`S_A];
  assign flash_bist.BIST_FLASH_WDATA  =  ST2IP[`S_DIN];
  assign flash_bist.BIST_FLASH_RDN    =  ST2IP[`S_RDN];
  assign flash_bist.BIST_FLASH_NVR    =  ST2IP[`S_NVR];
  assign flash_bist.BIST_FLASH_CEb    =  ST2IP[`S_CEB];
  assign flash_bist.BIST_FLASH_WEb    =  ST2IP[`S_WEB];
  assign flash_bist.BIST_FLASH_PROG   =  ST2IP[`S_PROG];
  assign flash_bist.BIST_FLASH_PROG2  =  ST2IP[`S_PROG2];
  assign flash_bist.BIST_FLASH_ERASE  =  ST2IP[`S_ERASE];
  assign flash_bist.BIST_FLASH_BLOCK  =  ST2IP[`S_BLOCK];
  assign flash_bist.BIST_FLASH_CHIP   =  ST2IP[`S_CHIP];
  assign flash_bist.BIST_FLASH_OEb    =  ST2IP[`S_OEB];
  assign flash_bist.BIST_FLASH_CONFEN =  ST2IP[`S_CONFEN];
  assign flash_bist.BIST_FLASH_TMEN   =  ST2IP[`S_TMEN];
  assign flash_bist.BIST_FLASH_VREAD1 =  ST2IP[`S_VREAD1];
  assign flash_bist.BIST_FLASH_VREAD0 =  ST2IP[`S_VREAD0];
  assign flash_bist.BIST_FLASH_VMON1  =  ST2IP[`S_VMON1];
  assign flash_bist.BIST_FLASH_VMON2  =  ST2IP[`S_VMON2];
  assign flash_bist.BIST_FLASH_DPSTB  =  ST2IP[`S_DEEPPD];

  assign flash_bist.RESETb             = RESETb;  

 // --------------------------------------------------------------------------
 // Instantiate HHG BIST Data Generator
 // --------------------------------------------------------------------------

  data_generator u_data_generator(
    .TCK(TCK),
    .RESETb(RESETb),
    .TDI(TDI),
    .STROBE(STROBE),
    .TESTEN(TESTEN),
    .PDI(PDI),
    .IP2ST(IP2ST),
    .DO(DO),
    .TDO(TDO),
    .ST2IP(ST2IP),
    .OEN(OEN),
    .BUSY(BUSY),
//    .RESETb_flash(RESETb_flash),
    .TDI_valid(TDI_valid),
    .TDI_en(TDI_en) 
  );
 
  command_detector u_command_detector(
       .TDI(TDI),
       .TCK(TCK),
       .RESETb(RESETb),
       .STROBE(STROBE),
       .BUSY(BUSY),
       .TDI_valid(TDI_valid),
       .TDI_en(TDI_en),
       .OEN(OEN)
       ); 
                       
endmodule

