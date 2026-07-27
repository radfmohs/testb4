# ------------------------------------------------------------------------------
# Purpose : Common per-scenario settings (BAF4)
# ------------------------------------------------------------------------------

if {[shell_is_in_topographical_mode]} {
  set_tlu_plus_files -max_tluplus $tluplus_file($slow_corner_extraction) \
	               -min_tluplus $tluplus_file($fast_corner_extraction) \
	               -tech2itf_map $tf2itf_map_file

  check_tlu_plus_files
}

# ------------------------------------------------------------------------------
# Set design context
# ------------------------------------------------------------------------------

# Set the maximum fanout value on the design
set_max_fanout $max_fanout $rm_project_top

# Set the maximum transition value on the design
set_max_transition $max_transition $rm_project_top

# Set the maximum capacitance
set_max_capacitance  $max_capacitance $rm_project_top

# Load all outputs with suitable capacitance
set_load $output_load [all_outputs]

set_input_transition  $input_transition [all_inputs]

set_clock_transition $max_clock_transition [filter_collection [all_clocks] defined(sources)]

# Derive list of clock ports
set clock_ports [filter_collection [get_attribute [filter_collection [all_clocks] defined(sources)] sources] object_class==port]
set clock_pins [get_attribute [filter_collection [all_clocks] defined(sources)] sources]

# ------------------------------------------------------------------------------
# Set Operating conditions
# ------------------------------------------------------------------------------
# BC-WC analysis
if {[string match *_min $i]} {
  set_operating_conditions \
      -max $operating_condition_name($fast_corner_pvt) -max_lib [get_libs $target_library_name($fast_corner_pvt)] \
      -min $operating_condition_name($fast_corner_pvt) -min_lib [get_libs $target_library_name($fast_corner_pvt)] \
      -analysis_type on_chip_variation
}
if {[string match *_max $i]} {
  set_operating_conditions \
      -max $operating_condition_name($slow_corner_pvt) -max_lib [get_libs $target_library_name($slow_corner_pvt)] \
      -min $operating_condition_name($slow_corner_pvt) -min_lib [get_libs $target_library_name($slow_corner_pvt)] \
      -analysis_type on_chip_variation
}

group_path -name In2Reg     -from [all_inputs]
group_path -name Reg2Out    -to   [all_outputs]
group_path -name In2Out     -from [all_inputs]  -to [all_outputs]

# ------------------------------------------------------------------------------
# Additional optimization constraints
# ------------------------------------------------------------------------------

# Critical range for core (scan scenarios use the scan clock period)
if {[string match S4_* $i] == 0} {
  set_critical_range [expr {0.10 * ${hfosc_period}}] ${rm_project_top}
} else {
  set_critical_range [expr {0.10 * ${scan_clock_period}}] ${rm_project_top}
}

# Timing derate
set_timing_derate -early 0.95
set_timing_derate -late 1.05

# ------------------------------------------------------------------------------
# Compile the design
# ------------------------------------------------------------------------------
if {$generate_sdf == "sdf"} {
	set_propagated_clock [filter_collection [all_clocks] defined(sources)]
}
