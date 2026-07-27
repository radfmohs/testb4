//------------------------------------------------------------------------------
// Nanochap Pty Ltd (c) 2021
//
// Module Name : pinmux_1bit
// Description : 1bit pinmux
//------------------------------------------------------------------------------
// Revision History
//------------------------------------------------------------------------------
// Revision     Date        Author  
//------------------------------------------------------------------------------
// 0.1          16/04/2021  Daniel

module pinmux_1bit (
// test and alternate select
input  wire         altf_sel,			
input  wire [3:0]   test_sel,			
input  wire         test_en,
input  wire         test0_en,
input  wire         test1_en,
input  wire         test2_en,
input  wire         test3_en,
input  wire         test4_en,
input  wire         test5_en,
input  wire         test6_en,
input  wire         test7_en,
input  wire         test8_en,
input  wire         test9_en,
input  wire         test10_en,
input  wire         test11_en,
input  wire         test12_en,
input  wire         test13_en,
input  wire         test14_en,
input  wire	        test_ana,			//added by supriya
// alternate function
// altf0
input  wire         altf0_ie,
input  wire         altf0_oe,
input  wire         altf0_a,
input  wire         altf0_def,
output wire         altf0_y,
// test mode function
// test0
input  wire         test0_ie,
input  wire         test0_oe,
input  wire         test0_a,
input  wire         test0_def,
output wire         test0_y,
// test1
input  wire         test1_ie,
input  wire         test1_oe,
input  wire         test1_a,
input  wire         test1_def,
output wire         test1_y,
// test2
input  wire         test2_ie,
input  wire         test2_oe,
input  wire         test2_a,
input  wire         test2_def,
output wire         test2_y,
// test3
input  wire         test3_ie,   
input  wire         test3_oe,   
input  wire         test3_a,    
input  wire         test3_def, 
output wire         test3_y,    
/// test4
input  wire         test4_ie,   
input  wire         test4_oe,   
input  wire         test4_a,   
input  wire         test4_def,  
output wire         test4_y,    
/// test5
input  wire         test5_ie,   
input  wire         test5_oe,   
input  wire         test5_a,    
input  wire         test5_def,  
output wire         test5_y,    
/// test6
input  wire         test6_ie,   
input  wire         test6_oe,   
input  wire         test6_a,    
input  wire         test6_def,  
output wire         test6_y,   
/// test7
input  wire         test7_ie,   
input  wire         test7_oe,   
input  wire         test7_a,    
input  wire         test7_def,  
output wire         test7_y,  
/// test8
input  wire         test8_ie,   
input  wire         test8_oe,   
input  wire         test8_a,    
input  wire         test8_def,  
output wire         test8_y,    
/// test9
input  wire         test9_ie,   
input  wire         test9_oe,   
input  wire         test9_a,    
input  wire         test9_def, 
output wire         test9_y,    
/// test10
input  wire         test10_ie,   
input  wire         test10_oe,   
input  wire         test10_a,    
input  wire         test10_def,  
output wire         test10_y,    
/// test11
input  wire         test11_ie,   
input  wire         test11_oe,   
input  wire         test11_a,    
input  wire         test11_def,  
output wire         test11_y,    
/// test12
input  wire         test12_ie,   
input  wire         test12_oe,   
input  wire         test12_a,    
input  wire         test12_def,  
output wire         test12_y,    
/// test13
input  wire         test13_ie,   
input  wire         test13_oe,   
input  wire         test13_a,    
input  wire         test13_def,  
output wire         test13_y, 
/// test14
input  wire         test14_ie,   
input  wire         test14_oe,   
input  wire         test14_a,    
input  wire         test14_def,  
output wire         test14_y, 
//end
// analog enable
//output wire         analog_en,
//output wire [1:0]     analog_en,
// with pad interface
input  wire         iopad_gpio_y,
output wire         iopad_gpio_ie,
output wire         iopad_gpio_oe,
output wire         iopad_gpio_a
);

//parameter ALTF0_CLKIN = 0;
//parameter TEST0_CLKIN = 0;		
//parameter TEST1_CLKIN = 0;	
//parameter TEST2_CLKIN = 0;
//parameter TEST3_CLKIN = 0; 
//parameter TEST4_CLKIN = 0; 
//parameter TEST5_CLKIN = 0; 
//parameter TEST6_CLKIN = 0; 
//parameter TEST7_CLKIN = 0; 
//parameter TEST8_CLKIN = 0; 
//parameter TEST9_CLKIN = 0; 
//parameter TEST10_CLKIN = 0;
//parameter TEST11_CLKIN = 0;
//parameter TEST12_CLKIN = 0;
//parameter TEST13_CLKIN = 0;
	

wire altf0_en;


wire test_mux_ie;
wire test_mux_oe;
wire test_mux_a;

wire altf_mux_ie;
wire altf_mux_oe;
wire altf_mux_a;

//wire clk_bufin;
wire data_bufin;

wire altf0_bufin;

wire test0_bufin;
wire test1_bufin;
wire test2_bufin;
wire test3_bufin;
wire test4_bufin;
wire test5_bufin;
wire test6_bufin;
wire test7_bufin;
wire test8_bufin;
wire test9_bufin;
wire test10_bufin;
wire test11_bufin;
wire test12_bufin;
wire test13_bufin;
wire test14_bufin;

wire testmode_en;
wire testmode_ie;
wire testmode_oe;
wire testmode_a;

//modified by supriya
//0:  digital function considered
//1:  analog function considered
//assign altf0_en = altf_sel & ~test_en;
assign altf0_en = test_en ? 1'b1 : altf_sel;

//
//assign testmode_en = test_en ? (test0_en | test1_en | test2_en | test3_en | test4_en | test5_en | test6_en | test7_en | test8_en | test9_en | test10_en) : 1'b0;
//assign testmode_ie = testmode_en ? (test0_ie | test1_ie | test2_ie | test3_ie | test4_ie | test5_ie | test6_ie | test7_ie | test8_ie | test9_ie | test10_ie) : 1'b0;
//assign testmode_oe = testmode_en ? (test0_oe | test1_oe | test2_oe | test3_oe | test4_oe | test5_oe | test6_oe | test7_oe | test8_oe | test9_oe | test10_oe) : 1'b0;
//assign testmode_a  = testmode_en ? (test0_a | test1_a | test2_a | test3_a | test4_a | test5_a | test6_a | test7_a | test8_a | test9_a | test10_a) : 1'b0;

//
//assign altf0_bufin = ALTF0_CLKIN ? clk_bufin : data_bufin;
assign altf0_bufin = data_bufin;

//
//assign test0_bufin  = TEST0_CLKIN  ? clk_bufin : data_bufin;
//assign test1_bufin  = TEST1_CLKIN  ? clk_bufin : data_bufin;
//assign test2_bufin  = TEST2_CLKIN  ? clk_bufin : data_bufin;
//assign test3_bufin  = TEST3_CLKIN  ? clk_bufin : data_bufin;
//assign test4_bufin  = TEST4_CLKIN  ? clk_bufin : data_bufin;
//assign test5_bufin  = TEST5_CLKIN  ? clk_bufin : data_bufin;
//assign test6_bufin  = TEST6_CLKIN  ? clk_bufin : data_bufin;
//assign test7_bufin  = TEST7_CLKIN  ? clk_bufin : data_bufin;
//assign test8_bufin  = TEST8_CLKIN  ? clk_bufin : data_bufin;
//assign test9_bufin  = TEST9_CLKIN  ? clk_bufin : data_bufin;
//assign test10_bufin = TEST10_CLKIN ? clk_bufin : data_bufin;
//assign test11_bufin = TEST11_CLKIN ? clk_bufin : data_bufin;
//assign test12_bufin = TEST12_CLKIN ? clk_bufin : data_bufin;
//assign test13_bufin = TEST13_CLKIN ? clk_bufin : data_bufin;

assign test0_bufin  = data_bufin;
assign test1_bufin  = data_bufin;
assign test2_bufin  = data_bufin;
assign test3_bufin  = data_bufin;
assign test4_bufin  = data_bufin;
assign test5_bufin  = data_bufin;
assign test6_bufin  = data_bufin;
assign test7_bufin  = data_bufin;
assign test8_bufin  = data_bufin;
assign test9_bufin  = data_bufin;
assign test10_bufin = data_bufin;
assign test11_bufin = data_bufin;
assign test12_bufin = data_bufin;
assign test13_bufin = data_bufin;
assign test14_bufin = data_bufin;

cell_mx16 u_test_ie (.Y(test_mux_ie), .A(test0_ie), .B(test1_ie), .C(test2_ie), .D(test3_ie), .E(test4_ie), .F(test5_ie),  .G(test6_ie),  .H(test7_ie),  .I(test8_ie),
     				     .J(test9_ie),  .K(test10_ie),  .L(test11_ie),  .M(test12_ie),  .N(test13_ie),  .O(test14_ie),  .P(1'b0),
		   		     .S0(test_sel[0]), .S1(test_sel[1]), .S2(test_sel[2]), .S3(test_sel[3]));

cell_mx16 u_test_oe (.Y(test_mux_oe), .A(test0_oe), .B(test1_oe), .C(test2_oe), .D(test3_oe), .E(test4_oe), .F(test5_oe),  .G(test6_oe),  .H(test7_oe),  .I(test8_oe),    
 				     .J(test9_oe),  .K(test10_oe), .L(test11_oe),     .M(test12_oe),      .N(test13_oe),    .O(test14_oe),      .P(1'b0),
				     .S0(test_sel[0]), .S1(test_sel[1]), .S2(test_sel[2]), .S3(test_sel[3]));

cell_mx16 u_test_a  (.Y(test_mux_a),  .A(test0_a),  .B(test1_a),  .C(test2_a),  .D(test3_a),  .E(test4_a),  .F(test5_a),   .G(test6_a),   .H(test7_a),   .I(test8_a),  
    				      .J(test9_a),  .K(test10_a), .L(test11_a),     .M(test12_a),      .N(test13_a),    .O(test14_a),      .P(1'b0),
				      .S0(test_sel[0]), .S1(test_sel[1]), .S2(test_sel[2]), .S3(test_sel[3]));

//cell_mx4 u_test_ie (.Y(test_mux_ie), .A(1'b0), .B(test0_ie), .C(test1_ie), .D(test2_ie), .S0(test_sel[0]), .S1(test_sel[1]));
//cell_mx4 u_test_oe (.Y(test_mux_oe), .A(1'b0), .B(test0_oe), .C(test1_oe), .D(test2_oe), .S0(test_sel[0]), .S1(test_sel[1]));
//cell_mx4 u_test_a  (.Y(test_mux_a),  .A(1'b0), .B(test0_a),  .C(test1_a),  .D(test2_a),  .S0(test_sel[0]), .S1(test_sel[1]));
//cell_mx2 u_test_ie (.Y(test_mux_ie), .A(1'b0), .B(testmode_ie), .S0(testmode_en));
//cell_mx2 u_test_oe (.Y(test_mux_oe), .A(1'b0), .B(testmode_oe), .S0(testmode_en));
//cell_mx2 u_test_a  (.Y(test_mux_a),  .A(1'b0), .B(testmode_a),  .S0(testmode_en));

//modified by supriya
cell_mx2 u_altf_ie (.Y(altf_mux_ie), .A(altf0_ie), .B(1'b0), .S0(altf0_en));
cell_mx2 u_altf_oe (.Y(altf_mux_oe), .A(altf0_oe), .B(1'b0), .S0(altf0_en));
cell_mx2 u_altf_a  (.Y(altf_mux_a),  .A(altf0_a),  .B(1'b0), .S0(altf0_en));


//cell_mx2 u_ie_out  (.Y(iopad_gpio_ie), .A(altf_mux_ie), .B(test_mux_ie), .S0(test_en));
//cell_mx2 u_oe_out  (.Y(iopad_gpio_oe), .A(altf_mux_oe), .B(test_mux_oe), .S0(test_en));
//cell_mx2 u_a_out   (.Y(iopad_gpio_a),  .A(altf_mux_a),  .B(test_mux_a),  .S0(test_en));

//modified by Supriya
//Disable ie,oe when analog mode selected
cell_mx4 u_ie_out  (.Y(iopad_gpio_ie), .A(altf_mux_ie), .B(altf_mux_ie), .C(test_mux_ie), .D(1'b0), .S0(test_ana), .S1(test_en));
cell_mx4 u_oe_out  (.Y(iopad_gpio_oe), .A(altf_mux_oe), .B(altf_mux_oe), .C(test_mux_oe), .D(1'b0), .S0(test_ana), .S1(test_en));
cell_mx4 u_a_out   (.Y(iopad_gpio_a),  .A(altf_mux_a),  .B(altf_mux_a),  .C(test_mux_a),  .D(1'b0), .S0(test_ana), .S1(test_en));

//
//cell_buf    u_clk_bufin  (.Y(clk_bufin), .A(iopad_gpio_y));
cell_buf    u_data_bufin (.Y(data_bufin), .A(iopad_gpio_y));

//
cell_mx2 u_altf0_y (.Y(altf0_y), .A(altf0_bufin), .B(altf0_def), .S0(altf0_en));

//
cell_mx2 u_test0_y  (.Y(test0_y),  .A(test0_def),  .B(test0_bufin),  .S0(test0_en));
cell_mx2 u_test1_y  (.Y(test1_y),  .A(test1_def),  .B(test1_bufin),  .S0(test1_en));
cell_mx2 u_test2_y  (.Y(test2_y),  .A(test2_def),  .B(test2_bufin),  .S0(test2_en));

//
//
cell_mx2 u_test3_y  (.Y(test3_y),  .A(test3_def),  .B(test3_bufin),  .S0(test3_en));
cell_mx2 u_test4_y  (.Y(test4_y),  .A(test4_def),  .B(test4_bufin),  .S0(test4_en));
cell_mx2 u_test5_y  (.Y(test5_y),  .A(test5_def),  .B(test5_bufin),  .S0(test5_en));

cell_mx2 u_test6_y  (.Y(test6_y),  .A(test6_def),  .B(test6_bufin),  .S0(test6_en));
cell_mx2 u_test7_y  (.Y(test7_y),  .A(test7_def),  .B(test7_bufin),  .S0(test7_en));
cell_mx2 u_test8_y  (.Y(test8_y),  .A(test8_def),  .B(test8_bufin),  .S0(test8_en));

cell_mx2 u_test9_y  (.Y(test9_y),  .A(test9_def),  .B(test9_bufin),  .S0(test9_en));
cell_mx2 u_test10_y (.Y(test10_y), .A(test10_def), .B(test10_bufin), .S0(test10_en));
cell_mx2 u_test11_y (.Y(test11_y), .A(test11_def), .B(test11_bufin), .S0(test11_en));
cell_mx2 u_test12_y (.Y(test12_y), .A(test12_def), .B(test12_bufin), .S0(test12_en));
cell_mx2 u_test13_y (.Y(test13_y), .A(test13_def), .B(test13_bufin), .S0(test13_en));
cell_mx2 u_test14_y (.Y(test14_y), .A(test14_def), .B(test14_bufin), .S0(test14_en));


endmodule
