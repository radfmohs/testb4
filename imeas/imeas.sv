/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/* File Name	: cmsdk_apb_imeas.v                                                     */
/* Project	: Nanochap Glucose Chip                                                     */
/* Description	: Glucose measument digital part                                        */
/* Designer	: Daniel Wang                                                               */
/* Date		: 05/21/2019                                                                */
/* Revision	: R001 first draft                                                          */
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/

module imeas(
//clock and reset
flash2imeas.slave       flash2imeas,
spi2imeas.slave         spi2imeas,

input wire        pclk,             // pclk
input wire        adc_clk,          // adc working clock, divider of 256khz
input wire        nf_pclk,             // pclk
input wire        presetn,          // reset
input wire        atpg_en,          // atpg enable
input wire        scan_en,          // Tri add
//input/ouput wires from/to SPI
output wire   [2:0]    cic_rate,
output reg       notch_filter_enable,
//xin add 24 May 2024 for co-work with led_status
input  wire 	  LED_STATUS,   //1 is led2, 0 is led1 ,from ppg_controller
input  wire 	  D2A_PPG_SH_CK,   //from ppg_controller
input  wire 	  check_pulse_pclk,

input  wire         m1k_reg_atpg,

input  wire         D2A_ACLEADOFF_EN,
input  wire         D2A_DCLEADOFF_EN,
input  wire         A2D_ACLEADOFF_STATN,
input  wire         A2D_ACLEADOFF_STATP,

input  wire    	    A2D_LOFF_STATN,
input  wire    	    A2D_LOFF_STATP,

output wire      chdata_en_n,
output wire   [17:0]   chdata,
//output wire            int_set,
//interrupt
output wire       imeas_int,        // interrupt 
output wire       imeas_int_alarm,        // interrupt 
//with analog
input  wire       imeas_adc_din,    // adc serial data input

output wire [3:0] imeas_chnum      // register: channel number select

);

wire imeas_int_temp;






//I/O
wire         notch_filter_en;
wire [1:0]   gain_mul;
wire [15:0]  nf_unstale_tar; 
assign notch_filter_en = spi2imeas.notch_filter_en;
assign gain_mul        = spi2imeas.gain_mul;
assign nf_unstale_tar  = spi2imeas.nf_unstable_time;



wire         leadoff_det_en;
wire         leadoff_int_en;
wire         leadoff_active;
wire [1:0]   switch_duration_sel;
wire [1:0]   leadoff_type_sel_reg;
wire [7:0]   leadoff_tgt_0;
wire [7:0]   leadoff_tgt_1;
wire [7:0]   leadoff_switch_tgt;


assign  leadoff_int_en = spi2imeas.leadoff_int_en;
assign  leadoff_det_en = spi2imeas.leadoff_det_en;

assign  leadoff_type_sel_reg = spi2imeas.leadoff_type_sel_reg;
assign  switch_duration_sel  = spi2imeas.switch_duration_sel;
assign  leadoff_active       = spi2imeas.leadoff_active;

assign  leadoff_tgt_0      = spi2imeas.leadoff_tgt_0;
assign  leadoff_tgt_1      = spi2imeas.leadoff_tgt_1;
assign  leadoff_switch_tgt = spi2imeas.leadoff_switch_tgt;


 wire	   int_alarm_clr;
 wire	   int_clr;
 wire	   int_length_slct;

assign int_clr       = spi2imeas.o_imeas_int_clr;
assign int_alarm_clr =  spi2imeas.o_imeas_int_alarm_clr;
assign int_length_slct    =  spi2imeas.int_length;


 wire [15:0]  threshold_hi;
 wire [15:0]  threshold_lo;
 wire	      int_alarm_en;
 wire [7:0]   reg_rstval;
 wire [1:0]   imeas_input_format;
 wire         imeas_grp_ctl;
 wire [11:0]  active_channel_num; //[3:0] chnA,[7:4] chnB, [11:8] chnC 
 wire [15:0]  reg_ctrl;
 wire [7:0]   reg_ch;
 wire [2:0]   reg_seq;

assign threshold_hi  = spi2imeas.o_threshold_hi;
assign threshold_lo  = spi2imeas.o_threshold_lo;
assign int_alarm_en  = spi2imeas.o_int_alarm_en;
assign reg_ctrl      = spi2imeas.o_imeas_reg_ctrl;
assign reg_ch        = spi2imeas.o_imeas_reg_ch;
assign reg_seq       = spi2imeas.o_imeas_reg_seq;
assign reg_rstval    = spi2imeas.o_imeas_reg_rstval;

//assign = spi2imeas.o_imeas_en;
assign imeas_input_format = spi2imeas.o_imeas_input_format;
assign active_channel_num = spi2imeas.o_active_channel_num;
assign imeas_grp_ctl      = spi2imeas.o_imeas_grp_ctl;        








wire       imeas_int_alarm_sts;
wire 	   imeas_int_sts;
wire 	   imeas_int_sts0;
wire 	   imeas_int_sts1;
wire 	   imeas_bio_int_sts;
wire       int_sts_switch_loff_statn;
wire       int_sts_duration_loff_statn;
wire       int_sts_switch_loff_statp;
wire       int_sts_duration_loff_statp;
wire       int_sts_switch_acloff_statn;
wire       int_sts_duration_acloff_statn;
wire       int_sts_switch_acloff_statp;
wire       int_sts_duration_acloff_statp;

reg [15:0]  ch0data_max_final;
reg [15:0]  ch0data_min_final;
reg [15:0]  ch0data_delta_final;

wire [15:0]   ch0data;
wire [15:0]   ch1data;
wire [15:0]   ch2data;
wire [15:0]   ch0data_temp;



assign spi2imeas.ch0data_max_final = ch0data_max_final;
assign spi2imeas.ch0data_min_final = ch0data_min_final;
assign spi2imeas.ch0data_delta_final = ch0data_delta_final;
assign spi2imeas.i_imeas_ch0data = ch0data_temp;               
assign spi2imeas.i_imeas_ch1data = ch1data;
assign spi2imeas.i_imeas_ch2data = ch2data;
assign spi2imeas.i_imeas_int_sts = imeas_int_sts;
assign spi2imeas.i_imeas_int_sts0 = imeas_int_sts0;
assign spi2imeas.i_imeas_int_sts1 = imeas_int_sts1;
assign spi2imeas.i_imeas_bio_int_sts = imeas_bio_int_sts;
assign spi2imeas.int_sts_switch_loff_statn = int_sts_switch_loff_statn;
assign spi2imeas.int_sts_duration_loff_statn = int_sts_duration_loff_statn;
assign spi2imeas.int_sts_switch_loff_statp = int_sts_switch_loff_statp;
assign spi2imeas.int_sts_duration_loff_statp = int_sts_duration_loff_statp;
assign spi2imeas.int_sts_switch_acloff_statn = int_sts_switch_acloff_statn;
assign spi2imeas.int_sts_duration_acloff_statn = int_sts_duration_acloff_statn;
assign spi2imeas.int_sts_switch_acloff_statp = int_sts_switch_acloff_statp;
assign spi2imeas.int_sts_duration_acloff_statp = int_sts_duration_acloff_statp;
assign spi2imeas.i_imeas_int_alarm_sts = imeas_int_alarm_sts;

//xin add notch filter
wire      chdata_en_n_tmp;
wire   [17:0]   chdata_tmp;
wire   [17:0]   chdata_tmp_notch_in;
wire   [15:0]   chdata_filter;

wire filter_data_en;
assign filter_data_en = ~chdata_en_n_tmp;
wire filter_resetn;
assign filter_resetn = presetn;


//NF logic
//reg        notch_filter_enable;
wire [4:0] notch_filter_enable_cnt;
wire       nf_data_valid;

always @ (posedge pclk or negedge filter_resetn)begin
    if (!filter_resetn) begin
        notch_filter_enable <= 1'b0;
    end
    else if (filter_data_en == 1'b1) begin        
        notch_filter_enable <= 1'b1;   
    end
    else if (notch_filter_enable) begin 
	    if (notch_filter_enable_cnt == 5'd23) begin 
              notch_filter_enable <= 1'b0;   
            end
            else begin
              notch_filter_enable <= 1'b1;   
	    end	    
    end   
    else begin
        notch_filter_enable <= 1'b0;
    end 
end

reg [15:0] nf_unstale_timeout_cnt;
wire       unstable_timeout;

assign    unstable_timeout = nf_unstale_timeout_cnt == nf_unstale_tar;

always @ (posedge pclk or negedge filter_resetn)begin
    if (!filter_resetn) begin
      nf_unstale_timeout_cnt <= 16'h0000;
    end
    else if(notch_filter_en) begin
           if((nf_unstale_timeout_cnt != nf_unstale_tar) & filter_data_en)begin
            nf_unstale_timeout_cnt <= nf_unstale_timeout_cnt + 1'b1;
           end   
    end
    else begin
      nf_unstale_timeout_cnt <= 16'h0000;
    end
end


filter   u_filter
               (
                .clk(nf_pclk),
                .clk_enable(1'b1),
                .reset(filter_resetn),
                .sign_en(~reg_ch[2]),
                .bypass(~notch_filter_en),

                .scaleconst_flat({flash2imeas.nf_coeff[18],flash2imeas.nf_coeff[12],flash2imeas.nf_coeff[6],flash2imeas.nf_coeff[0] }),
                .coeff_b1_flat  ({flash2imeas.nf_coeff[19],flash2imeas.nf_coeff[13],flash2imeas.nf_coeff[7],flash2imeas.nf_coeff[1] }),
                .coeff_b2_flat  ({flash2imeas.nf_coeff[20],flash2imeas.nf_coeff[14],flash2imeas.nf_coeff[8],flash2imeas.nf_coeff[2] }), 
                .coeff_b3_flat  ({flash2imeas.nf_coeff[21],flash2imeas.nf_coeff[15],flash2imeas.nf_coeff[9],flash2imeas.nf_coeff[3] }),
                .coeff_a2_flat  ({flash2imeas.nf_coeff[22],flash2imeas.nf_coeff[16],flash2imeas.nf_coeff[10],flash2imeas.nf_coeff[4]}),
                .coeff_a3_flat  ({flash2imeas.nf_coeff[23],flash2imeas.nf_coeff[17],flash2imeas.nf_coeff[11],flash2imeas.nf_coeff[5]}),
                
//                .scaleconst1       (flash2imeas.nf_coeff[0]),
//                .coeff_b1_section1 (flash2imeas.nf_coeff[1]),
//                .coeff_b2_section1 (flash2imeas.nf_coeff[2]),
//                .coeff_b3_section1 (flash2imeas.nf_coeff[3]),
//                .coeff_a2_section1 (flash2imeas.nf_coeff[4]),
//                .coeff_a3_section1 (flash2imeas.nf_coeff[5]),
//                .scaleconst2       (flash2imeas.nf_coeff[6]),
//                .coeff_b1_section2 (flash2imeas.nf_coeff[7]),
//                .coeff_b2_section2 (flash2imeas.nf_coeff[8]),
//                .coeff_b3_section2 (flash2imeas.nf_coeff[9]),
//                .coeff_a2_section2 (flash2imeas.nf_coeff[10]),
//                .coeff_a3_section2 (flash2imeas.nf_coeff[11]),
//                .scaleconst3       (flash2imeas.nf_coeff[12]),
//                .coeff_b1_section3 (flash2imeas.nf_coeff[13]),
//                .coeff_b2_section3 (flash2imeas.nf_coeff[14]),
//                .coeff_b3_section3 (flash2imeas.nf_coeff[15]),
//                .coeff_a2_section3 (flash2imeas.nf_coeff[16]),
//                .coeff_a3_section3 (flash2imeas.nf_coeff[17]),
//                .scaleconst4       (flash2imeas.nf_coeff[18]),
//                .coeff_b1_section4 (flash2imeas.nf_coeff[19]),
//                .coeff_b2_section4 (flash2imeas.nf_coeff[20]),
//                .coeff_b3_section4 (flash2imeas.nf_coeff[21]),
//                .coeff_a2_section4 (flash2imeas.nf_coeff[22]),
//                .coeff_a3_section4 (flash2imeas.nf_coeff[23]), 

                .o_cnt(notch_filter_enable_cnt),		
                .nf_data_valid(nf_data_valid),	              
                .filter_in(chdata_tmp_notch_in[15:0]),
                .filter_out(chdata_filter[15:0])

                );


reg[15:0] chdata_filter_reg;
always @ (posedge pclk or negedge presetn) begin
	if (~presetn) 
	  	chdata_filter_reg <= 16'b0;
	else if(nf_data_valid)
	  	chdata_filter_reg <= chdata_filter[15:0];
end


assign chdata_en_n = notch_filter_en ? nf_data_valid & unstable_timeout : chdata_en_n_tmp; 
//assign chdata = notch_filter_en ? {2'b0, chdata_filter[15:0]} : chdata_tmp;
assign chdata = notch_filter_en ? {2'b0, chdata_filter_reg[15:0]} : chdata_tmp;

//xin add led_status co-work logic

wire     ppg_mode;
wire      filter0_en;
wire      filter1_en;
wire      filter0_en_sync_pclk;
wire      filter1_en_sync_pclk;
wire      filter0_en_sync_adcclk;
wire      filter1_en_sync_adcclk;
reg      filter0_en_sync_adcclk_d1;
reg      filter1_en_sync_adcclk_d1;
assign      filter0_en = ppg_mode ? (~D2A_PPG_SH_CK) & (~LED_STATUS) : 1'b1;
assign      filter1_en = ppg_mode ? (~D2A_PPG_SH_CK) & (LED_STATUS) : 1'b1;



wire      ch0data_en_n;
wire      ch1data_en_n;
wire      ch2data_en_n;
wire            int_set;
wire            int_set0;
wire            int_set1;
wire            int_alarm_set;
wire   [1:0]    chmod;
wire grp_mod = (chmod == 2'b10);
//assign chdata_en_n = ch0data_en_n & ch1data_en_n & ch2data_en_n;
assign chdata_en_n_tmp = ch0data_en_n & ch1data_en_n & ch2data_en_n;

//assign chdata = ppg_mode ? ((ch0data_en_n == 1'b0) ? {2'b00,ch0data} :
assign chdata_tmp = ppg_mode ? ((ch0data_en_n == 1'b0) ? {2'b00,ch0data} :
                    	    (ch1data_en_n == 1'b0) ? {2'b01,ch1data} : 
						     {2'b00,ch0data}
			   ) :
		((~grp_mod) ? {2'b11,ch0data} : 
		 (ch0data_en_n == 1'b0) ? {2'b00,ch0data} :
		 (ch1data_en_n == 1'b0) ? {2'b01,ch1data} :
		 (ch2data_en_n == 1'b0) ? {2'b10,ch2data} :
				          {2'b11,ch0data} );
assign   chdata_tmp_notch_in = notch_filter_en ? chdata_tmp : 18'b0;


wire imeas_int_pre;
assign imeas_int_pre = imeas_int_temp;

wire imeas_int_sts_temp;
common_pulse_rising u_imeas_int_r(
.d_in(imeas_int_pre),
.clk(pclk),
.rst_(presetn),
.d_out(imeas_int_sts_temp)

);

assign imeas_int = (imeas_int_pre & !int_length_slct) | (imeas_int_sts_temp & int_length_slct);



wire imeas_int_alarm_temp;

wire imeas_int_alarm_sts_temp;
common_pulse_rising u_imeas_alarm_int_r(
.d_in(imeas_int_alarm_temp),
.clk(pclk),
.rst_(presetn),
.d_out(imeas_int_alarm_sts_temp)

);

assign imeas_int_alarm = (imeas_int_alarm_temp & !int_length_slct) | (imeas_int_alarm_sts_temp & int_length_slct);





assign ch0data_temp = notch_filter_en? ppg_mode? ch0data : (~grp_mod)? chdata_filter_reg: ch0data : ch0data; 

//bioelectrical test
reg 	  check_pulse_pclk_d1;
reg[15:0] ch0data_max;
reg[15:0] ch0data_min;
wire            format_sel;
always @ (posedge pclk or negedge presetn) begin
	if (~presetn) 
	  	check_pulse_pclk_d1 <= 1'b0;
	else 
	  	check_pulse_pclk_d1 <= check_pulse_pclk;
end
always @ (posedge pclk or negedge presetn) begin
	if (~presetn) 
		ch0data_max <= 16'b0;
	else if(check_pulse_pclk_d1)
		ch0data_max <= 16'b0;
	else if((ch0data_en_n == 1'b0) & (format_sel? ch0data>= ch0data_max : $signed(ch0data) >= $signed(ch0data_max)))
		ch0data_max <= ch0data;
	else 
		ch0data_max <= ch0data_max;
end
always @ (posedge pclk or negedge presetn) begin
	if (~presetn) 
		ch0data_max_final <= 16'b0;
	else if(check_pulse_pclk)
		ch0data_max_final <= ch0data_max;
	else
		ch0data_max_final <= ch0data_max_final;
end

always @ (posedge pclk or negedge presetn) begin
	if (~presetn) 
		ch0data_min <= 16'hffff;
	else if(check_pulse_pclk_d1)
		ch0data_min <= 16'hffff;
	else if((ch0data_en_n == 1'b0) & (format_sel? ch0data<= ch0data_min  : $signed(ch0data) <= $signed(ch0data_min)))
		ch0data_min <= ch0data;
	else 
		ch0data_min <= ch0data_min;
end

always @ (posedge pclk or negedge presetn) begin
	if (~presetn) 
		ch0data_min_final <= 16'b0;
	else if(check_pulse_pclk)
		ch0data_min_final <= ch0data_min;
	else
		ch0data_min_final <= ch0data_min_final;
end

wire 	  wrong_data;
//assign wrong_data = check_pulse_pclk & (ch0data_min >= ch0data_max);;
assign wrong_data = check_pulse_pclk & (ch0data_min > ch0data_max);;
always @ (posedge pclk or negedge presetn) begin
	if (~presetn) 
		ch0data_delta_final <= 16'b0;
	else if(check_pulse_pclk) begin
		if(ch0data_min >= ch0data_max)
			ch0data_delta_final <= 16'b0;
		else    
			ch0data_delta_final <= ch0data_max - ch0data_min;
	end else
		ch0data_delta_final <= ch0data_delta_final;
end
//lead off
wire leadoff_det_en_sync;
assign leadoff_det_en_sync = leadoff_det_en;


wire A2D_LOFF_STATN_final;
wire A2D_LOFF_STATP_final;
wire A2D_ACLOFF_STATN_final;
wire A2D_ACLOFF_STATP_final;
/*
assign A2D_LOFF_STATN_final = (D2A_DCLEADOFF_EN & D2A_ACLEADOFF_EN) ? (A2D_LOFF_STATN | A2D_ACLEADOFF_STATN) :  
			       D2A_DCLEADOFF_EN ? A2D_LOFF_STATN :
			       D2A_ACLEADOFF_EN ? A2D_ACLEADOFF_STATN : 1'b0;
assign A2D_LOFF_STATP_final = (D2A_DCLEADOFF_EN & D2A_ACLEADOFF_EN) ? (A2D_LOFF_STATP | A2D_ACLEADOFF_STATP) : 
				D2A_DCLEADOFF_EN ? A2D_LOFF_STATP :
                                D2A_ACLEADOFF_EN ? A2D_ACLEADOFF_STATP : 1'b0;
*/
assign A2D_LOFF_STATN_final =   
			       D2A_DCLEADOFF_EN ? (leadoff_active ? ~A2D_LOFF_STATN : A2D_LOFF_STATN) : 1'b0;
assign A2D_LOFF_STATP_final =  
			       D2A_DCLEADOFF_EN ? (leadoff_active ? ~A2D_LOFF_STATP : A2D_LOFF_STATP) : 1'b0;

assign A2D_ACLOFF_STATN_final =   
			       D2A_ACLEADOFF_EN ? (leadoff_active ? ~A2D_ACLEADOFF_STATN : A2D_ACLEADOFF_STATN) : 1'b0;
assign A2D_ACLOFF_STATP_final =  
                               D2A_ACLEADOFF_EN ? (leadoff_active ? ~A2D_ACLEADOFF_STATP : A2D_ACLEADOFF_STATP) : 1'b0;


wire    	    A2D_LOFF_STATN_sync;
wire    	    A2D_LOFF_STATP_sync;
wire    	    A2D_ACLOFF_STATN_sync;
wire    	    A2D_ACLOFF_STATP_sync;
reg    	    A2D_LOFF_STATN_sync_d1;
reg    	    A2D_LOFF_STATP_sync_d1;
reg    	    A2D_ACLOFF_STATN_sync_d1;
reg    	    A2D_ACLOFF_STATP_sync_d1;

common_sync_bit u_STATN_sync_pclk(
.async_in(A2D_LOFF_STATN_final),
.clk(pclk),
.rst_(presetn),
.sync_out(A2D_LOFF_STATN_sync)
);
common_sync_bit u_STATP_sync_pclk(
.async_in(A2D_LOFF_STATP_final),
.clk(pclk),
.rst_(presetn),
.sync_out(A2D_LOFF_STATP_sync)
);
common_sync_bit u_acSTATN_sync_pclk(
.async_in(A2D_ACLOFF_STATN_final),
.clk(pclk),
.rst_(presetn),
.sync_out(A2D_ACLOFF_STATN_sync)
);
common_sync_bit u_acSTATP_sync_pclk(
.async_in(A2D_ACLOFF_STATP_final),
.clk(pclk),
.rst_(presetn),
.sync_out(A2D_ACLOFF_STATP_sync)
);

always @ (posedge pclk or negedge presetn) begin
	if (~presetn) begin 
		A2D_LOFF_STATN_sync_d1 <= 1'b0;
		A2D_LOFF_STATP_sync_d1 <= 1'b0;
		A2D_ACLOFF_STATN_sync_d1 <= 1'b0;
		A2D_ACLOFF_STATP_sync_d1 <= 1'b0;
	end else begin
		A2D_LOFF_STATN_sync_d1 <= A2D_LOFF_STATN_sync;
		A2D_LOFF_STATP_sync_d1 <= A2D_LOFF_STATP_sync;
		A2D_ACLOFF_STATN_sync_d1 <= A2D_ACLOFF_STATN_sync;
		A2D_ACLOFF_STATP_sync_d1 <= A2D_ACLOFF_STATP_sync;
	end
end
wire    	    A2D_LOFF_STATN_sync_pos;
wire    	    A2D_LOFF_STATP_sync_pos;
wire    	    A2D_ACLOFF_STATN_sync_pos;
wire    	    A2D_ACLOFF_STATP_sync_pos;
assign    	    A2D_LOFF_STATN_sync_pos = A2D_LOFF_STATN_sync & (~A2D_LOFF_STATN_sync_d1);
assign    	    A2D_LOFF_STATP_sync_pos = A2D_LOFF_STATP_sync & (~A2D_LOFF_STATP_sync_d1);
assign    	    A2D_ACLOFF_STATN_sync_pos = A2D_ACLOFF_STATN_sync & (~A2D_ACLOFF_STATN_sync_d1);
assign    	    A2D_ACLOFF_STATP_sync_pos = A2D_ACLOFF_STATP_sync & (~A2D_ACLOFF_STATP_sync_d1);
/*
wire which_switch;
assign which_switch = (leadoff_type_sel_reg==2'b00) ? (A2D_LOFF_STATN_sync_pos | A2D_LOFF_STATP_sync_pos) :
		      (leadoff_type_sel_reg==2'b01) ? A2D_LOFF_STATN_sync_pos : 
		      (leadoff_type_sel_reg==2'b10) ? A2D_LOFF_STATP_sync_pos :
						      (A2D_LOFF_STATN_sync_pos | A2D_LOFF_STATP_sync_pos);
wire which_duration;
assign which_duration = (leadoff_type_sel_reg==2'b00) ? (A2D_LOFF_STATN_sync | A2D_LOFF_STATP_sync) :
		        (leadoff_type_sel_reg==2'b01) ? A2D_LOFF_STATN_sync : 
		        (leadoff_type_sel_reg==2'b10) ? A2D_LOFF_STATP_sync :
						      (A2D_LOFF_STATN_sync | A2D_LOFF_STATP_sync);
*/

wire which_switch_loff_statn;
assign which_switch_loff_statn = 
		       		((leadoff_type_sel_reg==2'b00) | (leadoff_type_sel_reg==2'b01) | (leadoff_type_sel_reg==2'b11)) ? A2D_LOFF_STATN_sync_pos : 1'b0; 
wire which_duration_loff_statn;
assign which_duration_loff_statn = 
		         	((leadoff_type_sel_reg==2'b00) | (leadoff_type_sel_reg==2'b01) | (leadoff_type_sel_reg==2'b11)) ? A2D_LOFF_STATN_sync : 1'b0; 

wire which_switch_loff_statp;
assign which_switch_loff_statp = 
		      		((leadoff_type_sel_reg==2'b00) | (leadoff_type_sel_reg==2'b10) | (leadoff_type_sel_reg==2'b11)) ? A2D_LOFF_STATP_sync_pos : 1'b0;
wire which_duration_loff_statp;
assign which_duration_loff_statp = 
		                ((leadoff_type_sel_reg==2'b00) | (leadoff_type_sel_reg==2'b10) | (leadoff_type_sel_reg==2'b11)) ? A2D_LOFF_STATP_sync : 1'b0;


wire which_switch_acloff_statn;
assign which_switch_acloff_statn = 
		       		((leadoff_type_sel_reg==2'b00) | (leadoff_type_sel_reg==2'b01) | (leadoff_type_sel_reg==2'b11)) ? A2D_ACLOFF_STATN_sync_pos : 1'b0 ; 
wire which_duration_acloff_statn;
assign which_duration_acloff_statn = 
		         	((leadoff_type_sel_reg==2'b00) | (leadoff_type_sel_reg==2'b01) | (leadoff_type_sel_reg==2'b11)) ? A2D_ACLOFF_STATN_sync : 1'b0; 

wire which_switch_acloff_statp;
assign which_switch_acloff_statp = 
		      		((leadoff_type_sel_reg==2'b00) | (leadoff_type_sel_reg==2'b10) | (leadoff_type_sel_reg==2'b11)) ? A2D_ACLOFF_STATP_sync_pos : 1'b0 ;
wire which_duration_acloff_statp;
assign which_duration_acloff_statp = 
		                ((leadoff_type_sel_reg==2'b00) | (leadoff_type_sel_reg==2'b10) | (leadoff_type_sel_reg==2'b11)) ? A2D_LOFF_STATP_sync  : 1'b0;

wire [15:0] leadoff_duration_tgt;
assign leadoff_duration_tgt = {leadoff_tgt_1,leadoff_tgt_0};

//wire which_switch_loff_statn;
//wire which_duration_loff_statn;
wire hit_tgt_switch_loff_statn;
wire hit_tgt_duration_loff_statn;
//wire which_switch_acloff_statn;
//wire which_duration_acloff_statn;
wire hit_tgt_switch_acloff_statn;
wire hit_tgt_duration_acloff_statn;


leadoff_chk u_leadoff_chk_loff_statn(
.m1k_reg_atpg(m1k_reg_atpg),
.presetn(presetn),
.pclk(pclk),
.atpg_en(atpg_en),
.leadoff_det_en_sync(leadoff_det_en_sync),
.switch_duration_sel(switch_duration_sel),
.which_switch(which_switch_loff_statn),
.which_duration(which_duration_loff_statn),
.leadoff_duration_tgt(leadoff_duration_tgt),
.leadoff_switch_tgt(leadoff_switch_tgt),
.hit_tgt_switch(hit_tgt_switch_loff_statn),
.hit_tgt_duration(hit_tgt_duration_loff_statn)
);
wire hit_tgt_switch_loff_statp,hit_tgt_duration_loff_statp;
leadoff_chk u_leadoff_chk_loff_statp(
.m1k_reg_atpg(m1k_reg_atpg),
.presetn(presetn),
.pclk(pclk),
.atpg_en(atpg_en),
.leadoff_det_en_sync(leadoff_det_en_sync),
.switch_duration_sel(switch_duration_sel),
.which_switch(which_switch_loff_statp),
.which_duration(which_duration_loff_statp),
.leadoff_duration_tgt(leadoff_duration_tgt),
.leadoff_switch_tgt(leadoff_switch_tgt),
.hit_tgt_switch(hit_tgt_switch_loff_statp),
.hit_tgt_duration(hit_tgt_duration_loff_statp)
);


leadoff_chk u_leadoff_chk_acloff_statn(
.m1k_reg_atpg(m1k_reg_atpg),
.presetn(presetn),
.pclk(pclk),
.atpg_en(atpg_en),
.leadoff_det_en_sync(leadoff_det_en_sync),
.switch_duration_sel(switch_duration_sel),
.which_switch(which_switch_acloff_statn),
.which_duration(which_duration_acloff_statn),
.leadoff_duration_tgt(leadoff_duration_tgt),
.leadoff_switch_tgt(leadoff_switch_tgt),
.hit_tgt_switch(hit_tgt_switch_acloff_statn),
.hit_tgt_duration(hit_tgt_duration_acloff_statn)
);
wire hit_tgt_switch_acloff_statp,hit_tgt_duration_acloff_statp;
leadoff_chk u_leadoff_chk_acloff_statp(
.m1k_reg_atpg(m1k_reg_atpg),
.presetn(presetn),
.pclk(pclk),
.atpg_en(atpg_en),
.leadoff_det_en_sync(leadoff_det_en_sync),
.switch_duration_sel(switch_duration_sel),
.which_switch(which_switch_acloff_statp),
.which_duration(which_duration_acloff_statp),
.leadoff_duration_tgt(leadoff_duration_tgt),
.leadoff_switch_tgt(leadoff_switch_tgt),
.hit_tgt_switch(hit_tgt_switch_acloff_statp),
.hit_tgt_duration(hit_tgt_duration_acloff_statp)
);


 //wire 	   old_group_mode_in = imeas_grp_ctl[0];  //default is new
 wire 	   old_group_mode_in = imeas_grp_ctl;  //default is new
 //wire 	   old_group_mode_in = 1;  //default is new
//internal wire
//wire   [2:0]    cic_rate;
wire            chrsv;
wire            sd16rst;
wire   [3:0]    chnum;
wire   [7:0]    rst_val;
wire            cic_rst;
wire            sd16eoc_sync;
wire            cic_rst_n;
wire   [15:0]   sd16cic_data;
wire            sd16eoc;
wire   [15:0]   sd16cic_data_0;
wire            sd16eoc_0;
wire   [15:0]   sd16cic_data_1;
wire            sd16eoc_1;
wire   [15:0]   sd16cic_data_2;
wire            sd16eoc_2;

wire   [2:0]    ch_cnt_reg;

wire   [3:0]    chnum_out;
/*
wire            gubias_en;
wire   [1:0]    rebias_dac;
wire   [5:0]    webias_dac;
wire            cal_en;
wire   [1:0]    pga_gain;
wire            sd16off;
wire            sd16slp;
*/

// disable interface with analog when atpg enable
//removed as the new pin list
//xin 2/oct/2022
/*
assign imeas_gubias_en  = atpg_en ? 1'b0 : gubias_en;
assign imeas_rebias_dac = atpg_en ? 2'b0 : rebias_dac;
assign imeas_webias_dac = atpg_en ? 6'b0 : webias_dac;
assign imeas_cal_en     = atpg_en ? 1'b0 : cal_en;
assign imeas_pga_gain   = atpg_en ? 2'b0 : pga_gain;
*/
assign imeas_chnum      = atpg_en ? 4'b0 : chnum_out;
//assign imeas_sd16off    = atpg_en ? 1'b1 : sd16off;
//assign imeas_sd16slp    = atpg_en ? 1'b1 : sd16slp;
wire restart;
imeas_reg u_imeas_reg(
.pclk(pclk),
.atpg_en(atpg_en),

.restart(restart),
.ppg_mode(ppg_mode),
.reg_ctrl(reg_ctrl),
.reg_ch(reg_ch),
.reg_seq(reg_seq),
.reg_rstval(reg_rstval),
.int_clr(int_clr),
.preset_n(presetn),

.wrong_data(wrong_data),
.check_pulse_pclk(check_pulse_pclk),
.int_alarm_en(int_alarm_en),

.int_sts(imeas_int_sts),
.int_sts0(imeas_int_sts0),
.int_sts1(imeas_int_sts1),
.bio_int_sts(imeas_bio_int_sts),
.imeas_int(imeas_int_temp),
.int_set(int_set),
.int_set0(int_set0),
.int_set1(int_set1),
.leadoff_int_en(leadoff_int_en),
.hit_tgt_switch_loff_statn(hit_tgt_switch_loff_statn),
.hit_tgt_duration_loff_statn(hit_tgt_duration_loff_statn),
.int_sts_switch_loff_statn(int_sts_switch_loff_statn),
.int_sts_duration_loff_statn(int_sts_duration_loff_statn),
.hit_tgt_switch_loff_statp(hit_tgt_switch_loff_statp),
.hit_tgt_duration_loff_statp(hit_tgt_duration_loff_statp),
.int_sts_switch_loff_statp(int_sts_switch_loff_statp),
.int_sts_duration_loff_statp(int_sts_duration_loff_statp),

.hit_tgt_switch_acloff_statn(hit_tgt_switch_acloff_statn),
.hit_tgt_duration_acloff_statn(hit_tgt_duration_acloff_statn),
.int_sts_switch_acloff_statn(int_sts_switch_acloff_statn),
.int_sts_duration_acloff_statn(int_sts_duration_acloff_statn),
.hit_tgt_switch_acloff_statp(hit_tgt_switch_acloff_statp),
.hit_tgt_duration_acloff_statp(hit_tgt_duration_acloff_statp),
.int_sts_switch_acloff_statp(int_sts_switch_acloff_statp),
.int_sts_duration_acloff_statp(int_sts_duration_acloff_statp),

.int_alarm_clr(int_alarm_clr),
.int_alarm_sts(imeas_int_alarm_sts),
.imeas_int_alarm(imeas_int_alarm_temp),
.int_alarm_set(int_alarm_set),

//removed as the new pin list
/*
.webias_dac(webias_dac),
.rebias_dac(rebias_dac),
.gubias_en(gubias_en),
.cal_en(cal_en),
.pga_gain(pga_gain),
*/
.cic_rate(cic_rate),
.chmod(chmod),
.chrsv(chrsv),
.format_sel(format_sel),
.chnum(chnum),
//.sd16off(sd16off),
//.sd16slp(sd16slp),
.sd16rst(sd16rst),
.rst_val(rst_val)
);

always @ (posedge adc_clk or negedge cic_rst_n) begin
	if (~cic_rst_n) begin
		filter0_en_sync_adcclk_d1 <= 1'b0;
		filter1_en_sync_adcclk_d1 <= 1'b0;
	end else begin 
		filter0_en_sync_adcclk_d1 <= filter0_en_sync_adcclk;		
		filter1_en_sync_adcclk_d1 <= filter1_en_sync_adcclk;		
	end
end


//assign sd16eoc =  ppg_mode ? ( filter0_en ? sd16eoc_0 :
//			       filter1_en ? sd16eoc_1 : sd16eoc_0) : 
assign sd16eoc =  ppg_mode ? ( filter0_en_sync_adcclk_d1 ? sd16eoc_0 :
			       filter1_en_sync_adcclk_d1 ? sd16eoc_1 : 1'b0) : 
		  ((ch_cnt_reg == 3'h0) ? sd16eoc_0 :
		  (ch_cnt_reg == 3'h1) ? sd16eoc_1 : sd16eoc_2); 
//assign sd16cic_data = ppg_mode ? (filter0_en ? sd16cic_data_0 :
//				  filter1_en ? sd16cic_data_1 : sd16cic_data_0) : 
assign sd16cic_data = ppg_mode ? (filter0_en_sync_adcclk_d1 ? sd16cic_data_0 :
				  filter1_en_sync_adcclk_d1 ? sd16cic_data_1 : 16'b0) : 
			((ch_cnt_reg == 3'h0) ? sd16cic_data_0 :
                         (ch_cnt_reg == 3'h1) ? sd16cic_data_1 : sd16cic_data_2);

/*
assign sd16eoc = (ch_cnt_reg == 3'h0) ? sd16eoc_0 :
		 (ch_cnt_reg == 3'h1) ? sd16eoc_1 : sd16eoc_2; 
assign sd16cic_data = (ch_cnt_reg == 3'h0) ? sd16cic_data_0 :
                      (ch_cnt_reg == 3'h1) ? sd16cic_data_1 : sd16cic_data_2;
*/
imeas_cdc u_imeas_cdc(
.pclk(pclk),
.adc_clk(adc_clk),
.preset_n(presetn),
.atpg_en(atpg_en),
//.filter0_en(filter0_en),
//.filter1_en(filter1_en),

.D2A_PPG_SH_CK(D2A_PPG_SH_CK),
.ppg_mode(ppg_mode),
.restart(restart),

.filter0_en(filter0_en_sync_adcclk),
.filter1_en(filter1_en_sync_adcclk),
.filter0_en_sync_pclk(filter0_en_sync_pclk),
.filter1_en_sync_pclk(filter1_en_sync_pclk),
.sd16eoc(sd16eoc),
.cic_rst(cic_rst),
.sd16eoc_sync(sd16eoc_sync),
.cic_rst_n(cic_rst_n)
);

imeas_ctrl u_imeas_ctrl(
.ppg_mode(ppg_mode),
.filter0_en(filter0_en_sync_pclk),
.filter1_en(filter1_en_sync_pclk),

.old_group_mode_in(old_group_mode_in),
//.old_group_mode(old_group_mode),
.active_channel_num(active_channel_num),
.adc_clk(adc_clk),
.cic_rst_n(cic_rst_n),
.pclk(pclk),
.preset_n(presetn),
.sd16eoc_sync(sd16eoc_sync),
.sd16cic_data(sd16cic_data),
.sd16rst(sd16rst),
.chmod(chmod),
.chnum(chnum),
.rst_val(rst_val),
.ch0data(ch0data),
.ch1data(ch1data),
.ch2data(ch2data),
.ch0data_en_n(ch0data_en_n),
.ch1data_en_n(ch1data_en_n),
.ch2data_en_n(ch2data_en_n),
.chnum_out(chnum_out),
.ch_cnt_reg(ch_cnt_reg),
.cic_rst(cic_rst),
.format_sel(format_sel),
.threshold_hi(threshold_hi),
.threshold_lo(threshold_lo),
.nf_int(nf_data_valid & unstable_timeout),
.nf_en(notch_filter_en),
.int_set(int_set),
.int_set0(int_set0),
.int_set1(int_set1),
.int_alarm_set(int_alarm_set)
);

//wire      filter0_en;
//wire      filter1_en;
common_sync_bit u_filter0_sync_adcclk(
.async_in(filter0_en),
.clk(adc_clk),
.rst_(cic_rst_n),
.sync_out(filter0_en_sync_adcclk)
);
common_sync_bit u_filter1_sync_adcclk(
.async_in(filter1_en),
.clk(adc_clk),
.rst_(cic_rst_n),
.sync_out(filter1_en_sync_adcclk)
);


wire adc_clk_0;
wire adc_clk_1;
wire adc_clk_2;
/*
wire adc_clk_0_en = (ch_cnt_reg == 3'h0); 
wire adc_clk_1_en = (ch_cnt_reg == 3'h1); 
wire adc_clk_2_en = (ch_cnt_reg == 3'h2); 
*/
wire adc_clk_0_en = ppg_mode ? filter0_en_sync_adcclk : (ch_cnt_reg == 3'h0); 
wire adc_clk_1_en = ppg_mode ? filter1_en_sync_adcclk : (ch_cnt_reg == 3'h1); 
wire adc_clk_2_en = (ch_cnt_reg == 3'h2); 

common_clock_gate 
u_imeas_adc_clk_0 (
.clk        (adc_clk),
.enable     (adc_clk_0_en),
.bypass     (scan_en),   //Tri change
.gated_clk  (adc_clk_0));

common_clock_gate
u_imeas_adc_clk_1 (
.clk        (adc_clk),
.enable     (adc_clk_1_en),
.bypass     (scan_en),  //Tri change
.gated_clk  (adc_clk_1));

common_clock_gate
u_imeas_adc_clk_2 (
.clk        (adc_clk),
.enable     (adc_clk_2_en),
.bypass     (scan_en),  //Tri change
.gated_clk  (adc_clk_2));


imeas_cic u_imeas_cic_0(
.clk(adc_clk_0),
.resetn(cic_rst_n),
.imeas_input_format(imeas_input_format),
.cic_rate(cic_rate),
.format_sel(format_sel),
.filter_in(imeas_adc_din),
.filter_out(sd16cic_data_0),
.eoc_out(sd16eoc_0)
);

imeas_cic u_imeas_cic_1(
.clk(adc_clk_1),
.resetn(cic_rst_n),
.imeas_input_format(imeas_input_format),
.cic_rate(cic_rate),
.format_sel(format_sel),
.filter_in(imeas_adc_din),
.filter_out(sd16cic_data_1),
.eoc_out(sd16eoc_1)
);

imeas_cic u_imeas_cic_2(
.clk(adc_clk_2),
.resetn(cic_rst_n),
.imeas_input_format(imeas_input_format),
.cic_rate(cic_rate),
.format_sel(format_sel),
.filter_in(imeas_adc_din),
.filter_out(sd16cic_data_2),
.eoc_out(sd16eoc_2)
);



endmodule

module   leadoff_chk (
input  wire m1k_reg_atpg,
input  wire presetn,
input  wire pclk,
input  wire atpg_en,
input  wire leadoff_det_en_sync,
input  wire which_switch,
input  wire which_duration,
input  wire[1:0]  switch_duration_sel,  //00 is s&D, 01 is s, 10 is d, 11 is s&d
input  wire [15:0] leadoff_duration_tgt,
input  wire [7:0]   leadoff_switch_tgt,
output wire hit_tgt_switch,
output wire hit_tgt_duration
);

reg [7:0]   leadoff_switch_tgt_cnt;
reg [15:0]   leadoff_duration_tgt_cnt;

reg switch_rstn_bak;
wire switch_rstn_bak_sync;

always @ (posedge m1k_reg_atpg or negedge presetn) begin
	if (~presetn) begin
         switch_rstn_bak <= 1'b0;
        end
        else if(leadoff_duration_tgt_cnt == leadoff_duration_tgt) begin
         switch_rstn_bak <= 1'b0;
        end
        else begin
         switch_rstn_bak <= 1'b1;
        end
end

//assign switch_rstn_bak = (presetn & (~(leadoff_duration_tgt_cnt == leadoff_duration_tgt)));

wire switch_rstn_bak_atpg = atpg_en ? presetn : switch_rstn_bak; 
common_rst_sync u_switch_rstn_sync(
.RSTINn    (switch_rstn_bak_atpg),
.RSTREQ    (1'b0),
.CLK       (pclk),
.SE        (atpg_en),
.RSTBYPASS (atpg_en),
.RSTOUTn   (switch_rstn_bak_sync)
);

wire switch_rstn;
//assign switch_rstn = atpg_en ? presetn : (presetn & (~(leadoff_duration_tgt_cnt == leadoff_duration_tgt)));
assign switch_rstn = atpg_en ? presetn : switch_rstn_bak_sync;
reg which_switch_d1;
always @ (posedge pclk or negedge switch_rstn) begin
	if (~switch_rstn) 
		which_switch_d1 <= 1'b0;
	else
		which_switch_d1 <= which_switch;
end
wire which_switch_neg;
assign which_switch_neg = which_switch_d1 & (~which_switch);


wire sel_switch;
wire sel_duration;
assign sel_switch = (switch_duration_sel == 2'b00) | (switch_duration_sel == 2'b01) | (switch_duration_sel == 2'b11);
assign sel_duration = (switch_duration_sel == 2'b00) | (switch_duration_sel == 2'b10) | (switch_duration_sel == 2'b11);
//always @ (posedge pclk or negedge presetn) begin
//	if (~presetn) 
always @ (posedge pclk or negedge switch_rstn) begin
	if (~switch_rstn) 
		leadoff_switch_tgt_cnt <= 8'b0;
	else if((~leadoff_det_en_sync) | (~sel_switch))
		leadoff_switch_tgt_cnt <= 8'b0;
	else if(leadoff_switch_tgt_cnt == leadoff_switch_tgt)
		leadoff_switch_tgt_cnt <= 8'b0;
	else if(which_switch)
		leadoff_switch_tgt_cnt <= leadoff_switch_tgt_cnt + 8'b1;
end

reg duration_rstn_bak;

always @ (posedge pclk or negedge presetn) begin
	if (~presetn) begin
          duration_rstn_bak <= 1'b0;
        end
        else if((which_switch_neg) | ((leadoff_switch_tgt_cnt == leadoff_switch_tgt))) begin
          duration_rstn_bak <= 1'b0;
        end
        else begin
          duration_rstn_bak <= 1'b1;     
        end
end


//assign duration_rstn_bak = (presetn & (~which_switch_neg) & (~(leadoff_switch_tgt_cnt == leadoff_switch_tgt)));





wire duration_rstn_bak_sync;
wire duration_rstn_bak_atpg;
assign duration_rstn_bak_atpg = atpg_en ? presetn : duration_rstn_bak;
common_rst_sync u_duration_rstn_sync(
.RSTINn    (duration_rstn_bak_atpg),
.RSTREQ    (1'b0),
.CLK       (m1k_reg_atpg),
.SE        (atpg_en),
.RSTBYPASS (atpg_en),
.RSTOUTn   (duration_rstn_bak_sync)
);

wire duration_rstn;
//assign duration_rstn = atpg_en ? presetn : (presetn & (~which_switch_neg) & (~(leadoff_switch_tgt_cnt == leadoff_switch_tgt)));
assign duration_rstn = atpg_en ? presetn : duration_rstn_bak_sync;
//always @ (posedge m1k_reg_atpg or negedge presetn) begin
//	if (~presetn) 
always @ (posedge m1k_reg_atpg or negedge duration_rstn) begin
	if (~duration_rstn) 
		leadoff_duration_tgt_cnt <= 16'b0;
	else if((~leadoff_det_en_sync) | (~sel_duration))
		leadoff_duration_tgt_cnt <= 16'b0;
	//else if(which_switch_neg)
	//	leadoff_duration_tgt_cnt <= 16'b0;
	else if(leadoff_duration_tgt_cnt == leadoff_duration_tgt) 
		leadoff_duration_tgt_cnt <= 16'b0;
	else if(which_duration)
		leadoff_duration_tgt_cnt <= leadoff_duration_tgt_cnt + 16'b1;
end

wire hit_tgt_duration_bak;
assign hit_tgt_switch = sel_switch ? (leadoff_switch_tgt_cnt == leadoff_switch_tgt) : 1'b0;
assign hit_tgt_duration_bak = sel_duration ? (leadoff_duration_tgt_cnt == leadoff_duration_tgt) : 1'b0;
wire hit_tgt_duration_bak_sync;
reg hit_tgt_duration_bak_sync_d1;
common_sync_bit u_dur_sync_pclk(
.async_in(hit_tgt_duration_bak),
.clk(pclk),
.rst_(presetn),
.sync_out(hit_tgt_duration_bak_sync)
);
always @ (posedge pclk or negedge presetn) begin
	if (~presetn) 
		hit_tgt_duration_bak_sync_d1 <= 1'b0;
	else 
		hit_tgt_duration_bak_sync_d1 <= hit_tgt_duration_bak_sync;
end
assign hit_tgt_duration = sel_duration ? (hit_tgt_duration_bak_sync & (~hit_tgt_duration_bak_sync_d1)) : 1'b0;

endmodule
