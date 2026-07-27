//============================================================================== 
// ----------------------------------------------------------------------------- 
//  Nanochap Electronics Copyright (C) 2014. ALL RIGHTS RESERVED. 
// ----------------------------------------------------------------------------- 
// Module name     : flash_trim_value.v
// Description     : sync the async signal
// ----------------------------------------------------------------------------- 
// Revision History: 
// ----------------------------------------------------------------------------- 
// Revision       Date(xxxx-xx-xx)     Author             Description 
// ----------------------------------------------------------------------------- 
//   1.0          2024-10-22           Zhen Cao           Initial version 
//   1.1          2024-11-19           Daniel Dang        Changed format 
// ----------------------------------------------------------------------------- 
//==============================================================================

module flash_trim_value#(
parameter   NO_I2C_REGS = 21,
parameter   COEFFI_DATA = 28

)(
  //input
     // clk, rst
 input wire       clk,
 input wire       rst_n,
     // data from flash_regs
// input wire [7:0] shadow_regs[7:0],
     // the flag of write trim/value reg
 input wire [7:0] trim_regs[NO_I2C_REGS + COEFFI_DATA -1:0],
 input wire       flash_regload_flg, 
     // the command writes spi_regs,	 
 input wire       spi_regs_wrcmd,
 input wire       spi_ser,
 input wire       spi_cer,
 input wire       spi_nvr,

 input wire       spi_wr_command,
 input wire       unlock_en,
 input wire       spi_rd_command,
 input wire       flash_debug_mode1, 
// input wire       trim_read_en_ack,
     // data write into flash

 input wire                 analog_test_mode,
 input wire                 unlock_gpio,

 output wire       spi_wr_sync,
 output wire       spi_ser_sync,
 output wire       spi_cer_sync,
 output wire       spi_nvr_sync,
 //output wire       write_word_sync,
 //output wire       write_hword_sync,
 //output wire       write_u_hword_sync,
 //output wire       write_l_hword_sync,
 output wire       spi_wr_command_sync,
 output wire       unlock_sync,
 output wire       spi_rd_command_sync,
// output wire       trim_read_en_ack_sync,
 output  wire       flash_debug_mode1_sync, 
 output  wire       atm_unlock_sync,
 output  wire       analog_test_mode_sync,

 output wire [15:0] nf_coeff[23:0],
 output wire [7:0]  default_value_coeff[COEFFI_DATA-1:0],
 output wire [7:0]  default_value_trim [NO_I2C_REGS-1:0],
  //output
     // data to flash_regs

 output wire [7:0] trim_read[NO_I2C_REGS-1:0],
 output wire       FLASH_Reset_Done



);

assign default_value_coeff = {
8'b00111110, 
8'b01000010,
8'b10000111, 
8'b10101110,
8'b10000110, 
8'b01011100,
8'b00111110, 
8'b00110000,
8'b10001000, 
8'b00111101,
8'b10000110, 
8'b00101011,
8'b00111111, 
8'b00011100,
8'b00111111, 
8'b01001011,
8'b10000110, 
8'b01011101,
8'b10000110, 
8'b10000000,
8'b00111111, 
8'b00111001,
8'b10000111, 
8'b10100010,
8'b10000110, 
8'b00001001,
8'b00111111, 
8'b10011111

};

//section1
 assign nf_coeff[0]  = {trim_regs[NO_I2C_REGS+1],trim_regs[NO_I2C_REGS]}; 
 assign nf_coeff[1]  = 16'b0100_0000_0000_0000; 
 assign nf_coeff[2]  = {trim_regs[NO_I2C_REGS+3],trim_regs[NO_I2C_REGS+2]}; 
 assign nf_coeff[3]  = 16'b0100_0000_0000_0000; 
 assign nf_coeff[4]  = {trim_regs[NO_I2C_REGS+5],trim_regs[NO_I2C_REGS+4]}; 
 assign nf_coeff[5]  = {trim_regs[NO_I2C_REGS+7],trim_regs[NO_I2C_REGS+6]}; 
//section2
 assign nf_coeff[6]  = {trim_regs[NO_I2C_REGS+1],trim_regs[NO_I2C_REGS]};
 assign nf_coeff[7]  = 16'b0100_0000_0000_0000; 
 assign nf_coeff[8]  = {trim_regs[NO_I2C_REGS+9],trim_regs[NO_I2C_REGS+8]}; 
 assign nf_coeff[9]  = 16'b0100_0000_0000_0000; 
 assign nf_coeff[10] = {trim_regs[NO_I2C_REGS+11],trim_regs[NO_I2C_REGS+10]}; 
 assign nf_coeff[11] = {trim_regs[NO_I2C_REGS+13],trim_regs[NO_I2C_REGS+12]}; 
//section3
 assign nf_coeff[12] = {trim_regs[NO_I2C_REGS+15],trim_regs[NO_I2C_REGS+14]}; 
 assign nf_coeff[13] = 16'b0100_0000_0000_0000; 
 assign nf_coeff[14] = {trim_regs[NO_I2C_REGS+17],trim_regs[NO_I2C_REGS+16]}; 
 assign nf_coeff[15] = 16'b0100_0000_0000_0000; 
 assign nf_coeff[16] = {trim_regs[NO_I2C_REGS+19],trim_regs[NO_I2C_REGS+18]}; 
 assign nf_coeff[17] = {trim_regs[NO_I2C_REGS+21],trim_regs[NO_I2C_REGS+20]}; 
//section4
 assign nf_coeff[18] = {trim_regs[NO_I2C_REGS+15],trim_regs[NO_I2C_REGS+14]};
 assign nf_coeff[19] = 16'b0100_0000_0000_0000; 
 assign nf_coeff[20] = {trim_regs[NO_I2C_REGS+23],trim_regs[NO_I2C_REGS+22]}; 
 assign nf_coeff[21] = 16'b0100_0000_0000_0000; 
 assign nf_coeff[22] = {trim_regs[NO_I2C_REGS+25],trim_regs[NO_I2C_REGS+24]}; 
 assign nf_coeff[23] = {trim_regs[NO_I2C_REGS+27],trim_regs[NO_I2C_REGS+26]}; 



//`include "flash_param.vh"

//trim

//wire  [7:0] ana_trim_df[NO_I2C_REGS-1:0];


wire spi_wr_sync_temp;
common_sync_bit u_spi_wr_sync(
       .clk(clk),
       .rst_(rst_n),
       .async_in(spi_regs_wrcmd),
       .sync_out(spi_wr_sync_temp)
);

common_pulse_rising u_spi_wr_sync_rising(
.d_in(spi_wr_sync_temp),
.clk(clk),
.rst_(rst_n),
.d_out(spi_wr_sync)

);

common_sync_bit u_unlock_gpio_sync(
       .clk(clk),
       .rst_(rst_n),
       .async_in(unlock_gpio),
       .sync_out(atm_unlock_sync)
);

common_sync_bit u_analog_test_mode_sync(
       .clk(clk),
       .rst_(rst_n),
       .async_in(analog_test_mode),
       .sync_out(analog_test_mode_sync)
);

common_sync_bit u_spi_cer_sync(
       .clk(clk),
       .rst_(rst_n),
       .async_in(spi_cer),
       .sync_out(spi_cer_sync)
);

common_sync_bit u_spi_ser_sync(
       .clk(clk),
       .rst_(rst_n),
       .async_in(spi_ser),
       .sync_out(spi_ser_sync)
);

common_sync_bit u_spi_nvr_sync(
       .clk(clk),
       .rst_(rst_n),
       .async_in(spi_nvr),
       .sync_out(spi_nvr_sync)
);

//common_sync_bit u_write_word_sync(
//       .clk(clk),
//       .rst_(rst_n),
//       .async_in(write_word),
//       .sync_out(write_word_sync)
//);
//
//common_sync_bit u_write_hword_sync(
//       .clk(clk),
//       .rst_(rst_n),
//       .async_in(write_hword),
//       .sync_out(write_hword_sync)
//);
//
//common_sync_bit u_write_u_hword_sync(
//       .clk(clk),
//       .rst_(rst_n),
//       .async_in(write_u_hword),
//       .sync_out(write_u_hword_sync)
//);
//
//common_sync_bit u_write_l_hword_sync(
//       .clk(clk),
//       .rst_(rst_n),
//       .async_in(write_l_hword),
//       .sync_out(write_l_hword_sync)
//);

common_sync_bit u_spi_wr_command_sync(
       .clk(clk),
       .rst_(rst_n),
       .async_in(spi_wr_command),
       .sync_out(spi_wr_command_sync)
);

common_sync_bit  u_unlock_sync (
       .clk(clk),
       .rst_(rst_n),
       .async_in(unlock_en),
       .sync_out(unlock_sync)
       );

common_sync_bit  u_read_sync (
       .clk(clk),
       .rst_(rst_n),
       .async_in(spi_rd_command),
       .sync_out(spi_rd_command_sync)
       );


common_sync_bit  u_flash_debug_mode1_sync (
       .clk(clk),
       .rst_(rst_n),
       .async_in(flash_debug_mode1),
       .sync_out(flash_debug_mode1_sync)
       );


//common_sync_bit  u_trim_read_en_ack_sync (
//       .clk(clk),
//       .rst_(rst_n),
//       .async_in(trim_read_en_ack),
//       .sync_out(trim_read_en_ack_sync)
//       );


assign FLASH_Reset_Done = flash_regload_flg;

assign trim_read = trim_regs[NO_I2C_REGS-1:0];

assign default_value_trim = {
8'h00,
8'h00,8'h00,8'h00,8'h00,8'h00,
8'h00,8'h80,8'h00,8'hC0,8'h01,
8'h04,8'h04,8'h00,8'h00,8'h01,
8'h20,8'h02,8'h40,8'h10,8'h5a};

//genvar i;
//generate
//for(i=0;i<NO_I2C_REGS;i=i+1) begin
//assign ana_trim_df[i] = analog_trim[8*i+7:8*i];
//end
//endgenerate  
endmodule
