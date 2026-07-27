# ------------------------------------------------------------------------------
# Purpose : Synthesis Script - Design Compiler DFT insertion script (BAF4)
#
# Single power domain (no UPF / no multi-voltage).
# Scan constrained per S4_min / S4_max scenario (adapted from ENS2).
# No bottom-up flow.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Job Diagnostics
# ------------------------------------------------------------------------------

# Log the time that this script starts executing
set start_time [clock seconds] ; echo [clock format ${start_time} -gmt false]

echo [pwd]

print_suppressed_messages

# ------------------------------------------------------------------------------
# Set-up Design Configuration Options
# ------------------------------------------------------------------------------

source -echo -verbose ../scripts/design_config.tcl

# ------------------------------------------------------------------------------
# Set-up Target Technology
# ------------------------------------------------------------------------------

source -echo -verbose ../scripts/Nanochap_imp_tech.tcl

# ------------------------------------------------------------------------------
# Set-up Target/Link Libraries
# ------------------------------------------------------------------------------
# min/max corners are both required now that scan runs S4_min and S4_max.

set_app_var synthetic_library dw_foundation.sldb

set_app_var search_path [concat . $stdcell_search_path $flash_mod_search_path $io_search_path $ana_search_path $search_path]
set_app_var symbol_library $stdcell_sdb

set_app_var target_library [concat $stdcell_library(db,$slow_corner_pvt) $stdcell_library(db,$fast_corner_pvt)]

set_app_var link_library [concat * $stdcell_library(db,$slow_corner_pvt) $flash_mod_max_library $io_max_library $ana_max_library $stdcell_library(db,$fast_corner_pvt) $flash_min_library $io_min_library $ana_min_library $synthetic_library]

# Set any dont use lists
foreach libraryname [array names dont_use] {
  foreach dontusecelltype $dont_use($libraryname) {
      echo "set_dont_use -power [get_object_name [get_lib_cells ${libraryname}/${dontusecelltype}]]"
      set_dont_use -power [get_lib_cells ${libraryname}/${dontusecelltype}]
      unset dontusecelltype
  }
  unset libraryname
}

# ------------------------------------------------------------------------------
# Open MW design library (already built by synthesis) + TLU+ (topographical)
# ------------------------------------------------------------------------------
set_app_var mw_design_library $rm_project_top

#sh rm -rf ./$mw_design_library
#create_mw_lib -technology $tech_file \
#	      -mw_reference_library $mw_reference_library \
#	                            $mw_design_library

open_mw_lib $mw_design_library

# Check consistency of logical vs. physical libraries
#check_library

# ------------------------------------------------------------------------------
# Setup for Formality verification
# ------------------------------------------------------------------------------
set stage postscan

sh mkdir -p ../reports/synthesis_${stage}_${generate_sdf}
sh mkdir -p ../data/synthesis_${stage}_${generate_sdf}

set out_rep  ../reports/synthesis_${stage}_${generate_sdf}
set out_data ../data/synthesis_${stage}_${generate_sdf}

set_svf ${out_data}/${rm_project_top}.$stage.svf

# -----------------------------------------------------------------------------
# Re-apply synthesis tool options
# -----------------------------------------------------------------------------
set_app_var enable_recovery_removal_arcs true
# Case analysis required to support EMA value setting for memories
set_app_var case_analysis_with_logic_constants true

# Allow identification of inserted logic
set_app_var compile_instance_name_prefix DFT_

set_app_var write_name_nets_same_as_ports true
set_app_var report_default_significant_digits 3

# -----------------------------------------------------------------------------
# Read pre-scan insertion synthesis DDC (carries functional scenarios)
# -----------------------------------------------------------------------------

read_ddc ../data/synthesis_prescan_${generate_sdf}/${rm_project_top}.prescan.ddc

# ------------------------------------------------------------------------------
# Function clock and constraints for Scan (S4) scenarios
# ------------------------------------------------------------------------------
# SXY_mZZ => X: 4=Scan Mode.  Y: 1=Internal Clock, 2=External Clock.  ZZ: min/max.
# Single power domain: no load_upf / set_voltage needed here.

lappend scenarios S4_min S4_max
foreach i $scenarios {
  create_scenario $i
  set_scenario_options -setup true -hold true -cts_mode true -leakage_power true -dynamic_power true -cts_corner min_max
  source -echo -verbose ../scripts/Nanochap_imp_scan_constraints.tcl
  source -echo -verbose ../scripts/Nanochap_imp_scenario_specific.tcl;#common scenario specific command needs to be here
}
set_active_scenarios [all_scenarios]
current_scenario S4_max

# -----------------------------------------------------------------------------
# Link the design
# -----------------------------------------------------------------------------

current_design $rm_project_top

link

check_design -no_warnings
check_design -multiple_designs > \
  ${out_rep}/${rm_project_top}_initial.check_design

# Disable register merging
set_register_merging [all_registers] false

# ------------------------------------------------------------------------------
# Set design context
# ------------------------------------------------------------------------------
# NOTE: topographical (MW) flow now, so no set_wire_load_model.
set_dont_touch [get_cells {DNT*} -hierarchical]
set_dont_touch_network [get_pin  u_top_ana/VREF0P8]

# ------------------------------------------------------------------------------
# DFT: Add test ports
# ------------------------------------------------------------------------------

set_dft_drc_configuration -internal_pins enable
set num_scan_chains           8        ;# Number of scan chains to be inserted

# ------------------------------------------------------------------------------
# 1. Scan In/Out Define
# ------------------------------------------------------------------------------
set_dft_signal -view spec -test_mode all -type ScanDataIn -port [get_ports IOBUF_PAD[4]]   -hookup_pin [get_pins u_top_dig/u_pinmux/u_gpio4_pinmux/test0_y]
set_dft_signal -view spec -test_mode all -type ScanDataIn -port [get_ports IOBUF_PAD[5]]   -hookup_pin [get_pins u_top_dig/u_pinmux/u_gpio5_pinmux/test0_y]
set_dft_signal -view spec -test_mode all -type ScanDataIn -port [get_ports IOBUF_PAD[7]]   -hookup_pin [get_pins u_top_dig/u_pinmux/u_gpio7_pinmux/test0_y]
set_dft_signal -view spec -test_mode all -type ScanDataIn -port [get_ports IOBUF_PAD[8]]   -hookup_pin [get_pins u_top_dig/u_pinmux/u_gpio8_pinmux/test0_y]
set_dft_signal -view spec -test_mode all -type ScanDataIn -port [get_ports IOBUF_PAD[9]]   -hookup_pin [get_pins u_top_dig/u_pinmux/u_gpio9_pinmux/test0_y]
set_dft_signal -view spec -test_mode all -type ScanDataIn -port [get_ports IOBUF_PAD[10]]  -hookup_pin [get_pins u_top_dig/u_pinmux/u_gpio10_pinmux/test0_y]
set_dft_signal -view spec -test_mode all -type ScanDataIn -port [get_ports IOBUF_PAD[11]]  -hookup_pin [get_pins u_top_dig/u_pinmux/u_gpio11_pinmux/test0_y]
set_dft_signal -view spec -test_mode all -type ScanDataIn -port [get_ports IOBUF_PAD[12]]  -hookup_pin [get_pins u_top_dig/u_pinmux/u_gpio12_pinmux/test0_y]

set_dft_signal -view spec -test_mode all -type ScanDataOut -port [get_ports IOBUF_PAD[0]]  -hookup_pin [get_pins u_top_dig/u_pinmux/scan_out[0]]
set_dft_signal -view spec -test_mode all -type ScanDataOut -port [get_ports IOBUF_PAD[1]]  -hookup_pin [get_pins u_top_dig/u_pinmux/scan_out[1]]
set_dft_signal -view spec -test_mode all -type ScanDataOut -port [get_ports IOBUF_PAD[13]] -hookup_pin [get_pins u_top_dig/u_pinmux/scan_out[2]]
set_dft_signal -view spec -test_mode all -type ScanDataOut -port [get_ports IOBUF_PAD[14]] -hookup_pin [get_pins u_top_dig/u_pinmux/scan_out[3]]
set_dft_signal -view spec -test_mode all -type ScanDataOut -port [get_ports IOBUF_PAD[15]] -hookup_pin [get_pins u_top_dig/u_pinmux/scan_out[4]]
set_dft_signal -view spec -test_mode all -type ScanDataOut -port [get_ports IOBUF_PAD[16]] -hookup_pin [get_pins u_top_dig/u_pinmux/scan_out[5]]
set_dft_signal -view spec -test_mode all -type ScanDataOut -port [get_ports IOBUF_PAD[17]] -hookup_pin [get_pins u_top_dig/u_pinmux/scan_out[6]]
set_dft_signal -view spec -test_mode all -type ScanDataOut -port [get_ports IOBUF_PAD[18]] -hookup_pin [get_pins u_top_dig/u_pinmux/scan_out[7]]

# ------------------------------------------------------------------------------
# 2. Control Signals (Constants vs TestModes)
# ------------------------------------------------------------------------------
# Pure Constants
set_dft_signal -view existing_dft -type Constant -port [get_ports iopad_testmode1] -active_state 0
set_dft_signal -view spec         -type Constant -port [get_ports iopad_testmode1] -active_state 0
set_dft_signal -view existing_dft -type Constant -hookup_pin [get_pins u_top_ana/A2D_Wake_UP_i] -active_state 1
set_dft_signal -view spec         -type Constant -hookup_pin [get_pins u_top_ana/A2D_Wake_UP_i] -active_state 1
set_dft_signal -view existing_dft -type Constant -hookup_pin [get_pins u_top_ana/POC] -active_state 1
set_dft_signal -view spec         -type Constant -hookup_pin [get_pins u_top_ana/POC] -active_state 1

# Test Modes (drive the define_test_mode encodings)
set_dft_signal -view spec         -type TestMode -port [get_ports iopad_testmode0] -hookup_pin [get_pins u_top_dig/u_pinmux/atpg_en]
set_dft_signal -view existing_dft -type TestMode -port [get_ports iopad_testmode0] -hookup_pin [get_pins u_top_dig/u_pinmux/atpg_en]
set_dft_signal -view spec         -type TestMode -port [get_ports IOBUF_PAD[6]] -hookup_pin [get_pins u_top_dig/u_pinmux/u_gpio6_pinmux/test0_y]
set_dft_signal -view existing_dft -type TestMode -port [get_ports IOBUF_PAD[6]] -hookup_pin [get_pins u_top_dig/u_pinmux/u_gpio6_pinmux/test0_y]

# Reset
set_dft_signal -view existing_dft -type Reset -port [get_ports iopad_resetn] -hookup_pin [get_pins u_iopad_exresetn/Y] -active_state 0

# Scan clock
set_dft_signal -view existing_dft -type ScanClock -timing {45 65} -port [get_ports IOBUF_PAD[2]] -hookup_pin [get_pins u_top_dig/u_pinmux/scan_clk]

# Scan enable requires spec and existing_dft as connected to ICG SE pins and also
# needs to be connected to the DFTSE pins of flops by the insert_dft command
set_dft_signal -view spec         -type ScanEnable -port [get_ports IOBUF_PAD[3]] -hookup_pin [get_pins top_dig_always_on_inst/DNT_SCAN_EN_AL_ON/Y] -active_state 1
set_dft_signal -view existing_dft -type ScanEnable -port [get_ports IOBUF_PAD[3]] -hookup_pin [get_pins top_dig_always_on_inst/DNT_SCAN_EN_AL_ON/Y] -active_state 1

# ------------------------------------------------------------------------------
# 3. Test Mode Definitions & Compression Config
# ------------------------------------------------------------------------------
define_test_mode internal_scan -usage scan             -encoding {iopad_testmode0 1 u_top_dig/u_pinmux/atpg_en 1 IOBUF_PAD[6] 0 u_top_dig/u_pinmux/u_gpio6_pinmux/test0_y 0}
define_test_mode compress_scan -usage scan_compression -encoding {iopad_testmode0 1 u_top_dig/u_pinmux/atpg_en 1 IOBUF_PAD[6] 1 u_top_dig/u_pinmux/u_gpio6_pinmux/test0_y 1}

set_dft_configuration -scan_compression enable
set_scan_compression_configuration -base_mode internal_scan -test_mode compress_scan -chain_count 56 -inputs 8 -outputs 8
set_scan_configuration -style multiplexed_flip_flop  \
                       -clock_mixing mix_clocks \
                       -create_dedicated_scan_out_ports true \
                       -chain_count ${num_scan_chains} \
                       -add_lockup true \
                       -lockup_type latch -test_mode internal_scan -replace false

set_dft_insertion_configuration -synthesis_optimization none

# ------------------------------------------------------------------------------
# 4. Scan Path Define
# ------------------------------------------------------------------------------
set_scan_path chain0 -view spec -test_mode internal_scan -scan_data_in IOBUF_PAD[4]   -scan_data_out IOBUF_PAD[0]
set_scan_path chain1 -view spec -test_mode internal_scan -scan_data_in IOBUF_PAD[5]   -scan_data_out IOBUF_PAD[1]
set_scan_path chain2 -view spec -test_mode internal_scan -scan_data_in IOBUF_PAD[7]   -scan_data_out IOBUF_PAD[13]
set_scan_path chain3 -view spec -test_mode internal_scan -scan_data_in IOBUF_PAD[8]   -scan_data_out IOBUF_PAD[14]
set_scan_path chain4 -view spec -test_mode internal_scan -scan_data_in IOBUF_PAD[9]   -scan_data_out IOBUF_PAD[15]
set_scan_path chain5 -view spec -test_mode internal_scan -scan_data_in IOBUF_PAD[10]  -scan_data_out IOBUF_PAD[16]
set_scan_path chain6 -view spec -test_mode internal_scan -scan_data_in IOBUF_PAD[11]  -scan_data_out IOBUF_PAD[17]
set_scan_path chain7 -view spec -test_mode internal_scan -scan_data_in IOBUF_PAD[12]  -scan_data_out IOBUF_PAD[18]

# -----------------------------------------------------------------------------
# DFT: Configuration
# -----------------------------------------------------------------------------
# Design already has test-ready scan flops in place
set_scan_state test_ready

set_dft_insertion_configuration -preserve_design_name true

# Do not run incremental compile as a part of insert_dft
set_dft_insertion_configuration -synthesis_optimization none

set_app_var power_cg_auto_identify true

# Specify that all constant flops are to be scan stitched (TEST-504 for constant 0 and TEST-505 for constant 1)
set_dft_drc_rules -ignore {TEST-504}
set_dft_drc_rules -ignore {TEST-505}

create_test_protocol
# -----------------------------------------------------------------------------
# DFT: Scan chain insertion
# -----------------------------------------------------------------------------

# Use the -verbose option of dft_drc to assist in debugging if necessary
dft_drc -verbose > ${out_rep}/${rm_project_top}.initial_dft_drc

report_scan_configuration > ${out_rep}/${rm_project_top}.scan_configuration
report_dft_insertion_configuration > ${out_rep}/${rm_project_top}.dft_insertion_configuration

# Use the '-show all -test_points all' options to preview_dft for more detail
preview_dft > ${out_rep}/${rm_project_top}.preview_dft

insert_dft
dft_drc

current_design $rm_project_top
# -----------------------------------------------------------------------------
# Additional optimization constraints
# -----------------------------------------------------------------------------

# Control DRC/Fanout for tie cells
# This allows a fanout of 1 on tie cells to be set:
set_auto_disable_drc_nets -constant false

# Prevent assignment statements resulting from insert_dft
set_fix_multiple_port_nets -all -buffer_constants [get_designs]

# prevent add new cells at top level
set_app_var compile_no_new_cells_at_top_level true

# -----------------------------------------------------------------------------
# DFT: Post DFT incremental optimization
# -----------------------------------------------------------------------------

# Incremental compile required after scan chain insertion
compile_ultra -incremental

# -----------------------------------------------------------------------------
# DFT: Write out test protocols and reports
# -----------------------------------------------------------------------------

# write_scan_def adds SCANDEF info to the design database in memory so this
# must be performed prior to writing out the design
write_scan_def -output ${out_data}/${rm_project_top}.dft_scandef

check_scan_def > ${out_rep}/${rm_project_top}.check_scan_def

write_test_model -format ctl -output ${out_data}/${rm_project_top}.dft_ctl

current_test_mode internal_scan
report_dft_signal > ${out_rep}/${rm_project_top}.dft_signals_internal
dft_drc -verbose > ${out_rep}/${rm_project_top}.dft_drc_internal
report_scan_path > ${out_rep}/${rm_project_top}.scanpath_internal
report_scan_path -chain all > ${out_rep}/${rm_project_top}.scanpath_chain_internal
report_scan_path -cell  all > ${out_rep}/${rm_project_top}.scanpath_cell_internal
write_test_protocol -names verilog -test_mode internal_scan -output ${out_data}/${rm_project_top}.dft_scan_spf_internal

current_test_mode compress_scan
report_dft_signal > ${out_rep}/${rm_project_top}.dft_signals
dft_drc -verbose > ${out_rep}/${rm_project_top}.dft_drc
report_scan_path > ${out_rep}/${rm_project_top}.scanpath
report_scan_path -chain all > ${out_rep}/${rm_project_top}.scanpath_chain
report_scan_path -cell  all > ${out_rep}/${rm_project_top}.scanpath_cell
write_test_protocol -names verilog -test_mode compress_scan -output ${out_data}/${rm_project_top}.dft_scan_spf

# -----------------------------------------------------------------------------
# Change names before output
# -----------------------------------------------------------------------------

set_app_var uniquify_naming_style ${rm_project_top}_%s_%d
uniquify -force

define_name_rules verilog -case_insensitive
change_names -rules verilog -hierarchy -verbose > ${out_rep}/${rm_project_top}.change_names

# ------------------------------------------------------------------------------
# Write out design data
# ------------------------------------------------------------------------------

set_app_var verilogout_higher_designs_first true
set_app_var verilogout_no_tri true

write -f verilog  -hierarchy -output ${out_data}/${rm_project_top}.${stage}.v

# Write and close SVF file, make it available for immediate use
set_svf -off

# Write parasitics data from DCT placement for static timing analysis
write_parasitics -output ${out_data}/${rm_project_top}.${stage}.spef

# Write SDF backannotation data from DCT placement for static timing analysis
write_sdf ${out_data}/${rm_project_top}.${stage}.max.sdfv2 -context verilog

# Do not write out net RC info into SDC
set_app_var write_sdc_output_lumped_net_capacitance false
set_app_var write_sdc_output_net_resistance false

# Write out SDC version 2.0 to omit set_voltage for backwards compatibility (scan S4)
write_sdc -version 2.0 -nosplit ${out_data}/${rm_project_top}.${stage}.sdc

# ------------------------------------------------------------------------------
# Per-scenario functional SDCs (S11/S12/S22/S3 carried in from prescan ddc)
# ------------------------------------------------------------------------------
lappend scenarios S11_min S12_min S22_min S3_min S11_max S12_max S22_max S3_max
foreach i $scenarios {
    current_scenario $i

    #use following sdc files for sta and post cts
    if {$generate_sdf == "sdf"} {
      set_clock_uncertainty -hold  0.05 [all_clocks]
      remove_clock_transition [all_clocks]
    }

    report_clock -skew
    write_sdc -version 2.0 -nosplit ${out_data}/${rm_project_top}.${stage}.scre_[current_scenario].sdc
    source -echo -verbose ../scripts/Nanochap_imp_reports.tcl
}
current_scenario S4_max

# If SAIF is used, write out SAIF name mapping file for PrimeTime-PX
saif_map -type ptpx -write_map ${out_rep}/${rm_project_top}_SAIF.namemap

# ------------------------------------------------------------------------------
# Insert scan chains and report estimated scan coverage
# ------------------------------------------------------------------------------

#dft_drc -verbose -coverage_estimate > \
#  ${out_rep}/${rm_project_top}.scan_estimate

report_scenarios

# ------------------------------------------------------------------------------
# Report message summary and quit
# ------------------------------------------------------------------------------

print_message_info

set end_time [clock seconds]; echo [string toupper inform:] End time [clock format ${end_time} -gmt false]

# Total script wall clock run time
echo "[string toupper inform:] Time elapsed: [format %02d \
                     [expr ($end_time - $start_time)/86400]]d \
                    [clock format [expr ($end_time - $start_time)] \
                    -format %Hh%Mm%Ss -gmt true]"
exit

# ------------------------------------------------------------------------------
# End of File
# ------------------------------------------------------------------------------
