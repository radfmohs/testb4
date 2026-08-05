############################################
##            Initial settings	           #
############################################

set STAGE   "07_chip_finish"
echo "\n####  BEGIN POINT:  $STAGE \n"
set PREV    "07_post_route"

################################################################################
# General ICC settings
source -e -v ./PROJECT.tcl

#################################################################################

if {[file exists $rpt_path/RPT/${STAGE}] == 0}    {sh mkdir $rpt_path/RPT/${STAGE};    sh ln -snf $rpt_path/RPT/${STAGE} RPT/}
if {[file exists $rpt_path/output/${STAGE}] == 0} {sh mkdir $rpt_path/output/${STAGE}; sh ln -snf $rpt_path/output/${STAGE} output/}

set ECO_FILE    ""
set ECOPLACE    "1"
set ECOROUTE    "1"
set SWAPVIA     "0"
set STDFILL     "1"
set EXPORT      "1"

################################################################################
# Restore DB
close_mw_cel   -all_views
close_mw_lib   $design_mw_lib
open_mw_lib    $design_mw_lib
copy_mw_cel    -from $PREV -to $STAGE
open_mw_cel    $STAGE
link

################################################################################
## DontTouch and DontUse settings
set_dont_use    [get_lib_cells  $dont_use]
set_size_only   [get_flat_cell $size_only]
set_dont_touch [get_flat_cells *DNT*]
set_dont_use [get_lib_cells {*/CLK* */*EDFF* */*TBUF* */*SDFFTR* */*XL* */*TIE*}]

set_attribute [get_flat_nets -all -filter net_type==Clock] dont_touch 1

################################################################################
#Check clk buffers in data path or vice-versa
source ./script/check_clkbuf_indata.tcl
sh gvim ./swap_clkbuf_tonor.tcl
source ./script/check_norbuf_inclk.tcl 
sh gvim ./swap_norbuf_toclk.tcl
source ./script/check_clkinv_indata.tcl 
sh gvim ./script/2.1.clkinv_filter.tcl
source ./script/check_norinv_inclk.tcl
sh gvim ./script/1.1.inv_filter.tcl

###############################################################################
## Eco Place any newly added/modified cells
if {$ECOPLACE} {
remove_stdcell_filler -stdcell 
place_eco_cells -eco_changed_cells  -legalize_only
legalize_placement -incremental
}

###############################################################################
## ECO route settings  
##Turn of soft spacing for timing optimization during chip finishing
set_route_zrt_detail_options -eco_route_use_soft_spacing_for_timing_optimization false
set_route_zrt_common_options -concurrent_redundant_via_mode off
set_route_zrt_global_options -timing_driven false -crosstalk_driven false
set_route_zrt_track_options  -timing_driven false -crosstalk_driven false
set_route_zrt_detail_options -timing_driven false

set_route_zrt_detail_options  -antenna_on_iteration  15
set_route_zrt_detail_options  -antenna_fixing_preference use_diodes
set_route_zrt_detail_options  -diode_libcell_names  $ANTENNA

########################
##      ECO route     ##
########################
if {$ECOROUTE} {
#gset ANA_NET  [get_nets -of [get_flat_pins */CLK2MHZ]]
#gcreate_zrt_shield -nets $ANA_NET -mode reshield  -with_ground VSS_DIG_AO  -ignore_shielding_net_pins true
route_zrt_eco -reroute modified_nets_first_then_others -open_net_driven true 
#route_zrt_detail -incremental true  -max_number_iterations 15
}

verify_zrt_route

##############################################################################
## Optional Check LVS and fix shorts

verify_lvs -max_error 2000  -use_notch_gap_fill_cell -check_single_pin_net_for_floating_port -check_single_pin_net_for_floating_net -check_floating_port_on_null_net -check_open_locator -check_short_locator

route_zrt_eco -nets [get_object_name $OPEN_NET] -max_detail_route_iterations 5

#############################################################################
## Insert Filler cells

if {$STDFILL} {
remove_stdcell_filler -stdcell 
if {$CAPCELL  != ""} {insert_stdcell_filler -cell_with_metal    $CAPCELL  -cell_with_metal_prefix    CAPCELL  -connect_to_power VDD -connect_to_ground VSS -dont_respect_soft_placement_blockage}
if {$FILLCELL != ""} {insert_stdcell_filler -cell_without_metal $FILLCELL -cell_without_metal_prefix FILLCELL -connect_to_power VDD -connect_to_ground VSS -dont_respect_soft_placement_blockage}
}

#############################################################################
## Connect PG
source ./connect_pg.tcl
derive_pg_connection

#############################################################################
## Save DB

change_names -rules verilog -hierarchy
save_mw_cel -as ${STAGE}



#######################################
####Outputs Script
#######################################
#gif {$EXPORT} {
extract_rc -coupling_cap
write_parasitics  -format SPEF -compress  -output   ./output/$STAGE/$STAGE.spef
write_verilog -diode_ports -no_physical_only_cells  ./output/$STAGE/$DESIGN_NAME.output.v -macro_definition

write_def -compressed  -output  ./output/$STAGE/$STAGE.def.gz

## For comparison with a Design Compiler netlist,the option -diode_ports is removed
write_verilog -no_physical_only_cells ./output/$STAGE/$DESIGN_NAME.output.dc.v -macro_definition

## For LVS use,the option -no_physical_only_cells is removed
write_verilog -diode_ports -pg ./output/$STAGE/$DESIGN_NAME.output.pg.lvs.v  -no_tap_cells -no_pad_filler_cells -force_no_output_references [concat $TAPCELL $FILLCELL]

## CELL LIST for LVS hcell
report_reference -nosplit -hierarchy  >  ./output/$STAGE/$DESIGN_NAME.reference

##SDC (optional)
set_app_var write_sdc_output_lumped_net_capacitance false
set_app_var write_sdc_output_net_resistance false

set cur_scenario [current_scenario]
foreach scenario [all_active_scenarios] {
  current_scenario $scenario
  write_sdc ./output/$STAGE/$DESIGN_NAME.$scenario.output.sdc
};
current_scenario $cur_scenario


###GDSII
echo "[get_object_name [current_mw_cel]] $DESIGN_NAME" > ./output/$STAGE/cell_map
set_write_stream_options \
    -map_layer $gds_out \
    -rename_cell ./output/$STAGE/cell_map \
    -child_depth 0 \
    -output_filling fill \
    -output_outdated_fill \
    -output_pin text \
    -keep_data_type
write_stream -cells $STAGE -format gds ./output/$STAGE/$DESIGN_NAME.gds

}
read_drc_error_file -drc_type calibre -error_cell drc ./pv/drc/Nanochap_BAF4.drc.results    
exec touch ./output/$STAGE/done_$STAGE

echo "\n####  END POINT:  $STAGE"
####################exit#################################
#########################################################

