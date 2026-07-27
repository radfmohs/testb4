//RS 8aug: disable analog during scan test mode using mux bypass qualified by
//atpg_en
//Note: this is bit risky because I am already introducing one mux skew
//between what bwd_ctrl/dds_phacc sees and SARADC/ DAC sees ~1.5ns but since
//its only ~1% of clk it should be ok
module zmeas_atpg_bypass (
	input wire atpg_en,
	input wire adc_enable_from_digital,  //1 => SARADC ON, 0=> SARADC off 
	input wire adc_clk_from_digital,     //active => SARADC clock active
	input wire [1:0] config_output_voltage_range_from_dig,
	input wire zmeas_power_en_from_dig,  // not use yet
	output wire adc_enable_to_saradc,    //qualified on atpg_en: 1 => SARADC ON, 0=> SARADC off
	output wire adc_clk_to_analog,       //qualified on atpg_en: active => SARADC clock active
	output wire [1:0] config_output_voltage_range_to_analog,//1 => DAC on,    0=> DAC off
	output wire zmeas_power_en_to_analog //qualified on atpg_en: 1 => DAC on,    0=> DAC off
);

//RS: should I worry about glitch?? maybe not
//: Ref:https://m.eet.com/media/1121681/chapter2_clocks_resets-02.pdf pg26
assign adc_enable_to_saradc     = (atpg_en) ? 1'b0 : adc_enable_from_digital;
assign adc_clk_to_analog        = (atpg_en) ? 1'b0 : adc_clk_from_digital;
assign config_output_voltage_range_to_analog = (atpg_en) ? 2'b00 : config_output_voltage_range_from_dig;
assign zmeas_power_en_to_analog = (atpg_en) ? 1'b0 : zmeas_power_en_from_dig;

endmodule
