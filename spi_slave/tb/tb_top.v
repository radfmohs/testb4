
`timescale 1 ns /  1 ps
module tb_top();

parameter SPI_CLK_PERIOD          =62.5;  //21.5;// 46 MHZ      //19.5 //51.2 MHZ  //.0002857  //285KHZ
parameter SYS_CLK_PERIOD_16MHZ    =62.5;     //16 MHZ
 



reg clk_r;
reg rst_n_r;
reg cs_n_r;
reg mosi_r;
reg miso_r;
wire miso_w;

reg  sts_wr_en_r;
reg [127:0] sts_wr_value_r;
reg wr;
reg rd;
reg stop_clk;
//wire clk_rr;
reg clk_enable;
reg wr_rd;
reg rd_wr;
reg sys_clk;



initial 
 begin
//  rst_n_r      =1'b1; 
 // cs_n_r       =1'b1;     //chip select (active low)     
  clk_r        =1'b0; 
  clk_enable   =1'b0; 
  sts_wr_en_r  =1'b0;
  sts_wr_value_r =128'b0;

  wr           =1'b0;
  rd           =1'b0;
  wr_rd        =1'b0;
  rd_wr        =1'b0;
  #30 rst_n_r  =1'b0;
 #20 rst_n_r   =1'b1;     //reset release
// #10 cs_n_r  =1'b0;
/*
 #30 wr         =1'b1;     //send write command
// #10 sts_wr_en_r=1'b1;
//     sts_wr_value_r =128'h1111_1111;
 #5000  wr     =1'b0;
 #1000  rd     =1'b1;     //send rd_cmd
 #2000  rd     =1'b0;
 #500   wr_rd  =1'b1;    //send wr_rd
 #4500  wr_rd  =1'b0;
 #500   rd_wr  =1'b1;    //send rd_wr
 #5000  rd_wr  =1'b0;
*/
 //#2350 rd     =1'b1;  //send read
  #100100 rd= 1'b1;
 //#10000 rd    =1'b0;
 
end

//serial data input
//wr only
reg [0:31] data_in_wr;
reg [4:0]  cnt_wr;
//rd_only
 reg [0:31] data_in_rd;
 reg [4:0] cnt_rd;
//wr_rd 
 reg [0:63] data_in_wr_rd;
 reg [6:0] cnt_wr_rd;
//rd_wr
 reg [0:63] data_in_rd_wr;
 reg [6:0]  cnt_rd_wr;


reg stop_flag;
 reg clk_en;
reg [7:0] rd_cnt;

always @(posedge clk_r or negedge rst_n_r)
 begin
    if(!rst_n_r ) begin
      mosi_r     = 1'bz;
      clk_en     =1'b0;
      stop_flag  =1'b0; 
      rd_cnt     =8'h00;
      //to write
       cnt_wr =5'h00;
       data_in_wr = 32'h80_90_ee_00;  //write/ addr= 00000010 /data=ff/don'tcare
     //to read
        cnt_rd =5'h00;
        data_in_rd =32'h00_82_ff_ff;   //read /addr=00000010/don'tcare/do'tcare
     // to wr_rd
        cnt_wr_rd =7'h00;
        data_in_wr_rd =64'h80_03_ee_00_00_02_ff_ff; //wr_ins/addr=3/wr_data/pad/rd_ins/add/pad/pad
    // to rd_wr
        cnt_rd_wr =7'h00;
        data_in_rd_wr =64'h00_02_ff_ff_80_03_ee_00; //rd_ins/addr_2/padd/pad/wr_ins/add/wr_data_pad   
        cs_n_r=1'b1;
     end
    else begin 
     if(wr==1 )begin   //write cmd
        cs_n_r   =1'b0;
        clk_en   =1'b1;
        mosi_r   = data_in_wr[cnt_wr];
        cnt_wr   =cnt_wr+1'b1;
          
       if(cnt_wr == 5'h20) begin   //18
          cnt_wr =5'h00;
         end
 
      end
      else if(rd==1)begin  //rd cmd
         cs_n_r  =1'b0;
         clk_en  =1'b1;

         mosi_r = data_in_rd[cnt_rd]; //-1];
         cnt_rd =cnt_rd+1;

        if(cnt_rd == 5'h20) begin
          cnt_rd =5'h00;
          rd_cnt =rd_cnt+1;
         end
       end
     else if(wr_rd==1)begin  //write && read
       cs_n_r =1'b0;
       clk_en =1'b1;
       mosi_r =data_in_wr_rd[cnt_wr_rd];
       cnt_wr_rd =cnt_wr_rd+1;
        if(cnt_wr_rd ==7'h64)begin
         cnt_wr_rd =7'h00;
        end
    end
     else if(rd_wr ==1) begin  //read && write
        cs_n_r =1'b0;
        clk_en =1'b1;
        mosi_r =data_in_rd_wr[cnt_rd_wr];
         cnt_rd_wr =cnt_rd_wr+1;
        if(cnt_rd_wr==7'h64) begin
          cnt_rd_wr =7'h00;
        end
     end
     else begin
     cs_n_r =1'b1;
     mosi_r =1'bz;
     clk_en =1'b0;
     end
  end 
end

 
always 
 begin
  clk_r = #(SPI_CLK_PERIOD/2) ~clk_r; //clk for input MOSI data (data change on posedge of clk changes)
 end 

always 
 begin
  clk_enable = #( 1*(SPI_CLK_PERIOD/2)) clk_en;
 end



//sclk generation 
wire clk_rr; //original
assign clk_rr =  cs_n_r ? 1'b0 : clk_r; // ( cpol=0, cpha=0(general) (spi_contoller_new.v)
//assign clk_rr =  cs_n_r ? 1'b0 : ~clk_r;// ( cpol=0, cpha=1)
//assign clk_rr =  cs_n_r ? 1'b1 : clk_r; // ( cpol=1, cpha=1) 
//assign clk_rr =  cs_n_r ? 1'b1 : ~clk_r;// ( cpol=1, cpha=0) spi_controller.v


///------sys clk generation -------------
wire drive_sts_reg_input;
wire drive_sts_reg_wr_en_high;
wire drive_sts_reg_wr_en_low;

initial
 begin
  sys_clk=1'b0;
// drive_sts_reg_input =1'b0;
 end

always 
 begin
  sys_clk = #(SYS_CLK_PERIOD_16MHZ/2) ~sys_clk;
 end

//-------------------calculate 100us of 16MHZ----------------100us =1600
reg [11:0] cnt ;
wire cnt_time_out;
wire cnt_1clk_time_out;
wire cnt_95us_time_out;
wire cnt_100us_time_out;

always @(posedge sys_clk or negedge rst_n_r) begin
  if(!rst_n_r) 
    cnt =12'hfff;
  else if(cnt_time_out)
    cnt =12'h000;
  else
    cnt=cnt+1'b1;
end

assign cnt_time_out      = (cnt ==12'h640); //for 100us dec=1600 //hex-640
assign drive_sts_reg_input =cnt_time_out;


//-------------drive the status reg inputs every 100us of 16mhz system clock

reg [127:0] sts_dri_val[4]; //ins
reg  [1:0] dri_val_cnt;
initial begin
  sts_dri_val[0] =128'hffff_ffff_ffff_ffff_ffff_ffff_ffff;
  sts_dri_val[1] =128'h0000_0000_0000_0000_0000_0000_0000; 
  sts_dri_val[2] =128'hffff_ffff_ffff_ffff_ffff_ffff_ffff;
  sts_dri_val[3] =128'h0000_0000_0000_0000_0000_0000_ffff;
end

always @(posedge sys_clk or negedge rst_n_r) begin
  if(!rst_n_r) begin
    //sts_wr_en_r=1'b0;
    sts_wr_value_r =128'h0000_0000_0000_0000_0000_0000_00000;
    dri_val_cnt =2'b00;
  end
   if(drive_sts_reg_input) begin
     sts_wr_value_r = sts_dri_val[dri_val_cnt] ;
     dri_val_cnt =dri_val_cnt+1;  
  end
  else begin
   sts_wr_value_r =sts_wr_value_r;
   dri_val_cnt =dri_val_cnt;
  end
end


assign cnt_1clk_time_out = (cnt==12'h001);
assign cnt_95us_time_out = (cnt==12'h5ef);
assign cnt_100us_time_out =  (cnt==12'h640);

// drive the status reg enable low for every 95us for the priod of 5us+1clk(5.0625us) of 16 mhz clk
always @(posedge sys_clk or negedge rst_n_r) begin
  if(!rst_n_r) begin
   sts_wr_en_r =1'b0;
  end
  else if(cnt_1clk_time_out)
    sts_wr_en_r =1'b1;
  else if(cnt_95us_time_out)
   sts_wr_en_r =1'b0;
  else if(cnt_100us_time_out)
   sts_wr_en_r=1'b0;
  else
   sts_wr_en_r =sts_wr_en_r;
end

/*
always
  begin
  if( cnt_100us_time_out)
   rd = ~rd;
 end

*/
//dut instance
spi_top  #(.addr_width(8),
           .data_width(8))
 spi_top_u (
    .i_rst_n(rst_n_r),
   // .i_clk(sys_clk),                      //clk for the reg block  sys_clk 16MHZ
    .i_sclk(clk_rr), //clk_rr            // sclk clock for the spi-slave controller and reg block 
    .i_cs_n(cs_n_r),
    .i_mosi(mosi_r),
    .i_sts_wr_en(sts_wr_en_r),
    //.i_sts_wr_en(sts_wr_en_req),
    .i_sts_wr_value(sts_wr_value_r),
    //.o_sts_wr_en_ack(sts_wr_en_ack),
    .o_miso(miso_w),
    .o_spi_wr(),
    .o_spi_wr_data(),
    .o_spi_addr(),


     //config_outputs
      //system reg output
   .o_np_sys_en(),
  // .o_np_clk_sel(),
  // .o_samp_period(),
  // .o_samp_width(),
   .o_test_mode(),
   .o_auto_stop( ),
   .o_clk_sys_config(), 
   .o_sys_rst_width(),
   .o_sys_rst_delay(),
   .o_rst_width(),
   .o_rst_delay(),
   .o_clk_ini_width(),
   .o_clk_ini_delay(),
   .o_clk_fnl_width(),
   .o_clk_fnl_delay(),
   .o_adc_en_width(),
   .o_adc_en_delay(),
   .o_adc_start_width(),
   .o_adc_start_delay(),
   .o_adc_ch_st_width(),
   .o_adc_ch_st_delay(),
   .o_adc_sample_width(),
   .o_adc_sample_delay(),
   .o_adc_clk_en_width(),
   .o_adc_clk_en_delay(),
   .o_adc_mux_en_width(),
   .o_adc_mux_en_delay(),
  // .o_p2s_sys_config_(),
   .o_p2s_sys_config_wait_count( ), 
   .o_p2s_sys_config_parity_bit( ),
   .o_p2s_sys_config_stop_bit( ),

   .o_np_fault_det_th1( ),
   .o_np_fault_det_th2( ),
  // .o_np_fault_det_th2_reg1( ),
  // .o_np_fault_det_th2_reg2( ),


 

 //analog output

 .out_channel_config_val()
/*
   .o_channel_0_config_val(),
   .o_channel_1_config_val(),
   .o_channel_2_config_val( ),
   .o_channel_3_config_val( ),
   .o_channel_4_config_val( ),
   .o_channel_5_config_val( ),
   .o_channel_6_config_val( ),
   .o_channel_7_config_val( ),
   .o_channel_8_config_val( ),
   .o_channel_9_config_val( ),
   .o_channel_10_config_val( ),
   .o_channel_11_config_val( ),
   .o_channel_12_config_val( ),
   .o_channel_13_config_val( ),
   .o_channel_14_config_val( ),
   .o_channel_15_config_val( ),
   .o_channel_16_config_val( ),
   .o_channel_17_config_val( ),
   .o_channel_18_config_val( ),
   .o_channel_19_config_val( ),
   .o_channel_20_config_val( ),
   .o_channel_21_config_val( ),
   .o_channel_22_config_val( ),
   .o_channel_23_config_val( ),
   .o_channel_24_config_val( ),
   .o_channel_25_config_val( ),
   .o_channel_26_config_val( ),
   .o_channel_27_config_val( ),
   .o_channel_28_config_val( ),
   .o_channel_29_config_val( ),
   .o_channel_30_config_val( ),
   .o_channel_31_config_val( ),
   .o_channel_32_config_val( ),
   .o_channel_33_config_val( ),
   .o_channel_34_config_val( ),
   .o_channel_35_config_val( ),
   .o_channel_36_config_val( ),
   .o_channel_37_config_val( ),
   .o_channel_38_config_val( ),
   .o_channel_39_config_val( ),
   .o_channel_40_config_val( ),
   .o_channel_41_config_val( ),
   .o_channel_42_config_val( ),
   .o_channel_43_config_val( ),
   .o_channel_44_config_val( ),
   .o_channel_45_config_val( ),
   .o_channel_46_config_val( ),
   .o_channel_47_config_val( ),
   .o_channel_48_config_val( ),
   .o_channel_49_config_val( ),
   .o_channel_50_config_val( ),
   .o_channel_51_config_val( ),
   .o_channel_52_config_val( ),
   .o_channel_53_config_val( ),
   .o_channel_54_config_val( ),
   .o_channel_55_config_val( ),
   .o_channel_56_config_val( ),
   .o_channel_57_config_val( ),
   .o_channel_58_config_val( ),
   .o_channel_59_config_val( ),
   .o_channel_60_config_val( ),
   .o_channel_61_config_val( ),
   .o_channel_62_config_val( ),
   .o_channel_63_config_val()
*/
  
    ); 
 



initial 
begin
       $display("start dumping vcd file\n");
       $vcdplusfile("top_tb.vpd");    
       $vcdpluson (0);
       $vcdplusmemon(0);

end

initial begin
#480000;
//$display($time, "\tERROR: Simulation is HANG!!!\n");
$finish;
end


endmodule


/*
reg sts_wr_en_req;
wire sts_wr_en_ack;
///hand shake for the sts_wr_en
always@(posedge sys_clk or rst_n_r)
 begin
   if(!rst_n_r)
      sts_wr_en_req <=1'b0;
   else if(sts_wr_en_r)
      sts_wr_en_req <=1'b1;
   else if(sts_wr_en_ack)
     sts_wr_en_req <=1'b0;
 end
*/

/*
wire cnt_time_out_high;
wire cnt_time_out_low;
assign cnt_time_out_high = (cnt ==12'h5f0); //     1. for 95 micro seconds of 16mhz =5f0hex ,
assign cnt_time_out_low  = (cnt ==12'h51);  //     5us+1clk of 16mhz is low period =(5.0625 us =81dec=51 hex)

assign drive_sts_reg_wr_en_high =cnt_time_out_low;  //make it high when it reached the low priod limit(6us)
assign drive_sts_reg_wr_en_low = cnt_time_out_high; //make it low when it reaches high period limit(95us)

// drive the status reg enable low for every 95us for the priod of 5us+1clk(5.0625us) of 16 mhz clk
always @(posedge sys_clk or negedge rst_n_r) begin
  if(!rst_n_r) begin
   sts_wr_en_r =1'b0;
  end
  else begin
   if(sts_wr_en_r ==1) begin
    if(drive_sts_reg_wr_en_low) 
     sts_wr_en_r =1'b0;
    else
     sts_wr_en_r =sts_wr_en_r;
   end
   if(sts_wr_en_r ==0) begin
    if(drive_sts_reg_wr_en_high)
      sts_wr_en_r =1'b1;
    else
      sts_wr_en_r =sts_wr_en_r;
   end
 end
end
*/

