set_host_options -max_cores 16

set DIR [pwd]

alias off {stop_gui}
alias win {start_gui}
alias cs {change_selection}
alias gs {get_selection}
proc l {extend} {
set b [gs]
foreach_in_collection len $b {
set a [get_att $len length]
set_undoable_att $len length [expr $a + $extend]
} }

################################################################################
# General useful settings
# Suppress warning NETLIST 
# Suppress warnings about metal layer pitch that occurs during create_mw_lib:
suppress_message {TFCHK-049 TFCHK-050}

# Suppress warnings about "Ignore pin on layer 0", "Ignore top cell pins with no ports", 
# and "METAL pitch too small" during route_zrt_global -congestion_map_only true:
suppress_message {ZRT-026 ZRT-027 ZRT-030}

# Suppress known and/or annoying messages
suppress_message {PSYN-040 PSYN-088 PSYN-058 PSYN-039 PSYN-024 RCEX-060 PSYN-087 PSYN-850 TFCHK-055}

# Suppress warning: Power connection/checking is skipped for 2666 power pins because the required power pin information cannot be found in logical libraries. 
suppress_message {MV-510}
suppress_message {PSYN-040}
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
set DESIGN_NAME  "Nanochap_BAF4P1"  ;#  The name of the top-level design
set design_mw_lib "${DESIGN_NAME}"

## Define inputs
set central_path 	"/projects/libs/baf4p1/digital_work/GY_BAF4P1_DIG/pnr"
set nobackup_path	"/local/scratch/mohsen/baf4p1"
set rpt_path		"${nobackup_path}/BAF4P1_PD_2603"
set run_path 		"${central_path}/BAF4P1_PD_2603"
set lib_inputs      	"${central_path}/lib_inputs"
set syn_inputs      	"${central_path}/syn_inputs"
set tech_inputs     	"${central_path}/tech_inputs"
set tluplus_inputs  	"${central_path}/tluplus_inputs"

set netlist   "$syn_inputs/${DESIGN_NAME}.postscan.v"
set scandef   "$syn_inputs/${DESIGN_NAME}.dft_scandef"
set S11_max   "$syn_inputs/${DESIGN_NAME}.postscan.scre_S11_max.sdc"
set S11_min   "$syn_inputs/${DESIGN_NAME}.postscan.scre_S11_min.sdc"
set S12_max   "$syn_inputs/${DESIGN_NAME}.postscan.scre_S12_max.sdc"
set S12_min   "$syn_inputs/${DESIGN_NAME}.postscan.scre_S12_min.sdc"
set S22_max   "$syn_inputs/${DESIGN_NAME}.postscan.scre_S22_max.sdc"
set S22_min   "$syn_inputs/${DESIGN_NAME}.postscan.scre_S22_min.sdc"
set S3_max    "$syn_inputs/${DESIGN_NAME}.postscan.scre_S3_max.sdc"
set S3_min    "$syn_inputs/${DESIGN_NAME}.postscan.scre_S3_min.sdc"
set S4_max    "$syn_inputs/${DESIGN_NAME}.postscan.scre_S4_max.sdc"
set S4_min    "$syn_inputs/${DESIGN_NAME}.postscan.scre_S4_min.sdc"

set tech_file "$tech_inputs/sc7_tech.tf"
set antenna   "$tech_inputs/antenna_rules.tcl"
set gds_out   "$tech_inputs/stream_out_layer_map"
set re_via    "$tech_inputs/icc_route_options.tcl"

####################OPCOND################################
set max_cond  "max"   ;# "ss_typical_max_1p35v_125c  ss_1p35v_125c  max  MAX"
set min_cond  "min"   ;# "ff_typical_min_1p65v_m40c  ff_1p65v_-40c  min  MIN"
set typ_cond  "typ"    ;# "tt_typical_max_1p50v_25c   tt_1p50v_25c   typ  TYP"

####################TLUP################################
set tlup_map  "$tluplus_inputs/tluplus.map"
set tlup_max  "$tluplus_inputs/MAX.tluplus"
set tlup_min  "$tluplus_inputs/MIN.tluplus"
set tlup_typ  "$tluplus_inputs/TYP.tluplus"

####################STA-STARRC################################
set nxtgrd_max "$tech_inputs/GSMC_A013S5G0_tran_max_1p05um.nxtgrd"
set nxtgrd_min "$tech_inputs/GSMC_A013S5G0_tran_min_1p05um.nxtgrd"

#set_starrcxt_options -map_file $tlup_map -max_nxtgrd_file $nxtgrd_max -min_nxtgrd_file $nxtgrd_min -exec_dir /eda/digital/starrc_201312_SP3/bin/
#set_si_options -delta_delay true -static_noise false -timing_window true -min_delta_delay false -static_noise_threshold_above_low 0.35 -static_noise_threshold_below_high 0.35 -route_xtalk_prevention true -route_xtalk_prevention_threshold 0.35

####################LOGIC LIB settings################################
set search_path	  "${lib_inputs}/DB"
set db_list       "${lib_inputs}/DB/db_list"   
set db_max_list   "${lib_inputs}/DB/db_max_list"   
set db_min_list   "${lib_inputs}/DB/db_min_list"   

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

################################################################################
##### Set Physical Library
set final_lefs  "
${lib_inputs}/mw/lef/sc7_l013_base_rvt.lef
${lib_inputs}/mw/lef/FPFLE032K09DA_M5a.lef
${lib_inputs}/mw/lef/BAF4P1_ANA_CHIP.lef
${lib_inputs}/mw/lef/PADLRCMCUDB_M5t.lef
"
set mw_ref_libs  "
$lib_inputs/mw/sc7_l013_base_rvt
$lib_inputs/mw/BAF4P1_ANA_CHIP_pd.mw
$lib_inputs/mw/IO.mw
$lib_inputs/mw/FLASH.mw
"

################################################################################
##### Set Variable
set dont_use    {*/CLK* */*EDFF* */*TBUF* */*SDFFTR* */*XL* */*TIE* */DLY*}
set size_only   {*DNT* *ICG*}

set CTS_CELLS  "CLKBUFX20M CLKBUFX16M CLKBUFX12M CLKBUFX8M CLKBUFX6M CLKBUFX4M CLKBUFX3M CLKBUFX2M"
set CTS_INV    "CLKINVX20M CLKINVX16M CLKINVX12M CLKINVX8M  CLKINVX6M CLKINVX4M CLKINVX3M CLKINVX2M"
set SIZE_ONLY_INSTS ""


set HOLD_DELAY_CELLS  "*/*DLY4* */*DLY2* */DLY1* */BUF*"

set ANTENNA  "ANTENNAM"

set TAPCELL  "FILLTIEM"

set CAPCELL  "FILLCAP64M FILLCAP32M FILLCAP16M FILLCAP8M FILLCAP4M"
set FILLCELL "FILL64M FILL32M FILL16M FILL8M FILL4M FILL2M FILL1M"
set PADFILLCELL "RCMCU_PLFLR5 RCMCU_PLFLR1"

################################################################################
##### Additional
set SPARE_LIST {DFFNSRHX2M 1 NAND2BX2M 1 NOR2X2M 1 AND2X2M 1 OR2X2M 1 INVX8M 2}

## METAL routing information
#  Layer  Pitch  Width
#  "M1"   0.41   0.16
#  "M2"   0.41   0.2
#  "M3"   0.41   0.2
#  "M4"   0.41   0.2
#  "M5"   0.82   0.4



