set STAGE "01_place_opt"
echo "\n####  BEGIN POINT:  $STAGE"
set PREV    "00_init"
################################################################################
# General useful settings
source -e -v ./PROJECT.tcl

close_mw_cel  -all_views
close_mw_lib $design_mw_lib
open_mw_lib $design_mw_lib
copy_mw_cel -from $PREV -to $STAGE
open_mw_cel  $STAGE
link

if {[file exists $rpt_path/RPT/${STAGE}] == 0} {sh mkdir $rpt_path/RPT/${STAGE};   sh ln -snf $rpt_path/RPT/${STAGE} RPT/}
if {[file exists $rpt_path/output/${STAGE}] == 0} {sh mkdir $rpt_path/output/${STAGE}; sh ln -snf $rpt_path/output/${STAGE} output/}

set_attribute [all_macro_cells] is_fixed true
set_att [get_cells -all *FILL*] is_fixed true

################################################################################
##Partial checkerboard blockages in core area for even placement
source ./NNC_setup.tcl
add_checkerboard_blkgs {10 20}

#g set AREA {222.000 842.740 771.400 1872.390  771.400 1653.240 956.310 1819.465  953.850 1653.240 1124.410 1820.020  1121.130 1653.290 1211.620 2232.130 770.580 1241.850 884.970 1658.000 884.560 1471.450 1035.850 1658.000}
#g set cnt 0
#g set step 50
#g foreach {x1 y1 x2 y2} $AREA {
#g     for {set x $x1} {$x < $x2} {set x [expr $x + $step]} {
#g         for {set y $y1} {$y < $y2} {set y [expr $y + $step]} {
#g             set per 15
#g             if {$x1 == 212} {set per 5}
#g             #if {$y >2727 && $x>1367} {set per 15}
#g             create_placement_blockage  -name PARTIAL_DEN_[incr cnt] -type partial -blocked_percentage $per -bbox "{$x $y} {[expr $x+$step] [expr $y+$step]}"
#g         }
#g     }
#g }
#g 
################################################################################
## CELL PADDING
#g set ANA_PORT     [get_flat_cells  {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_rom/* }]
#g set PIN_UTIL     [get_flat_cells -filter "ref_name=~*AO*||ref_name=~*OA*||ref_name=~*4X*||ref_name=~*2X*" u_top_dig/flash_ctrl_top_inst/u_bist/data_generator_i/*]
#g set_keepout_margin -outer  {0 1 0 0 } -type hard  $ANA_PORT
#g set_keepout_margin -outer  {0 0.8 0 0 } -type hard  $PIN_UTIL
set_keepout_margin -all_macros -type hard -outer {6 6 6 6 } 
set_keepout_margin -all_macros -type soft -outer {20 20 20 20}

################################################################################
## FLASH/ANA route guide
regexp "{(.+) (.+)} {(.+) (.+)}" [get_att [get_cells -all u_top_dig/flash_ctrl_top_inst/u_32k] bbox] - x1 y1 x2 y2
set box  "$x1 [expr $y1-10] $x2 $y2"
create_route_guide -name ROUTE_UTIL_FLASH -coordinate $box -horizontal_track_utilization 90 -vertical_track_utilization 90 -track_utilization_layers {M2 M3 M4} -no_snap
create_route_guide -name ROUTE_UTIL_ANA -no_signal_layers {M4 M5} -coordinate {{774.730 874.440} {786.775 1216.150}} -no_snap

################################################################################
## NDR ANA rules
set pin_ana [get_pins -all -filter "(name==VREF0P8 || name=~Z_*) && direction==inout" -of [get_cells u_top_ana]]
 set pin_sig [get_pins -all -filter "(name==D2A_SDM_CLK || name==A2D_SDM_OUT || name=~D2A_Z* || name=~A2D_Z*) && name!~*SEL* && name!~*EN" -of [get_cells u_top_ana]]
 set pin_ana [add_to_col $pin_ana [get_pins -all u_iopad_plvpp/VPP]]
 set ndr_net [get_nets -of [add_to_col $pin_ana $pin_sig]]
 
 define_routing_rule  NDR_ANA -spacings "M3  0.82  M4  0.82  M5  0.82" -widths "M3  0.4  M4  0.4  M5  0.4"  
 set_net_routing_rule -rule NDR_ANA  [get_object_name [get_nets -of [add_to_col $pin_ana $pin_sig]]]
 set_net_routing_layer_constraints  [get_nets -of [add_to_col $pin_ana $pin_sig]]  -min_layer_name M3 -max_layer_name M5 -min_layer_mode  allow_pin_connection
 
################################################################################
## ANA SHIELD
 set cnt 0
 set pin_ana [get_pins -all -filter "(name==VREF0P8 || name=~Z_*) && direction==inout" -of [get_cells u_top_ana]]
 set m4_shape [get_net_shapes -filter {layer_name==M5 && length > 15} -of [get_nets -of $pin_ana]]
 foreach i [get_att $m4_shape bbox] {create_route_guide -no_signal_layers M4 -name ANA_SHIELD_[incr cnt] -coordinate $i}


################################################################################
## ADD PREBUFFERS for IO and ANA 
################################################################################
## Insert AO_buffer
source -e -v ./AO_buf.tcl
if {[sizeof_col [get_cells -q -hier IO_PREBUF*]] != 0} {
    set IO_BUF  [get_cells -q -hier IO_PREBUF*]
    set IO_BUF_NET     [get_nets -segment -of $IO_BUF]
    set_att $IO_BUF_NET    dont_touch true
    set_att $IO_BUF        dont_touch true
    set_net_routing_layer_constraints  $IO_BUF_NET   -min_layer_name M3 -max_layer_name M5 -min_layer_mode  allow_pin_connection
}

source -e -v ./AO_PIN.tcl
source -e -v ./ana_buffers.tcl

################################################################################
## VPP and IO PAD pins Donttouch setting 
set     net_ana     [get_nets -of $pin_ana]
set_att $net_ana    dont_touch true

set SKIP_ROUTE1 [get_nets -all VPP] 
set_att $SKIP_ROUTE1    dont_touch true
set_net_routing_rule -reroute freeze $SKIP_ROUTE1

set SKIP_ROUTE2 [get_nets -all VREF0P8] 
set_att $SKIP_ROUTE2   dont_touch true
set_net_routing_rule -reroute freeze $SKIP_ROUTE2 

#######################
## PLACE OPT SETTING ## 
#######################
################################################################################
## DontTouch and DontUse settings
set_dont_use    [get_lib_cells  $dont_use]
set_size_only   [get_flat_cell $size_only]
set_dont_touch [get_flat_cells *DNT*]
set_dont_use [get_lib_cells {*/CLK* */*EDFF* */*TBUF* */*SDFFTR* */*XL* */*TIE* */DLY*}]

#gset_dont_use    [get_lib_cells  $dont_use]
#gset_size_only   [get_flat_cell $size_only]

################################################################################
##Transition/Cap settings
#set_max_transition 0.8 [get_lib_pins */*M*/* -filter "pin_direction==in"]
#set_max_capacitance 0.8 [get_lib_pins */*M*/* -filter "pin_direction==out"]
set_max_fanout 32 [get_lib_pins */*M*/* -filter "pin_direction==out"]
################################################################################
## SCANDEF
read_def $scandef
################################################################################
## Create corners, scenarios and OPCOND
source -e -v ./create_scenarios.tcl

set_active_scenarios -all
foreach scenario [all_active_scenarios] {
   current_scenario $scenario
   set_ideal_network [all_fanout -flat -clock_tree ]
}
current_scenario S11_max

remove_propagated_clock -all
set_operating_conditions -analysis_type bc_wc -max $max_cond -max_library $max_lib  -min $min_cond -min_library $min_lib

set_ideal_network [all_fanout -flat -clock_tree ]

## SPARE
if {1} {
set SPARE_LIST {DFFNSRHX2M 1 NAND2BX2M 1 NOR2X2M 1 AND2X2M 1 OR2X2M 1 INVX8M 2}
set_keepout_margin -outer {100 100 100 100} $SPARE_LIST
insert_spare_cells -num_cells $SPARE_LIST -cell_name pd_spare -hier_cell u_top_dig
set_undoable_attribute [get_cells -all */*pd_spare*] is_soft_fixed {1}
remove_keepout_margin $SPARE_LIST

}

#g set_attribute [get_placement_blockages AO_BUF_*] type {hard}
save_mw_cel -as ${STAGE}_1  
################################################################################
## SANITY CHECK
set_zero_interconnect_delay_mode true
report_constraint -all -max_delay -nosplit > RPT/01_init.constraint
set_zero_interconnect_delay_mode false

#report_clock -nosplit  > RPT/$STAGE.report_clock

################################################################################
##ICC placeopt settings
set_delay_calculation_options -preroute elmore
set_delay_calculation_options -postroute arnoldi -arnoldi_effort medium
set_app_var enable_recovery_removal_arcs true
set_app_var compile_instance_name_prefix icc_place  
set_max_net_length  1010  $DESIGN_NAME

# Controls the effort level of TNS optimization:	[medium|high]
set_optimization_strategy -tns_effort medium

set_place_opt_strategy -default
#set_place_opt_strategy -layer_optimization "true|flase" -layer_optimization_effort "medium|high" -consider_routing "false|true"
#set_place_opt_strategy -layer_optimization "true" -layer_optimization_effort "medium" -consider_routing "true"
report_place_opt_strategy

set_app_var placer_reduce_high_density_regions true
set_app_var placer_channel_detect_mode true
set_app_var placer_max_cell_density_threshold 0.70
set_app_var psynopt_high_fanout_legality_limit 32
get_app_var psynopt_high_fanout_legality_limit

################################################################################
##Partial blkgs to reduce shorts
create_placement_blockage -coordinate {{225.280 1118.370} {502.625 1141.255}} -name ctrl_cd1 -type partial -blocked_percentage 60
create_placement_blockage -coordinate {{225.280 1319.780} {266.280 1342.740}} -name ctrl_cd2 -type partial -blocked_percentage 70
create_placement_blockage -coordinate {{691.310 1603.035} {785.975 1710.920}} -name shorts1 -type partial -blocked_percentage 30
create_placement_blockage -coordinate {{1069.060 1652.260} {1075.620 1675.220}} -name shorts2 -type partial -blocked_percentage 90
create_placement_blockage -coordinate {{826.735 1668.030} {877.825 1698.310}} -name shorts3 -type partial -blocked_percentage 20


########################################
#           START PLACE OPT            #
########################################
stop_gui
set place_opt_cmd "place_opt -area_recovery  -effort high  -congestion -optimize_dft" 
set_host_options -max_cores 16
#place_opt -area_recovery  -effort high   -optimize_dft  -continue_on_missing_scandef
place_opt -area_recovery -effort high -optimize_dft
#return

save_mw_cel -as ${STAGE}_done 
#psynopt -area_recovery 

if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }
## preroute_focal_opt -size_only_mode
#  Use the command to perform preroute focal optimizations with cell sizing only

## psynopt -refine_critical_paths max_path_count
#  Use the command to perform register optimization. 
#  Register optimization moves registers and combinational logic along timing paths to minimize timing violations.
################################################################################
## Add Tie cells
remove_tie_cells [all_tieoff_cells]
redirect -variable TIE {report_tie_nets}
set TIE_PIN [get_pins -q [lsort -u $TIE]]
connect_tie_cells -max_fanout 5  -max_wirelength 20 -tie_low_lib_cell TIELOM -tie_high_lib_cell TIEHIM  -obj_type port_inst  -objects $TIE_PIN 

set AO_PIN  [get_flat_pins -filter "direction==in && net_name=~*TIE*"]
set AO_ALL  [get_cells -all -of [get_nets -of $AO_PIN] -filter "name=~*TIE*"]

legalize_placement -cells $AO_ALL
set_attribute -quiet $AO_ALL  is_fixed true
#set_attribute -quiet [get_flat_cells  {TIELO* TIEHI*}]  is_fixed true

report_tie_nets

########################################
#           CONNECT P/G                #
########################################
source -e -v ./connect_pg.tcl
derive_pg_connection

################################################################################
# Remove checkerboard blockages and save DB
#remove_keepout_margin -type hard  $ANA_PORT
remove_placement_blockage PB*

if { [check_error -verbose] != 0} { echo "RM-Error, flagging ..." }

save_mw_cel -as ${STAGE} 
return
################################################################################
###############################################################
check_legality

all_tieoff_cells
report_tie_nets

return

########################################
#           WRITE REPORT               #
########################################
create_qor_snapshot -clock_tree -name $STAGE

redirect -file RPT/$STAGE/$STAGE.constraints {report_constraints}
redirect -file RPT/$STAGE/$STAGE.placement_utilization.rpt {report_placement_utilization -verbose}
redirect -file RPT/$STAGE/$STAGE.qor {report_qor}
redirect -file RPT/$STAGE/$STAGE.qor -append {report_qor -summary}
redirect -file RPT/$STAGE/$STAGE.qor_snapshot.rpt {report_qor_snapshot -no_display}

redirect -file RPT/$STAGE/$STAGE.sys_max.tim {report_timing -scenarios func -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay max}
redirect -file RPT/$STAGE/$STAGE.sys_min.tim {report_timing -scenarios func -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay min}
redirect -file RPT/$STAGE/$STAGE.dft_max.tim {report_timing -scenarios scan -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay max}
redirect -file RPT/$STAGE/$STAGE.dft_min.tim {report_timing -scenarios scan -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay min}

u_dig_top_wrapper/u_dig_top/gen_pl230_udma_u_dmac_top_wrapper/x_dmac_top/x_dmac_chfsm_ctrl/x_dmac_fsmc7/cntr_rdsrc_reg_1_/Q
u_dig_top_wrapper/top_dig_always_on_inst/shadow_regs_always_on_inst/imeas_ch1_dinrce_reg_10_/SI
echo "\n####  END POINT:  $STAGE"
