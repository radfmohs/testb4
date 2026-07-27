/*--------------------------------------------------------------------------------------*/
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
// --------------------------------------------------------------------------------------
// Project      : Nanochap ENS3
// File         : tb_chip_top_uvm_sys.sv
// Description  : SYSTEM CLOCK TB (included file) 
// Designer     : Daniel Dang
// Date         : 22/11/2023
// Revision     : 0.1
/*--------------------------------------------------------------------------------------*/

parameter SYS_CLK_PERIOD_2MHZ=500;   //2 MHZ

reg sys_clk;
reg sys_rst_n;

wire BAF4P1_CLK;
assign BAF4P1_CLK = (`ANA_TOP.A2D_external_en_I === 1) ? `ANA_TOP.u_ext_hfosc.ext_hfosc_q : `ANA_TOP.A2D_OSC_OUT_bak;

initial
 begin
  sys_clk=1'b0;
  forever 
    #(SYS_CLK_PERIOD_2MHZ/2*(2**dut_vif.pclk_sel))  sys_clk = ~sys_clk;
    /*
    begin 
    case(dut_vif.pclk_sel)
      2'b00: #(SYS_CLK_PERIOD_2MHZ/2)  sys_clk = ~sys_clk;
      2'b01: #(SYS_CLK_PERIOD_2MHZ/4)  sys_clk = ~sys_clk; 
      2'b10: #(SYS_CLK_PERIOD_2MHZ/8)  sys_clk = ~sys_clk; 
      2'b11: #(SYS_CLK_PERIOD_2MHZ/16) sys_clk = ~sys_clk;
    endcase
    end//2mhz
    */
 end

initial
  begin
    sys_rst_n = 1'b0;
    #10000;
    sys_rst_n = 1'b1;
    forever begin 
      @(dut_vif.soc_resetn); 
      if (dut_vif.soc_resetn === 0) sys_rst_n = 1'b0;
      else if (dut_vif.soc_resetn === 1) #10 sys_rst_n = 1'b1;
      else if (TESTMODE === 2'b00 && `ANA_TOP.A2D_Wake_UP_i && `ANA_TOP.VDD_DIG_SW && (dut_vif.soc_resetn === 1'bx))
        `nnc_error("SOC", $sformatf("dut_vif.soc_resetn reset is: %h as unexpected", dut_vif.soc_resetn));
    end
  end


////////////////////clk signals connection//////////////////////////
nnc_clk_interface           clk_if();

assign clk_if.ext_clk_en      =    `ANA_TOP.A2D_external_en_I ;
assign clk_if.pclk            =    `CLK_CTRL_TOP.pclk     ;
assign clk_if.imeas_dig_adc_clk =    `CLK_CTRL_TOP.imeas_dig_adc_clk;      
assign clk_if.imeas_adc_clk     =    `CLK_CTRL_TOP.imeas_adc_clk;
assign clk_if.zmeas_mclk      =    `CLK_CTRL_TOP.zmeas_mclk ; 
assign clk_if.zmeas_pclk      =    `CLK_CTRL_TOP.zmeas_pclk ;
assign clk_if.imeas_pclk      =    `CLK_CTRL_TOP.imeas_pclk ;
assign clk_if.SDM_CLK_GPIO    =    IOBUF_PAD[12];
assign clk_if.check_pclk      =    `CLK_CTRL_TOP.check_pulse_pclk;
assign clk_if.m1k_reg_atpg    =    `CLK_CTRL_TOP.m1k_reg_atpg;
assign clk_if.RLD_CLK         =    `ANA_TOP.D2A_RLD_CLK64K;  //input to analog
assign clk_if.D2A_ACLEADOFF_CLK =  `ANA_TOP.D2A_ACLEADOFF_CLK ;


initial begin
    nnc_config_db#(virtual nnc_clk_interface)::set(uvm_root::get(), "uvm_test_top.top_env.sysc_env.*", "clk_if", clk_if);
end


`define  SYS_CTRL_CFG           top_cfg.sysc_cfg
`define  CLKDIV_CHECK_EN        `SYS_CTRL_CFG.clkdiv_check_en 


////////////////////ao_top signals connection//////////////////////////

nnc_ao_top_interface        ao_if();


assign  ao_if.VDD_DIG_AO                 =    `ANA_TOP.VDD_DIG_AO                ; 
//assign  ao_if.AVDD_PMU                   =                    ;
assign  ao_if.iopad_testen               =    TESTMODE===2'b00 ? 0 : 1          ;
assign  ao_if.o_iopad_testmode0_en_y     =    `ALWAYSON_TOP.o_iopad_testmode0_en_y             ;
assign  ao_if.o_iopad_testmode1_en_y     =    `ALWAYSON_TOP.o_iopad_testmode1_en_y             ;
assign  ao_if.o_iopad_resetn_y           =    `ALWAYSON_TOP.o_iopad_resetn_y                   ;
assign  ao_if.o_IOBUF_IE                 =    `ALWAYSON_TOP.o_IOBUF_IE                         ;
assign  ao_if.o_IOBUF_CS                 =    `ALWAYSON_TOP.o_IOBUF_CS                         ;
assign  ao_if.o_IOBUF_PU                 =    `ALWAYSON_TOP.o_IOBUF_PU                         ;
assign  ao_if.o_IOBUF_SR                 =    `ALWAYSON_TOP.o_IOBUF_SR                         ;
assign  ao_if.o_IOBUF_DR                 =    `ALWAYSON_TOP.o_IOBUF_DR                         ;
assign  ao_if.o_IOBUF_A                  =    `ALWAYSON_TOP.o_IOBUF_A                          ;
assign  ao_if.o_IOBUF_OE                 =    `ALWAYSON_TOP.o_IOBUF_OE                         ;
assign  ao_if.o_IOBUF_OS                 =    `ALWAYSON_TOP.o_IOBUF_OS                         ;
assign  ao_if.o_IOBUF_OD                 =    `ALWAYSON_TOP.o_IOBUF_OD                         ;
assign  ao_if.o_IOBUF_PD                 =    `ALWAYSON_TOP.o_IOBUF_PD                         ;
assign  ao_if.o_IOBUF_IE_testmode0       =    `ALWAYSON_TOP.o_IOBUF_IE_testmode0               ;
assign  ao_if.o_IOBUF_PD_testmode0       =    `ALWAYSON_TOP.o_IOBUF_PD_testmode0               ;
assign  ao_if.o_IOBUF_IE_testmode1       =    `ALWAYSON_TOP.o_IOBUF_IE_testmode1               ;
assign  ao_if.o_IOBUF_PD_testmode1       =    `ALWAYSON_TOP.o_IOBUF_PD_testmode1               ;
assign  ao_if.o_IOBUF_IE_resetn          =    `ALWAYSON_TOP.o_IOBUF_IE_resetn                  ;
assign  ao_if.o_IOBUF_PU_resetn          =    `ALWAYSON_TOP.o_IOBUF_PU_resetn                  ;
assign  ao_if.atpg_en_out                =    `ALWAYSON_TOP.atpg_en_out                        ;
assign  ao_if.scan_en_out                =    `ALWAYSON_TOP.scan_en_out                        ;
assign  ao_if.D2A_BG1P2_BUF_EN           =    `ALWAYSON_TOP.D2A_BG1P2_BUF_EN                   ;
assign  ao_if.d2a_vcm1p5_buf_en          =    `ALWAYSON_TOP.d2a_vcm1p5_buf_en                  ;
assign  ao_if.d2a_rld_amp_en             =    `ALWAYSON_TOP.d2a_rld_amp_en                     ;
assign  ao_if.d2a_ecg_pga_en             =    `ALWAYSON_TOP.d2a_ecg_pga_en                     ;
assign  ao_if.d2a_ecg_lpf_en             =    `ALWAYSON_TOP.d2a_ecg_lpf_en                     ;
assign  ao_if.d2a_ecg_pga_gsel           =    `ALWAYSON_TOP.d2a_ecg_pga_gsel                   ;
assign  ao_if.d2a_ecg_dda_clksel         =    `ALWAYSON_TOP.d2a_ecg_dda_clksel                 ;
assign  ao_if.d2a_ecg_dda_en             =    `ALWAYSON_TOP.d2a_ecg_dda_en                     ;
assign  ao_if.d2a_ecg_dda_gsel           =    `ALWAYSON_TOP.d2a_ecg_dda_gsel                   ;
assign  ao_if.d2a_ecg_ddachop_en         =    `ALWAYSON_TOP.d2a_ecg_ddachop_en                 ;
assign  ao_if.d2a_ecg_dda_isel           =    `ALWAYSON_TOP.d2a_ecg_dda_isel                   ;
assign  ao_if.d2a_dc_lead_off_rmode_en   =    `ALWAYSON_TOP.d2a_dc_lead_off_rmode_en           ;
assign  ao_if.d2a_dc_lead_off_vin_flip   =    `ALWAYSON_TOP.d2a_dc_lead_off_vin_flip           ;
//assign  ao_if.d2a_dc_lead_off_isel       =    `ALWAYSON_TOP.d2a_dc_lead_off_isel               ;
//assign  ao_if.d2a_dc_lead_off_comp_th    =    `ALWAYSON_TOP.d2a_dc_lead_off_comp_th            ;
assign  ao_if.d2a_dc_lead_off_en         =    `ALWAYSON_TOP.d2a_dc_lead_off_en                 ;
assign  ao_if.D2A_BIST_EN                =    `ALWAYSON_TOP.D2A_BIST_EN                        ;
assign  ao_if.D2A_BIST_ISEL              =    `ALWAYSON_TOP.D2A_BIST_ISEL                      ;
assign  ao_if.trim1_always_on            =    `ALWAYSON_TOP.trim1_always_on                    ;
assign  ao_if.trim2_always_on            =    `ALWAYSON_TOP.trim2_always_on                    ;
assign  ao_if.trim3_always_on            =    `ALWAYSON_TOP.trim3_always_on                    ;
assign  ao_if.trim4_always_on            =    `ALWAYSON_TOP.trim4_always_on                    ;
assign  ao_if.trim5_always_on            =    `ALWAYSON_TOP.trim5_always_on                    ;
assign  ao_if.trim6_always_on            =    `ALWAYSON_TOP.trim6_always_on                    ;
assign  ao_if.trim7_always_on            =    `ALWAYSON_TOP.trim7_always_on                    ;
assign  ao_if.trim8_always_on            =    `ALWAYSON_TOP.trim8_always_on                    ;
assign  ao_if.o_IOBUF_Y                  =    `ALWAYSON_TOP.o_IOBUF_Y                          ;
assign  ao_if.o_D2A_SDM_EN_AO            =    `ALWAYSON_TOP.o_D2A_SDM_EN_AO                    ;
assign  ao_if.o_D2A_SDM_CLK_AO           =    `ALWAYSON_TOP.o_D2A_SDM_CLK_AO                   ;
assign  ao_if.o_D2A_SDM_VIN_SEL_AO       =    `ALWAYSON_TOP.o_D2A_SDM_VIN_SEL_AO               ;
assign  ao_if.o_D2A_SDM_BIAS_AO          =    `ALWAYSON_TOP.o_D2A_SDM_BIAS_AO                  ;
assign  ao_if.o_D2A_TSC_INA_GSEL_AO      =    `ALWAYSON_TOP.o_D2A_TSC_INA_GSEL_AO              ;
assign  ao_if.o_D2A_TSC_EN_AO            =    `ALWAYSON_TOP.o_D2A_TSC_EN_AO                    ;
assign  ao_if.o_D2A_TSC_BJT_SEL_AO       =    `ALWAYSON_TOP.o_D2A_TSC_BJT_SEL_AO               ;
assign  ao_if.o_D2A_TSC_OUT_SEL_AO       =    `ALWAYSON_TOP.o_D2A_TSC_OUT_SEL_AO               ;
assign  ao_if.o_D2A_EN_PPG_AF_AO         =    `ALWAYSON_TOP.o_D2A_EN_PPG_AF_AO                 ;
assign  ao_if.o_D2A_EN_PPG_BUFFER_AO     =    `ALWAYSON_TOP.o_D2A_EN_PPG_BUFFER_AO             ;
assign  ao_if.o_D2A_EN_PPG_SH_AO         =    `ALWAYSON_TOP.o_D2A_EN_PPG_SH_AO                 ;
assign  ao_if.o_D2A_EN_TIA_AO            =    `ALWAYSON_TOP.o_D2A_EN_TIA_AO                    ;
assign  ao_if.o_D2A_EN_TIA_VREFBUFFER_AO =    `ALWAYSON_TOP.o_D2A_EN_TIA_VREFBUFFER_AO         ;
assign  ao_if.o_D2A_LEDDAC_SEL_AO        =    `ALWAYSON_TOP.o_D2A_LEDDAC_SEL_AO                ;
assign  ao_if.o_D2A_LEDSEL_AO            =    `ALWAYSON_TOP.o_D2A_LEDSEL_AO                    ;
assign  ao_if.o_D2A_LED_EN_AO            =    `ALWAYSON_TOP.o_D2A_LED_EN_AO                    ;
assign  ao_if.o_D2A_LED_STANDBYEN_AO     =    `ALWAYSON_TOP.o_D2A_LED_STANDBYEN_AO             ;
assign  ao_if.o_D2A_PDVREF_SEL_AO        =    `ALWAYSON_TOP.o_D2A_PDVREF_SEL_AO                ;
assign  ao_if.o_D2A_PPG_SH_CK_AO         =    `ALWAYSON_TOP.o_D2A_PPG_SH_CK_AO                 ;
assign  ao_if.o_D2A_PPG_TEST_IN_AO       =    `ALWAYSON_TOP.o_D2A_PPG_TEST_IN_AO               ;
assign  ao_if.o_D2A_PPG_TEST_OUT_AO      =    `ALWAYSON_TOP.o_D2A_PPG_TEST_OUT_AO              ;
assign  ao_if.o_D2A_TIA_GAIN_AO          =    `ALWAYSON_TOP.o_D2A_TIA_GAIN_AO                  ;
assign  ao_if.o_D2A_TIA_IDAC_AO          =    `ALWAYSON_TOP.o_D2A_TIA_IDAC_AO                  ;
assign  ao_if.o_D2A_PPGDAC0_EN_AO        =    `ALWAYSON_TOP.o_D2A_PPGDAC0_EN_AO                ;
assign  ao_if.o_D2A_PPGDAC0_VSEL_AO      =    `ALWAYSON_TOP.o_D2A_PPGDAC0_VSEL_AO              ;
assign  ao_if.o_D2A_PPGDAC1_EN_AO        =    `ALWAYSON_TOP.o_D2A_PPGDAC1_EN_AO                ;
assign  ao_if.o_D2A_PPGDAC1_VSEL_AO      =    `ALWAYSON_TOP.o_D2A_PPGDAC1_VSEL_AO              ;
assign  ao_if.o_D2A_EN_PPGDAC_BUFFER_AO  =    `ALWAYSON_TOP.o_D2A_EN_PPGDAC_BUFFER_AO          ;
assign  ao_if.o_D2A_ATM0_AO              =    `ALWAYSON_TOP.o_D2A_ATM0_AO                      ;
assign  ao_if.o_D2A_ATM1_AO              =    `ALWAYSON_TOP.o_D2A_ATM1_AO                      ;
assign  ao_if.o_D2A_ATM2_AO              =    `ALWAYSON_TOP.o_D2A_ATM2_AO                      ;
assign  ao_if.o_D2A_ATM3_AO              =    `ALWAYSON_TOP.o_D2A_ATM3_AO                      ;
assign  ao_if.o_D2A_ATM4_AO              =    `ALWAYSON_TOP.o_D2A_ATM4_AO                      ;
assign  ao_if.o_D2A_ATM5_AO              =    `ALWAYSON_TOP.o_D2A_ATM5_AO                      ;
assign  ao_if.o_D2A_ATM6_AO              =    `ALWAYSON_TOP.o_D2A_ATM6_AO                      ;
assign  ao_if.o_D2A_ATM7_AO              =    `ALWAYSON_TOP.o_D2A_ATM7_AO                      ;
assign  ao_if.o_D2A_ATM8_AO              =    `ALWAYSON_TOP.o_D2A_ATM8_AO                      ;
assign  ao_if.o_D2A_ATM9_AO              =    `ALWAYSON_TOP.o_D2A_ATM9_AO                      ;
assign  ao_if.o_D2A_ATM10_AO             =    `ALWAYSON_TOP.o_D2A_ATM10_AO                     ;
assign  ao_if.o_D2A_ATM11_AO             =    `ALWAYSON_TOP.o_D2A_ATM11_AO                     ;
assign  ao_if.o_IOBUF_PU_testmode0       =    `ALWAYSON_TOP.o_IOBUF_PU_testmode0               ;
assign  ao_if.o_IOBUF_PU_testmode1       =    `ALWAYSON_TOP.o_IOBUF_PU_testmode1               ;
assign  ao_if.o_IOBUF_PD_resetn          =    `ALWAYSON_TOP.o_IOBUF_PD_resetn                  ;

initial begin
    nnc_config_db#(virtual nnc_ao_top_interface)::set(uvm_root::get(), "uvm_test_top.top_env.sysc_env.ao_mon", "ao_if", ao_if);
end

`define  ALWAYSON_CHECK_EN        `SYS_CTRL_CFG.ao_top_check_en
