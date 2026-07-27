`define ARM_UD_SEQ #1
`define PROJECT_NAME "ENS2"
`define POSTSCAN_NETLIST_ROOT "../netlist/prelayout/data"
`define POSTLAYOUT_NETLIST_ROOT "../netlist/postlayout/data"

module soc_top_tb ();

initial begin
`ifdef POSTLAYOUT_PG
  `ifdef SDFANNOTATE_MIN
    $sdf_annotate ({`POSTLAYOUT_NETLIST_ROOT,"/Nanochap_",`PROJECT_NAME,"_S4_min.sdf"}, soc_top_tb.atpg_tb.dut, ,"./sdf_annotate_min_postlayout_S4.log", "MINIMUM");
  `elsif SDFANNOTATE_MAX
    $sdf_annotate ({`POSTLAYOUT_NETLIST_ROOT,"/Nanochap_",`PROJECT_NAME,"_S4_max.sdf"}, soc_top_tb.atpg_tb.dut, ,"./sdf_annotate_max_postlayout_S4.log", "MAXIMUM");
  `elsif SDFANNOTATE_TYP
    $sdf_annotate ({`POSTLAYOUT_NETLIST_ROOT,"/Nanochap_",`PROJECT_NAME,"_S4_typ.sdf"}, soc_top_tb.atpg_tb.dut, ,"./sdf_annotate_typ_postlayout_S4.log");
  `endif
`else
  `ifdef SDFANNOTATE_MIN
    $sdf_annotate ({`POSTSCAN_NETLIST_ROOT,"/synthesis_postscan_dct.BUD=yes_sdf/Nanochap_",`PROJECT_NAME,".postscan_dct_S4_min.sdfv3"}, soc_top_tb.atpg_tb.dut, ,"./sdf_annotate_min_postlayout_S4.log", "MINIMUM");
  `elsif SDFANNOTATE_MAX
    $sdf_annotate ({`POSTSCAN_NETLIST_ROOT,"/synthesis_postscan_dct.BUD=yes_sdf/Nanochap_",`PROJECT_NAME,".postscan_dct_S4_max.sdfv3"}, soc_top_tb.atpg_tb.dut, ,"./sdf_annotate_max_postlayout_S4.log", "MAXIMUM");
  `elsif SDFANNOTATE_TYP
    $sdf_annotate ({`POSTSCAN_NETLIST_ROOT,"/synthesis_postscan_dct.BUD=yes_sdf/Nanochap_",`PROJECT_NAME,".postscan_dct_S4_typ.sdfv3"}, soc_top_tb.atpg_tb.dut, ,"./sdf_annotate_typ_postlayout_S4.log");
  `endif
`endif
end

tb_chip_top atpg_tb();
initial begin
    force atpg_tb.dut.VPP           =  1'b0 ; 
    force atpg_tb.dut.VDDIO         =  1'b1 ; 
    force atpg_tb.dut.VSSIO         =  1'b0 ; 
    force atpg_tb.dut.VDD_DIG       =  1'b1 ; 
    force atpg_tb.dut.VSS_DIG       =  1'b0 ; 
end

// ==============================
// DUMP Command of Simulation
// ==============================
// DON'T CHANGE THE ORDER of checker.sv and testcase.sv (somes varialables are defined to use in advance)
`ifdef FSDB_DUMP
initial begin
  $fsdbDumpvars(0, soc_top_tb.atpg_tb);
end
`endif

endmodule
