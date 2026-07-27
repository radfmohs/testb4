
#####################################################################################
# 1. Main design performance targets
#####################################################################################

# -----------------------------------------------------------------------------
# Default corners:
# -----------------------------------------------------------------------------

# The default corner names are 'keys' defining the min/max PVT used throughout
# implementation. These can be changed if matching libraries/pvt corners are
# available
set ss_lib_name sc7_l013_base_rvt_ss_TYP_max_1p35v_125c
set tt_lib_name sc7_l013_base_rvt_tt_TYP_max_1p50v_25c
set ff_lib_name sc7_l013_base_rvt_ff_TYP_min_1p65v_m40c
set sc sc7_l013_base_rvt

set slow_corner_pvt ss_TYP_max_1p35v_125c
set typ_corner_pvt  tt_TYP_max_1p50v_25c
set fast_corner_pvt ff_TYP_min_1p65v_m40c

# Equivalent default RC extraction corners 'keys' are also used

set slow_corner_extraction max
set typ_corner_extraction  typ
set fast_corner_extraction min

# -----------------------------------------------------------------------------
# setup/hold timing margin
# -----------------------------------------------------------------------------
set setup_margin            0.100       ;# in ns. Setup margin this really is the additional margin after ocv, undertainty and corner
set hold_margin             0.050       ;# in ns. Hold margin

# -----------------------------------------------------------------------------
# Pre-CTS clock skew and latency estimates
# -----------------------------------------------------------------------------

set pre_cts_clock_skew_estimate    0.150 ;
set pre_cts_clock_latency_estimate 2.000 ;

#####################################################################################
# 2. Design environment
#####################################################################################

# -----------------------------------------------------------------------------
# Input driving cell models
# -----------------------------------------------------------------------------
set driving_cell            BUFX4M	        ;# The driving cell for all inputs 
set driving_from_pin        A
set driving_pin             Y                   ;# The output pin of the driving cell

set clock_driving_cell      CLKBUFX8M	        ;# The driving cell for clock ports
set clock_driving_from_pin  A
set clock_driving_pin       Y                   ;# The output pin of the clock driving cell

set icg_name    {integrated:TLATNTSCAX8M}	;# Name of ICG cell

# -----------------------------------------------------------------------------
# Output loading models
# -----------------------------------------------------------------------------

set output_load             10.0            ;# Capacitive load placed on all inout/output pad

# -----------------------------------------------------------------------------
# Input transition models
# -----------------------------------------------------------------------------

set input_transition        1.0             ;# Input transition placed on all inout/input pad 

# -----------------------------------------------------------------------------
# Max capacitance
# -----------------------------------------------------------------------------

# Keyed from "$transistor_$voltage_$temperature"

# This is used to set the upper limits for tables during timing model creation
# These values have based on the largest max_capacitance in target library
# Smaller values may be preferable for increased accuracy over a smaller range
# CLKINVX32M/Y max_capacitance as reference
set max_capacitance 2.45678; #max cap was in tt corner

# -----------------------------------------------------------------------------
# Transition time targets
# -----------------------------------------------------------------------------

# Keyed from "$transistor_$voltage_$temperature"

# Only max_transition($slow_corner_pvt) is required during implementation
# Others are used in analysis steps such as sta and model creation
# ARM suggests: 1. design frequency is equal or less than lib freq 66.7% of max lib, 
# 2. 1/5 of clock cycle
# take the small one
# default_max_transition : 2.38 ;
# clock cycle : 1000 (1 MHz maximum)
set max_transition          1.58   ;# 2.38 * 0.667  

# Clock transition requirement
set max_clock_transition    [expr {$max_transition/2.0}]

# max fanout 
set max_fanout 32            ;# Maximum fanout threshold

#####################################################################################
# 3. Design libraries
#####################################################################################

# -----------------------------------------------------------------------------------
# Path to libraries
# -----------------------------------------------------------------------------------

if {[info exists sh_launch_dir] == 0} {
  set sh_launch_dir "."
}

# Set the base path for libraries (e.g. "/projects/my_project/libraries")
set stdcell_db_path "../tech/sc7_lib/db"
#set flash_db_path "../tech/HHG_FS13Q7P6_FPFLE032K09DA_32Kx8/synopsys_model"
set flash_mod_path "../tech/Flash_mod_lib"
set io_db_path "../tech/HHG_F013Q7P6_PADLRCMCUDB41K/synopsys_model/3.3v"
set ana_db_path "../tech/ana_lib"
# Standard Cells Symbol library
set stdcell_sdb_path "../tech/sc7_lib/sdb"
set stdcell_sdb "sc7_l013_base_rvt.sdb"
# RTL verilog folder
set verilog_rtl_path "../../rtl/"

# -----------------------------------------------------------------------------
# Techfile and metal stack extract models
# -----------------------------------------------------------------------------

set tech_file             [list /home/projects/digitech/HHG130nm_eFlash_ARM/arm/grace/l013/arm_tech/r1p0/milkyway/S7G0_5M/sc7_tech.tf]
set tf2itf_map_file       [list /home/projects/digitech/HHG130nm_eFlash_ARM/arm/grace/l013/arm_tech/r1p0/synopsys_tluplus/S7G0_5M/tluplus.map]
#
## Keyed from '$extraction'
#
set tluplus_file($slow_corner_extraction) [list /home/projects/digitech/HHG130nm_eFlash_ARM/arm/grace/l013/arm_tech/r1p0/synopsys_tluplus/S7G0_5M/MIN.tluplus]
set tluplus_file($typ_corner_extraction)  [list /home/projects/digitech/HHG130nm_eFlash_ARM/arm/grace/l013/arm_tech/r1p0/synopsys_tluplus/S7G0_5M/TYP.tluplus]
set tluplus_file($fast_corner_extraction) [list /home/projects/digitech/HHG130nm_eFlash_ARM/arm/grace/l013/arm_tech/r1p0/synopsys_tluplus/S7G0_5M/MAX.tluplus]

set stdcell_mw_library [list /projects/libs/baf4p1/digital_work/GY_BAF4P1_DIG/pnr/lib_inputs/mw/sc7_l013_base_rvt]
set ana_mw_library     [list /projects/libs/baf4p1/digital_work/GY_BAF4P1_DIG/pnr/lib_inputs/mw/BAF4P1_ANA_CHIP_syn.mw]
set flash_mw_library     [list /projects/libs/baf4p1/digital_work/GY_BAF4P1_DIG/pnr/lib_inputs/mw/FLASH_baf4.mw]
set io_mw_library     [list /projects/libs/baf4p1/digital_work/GY_BAF4P1_DIG/pnr/lib_inputs/mw/IO.mw]

# -----------------------------------------------------------------------------
# Library search path and Milkyway locations
# -----------------------------------------------------------------------------
set stdcell_search_path     [list $stdcell_db_path $stdcell_sdb_path]
#set flash_search_path         [list $flash_db_path]
set flash_mod_search_path   [list $flash_mod_path]
set io_search_path          [list $io_db_path]
set ana_search_path         [list $ana_db_path]

# -----------------------------------------------------------------------------
# Library search path and Milkyway locations
# -----------------------------------------------------------------------------
set verilog_search_path     [list $verilog_rtl_path]

# Standard Cells db

set stdcell_library(db,$fast_corner_pvt) [ list \
                                        ${ff_lib_name}.db \
                                        ]

set stdcell_library(db,$slow_corner_pvt) [ list \
                                        ${ss_lib_name}.db \
                                        ]

set stdcell_library(db,$typ_corner_pvt)  [ list \
                                        ${tt_lib_name}.db \
                                        ]

# FLASH
#set flash_max_library [list FPFLE032K09DA_max.db]
set flash_mod_max_library [list FPFLE032K09DA_max_mod.db]
set flash_min_library [list FPFLE032K09DA_min.db]
set flash_typ_library [list FPFLE032K09DA_typ.db]

# IO
set io_max_library [list PADLRCMCUDB_max.db]
set io_min_library [list PADLRCMCUDB_min.db]
set io_typ_library [list PADLRCMCUDB_typ.db]

# Analog
set ana_max_library [list BAF4P1_ANA_CHIP_wc.db]
set ana_min_library [list BAF4P1_ANA_CHIP_bc.db]
set ana_typ_library [list BAF4P1_ANA_CHIP_tc.db]

# -----------------------------------------------------------------------------
# Operating conditions
# -----------------------------------------------------------------------------

# Keyed from "$transistor_$voltage_$temperature"


set operating_condition_name($fast_corner_pvt)  $fast_corner_pvt
set target_library_name($fast_corner_pvt)       $ff_lib_name

set operating_condition_name($slow_corner_pvt)  $slow_corner_pvt
set target_library_name(${slow_corner_pvt})     $ss_lib_name

set operating_condition_name(${typ_corner_pvt}) $typ_corner_pvt
set target_library_name(${typ_corner_pvt})      $tt_lib_name

# -----------------------------------------------------------------------------
# Tetramax ATPG cell views
# -----------------------------------------------------------------------------

set tmax_library [ list \
                        ../tech/sc7_lib/tetramax/sc7_l013_base_rvt.tv \
                       ]

# -----------------------------------------------------------------------------
# Don't use lists
# -----------------------------------------------------------------------------

# Keyed from a target libary name,
# Note: Use of wildcards permitted in Tcl for library names and cell names:
# e.g. set dont_use(sc7_ce018fg_base_rvt*) [list *_XL_* ]

set dont_use(${sc}_*) {}

# Basic dont_use for specific cell types
lappend dont_use(${sc}_*) *CLK*
lappend dont_use(${sc}_*) *EDFF*
lappend dont_use(${sc}_*) DLY*
lappend dont_use(${sc}_*) TBUF*
lappend dont_use(${sc}_*) SDFFTR*

# Banning low drive strength cells may improve speed, but with area/power impact
#lappend dont_use(${sc}_*) *XL*
# Physical only: Tie cell
lappend dont_use(${sc}_*) TIE*

# Example of use within tool:
# foreach libraryname [array names dont_use] {
#     foreach dontusecelltype $dont_use($libraryname) {
#         echo "set_dont_use -power [get_object_name [get_lib_cells ${libraryname}/${dontusecelltype}]]"
#         set_dont_use -power [get_lib_cells ${libraryname}/${dontusecelltype}]
#     }
# }

# -----------------------------------------------------------------------------------
# Tool reporting defaults
# -----------------------------------------------------------------------------------

# Increase the precision of timing reports to 3 significant digits
# Note: *decreases* precision of area reports to 3 from 6 significant digits
set report_default_significant_digits 3

# End of File
