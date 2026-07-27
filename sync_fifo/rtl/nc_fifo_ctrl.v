//------------------------------------------------------------------------------
// Nanochap Pty Ltd (c) 2022
//
// Module Name : nc_fifo_ctrl
// Description : FIFO Controller
//------------------------------------------------------------------------------
// Revision History
//------------------------------------------------------------------------------
// Revision     Date        Author
//------------------------------------------------------------------------------
// 0.1          10/09/2022  Duong Dang
// Initial Rev
//------------------------------------------------------------------------------
`define SYNC_READ
module nc_fifo_ctrl (
    clk,
    rst_n,
    atpg_en,

    // FIFO control signals
    fifo_flush_n,
    fifo_roll,
    fifo_a_empty_level,
    fifo_a_full_level,
    
    fifo_wr_req_n,
    fifo_rd_req_n_a,

    fifo_full_intr_en_a,
    fifo_empty_intr_en_a,
    fifo_a_full_intr_en_a,
    fifo_a_empty_intr_en_a,
    fifo_error_intr_en_a,

    fifo_full_sts_clr_a,
    fifo_empty_sts_clr_a,
    fifo_a_full_sts_clr_a,
    fifo_a_empty_sts_clr_a,
    fifo_error_sts_clr_a,

    
    // FIFO status signals
    fifo_empty,
    fifo_a_empty,
    fifo_half_full,
    fifo_a_full,
    fifo_full,
    fifo_error,
    fifo_intr,
    
    // mem control signal interface
    we_n,
    wr_addr,
    rd_addr,
    
    // data count
    data_word_count,
    lost_item_count
    
    // Some status
    //fifo_next_empty_n,
    //fifo_next_full,
    //fifo_next_error
    );

parameter FIFO_DEPTH = 256;
parameter FIFO_ERROR_MODE = 0;      
parameter FIFO_ADDR_WIDTH = 8; 
  
input                        clk;            
input                        rst_n;
input			     atpg_en;
    
input                        fifo_flush_n;
input                        fifo_roll;             
input  [7:0]                 fifo_a_empty_level;       
input  [7:0]                 fifo_a_full_level;

input                        fifo_wr_req_n;     
input                        fifo_rd_req_n_a;

input                        fifo_full_intr_en_a;
input                        fifo_empty_intr_en_a;
input                        fifo_a_full_intr_en_a;
input                        fifo_a_empty_intr_en_a;
input                        fifo_error_intr_en_a;

input                        fifo_full_sts_clr_a;
input                        fifo_empty_sts_clr_a;
input                        fifo_a_full_sts_clr_a;
input                        fifo_a_empty_sts_clr_a;
input                        fifo_error_sts_clr_a;
                
output                       fifo_empty;          
output                       fifo_a_empty;   
output                       fifo_half_full;      
output                       fifo_a_full;    
output                       fifo_full;          
output                       fifo_error;
output                       fifo_intr;

output                       we_n;         
output [FIFO_ADDR_WIDTH-1:0] wr_addr;        
output [FIFO_ADDR_WIDTH-1:0] rd_addr;        
output [FIFO_ADDR_WIDTH:0]   data_word_count;      
output reg [FIFO_ADDR_WIDTH-1:0] lost_item_count;

wire                         fifo_next_empty_n;    
wire                         fifo_next_full;       
wire                         fifo_next_error;
  
wire                         next_empty_n;
reg                          empty_n;
wire                         next_a_empty_n;
reg                          a_empty_n;
wire                         next_half_full;
reg                          half_full_local;
wire                         next_a_full;
reg                          a_full_local;
wire                         next_full;
reg                          full_local;
wire                         next_fifo_error;
reg                          error_local;
wire [FIFO_ADDR_WIDTH-1:0]   next_wr_addr;
reg  [FIFO_ADDR_WIDTH-1:0]   wr_addr_local;
wire                         next_wr_addr_at_max;
reg                          wr_addr_at_max;
wire [FIFO_ADDR_WIDTH-1:0]   next_rd_addr;
reg  [FIFO_ADDR_WIDTH-1:0]   rd_addr_local;
wire                         next_rd_addr_at_max;
reg                          rd_addr_at_max;
wire [FIFO_ADDR_WIDTH:0]     next_word_count;
reg  [FIFO_ADDR_WIDTH:0]     word_count;
reg  [FIFO_ADDR_WIDTH+1:0]   updated_word_count;

wire                         wr_addr_changed;
wire [FIFO_ADDR_WIDTH+1:0]   advanced_wr_addr;
wire                         rd_addr_changed;
wire [FIFO_ADDR_WIDTH+1:0]   advanced_rd_addr;
wire                         inc_word_count;
wire                         dec_word_count;

wire                         full_int_rstn_a;
wire                         empty_int_rstn_a;
wire                         a_full_int_rstn_a;
wire                         a_empty_int_rstn_a;
wire                         error_int_rstn_a;

reg                          full_sts;
reg                          a_full_sts;
reg                          empty_sts;
reg                          a_empty_sts;
reg                          error_sts;

wire                         next_fifo_intr;
reg                          fifo_intr_local;

wire                         fifo_rd_req_n;

localparam [FIFO_ADDR_WIDTH-1 : 0] END_ADDR       =  FIFO_DEPTH - 1;
localparam [FIFO_ADDR_WIDTH-1 : 0] HALF_FIFO_SIZE = (FIFO_DEPTH + 1)/2;

`ifndef SYNC_READ
reg                          detect_fifo_read;
reg                          fifo_rd_req_n_local;
reg    [2:0]                 pulse_cnt;
//Original
always @(posedge clk or negedge rst_n)
  begin
    if (!rst_n)
      fifo_rd_req_n_local <= 1'b1;
    else if (detect_fifo_read)
      fifo_rd_req_n_local <= 1'b0;
    else
      fifo_rd_req_n_local<=1'b1;
  end

always @(posedge clk or negedge rst_n)
  begin
    if (!rst_n)
      pulse_cnt <= 2'b00;
    else if (!fifo_rd_req_n_local)
      pulse_cnt <= 2'b00;
    else if (pulse_cnt==2'b11)
      pulse_cnt <= pulse_cnt;
    else if (detect_fifo_read)
      pulse_cnt <= pulse_cnt+1;
    else
       pulse_cnt <= pulse_cnt;
  end

wire int_read_rst_n = atpg_en ? rst_n : rst_n & fifo_rd_req_n_a;
always @(posedge clk or negedge int_read_rst_n)
  begin
    if (!int_read_rst_n)
      detect_fifo_read <= 1'b1;
    else if(detect_fifo_read)
      detect_fifo_read <= 1'b0;
    else
     detect_fifo_read<=detect_fifo_read;
  end

  // Write Enable to MEM
  assign fifo_rd_req_n  = ~(!fifo_rd_req_n_local & (pulse_cnt == 2'b01));//fifo_rd_req_n_sync | ~fifo_rd_req_n_sync_ff;
`else
// New fix
  // reg fifo_read_req_en;
  // always @(posedge spi_clk or negedge spi_rst_n)
  //   if (!rst_n)
  //     pulse_cnt <= 3'b000;
  //   else if (!fifo_read_req_en)
  //     pulse_cnt <= 3'b000;
  //   else
  //     pulse_cnt <= pulse_cnt+1;

  // wire spi_rst_n = rst_n & !i_cs_n;
  // // Creating new read_req_en
  // always @(posedge spi_clk or negedge spi_rst_n)
  //   if (!spi_rst_n)
  //     fifo_read_req_en <= 1'b0;
  //   else if (i_cs_n)
  //     fifo_read_req_en <= 1'b0;
  //   else if (fifo_rd_req_n_a == 1'b0)
  //     fifo_read_req_en <= 1'b1;
  //   else if (pulse_cnt == 3'b100)
  //     fifo_read_req_en <= 1'b0;
  //   else
  //     fifo_read_req_en <= fifo_read_req_en;

  // fifo_read_req_en_sync
  wire fifo_rd_req;
  wire fifo_read_req_en_sync;
  assign fifo_rd_req = ~fifo_rd_req_n_a;
  common_sync_bit  //common_bit_sync 
  #(.RST_VAL(0))
  u_fifo_flush_n_sync (
       .clk(clk),
       .rst_(rst_n),
       .async_in(fifo_rd_req),
       .sync_out(fifo_read_req_en_sync)
  );

  // Rising edge detection
  reg fifo_read_req_en_sync_ff;
  always @(posedge clk or negedge rst_n)
    if (!rst_n)
      fifo_read_req_en_sync_ff <= 1'b0;
    else 
      fifo_read_req_en_sync_ff <= fifo_read_req_en_sync;

  assign fifo_rd_req_n  = ~(fifo_read_req_en_sync && !fifo_read_req_en_sync_ff);
`endif

  // Calculate WRITE ADDRESS of next time
  // Write Enable is asserted when request write + (fifo is not full OR fifo is full but read at the same time)   
  assign we_n = fifo_roll ? fifo_wr_req_n : fifo_wr_req_n | (full_local & fifo_rd_req_n); 
  // Create signal to detect write address to be changed
  assign wr_addr_changed = ~we_n;
  // if wr_addr_changed = 1, wr_addr_local will be increased, else wr_addr_local will keep the old one
  assign advanced_wr_addr = ({wr_addr_local, wr_addr_changed} + 1'b1);
  // if wr_addr_changed = 1 and wr_addr_at_max = 1 (full), next addr will be 0
  // if wr_addr_changed = 1 and wr_addr_at_max = 0 (full), next addr will be wr_addr_local
  //assign next_wr_addr = ((wr_addr_at_max | (fifo_roll & full_local)) & wr_addr_changed) ? {FIFO_ADDR_WIDTH{1'b0}} : advanced_wr_addr[FIFO_ADDR_WIDTH:1];
  assign next_wr_addr = (wr_addr_at_max & wr_addr_changed) ? {FIFO_ADDR_WIDTH{1'b0}} : advanced_wr_addr[FIFO_ADDR_WIDTH:1];
 
  // Calculate READ ADDRESS of next time
  // Create signal to detect read address to be changed
  assign rd_addr_changed = ~fifo_rd_req_n  & empty_n;
  // if rd_addr_changed = 1: rd_addr_local will be increased, else rd_addr_local will keep the old one
  assign advanced_rd_addr = ({rd_addr_local, rd_addr_changed} + 1'b1); 
  // if rd_addr_changed = 1 and rd_addr_at_max = 1 (full), next addr will be 0
  // if rd_addr_changed = 1 and rd_addr_at_max = 0 (full), next addr will be rd_addr_local
  assign next_rd_addr =  (rd_addr_at_max & rd_addr_changed)? {FIFO_ADDR_WIDTH{1'b0}} : advanced_rd_addr[FIFO_ADDR_WIDTH:1];
  
  // Create signals to detect read/write address is reached to FIFO_DEPTH - 1, should ROLL address
  assign next_rd_addr_at_max = ((next_rd_addr & END_ADDR) == END_ADDR)? 1'b1 : 1'b0;
  assign next_wr_addr_at_max = ((next_wr_addr & END_ADDR) == END_ADDR)? 1'b1 : 1'b0;

  // Create this to detect increase no of words in FIFO when
  // Write FIFO when there is no read & FIFO is not FULL
  // Or Write FIFO when FIFO is EMPTY
  assign inc_word_count = (~fifo_wr_req_n & fifo_rd_req_n & (~full_local)) | ((~fifo_wr_req_n) & (~empty_n));

  // Create this to decrease no of words in FIFO when READ FIFO with NO WRITE at FIFO is not EMPTY
  assign dec_word_count = fifo_wr_req_n & (~fifo_rd_req_n) & empty_n;
  
  // Calculate word count
  always @ (word_count or dec_word_count) 
    begin
      if (dec_word_count)
        updated_word_count = word_count - 1;
      else
        updated_word_count = word_count + 1;
    end
  assign next_word_count = ((inc_word_count | dec_word_count) == 1'b0)? word_count : updated_word_count[FIFO_ADDR_WIDTH:0];

  // Full conditions:
  // 1- word count is reached to FIFO_DEPTH - 1 and write without read to FIFO
  // 2- No Write/Read while FIFO is fulled
  // 3- FIFO is fulled then continue WRITE
  assign next_full =    ((word_count[FIFO_ADDR_WIDTH-1:0] == END_ADDR)? ~fifo_wr_req_n & fifo_rd_req_n : 1'b0) |
                        (full_local & fifo_wr_req_n & fifo_rd_req_n) |
                        (full_local & (~fifo_wr_req_n));

  // Empty conditions when No of words in FIFO is 0 and same timing with next_full
  assign next_empty_n = (next_word_count[FIFO_ADDR_WIDTH-1:0] == {FIFO_ADDR_WIDTH{1'b0}})? next_full : 1'b1;

  // Half Full conditions
  assign next_half_full = (next_word_count[FIFO_ADDR_WIDTH-1:0] >= HALF_FIFO_SIZE)? 1'b1 : next_full;

generate
  if ((1<<FIFO_ADDR_WIDTH) == FIFO_DEPTH) begin : GEN_PWR2
    assign next_a_empty_n = ~(((next_word_count[FIFO_ADDR_WIDTH-1:0] <= fifo_a_empty_level)? 1'b1 : 1'b0) & (~next_full));
  end else begin : GEN_NOT_PWR2
    assign next_a_empty_n = ~((next_word_count[FIFO_ADDR_WIDTH-1:0] <= fifo_a_empty_level)? 1'b1 : 1'b0);
  end
endgenerate

  // Almost Full conditions
  assign next_a_full = (next_word_count[FIFO_ADDR_WIDTH-1:0] >= fifo_a_full_level)? 1'b1 : next_full;

generate
  if (FIFO_ERROR_MODE == 0) begin : GEN_EM_EQ0
    assign next_fifo_error =  (~fifo_rd_req_n & (~empty_n)) | (~fifo_wr_req_n & fifo_rd_req_n & full_local) |
                         (( |(wr_addr_local ^ rd_addr_local)) ^ (empty_n & (~full_local))) | error_local;
  end
  
  if (FIFO_ERROR_MODE == 1) begin : GEN_EM_EQ1
    assign next_fifo_error = (~fifo_rd_req_n & (~empty_n)) | (~fifo_wr_req_n & fifo_rd_req_n & full_local) | error_local;
  end
  
  if (FIFO_ERROR_MODE == 2) begin : GEN_EM_EQ2
    assign next_fifo_error = (~fifo_rd_req_n & (~empty_n)) | (~fifo_wr_req_n & fifo_rd_req_n & full_local);
  end
endgenerate

  // Counter for couting lost items 
  always @(posedge clk or negedge rst_n)
    begin
      if (~rst_n)
        lost_item_count <= 7'h00;
      else if (~(fifo_rd_req_n & fifo_flush_n))
        lost_item_count <= 7'h00;
      else if (lost_item_count == 7'h7F) 
        lost_item_count <= lost_item_count;
      else if (full_local & !fifo_wr_req_n)
        lost_item_count <= lost_item_count + 1;
      else
        lost_item_count <= lost_item_count;
    end

  // Generate async signals reset here
  assign full_int_rstn_a    = atpg_en ? rst_n : rst_n & (~fifo_full_sts_clr_a);
  assign empty_int_rstn_a   = atpg_en ? rst_n : rst_n & (~fifo_empty_sts_clr_a);
  assign a_full_int_rstn_a  = atpg_en ? rst_n : rst_n & (~fifo_a_full_sts_clr_a);
  assign a_empty_int_rstn_a = atpg_en ? rst_n : rst_n & (~fifo_a_empty_sts_clr_a);
  assign error_int_rstn_a   = atpg_en ? rst_n : rst_n & (~fifo_error_sts_clr_a);

  always @(posedge clk or negedge full_int_rstn_a) begin
    if (~full_int_rstn_a)
      full_sts <= 1'b0;
    else if (!fifo_flush_n)
      full_sts <= 1'b0;
    else if (full_local)
      full_sts <= 1'b1;
    else
      full_sts <= full_sts;
  end

  always @(posedge clk or negedge empty_int_rstn_a) begin
    if (~empty_int_rstn_a)
      empty_sts <= 1'b0;
    else if (!fifo_flush_n)
      empty_sts <= 1'b1;
    else if (~empty_n)
      empty_sts <= 1'b1;
    else
      empty_sts <= empty_sts;
  end

  always @(posedge clk or negedge a_full_int_rstn_a) begin
    if (~a_full_int_rstn_a)
      a_full_sts <= 1'b0;
    else if (!fifo_flush_n)
      a_full_sts <= 1'b0;
    else if (a_full_local)
      a_full_sts <= 1'b1;
    else
      a_full_sts <= a_full_sts;
  end

  always @(posedge clk or negedge a_empty_int_rstn_a) begin
    if (~a_empty_int_rstn_a)
      a_empty_sts <= 1'b0;
    else if (!fifo_flush_n)
      a_empty_sts <= 1'b1;
    else if (~a_empty_n)
      a_empty_sts <= 1'b1;
    else
      a_empty_sts <= a_empty_sts;
  end

  always @(posedge clk or negedge error_int_rstn_a) begin
    if (~error_int_rstn_a)
      error_sts <= 1'b0;
    else if (!fifo_flush_n)
      error_sts <= 1'b0;
    else if (error_local)
      error_sts <= 1'b1;
    else
      error_sts <= error_sts;
  end

  // Generate Interrupt
  assign next_fifo_intr = (full_sts & fifo_full_intr_en_a) | ( empty_sts & fifo_empty_intr_en_a) | 
                          (error_sts &  fifo_error_intr_en_a) | 
                          (a_full_sts & fifo_a_full_intr_en_a) | ( a_empty_sts & fifo_a_empty_intr_en_a);

  // FFs for all signals
  always @ (posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
      empty_n          <=  1'b0;
      a_empty_n        <=  1'b0;
      half_full_local  <=  1'b0;
      a_full_local     <=  1'b0;
      full_local       <=  1'b0;
      error_local      <=  1'b0;
      wr_addr_local    <=  {FIFO_ADDR_WIDTH{1'b0}};
      rd_addr_at_max   <=  1'b0;
      wr_addr_at_max   <=  1'b0;
      rd_addr_local    <=  {FIFO_ADDR_WIDTH{1'b0}};
      word_count       <=  {(FIFO_ADDR_WIDTH+1){1'b0}};
      fifo_intr_local  <=  1'b0; 
    end else if (fifo_flush_n == 1'b0) begin
      empty_n          <=  1'b0;
      a_empty_n        <=  1'b0;
      half_full_local  <=  1'b0;
      a_full_local     <=  1'b0;
      full_local       <=  1'b0;
      error_local      <=  1'b0;
      rd_addr_at_max   <=  1'b0;
      wr_addr_at_max   <=  1'b0;
      wr_addr_local    <=  {FIFO_ADDR_WIDTH{1'b0}};
      rd_addr_local    <=  {FIFO_ADDR_WIDTH{1'b0}};
      word_count       <=  {(FIFO_ADDR_WIDTH+1){1'b0}};
      fifo_intr_local  <=  1'b0; 
    end else begin
      empty_n          <=  next_empty_n;
      a_empty_n        <=  next_a_empty_n;
      half_full_local  <=  next_half_full;
      a_full_local     <=  next_a_full;
      full_local       <=  next_full;
      error_local      <=  next_fifo_error;
      rd_addr_at_max   <=  next_rd_addr_at_max;
      wr_addr_at_max   <=  next_wr_addr_at_max;
      wr_addr_local    <=  next_wr_addr;
      rd_addr_local    <=  next_rd_addr;
      word_count       <=  next_word_count;
      fifo_intr_local  <=  next_fifo_intr; 
    end
  end

  assign fifo_empty        = empty_sts;//~empty_n;
  assign fifo_a_empty      = a_empty_sts; // ~a_empty_n;
  assign fifo_half_full    = half_full_local;
  assign fifo_a_full       = a_full_sts; // a_full_local;
  assign fifo_full         = full_sts;// full_local;
  assign fifo_error        = error_sts; // error_local;
  assign wr_addr           = wr_addr_local;
  assign rd_addr           = rd_addr_local;
  assign data_word_count   = word_count;
  assign fifo_intr         = fifo_intr_local;
  //assign fifo_next_empty_n = next_empty_n | (~fifo_flush_n);
  //assign fifo_next_full    = next_full    &  fifo_flush_n;
  //assign fifo_next_error   = next_fifo_error   &  fifo_flush_n;

endmodule

