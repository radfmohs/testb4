set start_time [clock seconds] ; echo [clock format ${start_time} -gmt false]
echo [pwd]
print_suppressed_messages
# ------------------------------------------------------------------------------
# Per-scenario PrimeTime sign-off (BAF4)
# ------------------------------------------------------------------------------
# Runs on the post-ECO netlist using the master-generated .sdc_2 for this
# scenario. Generates timing reports and the back-annotated SDF.
#
# Expected invocation variables (set by the run wrapper):
#   set stage    postscan
#   set scenario S11_max      ;# one of S11/S12/S22/S3/S4 _min|_max
# ------------------------------------------------------------------------------
#set stage postscan
#set scenario S11_max
set dc_sel  DC;#PT doesn't need routing information
set reports ../reports/pt_${scenario}
sh mkdir -p $reports
# -----------------------------------------------------------------------------------
# Setup the configuration
# -----------------------------------------------------------------------------------
source -echo -verbose ../scripts/design_config.tcl
# -----------------------------------------------------------------------------------
# Setup the Target Technology
# -----------------------------------------------------------------------------------
source -echo -verbose ../scripts/Nanochap_imp_tech.tcl
# -----------------------------------------------------------------------------------
# Search path and link path
# -----------------------------------------------------------------------------------
set_app_var search_path [concat . $stdcell_search_path $flash_mod_search_path $io_search_path $ana_search_path $search_path]
if {[string match *_max $scenario]} {
    set_app_var link_path [concat * $stdcell_library(db,$slow_corner_pvt) $flash_mod_max_library $io_max_library $ana_max_library $stdcell_library(db,$fast_corner_pvt) $flash_min_library $io_min_library $ana_min_library]
}
if {[string match *_min $scenario]} {
    set_app_var link_path [concat * $stdcell_library(db,$fast_corner_pvt) $flash_min_library $io_min_library $ana_min_library $stdcell_library(db,$slow_corner_pvt) $flash_mod_max_library $io_max_library $ana_max_library]
}
# -----------------------------------------------------------------------------------
# PT Setting
# -----------------------------------------------------------------------------------
set timing_disable_clock_gating_checks false
set timing_slew_propagation_mode worst_slew
set rc_degrade_min_slew_when_rd_less_than_met true
set si_enable_analysis false
set si_xtalk_double_switching_mode clock_network
set report_default_significant_digits 4
# -----------------------------------------------------------------------------------
# Read design and sdc
# -----------------------------------------------------------------------------------
read_verilog ../data/synthesis_postscan_pteco_sdf/${rm_project_top}.postscan_pteco.v
link_design  $rm_project_top
current_design $rm_project_top
source -echo -verbose ../data/synthesis_postscan_sdf/${rm_project_top}.postscan.scre_${scenario}.sdc
# -----------------------------------------------------------------------------------
# Clock Tree Synthesis Section
# -----------------------------------------------------------------------------------
set_propagated_clock [filter_collection [all_clocks] defined(sources)]
# -----------------------------------------------------------------------------------
# Operation Condition Setting
# -----------------------------------------------------------------------------------
if {[string match *_max $scenario]} {
	set_operating_conditions -library [get_libs $target_library_name($slow_corner_pvt)] $operating_condition_name($slow_corner_pvt)
}
if {[string match *_min $scenario]} {
	set_operating_conditions -library [get_libs $target_library_name($fast_corner_pvt)] $operating_condition_name($fast_corner_pvt)
}
# Timing derate
set_timing_derate -early 0.95
set_timing_derate -late 1.05
# CPPR
set timing_remove_clock_reconvergence_pessimism true
# -----------------------------------------------------------------------------------
# Update timing and Check timing
# -----------------------------------------------------------------------------------
update_timing -full
check_timing -verbose > ${reports}/check_timing.rpt
check_constraints -verbose > ${reports}/check_constraints.rpt
# -----------------------------------------------------------------------------------
# Report timing
# -----------------------------------------------------------------------------------
report_timing -slack_lesser_than 0.0 -delay min_max -nosplit -input -net -cap -path full_clock > ${reports}/report_timing.rpt
report_clock -skew -attribute > ${reports}/clock_skew.rpt
report_analysis_coverage > ${reports}/analysis_coverage.rpt
report_analysis_coverage -status_details untested -check_type setup > ${reports}/untested_setup.rpt
report_analysis_coverage -status_details untested -check_type hold > ${reports}/untested_hold.rpt
report_analysis_coverage -status_details untested -check_type recovery > ${reports}/untested_recovery.rpt
report_analysis_coverage -status_details untested -check_type removal > ${reports}/untested_removal.rpt
report_analysis_coverage -status_details untested -check_type min_period > ${reports}/untested_min_period.rpt
report_analysis_coverage -status_details untested -check_type min_pulse_width > ${reports}/untested_min_pulse_width.rpt
report_analysis_coverage -status_details untested -check_type clock_gating_setup > ${reports}/untested_clock_gating_setup.rpt
report_analysis_coverage -status_details untested -check_type clock_gating_hold > ${reports}/untested_clock_gating_hold.rpt
report_analysis_coverage -status_details untested -check_type out_setup > ${reports}/untested_out_setup.rpt
report_analysis_coverage -status_details untested -check_type out_hold > ${reports}/untested_out_hold.rpt
report_constraint -all_violators > ${reports}/all_vio_${scenario}.rpt
report_annotated_parasitics -max_nets 100 -list_not_annotated > ${reports}/not_annotated.rpt
report_global_timing > ${reports}/global_timing.rpt
write_sdf -version 3.0 ../data/synthesis_postscan_pteco_sdf/${rm_project_top}.postscan_pteco_${scenario}.sdfv3 -context verilog -exclude_cells {u_top_dig/flash_ctrl_top_inst/u_32k}
#if {[string match S4_* $scenario]} {
#    write_sdc -version 2.0 -nosplit ../data/synthesis_postscan_pteco_sdf/${rm_project_top}.postscan_pteco.${scenario}.sdc
#}
# -----------------------------------------------------------------------------------
# Recovery/removal check without async clock groups (BAF4 group names)
# -----------------------------------------------------------------------------------
if {[string match S1?_* $scenario]} {
	remove_clock_groups -asynchronous -name async_grp;#normal-mode async group
}
if {[string match S3_* $scenario]} {
	remove_clock_groups -asynchronous -name async_grp_bist;#bist async group
}
if {([string match S1?_* $scenario]) || ([string match S3_* $scenario])} {
	update_timing
	report_constraint -all_violators -recovery -removal -verbose -include_hierarchical_pins > ${reports}/recrem.rpt
	report_timing -slack_lesser_than 0 -delay_type min_max -max_paths 50  > ${reports}/report_timing_no_async.rpt
}
print_message_info
set end_time [clock seconds]; echo [clock format ${end_time} -gmt false]
# Total script wall clock run time
echo "Time elapsed: [format %02d [expr ( $end_time - $start_time ) / 86400 ]]d\
[clock format [expr ( $end_time - $start_time ) ] -format %Hh%Mm%Ss -gmt true]"
exit
