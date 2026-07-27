/*--------------------------------------------------------------------------------------*/
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
// --------------------------------------------------------------------------------------
// Project      : Nanochap SOC
// File         : tb_chip_top_uvm_spi.sv
// Description  : SPI TB 
// Designer     : Daniel Dang
// Date         : 29/11/2023
// Revision     : 0.1
/*--------------------------------------------------------------------------------------*/

wire IOBUF_CPOLn, IOBUF_CPHA;

spi_master_vip spim_vip 
(
.spi_rst_n(sys_rst_n),
.spi_clk(sys_clk),
.spi_clk_sel(dut_vif.pclk_sel),
.spi_sclk_freq(dut_vif.spi_sclk_freq),         // unit is Khz (up to 1Mhz)
.spi_clk_jitter(dut_vif.spi_clk_jitter),       // unit is percentage (0-100)
.spi_sclk_jitter(dut_vif.spi_sclk_jitter),     // unit is percentage (0-100)
.tcssc(dut_vif.tcssc),                         // min is 400ns   
.tsccs(dut_vif.tsccs),                         // min is 400ns
.tcsh(dut_vif.tcsh),                           // min is 500ns
.tdist(dut_vif.tdist),                         // unit is percentage (0-100)
.tch(dut_vif.tch),                             // unit is percentage (0-100)
.spi_nss(spi_nss),
.spi_sck(spi_sck),
.spi_mosi(spi_mosi),
.spi_miso(spi_miso),
.spi_mode(dut_vif.spimode_sel),
.spi_cpol(IOBUF_CPOLn),
.spi_cpha(IOBUF_CPHA)
);

/*
/////////////////////register connection///////////////////////////////////////////////
assign      reg_vif.D2ALP_OSC32K_EN   = `DIG_TOP.D2ALP_OSC32K_EN;
assign      reg_vif.D2ALP_OSC300K_EN  = `DIG_TOP.D2ALP_OSC300K_EN;
assign      reg_vif.D2ALP_SWLDO_EN    = `DIG_TOP.D2ALP_SWLDO_EN;
assign      reg_vif.D2ASW_TSC_SIG_clk = `DIG_TOP.D2ASW_TSC_SIG_clk;
assign      reg_vif.D2ASW_EEPROM_VDD2_EN = `DIG_TOP.D2ASW_EEPROM_VDD2_EN;
assign      reg_vif.D2ALP_IREF_EN      = `DIG_TOP.D2ALP_IREF_EN;
assign      reg_vif.D2ALP_BGBUFFER_EN      = `DIG_TOP.D2ALP_BGBUFFER_EN;
assign      reg_vif.A2DLP_OSCOUT32K = `DIG_TOP.A2DLP_OSCOUT32K;
assign      reg_vif.A2DSW_OSCOUT300K = `DIG_TOP.A2DSW_OSCOUT300K;
assign      reg_vif.A2DSW_POR_SWLDO = `DIG_TOP.A2DSW_POR_SWLDO;
assign      reg_vif.A2DLP_POR_LPLDO = `DIG_TOP.A2DLP_POR_LPLDO;
assign      reg_vif.A2DSW_TSC_SDM_OUT = `DIG_TOP.A2DSW_TSC_SDM_OUT;
assign      reg_vif.A2DSW_TSC_SDM_CLK = `DIG_TOP.A2DSW_TSC_SDM_CLK;
assign      reg_vif.VSWLDO1P8 = `ANA_TOP.VSWLDO1P8;
assign      reg_vif.poresetn = Nanochap_SOC_top_tb.SOC.u_top_dig.u_top_dig_always_on.u_shadow_regs_always_on.poresetn;
assign      reg_vif.EEPROM_Reset_Done = Nanochap_SOC_top_tb.SOC.u_top_dig.u_spi_slave_top.u_spi_reg.EEPROM_Reset_Done;

`ifdef BEHAVIORAL
assign      reg_vif.i_rst_n  = `I2CS_TOP.i_rst_n;
assign      reg_vif.o_autorst_dis = `I2CS_REG.o_autorst_dis;
assign      reg_vif.o_timer_reg_write =  `I2CS_REG.o_timer_reg_write;
assign      reg_vif.EEPROM_reload_done = `ALWAYSON_SHADOW_REGS.EEPROM_reload_done;
//assign      reg_vif.EEPROM_Reset_Done = `ALWAYSON_TOP.EEPROM_Reset_Done;
assign      reg_vif.array[0] = {`I2CS_REG.Temp_result[15:0]};
assign      reg_vif.array[1] = {`I2CS_REG.DEVICE_ID[15:0]};
assign      reg_vif.array[2] = {`I2CS_REG.Config_reg[15:13],`I2CS_REG.EEPROM_busy, `I2CS_REG.Config_reg[11:0]};
assign      reg_vif.array[3] = {`I2CS_REG.Thigh_limit_reg[15:0]};
assign      reg_vif.array[4] = {`I2CS_REG.Tlow_limit_reg[15:0]};
assign      reg_vif.array[5] = {`I2CS_REG.EEPROM_UNLock_reg,`I2CS_REG.EEPROM_busy,14'b0};
assign      reg_vif.array[6] = {`I2CS_REG.EEPROM1_reg[15:0]};
assign      reg_vif.array[7] = {`I2CS_REG.EEPROM2_reg[15:0]};
assign      reg_vif.array[8] = {`I2CS_REG.Temp_Offset_reg[15:0]};
assign      reg_vif.array[9] = {`I2CS_REG.Temp_slope_reg[15:0]};
assign      reg_vif.array[10] = {`I2CS_REG.EEPROM3_reg[15:0]};
assign      reg_vif.array[11] = {8'b0,`I2CS_REG.trim_tag_reg[7:0]};
assign      reg_vif.array[12] = {8'b0,`I2CS_REG.temp_sensor_reg_ctrl[7:0]};
assign      reg_vif.array[13] = {8'b0,`I2CS_REG.ana_pmu};
assign      reg_vif.array[14] = {`I2CS_REG.ana_sensor[15:0]};
assign      reg_vif.array[15] = {8'b0,`I2CS_REG.clk_ctrl_reg[7:0]};
assign      reg_vif.array[16] = {`I2CS_REG.EEPROM_debug_reg[15:0]};

assign      reg_vif.array[17] = {12'b0,`I2CS_REG.d2a_osc32k_trim[3:0]};
assign      reg_vif.array[18] = {14'b0,`I2CS_REG.d2a_osc300k_trim[3:0]};
assign      reg_vif.array[19] = {11'b0,`I2CS_REG.d2a_ref_trim[4:0]};
assign      reg_vif.array[20] = {14'b0,`I2CS_REG.d2a_lpldo_trim[1:0]};
assign      reg_vif.array[21] = {14'b0,`I2CS_REG.d2a_swldo_trim[1:0]};
assign      reg_vif.array[22] = {13'b0,`I2CS_REG.d2a_tsc_core_trim[2:0]};
assign      reg_vif.array[23] = {12'b0,`I2CS_REG.d2a_lpbg_trim[3:0]};

assign      reg_vif.array[24] = {15'b0,`I2CS_REG.reg_temp_sensor_int_sts};
assign      reg_vif.array[25] = {`I2CS_REG.reg_temp_sensor_ch0data[15:0]};

assign      reg_vif.array[26] = {11'b0,`I2CS_REG.reg_ctrl};//address =29 ,ADDR_AO_TIMER_CTR
//xin  change
//assign      reg_vif.array[27] = {15'b0,`I2CS_REG.i_timer_int_sts};
assign      reg_vif.array[27] = {16'b0};
//xin change
//assign      reg_vif.array[28] = {14'b0,`I2CS_REG.always_on_spi_digital_wake,`I2CS_REG.timer_onesec_digital_wake_up};
//assign      reg_vif.array[28] = {14'b0,`I2CS_REG.always_on_spi_digital_wake,`I2CS_REG.i_digital_wake_up};
assign      reg_vif.array[29] = {8'b0,`I2CS_REG.por_cnt_sel[7:0]};
assign      reg_vif.array[30] = {8'b0,`I2CS_REG.wakeup_cnt_reg[7:0]};
assign      reg_vif.array[31] = {14'b0,`I2CS_REG.spi_expire_cnt_sel[1:0]};
`endif
*/


nnc_spi_interface       spi_if();
assign spi_if.CS         =  `SOC_TB.spi_nss      ;    
assign spi_if.DIN        =  `SOC_TB.spi_mosi      ;
assign spi_if.DOUT       =  `SOC_TB.spi_miso      ;
assign spi_if.SCLK       =  `SOC_TB.spi_sck     ;
assign spi_if.tclk       =  `CLK_CTRL_TOP.pclk  ;
//assign spi_if.CPOL       =  `SOC_TOP.IOBUF_CPOLn ;
//assign spi_if.CPHA       =  `SOC_TOP.IOBUF_CPHA  ;



nnc_spi_if          spi_mon_if();
nnc_reg_interface   spi_reg_if();


assign spi_mon_if.i_scanclk  = `SPI_TOP.i_scanclk;
assign spi_mon_if.i_rst_n    = `SPI_TOP.spi_reg_u.i_rst_n;
assign spi_mon_if.iopad_cpha = `SOC_TB.IOBUF_CPHA;
assign spi_mon_if.iopad_cpol = `SOC_TB.IOBUF_CPOLn;
//assign spi_mon_if.i_sys_clk  = `SPI_TOP.i_sys_clk;
assign spi_mon_if.i_sclk     = `SOC_TB.spi_sck;
assign spi_mon_if.i_cs_n     = `SOC_TB.spi_nss;
assign spi_mon_if.i_mosi     = `SOC_TB.spi_mosi;
assign spi_mon_if.o_miso     = `SOC_TB.spi_miso;
/*
assign   spi_reg_if.i_clk               =       `SPI_TOP.spi_reg_u.i_clk        ;
assign   spi_reg_if.pmu_reg             =       `SPI_TOP.spi_reg_u.pmu_reg0 ;
assign   spi_reg_if.clk_ctrl_reg        =       `SPI_TOP.spi_reg_u.clk_ctrl_reg;
assign   spi_reg_if.ana_pmu             =       `SPI_TOP.spi_reg_u.ana_pmu ;
assign   spi_reg_if.ana_tsc_0           =       `SPI_TOP.spi_reg_u.ana_tsc_0 ;
assign   spi_reg_if.ana_tsc_1           =       `SPI_TOP.spi_reg_u.ana_tsc_1 ;
assign   spi_reg_if.ana_bist            =       `SPI_TOP.spi_reg_u.ana_bist ;
assign   spi_reg_if.ana_dda             =       `SPI_TOP.spi_reg_u.ana_dda ;
assign   spi_reg_if.ana_pga             =       `SPI_TOP.spi_reg_u.ana_pga ;
assign   spi_reg_if.ana_ele             =       `SPI_TOP.spi_reg_u.ana_ele ;
assign   spi_reg_if.ana_sdm             =       `SPI_TOP.spi_reg_u.ana_sdm ;
assign   spi_reg_if.flash_debug1        =       `SPI_TOP.spi_reg_u.DEBUG_FLASH_sync[7:0];
assign   spi_reg_if.flash_debug2        =       `SPI_TOP.spi_reg_u.DEBUG_FLASH_sync[15:8];
assign   spi_reg_if.flash_trim0         =       `SPI_TOP.spi_reg_u.trim_tag_reg[7:0];
assign   spi_reg_if.flash_trim1         =       `SPI_TOP.spi_reg_u.d2a_trim1_to_otp[7:0];   
assign   spi_reg_if.flash_trim2         =       `SPI_TOP.spi_reg_u.d2a_trim2_to_otp[7:0];   
assign   spi_reg_if.flash_trim3         =       `SPI_TOP.spi_reg_u.d2a_trim3_to_otp[7:0];   
assign   spi_reg_if.flash_trim4         =       `SPI_TOP.spi_reg_u.d2a_trim4_to_otp[7:0];   
assign   spi_reg_if.flash_trim5         =       `SPI_TOP.spi_reg_u.d2a_trim5_to_otp[7:0];   
assign   spi_reg_if.flash_trim6         =       `SPI_TOP.spi_reg_u.d2a_trim6_to_otp[7:0];   
assign   spi_reg_if.flash_unlock           =   {7'b0,`SPI_TOP.spi_reg_u.otp_unlock};
assign   spi_reg_if.SOC_EEPROM_ALT_FUN_REG =   {6'b0, `SPI_TOP.spi_reg_u.alt_fun_reg};    
//assign   spi_reg_if.SOC_GPIO_0_CTRL_REG  =   {2'b0,`SPI_TOP.spi_reg_u.gpio_0_ctrl};	  
//assign   spi_reg_if.SOC_GPIO_1_CTRL_REG  =   {2'b0,`SPI_TOP.spi_reg_u.gpio_1_ctrl};
//assign   spi_reg_if.SOC_GPIO_2_CTRL_REG  =   {2'b0,`SPI_TOP.spi_reg_u.gpio_2_ctrl};         
//assign   spi_reg_if.SOC_GPIO_3_CTRL_REG  =   {2'b0,`SPI_TOP.spi_reg_u.gpio_3_ctrl};
//assign   spi_reg_if.SOC_GPIO_4_CTRL_REG  =   {2'b0,`SPI_TOP.spi_reg_u.gpio_4_ctrl};
//assign   spi_reg_if.SOC_GPIO_5_CTRL_REG  =   {2'b0,`SPI_TOP.spi_reg_u.gpio_5_ctrl};
//assign   spi_reg_if.SOC_GPIO_6_CTRL_REG  =   {2'b0,`SPI_TOP.spi_reg_u.gpio_6_ctrl};         
//assign   spi_reg_if.SOC_GPIO_7_CTRL_REG  =   {2'b0,`SPI_TOP.spi_reg_u.gpio_7_ctrl};
//assign   spi_reg_if.SOC_GPIO_8_CTRL_REG  =   {1'b0,`SPI_TOP.spi_reg_u.gpio_8_ctrl}; 
//assign   spi_reg_if.SOC_GPIO_9_CTRL_REG  =   {1'b0,`SPI_TOP.spi_reg_u.gpio_9_ctrl};
//assign   spi_reg_if.SOC_GPIO_10_CTRL_REG =   {1'b0,`SPI_TOP.spi_reg_u.gpio_10_ctrl};         
//assign   spi_reg_if.SOC_GPIO_11_CTRL_REG =   {1'b0,`SPI_TOP.spi_reg_u.gpio_11_ctrl};
//assign   spi_reg_if.SOC_GPIO_12_CTRL_REG =   {1'b0,`SPI_TOP.spi_reg_u.gpio_12_ctrl};
//assign   spi_reg_if.SOC_GPIO_13_CTRL_REG =   {1'b0,`SPI_TOP.spi_reg_u.gpio_13_ctrl};
//assign   spi_reg_if.SOC_GPIO_14_CTRL_REG =   {1'b0,`SPI_TOP.spi_reg_u.gpio_14_ctrl};         
//assign   spi_reg_if.SOC_GPIO_15_CTRL_REG =   {1'b0,`SPI_TOP.spi_reg_u.gpio_15_ctrl};

assign   spi_reg_if.GPIO_DS_CTRL           =   {7'b0, `SPI_TOP.spi_reg_u.ds_ctrl};		    
assign   spi_reg_if.GPIO_PD_CTRL           =   {`SPI_TOP.spi_reg_u.pd_ctrl};              
//assign   spi_reg_if.GPIO_SR_PDRV0_1_CTRL   =   {5'b0, `SPI_TOP.spi_reg_u.sr_pdrv0_1_ctrl};
assign   spi_reg_if.SOC_COMP0_CTRL_REG     =   `SPI_TOP.spi_reg_u.comp0_ctrl_reg;
assign   spi_reg_if.SOC_COMP1_CTRL_REG     =   {`SPI_TOP.spi_reg_u.comp1_out,`SPI_TOP.spi_reg_u.comp1_ctrl_reg};
assign   spi_reg_if.SOC_PGA_CTRL0_REG      =   {1'b0,`SPI_TOP.spi_reg_u.pga_ctrl0_reg};
assign   spi_reg_if.SOC_PGA_CTRL1_REG      =   {2'b00,`SPI_TOP.spi_reg_u.pga_ctrl1_reg};
assign   spi_reg_if.SOC_CHARGE_CTRL0_REG   =   {1'b0,`SPI_TOP.spi_reg_u.charger_end, `SPI_TOP.spi_reg_u.charger_ok, `SPI_TOP.spi_reg_u.charge_ctrl0_reg[4:0]};
assign   spi_reg_if.SOC_CHARGE_CTRL1_REG   =   {5'b00000, `SPI_TOP.spi_reg_u.charge_ctrl1_reg};
assign   spi_reg_if.SOC_PMU_CTRL_REG       =   {`SPI_TOP.spi_reg_u.temp_150c_trig, `SPI_TOP.spi_reg_u.lvd_out, `SPI_TOP.spi_reg_u.pmu_ctrl_reg};
assign   spi_reg_if.SOC_BOOST_CTRL0_REG    =   {`SPI_TOP.spi_reg_u.boost_oc, `SPI_TOP.spi_reg_u.boost_ctrl0_reg[6:4], 1'b0, `SPI_TOP.spi_reg_u.boost_ctrl0_reg[2:0]};
assign   spi_reg_if.SOC_BOOST_CTRL1_REG    =   {`SPI_TOP.spi_reg_u.boost_ot, `SPI_TOP.spi_reg_u.boost_ctrl1_reg[6:4], `SPI_TOP.spi_reg_u.boost_ov, `SPI_TOP.spi_reg_u.boost_ctrl1_reg[2:0]};
assign   spi_reg_if.SOC_BOOST_CTRL2_REG    =   `SPI_TOP.spi_reg_u.boost_ctrl2_reg;
assign   spi_reg_if.SOC_ANA_BIST0_REG      =   {4'b0, `SPI_TOP.spi_reg_u.ana_bist0_reg[3:0]};
assign   spi_reg_if.SOC_ANA_BIST1_REG      =   `SPI_TOP.spi_reg_u.ana_bist1_reg;
assign   spi_reg_if.SOC_COMP0_OUT_REG      =   {7'b0000000, `SPI_TOP.spi_reg_u.comp0_out}; 
assign   spi_reg_if.SOC_LEAD_OFF_CTRL_REG  =   `SPI_TOP.spi_reg_u.lead_off_ctrl 	; 
assign   spi_reg_if.SOC_LEAD_OFF_THR_H_REG =   `SPI_TOP.spi_reg_u.led_off_th_h 	; 
assign   spi_reg_if.SOC_LEAD_OFF_THR_L_REG      =   `SPI_TOP.spi_reg_u.led_off_th_l 	; 
assign   spi_reg_if.SOC_LEAD_OFF_DLY_TGT_0_REG  =   `SPI_TOP.spi_reg_u.measure_dly_tgt_0 	; 
assign   spi_reg_if.SOC_LEAD_OFF_DLY_TGT_1_REG  =   `SPI_TOP.spi_reg_u.measure_dly_tgt_1 	; 
assign   spi_reg_if.SOC_LEAD_OFF_DLY_TGT_2_REG  =   `SPI_TOP.spi_reg_u.measure_dly_tgt_2 	; 
assign   spi_reg_if.SOC_LEAD_OFF_DLY_TGT_3_REG  =   `SPI_TOP.spi_reg_u.measure_dly_tgt_3 	; 
assign   spi_reg_if.SOC_LEAD_OFF_TGT_REG        =   `SPI_TOP.spi_reg_u.lead_off_tgt_reg 	; 
assign   spi_reg_if.SOC_LEAD_OFF_INT_REG        =   {`SPI_TOP.spi_reg_u.lead_off_int[7:1], `SPI_TOP.spi_reg_u.lead_off_result}; 
assign   spi_reg_if.SOC_LEAD_OFF_ANA_REG        =   {6'b0, `SPI_TOP.spi_reg_u.A2D_COMP1, `SPI_TOP.spi_reg_u.A2D_COMP0}; 
assign   spi_reg_if.SOC_D2A_SPARE_WR_REG0       =   `SPI_TOP.spi_reg_u.d2a_spare_wr_reg0 ;  
assign   spi_reg_if.SOC_D2A_SPARE_WR_REG1       =   `SPI_TOP.spi_reg_u.d2a_spare_wr_reg1 ; 
assign   spi_reg_if.SOC_A2D_SPARE_RO_REG0       =   `SPI_TOP.spi_reg_u.A2D_SPARE_RO_REG0 ;  
assign   spi_reg_if.SOC_A2D_SPARE_RO_REG1       =   `SPI_TOP.spi_reg_u.A2D_SPARE_RO_REG1 ;                                                   
                                    
*/
                                                                                                                                              

initial begin
    nnc_config_db#(virtual nnc_reg_interface)::set(uvm_root::get(), "uvm_test_top.top_env", "spi_reg_if", spi_reg_if);
    nnc_config_db#(virtual nnc_spi_interface)::set(uvm_root::get(), "uvm_test_top.top_env.spi_env_i", "spi_if", spi_if);
    nnc_config_db#(virtual nnc_spi_if)::set(uvm_root::get(), "uvm_test_top.top_env", "spi_mon_if", spi_mon_if);

    nnc_config_db#(virtual nnc_spi_if)::set(uvm_root::get(), "uvm_test_top.top_env.spi_fifo_mon", "spi_mon_if", spi_mon_if);
end

