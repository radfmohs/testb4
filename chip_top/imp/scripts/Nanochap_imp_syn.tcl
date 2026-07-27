# ------------------------------------------------------------------------------
# Purpose : Synthesis Script - Synthesis (BAF4)
#
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Job Diagnostics
# ------------------------------------------------------------------------------

set start_time [clock seconds] ; echo [clock format ${start_time} -gmt false]

echo [pwd]

print_suppressed_messages

suppress_message {ELAB-311}

# -----------------------------------------------------------------------------------
# Setup the configuration
# -----------------------------------------------------------------------------------

source -echo -verbose ../scripts/design_config.tcl

# ------------------------------------------------------------------------------
# Set-up Target Technology
# ------------------------------------------------------------------------------

source -echo -verbose ../scripts/Nanochap_imp_tech.tcl

# ------------------------------------------------------------------------------
# Set-up Target/Link Libraries
# ------------------------------------------------------------------------------

set_app_var synthetic_library dw_foundation.sldb

set_app_var search_path [concat . $stdcell_search_path $flash_mod_search_path $io_search_path $ana_search_path $search_path]
set_app_var symbol_library $stdcell_sdb

set_app_var target_library [concat $stdcell_library(db,$slow_corner_pvt) $stdcell_library(db,$fast_corner_pvt)]

set_app_var link_library [concat * $stdcell_library(db,$slow_corner_pvt) $flash_mod_max_library $io_max_library $ana_max_library $stdcell_library(db,$fast_corner_pvt) $flash_min_library $io_min_library $ana_min_library $synthetic_library]

# ------------------------------------------------------------------------------
# Associate libraries with min libraries
# ------------------------------------------------------------------------------

# Set any dont use lists
foreach libraryname [array names dont_use] {
  foreach dontusecelltype $dont_use($libraryname) {
      echo "set_dont_use -power [get_object_name [get_lib_cells ${libraryname}/${dontusecelltype}]]"
      set_dont_use -power [get_lib_cells ${libraryname}/${dontusecelltype}]
      unset dontusecelltype
  }
  unset libraryname
}

set hdlin_infer_multibit default_all
set_app_var mw_reference_library [concat $stdcell_mw_library $io_mw_library $flash_mw_library $ana_mw_library]

# ------------------------------------------------------------------------------
# Create MW design library
# ------------------------------------------------------------------------------

set_app_var mw_design_library $rm_project_top

sh rm -rf ./$mw_design_library

create_mw_lib -technology $tech_file \
	      -mw_reference_library $mw_reference_library \
	                            $mw_design_library

open_mw_lib $mw_design_library

# ------------------------------------------------------------------------------
# Setup for Formality verification
# ------------------------------------------------------------------------------
set stage prescan

sh mkdir -p ../reports/synthesis_${stage}_${generate_sdf}
sh mkdir -p ../data/synthesis_${stage}_${generate_sdf}

set out_rep  ../reports/synthesis_${stage}_${generate_sdf}
set out_data ../data/synthesis_${stage}_${generate_sdf}

set_svf ${out_data}/${rm_project_top}.$stage.svf

# ------------------------------------------------------------------------------
# Setup for SAIF name mapping database
# ------------------------------------------------------------------------------

saif_map -start

# ------------------------------------------------------------------------------
# Read in the design verilog RTL
# ------------------------------------------------------------------------------

# Default to read Verilog as standard version 2001 (not 2005)
set_app_var hdlin_vrlg_std 2001

# Don't optimize constants for Formality and ID registers.
set_app_var compile_seqmap_propagate_constants false

# Identify architecturally instantiated clock gates
# Note: This application variable must be set BEFORE the RTL is read in.
set_app_var power_cg_auto_identify true

# Check for latches in RTL
set_app_var hdlin_check_no_latch true

# Setup RTL files and paths
define_design_lib work -path elab
set_app_var compile_no_new_cells_at_top_level true

if {[file exists elab] == 1 } {puts "directory elab exists"} else {file mkdir elab}

exec /bin/csh -c ../scripts/Nanochap_imp_verilog.csh

set f  [open "./rtl.f" r ]
set file_list [regsub -all {\s+} [read $f] " "];#read into variable and replace whitespace with ,

if {[file exists def.f] == 1 } {
    set d  [open "./def.f" r ]
    set def_list [regsub -all {\s+} [read $d] " "];#read into variable and replace whitespace with ,
    puts $def_list
    puts $file_list
    redirect -tee ${out_rep}/${rm_project_top}.read_file { \
    	read_file -define $def_list $file_list -auto -top ${rm_project_top}};#read in
    close $d
    close $f
    exec rm rtl.f rtl_tmp.f def.f
} else {
    redirect -tee ${out_rep}/${rm_project_top}.read_file { \
    	analyze  $file_list -auto -top ${rm_project_top}};#read in
    close $f
    exec rm rtl.f rtl_tmp.f
}

# Tee elaboration output to separate log file
redirect -tee ${out_rep}/${rm_project_top}.elaborate { \
  elaborate -architecture verilog ${rm_project_top}}

# ------------------------------------------------------------------------------
# Link the design
# ------------------------------------------------------------------------------

current_design $rm_project_top

link

check_design -no_warnings
check_design -multiple_designs > \
  ${out_rep}/${rm_project_top}_initial.check_design

# Disable register merging
set_register_merging [all_registers] false

# ------------------------------------------------------------------------------
# Optimize for area
# ------------------------------------------------------------------------------
set_max_area 0

# -----------------------------------------------------------------------------------
# stop synthesis optimization for the following static signals, add more other
# appropriate signals here for your design
# -----------------------------------------------------------------------------------

set_dont_touch_network [get_pin  u_top_ana/VREF0P8]

set_dont_touch [remove_from_collection [get_cells {DNT*} -hierarchical] [get_cells u_top_dig/u_pinmux/*/*/DNT*]]
set_dont_touch [get_nets IOBUF_CS]
set_dont_touch [get_nets IOBUF_PU]
set_dont_touch [get_nets IOBUF_PD]
set_dont_touch [get_nets D2A_*]
set_dont_touch [get_nets scan_*]

# CPPR
set timing_remove_clock_reconvergence_pessimism true

# ------------------------------------------------------------------------------
# Apply synthesis tool options
# ------------------------------------------------------------------------------

set_app_var enable_recovery_removal_arcs true

# Case analysis required to support EMA value setting for memories
set_app_var case_analysis_with_logic_constants true

set_app_var write_name_nets_same_as_ports true
set_app_var report_default_significant_digits 3

# Control DRC/Fanout for tie cells
# This allows a fanout of 1 on tie cells to be set:
set_auto_disable_drc_nets -constant false

# Prevent assignment statements in the Verilog netlist.
set_fix_multiple_port_nets -all -buffer_constants [get_designs]

# Set to enable full range of flops for synthesis consideration
set compile_filter_prune_seq_cells false
set remove_constant_register true
set remove_unloaded_register true

# ------------------------------------------------------------------------------
# boundary optimization false
# ------------------------------------------------------------------------------
set_boundary_optimization u_top_dig/u_pinmux false
set_boundary_optimization u_top_dig/u_pinmux/u_gpio*_pinmux false
set_boundary_optimization u_top_dig/u_pinmux/u_gpio*_pinmux/u_* false
set_boundary_optimization [get_cells u_top_dig] false ;

# Set constant not optimization
set_app_var compile_enable_constant_propagation_with_no_boundary_opt false

# Controls the identification of shift registers in compile -scan.
# This feature is only supported in test-ready compile with Design
# Compiler Ultra with a multiplexed scan style.
set_app_var compile_seqmap_identify_shift_registers false

# ------------------------------------------------------------------------------
# Function clock and constraints  (multi-scenario, single power domain)
# ------------------------------------------------------------------------------
# SXY_mZZ => X: 1=Normal Mode, 2=CP test Mode, 3=Bist Mode.
#            Y: 1=Internal (OSC) Clock, 2=External Clock.
#            ZZ: min / max corner.
# CPHA phase/polarity scenario (used by ENS2/BMS6) is NOT needed for BAF4.
lappend scenarios S11_min S12_min S22_min S3_min S11_max S12_max S22_max S3_max
foreach i $scenarios {
  create_scenario $i
  set_scenario_options -setup true -hold true -cts_mode true -leakage_power true -dynamic_power true -cts_corner min_max
  source -echo -verbose ../scripts/Nanochap_imp_constraints.tcl
  source -echo -verbose ../scripts/Nanochap_imp_scenario_specific.tcl;#common scenario specific command needs to be here
}
set_active_scenarios [all_scenarios]
current_scenario S11_max

# ------------------------------------------------------------------------------
# Clock gating setup
# ------------------------------------------------------------------------------

set_app_var compile_clock_gating_through_hierarchy true
set_app_var power_cg_balance_stages true

set_clock_gating_style -sequential_cell latch \
                       -positive_edge_logic $icg_name \
                       -control_point before \
                       -control_signal scan_enable \
                       -minimum_bitwidth 8 \
                       -num_stages 2 \
                       -max_fanout 32

# for icg margin
set_clock_gating_check -setup 0.50 [all_clocks]
set_clock_gating_check -hold 0.25 [all_clocks]
set_clock_gating_objects -exclude top_dig_always_on_inst/reset_ctrl_always_on_inst/sw_por_cnt_reg[*];#causes X propagation
set_clock_gating_objects -exclude top_dig_always_on_inst/reset_ctrl_always_on_inst/por_cnt_reg[*];#causes X propagation
set_clock_gating_objects -exclude u_top_dig/spi_top_u/spi_reg_u/*_reg*;#difficulty fixing Hold by STA. SPI not always clocked anyway
set_clock_gating_objects -exclude u_top_dig/u_imeas/u_filter;#difficulty fixing Hold by STA. SPI not always clocked anyway

set_app_var physopt_enable_via_res_support true
set placer_tns_driven true
set_app_var placer_max_cell_density_threshold 0.65
set_app_var placer_enable_enhanced_router true
set_app_var compile_prefer_mux true

# placement based banking with physically aware clock gating
set_app_var power_cg_physically_aware_cg true

# Optional: once a placement-aware PNR run exists for this project, point this
# at that block's .def to feed physical data back into synthesis 
# run this in ICC and provide result below: write_def -version 5.7 -rows_tracks_gcells -macro -pins -blockages -specialnets -vias -regions_groups -verbose -output my_physical_data.def
# extract_physical_constraints /projects/libs/<project_block>/digital_work/.../<project_top>.def

compile_ultra  -check_only
# Target routing layers
set_ignored_layers -min_routing_layer M1
set_ignored_layers -max_routing_layer M5
report_ignored_layers

compile_ultra -scan -gate_clock -no_autoungroup; # -spg;# -self_gating;#use place_opt -spg in ICC
#identify_register_banks -multibit_components_only -output_file create_reg.tcl;# source create_reg.tcl before dft_insertion

# ------------------------------------------------------------------------------
# Change names before output
# ------------------------------------------------------------------------------

# If this will be a sub-block in a hierarchical design, uniquify with block
# unique names to avoid name collisions when integrating the design at the top
# level
set_app_var uniquify_naming_style ${rm_project_top}_%s_%d
uniquify -force

define_name_rules verilog -case_insensitive
change_names -rules verilog -hierarchy -verbose > \
  ${out_rep}/${rm_project_top}.change_names

# ------------------------------------------------------------------------------
# Write out design data
# ------------------------------------------------------------------------------
set_app_var verilogout_higher_designs_first true
set_app_var verilogout_no_tri true

write -format ddc -hierarchy -output ${out_data}/${rm_project_top}.${stage}.ddc
write -f verilog  -hierarchy -output ${out_data}/${rm_project_top}.${stage}.v

# Write and close SVF file, make it available for immediate use
set_svf -off

# Write parasitics data from DCT placement for static timing analysis
write_parasitics -output ${out_data}/${rm_project_top}.${stage}.spef

# Write SDF backannotation data from DCT placement for static timing analysis
write_sdf ${out_data}/${rm_project_top}.${stage}.sdf

# Do not write out net RC info into SDC
set_app_var write_sdc_output_lumped_net_capacitance false
set_app_var write_sdc_output_net_resistance false

# Write out SDC version 2.0 to omit set_voltage for backwards compatibility
write_sdc -version 2.0 -nosplit ${out_data}/${rm_project_top}.${stage}.sdc

# If SAIF is used, write out SAIF name mapping file for PrimeTime-PX
saif_map -type ptpx -write_map ${out_rep}/${rm_project_top}_SAIF.namemap

######################################################################################
# ------------------------------------------------------------------------------
# Reports
# ------------------------------------------------------------------------------
foreach i $scenarios {
    current_scenario $i
    source -echo -verbose ../scripts/Nanochap_imp_reports.tcl
}
current_scenario S11_max

report_scenarios

# ------------------------------------------------------------------------------
# Report message summary and quit
# ------------------------------------------------------------------------------

print_message_info

set end_time [clock seconds]; echo [string toupper inform:] End time [clock format ${end_time} -gmt false]

# Total script wall clock run time
echo "[string toupper inform:] Time elapsed: [format %02d \
                     [expr {($end_time - $start_time)/86400}]]d \
                     [clock format [expr {$end_time - $start_time}] \
                     -format %Hh%Mm%Ss -gmt true]"

exit

# ------------------------------------------------------------------------------
# End of File
# ------------------------------------------------------------------------------
