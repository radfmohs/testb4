/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/* File Name	: cmsdk_apb_iq.v                                                     */
/* Project	: Nanochap Glucose Chip                                                     */
/* Description	: Glucose measument digital part                                        */
/* Designer	: Daniel Wang                                                               */
/* Date		: 05/21/2019                                                                */
/* Revision	: R001 first draft                                                          */
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/

module iq_filter_wrapper(
//clock and reset

input wire        pclk,             // pclk
input wire        adc_clk,          // adc working clock, divider of 256khz
input wire        presetn,          // reset
input wire        atpg_en,          // atpg enable
input wire        scan_en,          // Tri add
output wire   [3:0]    cic_rate,

 input wire	   int_clr,
 input wire	   int_length_slct,
 input wire [15:0]  reg_ctrl,

output wire      chdata_en_n_I,
output wire   [19:0]   chdata_I,
output wire      chdata_en_n_Q,
output wire   [19:0]   chdata_Q,

output wire       iq_int_I,        // interrupt 
output wire       iq_int_sts_I,        // interrupt 
output wire       iq_int_Q,        // interrupt 
output wire       iq_int_sts_Q,        // interrupt 
//with analog
input  wire       iq_adc_din_I,    // adc serial data input
input  wire       iq_adc_din_Q    // adc serial data input


);



iq_filter u_iq_filter_I(
     .pclk(pclk),             // pclk
     .adc_clk(adc_clk),          // adc working clock(), divider of 256khz
     .presetn(presetn),          // reset
     .atpg_en(atpg_en),          // atpg enable
     .scan_en(scan_en),          // Tri add
     .cic_rate(cic_rate),

      .int_clr(int_clr),
      .int_length_slct(int_length_slct),
    .reg_ctrl(reg_ctrl),

    .chdata_en_n(chdata_en_n_I),
    .chdata(chdata_I),

     .iq_int(iq_int_I),        // interrupt 
     .iq_int_sts(iq_int_sts_I),        // interrupt 

     .iq_adc_din(iq_adc_din_I)    // adc serial data input

);

iq_filter u_iq_filter_Q(
     .pclk(pclk),             // pclk
     .adc_clk(adc_clk),          // adc working clock(), divider of 256khz
     .presetn(presetn),          // reset
     .atpg_en(atpg_en),          // atpg enable
     .scan_en(scan_en),          // Tri add
     .cic_rate(cic_rate),

      .int_clr(int_clr),
      .int_length_slct(int_length_slct),
    .reg_ctrl(reg_ctrl),

    .chdata_en_n(chdata_en_n_Q),
    .chdata(chdata_Q),

     .iq_int(iq_int_Q),        // interrupt 
     .iq_int_sts(iq_int_sts_Q),        // interrupt 

     .iq_adc_din(iq_adc_din_Q)    // adc serial data input
);

endmodule

