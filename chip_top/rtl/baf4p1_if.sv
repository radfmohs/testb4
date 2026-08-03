//------------------------------------------------------------------------------
// Nanochap Pty Ltd (c) 2021
//------------------------------------------------------------------------------
// Project name: Nanochap ENS2  
// File name:    ens2_if.sv 
// Module Name : ENS2 Interface
// Description : 
//------------------------------------------------------------------------------
// Revision History
//------------------------------------------------------------------------------
// Revision     Date        Author          Description      
//------------------------------------------------------------------------------
// 0.1                                      Initial Rev 
//------------------------------------------------------------------------------

interface spi2imeas();
//o
wire         notch_filter_en;
wire         lpf_filter_en;
wire [1:0]   gain_mul;
wire [15:0]  nf_unstable_time;
wire         leadoff_int_en;
wire         leadoff_det_en;
wire [1:0]   leadoff_type_sel_reg;
wire [1:0]   switch_duration_sel;
wire         leadoff_active;
wire [7:0]   leadoff_tgt_0;
wire [7:0]   leadoff_tgt_1;
wire [7:0]   leadoff_switch_tgt;
wire         o_imeas_int_clr;
wire         o_imeas_int_alarm_clr;
wire [15:0]  o_threshold_hi;
wire [15:0]  o_threshold_lo;
wire         o_int_alarm_en;
wire [15:0]  o_imeas_reg_ctrl;
wire [7:0]   o_imeas_reg_ch;
wire [2:0]   o_imeas_reg_seq;
wire [7:0]   o_imeas_reg_rstval;
wire         o_imeas_en;
wire [1:0]   o_imeas_input_format;
wire [11:0]  o_active_channel_num;
wire         o_imeas_grp_ctl;   
wire         int_length;
//I
wire[15:0]   ch0data_max_final;
wire[15:0]   ch0data_min_final;
wire[15:0]   ch0data_delta_final;
wire [15:0]  i_imeas_ch0data;
wire [15:0]  i_imeas_ch1data;
wire [15:0]  i_imeas_ch2data;
wire         i_imeas_int_sts;
wire         i_imeas_int_sts0;
wire         i_imeas_int_sts1;
wire         i_imeas_bio_int_sts;
wire  	     int_sts_switch_loff_statn;
wire  	     int_sts_duration_loff_statn;
wire  	     int_sts_switch_loff_statp;
wire  	     int_sts_duration_loff_statp;
wire  	     int_sts_switch_acloff_statn;
wire  	     int_sts_duration_acloff_statn;
wire  	     int_sts_switch_acloff_statp;
wire  	     int_sts_duration_acloff_statp;
wire         i_imeas_int_alarm_sts;

modport master(
output notch_filter_en,
output lpf_filter_en,
output gain_mul,
output nf_unstable_time,
output leadoff_int_en,
output leadoff_det_en,
output leadoff_type_sel_reg,
output switch_duration_sel,
output leadoff_active,
output leadoff_tgt_0,
output leadoff_tgt_1,
output leadoff_switch_tgt,
output o_imeas_int_clr,
output o_imeas_int_alarm_clr,
output o_threshold_hi,
output o_threshold_lo,
output o_int_alarm_en,
output o_imeas_reg_ctrl,
output o_imeas_reg_ch,
output o_imeas_reg_seq,
output o_imeas_reg_rstval,
output o_imeas_en,
output o_imeas_input_format,
output o_active_channel_num,
output o_imeas_grp_ctl,
output int_length,

input ch0data_max_final,
input ch0data_min_final,
input ch0data_delta_final,
input i_imeas_ch0data,
input i_imeas_ch1data,
input i_imeas_ch2data,
input i_imeas_int_sts,
input i_imeas_int_sts0,
input i_imeas_int_sts1,
input i_imeas_bio_int_sts,
input int_sts_switch_loff_statn,
input int_sts_duration_loff_statn,
input int_sts_switch_loff_statp,
input int_sts_duration_loff_statp,
input int_sts_switch_acloff_statn,
input int_sts_duration_acloff_statn,
input int_sts_switch_acloff_statp,
input int_sts_duration_acloff_statp,
input i_imeas_int_alarm_sts

);
modport slave (
input notch_filter_en,
input lpf_filter_en,
input gain_mul,
input nf_unstable_time,
input leadoff_int_en,
input leadoff_det_en,
input leadoff_type_sel_reg,
input switch_duration_sel,
input leadoff_active,
input leadoff_tgt_0,
input leadoff_tgt_1,
input leadoff_switch_tgt,
input o_imeas_int_clr,
input o_imeas_int_alarm_clr,
input o_threshold_hi,
input o_threshold_lo,
input o_int_alarm_en,
input o_imeas_reg_ctrl,
input o_imeas_reg_ch,
input o_imeas_reg_seq,
input o_imeas_reg_rstval,
input o_imeas_en,
input o_imeas_input_format,
input o_active_channel_num,
input o_imeas_grp_ctl,
input int_length,


output ch0data_max_final,
output ch0data_min_final,
output ch0data_delta_final,
output i_imeas_ch0data,
output i_imeas_ch1data,
output i_imeas_ch2data,
output i_imeas_int_sts,
output i_imeas_int_sts0,
output i_imeas_int_sts1,
output i_imeas_bio_int_sts,
output int_sts_switch_loff_statn,
output int_sts_duration_loff_statn,
output int_sts_switch_loff_statp,
output int_sts_duration_loff_statp,
output int_sts_switch_acloff_statn,
output int_sts_duration_acloff_statn,
output int_sts_switch_acloff_statp,
output int_sts_duration_acloff_statp,
output i_imeas_int_alarm_sts

);

endinterface 


interface spi2flash #(
TRIM_NUMBER = 21,
BD2F = 3,
BD2S = 4,
SD2F=13,
SD2P=3
)();

wire [7:0] trim [TRIM_NUMBER-1 :0]; 
wire [7:0] trim_read [TRIM_NUMBER-1 :0];

wire [7:0] bd2f [BD2F-1 :0]; //byte data from spi to flash
wire [7:0] bd2s [BD2S-1 :0];//byte data value from flash to spi

wire [SD2F-1:0] sd2f;//single bit from spi to flash
wire [SD2P-1:0] sd2s;//single bit from flash to spi

modport master(
output trim, 
output bd2f,
output sd2f,
input  trim_read,
input  bd2s,
input  sd2s
);
modport slave (
input  trim,
input  bd2f,
input  sd2f,
output trim_read,
output bd2s,
output sd2s

);

endinterface 

interface flash_bist ();
wire [7:0]  BIST_FLASH_RDATA;
wire        BIST_FLASH_NVR;
wire        BIST_FLASH_CEb;
wire        BIST_FLASH_WEb;
wire        BIST_FLASH_PROG;
wire        BIST_FLASH_PROG2;
wire        BIST_FLASH_ERASE;
wire        BIST_FLASH_CHIP;
wire        BIST_FLASH_OEb;
wire        BIST_FLASH_VREAD1;
wire        BIST_FLASH_VREAD0;
wire        BIST_FLASH_TMEN;
wire [14:0] BIST_FLASH_ADDR;
wire [7:0]  BIST_FLASH_WDATA;
wire        BIST_FLASH_DPSTB; 
wire        BIST_FLASH_CONFEN;
wire        BIST_FLASH_RDN;
wire        BIST_FLASH_BLOCK;
wire        BIST_FLASH_VMON2;
wire        BIST_FLASH_VMON1;         
wire        RESETb;


modport master(
output BIST_FLASH_NVR,
output BIST_FLASH_CEb,
output BIST_FLASH_WEb,
output BIST_FLASH_PROG,
output BIST_FLASH_PROG2,
output BIST_FLASH_ERASE,
output BIST_FLASH_CHIP,
output BIST_FLASH_OEb,
output BIST_FLASH_VREAD1,
output BIST_FLASH_VREAD0,
output BIST_FLASH_TMEN,
output BIST_FLASH_ADDR,
output BIST_FLASH_WDATA,
output BIST_FLASH_DPSTB, 
output BIST_FLASH_CONFEN,
output BIST_FLASH_RDN,
output BIST_FLASH_BLOCK,
output BIST_FLASH_VMON2,
output BIST_FLASH_VMON1,        

output RESETb,

input BIST_FLASH_RDATA
);

modport slave (
input BIST_FLASH_NVR,
input BIST_FLASH_CEb,
input BIST_FLASH_WEb,
input BIST_FLASH_PROG,
input BIST_FLASH_PROG2,
input BIST_FLASH_ERASE,
input BIST_FLASH_CHIP,
input BIST_FLASH_OEb,
input BIST_FLASH_VREAD1,
input BIST_FLASH_VREAD0,
input BIST_FLASH_TMEN,
input BIST_FLASH_ADDR,
input BIST_FLASH_WDATA,
input BIST_FLASH_DPSTB, 
input BIST_FLASH_CONFEN,
input BIST_FLASH_RDN,
input BIST_FLASH_BLOCK,
input BIST_FLASH_VMON2,
input BIST_FLASH_VMON1, 
input RESETb, 

output BIST_FLASH_RDATA
);
endinterface 


interface flash2imeas();

wire [15:0] nf_coeff  [23:0];
wire [15:0] lpf_coeff [27:0];

modport master(
  output nf_coeff,
  output lpf_coeff
);

modport slave (
  input  nf_coeff,
  input  lpf_coeff
);

endinterface






interface spi_anac #(
  NO_OF_WAVEGEN = 2
)();

//I
wire          ana_lvd_intr_en;
//O
wire          ana_lvd_intr_pin;
////I
wire          int_length_slct;
//wire [31:0]                 ana_stimu_ch_timer_TH[NO_OF_WAVEGEN-1 :0];	
//wire [31:0]                 ana_stimu_ch_counter_TH[NO_OF_WAVEGEN-1 :0];	
//wire [NO_OF_WAVEGEN-1 :0 ]  ana_comp_ch_intr_en;
//wire [NO_OF_WAVEGEN-1 :0 ]  ana_comp_ch_intr_trans_sel;
//wire [NO_OF_WAVEGEN-1 :0 ]  ana_comp_ch_intr_sts_clr;
//wire [NO_OF_WAVEGEN-1 :0 ]  ana_stimu_ch_intr_sts_clr;
//wire [NO_OF_WAVEGEN-1 :0]   anac_short_int_en;
//wire [NO_OF_WAVEGEN-1 :0]   anac_short_drive_en;
//wire                        anac_short_leadoff_en;
//wire [NO_OF_WAVEGEN-1 :0]   anac_int_pol;
//
////O
//wire [31:0]                 counter_th_cnt_dbg[NO_OF_WAVEGEN-1 :0];
//wire [NO_OF_WAVEGEN-1 :0]   ana_stimu_ch_intr_sts;
//wire [NO_OF_WAVEGEN-1 :0]   ana_comp_ch_intr_sts;

modport master(
  output ana_lvd_intr_en,
  output int_length_slct,
//output ana_stimu_ch_timer_TH,
//output ana_stimu_ch_counter_TH,
//output ana_comp_ch_intr_en,
//output ana_comp_ch_intr_trans_sel,
//output ana_comp_ch_intr_sts_clr,
//output ana_stimu_ch_intr_sts_clr,
//output anac_short_int_en,
//output anac_short_drive_en,
//output anac_short_leadoff_en,
//output anac_int_pol,

  input ana_lvd_intr_pin
//input counter_th_cnt_dbg,
//input ana_stimu_ch_intr_sts,
//input ana_comp_ch_intr_sts
);

modport slave (
  input ana_lvd_intr_en,
  input int_length_slct,
//input ana_stimu_ch_timer_TH,
//input ana_stimu_ch_counter_TH,
//input ana_comp_ch_intr_en,
//input ana_comp_ch_intr_trans_sel,
//input ana_comp_ch_intr_sts_clr,
//input ana_stimu_ch_intr_sts_clr,
//input anac_short_int_en,
//input anac_short_drive_en,
//input anac_short_leadoff_en,
//input anac_int_pol,

  output ana_lvd_intr_pin
//output counter_th_cnt_dbg,
//output ana_stimu_ch_intr_sts,
//output ana_comp_ch_intr_sts
);
endinterface

//interface spi_leadoff #(
//NO_OF_WAVEGEN = 8
//)();
//
////I
//wire [31:0]                 timer_cnt_tgt[NO_OF_WAVEGEN-1 :0];	
//wire [31:0]                 counter_th_tgt[NO_OF_WAVEGEN-1 :0];	
//wire [NO_OF_WAVEGEN-1 :0]   lead_off_stop_en;
//wire [NO_OF_WAVEGEN-1 :0 ]  lead_off_sts_clear;
//wire [NO_OF_WAVEGEN-1 :0 ]  dac_en_in;
//wire  			    sel_stim;
//wire [NO_OF_WAVEGEN-1 :0 ]  comp_low_en;
//wire                        int_length_slct;
//wire [NO_OF_WAVEGEN-1 :0]   lead_off_int_en;
//
//
////O
//wire [NO_OF_WAVEGEN-1 :0 ]  lead_off_stop;
//wire [NO_OF_WAVEGEN-1 :0 ]  lead_off_result;
//wire [31:0]                 lead_off_Counter_cnt_dac0_final_dbg [NO_OF_WAVEGEN-1 :0];
//wire [7:0]                 lead_off_Counter_cnt_dac0_dbg [NO_OF_WAVEGEN-1 :0];
//
//modport master(
////I
//output   timer_cnt_tgt,	
//output   counter_th_tgt,	
//output   lead_off_stop_en,
//output   lead_off_sts_clear,
//output   dac_en_in,
//output   sel_stim,
//output   comp_low_en,
//output   int_length_slct,
//output   lead_off_int_en,
//
//
////O
//input   lead_off_stop,
//input   lead_off_result,
//input   lead_off_Counter_cnt_dac0_final_dbg ,
//input   lead_off_Counter_cnt_dac0_dbg 
//
//);

//modport slave (
////I
//input   timer_cnt_tgt,	
//input   counter_th_tgt,	
//input   lead_off_stop_en,
//input   lead_off_sts_clear,
//input   dac_en_in,
//input   sel_stim,
//input   comp_low_en,
//input   int_length_slct,
//input   lead_off_int_en,
//
//
////O
//output   lead_off_stop,
//output   lead_off_result,
//output   lead_off_Counter_cnt_dac0_final_dbg ,
//output   lead_off_Counter_cnt_dac0_dbg 
//
//);
//
//
//
//
//endinterface

// Interface between PINMUX and ANA_WRAPPER
interface pinmux_if #(
  TRIM_NUMBER = 15,
  EN_SEC_NUMBER = 2,
  EN_REG_NUMBER = 1,
  ADJ_NUMBER = 15

//SPARE_NUMBER  = 3
) ();

//wire       [7:0]  D2A_TRIM_SIG_SPARE [SPARE_NUMBER-1:0];
  wire       [7:0]  D2A_ANA_ENABLE_REG [EN_SEC_NUMBER-1:0] [EN_REG_NUMBER-1:0];
  wire      [29:0]  D2A_ATM;                        //from pinmux to ana
//wire       [2:0]  ENCODED_ATM;                    //from pinmux to ana
  wire       [7:0]  D2A_TRIM_SIG [TRIM_NUMBER-1:0]; //from pinmux to ana 
  wire       [7:0]  D2A_ADJ_IO   [ADJ_NUMBER-1:0];  //from pinmux to ana 
  wire              ATM_HC_SEL;
//wire       [1:0]  A2D_TRIM_SIG [TRIM_NUMBER-1:0]; //from ana to pinmux 
  wire       [7:0]  d2a_tsc_vdac8b_din_ch1; 
//wire              d2a_tsc_vdac8b_en_ch1;  
//wire              d2a_tsc_comp_en_ch1;    
  wire              d2a_tsc_en_ch1;       
  wire              i_ds_driver_en_current;       
  wire              i_stimu_en;     
  wire							debug_mode_en;  
//wire              D2A_ANA_OUT_SEL1;
//wire              D2A_ANA_OUT_SEL2;
//wire              D2A_ANA_OUT_SEL3;
//wire              D2A_ANA_OUT_SEL4;
//wire              D2A_ANA_OUT_SEL5;
//wire              D2A_ANA_OUT_SEL6;
//wire              D2A_ANA_OUT_SEL7;  

modport A2D (
//input  D2A_TRIM_SIG_SPARE,
  input  D2A_ANA_ENABLE_REG,
//input  ENCODED_ATM,
  input  D2A_ATM,
  input  D2A_TRIM_SIG,
  input  D2A_ADJ_IO,
//output A2D_TRIM_SIG
  input  ATM_HC_SEL,
  input  d2a_tsc_vdac8b_din_ch1,
//input  d2a_tsc_vdac8b_en_ch1,
//input  d2a_tsc_comp_en_ch1,
  input  i_ds_driver_en_current,
  input  i_stimu_en,
  input  debug_mode_en,
  input  d2a_tsc_en_ch1


//input   D2A_ANA_OUT_SEL1,
//input   D2A_ANA_OUT_SEL2,
//input   D2A_ANA_OUT_SEL3,
//input   D2A_ANA_OUT_SEL4,
//input   D2A_ANA_OUT_SEL5,
//input   D2A_ANA_OUT_SEL6,
//input   D2A_ANA_OUT_SEL7
);

modport D2A (
//output D2A_TRIM_SIG_SPARE,
  output D2A_ANA_ENABLE_REG,
//output ENCODED_ATM,
  output D2A_ATM,
  output D2A_TRIM_SIG,
  output D2A_ADJ_IO,
//input  A2D_TRIM_SIG
  output ATM_HC_SEL,
  output d2a_tsc_vdac8b_din_ch1,
  output i_ds_driver_en_current,
  output i_stimu_en,
  output debug_mode_en,
//output d2a_tsc_vdac8b_en_ch1,
//output d2a_tsc_comp_en_ch1,
  output d2a_tsc_en_ch1

//output  D2A_ANA_OUT_SEL1,
//output  D2A_ANA_OUT_SEL2,
//output  D2A_ANA_OUT_SEL3,
//output  D2A_ANA_OUT_SEL4,
//output  D2A_ANA_OUT_SEL5,
//output  D2A_ANA_OUT_SEL6,
//output  D2A_ANA_OUT_SEL7
);
endinterface

// Interface between SPI and ANA_WRAPPER
interface spi_ana_if #(
  A2D_REG_NUMBER = 8,
  GEN_SEC_NUMBER = 8,
  REG_NUMBER = 15
) ();

//wire       ATM_HC_SEL;
wire [7:0] D2A_ANA_GEN_REG [GEN_SEC_NUMBER-1:0][REG_NUMBER-1:0];
wire [7:0] A2D_ANA_GEN_REG [A2D_REG_NUMBER-1:0];

modport spi (
//output ATM_HC_SEL,
  output D2A_ANA_GEN_REG,
  input  A2D_ANA_GEN_REG
);

modport ana (
//input  ATM_HC_SEL,
  input  D2A_ANA_GEN_REG,
  output A2D_ANA_GEN_REG
);
endinterface

// Interface between SPI and PINMUX
interface spi_pinmux_if #(
  EN_SEC_NUMBER = 2,
  EN_REG_NUMBER = 16
) ();

wire [7:0] ANA_ENABLE_REG [EN_SEC_NUMBER-1:0][EN_REG_NUMBER-1:0];
wire       ATM_HC_SEL;
wire       ANA_BIST_HC_SEL;
wire       INT_LEVEL_SEL;

modport spi (
  output ANA_ENABLE_REG,
  output ATM_HC_SEL,
  output INT_LEVEL_SEL,
  output ANA_BIST_HC_SEL
);

modport pinmux(
  input  ANA_ENABLE_REG,
  input  ATM_HC_SEL,
  input  INT_LEVEL_SEL,
  input  ANA_BIST_HC_SEL
);
endinterface

// Interface between ANA and NIRS
interface ana_nirs_if #(
  parameter NO_OF_NIRS = 8
)
();

wire  [8:0] IDAC_MANUAL_ATM;
wire        D2A_NIRS_POWER_EN;
wire        D2A_PDBIAS_EN;
wire  [1:0] D2A_PDBIAS_ADJ;
wire        D2A_CLK_NIRS;
wire        D2A_CHOPPER_EN;
wire  [1:0] D2A_FCHOP_ADJ;
wire        D2A_TEST_EN;

wire        D2A_NIRS_EN         [NO_OF_NIRS-1:0];
wire        D2A_IDAC_EN         [NO_OF_NIRS-1:0];
wire        D2A_NIRS_RESET_SW   [NO_OF_NIRS-1:0];
wire        D2A_NIRS_IPD_SW     [NO_OF_NIRS-1:0];
wire        D2A_NIRS_IIN_SW     [NO_OF_NIRS-1:0];
wire  [1:0] D2A_IPDMIRROR_ADJ   [NO_OF_NIRS-1:0]; //
wire  [1:0] D2A_IREFC_ADJ       [NO_OF_NIRS-1:0]; //
wire  [8:0] D2A_NIRS_IDAC       [NO_OF_NIRS-1:0];
wire  [1:0] D2A_NIRS_RATIO      [NO_OF_NIRS-1:0];
wire        A2D_NIRS_IREFCOARSE [NO_OF_NIRS-1:0];
wire        A2D_NIRS_IREFFINE   [NO_OF_NIRS-1:0];


modport nirs (
  output    IDAC_MANUAL_ATM,
  output    D2A_NIRS_POWER_EN,
  output    D2A_PDBIAS_EN,
  output    D2A_NIRS_EN,
  output    D2A_CLK_NIRS,
  output    D2A_NIRS_RESET_SW,
  output    D2A_NIRS_IPD_SW,
  output    D2A_NIRS_IIN_SW,
  output    D2A_NIRS_IDAC,
  output    D2A_IDAC_EN,
  output    D2A_NIRS_RATIO,
  input     A2D_NIRS_IREFCOARSE,
  input     A2D_NIRS_IREFFINE,
  output    D2A_PDBIAS_ADJ,
  output    D2A_FCHOP_ADJ,
  output    D2A_CHOPPER_EN,
  output    D2A_TEST_EN,
  output    D2A_IPDMIRROR_ADJ,
  output    D2A_IREFC_ADJ
);

modport ana (
  input     IDAC_MANUAL_ATM,
  input     D2A_NIRS_POWER_EN,
  input     D2A_PDBIAS_EN,
  input     D2A_NIRS_EN,
  input     D2A_CLK_NIRS,
  input     D2A_NIRS_RESET_SW,
  input     D2A_NIRS_IPD_SW,
  input     D2A_NIRS_IIN_SW,
  input     D2A_NIRS_IDAC,
  input     D2A_IDAC_EN,
  input     D2A_NIRS_RATIO,
  output    A2D_NIRS_IREFCOARSE,
  output    A2D_NIRS_IREFFINE,
  input     D2A_PDBIAS_ADJ,
  input     D2A_FCHOP_ADJ,
  input     D2A_CHOPPER_EN,
  input     D2A_TEST_EN,
  input     D2A_IPDMIRROR_ADJ,
  input     D2A_IREFC_ADJ
);
endinterface

// Interface between SPI and NIRS
interface spi_nirs_if #(

  parameter NO_OF_NIRS = 8
)
();

  wire              [5:0] NIRS_CTRL_MODE      [NO_OF_NIRS-1:0];
  wire              [1:0] NIRS_CTRL_CMD       [NO_OF_NIRS-1:0];
  wire              [7:0] NIRS_CTRL_INT       [NO_OF_NIRS-1:0];
  wire   [NO_OF_NIRS-1:0] NIRS_INT_CLR;
  wire              [7:0] NIRS_CTRL           [NO_OF_NIRS-1:0][1:0][8:0]; // NO_OF_NIRS channels, 14 regs each channel, 8 bits each reg
  wire              [7:0] NIRS_CTRL_ADJ;
  wire              [7:0] NIRS_DOUT           [NO_OF_NIRS-1:0][3:0];
  wire              [7:0] NIRS_DEBUG          [NO_OF_NIRS-1:0][4:0];
  wire   [NO_OF_NIRS-1:0] NIRS_INT;


modport nirs (
  input   NIRS_CTRL_MODE,
  input   NIRS_CTRL_CMD,
  input   NIRS_CTRL_INT,
  input   NIRS_INT_CLR,
  input   NIRS_CTRL,
  input   NIRS_CTRL_ADJ,
  output  NIRS_DOUT,
  output  NIRS_DEBUG,
  output  NIRS_INT
);

modport spi (
  output  NIRS_CTRL_MODE,
  output  NIRS_CTRL_CMD,
  output  NIRS_CTRL_INT,
  output  NIRS_INT_CLR,
  output  NIRS_CTRL,
  output  NIRS_CTRL_ADJ,
  input   NIRS_DOUT,
  input   NIRS_DEBUG,
  input   NIRS_INT
);
endinterface
