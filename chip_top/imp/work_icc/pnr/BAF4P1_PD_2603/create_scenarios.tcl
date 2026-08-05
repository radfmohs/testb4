    remove_scenario -all
###############################################################
###############################################################
## SCAN SCENARIO
create_scenario "S4_min"
set auto_link_disable true

read_sdc -echo  $S4_min > log/${STAGE}_S4_min.log
if {$STAGE=="03_cts"} { remove_clock_uncertainty [all_clocks] }


set auto_link_disable false

set_operating_conditions -analysis_type bc_wc -max $min_cond -max_library $min_lib  -min $min_cond -min_library $min_lib
 
set_voltage 0.0 -object_list {VSS_DIG_SW VSS_DIG_AO TOP.primary.ground PD_SW.primary.ground}
set_voltage 1.65 -object_list {VDD_DIG_AO VDD_DIG_SW PD_SW.primary.power TOP.primary.power}

set_tlu_plus_files -max_tluplus $tlup_max -min_tluplus $tlup_min -tech2itf_map $tlup_map
set_scenario_options -setup true -hold true  -cts_mode false

report_scenario_options
###############
create_scenario "S4_max"
set auto_link_disable true

read_sdc -echo  $S4_max > log/${STAGE}_S4_max.log
if {$STAGE=="03_cts"} { remove_clock_uncertainty [all_clocks] }


set auto_link_disable false

set_operating_conditions -analysis_type bc_wc -max $max_cond -max_library $max_lib  -min $max_cond -min_library $max_lib
 
set_voltage 0.0 -object_list {VSS_DIG_SW VSS_DIG_AO TOP.primary.ground PD_SW.primary.ground}
set_voltage 1.35 -object_list {VDD_DIG_AO VDD_DIG_SW PD_SW.primary.power TOP.primary.power}

set_tlu_plus_files -max_tluplus $tlup_max -min_tluplus $tlup_min -tech2itf_map $tlup_map
set_scenario_options -setup true -hold true  -cts_mode false

report_scenario_options

###############################################################
## SYSTEM MODE
create_scenario "S3_min"
set auto_link_disable true

read_sdc -echo $S3_min > log/${STAGE}_S3_min.log
if {$STAGE=="03_cts"} { remove_clock_uncertainty [all_clocks] }

set auto_link_disable false
set_voltage 0.0 -object_list {VSS_DIG_SW VSS_DIG_AO TOP.primary.ground PD_SW.primary.ground}
set_voltage 1.65 -object_list {VDD_DIG_AO VDD_DIG_SW PD_SW.primary.power TOP.primary.power}
set_operating_conditions -analysis_type bc_wc -max $min_cond -max_library $min_lib  -min $min_cond -min_library $min_lib

set_tlu_plus_files -max_tluplus $tlup_max -min_tluplus $tlup_min -tech2itf_map $tlup_map
set_scenario_options -setup true -hold true  -cts_mode true -leakage_power true  -dynamic_power true
report_scenario_options
#####
create_scenario "S3_max"
set auto_link_disable true

read_sdc -echo $S3_max > log/${STAGE}_S3_max.log
if {$STAGE=="03_cts"} { remove_clock_uncertainty [all_clocks] }

set auto_link_disable false
set_voltage 0.0 -object_list {VSS_DIG_SW VSS_DIG_AO TOP.primary.ground PD_SW.primary.ground}
set_voltage 1.35 -object_list {VDD_DIG_AO VDD_DIG_SW PD_SW.primary.power TOP.primary.power}
set_operating_conditions -analysis_type bc_wc -max $max_cond -max_library $max_lib  -min $max_cond -min_library $max_lib

set_tlu_plus_files -max_tluplus $tlup_max -min_tluplus $tlup_min -tech2itf_map $tlup_map
set_scenario_options -setup true -hold true  -cts_mode true -leakage_power true  -dynamic_power true
report_scenario_options
	
######################
create_scenario "S22_min"
set auto_link_disable true

read_sdc -echo $S22_min > log/${STAGE}_S22_min.log
if {$STAGE=="03_cts"} { remove_clock_uncertainty [all_clocks] }

set auto_link_disable false
set_voltage 0.0 -object_list {VSS_DIG_SW VSS_DIG_AO TOP.primary.ground PD_SW.primary.ground}
set_voltage 1.65 -object_list {VDD_DIG_AO VDD_DIG_SW PD_SW.primary.power TOP.primary.power}
set_operating_conditions -analysis_type bc_wc -max $min_cond -max_library $min_lib  -min $min_cond -min_library $min_lib

set_tlu_plus_files -max_tluplus $tlup_max -min_tluplus $tlup_min -tech2itf_map $tlup_map
set_scenario_options -setup true -hold true  -cts_mode true -leakage_power true  -dynamic_power true
report_scenario_options
#####
create_scenario "S22_max"
set auto_link_disable true

read_sdc -echo $S22_max > log/${STAGE}_S22_max.log
if {$STAGE=="03_cts"} { remove_clock_uncertainty [all_clocks] }

set auto_link_disable false
set_voltage 0.0 -object_list {VSS_DIG_SW VSS_DIG_AO TOP.primary.ground PD_SW.primary.ground}
set_voltage 1.35 -object_list {VDD_DIG_AO VDD_DIG_SW PD_SW.primary.power TOP.primary.power}
set_operating_conditions -analysis_type bc_wc -max $max_cond -max_library $max_lib  -min $max_cond -min_library $max_lib

set_tlu_plus_files -max_tluplus $tlup_max -min_tluplus $tlup_min -tech2itf_map $tlup_map
set_scenario_options -setup true -hold true  -cts_mode true -leakage_power true  -dynamic_power true
report_scenario_options
	
######################
create_scenario "S12_min"
set auto_link_disable true

read_sdc -echo $S12_min > log/${STAGE}_S12_min.log
if {$STAGE=="03_cts"} { remove_clock_uncertainty [all_clocks] }

set auto_link_disable false
set_voltage 0.0 -object_list {VSS_DIG_SW VSS_DIG_AO TOP.primary.ground PD_SW.primary.ground}
set_voltage 1.65 -object_list {VDD_DIG_AO VDD_DIG_SW PD_SW.primary.power TOP.primary.power}
set_operating_conditions -analysis_type bc_wc -max $min_cond -max_library $min_lib  -min $min_cond -min_library $min_lib

set_tlu_plus_files -max_tluplus $tlup_max -min_tluplus $tlup_min -tech2itf_map $tlup_map
set_scenario_options -setup true -hold true  -cts_mode true -leakage_power true  -dynamic_power true
report_scenario_options
#####
create_scenario "S12_max"
set auto_link_disable true

read_sdc -echo $S12_max > log/${STAGE}_S12_max.log
if {$STAGE=="03_cts"} { remove_clock_uncertainty [all_clocks] }

set auto_link_disable false
set_voltage 0.0 -object_list {VSS_DIG_SW VSS_DIG_AO TOP.primary.ground PD_SW.primary.ground}
set_voltage 1.35 -object_list {VDD_DIG_AO VDD_DIG_SW PD_SW.primary.power TOP.primary.power}
set_operating_conditions -analysis_type bc_wc -max $max_cond -max_library $max_lib  -min $max_cond -min_library $max_lib

set_tlu_plus_files -max_tluplus $tlup_max -min_tluplus $tlup_min -tech2itf_map $tlup_map
set_scenario_options -setup true -hold true  -cts_mode true -leakage_power true  -dynamic_power true
report_scenario_options
	
######################
create_scenario "S11_min"
set auto_link_disable true

read_sdc -echo $S11_min > log/${STAGE}_S11_min.log
if {$STAGE=="03_cts"} { remove_clock_uncertainty [all_clocks] }

set auto_link_disable false
set_voltage 0.0 -object_list {VSS_DIG_SW VSS_DIG_AO TOP.primary.ground PD_SW.primary.ground}
set_voltage 1.65 -object_list {VDD_DIG_AO VDD_DIG_SW PD_SW.primary.power TOP.primary.power}
set_operating_conditions -analysis_type bc_wc -max $min_cond -max_library $min_lib  -min $min_cond -min_library $min_lib

set_tlu_plus_files -max_tluplus $tlup_max -min_tluplus $tlup_min -tech2itf_map $tlup_map
set_scenario_options -setup true -hold true  -cts_mode true -leakage_power true  -dynamic_power true
report_scenario_options
#####
create_scenario "S11_max"
set auto_link_disable true

read_sdc -echo $S11_max > log/${STAGE}_S11_max.log
if {$STAGE=="03_cts"} { remove_clock_uncertainty [all_clocks] }

set auto_link_disable false
set_voltage 0.0 -object_list {VSS_DIG_SW VSS_DIG_AO TOP.primary.ground PD_SW.primary.ground}
set_voltage 1.35 -object_list {VDD_DIG_AO VDD_DIG_SW PD_SW.primary.power TOP.primary.power}
set_operating_conditions -analysis_type bc_wc -max $max_cond -max_library $max_lib  -min $max_cond -min_library $max_lib

set_tlu_plus_files -max_tluplus $tlup_max -min_tluplus $tlup_min -tech2itf_map $tlup_map
set_scenario_options -setup true -hold true  -cts_mode true -leakage_power true  -dynamic_power true
report_scenario_options
	
###############################################
##########END CREATING SCENARIOS###############
###############################################

	
