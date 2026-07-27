/////////////////////////////////////////////////////////
////----------------------------------------------------
////-- author: zhen
////
////-- module: ppg_outdrv
////
////-- discription: output led signal
////
////-- data:11/3/2024
////
////-- version: first version
////
////----------------------------------------------------
/////////////////////////////////////////////////////////

module ppg_outdrv(
input wire         OSC_256K,  //256k clock
input wire         OSC_256K_gate,
input wire         rst_n, 
input wire         IDAC_LEDSEL,
input wire  [7:0]  TIA_IDAC_in,
input wire  [2:0]  Mode_sel,
input wire  [3:0]  TIA_GAIN_temp,

input wire led1_working,
input wire led2_working,

input wire drvh_standby_en, 
input wire drvh_ledortia_en,
input wire drvh_shck_en,    
input wire drvh_aforbuff_en,
input wire drvh_status_en,  

input wire drvl_standby_en, 
input wire drvl_ledortia_en,
input wire drvl_shck_en,    
input wire drvl_aforbuff_en,
input wire drvl_status_en,

output wire       EN_PPG_AF_fsm,
output wire       EN_PPG_BUFFER_fsm,
output wire       EN_PPG_SH_fsm,
output wire       EN_TIA_fsm,
output wire       EN_TIA_BUFFER_fsm,
output wire [7:0] TIA_IDAC_fsm,
output wire       PPG_SH_CK_fsm,
output wire       LED_STANDBY_fsm,
output wire       LED_EN_fsm,
output wire [1:0]  LEDSEL_fsm,
//output reg [1:0]  LED2SEL_fsm,
output wire       leddca_sel,
output wire [3:0]  TIA_GAIN_fsm,
output wire       LED_STATUS

);

//wire
reg [1:0] LED1SEL_fsm,LED2SEL_fsm;
wire standby_en,ledortia_en,shck_en,aforbuff_en,status_en;
assign EN_PPG_AF_fsm       = aforbuff_en;
assign EN_PPG_BUFFER_fsm   = aforbuff_en;
assign EN_PPG_SH_fsm       = aforbuff_en;
assign EN_TIA_BUFFER_fsm   = aforbuff_en;

assign LED_STANDBY_fsm     = standby_en;
assign LED_EN_fsm          = ledortia_en;
assign EN_TIA_fsm          = ledortia_en;
assign PPG_SH_CK_fsm       = shck_en;
assign LED_STATUS          = status_en;

//reg

reg IDAC_LEDSEL_sync1,IDAC_LEDSEL_sync2,IDAC_LEDSEL_sync3;
always @( posedge OSC_256K  or negedge rst_n)begin
    if(!rst_n) begin
    IDAC_LEDSEL_sync1 <= 1'b0;
    IDAC_LEDSEL_sync2 <= 1'b0; 
    IDAC_LEDSEL_sync3 <= 1'b0;   
    end
    else begin
    IDAC_LEDSEL_sync1 <= IDAC_LEDSEL;
    IDAC_LEDSEL_sync2 <= IDAC_LEDSEL_sync1; 
    IDAC_LEDSEL_sync3 <= IDAC_LEDSEL_sync2;    
    end    
end

reg [7:0] idrg1_reg, idrg2_reg;
reg [3:0] idrg3_reg, idrg4_reg;
always @( posedge OSC_256K  or negedge rst_n)begin
    if(!rst_n) begin
    idrg1_reg <= 8'h00;
    idrg2_reg <= 8'h00;    
    end
    else if(!IDAC_LEDSEL_sync2 && IDAC_LEDSEL_sync3) begin
    idrg2_reg <= TIA_IDAC_in;
    idrg1_reg <= idrg1_reg;  
    end
    else if(IDAC_LEDSEL_sync2 && !IDAC_LEDSEL_sync3)begin
    idrg2_reg <= idrg2_reg;
    idrg1_reg <= TIA_IDAC_in;  
    end    
end

always @( posedge OSC_256K  or negedge rst_n)begin
    if(!rst_n) begin
    idrg3_reg <= 4'h0;
    idrg4_reg <= 4'h0;    
    end
    else if(!IDAC_LEDSEL_sync2 && IDAC_LEDSEL_sync3) begin
    idrg4_reg <= TIA_GAIN_temp;
    idrg3_reg <= idrg3_reg;  
    end
    else if(IDAC_LEDSEL_sync2 && !IDAC_LEDSEL_sync3)begin
    idrg4_reg <= idrg4_reg;
    idrg3_reg <= TIA_GAIN_temp;  
    end    
end


assign TIA_IDAC_fsm = leddca_sel? idrg2_reg   : idrg1_reg;
assign LEDSEL_fsm   = leddca_sel? LED2SEL_fsm : LED1SEL_fsm; 
assign TIA_GAIN_fsm = leddca_sel? idrg4_reg   : idrg3_reg;

// model sel logic
// 0  1  2  3  4  5  6  7 //value
// aa ab ac bb bc cc cd   //LED	

always@(*) begin
   case(Mode_sel)
     3'b000: begin
     LED1SEL_fsm =  2'b00;
     LED2SEL_fsm =  2'b00;	     
     end
     3'b001: begin
     LED1SEL_fsm =  2'b00;
     LED2SEL_fsm =  2'b01;	     
     end
     3'b010: begin
     LED1SEL_fsm =  2'b00;
     LED2SEL_fsm =  2'b10;	     
     end
     3'b011: begin
     LED1SEL_fsm =  2'b01;
     LED2SEL_fsm =  2'b01;	     
     end
     3'b100:begin
     LED1SEL_fsm =  2'b01;
     LED2SEL_fsm =  2'b10;	     
     end
     3'b101: begin
     LED1SEL_fsm =  2'b10;
     LED2SEL_fsm =  2'b10;	     
     end
     3'b110: begin
     LED1SEL_fsm =  2'b10;
     LED2SEL_fsm =  2'b11;	     
     end
     3'b111: begin
     LED1SEL_fsm =  2'b00;
     LED2SEL_fsm =  2'b00;	     
     end
     default: begin
     LED1SEL_fsm =  2'b00;
     LED2SEL_fsm =  2'b00;	     
     end
   endcase
end

//instance
outdrv_reg u_standby (
       .clk	(OSC_256K_gate),
       .resetn	(rst_n),
       .drvh	(drvh_standby_en),
       .drvl	(drvl_standby_en || drvl_status_en),
       .outreg	(standby_en)
     );
     
outdrv_reg u_leddca_sel (
       .clk	(OSC_256K_gate),
       .resetn	(rst_n),
       .drvh	(drvh_standby_en && led2_working),
       .drvl	(drvh_standby_en && led1_working),
       .outreg	(leddca_sel)
     );     
                                         
outdrv_reg u_ledortia (
       .clk	(OSC_256K_gate),
       .resetn	(rst_n),
       .drvh	(drvh_ledortia_en),
       .drvl	(drvl_ledortia_en || drvl_status_en),
       .outreg	(ledortia_en)
     );

outdrv_reg u_shck (
       .clk	(OSC_256K_gate),
       .resetn	(rst_n),
       .drvh	(drvh_shck_en),
       .drvl	(drvl_shck_en || drvl_status_en),
       .outreg	(shck_en)
     );

outdrv_reg u_aforbuff (
       .clk	(OSC_256K_gate),
       .resetn	(rst_n),
       .drvh	(drvh_aforbuff_en),
       .drvl	(drvl_aforbuff_en),
       .outreg	(aforbuff_en)
     );

outdrv_reg u_status (
       .clk	(OSC_256K_gate),
       .resetn	(rst_n),
       .drvh	(drvh_status_en && led2_working),
       .drvl	((drvh_status_en && led1_working) || drvl_status_en),
       .outreg	(status_en)
     );




endmodule

