/*--------------------------------------------------------------------------------------*/
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
// --------------------------------------------------------------------------------------
// Project      : Nanochap ENS3
// File         : tb_chip_top_uvm_zmeas.sv
// Description  : ZMEAS TB 
// Designer     : Ophina C
// Date         : 22/11/2023
// Revision     : 0.1
/*--------------------------------------------------------------------------------------*/

//---------------------------- ZMEAS -------------------------------------------
`define  ZMEAS_REG_NUMBER_OF_REPEAT_CYCLE_VAL_2      1
`define  ZMEAS_REG_NUMBER_OF_REPEAT_CYCLE_VAL_4      2
`define  ZMEAS_REG_NUMBER_OF_REPEAT_CYCLE_VAL_8      3
`define  ZMEAS_REG_NUMBER_OF_REPEAT_CYCLE_VAL_16     4
`define  ZMEAS_REG_NUMBER_OF_REPEAT_CYCLE_VAL_32     5
`define  ZMEAS_REG_NUMBER_OF_REPEAT_CYCLE_VAL_64     6
`define  ZMEAS_REG_NUMBER_OF_REPEAT_CYCLE_VAL_128    7
`define  ZMEAS_REG_NUMBER_OF_REPEAT_CYCLE_VAL_256    8
`define  ZMEAS_REG_FREQ_VAL_500HZ	 	     1
`define  ZMEAS_REG_FREQ_VAL_1KHZ        	     2
`define  ZMEAS_REG_FREQ_VAL_2KHZ        	     3
`define  ZMEAS_REG_FREQ_VAL_4KHZ        	     4
`define  ZMEAS_REG_NO_FREQVAL        		     0
`define  ZMEAS_NOOP			    	     0
`define  ZMEAS_INIT			             1
`define  ZMEAS_CALC  		                     3
`define  ZMEAS_POWER_DOWN		             2
`define  ZMEAS_STANDBY		                     6

nnc_zmeas_freq_interface       zmeas_mon_if();

// Changing clocks
assign `ANA_TOP.u_zmeas_analog.zmeas_freq_sel = dut_vif.zmeas_freq_sel;

assign zmeas_mon_if.mclk = `DIG_TOP.zmeas_mclk;
assign zmeas_mon_if.pclk = `DIG_TOP.zmeas_pclk;
assign zmeas_mon_if.rom_data_out = `DIG_TOP.D2A_SW_Z_DDS;
assign zmeas_mon_if.d2a_ecgcal_vsel_trim = `ANA_TOP.D2A_ECGCAL_VSEL_TRIM;
assign zmeas_mon_if.d2a_sw_z_clk256K = `ANA_TOP.D2A_SW_Z_CLK256K;
assign zmeas_mon_if.data_type_wave_sel_dut = `DIG_TOP.data_type_sel;
`ifdef BEHAVIORAL 
  assign zmeas_mon_if.dds_en = `ZMEAS_TOP.dds_enable;
  assign zmeas_mon_if.dds = `ZMEAS_TOP.DDS;
  assign zmeas_mon_if.addrs_in_fwd = `ZMEAS_TOP.addrs_in_fwd;
`else
  assign zmeas_mon_if.dds_en = `ZMEAS_TOP.reg_status[3];
  assign zmeas_mon_if.dds = `ZMEAS_ROM.rom_data_out_dac;
  assign zmeas_mon_if.addrs_in_fwd = `ZMEAS_ROM.addrs_in_fwd;
`endif

assign zmeas_mon_if.freq_val = dut_vif.zmeas_freq_val;
assign zmeas_mon_if.zmeas_dds_wave_sel = dut_vif.zmeas_dds_wave_sel;
assign zmeas_mon_if.dc_data_val = dut_vif.dc_data_val;
assign zmeas_mon_if.sq_data_lval= dut_vif.sq_data_lval;
assign zmeas_mon_if.sq_data_hval= dut_vif.sq_data_hval;
assign zmeas_mon_if.sq_wave_div= dut_vif.sq_wave_div;
assign zmeas_mon_if.zmeas_sq_ref_clk= `CLK_CTRL_TOP.m1k_reg_atpg ; 

assign zmeas_mon_if.shr_man_en= dut_vif.shr_man_en;
assign zmeas_mon_if.shr_man_val= dut_vif.shr_man_val;

initial begin
    nnc_config_db#(virtual nnc_zmeas_freq_interface)::set(uvm_root::get(), "uvm_test_top.top_env", "zmeas_mon_if", zmeas_mon_if);
end


