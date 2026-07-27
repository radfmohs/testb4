module cell_buf (
input  wire A,
output wire Y
);

`ifdef FPGA
assign Y = A;
`endif

`ifdef SYNTHESIS
BUFX4M DNT_BUF (.A(A), .Y(Y));	
`else
assign Y = A;	
//BUF_X4_A7TULL DNT_BUF (.A(A), .Y(Y));
`endif

endmodule
