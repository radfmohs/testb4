task do_run;
 begin
   @(posedge rst_n);
   @(posedge clk);
   for (i = 0; i < 100; i = i + 1) begin
     write_data = $random;
     wr_fifo(write_data);
   end

   @(posedge i_sclk);
   fifo_flush_n = 1'b0;
   @(posedge i_sclk);
   fifo_flush_n = 1'b1;

   #(sys_period*4);
   @(posedge clk);
   // Check empty
   if (fifo_top_tb.fifo_top.fifo_empty) 
     $display ("PASSED - FIFO is happen");
   else begin
     $display ("FAILED - FIFO is not empty");
     error=error+1;
   end
   
   @(posedge i_sclk);
   rd_fifo(read_data);

   #(sys_period*4);
   @(posedge clk);
   // Error should happen
   if (fifo_top_tb.fifo_top.fifo_error) $display ("PASSED - Error FIFO is happen when write full");
   else begin
     $display ("FAILED - Error FIFO is not happen when write full");
     error=error+1;
   end
 end
endtask

