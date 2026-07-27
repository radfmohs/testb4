/////////////////////////////////////////////////////////
////----------------------------------------------------
////-- author: zhen cao
////
////-- module: common_cnt_cond2.v
////
////-- discription:there are there conditions for a counter:
////   the fitst "else if" statement clears the counter, "else" statement
////   enbales the counter
////
////-- data:25/5/2025
////
////-- version:0.1
////
////----------------------------------------------------
/////////////////////////////////////////////////////////

module common_cnt_cond2 #(
parameter RST_VAL    = 1'b0,
parameter CNT_WIDTH  = 18
)(
input  wire                   cond_clr_cnt,
input  wire                   clk,
input  wire                   rst_,
output reg  [CNT_WIDTH-1:0]   d_out
); 


always @( posedge clk  or negedge rst_)begin
    if(~rst_) begin
    d_out <= {18{RST_VAL}};
    end
    else if (cond_clr_cnt) begin
    d_out <= {18{RST_VAL}};       
    end
    else begin
    d_out <= d_out + 1'b1;    
    end
end


endmodule

