//============================================================================== 
// ----------------------------------------------------------------------------- 
//  Nanochap Electronics Copyright (C) 2014. ALL RIGHTS RESERVED. 
// ----------------------------------------------------------------------------- 
// Module name     : flash_regs.v
// Description     : deal with the commands whichs comes from SPI,drive FSM to work
// ----------------------------------------------------------------------------- 
// Revision History: 
// ----------------------------------------------------------------------------- 
// Revision       Date(xxxx-xx-xx)     Author             Description 
// ----------------------------------------------------------------------------- 
//   1.0          2024-10-22           Zhen Cao           Initial version 
//   1.1          2024-11-19           Daniel Dang        Changed format 
// ----------------------------------------------------------------------------- 
//==============================================================================

module flash_regs 
#(parameter NO_I2C_REGS = 16,
  parameter COEFFI_DATA = 28,
  parameter ATM_MDOE    = 5,
  parameter ATM_DATA    = 12
)(
	input rst_n,
	input clk,
	input flash_inf_blk_rd_set_en,
	input flash_inf_blk_wd_set_en,
	input flash_inf_blk_ser_set_en, 
	input flash_inf_blk_cer_set_en, 
	input flash_ip_por_resetn,
	input unlock,
        input rd_addr_add,

	input spi_wr,
        input wire spi_ser,
        input wire spi_cer,
        input wire spi_nvr,
	input [7:0] flash_dout,

        input wire [7:0] default_value_coeff[COEFFI_DATA-1:0],
        input wire [7:0] default_value_trim [NO_I2C_REGS-1:0],
	input wire [7:0] spi_regs [NO_I2C_REGS-1:0],
        input wire  [7:0] spi_data_all,
        input wire  [14:0] spi_addr_all,
        input wire        spi_rd_command,
        input wire        spi_wr_command,
        input wire        flash_debug_mode1,
        output reg [7:0] flash_data_spi,
	output reg [7:0] flash_data_otp,
	output reg [7:0]  trim_regs [NO_I2C_REGS + COEFFI_DATA-1:0],
	output reg [14:0] flash_addr, //only 16 registers needed in this project
	output reg [7:0] rnd_regs,
	output reg [7:0] regs_confen_data,
	output reg [6:0] cunter,
	output wire        reload_rnd,
	output reg flash_en,
	output reg flash_inf_rw,
        output reg wr_working,        
        output reg flash_nvr,
        output wire reload_trim,
        output wire rd_spi,
        output wire enable_reload2,
        output reg  trim_invalid_reload,
        output wire flash_ser_en,             
        output wire flash_cer_en,   
        output reg nvr2_trim_tag,
        output reg confen_valid,

        input  wire                atm_unlock,
        input  wire                analog_test_mode,
        input  wire [ATM_MDOE-1:0] atm_mode,
        input  wire [ATM_DATA-1:0] atm_data,


        output wire flash_regload_flg
);
///////////////////////////////reload from main arry sector0/////////////////////////////
//reg [7:0] trim_regs[9:0];

reg [7:0] reg_confen;
wire trim_tag_valid;
reg nvr2_trim_tag2;
reg nvr2_trim_tag1;
reg rd_addr_add2;
reg rd_addr_add1;

reg enable_reload1;
wire flash_regload_flg1;
wire anatrim_regload_flg;
wire unlock_ready;
wire wr_spi;
reg [2:0] trim_load_cnt;
wire trim_load_valid;
assign flash_regload_flg1 = ((enable_reload1||enable_reload2)^enable_reload1);
assign trim_load_valid =(reload_trim && (flash_addr[7:0]==8'h00) && flash_inf_blk_rd_set_en)? (flash_dout[7:0] == 8'h5a) :1'b0;

assign trim_tag_valid = ((nvr2_trim_tag2 || nvr2_trim_tag1)^nvr2_trim_tag1)? (reg_confen == 8'h5a) : 1'b0;
//wire reload_trim_f;
wire unlock_sync_r,unlock_sync_f;
wire spi_rd_command_sync_r,spi_rd_command_sync_f,spi_wr_command_sync_r;
//wire spi_wr_r,spi_wr_f;

wire spi_ser_r,spi_ser_f;
wire spi_cer_r,spi_cer_f;
wire reload_trim_en_f;
wire reload_rnd_flag;
wire reload_rnd_f;
wire reload_rnd_en;
wire wr_stop_cond;
wire flash_debug_mode1_r;
//ATM
//wire flash_inf_blk_wd_set_en_d1;
wire atm_unlock_r,atm_unlock_f;

assign wr_stop_cond = (flash_addr==NO_I2C_REGS);

integer i;
always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin	
                for(i=0;i<NO_I2C_REGS;i=i+1)begin                   
		trim_regs[i] <= default_value_trim[i];
                end		
                for(i=NO_I2C_REGS;i<NO_I2C_REGS+COEFFI_DATA;i=i+1)begin                   
		trim_regs[i] <= default_value_coeff[i-NO_I2C_REGS];
                end	
//                for(i=0;i<8;i=i+1)begin
		rnd_regs <= 8'hff;
//                end	
                reg_confen  <= 8'h00;
                regs_confen_data<=8'h00;
                wr_working  <= 1'b0;
                flash_data_spi<= 8'h00;
                flash_data_otp <= 8'h00;
		flash_addr <= 15'h0000;
		flash_en <= 1'b0;
		flash_inf_rw <= 1'b0;
                flash_nvr <= 1'b1;
                cunter <= 7'h00;
                enable_reload1 <= 1'b1;
                trim_invalid_reload <= 1'b0;
	end
///////////////a///////////
        else if (nvr2_trim_tag)begin
                        enable_reload1 <= 1'b1;
                if(rd_addr_add) begin
			flash_addr <= 15'h0210;
                        flash_nvr  <= 1'b1;
                end
                else if(rd_addr_add1)begin
 	        	reg_confen <= flash_dout;            
                end

		else if(rd_addr_add2)begin
			        flash_addr <= 15'h0000;
                                flash_nvr  <= 1'b1;
                end
        end   
        else if (confen_valid)begin
               if(rd_addr_add) begin
			flash_addr <= {8'h04,cunter};
                        flash_nvr  <= 1'b1;
                        end

               else if (flash_addr == 15'h0208 & rd_addr_add2)begin
                       flash_addr <= 15'h0000;
                        flash_nvr <= 1'b1;
                        cunter   <= 7'h00;
                       end
               else if(rd_addr_add2) begin
                        flash_addr <= {8'h00,cunter};
	        	reg_confen <= flash_dout;
                        flash_nvr  <= 1'b0;
                        end

               else if (flash_inf_blk_wd_set_en)begin
                       flash_nvr <= 1'b0;
                       regs_confen_data <= reg_confen;
                       cunter <= cunter + 1'b1;
               end
        end  
	else if (reload_trim_en_f) begin //Reading from EEPROM at reset time
	        flash_addr <= 15'h0000;
        end
	else if (reload_trim) begin //Reading from FLASH at reset time
		if(flash_inf_blk_rd_set_en) begin
			trim_regs[cunter] <= flash_dout;			
			if (flash_addr[14:0]< NO_I2C_REGS + COEFFI_DATA) begin
                                cunter    <= cunter + 1'b1;
				flash_addr <= flash_addr + 1'b1;
                        end
	             end 
                else if(flash_addr[14:0]== NO_I2C_REGS  + COEFFI_DATA)begin
 	   	 flash_addr <= 15'h0000;
                 cunter    <= 7'h00;
                 flash_nvr <= 1'b0;
                 enable_reload1 <= 1'b0;
                end
                else if(trim_load_cnt == 3'b111)begin
 		 flash_addr <= 15'h0000;
                 cunter    <= 7'h00;
                 flash_nvr <= 1'b0;
                 enable_reload1 <= 1'b0;
                 trim_invalid_reload <= 1'b1;
                end
	end
	else if (reload_rnd_en) begin //Reading from FLASH at reset time
	        flash_addr <= 15'h03ff;
                flash_nvr <= 1'b1;
        end
	else if (reload_rnd) begin 
		if(flash_inf_blk_rd_set_en) begin
			rnd_regs <= flash_dout;
			if (flash_addr[14:0] > 15'h03fe) begin
                                cunter    <= cunter + 1'b1;
				flash_addr <= flash_addr - 1'b1;
                        end
	             end 
                else if(flash_addr[14:0]== 15'h03fe)begin
 	   	 flash_addr <= 15'h0000;
                 cunter    <= 7'h00;
                 flash_nvr <= 1'b0;
                 enable_reload1 <= 1'b0;
                end
	end
        else if(spi_wr)begin
            for(i=0;i<NO_I2C_REGS;i=i+1)begin                   
               trim_regs[i] <= spi_regs[i];
            end
        end
        else if(flash_debug_mode1_r)begin
               trim_regs[spi_addr_all[7:0]] <= spi_data_all;
        end
        else if(analog_test_mode & !atm_unlock)begin
                 trim_regs[0] <= 8'h5a;
            for(i=0;i<ATM_MDOE;i=i+1)begin 
               if(atm_mode[i])begin                  
                 trim_regs[i+1] <= atm_data;
               end
            end
        end
        else if(rd_spi & reload_rnd_flag) begin

	          	if(flash_inf_blk_rd_set_en) begin
			 flash_data_spi <= flash_dout;
                         flash_nvr  <=1'b0;
                         wr_working  <= 1'b1;         	                  
                        end
 		        else begin
                         flash_addr <= spi_addr_all;  
                                  if(spi_nvr) 
                                  flash_nvr  <=1'b1;
                                  else 
                                  flash_nvr  <=1'b0;
                        end

        end
        else if(wr_spi & reload_rnd_flag)begin
     		  	if (!flash_inf_rw ) begin   
                          wr_working  <= 1'b1;         
 		          flash_addr <= spi_addr_all;                          
     			  flash_en <= 1'b1;
    			  flash_inf_rw <= 1'b1;
                          flash_data_otp <= spi_data_all;
                                   if(spi_nvr) 
                                   flash_nvr  <=1'b1;
                                   else 
                                   flash_nvr  <=1'b0;
                        end
                        else if(flash_inf_blk_wd_set_en) begin            
    			  flash_inf_rw <= 1'b0;
    			  flash_en <= 0;
                          wr_working  <= 1'b0;     
                          flash_nvr  <=1'b0;    
                        end
        end
   	else begin
		if (unlock_ready) begin //Programming FLASH
                        flash_nvr <= 1'b1;
			if (wr_stop_cond) begin
					flash_addr <= 15'h0000;
					flash_en <= 0;
                                        wr_working  <= 1'b0;         
                                        cunter    <= 7'b0;
			end
			else if (!flash_inf_rw) begin
				flash_en <= 1'b1;
				flash_inf_rw <= 1'b1;
                                wr_working  <= 1'b1;         
			end
			else if (flash_inf_blk_wd_set_en) begin
				flash_inf_rw <= 1'b0;
				flash_addr <= flash_addr + 1'b1;
	 	                trim_regs[cunter]<=spi_regs[cunter];
                                cunter    <= cunter + 1'b1;
				flash_en <= 0;
			end
		end
                else if (flash_ser_en & reload_rnd_flag) begin
                               if(flash_inf_blk_ser_set_en) begin
					flash_addr <= 15'h0000;
                                        flash_nvr  <=1'b0;
                                        wr_working  <= 1'b0;         
                               end
                               else begin
                                        wr_working  <= 1'b1;         
					flash_addr <= spi_addr_all;
                                          if(spi_nvr) 
                                          flash_nvr  <=1'b1;
                                          else 
                                          flash_nvr  <=1'b0;
                               end
                end
                else if (flash_cer_en) begin	        
                               if(flash_inf_blk_cer_set_en) begin					
	        	                flash_addr <= 15'h0000;
                                        flash_nvr  <=1'b0;
                                        wr_working  <= 1'b0;         
                               end
                               else begin
					flash_addr <= spi_addr_all;
                                        wr_working  <= 1'b1;         					
                                          if(spi_nvr) 
                                          flash_nvr  <=1'b1;
                                          else 
                                          flash_nvr  <=1'b0;
                               end
                end
                else if (unlock_sync_f /*| spi_wr_f*/ | spi_ser_f | spi_cer_f | spi_rd_command_sync_f)begin
					flash_addr <= 15'h0000;
					flash_en <= 1'b0;
                                        flash_nvr <= 1'b0;        
                                        wr_working <=1'b0;
                                        cunter    <= 7'b0;
               end

	end
end

/////////////////////////////////////////reload from nvr2 (the first 8 bytes)/////////////////////////////////
////CONFEN RELOAD////
reg [1:0] mode_cunter;
reg mode_flag;
always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
         mode_cunter<=2'b00;
        end
        else if(mode_flag)begin
        mode_cunter <=mode_cunter + 1'b1;
        end
        else begin
        mode_cunter <=2'b00;
        end
end

reg nvr2_trim_tag_lock;

always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
        nvr2_trim_tag_lock <= 1'b0;
        end
        else if(nvr2_trim_tag) begin
        nvr2_trim_tag_lock <= 1'b1;        
        end
end

always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
        nvr2_trim_tag <=1'b0;
        nvr2_trim_tag1 <=1'b0;
        nvr2_trim_tag2 <=1'b0;
        mode_flag      <= 1'b0;
        end
        else if(!nvr2_trim_tag & !nvr2_trim_tag_lock & flash_ip_por_resetn) begin
        nvr2_trim_tag <=1'b1;
        end
        else if (mode_cunter == 2'b11)begin
               mode_flag      <= 1'b0;
        end
        else begin
         nvr2_trim_tag1 <=nvr2_trim_tag;
         nvr2_trim_tag2 <=nvr2_trim_tag1;
          if (nvr2_trim_tag && flash_inf_blk_rd_set_en)begin
               nvr2_trim_tag <=1'b0;
               mode_flag      <= 1'b1;
          end
        end
end

always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
        confen_valid <=1'b0;
        end
        else if(trim_tag_valid)begin
        confen_valid <=1'b1;
        end
        else if (confen_valid && (flash_addr == 15'h0208) && rd_addr_add2)begin
        confen_valid <=1'b0;
        end
end

always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
        rd_addr_add1 <=1'b0;
        rd_addr_add2 <=1'b0;
        end
        else begin
        rd_addr_add1 <=rd_addr_add;
        rd_addr_add2 <=rd_addr_add1;
        end
end

wire recall_done;
assign recall_done = ((confen_valid && (flash_addr == 15'h0208) && rd_addr_add2) || (~confen_valid && ( mode_cunter == 2'b11)));

////TRIM RELOAD////
always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
        trim_load_cnt<=3'b000;
        end
        else if(reload_trim && ~anatrim_regload_flg) begin
        trim_load_cnt <= trim_load_cnt + 1'b1;
        end
        else begin
        trim_load_cnt<=3'b000;
        end
end

wire reload_trim_en;
wire reload_trim_lock_en;
reg  reload_trim_en_lock;
assign reload_trim_lock_en = !reload_trim;
assign reload_trim_en = !reload_trim_en_lock & reload_trim_lock_en;

always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
        reload_trim_en_lock <= 1'b0;
        end
        else if(reload_trim_lock_en & recall_done) begin
        reload_trim_en_lock <= 1'b1;        
        end
end

common_pulse_falling u_spi_reload_trim_en_falling(
.d_in(reload_trim_en),
.clk(clk),
.rst_(rst_n),
.d_out(reload_trim_en_f)

);

wire [2:0] reload_trim_in;
assign reload_trim_in = {trim_load_cnt == 3'b111,reload_trim && (flash_addr == NO_I2C_REGS + COEFFI_DATA),reload_trim_en_f};
common_reg_cond3 #(
.RST_VAL(1'b0),
.COND_VALUE(3'b001)
)u_reload_trim(
.clk(clk),
.rst_(rst_n),
.cond_in(reload_trim_in),
.d_out(reload_trim)
);

wire reload_trim_f;
common_pulse_falling u_spi_reload_trim_falling(
.d_in(reload_trim),
.clk(clk),
.rst_(rst_n),
.d_out(reload_trim_f)

);


////RND RELOAD////
common_reg_cond1 #(
.COND_VALUE(1'b1)
)u_reload_rnd_flag(
.clk(clk),
.rst_(rst_n),
.cond_in(reload_rnd_f),
.d_out(reload_rnd_flag)
);

common_pulse_falling u_reload_rnd_en_falling(
.d_in(reload_rnd),
.clk(clk),
.rst_(rst_n),
.d_out(reload_rnd_f)
);

wire [1:0] reload_rnd_in;
assign reload_rnd_en = (reload_trim_f & !reload_rnd_flag);

assign reload_rnd_in = {reload_rnd & (flash_addr == 15'h03fe),reload_rnd_en};
common_reg_cond2 #(
.COND_VALUE(2'b01)
)u_reload_rnd(
.clk(clk),
.rst_(rst_n),
.cond_in(reload_rnd_in),
.d_out(reload_rnd)
);



common_clock_d1 u_enable_reload1(
.d_in(enable_reload1),
.clk(clk),
.rst_(rst_n),
.d_out(enable_reload2)

);

wire [2:0] flash_regload_flg_in;
assign flash_regload_flg_in = {flash_regload_flg1 & anatrim_regload_flg,2'b00};
common_reg_cond3 #(
.COND_VALUE(3'b110)
)u_flash_regload_flg(
.clk(clk),
.rst_(rst_n),
.cond_in(flash_regload_flg_in),
.d_out(flash_regload_flg)
);


common_reg_cond1 #(
.COND_VALUE(1'b1)
)u_trim_load_valid(
.clk(clk),
.rst_(rst_n),
.cond_in(trim_load_valid),
.d_out(anatrim_regload_flg)
);

wire [1:0] rd_spi_in;
assign rd_spi_in = {rd_spi && flash_inf_blk_rd_set_en,spi_rd_command_sync_r};
common_reg_cond2 #(
.COND_VALUE(2'b01)
)u_rd_spi(
.clk(clk),
.rst_(rst_n),
.cond_in(rd_spi_in),
.d_out(rd_spi)
);

wire [1:0] wr_spi_in;
assign wr_spi_in = {wr_spi && flash_inf_blk_wd_set_en,spi_wr_command_sync_r};
common_reg_cond2 #(
.COND_VALUE(2'b01)
)u_wr_spi(
.clk(clk),
.rst_(rst_n),
.cond_in(wr_spi_in),
.d_out(wr_spi)
);

wire [2:0] unlock_ready_in;
wire [2:0] unlock_ready_spi;
wire [2:0] unlock_ready_cp;

assign unlock_ready_spi = {unlock_sync_f,unlock_ready && flash_addr==NO_I2C_REGS,unlock_sync_r};
assign unlock_ready_cp  = {atm_unlock_f,unlock_ready &&  flash_addr==NO_I2C_REGS,atm_unlock_r};
assign unlock_ready_in  = analog_test_mode? unlock_ready_cp : unlock_ready_spi;
common_reg_cond3 #(
.COND_VALUE(3'b001)
)u_unlock_ready(
.clk(clk),
.rst_(rst_n),
.cond_in(unlock_ready_in),
.d_out(unlock_ready)
);



wire [2:0] flash_ser_in;
assign flash_ser_in = {spi_ser_f,flash_ser_en && flash_inf_blk_ser_set_en,spi_ser_r};
common_reg_cond3 #(
.COND_VALUE(3'b001)
)u_flash_ser(
.clk(clk),
.rst_(rst_n),
.cond_in(flash_ser_in),
.d_out(flash_ser_en)
);

wire [2:0] flash_cer_in;
assign flash_cer_in = {spi_cer_f,flash_cer_en && flash_inf_blk_cer_set_en,spi_cer_r};
common_reg_cond3 #(
.COND_VALUE(3'b001)
)u_flash_cer(
.clk(clk),
.rst_(rst_n),
.cond_in(flash_cer_in),
.d_out(flash_cer_en)
);

common_pulse_edge u_unlock_sync_edge(
.d_in(unlock),
.clk(clk),
.rst_(rst_n),
.d_out_r(unlock_sync_r),
.d_out_f(unlock_sync_f)

);

//common_pulse_edge u_spi_wr_edge(
//.d_in(spi_wr),
//.clk(clk),
//.rst_(rst_n),
//.d_out_r(spi_wr_r),
//.d_out_f(spi_wr_f)
//);

common_pulse_edge u_atm_unlock_edge(
.d_in(atm_unlock),
.clk(clk),
.rst_(rst_n),
.d_out_r(atm_unlock_r),
.d_out_f(atm_unlock_f)

); 

common_pulse_edge u_spi_ser_edge(
.d_in(spi_ser),
.clk(clk),
.rst_(rst_n),
.d_out_r(spi_ser_r),
.d_out_f(spi_ser_f)

); 

common_pulse_edge u_spi_cer_edge(
.d_in(spi_cer),
.clk(clk),
.rst_(rst_n),
.d_out_r(spi_cer_r),
.d_out_f(spi_cer_f)
); 

common_pulse_edge u_spi_rd_command_sync_edge(
.d_in(spi_rd_command),
.clk(clk),
.rst_(rst_n),
.d_out_r(spi_rd_command_sync_r),
.d_out_f(spi_rd_command_sync_f)

);

common_pulse_rising u_spi_wr_command_sync_rising(
.d_in(spi_wr_command),
.clk(clk),
.rst_(rst_n),
.d_out(spi_wr_command_sync_r)

);

common_pulse_rising u_flash_debug_mode1_sync_rising(
.d_in(flash_debug_mode1),
.clk(clk),
.rst_(rst_n),
.d_out(flash_debug_mode1_r)

);

//common_pulse_falling u_reload_trim_falling(
//.d_in(reload_trim),
//.clk(clk),
//.rst_(rst_n),
//.d_out(reload_trim_f)

//);

//common_clock_d1 u_flash_inf_blk_wd_set_en_d1(
//.d_in(flash_inf_blk_wd_set_en),
//.clk(clk),
//.rst_(rst_n),
//.d_out(flash_inf_blk_wd_set_en_d1)

//);



endmodule
