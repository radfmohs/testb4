set STAGE "07_post_route"
echo "\n####  BEGIN POINT:  $STAGE \n"
set PREV    "06_route"

################################################################################
# General ICC settings
source -e -v ./PROJECT.tcl

if {[file exists $rpt_path/RPT/${STAGE}] == 0}    {sh mkdir $rpt_path/RPT/${STAGE};    sh ln -snf $rpt_path/RPT/${STAGE} RPT/}
if {[file exists $rpt_path/output/${STAGE}] == 0} {sh mkdir $rpt_path/output/${STAGE}; sh ln -snf $rpt_path/output/${STAGE} output/}

close_mw_cel  -all_views
close_mw_lib $design_mw_lib
open_mw_lib $design_mw_lib
copy_mw_cel -from $PREV -to $STAGE
open_mw_cel  $STAGE
link 

################################################################################
## DontTouch and DontUse settings
#g set_dont_use    [get_lib_cells  $dont_use]
set_size_only   [get_flat_cell $size_only]
set_dont_touch [get_flat_cells *DNT*]
#set_dont_use [get_flat_cells {*EDFF* DLY* TBUF* SDFFTR* *XL* TIE*}]
set_dont_use [get_lib_cells {*/*EDFF* */*TBUF* */*SDFFTR* */*XL* */*TIE* */CLK*}]
set_attribute [get_flat_nets -all -filter net_type==Clock] dont_touch 1

################################################################################
## VPP and IO PAD pins routing freeze
## SKIP ROUTE
set IO_PADNET     [get_nets -of [get_pins -filter "name==P" -of [get_flat_cells -filter "mask_layout_type==io_pad"]]]
set_net_routing_rule -reroute freeze  $IO_PADNET

################################################################################
## Create corners, scenarios and OPCOND
source ./script/create_scenarios.tcl
set_active_scenarios -all
foreach scenario [all_active_scenarios] {
  current_scenario $scenario
  remove_ideal_network [all_fanout -flat -clock_tree]
  set_propagated_clock [all_clocks]
}
current_scenario S11_max

################################################################################
##Routing constraints
set_ignored_layers -max_routing_layer M5
set_app_var psynopt_high_fanout_legality_limit 32
set_delay_calculation_options -postroute arnoldi -arnoldi_effort medium
set_app_var compile_instance_name_prefix NNC_postRoute
set_route_options -same_net_notch check_and_fix
set_parameter -module droute -name cornerSpacingMode -value 1
set_route_zrt_detail_options  -antenna_on_iteration  15
#set_route_zrt_detail_options  -antenna_fixing_preference use_diodes
#set_route_zrt_detail_options  -insert_diodes_during_routing  true
set_route_zrt_detail_options  -antenna_fixing_preference hop_layers
set_route_zrt_detail_options  -diode_libcell_names  $ANTENNA
set_app_var routeopt_drc_over_timing true

################################################################################
##Extra PD options
set_keepout_margin -all_macros -outer {5 5 5 5} 
set_keepout_margin -all_macros -type soft -outer {20 20 20 20}
set pin_sig [get_pins -all -filter "(name==D2A_SDM_CLK || name==A2D_SDM_OUT || name=~D2A_Z* || name=~A2D_Z*) && name!~*SEL* && name!~*EN" -of [get_cells u_top_ana]]
set_net_routing_rule -reroute normal  [get_nets -of $pin_sig ]

## Remove Route guide util
remove_route_guide ROUTE_UTIL*
#gaya added options:
remove_route_guide ANA_PIN*
set_max_fanout 16 [get_lib_pins */*M*/* -filter "pin_direction==out"]

########################################
#               ROUTE_OPT	       #
########################################
route_opt -incremental -only_design_rule
route_opt -incremental -effort high -area_recovery -power

########################################
#   Additional route_opt practices
########################################
# Using the following flow can help further improvme QoR in postroute. 
# These steps come after the initial "route_opt -incremental":
set_app_var routeopt_enable_aggressive_optimization true
route_opt -incremental -xtalk_reduction
set_app_var routeopt_restrict_tns_to_size_only true
route_opt -incremental

## To limit route_opt to specific optimizations :
#  route_opt -incremental -only_xtalk_reduction : only xtalk reduction 
#  route_opt -incremental -only_hold_time : only hold fixing 
#  route_opt -incremental -(only_)wire_size : runs wire sizing which fixes timing by applying NDR's from define_routing_rule

################################################################################
## Connect PG
#source ${DIR}/connect_pg.tcl
derive_pg_connection 

################################################################################
##Save DB
save_mw_cel -as $STAGE

################################################################################
#################################################################################
return
## VERIFY
#verify_zrt_route -report_all_open_nets true
verify_lvs -use_notch_gap_fill_cell -check_single_pin_net_for_floating_port -check_single_pin_net_for_floating_net -check_floating_port_on_null_net -check_open_locator -check_short_locator

verify_pg_nets
verify_pg_nets  -pad_pin_connection all


########################################
#           REPORT DESIGN              #
########################################
create_qor_snapshot -clock_tree -name $STAGE
redirect -file RPT/$STAGE.qor_snapshot.rpt {report_qor_snapshot -no_display}

if {1} {
redirect -file RPT/$STAGE/$STAGE.placement_utilization.rpt {report_placement_utilization -verbose}
redirect -file RPT/$STAGE/$STAGE.power            {report_power -nosplit -scenario {system}}
redirect -file RPT/$STAGE/$STAGE.qor              {report_qor}
redirect -file RPT/$STAGE/$STAGE.qor -append      {report_qor -summary}
redirect -file RPT/$STAGE/$STAGE.constraints      {report_constraints -nosplit -scenario "system scan"}
redirect -file RPT/$STAGE/$STAGE.max_fanout       {report_constraints -nosplit -all_violators -max_fanout      -verbose -scenario "system scan"}
redirect -file RPT/$STAGE/$STAGE.max_capacitannce {report_constraints -nosplit -all_violators -max_capacitance -verbose -scenario "system scan"}
redirect -file RPT/$STAGE/$STAGE.max_transition   {report_constraints -nosplit -all_violators -max_transition  -verbose -scenario "system scan" }
}
redirect -file RPT/$STAGE/$STAGE.clock_timing {report_clock_timing -nosplit -type skew -scenarios [get_scenarios -active true -setup true]} ;# local skew report
redirect -tee -file RPT/$STAGE/$STAGE.max.clock_tree {report_clock_tree -nosplit -summary -scenarios [get_scenarios -active true -setup true]}     ;# global skew report
redirect -tee -file RPT/$STAGE/$STAGE.min.clock_tree {report_clock_tree -nosplit -operating_condition min -summary -scenarios [get_scenarios -active true -hold true]}     ;# min global skew report

## OUTPUT
if {1} {
extract_rc -coupling_cap
write_parasitics  -format SPEF -compress  -output output/$STAGE/$STAGE.spef
write_verilog -diode_ports -no_physical_only_cells output/$STAGE/$DESIGN_NAME.output.v
}

return
if {0} {
#redirect -file RPT/$STAGE.max.tim {report_timing -nosplit -unique_pins -crosstalk_delta -scenario [all_active_scenarios] -capacitance -transition_time -input_pins -nets -delay max}
#redirect -file RPT/$STAGE.min.tim {report_timing -nosplit -unique_pins -crosstalk_delta -scenario [all_active_scenarios] -capacitance -transition_time -input_pins -nets -delay min}
redirect -file RPT/$STAGE/$STAGE.func_max.tim {report_timing -scenarios func -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay max}
redirect -file RPT/$STAGE/$STAGE.func_min.tim {report_timing -scenarios func -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay min}
redirect -file RPT/$STAGE/$STAGE.scan_max.tim {report_timing -scenarios scan -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay max}
redirect -file RPT/$STAGE/$STAGE.scan_min.tim {report_timing -scenarios scan -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay min}
redirect -file RPT/$STAGE/${STAGE}_full_clock.sys_max.tim {report_timing -path_type full_clock_expanded -scenarios system -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay max}
redirect -file RPT/$STAGE/${STAGE}_full_clock.sys_min.tim {report_timing -path_type full_clock_expanded -scenarios system -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay min}
redirect -file RPT/$STAGE/${STAGE}_full_clock.dft_max.tim {report_timing -path_type full_clock_expanded -scenarios scan -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay max}
redirect -file RPT/$STAGE/${STAGE}_full_clock.dft_min.tim {report_timing -path_type full_clock_expanded -scenarios scan -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay min}
}


echo "\n####  END POINT:  $STAGE"
