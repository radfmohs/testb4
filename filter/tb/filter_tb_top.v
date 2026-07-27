module filter_tb_top;

filter_soc_tb_125  filter_chip_125();
filter_soc_tb_250  filter_chip_250();
filter_soc_tb_500  filter_chip_500();
filter_soc_tb_1000 filter_chip_1000();

`define CLK filter_chip_125.clk

initial begin
        $fsdbDumpvars(0, filter_tb_top);
        $vcdpluson(0);
        $vcdplusmemon(0);
        $vcdplusglitchon(0);
        $vcdplusdeltacycleon();

  // This is signed DATA
  force filter_tb_top.filter_chip_1000.u_notch_filter.sign_en = 1'b1;
  force filter_tb_top.filter_chip_500.u_notch_filter.sign_en = 1'b1;
  force filter_tb_top.filter_chip_250.u_notch_filter.sign_en = 1'b1;
  force filter_tb_top.filter_chip_125.u_notch_filter.sign_en = 1'b1;

`ifndef SIN_DATA_24HZ
  force filter_tb_top.filter_chip_125.imeas_sampling_rate[15:0] = 20000;
  force filter_tb_top.filter_chip_250.imeas_sampling_rate[15:0] = 20000;
  force filter_tb_top.filter_chip_500.imeas_sampling_rate[15:0] = 20000;
  force filter_tb_top.filter_chip_1000.imeas_sampling_rate[15:0] = 20000;
`endif

`ifdef MATLAB_DATA
  force filter_tb_top.filter_chip_125.matlab_data = 1'b1;
  force filter_tb_top.filter_chip_250.matlab_data = 1'b1;
  force filter_tb_top.filter_chip_500.matlab_data = 1'b1;
  force filter_tb_top.filter_chip_1000.matlab_data = 1'b1;
`endif

repeat(2003) @(posedge `CLK);
$finish;

end

/*
0 < Amp <= 7FFF
0 < offset < 7FFF
0 < Amp + offset <=FFFF
0 < offset - Amp <FFFF
0<=freq<sampling_rate/2
*/

reg [14:0] imeas_sin_amp = 1234;
reg [14:0] imeas_sin_offset = 2346;
reg [15:0] filter_in;
parameter imeas_sampling_rate = 5000;
parameter imeas_sin_freq = 20;
integer counter = 0;
real pi = 3.141592;
real fin_sin;

logic [15:0] filter_in;

always @(*)
  fin_sin = $sin(2*pi* counter * imeas_sin_freq/(imeas_sampling_rate));

always @(`CLK) begin
 filter_in = imeas_sin_offset + (imeas_sin_amp * fin_sin);
end

always @(`CLK) begin
 if ((counter >= imeas_sampling_rate / imeas_sin_freq) && (fin_sin<0))
  counter = 1;
 else
  counter = counter + 1;
end

endmodule
