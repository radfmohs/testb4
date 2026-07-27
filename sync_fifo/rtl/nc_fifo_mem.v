//------------------------------------------------------------------------------
// Nanochap Pty Ltd (c) 2022
//
// Module Name : nc_fifo_mem
// Description : FIFO MEM
//------------------------------------------------------------------------------
// Revision History
//------------------------------------------------------------------------------
// Revision     Date        Author
//------------------------------------------------------------------------------
// 0.1          10/09/2022  Duong Dang
// Initial Rev
//------------------------------------------------------------------------------
module nc_fifo_mem (
        clk,
        rst_n,

        fifo_flush_n,

        wr_n,
        fifo_data_i,
        wr_addr,
        rd_addr,
        fifo_data_o
        );

   // Parameter declarations
   parameter FIFO_WIDTH = 16;
   parameter FIFO_DEPTH = 256;
   parameter FIFO_MEM_MODE = 0; 
   // ==========================
   // How to use FIFO_MEM_MODE
   // 0: NO DELAY FOR BOTH RD/WR, 
   // 1: DELAY for RD, 
   // 2: DELAY for WR, 
   // 3: DELAY for both RD/WR
   // ==========================
   parameter FIFO_ADDR_WIDTH = 8;

   // Port decalrations
   input                             clk;            // clock input
   input                             rst_n;          // reset
   input                             fifo_flush_n;   // flush fifo with negative active
   input                             wr_n;           // write enable with negative active
   input [FIFO_WIDTH-1:0]            fifo_data_i;    // write data bus
   input [FIFO_ADDR_WIDTH-1:0]       wr_addr;        // address bus for write
   input [FIFO_ADDR_WIDTH-1:0]       rd_addr;        // address bus for read

   output [FIFO_WIDTH-1:0]           fifo_data_o;    // read data bus

  // Internal signal decalration
  reg  [FIFO_WIDTH-1:0]              mem [0 : FIFO_DEPTH-1]; // memory defines

  wire [FIFO_ADDR_WIDTH-1:0]         write_addr;
  wire                               wr_n_local;
  wire                               write_en_n;
  wire [FIFO_WIDTH-1:0]              write_data;
  wire [FIFO_ADDR_WIDTH-1:0]         read_addr;
  wire [FIFO_WIDTH-1:0]              read_data;

  localparam [FIFO_ADDR_WIDTH-1:0]   MAX_ADDR = FIFO_DEPTH-1;
  integer i;
   
generate
  if ( FIFO_DEPTH != (1 << FIFO_ADDR_WIDTH) ) begin : GEN_DEPTH_NONPOWER2_ADDR
    assign read_data = (rd_addr <= MAX_ADDR) ? mem[read_addr] : {FIFO_WIDTH{1'b0}};
    assign wr_n_local  = (wr_addr <= MAX_ADDR) ? wr_n : 1'b1;
  end else begin : GEN_DEPTH_POWER2_ADDR
    assign read_data = mem[read_addr];
    assign wr_n_local  = wr_n;
  end
endgenerate

  // Write Mem Block
  always @ (posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
      for (i=0 ; i < FIFO_DEPTH ; i=i+1)
        mem[i] <= {FIFO_WIDTH{1'b0}};
    end else if (fifo_flush_n == 1'b0) begin
      for (i=0 ; i < FIFO_DEPTH ; i=i+1)
        mem[i] <= {FIFO_WIDTH{1'b0}};
    end else begin
      if (write_en_n == 1'b0)
        mem[write_addr] <= write_data;
    end
  end
 
// Read Mem block with FIFO_MEM_MODE = 1
generate
  if ((FIFO_MEM_MODE & 1) == 1) begin : GEN_DELAY_IN_RD
    reg [FIFO_WIDTH-1:0] data_out_ff;

    always @ (posedge clk or negedge rst_n) begin : insert_delay_rd
      if (rst_n == 1'b0) begin
        data_out_ff <= {FIFO_WIDTH{1'b0}};
      end else if (fifo_flush_n == 1'b0) begin
        data_out_ff <= {FIFO_WIDTH{1'b0}};
      end else begin
        data_out_ff <= read_data;
      end
    end

    assign fifo_data_o = data_out_ff;

// Read Mem block with FIFO_MEM_MODE = 0
  end else begin : GEN_NO_DELAY_IN_RD
    assign fifo_data_o = read_data;
  end
endgenerate

// For Read and Write with FIFO_MEM_MODE = 2
generate
  if ((FIFO_MEM_MODE & 2) == 2) begin : GEN_DELAY_BOTH_WR_RD
    reg [FIFO_ADDR_WIDTH-1:0] rd_addr_ff;
    reg                       we_ff;
    reg [FIFO_ADDR_WIDTH-1:0] wr_addr_ff;
    reg [FIFO_WIDTH-1:0]      data_in_ff;


    always @ (posedge clk or negedge rst_n) begin
      if (rst_n == 1'b0) begin
        rd_addr_ff <= {FIFO_ADDR_WIDTH{1'b0}};
        wr_addr_ff <= {FIFO_ADDR_WIDTH{1'b0}};
        we_ff      <= 1'b0;
        data_in_ff <= {FIFO_WIDTH{1'b0}};
      end else if (fifo_flush_n == 1'b0) begin
        rd_addr_ff <= {FIFO_ADDR_WIDTH{1'b0}};
        wr_addr_ff <= {FIFO_ADDR_WIDTH{1'b0}};
        we_ff      <= 1'b0;
        data_in_ff <= {FIFO_WIDTH{1'b0}};
      end else begin
        rd_addr_ff <= rd_addr;
        wr_addr_ff <= wr_addr;
        we_ff      <= wr_n_local;
        data_in_ff <= fifo_data_i;
      end
    end

    assign write_en_n = we_ff;
    assign write_data = data_in_ff;
    assign write_addr = wr_addr_ff;
    assign read_addr  = rd_addr_ff;

// For Read and Write with FIFO_MEM_MODE = 0
  end else begin : GEN_NON_DELAY
    assign write_en_n = wr_n_local;
    assign write_data = fifo_data_i;
    assign write_addr = wr_addr;
    assign read_addr  = rd_addr;
  end
endgenerate

endmodule
