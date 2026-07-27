task do_run;
 reg [2:0] num;
 begin
   num = $random($time); 
   spi_period = 4000 * num + 1;
   @(posedge rst_n);
   @(posedge clk);
   // Disable FIFO roll
   fifo_roll = 1'b0;

   for (i = 0; i < 256; i = i + 1) begin
     write_data = $random;
     wr_fifo(write_data);
   end
   // Check full
   if (fifo_top_tb.fifo_top.fifo_full) 
     $display ("PASSED - Full FIFO is happen");
   else begin
     $display ("FAILED - Full FIFO is not happen");
     error=error+1;
   end
   for (i = 0; i < 10; i = i + 1) begin
      wr_fifo(i);
      if (fifo_top_tb.fifo_top.fifo_error) 
        $display ("PASSED - Error FIFO is happen when write full");
      else begin
        $display ("FAILED - Error FIFO is not happen when write full");
        error=error+1;
      end

      @(posedge i_sclk);
      rd_fifo(read_data);

      #(sys_period*4);
      @(posedge clk);
      if (i != read_data) begin
        $display("PASSED - Data is not override when FIFO is full");
      end else begin
        $display("FAILED - Data is override when FIFO is full");
        error = error + 1;
      end
   end

   @(posedge i_sclk);
   for (i = 0; i < 267; i = i + 1) begin
     rd_fifo(read_data);
   end

   #(sys_period*4);
   @(posedge clk);
   // Check empty
   if (fifo_top_tb.fifo_top.fifo_empty) 
     $display ("PASSED - Empty FIFO is happen");
   else begin
     $display ("FAILED - Empty FIFO is not happen");
     error=error+1;
   end

   if (fifo_top_tb.fifo_top.fifo_error) 
     $display ("PASSED - Error FIFO is happen when read empty");
   else begin
     $display ("FAILED - Error FIFO is not happen when read empty");
     error=error+1;
   end

 end
endtask

