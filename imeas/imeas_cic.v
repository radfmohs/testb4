module imeas_cic (
                 clk,
                 resetn,
		 //imeas_en,
		 imeas_input_format,
                 filter_in,
                 cic_rate,
                 format_sel,
                 filter_out,
                 eoc_out
                 );
 input  clk;
 input  resetn;
 //input  imeas_en;
 input [1:0]	imeas_input_format;
 input  filter_in;
 input  [2:0] cic_rate;
 input  format_sel;
 output [15:0] filter_out;
 output eoc_out;

 //reg imeas_en_d1;
 //reg imeas_en_d2;
 
 //Bmax=Bin+3*11+1;expand sign
 reg [11:0]count;
 reg [34:0]integ1;
 reg [34:0]integ2;
 reg [34:0]integ3;
 reg [34:0]comb1;
 reg [34:0]comb2;
 reg [34:0]comb3;
 wire [34:0]comb1_dec;
 wire [34:0]comb2_dec;
 wire [34:0]comb3_dec;
 wire [34:0]din_use;
 wire [34:0]din_use1;
 wire [11:0]down_rate;
 
 //assign din_use =  {{34{1'b0}},1'b1} ;
//for 1 to -1 and 0 to 1
/*
 assign din_use = 
		  (filter_in) ? {{34{1'b1}},1'b1} : {{34{1'b0}},1'b1};
*/
//for verification
/*
 assign din_use = 
		  (filter_in) ? {{34{1'b0}},1'b1} : {{34{1'b0}},1'b0};
*/
 assign din_use = (imeas_input_format == 2'b00) ? 
			((filter_in) ? {{34{1'b0}},1'b1} : {{34{1'b0}},1'b0}) :  		  (imeas_input_format == 2'b01) ?
		        ((filter_in) ? {{34{1'b1}},1'b1} : {{34{1'b0}},1'b1}) :
		  ((filter_in) ? {{34{1'b0}},1'b1} : {{34{1'b1}},1'b1});

 assign down_rate = (cic_rate == 3'b000) ? 12'h1f:
                    (cic_rate == 3'b001) ? 12'h3f:
                    (cic_rate == 3'b010) ? 12'h7f:
                    (cic_rate == 3'b011) ? 12'hff:
                    (cic_rate == 3'b100) ? 12'h1ff:
                    (cic_rate == 3'b101) ? 12'h3ff:
                    (cic_rate == 3'b110) ? 12'h7ff:
                                           12'h7ff;
//assign din_use1 = din_use;
 //data expand,B(din_use) =1+Bmax,other add "0"
 assign din_use1 =  (cic_rate == 3'b000) ? {din_use[16:0],18'b0}:
                    (cic_rate == 3'b001) ? {din_use[19:0],15'b0}:
                    (cic_rate == 3'b010) ? {din_use[22:0],12'b0}:
                    (cic_rate == 3'b011) ? {din_use[25:0],9'b0}:
                    (cic_rate == 3'b100) ? {din_use[28:0],6'b0}:
                    (cic_rate == 3'b101) ? {din_use[31:0],3'b0}:
                    (cic_rate == 3'b110) ?  din_use[34:0]:
                                            din_use;
/*
 always @(posedge clk or negedge resetn)
   if(!resetn) begin
 	imeas_en_d1 <= 1'b0;
 	imeas_en_d2 <= 1'b0;
   end else begin
 	imeas_en_d1 <= imeas_en;
 	imeas_en_d2 <= imeas_en_d1;
   end
*/

wire imeas_en_d2 = 1'b1;
 
 //wire sample;
 //assign sample = (count >= down_rate);
 wire sample_tmp;
 assign sample_tmp = (count >= down_rate);
 reg sample_tmp_d1;
 always @(posedge clk or negedge resetn)
   if(!resetn)
 	sample_tmp_d1 <= 1'b0;
   else
 	sample_tmp_d1 <= sample_tmp;

wire sample = sample_tmp & (~sample_tmp_d1);

 always @(posedge clk or negedge resetn)
   if(!resetn)
      count <= 12'hfff;
   else if(sample)
      count <= 12'h0;
   //else
   else if(imeas_en_d2)
      count <= count + 1'b1;

 always @(posedge clk or negedge resetn)
   if(!resetn) 
   begin
     integ1 <= 35'h0;
     integ2 <= 35'h0;
     integ3 <= 35'h0;
   end
   else if(imeas_en_d2) begin
     integ1 <= integ1 + din_use1;
     integ2 <= integ1 + integ2;
     integ3 <= integ2 + integ3;
   end

  assign comb1_dec = integ3 - comb1;
  assign comb2_dec = comb1_dec - comb2;
  assign comb3_dec = comb2_dec - comb3;
  reg [16:0]cic_out_0;
  //reg [34:0]cic_out_0;
  always @(posedge clk or negedge resetn)
    if(!resetn)
    begin
      comb1 <= 35'h0;
      comb2 <= 35'h0;
      comb3 <= 35'h0;
      cic_out_0 <= 17'h0;
      //cic_out_0 <= 35'h0;
    end
    else if(sample & imeas_en_d2)
    begin
      comb1 <= integ3;
      comb2 <= comb1_dec;
      comb3 <= comb2_dec;
      //cic_out_0 <= comb3_dec;
      cic_out_0 <= comb3_dec[34:18];
    end
  //check overflow
  //wire [34:0]cic_out_1;
  wire [15:0]cic_out_1;
  assign cic_out_1 = (imeas_input_format == 2'b00) ? cic_out_0[15:0] : 
			(cic_out_0[16:15] == 2'b10) ? 16'h8000:
                     (cic_out_0[16:15] == 2'b01) ? 16'h7fff:
                     cic_out_0[15:0];
  //assign cic_out_1 = cic_out_0[23:7];
  
  //check format
  wire [15:0]cic_out_sel;
  wire [16:0] cic_unsign;
  assign cic_unsign = {cic_out_1[15],cic_out_1} + 17'h8000;
  //assign cic_out_sel = format_sel ? (cic_out_1+16'h8000) :cic_out_1;
  assign cic_out_sel = format_sel ? cic_unsign[15:0] :cic_out_1;

  //eco out ?
  reg [2:0]cont_dely;
  wire cont_dely_en;
  assign cont_dely_en = (cont_dely < 3'h3) & sample;
  always @(posedge clk or negedge resetn)
    if(!resetn)
      cont_dely <= 3'h0;
    else if(cont_dely_en)
      cont_dely <= cont_dely + 1'b1;
    else
      cont_dely <= cont_dely;

  reg eoc_out_reg;
  always @(posedge clk or negedge resetn)
    if(!resetn)
      eoc_out_reg <= 1'b0;
    else if(cont_dely == 3'h3)
      eoc_out_reg <= sample;
    else
      eoc_out_reg <= eoc_out_reg;

  reg eoc_out_reg_1t;
  always @(posedge clk or negedge resetn)
    if(!resetn) 
      eoc_out_reg_1t <= 1'b0;
    else
      eoc_out_reg_1t <= eoc_out_reg;
  
  assign filter_out = cic_out_sel;

  assign eoc_out = eoc_out_reg_1t;



endmodule
