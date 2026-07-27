//------------------------------------------------------------------------------
// Nanochap Pty Ltd (c) 2021
//
// Module Name : spi
// Description : spi slave controller 
//------------------------------------------------------------------------------
// Revision History
//------------------------------------------------------------------------------
// Revision     Date        Author
//------------------------------------------------------------------------------
// 0.1          5/08/2021  Jayanthi 
// Initial Rev
//------------------------------------------------------------------------------
//slave samples at posedge of sclk and changes data at posedge of sclk. master has to place the data at posdeg of master clk and samples on posedge of master clk)
//supported mode  general cpol=0,cpha=0, data latch and sample at same as master posdeg of sclk and master clk
//master equavalent is cpol=0,cpha=1(master won't work, it can't latch the data)

`timescale 1ns/1ps

module spi_slave_controller#(
parameter ADDR_WIDTH = 8,
parameter DATA_WIDTH = 8	
)(
i_rst_n          ,
i_sclk           ,
atpg_en		 ,
i_cs_n           ,
i_mosi           ,
o_addr           ,
o_wr             ,
o_wr_data        ,
i_rd_data        ,
o_miso           ,
i_fifo_rd_data   ,
i_tag_out_en     ,
o_fifo_rd_req_n  ,
 o_addr_vld_for_int_clr,
 o_pre_addr,
 burst_cmd_reg 
//o_fifo_data_rd_done
);

//parameter DATA_WIDTH = 8;
//parameter ADDR_WIDTH = 8;

//Port declarations
input i_rst_n                        ;
input i_sclk                         ;
input atpg_en			     ;
input i_cs_n                         ;
input i_mosi                         ;
input [DATA_WIDTH-1:0] i_rd_data     ;
input [ 17:0]           i_fifo_rd_data ;
input  i_tag_out_en;
output reg o_wr                      ;
output reg [DATA_WIDTH-1:0] o_wr_data;
output reg [ADDR_WIDTH-1:0] o_addr   ;
output reg o_miso                    ;
output     o_fifo_rd_req_n;
output reg o_addr_vld_for_int_clr;
output reg burst_cmd_reg;
output reg [ADDR_WIDTH-1:0] o_pre_addr;
//output reg o_fifo_data_rd_done;


reg [DATA_WIDTH-1:0]    rx_buf ;
reg [DATA_WIDTH-1:0]    tx_buf ;
reg [5:0]               bit_cnt;
reg tx_d,cs_n_d                ;
reg rd_data_rdy                ;
reg cmd_reg,i_mosi_d             ;
reg latch_state,latch_state_d  ;
reg fifo_cmd_reg;


reg  fifo_rd_data_tag_done;
reg fifo_rd_data_msb_done;
reg fifo_rd_data_lsb_done;

reg [2:0] byte_bit_count;
wire [2:0] trans_cnt = byte_bit_count - 3'd2;

// chip select latch

always@(posedge i_sclk or negedge i_rst_n)           //include reset
 begin
   if(!i_rst_n)
    cs_n_d <= 1;   //active low
   else
    cs_n_d <= i_cs_n;
 end


//mosi latch

always@(posedge i_sclk or negedge i_rst_n)            //include reset
  begin
   if(!i_rst_n)
   // i_mosi_d <=1'bz;
    i_mosi_d <=1'b0;
   else
    i_mosi_d <= i_mosi;
  end




always@(posedge i_sclk , negedge i_rst_n) begin
  if (!i_rst_n) begin
    rx_buf <= {DATA_WIDTH{1'b0}};
  end 
 else if (cs_n_d == 1'b1) begin
    rx_buf <= {DATA_WIDTH{1'b0}};
  end 
 else begin
   rx_buf <= {rx_buf[DATA_WIDTH-2:0],i_mosi_d};
  end
end


//bit cnt logic
wire bit_cnt_reset = i_rst_n & !i_cs_n;
always@(posedge i_sclk or negedge bit_cnt_reset)begin //or negedge i_cs_n)  begin // or negedge i_cs_n) begin
 // if (!i_rst_n) begin
   if (!bit_cnt_reset) begin
    bit_cnt <= 0;
  end
  else if (i_cs_n)begin
    bit_cnt <= 0;
  end
// else if (cs_n_d == 1'b1) begin
//    bit_cnt <= 0;
//  end
 else begin  
 
// if ((bit_cnt ==6'h21 && cmd_reg==1 ) || (bit_cnt == 6'h19 && cmd_reg==0))    // if number of bit in cmd is 24
 if ((bit_cnt ==6'h20 && cmd_reg==1 ) || (bit_cnt == 6'h18 && cmd_reg==0))    // if number of bit in cmd is 24
    bit_cnt <= bit_cnt;
   else
    bit_cnt <= bit_cnt + 1;
 end



end

//------ byte_done logic------------//
always@(posedge i_sclk, negedge i_rst_n) begin
  if (!i_rst_n) begin
   byte_bit_count <=3'b111;
  end
// else if(byte_bit_count==8'h00  || bit_cnt==6'h01) begin   //starts counting the bits of wr_data //|| bit_cnt ==6'h12 ||
  else if(bit_cnt==6'h00) begin   //starts counting the bits of wr_data //|| bit_cnt ==6'h12 ||

   byte_bit_count<= 3'b111;
  end
  else  begin
   byte_bit_count <=byte_bit_count-1;
  end
end

wire byte_done;
assign byte_done = (byte_bit_count==3'h0);


reg burst_mode;
always@(posedge i_sclk, negedge i_rst_n) begin
  if (!i_rst_n) begin
   burst_mode <=1'b0;
  end
 //else if(bit_cnt ==5'h02) begin
else if(bit_cnt ==6'h00) begin
   burst_mode <=1'b0;
  end
  // else if ((bit_cnt ==6'h21 &&  cmd_reg==1 ) || (bit_cnt == 5'h19 && cmd_reg==0)) begin
 else if ((bit_cnt ==6'h20 &&  cmd_reg==1 ) || (bit_cnt == 6'h18 && cmd_reg==0)) begin
   burst_mode <=1'b1;
  end
end






//-------------------address-------------//
always@(posedge i_sclk or negedge i_rst_n) begin
  if (!i_rst_n) begin
    o_addr   <= 0;
    o_addr_vld_for_int_clr <=0;
    o_pre_addr <=0;
  end else if (bit_cnt == 6'h09 ) begin //original 8
    o_addr  <= rx_buf[ADDR_WIDTH-1:0];    
    o_addr_vld_for_int_clr <=1; 
    o_pre_addr <= o_addr;
  end
   //    else if ((!fifo_cmd_reg && cmd_reg==1 && burst_cmd_reg && bit_cnt>6'h19 && byte_done )||(!fifo_cmd_reg &&cmd_reg==0 && burst_cmd_reg &&  bit_cnt >6'h12 && byte_bit_count==3'h4))  begin
    else if ((!fifo_cmd_reg && cmd_reg==1 && burst_cmd_reg && bit_cnt>6'h18 && byte_done )||(!fifo_cmd_reg &&cmd_reg==0 && burst_cmd_reg &&  bit_cnt >6'h12 && byte_bit_count==3'h4))  begin

     o_addr   <= o_addr+1'B1; 
     o_addr_vld_for_int_clr <=1;
     o_pre_addr <= o_addr;
   end
   else
    begin
    o_addr   <= o_addr;
    o_addr_vld_for_int_clr <=0;
    o_pre_addr <= o_pre_addr;
   end
end



//-------------------Command type (RD/WR)-----------/
always@(posedge i_sclk, negedge i_rst_n) begin
  if (!i_rst_n) begin
    cmd_reg <= 1'b0;
  end else if (cs_n_d == 1'b1) begin
    cmd_reg <= 1'b0;
  end else if(bit_cnt == 6'h00) begin
    cmd_reg <= 1'b0;
 // end else if (bit_cnt == 6'h0b )begin        // 9th bit is the command bit(9+2 =11) 
  end else if (bit_cnt == 6'h0a )begin        // 9th bit is the command bit(9+1 =10) 
    cmd_reg <= rx_buf[0];            
  end
end


//-------------FIFO_CMD---------------------//
always@(posedge i_sclk, negedge i_rst_n) begin
  if (!i_rst_n) begin
    fifo_cmd_reg <= 1'b0;
  end else if (cs_n_d == 1'b1) begin
    fifo_cmd_reg <= 1'b0;
 // end else if (bit_cnt == 6'h0c )begin        // 10th bit is the command bit(10+2=12) 
 end else if (bit_cnt == 6'h0b )begin        // 10th bit is the command bit(10+1=11) 
    fifo_cmd_reg <= rx_buf[0];            
  end
end

//-------------Burst_CMD-------------------//
always@(posedge i_sclk, negedge i_rst_n) begin
  if (!i_rst_n) begin
    burst_cmd_reg <= 1'b0;
  end else if (cs_n_d == 1'b1) begin
    burst_cmd_reg <= 1'b0;
  end else if(bit_cnt == 6'h00) begin
   burst_cmd_reg <= 1'b0;
//  end else if (bit_cnt == 6'h0d )begin        // 11th bit is the command bit(11+2=13) 
 end else if (bit_cnt == 6'h0c )begin        // 11th bit is the command bit(11+1=12)
    burst_cmd_reg <= rx_buf[0];            
  end
end




//-----------------------wr_data logic--------------------/
//latch 
always@(posedge i_sclk, negedge i_rst_n) begin
  if (!i_rst_n) begin
    latch_state <= 1'b0;
 end else if (cs_n_d == 1'b1) begin
    latch_state <= 1'b0;
 end else if(bit_cnt==6'h0) begin
    latch_state <= 1'b0;
 
 //end else if (burst_mode ==1'b0 && bit_cnt ==6'h19 && cmd_reg==1 )begin // after receiving data1 is 7th bit
end else if (burst_mode ==1'b0 && bit_cnt ==6'h18 && cmd_reg==1 )begin // after receiving data1 is 7th bit

    latch_state <= 1'b1;
// end else if ( bit_cnt ==6'h21 && byte_bit_count==3'h0 && cmd_reg==1) begin //burst_mode==1'b1
 end else if ( bit_cnt ==6'h20 && byte_bit_count==3'h0 && cmd_reg==1) begin //burst_mode==1'b1

   latch_state <= 1'b1;
  end else begin
    latch_state <= 1'b0;
  end
end


//wr_data
always@(posedge i_sclk, negedge i_rst_n) begin
  if (!i_rst_n) begin
    o_wr_data <= 0;
  end else if (latch_state) begin
    o_wr_data <= rx_buf[DATA_WIDTH-1:0];
  end
end

// wr_enable
always@(posedge i_sclk, negedge i_rst_n) begin
  if (!i_rst_n) begin
    o_wr <= 1'b0;
  end
 else if(bit_cnt ==6'h0)begin
    o_wr <=1'b0;
 end else if ((latch_state) && (cmd_reg == 1'b1)) begin    //can be latch_state
    o_wr <= 1'b1;
  end else begin
    o_wr <= 1'b0;
  end
end

//-----------------------------mosi output------------------//

wire i_sclk_neg = atpg_en ? i_sclk : ~i_sclk;
//always@(posedge i_sclk, negedge i_rst_n) begin
always@(posedge i_sclk_neg, negedge i_rst_n) begin
  if (!i_rst_n) begin
      o_miso <= 1'b0;
  end else if (cs_n_d == 1'b1) begin
      o_miso <= 1'b0;
  end else begin
    o_miso <= tx_d;
  end 
end

reg [17:0] fifo_rd_data_sync;
wire [17:0] o_fifo_rd_data_sync;
wire [7:0] fifo_tag = {6'b0,fifo_rd_data_sync[17:16]};
wire [7:0] msb_data = fifo_rd_data_sync[15:8];
wire [7:0] lsb_data = fifo_rd_data_sync[7:0];

//tx_d
always@(posedge i_sclk, negedge i_rst_n) begin
//always@(negedge i_sclk, negedge i_rst_n) begin
  if (!i_rst_n) begin
    tx_d <= 1'b0;
  end else if (cs_n_d == 1'b1) begin
    tx_d <= 1'b0;
  end else if (rd_data_rdy == 1) begin
    if (fifo_rd_data_tag_done == 1'b1) begin
      tx_d <= fifo_tag[trans_cnt]; ; 
    end else if (fifo_rd_data_msb_done == 1'b1) begin
      tx_d <= msb_data[trans_cnt];;
    end else if (fifo_rd_data_lsb_done == 1'b1) begin
      tx_d <= lsb_data[trans_cnt];;
    end else
      tx_d <= tx_buf[DATA_WIDTH-1];
  end else begin
    tx_d <= rx_buf[5]; // just send what is received //original 2  
 end
end

//rd_data_rdy
always@(posedge i_sclk, negedge i_rst_n) begin
  if (!i_rst_n) begin
    rd_data_rdy <= 1'b0;
  end else if (cs_n_d == 1'b1) begin
     rd_data_rdy <= 1'b0;
  end else if (bit_cnt ==6'h4 ) begin  // bit_cnt == 2) begin   //when sampling the cmd instruction 2
    rd_data_rdy <= 1'b0; 
 end else if (bit_cnt > 6'h8 && byte_bit_count==3'h2 && cmd_reg == 1'b0) begin // @ the end of the 2nd byte(cmd byte)
// end else if (bit_cnt > 6'h8 && byte_bit_count==3'h3 && cmd_reg == 1'b0) begin // @ the end of the 2nd byte(cmd byte)
    rd_data_rdy <= 1'b1;
  end
end



//fifo_rd_req_n
//bit_cnt_reset
reg           fifo_read_req_en;
reg           fifo_rd_req_n_local;
reg    [2:0]  pulse_cnt;
reg           fifo_rd_req_n;

always@(posedge i_sclk, negedge bit_cnt_reset) begin
  if (!bit_cnt_reset) begin
    fifo_rd_req_n <= 1'b1;
  end

  // Clock dead!
  else if (i_cs_n) begin
    fifo_rd_req_n <= 1'b1;
  end else if(bit_cnt ==6'h00) begin //02
    fifo_rd_req_n <= 1'b1;
  end
//  else if(fifo_cmd_reg ==1 && cmd_reg==0 && byte_bit_count==3'h0  && fifo_rd_data_msb_done==1'b0 && bit_cnt == 6'h19 ) begin // after detecting the fifo_cmd, before sending the lsb
//  else if(fifo_cmd_reg ==1 && cmd_reg==0 && byte_bit_count==3'h0  && fifo_rd_data_tag_done==1'b0 && fifo_rd_data_msb_done==1'b0 && bit_cnt == 6'h18 ) begin // after detecting the fifo_cmd, before sending the lsb
//   fifo_rd_req_n <= 1'b0;
//end

  else if(fifo_cmd_reg ==1 && cmd_reg==0 && ((byte_bit_count==3'h3 && bit_cnt==6'h0d && fifo_rd_data_msb_done==1'b0) || (byte_bit_count==3'h1 && bit_cnt==6'h18 && fifo_rd_data_msb_done==1'b1)) && fifo_rd_data_tag_done==1'b0 &&  i_tag_out_en ==1'b0 ) begin // after detecting the fifo_cmd, before sending the lsb
    fifo_rd_req_n <= 1'b0;
  end else if(fifo_cmd_reg ==1 && cmd_reg==0 && ((byte_bit_count==3'h3 && bit_cnt==6'h0d && fifo_rd_data_tag_done==1'b0) || (byte_bit_count==3'h1 && bit_cnt==6'h18 && fifo_rd_data_tag_done==1'b1)) &&  i_tag_out_en ==1'b1 ) begin // after detecting the fifo_cmd, before sending the lsb
    fifo_rd_req_n <= 1'b0;
  end

//  else if(fifo_cmd_reg ==1 && cmd_reg==0 && byte_bit_count==3'h0  && fifo_rd_data_msb_done==1'b1 && bit_cnt == 6'h19 &&  i_tag_out_en ==1'b1 && fifo_rd_data_lsb_done==1'b1) begin
//   fifo_rd_req_n <= 1'b0;
//  end
  else
    fifo_rd_req_n<=1'b1;
end

always @(posedge i_sclk or negedge bit_cnt_reset)
  if (!bit_cnt_reset)
    pulse_cnt <= 3'b000;
  else if (!fifo_read_req_en)
    pulse_cnt <= 3'b000;
  else
    pulse_cnt <= pulse_cnt+1;

// Creating new read_req_en
always @(posedge i_sclk or negedge bit_cnt_reset)
  if (!bit_cnt_reset)
    fifo_read_req_en <= 1'b0;
  else if (i_cs_n)
    fifo_read_req_en <= 1'b0;
  else if (fifo_rd_req_n == 1'b0)
    fifo_read_req_en <= 1'b1;
  else if (pulse_cnt == 3'b100)
    fifo_read_req_en <= 1'b0;
  else
    fifo_read_req_en <= fifo_read_req_en;

assign o_fifo_rd_req_n = ~fifo_read_req_en;


//-----------tx_buf----------------------/

//bit syn for the Fifo_rd_data   //synchronized spi_top

assign o_fifo_rd_data_sync = i_fifo_rd_data; 
/*
common_sync_bit //common_bit_sync 
 #(
.RST_VAL(0))
 u_fifo_rd_data[17:0] (
       .clk(i_sclk),
       .rst_(i_rst_n),
      .async_in (i_fifo_rd_data), //(18'h03322),
     //  .async_in (18'h03322),
       .sync_out(o_fifo_rd_data_sync)
       );
*/
       
always@(posedge i_sclk, negedge i_rst_n) begin
  if (!i_rst_n) begin
    fifo_rd_data_sync <= 18'h0;

  // FIRST ELEMENT
  end else if (fifo_cmd_reg == 1'b1 && bit_cnt==6'h0c && byte_bit_count==3'h4) begin
    fifo_rd_data_sync <= o_fifo_rd_data_sync;

  // SECOND ELEMENT ONWARD
  end else if (fifo_rd_data_lsb_done==1'b1 && bit_cnt==6'h18 && byte_bit_count==3'h2 && fifo_cmd_reg==1'b1) begin
    fifo_rd_data_sync <= o_fifo_rd_data_sync;
  end else begin
    fifo_rd_data_sync <= fifo_rd_data_sync;
  end
end

always@(posedge i_sclk, negedge i_rst_n) begin
  if (!i_rst_n) begin
    tx_buf <= 0;
    fifo_rd_data_tag_done  <= 1'b0;
    fifo_rd_data_msb_done <= 1'b0;
    fifo_rd_data_lsb_done <= 1'b0;
  end else if (cs_n_d == 1'b1) begin
     tx_buf <= 0;
     fifo_rd_data_tag_done  <= 1'b0;
     fifo_rd_data_msb_done <= 1'b0;
     fifo_rd_data_lsb_done <= 1'b0;
  end else if(bit_cnt ==6'h02) begin
     tx_buf <= 0;                         
     fifo_rd_data_tag_done <= 1'b0;
     fifo_rd_data_msb_done <= 1'b0;
     fifo_rd_data_lsb_done <= 1'b0;
  end else if (fifo_cmd_reg ==1 && burst_cmd_reg==1'b1 && cmd_reg==0 &&  bit_cnt > 6'h8 && byte_bit_count==3'h2 && fifo_rd_data_tag_done == 1'b0 && fifo_rd_data_msb_done ==1'b0 && fifo_rd_data_msb_done ==1'b0&& i_tag_out_en==1'b1) begin //to read from the FIFO_data_lsb
     tx_buf <= {6'b0,fifo_rd_data_sync[17:16]};  //i_fifo_data_rd;
     fifo_rd_data_tag_done <= 1'b1;
     fifo_rd_data_msb_done <= 1'b0;
     fifo_rd_data_lsb_done <= 1'b0;
  end else if (fifo_cmd_reg ==1 && burst_cmd_reg==1'b1 && cmd_reg==0 &&  bit_cnt > 6'h8 && byte_bit_count==3'h2 && fifo_rd_data_msb_done == 1'b0) begin  //to read from the FIFO_data_msb
    tx_buf <= fifo_rd_data_sync[15:8];  //i_fifo_data_rd;
    fifo_rd_data_msb_done <= 1'b1;
    fifo_rd_data_lsb_done <= 1'b0;
    fifo_rd_data_tag_done <= 1'b0;
  end else if (fifo_cmd_reg ==1 && burst_cmd_reg==1'b1 && cmd_reg==0 &&  bit_cnt > 6'h8 && byte_bit_count==3'h2 && fifo_rd_data_lsb_done == 1'b0) begin //to read from the FIFO_data_lsb
   tx_buf <= fifo_rd_data_sync[7:0];  //i_fifo_data_rd;
   fifo_rd_data_lsb_done <= 1'b1;
   fifo_rd_data_msb_done <= 1'b0;
    fifo_rd_data_tag_done <= 1'b0;
   end else if (bit_cnt > 6'h8 && byte_bit_count==3'h2) begin // @ the end of the 2nd byte(cmd byte)
//  end else if (bit_cnt > 6'h8 && byte_bit_count==3'h3) begin // @ the end of the 2nd byte(cmd byte)

    tx_buf <= i_rd_data;
    fifo_rd_data_msb_done <= 1'b0;
    fifo_rd_data_lsb_done <= 1'b0;
     fifo_rd_data_tag_done <= 1'b0;
  end else begin

    tx_buf <= {tx_buf[DATA_WIDTH-2:0],1'b0};
    fifo_rd_data_msb_done <= fifo_rd_data_msb_done;
    fifo_rd_data_lsb_done <= fifo_rd_data_lsb_done;
     fifo_rd_data_tag_done <= fifo_rd_data_tag_done;
  end
end


/*
//o_fifo_data_rd_done
always@(posedge i_sclk, negedge i_rst_n) begin
  if (!i_rst_n) begin
    o_fifo_data_rd_done <= 0;
  end else if (cs_n_d == 1'b1) begin
    o_fifo_data_rd_done <= 0;
 end else if(bit_cnt ==6'h02) begin
   o_fifo_data_rd_done <= 0;
 end else if(bit_cnt == 6'h02) begin
   o_fifo_data_rd_done <= 1'b0;
//  end else if(o_addr == `FIFO_DATA_REG2 && bit_cnt==6'h18 || (fifo_cmd_reg ==1 && fifo_rd_data_msb_done && byte_bit_count==3'h01 ) ) begin  //after reading the fifo_data_reg2(lsb)
  end else if(o_addr == `FIFO_DATA_REG2 && bit_cnt==6'h18 || (fifo_cmd_reg ==1 && fifo_rd_data_msb_done && byte_bit_count==3'h7 ) ) begin  //after reading the fifo_data_reg2(lsb)
   o_fifo_data_rd_done <= 1'b1;
  end else
   o_fifo_data_rd_done <=1'b0;    //o_fifo_data_rd_done;
end

*/
endmodule










/*
always@(posedge i_sclk, negedge i_rst_n) begin
  if (!i_rst_n) begin
    tx_buf <= 0;
    fifo_rd_data_msb_done <= 1'b0;
    fifo_rd_data_lsb_done <= 1'b0;
  end else if (cs_n_d == 1'b1) begin
     tx_buf <= 0;
     fifo_rd_data_msb_done <= 1'b0;
     fifo_rd_data_lsb_done <= 1'b0;
  end else if(bit_cnt ==6'h02) begin
     tx_buf <= 0;         //fifo_rd_data_sync[15:8];// //0;
     fifo_rd_data_msb_done <= 1'b0;
     fifo_rd_data_lsb_done <= 1'b0;
  end else if (fifo_cmd_reg ==1 && burst_cmd_reg==1'b1 && cmd_reg==0 &&  bit_cnt > 6'h8 && byte_bit_count==3'h2 && fifo_rd_data_msb_done == 1'b0) begin  //to read from the FIFO_data_msb
    tx_buf <= fifo_rd_data_sync[15:8];  //i_fifo_data_rd;
    fifo_rd_data_msb_done <= 1'b1;
    fifo_rd_data_lsb_done <= 1'b0;
  end else if (fifo_cmd_reg ==1 && burst_cmd_reg==1'b1 && cmd_reg==0 &&  bit_cnt > 6'h8 && byte_bit_count==3'h2 && fifo_rd_data_lsb_done == 1'b0) begin //to read from the FIFO_data_lsb
   tx_buf <= fifo_rd_data_sync[7:0];  //i_fifo_data_rd;
   fifo_rd_data_lsb_done <= 1'b1;
    if( !i_tag_out_en)
     fifo_rd_data_msb_done <= 1'b0;
    else
     fifo_rd_data_msb_done <= 1'b1;
  end else if (fifo_cmd_reg ==1 && burst_cmd_reg==1'b1 && cmd_reg==0 &&  bit_cnt > 6'h8 && byte_bit_count==3'h2 && fifo_rd_data_lsb_done == 1'b1 && fifo_rd_data_msb_done == 1'b1 && i_tag_out_en==1'b1) begin //to read from the FIFO_data_lsb
   tx_buf <= {fifo_rd_data_sync[17:16],4'b0};  //i_fifo_data_rd;
   fifo_rd_data_lsb_done <= 1'b0;
   fifo_rd_data_msb_done <= 1'b0;
  end else if (bit_cnt > 6'h8 && byte_bit_count==3'h2) begin // @ the end of the 2nd byte(cmd byte)
    tx_buf <= i_rd_data;
    fifo_rd_data_msb_done <= 1'b0;
    fifo_rd_data_lsb_done <= 1'b0;
  end else begin
    tx_buf <= {tx_buf[DATA_WIDTH-2:0],1'b0};
    fifo_rd_data_msb_done <= fifo_rd_data_msb_done;
    fifo_rd_data_lsb_done <= fifo_rd_data_lsb_done;
  end
end
*/








