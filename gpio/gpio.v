module gpio (
  input	 wire  [2:0]  i_gpio_pu_ctrl,
  input  wire         i_gpio_pu_resetn,
  input  wire  [1:0]  i_gpio_pd_testmode,
  input  wire 		    i_scan_mode,

	output      [18:0]  o_baf4p1_IOBUF_CS,
	output      [18:0]  o_baf4p1_IOBUF_SR,
  output      [18:0]  o_baf4p1_IOBUF_DR,
  output      [18:0]  o_baf4p1_IOBUF_PU,
  output      [18:0]  o_baf4p1_IOBUF_PD,
  output      [18:0]  o_baf4p1_IOBUF_OS,
  output      [18:0]  o_baf4p1_IOBUF_OD,

  output              o_IO_testmode0_PD,
  output              o_IO_testmode1_PD,
  output              o_IO_exresetn_PU

);

wire [18:0] gpio_pd;
wire [18:0] gpio_pu;
wire [18:0] gpio_os;
wire [18:0] gpio_od;
wire [18:0] gpio_cs;
wire [18:0] gpio_sr;
wire [18:0] gpio_dr;

assign gpio_cs[18:0] = 19'd0;
assign gpio_sr[18:0] = 19'h7_FFFF;
assign gpio_dr[18:0] = 19'd0;
assign gpio_pu[18:0] = {9'b00000000, 4'b0000, 3'b000, i_gpio_pu_ctrl};
assign gpio_pd[18:0] = 19'b0;
assign gpio_os[18:0] = 19'd0;
assign gpio_od[18:0] = 19'd0;

assign o_baf4p1_IOBUF_CS[18:0] = 	~({19{i_scan_mode}} ) & gpio_cs[18:0];
assign o_baf4p1_IOBUF_SR[18:0] = 	~({19{i_scan_mode}} ) & gpio_sr[18:0];
assign o_baf4p1_IOBUF_DR[18:0] = 	~({19{i_scan_mode}} ) & gpio_dr[18:0];
assign o_baf4p1_IOBUF_PU[18:0] = 	~({19{i_scan_mode}} ) & gpio_pu[18:0];
assign o_baf4p1_IOBUF_PD[18:0] = 	~({19{i_scan_mode}} ) & gpio_pd[18:0];
assign o_baf4p1_IOBUF_OS[18:0] = 	~({19{i_scan_mode}} ) & gpio_os[18:0];
assign o_baf4p1_IOBUF_OD[18:0] = 	~({19{i_scan_mode}} ) & gpio_od[18:0];

assign o_IO_testmode0_PD     =  i_gpio_pd_testmode[0];
assign o_IO_testmode1_PD     =  i_gpio_pd_testmode[1];
assign o_IO_exresetn_PU      =  i_gpio_pu_resetn;

endmodule	
