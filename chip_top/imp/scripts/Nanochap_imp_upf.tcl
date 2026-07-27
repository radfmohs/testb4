
#set mv_use_std_cell_for_isolation true
#set_attribute [get_lib_cells sc7_l013_base_rvt_ff_TYP_min_1p65v_m40c/AND2X4M] ok_for_isolation true
#set_attribute [get_lib_pins sc7_l013_base_rvt_ff_TYP_min_1p65v_m40c/AND2X4M/A] isolation_cell_enable_pin true

create_power_domain TOP
create_power_domain PD_AO -elements top_dig_always_on_inst -scope top_dig_always_on_inst
create_power_domain PD_SW -elements u_top_dig -scope u_top_dig

#if {$stage == "postscan_pteco"} {
	#tmp remove_net VDD_DIG_AO
	#tmp remove_net VSS_DIG_AO
	#tmp remove_net VDD_DIG_SW
	#tmp remove_net VSS_DIG_SW
	#tmp remove_port VSS_DIG_AO
	#tmp remove_port VDD_DIG_AO
	#tmp remove_port VSS_DIG_SW
	#tmp remove_port VDD_DIG_SW
#};#in postscan_pteco2 netlist, these nets are already removed before in postscan_pteco stage

set_scope top_dig_always_on_inst
create_supply_net VDD_DIG_AO -domain PD_AO
create_supply_net VSS_DIG_AO -domain PD_AO
create_supply_port VSS_DIG_AO -domain PD_AO
create_supply_port VDD_DIG_AO -domain PD_AO
connect_supply_net VSS_DIG_AO -ports VSS_DIG_AO
connect_supply_net VDD_DIG_AO -ports VDD_DIG_AO
set_scope  /
set_scope  /
set_domain_supply_net top_dig_always_on_inst/PD_AO -primary_power_net top_dig_always_on_inst/VDD_DIG_AO -primary_ground_net top_dig_always_on_inst/VSS_DIG_AO

set_scope u_top_dig
create_supply_net VDD_DIG_SW -domain PD_SW
create_supply_net VSS_DIG_SW -domain PD_SW
create_supply_port VSS_DIG_SW -domain PD_SW
create_supply_port VDD_DIG_SW -domain PD_SW
connect_supply_net VDD_DIG_SW -ports {VDD_DIG_SW}
connect_supply_net VSS_DIG_SW -ports {VSS_DIG_SW}
set_scope  /
set_scope  /
set_domain_supply_net u_top_dig/PD_SW -primary_power_net u_top_dig/VDD_DIG_SW -primary_ground_net u_top_dig/VSS_DIG_SW

#tmp  ## SUPPLY NETWORK - TOP
#tmp   create_supply_port VDD_DIG_AO -domain TOP 
#tmp   create_supply_port VSS_DIG_AO -domain TOP
#tmp   create_supply_port VDD_DIG_SW -domain TOP
#tmp   create_supply_port VSS_DIG_SW -domain TOP
create_supply_net VDD_DIG_AO -domain TOP
create_supply_net VSS_DIG_AO -domain TOP
create_supply_net VDD_DIG_SW -domain TOP
create_supply_net VSS_DIG_SW -domain TOP
set_domain_supply_net TOP -primary_power_net VDD_DIG_AO -primary_ground_net VSS_DIG_AO
connect_supply_net VDD_DIG_SW -ports {u_top_dig/VDD_DIG_SW }
connect_supply_net VSS_DIG_SW -ports {u_top_dig/VSS_DIG_SW }
connect_supply_net VDD_DIG_AO -ports {top_dig_always_on_inst/VDD_DIG_AO }
connect_supply_net VSS_DIG_AO -ports {top_dig_always_on_inst/VSS_DIG_AO }
create_supply_port VDD_DIG_AO -domain TOP 
create_supply_port VSS_DIG_AO -domain TOP
create_supply_port VDD_DIG_SW -domain TOP
create_supply_port VSS_DIG_SW -domain TOP
#tmp connect_supply_net VDD_DIG_SW -ports {VDD_DIG_SW u_top_dig/VDD_DIG_SW u_ana_top/VDD_DIG_SW u_iopad_plvddi1/vddi u_ana_top/VDD_DIG_ZMEASURE}
#tmp connect_supply_net VSS_DIG_SW -ports {VSS_DIG_SW u_top_dig/VSS_DIG_SW u_ana_top/VSS_DIG_SW u_iopad_plvddi0/vssi u_iopad_plvddi1/vssi u_iopad_plvss_sw/gnd}
#tmp connect_supply_net VDD_DIG_AO -ports {VDD_DIG_AO top_dig_always_on_inst/VDD_DIG_AO  u_ana_top/VDD_DIG_AO u_iopad_plvdd/vdd}
#tmp connect_supply_net VSS_DIG_AO -ports {VSS_DIG_AO top_dig_always_on_inst/VSS_DIG_AO  u_ana_top/VSS_DIG_AO u_iopad_plvss/gnd}

## ISOLATION STRATEGY
#set_isolation iso_ao -domain u_top_dig_wrapper/PD_AO \
#-isolation_power_net u_top_dig_wrapper/VDD_AO -isolation_ground_net u_top_dig_wrapper/VSS_DIG -clamp_value 0 \
#-applies_to inputs -diff_supply_only TRUE -name_prefix ISO
#set_isolation_control iso_ao -domain u_top_dig_wrapper/PD_AO \
#-isolation_signal u_top_dig_wrapper/top_dig_always_on_inst/wakeup_done -isolation_sense low -location self

#POWER STATE TABLE
## CREATE PORT STATES
add_port_state VDD_DIG_AO -state {TOP 1.35}
add_port_state VDD_DIG_SW -state {ON 1.35} -state {OFF off}
add_port_state VSS_DIG_AO -state {OFF 0}
add_port_state VSS_DIG_SW -state {OFF 0}

## OPERATING VOLTAGES
create_pst gc2_pst -supplies {VDD_DIG_AO VDD_DIG_SW}
add_pst_state s0 -pst gc2_pst -state {TOP ON}
add_pst_state s1 -pst gc2_pst -state {TOP OFF}
#set_port_attributes -elements {u_top_dig_wrapper} -applies_to outputs \
#-attribute repeater_power_net u_top_dig_wrapper/VDD_AO \
#-attribute repeater_ground_net u_top_dig_wrapper/VSS_DIG
#set_port_attributes -elements {I_STACK_TOP} -applies_to inputs \
#-attribute repeater_power_net VDD -attribute repeater_ground_net VSS
#set_port_attributes -elements {I_REG_FILE} -applies_to inputs \
#-attribute repeater_power_net VDD -attribute repeater_ground_net VSS

