module cell_clkbuf (
input  wire A,
output wire Y
);

`ifdef SYNTHESIS
BUF_X4M_A7TULL DNT_CLKBUF (.A(A), .Y(Y));	
`elsif FPGA
assign Y = A;
`elsif A9TULL
BUF_X4M_A9TULL DNT_CLKBUF (.A(A), .Y(Y));
`else
assign Y = A;
`endif

endmodule
