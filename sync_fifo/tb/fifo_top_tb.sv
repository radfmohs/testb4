module fifo_top_tb ();

reg rst_n;
reg i_sclk; // 256Kz
reg clk;
reg fifo_wr_req_n = 1;
reg fifo_rd_req_n = 1;
reg [17:0] fifo_data_i;
wire [17:0] fifo_data_o;
reg fifo_flush_n;
reg fifo_roll;
reg [7:0] fifo_a_empty_level;
reg [7:0] fifo_a_full_level;
integer sys_period = 3906; // 256 Khz
integer spi_period = 3906; // 256 Khz
reg [7:0] delay;

initial begin
   clk = 0;
   forever #(sys_period/2) clk = ~clk;
end 

initial begin
   delay = $random($time); 
   i_sclk = 0;
   #(delay);
   forever #(spi_period/2) i_sclk = ~i_sclk;
end

initial begin
   fifo_flush_n = 1;
end

initial begin
   fifo_roll = 0; 
end

initial begin
   fifo_a_empty_level = 8'h00;
end

initial begin
   fifo_a_full_level = 8'hFF;
end
  
  nc_fifo_top
    #(.FIFO_WIDTH(18), .FIFO_DEPTH(256), .FIFO_ERROR_MODE(0), .FIFO_RESET_MODE(0), .FIFO_ADDR_WIDTH(8))
  fifo_top (
    // clock and reset 
    .clk(clk),
    .rst_n(rst_n),
	
	  // FiFO configuration inputs
    .fifo_flush_n(fifo_flush_n),
    .fifo_roll(fifo_roll),
    .fifo_a_empty_level(fifo_a_empty_level),
    .fifo_a_full_level(fifo_a_full_level),
    
    // Read/Write Interface
    .fifo_wr_req_n(fifo_wr_req_n),
    .fifo_rd_req_n(fifo_rd_req_n),
    .fifo_data_i(fifo_data_i),

    .fifo_data_o(fifo_data_o),

    // FIFO Status Outputs
    .fifo_half_full(fifo_half_full),
    .fifo_a_empty(fifo_a_empty),
    .fifo_a_full(fifo_a_full),
    .fifo_empty(fifo_empty),
    .fifo_full(fifo_full),
    .fifo_error(fifo_error)
);
  reg [17:0] fifo_data_o_ff;
  reg [17:0] fifo_data_o_2ff;

  // Synchronous from SPI to FIFO
  always @(posedge i_sclk or negedge rst_n)
    if (!rst_n) begin
      fifo_data_o_ff <= 16'h0;
    end
    else begin
      fifo_data_o_ff <= fifo_data_o;
    end

  always @(posedge i_sclk or negedge rst_n)
    if (!rst_n) begin
      fifo_data_o_2ff       <= 16'h0;
    end
    else begin
      fifo_data_o_2ff      <= fifo_data_o_ff;
    end

initial begin
   rst_n = 1;
   #10 rst_n = 0;
   #100 rst_n = 1;
end

task wr_fifo;
  input [17:0] data_in;
  begin
    @(posedge clk);
    #1;
    fifo_wr_req_n = 0;
    fifo_data_i = data_in;
    @(posedge clk);
    #1;
    fifo_wr_req_n = 1;
    fifo_data_i = 17'h0;
  end
endtask

task rd_fifo;
  output reg [17:0] data_out;
  begin
    @(posedge i_sclk);
    #1;
    fifo_rd_req_n = 0;
    @(negedge i_sclk);
    data_out=fifo_data_o;
    @(posedge i_sclk);
    #1;
    fifo_rd_req_n = 1;
    data_out=fifo_data_o_2ff;
  end
endtask

reg [17:0] read_data;
reg [17:0] write_data;
integer i;
integer error;

`include "testcase.sv"

task do_report;
  input integer error;
  begin
    if (error == 0) begin
      $display("===========");
      $display("TEST PASSED");
      $display("===========");
    end
    else begin
      $display("===========");
      $display("TEST FAILED");
      $display("===========");
    end
  end
endtask 

initial

  begin
    error = 0;
//    do_reset();
    do_run();
    #(sys_period*100);
    do_report(error); 
    $finish; 
  end

initial begin
    $fsdbAutoSwitchDumpfile((8*1024), "testcase.fsdb", 2, "fsdb.log");
    $fsdbDumpfile("testcase.fsdb");     
    $fsdbDumpvars(0,fifo_top_tb); 
end
endmodule
