/*--------------------------------------------------------------------------------------
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name    : soc_top_tb.sv                                                   
// Project      : Nanochap ENS3                                                         
// Description  : SOC TOP Testbench                                        
// Designer     : ddang@nanochap.com                                                                 
// Date         : 16-10-2023                                                                    
// Revision     : 0.1                                 
--------------------------------------------------------------------------------------*/
//`timescale 1 ns /  1ps

`define  SOC_TB  soc_top_tb
`define  SOC_TOP `SOC_TB.u_Nanochap_BAF4P1
`define  DIG_TOP `SOC_TOP.u_top_dig
`define  ANA_TOP `SOC_TOP.u_top_ana
`define  FLASH_TOP `DIG_TOP.flash_ctrl_top_inst
`define  FIFO_TOP `DIG_TOP.fifo_top
`define  IMEAS_TOP `DIG_TOP.u_imeas
`define  ZMEAS_TOP `DIG_TOP.u_zmeas
`define  ZMEAS_ROM `ZMEAS_TOP.u_zmeas_top.u_zmeas_rom
`define  SPI_TOP `DIG_TOP.spi_top_u
`define  SPI_CTRL `SPI_TOP.spi_slv_ctrl_u
`define  ALWAYSON_TOP `SOC_TOP.top_dig_always_on_inst
`define  RESETN `DIG_TOP.rst_ctrl_inst.presetn
`define  HF_RESETN `DIG_TOP.rst_ctrl_inst.poresetn_hf
`define  ALWAYSON_RST_CTRL `ALWAYSON_TOP.reset_ctrl_always_on_inst
`define  ALWAYSON_RESETN `ALWAYSON_RST_CTRL.poresetn
`define  ALWAYSON_CLK_CTRL `ALWAYSON_TOP.clk_ctrl_always_on_inst
`define  PMU_CTRL_TOP `DIG_TOP.u_pmu
`define  CLK_CTRL_TOP `DIG_TOP.clk_ctrl_inst
`define  RST_CTRL_TOP `DIG_TOP.rst_ctrl_inst 
`define  ALWAYSON_SHADOW_REGS `ALWAYSON_TOP.shadow_regs_always_on_inst
`define  PPG_TOP      `DIG_TOP.u_ppg_controller
`define  FLASH_IP     `FLASH_TOP.u_32k
`define  FLASH_BIST_MASTER_TOP `SOC_TB.u_flash_bist_master
`define  SPIM_VIP `SOC_TB.spim_vip
`define  BIOZ_TOP `DIG_TOP.BioZ

`ifndef POSTLAYOUT_PG 
`define SPI_IF_EXP_DATA  `SPI_TOP.i_fifo_rd_data
`else
`define SPI_IF_EXP_DATA  `SPI_CTRL.i_fifo_rd_data
`endif

`define SPI_SCB_EN top_cfg.spi_cfg.spi_scoreboard_en
`define LEAD_OFF_SCB_EN top_cfg.lead_off_cfg.lead_off_check_en
`define ANALOG_SCOREBOARD_EN     top_cfg.ana_cfg.nnc_analog_scoreboard_en
`define FILTER_POINT_TO_POINT_SB_EN     top_cfg.imeas_filter_cfg.filter_data_check_en
`define FILTER_PEAK_TO_PEAK_SB_EN     top_cfg.imeas_filter_cfg.filter_peak_data_check_en
`define FILTER_OFFSET_SB_EN     top_cfg.imeas_filter_cfg.filter_offset_check_en

`define TOP_ENV_ENABLE
`define POSTSCAN_NETLIST_ROOT "../netlist/prelayout"
`define POSTLAYOUT_NETLIST_ROOT "../netlist/postlayout"

// FIFO SIZE
`define SOC_FIFO_SIZE 128
`define SOC_FIFO_ADDR (`SOC_FIFO_SIZE/16 - 1)

// SPI VIP TASKs
`define WR_NORMAL_REG `SPIM_VIP.spi_wr_single_normal_reg
// `WR_NORMAL_REG(addr, data, pad, ,mask); 

`define RD_NORMAL_REG `SPIM_VIP.spi_rd_single_normal_reg
// `RD_NORMAL_REG(addr, number_of_data, data[]);  

`define WR_BURST_NORMAL_REG `SPIM_VIP.spi_wr_burst_normal_reg
// `WR_BURST_NORMAL_REG(addr, number_of_data, data[]); 

`define RD_BURST_NORMAL_REG `SPIM_VIP.spi_rd_burst_normal_reg
// `RD_BURST_NORMAL_REG(addr, number_of_data, data[]); 

`define WR_RD_CHK_NORMAL_REG `SPIM_VIP.spi_wr_rd_single_normal_reg_chk
// `WR_RD_CHK_NORMAL_REG(addr, data, pad, mask); 

`define RD_RESET_CHK_NORMAL_REG `SPIM_VIP.spi_check_reset_value_normal_reg
// `RD_RESET_CHK_NORMAL_REG(addr, data, pad); 

`define RD_BURST_FIFO_TAG `SPIM_VIP.spi_rd_burst_fifo_tag
// `RD_BURST_NORMAL_REG(number_of_element, data[]);

`define RD_BURST_FIFO_NO_TAG `SPIM_VIP.spi_rd_burst_fifo
// `RD_BURST_NORMAL_REG(number_of_element, data[]);

`define MAX_TRIM_REG_NUM 8'h15  // 21


import uvm_pkg::*;
import soc_top_pkg::*;


module soc_top_tb
#(parameter 
	REDUNDANT_NO = 4  
);
wire [18:0] IOBUF_PAD;
wire [1:0]  TESTMODE;
//SPI
wire                            spi_sck;
wire                            spi_miso;
reg                             spi_mosi;
reg                             spi_nss;

wire                            iopad_resetn;
reg                             ext_resetn;
reg				unlock;

integer                         err_cnt=0;
reg  [1:0]                      test_value = 2'b00;
wire                            RESETb;
wire                            TCK;
wire                            TDO;
wire                            TESTEN;
wire                            TDI;
wire                            SDM_CLK;
wire                            SDM_OUT;
wire                            scan_rst_n;
wire                            scan_clk;
wire                            scan_en;
wire  [3:0]                     scan_in;
wire  [3:0]                     scan_out;
wire                            atpg_en;
wire                            INTB;
wire				VDD_DIG;

wire IOBUF_CPOLn, IOBUF_CPHA;

`include "soc_uvm_tb.sv"

wire [1:0] testmode_conn;
assign testmode_conn[1] = (TESTMODE[1:0] !== 2'b00) ? TESTMODE[1] : (dut_vif.gpio_pd_en[20] === 1'b1) ? 1'bz : TESTMODE[1];
assign testmode_conn[0] = (TESTMODE[1:0] !== 2'b00) ? TESTMODE[0] : (dut_vif.gpio_pd_en[19] === 1'b1) ? 1'bz : TESTMODE[0];

//assign testmode_conn[1] = TESTMODE[1];
//assign testmode_conn[0] = TESTMODE[0];

`ifdef FPGA
wire clk_in1;
Nanochap_BAF4P1 u_Nanochap_BAF4P1
(
	.clk_in1(clk_in1),
        .IOBUF_PAD              (IOBUF_PAD)

);
`else
Nanochap_BAF4P1 u_Nanochap_BAF4P1
(
        .VPP            (1'b1),

        .VDDIO          (1'b1),
        .VSSIO          (1'b0),
        .VDD_DIG_AFSW   (VDD_DIG),
        .VDD_DIG_SW     (VDD_DIG), //VDD_DIG_SW is generated after wake up = 1 and then it is bonded back to VDD_DIG
        .DVDD_1P5_ANA   (1'b1),
        .VDD_DIG_AO     (1'b1),
        .VSS_DIG_SW     (1'b0),
        .VSS_DIG_AO     (1'b0),

	.IOBUF_PAD		 (IOBUF_PAD),
.iopad_testmode0	 (testmode_conn[0]),
	.iopad_testmode1	 (testmode_conn[1]),
	.iopad_resetn            (iopad_resetn)
);
`endif

// --------------------------------------------------------------------------------
// External HF_CLK
//
// --------------------------------------------------------------------------------
`ifdef FPGA
`else
//ext_hfosc u_ext_hfosc (
//  .ext_hfclk(ext_hfclk),
//  .ext_hfclk_sel(dut_vif.ext_clk_en)
//);
`endif


initial
  begin
  ext_resetn = 0;
  #10000;
  ext_resetn = 1;
  end


// ==============================
// ALTF Decoder for SOC
// ==============================
/*
assign gpio3_conn    = spi_nss; // Checked 

assign gpio4_conn    = (dut_vif.altf_gpio_sel === 2'b00) ? spi_sck      : (dut_vif.altf_gpio_sel === 2'b01) ? spi_sck      : (dut_vif.altf_gpio_sel === 2'b10) ? spi_mosi     : (dut_vif.altf_gpio_sel === 2'b11) ? 1'bz         : 1'bx; // Checked
assign gpio5_conn    = (dut_vif.altf_gpio_sel === 2'b00) ? spi_mosi     : (dut_vif.altf_gpio_sel === 2'b01) ? 1'bz         : (dut_vif.altf_gpio_sel === 2'b10) ? 1'bz         : (dut_vif.altf_gpio_sel === 2'b11) ? spi_mosi     : 1'bx; // Checked

assign gpio6_conn    = (dut_vif.altf_gpio_sel === 2'b00) ? 1'bz         : (dut_vif.altf_gpio_sel === 2'b01) ? spi_mosi     : (dut_vif.altf_gpio_sel === 2'b10) ? spi_sck      : (dut_vif.altf_gpio_sel === 2'b11) ? spi_sck      : 1'bx; // Checked

assign spi_miso_conn = (dut_vif.altf_gpio_sel === 2'b00) ? IOBUF_PAD[6] : (dut_vif.altf_gpio_sel === 2'b01) ? IOBUF_PAD[5] : (dut_vif.altf_gpio_sel === 2'b10) ? IOBUF_PAD[5] : (dut_vif.altf_gpio_sel === 2'b11) ? IOBUF_PAD[4] : 1'bx; // Checked
*/
// ==============================
// Connecting to PADs of SOC
// ==============================
assign scan_rst_n = 1'b1;
assign iopad_resetn = (TESTMODE == 2'b11)? 1'bz : (TESTMODE == 2'b10)? RESETb : (TESTMODE == 2'b01)? scan_rst_n : (dut_vif.gpio_pu_en[21] === 1'b1) ? 1'bz : ext_resetn;

assign IOBUF_PAD[12]= (TESTMODE == 2'b11)? 1'bz : (TESTMODE == 2'b10)? 1'bz : (TESTMODE == 2'b01)? scan_in[3]  : 1'bz;
assign IOBUF_PAD[11]= (TESTMODE == 2'b11)? 1'bz : (TESTMODE == 2'b10)? 1'bz : (TESTMODE == 2'b01)? scan_in[2]  : 1'bz;
assign IOBUF_PAD[5] = (TESTMODE == 2'b11)? 1'bz : (TESTMODE == 2'b10)? 1'bz : (TESTMODE == 2'b01)? scan_in[1]  : 1'bz;
assign IOBUF_PAD[4] = (TESTMODE == 2'b11)? 1'bz : (TESTMODE == 2'b10)? 1'bz : (TESTMODE == 2'b01)? scan_in[0]  : 1'bz;
assign IOBUF_PAD[3] = (TESTMODE == 2'b11)? 1'bz : (TESTMODE == 2'b10)? 1'bz : (TESTMODE == 2'b01)? scan_en     : 1'bz;
assign IOBUF_PAD[2] = (TESTMODE == 2'b11)? 1'b0 : (TESTMODE == 2'b10)? TCK  : (TESTMODE == 2'b01)? scan_clk    : spi_sck;
assign IOBUF_PAD[1] = (TESTMODE == 2'b11)? 1'bz : (TESTMODE == 2'b10)? TDI  : (TESTMODE == 2'b01)? 1'bz        : spi_mosi;
assign IOBUF_PAD[0] = (TESTMODE == 2'b11)? 1'bz : (TESTMODE == 2'b10)? 1'bz : (TESTMODE == 2'b01)? 1'bz        : spi_nss;

assign spi_miso     = (TESTMODE == 2'b10)? 1'bz                             : IOBUF_PAD[3];
assign scan_out     = (TESTMODE == 2'b01)? {IOBUF_PAD[14:13], IOBUF_PAD[1:0]} : 4'bz;
assign TDO          = (TESTMODE == 2'b10)? IOBUF_PAD[3]                     : 1'bz;
assign INTB         = (TESTMODE == 2'b00)? IOBUF_PAD[4]                     : 1'bz;
 
// ==============================
// DUMP Command of Simulation
// ==============================
// DON'T CHANGE THE ORDER of checker.sv and testcase.sv (somes varialables are defined to use in advance)
`ifdef FSDB_DUMP
initial begin
	$fsdbDumpvars(0,`SOC_TB);
	$vcdpluson(0);
	$vcdplusmemon(0);
	$vcdplusglitchon(0);
	$vcdplusdeltacycleon();
end
`endif

`ifdef POSTLAYOUT_PG
  `define POSTSCAN
`endif

//switching activity recording for power consumption reports
`ifdef ACT_EN
initial begin
	$set_gate_level_monitoring("on"); 
	$set_toggle_region(soc_top_tb.u_Nanochap_BAF4P1); 
	//#2500000.000; //ns
	//$display ("toggle start");
	//wait(~u_chip_top.u_dig_top_wrapper.u_dig_top.u_ahb_subsystem.u_dflash_hclk.E);//start capturing switching activity after hclks are disabled
	wait(soc_top_tb.u_Nanochap_BAF4P1.u_top_dig.u_imeas.imeas_int_sts);
	$toggle_start(); 
	$display ("toggle start");
	wait(~soc_top_tb.u_Nanochap_BAF4P1.u_top_dig.spi_top_u.i_cs_n);
	$toggle_stop; 
	$display ("toggle end");
	$toggle_report(`SAIF_FILE,1.0e-12,soc_top_tb.u_Nanochap_BAF4P1);
end

final begin
  //$toggle_stop; 
	//$toggle_report(`SAIF_FILE,1.0e-12,soc_top_tb.u_Nanochap_BAF4P1);
	//$display ("toggle end");
end
`endif

// ==============================
// SDF Annotation to GATE SIM
// ==============================
 initial begin

    `ifdef SDFANNOTATE_MIN
	//$display ("------Start sdf_annotate (MIN) --------\n");
        `ifdef POSTSCAN_PG
    	       $sdf_annotate ({`POSTSCAN_NETLIST_ROOT,"/data/synthesis_postscan_pteco_sdf/Nanochap_BAF4P1.postscan_pteco.min_functional.sdfv3"} ,`SOC_TOP, ,"./sdf_annotate_min_postscan.log", "MINIMUM");
        `elsif POSTLAYOUT_PG 
		$sdf_annotate ({`POSTLAYOUT_NETLIST_ROOT,"/data/Nanochap_BAF4P1_func_min.sdf"},`SOC_TOP, , "./sdf_annotate_min_postlayout.log", "MINIMUM");
	`endif

    `elsif SDFANNOTATE_MAX
    	//$display ("------Start sdf_annotate (MAX) --------\n");
	`ifdef POSTSCAN_PG
    		$sdf_annotate ({`POSTSCAN_NETLIST_ROOT,"/data/synthesis_postscan_pteco_sdf/Nanochap_BAF4P1.postscan_pteco.max_functional.sdfv3"} ,`SOC_TOP, ,"./sdf_annotate_max_postscan.log" , "MAXIMUM");
	`elsif POSTLAYOUT_PG
		//$display ("-------Complete sdf_annotate---------\n");
                $sdf_annotate ({`POSTLAYOUT_NETLIST_ROOT,"/data/Nanochap_BAF4P1_func_max.sdf"},`SOC_TOP, , "./sdf_annotate_max_postlayout.log", "MAXIMUM");
 	`endif

    `elsif SDFANNOTATE_TYP
 	//$display ("------Start sdf_annotate (TYP) --------\n");
	`ifdef POSTSCAN_PG
    		$sdf_annotate ({`POSTSCAN_NETLIST_ROOT,"/data/synthesis_postscan_pteco_sdf/Nanochap_BAF4P1.postscan_pteco.typ_functional.sdfv3"} ,`SOC_TOP, ,"./sdf_annotate_typ_postscan.log");
	`elsif POSTLAYOUT_PG
                $sdf_annotate ({`POSTLAYOUT_NETLIST_ROOT,"/data/Nanochap_BAF4P1_func_typ.sdf"},`SOC_TOP, , "./sdf_annotate_typ_postlayout.log");
	`endif
    `endif
 end

// ==============================
// Power of otp
// ==============================
initial begin
`ifndef OTP_ENABLE
`else
   force VDD_DIG = 1'b0;
   #1000ns;
   force VDD_DIG = 1'b1;
`endif
end

initial begin
`ifdef POWER_PINS
//   force `ALWAYSON_RST_CTRL.test_se = 0;
`endif
end

endmodule
