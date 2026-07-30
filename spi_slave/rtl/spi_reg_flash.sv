



module spi_reg_flash#(
	parameter ADDR_WIDTH =8,
	parameter DATA_WIDTH =8,
	parameter NO_TRIM_REGS = 21

)(
    spi2flash.master         spi2flash,

	input                  i_clk,
	input                  i_rst_n,
	input [ADDR_WIDTH-1:0] i_addr,
	input                  i_wr,
	input [DATA_WIDTH-1:0] i_wr_data,
        
	output [DATA_WIDTH-1:0] o_rd_data

);


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////--------------------------Flash Register Logic------------------------------////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
wire [15:0]  i_DEBUG_FLASH;
wire [7:0]   flash_data_spi;
wire [7:0]   flash_rnd_addr;
wire         wr_working;
wire         i_FLASH_busy;
wire         FLASH_Reset_Done;
reg [7:0]    spi_data_all00;
reg [7:0]    spi_addr_all00;
reg [6:0]    spi_addr_all01;

wire        FLASH_busy_sync;
wire        FLASH_Reset_Done_sync;

assign i_DEBUG_FLASH  = {spi2flash.bd2s[1],spi2flash.bd2s[0]};
assign flash_data_spi = spi2flash.bd2s[2];
assign flash_rnd_addr = spi2flash.bd2s[3];

assign wr_working         = spi2flash.sd2s[0];
assign i_FLASH_busy       = spi2flash.sd2s[1];
assign FLASH_Reset_Done   = spi2flash.sd2s[2];



//flash Reset_Done
common_sync_bit #(
.RST_VAL(0)
) u_FLASH_Reset_Done (
       .clk(i_clk),
       .rst_(i_rst_n),
       .async_in(FLASH_Reset_Done),
       .sync_out(FLASH_Reset_Done_sync)
      );

//flash busy
common_sync_bit#(
.RST_VAL(0)
) u_FLASH_busy_sync (
       .clk(i_clk),
       .rst_(i_rst_n),
       .async_in(i_FLASH_busy),
       .sync_out(FLASH_busy_sync)
      );




/////----FLASH_UNLOCK-----------/////
wire wr_working_sync,wr_working_sync_f,wr_working_sync_r;
common_sync_bit    
 #(
.RST_VAL(0))
 u_wr_working_sync(
       .clk(i_clk),
       .rst_(i_rst_n),
       .async_in(wr_working),
       .sync_out(wr_working_sync)
       );

common_pulse_edge u_wr_working_sync_edge(
.d_in(wr_working_sync),
.clk(i_clk),
.rst_(i_rst_n),
.d_out_r(wr_working_sync_r),
.d_out_f(wr_working_sync_f)

);

reg [7:0] flash_unlock;
reg [7:0] flash_trim_pro;
reg [7:0] flash_nvr_pro00;
reg [7:0] flash_nvr_pro01;
wire [15:0] flash_nvr_pro;
wire [14:0] spi_addr_all;
reg [7:0] flash_ctrl;
//reg [2:0] flash_rnd_slct;
wire      flash_op_en, nvr1_op_en,nvr1_addr_en,nvr1_addr_trim;

assign flash_nvr_pro = {flash_nvr_pro01,flash_nvr_pro00};
assign spi_addr_all  = {spi_addr_all01[6:0],spi_addr_all00[7:0]};
assign flash_op_en   = flash_trim_pro==8'hAA;
assign nvr1_op_en    = flash_nvr_pro==16'hAAAA;
assign nvr1_addr_en  = flash_ctrl[4] && (spi_addr_all<=15'h01FF);
assign nvr1_addr_trim  = (spi_addr_all<=15'h01FF) && (spi_addr_all> NO_TRIM_REGS - 1);

always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)begin
  flash_unlock      <=8'h00;
  end
  else if((i_addr[ADDR_WIDTH-1:0]==`FLASH_UNLOCK) && i_wr && flash_op_en) begin
   flash_unlock       <= i_wr_data[7:0];
  end
  else if((!flash_unlock[2] & wr_working_sync_f) || (flash_unlock[2] & wr_working_sync_r))begin
  flash_unlock      <=8'h00;
  end
end

always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)begin
  flash_nvr_pro00      <=8'h00;
  end
  else if((i_addr[ADDR_WIDTH-1:0]==`FLASH_NVR_PRO_BYTE00) && i_wr ) begin
  flash_nvr_pro00       <= i_wr_data[7:0];
  end
end

always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)begin
  flash_nvr_pro01      <=8'h00;
  end
  else if((i_addr[ADDR_WIDTH-1:0]==`FLASH_NVR_PRO_BYTE01) && i_wr ) begin
  flash_nvr_pro01       <= i_wr_data[7:0];
  end
end

always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)begin
  flash_trim_pro      <=8'h00;
  end
  else if((i_addr[ADDR_WIDTH-1:0]==`FLASH_UNLOCK_PRO) && i_wr ) begin
  flash_trim_pro      <= i_wr_data[7:0];
  end
end

wire flash_debug_mode;
reg flash_debug_mode0;//read back trim register
reg flash_debug_mode1;//write trim register

assign flash_debug_mode = flash_debug_mode0 | flash_debug_mode1;


assign  spi2flash.sd2f[0]   = flash_unlock[0] && nvr1_op_en && !flash_debug_mode;//trim wr
assign  spi2flash.sd2f[1]   = flash_unlock[2] && !flash_debug_mode;//normal rd
assign  spi2flash.sd2f[2]   = (nvr1_addr_en? flash_unlock[3] && nvr1_op_en && nvr1_addr_trim: flash_unlock[3]) && !flash_debug_mode;//normal wr
assign  spi2flash.sd2f[3]   = (nvr1_addr_en? flash_unlock[4] && nvr1_op_en : flash_unlock[4]) && !flash_debug_mode;//ser
assign  spi2flash.sd2f[4]   = flash_unlock[5] && !flash_debug_mode;//cer
assign  spi2flash.sd2f[6]   = flash_unlock[1] && !flash_debug_mode;//shadow wr
assign  spi2flash.sd2f[7]   = flash_debug_mode0;//shadow wr
assign  spi2flash.sd2f[8]   = flash_debug_mode1;//shadow wr


always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)begin
  flash_ctrl      <=8'h00;
  end
  else if((i_addr[ADDR_WIDTH-1:0]==`FLASH_CTRL) && i_wr ) begin
  flash_ctrl       <= i_wr_data[7:0];
  end
end

assign spi2flash.sd2f[5] = flash_ctrl[4];//nvr


always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)begin
  spi_data_all00           <= 8'hff;
  end
  else if(!FLASH_busy_sync & (i_addr[ADDR_WIDTH-1:0]==`FLASH_DATA00) && i_wr) begin
  spi_data_all00          <= i_wr_data;
  end
end


always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)begin
  spi_addr_all00           <= 8'h00;
  end
  else if(!FLASH_busy_sync & (i_addr[ADDR_WIDTH-1:0]==`FLASH_ADDR00) && i_wr) begin
  spi_addr_all00           <= i_wr_data[7:0];
  end
end

always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)begin
  spi_addr_all01           <= 7'h00;
  end
  else if(!FLASH_busy_sync & (i_addr[ADDR_WIDTH-1:0]==`FLASH_ADDR01) && i_wr) begin
  spi_addr_all01           <= i_wr_data[6:0];
  end
end

assign spi2flash.bd2f[0] = spi_data_all00;
assign spi2flash.bd2f[1] = spi_addr_all00;
assign spi2flash.bd2f[2] = {1'b0,spi_addr_all01};


always@(posedge i_clk or negedge i_rst_n) begin
  if(!i_rst_n)begin
  flash_debug_mode0  <= 1'b0;
  flash_debug_mode1  <= 1'b0;
  end
  else if(!FLASH_busy_sync & (i_addr[ADDR_WIDTH-1:0]==`DEBUG_MODE_TYPE) && i_wr) begin
  flash_debug_mode0  <= (i_wr_data==8'h01);
  flash_debug_mode1  <= (i_wr_data==8'h02);
  end
end


////////////////////trim values can be wriiten through spi and Flash)/////////////////
reg trim_reg_updated[NO_TRIM_REGS-1:0];
reg [7:0] trim_reg[NO_TRIM_REGS-1:0];

genvar trim_num;
generate 
  for(trim_num=0; trim_num < NO_TRIM_REGS; trim_num++) begin : TRIM_DEFINE
      always@(posedge i_clk or negedge i_rst_n) begin
        if(!i_rst_n)begin
        trim_reg[trim_num]           <= 8'h00; 
        trim_reg_updated[trim_num]   <= 1'b0;
        end
        else if(FLASH_Reset_Done_sync & !trim_reg_updated[trim_num])begin   // @OTP_Reset_Done OTP values are loaded
         trim_reg[trim_num]           <= spi2flash.trim_read[trim_num];
         trim_reg_updated[trim_num]   <= 1'b1;
        end
        else if(!FLASH_busy_sync & (i_addr[ADDR_WIDTH-1:0]==(`FLASH_TRIMDATA0 + trim_num)) && i_wr) begin
          trim_reg[trim_num]          <= i_wr_data;
        end
       end

          assign spi2flash.trim[trim_num] =  trim_reg[trim_num];
   end
endgenerate


//READ//
reg [7:0]  reg_rd_data;
always @ (posedge i_clk or negedge i_rst_n) begin
//always @ (*) begin
   if (!i_rst_n)
        reg_rd_data <= 8'b0;
   else if(!i_wr) begin
     if((i_addr[ADDR_WIDTH-1:0]>=`FLASH_TRIMDATA0) & (i_addr[ADDR_WIDTH-1:0] < `FLASH_TRIMDATA0 + NO_TRIM_REGS))begin             
        reg_rd_data <=  trim_reg[i_addr[ADDR_WIDTH-1:0] - `FLASH_TRIMDATA0]; 
     end
     else begin
        case(i_addr[ADDR_WIDTH-1:0])
          `FLASH_DEBUG1                     :   reg_rd_data <=  i_DEBUG_FLASH[7:0];   //i_DEBUG_FLASH[7:0];
          `FLASH_DEBUG2                     :   reg_rd_data <=  i_DEBUG_FLASH[15:8];  //i_DEBUG_FLASH[15:8];
          `FLASH_UNLOCK                     :   reg_rd_data <=  flash_unlock;
          `FLASH_CTRL                       :   reg_rd_data <=  flash_ctrl;                   
          `FLASH_DATA00                     :   reg_rd_data <=  spi_data_all00;
          `FLASH_ADDR00                     :   reg_rd_data <=  spi_addr_all00;
          `FLASH_ADDR01                     :   reg_rd_data <=  {1'b0,spi_addr_all01};

          `FLASH_EME_DATA00                 :   reg_rd_data <=  flash_data_spi[7:0];
          `FLASH_RDN_ADDR                   :   reg_rd_data <=  flash_rnd_addr;

          `FLASH_NVR_PRO_BYTE00             :   reg_rd_data <=  flash_nvr_pro00;
          `FLASH_NVR_PRO_BYTE01             :   reg_rd_data <=  flash_nvr_pro01;
          `FLASH_UNLOCK_PRO                 :   reg_rd_data <=  flash_trim_pro;
          `DEBUG_MODE_TYPE                  :   reg_rd_data <=  {6'b0,flash_debug_mode1,flash_debug_mode0};
            	default   		    :  reg_rd_data     <= 8'b0;
        endcase 
     end     
   end
   else
      reg_rd_data <= reg_rd_data;  //or 8'b0 =>rd_data=0 when not reading
 end

assign o_rd_data =reg_rd_data;


endmodule
