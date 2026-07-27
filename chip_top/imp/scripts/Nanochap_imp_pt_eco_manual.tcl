set start_time [clock seconds] ; echo [clock format ${start_time} -gmt false]

echo [pwd]

print_suppressed_messages

#set stage postscan
#set corner max
#set mode functional

#sh mkdir -p ../reports/pt_postscan_max
#sh mkdir -p ../data/pt_postscan

# -----------------------------------------------------------------------------------
# Setup the Target Technology
# -----------------------------------------------------------------------------------
set dc_sel  DC;#PT doesn't need routing information
source -echo -verbose ../scripts/design_config.tcl

# ------------------------------------------------------------------------------
# Set-up Target Technology
# ------------------------------------------------------------------------------

source -echo -verbose ../scripts/Nanochap_imp_tech.tcl

# ------------------------------------------------------------------------------
# Set-up Target/Link Libraries
# ------------------------------------------------------------------------------

set_app_var search_path [concat . $stdcell_search_path $flash_search_path $io_search_path $ana_search_path $search_path]
if {$corner == "max"} {
    lappend link_path * $stdcell_library(db,$slow_corner_pvt) $flash_max_library $io_max_library $ana_max_library
}
if {$corner == "min"} {
    lappend link_path * $stdcell_library(db,$fast_corner_pvt) $flash_min_library $io_min_library $ana_min_library
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
set timing_update_status_level high

# -----------------------------------------------------------------------------------
# Read design and sdc
# -----------------------------------------------------------------------------------
read_verilog ../data/synthesis_${stage}_sdf/${rm_project_top}.$stage.v

link_design  $rm_project_top
current_design $rm_project_top

if {$mode == "scan"} {
	set eco_instance_name_prefix "uScan_"
	set eco_net_name_prefix "nScan_"
	source -echo -verbose ../scripts/Nanochap_imp_scan_constraints.tcl
} else {
	set eco_instance_name_prefix "uFunc_"
	set eco_net_name_prefix "nFunc_"
	source -echo -verbose ../data/synthesis_postscan_sdf/${rm_project_top}.postscan.sdc
}

#set_operating_conditions     -max $operating_condition_name($slow_corner_pvt) -max_lib [get_libs $target_library_name($slow_corner_pvt)]     -min $operating_condition_name($fast_corner_pvt) -min_lib [get_libs $target_library_name($fast_corner_pvt)]     -analysis_type on_chip_variation
if {$corner == "max"} {
	set_operating_conditions -library [get_libs $target_library_name($slow_corner_pvt)] $operating_condition_name($slow_corner_pvt)
}

if {$corner == "min"} {
	set_operating_conditions -library [get_libs $target_library_name($fast_corner_pvt)] $operating_condition_name($fast_corner_pvt) 
}
# Timing derate
set_timing_derate -early 0.92
set_timing_derate -late 1.05

# CPPR 
set_app_var timing_remove_clock_reconvergence_pessimism true
set_propagated_clock [filter_collection [all_clocks] defined(sources)]

#reset_timing_derate

# -----------------------------------------------------------------------------------
# Update timing and Check timing
# -----------------------------------------------------------------------------------
update_timing -full 
set fname_time [clock format [clock seconds] -format {%H%M}]
report_constraint -all_violators -nospli > ../reports/synthesis_postscan_sdf/all_vio_${stage}_${corner}_${mode}_${fname_time}.rpt
#report_timing -slack_lesser_than 0.0 -delay min_max -nosplit -input -net -cap -path full_clock > ../reports/synthesis_postscan_sdf/${rm_project_top}_${fname_time}.timing_vio_min

####### Manual part:
#Note: 
#if this is max (min) corner fixing, first fix setup (hold) violations. start with large hold (setup) margin (already 10) and reduce the margin garually to 0 whenever fix command cannot fix anymore. 
#Then perform hold (setup) fix with large setup (hold) margin and gradually reduce the margin from 10 to 0 each time fix command cannot fix anymore.
#repeat above two steps until all or most of violations are fixed and the rest can be waived or added to the constraints maybe
#then write the changes, take it through dc_shell (run Nanochap_BMS5_eco.tcl). if this is the first run on the original post scan netlist, use stage postscan_pteco
#if this is the generated netlist after one (or more) iteration of eco fix, use stage postscan_pteco2 in the dc_shell eco script
#order should be like this: first fix max on original netlist. then eco apply fix, then min timing fix on the eco netlist (use postscan_pteco in Nanochap_BMS4_pt_eco.tcl),
#then eco apply fix, then max timing fix on the eco netlist (use postscan_pteco in Nanochap_BMS4_pt_eco.tcl), and repeat until all violations are fixed. If something cannot be fixed, then maybe change constraint
exec perl ../scripts/fix_hold_delay.pl ../reports/synthesis_postscan_sdf/all_vio_${stage}_${corner}_${mode}_${fname_time}.rpt
source -e -v manual_fix_hold_timing.tcl
write_changes -verbose -format dctcl -output ../data/synthesis_postscan_sdf/${rm_project_top}.postscan.pteco_fix.tcl

print_message_info

set end_time [clock seconds]; echo [clock format ${end_time} -gmt false]

# Total script wall clock run time
echo "Time elapsed: [format %02d [expr ( $end_time - $start_time ) / 86400 ]]d\
[clock format [expr ( $end_time - $start_time ) ] -format %Hh%Mm%Ss -gmt true]"

exit
