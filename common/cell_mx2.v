module cell_mx2 (
input  wire A,
input  wire B,
input  wire S0,
output wire Y
);

`ifdef FPGA
assign Y = S0 ? B : A;
`endif


`ifdef SYNTHESIS
MX2X4M DNT_MX2 (.A(A), .B(B), .S0(S0), .Y(Y));	
`else
assign Y = S0 ? B : A;	
//MX2_X4_A7TULL DNT_MX2 (.A(A), .B(B), .S0(S0), .Y(Y));
`endif

endmodule
