############################################
##            Initial settings	           #
############################################

set STAGE   "09_ECO1"
echo "\n####  BEGIN POINT:  $STAGE \n"
set PREV    "07_chip_finish"

################################################################################
# General ICC settings
source -e -v ./PROJECT.tcl

############################
if {[file exists $rpt_path/RPT/${STAGE}] == 0}    {sh mkdir $rpt_path/RPT/${STAGE};    sh ln -snf $rpt_path/RPT/${STAGE} RPT/}
if {[file exists $rpt_path/output/${STAGE}] == 0} {sh mkdir $rpt_path/output/${STAGE}; sh ln -snf $rpt_path/output/${STAGE} output/}

############################
set ECOCARD     "1"
set ECOPLACE    "1"
set ECOROUTE    "1"
set SWAPVIA     "0"
set STDFILL     "1"
set EXPORT      "1"
set ECOPATH 	"./STA_09_ECO1/timing_eco"
set ECO_FILE    "${ECOPATH}/func_min.tcl ${ECOPATH}/scan_min.tcl"

################################################################################
# Restore DB
close_mw_cel  -all_views
close_mw_lib $design_mw_lib
open_mw_lib $design_mw_lib
copy_mw_cel -from $PREV -to $STAGE
open_mw_cel  $STAGE
link

################################################################################
## DontTouch and DontUse settings
set_dont_use    [get_lib_cells  $dont_use]
set_size_only   [get_flat_cell $size_only]
set_dont_touch [get_flat_cells *DNT*]
set_dont_use [get_lib_cells {*/CLK* */*EDFF* */*TBUF* */*SDFFTR* */*XL* */*TIE*}]

suppress_message OPT-1022
suppress_message LIBSETUP-751
suppress_message LIBSETUP-754

set_keepout_margin -all_macros -outer {5 5 5 5} 
set_keepout_margin -all_macros -type soft -outer {8 8 8 8}

###############################################################################
## Load ECO file
stop_gui
if {$ECOCARD} {
foreach CARD $ECO_FILE {source -continue_on_error -echo -verbose $CARD > ${CARD}.log}
}

remove_placement_blockage par1

#If fixing DRC/ANT in parallel, load DRC/ANT errors and fix them manually
read_drc_error_file -drc_type calibre -error_cell drc /local/scratch/gayathri/baf4p1/drc/Nanochap_BAF4P1.drc.results 
read_drc_error_file -drc_type calibre -error_cell ant /local/scratch/gayathri/baf4p1/drc/Nanochap_BAF4P1.ant.results

###############################################################################
## Eco Place any newly added/modified cells

if {$ECOPLACE} {
remove_stdcell_filler -stdcell 
place_eco_cells -eco_changed_cells -legalize_only -displacement_threshold 5
legalize_placement -incremental
derive_pg_connection
}

###############################################################################
## Manual addition of buffers for tran/cap/ant fixes
## Add buffers using below cmnd to fix tran/cap fixes
insert_buffer [get_pin ANA_BUF_24/A] BUFX10M -new_cell_names tranfix_eco_cell1 -new_net_names tranfix_eco_net1
## Add diodes to fix antenna if removing and rerouting didnt fix the violation
insert_zrt_diodes {{A u_top_dig/spi_top_u/spi_reg_u/icc_ctsCLKBUFX4M_G8B1I65 ANTENNAM 1 M5 20}}
insert_zrt_diodes {{A u_top_dig/u_imeas/u_imeas_cic_2/U39 ANTENNAM 1 M5 20}}
insert_zrt_diodes {{B0 u_top_dig/u_imeas/u_filter/U1620 ANTENNAM 1 M5 20}}
insert_zrt_diodes {{A1 u_top_dig/u_imeas/u_filter/U1834 ANTENNAM 1 M5 20}}
insert_zrt_diodes {{A1 u_top_dig/u_imeas/u_filter/U1874 ANTENNAM 1 M5 20}}
insert_zrt_diodes {{B0 u_top_dig/u_imeas/u_filter/U1611 ANTENNAM 1 M5 20}}
insert_zrt_diodes {{D u_top_dig/spi_top_u/spi_reg_u/u_debug_flash_0_/async_in_d1_reg ANTENNAM 1 M5 20}}
insert_zrt_diodes {{SI u_top_dig/fifo_top/fifo_mem_inst/mem_reg_49__0_ ANTENNAM 1 M5 20}}
insert_zrt_diodes {{A icc_place1 ANTENNAM 1 M5 20}}
insert_zrt_diodes {{A icc_place78 ANTENNAM 1 M5 20}}
insert_zrt_diodes {{A u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl/icc_ctsCLKBUFX4M_G11B1I3 ANTENNAM 1 M5 20}}
insert_zrt_diodes {{B1 top_dig_always_on_inst/shadow_regs_always_on_inst/U27 ANTENNAM 1 M5 20}}
insert_zrt_diodes {{A u_top_dig/u_imeas/u_imeas_cic_2/U308 ANTENNAM 1 M5 20}}
insert_zrt_diodes {{A icc_place68 ANTENNAM 1 M5 20}}

##############################################################################
## Eco route settings  
set_route_zrt_detail_options -eco_route_use_soft_spacing_for_timing_optimization false
set_route_zrt_common_options -concurrent_redundant_via_mode off
#set_route_zrt_common_options -post_detail_route_redundant_via_insertion high
set_route_zrt_global_options -timing_driven false -crosstalk_driven false
set_route_zrt_track_options -timing_driven false -crosstalk_driven false
set_route_zrt_detail_options -timing_driven false
# set_route_zrt_common_options -reshield_modified_nets reshield

########################
##      ECO route     ##
########################
if {$ECOROUTE} {
route_zrt_eco -reroute modified_nets_first_then_others -open_net_driven true
}

##############################################################################
## Optional LVS short/open check and fix
verify_lvs -max_error 2000  -use_notch_gap_fill_cell -check_single_pin_net_for_floating_port -check_single_pin_net_for_floating_net -check_floating_port_on_null_net -check_open_locator -check_short_locator
#Reroute after fixing lvs short/open if any
route_zrt_eco -reroute modified_nets_first_then_others -open_net_driven true

############################################################################
## Insert Filler cells

if {$STDFILL} {
remove_stdcell_filler -stdcell 
if {$CAPCELL  != ""} {insert_stdcell_filler -cell_with_metal    $CAPCELL  -cell_with_metal_prefix    CAPCELL  -connect_to_power VDD -connect_to_ground VSS -dont_respect_soft_placement_blockage}
if {$FILLCELL != ""} {insert_stdcell_filler -cell_without_metal $FILLCELL -cell_without_metal_prefix FILLCELL -connect_to_power VDD -connect_to_ground VSS -dont_respect_soft_placement_blockage}
}

#############################################################################
## Connect PG
source ./connect_pg.tcl
#derive_pg_connection -all 

#############################################################################
## Save DB
change_names -rules verilog -hierarchy
save_mw_cel -as ${STAGE}

#######################################
####Outputs Script
#######################################
#if {$EXPORT} {
extract_rc -coupling_cap
write_parasitics  -format SPEF -compress  -output   ./output/$STAGE/$STAGE.spef
## No pg netlist for STA runs
write_verilog -diode_ports -no_physical_only_cells  ./output/$STAGE/$DESIGN_NAME.output.v -macro_definition
exec touch ./output/$STAGE/done_$STAGE
write_def -compressed  -output  ./output/$STAGE/$STAGE.def.gz -version 5.8
## For Formality check,the option -diode_ports is removed
write_verilog -no_physical_only_cells ./output/$STAGE/$DESIGN_NAME.output.dc.v -macro_definition
## For lvs check
write_verilog -diode_ports -pg ./output/$STAGE/$DESIGN_NAME.output.pg.lvs.v  -no_tap_cells -no_pad_filler_cells -force_no_output_references [concat $TAPCELL $FILLCELL]
##PG netlist for SPO:
write_verilog -diode_ports -no_physical_only_cells ./output/$STAGE/$DESIGN_NAME.output.pg.v -macro_definition -pg

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


## CELL LIST for LVS hcell
report_reference -nosplit -hierarchy  >  ./output/$STAGE/$DESIGN_NAME.reference

##SDC (Optional)
set_app_var write_sdc_output_lumped_net_capacitance false
set_app_var write_sdc_output_net_resistance false

set cur_scenario [current_scenario]
foreach scenario [all_active_scenarios] {
  current_scenario $scenario
  write_sdc ./output/$STAGE/$DESIGN_NAME.$scenario.output.sdc
};
current_scenario $cur_scenario

echo "\n####  END POINT:  $STAGE"
###

