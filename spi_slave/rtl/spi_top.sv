//------------------------------------------------------------------------------
// Nanochap Pty Ltd (c) 2021
//
// Module Name : spi_top
// Description : top module which has  spi slave  controller and register block 
//------------------------------------------------------------------------------
// Revision History
//------------------------------------------------------------------------------
// Revision     Date        Author
//------------------------------------------------------------------------------
// 0.1          7/09/2022  Jayanthi 
// Initial Rev
//------------------------------------------------------------------------------

`timescale 1ns/1ps

module spi_top#(
parameter ADDR_WIDTH = 8,
parameter DATA_WIDTH = 8,
parameter NO_TRIM_REGS = 21
)(
       spi2flash.master         spi2flash,
       spi2imeas.master         spi2imeas,

	
	input		SCANMODE,
	input    	i_scanclk,
	input         i_rst_n,
	input         i_sclk,
	input         i_cs_n,
	input         i_mosi,
	output        o_miso,
       	output wire   meas_sync_en,
        output wire   config_zmeas_ctrl_reg,
	output wire   zmeas_en,
        output wire   zmeas_phase_dither_en,
	output wire [1:0]   data_type_sel,    //00 is sinwave, 01: DC, others: sinwave
	output wire [9:0]   dc_data,    
	output wire [9:0]   dc_data_c,    

output  wire [31:0]   phase_inc,
output  wire [31:0]   phase_offset,
output  wire [31:0]   phase_offset_c,
output  wire Bioz_en,
output  wire Bioz_reset_reg,
output  wire [15:0] iq_reg_ctrl,
output  wire [3:0]  iq_iclk_div, 
output  wire        iq_adc_clk_inv,

/*
	output wire [9:0]   square_data_l,    
	output wire [9:0]   square_data_h,    
*/
	//output wire [15:0]  square_clk_div,

	output wire        zmeas_int_clr,
	output wire        zmeas_adc_int_clr,
	output wire[31:0]  zmeas_reg_ctrl,
	input  wire[15:0]  zmeas_reg_status,
	input  wire[31:0]  zmeas_reg_dataout,

	input wire [9:0] zmeas_xn_data,
	input wire [9:0] zmeas_sine_for_dft,
	input wire [9:0] zmeas_cosine_for_dft,
	input wire[28:0] zmeas_summation_offset_forreal,
	input wire[28:0] zmeas_summation_real,
	input wire[28:0] zmeas_summation_imag,
	input wire[16:0] zmeas_shiftedreal_inter,
	input wire[11:0] zmeas_dft_cnt,
	input wire       reg_zmeas_int,
	input wire       reg_zmeas_adc_int,

	output  wire         SDM_CLK_GPIO_pha_sel,
	output  wire  [1:0]  acleadoff_clk_sel,
	output  wire  [1:0]  rld_clk_reg,
	output  wire         fclk_dynen,
	output  wire  [1:0]  pclk_div,
	output  wire  [2:0]  iclk_div,
	output  wire  [7:0]  mclk_div,
	output  wire  [15:0]  checking_clk_div,
        output  wire         imeas_adc_inv,

  //gpio
       //gpio
       output wire [2:0] gpio_pu_ctrl,
       output wire       gpio_pu_resetn,
       output wire [1:0] gpio_pd_testmode,

    //input from alwasy on
    //    input          i_fclk_dynen_always_on,   //input From always on block for always_on_clk_ctrl_debug_register
    //    input          i_dc_dc_en_always_on,     //input From always on block for always_on_clk_ctrl_debug_register
    //    input  [2:0]   i_dc_clk_div_always_on,   //input From always on block for always_on_clk_ctrl_debug_register
      
    //output to always on    
     //   output         fclk_dynen_flash,
     //   output         dc_dc_en_flash,
     //    output [2:0]   dc_clk_div_flash, 
        output         o_always_on_spi_write,

    	output  wire   pmuenable,            // pmu enable
	output  wire   hresetreq,            // system reset request
	output  wire   sleepdeep,            // system enters deep-sleep state
	output  wire   flash_dpstb_en,        // flash deep power down standby mode enable 
	output  wire   o_fifo_disable,         
    //    output  wire   fclk_sleep_en,
    
      //fifo 
       input wire  [6:0] i_fifo_rd_ptr,
       input wire  [6:0] i_fifo_wr_ptr,
       input wire        i_fifo_a_empty,
       input wire        i_fifo_empty,
       input wire        i_fifo_a_full,
       input wire        i_fifo_full,
       input wire        i_fifo_error,
       input wire  [7:0] i_fifo_data_cnt,
       input wire  [6:0] i_fifo_ovf_cnt,
       output wire [7:0] o_fifo_config3,
       output wire [7:0] o_fifo_a_full_level,
       output wire [7:0] o_fifo_a_empty_level,
       input       [17:0]i_fifo_rd_data,
       output            o_fifo_rd_req_n,
       output wire       o_fifo_full_sts_clr,
       output wire       o_fifo_empty_sts_clr,
       output wire       o_fifo_a_full_sts_clr,
       output wire       o_fifo_a_empty_sts_clr,
       output wire       o_fifo_a_error_sts_clr,

   //PPG
    //  output reg   [7:0] o_ppg_TIA_IDAC,  
      output wire         o_ppg_enable, 
      output wire         o_ppg_IDAC_LED_SEL,
      output wire   [2:0] o_ppg_mode_sel,
      output wire         o_PPG_SYNC_BYPASS,
     // output reg   [3:0] o_ppg_TIA_GAIN,
      output wire   [3:0] o_ppg_LED_TIME_SEL,
      output wire   [3:0] o_ppg_LED_FREQ_SEL,
      input wire          i_ppg_LED_STATUS,

//new added by Xin 26Mar2026
      output wire         o_PPG_LED_PROG_SEL,
 	output wire   [13:0] led_on,
 	output wire   [13:0] led_freq,
   
  

   //analog register outputs
   //ana_buffer
      output wire       o_BG1P2_BUF_EN,     
      output wire       o_VCM1P5_BUF_EN,
      output wire       o_RLD_AMP_EN,
      output wire       o_RLD_CHOP_EN,
    //ECG
     output wire        o_ECG_PGA_EN,
     output wire        o_ECG_LPF_EN,
     output wire  [2:0] o_ECG_PGA_GSEL, 
     output wire  [1:0] o_ECG_DDA_CLKSEL,
     output wire        o_ECG_DDA_EN,
     output wire  [2:0] o_ECG_DDA_GSEL,
     output wire        o_ECG_DDACHOP_EN,
     output wire  [1:0] o_ECG_DDA_ISEL,
     output wire         o_ECG_CAL_EN,
     output wire        o_ECG_ELECTRODE_EN,
   
 //DC_LEAD_OFF
    output wire         o_DC_LEAD_OFF_RMODE_EN,      
    output wire         o_DC_LEAD_OFF_VIN_FLIP,
  //output wire  [1:0]  o_DC_LEAD_OFF_ISEL,
  //output wire  [2:0]  o_DC_LEAD_OFF_COMP_TH_EN,
    output wire  [1:0]  o_LEAD_OFF_EN,

//TSC
   output wire         o_TSC_OUT_SEL,
   output wire  [2:0]  o_TSC_BJT_SEL,
   output wire         o_TSC_EN,
   output wire  [2:0]  o_TSC_INA_GEL, 
   output wire         o_TSC_INA_EN,

 //ANA_PPG
   output wire         o_PPG_DAC_BUFFER_EN,
   output wire  [11:0] o_PPG_DAC0_VSEL,
   output wire         o_PPG_DAC0_EN,
   output wire  [11:0] o_PPG_DAC1_VSEL,
   output wire         o_PPG_DAC1_EN,
   output wire  [7:0]  o_PPG_TIA_IDAC,
   output wire  [3:0]  o_PPG_TIA_GAIN,
   output wire  [1:0]  o_PPG_TEST_OUT,
   output wire  [1:0]  o_PPG_TEST_IN,
   output wire         o_PPG_SH_CK,
   output wire  [1:0]  o_PPG_PDV_REF_SEL,
   //output wire         o_PPG_LED_STATUS,
   output wire         o_PPG_LED_STANDBYEN,
   output wire         o_PPG_LED_EN,
   output wire  [1:0]  o_PPG_LED_SEL,
   output wire         o_PPG_LED_DAC_SEL,
   output wire         o_PPG_TIA_VREF_BUFFER_EN,
   output wire         o_PPG_TIA_EN,
   output wire         o_PPG_SH_EN,
   output wire         o_PPG_BUFFER_EN,
   output wire         o_PPG_AF_EN,

 //ANA_SDM
   //output wire  [2:0] o_SDM_VIN_SEL,
  // output wire        o_SDM_CLK,
   output wire        o_SDM_EN,
   output wire  [1:0] o_SDM_BIAS,

    output wire        o_Z_ADC_EN_SPI,
    output wire        o_adc_en_sel  ,  
    output wire 	ppg_ctrl_disable,
    output wire 	bio_disable,

 
//ANA_BIST
    output wire  [2:0] o_BIST_ISEL,        
    output wire        o_BIST_EN,
//A2D SPARE
   input wire [7:0]  i_A2D_SPARE_0,
   input wire        i_A2D_LOFF_STATN,         
   input wire        i_A2D_LOFF_STATP,         
   input wire        i_A2D_ACLEADOFF_STATN,         
   input wire        i_A2D_ACLEADOFF_STATP,  

//trim from always on
/*
 input wire [4:0]   trim1_always_on, // bgh_vtrim_always_on,
 input wire [6:0]   trim2_always_on, // bgh_ctrim_always_on,
 input wire [1:0]   trim3_always_on, // ldo1v5_trim_always_on,
 input wire [5:0]   trim4_always_on  // osc_trim_always_on
*/

 input wire [7:0]   trim1_always_on, // bgh_vtrim_always_on,
 input wire [7:0]   trim2_always_on, // bgh_ctrim_always_on,
 input wire [7:0]   trim3_always_on, // ldo1v5_trim_always_on,
 input wire [7:0]   trim4_always_on,// osc_trim_always_on
 input wire [7:0]   trim5_always_on,
 input wire [7:0]   trim6_always_on,
 input wire [7:0]   trim7_always_on,
 input wire [7:0]   trim8_always_on,
 input wire [7:0]   trim9_always_on,
 input wire [7:0]   trim10_always_on 


 
);

//parameter ADDR_WIDTH = 8;
//parameter DATA_WIDTH = 8;

//internal signals

wire [ADDR_WIDTH-1:0] addr;
wire                   wr;
wire                   rd;
wire [DATA_WIDTH-1:0] wr_data;
wire [DATA_WIDTH-1:0] rd_data;
wire  addr_vld_for_int_clr;
wire burst_cmd;
wire [ADDR_WIDTH-1:0] pre_addr;



wire int_clk = SCANMODE ? i_scanclk : i_sclk;




//fifo_data synchronizer (which goes to spi_reg and spi_slave controller)

wire [17:0] rd_fifo_data_sync;
common_sync_bit  //common_bit_sync 
 #(
.RST_VAL(0))
 u_rd_fifo_data_sync [17:0](
       .clk(int_clk),// i_clk),
       .rst_(i_rst_n),
      .async_in(i_fifo_rd_data), //16'h18877), 
     //   .async_in(18'h8877), 
       .sync_out(rd_fifo_data_sync)   //fifo_rd_data
       );




spi_slave_controller#(
.ADDR_WIDTH(ADDR_WIDTH),
.DATA_WIDTH(DATA_WIDTH)
)spi_slv_ctrl_u (
  .i_rst_n       (i_rst_n),
  .i_sclk        (int_clk),      //clk for spi_slave 
  .atpg_en	 (SCANMODE),
  .i_cs_n        (i_cs_n),
  .i_mosi        (i_mosi),
  .i_rd_data     (rd_data),
  .o_miso        (o_miso),
  .o_addr        (addr),
  .o_addr_vld_for_int_clr(addr_vld_for_int_clr),
  .o_wr          (wr),
  .o_rd          (rd),
  .o_wr_data     (wr_data),
 
  .i_fifo_rd_data  (rd_fifo_data_sync),//i_fifo_rd_data),
  .o_fifo_rd_req_n (o_fifo_rd_req_n),
  .i_tag_out_en    (o_fifo_config3[2]),
  .burst_cmd_reg   (burst_cmd),
  .o_pre_addr      (pre_addr)
);

//defparam spi_slv_ctrl_u.ADDR_WIDTH = ADDR_WIDTH;
//defparam spi_slv_ctrl_u.DATA_WIDTH = DATA_WIDTH;

spi_reg #(
.ADDR_WIDTH(ADDR_WIDTH),
.DATA_WIDTH(DATA_WIDTH),
.NO_TRIM_REGS(NO_TRIM_REGS)	
)
spi_reg_u (
        .spi2flash       (spi2flash),
        .spi2imeas(spi2imeas),		
	.i_clk(int_clk),            //clk for reg block same as sclk 
	.i_rst_n(i_rst_n),
	.atpg_en(SCANMODE),
	.i_addr(addr),
	.i_wr(wr),
	.i_rd(rd),
	.i_wr_data(wr_data),
	.o_rd_data(rd_data),
        .i_addr_vld_for_int_clr(addr_vld_for_int_clr),

        .i_burst_cmd   (burst_cmd),
        .i_pre_addr    (pre_addr),

.phase_inc    (phase_inc),
.phase_offset (phase_offset),
.phase_offset_c (phase_offset_c),
.Bioz_en    (Bioz_en),
.Bioz_reset_reg    (Bioz_reset_reg),
.iq_reg_ctrl (iq_reg_ctrl),
.iq_iclk_div (iq_iclk_div), 
.iq_adc_clk_inv (iq_adc_clk_inv),
	
	.o_meas_sync_en(meas_sync_en),
        .o_config_zmeas_ctrl_reg(config_zmeas_ctrl_reg),
	.o_zmeas_en(zmeas_en),
        .o_zmeas_phase_dither_en(zmeas_phase_dither_en), 

	.data_type_sel(data_type_sel),    //00 is sinwave, 01: DC, 10: square wave, 11: sinwave
	.dc_data(dc_data),    
	.dc_data_c(dc_data_c),    
/*
	.square_data_l(square_data_l),    
	.square_data_h(square_data_h),    
*/
	//.square_clk_div(square_clk_div),

//z-meas
	.o_zmeas_int_clr(zmeas_int_clr),//output wire
	.o_zmeas_adc_int_clr(zmeas_adc_int_clr),//output wire
	.o_zmeas_reg_ctrl(zmeas_reg_ctrl),
	.i_zmeas_reg_status(zmeas_reg_status),
	.i_zmeas_reg_dataout(zmeas_reg_dataout),

	.i_zmeas_xn_data(zmeas_xn_data),
	.i_zmeas_sine_for_dft(zmeas_sine_for_dft),
	.i_zmeas_cosine_for_dft(zmeas_cosine_for_dft),
	.i_zmeas_summation_offset_forreal(zmeas_summation_offset_forreal),
	.i_zmeas_summation_real(zmeas_summation_real),
	.i_zmeas_summation_imag(zmeas_summation_imag),
	.i_zmeas_shiftedreal_inter(zmeas_shiftedreal_inter),
	.i_zmeas_dft_cnt(zmeas_dft_cnt),
	.i_reg_zmeas_int(reg_zmeas_int),
	.i_reg_zmeas_adc_int(reg_zmeas_adc_int),

//sys_ctrl
	.SDM_CLK_GPIO_pha_sel(SDM_CLK_GPIO_pha_sel),
	.acleadoff_clk_sel(acleadoff_clk_sel),
	.rld_clk_reg(rld_clk_reg),
	.o_fclk_dynen(fclk_dynen),
	.o_pclk_div(pclk_div),
	.o_iclk_div(iclk_div),
	.o_mclk_div(mclk_div),
	.o_checking_clk_div(checking_clk_div),
        .o_imeas_adc_inv(imeas_adc_inv),
        .o_always_on_spi_write(o_always_on_spi_write),

//GPIO
        .gpio_pu_ctrl(gpio_pu_ctrl),	
        .gpio_pu_resetn(gpio_pu_resetn),
        .gpio_pd_testmode(gpio_pd_testmode),


 //PPG
  //    .o_ppg_TIA_IDAC(o_ppg_TIA_IDAC),  
      .o_ppg_enable(o_ppg_enable), 
      .o_ppg_IDAC_LED_SEL(o_ppg_IDAC_LED_SEL),
      .o_ppg_mode_sel(o_ppg_mode_sel),
      .o_PPG_SYNC_BYPASS(o_PPG_SYNC_BYPASS), 
    //  .o_ppg_TIA_GAIN(o_ppg_TIA_GAIN),
      .o_ppg_LED_TIME_SEL(o_ppg_LED_TIME_SEL),
      .o_ppg_LED_FREQ_SEL(o_ppg_LED_FREQ_SEL),

//new added by Xin 26Mar2026
        .o_PPG_LED_PROG_SEL(o_PPG_LED_PROG_SEL),
        .led_on(led_on),
        .led_freq(led_freq),

    //to always on
     //   .o_fclk_dynen_flash(fclk_dynen_flash),
     //   .o_dc_dc_en_flash(dc_dc_en_flash), 
      //  .o_dc_clk_div_flash(dc_clk_div_flash), 

   //from always on
      //  .i_fclk_dynen_always_on(i_fclk_dynen_always_on),
     //   .i_dc_dc_en_always_on(i_dc_dc_en_always_on),
      //  .i_dc_clk_div_always_on(i_dc_clk_div_always_on),

      //PMU
     	.bio_disable(bio_disable),
     	.ppg_ctrl_disable(ppg_ctrl_disable),
	.o_pmuenable(pmuenable),            // pmu enable
	.o_hresetreq(hresetreq),            // system reset request
	.o_sleepdeep(sleepdeep),            // system enters deep-sleep state
	.o_flash_dpstb_en(flash_dpstb_en),        // flash deep power down standby mode enable
	.o_fifo_disable(o_fifo_disable),        // flash deep power down standby mode enable
    //    .o_fclk_sleep_en(fclk_sleep_en),
 
    
         //FIFO
        .i_fifo_rd_ptr   (i_fifo_rd_ptr),
        .i_fifo_wr_ptr   (i_fifo_wr_ptr),
        .i_fifo_a_empty  (i_fifo_a_empty),
        .i_fifo_empty    (i_fifo_empty),
        .i_fifo_a_full   (i_fifo_a_full),
        .i_fifo_full     (i_fifo_full),
        .i_fifo_error    (i_fifo_error),
        .i_fifo_data_cnt (i_fifo_data_cnt),
        .i_fifo_ovf_cnt  (i_fifo_ovf_cnt),
        .i_rd_fifo_data  (rd_fifo_data_sync),//i_fifo_rd_data), //i_rd_fifo_data),

        .o_fifo_config3(o_fifo_config3),
        .o_fifo_a_full_level(o_fifo_a_full_level),
        .o_fifo_a_empty_level(o_fifo_a_empty_level),
        .o_fifo_full_sts_clr(o_fifo_full_sts_clr),
        .o_fifo_empty_sts_clr(o_fifo_empty_sts_clr),
        .o_fifo_a_full_sts_clr(o_fifo_a_full_sts_clr),
        .o_fifo_a_empty_sts_clr(o_fifo_a_empty_sts_clr),
        .o_fifo_a_error_sts_clr(o_fifo_a_error_sts_clr),

 //analog register outputs
  
   //Peripheral
     //ana_buffer
      .o_BG1P2_BUF_EN(o_BG1P2_BUF_EN),     
      .o_VCM1P5_BUF_EN(o_VCM1P5_BUF_EN),
      .o_RLD_AMP_EN(o_RLD_AMP_EN), 
      .o_RLD_CHOP_EN(o_RLD_CHOP_EN),   
    //ECG
     .o_ECG_PGA_EN(o_ECG_PGA_EN),
     .o_ECG_LPF_EN(o_ECG_LPF_EN),
     .o_ECG_PGA_GSEL(o_ECG_PGA_GSEL), 
     .o_ECG_DDA_CLKSEL(o_ECG_DDA_CLKSEL),
     .o_ECG_DDA_EN(o_ECG_DDA_EN),
     .o_ECG_DDA_GSEL(o_ECG_DDA_GSEL),
     .o_ECG_DDACHOP_EN(o_ECG_DDACHOP_EN),
     .o_ECG_DDA_ISEL(o_ECG_DDA_ISEL),
     .o_ECG_CAL_EN(o_ECG_CAL_EN),
     .o_ECG_ELECTRODE_EN(o_ECG_ELECTRODE_EN),
   
 //DC_LEAD_OFF
    .o_DC_LEAD_OFF_RMODE_EN(o_DC_LEAD_OFF_RMODE_EN),      
    .o_DC_LEAD_OFF_VIN_FLIP(o_DC_LEAD_OFF_VIN_FLIP),
  //.o_DC_LEAD_OFF_ISEL(o_DC_LEAD_OFF_ISEL),
  //.o_DC_LEAD_OFF_COMP_TH_EN(o_DC_LEAD_OFF_COMP_TH_EN),
    .o_LEAD_OFF_EN(o_LEAD_OFF_EN),

//TSC
   .o_TSC_OUT_SEL(o_TSC_OUT_SEL),
   .o_TSC_BJT_SEL(o_TSC_BJT_SEL),
   .o_TSC_EN(o_TSC_EN),
   .o_TSC_INA_GEL(o_TSC_INA_GEL), 
   .o_TSC_INA_EN(o_TSC_INA_EN),
 //ANA_PPG
   .o_PPG_DAC_BUFFER_EN(o_PPG_DAC_BUFFER_EN),
   .o_PPG_DAC0_VSEL(o_PPG_DAC0_VSEL),
   .o_PPG_DAC0_EN(o_PPG_DAC0_EN),
   .o_PPG_DAC1_VSEL(o_PPG_DAC1_VSEL),
   .o_PPG_DAC1_EN(o_PPG_DAC1_EN),
   .o_PPG_TIA_IDAC(o_PPG_TIA_IDAC),
   .o_PPG_TIA_GAIN(o_PPG_TIA_GAIN),
   .o_PPG_TEST_OUT(o_PPG_TEST_OUT),
   .o_PPG_TEST_IN(o_PPG_TEST_IN),
   .o_PPG_SH_CK(o_PPG_SH_CK),
   .o_PPG_PDV_REF_SEL(o_PPG_PDV_REF_SEL),
  // .o_PPG_LED_STATUS(o_PPG_LED_STATUS),
   .o_PPG_LED_STANDBYEN(o_PPG_LED_STANDBYEN),
   .o_PPG_LED_EN(o_PPG_LED_EN),
   .o_PPG_LED_SEL(o_PPG_LED_SEL),
   .o_PPG_LED_DAC_SEL(o_PPG_LED_DAC_SEL),
   .o_PPG_TIA_VREF_BUFFER_EN(o_PPG_TIA_VREF_BUFFER_EN),
   .o_PPG_TIA_EN(o_PPG_TIA_EN),
   .o_PPG_SH_EN(o_PPG_SH_EN),
   .o_PPG_BUFFER_EN(o_PPG_BUFFER_EN),
   .o_PPG_AF_EN(o_PPG_AF_EN),

//ANA_SDM
   // .o_SDM_VIN_SEL(o_SDM_VIN_SEL),
  //  .o_SDM_CLK(o_SDM_CLK),
    .o_SDM_EN(o_SDM_EN),        
    .o_SDM_BIAS(o_SDM_BIAS),

	.o_Z_ADC_EN_SPI(o_Z_ADC_EN_SPI),
        .o_adc_en_sel  (o_adc_en_sel),
   
//ANA_BIST
    .o_BIST_ISEL(o_BIST_ISEL),        
    .o_BIST_EN(o_BIST_EN),

 //A2D_SPARE
  .i_A2D_SPARE_0(i_A2D_SPARE_0),
  .i_A2D_LOFF_STATN(i_A2D_LOFF_STATN),         
  .i_A2D_LOFF_STATP(i_A2D_LOFF_STATP),         
  .i_A2D_ACLEADOFF_STATN(i_A2D_ACLEADOFF_STATN),         
  .i_A2D_ACLEADOFF_STATP(i_A2D_ACLEADOFF_STATP),

 //PPG_LED_STATUS
    .i_ppg_LED_STATUS (i_ppg_LED_STATUS),

//DEBUG REGSISTERS from always_on 
  .trim1_always_on(trim1_always_on), //bgh_vtrim_always_on
  .trim2_always_on(trim2_always_on), //bgh_ctrim_always_on
  .trim3_always_on(trim3_always_on), //ldo1v5_trim_always_on
  .trim4_always_on(trim4_always_on),  //osc_trim_always_on    
  .trim5_always_on(trim5_always_on), 
  .trim6_always_on(trim6_always_on), 
  .trim7_always_on(trim7_always_on), 
  .trim8_always_on(trim8_always_on), 
  .trim9_always_on(trim9_always_on), 
  .trim10_always_on(trim10_always_on)
  
);

endmodule  

