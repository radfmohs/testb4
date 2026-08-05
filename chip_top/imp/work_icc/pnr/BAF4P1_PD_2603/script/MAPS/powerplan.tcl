#PNS:
remove_route_by_type -pg_ring -pg_strap -pg_std_cell_pin_conn -pg_macro_io_pin_conn -signal_detail_route -signal_user 
set_fp_rail_constraints -set_global   -keep_floating_segments -no_routing_over_hard_macros
set_fp_rail_constraints  -set_ring -nets  {VDD_DIG_SW VSS_DIG_SW VDD_DIG_SW VSS_DIG_SW}  -horizontal_ring_layer { M5 } -vertical_ring_layer { M4 } -ring_spacing 1 -ring_offset 2 -extend_strap core_ring

#set_fp_rail_constraints  -skip_ring
set_fp_rail_constraints -add_layer  -layer M5 -direction horizontal -max_pitch 77.33 -min_pitch 77.33 -max_width 6 -min_width 6 -spacing minimum
set_fp_rail_constraints -add_layer  -layer M4 -direction vertical -max_pitch 81.955 -min_pitch 81.955 -max_width 5 -min_width 5 -spacing minimum

set_fp_rail_voltage_area_constraints -voltage_area PD_SW -keep_floating_segments -no_routing_over_hard_macros -global
set_fp_rail_voltage_area_constraints -voltage_area DEFAULT_VA -keep_floating_segments -no_routing_over_hard_macros -global
set_fp_rail_voltage_area_constraints -voltage_area PD_SW -layer M5 -direction horizontal -max_pitch 77.33 -min_pitch 77.33 -max_width 6 -min_width 6 -spacing minimum
set_fp_rail_voltage_area_constraints -voltage_area PD_SW -layer M4 -direction vertical -max_pitch 81.955 -min_pitch 81.955 -max_width 5 -min_width 5 -spacing minimum
set_fp_rail_voltage_area_constraints -voltage_area DEFAULT_VA -layer M5 -direction horizontal -max_pitch 77.33 -min_pitch 77.33 -max_width 6 -min_width 6 -spacing minimum
set_fp_rail_voltage_area_constraints -voltage_area DEFAULT_VA -layer M4 -direction vertical -max_pitch 81.955 -min_pitch 81.955 -max_width 5 -min_width 5 -spacing minimum


synthesize_fp_rail -voltage_areas PD_SW -nets {VDD_DIG VSS_DIG} -voltage_supply 1.5 -synthesize_power_plan -analyze_power -use_pins_as_pads -top_level_only -create_virtual_rail M1
synthesize_fp_rail -voltage_areas DEFAULT_VA -nets {VDD_DIG_AO VSS_DIG_AO} -voltage_supply 1.5 -synthesize_power_plan -analyze_power -use_pins_as_pads -top_level_only -create_virtual_rail M1
#powerplan:
#source -e -v ./script/MAPS/ioandrings_0406.tcl
source -e -v ./script/MAPS/ioandrings_0207.tcl
remove_power_plan_strategy -all
remove_power_plan_regions -all
create_power_plan_regions -voltage_area PD_SW PD_SW
create_power_plan_regions -polygon {{222.000 1820.015} {361.715 1820.015} {361.715 1649.955} {222.000 1649.955}} AO1
create_power_plan_regions -polygon {{1134.315 2192.870} {1134.315 2232.000} {1208.275 2232.000} {1208.275 2192.870}} AO2
create_power_plan_regions -polygon {{1069.425 1653.240} {1069.425 1675.385} {1167.195 1675.385} {1167.195 1653.240}} AO3
create_power_plan_regions -polygon {{779.480 1653.240} {779.480 1672.395} {835.090 1672.395} {835.090 1653.240}} AO4
create_power_plan_regions -polygon {{758.130 1404.405} {758.130 1453.815} {774.730 1453.815} {774.730 1404.405}} AO5
create_power_plan_regions -polygon {{748.335 1103.255} {748.335 1203.230} {774.730 1203.230} {774.730 1103.255}} AO6
create_power_plan_regions -polygon {{755.720 877.800} {755.720 943.690} {774.730 943.690} {774.730 877.800}} AO7
create_power_plan_regions -polygon {{686.420 842.610} {686.420 857.235} {733.955 857.235} {733.955 842.610}} AO8
create_power_plan_regions -polygon {{467.380 842.610} {467.380 854.365} {535.465 854.365} {535.465 842.610}} AO9
create_power_plan_regions -polygon {{222.000 1238.635} {222.000 1282.055} {238.880 1282.055} {238.880 1238.635} {222.000 1238.635}} AO10

set_power_plan_strategy PD_SW_strategy -nets {VDD_DIG_SW VSS_DIG_SW} -power_plan_regions PD_SW -template /projects/libs/baf4/digital_work/GY_BAF4_DIG/pnr/BAF4_1505/script/MAPS/PD_SW_template.tcl
set_power_plan_strategy AO_strategy -nets {VDD_DIG_AO VSS_DIG_AO} -power_plan_regions {AO1 AO2 AO3 AO4 AO5 AO6 AO7 AO8 AO9 AO10} -template /projects/libs/baf4/digital_work/GY_BAF4_DIG/pnr/BAF4_1505/script/MAPS/AO_template.tcl
compile_power_plan -strategy {AO_strategy}

source ./routing_blkg.tcl

compile_power_plan -strategy {PD_SW_strategy}
set_preroute_drc_strategy -min_layer M1 -max_layer M4


preroute_standard_cells -nets  {VSS_DIG_SW VDD_DIG_SW}  -extend_for_multiple_connections  -extension_gap 0.0 -connect horizontal  -skip_macro_pins  -skip_pad_pins  -avoid_merging_vias  -no_via_to_boundary_pin -do_not_route_over_macros  -fill_empty_rows -port_filter_mode off -cell_master_filter_mode off -cell_instance_filter_mode off -voltage_area_filter_mode off -route_type {P/G Std. Cell Pin Conn} -within_voltage_areas {PD_SW}
preroute_standard_cells -nets  {VSS_DIG_AO VDD_DIG_AO}  -extend_for_multiple_connections  -extension_gap 0.0 -connect horizontal  -skip_macro_pins  -skip_pad_pins  -avoid_merging_vias  -no_via_to_boundary_pin -do_not_route_over_macros  -fill_empty_rows -port_filter_mode off -cell_master_filter_mode off -cell_instance_filter_mode off -voltage_area_filter_mode off -route_type {P/G Std. Cell Pin Conn} -exclude_voltage_areas {PD_SW}


#set_fp_voltage_area_constraints -allow_feedthroughs true

set_fp_rail_voltage_area_constraints -voltage_area PD_SW -keep_floating_segments -no_routing_over_hard_macros -global -allow_routing_over_voltage_area
set_fp_rail_voltage_area_constraints -voltage_area DEFAULT_VA -keep_floating_segments -no_routing_over_hard_macros -global -allow_routing_over_voltage_area

