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

module iq_filter(
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

output wire      chdata_en_n,
output wire   [19:0]   chdata,

output wire       iq_int,        // interrupt 
output wire       iq_int_sts,        // interrupt 
//with analog
input  wire       iq_adc_din    // adc serial data input


);


  wire [1:0]   iq_input_format;
wire            int_set;
wire      chmod;

wire iq_int_temp;
wire iq_int_pre;
assign iq_int_pre = iq_int_temp;

wire iq_int_sts_temp;
common_pulse_rising u_iq_int_r(
.d_in(iq_int_pre),
.clk(pclk),
.rst_(presetn),
.d_out(iq_int_sts_temp)

);

assign iq_int = (iq_int_pre & !int_length_slct) | (iq_int_sts_temp & int_length_slct);



wire            sd16rst;
wire   [5:0]    rst_val;
wire            cic_rst;
wire            sd16eoc_sync;
wire            cic_rst_n;
wire   [19:0]   sd16cic_data;
wire            sd16eoc;


iq_reg u_iq_reg(
.pclk(pclk),
.atpg_en(atpg_en),

.reg_ctrl(reg_ctrl),
.int_clr(int_clr),
.preset_n(presetn),


.int_sts(iq_int_sts),
.iq_int(iq_int_temp),
.int_set(int_set),

.iq_input_format(iq_input_format),
.cic_rate(cic_rate),
.chmod(chmod),
.format_sel(format_sel),

.sd16rst(sd16rst),
.rst_val(rst_val)
);


iq_cdc u_iq_cdc(
.pclk(pclk),
.adc_clk(adc_clk),
.preset_n(presetn),
.atpg_en(atpg_en),


.sd16eoc(sd16eoc),
.cic_rst(cic_rst),
.sd16eoc_sync(sd16eoc_sync),
.cic_rst_n(cic_rst_n)
);

iq_ctrl u_iq_ctrl(


.adc_clk(adc_clk),
.cic_rst_n(cic_rst_n),
.pclk(pclk),
.preset_n(presetn),
.sd16eoc_sync(sd16eoc_sync),
.sd16cic_data(sd16cic_data),
.sd16rst(sd16rst),
.chmod(chmod),
.rst_val(rst_val),
.ch0data(chdata),
.ch0data_en_n(chdata_en_n),
.cic_rst(cic_rst),
.format_sel(format_sel),
.int_set(int_set)
);



iq_cic u_iq_cic(
.clk(adc_clk),
.resetn(cic_rst_n),
.iq_input_format(iq_input_format),
.cic_rate(cic_rate),
.format_sel(format_sel),
.filter_in(iq_adc_din),
.filter_out(sd16cic_data),
.eoc_out(sd16eoc)
);

endmodule

