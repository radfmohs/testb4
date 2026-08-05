

set_host_options -max_cores 8

set DIR [pwd]

alias off {stop_gui}
alias win {start_gui}
alias cs {change_selection}
alias gs {get_selection}
alias ss {get_object_name [get_selection]}
alias name {get_object_name }
alias gc {get_flat_cells -all }
alias gn {get_nets -all}
alias gp {get_flat_pins -all}
alias mc {all_macro_cells}
alias gm {change_selection [all_macro_cells]}
alias n  {get_object_name}
alias att {get_attr [get_selection]}
alias satt {get_attribute [gs]}
alias bbox {get_attribute [gs] bbox}
alias blk  {get_placement_blockages}
alias gblk {blk -filter "name!~CORE*"}
alias rr  {write_route  -objects  [get_selection ] -output }

proc sc   {in} {set DIR [pwd] ; source $DIR/$in}

proc scr  {in} {set DIR [pwd] ; puts "\nsource $DIR/$in"}

proc cc {x y {n 0}} {set dir [pwd] ; rr a ; mm $x $y ; if {$n != 0 } {set_undoable_att [gs] owner_net $n} ; source $dir/a }

proc pls {in {s xx}} { if {$s != "xx" } {set in [lsort -u -dic $in]} ; foreach i $in {puts $i} }

proc mv {x y} {move_objects -ignore_fixed -x $x -y $y [get_selection]}
proc mm {x y} {move_objects -ignore_fixed -delta "$x $y" [get_selection]}
proc al {x} {align_objects -ignore_fixed  -side [string map "l Left r Right t TOP b Bottom" $x] [get_selection]}
proc dd {x o} {distribute_objects  -ignore_fixed  -offset $o -side [string map "l Left r Right t TOP b Bottom" $x] [get_selection]}
proc ex {x {o 0}} {expand_objects -ignore_fixed   -offset $o -side [string map "l Left r Right t TOP b Bottom" $x] [get_selection]}


proc l {extend {back 0}} {set l [lindex [get_att [gs] length] 0] ; set_undoable_att [gs] length [expr $l + $extend] }


alias x_rail {analyze_fp_rail  -nets {vdd_dig vss_dig} -analyze_power -pad_masters {RCMCU_PLVSS RCMCU_PLVDD} }

alias x_fp {write_floorplan -placement hard_macro -no_create_boundary }
alias x_blkg {
    foreach_in_collection i [gs] {
        set partial ""
        if {[get_att $i type]=="partial"} {set partial " -blocked_percentage [get_att $i blocked_percentage]"}
        puts "create_placement_blockage -type [get_att $i type]  -name [get_att $i name] $partial -bbox {[get_att $i bbox]}" 
    } 
}

alias cal {source /eda/calibre/aoi_cal_2020.2_14.12/shared/pkgs/icv.aoi/tools/querytcl/icc_gui.tcl}

alias ck {remove_stdcell_filler -stdcell ;  verify_lvs -max_error 2000  -use_notch_gap_fill_cell -check_single_pin_net_for_floating_port -check_single_pin_net_for_floating_net -check_floating_port_on_null_net -check_open_locator -check_short_locator }


################################################################################
# General useful settings
# Suppress warning NETLIST 
suppress_message {LINT-1 LINT-2}

# Suppress warning generated clock 
suppress_message {TIM-111 TIM-112}

# Suppress known and/or annoying messages
suppress_message {PSYN-040 PSYN-088 PSYN-058 PSYN-039 PSYN-024 RCEX-060 PSYN-087 PSYN-850 TFCHK-055}

# Suppress warnings about metal layer pitch that occurs during create_mw_lib:
suppress_message {TFCHK-049 TFCHK-050}

# Suppress warning that "43 logical cells do not have P/G pins" from check_mv_design -power_nets:
suppress_message {MV-597}

# Suppress warning about ignored DEF syntax and "Information" about "preferred wire track direction
#  not being set" during read_def:
suppress_message {DDEFR-054 MWDEFR-159}

# Suppress warning about "skipping AHFS on don't touch high-fanout nets" during place_opt:
suppress_message {PSYN-1002}

# Suppress warnings about "Ignore pin on layer 0", "Ignore top cell pins with no ports", 
# and "METAL pitch too small" during route_zrt_global -congestion_map_only true:
suppress_message {ZRT-026 ZRT-027 ZRT-030}

# Suppress warning about "P/G ports being on non-routing layer "UNKNOWN" " and warning about
# using Elmore instead of "clock_arnoldi" delay calculation model during clock_opt:
suppress_message {MWLIBP-311 CTS-352}

# Suppress warning about "not enough nets being routed" during route_opt:
suppress_message {RCEX-047}

# Suppress warning: Power connection/checking is skipped for 2666 power pins because the required power pin information cannot be found in logical libraries. 
suppress_message {MV-510}


################################################################################
# Disable more-like page mode
set_app_var enable_page_mode false
# Don't want to see CMD-041 when creating new variables
set_app_var sh_new_variable_message false
# Increase history buffer from 20 commands to 100
history keep 200


################################################################################
# Enable logging of commands and everything by date/shell
if {[file exists log] == 0} {sh mkdir log}
set timestamp [clock format [clock scan now] -format "%Y-%m-%d_%H-%M"]
set sh_output_log_file  log/${STAGE}.log.[pid].$timestamp
set sh_command_log_file log/${STAGE}.cmd.[pid].$timestamp


################################################################################
#reset all variables in design
set std_lib_max {}
set std_lib_min {}
set std_lib_typ {}
set link_library {}

################################################################################
# IP setup variables
set DESIGN_NAME  "Nanochap_BAF4"  ;#  The name of the top-level design
set design_mw_lib "${DESIGN_NAME}"

set project_path "/projects/libs/baf4/digital_work/GY_BAF4_DIG/pnr"

## Define inputs
set lib_inputs      "$project_path/lib_inputs"
set syn_inputs      "$project_path/syn_inputs"
set tech_inputs     "$project_path/tech_inputs"
set tluplus_inputs  "$project_path/tluplus_inputs"

set netlist   "$syn_inputs/${DESIGN_NAME}.postscan.v"
set scandef   "$syn_inputs/${DESIGN_NAME}.dft_scandef"
set sdc	      "$syn_inputs/${DESIGN_NAME}.postscan.sdc"
set scan_sdc  "$syn_inputs/${DESIGN_NAME}.postscan_pteco_scan.sdc"

#set bist_sdc  "/barista/scratch/gayathri/bms5/pnr/BMS5_0902/inputs_1503/Nanochap_BMS5_constraints_bist.tcl"

#set tech_file "/home/projects/digitech/HHG130nm_eFlash_ARM/arm/grace/l013/arm_tech/r1p0/milkyway/S7G0_6M/sc7_tech.tf"
set tech_file "$tech_inputs/sc7_tech.tf"
set antenna   "$tech_inputs/antenna_rules.tcl"
set gds_out   "$tech_inputs/stream_out_layer_map"
set re_via    "$tech_inputs/icc_route_options.tcl"


set max_cond  "max"   ;# "ss_typical_max_1p35v_125c  ss_1p35v_125c  max  MAX"
set min_cond  "min"   ;# "ff_typical_min_1p65v_m40c  ff_1p65v_-40c  min  MIN"
set typ_cond  "typ"    ;# "tt_typical_max_1p50v_25c   tt_1p50v_25c   typ  TYP"

set tlup_map  "$tluplus_inputs/tluplus.map"
set tlup_max  "$tluplus_inputs/MAX.tluplus"
set tlup_min  "$tluplus_inputs/MIN.tluplus"
set tlup_typ  "$tluplus_inputs/TYP.tluplus"

set nxtgrd_max "$tech_inputs/GSMC_A013S5G0_tran_max_1p05um.nxtgrd"
set nxtgrd_min "$tech_inputs/GSMC_A013S5G0_tran_min_1p05um.nxtgrd"

#set_starrcxt_options -map_file $tlup_map -max_nxtgrd_file $nxtgrd_max -min_nxtgrd_file $nxtgrd_min -exec_dir /eda/digital/starrc_201312_SP3/bin/
#set_si_options -delta_delay true -static_noise false -timing_window true -min_delta_delay false -static_noise_threshold_above_low 0.35 -static_noise_threshold_below_high 0.35 -route_xtalk_prevention true -route_xtalk_prevention_threshold 0.35

#  set search_path "
#  ../input/libs_210701/FLASH/DB  
#  ../input/libs_210701/IO/DB/3.3v  
#  ../input/libs_210701/ROM/DB  
#  ../input/libs_210701/SRAM/DB  
#  ../input/libs_210701/STD/DB
#  ../input/libs_210701/ANA/DB
#  "
set search_path "
${lib_inputs}/DB
"
set db_list       "${lib_inputs}/DB/db_list"   
set db_max_list   "${lib_inputs}/DB/db_max_list"   
set db_min_list   "${lib_inputs}/DB/db_min_list"   
# ls ../input/libs_210701/*/DB/*db ../input/libs_210425/IO/DB/3.3v/*db | egrep "25c|40c|FLASH|IO" | sed 's|.*/||'  > ../input/libs_210425/db_list

set std_lib_max "sc7_l013_base_rvt_ss_TYP_max_1p35v_125c.db"
set std_lib_min "sc7_l013_base_rvt_ff_TYP_min_1p65v_m40c.db"
#set std_lib_typ "sc7_l013_base_rvt_tt_TYP_max_1p50v_25c.db"
################################################################################
##### Logic Library settings
#set target_library "$std_lib_max  $std_lib_min"
set all_lib       [lrange [read [open $db_list r]]     0 end]
set max_lib       [lrange [read [open $db_max_list r]] 0 end]
set min_lib       [lrange [read [open $db_min_list r]] 0 end]

#set target_library "$std_lib_max"
set link_library  "[join $all_lib {.db }].db"
set target_library $link_library

foreach {min max} $all_lib { set_min_library $max.db -min_version $min.db }
#set_operating_conditions -analysis_type bc_wc -max $max_cond -max_library $max_lib  -min $min_cond -min_library $min_lib
#set_operating_conditions -analysis_type on_chip_variation

################################################################################
##### Set Physical Library
set mw_ref_libs  "
$lib_inputs/mw/sc7_l013_base_rvt
$lib_inputs/mw/BAF4_ANA_CHIP.mw
$lib_inputs/mw/IO.mw
$lib_inputs/mw/FLASH.mw
"

################################################################################
##### Set Variable
#set dont_use    { */*X0* */BUF*X0* */INV*X0* */BUF*X20* */INV*X20* */*DLY* */*DFF*H* */*DFFX* }
#set dont_use    { */*X0* */*BUF*X0* */*INV*X0* */*BUF*X2*M */INV*X2*M */*BUF*X3*M */*BUF*X40M */INV*X3*M */*DLY* */*DFF*H* */*DFFX* */*TBUF* */*SDFFTR* */*XL* }
set dont_use    {*/CLK* */*EDFF* */*TBUF* */*SDFFTR* */*XL* */*TIE* */DLY*}
#set size_only   {*DNT* *ICG*}
set size_only   {*DNT* *ICG*}

#set CTS_CELLS   "BUF_X14B_A7TULL BUF_X12B_A7TULL BUF_X10B_A7TULL BUF_X8B_A7TULL"
#epc1 set CTS_CELLS   "INV_X14B_A7TULL INV_X12B_A7TULL INV_X10B_A7TULL INV_X8B_A7TULL"
set CTS_CELLS  "CLKBUFX20M CLKBUFX16M CLKBUFX12M CLKBUFX8M CLKBUFX6M CLKBUFX4M CLKBUFX3M CLKBUFX2M"
set CTS_INV    "CLKINVX20M CLKINVX16M CLKINVX12M CLKINVX8M  CLKINVX6M CLKINVX4M CLKINVX3M CLKINVX2M"
set SIZE_ONLY_INSTS ""


set HOLD_DELAY_CELLS  "*/*DLY4* */*DLY2* */DLY1* */BUF*"

set ANTENNA  "ANTENNAM"

set TAPCELL  "FILLTIEM"

set CAPCELL  "FILLCAP64M FILLCAP32M FILLCAP16M FILLCAP8M FILLCAP4M"
set FILLCELL "FILL64M FILL32M FILL16M FILL8M FILL4M FILL2M FILL1M"
set PADFILLCELL "RCMCU_PLFLR5 RCMCU_PLFLR1"


#define_routing_rule  NDR_2W_2S -spacings "M3  0.82  M4  0.82  M5  1.64" -widths "M3  0.4  M4  0.4  M5  0.8"  
#set_clock_tree_options -routing_rule NDR_2W_2S -layer_list "M3 M4 M5"  ;# -use_default_routing_for_sinks 1
##set_clock_tree_options -routing_rule NDR_2W_2S -layer_list "M3 M4 M5"   -use_default_routing_for_sinks 1



################################################################################
##### Additional
set SPARE_LIST {
PREICG_X4B_A7TULL  100 
SDFFRPQA_X2M_A7TULL 100
MXIT2_X2M_A7TULL  100
INV_X8B_A7TULL  600
NAND_X4M_A7TULL 200
OA21_X2M_A7TULL 100
}
set SPARE_LIST {DFFNSRHX2M 1 NAND2BX2M 1 NOR2X2M 1 AND2X2M 1 OR2X2M 1 INVX8M 2}

## METAL routing information
#  Layer  Pitch  Width
#  "M1"   0.41   0.16
#  "M2"   0.41   0.2
#  "M3"   0.41   0.2
#  "M4"   0.41   0.2
#  "M5"   0.82   0.4



