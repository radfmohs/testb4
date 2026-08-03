/*--------------------------------------------------------------------------------------*/
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
// --------------------------------------------------------------------------------------
// Project      : Nanochap BAF4P1
// File         : tb_chip_top_uvm_imeas.sv
// Description  : IMEAS TB 
// Designer     : Ophina Correya
// Date         : 11/06/2024
// Revision     : 0.1
/*--------------------------------------------------------------------------------------*/
`define  IMEAS_CHA_MODE_SINGLE      	             0
`define  IMEAS_CHA_MODE_SINGLE_CONT 	             1
`define  IMEAS_CHA_MODE_GROUP      	             2
`define  IMEAS_CHA_FORMAT_SIGNED    	             0
`define  IMEAS_CHA_FORMAT_UNSIGNED  	             1
`define  IMEAS_CIC_RATE_32          	             0
`define  IMEAS_CIC_RATE_64         	             1
`define  IMEAS_CIC_RATE_128        	             2
`define  IMEAS_CIC_RATE_256         	             3
`define  IMEAS_CIC_RATE_512        	             4
`define  IMEAS_CIC_RATE_1024       	             5
`define  IMEAS_CIC_RATE_2048        	             6

wire [(16-1):0] notch_coeffs [9:0][13:0];        //[65536Hz - 128Hz] [coeff_18 : coeff_0]
wire [(16-1):0] lpf_coeffs [13:0][6:0][27:0];   //[262144Hz - 32Hz] [Fpass=Fs/10  : Fpass=Fs/4] [coeff_27 : coeff_0]
wire [(24-1):0] hpf_coeffs [13:0][5:0];         //[262144Hz - 32Hz] [10, 5, 2, 1, 0.5, 0.2]Hz -> Fc

`include "blocks/notch_coeffs_list.svh"
`include "blocks/lpf_coeffs_list.svh"
`include "blocks/hpf_coeffs_list.svh"

nnc_imeas_filter_mon_interface   imeas_filter_mon_if();

initial begin
    nnc_config_db#(virtual nnc_imeas_filter_mon_interface)::set(uvm_root::get(), "uvm_test_top.top_env", "imeas_filter_mon_if", imeas_filter_mon_if);
end

// --------------------------------------------------------------------------------
// IMEAS REF MODEL
// --------------------------------------------------------------------------------
reg  [15:0] ch0_cic_out;
reg  [15:0] ch1_cic_out;
reg  [15:0] ch2_cic_out;
reg  [27:0] ch0_exp_cic_out;
reg  [27:0] ch1_exp_cic_out;
reg  [27:0] ch2_exp_cic_out;
wire [27:0] exp_cic_out0;
wire [27:0] exp_cic_out1;
wire [27:0] exp_cic_out2;
wire [27:0] exp_cic_out3;
wire [27:0] exp_cic_out4;
wire [27:0] exp_cic_out5;
wire [27:0] exp_cic_out6;
wire [27:0] exp_cic_out7;
reg  [27:0] exp_cic_out_max;
reg  [27:0] exp_cic_out_min;
reg  [27:0] exp_cic_out_delta;
reg  [27:0] exp_cic_out_max_final;
reg  [27:0] exp_cic_out_min_final;
reg         imeas_filter0_en;
reg         imeas_filter1_en;
wire [7:0]  ch_en;
wire [3:0]  chnum;
wire [3:0]  ppg_chnum;
wire [2:0]  cic_rate;
wire [1:0]  imeas_input_format;
wire offset;
wire sdm_adc0_clk;//only ch0 & ch1 considered for ppg mode test
wire sdm_adc1_clk;//only ch0 & ch1 considered for ppg mode test
wire sdm_adc_rst;

buf #(1) (offset, `IMEAS_TOP.cic_rst_n) ;
assign cic_rate = dut_vif.imeas_cic_rate;
assign imeas_input_format = dut_vif.imeas_input_format;

//connect imeas fifo signals to interface
assign dut_vif.imeas_chdata_en_n = `IMEAS_TOP.chdata_en_n;
assign dut_vif.imeas_chdata = `IMEAS_TOP.chdata;
assign dut_vif.fifo_full = `FIFO_TOP.fifo_full;
assign dut_vif.fifo_config_a = `FIFO_TOP.fifo_config_a;

`ifndef ZMEAS_DDS_TO_IMEAS
// Connecting DUT_VIF to model
assign `ANA_TOP.u_imeas_analog.ppg_mode = dut_vif.imeas_ppg_en;
assign `ANA_TOP.u_imeas_analog.imeas_24Hz_ena = dut_vif.imeas_24Hz_in;
assign `ANA_TOP.u_imeas_analog.imeas_sin_amp = dut_vif.imeas_sin_amp;
assign `ANA_TOP.u_imeas_analog.imeas_sin_offset = dut_vif.imeas_sin_offset;
assign `ANA_TOP.u_imeas_analog.imeas_sampling_rate = dut_vif.imeas_sampling_rate;
assign `ANA_TOP.u_imeas_analog.imeas_sin_freq = dut_vif.imeas_sin_freq;
assign `ANA_TOP.u_imeas_analog.imeas_sin_gen_en = dut_vif.imeas_sin_gen_en;
assign `ANA_TOP.u_imeas_analog.imeas_clk_sel = dut_vif.iclk_sel;
assign `ANA_TOP.u_imeas_analog.imeas_cic_rate = dut_vif.imeas_cic_rate;
assign `ANA_TOP.u_imeas_analog.imeas_rtl_bypass_en = dut_vif.imeas_rtl_bypass_en;
assign dut_vif.OSR = `ANA_TOP.u_imeas_analog.OSR;
assign dut_vif.counter = `ANA_TOP.u_imeas_analog.counter;
`endif

//`ifdef BEHAVIORAL - not required
// connect filter coefficients to dut if
/*
assign dut_vif.scaleconst1       = `IMEAS_TOP.u_filter.scaleconst1      ;
assign dut_vif.coeff_b1_section1 = `IMEAS_TOP.u_filter.coeff_b1_section1;
assign dut_vif.coeff_b2_section1 = `IMEAS_TOP.u_filter.coeff_b2_section1;
assign dut_vif.coeff_b3_section1 = `IMEAS_TOP.u_filter.coeff_b3_section1;
assign dut_vif.coeff_a2_section1 = `IMEAS_TOP.u_filter.coeff_a2_section1;
assign dut_vif.coeff_a3_section1 = `IMEAS_TOP.u_filter.coeff_a3_section1;
assign dut_vif.scaleconst2       = `IMEAS_TOP.u_filter.scaleconst2      ;
assign dut_vif.coeff_b1_section2 = `IMEAS_TOP.u_filter.coeff_b1_section2;
assign dut_vif.coeff_b2_section2 = `IMEAS_TOP.u_filter.coeff_b2_section2;
assign dut_vif.coeff_b3_section2 = `IMEAS_TOP.u_filter.coeff_b3_section2;
assign dut_vif.coeff_a2_section2 = `IMEAS_TOP.u_filter.coeff_a2_section2;
assign dut_vif.coeff_a3_section2 = `IMEAS_TOP.u_filter.coeff_a3_section2;
*/
assign dut_vif.sign_en = `IMEAS_TOP.u_filter.sign_en;

assign imeas_filter_mon_if.filter_in = `IMEAS_TOP.u_filter.filter_in;
assign imeas_filter_mon_if.filter_out = `IMEAS_TOP.u_filter.filter_out;
assign imeas_filter_mon_if.clk = `IMEAS_TOP.u_filter.clk;
assign imeas_filter_mon_if.clk_en = `IMEAS_TOP.u_filter.clk_enable;
assign imeas_filter_mon_if.notch_filter_en = `IMEAS_TOP.notch_filter_en;
/*
assign dut_vif.scaleconst3       = `IMEAS_TOP.u_filter.scaleconst3      ;
assign dut_vif.coeff_b1_section3 = `IMEAS_TOP.u_filter.coeff_b1_section3;
assign dut_vif.coeff_b2_section3 = `IMEAS_TOP.u_filter.coeff_b2_section3;
assign dut_vif.coeff_b3_section3 = `IMEAS_TOP.u_filter.coeff_b3_section3;
assign dut_vif.coeff_a2_section3 = `IMEAS_TOP.u_filter.coeff_a2_section3;
assign dut_vif.coeff_a3_section3 = `IMEAS_TOP.u_filter.coeff_a3_section3;
assign dut_vif.scaleconst4       = `IMEAS_TOP.u_filter.scaleconst4      ;
assign dut_vif.coeff_b1_section4 = `IMEAS_TOP.u_filter.coeff_b1_section4;
assign dut_vif.coeff_b2_section4 = `IMEAS_TOP.u_filter.coeff_b2_section4;
assign dut_vif.coeff_b3_section4 = `IMEAS_TOP.u_filter.coeff_b3_section4;
assign dut_vif.coeff_a2_section4 = `IMEAS_TOP.u_filter.coeff_a2_section4;
assign dut_vif.coeff_a3_section4 = `IMEAS_TOP.u_filter.coeff_a3_section4;
*/
//`endif

assign imeas_filter_mon_if.imeas_sin_amp            = dut_vif.imeas_sin_amp           ;
assign imeas_filter_mon_if.imeas_out_diff_amp       = dut_vif.imeas_out_diff_amp      ;
assign imeas_filter_mon_if.filter_gain              = dut_vif.filter_gain             ;
assign imeas_filter_mon_if.imeas_sin_expected_freq  = dut_vif.imeas_sin_expected_freq ; 
assign imeas_filter_mon_if.imeas_sin_offset         = dut_vif.imeas_sin_offset        ;
assign imeas_filter_mon_if.t1                       = (dut_vif.counter=== 'd1) ? 1 :0  ;
assign imeas_filter_mon_if.filter_gain_mult         = dut_vif.filter_gain_mult        ;
assign imeas_filter_mon_if.imeas_sampling_rate      = dut_vif.imeas_sampling_rate        ;
assign imeas_filter_mon_if.imeas_rtl_bypass_en      = dut_vif.imeas_rtl_bypass_en;
assign imeas_filter_mon_if.OSR                      = dut_vif.OSR;

assign ppg_chnum = ((`ANA_TOP.D2A_PPG_SH_CK === 0) && (`SOC_TB.IOBUF_PAD[18] === 0)) ? 4'h0 : (((`ANA_TOP.D2A_PPG_SH_CK === 0) && (`SOC_TB.IOBUF_PAD[18] === 1)) ? 4'h1 : ppg_chnum);

//`ifdef BEHAVIORAL
  assign chnum = (dut_vif.imeas_ppg_en === 1) ? ppg_chnum : `ANA_TOP.D2A_SDM_VIN_SEL;
  `ifdef ZMEAS_DDS_TO_IMEAS
  assign sdm_adc0_clk = ~`ANA_TOP.D2A_SDM_CLK;
  assign sdm_adc1_clk = ~`ANA_TOP.D2A_SDM_CLK;
  `else
  assign sdm_adc0_clk = (dut_vif.imeas_ppg_en === 1) ? `ANA_TOP.u_imeas_analog.adc_clk_0_final : ~`ANA_TOP.D2A_SDM_CLK;
  assign sdm_adc1_clk = (dut_vif.imeas_ppg_en === 1) ? `ANA_TOP.u_imeas_analog.adc_clk_1_final : ~`ANA_TOP.D2A_SDM_CLK;
  `endif
  //Generate channel enables of ref model
  assign ch_en[0] = (dut_vif.imeas_ppg_en === 1) ? `IMEAS_TOP.adc_clk_0_en : ((chnum === 0) ? 1'b1 : 1'b0);//only ch0 & ch1 considered for ppg mode test
  assign ch_en[1] = (dut_vif.imeas_ppg_en === 1) ? `IMEAS_TOP.adc_clk_1_en : ((chnum === 1) ? 1'b1 : 1'b0);//only ch0 & ch1 considered for ppg mode test

assign sdm_adc_rst = `IMEAS_TOP.u_imeas_reg.restart ? (`SOC_TOP.A2D_SW_POWER_POR & offset) : `SOC_TOP.A2D_SW_POWER_POR;
assign ch_en[2] = (chnum === 2) ? 1'b1 : 1'b0;
assign ch_en[3] = (chnum === 3) ? 1'b1 : 1'b0;
assign ch_en[4] = (chnum === 4) ? 1'b1 : 1'b0;
assign ch_en[5] = (chnum === 5) ? 1'b1 : 1'b0;
assign ch_en[6] = (chnum === 6) ? 1'b1 : 1'b0;
assign ch_en[7] = (chnum === 7) ? 1'b1 : 1'b0;

//always block to sample ref model output
always @ (posedge `IMEAS_TOP.u_imeas_reg.int_set)
begin
if(`IMEAS_TOP.u_imeas_reg.chmod === 2'b10) begin//group mode
case (`IMEAS_TOP.active_channel_num[3:0])
              4'b0000: ch0_exp_cic_out=exp_cic_out0;
              4'b0001: ch0_exp_cic_out=exp_cic_out1;
              4'b0010: ch0_exp_cic_out=exp_cic_out2;
              4'b0011: ch0_exp_cic_out=exp_cic_out3;
              4'b0100: ch0_exp_cic_out=exp_cic_out4;
              4'b0101: ch0_exp_cic_out=exp_cic_out5;
              4'b0110: ch0_exp_cic_out=exp_cic_out6;
              4'b0111: ch0_exp_cic_out=exp_cic_out7;
endcase
case (`IMEAS_TOP.active_channel_num[7:4])
              4'b0000: ch1_exp_cic_out=exp_cic_out0;
              4'b0001: ch1_exp_cic_out=exp_cic_out1;
              4'b0010: ch1_exp_cic_out=exp_cic_out2;
              4'b0011: ch1_exp_cic_out=exp_cic_out3;
              4'b0100: ch1_exp_cic_out=exp_cic_out4;
              4'b0101: ch1_exp_cic_out=exp_cic_out5;
              4'b0110: ch1_exp_cic_out=exp_cic_out6;
              4'b0111: ch1_exp_cic_out=exp_cic_out7;
endcase
case (`IMEAS_TOP.active_channel_num[11:8])
              4'b0000: ch2_exp_cic_out=exp_cic_out0;
              4'b0001: ch2_exp_cic_out=exp_cic_out1;
              4'b0010: ch2_exp_cic_out=exp_cic_out2;
              4'b0011: ch2_exp_cic_out=exp_cic_out3;
              4'b0100: ch2_exp_cic_out=exp_cic_out4;
              4'b0101: ch2_exp_cic_out=exp_cic_out5;
              4'b0110: ch2_exp_cic_out=exp_cic_out6;
              4'b0111: ch2_exp_cic_out=exp_cic_out7;
endcase
   imeas_filter0_en = 1;
   imeas_filter1_en = 0;
end
else begin//single mode
case (chnum)
              4'b0000: ch0_exp_cic_out=exp_cic_out0;
              4'b0001: ch0_exp_cic_out=exp_cic_out1;
              4'b0010: ch0_exp_cic_out=exp_cic_out2;
              4'b0011: ch0_exp_cic_out=exp_cic_out3;
              4'b0100: ch0_exp_cic_out=exp_cic_out4;
              4'b0101: ch0_exp_cic_out=exp_cic_out5;
              4'b0110: ch0_exp_cic_out=exp_cic_out6;
              4'b0111: ch0_exp_cic_out=exp_cic_out7;
endcase
//imeas_bio max/min only for single mode
if(dut_vif.imeas_bio_en === 1) begin
   if(ch0_exp_cic_out >= exp_cic_out_max)
	exp_cic_out_max = ch0_exp_cic_out;
   else
	exp_cic_out_max = exp_cic_out_max;

   if(ch0_exp_cic_out <= exp_cic_out_min)
	exp_cic_out_min = ch0_exp_cic_out;
   else
	exp_cic_out_min = exp_cic_out_min;
end
//imeas ppg_mode only for single mode
if(((`ANA_TOP.D2A_PPG_SH_CK === 0) && (`SOC_TB.IOBUF_PAD[18] === 0)) || ((`ANA_TOP.D2A_PPG_SH_CK === 1) && (`SOC_TB.IOBUF_PAD[18] === 1))) begin
   imeas_filter0_en = 1;
   imeas_filter1_en = 0;
end
else if(((`ANA_TOP.D2A_PPG_SH_CK === 0) && (`SOC_TB.IOBUF_PAD[18] === 1)) || ((`ANA_TOP.D2A_PPG_SH_CK === 1) && (`SOC_TB.IOBUF_PAD[18] === 0))) begin
   imeas_filter0_en = 0;
   imeas_filter1_en = 1;
end

end
end

//always block to get max,min,delta final
always @ (posedge `SOC_TB.IOBUF_PAD[4])
begin
   exp_cic_out_max_final = exp_cic_out_max;
   exp_cic_out_min_final = exp_cic_out_min;
   exp_cic_out_max = 28'h0;
   exp_cic_out_min = 28'hfffffff;
end

//always block to check result
always @ (negedge `SOC_TB.IOBUF_PAD[4])
begin

  if(~`IMEAS_TOP.presetn) begin
	`nnc_info("SOC_TEST", "Imeas reset!!!", UVM_LOW)
	exp_cic_out_max = 28'h0;
	exp_cic_out_min = 28'hfffffff;
        exp_cic_out_delta = 28'h0;
  end
  else if (dut_vif.imeas_sb_en === 1'b1) begin
    case(cic_rate)
      `IMEAS_CIC_RATE_32:  begin//cic_rate:32
		     if(imeas_filter0_en === 1)
			ch0_cic_out = dut_vif.ch0_data[15:6];
		     else if(imeas_filter1_en === 1)
			ch0_cic_out = dut_vif.ch1_data[15:6];
			ch1_cic_out = dut_vif.ch1_data[15:6];
			ch2_cic_out = dut_vif.ch2_data[15:6];
			if(`IMEAS_TOP.u_imeas_reg.chmod === 2'b10) begin//group mode
			  if(ch0_cic_out !== ch0_exp_cic_out[9:0])
			  	`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[3:0], ch0_cic_out, ch0_exp_cic_out[9:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[3:0], ch0_cic_out, ch0_exp_cic_out[9:0]),UVM_LOW)
			  if(ch1_cic_out !== ch1_exp_cic_out[9:0])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[7:4], ch1_cic_out, ch1_exp_cic_out[9:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[7:4], ch1_cic_out, ch1_exp_cic_out[9:0]),UVM_LOW)
			  if(ch2_cic_out !== ch2_exp_cic_out[9:0])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[11:8],ch2_cic_out, ch2_exp_cic_out[9:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[11:8],ch2_cic_out, ch2_exp_cic_out[9:0]),UVM_LOW)
			end
			else begin
			 if(dut_vif.imeas_bio_en === 1) begin
			  ch0_cic_out = dut_vif.ch0_data_max[15:6];
			  if(ch0_cic_out !== exp_cic_out_max_final[9:0])
				`nnc_error("TEST", $sformatf("imeas max_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_max_final[9:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas max_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_max_final[9:0]),UVM_LOW)
			  ch0_cic_out = dut_vif.ch0_data_min[15:6];
			  if(ch0_cic_out !== exp_cic_out_min_final[9:0])
				`nnc_error("TEST", $sformatf("imeas min_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_min_final[9:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas min_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_min_final[9:0]),UVM_LOW)
			  ch0_cic_out = dut_vif.ch0_data_delta[15:6];
			  exp_cic_out_delta = exp_cic_out_max_final[9:0] - exp_cic_out_min_final[9:0];
			  if(((ch0_cic_out >= exp_cic_out_delta) && ((ch0_cic_out - exp_cic_out_delta) > 1)) || ((ch0_cic_out < exp_cic_out_delta) && ((exp_cic_out_delta - ch0_cic_out) > 1)))
				`nnc_error("TEST", $sformatf("imeas delta_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_delta))
			  else
				`nnc_info("TEST", $sformatf("imeas delta_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_delta),UVM_LOW)
			 end
			 else begin
			  if(ch0_cic_out !== ch0_exp_cic_out[9:0])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, ch0_exp_cic_out[9:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, ch0_exp_cic_out[9:0]),UVM_LOW)
			 end
			end
	      	     end
     `IMEAS_CIC_RATE_64:  begin//cic_rate:64
		     if(imeas_filter0_en === 1)
			ch0_cic_out = dut_vif.ch0_data[15:3];
		     else if(imeas_filter1_en === 1)
			ch0_cic_out = dut_vif.ch1_data[15:3];
			ch1_cic_out = dut_vif.ch1_data[15:3];
			ch2_cic_out = dut_vif.ch2_data[15:3];
			if(`IMEAS_TOP.u_imeas_reg.chmod === 2'b10) begin//group mode
			  if(ch0_cic_out !== ch0_exp_cic_out[12:0])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[3:0], ch0_cic_out, ch0_exp_cic_out[12:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[3:0], ch0_cic_out, ch0_exp_cic_out[12:0]),UVM_LOW)
			  if(ch1_cic_out !== ch1_exp_cic_out[12:0])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[7:4], ch1_cic_out, ch1_exp_cic_out[12:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[7:4], ch1_cic_out, ch1_exp_cic_out[12:0]),UVM_LOW)
			  if(ch2_cic_out !== ch2_exp_cic_out[12:0])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[11:8],ch2_cic_out, ch2_exp_cic_out[12:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[11:8],ch2_cic_out, ch2_exp_cic_out[12:0]),UVM_LOW)
			end
			else begin
			 if(dut_vif.imeas_bio_en === 1) begin
			  ch0_cic_out = dut_vif.ch0_data_max[15:3];
			  if(ch0_cic_out !== exp_cic_out_max_final[12:0])
				`nnc_error("TEST", $sformatf("imeas max_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_max_final[12:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas max_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_max_final[12:0]),UVM_LOW)
			  ch0_cic_out = dut_vif.ch0_data_min[15:3];
			  if(ch0_cic_out !== exp_cic_out_min_final[12:0])
				`nnc_error("TEST", $sformatf("imeas min_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_min_final[12:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas min_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_min_final[12:0]),UVM_LOW)
			  ch0_cic_out = dut_vif.ch0_data_delta[15:3];
			  exp_cic_out_delta = exp_cic_out_max_final[12:0] - exp_cic_out_min_final[12:0];
			  if(((ch0_cic_out >= exp_cic_out_delta) && ((ch0_cic_out - exp_cic_out_delta) > 1)) || ((ch0_cic_out < exp_cic_out_delta) && ((exp_cic_out_delta - ch0_cic_out) > 1)))
				`nnc_error("TEST", $sformatf("imeas delta_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_delta))
			  else
				`nnc_info("TEST", $sformatf("imeas delta_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_delta),UVM_LOW)
			 end
			 else begin
			  if(ch0_cic_out !== ch0_exp_cic_out[12:0])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, ch0_exp_cic_out[12:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, ch0_exp_cic_out[12:0]),UVM_LOW)
			 end
			end
	      	     end
     `IMEAS_CIC_RATE_128: begin//cic_rate:128
		     if(imeas_filter0_en === 1)
			ch0_cic_out = dut_vif.ch0_data[15:0];
		     else if(imeas_filter1_en === 1)
			ch0_cic_out = dut_vif.ch1_data[15:0];
			ch1_cic_out = dut_vif.ch1_data[15:0];
			ch2_cic_out = dut_vif.ch2_data[15:0];
			if(`IMEAS_TOP.u_imeas_reg.chmod === 2'b10) begin//group mode
			  if(ch0_cic_out !== ch0_exp_cic_out[15:0])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[3:0], ch0_cic_out, ch0_exp_cic_out[15:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[3:0], ch0_cic_out, ch0_exp_cic_out[15:0]),UVM_LOW)
			  if(ch1_cic_out !== ch1_exp_cic_out[15:0])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[7:4], ch1_cic_out, ch1_exp_cic_out[15:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[7:4], ch1_cic_out, ch1_exp_cic_out[15:0]),UVM_LOW)
			  if(ch2_cic_out !== ch2_exp_cic_out[15:0])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[11:8],ch2_cic_out, ch2_exp_cic_out[15:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[11:8],ch2_cic_out, ch2_exp_cic_out[15:0]),UVM_LOW)
			end
			else begin
			 if(dut_vif.imeas_bio_en === 1) begin
			  ch0_cic_out = dut_vif.ch0_data_max[15:0];
			  if(ch0_cic_out !== exp_cic_out_max_final[15:0])
				`nnc_error("TEST", $sformatf("imeas max_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_max_final[15:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas max_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_max_final[15:0]),UVM_LOW)
			  ch0_cic_out = dut_vif.ch0_data_min[15:0];
			  if(ch0_cic_out !== exp_cic_out_min_final[15:0])
				`nnc_error("TEST", $sformatf("imeas min_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_min_final[15:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas min_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_min_final[15:0]),UVM_LOW)
			  ch0_cic_out = dut_vif.ch0_data_delta[15:0];
			  exp_cic_out_delta = exp_cic_out_max_final[15:0] - exp_cic_out_min_final[15:0];
			  if(ch0_cic_out !== exp_cic_out_delta)
				`nnc_error("TEST", $sformatf("imeas delta_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_delta))
			  else
				`nnc_info("TEST", $sformatf("imeas delta_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_delta),UVM_LOW)
			 end
			 else begin
			  if(ch0_cic_out !== ch0_exp_cic_out[15:0])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, ch0_exp_cic_out[15:0]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, ch0_exp_cic_out[15:0]),UVM_LOW)
			 end
			end
	      	     end
     `IMEAS_CIC_RATE_256: begin//cic_rate:256
		     if(imeas_filter0_en === 1)
			ch0_cic_out = dut_vif.ch0_data[15:0];
		     else if(imeas_filter1_en === 1)
			ch0_cic_out = dut_vif.ch1_data[15:0];
			ch1_cic_out = dut_vif.ch1_data[15:0];
			ch2_cic_out = dut_vif.ch2_data[15:0];
			if(`IMEAS_TOP.u_imeas_reg.chmod === 2'b10) begin//group mode
			  if(ch0_cic_out !== ch0_exp_cic_out[18:3])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[3:0], ch0_cic_out, ch0_exp_cic_out[18:3]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[3:0], ch0_cic_out, ch0_exp_cic_out[18:3]),UVM_LOW)
			  if(ch1_cic_out !== ch1_exp_cic_out[18:3])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[7:4], ch1_cic_out, ch1_exp_cic_out[18:3]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[7:4], ch1_cic_out, ch1_exp_cic_out[18:3]),UVM_LOW)
			  if(ch2_cic_out !== ch2_exp_cic_out[18:3])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[11:8],ch2_cic_out, ch2_exp_cic_out[18:3]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[11:8],ch2_cic_out, ch2_exp_cic_out[18:3]),UVM_LOW)
			end
			else begin
			 if(dut_vif.imeas_bio_en === 1) begin
			  ch0_cic_out = dut_vif.ch0_data_max[15:0];
			  if(ch0_cic_out !== exp_cic_out_max_final[18:3])
				`nnc_error("TEST", $sformatf("imeas max_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_max_final[18:3]))
			  else
				`nnc_info("TEST", $sformatf("imeas max_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_max_final[18:3]),UVM_LOW)
			  ch0_cic_out = dut_vif.ch0_data_min[15:0];
			  if(ch0_cic_out !== exp_cic_out_min_final[18:3])
				`nnc_error("TEST", $sformatf("imeas min_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_min_final[18:3]))
			  else
				`nnc_info("TEST", $sformatf("imeas min_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_min_final[18:3]),UVM_LOW)
			  ch0_cic_out = dut_vif.ch0_data_delta[15:0];
			  exp_cic_out_delta = exp_cic_out_max_final[18:3] - exp_cic_out_min_final[18:3];
			  if(ch0_cic_out !== exp_cic_out_delta)
				`nnc_error("TEST", $sformatf("imeas delta_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_delta))
			  else
				`nnc_info("TEST", $sformatf("imeas delta_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_delta),UVM_LOW)
			 end
			 else begin
			  if(ch0_cic_out !== ch0_exp_cic_out[18:3])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, ch0_exp_cic_out[18:3]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, ch0_exp_cic_out[18:3]),UVM_LOW)
			 end
			end
	      	     end
     `IMEAS_CIC_RATE_512: begin//cic_rate:512
		     if(imeas_filter0_en === 1)
			ch0_cic_out = dut_vif.ch0_data[15:0];
		     else if(imeas_filter1_en === 1)
			ch0_cic_out = dut_vif.ch1_data[15:0];
			ch1_cic_out = dut_vif.ch1_data[15:0];
			ch2_cic_out = dut_vif.ch2_data[15:0];
			if(`IMEAS_TOP.u_imeas_reg.chmod === 2'b10) begin//group mode
			  if(ch0_cic_out !== ch0_exp_cic_out[21:6])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[3:0], ch0_cic_out, ch0_exp_cic_out[21:6]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[3:0], ch0_cic_out, ch0_exp_cic_out[21:6]),UVM_LOW)
			  if(ch1_cic_out !== ch1_exp_cic_out[21:6])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[7:4], ch1_cic_out, ch1_exp_cic_out[21:6]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[7:4], ch1_cic_out, ch1_exp_cic_out[21:6]),UVM_LOW)
			  if(ch2_cic_out !== ch2_exp_cic_out[21:6])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[11:8],ch2_cic_out, ch2_exp_cic_out[21:6]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[11:8],ch2_cic_out, ch2_exp_cic_out[21:6]),UVM_LOW)
			end
			else begin
			 if(dut_vif.imeas_bio_en === 1) begin
			  ch0_cic_out = dut_vif.ch0_data_max[15:0];
			  if(ch0_cic_out !== exp_cic_out_max_final[21:6])
				`nnc_error("TEST", $sformatf("imeas max_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_max_final[21:6]))
			  else
				`nnc_info("TEST", $sformatf("imeas max_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_max_final[21:6]),UVM_LOW)
			  ch0_cic_out = dut_vif.ch0_data_min[15:0];
			  if(ch0_cic_out !== exp_cic_out_min_final[21:6])
				`nnc_error("TEST", $sformatf("imeas min_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_min_final[21:6]))
			  else
				`nnc_info("TEST", $sformatf("imeas min_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_min_final[21:6]),UVM_LOW)
			  ch0_cic_out = dut_vif.ch0_data_delta[15:0];
			  exp_cic_out_delta = exp_cic_out_max_final[21:6] - exp_cic_out_min_final[21:6];
			  if(ch0_cic_out !== exp_cic_out_delta)
				`nnc_error("TEST", $sformatf("imeas delta_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_delta))
			  else
				`nnc_info("TEST", $sformatf("imeas delta_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_delta),UVM_LOW)
			 end
			 else begin
			  if(ch0_cic_out !== ch0_exp_cic_out[21:6])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, ch0_exp_cic_out[21:6]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, ch0_exp_cic_out[21:6]),UVM_LOW)
			 end
			end
	      	     end
     `IMEAS_CIC_RATE_1024:begin//cic_rate:1024
		     if(imeas_filter0_en === 1)
			ch0_cic_out = dut_vif.ch0_data[15:0];
		     else if(imeas_filter1_en === 1)
			ch0_cic_out = dut_vif.ch1_data[15:0];
			ch1_cic_out = dut_vif.ch1_data[15:0];
			ch2_cic_out = dut_vif.ch2_data[15:0];
			if(`IMEAS_TOP.u_imeas_reg.chmod === 2'b10) begin//group mode
			  if(ch0_cic_out !== ch0_exp_cic_out[24:9])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[3:0], ch0_cic_out, ch0_exp_cic_out[24:9]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[3:0], ch0_cic_out, ch0_exp_cic_out[24:9]),UVM_LOW)
			  if(ch1_cic_out !== ch1_exp_cic_out[24:9])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[7:4], ch1_cic_out, ch1_exp_cic_out[24:9]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[7:4], ch1_cic_out, ch1_exp_cic_out[24:9]),UVM_LOW)
			  if(ch2_cic_out !== ch2_exp_cic_out[24:9])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[11:8],ch2_cic_out, ch2_exp_cic_out[24:9]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[11:8],ch2_cic_out, ch2_exp_cic_out[24:9]),UVM_LOW)
			end
			else begin
			 if(dut_vif.imeas_bio_en === 1) begin
			  ch0_cic_out = dut_vif.ch0_data_max[15:0];
			  if(ch0_cic_out !== exp_cic_out_max_final[24:9])
				`nnc_error("TEST", $sformatf("imeas max_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_max_final[24:9]))
			  else
				`nnc_info("TEST", $sformatf("imeas max_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_max_final[24:9]),UVM_LOW)
			  ch0_cic_out = dut_vif.ch0_data_min[15:0];
			  if(ch0_cic_out !== exp_cic_out_min_final[24:9])
				`nnc_error("TEST", $sformatf("imeas min_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_min_final[24:9]))
			  else
				`nnc_info("TEST", $sformatf("imeas min_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_min_final[24:9]),UVM_LOW)
			  ch0_cic_out = dut_vif.ch0_data_delta[15:0];
			  exp_cic_out_delta = exp_cic_out_max_final[24:9] - exp_cic_out_min_final[24:9];
			  if(ch0_cic_out !== exp_cic_out_delta)
				`nnc_error("TEST", $sformatf("imeas delta_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_delta))
			  else
				`nnc_info("TEST", $sformatf("imeas delta_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_delta),UVM_LOW)
			 end
			 else begin
			  if(ch0_cic_out !== ch0_exp_cic_out[24:9])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, ch0_exp_cic_out[24:9]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, ch0_exp_cic_out[24:9]),UVM_LOW)
			 end
			end
	      	     end
    `IMEAS_CIC_RATE_2048:begin//cic_rate:2048
		     if(imeas_filter0_en === 1)
			ch0_cic_out = dut_vif.ch0_data[15:0];
		     else if(imeas_filter1_en === 1)
			ch0_cic_out = dut_vif.ch1_data[15:0];
			ch1_cic_out = dut_vif.ch1_data[15:0];
			ch2_cic_out = dut_vif.ch2_data[15:0];
			if(`IMEAS_TOP.u_imeas_reg.chmod === 2'b10) begin//group mode
			  if(ch0_cic_out !== ch0_exp_cic_out[27:12])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[3:0], ch0_cic_out, ch0_exp_cic_out[27:12]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[3:0], ch0_cic_out, ch0_exp_cic_out[27:12]),UVM_LOW)
			  if(ch1_cic_out !== ch1_exp_cic_out[27:12])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[7:4], ch1_cic_out, ch1_exp_cic_out[27:12]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[7:4], ch1_cic_out, ch1_exp_cic_out[27:12]),UVM_LOW)
			  if(ch2_cic_out !== ch2_exp_cic_out[27:12])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[11:8],ch2_cic_out, ch2_exp_cic_out[27:12]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", `IMEAS_TOP.active_channel_num[11:8],ch2_cic_out, ch2_exp_cic_out[27:12]),UVM_LOW)
			end
			else begin
			 if(dut_vif.imeas_bio_en === 1) begin
			  ch0_cic_out = dut_vif.ch0_data_max[15:0];
			  if(ch0_cic_out !== exp_cic_out_max_final[27:12])
				`nnc_error("TEST", $sformatf("imeas max_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_max_final[27:12]))
			  else
				`nnc_info("TEST", $sformatf("imeas max_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_max_final[27:12]),UVM_LOW)
			  ch0_cic_out = dut_vif.ch0_data_min[15:0];
			  if(ch0_cic_out !== exp_cic_out_min_final[27:12])
				`nnc_error("TEST", $sformatf("imeas min_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_min_final[27:12]))
			  else
				`nnc_info("TEST", $sformatf("imeas min_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_min_final[27:12]),UVM_LOW)
			  ch0_cic_out = dut_vif.ch0_data_delta[15:0];
			  exp_cic_out_delta = exp_cic_out_max_final[27:12] - exp_cic_out_min_final[27:12];
			  if(ch0_cic_out !== exp_cic_out_delta)
				`nnc_error("TEST", $sformatf("imeas delta_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_delta))
			  else
				`nnc_info("TEST", $sformatf("imeas delta_channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, exp_cic_out_delta),UVM_LOW)
			 end
			 else begin
			  if(ch0_cic_out !== ch0_exp_cic_out[27:12])
				`nnc_error("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, ch0_exp_cic_out[27:12]))
			  else
				`nnc_info("TEST", $sformatf("imeas channel_(%d) data: (0x%x), exp data: (0x%x)", chnum, ch0_cic_out, ch0_exp_cic_out[27:12]),UVM_LOW)
			 end
			end
	      	     end
   endcase
 
  //check alarm feature (only for single mode)
  if(((dut_vif.ch0_data > `IMEAS_TOP.threshold_hi) || (dut_vif.ch0_data < `IMEAS_TOP.threshold_lo)) && (dut_vif.alarm_sts === 1'b0) && (dut_vif.imeas_sb_en === 1'b1)) 
	`nnc_error("SOC_TEST", "[ERROR] imeas alarm interrupt failed!")
  else if((dut_vif.ch0_data < `IMEAS_TOP.threshold_hi) && (dut_vif.ch0_data > `IMEAS_TOP.threshold_lo) && (dut_vif.alarm_sts === 1'b1) && (dut_vif.imeas_sb_en === 1'b1))
	`nnc_error("SOC_TEST", "[ERROR] unexpected imeas alarm interrupt occurred!")
  end
end

// --------------------------------------------------------------------------------
// IMEAS REF MODEL
// --------------------------------------------------------------------------------
test_SINC_3 #(
 .file_adc("../../../verification/models/analog/imeas_analog/stimulus/dB0.dat")
 )
  u_imeas_ch0_refmodel(
	.POR(sdm_adc_rst),
        .ADC_CLK(sdm_adc0_clk),
        .CH_EN(ch_en[0]),
	.OSR(cic_rate),
	.OFFSET(offset),
	.FORMAT(imeas_input_format),
	.IA(exp_cic_out0)
  );

test_SINC_3 #(
 .file_adc("../../../verification/models/analog/imeas_analog/stimulus/dB1.dat")
 )
  u_imeas_ch1_refmodel(
	.POR(sdm_adc_rst),
        .ADC_CLK(sdm_adc1_clk),
	.CH_EN(ch_en[1]),
	.OSR(cic_rate),
	.OFFSET(offset),
	.FORMAT(imeas_input_format),
	.IA(exp_cic_out1)
  );

test_SINC_3 #(
 .file_adc("../../../verification/models/analog/imeas_analog/stimulus/dB2.dat")
 )
  u_imeas_ch2_refmodel(
	.POR(sdm_adc_rst),
        .ADC_CLK(~`ANA_TOP.D2A_SDM_CLK),
	.CH_EN(ch_en[2]),
	.OSR(cic_rate),
	.OFFSET(offset),
	.FORMAT(imeas_input_format),
	.IA(exp_cic_out2)
  );

test_SINC_3 #(
 .file_adc("../../../verification/models/analog/imeas_analog/stimulus/dB3.dat")
 )
  u_imeas_ch3_refmodel(
	.POR(sdm_adc_rst),
        .ADC_CLK(~`ANA_TOP.D2A_SDM_CLK),
	.CH_EN(ch_en[3]),
	.OSR(cic_rate),
	.OFFSET(offset),
	.FORMAT(imeas_input_format),
	.IA(exp_cic_out3)
  );

test_SINC_3 #(
 .file_adc("../../../verification/models/analog/imeas_analog/stimulus/dB4.dat")
 )
  u_imeas_ch4_refmodel(
	.POR(sdm_adc_rst),
        .ADC_CLK(~`ANA_TOP.D2A_SDM_CLK),
	.CH_EN(ch_en[4]),
	.OSR(cic_rate),
	.OFFSET(offset),
	.FORMAT(imeas_input_format),
	.IA(exp_cic_out4)
  );

test_SINC_3 #(
 .file_adc("../../../verification/models/analog/imeas_analog/stimulus/dB5.dat")
 )
  u_imeas_ch5_refmodel(
	.POR(sdm_adc_rst),
        .ADC_CLK(~`ANA_TOP.D2A_SDM_CLK),
	.CH_EN(ch_en[5]),
	.OSR(cic_rate),
	.OFFSET(offset),
	.FORMAT(imeas_input_format),
	.IA(exp_cic_out5)
  );

test_SINC_3 #(
 .file_adc("../../../verification/models/analog/imeas_analog/stimulus/dB6.dat")
 )
  u_imeas_ch6_refmodel(
	.POR(sdm_adc_rst),
        .ADC_CLK(~`ANA_TOP.D2A_SDM_CLK),
	.CH_EN(ch_en[6]),
	.OSR(cic_rate),
	.OFFSET(offset),
	.FORMAT(imeas_input_format),
	.IA(exp_cic_out6)
  );

test_SINC_3 #(
 .file_adc("../../../verification/models/analog/imeas_analog/stimulus/dB7.dat")
 )
  u_imeas_ch7_refmodel(
	.POR(sdm_adc_rst),
        .ADC_CLK(~`ANA_TOP.D2A_SDM_CLK),
	.CH_EN(ch_en[7]),
	.OSR(cic_rate),
	.OFFSET(offset),
	.FORMAT(imeas_input_format),
	.IA(exp_cic_out7)
  );

