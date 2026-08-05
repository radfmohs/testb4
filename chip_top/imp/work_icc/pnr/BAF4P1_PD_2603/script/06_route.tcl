set STAGE "06_route"
echo "\n####  BEGIN POINT:  $STAGE \n"
set PREV    "04_post_cts"

################################################################################
# General ICC settings
source -e -v ./PROJECT.tcl

if {[file exists $rpt_path/RPT/${STAGE}] == 0}    {sh mkdir $rpt_path/RPT/${STAGE};    sh ln -snf $rpt_path/RPT/${STAGE} RPT/}
if {[file exists $rpt_path/output/${STAGE}] == 0} {sh mkdir $rpt_path/output/${STAGE}; sh ln -snf $rpt_path/output/${STAGE} output/}

close_mw_cel  -all_views
close_mw_lib $design_mw_lib
open_mw_lib $design_mw_lib
copy_mw_cel -from $PREV -to $STAGE
open_mw_cel  $STAGE
link

################################################################################
## DontTouch and DontUse settings
set_size_only   [get_flat_cell $size_only]
set_dont_touch [get_flat_cells *DNT*]
set_dont_use [get_lib_cells {*/*EDFF* */*TBUF* */*SDFFTR* */*XL* */*TIE* */DLY* */CLK*}]

set_attribute [get_flat_nets -all -filter net_type==Clock] dont_touch 1

################################################################################
## Create corners, scenarios and OPCOND
source ${DIR}/create_scenarios.tcl
set_active_scenarios -all
foreach scenario [all_active_scenarios] {
  current_scenario $scenario
  remove_ideal_network [all_fanout -flat -clock_tree]
  set_propagated_clock [all_clocks]
}
current_scenario S11_max
set_fp_voltage_area_constraints -allow_feedthroughs true
set_fp_pin_constraints -allow_feedthroughs on -keep_buses_together on

################################################################################
## VPP and IO PAD pins routing freeze
set SKIP_ROUTE1 [get_nets -all VPP] 
set_att $SKIP_ROUTE1    dont_touch true
set_net_routing_rule -reroute freeze $SKIP_ROUTE1

set SKIP_ROUTE2 [get_nets -all VREF0P8] 
set_att $SKIP_ROUTE2   dont_touch true
set_net_routing_rule -reroute freeze $SKIP_ROUTE2 
set IO_PADNET     [get_nets -of [get_pins -filter "name==P" -of [get_flat_cells -filter "mask_layout_type==io_pad"]]]
set_net_routing_rule -reroute freeze  $IO_PADNET

################################################################################
##Extra PD options
#ana_blkg
create_routing_blockage -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage} -bbox {{0.000 0.000} {2500.000 679.500}}
create_routing_blockage -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage} -bbox {{212.200 679.500} {2500.000 836.045}}
create_routing_blockage -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage} -bbox {{782.165 836.045} {2500.000 1242.590}}
create_routing_blockage -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage} -bbox {{891.595 1242.590} {2500.000 1464.985}}
create_routing_blockage -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage} -bbox {{1037.640 1464.985} {2500.000 1646.810}}
create_routing_blockage -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage} -bbox {{1218.020 1646.790} {2500.000 2232.000}}
create_routing_blockage -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage} -bbox {{1959.625 2232.000} {2500.000 2450.000}}

################################################################################
##Antenna constraints
set_route_zrt_detail_options  -antenna true  
set_route_zrt_detail_options  -diode_libcell_names $ANTENNA
set_route_zrt_detail_options  -antenna_on_iteration  15
source -echo $antenna

################################################################################
## ICC routing settings
set_si_options -delta_delay true  \
               -route_xtalk_prevention true \
               -route_xtalk_prevention_threshold 0.2 \
               -analysis_effort medium 

set_si_options -min_delta_delay true 

set_route_opt_strategy -search_repair_loop 40
set_route_opt_strategy -route_drc_threshold -1
set_route_zrt_detail_options -timing_driven false
set_route_zrt_common_options -post_detail_route_fix_soft_violations true
set_route_zrt_common_options -read_user_metal_blockage_layer true
set_ignored_layers -max_routing_layer M5
set_app_var psynopt_high_fanout_legality_limit 32
set_max_fanout 32 [get_lib_pins */*M*/* -filter "pin_direction==out"]
## 180um lib guideline
set_route_options -same_net_notch check_and_fix
set_parameter -module droute -name cornerSpacingMode -value 1
set_route_zrt_common_options -read_user_metal_blockage_layer true

if {[sizeof_col [get_cells -q *IO_PREBUF*]] != 0} {
    set IO_BUF  [get_cells -q *IO_PREBUF*]
    set IO_BUF_NET     [get_nets -segment -of $IO_BUF]
    #define_routing_rule  NDR_IOBUF -spacings "M3  0.82  M4  0.82  M5  0.82" 
    #set_net_routing_rule -rule NDR_IOBUF  [get_object_name $IO_BUF_NET]
    set_net_routing_layer_constraints  $IO_BUF_NET   -min_layer_name M3 -max_layer_name M5 -min_layer_mode  allow_pin_connection
}

################################################################################
## NDR Routing
## Route NDR first
remove_route_guide ROUTE_UTIL_ANA
set pin_ana [get_pins -all -filter "(name==D2A_SDM_CLK || name==A2D_SDM_OUT || name=~D2A_Z* || name=~A2D_Z*) && name!~*SEL* && name!~*EN" -of [get_cells u_top_ana]]
set ndr_net [get_nets -of $pin_ana]
route_zrt_group -nets  [get_object_name  $ndr_net]  -route_nondefault_nets_first true -max_detail_route_iterations 20
#set_net_routing_rule -reroute freeze  $ndr_net


## ANA CLK shielding
if {1} {
define_routing_rule  CLK_SHIELD  -widths "M3  0.4  M4  0.4  M5  0.4"  -shield ; # -shield_widths "M5 0.64 MTOP 0.64" shield_spacings "M5 0.4 MTOP 0.4"
set ANA_CLK  [get_nets -of [get_flat_pins */D2A_SDM_CLK]]
set_net_routing_layer_constraints  $ANA_CLK  -min_layer_name M3 -max_layer_name M5 -min_layer_mode  allow_pin_connection
set_net_routing_rule -rule  CLK_SHIELD [get_object_name $ANA_CLK]
route_zrt_group -nets $ANA_CLK  -max_detail_route_iterations 20
create_zrt_shield -nets $ANA_CLK -mode new  -with_ground VSS_DIG_SW  -ignore_shielding_net_pins true
}

derive_pg_connection

########################################
#             ROUTE_DESIGN             #
########################################
route_opt -initial_route_only
set_route_opt_strategy -search_repair_loop 10
set_route_zrt_detail_options  -antenna_on_iteration  15
set_route_zrt_detail_options  -antenna_fixing_preference hop_layers
#set_route_zrt_detail_options  -antenna_fixing_preference use_diodes
set_route_zrt_detail_options  -insert_diodes_during_routing  false
set_route_zrt_detail_options  -diode_libcell_names  $ANTENNA
route_opt -initial_route_only -stage detail

verify_zrt_route -antenna true -drc true -voltage_area false 

################################################################################
## Connect PG
#source ./connect_pg.tcl
derive_pg_connection 

################################################################################
##Save DB
save_mw_cel -as ${STAGE}

return
########################################
#           REPORT DESIGN              #
########################################
create_qor_snapshot -clock_tree -name $STAGE
redirect -file RPT/$STAGE/$STAGE.qor_snapshot.rpt {report_qor_snapshot -no_display}

if {1} {
redirect -file RPT/$STAGE/$STAGE.qor {report_qor}
redirect -file RPT/$STAGE/$STAGE.qor -append {report_qor -summary}
redirect -file RPT/$STAGE/$STAGE.constraints {report_constraints}
}

#redirect -file RPT/$STAGE.max.tim {report_timing -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay max}
#redirect -file RPT/$STAGE.min.tim {report_timing -nosplit -unique_pins -sort_by slack -significant_digits 3 -slack_lesser_than 0 -max_path 100000 -crosstalk_delta  -capacitance -transition_time -input_pins -nets -delay min}


echo "\n####  END POINT:  $STAGE"
