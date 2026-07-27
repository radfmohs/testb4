/*--------------------------------------------------------------------------------------*/
/*      Nanochap Confidential                                                           */
/*--------------------------------------------------------------------------------------*/
/* File Name	 : shadow_regs_always_on.v                                                        */
/* Project	 : BAF4P1 Chip                                                        */
/* Designer	 : Mohsen Radfar	                                               */
/* Description	 : to load flash shadow registers to always on registers after each wake up*/
/* Date		 : 2/8/2022                                                          */
/*--------------------------------------------------------------------------------------*/
/* Revision History :                                                           */    
/* Data         Rev.     By             Description                                     */
/*--------------------------------------------------------------------------------------*/
/* 							                            */
/*--------------------------------------------------------------------------------------*/

module shadow_regs_always_on (
  //always on inputs:
  input poresetn, //POR reset of always on domain
  input hfosc_atpg,
  input wakeup_done, //disabled (active high) when in low power mode (connects to the wake up pin)

  //switchable inputs:	
  input atpg_en, //floating atpg_en will be gated by clock gating cell
  input scan_en, //floating atpg_en will be gated by clock gating cell //Tri add
  input iopad_testmode0_en_y,
  input iopad_testmode1_en_y,
  input poresetn_hf_sw_power, //por signal (after por timer) from switchable domain
  input spi_write, // ready (loading) signal when spi has loaded data into spi  registers after the reset (active high)
  input flash_reset_done,

  //	input [2:0] d2a_cpclk_spi, 

  input bg1p2_buf_en_spi,
  //  input dac_buf_en_spi,

  input wire vcm1p5_buf_en_spi,     
  input wire rld_amp_en_spi,        
  //ecg
  input wire ecg_pga_en_spi,        
  input wire ecg_lpf_en_spi,         
  input wire [2:0] ecg_pga_gsel_spi,      
  input wire [1:0] ecg_dda_clksel_spi,    
  input wire ecg_dda_en_spi,        
  input wire [2:0] ecg_dda_gsel_spi,      
  input wire ecg_ddachop_en_spi,     
  input wire [1:0] ecg_dda_isel_spi,    
  input wire       ecg_2electrode_en_spi,
  input wire       ecg_cal_en_spi,
  input wire       ecg_rld_chop_en_spi,   

  //dc_lead_off
  input wire dc_lead_off_rmode_en_spi,      
  input wire dc_lead_off_vin_flip_spi,   
  input wire       dc_lead_off_en_spi,

  //ac_lead_off
  input wire       ac_lead_off_en_spi,

  input bist_en_spi,
  input [2:0]  bist_isel_spi,
  //input dda_en_spi,
  //input [2:0] dda_gsel_spi,
  //input ele_buf_en_spi,
  //input [2:0] ele_buf_sel_spi,
  /*input r2r_dac1_en_spi,
  input [11:0] r2r_dac1_din_spi,
  input r2r_dac2_en_spi,
  input [11:0] r2r_dac2_din_spi,*/

  input [7:0] flash_trim1_spi,
  input [7:0] flash_trim2_spi,
  input [7:0] flash_trim3_spi,
  input [7:0] flash_trim4_spi,
  input [7:0] flash_trim5_spi,
  input [7:0] flash_trim6_spi,
  input [7:0] flash_trim7_spi,
  input [7:0] flash_trim8_spi,
  input [7:0] flash_trim9_spi,
  input [7:0] flash_trim10_spi,
  input [7:0] flash_trim11_spi,
  input [7:0] flash_trim12_spi,
  input [7:0] flash_trim13_spi,
  input [7:0] flash_trim14_spi,

  output reg bg1p2_buf_en,
  //   output reg dac_buf_en,

  output reg vcm1p5_buf_en,     
  output reg rld_amp_en,        
  //ecg
  output reg ecg_pga_en,        
  output reg ecg_lpf_en,         
  output reg [2:0] ecg_pga_gsel,      
  output reg [1:0] ecg_dda_clksel,    
  output reg ecg_dda_en,        
  output reg [2:0] ecg_dda_gsel,      
  output reg ecg_ddachop_en,     
  output reg [1:0] ecg_dda_isel,     
  output reg       ecg_2electrode_en,
  output reg       ecg_cal_en,
  output reg       ecg_rld_chop_en,  

  //dc_lead_off
  output reg dc_lead_off_rmode_en,      
  output reg dc_lead_off_vin_flip,   
  output reg       dc_lead_off_en,

  //ac_lead_off
  output reg       ac_lead_off_en,

  output reg bist_en,
  output reg [2:0] bist_isel,
  //output reg dda_en,
  //output reg [2:0] dda_gsel,
  //output reg ele_buf_en,
  //output reg [2:0] ele_buf_sel,
  /*output reg r2r_dac1_en,
  output reg [11:0] r2r_dac1_din,
  output reg r2r_dac2_en,
  output reg [11:0] r2r_dac2_din,*/

  output reg [7:0] trim1_always_on,
  output reg [7:0] trim2_always_on,
  output reg [7:0] trim3_always_on,
  output reg [7:0] trim4_always_on,
  output reg [7:0] trim5_always_on,
  output reg [7:0] trim6_always_on,
  output reg [7:0] trim7_always_on,
  output reg [7:0] trim8_always_on,
  output reg [7:0] trim9_always_on,
  output reg [7:0] trim10_always_on,
  output reg [7:0] trim11_always_on,
  output reg [7:0] trim12_always_on,
  output reg [7:0] trim13_always_on,
  output reg [7:0] trim14_always_on
);

parameter WAKEUP_COUNT = 3'b100; //4 * 1/256KHz = 15.625 us delay before loading from switchable domain is allowed

reg [2:0] count;
reg load_allowed;
wire sclk;
reg flash_reset_done_d1, flash_reset_done_d2, flash_reset_done_d3;
reg spi_write_d1, spi_write_d2, spi_write_d3;
wire spi_write_rising_edge, flash_reset_done_rising_edge;
wire poresetn_sw_sync;

wire poresetn_hf_sw_power_tmp;
assign poresetn_hf_sw_power_tmp = atpg_en? poresetn: (wakeup_done & poresetn_hf_sw_power);

common_rst_sync u_poresetn_hf_sync(
.RSTINn    (poresetn_hf_sw_power_tmp),
.RSTREQ    (~poresetn),
.CLK       (hfosc_atpg),
.SE        (),
.RSTBYPASS (atpg_en),   //Tri change atpg_en is after AND with wakeup_done
.RSTOUTn   (poresetn_sw_sync)
);

//checking if loading from switchable domain is allowed (if wakeup process is complete)
always @(posedge hfosc_atpg or negedge poresetn_sw_sync) 
begin
  if (!poresetn_sw_sync) 
  begin
     count <= 3'b0;
     load_allowed <= 1'b0;
  end
  else 
  begin
    if(count > WAKEUP_COUNT)
	load_allowed <= 1'b1;
      else
        count <= count + 1'b1;
  end
end

//sclk gating
common_clock_gate 
u_cmsdk_clock_gate_hclk (
.clk        (hfosc_atpg),
.enable     (load_allowed),
.bypass     (scan_en),  //Tri change
.gated_clk  (sclk));

always @(posedge sclk or negedge poresetn)
begin
  if(!poresetn)
  begin
    flash_reset_done_d1      <= 1'b0;
    flash_reset_done_d2      <= 1'b0;
    flash_reset_done_d3      <= 1'b0;
    spi_write_d1             <= 1'b0;
    spi_write_d2             <= 1'b0;
    spi_write_d3             <= 1'b0;
  end
  else
  begin
    flash_reset_done_d1      <= flash_reset_done & load_allowed;
    flash_reset_done_d2      <= flash_reset_done_d1;
    flash_reset_done_d3      <= flash_reset_done_d2;
    spi_write_d1             <= spi_write & load_allowed;
    spi_write_d2             <= spi_write_d1; 
    spi_write_d3             <= spi_write_d2;
  end
end

assign spi_write_rising_edge = ({iopad_testmode1_en_y & load_allowed,iopad_testmode0_en_y & load_allowed} == 2'b11) ? 1'b1 : spi_write_d2 & !spi_write_d3;
assign flash_reset_done_rising_edge = ({iopad_testmode1_en_y & load_allowed,iopad_testmode0_en_y & load_allowed} == 2'b11) ? 1'b1 : flash_reset_done_d2 & !flash_reset_done_d3;

//loading registers from switchable domain into always on domain
always @(posedge sclk or negedge poresetn) 
begin
  if(!poresetn) 
  begin
	//d2a_cpclk  <= 3'b000;
	bg1p2_buf_en  <= 1'b0; 
	//dac_buf_en <= 1'b0;

	vcm1p5_buf_en <= 1'b0;     
	rld_amp_en <= 1'b0;        
	//ecg
	ecg_pga_en <= 1'b1;        
	ecg_lpf_en <= 1'b1;         
	ecg_pga_gsel  <= 3'b00;      
	ecg_dda_clksel  <= 2'b0;    
	ecg_dda_en <= 1'b1;        
	ecg_dda_gsel  <= 3'b0;      
	ecg_ddachop_en <= 1'b0;     
	ecg_dda_isel  <= 2'b0;       
  ecg_2electrode_en <= 1'b0;
  ecg_cal_en        <= 1'b0;
  ecg_rld_chop_en   <= 1'b0;

	//dc_lead_off
	dc_lead_off_rmode_en <= 1'b0;      
	dc_lead_off_vin_flip <= 1'b0;   
	dc_lead_off_en <= 1'b0; 
  ac_lead_off_en <= 1'b0;

	bist_en                 <= 1'b0; 
	bist_isel               <= 3'b000;
	//dda_en                  <= 1'b0;
	//dda_gsel                <= 3'b000;
	//ele_buf_en              <= 1'b0;
	//ele_buf_sel             <= 3'b000;
	/*r2r_dac1_en             <= 1'b0;
	r2r_dac1_din            <= 12'h000;
	r2r_dac2_en             <= 1'b0;
	r2r_dac2_din            <= 12'h000;*/
  end
  else 
  begin
    if(spi_write_rising_edge) 
    begin
	//d2a_cpclk  <= d2a_cpclk_spi & {3{load_allowed}};

	bg1p2_buf_en  <= bg1p2_buf_en_spi & load_allowed;
	//dac_buf_en <= dac_buf_en_spi & load_allowed;

	vcm1p5_buf_en <= vcm1p5_buf_en_spi & load_allowed;   
	rld_amp_en <= rld_amp_en_spi & load_allowed; 
	//ecg
	ecg_pga_en <= ecg_pga_en_spi & load_allowed;        
	ecg_lpf_en <= ecg_lpf_en_spi & load_allowed;         
	ecg_pga_gsel  <= ecg_pga_gsel_spi & {3{load_allowed}};      
	ecg_dda_clksel  <= ecg_dda_clksel_spi & {2{load_allowed}};    
	ecg_dda_en <= ecg_dda_en_spi & load_allowed;        
	ecg_dda_gsel  <= ecg_dda_gsel_spi & {3{load_allowed}};      
	ecg_ddachop_en <= ecg_ddachop_en_spi & load_allowed;     
	ecg_dda_isel  <= ecg_dda_isel_spi & {2{load_allowed}};   
  ecg_2electrode_en <= ecg_2electrode_en_spi & load_allowed; 
  ecg_cal_en        <= ecg_cal_en_spi        & load_allowed;
  ecg_rld_chop_en   <= ecg_rld_chop_en_spi   & load_allowed;        

	//dc_lead_off
	dc_lead_off_rmode_en <= dc_lead_off_rmode_en_spi & load_allowed;      
	dc_lead_off_vin_flip <= dc_lead_off_vin_flip_spi & load_allowed;   
	dc_lead_off_en <= dc_lead_off_en_spi & load_allowed; 
	ac_lead_off_en <= ac_lead_off_en_spi & load_allowed; 

	bist_en                <= bist_en_spi & load_allowed;
	bist_isel              <= bist_isel_spi & {3{load_allowed}};
	//dda_en                 <= dda_en_spi & load_allowed;
	//dda_gsel               <= dda_gsel_spi & {3{load_allowed}};
	//ele_buf_en             <= ele_buf_en_spi & load_allowed;
	//ele_buf_sel            <= ele_buf_sel_spi & {3{load_allowed}};
	/*r2r_dac1_en            <= r2r_dac1_en_spi & load_allowed;
	r2r_dac1_din           <= r2r_dac1_din_spi & {12{load_allowed}};
	r2r_dac2_en            <= r2r_dac2_en_spi & load_allowed;
	r2r_dac2_din           <= r2r_dac2_din_spi & {12{load_allowed}};*/
    end
  end
end

always @(posedge sclk or negedge poresetn)
begin
  if(!poresetn)
  begin
	trim1_always_on          <=  8'b00010000;
	trim2_always_on          <=  8'b01000000;
	trim3_always_on          <=  8'b00000010;
	trim4_always_on          <=  8'b00100000;
	trim5_always_on          <=  8'b00000001;
	trim6_always_on          <=  8'b00000000;
	trim7_always_on          <=  8'b00000000;
	trim8_always_on          <=  8'b00000100;
	trim9_always_on          <=  8'b00000100;
	trim10_always_on         <=  8'b00000001;
	trim11_always_on         <=  8'b00000000;
	trim12_always_on         <=  8'b00000000;
	trim13_always_on         <=  8'b00000000;
	trim14_always_on         <=  8'b00000000;
  end
  else
  begin
    if(flash_reset_done_rising_edge)
    begin 
	trim1_always_on        <=  flash_trim1_spi & {8{load_allowed}};
	trim2_always_on        <=  flash_trim2_spi & {8{load_allowed}};
	trim3_always_on        <=  flash_trim3_spi & {8{load_allowed}};
	trim4_always_on        <=  flash_trim4_spi & {8{load_allowed}};
	trim5_always_on        <=  flash_trim5_spi & {8{load_allowed}};
	trim6_always_on        <=  flash_trim6_spi & {8{load_allowed}};
	trim7_always_on        <=  flash_trim7_spi & {8{load_allowed}};
	trim8_always_on        <=  flash_trim8_spi & {8{load_allowed}};
	trim9_always_on        <=  flash_trim9_spi & {8{load_allowed}};
	trim10_always_on        <= flash_trim10_spi & {8{load_allowed}};
	trim11_always_on        <= flash_trim11_spi & {8{load_allowed}};
	trim12_always_on        <= flash_trim12_spi & {8{load_allowed}};
	trim13_always_on        <= flash_trim13_spi & {8{load_allowed}};
	trim14_always_on        <= flash_trim14_spi & {8{load_allowed}};
    end
  end
end
	
endmodule
 			
