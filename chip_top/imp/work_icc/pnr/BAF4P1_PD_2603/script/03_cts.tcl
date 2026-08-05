set STAGE "03_cts"
echo "\n####  BEGIN POINT:  $STAGE"
set PREV    "01_place_opt"

################################################################################
# General ICC settings
source -e -v ./PROJECT.tcl

if {[file exists $rpt_path/RPT/${STAGE}] == 0}    {sh mkdir $rpt_path/RPT/${STAGE};    sh ln -snf $rpt_path/RPT/${STAGE} RPT/}
if {[file exists $rpt_path/output/${STAGE}] == 0} {sh mkdir $rpt_path/output/${STAGE}; sh ln -snf $rpt_path/output/${STAGE} output/}

close_mw_lib $design_mw_lib
open_mw_lib $design_mw_lib
copy_mw_cel -from $PREV -to $STAGE
open_mw_cel  $STAGE
link

set_attribute [all_macro_cells] is_fixed true

################################################################################
## Create corners, scenarios and OPCOND
source ${DIR}/create_scenarios.tcl
set_active_scenarios [all_scenarios]
puts "RM-Info: CTS scenarios are [get_scenarios -cts_mode true]"
#current_scenario [lindex [get_scenarios -cts_mode true] 0]
set_active_scenarios [get_scenarios -cts_mode true]
current_scenario S11_max

################################################################################
## DontTouch and DontUse settings
set_size_only   [get_flat_cell $size_only]
set_dont_touch [get_flat_cells *DNT*]
set_dont_use [get_lib_cells {*/*EDFF* */*TBUF* */*SDFFTR* */*XL* */*TIE* */BUFX* */DLY*}]

#######################
## CLOCK OPT SETTING ## 
#######################
################################################################################
## Clock Tree References
set_clock_tree_references -references  $CTS_CELLS
check_physical_design -stage pre_clock_opt -no_display -output RPT/03_check_physical_design.pre_clock_opt 

################################################################################
##  CLOCK NDR rules
define_routing_rule NDR_2W_2S -spacings "M3 0.82 M4  0.82  M5  1.64" -widths "M3 0.4 M4  0.4  M5  0.8"  
set_clock_tree_options -routing_rule NDR_2W_2S -layer_list "M3 M4 M5"  ;# -use_default_routing_for_sinks 1

################################################################################
## ICC CTS constraints and options
set_app_var cts_instance_name_prefix icc_cts
set_app_var psynopt_high_fanout_legality_limit 32
set_max_fanout 16 [get_lib_pins */*M*/* -filter "pin_direction==out"]
set_attribute [all_macro_cells] is_fixed true

set_fp_voltage_area_constraints -allow_feedthroughs true
set_fp_pin_constraints -allow_feedthroughs on -keep_buses_together on
set_clock_tree_options -max_fanout 16 
#set_clock_tree_options -max_transition 1.2   
#set_clock_tree_options -max_capacitance 1.2 
set_clock_tree_options -target_skew 0.5

#to prohibit detour of clk nets outside core:
create_route_guide -name tmp -no_signal_layers {M2 M3 M4} -coordinate {{0.000 842.740} {201.270 1872.390}} -no_snap

#######################
##         CTS       ## 
#######################
stop_gui
clock_opt -only_cts -no_clock_route
#clock_opt  -no_clock_route -optimize_dft

################################################################################
## Set clock propagation
set cur_active_scenarios [all_active_scenarios]
set_active_scenarios -all
foreach scenario [all_active_scenarios] {
  #ideal network
  current_scenario $scenario
  remove_ideal_network [all_fanout -flat -clock_tree]
  set_propagated_clock [all_clocks]
}
set_active_scenarios -all

################################################################################
## Connect PG
#source -e -v ./connect_pg.tcl
derive_pg_connection

################################################################################
## Save DB
save_mw_cel -as ${STAGE}

################################################################################
#################################################################################
return 
## REPORT
create_qor_snapshot -clock_tree -name $STAGE
redirect -file RPT/$STAGE/$STAGE.constraints {report_constraints}
#redirect -file RPT/$STAGE/$STAGE.congestion.rpt {report_congestion -effort high -grc_based}
redirect -file RPT/$STAGE/$STAGE.placement_utilization.rpt {report_placement_utilization -verbose}
redirect -file RPT/$STAGE/$STAGE.qor {report_qor}
redirect -file RPT/$STAGE/$STAGE.qor -append {report_qor -summary}
redirect -file RPT/$STAGE/$STAGE.qor_snapshot.rpt {report_qor_snapshot -no_display}
return
redirect -file RPT/$STAGE/$STAGE.max.clock_tree    {report_clock_tree -scenarios {func scan} -nosplit -summary }     ;# global skew report
redirect -file RPT/$STAGE/$STAGE.cts_skew          {report_clock_timing -scenarios {func scan} -nosplit -type skew } ;# local skew report
redirect -file RPT/$STAGE/$STAGE.cts_skew -append  {report_clock_timing -scenarios {func scan} -type latency  -launch -nosplit -setup  -verbose }
redirect -file RPT/$STAGE/$STAGE.cts_latency       {report_clock_timing -scenarios {func scan} -type latency -launch -nosplit -setup -nworst 100000 }
redirect -file RPT/$STAGE/$STAGE.cts_structure     {report_clock_tree -scenarios {func scan} -structure -nosplit }
redirect -file RPT/$STAGE/$STAGE.cts_transition    {report_clock_tree -scenarios {func scan} -drc -nosplit }

#redirect -file RPT/$STAGE.max.tim {report_timing -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay max}
#redirect -file RPT/$STAGE.min.tim {report_timing -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay min}

## OUTPUT
#extract_rc 
write_parasitics  -format SPEF -compress  -output output/$STAGE/$STAGE.spef
write_verilog -diode_ports -no_physical_only_cells  output/$STAGE/$STAGE.v


#return
echo "\n####  END POINT:  $STAGE"
