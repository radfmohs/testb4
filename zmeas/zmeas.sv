//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from Arm Limited or its affiliates.
//
//            (C) COPYRIGHT 2010-2011,2017 Arm Limited or its affiliates.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from Arm Limited or its affiliates.
//
//      SVN Information
//
//      Checked In          : $Date: 2017-10-10 15:55:38 +0100 (Tue, 10 Oct 2017) $
//
//      Revision            : $Revision: 371321 $
//
//      Release Information : Cortex-M System Design Kit-r1p1-00rel0
//
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Abstract : APB impedance measurement
//-----------------------------------------------------------------------------

`include "zmeas_parameters.vh"

module zmeas (
   input  wire        pclk,                          // PCLK 
   input  wire        presetn,                       // Reset

   output wire        zmeasint,                      // zmeasurement done interrupt output
   output wire        zmeasadcint,                      // zmeasurement adc interrupt output

   //DC and sqaure wave feature added
   input wire [1:0]   data_type_sel,    //00 is sinwave, 01: DC, 10: square wave, 11: sinwave
   input wire [9:0]   dc_data,    
   input wire [9:0]   square_data,    //from clk cntrl
   input wire [9:0]   square_data_l,  //from trim
   input wire [9:0]   square_data_h,  //from trim
   input wire [7:0]   ecgcal_reg_ctrl, //coming from imeas_reg_ctrl_1 of SPI

   //===================
   input  wire        mclk,                          //4mhz clock needed by zmeas_top changed on 14may
   //wire to/from SPI
   input wire                    meas_sync_en,
   input wire                    zmeas_phase_dither_en,           
   input wire                    config_zmeas_ctrl_reg,
   input wire 			zmeas_int_clr,
   input wire 			adc_int_clr,
   input wire 	[31:0] 		reg_ctrl,
   output wire 	[31:0] 		reg_dataout,
   output wire  	[9:0] 		xn_data,
   output wire  	[9:0] 		sine_for_dft,
   output wire  	[9:0] 		cosine_for_dft,
   output wire 	[28:0] 		summation_offset_forreal,
   output wire 	[28:0] 		summation_real,
   output wire 	[28:0] 		summation_imag,
   output wire signed [16:0] 	shiftedreal_inter,
   output wire 	[11:0] 		dft_cnt,
   output reg 			reg_zmeas_int,
   output reg 			reg_zmeas_adc_int,

   output wire [15:0]  reg_status,   
   // inputs outputs from to testmode logic
   input atpg_en,                                    // atpg_en=1: this block is in scan test mode
   input scan_en,                                    // Tri add


   //=============
   // new names
   output wire [9:0]	D2A_ECGCAL_VSEL_TRIM,

   output wire [1:0]  	D2A_SW_Z_TX_GSEL,
   output wire 		D2A_SW_Z_CALMD,
   output wire 		D2A_SW_Z_CLK256K,
   output wire [9:0]	D2A_SW_Z_DDS,
   output wire		D2A_SW_Z_RXGAIN,
   //output wire		D2A_SW_Z_EN,
   output wire		D2A_Z_EN,

   output wire		D2A_SW_Z_ADC_EN,
   output wire		D2A_SW_Z_ADC_SAMPLE,
   input  wire [9:0]	A2D_SW_Z_ADC_D,
   input  wire 		A2D_SW_Z_ADC_EOC,

   input wire        Z_ADC_EN_SPI,   //from SPI, then select 2 source, then output to ana
   //input wire        Z_DAC_EN_SPI,   //from SPI, directly go to ana

   /*	
   //new add signals
   output wire [3:0]  Z_SEL1V5,  //1:0, config_output_voltage_range[1:0]
                                 //2:measure_calibrate
                                 //3. pga_gain
   output wire        Z_ADC_EN,   //from SPI, then select 2 source, then output to ana
   //output wire        Z_DAC_EN,   //from SPI, directly go to ana
   output wire        Z_SYS_CLK,  //adc_clk
   output wire [9:0]  DDS,  //rom
   // signals talking to analog ADC and DAC throug zmeas_top
   input  wire        adc_eoc,                       // SARADC signals data is ready
   input  wire [9:0]  adc_in,                        // 10b dig input  from SARADC
   output wire        adc_sample,                    // out put to SARADC to start sampling
   */
   input  wire 	     adc_en_sel   //0 is state machine, 1 is register control
   //input  wire 	     dac_en_sel,   //0 is state machine, 1 is register control

); 

//the following 2 signals are not useful
wire        adc_clk;                       // clock out to SARADC
wire        adc_enable;                    // enable SARADC
//the followings are not useful
wire        measure_calibrate;             // 1: measurement, 0: calibration
wire [1:0]  config_output_voltage_range;   // configures the o/p voltage range
wire        d2a_z_tx_gsel_1;
wire        pga_gain;                      // gain factor setting


wire             zmeas_power_en;                // 1: DAC enable, 0: DAC disable
wire [9:0]  rom_data_out  ;                 // 10b input to DAC
wire [`DDS_PHACC_BITS-1-12:0] addrs_in_fwd;
//==============

wire [3:0]  Z_SEL1V5;  //1:0, config_output_voltage_range[1:0]
                       //2:measure_calibrate
                       //3. pga_gain
wire        Z_ADC_EN;   //from SPI, then select 2 source, then output to ana
//output wire        Z_DAC_EN,   //from SPI, directly go to ana
wire        Z_SYS_CLK;  //adc_clk
wire [9:0]  DDS;  //rom
wire [9:0]  DDS_CAL;  
// signals talking to analog ADC and DAC throug zmeas_top
wire        adc_eoc;                       // SARADC signals data is ready
wire [9:0]  adc_in;                        // 10b dig input  from SARADC
wire        adc_sample;                    // out put to SARADC to start sampling


//new signals 30/Sep/2022
assign DDS  = rom_data_out;
//because the GC1 is connected like this
//assign Z_SEL1V5  = {pga_gain,measure_calibrate,config_output_voltage_range};
//assign Z_SEL1V5  = {pga_gain,measure_calibrate,config_output_voltage_range[0],config_output_voltage_range[1]};
assign Z_SEL1V5[0] =   config_output_voltage_range[0];
assign Z_SEL1V5[1] =   config_output_voltage_range[1];
assign Z_SEL1V5[2] =   measure_calibrate;
assign Z_SEL1V5[3] =   pga_gain;

assign Z_SYS_CLK = adc_clk; 
//temporily
assign Z_ADC_EN = adc_en_sel ? Z_ADC_EN_SPI :  adc_enable; 
//assign Z_DAC_EN = dac_en_sel ? Z_DAC_EN_SPI :  zmeas_power_en;
//==============================
assign		D2A_SW_Z_RXGAIN  = Z_SEL1V5[3];
assign 		D2A_SW_Z_CALMD   = Z_SEL1V5[2];
assign  	   D2A_SW_Z_TX_GSEL = {d2a_z_tx_gsel_1,Z_SEL1V5[0]};
assign 		D2A_SW_Z_CLK256K = Z_SYS_CLK;
//assign 		D2A_SW_Z_CLK256K = (data_type_sel == 2'b01) ? 1'b1 : Z_SYS_CLK;

reg [9:0] ecg_vsel_trim;
always @(posedge pclk or negedge presetn)
  if (~presetn) 
    ecg_vsel_trim <= 10'b0;
  else
    ecg_vsel_trim <=   (data_type_sel == 2'b00) ? DDS : 
                       (data_type_sel == 2'b01) ? dc_data :
                       (data_type_sel == 2'b10) ? square_data :
	                                                DDS_CAL;
							                                                
assign 		D2A_ECGCAL_VSEL_TRIM = ecg_vsel_trim;
assign 		D2A_SW_Z_DDS 	 = D2A_ECGCAL_VSEL_TRIM;

wire [10:0] trim_diff;
assign trim_diff = square_data_h - square_data_l + 1;

reg [3:0] count_pow;
always @(*) begin
   count_pow = 3'b0;
   for (integer idx = 0; idx <= 10; idx = idx + 1) begin//calculate log2(trim_diff)
      if (((trim_diff >> idx) > 0) && (ecgcal_reg_ctrl[0]==0))
         count_pow = 10 - idx;//calculate shiftright applied to the 10 bit sine
      else if (((trim_diff >> idx) <= 0) && (ecgcal_reg_ctrl[0]==0))
         count_pow = count_pow;
      else
         count_pow = ecgcal_reg_ctrl[4:1];
   end
end

/*always_comb begin

  if (ecgcal_reg_ctrl[0]) begin
    count_pow = ecgcal_reg_ctrl[4:1];
  end
  else begin
    if (trim_diff < 10'h001) begin
      count_pow = 4'h9;
    end
    else begin
      if (trim_diff < 10'h003) begin
        count_pow = 4'h8;
      end
      else begin
        if (trim_diff < 10'h007) begin
          count_pow = 4'h7;
        end
        else begin
          if (trim_diff < 10'h00f) begin
            count_pow = 4'h6;
          end
          else begin
            if (trim_diff < 10'h01f) begin
              count_pow = 4'h5;
            end
            else begin
              if (trim_diff < 10'h07f) begin
                count_pow = 4'h4;
              end
              else begin
                if (trim_diff < 10'h0ff) begin
                  count_pow = 4'h3;
                end
                else begin
                  if (trim_diff < 10'h1ff) begin
                    count_pow = 4'h2;
                  end
                  else begin
                    if (trim_diff < 10'h3ff) begin
                      count_pow = 4'h1;
                    end
                    else begin
                      if (trim_diff == 10'h3ff) begin
                        count_pow = 4'h0;
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end*/

wire [9:0] shiftright = (DDS >> count_pow);//Divide DDS by 2^log2(trim_diff)
wire [9:0] offset = (square_data_h - (10'h3ff >> count_pow));//offset for positive side of sine wave
assign DDS_CAL =  (0 <= addrs_in_fwd && addrs_in_fwd <= 9'h0ff) ? 
                  //only perform following for pos side of waveform
                  shiftright + offset : //add offset to make max exactly square_data_h
                  //only perform following for neg side of waveform
                  shiftright + square_data_l;//add offset to make min exactly square_data_l


//assign 		D2A_SW_Z_EN 	 = Z_SEL1V5[1];
assign 		D2A_Z_EN 	 = Z_SEL1V5[1];

assign		D2A_SW_Z_ADC_EN  = Z_ADC_EN;
assign 		D2A_SW_Z_ADC_SAMPLE = adc_sample; 
assign      adc_eoc = A2D_SW_Z_ADC_EOC;                       // SARADC signals data is ready
assign   	adc_in = A2D_SW_Z_ADC_D;                       // 10b dig input  from SARADC

wire dds_enable;

wire [15:0] reg_ctrl_int;
wire [2:0] reg_freq_val; 
wire [7:0] reg_settling_time_val;
wire [3:0] reg_number_of_repeat_cycle_val;
assign d2a_z_tx_gsel_1= reg_ctrl_int[7];


wire reg_zmeas_enable_intr;
wire reg_zmeas_adc_enable_intr;

//output to f/w thr apb
wire reg_freq_calc_complete;
wire reg_valid_imag_data;
wire reg_valid_real_data;

wire adc_eoc_level;

  reg  config_zmeas_ctrl_reg_d1;
  reg  config_zmeas_ctrl_reg_d2;
  reg  config_zmeas_ctrl_reg_d3;

always @(posedge pclk or negedge presetn)
begin
  if (~presetn) begin 
  	config_zmeas_ctrl_reg_d1 <= 1'b0;
  	config_zmeas_ctrl_reg_d2 <= 1'b0;
  	config_zmeas_ctrl_reg_d3 <= 1'b0;
  end else begin
  	config_zmeas_ctrl_reg_d1 <= config_zmeas_ctrl_reg;
  	config_zmeas_ctrl_reg_d2 <= config_zmeas_ctrl_reg_d1;
  	config_zmeas_ctrl_reg_d3 <= config_zmeas_ctrl_reg_d2;
  end
end

wire config_zmeas_ctrl_reg_active = config_zmeas_ctrl_reg_d2 ^ config_zmeas_ctrl_reg_d3;
/*
reg 	[31:0] 		reg_ctrl_sync;
always @(posedge pclk or negedge presetn)
begin
  if (~presetn) 
  	reg_ctrl_sync <= 32'b0;
  else if (config_zmeas_ctrl_reg_active)
  	reg_ctrl_sync <= reg_ctrl;
end
*/
wire 	[31:0] 		reg_ctrl_sync;
assign reg_ctrl_sync = reg_ctrl;


wire [31:0] reg_ctrl_final = meas_sync_en ? reg_ctrl_sync : reg_ctrl;

// Internal signals
reg          zmeas_int_set;       // Set zmeas interrupt status
reg          adc_int_set;         // set zmeas adc int status
reg          adc_eoc_dly;         // dlyed adc_eoc to generate pulse for interrupt on pclk
reg          freq_meas_done_dly;

//wire [15:0]  reg_status;   
wire  [2:0] reg_freq_val_init; 
wire  [3:0] reg_number_of_repeat_cycle_val_init;
wire [15:0]  reg_status_int;   
assign reg_status =  {reg_number_of_repeat_cycle_val_init, reg_freq_val_init, config_output_voltage_range, measure_calibrate, pga_gain, adc_enable, dds_enable, reg_freq_calc_complete, reg_valid_imag_data, reg_valid_real_data}; 

// Start of main code
// internal assignments
assign reg_ctrl_int = reg_ctrl_final[15:0];
assign reg_freq_val = reg_ctrl_final[18:16];
assign reg_settling_time_val = reg_ctrl_final[27:20];
assign reg_number_of_repeat_cycle_val = reg_ctrl_final[31:28];

assign reg_zmeas_enable_intr = reg_ctrl_final[10];
//assign  reg_zmeas_clr_intr = reg_ctrl_final[11];
assign reg_zmeas_adc_enable_intr = reg_ctrl_final[8];



// Read and write control signals
/*assign  read_enable  = psel & (~pwrite);                            // assert for whole APB read transfer
assign  write_enable = psel & (~penable) & pwrite;                  // assert for 1st cycle of write transfer
assign  write_enable00 = write_enable & (paddr[11:2] == 10'h000);
assign  write_enable20 = write_enable & (paddr[11:2] == 10'h008); //TODO
assign  write_enable24 = write_enable & (paddr[11:2] == 10'h009);*/

// Write operations
  // Control register
/*  always @(posedge pclkg or negedge presetn)
  begin
    if (~presetn)
      reg_ctrl <= {32{1'b0}};
    else if (write_enable00)
      reg_ctrl <= pwdata[31:0];
    else 
      reg_ctrl <= reg_ctrl;
  end*/


// register read  

/*always @ (*)
 begin
   case (read_enable)
     1'b1:
     begin
       if (paddr[11:6] == 6'h0) begin
         case(paddr[5:2])
           4'b0000: prdata =  reg_ctrl;
           4'b0001: prdata =  {{16{1'b0}}, reg_number_of_repeat_cycle_val_init, reg_freq_val_init, config_output_voltage_range, measure_calibrate, pga_gain, adc_enable, dbg_signal_zmeas3[6], reg_freq_calc_complete, reg_valid_imag_data, reg_valid_real_data};
           4'b0010: prdata =  {reg_dataout};
           4'b0011: prdata =  {2'b00, xn_data[9:0],sine_for_dft[9:0], cosine_for_dft[9:0]}; 
           4'b0100: prdata =  {3'b000,summation_offset_forreal[28:0]};
	   4'b0101: prdata =  {3'b000, summation_real[28:0]};
	   4'b0110: prdata =  {3'b000, summation_imag[28:0]};
	   4'b0111: prdata =  {3'b000, shiftedreal_inter[16:0], dft_cnt[11:0]};
	   4'b1000: prdata =  {{31{1'b0}}, reg_zmeas_int}; // TODO
	   4'b1001: prdata =  {{31{1'b0}}, reg_zmeas_adc_int};
           default: prdata = {32'h00000000};
         endcase
       end
       else begin
         prdata = {32'h00000000}; // default
       end
   end
   1'b0:
     begin
       prdata =  {32{1'b0}};
     end
   default:
     begin
       prdata =  {32{1'b0}};
     end
   endcase
 end*/

 // APB interface
//assign   pready  = 1'b1; //always ready. Can be customized to support waitstate if required.
//assign   pslverr = 1'b0; //alwyas OKAY. Can be customized to support error response if required.

// Interrupt generation
// Trigger an interrupt when freq_measurement_done and interrupt enabled
// and hold it until clear by software
//assign zmeas_int_set   = ((reg_zmeas_enable_intr) & (reg_freq_calc_complete) & (reg_ctrl[15:13]==`CTRL_START_CALC));
//assign zmeas_int_set   = ( (reg_freq_calc_complete) & (reg_ctrl[15:13]==`CTRL_START_CALC));
always @(posedge pclk or negedge presetn)
begin
  if (~presetn) begin
    freq_meas_done_dly <= 1'b0;
    zmeas_int_set <= 1'b0;
  end
  else begin
    freq_meas_done_dly <= reg_freq_calc_complete;
    zmeas_int_set <= (freq_meas_done_dly==1'b0&&reg_freq_calc_complete==1'b1&&(reg_ctrl_final[15:13]==`CTRL_START_CALC)) ? 1'b1 : 1'b0;
  end
end


// Trigger the interrupt when adc_eoc and hold it until clear by software
//assign adc_int_set = adc_eoc; //TODO too risky because adc_eoc is generated w.r.t mclk and what if pclk is run slower than 4mhz
//shall i do this for safety? This will trigger reg_zmeas_adc_int after one
//whole pclk cycle but since adc runs at 250khz, we will still have time to
//read adc_in registers on apb and do operations hopefully

always @(posedge pclk or negedge presetn)
begin
  if (~presetn) begin
    adc_eoc_dly <= 1'b0;
    adc_int_set <= 1'b0;
  end
  else begin
    adc_eoc_dly <= adc_eoc_level;
    adc_int_set <= (adc_eoc_level==1'b1&&adc_eoc_dly==1'b0) ? 1'b1 : 1'b0;
  end
end

// Registering zmeas done interrupt output
//always @(posedge pclk or negedge presetn)
//begin
//  if (~presetn)
//    reg_zmeas_int <= 1'b0;
//    else
//    reg_zmeas_int <= (reg_zmeas_clr_intr)? 0 : zmeas_int_set;
//end

wire zmeas_int_rstn = atpg_en ? presetn: presetn & (~zmeas_int_clr);

//always @(posedge pclk or negedge presetn) begin
always @(posedge pclk or negedge zmeas_int_rstn) begin
  //if (~presetn)
  if (~zmeas_int_rstn)
    reg_zmeas_int <= 1'b0;
  //else if (zmeas_int_clr) 
  //  reg_zmeas_int <= 1'b0;
  else if (zmeas_int_set)
    reg_zmeas_int <= 1'b1;
  else 
    //reg_zmeas_int <= reg_zmeas_int && reg_zmeas_enable_intr;
    reg_zmeas_int <= reg_zmeas_int ;
end

//interrupt clear
//assign zmeas_int_clr = write_enable20 & pwdata[0]; //TODO

//adc interrupt generate
wire adc_int_rstn = atpg_en ? presetn: presetn & (~adc_int_clr);
//always @(posedge pclk or negedge presetn) begin
always @(posedge pclk or negedge adc_int_rstn) begin
  //if (~presetn)
  if (~adc_int_rstn)
    reg_zmeas_adc_int <= 1'b0;
  //else if (adc_int_clr)
  //  reg_zmeas_adc_int <= 1'b0;
  else if (adc_int_set)
    reg_zmeas_adc_int <= 1'b1;
  else
    reg_zmeas_adc_int <= reg_zmeas_adc_int;
end

//interrupt clear
//assign adc_int_clr = write_enable24 & pwdata[0];


//combo

assign reg_number_of_repeat_cycle_val_init = reg_status_int[13:10];
assign reg_freq_val_init = reg_status_int[9:7];


assign reg_freq_calc_complete = reg_status_int[2];
assign reg_valid_imag_data= reg_status_int[1];
assign reg_valid_real_data= reg_status_int[0];

// Connect to external
//assign zmeasint = reg_zmeas_int;
assign zmeasint = reg_zmeas_int & reg_zmeas_enable_intr;
assign zmeasadcint = reg_zmeas_adc_int & reg_zmeas_adc_enable_intr; 


// instantiate zmeas_top module

zmeas_top u_zmeas_top (
   .mclk(mclk), 
   .pclk(pclk), 
   .nrst(presetn), 
   .reg_freq_val(reg_freq_val), 
   .reg_ctrl(reg_ctrl_int),
   .reg_settling_time_val(reg_settling_time_val),
   .reg_number_of_repeat_cycle_val(reg_number_of_repeat_cycle_val),
   .phase_dither_en(zmeas_phase_dither_en),
   .adc_eoc(adc_eoc),
   .adc_eoc_level(adc_eoc_level),
   .adc_in(adc_in),
   .adc_enable(adc_enable),
   .adc_clk(adc_clk),
   .adc_sample(adc_sample),
   .measure_calibrate(measure_calibrate),
   .config_output_voltage_range(config_output_voltage_range),
   .pga_gain(pga_gain),
   .zmeas_power_en(zmeas_power_en),
   .reg_status(reg_status_int),
   .reg_dataout(reg_dataout), 
   .rom_data_out(rom_data_out),
   .addrs_in_fwd(addrs_in_fwd),
   .sine_for_dft(sine_for_dft),
   .cosine_for_dft(cosine_for_dft),
   .summation_offset_forreal(summation_offset_forreal),
   .summation_real(summation_real),
   .summation_imag(summation_imag),
   .shiftedreal_inter(shiftedreal_inter),
   .dft_cnt(dft_cnt),
   .xn_data(xn_data),
   .dds_enable(dds_enable),
   // inputs outputs from to testmode logic
   .atpg_en(atpg_en),
   .scan_en(scan_en)   //Tri ADD
);


endmodule
