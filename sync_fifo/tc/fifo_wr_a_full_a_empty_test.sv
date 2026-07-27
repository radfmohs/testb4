task do_run;
 begin
   @(posedge rst_n);
   @(posedge clk);

   // Check almost full at the begining
   if (!fifo_top_tb.fifo_top.fifo_a_full) $display ("PASSED - Almost Full FIFO is happen");
   else begin
     $display ("FAILED - Almost Full FIFO is not happen");
     error=error+1;
   end
   
   @(posedge i_sclk);
   fifo_a_full_level = 199;
   fifo_a_empty_level = 10;
   
   @(posedge clk); 
   for (i = 0; i < 200; i = i + 1) begin
     write_data = $random;
     wr_fifo(write_data);
   end
   
   // Check almost full
   if (fifo_top_tb.fifo_top.fifo_a_full) $display ("PASSED - Almost Full FIFO is happen");
   else begin
     $display ("FAILED - Almost Full FIFO is not happen");
     error=error+1;
   end

   // Error should not happen
   if (!fifo_top_tb.fifo_top.fifo_error) $display ("PASSED - Error FIFO is happen when write full");
   else begin
     $display ("FAILED - Error FIFO is not happen when write full");
     error=error+1;
   end
   
   // Continue to write until FIFO is full 
   for (i = 0; i < 56; i = i + 1) begin
     write_data = $random;
     wr_fifo(write_data);
   end

   // Check full
   if (fifo_top_tb.fifo_top.fifo_full) $display ("PASSED - Full FIFO is happen");
   else begin
     $display ("FAILED - Full FIFO is not happen");
     error=error+1;
   end

   // Error should not happen
   if (!fifo_top_tb.fifo_top.fifo_error) $display ("PASSED - Error FIFO is happen when write full");
   else begin
     $display ("FAILED - Error FIFO is not happen when write full");
     error=error+1;
   end

   // Write when FIFO is full
     write_data = $random;
     wr_fifo(write_data);

   // Error should happen
   if (fifo_top_tb.fifo_top.fifo_error) $display ("PASSED - Error FIFO is happen when write full");
   else begin
     $display ("FAILED - Error FIFO is not happen when write full");
     error=error+1;
   end
   
   @(posedge i_sclk);
   for (i = 0; i < 246; i = i + 1) begin
     rd_fifo(read_data);
   end

   #(sys_period*4);
   @(posedge clk);
   // Check almost empty
   if (fifo_top_tb.fifo_top.fifo_a_empty) $display ("PASSED - Almost Empty FIFO is happen");
   else begin
     $display ("FAILED - Almost Empty FIFO is not happen");
     error=error+1;
   end

   for (i = 0; i < 10; i = i + 1) begin
     rd_fifo(read_data);
   end

   #(sys_period*4);
   @(posedge clk);
   // Check almost empty
   if (fifo_top_tb.fifo_top.fifo_empty) $display ("PASSED - FIFO is happen");
   else begin
     $display ("FAILED - FIFO is not empty");
     error=error+1;
   end

 end
endtask

