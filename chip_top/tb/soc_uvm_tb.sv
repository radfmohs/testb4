/*--------------------------------------------------------------------------------------*/
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
// --------------------------------------------------------------------------------------
// Project      : Nanochap ENS3
// File name:   : tb_chip_top_uvm.sv
// Description  : UVM TB and Configurations
// Designer     : Daniel Dang
// Date         : 20/11/2023
// Revision     : 0.1
/*--------------------------------------------------------------------------------------*/
import nnc_uvm_pkg::*;
`include "nnc_uvm_methodology.svh"

// ============================
// TB Defines
// ============================
`define SPI_BLOCK_ENABLE
`define SYS_BLOCK_ENABLE
`define FLASH_BLOCK_ENABLE
`define IMEAS_BLOCK_ENABLE
`define BIOZ_BLOCK_ENABLE
`define MONITOR_BLOCK_ENABLE
`define PPG_BLOCK_ENABLE
`define ANA_BLOCK_ENABLE
`define LEAD_OFF_BLOCK_ENABLE

`ifdef SYS_BLOCK_ENABLE
`include "blocks/tb_chip_top_uvm_sys.sv"
`endif

`ifdef SPI_BLOCK_ENABLE
`include "blocks/tb_chip_top_uvm_spi.sv"
`endif

`ifdef FLASH_BLOCK_ENABLE
`include "blocks/tb_chip_top_uvm_flash.sv"
`endif

`ifdef IMEAS_BLOCK_ENABLE
`include "blocks/tb_chip_top_uvm_imeas.sv"
`endif

`ifdef ANA_BLOCK_ENABLE
`include "blocks/tb_chip_top_uvm_ana.sv"
`endif

`ifdef MONITOR_BLOCK_ENABLE
`include "blocks/tb_chip_top_uvm_monitor.sv"
`endif

`ifdef LEAD_OFF_BLOCK_ENABLE
`include "blocks/tb_chip_top_uvm_lead_off.sv"
`endif

`ifdef PPG_BLOCK_ENABLE
`include "blocks/tb_chip_top_uvm_ppg.sv" //temporarily commented
`endif

`ifdef BIOZ_BLOCK_ENABLE
`include "blocks/tb_chip_top_uvm_bioZ.sv"
`endif
// ============================
// Define for SOC project
// ============================
/*
`define EEPROM_SCOREBOARD_EN top_cfg.eeprom_cfg.tsc1_eeprom_scoreboard_en
`define I2CS_SCOREBOARD_EN top_cfg.spi_cfg.tsc1_spi_scoreboard_en
`define TIMER_SCOREBOARD_EN top_cfg.timer_cfg.tsc1_timer_scoreboard_en
`define ANALOG_SCOREBOARD_EN  top_cfg.analog_cfg.tsc1_analog_scoreboard_en
`define AO_TOP_SCOREBOARD_EN  top_cfg.ao_sysc_cfg.tsc1_ao_top_scoreboard_en
*/
`define DUT_IF top_env.top_sqr.dut_if

// =================================
// DUT virtual interface declaration
// =================================
dut_interface      dut_vif();

assign dut_vif.sys_clk = `CLK_CTRL_TOP.pclk;
assign dut_vif.soc_resetn = `RST_CTRL_TOP.presetn;//por_resetn;//iopad_resetn;soc_top_tb.u_Nanochap_ENS3.u_top_dig.u_reset_ctrl.presetn
assign dut_vif.resetn = `RST_CTRL_TOP.presetn;//por_resetn;//iopad_resetn;soc_top_tb.u_Nanochap_ENS3.u_top_dig.u_reset_ctrl.poresetn
assign spi_reg_if.assertion_on = dut_vif.assertion_on;
assign dut_vif.iopad_gpio = `SOC_TB.IOBUF_PAD;

assign `ANA_TOP.A2D_SPARE_TRIM_SW0 = dut_vif.A2D_SPARE_TRIM_SW0;

assign `ANA_TOP.A2D_external_en_I_internal = dut_vif.ext_clk_en;
//assign `ANA_TOP.A2D_external_clock_I_internal = `SOC_TB.ext_hfclk;

// Connecting from DUT Interface to internal OSC and external OSC
`ifndef FPGA
  `ifndef VERILOG_OSC_MODEL
    // Internal clock connection
    assign `ANA_TOP.OSC.hfosc_fixed_gnd_en = dut_vif.hfosc_fixed_gnd_en;
    assign `ANA_TOP.OSC.hfosc_jitter = dut_vif.hfosc_jitter;
    assign `ANA_TOP.OSC.hfosc_variation = dut_vif.hfosc_variation;

    // External clock connections
    // assign `ANA_TOP.u_ext_hfosc.ext_hfosc_fixed_gnd_en = (`ANA_TOP.wakeup == 1'b0) ? 1 : dut_vif.ext_hfosc_fixed_gnd_en;
    assign `ANA_TOP.u_ext_hfosc.ext_hfosc_fixed_gnd_en = dut_vif.ext_hfosc_fixed_gnd_en;
    assign `ANA_TOP.u_ext_hfosc.ext_hfosc_jitter = dut_vif.hfosc_jitter;
    assign `ANA_TOP.u_ext_hfosc.ext_hfosc_variation = dut_vif.hfosc_variation;
    assign `ANA_TOP.u_ext_hfosc.ext_hfosc_sel = dut_vif.ext_clk_sel;
    
    // Assign to control Wakeup from PMU
    assign #1 `ANA_TOP.PMU_SW.wakeup = dut_vif.wake_up_en;
  `endif
`endif

/*
flash_interface         flash_vif();
flash_bist_interface    flash_bist_if();
analog_interface        ana_vif();
register_interface      reg_vif();
*/
// ============================
// Power Pins define
// ============================
/*
`define VBAT `ANA_TOP.VBAT3P3
//`define VSWLDO `ANA_TOP.PMU_SW.ext_sw_power
//`define VPLDO `ANA_TOP.PMU_ALW_ON.ext_ao_power
`define VSWLDO `ANA_TOP.VSWLDO1P8
`define VPLDO `ANA_TOP.VLPLDO1P8
`define VPLDO_EN5V `ANA_TOP.LPLDO_EN5V
*/

initial begin
  //uvm_config_db#(virtual spi_master_if)::set(uvm_root::get(), "uvm_test_top.top_env", "m_spiif", m_spiif);
  //uvm_config_db#(virtual spi_slave_if)::set(uvm_root::get(), "uvm_test_top.top_env", "s_spiif", s_spiif);
  //uvm_config_db#(virtual spi_AO_if)::set(uvm_root::get(), "uvm_test_top.top_env", "a_spiif", a_spiif); 
  //uvm_config_db#(virtual nnc_spi_vip_if)::set(uvm_root::get(), "uvm_test_top.top_env", "top_spi_if", top_spi_if);
  uvm_config_db#(virtual dut_interface)::set(uvm_root::get(), "*", "dut_if" ,dut_vif);
  //uvm_config_db#(virtual tsc1_eeprom_interface)::set(uvm_root::get(),"uvm_test_top.top_env.eeprom_env_i.*", "eeprom_if", eeprom_vif);
  //uvm_config_db#(virtual eeprom_bist_interface)::set(uvm_root::get(), "uvm_test_top.top_env.eeprom_env_i.*", "eeprom_bist_if", eeprom_bist_if);
  //uvm_config_db#(virtual ao_sys_ctrl_interface)::set(uvm_root::get(), "*", "AO_sys_ctrl_if", AO_sys_ctrl_if);
end

initial
  begin
    run_test();
  end

logic timing_enable = 1'b1;
logic timing_enable_1 = 1'b1;

// =================================
// Turn off Timing Check when Sleep
// =================================
`ifdef POSTSCAN_PG
  `define ENABLE_TIMING_CHECK 
`endif

`ifdef POSTLAYOUT_PG
  `define ENABLE_TIMING_CHECK
`endif

`ifdef ENABLE_TIMING_CHECK
always @(`ALWAYSON_TOP.A2D_Wake_UP_i or TESTMODE)
  begin
    if ((`ALWAYSON_TOP.A2D_Wake_UP_i === 1'b0) && ((TESTMODE === 2'b00) || (TESTMODE === 2'b10)) && (timing_enable === 1'b1)) begin
       timing_enable = 1'b0;
       $disable_warnings(`DIG_TOP);
       $display("===========================================================================================");
       $display("===== SOC is entering to LOWPOWER mode now and disable timing check for SW block");
       $display("===========================================================================================");
    end
    else if ((`ALWAYSON_TOP.A2D_Wake_UP_i === 1'b1) && ((TESTMODE === 2'b00) || (TESTMODE === 2'b10)) && (timing_enable === 1'b0)) begin
       $enable_warnings(`DIG_TOP);
       timing_enable = 1'b1;
       $display("===========================================================================================");
       $display("===== SOC is entering to WAKEUP (Active) mode now and enable timing check for SW block");
       $display("===========================================================================================");
    end
  end

//always @(`ANA_TOP.VDD_DIG_AO or TESTMODE)
always @(*)
  begin
    if ((`ANA_TOP.VDD_DIG_AO === 1'b0) && ((TESTMODE === 2'b00) || (TESTMODE === 2'b10)) && (timing_enable_1 === 1'b1)) begin
       timing_enable_1 = 1'b0;
       $disable_warnings(`DIG_TOP);
       $disable_warnings(`ALWAYSON_TOP);
       $display("===========================================================================================");
       $display("===== SOC is entering to VDD_AO=0 and disable timing check for SW + AO blocks");
       $display("===========================================================================================");
    end
    else if ((`ANA_TOP.VDD_DIG_AO === 1'b1) && (`ALWAYSON_TOP.A2D_Wake_UP_i === 1'b1) && ((TESTMODE === 2'b00) || (TESTMODE === 2'b10)) && (timing_enable_1 === 1'b0)) begin
       $enable_warnings(`DIG_TOP);
       $enable_warnings(`ALWAYSON_TOP);
       timing_enable_1 = 1'b1;
       $display("===========================================================================================");
       $display("===== SOC is entering to VDD_AO=1, WAKEUP=1 and enable timing check for SW + AO blocks");
       $display("===========================================================================================");
    end
    else if ((`ANA_TOP.VDD_DIG_AO === 1'b1) && (`ALWAYSON_TOP.A2D_Wake_UP_i === 1'b0) && ((TESTMODE === 2'b00) || (TESTMODE === 2'b10)) && (timing_enable_1 === 1'b0)) begin
       $display("===========================================================================================");
       $display("===== SOC is entering to VDD_AO=1, WAKEUP=0 and disable timing check for SW + AO blocks");
       $display("===========================================================================================");
    end
  end
`endif
