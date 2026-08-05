set STAGE   "04_post_cts"
echo "\n####  BEGIN POINT:  $STAGE"
set PREV    "03_cts"

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

create_placement_blockage -coordinate {{224.460 842.920} {627.080 1178.710}} -name mod1 -type partial -blocked_percentage 10
create_placement_blockage -coordinate {{1135.480 1655.130} {1211.330 2183.210}} -name mod2 -type partial -blocked_percentage 10
create_placement_blockage -coordinate {{563.120 1178.710} {627.080 1236.110}} -name mod3 -type partial -blocked_percentage 10

remove_route_guide ANA_PIN_4
set_keepout_margin -all_macros -type hard -outer {10 10 10 10} 
set_keepout_margin -all_macros -type soft -outer {20 20 20 20}

################################################################################
## Create corners, scenarios and OPCOND
source ./create_scenarios.tcl
set_active_scenarios -all
foreach scenario [all_active_scenarios] {
  current_scenario $scenario
  remove_ideal_network [all_fanout -flat -clock_tree]
  set_propagated_clock [all_clocks]
}
current_scenario S11_max

################################################################################
## DontTouch and DontUse settings
 set_dont_use    [get_lib_cells  $dont_use]
 set_size_only   [get_flat_cell $size_only]
set_dont_touch [get_flat_cells *DNT*]
set_dont_use [get_lib_cells {*/*EDFF* */*TBUF* */*SDFFTR* */*XL* */*TIE* */BUFX* */DLY*}]

#######################
## CLOCK OPT SETTING ## 
#######################
################################################################################
## Clock Tree References
#gdefine_routing_rule NDR_2W_2S -spacings "M3 0.82 M4  0.82  M5  1.64" -widths "M3 0.4 M4  0.4  M5  0.8"  

set_clock_tree_options -routing_rule NDR_2W_2S -layer_list "M3 M4 M5"  -use_default_routing_for_sinks 1

################################################################################
## ICC CLOCKOPT settings
set_ignored_layers -max_routing_layer M5
set_app_var psynopt_high_fanout_legality_limit 32
set_max_fanout 16 [get_lib_pins */*M*/* -filter "pin_direction==out"]
set_app_var compile_instance_name_prefix icc_pco 
extract_rc
#set_fp_pin_constraints -allow_feedthroughs on -keep_buses_together on
#set_fp_voltage_area_constraints -allow_feedthroughs true
#######################
##      CLOCK OPT    ## 
#######################
#-optimize_dft# CLOCK TOP
clock_opt -no_clock_route  -optimize_dft 

route_zrt_group -all_clock_nets -reuse_existing_global_route true -stop_after_global_route true

set_si_options -delta_delay false -min_delta_delay false -route_xtalk_prevention false

route_zrt_group -all_clock_nets -reuse_existing_global_route true
save_mw_cel -as ${STAGE}_opt1

clock_opt  -only_psyn -area_recovery -power 

remove_route_guide tmp
################################################################################
## Connect PG
#source ./connect_pg.tcl
derive_pg_connection

################################################################################
## Save DB
save_mw_cel -as ${STAGE}
################################################################################
#################################################################################
return

## REPORT
create_qor_snapshot -clock_tree -name $STAGE

redirect -file RPT/$STAGE/$STAGE.power            {report_power -nosplit -scenario {func}}
redirect -file RPT/$STAGE/$STAGE.qor              {report_qor}
redirect -file RPT/$STAGE/$STAGE.qor -append      {report_qor -summary}
redirect -file RPT/$STAGE/$STAGE.qor_snapshot.rpt {report_qor_snapshot -no_display}
redirect -file RPT/$STAGE/$STAGE.constraints      {report_constraints -nosplit -scenario "func scan"}
redirect -file RPT/$STAGE/$STAGE.max_fanout       {report_constraints -nosplit -all_violators -max_fanout      -verbose -scenario "func scan"}
redirect -file RPT/$STAGE/$STAGE.max_capacitannce {report_constraints -nosplit -all_violators -max_capacitance -verbose -scenario "func scan"}
redirect -file RPT/$STAGE/$STAGE.max_transition   {report_constraints -nosplit -all_violators -max_transition  -verbose -scenario "func scan" }

redirect -file RPT/$STAGE/$STAGE.placement_utilization.rpt {report_placement_utilization -verbose}
redirect -file RPT/$STAGE/$STAGE.max.clock_tree    {report_clock_tree -scenarios {func scan} -nosplit -summary }     ;# global skew report
redirect -file RPT/$STAGE/$STAGE.cts_skew          {report_clock_timing -scenarios {func scan} -nosplit -type skew } ;# local skew report
redirect -file RPT/$STAGE/$STAGE.cts_skew -append  {report_clock_timing -scenarios {func scan} -type latency -nosplit -verbose }
redirect -file RPT/$STAGE/$STAGE.cts_latency       {report_clock_timing -scenarios {func scan} -type latency -launch -nosplit -setup -nworst 100000 }
redirect -file RPT/$STAGE/$STAGE.cts_structure     {report_clock_tree -scenarios {func scan} -structure -nosplit }
redirect -file RPT/$STAGE/$STAGE.cts_transition    {report_clock_tree -scenarios {func scan} -drc -nosplit }

return
## OUTPUT
#extract_rc 
if {0} {
write_parasitics  -format SPEF -compress  -output ./output/$STAGE/$STAGE.spef
write_verilog -diode_ports -no_physical_only_cells  ./output/$STAGE/$DESIGN_NAME.output.v -macro_definition


#redirect -file RPT/$STAGE.max.tim {report_timing -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay max}
#redirect -file RPT/$STAGE.min.tim {report_timing -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay min}
redirect -file RPT/$STAGE/$STAGE.sys_max.tim {report_timing -scenarios func -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay max}
redirect -file RPT/$STAGE/$STAGE.sys_min.tim {report_timing -scenarios func -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay min}
redirect -file RPT/$STAGE/$STAGE.dft_max.tim {report_timing -scenarios scan -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay max}
redirect -file RPT/$STAGE/$STAGE.dft_min.tim {report_timing -scenarios scan -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay min}
redirect -file RPT/$STAGE/${STAGE}_full_clock.sys_max.tim {report_timing -path_type full_clock_expanded -scenarios func -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay max}
redirect -file RPT/$STAGE/${STAGE}_full_clock.sys_min.tim {report_timing -path_type full_clock_expanded -scenarios func -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay min}
redirect -file RPT/$STAGE/${STAGE}_full_clock.dft_max.tim {report_timing -path_type full_clock_expanded -scenarios scan -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay max}
redirect -file RPT/$STAGE/${STAGE}_full_clock.dft_min.tim {report_timing -path_type full_clock_expanded -scenarios scan -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay min}
}

echo "\n####  END POINT:  $STAGE"
