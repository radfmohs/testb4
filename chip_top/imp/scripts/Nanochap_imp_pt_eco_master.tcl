set start_time [clock seconds] ; echo [clock format ${start_time} -gmt false]
echo [pwd]
print_suppressed_messages

sh mkdir -p ../data/synthesis_postscan_pteco_sdf

source -echo -verbose ../scripts/design_config.tcl
set eco_report_unfixed_reason_max_endpoints 1
set scenarios []
set corners []
lappend scenarios S11 S12 S22 S3 S4;#BAF4 modes (no CPHA)
lappend corners min max;
foreach i $scenarios {
  foreach j $corners {
      create_scenario -name ${i}_${j} -image session_${i}_${j}
      lappend all_scenarios ${i}_${j}
    }
}
set_host_options -max_cores 1 -num_processes [expr {[llength $scenarios] * [llength $corners]}]
start_hosts
current_session -all
current_scenario -all

remote_execute {update_timing}
remote_execute {update_power}
# ------------------------------------------------------------------------------
# Fix hold across all scenarios at once (power-aware)
# ------------------------------------------------------------------------------
fix_eco_timing -verbose -type hold -method {insert_buffer} -power_mode total -dynamic_scenario S11_min -leakage_scenario S11_max -slack_greater_than -10 -buffer_list {DLY4X4M BUFX4M BUFX8M BUFX10M BUFX12M BUFX14M BUFX16M BUFX20M BUFX24M BUFX32M } -cell_type {combinational} -setup_margin 0.1
remote_execute {update_power}
remote_execute {update_timing -full}
# ------------------------------------------------------------------------------
# Verify hold is clean in every scenario; re-fix if needed
# ------------------------------------------------------------------------------
set vio 1
set count 5;#to avoid an infinite loop
while {($vio) && ($count)} {
  set vio 0
  set count [expr {$count - 1}]
  foreach i $all_scenarios {
    current_scenario $i
    report_constraints -min_delay > tmp_report
    set f [open tmp_report r]
    set file_contents [read $f]
    close $f
    if {[string match "*VIOLATED*" $file_contents]} {
      set vio 1
      puts "Running hold eco again for scenario $i"
      fix_eco_timing -verbose -type hold -method {insert_buffer} -buffer_list {DLY4X4M BUFX4M BUFX8M BUFX10M BUFX12M BUFX14M BUFX16M BUFX20M BUFX24M BUFX32M } -cell_type {clock_network} 
      fix_eco_timing -verbose -type hold -method {sizing insert_buffer} -buffer_list {DLY4X4M BUFX4M BUFX8M BUFX10M BUFX12M BUFX14M BUFX16M BUFX20M BUFX24M BUFX32M } -cell_type {combinational sequential} 
    }
  }
}
# ------------------------------------------------------------------------------
# Write the single consolidated change file
# ------------------------------------------------------------------------------
if {$count != 4} {
  current_scenario -all
  exec find . -iname "*.tcl" -delete;#remove previous fixes
  remote_execute {update_power}
  fix_eco_timing -verbose -type hold -method {insert_buffer size_cell} -buffer_list {DLY4X4M BUFX4M BUFX8M BUFX10M BUFX12M BUFX14M BUFX16M BUFX20M BUFX24M BUFX32M } -cell_type {combinational}
  remote_execute {write_changes -verbose -format dctcl -output ../pteco_fix_${scenario}.tcl} -v
  #choosing the largest tcl file as the final changes file
  set find_output [exec find . -name "pteco_fix_*_m*.tcl" -type f -printf "%s\t%p\n"]
  set sorted_output [exec echo "$find_output" | sort -n -r]
  set largest_line [exec echo "$sorted_output" | head -n 1]
  set largest_path [exec echo "$largest_line" | awk "{print \$2}"]
  eval exec mv "$largest_path" ../data/synthesis_postscan_pteco_sdf/${rm_project_top}.postscan.pteco_fix.tcl
} else {
  write_changes -verbose -format dctcl -output ../data/synthesis_postscan_pteco_sdf/${rm_project_top}.postscan.pteco_fix.tcl
}
# Updated per-scenario SDC for sign-off (relative to per-scenario remote cwd)
#remote_execute {write_sdc -version 2.0 -nosplit ../../data/synthesis_postscan_${generate_sdf}/${rm_project_top}.postscan.${scenario}.sdc_2} -v
if {$count} {
  puts "All corner timing violations fixed"
} else {
  puts "Error: some corner timing violations NOT fixed"
}
report_constraints
report_qor
report_analysis_coverage
remote_execute {report_timing -slack_lesser_than 0.0 -delay_type min_max} -v
remote_execute {report_power} -v
stop_hosts
remove_host_options
print_message_info
set end_time [clock seconds]; echo [clock format ${end_time} -gmt false]
# Total script wall clock run time
echo "Time elapsed: [format %02d [expr ( $end_time - $start_time ) / 86400 ]]d\
[clock format [expr ( $end_time - $start_time ) ] -format %Hh%Mm%Ss -gmt true]"
exit
