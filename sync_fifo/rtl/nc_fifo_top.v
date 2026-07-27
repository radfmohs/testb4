//------------------------------------------------------------------------------
// Nanochap Pty Ltd (c) 2022
//
// Module Name : nc_fifo_top
// Description : SYNC FIFO TOP
//------------------------------------------------------------------------------
// Revision History
//------------------------------------------------------------------------------
// Revision     Date        Author
//------------------------------------------------------------------------------
// 0.1          10/09/2022  Duong Dang
// Initial Rev
//------------------------------------------------------------------------------
module nc_fifo_top(
    // clock and reset 
    clk,
    rst_n,

    atpg_en,
    scan_en,

    // FiFO configuration inputs
    fifo_config_a,

    fifo_a_empty_level_a,
    fifo_a_full_level_a,

    fifo_full_sts_clr_a,
    fifo_empty_sts_clr_a,
    fifo_a_full_sts_clr_a,
    fifo_a_empty_sts_clr_a,
    fifo_error_sts_clr_a,
    
    // Read/Write Interface
    fifo_wr_req_n,
    fifo_rd_req_n,
    fifo_data_i,

    fifo_data_o,

    // FIFO Status Outputs
    fifo_half_full,
    fifo_a_empty,
    fifo_a_full,
    fifo_empty,
    fifo_full,
    fifo_error,
    fifo_intr,
    fifo_rd_pntr,
    fifo_wr_pntr,
    fifo_data_cnt,
    fifo_ovf_cnt
);

  parameter FIFO_WIDTH      = 18;   
  parameter FIFO_DEPTH      = 256;  
  parameter FIFO_ERROR_MODE = 0;   
  parameter FIFO_RESET_MODE = 0;    
  parameter FIFO_ADDR_WIDTH = 8;

  input                          clk;                 // FIFO clock input
  input                          rst_n;               // FIFO asynchronous reset input 
  input				 atpg_en;	      // atpg mode
  input				 scan_en;	      // scan mode
 
  input  [7:0]                   fifo_config_a;       // FIFO Config 
  input  [7:0]   fifo_a_empty_level_a;// FIFO empty level configuration 
  input  [7:0]   fifo_a_full_level_a; // FIFO full level configuration

  input                          fifo_full_sts_clr_a; // FIFO Full Status Clear
  input                          fifo_empty_sts_clr_a;// FIFO Empty Status Clear
  input                          fifo_a_full_sts_clr_a;// FIFO Almost Full Status Clear
  input                          fifo_a_empty_sts_clr_a;// FIFO Almost Empty Status Clear
  input                          fifo_error_sts_clr_a;// FIFO Error Status Clear
  
  input                          fifo_wr_req_n;       // FIFO write request
  input                          fifo_rd_req_n;       // FIFO read request
  input  [FIFO_WIDTH-1 : 0]      fifo_data_i;         // FIFO write data bus
  
  output [FIFO_WIDTH-1 : 0]      fifo_data_o;         // FIFO read data bus
  output                         fifo_half_full;      // FIFO half full status
  output                         fifo_a_full;         // FIFO almost full status
  output                         fifo_full;           // FIFO full status
  output                         fifo_empty;          // FIFO empty status
  output                         fifo_a_empty;        // FIFO almost empty status
  output                         fifo_error;          // FIFO error status
  output                         fifo_intr;           // FIFO interrupt pin
  output [FIFO_ADDR_WIDTH-1:0]   fifo_rd_pntr;        // FIFO read pointer
  output [FIFO_ADDR_WIDTH-1:0]   fifo_wr_pntr;        // FIFO read pointer
  output [FIFO_ADDR_WIDTH:0]     fifo_data_cnt;       // FIFO data count
  output [FIFO_ADDR_WIDTH-1:0]   fifo_ovf_cnt;        // FIFO lost item counter   
  

  // Internal signals
  wire                           mem_async_rst_n;         
  wire                           mem_sync_rst_n;
  
  wire   [FIFO_ADDR_WIDTH-1 : 0] mem_rd_addr;
  wire   [FIFO_ADDR_WIDTH-1 : 0] mem_wr_addr;
  wire                           mem_we_n;

  wire                           fifo_flush_n_sync;
  wire                           fifo_roll_sync;
  wire    [7:0]                  fifo_a_full_level_sync;
  wire    [7:0]                  fifo_a_empty_level_sync;


//fifo_flush_n
common_sync_bit  //common_bit_sync 
 #(
.RST_VAL(0))
 u_fifo_flush_n_sync (
       .clk(clk),
       .rst_(rst_n),
       .async_in(~fifo_config_a[0]),
       .sync_out(fifo_flush_n_sync)
       );

//fifo_roll
common_sync_bit  //common_bit_sync 
 #(
.RST_VAL(0))
 u_fifo_roll_sync (
       .clk(clk),
       .rst_(rst_n),
       .async_in(fifo_config_a[1]),
       .sync_out(fifo_roll_sync)
       );

// fifo_a_full_level[7:0]
common_sync_bit  
 #(
.RST_VAL(0))
 u_fifo_a_full_level_sync [7:0](
       .clk(clk),
       .rst_(rst_n),
       .async_in(fifo_a_full_level_a),
       .sync_out(fifo_a_full_level_sync)
       );

// fifo_a_empty_level[7:0]
common_sync_bit  
 #(
.RST_VAL(0))
 u_fifo_a_empty_level_sync [7:0](
       .clk(clk),
       .rst_(rst_n),
       .async_in(fifo_a_empty_level_a),
       .sync_out(fifo_a_empty_level_sync)
       );

// Gated clock
wire gated_mem_clk;
wire clk_enable;
reg  mem_we_n_ff;

always @ (posedge clk or negedge rst_n) 
  begin
    if (!rst_n)
      mem_we_n_ff <= 1'b1;
    else
      mem_we_n_ff <= mem_we_n;
  end

assign clk_enable = !(mem_we_n && mem_we_n_ff);

common_clock_gate u_cmsdk_clock_gate_fifo_clk_mem (
.clk        (clk),
.enable     (clk_enable),
.bypass     (scan_en),
.gated_clk  (gated_mem_clk));

// Support reset modes for mem 
generate
  if (FIFO_RESET_MODE == 0) begin : GEN_MEM_RST_RM0
    assign mem_async_rst_n = rst_n;
    assign mem_sync_rst_n  = fifo_flush_n_sync;
  end else begin : GEN_MEM_RST_RM_NE_0
    assign mem_async_rst_n = 1'b1;
    assign mem_sync_rst_n  = 1'b1;
  end
endgenerate
  
  // Instantiate FIFO Controller
  nc_fifo_ctrl 
  #(FIFO_DEPTH, FIFO_ERROR_MODE, FIFO_ADDR_WIDTH) fifo_cntl_inst(
    .clk(clk),
    .rst_n(rst_n),
    .atpg_en(atpg_en),

    // Config Register
    .fifo_error_intr_en_a(fifo_config_a[7]),
    .fifo_a_empty_intr_en_a(fifo_config_a[6]),
    .fifo_a_full_intr_en_a(fifo_config_a[5]),
    .fifo_empty_intr_en_a(fifo_config_a[4]),
    .fifo_full_intr_en_a(fifo_config_a[3]),
    .fifo_roll(fifo_roll_sync),
    .fifo_flush_n(fifo_flush_n_sync),

    .fifo_full_sts_clr_a(fifo_full_sts_clr_a),
    .fifo_empty_sts_clr_a(fifo_empty_sts_clr_a),
    .fifo_a_full_sts_clr_a(fifo_a_full_sts_clr_a),
    .fifo_a_empty_sts_clr_a(fifo_a_empty_sts_clr_a),
    .fifo_error_sts_clr_a(fifo_error_sts_clr_a),

    .fifo_wr_req_n(fifo_wr_req_n),
    .fifo_rd_req_n_a(fifo_rd_req_n),
    .fifo_a_empty_level(fifo_a_empty_level_sync),
    .fifo_a_full_level(fifo_a_full_level_sync),
    .we_n(mem_we_n),
    .fifo_empty(fifo_empty),
    .fifo_a_empty(fifo_a_empty),
    .fifo_half_full(fifo_half_full),
    .fifo_a_full(fifo_a_full),
    .fifo_full(fifo_full),
    .fifo_error(fifo_error),
    .fifo_intr(fifo_intr),
    .wr_addr(mem_wr_addr),
    .rd_addr(mem_rd_addr),
    .data_word_count(fifo_data_cnt),
    .lost_item_count(fifo_ovf_cnt)
    //.fifo_next_empty_n(),
    //.fifo_next_full(),
    //.fifo_next_error()
  );
    
  nc_fifo_mem 
  #(FIFO_WIDTH, FIFO_DEPTH, 0, FIFO_ADDR_WIDTH) fifo_mem_inst( 
    .clk(gated_mem_clk),
    .rst_n(mem_async_rst_n),

    .fifo_flush_n(mem_sync_rst_n),                                     
    .wr_n(mem_we_n),
    //.wr_n(mem_we_n_ff),
    .rd_addr(mem_rd_addr),
    .wr_addr(mem_wr_addr),
    .fifo_data_i(fifo_data_i),
    .fifo_data_o(fifo_data_o)
  );

  assign fifo_wr_pntr = mem_wr_addr;
  assign fifo_rd_pntr = mem_rd_addr;

endmodule

