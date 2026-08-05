/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/* File Name	: cmsdk_mcu_clkctrl.v                                                   */
/* Project	: Nanochap Glucose Chip                                                     */
/* Description	: clock control                                                         */
/* Designer	: Daniel Wang                                                               */
/* Date		: 05/28/2019                                                                */
/* Revision	:                                                                           */
/* R001 first draft                             05/28/2019                              */
/* R002 add scan_clk mux                        07/29/2019                              */
/* R003 remove sram_en/dflash_en                09/10/2019                              */
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
module clk_ctrl (
output wire 	    D2A_ACLEADOFF_CLK,
output wire 	    D2A_RLD_CLK64K,

//input  wire   [2:0]    cic_rate,
input  wire         poresetn,               // global reset after sync by hfosc
input  wire         ext_clk_sel,            // external clk select
input  wire         ext_hfclk,              // external high frequency clk
input  wire         hfosc,                  // hfosc base clock input
input  wire         flash_bist_tck,         // flash bist clock
input  wire         scan_clk,               // atpg clock
input  wire         atpg_en,                // atpg enable
input  wire         scan_en,                // Tri add
input  wire 	      o_fifo_disable,
input  wire         dpstb_en,               //to use for gating flash clock
input  wire         Bioz_en,               // Bioz enable
output wire 	    Bioz_en_sync,
input  wire         imeas_en,               // imeas enable
input  wire         pmu_fclk_en,            // fclk enable when in idle state
input  wire         fclk_dynen,             // fclk dynamic clock enable

input  wire 	    bio_enable,
input  wire 	    ppg_ctrl_en,
output wire 	    ppg_ctrl_fclk,

input  wire [1:0]   data_type_sel,    //00 is sinwave, 01: DC, 10: square wave, 11: sinwave
output wire [9:0]   square_data,    
input  wire [9:0]   square_data_l,    
input  wire [9:0]   square_data_h,    
input  wire [15:0]  square_clk_div,

input  wire [1:0]   acleadoff_clk_sel,
input  wire [1:0]   rld_clk_reg,
output wire    m1k_reg_atpg,

input  wire [3:0]  iq_iclk_div, 
input  wire        iq_adc_clk_inv,

input  wire  [1:0]  pclk_div,               // pclk divider
input  wire  [2:0]  fclk_div,               // pclk divider
input  wire  [2:0]  iclk_div,               // imeas adc clock divider
input  wire  [7:0]  mclk_div,               // Bioz mclk clock divider
input  wire  [15:0]  checking_clk_div,               // checking clk clock divider
output wire 	    check_pulse_pclk,
input  wire	        imeas_adc_inv,	    // invert the input to analog imeas if 1, otherwise not inverted
output wire         hfosc_atpg,             // hfosc after atpg mux
output wire         flash_bist_tck_atpg,    // flash bist clock after atpg mux
output wire         fclk,                   // fclk after clock switching
output wire         pclk,                   // periperal clock free-running
output wire 	      fifo_pclk,
output wire         flash_fclk,
output wire         Bioz_pclk,             // for Bioz pclk
output wire         imeas_pclk,             // for imeas pclk
output wire         iq_pclk,             // for iq pclk
output wire         Bioz_mclk,             // Bioz mclk, 4m/N Hz
output wire         imeas_dig_adc_clk,      // imeas adc clock for digital 

output wire         iq_dig_adc_clk,      // iq adc clock for digital 
output wire         iq_adc_clk,      // iq adc clock for analog 

input  wire         notch_filter_enable,
output wire         nf_pclk,

input  wire         zmeas_en,               // Bioz enable
output wire         zmeas_pclk,             // for Bioz pclk
output wire         zmeas_mclk,             // Bioz mclk, 4m/N Hz

input  wire         SDM_CLK_GPIO_pha_sel,  // 
output wire         SDM_CLK_GPIO,          // 
output wire         imeas_adc_clk          // imeas adc clock for analog
);


//fclk_div
reg  [6:0]  fclk_div_cnt;
reg  [6:0]  fclk_div_num;
wire        fclk_sub;

always @ (*) begin
  case (fclk_div)
    3'b000: fclk_div_num = 7'd0;
    3'b001: fclk_div_num = 7'd1;
    3'b010: fclk_div_num = 7'd3;
    3'b011: fclk_div_num = 7'd7;
    3'b100: fclk_div_num = 7'd15;
    3'b101: fclk_div_num = 7'd31;
    3'b110: fclk_div_num = 7'd63;
    3'b111: fclk_div_num = 7'd127;
    default: fclk_div_num = 7'd0;
  endcase
end

always @ (posedge fclk or negedge poresetn) begin
  if (~poresetn) 
    fclk_div_cnt <= 7'b0;
  else if (fclk_div_cnt == fclk_div_num)
    fclk_div_cnt <= 7'b0;
  else
    fclk_div_cnt <= fclk_div_cnt + 7'b1;
end

reg fclk_div_filp_flag;
reg fclk_div_filp_lock;

always @ (*) begin
    if (fclk_div_cnt == fclk_div_num)
        fclk_div_filp_flag = ~fclk_div_filp_lock;
    else
        fclk_div_filp_flag = fclk_div_filp_lock;
end

always @ (posedge fclk or negedge poresetn) begin
    if (~poresetn)
        fclk_div_filp_lock <= 1'b0;
    else
        fclk_div_filp_lock <= fclk_div_filp_flag;
end 

`ifdef FPGA
reg fclk_div_reg;
wire fclk_div_q;
assign fclk_div_q = fclk_div_reg;
always @(posedge fclk or negedge poresetn) begin
if(~poresetn)
	fclk_div_reg <= 1'b0;
else	
	fclk_div_reg <= fclk_div_filp_flag;
end
assign iclk = fclk_div_q;
`else
// creat_generate_clk here
DFFRQX4M DFF_DIV_FCLK_SUB (.Q(fclk_div_q), .CK(fclk), .D(fclk_div_filp_flag), .RN(poresetn));

CLKMX2X4M DNT_DIV_FCLK_SUB_ATPG (.A(fclk_div_q), .B(scan_clk), .S0(atpg_en), .Y(fclk_sub));
`endif

//end


reg  [2:0]  pclk_div_cnt;
reg         i_pclken;
wire		    fclk_en;

reg         div_fclk_d;
reg         div_fclk_d_1t;
wire	      div_fclk_q;

reg  [6:0]  iclk_div_cnt;
reg  [6:0]  iclk_div_num;
reg  [10:0]  iq_iclk_div_cnt;
reg  [10:0]  iq_iclk_div_num;

wire        iclk;
wire        iq_iclk;

reg         div2_clk_div_pre;
wire        div2_clk_div;
wire	      div2_clk_atpg;
wire        hfosc_mux;

wire	    imeas_adc_inv_atpg;

`ifdef FPGA
assign hfosc_mux = hfosc;
assign hfosc_atpg = hfosc_mux;
assign flash_bist_tck_atpg = flash_bist_tck;
`else
// external clock select
CLKMX2X4M DNT_HFOSC_MUX (.A(hfosc), .B(ext_hfclk), .S0(ext_clk_sel), .Y(hfosc_mux));

// scan clock mux
CLKMX2X4M DNT_HFOSC_ATPG (.A(hfosc_mux), .B(scan_clk), .S0(atpg_en), .Y(hfosc_atpg));

// flash_bist_tck atpg mux
CLKMX2X4M DNT_FLASH_BIST_TCK_ATPG (.A(flash_bist_tck), .B(scan_clk), .S0(atpg_en), .Y(flash_bist_tck_atpg));
`endif


assign fclk_en = ~fclk_dynen | pmu_fclk_en;
//hclk gating
common_clock_gate 
u_cmsdk_clock_gate_hclk (
.clk        (hfosc_atpg),
.enable     (fclk_en),
.bypass     (scan_en),  //Tri change
.gated_clk  (fclk));

//add ppg controller clk gating
common_clock_gate 
u_cmsdk_clock_gate_ppg_ctrl_hclk (
.clk        (fclk),
.enable     (ppg_ctrl_en),
.bypass     (scan_en),  //Tri change
.gated_clk  (ppg_ctrl_fclk));



always @ (posedge fclk_sub or negedge poresetn) begin
  if (~poresetn) 
    pclk_div_cnt <= 3'b0;
  else
    pclk_div_cnt <= pclk_div_cnt + 3'b1;
end

always @ (*) begin
  case (pclk_div)
    2'b00: i_pclken = 1'b1;
    2'b01: i_pclken = (pclk_div_cnt[0]==1'b0);
    2'b10: i_pclken = (pclk_div_cnt[1:0]==2'b00);
    2'b11: i_pclken = (pclk_div_cnt[2:0]==3'b000);
    default: i_pclken = 1'b1;
  endcase
end

common_clock_gate 
u_cmsdk_clock_gate_pclk (
.clk        (fclk_sub),
.enable     (i_pclken),
.bypass     (scan_en),  //Tri change
.gated_clk  (pclk));

wire o_fifo_enable;
assign o_fifo_enable = ~o_fifo_disable;

common_clock_gate 
u_cmsdk_clock_gate_fifo_pclk (
.clk        (pclk),
.enable     (o_fifo_enable),
.bypass     (scan_en),  //Tri change
.gated_clk  (fifo_pclk));

//Bioz pclk/pclkg gating
/*
common_clock_gate 
u_cmsdk_clock_gate_Bioz_pclk (
.clk        (pclk),
.enable     (Bioz_en),
.bypass     (scan_en),  //Tri change
.gated_clk  (Bioz_pclk));
*/
//imeas pclk/pclkg gating
common_clock_gate 
u_cmsdk_clock_gate_imeas_pclk (
.clk        (pclk),
.enable     (imeas_en),
.bypass     (scan_en),  //Tri change
.gated_clk  (imeas_pclk));

wire Bioz_en_sync_bak;
reg Bioz_en_sync_bak_d1;
reg Bioz_en_sync_bak_d2;

common_clock_gate 
u_cmsdk_clock_gate_iq_pclk (
.clk        (pclk),
.enable     (Bioz_en_sync),
.bypass     (scan_en),  //Tri change
.gated_clk  (iq_pclk));



//nf gating
common_clock_gate 
u_cmsdk_clock_gate_nf_pclk (
.clk        (pclk),
.enable     (notch_filter_enable),
.bypass     (scan_en),  //Tri change
.gated_clk  (nf_pclk));


//Bioz mclk div from Amir requirement
common_sync_bit   //common_bit_sync 
 #(
.RST_VAL(0))
 u_Bioz_gen_clk_sync (
       .clk(fclk),
       .rst_(poresetn),
       .async_in(Bioz_en),
       .sync_out(Bioz_en_sync_bak)
      );

always @ (posedge fclk or negedge poresetn) begin
	if (~poresetn) begin
 		Bioz_en_sync_bak_d1 <= 1'b0;
 		Bioz_en_sync_bak_d2 <= 1'b0;
	end else begin
 		Bioz_en_sync_bak_d1 <= Bioz_en_sync_bak;
 		Bioz_en_sync_bak_d2 <= Bioz_en_sync_bak_d1;
	end
end

assign Bioz_en_sync = Bioz_en_sync_bak | Bioz_en_sync_bak_d1 | Bioz_en_sync_bak_d2;

reg  [7:0] mclk_div_cnt; 
always @ (posedge fclk or negedge poresetn) begin
  if (~poresetn)
    mclk_div_cnt <= 8'b0;
  else if (~Bioz_en_sync)
    mclk_div_cnt <= 8'b0;
  else if (mclk_div_cnt == mclk_div)
    mclk_div_cnt <= 8'b0;
  else
    mclk_div_cnt <= mclk_div_cnt + 8'b1;
end
wire  [7:0] mclk_div_divby2; 
assign mclk_div_divby2 = mclk_div>>1; 
reg mclk_reg;
always @ (posedge fclk or negedge poresetn) begin
  if (~poresetn)
    mclk_reg <= 1'b0;
  else if (~Bioz_en_sync)
    mclk_reg <= 1'b0;
  else if ((mclk_div_cnt == mclk_div_divby2) | (mclk_div_cnt == mclk_div))
    mclk_reg <= ~mclk_reg;
  else
    mclk_reg <= mclk_reg;
end

wire mclk_reg_final;
wire mclk_reg_final_atpg;
wire mclk_div_sel;
assign mclk_div_sel = mclk_div==8'b0;
CLKMX2X4M DNT_DIV_MCLK_SEL  (.A(mclk_reg), .B(fclk), .S0(mclk_div_sel), .Y(mclk_reg_final));
CLKMX2X4M DNT_DIV_MCLK_ATPG (.A(mclk_reg_final), .B(scan_clk), .S0(atpg_en), .Y(mclk_reg_final_atpg));

//1K generator
reg [6:0] m1k_cnt;
always @ (posedge fclk_sub or negedge poresetn) begin
  if (~poresetn)
    m1k_cnt <= 7'b0;
  else if (~bio_enable)
    m1k_cnt <= 7'b0;
  else if (m1k_cnt == 7'h7F)
    m1k_cnt <= 7'b0;
  else
    m1k_cnt <= m1k_cnt + 7'b1;
end
reg m1k_reg;
always @ (posedge fclk_sub or negedge poresetn) begin
  if (~poresetn)
    m1k_reg <= 1'b0;
  else if (~bio_enable)
    m1k_reg <= 1'b0;
  else if (m1k_cnt == 7'h7F)
    m1k_reg <= ~m1k_reg;
  else
    m1k_reg <= m1k_reg ;
end
//wire m1k_reg_atpg;
CLKMX2X4M DNT_M1KCLK_ATPG (.A(m1k_reg), .B(scan_clk), .S0(atpg_en), .Y(m1k_reg_atpg));

reg  [15:0] checking_clk_div_cnt;
always @ (posedge m1k_reg_atpg or negedge poresetn) begin
  if (~poresetn)
    checking_clk_div_cnt <= 16'b0;
  else if (~bio_enable)
    checking_clk_div_cnt <= 16'b0;
  else if (checking_clk_div_cnt == checking_clk_div)
    checking_clk_div_cnt <= 16'b0;
  else
    checking_clk_div_cnt <= checking_clk_div_cnt + 16'b1;
end
wire  [15:0] checking_clk_div_divby2;
assign checking_clk_div_divby2 = checking_clk_div>>1;
reg checking_clk_reg;
always @ (posedge m1k_reg_atpg or negedge poresetn) begin
  if (~poresetn)
    checking_clk_reg <= 1'b0;
  else if (~bio_enable)
    checking_clk_reg <= 1'b0;
  else if ((checking_clk_div_cnt == checking_clk_div_divby2) | (checking_clk_div_cnt == checking_clk_div))
    checking_clk_reg <= ~checking_clk_reg;
  else
    checking_clk_reg <= checking_clk_reg;
end

wire checking_clk_reg_sync;
common_sync_bit u_checking_clk_reg_pclk(
.async_in(checking_clk_reg),
.clk(pclk),
.rst_(poresetn),
.sync_out(checking_clk_reg_sync)
);

reg checking_clk_reg_sync_d1;
always @ (posedge pclk or negedge poresetn) begin
  if (~poresetn)
	checking_clk_reg_sync_d1 <= 1'b0;
  else
	checking_clk_reg_sync_d1 <= checking_clk_reg_sync;
end

assign check_pulse_pclk = checking_clk_reg_sync_d1 & (~checking_clk_reg_sync);

//=================================
//square wave
//input  wire [1:0]   data_type_sel,    //00 is sinwave, 01: DC, 10: square wave, 11: sinwave
wire en_square;
assign en_square = (data_type_sel == 2'b10);

reg  [15:0] square_clk_div_cnt;
always @ (posedge m1k_reg_atpg or negedge poresetn) begin
  if (~poresetn)
    square_clk_div_cnt <= 16'b0;
  //else if (~bio_enable)
  else if (~en_square)
    square_clk_div_cnt <= 16'b0;
  else if (square_clk_div_cnt == square_clk_div)
    square_clk_div_cnt <= 16'b0;
  else
    square_clk_div_cnt <= square_clk_div_cnt + 16'b1;
end
wire  [15:0] square_clk_div_divby2;
assign square_clk_div_divby2 = square_clk_div>>1;
reg square_clk_reg;
always @ (posedge m1k_reg_atpg or negedge poresetn) begin
  if (~poresetn)
    square_clk_reg <= 1'b0;
  //else if (~bio_enable)
  else if (~en_square)
    square_clk_reg <= 1'b0;
  else if ((square_clk_div_cnt == square_clk_div_divby2) | (square_clk_div_cnt == square_clk_div))
    square_clk_reg <= ~square_clk_reg;
  else
    square_clk_reg <= square_clk_reg;
end
wire [9:0]   square_data_temp;    
//assign  square_data = square_clk_reg ? square_data_h : square_data_l;    
assign  square_data_temp = square_clk_reg ? square_data_h : square_data_l;    
//remove glitch
reg [9:0]   square_data_temp_reg;    
always @ (posedge m1k_reg_atpg or negedge poresetn) begin
  if (~poresetn)
    square_data_temp_reg <= 10'b0;
  else
    square_data_temp_reg <= square_data_temp;
end
assign  square_data = square_data_temp_reg;    

//================================
//Bioz adc clock gating
common_clock_gate 
u_cmsdk_clock_gate_Bioz_clk (
.clk        (mclk_reg_final_atpg),
.enable     (Bioz_en_sync),
.bypass     (scan_en),  //Tri change
.gated_clk  (Bioz_mclk));

//flash clock gating
common_clock_gate 
u_cmsdk_clock_gate_flash_fclk (
.clk        (fclk_sub),
.enable     (!dpstb_en),
.bypass     (scan_en),  //Tri change
.gated_clk  (flash_fclk));

//imeas adc clock divider 50% duty
always @ (*) begin
  case (iclk_div)
    3'b000: iclk_div_num = 7'd0;
    3'b001: iclk_div_num = 7'd1;
    3'b010: iclk_div_num = 7'd3;
    3'b011: iclk_div_num = 7'd7;
    3'b100: iclk_div_num = 7'd15;
    3'b101: iclk_div_num = 7'd31;
    3'b110: iclk_div_num = 7'd63;
    3'b111: iclk_div_num = 7'd127;
    default: iclk_div_num = 7'd0;
  endcase
end

always @ (posedge fclk_sub or negedge poresetn) begin
  if (~poresetn) 
    iclk_div_cnt <= 7'b0;
  else if (iclk_div_cnt == iclk_div_num)
    iclk_div_cnt <= 7'b0;
  else
    iclk_div_cnt <= iclk_div_cnt + 7'b1;
end

always @ (*) begin
    if (iclk_div_cnt == iclk_div_num)
        div_fclk_d = ~div_fclk_d_1t;
    else
        div_fclk_d = div_fclk_d_1t;
end

always @ (posedge fclk_sub or negedge poresetn) begin
    if (~poresetn)
        div_fclk_d_1t <= 1'b0;
    else
        div_fclk_d_1t <= div_fclk_d;
end

`ifdef FPGA
reg div_fclk_q_reg;
assign div_fclk_q = div_fclk_q_reg;
always @(posedge fclk_sub or negedge poresetn) begin
if(~poresetn)
	div_fclk_q_reg <= 1'b0;
else	
	div_fclk_q_reg <= div_fclk_d;
end
assign iclk = div_fclk_q;
`else
// creat_generate_clk here
DFFRQX4M DFF_DIV_FCLK (.Q(div_fclk_q), .CK(fclk_sub), .D(div_fclk_d), .RN(poresetn));

CLKMX2X4M DNT_DIV_FCLK_ATPG (.A(div_fclk_q), .B(scan_clk), .S0(atpg_en), .Y(iclk));
`endif

//imeas adc clock gating
common_clock_gate 
u_cmsdk_clock_gate_iadc_clk (
.clk        (iclk),
.enable     (imeas_en),
.bypass     (scan_en),  //Tri change
.gated_clk  (imeas_dig_adc_clk));

CLKMX2X4M DNT_DIV_SDM_CLK (.A(imeas_dig_adc_clk), .B(~imeas_dig_adc_clk ), .S0(SDM_CLK_GPIO_pha_sel), .Y(SDM_CLK_GPIO));
//assign         SDM_CLK_GPIO = SDM_CLK_GPIO_pha_sel ? ~imeas_dig_adc_clk : imeas_dig_adc_clk;          // 
//++++++++++++++++++++++++++++++++++++++++++++
//for  IQ clk
//+++++++++++++++++++++++++++++++++++++++++++++
//imeas adc clock divider 50% duty
reg         iq_div_fclk_d;
reg         iq_div_fclk_d_1t;
wire	    iq_div_fclk_q;
always @ (*) begin
  case (iq_iclk_div)
    4'b0000: iq_iclk_div_num = 11'd0;
    4'b0001: iq_iclk_div_num = 11'd1;
    4'b0010: iq_iclk_div_num = 11'd3;
    4'b0011: iq_iclk_div_num = 11'd7;
    4'b0100: iq_iclk_div_num = 11'd15;
    4'b0101: iq_iclk_div_num = 11'd31;
    4'b0110: iq_iclk_div_num = 11'd63;
    4'b0111: iq_iclk_div_num = 11'd127;
    4'b1000: iq_iclk_div_num = 11'd255;
    4'b1001: iq_iclk_div_num = 11'd511;
    4'b1010: iq_iclk_div_num = 11'd1023;
    4'b1011: iq_iclk_div_num = 11'd2047;
    default: iq_iclk_div_num = 11'd0;
  endcase
end

always @ (posedge fclk_sub or negedge poresetn) begin
  if (~poresetn) 
    iq_iclk_div_cnt <= 11'b0;
  else if (iq_iclk_div_cnt == iq_iclk_div_num)
    iq_iclk_div_cnt <= 11'b0;
  else
    iq_iclk_div_cnt <= iq_iclk_div_cnt + 11'b1;
end

always @ (*) begin
    if (iq_iclk_div_cnt == iq_iclk_div_num)
        iq_div_fclk_d = ~iq_div_fclk_d_1t;
    else
        iq_div_fclk_d = iq_div_fclk_d_1t;
end

always @ (posedge fclk_sub or negedge poresetn) begin
    if (~poresetn)
        iq_div_fclk_d_1t <= 1'b0;
    else
        iq_div_fclk_d_1t <= iq_div_fclk_d;
end

// creat_generate_clk here
DFFRQX4M DFF_IQ_DIV_FCLK (.Q(iq_div_fclk_q), .CK(fclk_sub), .D(iq_div_fclk_d), .RN(poresetn));

CLKMX2X4M DNT_IQ_DIV_FCLK_ATPG (.A(iq_div_fclk_q), .B(scan_clk), .S0(atpg_en), .Y(iq_iclk));

//imeas adc clock gating
common_clock_gate 
u_cmsdk_clock_gate_iq_adc_clk (
.clk        (iq_iclk),
.enable     (Bioz_en_sync),
.bypass     (scan_en),  //Tri change
.gated_clk  (iq_dig_adc_clk));

wire iq_adc_inv_atpg;

CLKMX2X2M DNT_IQ_ADC_CLK_ATPG (.A(iq_adc_clk_inv), .B(1'b1), .S0(atpg_en), .Y(iq_adc_inv_atpg));
CLKMX2X4M DNT_IQ_ADC_CLK_INV  (.A(~iq_dig_adc_clk), .B(iq_dig_adc_clk), .S0(iq_adc_inv_atpg), .Y(iq_adc_clk));


//++++++++++++++++++++++++++++++++++++++++++++

//ac lead off detection clock
reg[2:0] leadclk_div_num;
always @ (*) begin
  case (acleadoff_clk_sel)
    2'b00: leadclk_div_num = 3'd0;
    2'b01: leadclk_div_num = 3'd1;
    2'b10: leadclk_div_num = 3'd3;
    2'b11: leadclk_div_num = 3'd7;
    default: leadclk_div_num = 3'd0;
  endcase
end
reg[2:0] leadclk_div_cnt;
always @ (posedge fclk_sub or negedge poresetn) begin
  if (~poresetn) 
    leadclk_div_cnt <= 3'b0;
  else if (leadclk_div_cnt == leadclk_div_num)
    leadclk_div_cnt <= 3'b0;
  else
    leadclk_div_cnt <= leadclk_div_cnt + 3'b1;
end

 reg acleadoff_clk_reg; 
always @ (posedge fclk_sub or negedge poresetn) begin
  if (~poresetn) 
     acleadoff_clk_reg <= 1'b0;
  else if(leadclk_div_cnt == leadclk_div_num)
     acleadoff_clk_reg <= ~acleadoff_clk_reg;
  else acleadoff_clk_reg <= acleadoff_clk_reg;
end

CLKMX2X2M DNT_LEADOFF_CLK_ATPG (.A(acleadoff_clk_reg), .B(scan_clk), .S0(atpg_en), .Y(D2A_ACLEADOFF_CLK));
//=============================

reg[3:0] rldclk_div_num;
always @ (*) begin
  case (rld_clk_reg)
    2'b00: rldclk_div_num = 4'd1;
    2'b01: rldclk_div_num = 4'd3;
    2'b10: rldclk_div_num = 4'd7;
    2'b11: rldclk_div_num = 4'd15;
    default: rldclk_div_num = 4'd0;
  endcase
end
reg[3:0] rldclk_div_cnt;
always @ (posedge fclk_sub or negedge poresetn) begin
  if (~poresetn)
    rldclk_div_cnt <= 4'b0;
  else if (rldclk_div_cnt == rldclk_div_num)
    rldclk_div_cnt <= 4'b0;
  else
    rldclk_div_cnt <= rldclk_div_cnt + 4'b1;
end

 reg acrldoff_clk_reg;
always @ (posedge fclk_sub or negedge poresetn) begin
  if (~poresetn)
     acrldoff_clk_reg <= 1'b0;
  else if(rldclk_div_cnt == rldclk_div_num)
     acrldoff_clk_reg <= ~acrldoff_clk_reg;
  else acrldoff_clk_reg <= acrldoff_clk_reg;
end

CLKMX2X2M DNT_RLD_CLK_ATPG (.A(acrldoff_clk_reg), .B(scan_clk), .S0(atpg_en), .Y(D2A_RLD_CLK64K));

//============================
`ifdef FPGA
assign imeas_adc_clk = imeas_adc_inv ? imeas_dig_adc_clk : ~imeas_dig_adc_clk;
`else
// add inverter, so that has the 1/2T setup and hold timing margin for analog<->digital timing
//CLKINVX4M DNT_IMEAS_ADC_CLK_INV (.A(imeas_dig_adc_clk), .Y(imeas_adc_clk));
CLKMX2X2M DNT_ADC_CLK_ATPG (.A(imeas_adc_inv), .B(1'b1), .S0(atpg_en), .Y(imeas_adc_inv_atpg));
CLKMX2X4M DNT_ADC_CLK_INV  (.A(~imeas_dig_adc_clk), .B(imeas_dig_adc_clk), .S0(imeas_adc_inv_atpg), .Y(imeas_adc_clk));
`endif
endmodule

