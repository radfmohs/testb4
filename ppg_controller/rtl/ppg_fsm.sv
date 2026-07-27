/////////////////////////////////////////////////////////
////----------------------------------------------------
////-- author: zhen
////
////-- module: ppg_fsm
////
////-- discription: the fsm of ppg controller
////
////-- data: 11/3/2024
////
////-- version: first version
////
////----------------------------------------------------
/////////////////////////////////////////////////////////

module ppg_fsm(
input wire       OSC_256K,  //256k clock
input wire       rst_n,     

input wire [3:0] Freq_ctrl,  //	LED flashing period: 0 : 10ms; 1: 20ms,2 : 30ms, 3: 40ms
//input wire       IDAC_LEDSEL,// 0 : idrg1 ; 1: idrg2;
input wire       Sig_Sel,    // 0 : FSM OFF 1: FSM ON
input wire [3:0] on_time_sel,//0:180us,1: 280us
//input wire [2:0] Mode_sel,   // 0  1  2  3  4  5  6  7 //value
                             // aa ab ac bb bc cc cd   //LED	

//new added by Xin 26Mar2026
input   wire  scan_en,
input       wire          PPG_LED_PROG_SEL,
input 	wire   [13:0] led_on,
input 	wire   [13:0] led_freq,

//output
output reg led1_working,
output reg led2_working,

output wire drvh_standby_en, 
output wire drvh_ledortia_en,
output wire drvh_shck_en,    
output wire drvh_aforbuff_en,
output wire drvh_status_en,  

output wire drvl_standby_en, 
output wire drvl_ledortia_en,
output wire drvl_shck_en,    
output wire drvl_aforbuff_en,
output wire drvl_status_en  



	
	);

//-----------------
//parameter define
//-----------------
//FSM
localparam LED_IDLE       = 4'h0;
localparam LED_STANDY     = 4'h1;
localparam LED_ENBALE     = 4'h2;
localparam LED_PPG_CK     = 4'h3;
localparam LED_DISENBALE  = 4'h4;
localparam LED_WORK       = 4'h5;
localparam LED1_SEL       = 4'h6;
localparam LED2_SEL       = 4'h7;


//COUNTER
localparam COUNTER10MS  = 14'd2550;//10ms
localparam COUNTER12MS  = 14'd3062;//12ms
localparam COUNTER14MS  = 14'd3574;//14ms
localparam COUNTER16MS  = 14'd4086;//16ms
localparam COUNTER18MS  = 14'd4598;//18ms
localparam COUNTER20MS  = 14'd5110;//20ms
localparam COUNTER22MS  = 14'd5622;//22ms
localparam COUNTER24MS  = 14'd6134;//24ms
localparam COUNTER26MS  = 14'd6646;//26ms
localparam COUNTER28MS  = 14'd7158;//28ms
localparam COUNTER30MS  = 14'd7670;//30ms
localparam COUNTER32MS  = 14'd8182;//32ms
localparam COUNTER34MS  = 14'd8694;//34ms
localparam COUNTER36MS  = 14'd9206;//36ms
localparam COUNTER38MS  = 14'd9718;//38ms
localparam COUNTER40MS  = 14'd10230;//40ms

localparam COUNTER20US  = 14'd5;   //20us

localparam COUNTER125US = 14'd30;  //125us
localparam COUNTER150US = 14'd36;  //150us
localparam COUNTER175US = 14'd43;  //175us
localparam COUNTER200US = 14'd49;  //200us
localparam COUNTER225US = 14'd56;  //225us
localparam COUNTER250US = 14'd62;  //250us
localparam COUNTER275US = 14'd69;  //275us
localparam COUNTER300US = 14'd75;  //300us
localparam COUNTER325US = 14'd81;  //325us
localparam COUNTER350US = 14'd88;  //350us
localparam COUNTER375US = 14'd94;  //375us
localparam COUNTER400US = 14'd101;  //400us
localparam COUNTER425US = 14'd107;  //425us
localparam COUNTER450US = 14'd113;  //450us
localparam COUNTER475US = 14'd120;  //475us
localparam COUNTER500US = 14'd126;  //500us

//-----------------
//signal define
//-----------------
wire led_prd,led_en_prd; //led period
reg [3:0] cur_state,next_state;
reg [13:0] fsm_counter,led_one_prd, led_cha_prd;
reg [7:0] Freq_ctrl_temp; 
//reg led1_working,led2_working;

    
wire OSC_256K_noprog;
common_clock_gate 
u_cmsdk_clock_gate_noprog (
.clk        (OSC_256K),
.enable     (~PPG_LED_PROG_SEL),
.bypass     (scan_en),  //Tri change
.gated_clk  (OSC_256K_noprog));


//always @( posedge OSC_256K  or negedge rst_n)begin
always @( posedge OSC_256K_noprog  or negedge rst_n)begin
    if(!rst_n) begin
    Freq_ctrl_temp <= 8'h20; 
    end
    else if((cur_state==LED_IDLE) || (cur_state==LED1_SEL) || (cur_state==LED2_SEL)) begin
    Freq_ctrl_temp <= {on_time_sel,Freq_ctrl}; 
    end
end

wire OSC_256K_prog;
common_clock_gate 
u_cmsdk_clock_gate_prog (
.clk        (OSC_256K),
.enable     (PPG_LED_PROG_SEL),
.bypass     (scan_en),  //Tri change
.gated_clk  (OSC_256K_prog));

reg   [13:0] led_on_temp;
reg   [13:0] led_freq_temp;
always @( posedge OSC_256K_prog  or negedge rst_n)begin
    if(!rst_n) begin
    led_on_temp   <= 14'd30; 
    led_freq_temp <= 14'd3574; 
    end
    else if((cur_state==LED_IDLE) || (cur_state==LED1_SEL) || (cur_state==LED2_SEL)) begin
    led_on_temp <= led_on; 
    led_freq_temp <= led_freq; 
    end
end


assign led_one_prd = (Freq_ctrl_temp[7:4] == 4'h0)? COUNTER125US : 
                     (Freq_ctrl_temp[7:4] == 4'h1)? COUNTER150US : 
                     (Freq_ctrl_temp[7:4] == 4'h2)? COUNTER175US : 
                     (Freq_ctrl_temp[7:4] == 4'h3)? COUNTER200US : 
                     (Freq_ctrl_temp[7:4] == 4'h4)? COUNTER225US : 
                     (Freq_ctrl_temp[7:4] == 4'h5)? COUNTER250US : 
                     (Freq_ctrl_temp[7:4] == 4'h6)? COUNTER275US : 
                     (Freq_ctrl_temp[7:4] == 4'h7)? COUNTER300US : 
                     (Freq_ctrl_temp[7:4] == 4'h8)? COUNTER325US : 
                     (Freq_ctrl_temp[7:4] == 4'h9)? COUNTER350US : 
                     (Freq_ctrl_temp[7:4] == 4'ha)? COUNTER375US : 
                     (Freq_ctrl_temp[7:4] == 4'hb)? COUNTER400US : 
                     (Freq_ctrl_temp[7:4] == 4'hc)? COUNTER425US : 
                     (Freq_ctrl_temp[7:4] == 4'hd)? COUNTER450US : 
                     (Freq_ctrl_temp[7:4] == 4'he)? COUNTER475US : 
                     (Freq_ctrl_temp[7:4] == 4'hf)? COUNTER500US :  COUNTER175US;

assign led_cha_prd = (Freq_ctrl_temp[3:0] == 4'h0)? COUNTER10MS  :
                     (Freq_ctrl_temp[3:0] == 4'h1)? COUNTER12MS  :
                     (Freq_ctrl_temp[3:0] == 4'h2)? COUNTER14MS  :
                     (Freq_ctrl_temp[3:0] == 4'h3)? COUNTER16MS  :
                     (Freq_ctrl_temp[3:0] == 4'h4)? COUNTER18MS  :
                     (Freq_ctrl_temp[3:0] == 4'h5)? COUNTER20MS  :
                     (Freq_ctrl_temp[3:0] == 4'h6)? COUNTER22MS  :
                     (Freq_ctrl_temp[3:0] == 4'h7)? COUNTER24MS  :
                     (Freq_ctrl_temp[3:0] == 4'h8)? COUNTER26MS  :
                     (Freq_ctrl_temp[3:0] == 4'h9)? COUNTER28MS  :
                     (Freq_ctrl_temp[3:0] == 4'ha)? COUNTER30MS  :
                     (Freq_ctrl_temp[3:0] == 4'hb)? COUNTER32MS  :
                     (Freq_ctrl_temp[3:0] == 4'hc)? COUNTER34MS  :
                     (Freq_ctrl_temp[3:0] == 4'hd)? COUNTER36MS  :
                     (Freq_ctrl_temp[3:0] == 4'he)? COUNTER38MS  :
                     (Freq_ctrl_temp[3:0] == 4'hf)? COUNTER40MS  : COUNTER10MS;




//assign led_prd    =   (fsm_counter == (led_cha_prd-led_one_prd));

//assign led_en_prd =   (fsm_counter == led_one_prd);

assign led_prd    =   (fsm_counter == (PPG_LED_PROG_SEL ? (led_freq_temp - led_on_temp) : (led_cha_prd-led_one_prd)));
assign led_en_prd =   (fsm_counter == (PPG_LED_PROG_SEL ? led_on_temp : led_one_prd));
//-----------------
//LED1 logic
//-----------------
always @( posedge OSC_256K  or negedge rst_n)begin
    if(!rst_n) begin
    led1_working <= 1'b0;
    led2_working <= 1'b0;    
    end
    else if(cur_state==LED1_SEL) begin
    led1_working <= 1'b1;
    led2_working <= 1'b0;    
    end
    else if(cur_state==LED2_SEL) begin
    led1_working <= 1'b0;
    led2_working <= 1'b1;	     
    end
    else if(cur_state==LED_IDLE)begin
    led1_working <= 1'b0;
    led2_working <= 1'b0;    
    end    
end

//-----------------
//counter logic
//-----------------
always @( posedge OSC_256K  or negedge rst_n)begin
    if(!rst_n) begin
    fsm_counter <= 14'h000;
    end
    else if(Sig_Sel)begin
	    if(cur_state !=  next_state)
                fsm_counter <= 14'h000;
            else 
                fsm_counter <= fsm_counter + 1'b1;
    end
    else begin
    fsm_counter <=  14'h000;   
    end
end

//-----------------
//fsm seq logic
//-----------------
always @( posedge OSC_256K  or negedge rst_n)begin
    if(!rst_n) begin
    cur_state <= 4'h0;
    end
    else begin
    cur_state <=  next_state;   
    end
end
//-----------------
//fsm comb logic
//-----------------
always @(*)begin   
//next_state = cur_state;
  case(cur_state)
	 LED_IDLE : begin 
	    if (fsm_counter > 14'h002)
              next_state = LED1_SEL;
	    else 
              next_state = LED_IDLE;
	 end  
         LED1_SEL,LED2_SEL : begin
            if(!Sig_Sel)
              next_state = LED_IDLE;
	    else 
              next_state = LED_STANDY;	
	 end 
         LED_STANDY : begin
            if(!Sig_Sel)
              next_state = LED_IDLE;
	    else if (fsm_counter >= COUNTER20US-1'b1)
              next_state = LED_ENBALE;
	    else 
              next_state = LED_STANDY;	
	 end 
         LED_ENBALE : begin
            if(!Sig_Sel)
              next_state = LED_IDLE;		 
	    else if (led_en_prd)
              next_state = LED_PPG_CK;
	    else 
              next_state = LED_ENBALE;	
	 end 
         LED_PPG_CK : begin
              next_state = LED_DISENBALE;
         end
	 LED_DISENBALE: begin
              next_state = LED_WORK;
         end
         LED_WORK : begin
            if(!Sig_Sel)
              next_state = LED_IDLE;		 
            else if (led_prd) begin
                   if(led1_working)
                    next_state = LED2_SEL;
                   else
                    next_state = LED1_SEL;
           end
	   else 
              next_state = LED_WORK;	
	 end	 
         default : begin
              next_state = LED_IDLE;
	 end	 
   endcase

end

//--------------------
//fsm output control
//--------------------
 assign drvh_standby_en  = (cur_state==LED_STANDY)? 1'b1 : 1'b0;
 assign drvh_ledortia_en = (cur_state==LED_ENBALE)? 1'b1 : 1'b0;
 assign drvh_shck_en     = (cur_state==LED_ENBALE)? 1'b1 : 1'b0;
 assign drvh_aforbuff_en = (cur_state==LED_STANDY)? 1'b1 : 1'b0;
 assign drvh_status_en   = (cur_state==LED_ENBALE)? 1'b1 : 1'b0;

 assign drvl_standby_en  = (cur_state==LED_DISENBALE)? 1'b1 : 1'b0;
 assign drvl_ledortia_en = (cur_state==LED_DISENBALE)? 1'b1 : 1'b0;
 assign drvl_shck_en     = (cur_state==LED_PPG_CK)   ? 1'b1 : 1'b0;
 assign drvl_aforbuff_en = (cur_state==LED_IDLE)     ? 1'b1 : 1'b0;
 assign drvl_status_en   = (cur_state==LED_IDLE)     ? 1'b1 : 1'b0;


/*
always@(*) begin
 drvh_standby_en  = 1'b0;
 drvh_ledortia_en = 1'b0;
 drvh_shck_en     = 1'b0;
 drvh_aforbuff_en = 1'b0;
 drvh_status_en   = 1'b0;

 drvl_standby_en  = 1'b0;
 drvl_ledortia_en = 1'b0;
 drvl_shck_en     = 1'b0;
 drvl_aforbuff_en = 1'b0;
 drvl_status_en   = 1'b0;
   case(cur_state)
       LED_IDLE : begin
         drvl_aforbuff_en = 1'b1;
         drvl_status_en   = 1'b1;	 
       end	       
       LED_STANDY : begin
         drvh_standby_en  = 1'b1;
         drvh_aforbuff_en = 1'b1;
       end	
       LED_ENBALE : begin
         drvh_ledortia_en = 1'b1;
         drvh_shck_en     = 1'b1;
	 drvh_status_en   = 1'b1;	 
       end          
       LED_PPG_CK : begin
         drvl_shck_en     = 1'b1;	       
       end  
       LED_DISENBALE: begin
         drvl_ledortia_en = 1'b1;          
         drvl_standby_en  = 1'b1;	 
       end  
   endcase
end
*/
endmodule

