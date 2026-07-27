//============================================================================== 
// ----------------------------------------------------------------------------- 
//  Nanochap Electronics Copyright (C) 2014. ALL RIGHTS RESERVED. 
// ----------------------------------------------------------------------------- 
// Module name     : outdrv_reg.v
// Description     : Registered Output Drivers with selectable reset value
// ----------------------------------------------------------------------------- 
// Revision History: 
// ----------------------------------------------------------------------------- 
// Revision       Date(xxxx-xx-xx)     Author             Description 
// ----------------------------------------------------------------------------- 
//   1.0          2019-07-07           eugeenc            Initial version 
//   1.1          2024-11-19           Daniel Dang        Changed format 
// ----------------------------------------------------------------------------- 
//==============================================================================

module outdrv_reg #(
parameter INITVAL = 1'b0
)(
  input wire clk,
  input wire resetn,
//  input wire initval, //tie outside instantiation to set reset value
  
  input wire drvh,
  input wire drvl,
  
  output reg outreg
);

  //-----------------------------------------------------------------
  // Register
  //-----------------------------------------------------------------

   always @ (posedge clk or negedge resetn)
     begin
       if (~resetn)
         begin
           outreg <= INITVAL;
         end
       else if (drvh)
         begin
           outreg <= 1'b1;
         end
       else if (drvl)
         begin
           outreg <= 1'b0;
         end
       else 
         begin
           outreg <= outreg;
         end
     end
   
endmodule
