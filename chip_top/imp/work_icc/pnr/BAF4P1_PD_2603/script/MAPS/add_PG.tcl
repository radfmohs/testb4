gui_set_pref_value -category {layout} -key {editingEnableSnapping} -value {false}
remove_route_by_type -pg_ring -pg_strap -pg_std_cell_pin_conn -pg_macro_io_pin_conn -signal_detail_route -user_enter -pg_user -signal_user -signal
remove_net_routing VPP
########PG pin connection of macros########
gui_start
gui_set_pref_value -category {layout} -key {editingEnableSnapping} -value {false}
#g create_rectangular_rings  -nets  {VSS_DIG VDD_DIG}  -left_offset 2.0 -left_segment_layer M6 -left_segment_width 6.0 -skip_right_side -skip_bottom_side -top_offset 2.0 -top_segment_layer M5 -top_segment_width 6.0
#source -e -v ./script/MAPS/FL_SR_ANA_1512.tcl

source -e -v ./script/MAPS/io_routing.tcl
gui_set_pref_value -category {layout} -key {editingEnableSnapping} -value {true}

########################### PG Rail####################


########create routing blkgs over hard macro#########
source -e -v ./routing_blockages.tcl
########################################################


#M5 mesh
create_power_straps  -direction horizontal  -nets  {VDD_DIG_SW VSS_DIG_SW}  -layer M5 -width 6.000 -configure step_and_stop  -step 74 -stop 2232 -pitch_within_group 7.01 -keep_floating_wire_pieces  -clip_at_top_cell_boundaries  -do_not_merge_targets  -optimize_wire_locations  -do_not_route_over_macros  -mark_as_std_cell_pin_connections  -within_voltage_areas [get_voltage_areas {PD_SW}] -exclude_voltage_areas  [get_voltage_areas {DEFAULT_VA}]

create_power_straps  -direction horizontal  -start_at_offset 0.000 -nets  {VDD_DIG_AO VSS_DIG_AO}  -layer M5 -width 6 -configure step_and_stop  -step 74 -stop 2232 -pitch_within_group 7.01 -keep_floating_wire_pieces  -extend_for_multiple_connections  -extension_gap 20 -do_not_route_over_macros -mark_as_std_cell_pin_connections -do_not_merge_targets -exclude_voltage_areas {PD_SW}

#M4 mesh
create_power_straps  -direction vertical  -start_at_offset 69.765 -nets  {VSS_DIG_SW VDD_DIG_SW}  -layer M4 -width 5 -configure step_and_stop  -step 97.625  -num_groups 24 -stop 1212.040 -pitch_within_group 5.24 -keep_floating_wire_pieces  -do_not_route_over_macros  -extend_for_multiple_connections  -extension_gap 20 -mark_as_std_cell_pin_connections -do_not_merge_targets -within_voltage_areas {PD_SW}

create_power_straps  -direction vertical  -start_at_offset 0.0 -nets  {VSS_DIG_AO VDD_DIG_AO}  -layer M4 -width 5 -configure step_and_stop  -step 97.625  -num_groups 24 -stop 2232.000 -pitch_within_group 5.24 -keep_floating_wire_pieces  -do_not_route_over_macros  -extend_for_multiple_connections  -extension_gap 20 -mark_as_std_cell_pin_connections -do_not_merge_targets -exclude_voltage_areas {PD_SW}


##add rblkg between pads and core:
create_routing_blockage -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage} -bbox {{0.015 675.445} {221.980 2449.995}}
create_routing_blockage -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage} -bbox {{221.980 2231.995} {1959.610 2450.000}}

##############################stdcells base routing#############################

preroute_standard_cells -nets  {VSS_DIG_AO VDD_DIG_AO} -connect horizontal  -skip_macro_pins  -skip_pad_pins  -avoid_merging_vias  -no_via_to_boundary_pin -do_not_route_over_macros  -fill_empty_rows  -exclude_voltage_areas [get_voltage_areas {PD_SW}] -port_filter_mode off -cell_master_filter_mode off -cell_instance_filter_mode off -voltage_area_filter_mode off -route_type {P/G Std. Cell Pin Conn}

preroute_standard_cells -nets  {VSS_DIG_SW VDD_DIG_SW} -connect horizontal  -skip_macro_pins  -skip_pad_pins  -avoid_merging_vias  -no_via_to_boundary_pin -do_not_route_over_macros  -fill_empty_rows  -within_voltage_areas [get_voltage_areas {PD_SW}] -port_filter_mode off -cell_master_filter_mode off -cell_instance_filter_mode off -voltage_area_filter_mode off -route_type {P/G Std. Cell Pin Conn}


################################################################################


