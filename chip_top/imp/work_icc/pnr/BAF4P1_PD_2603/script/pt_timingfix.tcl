#For 1st Func_min hold fix, give Holdfix cells list as: 
#set PT_hold_fix_cell    "[DLY1X1M DLY2X1M DLY3X1M DLY4X1M]"
#pt_shell
restore_session ./session/scan_min.session
set_dont_use [get_lib_cells {*/CLK* */*EDFF* */*TBUF* */*SDFFTR* */*XL* */*TIE* }]
set_dont_touch [get_lib_cells {*/CLK*}]
if {$mode == "scan"} {
	set eco_instance_name_prefix "uScan_"
	set eco_net_name_prefix "nScan_"
} elseif {$mode == "bist"} {
	set eco_instance_name_prefix "uBIST_"
	set eco_net_name_prefix "nBIST_"
}  
set PT_setup_fix_cell   "[list \
BUFX10M \
BUFX12M \
BUFX14M \
BUFX16M \
BUFX18M \
BUFX20M \
BUFX24M \
BUFX2M \
BUFX3M \
BUFX4M \
BUFX5M \
BUFX6M \
BUFX8M\
]"
set PT_hold_fix_cell    "[list \
DLY2X1M \
DLY4X1M \
BUFX2M \
BUFX3M \
BUFX4M \
BUFX5M \
BUFX6M \
BUFX8M \
BUFX10M\
]"
#BUFX12M \
#BUFX14M \
#BUFX16M\
#]"
report_constraints -max_capacitance -all_violators 
report_constraints -max_transition -all_violators
report_constraints -max_fanout -all_violators
#report_constraints -min_capacitance -all_violators
#
set eco_report_unfixed_reason_max_endpoints 500
fix_eco_drc -type max_transition -buffer_list $PT_setup_fix_cell -methods {insert_buffer} -verbose
fix_eco_drc -type max_capacitance -buffer_list $PT_setup_fix_cell -methods {insert_buffer} -verbose
fix_eco_drc -type max_fanout -buffer_list $PT_setup_fix_cell -methods {size_cell insert_buffer} -verbose

#set lef_list "/latte/scratch/gayathri/bms5/pnr/BMS5_netlistv11_0401_icctest/MW/BMS5_ANA_CHIP_1201/BMS5_ANA_CHIP.lef /latte/scratch/gayathri/bms5/pnr/BMS5_netlistv11_0401_icctest/MW/FLS016K29DE/FLS016K29DE_M5a.lef /latte/scratch/gayathri/bms5/pnr/BMS5_netlistv11_0401_icctest/MW/FLS032K29DE/FLS032K29DE_M5a.lef /latte/scratch/gayathri/bms5/pnr/BMS5_netlistv11_0401_icctest/MW/M31HDSP030NL130P/M31HDSP030NL130P_2048X8X4CM8.lef /latte/scratch/gayathri/bms5/pnr/BMS5_netlistv11_0401_icctest/MW/PADLRCMCUDB/PADLRCMCUDB_M6t_g.lef /latte/scratch/gayathri/bms5/pnr/BMS5_netlistv11_0401_icctest/MW/sc7_l013_base_rvt.lef"
#set_eco_options -physical_design_path ../output/09_ECO2/09_ECO2.def.gz -physical_tech_lib_path ../MW/sc7_tech.lef -physical_lib_path $lef_list
#fix_eco_drc -type setup -buffer $PT_setup_fix_cell -slack_lesser_than -0.000 -pba_mode exhaustive -methods {size_cell insert_buffer} -physical_mode occupied_site -verbose

fix_eco_timing -type setup -buffer $PT_setup_fix_cell -slack_lesser_than -0.000 -pba_mode exhaustive -methods {size_cell} -verbose -hold_margin 10
fix_eco_timing -type hold -buffer $PT_hold_fix_cell -slack_lesser_than -0.000 -pba_mode exhaustive -methods {insert_buffer} -verbose -setup_margin 10
report_global_timing
write_changes -format icctcl -output ./timing_eco/${stage}_${corner}.tcl



restore_session ./session/func_min.session/
set_dont_use [get_lib_cells {*/CLK* */*EDFF* */*TBUF* */*SDFFTR* */*XL* */*TIE*}]
set_dont_touch [get_lib_cells {*/CLK*}]
set PT_setup_fix_cell   "[list \
BUFX10M \
BUFX12M \
BUFX14M \
BUFX16M \
BUFX18M \
BUFX20M \
BUFX24M \
BUFX2M \
BUFX3M \
BUFX4M \
BUFX5M \
BUFX6M \
BUFX8M\
]"
set PT_hold_fix_cell    "[list \
DLY1X1M \
DLY1X4M \
DLY2X1M \
DLY2X4M \
DLY3X1M \
DLY3X4M \
DLY4X1M \
DLY4X4M\
BUFX2M \
BUFX3M \
BUFX4M \
BUFX5M \
BUFX6M \
BUFX8M \
BUFX10M \
BUFX12M \
BUFX14M \
BUFX16M \
BUFX18M \
BUFX20M\
]"
set eco_report_unfixed_reason_max_endpoints 500
fix_eco_drc -type max_transition -buffer_list $PT_setup_fix_cell -methods {size_cell insert_buffer} -verbose
fix_eco_timing -type setup -buffer $PT_setup_fix_cell -slack_lesser_than -0.000 -pba_mode exhaustive -methods {size_cell} -verbose 
fix_eco_timing -type hold -buffer $PT_hold_fix_cell -slack_lesser_than -0.000 -pba_mode exhaustive -methods {size_cell insert_buffer} -verbose
write_changes -format icctcl -output ./timing_eco/${stage}_${corner}.tcl

restore_session ./session/scan_max.session/
set_dont_use [get_lib_cells {*/CLK* */*EDFF* */*TBUF* */*SDFFTR* */*XL* */*TIE*}]
set_dont_touch [get_lib_cells {*/CLK*}]
set PT_setup_fix_cell   "[list \
BUFX10M \
BUFX12M \
BUFX14M \
BUFX16M \
BUFX18M \
BUFX20M \
BUFX24M \
BUFX2M \
BUFX3M \
BUFX4M \
BUFX5M \
BUFX6M \
BUFX8M\
]"
set PT_hold_fix_cell    "[list \
DLY1X1M \
DLY1X4M \
DLY2X1M \
DLY2X4M \
DLY3X1M \
DLY3X4M \
DLY4X1M \
DLY4X4M \
BUFX2M \
BUFX3M \
BUFX4M \
BUFX5M \
BUFX6M \
BUFX8M \
BUFX10M \
BUFX12M \
BUFX14M \
BUFX16M \
BUFX18M \
BUFX20M\
]"
fix_eco_drc -type max_transition -buffer_list $PT_setup_fix_cell -methods {size_cell insert_buffer}
fix_eco_timing -type setup -buffer $PT_setup_fix_cell -slack_lesser_than -0.000 -pba_mode exhaustive -methods {size_cell}
fix_eco_timing -type hold -buffer $PT_hold_fix_cell -slack_lesser_than -0.000 -pba_mode exhaustive -methods {size_cell insert_buffer} -verbose -setup_margin 0.5
write_changes -format icctcl -output ./timing_eco/${stage}_${corner}.tcl

restore_session ./session/scan_min.session/
set_dont_use [get_lib_cells {*/CLK* */*EDFF* */*TBUF* */*SDFFTR* */*XL* */*TIE*}]
set_dont_touch [get_lib_cells {*/CLK*}]
set PT_setup_fix_cell   "[list \
BUFX10M \
BUFX12M \
BUFX14M \
BUFX16M \
BUFX18M \
BUFX20M \
BUFX24M \
BUFX2M \
BUFX3M \
BUFX4M \
BUFX5M \
BUFX6M \
BUFX8M\
]"
set PT_hold_fix_cell    "[list \
DLY1X1M \
DLY1X4M \
DLY2X1M \
DLY2X4M \
DLY3X1M \
DLY3X4M \
DLY4X1M \
DLY4X4M \
BUFX2M \
BUFX3M \
BUFX4M \
BUFX5M \
BUFX6M \
BUFX8M \
BUFX10M \
BUFX12M \
BUFX14M \
BUFX16M \
BUFX18M \
BUFX20M\
]"
set eco_report_unfixed_reason_max_endpoints 500            
fix_eco_drc -type max_transition -buffer_list $PT_setup_fix_cell -methods {size_cell insert_buffer}
fix_eco_timing -type setup -buffer $PT_setup_fix_cell -slack_lesser_than -0.000 -pba_mode exhaustive -methods {size_cell}
fix_eco_timing -type hold -buffer $PT_hold_fix_cell -slack_lesser_than -0.000 -pba_mode exhaustive -methods {size_cell insert_buffer} -setup_margin 0.2-verbose

write_changes -format icctcl -output ./timing_eco/${stage}_${corner}.tcl


set_eco_options -physical_design_path ../output/09_ECO2/09_ECO2.def.gz -physical_tech_lib_path ../MW/sc7_tech.lef -physical_lib_path $lef_list
fix_eco_timing -type setup -buffer $PT_setup_fix_cell -slack_lesser_than -0.000 -pba_mode exhaustive -methods {size_cell insert_buffer} -physical_mode occupied_site -verbose
set lef_list "/latte/scratch/gayathri/bms5/pnr/BMS5_netlistv11_0401_icctest/MW/BMS5_ANA_CHIP_1201/BMS5_ANA_CHIP.lef /latte/scratch/gayathri/bms5/pnr/BMS5_netlistv11_0401_icctest/MW/FLS016K29DE/FLS016K29DE_M5a.lef /latte/scratch/gayathri/bms5/pnr/BMS5_netlistv11_0401_icctest/MW/FLS032K29DE/FLS032K29DE_M5a.lef /latte/scratch/gayathri/bms5/pnr/BMS5_netlistv11_0401_icctest/MW/M31HDSP030NL130P/M31HDSP030NL130P_2048X8X4CM8.lef /latte/scratch/gayathri/bms5/pnr/BMS5_netlistv11_0401_icctest/MW/PADLRCMCUDB/PADLRCMCUDB_M6t_g.lef /latte/scratch/gayathri/bms5/pnr/BMS5_netlistv11_0401_icctest/MW/sc7_l013_base_rvt.lef"

