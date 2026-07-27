//------------------------------------------------------------------------------
// Nanochap Pty Ltd (c) 2021
//
// Module Name : io_buf_config
// Description : io_buffer_configuartion file 
//------------------------------------------------------------------------------
// Revision History
//------------------------------------------------------------------------------
// Revision     Date        Author
//------------------------------------------------------------------------------
// 0.1          25/10/2021  Jayanthi 
// Initial Rev
//------------------------------------------------------------------------------

`timescale 1ns/1ps


module pinmux (
	output      [18:0]  o_baf4p1_IOBUF_IE,
	output      [18:0]  o_baf4p1_IOBUF_A,
	output      [18:0]  o_baf4p1_IOBUF_OE,
 	input       [18:0]  i_baf4p1_IOBUF_Y,	 		
        
  //spi 
	output wire         sclk,
	output wire         cs_n,
	output wire         mosi,
	input  wire         miso,
  input  wire         i_LED_STATUS,
	
// scan
	output wire         atpg_en,                    // atpg enable
	output wire         scan_rst_n,                 // scan resetn
	output wire         scan_clk,                   // scan clock
	output wire         scan_en,                    // scan enable
	output wire  [7:0]  scan_in,                    // scan in
	input  wire  [7:0]  scan_out,                   // scan out
  output wire         scan_compression_in,
	
// flash bist
	
	output wire         flash_bist_en,              // flash bist enable  
	output wire         flash_bist_resetn,          // flash bist reset
	output wire         flash_bist_tck,             // flash bist TCK
	output wire         flash_bist_tdi,             // flash bist serial in data
	input  wire         flash_bist_oen,             // flash bist TDO output enable, low-active, no used 
	input  wire         flash_bist_tdo,             // flash bist TDO

//added by supriya
	input  wire 	      iopad_testmode0_en_y,
	input  wire 	      iopad_testmode1_en_y,
	input  wire 	      iopad_resetn_y,

//interrupts
//zmeas
	input  wire 	      zmeas_int,
	input  wire 	      zmeas_adc_int,
//imeas
 	input  wire 	      imeas_int,
  input  wire 	      imeas_int_alarm,
  input  wire	        fifo_intr,
  input  wire         SDM_CLK_GPIO,
//spi: ask jaya
//fifo: ask Daniel

//testmode
	input  wire 	      imeas_adc_clk,    //SDM_CLK_REG
//output wire         SDM_OUT,
	output wire	        pin_rstn,
	output wire	        ATM0,	
  output wire	        ATM1,
  output wire	        ATM2,
  output wire	        ATM3,
  output wire	        ATM4,
  output wire	        ATM5,
  output wire	        ATM6,
  output wire	        ATM7,
  output wire	        ATM8,
  output wire         ATM9,
  output wire         ATM10,
  output wire         ATM11,
  output wire         ATM12,

  //ATM0 - test mode 2
  output wire  [7:0]  DCLEADOFF_COMP_TH,
  output wire  [7:0]  DCLEADOFF_ISEL,
  output wire         DCLEADOFF_VINFLIP,
  output wire         DCLEADOFF_EN,
  output wire         DCLEADOFF_RMODE_EN,
  input  wire         LOFF_STATN,
  input  wire         LOFF_STATP,

  input  wire  [7:0]  DCLEADOFF_COMP_TH_REG,     
  input  wire  [7:0]  DCLEADOFF_ISEL_REG,        
  input  wire         DCLEADOFF_VINFLIP_REG,
  input  wire         DCLEADOFF_EN_REG,
  input  wire         DCLEADOFF_RMODE_EN_REG,

  //ATM1 - test mode 3 
  output wire [11:0]  PPGDAC1_VSEL,
  output wire         PPGDAC1_EN,
  output wire         EN_PPGDAC_BUFFER,
  output wire         LED_EN,
  output wire  [1:0]  LED_SEL,
  output wire         LEDDAC_SEL,
  output wire         LED_STANDBYEN,

  input  wire [11:0]  PPGDAC1_VSEL_REG,
  input  wire         PPGDAC1_EN_REG,
  input  wire         EN_PPGDAC_BUFFER_REG,
  input  wire         LED_EN_REG,
  input  wire  [1:0]  LED_SEL_REG,
  input  wire         LEDDAC_SEL_REG,
  input  wire         LED_STANDBYEN_REG,

  //ATM2 - test mode 4
  output wire  [2:0]  SDA_VIN_SEL,    //SDM_VIN_SEL
  output wire         SDM_EN,
  output wire         SDM_CLK,
  output wire  [1:0]  SDM_BIAS,
  output wire         BG1P2_BUF_EN,
  input  wire         imeas_adc_din,  //SDM_OUT 

  input  wire  [2:0]  SDA_VIN_SEL_REG,  
  input  wire         SDM_EN_REG,
  input  wire  [1:0]  SDM_BIAS_REG,
  input  wire         BG1P2_BUF_EN_REG,

  //ATM3 - test mode 5
  output wire         DDA_EN,	      
  output wire         PGA_EN,
  output wire         LPF_EN,
  output wire         DDACHOP_EN,
  output wire  [1:0]  DDA_CLKSEL,
  output wire  [2:0]  PGA_SEL,       
	output wire  [2:0]  DDA_GSEL,		
  output wire  [1:0]  DDA_ISEL,
  output wire         VCM1P5_BUF_EN,

	input  wire 	      DDA_EN_REG,
  input  wire 	      PGA_EN_REG,
  input  wire 	      LPF_EN_REG,
  input  wire 	      DDACHOP_EN_REG,
  input  wire  [1:0]  DDA_CLKSEL_REG,
  input  wire  [2:0]  PGA_SEL_REG,
  input  wire  [2:0]  DDA_GSEL_REG,
  input  wire  [1:0]  DDA_ISEL_REG,
  input  wire         VCM1P5_BUF_EN_REG,

  //ATM4 - test mode 6
  output wire  [3:0]  TIA_GAIN,
  output wire         PPG_SH_CK,
  output wire  [7:0]  TIA_IDAC,
  output wire         EN_TIA,
  output wire  [1:0]  PPG_TEST_IN,
  output wire         EN_PPG_SH,
  output wire         EN_PPG_AF,
  output wire         EN_PPG_BUFFER,
  output wire         EN_TIA_VREFBUFFER,
  output wire  [1:0]  PPG_TEST_OUT,
  output wire  [1:0]  PDVREF_SEL,

  input  wire  [3:0]  TIA_GAIN_REG,
  input  wire         PPG_SH_CK_REG,
  input  wire  [7:0]  TIA_IDAC_REG,
  input  wire         EN_TIA_REG,
  input  wire  [1:0]  PPG_TEST_IN_REG,
  input  wire         EN_PPG_SH_REG,
  input  wire         EN_PPG_AF_REG,
  input  wire         EN_PPG_BUFFER_REG,
  input  wire         EN_TIA_VREFBUFFER_REG,
  input  wire  [1:0]  PPG_TEST_OUT_REG,
  input  wire  [1:0]  PDVREF_SEL_REG,

  //ATM5 - test mode 7
	output wire  [7:0]  BGH_CTRIM,
	output wire  [7:0]  BGH_VTRIM,		//flash_to_ana_bgl_vtrim
  output wire  [7:0]  LDO1V5_VTRIM,
  output wire         BIST_EN,

  input  wire  [7:0]  BGH_CTRIM_REG,
  input  wire  [7:0]  BGH_VTRIM_REG,  //flash_to_ana_bgl_vtrim,
  input  wire  [7:0]  LDO1V5_VTRIM_REG,
  input  wire         BIST_EN_REG,

  //ATM6 - test mode 8 - T_Sensor
  output wire  [2:0]  TSC_BJT_SEL,
  output wire         TSC_OUT_SEL,
  output wire         TSC_EN,
  output wire  [2:0]  TSC_INA_GSEL,
  output wire         TSC_INA_EN,

  input  wire  [2:0]  TSC_BJT_SEL_REG,
  input  wire         TSC_OUT_SEL_REG,
  input  wire         TSC_EN_REG,
  input  wire  [2:0]  TSC_INA_GSEL_REG,
  input  wire         TSC_INA_EN_REG,

  //ATM7 - test mode 9
  output wire  [9:0]  DDS,
  output wire  [1:0]  Z_TX_GSEL,
  output wire         Z_EN,
  output wire         Z_CLK256K,
  output wire         Z_CALMD,

  input  wire  [9:0]  DDS_REG,
  input  wire  [1:0]  Z_TX_GSEL_REG,
  input  wire         Z_EN_REG,
  input  wire         Z_CLK256K_REG,
  input  wire         Z_CALMD_REG,

  //ATM8 - test mode 10
  output wire  [9:0]  ECGCAL_VSEL,
  output wire         ECGCAL_EN,

  input  wire  [9:0]  ECGCAL_VSEL_REG,
  input  wire         ECGCAL_EN_REG,
  
  //ATM9 - test mode 11
  output wire         RLD_CHOP_EN,
  output wire         ELECTRODE_EN,
  output wire         RLD_CLK64K,
  output wire         RLD_EN,

  input  wire         RLD_CHOP_EN_REG,
  input  wire         ELECTRODE_EN_REG,
  input  wire         RLD_CLK64K_REG,
  input  wire         RLD_EN_REG,

  //ATM10 - test mode 12
  output wire  [7:0]  OSC_TRIM,         //flash_to_ana_osc_trim //?????????????????default values and Z_MEAS/Z_CAL are pure analog 
  output wire  [7:0]  OSC_ISEL_TRIM,
  input  wire	        OSC_OUT,		      //hfosc	//??????????????????

  input  wire  [7:0]  OSC_TRIM_REG,		  //flash_to_ana_osc_trim  
  input  wire  [7:0]  OSC_ISEL_TRIM_REG,

  //ATM11 - test mode 13
  output wire [11:0]  PPGDAC0_VSEL,
  output wire         PPGDAC0_EN,

  input  wire [11:0]  PPGDAC0_VSEL_REG,
  input  wire         PPGDAC0_EN_REG,

  //ATM12 - test mode 14
  output wire  [7:0]  ACLEADOFF_VTHNSEL_TRIM,
  output wire  [7:0]  ACLEADOFF_VTHPSEL_TRIM,
  output wire         ACLEADOFF_CLK,
  output wire         ACLEADOFF_EN,
  output wire  [7:0]  ACLEADOFF_ISEL_TRIM,
  input  wire         ACLEADOFF_STATN,
  input  wire         ACLEADOFF_STATP,

  input  wire  [7:0]  ACLEADOFF_VTHNSEL_TRIM_REG,
  input  wire  [7:0]  ACLEADOFF_VTHPSEL_TRIM_REG,
  input  wire         ACLEADOFF_CLK_REG,
  input  wire         ACLEADOFF_EN_REG,
  input  wire  [7:0]  ACLEADOFF_ISEL_TRIM_REG
 );

//
wire        scan_mode; 
wire        mbist_mode;
wire        debug_mode_en;
wire  [3:0] ana_test_mode;
wire  [3:0] test_sel;
wire        ATM_CONFG;
wire        test_en;
wire  [3:0] wire_baf4p1_IOBUF_Y; 
wire        INTB;

// ATM0 -test2
wire  [2:0] pad_DCLEADOFF_COMP_TH;
wire  [2:0] pad_DCLEADOFF_ISEL;
wire        pad_DCLEADOFF_VINFLIP;
wire        pad_DCLEADOFF_EN;
wire        pad_DCLEADOFF_RMODE_EN;

// ATM1 - test3
wire [11:0] pad_PPGDAC1_VSEL;
wire        pad_LEDDAC_SEL0;
wire        pad_LED_EN0;
wire        pad_LED_SEL0;


// ATM2 -test4
wire  [2:0] pad_SDA_VIN_SEL0;
wire        pad_SDM_EN;
wire        pad_SDM_CLK0;
wire  [1:0] pad_SDM_BIAS;
wire        pad_BG1P2_BUF_EN;
wire        pad_VCM1P5_BUF_EN0;

// ATM3 - test5
wire        pad_DDA_EN;
wire        pad_PGA_EN;
wire        pad_LPF_EN;
wire        pad_DDACHOP_EN;
wire        pad_SDM_CLK1;
wire  [1:0] pad_DDA_CLKSEL;
wire  [2:0] pad_PGA_SEL;
wire  [2:0] pad_DDA_GSEL;
wire  [1:0] pad_DDA_ISEL;
wire        pad_VCM1P5_BUF_EN1;

// ATM4 - test6
wire  [2:0] pad_SDA_VIN_SEL1;
wire  [3:0] pad_TIA_GAIN;
wire        pad_PPG_SH_CK;
wire        pad_TIA_IDAC_0;
wire  [3:0] pad_TIA_IDAC_74;
wire  [1:0] pad_PPG_TEST_IN;

// ATM5 -test7
wire  [6:0] pad_BGH_CTRIM;
wire  [4:0] pad_BGH_VTRIM;
wire  [1:0] pad_LDO1V5_VTRIM;
wire        pad_VCM1P5_BUF_EN2;

// ATM6 - test8
wire  [2:0] pad_TSC_BJT_SEL;
wire        pad_TSC_OUT_SEL;
wire  [2:0] pad_SDA_VIN_SEL2;
wire        pad_TSC_EN;
wire  [2:0] pad_TSC_INA_GSEL;
wire        pad_VCM1P5_BUF_EN3;
wire        pad_TSC_INA_EN;

// ATM7 - test9
wire  [9:0] pad_DDS;
wire  [1:0] pad_Z_TX_GSEL;
wire        pad_Z_EN;
wire        pad_Z_CLK256K0;
wire        pad_Z_CALMD;

// ATM8 - test10
wire  [9:0] pad_ECGCAL_VSEL;
wire        pad_ECGCAL_EN;
wire        pad_VCM1P5_BUF_EN4;


// ATM9 - test11
wire        pad_RLD_CHOP_EN;
wire        pad_ELECTRODE_EN;
wire        pad_RLD_CLK64K;
wire        pad_RLD_EN;
wire        pad_VCM1P5_BUF_EN5;

// ATM10 - test12
wire  [5:0] pad_OSC_TRIM;
wire        pad_OSC_ISEL_TRIM;

// ATM11 - test13
wire [11:0] pad_PPGDAC0_VSEL;
wire        pad_LEDDAC_SEL1;
wire        pad_LED_EN1;
wire        pad_LED_SEL1;

// ATM12 - test14
wire  [2:0] pad_ACLEADOFF_VTHNSEL_TRIM;
wire  [2:0] pad_ACLEADOFF_VTHPSEL_TRIM;
wire        pad_ACLEADOFF_CLK;
wire        pad_ACLEADOFF_EN;
wire  [1:0] pad_ACLEADOFF_ISEL_TRIM;
wire        pad_VCM1P5_BUF_EN6;


assign pin_rstn           = iopad_resetn_y;
assign scan_rst_n         = pin_rstn;
assign flash_bist_resetn  = pin_rstn;

wire scan_mode_tmp;
assign scan_mode_tmp = (~iopad_testmode1_en_y &  iopad_testmode0_en_y)  ? 1'b1 : 1'b0;
assign flash_bist_en = (iopad_testmode1_en_y  &  ~iopad_testmode0_en_y) ? 1'b1 : 1'b0;
assign debug_mode_en = (iopad_testmode1_en_y  &  iopad_testmode0_en_y)  ? 1'b1 : 1'b0;

cell_buf u_scan_mode (.A(scan_mode_tmp),.Y(scan_mode));  //Tri add
assign atpg_en = scan_mode;


//assign test_sel = {iopad_testmode1_en_y ,iopad_testmode0_en_y};
assign test_en  = (scan_mode | flash_bist_en | debug_mode_en) ? 1'b1 : 1'b0;

//GPIO9,GPIO8,GPIO7,GPIO6
assign ana_test_mode   = debug_mode_en ? ({wire_baf4p1_IOBUF_Y[3],  wire_baf4p1_IOBUF_Y[2],   wire_baf4p1_IOBUF_Y[1],   wire_baf4p1_IOBUF_Y[0]}) : 4'b0; 

//outputs to analog 
assign ATM0	 = (ana_test_mode == 4'b0001)  ? 1'b1 : 1'b0;  	
assign ATM1	 = (ana_test_mode == 4'b0010)  ? 1'b1 : 1'b0; 
assign ATM2	 = (ana_test_mode == 4'b0011)  ? 1'b1 : 1'b0;
assign ATM3	 = (ana_test_mode == 4'b0100)  ? 1'b1 : 1'b0;
assign ATM4	 = (ana_test_mode == 4'b0101)  ? 1'b1 : 1'b0;
assign ATM5	 = (ana_test_mode == 4'b0110)  ? 1'b1 : 1'b0;
assign ATM6	 = (ana_test_mode == 4'b0111)  ? 1'b1 : 1'b0;
assign ATM7	 = (ana_test_mode == 4'b1000)  ? 1'b1 : 1'b0;
assign ATM8	 = (ana_test_mode == 4'b1001)  ? 1'b1 : 1'b0;
assign ATM9	 = (ana_test_mode == 4'b1010)  ? 1'b1 : 1'b0;
assign ATM10 = (ana_test_mode == 4'b1011)  ? 1'b1 : 1'b0;
assign ATM11 = (ana_test_mode == 4'b1100)  ? 1'b1 : 1'b0;
assign ATM12 = (ana_test_mode == 4'b1101)  ? 1'b1 : 1'b0;

assign ATM_CONFG =  debug_mode_en ? 1'b1 : 1'b0;

assign test_sel = ((scan_mode     == 1'b1)  ? 4'b0000 : 
		               (flash_bist_en == 1'b1)  ? 4'b0001 : 
		               (ana_test_mode == 4'd1)  ? 4'b0010 :
		               (ana_test_mode == 4'd2)  ? 4'b0011 :
                   (ana_test_mode == 4'd3)  ? 4'b0100 :
                   (ana_test_mode == 4'd4)  ? 4'b0101 :
                   (ana_test_mode == 4'd5)  ? 4'b0110 :
                   (ana_test_mode == 4'd6)  ? 4'b0111 :
                   (ana_test_mode == 4'd7)  ? 4'b1000 :
                   (ana_test_mode == 4'd8)  ? 4'b1001 :
                   (ana_test_mode == 4'd9)  ? 4'b1010 : 
                   (ana_test_mode == 4'd10) ? 4'b1011 : 
                   (ana_test_mode == 4'd11) ? 4'b1100 : 
                   (ana_test_mode == 4'd12) ? 4'b1101 :
                   (ana_test_mode == 4'd13) ? 4'b1110 :4'b1111);

// non-scan pad
// pad->core force to 0 in scan mode
// assign i_baf4p1_IOBUF6_Y  = ~scan_mode  &  i_baf4p1_IOBUF_Y[6]; 
// assign i_baf4p1_IOBUF7_Y  = ~scan_mode  &  i_baf4p1_IOBUF_Y[7];  
// assign i_baf4p1_IOBUF8_Y  = ~scan_mode  &  i_baf4p1_IOBUF_Y[8];  
// assign i_baf4p1_IOBUF9_Y  = ~scan_mode  &  i_baf4p1_IOBUF_Y[9];  
// assign i_baf4p1_IOBUF10_Y = ~scan_mode  &  i_baf4p1_IOBUF_Y[10]; 
// assign i_baf4p1_IOBUF15_Y = ~scan_mode  &  i_baf4p1_IOBUF_Y[15]; 
// assign i_baf4p1_IOBUF16_Y = ~scan_mode  &  i_baf4p1_IOBUF_Y[16]; 
// assign i_baf4p1_IOBUF17_Y = ~scan_mode  &  i_baf4p1_IOBUF_Y[17];    
// assign i_baf4p1_IOBUF18_Y = ~scan_mode  &  i_baf4p1_IOBUF_Y[18];  
   
//combine interrupt
assign INTB	= (zmeas_int | zmeas_adc_int | imeas_int | imeas_int_alarm | fifo_intr);

assign BIST_EN  = debug_mode_en  ? 1'b0 : BIST_EN_REG;

// ATM0
assign DCLEADOFF_COMP_TH  = ATM0 ? {{5'b0}, pad_DCLEADOFF_COMP_TH}  : DCLEADOFF_COMP_TH_REG;
assign DCLEADOFF_ISEL     = ATM0 ? {{5'b0}, pad_DCLEADOFF_ISEL}     : DCLEADOFF_ISEL_REG;
assign DCLEADOFF_VINFLIP  = ATM0 ? pad_DCLEADOFF_VINFLIP            : DCLEADOFF_VINFLIP_REG;
assign DCLEADOFF_EN       = ATM0 ? pad_DCLEADOFF_EN                 : DCLEADOFF_EN_REG;
assign DCLEADOFF_RMODE_EN = ATM0 ? pad_DCLEADOFF_RMODE_EN           : DCLEADOFF_RMODE_EN_REG;

// ATM1 & ATM9
assign PPGDAC1_VSEL       = ATM1 ? pad_PPGDAC1_VSEL        : PPGDAC1_VSEL_REG;
assign LEDDAC_SEL         = ATM1 ? pad_LEDDAC_SEL0         : ATM11 ? pad_LEDDAC_SEL1 : LEDDAC_SEL_REG;

assign LED_EN             = ATM1 ? pad_LED_EN0             : ATM11 ? pad_LED_EN1   : LED_EN_REG;
assign LED_SEL[0]         = ATM1 ? 1'b0                    : ATM11 ? 1'b0          : LED_SEL_REG[0];
assign LED_SEL[1]         = ATM1 ? pad_LED_SEL0            : ATM11 ? pad_LED_SEL1  : LED_SEL_REG[1];  
assign LED_STANDBYEN      = ATM1 ? 1'b1                    : ATM11 ? 1'b1          : LED_STANDBYEN_REG;
assign PPGDAC1_EN         = ATM1 ? 1'b1                    : PPGDAC1_EN_REG;
assign EN_PPGDAC_BUFFER   = ATM1 ? 1'b1                    : ATM11 ? 1'b1             : EN_PPGDAC_BUFFER_REG;

// ATM2
assign SDA_VIN_SEL        = ATM2 ? pad_SDA_VIN_SEL0        : ATM4 ? pad_SDA_VIN_SEL1  : ATM6 ? pad_SDA_VIN_SEL2 : SDA_VIN_SEL_REG;
assign SDM_EN             = ATM2 ? pad_SDM_EN              : SDM_EN_REG;
assign SDM_CLK            = ATM2 ? pad_SDM_CLK0            : ATM3 ? pad_SDM_CLK1      : imeas_adc_clk;
assign SDM_BIAS           = ATM2 ? pad_SDM_BIAS            : SDM_BIAS_REG;
assign BG1P2_BUF_EN       = ATM2 ? pad_BG1P2_BUF_EN        : BG1P2_BUF_EN_REG;

// ATM3
assign DDA_EN             = ATM3 ? pad_DDA_EN              : DDA_EN_REG;
assign PGA_EN             = ATM3 ? pad_PGA_EN              : PGA_EN_REG;
assign LPF_EN             = ATM3 ? pad_LPF_EN              : LPF_EN_REG;
assign DDACHOP_EN         = ATM3 ? pad_DDACHOP_EN          : DDACHOP_EN_REG;
assign DDA_CLKSEL         = ATM3 ? pad_DDA_CLKSEL          : DDA_CLKSEL_REG;
assign PGA_SEL            = ATM3 ? pad_PGA_SEL             : PGA_SEL_REG;
assign DDA_GSEL           = ATM3 ? pad_DDA_GSEL            : DDA_GSEL_REG;
assign DDA_ISEL           = ATM3 ? 2'b00                   : DDA_ISEL_REG;
assign VCM1P5_BUF_EN      = ATM2 ? pad_VCM1P5_BUF_EN0      : ATM3 ? pad_VCM1P5_BUF_EN1  : ATM5 ? pad_VCM1P5_BUF_EN2 : 
                            ATM6 ? pad_VCM1P5_BUF_EN3      : ATM8 ? pad_VCM1P5_BUF_EN4  : 
                            ATM9 ? pad_VCM1P5_BUF_EN5      : ATM12 ? pad_VCM1P5_BUF_EN6 : VCM1P5_BUF_EN_REG;

// ATM4
assign TIA_GAIN           = ATM4 ? pad_TIA_GAIN            : TIA_GAIN_REG;
assign PPG_SH_CK          = ATM4 ? pad_PPG_SH_CK           : PPG_SH_CK_REG;
assign TIA_IDAC[0]        = ATM4 ? pad_TIA_IDAC_0          : TIA_IDAC_REG[0];
assign TIA_IDAC[3:1]      = ATM4 ? 3'd0                    : TIA_IDAC_REG[3:1];
assign TIA_IDAC[7:4]      = ATM4 ? pad_TIA_IDAC_74         : TIA_IDAC_REG[7:4];
assign EN_TIA             = ATM4 ? 1'b1                    : EN_TIA_REG;
assign PPG_TEST_IN        = ATM4 ? pad_PPG_TEST_IN         : PPG_TEST_IN_REG;
assign EN_PPG_SH          = ATM4 ? 1'b1                    : EN_PPG_SH_REG;
assign EN_PPG_AF          = ATM4 ? 1'b1                    : EN_PPG_AF_REG;
assign EN_PPG_BUFFER      = ATM4 ? 1'b1                    : EN_PPG_BUFFER_REG;
//assign EN_TIA_VREFBUFFER  = ATM1 ? 1'b1                    : ATM4 ? 1'b1        : EN_TIA_VREFBUFFER_REG;
assign EN_TIA_VREFBUFFER  = ATM1 ? 1'b1                    : ATM4 ? 1'b1        : 
			    ATM11 ? 1'b1 : EN_TIA_VREFBUFFER_REG;
assign PPG_TEST_OUT       = ATM4 ? 2'd0                    : PPG_TEST_OUT_REG;
//assign PDVREF_SEL         = ATM4 ? 2'd0                    : PDVREF_SEL_REG;
assign PDVREF_SEL         = ATM4 ? 2'b10                    : PDVREF_SEL_REG;

// ATM5
assign BGH_CTRIM	        = ATM5 ? {{1'b0}, pad_BGH_CTRIM}        : BGH_CTRIM_REG;
assign BGH_VTRIM	        = ATM5 ? {{3{1'b0}}, pad_BGH_VTRIM}     : BGH_VTRIM_REG;
assign LDO1V5_VTRIM	      = ATM5 ? {{6{1'b0}}, pad_LDO1V5_VTRIM}  : LDO1V5_VTRIM_REG;

// ATM6
assign TSC_BJT_SEL        = ATM6 ? pad_TSC_BJT_SEL         : TSC_BJT_SEL_REG;
assign TSC_OUT_SEL        = ATM6 ? pad_TSC_OUT_SEL         : TSC_OUT_SEL_REG;
assign TSC_EN             = ATM6 ? pad_TSC_EN              : TSC_EN_REG;
assign TSC_INA_GSEL       = ATM6 ? pad_TSC_INA_GSEL        : TSC_INA_GSEL_REG;
assign TSC_INA_EN         = ATM6 ? pad_TSC_INA_EN          : TSC_INA_EN_REG;

// ATM7
assign DDS                = ATM7 ? pad_DDS                 : DDS_REG;
assign Z_TX_GSEL          = ATM7 ? pad_Z_TX_GSEL           : Z_TX_GSEL_REG;
assign Z_EN               = ATM7 ? pad_Z_EN                : Z_EN_REG;
assign Z_CLK256K          = ATM7 ? pad_Z_CLK256K0          : Z_CLK256K_REG;
assign Z_CALMD            = ATM7 ? pad_Z_CALMD             : Z_CALMD_REG;

// ATM8
assign ECGCAL_VSEL        = ATM8 ? pad_ECGCAL_VSEL         : ECGCAL_VSEL_REG;
assign ECGCAL_EN          = ATM8 ? pad_ECGCAL_EN           : ECGCAL_EN_REG;

// ATM9
assign RLD_CHOP_EN        = ATM9 ? pad_RLD_CHOP_EN         : RLD_CHOP_EN_REG;
assign ELECTRODE_EN      = ATM9 ?  pad_ELECTRODE_EN        : ELECTRODE_EN_REG;
assign RLD_CLK64K         = ATM9 ? pad_RLD_CLK64K          : RLD_CLK64K_REG;
assign RLD_EN             = ATM9 ? pad_RLD_EN              : RLD_EN_REG;

// ATM10
assign OSC_TRIM	          = ATM10 ? {{2{1'b0}}, pad_OSC_TRIM}       : OSC_TRIM_REG;
assign OSC_ISEL_TRIM      = ATM10 ? {{7{1'b0}}, pad_OSC_ISEL_TRIM}  :  OSC_ISEL_TRIM_REG;

// ATM11
assign PPGDAC0_EN         = ATM11 ? 1'b1                   : PPGDAC0_EN_REG;
assign PPGDAC0_VSEL       = ATM11 ? pad_PPGDAC0_VSEL       : PPGDAC0_VSEL_REG;

// ATM12
assign ACLEADOFF_VTHNSEL_TRIM = ATM12 ? {5'b0, pad_ACLEADOFF_VTHNSEL_TRIM} : ACLEADOFF_VTHNSEL_TRIM_REG;
assign ACLEADOFF_VTHPSEL_TRIM = ATM12 ? {5'b0, pad_ACLEADOFF_VTHPSEL_TRIM} : ACLEADOFF_VTHPSEL_TRIM_REG;
assign ACLEADOFF_CLK          = ATM12 ? pad_ACLEADOFF_CLK                  : ACLEADOFF_CLK_REG;
assign ACLEADOFF_EN           = ATM12 ? pad_ACLEADOFF_EN                   : ACLEADOFF_EN_REG;
assign ACLEADOFF_ISEL_TRIM    = ATM12 ? {6'b0, pad_ACLEADOFF_ISEL_TRIM}    : ACLEADOFF_ISEL_TRIM_REG;

//Supriya:Added
// GPIO0 pad
// alt0  : cs_n 
// test0 : scan_out[0] 
// test1 : none
// test2 : ATM0  
// test3 : ATM1
// test4 : ATM2
// test5 : ATM3
// test6 : ATM4
// test7 : ATM5
// test8 : ATM6
// test9 : ATM7
// test10: ATM8
// test11: ATM9
// test12: ATM10
// test13: ATM11
// test14: ATM12
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio0_pinmux (
// test and alternate select
.altf_sel   (1'b0),			//enable alternate function
.test_sel   (test_sel),			//4'd2
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (1'b0),
.test2_en   (ATM0),			//ATM_CONFG
.test3_en   (ATM1),
.test4_en   (ATM2),
.test5_en   (ATM3),
.test6_en   (ATM4),
.test7_en   (ATM5),
.test8_en   (ATM6),
.test9_en   (ATM7),
.test10_en  (ATM8),
.test11_en  (ATM9),
.test12_en  (ATM10),
.test13_en  (ATM11),
.test14_en  (ATM12),  
.test_ana   (1'b0),  			//Disable IE/OE/A:: TESTMODE0 GPIO0 serves pure analog signal
// alternate function
// altf0
.altf0_ie   (1'b1),
.altf0_oe   (1'b0),
.altf0_a    (1'b0),
.altf0_def  (1'b0),
.altf0_y    (cs_n),
// test mode function
// test0
.test0_ie   (1'b0),
.test0_oe   (1'b1),
.test0_a    (scan_out[0]),
.test0_def  (1'b0),
.test0_y    (),
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),
// test2
.test2_ie   (1'b1),
.test2_oe   (1'b0),
.test2_a    (1'b0),
.test2_def  (1'b0),
.test2_y    (pad_DCLEADOFF_COMP_TH[1]),
// test3
.test3_ie   (1'b1),
.test3_oe   (1'b0),
.test3_a    (1'b0),
.test3_def  (1'b0),
.test3_y    (pad_PPGDAC1_VSEL[8]),
// test4
.test4_ie   (1'b1),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (pad_SDA_VIN_SEL0[2]),
// test5
.test5_ie   (1'b1),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (pad_DDA_EN),
// test6
.test6_ie   (1'b1),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (pad_SDA_VIN_SEL1[1]),
// test7
.test7_ie   (1'b1),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (pad_BGH_CTRIM[3]),
// test8
.test8_ie   (1'b1),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (pad_TSC_BJT_SEL[0]),
// test9
.test9_ie   (1'b1),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (pad_DDS[8]),
// test10
.test10_ie   (1'b1),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (pad_ECGCAL_VSEL[5]),
// test11
.test11_ie   (1'b1),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (pad_RLD_CHOP_EN),
// test12
.test12_ie   (1'b1),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (pad_OSC_TRIM[5]),
// test13
.test13_ie   (1'b1),
.test13_oe   (1'b0),
.test13_a    (1'b0),
.test13_def  (1'b0),
.test13_y    (pad_PPGDAC0_VSEL[8]),
//test14
.test14_ie   (1'b1),
.test14_oe   (1'b0),
.test14_a    (1'b0),
.test14_def  (1'b0),
.test14_y    (pad_ACLEADOFF_VTHNSEL_TRIM[0]),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[0]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[0]),
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[0]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[0])
); 


// GPIO1 pad
// alt0  : MOSI 
// test0 : scan_out[1]     
// test1 : flash_bist_tdi
// test2 : ATM0  
// test3 : ATM1
// test4 : ATM2
// test5 : ATM3
// test6 : ATM4
// test7 : ATM5
// test8 : ATM6
// test9 : ATM7
// test10: ATM8
// test11: None
// test12: ATM10
// test13: ATM11
// test14: ATM12
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio1_pinmux (
// test and alternate select
.altf_sel   (1'b0),			//enable alternate function
.test_sel   (test_sel),			//4'd2
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (flash_bist_en),				//flash_bist_en
.test2_en   (ATM0),					//ATM_CONFG)
.test3_en   (ATM1),
.test4_en   (ATM2),
.test5_en   (ATM3),
.test6_en   (ATM4),
.test7_en   (ATM5),
.test8_en   (ATM6),
.test9_en   (ATM7),
.test10_en  (ATM8),
.test11_en  (1'b0),
.test12_en  (ATM10),
.test13_en  (ATM11),
.test14_en  (ATM12),
.test_ana   (1'b0),  			//Disable IE/OE/A:: TESTMODE0 GPIO0 serves pure analog signal
// alternate function
// altf0
.altf0_ie   (1'b1),
.altf0_oe   (1'b0),
.altf0_a    (1'b0),
.altf0_def  (1'b1),
.altf0_y    (mosi),
// test mode function
// test0
.test0_ie   (1'b0),
.test0_oe   (1'b1),
.test0_a    (scan_out[1]), 
.test0_def  (1'b0),
.test0_y    (),
// test1
.test1_ie   (flash_bist_oen),
.test1_oe   (1'b0),  
.test1_a    (1'b0), 
.test1_def  (1'b0),
.test1_y    (flash_bist_tdi),
// test2
.test2_ie   (1'b1),
.test2_oe   (1'b0),
.test2_a    (1'b0),
.test2_def  (1'b0),
.test2_y    (pad_DCLEADOFF_ISEL[1]),
// test3
.test3_ie   (1'b1),
.test3_oe   (1'b0),
.test3_a    (1'b0),
.test3_def  (1'b0),
.test3_y    (pad_PPGDAC1_VSEL[6]),
// test4
.test4_ie   (1'b1),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (pad_SDA_VIN_SEL0[0]),
// test5
.test5_ie   (1'b1),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (pad_PGA_EN),
// test6
.test6_ie   (1'b1),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (pad_TIA_GAIN[3]),
// test7
.test7_ie   (1'b1),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (pad_BGH_CTRIM[4]),
// test8
.test8_ie   (1'b1),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (pad_SDA_VIN_SEL2[1]),
// test9
.test9_ie   (1'b1),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (pad_DDS[6]),
// test10
.test10_ie   (1'b1),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (pad_ECGCAL_VSEL[3]),
// test11
.test11_ie   (1'b0),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (),
// test12
.test12_ie   (1'b1),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (pad_OSC_TRIM[3]),
// test13
.test13_ie   (1'b1),
.test13_oe   (1'b0),
.test13_a    (1'b0),
.test13_def  (1'b0),
.test13_y    (pad_PPGDAC0_VSEL[6]),
// test14
.test14_ie   (1'b1),
.test14_oe   (1'b0),
.test14_a    (1'b0),
.test14_def  (1'b0),
.test14_y    (pad_ACLEADOFF_VTHPSEL_TRIM[1]),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[1]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[1]),
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[1]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[1])
); 

// GPIO2 pad
// alt0  : sclk 
// test0 : scan_clk
// test1 : flash_bist_tck
// test2 : ATM0  
// test3 : ATM1
// test4 : ATM2
// test5 : ATM3
// test6 : ATM4
// test7 : ATM5
// test8 : ATM6
// test9 : ATM7
// test10: ATM8
// test11: None 
// test12: ATM10
// test13: ATM11
// test14: ATM12
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio2_pinmux (
// test and alternate select
.altf_sel   (1'b0),
.test_sel   (test_sel),			//4'd2
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (flash_bist_en),
.test2_en   (ATM0),				//ATM_CONFG
.test3_en   (ATM1),
.test4_en   (ATM2),
.test5_en   (ATM3),
.test6_en   (ATM4),
.test7_en   (ATM5),
.test8_en   (ATM6),
.test9_en   (ATM7),
.test10_en  (ATM8),
.test11_en  (ATM9),
.test12_en  (ATM10),
.test13_en  (ATM11),
.test14_en  (ATM12),  
.test_ana   (1'b0),  			//Disable IE/OE/A:: TESTMODE0 GPIO0 serves pure analog signal
// alternate function
// altf0
.altf0_ie   (1'b1),
.altf0_oe   (1'b0),
.altf0_a    (1'b0),
.altf0_def  (1'b0),
.altf0_y    (sclk),
// test mode function
// test0
.test0_ie   (1'b1),
.test0_oe   (1'b0),
.test0_a    (1'b0),
.test0_def  (1'b0),
.test0_y    (scan_clk),
// test1
.test1_ie   (1'b1),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (flash_bist_tck),
// test2
.test2_ie   (1'b1),
.test2_oe   (1'b0),
.test2_a    (1'b0),
.test2_def  (1'b0),
.test2_y    (pad_DCLEADOFF_COMP_TH[0]),
// test3
.test3_ie   (1'b1),
.test3_oe   (1'b0),
.test3_a    (1'b0),
.test3_def  (1'b0),
.test3_y    (pad_PPGDAC1_VSEL[7]),
// test4
.test4_ie   (1'b1),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (pad_SDA_VIN_SEL0[1]),
// test5
.test5_ie   (1'b1),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (pad_LPF_EN),
// test6
.test6_ie   (1'b1),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (pad_SDA_VIN_SEL1[0]),
// test7
.test7_ie   (1'b1),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (pad_BGH_CTRIM[5]),
// test8
.test8_ie   (1'b1),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (pad_SDA_VIN_SEL2[2]),
// test9
.test9_ie   (1'b1),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (pad_DDS[7]),
// test10
.test10_ie   (1'b1),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (pad_ECGCAL_VSEL[4]),
// test11
.test11_ie   (1'b0),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (),
// test12
.test12_ie   (1'b1),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (pad_OSC_TRIM[4]),
// test13
.test13_ie   (1'b1),
.test13_oe   (1'b0),
.test13_a    (1'b0),
.test13_def  (1'b0),
.test13_y    (pad_PPGDAC0_VSEL[7]),
// test14
.test14_ie   (1'b1),
.test14_oe   (1'b0),
.test14_a    (1'b0),
.test14_def  (1'b0),
.test14_y    (pad_ACLEADOFF_VTHPSEL_TRIM[2]),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[2]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[2]),
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[2]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[2])
); 

// GPIO3 pad
// alt0  : miso 
// test0 : scan_en 
// test1 : flash_bist_tdo
// test2 : ATM0  
// test3 : ATM1
// test4 : ATM2
// test5 : ATM3
// test6 : ATM4
// test7 : ATM5
// test8 : ATM6
// test9 : ATM7
// test10: ATM8
// test11: None 
// test12: ATM10
// test13: ATM11
// test14: ATM12
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio3_pinmux (
// test and alternate select
.altf_sel   (1'b0),		//enable alternate function
.test_sel   (test_sel),		//	4'd2
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (flash_bist_en),
.test2_en   (ATM0),			//ATM_CONFG
.test3_en   (ATM1),
.test4_en   (ATM2),
.test5_en   (ATM3),
.test6_en   (ATM4),
.test7_en   (ATM5),
.test8_en   (ATM6),
.test9_en   (ATM7),
.test10_en  (ATM8),
.test11_en  (1'b0),
.test12_en  (ATM10),
.test13_en  (ATM11),
.test14_en  (ATM12),
.test_ana   (1'b0),  			//Disable IE/OE/A:: TESTMODE0 GPIO0 serves pure analog signal
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (~cs_n),
.altf0_a    (miso),
.altf0_def  (1'b0),
.altf0_y    (),//
// test mode function
// test0
.test0_ie   (1'b1),
.test0_oe   (1'b0),
.test0_a    (1'b0),
.test0_def  (1'b0),
.test0_y    (scan_en),
// test1
.test1_ie   (1'b0),
.test1_oe   (~flash_bist_oen),
.test1_a    (flash_bist_tdo),
.test1_def  (1'b1),
.test1_y    (),
// test2
.test2_ie   (1'b1),
.test2_oe   (1'b0),
.test2_a    (1'b0),
.test2_def  (1'b0),
.test2_y    (pad_DCLEADOFF_ISEL[0]),
// test3
.test3_ie   (1'b1),
.test3_oe   (1'b0),
.test3_a    (1'b0),
.test3_def  (1'b0),
.test3_y    (pad_PPGDAC1_VSEL[5]),
// test4
.test4_ie   (1'b1),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (pad_SDM_EN),
// test5
.test5_ie   (1'b1),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (pad_DDACHOP_EN),
// test6
.test6_ie   (1'b1),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (pad_TIA_GAIN[2]),
// test7
.test7_ie   (1'b1),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (pad_BGH_CTRIM[6]),
// test8
.test8_ie   (1'b1),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (pad_SDA_VIN_SEL2[0]),
// test9
.test9_ie   (1'b1),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (pad_DDS[5]),
// test10
.test10_ie   (1'b1),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (pad_ECGCAL_VSEL[2]),
// test11
.test11_ie   (1'b0),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (),
// test12
.test12_ie   (1'b1),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (pad_OSC_TRIM[2]),
// test13
.test13_ie   (1'b1),
.test13_oe   (1'b0),
.test13_a    (1'b0),
.test13_def  (1'b0),
.test13_y    (pad_PPGDAC0_VSEL[5]),
// test14
.test14_ie   (1'b1),
.test14_oe   (1'b0),
.test14_a    (1'b0),
.test14_def  (1'b0),
.test14_y    (pad_ACLEADOFF_VTHPSEL_TRIM[0]),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[3]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[3]),
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[3]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[3])
); 

// GPIO4 pad
// alt0  : INTB  //check with xin
// test0 : scan_in[0]
// test1 : None 
// test2 : ATM0  
// test3 : ATM1
// test4 : ATM2
// test5 : ATM3
// test6 : ATM4
// test7 : ATM5
// test8 : ATM6
// test9 : ATM7
// test10: ATM8
// test11: None
// test12: ATM10
// test13: ATM11
// test14: ATM12
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio4_pinmux (
// test and alternate select
.altf_sel   (1'b0),
.test_sel   (test_sel),
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (1'b0),
.test2_en   (ATM0),
.test3_en   (ATM1),
.test4_en   (ATM2),
.test5_en   (ATM3),
.test6_en   (ATM4),
.test7_en   (ATM5),
.test8_en   (ATM6),
.test9_en   (ATM7),
.test10_en  (ATM8),
.test11_en  (1'b0),
.test12_en  (ATM10),
.test13_en  (ATM11),
.test14_en  (ATM12),
.test_ana   (1'b0),  			//Disable IE/OE/A:: TESTMODE0 GPIO0 serves pure analog signal
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (1'b1),
.altf0_a    (INTB),
.altf0_def  (1'b0),
.altf0_y    (),//
// test mode function
// test0
.test0_ie   (1'b1),
.test0_oe   (1'b0),
.test0_a    (1'b0),
.test0_def  (1'b0),
.test0_y    (scan_in[0]),// scan_in[0]
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),//flash_bist_resetn
// test2
.test2_ie   (1'b1),
.test2_oe   (1'b0),
.test2_a    (1'b0),
.test2_def  (1'b0),
.test2_y    (pad_DCLEADOFF_VINFLIP),
// test3
.test3_ie   (1'b1),
.test3_oe   (1'b0),
.test3_a    (1'b0),
.test3_def  (1'b0),
.test3_y    (pad_PPGDAC1_VSEL[4]),
// test4
.test4_ie   (1'b0),
.test4_oe   (1'b1),
.test4_a    (imeas_adc_din),
.test4_def  (1'b0),
.test4_y    (),
// test5
.test5_ie   (1'b1),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (pad_DDA_CLKSEL[1]),
// test6
.test6_ie   (1'b1),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (pad_TIA_GAIN[1]),
// test7
.test7_ie   (1'b1),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (pad_BGH_CTRIM[1]),
// test8
.test8_ie   (1'b1),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (pad_TSC_OUT_SEL),
// test9
.test9_ie   (1'b1),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (pad_DDS[4]),
// test10
.test10_ie   (1'b1),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (pad_ECGCAL_VSEL[1]),
// test11
.test11_ie   (1'b0),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (),
// test12
.test12_ie   (1'b1),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (pad_OSC_TRIM[1]),
// test13
.test13_ie   (1'b1),
.test13_oe   (1'b0),
.test13_a    (1'b0),
.test13_def  (1'b0),
.test13_y    (pad_PPGDAC0_VSEL[4]),
// test14
.test14_ie   (1'b0),
.test14_oe   (1'b1),
.test14_a    (ACLEADOFF_STATN),
.test14_def  (1'b0),
.test14_y    (),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[4]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[4]),
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[4]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[4])
); 

// GPIO5 pad
// alt0  : None
// test0 : scan_in[1]
// test1 : None 
// test2 : None  
// test3 : ATM1
// test4 : None
// test5 : ATM3
// test6 : ATM4
// test7 : ATM5
// test8 : ATM6
// test9 : ATM7
// test10: ATM8
// test11: None
// test12: None
// test13: None
// test14: ATM12
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio5_pinmux (
// test and alternate select
.altf_sel   (1'b0),
.test_sel   (test_sel),
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (flash_bist_en),
.test2_en   (1'b0),
.test3_en   (ATM1),
.test4_en   (1'b0),
.test5_en   (ATM3),
.test6_en   (ATM4),
.test7_en   (ATM5),
.test8_en   (ATM6),
.test9_en   (ATM7),
.test10_en  (ATM8),
.test11_en  (1'b0),
.test12_en  (1'b0),
.test13_en  (ATM11),
.test14_en  (ATM12),
.test_ana   (1'b0),  			//Disable IE/OE/A:: 
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (1'b0),
.altf0_a    (1'b0),
.altf0_def  (1'b0),
.altf0_y    (),
// test mode function
// test0
.test0_ie   (1'b1),
.test0_oe   (1'b0),
.test0_a    (1'b0), 
.test0_def  (1'b0),
.test0_y    (scan_in[1]),
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),
// test2
.test2_ie   (1'b0),
.test2_oe   (1'b0),
.test2_a    (1'b0),
.test2_def  (1'b0),
.test2_y    (),
// test3
.test3_ie   (1'b1),
.test3_oe   (1'b0),
.test3_a    (1'b0),
.test3_def  (1'b0),
.test3_y    (pad_PPGDAC1_VSEL[10]),
// test4
.test4_ie   (1'b0),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (),
// test5
.test5_ie   (1'b1),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (pad_PGA_SEL[0]),
// test6
.test6_ie   (1'b1),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (pad_PPG_SH_CK),
// test7
.test7_ie   (1'b1),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (pad_BGH_CTRIM[2]),
// test8
.test8_ie   (1'b1),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (pad_TSC_BJT_SEL[2]),
// test9
.test9_ie   (1'b1),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (pad_Z_TX_GSEL[1]),
// test10
.test10_ie   (1'b1),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (pad_ECGCAL_VSEL[7]),
// test11
.test11_ie   (1'b0),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (),
// test12
.test12_ie   (1'b0),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (),
// test13
.test13_ie   (1'b1),
.test13_oe   (1'b0),
.test13_a    (1'b0),
.test13_def  (1'b0),
.test13_y    (pad_PPGDAC0_VSEL[10]),
// test14
.test14_ie   (1'b1),
.test14_oe   (1'b0),
.test14_a    (1'b0),
.test14_def  (1'b0),
.test14_y    (pad_ACLEADOFF_VTHNSEL_TRIM[2]),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[5]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[5]),
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[5]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[5])
); 


// GPIO6 pad
// alt0  : None 
// test0 : scan_compression_in
// test1 : None
// test2 : ATM_CONFG
// test3 : None
// test4 : None
// test5 : None
// test6 : None
// test7 : None
// test8 : None
// test9 : None
// test10: None
// test11: None
// test12: None
// test13: None
// test14: None
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio6_pinmux (
// test and alternate select
.altf_sel   (1'b1),		//disbale alternate function
.test_sel   (scan_mode ? 4'd0 : (ATM_CONFG ? 4'd2 : 4'd14)),		// 4'd2 - hardcoded to configure test_sel, because test_sel not directly driven from testmode0/testmode1 pinss(or don't have enough test pins) 
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (1'b0),
.test2_en   (ATM_CONFG),	//control to slect only test2 inorder to set ATM0~ATM8
.test3_en   (1'b0),
.test4_en   (1'b0),
.test5_en   (1'b0),
.test6_en   (1'b0),
.test7_en   (1'b0),
.test8_en   (1'b0),
.test9_en   (1'b0),
.test10_en  (1'b0),
.test11_en  (1'b0),
.test12_en  (1'b0),
.test13_en  (1'b0),
.test14_en  (1'b0),
.test_ana   (1'b0),  			//Disable IE/OE/A:: 
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (1'b0),
.altf0_a    (1'b0),
.altf0_def  (1'b0),
.altf0_y    (),//
// test mode function
// test0
.test0_ie   (1'b1),
.test0_oe   (1'b0),
.test0_a    (1'b0),
.test0_def  (1'b0),
.test0_y    (scan_compression_in),   
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),//
// test2
.test2_ie   (1'b1),
.test2_oe   (1'b0),
.test2_a    (1'b0),
.test2_def  (1'b0),
.test2_y    (wire_baf4p1_IOBUF_Y[0]),//debug_sel_0, Enable signal to choose debug mode		
// test3
.test3_ie   (1'b0),
.test3_oe   (1'b0),
.test3_a    (1'b0),
.test3_def  (1'b0),
.test3_y    (),
// test4
.test4_ie   (1'b0),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (),
// test5
.test5_ie   (1'b0),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (),
// test6
.test6_ie   (1'b0),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (),
// test7
.test7_ie   (1'b0),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (),
// test8
.test8_ie   (1'b0),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (),
// test9
.test9_ie   (1'b0),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (),
// test10
.test10_ie   (1'b0),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (),
// test11
.test11_ie   (1'b0),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (),
// test12
.test12_ie   (1'b0),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (),
// test13
.test13_ie   (1'b0),
.test13_oe   (1'b0),
.test13_a    (1'b0),
.test13_def  (1'b0),
.test13_y    (),
// test14
.test14_ie   (1'b0),
.test14_oe   (1'b0),
.test14_a    (1'b0),
.test14_def  (1'b0),
.test14_y    (),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[6]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[6]),			
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[6]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[6])
); 

// GPIO7 pad
// alt0  : None
// test0 : scan_in[4]
// test1 : None
// test2 : ATM_CONFG
// test3 : None
// test4 : None
// test5 : None
// test6 : None
// test7 : None
// test8 : None
// test9 : None
// test10: None
// test11: None
// test12: None
// test13: None
// test14: None
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio7_pinmux (
// test and alternate select
.altf_sel   (1'b1),		//disbale alternate function
.test_sel   (scan_mode ? 4'd0 : (ATM_CONFG ? 4'd2 : 4'd14)),		// 4'd2 - hardcoded to configure test_sel, because test_sel not directly driven from testmode0/testmode1 pinss(or don't have enough test pins) 	
.test_en    (test_en),                  
.test0_en   (scan_mode),
.test1_en   (1'b0),
.test2_en   (ATM_CONFG),	//control to slect only test2 inorder to set ATM0~ATM8
.test3_en   (1'b0),
.test4_en   (1'b0),
.test5_en   (1'b0),
.test6_en   (1'b0),
.test7_en   (1'b0),
.test8_en   (1'b0),
.test9_en   (1'b0),
.test10_en  (1'b0),
.test11_en  (1'b0),
.test12_en  (1'b0),
.test13_en  (1'b0),
.test14_en  (1'b0),
.test_ana   (1'b0),  			//Disable IE/OE/A:: 
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (1'b0),
.altf0_a    (1'b0),
.altf0_def  (1'b0),
.altf0_y    (),
// test mode function
// test0
.test0_ie   (1'b1),
.test0_oe   (1'b0),
.test0_a    (1'b0),
.test0_def  (1'b0),
.test0_y    (scan_in[4]),
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),//
// test2
.test2_ie   (1'b1),
.test2_oe   (1'b0),
.test2_a    (1'b0),
.test2_def  (1'b0),
.test2_y    (wire_baf4p1_IOBUF_Y[1]),//debug_sel[1],Enable signal to choose debug mode		
// test3
.test3_ie   (1'b0),
.test3_oe   (1'b0),
.test3_a    (1'b0),
.test3_def  (1'b0),
.test3_y    (),
// test4
.test4_ie   (1'b0),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (),
// test5
.test5_ie   (1'b0),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (),
// test6
.test6_ie   (1'b0),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (),
// test7
.test7_ie   (1'b0),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (),
// test8
.test8_ie   (1'b0),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (),
// test9
.test9_ie   (1'b0),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (),
// test10
.test10_ie   (1'b0),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (),
// test11
.test11_ie   (1'b0),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (),
// test12
.test12_ie   (1'b0),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (),
// test13
.test13_ie   (1'b0),
.test13_oe   (1'b0),
.test13_a    (1'b0),
.test13_def  (1'b0),
.test13_y    (),
// test14
.test14_ie   (1'b0),
.test14_oe   (1'b0),
.test14_a    (1'b0),
.test14_def  (1'b0),
.test14_y    (),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[7]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[7]),					
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[7]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[7])
); 


// GPIO8 pad
// alt0  : None
// test0 : scan_in[5]
// test1 : None
// test2 : ATM_CONFG
// test3 : None
// test4 : None
// test5 : None
// test6 : None
// test7 : None
// test8 : None
// test9 : None
// test10: None
// test11: None
// test12: None
// test13: None
// test14: None
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio8_pinmux (
// test and alternate select
.altf_sel   (1'b1),		    //disbale alternate function
.test_sel   (scan_mode ? 4'd0 : (ATM_CONFG ? 4'd2 : 4'd14)),       // 4'd2 - hardcoded to configure test_sel, because test_sel not directly driven from testmode0/testmode1 pinss(or don't have enough test pins)
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (1'b0),
.test2_en   (ATM_CONFG),//control to slect only test2 inorder to set ATM0~ATM8	
.test3_en   (1'b0),
.test4_en   (1'b0),
.test5_en   (1'b0),
.test6_en   (1'b0),
.test7_en   (1'b0),
.test8_en   (1'b0),
.test9_en   (1'b0),
.test10_en  (1'b0),
.test11_en  (1'b0),
.test12_en  (1'b0),
.test13_en  (1'b0),
.test14_en  (1'b0),
.test_ana   (1'b0),  			//Disable IE/OE/A:: 
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (1'b0),
.altf0_a    (1'b0),
.altf0_def  (1'b0),
.altf0_y    (),
// test mode function
// test0
.test0_ie   (1'b1),    
.test0_oe   (1'b0),    
.test0_a    (1'b0),    
.test0_def  (1'b0),    
.test0_y    (scan_in[5]),
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),
// test2
.test2_ie   (1'b1),      
.test2_oe   (1'b0),      
.test2_a    (1'b0),      
.test2_def  (1'b0),      
.test2_y    (wire_baf4p1_IOBUF_Y[2]),
// test3
.test3_ie   (1'b0),
.test3_oe   (1'b0),
.test3_a    (1'b0),
.test3_def  (1'b0),
.test3_y    (),
// test4
.test4_ie   (1'b0),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (),
// test5
.test5_ie   (1'b0),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (),
// test6
.test6_ie   (1'b0),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (),
// test7
.test7_ie   (1'b0),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (),
// test8
.test8_ie   (1'b0),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (),
// test9
.test9_ie   (1'b0),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (),
// test10
.test10_ie   (1'b0),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (),
// test11
.test11_ie   (1'b0),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (),
// test12
.test12_ie   (1'b0),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (),
// test13
.test13_ie   (1'b0),
.test13_oe   (1'b0),
.test13_a    (1'b0),
.test13_def  (1'b0),
.test13_y    (),
// test14
.test14_ie   (1'b0),
.test14_oe   (1'b0),
.test14_a    (1'b0),
.test14_def  (1'b0),
.test14_y    (),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[8]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[8]),
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[8]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[8])
); 

// GPIO9 pad
// alt0  : None
// test0 : scan_in[6]
// test1 : None
// test2 : ATM_CONFG
// test3 : None
// test4 : None
// test5 : None
// test6 : None
// test7 : None
// test8 : None
// test9 : None
// test10: None
// test11: None
// test12: None
// test13: None
// test14: None
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio9_pinmux (
// test and alternate select
.altf_sel   (1'b1),	 	//disbale alternate function                                                                                                          			
.test_sel   (scan_mode ? 4'd0 : (ATM_CONFG ? 4'd2 : 4'd14)),   //4'd2 - hardcoded to configure test_sel, because test_sel not directly driven from testmode0/testmode1 pinss(or don't have enough test pins)
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (1'b0),
.test2_en   (ATM_CONFG),		//control to slect only test2 inorder to set ATM0~ATM8
.test3_en   (1'b0),
.test4_en   (1'b0),
.test5_en   (1'b0),
.test6_en   (1'b0),
.test7_en   (1'b0),
.test8_en   (1'b0),
.test9_en   (1'b0),
.test10_en  (1'b0),
.test11_en  (1'b0),
.test12_en  (1'b0),
.test13_en  (1'b0),
.test14_en  (1'b0),
.test_ana   (1'b0),  			//Disable IE/OE/A:: TESTMODE0 GPIO0 serves pure analog signal
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (1'b0),
.altf0_a    (1'b0),
.altf0_def  (1'b0),
.altf0_y    (),
// test mode function
// test0
.test0_ie   (1'b1),    
.test0_oe   (1'b0),    
.test0_a    (1'b0),    
.test0_def  (1'b0),    
.test0_y    (scan_in[6]),
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),
// test2
.test2_ie   (1'b1),
.test2_oe   (1'b0),
.test2_a    (1'b0),
.test2_def  (1'b0),
.test2_y    (wire_baf4p1_IOBUF_Y[3]),//debug_sel[3],Enable signal to choose debug mode
// test3
.test3_ie   (1'b0),
.test3_oe   (1'b0),
.test3_a    (1'b0),
.test3_def  (1'b0),
.test3_y    (),
// test4
.test4_ie   (1'b0),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (),
// test5
.test5_ie   (1'b0),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (),
// test6
.test6_ie   (1'b0),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (),
// test7
.test7_ie   (1'b0),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (),
// test8
.test8_ie   (1'b0),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (),
// test9
.test9_ie   (1'b0),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (),
// test10
.test10_ie   (1'b0),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (),
// test11
.test11_ie   (1'b0),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (),
// test12
.test12_ie   (1'b0),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (),
// test13
.test13_ie   (1'b0),
.test13_oe   (1'b0),
.test13_a    (1'b0),
.test13_def  (1'b0),
.test13_y    (),
// test14
.test14_ie   (1'b0),
.test14_oe   (1'b0),
.test14_a    (1'b0),
.test14_def  (1'b0),
.test14_y    (),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[9]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[9]),
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[9]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[9])
); 

// GPIO10 pad
// alt0  : None 
// test0 : scan_in[7]
// test1 : None
// test2 : ATM0  
// test3 : ATM1
// test4 : None
// test5 : None
// test6 : ATM4
// test7 : ATM5
// test8 : ATM6
// test9 : ATM7
// test10: ATM8
// test11: None
// test12: None
// test13: ATM11
// test14: ATM12
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio10_pinmux (
// test and alternate select
.altf_sel   (1'b1),
.test_sel   (test_sel),
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (1'b0),
.test2_en   (ATM0),
.test3_en   (ATM1),
.test4_en   (1'b0),
.test5_en   (1'b0),
.test6_en   (ATM4),
.test7_en   (ATM5),
.test8_en   (ATM6),
.test9_en   (ATM7),
.test10_en  (ATM8),
.test11_en  (1'b0),
.test12_en  (1'b0),
.test13_en  (ATM11),
.test14_en  (ATM12),
.test_ana   (1'b0),  			//Disable IE/OE/A for pure analog signals:: 
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (1'b0),
.altf0_a    (1'b0),
.altf0_def  (1'b0),
.altf0_y    (),
// test mode function
// test0
.test0_ie   (1'b1),    
.test0_oe   (1'b0),    
.test0_a    (1'b0),    
.test0_def  (1'b0),    
.test0_y    (scan_in[7]),
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),//
// test2
.test2_ie   (1'b1),
.test2_oe   (1'b0),
.test2_a    (1'b0),
.test2_def  (1'b0),
.test2_y    (pad_DCLEADOFF_COMP_TH[2]),
// test3
.test3_ie   (1'b1), 
.test3_oe   (1'b0), 
.test3_a    (1'b0), 
.test3_def  (1'b0), 
.test3_y    (pad_PPGDAC1_VSEL[9]),
// test4
.test4_ie   (1'b0),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (),
// test5
.test5_ie   (1'b0),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (),
// test6
.test6_ie   (1'b1),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (pad_SDA_VIN_SEL1[2]),
// test7
.test7_ie   (1'b1),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (pad_BGH_VTRIM[0]),
// test8
.test8_ie   (1'b1),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (pad_TSC_BJT_SEL[1]),
// test9
.test9_ie   (1'b1),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (pad_Z_TX_GSEL[0]),
// test10
.test10_ie   (1'b1),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (pad_ECGCAL_VSEL[6]),
// test11
.test11_ie   (1'b0),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (),
// test12
.test12_ie   (1'b1),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (),
// test13
.test13_ie   (1'b1), 
.test13_oe   (1'b0), 
.test13_a    (1'b0), 
.test13_def  (1'b0), 
.test13_y    (pad_PPGDAC0_VSEL[9]),
// test14
.test14_ie   (1'b1), 
.test14_oe   (1'b0), 
.test14_a    (1'b0), 
.test14_def  (1'b0), 
.test14_y    (pad_ACLEADOFF_VTHNSEL_TRIM[1]),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[10]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[10]),
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[10]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[10])
);
// GPIO11 pad
// alt0  : imeas_adc_din - SDM_OUT
// test0 : scan_in[2]
// test1 : None
// test2 : ATM0  
// test3 : ATM1
// test4 : None
// test5 : ATM3
// test6 : ATM4
// test7 : ATM5
// test8 : ATM6
// test9 : ATM7
// test10: ATM8
// test11: None
// test12: None
// test13: ATM11
// test14: ATM12
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio11_pinmux (
// test and alternate select
.altf_sel   (1'b0),
.test_sel   (test_sel),
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (1'b0),
.test2_en   (ATM0),
.test3_en   (ATM1),
.test4_en   (ATM2),
.test5_en   (ATM3),
.test6_en   (ATM4),
.test7_en   (ATM5),
.test8_en   (ATM6),
.test9_en   (ATM7),
.test10_en  (ATM8),
.test11_en  (1'b0),
.test12_en  (ATM10),
.test13_en  (ATM11),
.test14_en  (ATM12),
.test_ana   (1'b0),  			//Disable IE/OE/A for pure analof signals:: 
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (1'b1),
.altf0_a    (imeas_adc_din),
.altf0_def  (1'b0),
.altf0_y    (),
// test mode function
// test0
.test0_ie   (1'b1),
.test0_oe   (1'b0),
.test0_a    (1'b0),
.test0_def  (1'b0),
.test0_y    (scan_in[2]),
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),
// test2
.test2_ie   (1'b1),
.test2_oe   (1'b0),
.test2_a    (1'b0),
.test2_def  (1'b0),
.test2_y    (pad_DCLEADOFF_RMODE_EN),			
// test3
.test3_ie   (1'b1),         
.test3_oe   (1'b0),         
.test3_a    (1'b0),         
.test3_def  (1'b0),         
.test3_y    (pad_PPGDAC1_VSEL[3]),
// test4
.test4_ie   (1'b1),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (pad_SDM_BIAS[0]),
// test5
.test5_ie   (1'b1),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (pad_DDA_CLKSEL[0]),
// test6
.test6_ie   (1'b1),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (pad_TIA_GAIN[0]),
// test7
.test7_ie   (1'b1),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (pad_BGH_VTRIM[1]),
// test8
.test8_ie   (1'b1),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (pad_VCM1P5_BUF_EN3),
// test9
.test9_ie   (1'b1),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (pad_DDS[3]),
// test10
.test10_ie   (1'b1),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (pad_ECGCAL_VSEL[0]),
// test11
.test11_ie   (1'b0),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (),
// test12
.test12_ie   (1'b1),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (pad_OSC_TRIM[0]),
// test13
.test13_ie   (1'b1),         
.test13_oe   (1'b0),         
.test13_a    (1'b0),         
.test13_def  (1'b0),         
.test13_y    (pad_PPGDAC0_VSEL[3]),
// test14
.test14_ie   (1'b0),         
.test14_oe   (1'b1),         
.test14_a    (ACLEADOFF_STATP),         
.test14_def  (1'b0),         
.test14_y    (),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[11]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[11]),				//(o_baf4p1_IOBUF_IE[10] & 1'b0)
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[11]),                            //(o_baf4p1_IOBUF_OE[10] & 1'b0)
.iopad_gpio_a    (o_baf4p1_IOBUF_A[11])                             //(o_baf4p1_IOBUF_A[10]  & 1'b0)
);

// GPIO12 pad
// alt0  : SDM_CLK_GPIO 
// test0 : scan_in[3]
// test1 : None
// test2 : ATM0  
// test3 : ATM1
// test4 : ATM2
// test5 : ATM3
// test6 : ATM4
// test7 : ATM5
// test8 : ATM6 
// test9 : ATM7
// test10: ATM8
// test11: ATM9
// test12: ATM10
// test13: ATM11
// test14: ATM12 
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio12_pinmux (
// test and alternate select
.altf_sel   (1'b0),
.test_sel   (test_sel),
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (1'b0),
.test2_en   (ATM0),
.test3_en   (ATM1),
.test4_en   (ATM2),
.test5_en   (ATM3),
.test6_en   (ATM4),
.test7_en   (ATM5),
.test8_en   (ATM6),
.test9_en   (ATM7),
.test10_en  (ATM8),
.test11_en  (ATM9),
.test12_en  (ATM10),
.test13_en  (ATM11),
.test14_en  (ATM12),
.test_ana   (1'b0),  			//Disable IE/OE/A for pure analog signals:: 
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (1'b1),
.altf0_a    (SDM_CLK_GPIO),
.altf0_def  (1'b0),
.altf0_y    (),//
// test mode function
// test0
.test0_ie   (1'b1),
.test0_oe   (1'b0),
.test0_a    (1'b0),
.test0_def  (1'b0),
.test0_y    (scan_in[3]),
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),
// test2
.test2_ie   (1'b0),
.test2_oe   (1'b1),
.test2_a    (LOFF_STATN),
.test2_def  (1'b0),
.test2_y    (),	
// test3
.test3_ie   (1'b1),         
.test3_oe   (1'b0),         
.test3_a    (1'b0),         
.test3_def  (1'b0),         
.test3_y    (pad_PPGDAC1_VSEL[2]),
// test4
.test4_ie   (1'b1),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (pad_SDM_BIAS[1]),
// test5
.test5_ie   (1'b1),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (pad_PGA_SEL[2]),
// test6
.test6_ie   (1'b1),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (pad_TIA_IDAC_0),
// test7
.test7_ie   (1'b1),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (pad_BGH_VTRIM[2]),
// test8
.test8_ie   (1'b1),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (pad_TSC_INA_EN),
// test9
.test9_ie   (1'b1),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (pad_DDS[2]),
// test10
.test10_ie   (1'b1),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (pad_VCM1P5_BUF_EN4),
// test11
.test11_ie   (1'b1),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (pad_VCM1P5_BUF_EN5),
// test12
.test12_ie   (1'b1),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (pad_OSC_ISEL_TRIM),
// test13
.test13_ie   (1'b1),         
.test13_oe   (1'b0),         
.test13_a    (1'b0),         
.test13_def  (1'b0),         
.test13_y    (pad_PPGDAC0_VSEL[2]),
// test14
.test14_ie   (1'b1),         
.test14_oe   (1'b0),         
.test14_a    (1'b0),         
.test14_def  (1'b0),         
.test14_y    (pad_VCM1P5_BUF_EN6),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[12]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[12]),
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[12]), 
.iopad_gpio_a    (o_baf4p1_IOBUF_A[12])
);

// GPIO13 pad
// alt0  : None 
// test0 : scan_out[2]
// test1 : None
// test2 : ATM0  
// test3 : ATM1
// test4 : None
// test5 : ATM3
// test6 : ATM4
// test7 : ATM5
// test8 : None
// test9 : ATM7
// test10: None
// test11: None
// test12: ATM10
// test13: ATM11
// test14: None 
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio13_pinmux (
// test and alternate select
.altf_sel   (1'b1),
.test_sel   (test_sel),
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (1'b0),
.test2_en   (ATM0),
.test3_en   (ATM1),
.test4_en   (1'b0),
.test5_en   (ATM3),
.test6_en   (ATM4),
.test7_en   (ATM5),
.test8_en   (1'b0),
.test9_en   (ATM7),
.test10_en  (1'b0),
.test11_en  (1'b0),
.test12_en  (ATM10),
.test13_en  (ATM11),
.test14_en  (1'b0),
.test_ana   (1'b0),  			//Disable IE/OE/A:: 
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (1'b0),
.altf0_a    (1'b0),
.altf0_def  (1'b0),
.altf0_y    (),
// test mode function
// test0
.test0_ie   (1'b0),
.test0_oe   (1'b1),
.test0_a    (scan_out[2]),
.test0_def  (1'b0),
.test0_y    (),
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),
// test2
.test2_ie   (1'b1),
.test2_oe   (1'b0),
.test2_a    (1'b0),
.test2_def  (1'b0),
.test2_y    (pad_DCLEADOFF_EN),
// test3
.test3_ie   (1'b1),         
.test3_oe   (1'b0),         
.test3_a    (1'b0),         
.test3_def  (1'b0),         
.test3_y    (pad_PPGDAC1_VSEL[0]),
// test4
.test4_ie   (1'b0),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (),
// test5
.test5_ie   (1'b1),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (pad_PGA_SEL[1]),
// test6
.test6_ie   (1'b1),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (pad_TIA_IDAC_74[0]),
// test7
.test7_ie   (1'b1),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (pad_BGH_VTRIM[3]),
// test8
.test8_ie   (1'b0),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (),
// test9
.test9_ie   (1'b1),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (pad_DDS[0]),
// test10
.test10_ie   (1'b0),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (),
// test11
.test11_ie   (1'b0),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (),
// test12
.test12_ie   (1'b0),
.test12_oe   (1'b1),
.test12_a    (OSC_OUT),
.test12_def  (1'b0),
.test12_y    (),
// test13
.test13_ie   (1'b1),         
.test13_oe   (1'b0),         
.test13_a    (1'b0),         
.test13_def  (1'b0),         
.test13_y    (pad_PPGDAC0_VSEL[0]),
// test14
.test14_ie   (1'b0),         
.test14_oe   (1'b0),         
.test14_a    (1'b0),         
.test14_def  (1'b0),         
.test14_y    (),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[13]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[13]),	
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[13]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[13])
);

// GPIO14 pad
// alt0  : None 
// test0 : scan_out[3]
// test1 : None
// test2 : ATM0  
// test3 : ATM1
// test4 : ATM2
// test5 : ATM3
// test6 : ATM4
// test7 : ATM5
// test8 : None
// test9 : ATM7
// test10: None
// test11: None
// test12: None
// test13: ATM11
// test14: None 
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio14_pinmux (
// test and alternate select
.altf_sel   (1'b1),
.test_sel   (test_sel),
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (1'b0),
.test2_en   (ATM0),
.test3_en   (ATM1),
.test4_en   (ATM2),
.test5_en   (ATM3),
.test6_en   (ATM4),
.test7_en   (ATM5),
.test8_en   (ATM6),
.test9_en   (ATM7),
.test10_en  (1'b0),
.test11_en  (1'b0),
.test12_en  (1'b0),
.test13_en  (ATM11),
.test14_en  (1'b0),
.test_ana   (1'b0),  			//Disable IE/OE/A:: 
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (1'b0),
.altf0_a    (1'b0),
.altf0_def  (1'b0),
.altf0_y    (),
// test mode function
// test0
.test0_ie   (1'b0),
.test0_oe   (1'b1),
.test0_a    (scan_out[3]),
.test0_def  (1'b0),
.test0_y    (),
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),
// test2
.test2_ie   (1'b0),
.test2_oe   (1'b1),
.test2_a    (LOFF_STATP),
.test2_def  (1'b0),
.test2_y    (),	
// test3
.test3_ie   (1'b1),         
.test3_oe   (1'b0),         
.test3_a    (1'b0),         
.test3_def  (1'b0),         
.test3_y    (pad_PPGDAC1_VSEL[1]),
// test4
.test4_ie   (1'b1),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (pad_SDM_CLK0),
// test5
.test5_ie   (1'b1),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (pad_SDM_CLK1),
// test6
.test6_ie   (1'b1),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (pad_TIA_IDAC_74[3]),
// test7
.test7_ie   (1'b1),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (pad_BGH_VTRIM[4]),
// test8
.test8_ie   (1'b0),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (),
// test9
.test9_ie   (1'b1),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (pad_DDS[1]),
// test10
.test10_ie   (1'b0),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (),
// test11
.test11_ie   (1'b0),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (),
// test12
.test12_ie   (1'b0),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (),
// test13
.test13_ie   (1'b1),         
.test13_oe   (1'b0),         
.test13_a    (1'b0),         
.test13_def  (1'b0),         
.test13_y    (pad_PPGDAC0_VSEL[1]),
// test14
.test14_ie   (1'b0),         
.test14_oe   (1'b0),         
.test14_a    (1'b0),         
.test14_def  (1'b0),         
.test14_y    (),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[14]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[14]),
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[14]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[14])
);

// GPIO15 pad
// alt0  : None
// test0 : scan_out[4]
// test1 : None
// test2 : ATM0  
// test3 : ATM1
// test4 : ATM2 
// test5 : ATM3
// test6 : ATM4
// test7 : ATM5
// test8 : ATM6
// test9 : ATM7
// test10: ATM8
// test11: ATM9 
// test12: None
// test13: ATM11
// test13: ATM12
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio15_pinmux (
// test and alternate select
.altf_sel   (1'b1),
.test_sel   (test_sel),
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (1'b0),
.test2_en   (ATM0),
.test3_en   (ATM1),
.test4_en   (ATM2),
.test5_en   (ATM3),
.test6_en   (ATM4),
.test7_en   (ATM5),
.test8_en   (ATM6),
.test9_en   (ATM7),
.test10_en  (ATM8),
.test11_en  (ATM9),
.test12_en  (1'b0),
.test13_en  (ATM11),
.test14_en  (ATM12),
.test_ana   (1'b0),  			//Disable IE/OE/A:: 
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (1'b0),
.altf0_a    (1'b0),
.altf0_def  (1'b0),
.altf0_y    (),//
// test mode function
// test0
.test0_ie   (1'b0),
.test0_oe   (1'b1),
.test0_a    (scan_out[4]),
.test0_def  (1'b0),
.test0_y    (),
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),//
// test2
.test2_ie   (1'b1),
.test2_oe   (1'b0),
.test2_a    (1'b0),
.test2_def  (1'b0),
.test2_y    (pad_DCLEADOFF_ISEL[2]),
// test3
.test3_ie   (1'b1),
.test3_oe   (1'b0),
.test3_a    (1'b0),
.test3_def  (1'b0),
.test3_y    (pad_LED_EN0),
// test4
.test4_ie   (1'b1),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (pad_VCM1P5_BUF_EN0),
// test5
.test5_ie   (1'b1),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (pad_DDA_GSEL[2]),
// test6
.test6_ie   (1'b1),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (pad_PPG_TEST_IN[1]),
// test7
.test7_ie   (1'b1),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (pad_LDO1V5_VTRIM[0]),
// test8
.test8_ie   (1'b1),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (pad_TSC_EN),
// test9
.test9_ie   (1'b1),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (pad_Z_EN),
// test10
.test10_ie   (1'b1),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (pad_ECGCAL_EN),
// test11
.test11_ie   (1'b1),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (pad_ELECTRODE_EN),
// test12
.test12_ie   (1'b1),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (),
// test13
.test13_ie   (1'b1),
.test13_oe   (1'b0),
.test13_a    (1'b0),
.test13_def  (1'b0),
.test13_y    (pad_LED_EN1),
// test14
.test14_ie   (1'b1),
.test14_oe   (1'b0),
.test14_a    (1'b0),
.test14_def  (1'b0),
.test14_y    (pad_ACLEADOFF_CLK),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[15]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[15]),
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[15]), 
.iopad_gpio_a    (o_baf4p1_IOBUF_A[15]) 
);

// GPIO16 pad
// alt0  : 
// test0 : scan_out[5]
// test1 :
// test2 : None  
// test3 : ATM1
// test4 : ATM2 
// test5 : ATM3
// test6 : ATM4
// test7 : ATM5
// test8 : ATM6
// test9 : ATM7
// test10: ATM8
// test11: ATM9 
// test12: None
// test13: ATM11
// test14: ATM12
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio16_pinmux (
// test and alternate select
.altf_sel   (1'b1),
.test_sel   (test_sel),
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (1'b0),
.test2_en   (1'b0),
.test3_en   (ATM1),
.test4_en   (ATM2),
.test5_en   (ATM3),
.test6_en   (ATM4),
.test7_en   (ATM5),
.test8_en   (ATM6),
.test9_en   (ATM7),
.test10_en  (ATM8),
.test11_en  (ATM9),
.test12_en  (1'b0),
.test13_en  (ATM11),
.test14_en  (ATM12),
.test_ana   (1'b0),  			//Disable IE/OE/A:: 
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (1'b0),
.altf0_a    (1'b0),
.altf0_def  (1'b0),
.altf0_y    (),//
// test mode function
// test0
.test0_ie   (1'b0),
.test0_oe   (1'b1),
.test0_a    (scan_out[5]),
.test0_def  (1'b0),
.test0_y    (),
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),//
// test2
.test2_ie   (1'b0),
.test2_oe   (1'b0),
.test2_a    (1'b0),
.test2_def  (1'b0),
.test2_y    (),
// test3
.test3_ie   (1'b1),
.test3_oe   (1'b0),
.test3_a    (1'b0),
.test3_def  (1'b0),
.test3_y    (pad_LED_SEL0),
// test4
.test4_ie   (1'b1),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (pad_BG1P2_BUF_EN),
// test5
.test5_ie   (1'b1),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (pad_DDA_GSEL[1]),
// test6
.test6_ie   (1'b1),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (pad_PPG_TEST_IN[0]),
// test7
.test7_ie   (1'b1),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (pad_LDO1V5_VTRIM[1]),
// test8
.test8_ie   (1'b1),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (pad_TSC_INA_GSEL[2]),
// test9
.test9_ie   (1'b1),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (pad_Z_CLK256K0),
// test10
.test10_ie   (1'b1),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (pad_ECGCAL_VSEL[9]),
// test11
.test11_ie   (1'b1),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (pad_RLD_CLK64K),
// test12
.test12_ie   (1'b1),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (),
// test13
.test13_ie   (1'b1),
.test13_oe   (1'b0),
.test13_a    (1'b0),
.test13_def  (1'b0),
.test13_y    (pad_LED_SEL1),
// test13
.test14_ie   (1'b1),
.test14_oe   (1'b0),
.test14_a    (1'b0),
.test14_def  (1'b0),
.test14_y    (pad_ACLEADOFF_EN),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[16]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[16]),
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[16]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[16])
);

// GPIO17 pad
// alt0  : 
// test0 : scan_out[6]
// test1 :
// test2 : None  
// test3 : ATM1
// test4 : None
// test5 : ATM3
// test6 : ATM4
// test7 : ATM5 
// test8 : ATM6
// test9 : ATM7
// test10: ATM8
// test11: ATM9 
// test12: None
// test13: ATM11
// test13: ATM12
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio17_pinmux (
// test and alternate select
.altf_sel   (1'b1),
.test_sel   (test_sel),
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (1'b0),
.test2_en   (1'b0),
.test3_en   (ATM1),
.test4_en   (1'b0),
.test5_en   (ATM3),
.test6_en   (ATM4),
.test7_en   (ATM5),
.test8_en   (ATM6),
.test9_en   (ATM7),
.test10_en  (ATM8),
.test11_en  (ATM9),
.test12_en  (1'b0),
.test13_en  (ATM11),
.test14_en  (ATM12),
.test_ana   (1'b0),  			//Disable IE/OE/A:: 
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (1'b0),
.altf0_a    (1'b0),
.altf0_def  (1'b0),
.altf0_y    (),//
// test mode function
// test0
.test0_ie   (1'b0),
.test0_oe   (1'b1),
.test0_a    (scan_out[6]),
.test0_def  (1'b0),
.test0_y    (),
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),
// test2
.test2_ie   (1'b0),
.test2_oe   (1'b0),
.test2_a    (1'b0),
.test2_def  (1'b0),
.test2_y    (),
// test3
.test3_ie   (1'b1),
.test3_oe   (1'b0),
.test3_a    (1'b0),
.test3_def  (1'b0),
.test3_y    (pad_LEDDAC_SEL0),
// test4
.test4_ie   (1'b0),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (),
// test5
.test5_ie   (1'b1),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (pad_DDA_GSEL[0]),
// test6
.test6_ie   (1'b1),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (pad_TIA_IDAC_74[1]),
// test7
.test7_ie   (1'b1),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (pad_VCM1P5_BUF_EN2),
// test8
.test8_ie   (1'b1),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (pad_TSC_INA_GSEL[1]),
// test9
.test9_ie   (1'b1),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (pad_DDS[9]),
// test10
.test10_ie   (1'b1),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (pad_ECGCAL_VSEL[8]),
// test11
.test11_ie   (1'b1),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (pad_RLD_EN),
// test12
.test12_ie   (1'b1),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (),
// test13
.test13_ie   (1'b1),
.test13_oe   (1'b0),
.test13_a    (1'b0),
.test13_def  (1'b0),
.test13_y    (pad_LEDDAC_SEL1),
// test14
.test14_ie   (1'b1),
.test14_oe   (1'b0),
.test14_a    (1'b0),
.test14_def  (1'b0),
.test14_y    (pad_ACLEADOFF_ISEL_TRIM[0]),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[17]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[17]),
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[17]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[17])
);

// GPIO18 pad
// alt0  : LED_STATUS 
// test0 : scan_out[7]
// test1 : None
// test2 : None  
// test3 : ATM1
// test4 : None
// test5 : ATM3 
// test6 : ATM4
// test7 : ATM5
// test8 : ATM6
// test9 : ATM7 
// test10: None
// test11: None
// test12: None
// test13: ATM11
// test14: ATM12
pinmux_1bit 
//#(
//.ALTF0_CLKIN(0),
//.TEST0_CLKIN(0),
//.TEST1_CLKIN(0),
//.TEST2_CLKIN(0),
//.TEST3_CLKIN(0),
//.TEST4_CLKIN(0),
//.TEST5_CLKIN(0),
//.TEST6_CLKIN(0),
//.TEST7_CLKIN(0),
//.TEST8_CLKIN(0),
//.TEST9_CLKIN(0),
//.TEST10_CLKIN(0),
//.TEST11_CLKIN(0),
//.TEST12_CLKIN(0),
//.TEST13_CLKIN(0))
u_gpio18_pinmux (
// test and alternate select
.altf_sel   (1'b0),
.test_sel   (test_sel),
.test_en    (test_en),
.test0_en   (scan_mode),
.test1_en   (1'b0),
.test2_en   (1'b0),
.test3_en   (ATM1),
.test4_en   (1'b0),
.test5_en   (ATM3),
.test6_en   (ATM4),
.test7_en   (ATM5),
.test8_en   (ATM6),
.test9_en   (ATM7),
.test10_en  (1'b0),
.test11_en  (1'b0),
.test12_en  (1'b0),
.test13_en  (ATM11),
.test14_en  (ATM12),
.test_ana   (1'b0),  			//Disable IE/OE/A:: 
// alternate function
// altf0
.altf0_ie   (1'b0),
.altf0_oe   (1'b1),
.altf0_a    (i_LED_STATUS),
.altf0_def  (1'b0),
.altf0_y    (),//
// test mode function
// test0
.test0_ie   (1'b0),
.test0_oe   (1'b1),
.test0_a    (scan_out[7]),
.test0_def  (1'b0),
.test0_y    (),
// test1
.test1_ie   (1'b0),
.test1_oe   (1'b0),
.test1_a    (1'b0),
.test1_def  (1'b0),
.test1_y    (),
// test2
.test2_ie   (1'b0),      
.test2_oe   (1'b0),      
.test2_a    (1'b0),      
.test2_def  (1'b0),      
.test2_y    (),
// test3
.test3_ie   (1'b1),
.test3_oe   (1'b0),
.test3_a    (1'b0),
.test3_def  (1'b0),
.test3_y    (pad_PPGDAC1_VSEL[11]),
// test4
.test4_ie   (1'b0),
.test4_oe   (1'b0),
.test4_a    (1'b0),
.test4_def  (1'b0),
.test4_y    (),
// test5
.test5_ie   (1'b1),
.test5_oe   (1'b0),
.test5_a    (1'b0),
.test5_def  (1'b0),
.test5_y    (pad_VCM1P5_BUF_EN1),
// test6
.test6_ie   (1'b1),
.test6_oe   (1'b0),
.test6_a    (1'b0),
.test6_def  (1'b0),
.test6_y    (pad_TIA_IDAC_74[2]),
// test7
.test7_ie   (1'b1),
.test7_oe   (1'b0),
.test7_a    (1'b0),
.test7_def  (1'b0),
.test7_y    (pad_BGH_CTRIM[0]),//BGL_1P5_CTIM[0]
// test8
.test8_ie   (1'b1),
.test8_oe   (1'b0),
.test8_a    (1'b0),
.test8_def  (1'b0),
.test8_y    (pad_TSC_INA_GSEL[0]),
// test9
.test9_ie   (1'b1),
.test9_oe   (1'b0),
.test9_a    (1'b0),
.test9_def  (1'b0),
.test9_y    (pad_Z_CALMD),
// test10
.test10_ie   (1'b0),
.test10_oe   (1'b0),
.test10_a    (1'b0),
.test10_def  (1'b0),
.test10_y    (),
// test11
.test11_ie   (1'b0),
.test11_oe   (1'b0),
.test11_a    (1'b0),
.test11_def  (1'b0),
.test11_y    (),
// test12
.test12_ie   (1'b1),
.test12_oe   (1'b0),
.test12_a    (1'b0),
.test12_def  (1'b0),
.test12_y    (),
// test13
.test13_ie   (1'b1),
.test13_oe   (1'b0),
.test13_a    (1'b0),
.test13_def  (1'b0),
.test13_y    (pad_PPGDAC0_VSEL[11]),
// test14
.test14_ie   (1'b1),
.test14_oe   (1'b0),
.test14_a    (1'b0),
.test14_def  (1'b0),
.test14_y    (pad_ACLEADOFF_ISEL_TRIM[1]),
// with pad interface
.iopad_gpio_y    (i_baf4p1_IOBUF_Y[18]),
.iopad_gpio_ie   (o_baf4p1_IOBUF_IE[18]),
.iopad_gpio_oe   (o_baf4p1_IOBUF_OE[18]),
.iopad_gpio_a    (o_baf4p1_IOBUF_A[18])
);
endmodule
