



module spi_reg_imeas#(
	parameter ADDR_WIDTH =8,
	parameter DATA_WIDTH =8
)(
        spi2imeas.master       spi2imeas,

	input                  i_clk,
	input                  i_rst_n,
	input [ADDR_WIDTH-1:0] i_addr,
	input                  i_wr,
	input [DATA_WIDTH-1:0] i_wr_data,
        
	output wire          reg_imeas_int_sts,
	output wire          reg_imeas_int_sts0,
	output wire          reg_imeas_int_sts1,
	output wire          reg_imeas_bio_int_sts,
	output wire          reg_imeas_int_alarm_sts,
	output wire  	     int_sts_switch,
	output wire  	     int_sts_duration,

	output [DATA_WIDTH-1:0] o_rd_data

);


//O
wire         notch_filter_en;
wire [1:0]   gain_mul;
reg  [7:0]   nf_unstable_time_reg0;
reg  [7:0]   nf_unstable_time_reg1;

assign spi2imeas.notch_filter_en      = notch_filter_en;
assign spi2imeas.gain_mul             = gain_mul;
assign spi2imeas.nf_unstable_time     = {nf_unstable_time_reg1,nf_unstable_time_reg0};


wire         leadoff_int_en;
wire         leadoff_det_en;
wire [1:0]   leadoff_type_sel_reg;
wire [1:0]   switch_duration_sel;
wire         leadoff_active;
reg [7:0]    leadoff_tgt_0;
reg [7:0]    leadoff_tgt_1;
reg [7:0]    leadoff_switch_tgt;

assign spi2imeas.leadoff_int_en       = leadoff_int_en;
assign spi2imeas.leadoff_det_en       = leadoff_det_en;
assign spi2imeas.leadoff_type_sel_reg = leadoff_type_sel_reg;
assign spi2imeas.switch_duration_sel  = switch_duration_sel;
assign spi2imeas.leadoff_active       = leadoff_active;
assign spi2imeas.leadoff_tgt_0        = leadoff_tgt_0;
assign spi2imeas.leadoff_tgt_1        = leadoff_tgt_1;
assign spi2imeas.leadoff_switch_tgt   = leadoff_switch_tgt;

reg         o_imeas_int_clr;
reg         o_imeas_int_alarm_clr;

assign spi2imeas.o_imeas_int_clr       = o_imeas_int_clr;
assign spi2imeas.o_imeas_int_alarm_clr = o_imeas_int_alarm_clr;


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


assign spi2imeas.o_threshold_hi          = o_threshold_hi;
assign spi2imeas.o_threshold_lo          = o_threshold_lo;
assign spi2imeas.o_int_alarm_en          = o_int_alarm_en;
assign spi2imeas.o_imeas_reg_ctrl        = o_imeas_reg_ctrl;
assign spi2imeas.o_imeas_reg_ch          = o_imeas_reg_ch;
assign spi2imeas.o_imeas_reg_seq         = o_imeas_reg_seq;
assign spi2imeas.o_imeas_reg_rstval      = o_imeas_reg_rstval;
assign spi2imeas.o_imeas_en              = o_imeas_en;
assign spi2imeas.o_imeas_input_format    = o_imeas_input_format;
assign spi2imeas.o_active_channel_num    = o_active_channel_num;
assign spi2imeas.o_imeas_grp_ctl         = o_imeas_grp_ctl;        


//I
     //i-meas
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

assign ch0data_max_final                  = spi2imeas.ch0data_max_final;
assign ch0data_min_final                  = spi2imeas.ch0data_min_final;
assign ch0data_delta_final                = spi2imeas.ch0data_delta_final;
assign i_imeas_ch0data                    = spi2imeas.i_imeas_ch0data;                
assign i_imeas_ch1data                    = spi2imeas.i_imeas_ch1data;
assign i_imeas_ch2data                    = spi2imeas.i_imeas_ch2data;
assign i_imeas_int_sts                    = spi2imeas.i_imeas_int_sts;
assign i_imeas_int_sts0                   = spi2imeas.i_imeas_int_sts0;
assign i_imeas_int_sts1                   = spi2imeas.i_imeas_int_sts1;
assign i_imeas_bio_int_sts                = spi2imeas.i_imeas_bio_int_sts;
assign int_sts_switch_loff_statn          = spi2imeas.int_sts_switch_loff_statn;
assign int_sts_duration_loff_statn        = spi2imeas.int_sts_duration_loff_statn;
assign int_sts_switch_loff_statp          = spi2imeas.int_sts_switch_loff_statp;
assign int_sts_duration_loff_statp        = spi2imeas.int_sts_duration_loff_statp;
assign int_sts_switch_acloff_statn        = spi2imeas.int_sts_switch_acloff_statn;
assign int_sts_duration_acloff_statn      = spi2imeas.int_sts_duration_acloff_statn;
assign int_sts_switch_acloff_statp        = spi2imeas.int_sts_switch_acloff_statp;
assign int_sts_duration_acloff_statp      = spi2imeas.int_sts_duration_acloff_statp;
assign i_imeas_int_alarm_sts              = spi2imeas.i_imeas_int_alarm_sts;


wire  [15:0]  reg_imeas_ch0data;     // Channel 0 data
wire  [15:0]  reg_imeas_ch1data;     // Channel 1 data
wire  [15:0]  reg_imeas_ch2data;     // Channel 2 data

assign reg_imeas_int_sts = i_imeas_int_sts;

assign reg_imeas_int_sts0 = i_imeas_int_sts0;

assign reg_imeas_int_sts1 = i_imeas_int_sts1;

assign reg_imeas_bio_int_sts = i_imeas_bio_int_sts;

assign reg_imeas_int_alarm_sts = i_imeas_int_alarm_sts;

assign reg_imeas_ch0data = i_imeas_ch0data;

assign reg_imeas_ch1data = i_imeas_ch1data;

assign reg_imeas_ch2data = i_imeas_ch2data;

assign  	   int_sts_switch = int_sts_switch_loff_statn | int_sts_switch_loff_statp |
					   int_sts_switch_acloff_statn | int_sts_switch_acloff_statp;
assign  	   int_sts_duration = int_sts_duration_loff_statn | int_sts_duration_loff_statp |
					  int_sts_duration_acloff_statn | int_sts_duration_acloff_statp;


//imeas
reg   [7:0] threshold_hi_0;
reg   [7:0] threshold_hi_1;
reg   [7:0] threshold_lo_0;
reg   [7:0] threshold_lo_1;

reg	    int_alarm_en;

reg   [7:0] imeas_reg_ctrl_0;
reg   [7:0] imeas_reg_ctrl_1;//this is used in ECG CAL inside zmeas
reg   [7:0] imeas_reg_ch;
reg   [2:0] imeas_reg_seq;
reg         imeas_en;
reg  [7:0]  imeas_reg_rstval;
reg [1:0]   imeas_input_format;
reg         meas_sync_en;
reg         imeas_grp_ctl;
reg [7:0]   active_channel_num_lo;
reg [3:0]   active_channel_num_hi;

reg [2:0]   notch_filter_en_reg;   //1 is enable

reg [6:0]   leadoff_ctrl;
assign      leadoff_active = leadoff_ctrl[6];    
assign      switch_duration_sel = leadoff_ctrl[5:4];    
assign         leadoff_int_en = leadoff_ctrl[3];
assign      leadoff_det_en = leadoff_ctrl[2];
assign      leadoff_type_sel_reg = leadoff_ctrl[1:0];    

assign  notch_filter_en = notch_filter_en_reg[0];    //1 is enable
assign  gain_mul        = notch_filter_en_reg[2:1];

wire imeas_int_clr_reg;
wire imeas_int_alarm_clr_reg;

////////----imeas interrupts------/////

assign   imeas_int_alarm_clr_reg      = (i_addr[ADDR_WIDTH-1:0] == `IMEAS_ALARM_INT) &  i_wr & i_wr_data[0] ;

assign   imeas_int_clr_reg      = (i_addr[ADDR_WIDTH-1:0] == `IMEAS_INT) &  i_wr & i_wr_data[0] ;


//assign o_imeas_int_alarm_clr    = imeas_int_alarm_clr_reg;
always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)
     o_imeas_int_alarm_clr <= 1'b0;
  else
    o_imeas_int_alarm_clr <= imeas_int_alarm_clr_reg;
end


//assign o_imeas_int_clr     = imeas_int_clr_reg;
always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)
     o_imeas_int_clr <= 1'b0;
  else
    o_imeas_int_clr <= imeas_int_clr_reg;
end
  

always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)begin
   //i_meas
      imeas_reg_ctrl_0     <=8'h10;
      imeas_reg_ctrl_1     <=8'h0;//this is used in ECG CAL inside zmeas
      imeas_reg_ch         <=8'b0;
      imeas_reg_seq        <=3'h7; 

     imeas_reg_rstval      <= 8'h50;
     imeas_en              <= 1'b0;          
     imeas_grp_ctl         <= 1'b0;    
     active_channel_num_hi <= 4'h2;
     active_channel_num_lo <= 8'h10;
     imeas_input_format    <= 2'b10;    

    notch_filter_en_reg <= 3'b0;    //1 is enable
    leadoff_ctrl <= 7'h0 ;
    leadoff_tgt_0 <= 8'hff;
    leadoff_tgt_1 <= 8'h0;
    leadoff_switch_tgt <= 8'h3f ;

  //imeas ctrl
      threshold_hi_0       <=8'hFF;
      threshold_hi_1       <=8'hFF;
      threshold_lo_0       <=8'h00;
      threshold_lo_1       <=8'h00;

      
      int_alarm_en         <=1'b0;

      nf_unstable_time_reg0 <=8'h00;
      nf_unstable_time_reg1 <=8'h00;
   
  end
  else begin
      case(i_addr[ADDR_WIDTH-1:0])   	           
           //imeas ctrl
           `IMEAS_REG_CTRL_0    : imeas_reg_ctrl_0          <= i_wr ? i_wr_data[7:0] : imeas_reg_ctrl_0;    
           `IMEAS_REG_CTRL_1    : imeas_reg_ctrl_1          <= i_wr ? i_wr_data[7:0] : imeas_reg_ctrl_1; //this is used in ECG CAL inside zmeas
            
           `IMEAS_REG_RSTVAL   : imeas_reg_rstval[7:0]     <= i_wr ? i_wr_data[7:0] : imeas_reg_rstval[7:0];    
           `IMEAS_EN           : imeas_en                  <= i_wr ? i_wr_data[0]   : imeas_en;    
           `IMEAS_GRP_CTL      : imeas_grp_ctl             <= i_wr ? i_wr_data[0]   : imeas_grp_ctl;    
           `IMEAS_CHA_NUM_HI   : active_channel_num_hi     <= i_wr ? i_wr_data[3:0] : active_channel_num_hi;    
           `IMEAS_CHA_NUM_LO   : active_channel_num_lo     <= i_wr ? i_wr_data[7:0] : active_channel_num_lo;    
           `IMEAS_INPUT_FORMAT : imeas_input_format        <= i_wr ? i_wr_data[1:0] : imeas_input_format;
	   `NOTCH_FILTER_EN    : notch_filter_en_reg 	    <= i_wr ? i_wr_data[2:0]     : notch_filter_en_reg;    //1 is enable
    	   `LEADOFF_CTRL       : leadoff_ctrl 	    	    <= i_wr ? i_wr_data[6:0]   : leadoff_ctrl;
    	   `LEADOFF_TGT_0      : leadoff_tgt_0 	    <= i_wr ? i_wr_data[7:0]   : leadoff_tgt_0;
    	   `LEADOFF_TGT_1      : leadoff_tgt_1 	    <= i_wr ? i_wr_data[7:0]   : leadoff_tgt_1;
    	   `LEADOFF_SWITCH_TGT : leadoff_switch_tgt 	    <= i_wr ? i_wr_data[7:0]   : leadoff_switch_tgt;
        
           `IMEAS_THRESHOLD_HI_0: threshold_hi_0            <= i_wr ? i_wr_data[7:0] : threshold_hi_0;    
           `IMEAS_THRESHOLD_HI_1: threshold_hi_1            <= i_wr ? i_wr_data[7:0] : threshold_hi_1;    
           `IMEAS_THRESHOLD_LO_0: threshold_lo_0            <= i_wr ? i_wr_data[7:0] : threshold_lo_0;    
           `IMEAS_THRESHOLD_LO_1: threshold_lo_1            <= i_wr ? i_wr_data[7:0] : threshold_lo_1;    

           `IMEAS_ALARM_INT_EN :  int_alarm_en              <= i_wr ? i_wr_data[0] : int_alarm_en;    
           `IMEAS_CH_MODE       : imeas_reg_ch               <= i_wr ? i_wr_data[7:0] : imeas_reg_ch;    
	   `IMEAS_REG_SEQ      : imeas_reg_seq              <= i_wr ? i_wr_data[2:0] : imeas_reg_seq;  

            `NF_UNSTABLE_TIME_0 : nf_unstable_time_reg0     <= i_wr ? i_wr_data : nf_unstable_time_reg0;
            `NF_UNSTABLE_TIME_1 : nf_unstable_time_reg1     <= i_wr ? i_wr_data : nf_unstable_time_reg1;
 

	                
  endcase  
   
  end
end

//imeas register output
assign o_threshold_hi       = {threshold_hi_1,threshold_hi_0};
assign o_threshold_lo       = {threshold_lo_1,threshold_lo_0};

assign o_int_alarm_en       = int_alarm_en;

assign o_imeas_reg_ctrl     = {imeas_reg_ctrl_1,imeas_reg_ctrl_0}; //imeas_reg_ctrl_1 is used in ECG CAL inside zmeas
assign o_imeas_reg_ch       = imeas_reg_ch;
assign o_imeas_reg_seq      = imeas_reg_seq;
assign o_imeas_en           = imeas_en;
assign o_imeas_reg_rstval   = imeas_reg_rstval;
assign o_imeas_input_format =imeas_input_format;
assign o_imeas_grp_ctl      = imeas_grp_ctl;
assign o_active_channel_num = {active_channel_num_hi,active_channel_num_lo};











//READ//
reg [7:0]  reg_rd_data;
always @ (posedge i_clk or negedge i_rst_n) begin
//always @ (*) begin
   if (!i_rst_n)
        reg_rd_data <= 8'b0;
   else if(!i_wr) begin
        case(i_addr[ADDR_WIDTH-1:0])

            //I-Meas
		`IMEAS_REG_CTRL_0                 :   reg_rd_data <= {imeas_reg_ctrl_0[7:4],1'b0,imeas_reg_ctrl_0[2:0]};    //flash_to_imeas_ctrl0;    
        	`IMEAS_REG_CTRL_1                 :   reg_rd_data <= imeas_reg_ctrl_1;    //flash_to_imeas_ctrl1;  this is used in ECG CAL inside zmeas 

		`IMEAS_THRESHOLD_HI_0             :   reg_rd_data <= threshold_hi_0;    //flash_to_imeas_ctrl0;    
        	`IMEAS_THRESHOLD_HI_1             :   reg_rd_data <= threshold_hi_1;    //flash_to_imeas_ctrl1;   
		`IMEAS_THRESHOLD_LO_0             :   reg_rd_data <= threshold_lo_0;    //flash_to_imeas_ctrl0;    
		`IMEAS_THRESHOLD_LO_1             :   reg_rd_data <= threshold_lo_1;    //flash_to_imeas_ctrl0;    


		`IMEAS_ALARM_INT_EN               :   reg_rd_data <= {7'b0,int_alarm_en};            
		`IMEAS_CH_MODE                     :   reg_rd_data <= imeas_reg_ch;        //{imeas_reg_ch};    
		`IMEAS_REG_SEQ                    :   reg_rd_data <= {5'b0,imeas_reg_seq};  
            	`IMEAS_REG_RSTVAL                 :   reg_rd_data <= imeas_reg_rstval;
        	`IMEAS_EN                         :   reg_rd_data <= {7'b0,imeas_en};   
		`IMEAS_GRP_CTL                    :  reg_rd_data <= {7'b0,imeas_grp_ctl};  
       	        `IMEAS_CHA_NUM_HI                 :  reg_rd_data <= {4'b0,active_channel_num_hi};   
		`IMEAS_CHA_NUM_LO                 :  reg_rd_data <= active_channel_num_lo; 
              	`IMEAS_INPUT_FORMAT               :  reg_rd_data <=    {6'b0,imeas_input_format}; 

        	`IMEAS_INT                        :   reg_rd_data <=  {2'b0,int_sts_switch,int_sts_duration,reg_imeas_bio_int_sts,reg_imeas_int_sts1,reg_imeas_int_sts0, reg_imeas_int_sts};  

        	`LEADOFF_INT                      :   reg_rd_data <=  {
						        int_sts_switch_acloff_statp,int_sts_duration_acloff_statp,int_sts_switch_acloff_statn,int_sts_duration_acloff_statn,
							int_sts_switch_loff_statp,int_sts_duration_loff_statp,int_sts_switch_loff_statn,int_sts_duration_loff_statn};  
        	`IMEAS_ALARM_INT                  :   reg_rd_data <=  {7'b0, reg_imeas_int_alarm_sts};  
         	`IMEAS_CH0DATA_0                  :   reg_rd_data <=  reg_imeas_ch0data[7:0];   
		`IMEAS_CH0DATA_1                  :   reg_rd_data <=  reg_imeas_ch0data[15:8];   
		`IMEAS_CH1DATA_0                  :   reg_rd_data <=  reg_imeas_ch1data[7:0];   
		`IMEAS_CH1DATA_1                  :   reg_rd_data <=  reg_imeas_ch1data[15:8];   
		`IMEAS_CH2DATA_0                  :   reg_rd_data <=  reg_imeas_ch2data[7:0];  
		`IMEAS_CH2DATA_1                  :   reg_rd_data <=  reg_imeas_ch2data[15:8];   

         	`IMEAS_CH0DATA_MAX_0                  :   reg_rd_data <=  ch0data_max_final[7:0];   
		`IMEAS_CH0DATA_MAX_1                  :   reg_rd_data <=  ch0data_max_final[15:8];   
         	`IMEAS_CH0DATA_MIN_0                  :   reg_rd_data <=  ch0data_min_final[7:0];   
		`IMEAS_CH0DATA_MIN_1                  :   reg_rd_data <=  ch0data_min_final[15:8];   
         	`IMEAS_CH0DATA_DELTA_0                  :   reg_rd_data <=  ch0data_delta_final[7:0];   
		`IMEAS_CH0DATA_DELTA_1                  :   reg_rd_data <=  ch0data_delta_final[15:8];   

	        `NOTCH_FILTER_EN       :  reg_rd_data <= {5'b0,notch_filter_en_reg};

    	        `LEADOFF_CTRL       		:  reg_rd_data <= {1'b0,leadoff_ctrl };	
    	        `LEADOFF_TGT_0      		:  reg_rd_data <= {leadoff_tgt_0}; 	
    	        `LEADOFF_TGT_1      		:  reg_rd_data <= {leadoff_tgt_1}; 	
    	        `LEADOFF_SWITCH_TGT 		:  reg_rd_data <= {leadoff_switch_tgt}; 

                `NF_UNSTABLE_TIME_0             :  reg_rd_data <= nf_unstable_time_reg0;
                `NF_UNSTABLE_TIME_1             :  reg_rd_data <= nf_unstable_time_reg1;

            	default   		    :  reg_rd_data     <= 8'b0;
        endcase 
          
   end
   else
      reg_rd_data <= reg_rd_data;  //or 8'b0 =>rd_data=0 when not reading
 end

assign o_rd_data =reg_rd_data;


endmodule
