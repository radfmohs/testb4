task do_run;
 begin
   @(posedge rst_n);
   @(posedge clk);
   for (i = 0; i < 1000; i = i + 1) begin
     write_data = $random;
     wr_fifo(write_data);

     @(posedge i_sclk);
     rd_fifo(read_data);

      #(sys_period*4);
      @(posedge clk);
     if (write_data != read_data) begin
        $display("FAILED - Write DATA = %h is not equal Read_Data = %h", write_data, read_data);
        error = error + 1;
     end
     else begin
       $display("PASSED - Write DATA = %h is equal Read_Data = %h", write_data, read_data);
     end
   end
 end
endtask

