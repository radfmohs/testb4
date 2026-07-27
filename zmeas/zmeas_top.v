////////
// Design     	: top_z_module
// Project      : glucose_chip
// Dependencies	: 
//              : 
// Description	: top module :  dds_ph_acc + bwdctrl + romctrl + reg_ctrl.
//              :               reg_ctrl NEEDS TO BE ALWAYS ON POWER
//              :      Input : freq (27bit) at which Z (impedance) is to be calculated, from
//              :	     : firmware (or MCU) / apb interface; data from
//              :            : saradc
// 		:      Output: 16bit real register and 16bit imaginary
// 		             : register to apb; ctrl singnals to saradc
// Testbech   	: 
// Rev       	: 1.0 : 17april2019
//              : 4.0 : 28may2019
//              : 6.0 : 8 aug: atpg bypass module to switch off analog during scan test
//              :              register_memory_map_6thdraft.ods
//              : 7.0 : 21aug: bist bypass, debug signals , memory_map_compact1_v08.ods
//              : 8.0 : 20sep: added handcoded dnt_dbg for debug signals
// Company    	: Nanochap
// Author     	: RS
////////
`include "zmeas_parameters.vh"

module zmeas_top 
(
   //clk and reset
   input mclk, 
   input pclk, 
   //input mclk_fast, 
   input nrst,
   //input from saradc
   input adc_eoc,
   input [9:0] adc_in,
   //input from f/w through apb interface
   input [2:0] reg_freq_val, 
   //input [26:0] phase_in, 
   input [15:0] reg_ctrl,
   input [7:0] reg_settling_time_val,
   input [3:0] reg_number_of_repeat_cycle_val,
   // inputs from testmode logic
   input atpg_en,
   input scan_en,  //Tri add
   input phase_dither_en,
   //output to saradc
   output wire adc_enable,
   output adc_sample,
   output adc_clk,
   //output to analog 
   output measure_calibrate,
   output [1:0] config_output_voltage_range,
   output pga_gain,
   output zmeas_power_en,
   output wire [9:0] rom_data_out, 
   output wire [`DDS_PHACC_BITS-1-12:0] addrs_in_fwd,
   //output to f/w thr apb
   output adc_eoc_level,
   output [15:0] reg_status,
   output [31:0] reg_dataout, 
   output wire [9:0] sine_for_dft,
   output wire [9:0] cosine_for_dft,
   output wire [11:0] dft_cnt,
   output wire [28:0] summation_offset_forreal,
   output wire [28:0] summation_real,
   output wire [28:0] summation_imag,
   output wire signed [16:0] shiftedreal_inter,
   output wire [9:0] xn_data,
   output dds_enable
);

wire [15:0] reg_real_data_val; 
wire [15:0] reg_imag_data_val;

//wires
wire mclkg;
wire mclkg_invert;
wire [8:0] number_of_repeats_decoded;
wire freq_meas_done;
wire rom_cen_fwd;
wire rom_cen_bwd;  
wire [`PHJMP_BITS-1:0]	freq_phjmp_reg;
wire [`PH_JMPDFT_BITS-1:0] freq_phjmpdft_reg;

wire [11:0] phase_dither_num;
wire [`DDS_PHACC_BITS-1:0] addrs_in_fwd_tmp;	
wire [`DDS_PHACC_BITS-1:0] phacc;
reg  [`DDS_PHACC_BITS-1:0] phase_dither_num_shift;
wire [`SINROMDFT_ADDRS_WIDTH -1 :0] addrs_in_bwd; 
wire [9:0] rom_data_out_bwdctrl;

wire adc_enable_fromdig;
wire adc_clk_from_dig;
wire zmeas_power_en_from_dig;
wire [1:0] config_output_voltage_range_from_dig;
wire  phase_dither_en_d, phase_dither_en_d2;

////////////////////////////////////////////

//instantiate zmeas_ctrl module which decodes f/w loaded values from reg memory and
//sends it to ph acc, zmeas_rom and zmeas_bwdctrl

zmeas_ctrl u_zmeas_ctrl (
   //clk and reset
   .mclk(mclk), 
   .pclk(pclk), 
   .mclkg(mclkg), 
   .mclkg_invert(mclkg_invert), 
   .nrst(nrst), 
   .atpg_en(atpg_en),
   .scan_en(scan_en),  //Tri add
   //input from f/w through apb interface
   .reg_freq_val(reg_freq_val),
   .reg_ctrl(reg_ctrl),
   .reg_number_of_repeat_cycle_val(reg_number_of_repeat_cycle_val),
   .reg_settling_time_val(reg_settling_time_val),
   //input from zmeas_bwdctrl and ph_acc
   .freq_meas_done(freq_meas_done),
   .reg_real_data_val(reg_real_data_val),
   .reg_imag_data_val(reg_imag_data_val),
   //output to zmeas_rom(), zmeas_bwdctrl and ph_acc
   .adc_enable(adc_enable_fromdig),
   .adc_clk(adc_clk_from_dig),
   .dds_enable(dds_enable),
   .number_of_repeats_decoded(number_of_repeats_decoded),
   .freq_phjmp_reg(freq_phjmp_reg),
   .freq_phjmpdft_reg(freq_phjmpdft_reg),
   .reg_status(reg_status),
   .measure_calibrate(measure_calibrate),
   .config_output_voltage_range(config_output_voltage_range_from_dig),
   .reg_dataout(reg_dataout),
   .pga_gain(pga_gain),
   //.reg_settling_time_val_init(reg_settling_time_val_init),
   .zmeas_power_en(zmeas_power_en_from_dig)
);

zmeas_atpg_bypass u_zmeas_atpg_bypass (                    //8aug: so that analog is off during atpg(scan test) mode
   .atpg_en(atpg_en),
   .adc_enable_from_digital(adc_enable_fromdig),
   .adc_enable_to_saradc(adc_enable),
   .adc_clk_from_digital(adc_clk_from_dig),
   .adc_clk_to_analog(adc_clk),
   .config_output_voltage_range_from_dig(config_output_voltage_range_from_dig),
   .config_output_voltage_range_to_analog(config_output_voltage_range),
   .zmeas_power_en_from_dig(zmeas_power_en_from_dig),
   .zmeas_power_en_to_analog(zmeas_power_en)
);
	
//instantiate phase accumulator module
dds_phacc u_zmeas_phase_accumulator (
   //clk and reset inputs
   .presetn(nrst), .mclk(mclkg),
   //inputs from f/w thr apb
   .freq_phjmp(freq_phjmp_reg),
   //inputs from zmeas
   .dds_en(dds_enable),
   //output
   .dds_phase_add(addrs_in_fwd_tmp)
);

common_sync_bit u_common_sync_bit
(
  .clk(mclkg),
  .rst_(nrst),
  .async_in(phase_dither_en),
  .sync_out(phase_dither_en_d2)
);


lfsr_12bit u_lfsr_12bit
(
  .clk(mclkg),
  .resetn(nrst),
  .phase_dither_en(phase_dither_en_d2),
  .lfsr_out(phase_dither_num)
);

always@(*)
  case(reg_freq_val)
    `FREQ_SEL_500HZ: phase_dither_num_shift = {9'b000000000, phase_dither_num}; 
    `FREQ_SEL_1KHZ : phase_dither_num_shift = {8'b00000000,  phase_dither_num, 1'b0};
    `FREQ_SEL_2KHZ : phase_dither_num_shift = {7'b0000000,   phase_dither_num, 2'b00};
    `FREQ_SEL_4KHZ : phase_dither_num_shift = {6'b000000,    phase_dither_num, 3'b000};
    default:         phase_dither_num_shift = {9'b000000000, phase_dither_num};
  endcase 

assign phacc = phase_dither_en_d2 ? addrs_in_fwd_tmp + phase_dither_num_shift : addrs_in_fwd_tmp;
assign addrs_in_fwd = phacc[`DDS_PHACC_BITS-1:12];

//instantiate bwd DFT calculation module
zmeas_bwdctrl u_zmeas_bwdctrl (
   //clk and reset inputs
   .mclk(mclkg), .nrst(nrst), 
   .mclk_invert(mclkg_invert), 
   //inputs from f/w thr apb and zmeas_ctrl
   //.reg_settling_time_val(reg_settling_time_val_init), 
   .number_of_repeats_decoded(number_of_repeats_decoded), 
   .freq_phjmpdft_reg(freq_phjmpdft_reg),
   //xin change 27 Jun 2024 because we don't use adc in this version
   //.adc_enable(adc_enable_fromdig),
   .adc_enable(1'b0),
   //inputs from analog ac impedance measurement
   .adc_in(adc_in),  .adc_eoc(adc_eoc),  
   //inputs from zmeas_rom
   .sinrom(rom_data_out_bwdctrl),  
   //outputs
   .adc_eoc_level(adc_eoc_level),
   .shiftedreal(reg_real_data_val), 
   .shiftedimag(reg_imag_data_val), 
   .freq_meas_done(freq_meas_done),
   .adc_sample(adc_sample), 
   .addrs_in_bwd(addrs_in_bwd), 
   .rom_cen(rom_cen_bwd),
   .dft_cnt(dft_cnt),
   .sine_for_dft(sine_for_dft),
   .cosine_for_dft(cosine_for_dft),
   .summation_offset_forreal(summation_offset_forreal),
   .summation_real(summation_real),
   .summation_imag(summation_imag),
   .shiftedreal_inter(shiftedreal_inter),
   .xn_data(xn_data)
);

//instantiate rom ctrl module
zmeas_rom u_zmeas_rom (
   //inputs 
   .romclk(mclkg), 
   .nrst(nrst), 
   .addrs_in_fwd(addrs_in_fwd),
   .addrs_in_bwd(addrs_in_bwd),	
   //output 
   .rom_data_out_dac(rom_data_out),
   .rom_data_out_bwdctrl(rom_data_out_bwdctrl)
);

endmodule
