/*--------------------------------------------------------------------------------------*/
/*      Nanochap Confidential                                                           */
/*--------------------------------------------------------------------------------------*/
/* File Name	 : pinmux_always_on.v                                                   */
/* Project	 : BAF4P1 Chip                                                        	*/
/* Designer	 : Mohsen Radfar	                                               	*/
/* Description	 : to mux pin mux config values for io cell from top dig switchable domain*/
/* Date		 : 2/8/2022                                                          	*/
/*--------------------------------------------------------------------------------------*/
/* Revision History :                                                           	*/    
/* Data         Rev.     By             Description                                     */
/*--------------------------------------------------------------------------------------*/
/* 							                           	 */
/*--------------------------------------------------------------------------------------*/

module pinmux_always_on (
input  wire	        wakeup,

//sw domain pinmux to always on connections
input  wire [18:0]  i_IOBUF_IE,
input  wire [18:0]  i_IOBUF_CS,
input  wire [18:0]  i_IOBUF_PU,
input  wire [18:0]  i_IOBUF_SR,
input  wire [18:0]  i_IOBUF_DR,
input  wire [18:0]  i_IOBUF_A,
input  wire [18:0]  i_IOBUF_OE,
input  wire [18:0]  i_IOBUF_OS,
input  wire [18:0]  i_IOBUF_OD,
input  wire [18:0]  i_IOBUF_PD,
output wire [18:0]  o_IOBUF_Y,
input  wire         i_IO_testmode0_PD,
input  wire         i_IO_testmode1_PD,
input  wire         i_IO_exresetn_PU,
output wire 				o_iopad_testmode0_en_y,
output wire 				o_iopad_testmode1_en_y,
output wire				  o_iopad_resetn_y,

//always on to io cells connections
output wire [18:0]  o_IOBUF_IE,
output wire [18:0]  o_IOBUF_CS,
output wire [18:0]  o_IOBUF_PU,
output wire [18:0]  o_IOBUF_SR,
output wire [18:0]  o_IOBUF_DR,
output wire [18:0]  o_IOBUF_A,
output wire [18:0]  o_IOBUF_OE,
output wire [18:0]  o_IOBUF_OS,
output wire [18:0]  o_IOBUF_OD,
output wire [18:0]  o_IOBUF_PD,
input  wire [18:0]  i_IOBUF_Y,

output wire 			  o_IOBUF_IE_testmode0,
output wire 			  o_IOBUF_PU_testmode0,
output wire 			  o_IOBUF_PD_testmode0,
input wire 			    i_iopad_testmode0_en_y,

output wire 			  o_IOBUF_IE_testmode1,
output wire 			  o_IOBUF_PU_testmode1,
output wire 			  o_IOBUF_PD_testmode1,
input wire 			    i_iopad_testmode1_en_y,

output wire 			  o_IOBUF_IE_resetn,
output wire 			  o_IOBUF_PU_resetn,
output wire 			  o_IOBUF_PD_resetn,
input wire 			    i_iopad_resetn_y,

//SDM
input  wire         i_D2A_SDM_EN,
input  wire         i_D2A_SDM_CLK,
input  wire  [2:0]  i_D2A_SDM_VIN_SEL,
input  wire  [1:0]  i_D2A_SDM_BIAS,
output wire         o_D2A_SDM_EN_AO,
output wire         o_D2A_SDM_CLK_AO,
output wire  [2:0]  o_D2A_SDM_VIN_SEL_AO,
output wire  [1:0]  o_D2A_SDM_BIAS_AO,

//TSC
input  wire  [2:0]  i_D2A_TSC_INA_GSEL,
input  wire         i_D2A_TSC_EN,
input  wire  [2:0]  i_D2A_TSC_BJT_SEL,
input  wire         i_D2A_TSC_OUT_SEL,
input  wire         i_D2A_TSC_INA_EN,
output wire  [2:0]  o_D2A_TSC_INA_GSEL_AO,
output wire         o_D2A_TSC_EN_AO,
output wire  [2:0]  o_D2A_TSC_BJT_SEL_AO,
output wire         o_D2A_TSC_OUT_SEL_AO,
output wire         o_D2A_TSC_INA_EN_AO,

//PPG
input  wire         i_D2A_EN_PPG_AF,
input  wire         i_D2A_EN_PPG_BUFFER,
input  wire         i_D2A_EN_PPG_SH,
input  wire         i_D2A_EN_TIA,
input  wire         i_D2A_EN_TIA_VREFBUFFER,
input  wire         i_D2A_LEDDAC_SEL,
input  wire  [1:0]  i_D2A_LEDSEL,
input  wire         i_D2A_LED_EN,
input  wire         i_D2A_LED_STANDBYEN,
input  wire  [1:0]  i_D2A_PDVREF_SEL,
input  wire         i_D2A_PPG_SH_CK,
input  wire  [1:0]  i_D2A_PPG_TEST_IN,
input  wire  [1:0]  i_D2A_PPG_TEST_OUT,
input  wire  [3:0]  i_D2A_TIA_GAIN,
input  wire  [7:0]  i_D2A_TIA_IDAC,
input  wire         i_D2A_PPGDAC0_EN,
input  wire [11:0]  i_D2A_PPGDAC0_VSEL,
input  wire         i_D2A_PPGDAC1_EN,
input  wire [11:0]  i_D2A_PPGDAC1_VSEL,
input  wire         i_D2A_EN_PPGDAC_BUFFER,
output wire         o_D2A_EN_PPG_AF_AO,
output wire         o_D2A_EN_PPG_BUFFER_AO,
output wire         o_D2A_EN_PPG_SH_AO,
output wire         o_D2A_EN_TIA_AO,
output wire         o_D2A_EN_TIA_VREFBUFFER_AO,
output wire         o_D2A_LEDDAC_SEL_AO,
output wire  [1:0]  o_D2A_LEDSEL_AO,
output wire         o_D2A_LED_EN_AO,
output wire         o_D2A_LED_STANDBYEN_AO,
output wire  [1:0]  o_D2A_PDVREF_SEL_AO,
output wire         o_D2A_PPG_SH_CK_AO,
output wire  [1:0]  o_D2A_PPG_TEST_IN_AO,
output wire  [1:0]  o_D2A_PPG_TEST_OUT_AO,
output wire  [3:0]  o_D2A_TIA_GAIN_AO,
output wire  [7:0]  o_D2A_TIA_IDAC_AO,
output wire         o_D2A_PPGDAC0_EN_AO,
output wire [11:0]  o_D2A_PPGDAC0_VSEL_AO,
output wire         o_D2A_PPGDAC1_EN_AO,
output wire [11:0]  o_D2A_PPGDAC1_VSEL_AO,
output wire         o_D2A_EN_PPGDAC_BUFFER_AO,

//ECG
input  wire         i_D2A_RLD_CLK64K,
input wire          i_D2A_ACLEADOFF_CLK,
input wire          i_D2A_Z_EN,
input  wire  [9:0]  i_D2A_ECGCAL_VSEL_TRIM,
output wire         o_D2A_RLD_CLK64K,
output wire         o_D2A_ACLEADOFF_CLK,
output wire         o_D2A_Z_EN,
output wire  [9:0]  o_D2A_ECGCAL_VSEL_TRIM,

//ATM
input  wire         i_D2A_ATM0,
input  wire         i_D2A_ATM1,
input  wire         i_D2A_ATM2,
input  wire         i_D2A_ATM3,
input  wire         i_D2A_ATM4,
input  wire         i_D2A_ATM5,
input  wire         i_D2A_ATM6,
input  wire         i_D2A_ATM7,
input  wire         i_D2A_ATM8,
input  wire         i_D2A_ATM9,
input  wire         i_D2A_ATM10,
input  wire         i_D2A_ATM11,
input  wire         i_D2A_ATM12,
output wire         o_D2A_ATM0_AO,
output wire         o_D2A_ATM1_AO,
output wire         o_D2A_ATM2_AO,
output wire         o_D2A_ATM3_AO,
output wire         o_D2A_ATM4_AO,
output wire         o_D2A_ATM5_AO,
output wire         o_D2A_ATM6_AO,
output wire         o_D2A_ATM7_AO,
output wire         o_D2A_ATM8_AO,
output wire         o_D2A_ATM9_AO,
output wire         o_D2A_ATM10_AO,
output wire         o_D2A_ATM11_AO,
output wire         o_D2A_ATM12_AO
);

//use low leakage values during low power mode (all values 0, except SR)
MX2X4M  DNT_MUX2_IOBUF_IE [18:0]       (.Y(o_IOBUF_IE), .B(i_IOBUF_IE), .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_CS [18:0]       (.Y(o_IOBUF_CS), .B(i_IOBUF_CS), .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_PU [18:0]       (.Y(o_IOBUF_PU), .B(i_IOBUF_PU), .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_SR [18:0]       (.Y(o_IOBUF_SR), .B(i_IOBUF_SR), .A(1'b1), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_DR [18:0]       (.Y(o_IOBUF_DR), .B(i_IOBUF_DR), .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_A  [18:0]       (.Y(o_IOBUF_A ), .B(i_IOBUF_A ), .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_OE [18:0]       (.Y(o_IOBUF_OE), .B(i_IOBUF_OE), .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_OS [18:0]       (.Y(o_IOBUF_OS), .B(i_IOBUF_OS), .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_OD [18:0]       (.Y(o_IOBUF_OD), .B(i_IOBUF_OD), .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_PD [18:0]       (.Y(o_IOBUF_PD), .B(i_IOBUF_PD), .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_Y  [18:0]       (.Y(o_IOBUF_Y ), .B(i_IOBUF_Y ), .A(1'b0), .S0(wakeup)); //not required but for consistency*/

/*assign o_IOBUF_IE = wakeup ? i_IOBUF_IE : 18'b0;
assign o_IOBUF_CS = wakeup ? i_IOBUF_CS : 18'b0;
assign o_IOBUF_PU = wakeup ? i_IOBUF_PU : 18'b0;
assign o_IOBUF_SR = wakeup ? i_IOBUF_SR : 18'b1;
assign o_IOBUF_DR = wakeup ? i_IOBUF_DR : 18'b0;
assign o_IOBUF_A  = wakeup ? i_IOBUF_A : 18'b0;
assign o_IOBUF_OE = wakeup ? i_IOBUF_OE : 18'b0;
assign o_IOBUF_OS = wakeup ? i_IOBUF_OS : 18'b0;
assign o_IOBUF_OD = wakeup ? i_IOBUF_OD : 18'b0;
assign o_IOBUF_PD = wakeup ? i_IOBUF_PD : 18'b0;
assign o_IOBUF_Y  = wakeup ? i_IOBUF_Y : 18'b0; //not required but for consistency*/

MX2X4M  DNT_MUX2_IOBUF_IE_testmode0       (.Y(o_IOBUF_IE_testmode0),   .B(1'b1),                   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_PU_testmode0       (.Y(o_IOBUF_PU_testmode0),   .B(1'b0),                   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_PD_testmode0       (.Y(o_IOBUF_PD_testmode0),   .B(i_IO_testmode0_PD),      .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_iopad_testmode0_en_y     (.Y(o_iopad_testmode0_en_y), .B(i_iopad_testmode0_en_y), .A(1'b0), .S0(wakeup));

MX2X4M  DNT_MUX2_IOBUF_IE_testmode1       (.Y(o_IOBUF_IE_testmode1),   .B(1'b1),                   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_PU_testmode1       (.Y(o_IOBUF_PU_testmode1),   .B(1'b0),                   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_PD_testmode1       (.Y(o_IOBUF_PD_testmode1),   .B(i_IO_testmode1_PD),      .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_iopad_testmode1_en_y     (.Y(o_iopad_testmode1_en_y), .B(i_iopad_testmode1_en_y), .A(1'b0), .S0(wakeup));

MX2X4M  DNT_MUX2_IOBUF_IE_resetn          (.Y(o_IOBUF_IE_resetn),      .B(1'b1),                   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_PU_resetn          (.Y(o_IOBUF_PU_resetn),      .B(i_IO_exresetn_PU),       .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_IOBUF_PD_resetn          (.Y(o_IOBUF_PD_resetn),      .B(1'b0),                   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_iopad_resetn_y           (.Y(o_iopad_resetn_y),       .B(i_iopad_resetn_y),       .A(1'b0), .S0(wakeup));

//SDM
MX2X4M  DNT_MUX2_D2A_SDM_EN               (.Y(o_D2A_SDM_EN_AO),        .B(i_D2A_SDM_EN),           .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_SDM_CLK              (.Y(o_D2A_SDM_CLK_AO),       .B(i_D2A_SDM_CLK),          .A(1'b0), .S0(wakeup));        
MX2X4M  DNT_MUX2_D2A_SDM_VIN_SEL   [2:0]  (.Y(o_D2A_SDM_VIN_SEL_AO),   .B(i_D2A_SDM_VIN_SEL),      .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_SDM_BIAS      [1:0]  (.Y(o_D2A_SDM_BIAS_AO),      .B(i_D2A_SDM_BIAS),         .A(1'b0), .S0(wakeup));  

//TSC
MX2X4M  DNT_MUX2_D2A_TSC_INA_GSEL  [2:0]  (.Y(o_D2A_TSC_INA_GSEL_AO),  .B(i_D2A_TSC_INA_GSEL),     .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_TSC_EN               (.Y(o_D2A_TSC_EN_AO),        .B(i_D2A_TSC_EN),           .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_TSC_BJT_SEL   [2:0]  (.Y(o_D2A_TSC_BJT_SEL_AO),   .B(i_D2A_TSC_BJT_SEL),      .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_TSC_OUT_SEL          (.Y(o_D2A_TSC_OUT_SEL_AO),   .B(i_D2A_TSC_OUT_SEL),      .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_TSC_INA_EN           (.Y(o_D2A_TSC_INA_EN_AO),    .B(i_D2A_TSC_INA_EN),       .A(1'b0), .S0(wakeup));

//PPG
MX2X4M  DNT_MUX2_D2A_EN_PPG_AF                (.Y(o_D2A_EN_PPG_AF_AO),          .B(i_D2A_EN_PPG_AF),          .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_EN_PPG_BUFFER            (.Y(o_D2A_EN_PPG_BUFFER_AO),      .B(i_D2A_EN_PPG_BUFFER),      .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_EN_PPG_SH                (.Y(o_D2A_EN_PPG_SH_AO),          .B(i_D2A_EN_PPG_SH),          .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_EN_TIA                   (.Y(o_D2A_EN_TIA_AO),             .B(i_D2A_EN_TIA),             .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_EN_TIA_VREFBUFFER        (.Y(o_D2A_EN_TIA_VREFBUFFER_AO),  .B(i_D2A_EN_TIA_VREFBUFFER),  .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_LEDDAC_SEL               (.Y(o_D2A_LEDDAC_SEL_AO),         .B(i_D2A_LEDDAC_SEL),         .A(1'b0), .S0(wakeup)); 
MX2X4M  DNT_MUX2_D2A_LEDSEL            [1:0]  (.Y(o_D2A_LEDSEL_AO),             .B(i_D2A_LEDSEL),             .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_LED_EN                   (.Y(o_D2A_LED_EN_AO),             .B(i_D2A_LED_EN),             .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_LED_STANDBYEN            (.Y(o_D2A_LED_STANDBYEN_AO),      .B(i_D2A_LED_STANDBYEN),      .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_PDVREF_SEL        [1:0]  (.Y(o_D2A_PDVREF_SEL_AO),         .B(i_D2A_PDVREF_SEL),         .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_PPG_SH_CK                (.Y(o_D2A_PPG_SH_CK_AO),          .B(i_D2A_PPG_SH_CK),          .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_PPG_TEST_IN       [1:0]  (.Y(o_D2A_PPG_TEST_IN_AO),        .B(i_D2A_PPG_TEST_IN),        .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_PPG_TEST_OUT      [1:0]  (.Y(o_D2A_PPG_TEST_OUT_AO),       .B(i_D2A_PPG_TEST_OUT),       .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_TIA_GAIN          [3:0]  (.Y(o_D2A_TIA_GAIN_AO),           .B(i_D2A_TIA_GAIN),           .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_TIA_IDAC          [7:0]  (.Y(o_D2A_TIA_IDAC_AO),           .B(i_D2A_TIA_IDAC),           .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_PPGDAC0_EN               (.Y(o_D2A_PPGDAC0_EN_AO),         .B(i_D2A_PPGDAC0_EN),         .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_PPGDAC0_VSEL     [11:0]  (.Y(o_D2A_PPGDAC0_VSEL_AO),       .B(i_D2A_PPGDAC0_VSEL),       .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_PPGDAC1_EN               (.Y(o_D2A_PPGDAC1_EN_AO),         .B(i_D2A_PPGDAC1_EN),         .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_PPGDAC1_VSEL     [11:0]  (.Y(o_D2A_PPGDAC1_VSEL_AO),       .B(i_D2A_PPGDAC1_VSEL),       .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_EN_PPGDAC_BUFFER         (.Y(o_D2A_EN_PPGDAC_BUFFER_AO),   .B(i_D2A_EN_PPGDAC_BUFFER),   .A(1'b0), .S0(wakeup));

//ECG
MX2X4M  DNT_MUX2_D2A_RLD_CLK64K_BUFFER              (.Y(o_D2A_RLD_CLK64K),       .B(i_D2A_RLD_CLK64K),        .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_ACLEADOFF_CLK_BUFFER           (.Y(o_D2A_ACLEADOFF_CLK),    .B(i_D2A_ACLEADOFF_CLK),     .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_Z_EN_BUFFER                    (.Y(o_D2A_Z_EN),             .B(i_D2A_Z_EN),              .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_ECGCAL_VSEL_TRIM_BUFFER [9:0]  (.Y(o_D2A_ECGCAL_VSEL_TRIM), .B(i_D2A_ECGCAL_VSEL_TRIM),  .A(1'b0), .S0(wakeup));


//ATM
MX2X4M  DNT_MUX2_D2A_ATM0   (.Y(o_D2A_ATM0_AO),   .B(i_D2A_ATM0),   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_ATM1   (.Y(o_D2A_ATM1_AO),   .B(i_D2A_ATM1),   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_ATM2   (.Y(o_D2A_ATM2_AO),   .B(i_D2A_ATM2),   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_ATM3   (.Y(o_D2A_ATM3_AO),   .B(i_D2A_ATM3),   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_ATM4   (.Y(o_D2A_ATM4_AO),   .B(i_D2A_ATM4),   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_ATM5   (.Y(o_D2A_ATM5_AO),   .B(i_D2A_ATM5),   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_ATM6   (.Y(o_D2A_ATM6_AO),   .B(i_D2A_ATM6),   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_ATM7   (.Y(o_D2A_ATM7_AO),   .B(i_D2A_ATM7),   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_ATM8   (.Y(o_D2A_ATM8_AO),   .B(i_D2A_ATM8),   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_ATM9   (.Y(o_D2A_ATM9_AO),   .B(i_D2A_ATM9),   .A(1'b0), .S0(wakeup));
MX2X4M  DNT_MUX2_D2A_ATM10  (.Y(o_D2A_ATM10_AO),  .B(i_D2A_ATM10),  .A(1'b0), .S0(wakeup));  
MX2X4M  DNT_MUX2_D2A_ATM11  (.Y(o_D2A_ATM11_AO),  .B(i_D2A_ATM11),  .A(1'b0), .S0(wakeup));  
MX2X4M  DNT_MUX2_D2A_ATM12  (.Y(o_D2A_ATM12_AO),  .B(i_D2A_ATM12),  .A(1'b0), .S0(wakeup));  
/*
assign o_IOBUF_IE_testmode0 = wakeup ? 1'b1 : 1'b0;
assign o_IOBUF_PU_testmode0 = wakeup ? 1'b0 : 1'b0;
assign o_IOBUF_PD_testmode0 = wakeup ? 1'b1 : 1'b0;
assign o_iopad_testmode0_en_y = wakeup ? i_iopad_testmode0_en_y : 1'b0; //not required but for consistency

assign o_IOBUF_IE_testmode1 = wakeup ? 1'b1 : 1'b0;
assign o_IOBUF_PU_testmode1 = wakeup ? 1'b0 : 1'b0;
assign o_IOBUF_PD_testmode1 = wakeup ? 1'b1 : 1'b0;
assign o_iopad_testmode1_en_y = wakeup ? i_iopad_testmode1_en_y : 1'b0; //not required but for consistency

assign o_IOBUF_IE_resetn = wakeup ? 1'b1 : 1'b0;
assign o_IOBUF_PU_resetn = wakeup ? 1'b1 : 1'b0;
assign o_IOBUF_PD_resetn = wakeup ? 1'b0 : 1'b0;
assign o_iopad_resetn_y = wakeup ? i_iopad_resetn_y : 1'b0; //not required but for consistency
*/
endmodule
