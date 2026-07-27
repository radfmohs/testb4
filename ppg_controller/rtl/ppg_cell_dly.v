module ppg_cell_dly (
input  wire A,
output wire Y
);

`ifdef SYNTHESIS
DLY1X4M DNT_DLY (.A(A), .Y(Y));
`else
assign #0.02 Y = A;
`endif

endmodule
