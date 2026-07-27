/*--------------------------------------------------------------------------------------*/
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
// --------------------------------------------------------------------------------------
// Project      : Nanochap ENS3
// File         : tb_chip_top_uvm_ana.sv
// Description  : ANALOG BLOCK TB (included file) 
// Designer     : Daniel Dang
// Date         : 22/11/2023
// Revision     : 0.1
/*--------------------------------------------------------------------------------------*/


////////////////////analog signals connection//////////////////////////

nnc_analog_interface    ana_if();

assign ana_if.testmode                 =     `SOC_TB.TESTMODE  ;
assign ana_if.iopad_gpio               =     `SOC_TB.IOBUF_PAD ;  
assign ana_if.clk                      =     `FLASH_TOP.clk; //`CLK_CTRL_TOP.pclk;
assign ana_if.fclk                     =     `CLK_CTRL_TOP.fclk;

assign  ana_if.ANA_TSC_1                =     {7'b0, `ANA_TOP.D2A_TSC_INA_EN};

assign  ana_if.ANA_BUFFER               =     { 3'b0  ,
                                               `ANA_TOP.D2A_2ELECTRODE_EN, 
                                               `ANA_TOP.D2A_RLD_CHOP_EN, 
                                               `ANA_TOP.D2A_RLD_EN, 
                                               `ANA_TOP.D2A_BG1P2_BUF_EN, 
                                               `ANA_TOP.D2A_VCM1P5_BUF_EN};
 
assign  ana_if.ANA_ECG_CTRL_1           =     {`ANA_TOP.D2A_ECG_DDA_GSEL, 
                                               `ANA_TOP.D2A_ECG_PGA_GSEL, 
                                               `ANA_TOP.D2A_ECG_LPF_EN, 
                                               `ANA_TOP.D2A_ECG_PGA_EN};
 
assign  ana_if.ANA_ECG_CTRL_2           =     { 1'b0, 
                                               `ANA_TOP.D2A_ECGCAL_EN, 
                                               `ANA_TOP.D2A_ECG_DDA_ISEL, 
                                               `ANA_TOP.D2A_ECG_DDACHOP_EN, 
                                               `ANA_TOP.D2A_ECG_DDA_EN, 
                                               `ANA_TOP.D2A_ECG_DDA_CLKSEL};
 
assign  ana_if.ANA_DC_LEAD_OFF_CTRL     =     {6'b0, `ANA_TOP.D2A_DCLEADOFF_VINFLIP, `ANA_TOP.D2A_DCLEADOFF_RMODE_EN }  ; 
assign  ana_if.ANA_BIST                 =     {4'b0, `ANA_TOP.D2A_BIST_EN, `ANA_TOP.D2A_BIST_ISEL }  ; 
assign  ana_if.ANA_TSC                  =     {`ANA_TOP.D2A_TSC_INA_GSEL, `ANA_TOP.D2A_TSC_EN, `ANA_TOP.D2A_TSC_BJT_SEL, `ANA_TOP.D2A_TSC_OUT_SEL }  ; 
assign  ana_if.ANA_PPG_LED_SEL          =     {5'b0, `ANA_TOP.D2A_LEDSEL, `ANA_TOP.D2A_LEDDAC_SEL }  ; 
assign  ana_if.ANA_PPG_DAC0_CTRL_REG0   =     {`ANA_TOP.D2A_PPGDAC0_VSEL[7:0] }  ; 
assign  ana_if.ANA_PPG_DAC0_CTRL_REG1   =     {3'b0, `ANA_TOP.D2A_PPGDAC0_EN, `ANA_TOP.D2A_PPGDAC0_VSEL[11:8] }  ; 
assign  ana_if.ANA_PPG_DAC1_CTRL_REG0   =     {`ANA_TOP.D2A_PPGDAC1_VSEL[7:0] }  ; 
assign  ana_if.ANA_PPG_DAC1_CTRL_REG1   =     {3'b0, `ANA_TOP.D2A_PPGDAC1_EN, `ANA_TOP.D2A_PPGDAC1_VSEL[11:8] }  ; 
assign  ana_if.ANA_PPG_TIA_IDAC         =     {`ANA_TOP.D2A_TIA_IDAC }  ; 
assign  ana_if.ANA_PPG_TIA_GAIN         =     {4'b0, `ANA_TOP.D2A_TIA_GAIN }  ; 
assign  ana_if.ANA_PPG_TEST_REG         =     {2'b0, `ANA_TOP.D2A_PDVREF_SEL, `ANA_TOP.D2A_PPG_TEST_IN, `ANA_TOP.D2A_PPG_TEST_OUT }  ; 
assign  ana_if.ANA_PPG_LED_EN_REG       =     { 2'b0, 
                                               `ANA_TOP.D2A_EN_PPGDAC_BUFFER, 
                                               `ANA_TOP.D2A_EN_TIA_VREFBUFFER, 
                                               `ANA_TOP.D2A_EN_PPG_BUFFER, 
                                               `ANA_TOP.D2A_EN_PPG_SH, 
                                               `ANA_TOP.D2A_EN_PPG_AF, 
                                               `ANA_TOP.D2A_LED_STANDBYEN };
 
assign  ana_if.ANA_PPG_CTRL_REG         =     {5'b0, `ANA_TOP.D2A_LED_EN, `ANA_TOP.D2A_EN_TIA, `ANA_TOP.D2A_PPG_SH_CK }  ; 
assign  ana_if.ANA_SDM                  =     {5'b0, `ANA_TOP.D2A_SDM_EN, `ANA_TOP.D2A_SDM_BIAS }  ; 
assign  ana_if.ANA_LEAD_OFF_EN          =     {6'b0, `ANA_TOP.D2A_ACLEADOFF_EN, `ANA_TOP.D2A_DCLEADOFF_EN }  ; 

assign #50ns ana_if.D2A_ATM             =    '{`ANA_TOP.D2A_ATM12, 
                                               `ANA_TOP.D2A_ATM11, 
                                               `ANA_TOP.D2A_ATM10, 
                                               `ANA_TOP.D2A_ATM9, 
                                               `ANA_TOP.D2A_ATM8, 
                                               `ANA_TOP.D2A_ATM7, 
                                               `ANA_TOP.D2A_ATM6, 
                                               `ANA_TOP.D2A_ATM5, 
                                               `ANA_TOP.D2A_ATM4, 
                                               `ANA_TOP.D2A_ATM3, 
                                               `ANA_TOP.D2A_ATM2, 
                                               `ANA_TOP.D2A_ATM1, 
                                               `ANA_TOP.D2A_ATM0};

// Internal signals connected to interface so need to bypass it for NETLIST PRESCAN/POSTSCAN
`ifdef BEHAVIORAL
  assign ana_if.SPI_ANA_TSC_1               =  {7'b0,`SPI_TOP.spi_reg_u.ana_tsc_1}              ; 
  assign ana_if.SPI_ANA_BUFFER              =  {5'b0,`SPI_TOP.spi_reg_u.ana_buffer}              ;         
  assign ana_if.SPI_ANA_ECG_CTRL_1          =  `SPI_TOP.spi_reg_u.ana_ecg_ctrl_1          ;
  assign ana_if.SPI_ANA_ECG_CTRL_2          =  `SPI_TOP.spi_reg_u.ana_ecg_ctrl_2          ;
  assign ana_if.SPI_ANA_DC_LEAD_OFF_CTRL    =  {6'b0,`SPI_TOP.spi_reg_u.ana_dc_lead_off_ctrl}    ;
  assign ana_if.SPI_ANA_BIST                =  {4'b0,`SPI_TOP.spi_reg_u.ana_bist}                ;
  assign ana_if.SPI_ANA_TSC                 =  `SPI_TOP.spi_reg_u.ana_tsc	                 ;

  always @(*) begin
    if(ana_if.o_PPG_SYNC_BYPASS === 0) begin repeat(2) @(posedge ana_if.clk); end
    ana_if.SPI_ANA_PPG_LED_SEL              =  {5'b0,`SPI_TOP.spi_reg_u.ana_ppg_led_sel_reg}     ;
    ana_if.SPI_ANA_PPG_DAC0_CTRL_REG0       =  `SPI_TOP.spi_reg_u.ana_ppg_dac0_ctrl_reg0         ;
    ana_if.SPI_ANA_PPG_DAC0_CTRL_REG1       =  {3'B0,`SPI_TOP.spi_reg_u.ana_ppg_dac0_ctrl_reg1}  ;
    ana_if.SPI_ANA_PPG_DAC1_CTRL_REG0       =  `SPI_TOP.spi_reg_u.ana_ppg_dac1_ctrl_reg0         ;
    ana_if.SPI_ANA_PPG_DAC1_CTRL_REG1       =  {3'B0,`SPI_TOP.spi_reg_u.ana_ppg_dac1_ctrl_reg1}  ;
    ana_if.SPI_ANA_PPG_TIA_IDAC             =  `SPI_TOP.spi_reg_u.ana_ppg_tia_idac               ;
    ana_if.SPI_ANA_PPG_TIA_GAIN             =  {4'b0,`SPI_TOP.spi_reg_u.ana_ppg_tia_gain}        ;
    ana_if.SPI_ANA_PPG_TEST_REG             =  {2'b0,`SPI_TOP.spi_reg_u.ana_ppg_test_reg}        ;
    ana_if.SPI_ANA_PPG_LED_EN_REG           =  {2'b0,`SPI_TOP.spi_reg_u.ana_ppg_led_en_reg}      ;
    ana_if.SPI_ANA_PPG_CTRL_REG             =  {5'b0,`SPI_TOP.spi_reg_u.ana_ppg_ctrl_reg}        ;
  end

  assign ana_if.SPI_ANA_SDM                 =  {5'b0,`SPI_TOP.spi_reg_u.ana_sdm_reg}             ;
  assign ana_if.SPI_ANA_LEAD_OFF_EN         =  {6'b0,`SPI_TOP.spi_reg_u.ana_lead_off_en}         ;
`else
  `ifndef POSTLAYOUT_PG
    assign ana_if.SPI_ANA_TSC_1               =  {7'b0,`SPI_TOP.spi_reg_u.ana_tsc_1_reg.Q};
  `else
    assign ana_if.SPI_ANA_TSC_1               =  {7'b0,`SPI_TOP.spi_reg_u.ana_tsc_1_reg.Q};
  `endif

  assign ana_if.SPI_ANA_BUFFER              =  { 3'b0, 
                                                `SPI_TOP.spi_reg_u.o_ECG_ELECTRODE_EN, 
                                                `SPI_TOP.spi_reg_u.o_RLD_CHOP_EN, 
                                                `SPI_TOP.spi_reg_u.o_RLD_AMP_EN,
                                                `SPI_TOP.spi_reg_u.o_BG1P2_BUF_EN, 
                                                `SPI_TOP.spi_reg_u.o_VCM1P5_BUF_EN
                                               };
         
  assign ana_if.SPI_ANA_ECG_CTRL_1          =  {`SPI_TOP.spi_reg_u.o_ECG_DDA_GSEL, 
                                                `SPI_TOP.spi_reg_u.o_ECG_PGA_GSEL, 
                                                `SPI_TOP.spi_reg_u.o_ECG_LPF_EN, 
                                                `SPI_TOP.spi_reg_u.o_ECG_PGA_EN};

  assign ana_if.SPI_ANA_ECG_CTRL_2          =  { 1'b0, 
                                                `SPI_TOP.spi_reg_u.o_ECG_CAL_EN, 
                                                `SPI_TOP.spi_reg_u.o_ECG_DDA_ISEL, 
                                                `SPI_TOP.spi_reg_u.o_ECG_DDACHOP_EN, 
                                                `SPI_TOP.spi_reg_u.o_ECG_DDA_EN, 
                                                `SPI_TOP.spi_reg_u.o_ECG_DDA_CLKSEL};

  assign ana_if.SPI_ANA_DC_LEAD_OFF_CTRL    =  { 6'b0, 
                                                `SPI_TOP.spi_reg_u.o_DC_LEAD_OFF_VIN_FLIP, 
                                                `SPI_TOP.spi_reg_u.o_DC_LEAD_OFF_RMODE_EN};

  assign ana_if.SPI_ANA_BIST                =  { 4'b0,
                                                `SPI_TOP.spi_reg_u.o_BIST_EN, 
                                                `SPI_TOP.spi_reg_u.o_BIST_ISEL};

  assign ana_if.SPI_ANA_TSC                 =  {`SPI_TOP.spi_reg_u.o_TSC_INA_GEL, 
                                                `SPI_TOP.spi_reg_u.o_TSC_EN, 
                                                `SPI_TOP.spi_reg_u.o_TSC_BJT_SEL, 
                                                `SPI_TOP.spi_reg_u.o_TSC_OUT_SEL};

  always @(*) begin
    if(ana_if.o_PPG_SYNC_BYPASS === 0) begin repeat(2) @(posedge ana_if.clk); end
    ana_if.SPI_ANA_PPG_LED_SEL         =  {5'b0, `SPI_TOP.spi_reg_u.o_PPG_LED_SEL, `SPI_TOP.spi_reg_u.o_PPG_LED_DAC_SEL}       ;
    ana_if.SPI_ANA_PPG_DAC0_CTRL_REG0  =  `SPI_TOP.spi_reg_u.o_PPG_DAC0_VSEL[7:0]         ;
    ana_if.SPI_ANA_PPG_DAC0_CTRL_REG1  =  {3'B0, `SPI_TOP.spi_reg_u.o_PPG_DAC0_EN, `SPI_TOP.spi_reg_u.o_PPG_DAC0_VSEL[11:8]}  ;
    ana_if.SPI_ANA_PPG_DAC1_CTRL_REG0  =  `SPI_TOP.spi_reg_u.o_PPG_DAC1_VSEL[7:0]         ;
    ana_if.SPI_ANA_PPG_DAC1_CTRL_REG1  =  {3'B0, `SPI_TOP.spi_reg_u.o_PPG_DAC1_EN, `SPI_TOP.spi_reg_u.o_PPG_DAC1_VSEL[11:8]}  ;
    ana_if.SPI_ANA_PPG_TIA_IDAC        =  `SPI_TOP.spi_reg_u.o_PPG_TIA_IDAC[7:0]               ;
    ana_if.SPI_ANA_PPG_TIA_GAIN        =  {4'b0,`SPI_TOP.spi_reg_u.o_PPG_TIA_GAIN[3:0]}        ;
    ana_if.SPI_ANA_PPG_TEST_REG        =  {2'b0, `SPI_TOP.spi_reg_u.o_PPG_PDV_REF_SEL, `SPI_TOP.spi_reg_u.o_PPG_TEST_IN, `SPI_TOP.spi_reg_u.o_PPG_TEST_OUT}        ;

    ana_if.SPI_ANA_PPG_LED_EN_REG      =  { 2'b0,   
                                           `SPI_TOP.spi_reg_u.o_PPG_DAC_BUFFER_EN, 
                                           `SPI_TOP.spi_reg_u.o_PPG_TIA_VREF_BUFFER_EN, 
                                           `SPI_TOP.spi_reg_u.o_PPG_BUFFER_EN, 
                                           `SPI_TOP.spi_reg_u.o_PPG_SH_EN, 
                                           `SPI_TOP.spi_reg_u.o_PPG_AF_EN, 
                                           `SPI_TOP.spi_reg_u.o_PPG_LED_STANDBYEN};

    ana_if.SPI_ANA_PPG_CTRL_REG        =  { 5'b0,  
                                           `SPI_TOP.spi_reg_u.o_PPG_LED_EN, 
                                           `SPI_TOP.spi_reg_u.o_PPG_TIA_EN, 
                                           `SPI_TOP.spi_reg_u.o_PPG_SH_CK};
  end

  assign ana_if.SPI_ANA_SDM               =  {5'b0, `SPI_TOP.spi_reg_u.o_SDM_EN, `SPI_TOP.spi_reg_u.o_SDM_BIAS}             ;
  assign ana_if.SPI_ANA_LEAD_OFF_EN       =  {6'b0,`SPI_TOP.spi_reg_u.o_LEAD_OFF_EN}         ;
`endif

assign #1 ana_if.o_PPG_SYNC_BYPASS        =  `SPI_TOP.o_PPG_SYNC_BYPASS           ;

assign    ana_if.ao_reset                 =  `ALWAYSON_RST_CTRL.por_resetn        ;
assign    ana_if.sw_reset                 =  `RST_CTRL_TOP.presetn                ;

assign #1 ana_if.ppg_ctrl                 =  `CLK_CTRL_TOP.ppg_ctrl_en            ; 
assign #1 ana_if.ppg_en                   =  `PPG_TOP.ppg_enable                  ;

assign    ana_if.sw_vdd                   =  `ANA_TOP.VDD_DIG_SW                  ;
assign    ana_if.ao_vdd                   =  `ANA_TOP.VDD_DIG_AO                  ;

// ==========================================================================================
// This part for Flash checking and TRIM operaton to ANA Mon
// ==========================================================================================

// Connect Control Signal for WR and status of Reload to ANA
// Connect AO SPI WRITE
`ifdef BEHAVIORAL
  assign #1 ana_if.AO_SPI_WRITE            =  `SPI_TOP.spi_reg_u.clk_ctrl_reg[7];
`else
  assign #1 ana_if.AO_SPI_WRITE           =  `SPI_TOP.spi_reg_u.o_always_on_spi_write;
`endif
assign #1 ana_if.reload_done              =  `SPI_TOP.spi_reg_u.u_spi_reg_flash.u_FLASH_Reset_Done.async_in;
assign #1 ana_if.SPI_WRITE                =  0;// removed - `SPI_TOP.o_spi_regs_wrcmd;
assign #1 ana_if.FLASH_LOAD_FLG           =  `FLASH_TOP.flash_regload_flg;  

// Connect internal mem to ANA Interface
assign ana_if.FLASH_TRIM0            =    `FLASH_IP.inf0_mem[9'h0] ;
assign ana_if.FLASH_TRIM1            =    `FLASH_IP.inf0_mem[9'h1] ;
assign ana_if.FLASH_TRIM2            =    `FLASH_IP.inf0_mem[9'h2] ;
assign ana_if.FLASH_TRIM3            =    `FLASH_IP.inf0_mem[9'h3] ;
assign ana_if.FLASH_TRIM4            =    `FLASH_IP.inf0_mem[9'h4] ;
assign ana_if.FLASH_TRIM5            =    `FLASH_IP.inf0_mem[9'h5] ;
assign ana_if.FLASH_TRIM6            =    `FLASH_IP.inf0_mem[9'h6] ;
assign ana_if.FLASH_TRIM7            =    `FLASH_IP.inf0_mem[9'h7] ;
assign ana_if.FLASH_TRIM8            =    `FLASH_IP.inf0_mem[9'h8] ;
assign ana_if.FLASH_TRIM9            =    `FLASH_IP.inf0_mem[9'h9] ;
assign ana_if.FLASH_TRIM10           =    `FLASH_IP.inf0_mem[9'ha] ;
assign ana_if.FLASH_TRIM11           =    `FLASH_IP.inf0_mem[9'hb] ;
assign ana_if.FLASH_TRIM12           =    `FLASH_IP.inf0_mem[9'hc] ;
assign ana_if.FLASH_TRIM13           =    `FLASH_IP.inf0_mem[9'hd] ;
assign ana_if.FLASH_TRIM14           =    `FLASH_IP.inf0_mem[9'he] ;
assign ana_if.FLASH_TRIM15           =    `FLASH_IP.inf0_mem[9'hf] ;
assign ana_if.FLASH_TRIM16           =    `FLASH_IP.inf0_mem[9'h10] ;
assign ana_if.FLASH_TRIM17           =    `FLASH_IP.inf0_mem[9'h11] ;
assign ana_if.FLASH_TRIM18           =    `FLASH_IP.inf0_mem[9'h12] ;
assign ana_if.FLASH_TRIM19           =    `FLASH_IP.inf0_mem[9'h13] ;
assign ana_if.FLASH_TRIM20           =    `FLASH_IP.inf0_mem[9'h14] ;

// Connect internal register of TRIM in SPI to ANA Mon
`ifdef BEHAVIORAL
  assign ana_if.REG_TRIM1            =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[1];
  assign ana_if.REG_TRIM2            =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[2];
  assign ana_if.REG_TRIM3            =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[3];
  assign ana_if.REG_TRIM4            =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[4];
  assign ana_if.REG_TRIM5            =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[5];
  assign ana_if.REG_TRIM6            =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[6];
  assign ana_if.REG_TRIM7            =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[7];
  assign ana_if.REG_TRIM8            =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[8];
  assign ana_if.REG_TRIM9            =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[9];
  assign ana_if.REG_TRIM10           =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[10];
  assign ana_if.REG_TRIM11           =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[11];
  assign ana_if.REG_TRIM12           =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[12];
  assign ana_if.REG_TRIM13           =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[13];
  assign ana_if.REG_TRIM14           =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[14];
  assign ana_if.REG_TRIM15           =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[15];
  assign ana_if.REG_TRIM16           =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[16];
  assign ana_if.REG_TRIM17           =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[17];
  assign ana_if.REG_TRIM18           =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[18];
  assign ana_if.REG_TRIM19           =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[19];
  assign ana_if.REG_TRIM20           =    `SPI_TOP.spi_reg_u.u_spi_reg_flash.trim_reg[20];
`else // for prescan/postscan
  assign ana_if.REG_TRIM1            =    `SPI_TOP.spi_reg_u.d2a_trim1_from_flash  ;
  assign ana_if.REG_TRIM2            =    `SPI_TOP.spi_reg_u.d2a_trim2_from_flash  ;
  assign ana_if.REG_TRIM3            =    `SPI_TOP.spi_reg_u.d2a_trim3_from_flash  ;
  assign ana_if.REG_TRIM4            =    `SPI_TOP.spi_reg_u.d2a_trim4_from_flash  ;
  assign ana_if.REG_TRIM5            =    `SPI_TOP.spi_reg_u.d2a_trim5_from_flash  ;
  assign ana_if.REG_TRIM6            =    `SPI_TOP.spi_reg_u.d2a_trim6_from_flash  ;
  assign ana_if.REG_TRIM7            =    `SPI_TOP.spi_reg_u.d2a_trim7_from_flash  ;
  assign ana_if.REG_TRIM8            =    `SPI_TOP.spi_reg_u.d2a_trim8_from_flash  ;
  assign ana_if.REG_TRIM9            =    `SPI_TOP.spi_reg_u.d2a_trim9_from_flash  ;
  assign ana_if.REG_TRIM10           =    `SPI_TOP.spi_reg_u.d2a_trim10_from_flash  ;
  assign ana_if.REG_TRIM11           =    `SPI_TOP.spi_reg_u.d2a_trim11_from_flash  ;
  assign ana_if.REG_TRIM12           =    `SPI_TOP.spi_reg_u.d2a_trim12_from_flash  ;
  assign ana_if.REG_TRIM13           =    `SPI_TOP.spi_reg_u.d2a_trim13_from_flash  ;
  assign ana_if.REG_TRIM14           =    `SPI_TOP.spi_reg_u.d2a_trim14_from_flash  ;
  assign ana_if.REG_TRIM15           =    `SPI_TOP.spi_reg_u.d2a_trim15_from_flash  ;
  assign ana_if.REG_TRIM16           =    `SPI_TOP.spi_reg_u.d2a_trim16_from_flash  ;
  assign ana_if.REG_TRIM17           =    `SPI_TOP.spi_reg_u.d2a_trim17_from_flash  ;
  assign ana_if.REG_TRIM18           =    `SPI_TOP.spi_reg_u.d2a_trim18_from_flash  ;
  assign ana_if.REG_TRIM19           =    `SPI_TOP.spi_reg_u.d2a_trim19_from_flash  ;
  assign ana_if.REG_TRIM20           =    `SPI_TOP.spi_reg_u.d2a_trim20_from_flash  ;
`endif

// Assign Interface from ANA TOP to ANA MON 
assign ana_if.D2A_BGH_VTRIM               =   `ANA_TOP.D2A_BGH_VTRIM              ;     //trim1 
assign ana_if.D2A_BGH_CTRIM               =   `ANA_TOP.D2A_BGH_CTRIM              ;     //trim2
assign ana_if.D2A_LDO1V5_VTRIM            =   `ANA_TOP.D2A_LDO1V5_VTRIM           ;     //trim3
assign ana_if.D2A_OSC_TRIM                =   `ANA_TOP.D2A_OSC_TRIM               ;     //trim4
                                                                                        //trim5
assign ana_if.D2A_OSC_ISEL_TRIM           =   `ANA_TOP.D2A_OSC_ISEL_TRIM          ;     //trim9
assign ana_if.D2A_DCLEADOFF_COMP_TH_TRIM  =   `ANA_TOP.D2A_DCLEADOFF_COMP_TH_TRIM ;     //trim10
assign ana_if.D2A_ACLEADOFF_ISEL_TRIM     =   `ANA_TOP.D2A_ACLEADOFF_ISEL_TRIM    ;     //trim11
assign ana_if.D2A_ACLEADOFF_VTHNSEL_TRIM  =   `ANA_TOP.D2A_ACLEADOFF_VTHNSEL_TRIM ;     //trim12
assign ana_if.D2A_ACLEADOFF_VTHPSEL_TRIM  =   `ANA_TOP.D2A_ACLEADOFF_VTHPSEL_TRIM ;     //trim13
assign ana_if.D2A_DCLEADOFF_ISEL_TRIM     =   `ANA_TOP.D2A_DCLEADOFF_ISEL_TRIM    ;     //trim14
assign ana_if.D2A_SPARE_TRIM0             =   `ANA_TOP.D2A_SPARE_TRIM0            ;     //trim15
assign ana_if.D2A_SPARE_TRIM1             =   `ANA_TOP.D2A_SPARE_TRIM1            ;     //trim16
assign ana_if.D2A_SPARE_TRIM2             =   `ANA_TOP.D2A_SPARE_TRIM2            ;     //trim17
assign ana_if.D2A_SPARE_TRIM3             =   `ANA_TOP.D2A_SPARE_TRIM3            ;     //trim18
assign ana_if.D2A_SPARE_TRIM_SW0          =   `ANA_TOP.D2A_SPARE_TRIM_SW0         ;     //trim19
assign ana_if.D2A_SPARE_TRIM_SW1          =   `ANA_TOP.D2A_SPARE_TRIM_SW1         ;     //trim20
// ---------------------
// End of TRIM
// ---------------------

initial begin
    nnc_config_db#(virtual nnc_analog_interface)::set(uvm_root::get(), "uvm_test_top.top_env.ana_env.ana_mon" , "ana_if", ana_if);
end
