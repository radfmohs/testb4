// define slices for serial TDI input
`define S_CEB             0  
`define S_OEB             1 
`define S_WEB             2  
`define S_PROG            3  
`define S_PROG2           4  
`define S_ERASE           5  
`define S_BLOCK           6  
`define S_CHIP            7 
`define S_CONFEN          8
`define S_NVR             9
`define S_TMEN           10
`define S_VREAD1          11
`define S_VREAD0          12
`define S_RDN            13
`define S_DEEPPD         14
`define S_VMON1          15
`define S_VMON2          16
`define S_A           31:17
`define S_DIN         39:32
`define S_MS          43:40
`define S_FREQ        45:44
`define S_Tprog_conf  47:46   // to select differnent program time
`define S_Terase_conf 49:48   // to select differnent erase time 

// write states
`define FSM_WIDLE    4'b0000
`define FSM_WNVS     4'b0001
`define FSM_WPGS     4'b0010
`define FSM_WPROG    4'b0011
`define FSM_WADH     4'b0100
`define FSM_WADS     4'b0101
`define FSM_WRCV     4'b0111
`define FSM_WRW      4'b1111

// read states
`define FSM_RIDLE     3'b000
`define FSM_RVRS      3'b001
`define FSM_RRC       3'b011
`define FSM_RSAMPLE   3'b010
`define FSM_ROVER     3'b100
`define FSM_RCMP      3'b101

// erase states
`define FSM_EIDLE    3'b000
`define FSM_ENVS     3'b001
`define FSM_EERASE   3'b010
`define FSM_ERCV     3'b011
`define FSM_ERW      3'b100

// modes
`define PGMSER_RD_WR 4'b0000
`define PGM_WR       4'b0001
`define PGMCB_WR     4'b0010
`define PGMICB_WR    4'b0011
`define PGMDIAG_WR   4'b0100
`define PGM_RD       4'b0101
`define PGM_SERASE    4'b0110
`define PGM_BERASE   4'b1011
`define PGM_WR32     4'b0111   
`define PGMCB_WR32   4'b1000
`define PGMICB_WR32  4'b1001
`define PGM_WR_WORD  4'b1100
`define PGM_RD_WORD  4'b1101
`define PGM_RDCK     4'b1110
