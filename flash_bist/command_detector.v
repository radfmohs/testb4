module command_detector (TDI,TCK,RESETb,STROBE,BUSY,TDI_valid,TDI_en,OEN);
input TDI;
input TCK;
input RESETb;
input BUSY;
input TDI_en,OEN;
output STROBE;
output TDI_valid;

//The command to be detected 1001101100101010
parameter s0 = 6'b000000;
parameter s1 = 6'b000001;
parameter s2 = 6'b000010;
parameter s3 = 6'b000100;
parameter s4 = 6'b001000;
parameter s5 = 6'b010000;
parameter s6 = 6'b100000;
parameter s7 = 6'b100001;
parameter s8 = 6'b100010;
parameter s9 = 6'b100011;
parameter s10 = 6'b100100;
parameter s11 = 6'b100101;
parameter s12 = 6'b100110;
parameter s13 = 6'b100111;
parameter s14 = 6'b101000;
parameter s15 = 6'b101001;
parameter s16 = 6'b101010;

reg[5:0] state,next_state;

always @(posedge TCK or negedge RESETb)
begin
if (!RESETb)
state <= s0;
else 
state <= next_state;
end

always @(state or TDI or TDI_en or OEN)
begin
case (state)
s0 :if(TDI_en && OEN) begin 
    if(TDI == 1'b1)
    next_state <= s1;
    else
    next_state <= s0;
                      end
    else next_state <= s0;
s1 : if(TDI_en && OEN ) begin
     if(TDI == 1'b0 )
      next_state <= s2;
      else
      next_state <= s1;
                        end
      else next_state <= s0;
s2 : if(TDI_en && OEN) begin
     if(TDI == 1'b0 )
      next_state <= s3;
     else
      next_state <= s1;
                        end
      else next_state <= s0;
s3 :if(TDI_en && OEN) begin
      if(TDI == 1'b1)
      next_state <= s4;
     else
      next_state <= s0;
                      end
      else next_state <= s0;
s4 : if(TDI_en && OEN) begin 
     if(TDI == 1'b1)
      next_state <= s5;
     else 
      next_state <= s0;
                       end
     else next_state <= s0;
s5: if(TDI_en && OEN) begin
    if(TDI == 1'b0)
      next_state <= s6;
    else
      next_state <= s1;
                      end
     else next_state <= s0;
s6:  if(TDI_en && OEN) begin
     if(TDI == 1'b1)
      next_state <= s7;
     else 
      next_state <= s0;
                       end
      else next_state <= s0;
s7:  if(TDI_en && OEN) begin
     if(TDI == 1'b1 )
      next_state <= s8;
     else
      next_state <= s0;
                       end
      else next_state <= s0;
s8:  if(TDI_en && OEN) begin
     if(TDI == 1'b0)
      next_state <= s9;
     else
      next_state <= s1;
                       end
      else next_state <= s0;
s9 : if(TDI_en && OEN) begin
     if(TDI == 1'b0)
      next_state <= s10;
     else
      next_state <= s1;
                       end
      else next_state <= s0;
s10 : if(TDI_en && OEN) begin
      if(TDI == 1'b1 )
      next_state <= s11;
      else
      next_state <= s0;
                        end
       else next_state <= s0;
s11 : if(TDI_en && OEN) begin
      if(TDI == 1'b0)
      next_state <= s12;
      else
      next_state <= s1;
                        end
       else next_state <= s0;
s12 : if(TDI_en && OEN) begin
      if(TDI == 1'b1)
      next_state <= s13;
      else
      next_state <= s0;
                        end
       else next_state <= s0;
s13 : if(TDI_en && OEN) begin
      if(TDI == 1'b0)
      next_state <= s14;
      else
      next_state <= s1;
                        end
       else next_state <= s0;
s14 : if(TDI_en && OEN) begin
      if(TDI == 1'b1)
      next_state <= s15;
      else
      next_state <= s0;
                        end
       else next_state <= s0;
s15 : if(TDI_en && OEN) begin
      if(TDI == 1'b0)
      next_state <= s16;
      else
      next_state <= s1;
                         end
       else next_state <= s0;
s16 : next_state <= s0;
default : next_state <= s0;
endcase
end


reg TDI_valid;
always @(posedge TCK or negedge RESETb)
begin
if(!RESETb) 
TDI_valid <= 1'b0;
else if(state == s16 && !TDI_valid)
TDI_valid <= 1'b1;
end



reg STROBE;
always @(posedge TCK or negedge RESETb)
begin
if(!RESETb)
STROBE <= 1'b0;
else if (BUSY == 1'b1 && TDI_valid)
STROBE <= 1'b1;
else if (state == s16 && BUSY == 1'b0 && TDI_valid)
STROBE <= 1'b0;
end

endmodule
