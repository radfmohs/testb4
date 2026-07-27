#setenv stage postscan_pteco
sh mkdir -p ../reports/atpg_$env(stage)
sh mkdir -p ../data/atpg_patterns_$env(stage);

read_netlist -lib ../tech/sc7_lib/verilog/sc7_l013_base_rvt.v
read_netlist -lib ../tech/sc7_lib/verilog/sc7_l013_base_rvt_udp.v


read_netlist -lib ../tech/HHG_F013Q7P6_PADLRCMCUDB41K/behaviour_model/PADLRCMCUDB.v -define ATPG_SIM
read_netlist -lib ../tech/ana_lib/BAF4P1_ANA_CHIP.v -define ATPG_PATTERNS

if {$env(stage) == "postscan"} {
	read_netlist ../data/synthesis_postscan_no_sdf/Nanochap_BAF4P1.postscan.v
}
if {$env(stage) == "postscan_pteco"} {
	read_netlist ../data/synthesis_postscan_pteco_sdf/Nanochap_BAF4P1.postscan_pteco.v
}
if {$env(stage) == "postlayout"} {
	#read_netlist /projects/libs/baf4p1/digital_work/TP_BAF4P1_DIG/digital_design/logical/chip_top/sim_atpg/Nanochap_BAF4P1_for_atpg.v 
	read_netlist ../data/Nanochap_BAF4P1.postlayout.v 
}

set_build -black_box FPFLE032K09DA 
set_rules b12 warning
set_rules b24 warning

#add_net_connections TIE1 VDD_DIG_AO -disconnect
#add_net_connections TIE1 VDD_DIG_SW -disconnect
#add_net_connections TIE0 VSS_DIG_AO -disconnect
#add_net_connections TIE0 VSS_DIG_SW -disconnect
#
#add_net_connections TIE1 VDD_DIG_AFSW -disconnect
#add_net_connections TIE1 VDDIO -disconnect
#add_net_connections TIE0 VSSIO -disconnect
add_net_connections TIE1 top_dig_always_on_inst/atpg_en_out  -disconnect
add_net_connections TIE1 u_top_dig/u_pinmux/u_gpio6_pinmux/test0_y  -disconnect

add_net_connections TIE1 u_top_ana/A2D_Wake_UP_i -disconnect
add_net_connections TIE1 POC -all
set_build -nodelete_unused_gates

set_fault -atpg_effectiveness
set_fault -fault_coverage
run_build_model Nanochap_BAF4P1

set_drc -allow_unstable_set_resets

add_po_mask  VDD_DIG_AFSW
add_po_mask  VSS_DIG_AO
add_po_mask  VDD_DIG_AO
add_po_mask  VSS_DIG_SW
add_po_mask  VDD_DIG_SW 

run_drc ../data/synthesis_postscan_no_sdf/Nanochap_BAF4P1.dft_scan_spf
#run_drc ../data/synthesis_postscan_no_sdf/Nanochap_BAF4P1.dft_scan_spf_internal

set_faults -report uncollapsed
set_faults -summary verbose

remove_faults -all

#source ./scr/list_nofaults
#add_nofaults analogue_model_inst
#add_nofaults dna_dig_top_inst/redundant_inst 

add_faults -all
#

report_faults -uncollapse -summary > ../reports/atpg_$env(stage)/summary
report_faults -uncollapse -class AN > ../reports/atpg_$env(stage)/class_AN
report_faults -uncollapse -class UD > ../reports/atpg_$env(stage)/class_UD
report_faults -uncollapse -class UR > ../reports/atpg_$env(stage)/class_UR
report_violation -all > ../reports/atpg_$env(stage)/violation

#set_atpg -pattern 5

#set_atpg -capture_cycles 4

set_atpg -lete_fastseq
set_atpg -coverage 99.9

set_atpg -abort 100
set_atpg -merge high

run_atpg -auto

#report_faults -class AN -unsuccessfull >  ../reports/atpg_$env(stage)/unsuccessfull
report_scan_chain > ../reports/atpg_$env(stage)/scan_chain
report_scan_cells  -all > ../reports/atpg_$env(stage)/scan_cell
analyze_faults -class AN -verbose > ../reports/atpg_$env(stage)/ana_class_an

write_faults ../reports/atpg_$env(stage)/Nanochap_ENS1p4 -replace -uncollapse -class AN

write_patterns  ../data/atpg_patterns_$env(stage)/pattern_seri.wgl -replace -serial -format wgl
write_patterns  ../data/atpg_patterns_$env(stage)/pattern_seri.stil -replace -serial -format stil
write_testbench -input ../data/atpg_patterns_$env(stage)/pattern_seri.stil -output ../data/atpg_patterns_$env(stage)/test_pattern_seri -replace -parameters { -config_file ../scripts/Nanochap_imp_tmax.conf }


exit
