set STAGE "00_init"
echo "\n####  BEGIN POINT:  $STAGE"

################################################################################
# General useful settings
source -e -v ./PROJECT.tcl
if {[file exists $rpt_path/] == 0} 			{sh mkdir $rpt_path}
if {[file exists $rpt_path/output] == 0} 		{sh mkdir $rpt_path/output; sh mkdir output}
if {[file exists $rpt_path/RPT] == 0} 			{sh mkdir $rpt_path/RPT; sh mkdir RPT}
if {[file exists $rpt_path/RPT/${STAGE}] == 0} 		{sh mkdir $rpt_path/RPT/${STAGE}; sh ln -snf $rpt_path/RPT/${STAGE} RPT/}
if {[file exists $rpt_path/output/${STAGE}] == 0} 	{sh mkdir $rpt_path/output/${STAGE}; sh ln -snf $rpt_path/output/${STAGE} output/}

#close_mw_lib Nanochap_BMS3
#set design_mw_lib Nanochap_BAF4_1
sh rm -rf Nanochap_BAF4P1
################################################################################
##### Init Design
create_mw_lib $design_mw_lib -open -technology $tech_file -mw_reference_library $mw_ref_libs -bus_naming_style {[%d]}
read_verilog -top $DESIGN_NAME  $netlist
uniquify_fp_mw_cel 
current_design  $DESIGN_NAME

################################################################################
## TLUPLUS file inputs
set_tlu_plus_files -max_tluplus $tlup_max -min_tluplus $tlup_min -tech2itf_map $tlup_map

################################################################################
##Set PAD physical constraints and create floorplan
if {[get_cells -all -q IOFILLER*] != ""} {remove_cell IOFILLER*}
gui_set_pref_value -category {layout} -key {editingEnableSnapping} -value {false}

set io_ref [lsort -u [get_att [get_cells -all -filter "mask_layout_type==io_pad||mask_layout_type==pad_filler"] ref_name]]
foreach i $io_ref {set_pad_physical_constraints  -pad_name  $i  -lib_cell  -lib_cell_orientation  {FN  FS  FN  FS}}

#g remove_pin_pad_physical_constraints *
source -e -v ./io_fplan/io_placement_new.tdf
set_die_area -coordinate {0 0 2500 2450}
create_floorplan -control_type boundary -start_first_row -keep_macro_place -left_io2core 60 -bottom_io2core 837.18 -right_io2core 333.78 -top_io2core 56

#g 
#create_floorplan -control_type width_and_height -start_first_row -keep_macro_place \
#                        -core_width     [expr 2500 - 162 - 333.78 - 60 ] \
#                        -core_height    [expr 2300 - 162 - 837.18 - 56 ] \
#                        -left_io2core   60 \
#                        -bottom_io2core 837.18 \
#                        -right_io2core  333.78 \
#                        -top_io2core    56
source -e -v ./FP_final2.tcl 

################################################################################
##Load UPF
reset_upf
load_upf ./Nanochap_BAF4P1.upf
#set_attribute [get_lib_cells sc7_l013_base_rvt_ss_TYP_max_1p35v_125c/AND2X4M] ok_for_isolation true
#set_attribute [get_lib_pins sc7_l013_base_rvt_ss_TYP_max_1p35v_125c/AND2X4M/A] isolation_cell_enable_pin true
#set_voltage 1.35 -object_list {VDD_DIG VDD_DIG_AO PD_SW.primary.power PD_AO.primary.power}
#set_voltage 0.0 -object_list {VSS_DIG}
report_power_domain -hierarchy

################################################################################
##Create terminals and fix all pads
## RCMCU_PLCORNER
if {[get_cells -q -all cornerll] == ""} {create_cell {cornerul} RCMCU_PLCORNER}
set obj [get_cells {"cornerul"} -all]
set_attribute -quiet $obj origin {0.000 2450.000}
set_attribute -quiet $obj orientation E
set_attribute -quiet $obj is_fixed true

set oldSnapState [set_object_snap_type -enabled false]
remove_terminal {VSSIO* VDD_DIG_AO DVDD_1P5_ANA VSS_DIG_AO VDDIO VDD_DIG_SW* VDD_DIG_AFSW }
create_terminal  -port  VSSIO         -layer  M5  -name  VSSIO         -bbox  {{30.500    695.500}   {130.500   761.500}}
create_terminal  -port  DVDD_1P5_ANA  -layer  M5  -name  DVDD_1P5_ANA  -bbox  {{30.500    795.500}   {130.500   861.500}}
create_terminal  -port  VDD_DIG_AO    -layer  M5  -name  VDD_DIG_AO    -bbox  {{30.500    895.500}   {130.500   961.500}}
create_terminal  -port  VSS_DIG_AO    -layer  M5  -name  VSS_DIG_AO    -bbox  {{30.500    1095.500}  {130.500   1161.500}}
create_terminal  -port  VSS_DIG_SW    -layer  M5  -name  VSS_DIG_SW    -bbox  {{30.500    1195.500}  {130.500   1261.500}}
create_terminal  -port  VDD_DIG_AFSW  -layer  M5  -name  VDD_DIG_AFSW  -bbox  {{30.500    1295.500}  {130.500   1361.500}}
create_terminal  -port  VDD_DIG_SW    -layer  M5  -name  VDD_DIG_SW    -bbox  {{30.500    1395.500}  {130.500   1461.500}}
create_terminal  -port  VSS_DIG_SW    -layer  M5  -name  VSS_DIG_SW    -bbox  {{30.500    1495.500}  {130.500   1561.500}}
create_terminal  -port  VDDIO         -layer  M5  -name  VDDIO         -bbox  {{288.500   2339.500}  {354.500   2439.500}}
create_terminal  -port  VSSIO         -layer  M5  -name  VSSIO         -bbox  {{1888.500  2339.500}  {1954.500  2439.500}}

source -e -v ./io_fplan/io_placement_left_final.tcl

################################################################################
##Place hard macros
source -e -v ./macros.tcl
## Place FLASH                        
set_attribute -quiet [get_cells {"u_top_ana"}] origin {0 0}
set_attribute -quiet [get_cells {"u_top_ana"}] is_fixed true
set obj [get_cells {"u_top_dig/flash_ctrl_top_inst/u_32k"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true

################################################################################
## Insert PAD fillers and align
if {[get_cells -all -q IOFILLER*] != ""} {remove_cell IOFILLER*}
insert_pad_filler -prefix "IOFILLER" -cell "RCMCU_PLFLR5 RCMCU_PLFLR1"

set pad [get_cells -all -filter "mask_layout_type==pad_filler&&origin=~*2288.000"]
flip_objects -y 0 -anchor center -flip_transform $pad -ignore_fixed
set pad [get_cells -all -filter "mask_layout_type==pad_filler&&orientation==W&&origin=~162*"]
flip_objects -x 0 -anchor center -flip_transform $pad -ignore_fixed

gui_set_pref_value -category {layout} -key {editingEnableSnapping} -value {false}

change_selection [get_cells -all -filter "(mask_layout_type==pad_filler||mask_layout_type==io_pad)&&origin=~0*"]
move_objects -delta "20 0" -ignore_fixed [get_selection]
change_selection [get_cells -all -filter "(mask_layout_type==pad_filler||mask_layout_type==io_pad)&&origin=~*2450.000"]
move_objects -delta "0 [expr 0-20]" -ignore_fixed [get_selection]

#because there is a small gap
cs [get_cells -all {IOFILLERpfiller160 IOFILLERpfiller161}]
move_objects -delta {0.000 -20.000} -keep_placement -ignore_fixed [get_selection]
cs [get_cells -all IOFILLERpfiller156]
move_objects -delta {0.000 20.000} -ignore_fixed [get_selection]
cs
remove_objects [get_cells -all -touching [get_att [get_cells -all cornerul] bbox] -filter ref_name=~RCMCU_PLFLR*]

####
move_objects -delta "0 [expr 0 - 20]" -ignore_fixed [get_terminals -filter "bbox_ury>2438"]
move_objects -delta "20 0" -ignore_fixed [get_terminals -filter "bbox_llx<20"]


#save_mw_cel -as 01_init_ioplacement
## Flip PG IO
#G set obj [get_cells {"u_iopad_plvddi1"} -all]
#G set_attribute -quiet $obj orientation E
#G set_attribute -quiet $obj origin {20.000 1366.000}
#G set_attribute -quiet $obj is_placed true
#G set_attribute -quiet $obj is_fixed true

################################################################################
## Create PD
create_voltage_area -power_domain PD_SW -polygons {{222.000 842.610} {467.380 842.610} {467.380 854.365} {535.465 854.365} {535.465 842.610} {686.420 842.610} {686.420 857.235} {733.955 857.235} {733.955 842.610} {774.730 842.610} {774.730 877.800} {755.720 877.800} {755.720 943.690} {774.730 943.690} {774.730 1103.255} {748.335 1103.255} {748.335 1203.230} {774.730 1203.230} {774.730 1242.590} {884.550 1242.590} {884.550 1332.610} {867.950 1332.610} {867.950 1382.020} {884.550 1382.020} {884.550 1471.420} {925.035 1471.420} {925.035 1490.575} {980.645 1490.575} {980.645 1471.420} {1036.000 1471.420} {1036.000 1653.240} {1069.425 1653.240} {1069.425 1675.385} {1167.195 1675.385} {1167.195 1653.240} {1212.635 1653.240} {1212.635 2193.170} {1134.315 2193.170} {1134.315 2232.000} {222.000 2232.000} {222.000 1820.020} {361.715 1820.020} {361.715 1649.955} {222.000 1649.955} {222.000 1282.055} {238.880 1282.055} {238.880 1238.635} {222.000 1238.635} {222.000 842.610}} -cycle_color
#remove_net POC
#create_net -power POC

################################################################################
## Create route guide & macro KM
create_route_guide -name ANA_PIN_1 -no_signal_layers {M2 M3} -coordinate {{780.625 868.040} {783.000 1207.010}} -no_snap
create_route_guide -name ANA_PIN_2 -no_signal_layers {M2 M3} -coordinate {{1067.590 1644.985} {1167.720 1646.985}} -no_snap
create_route_guide -name ANA_PIN_3 -no_signal_layers {M2 M3} -coordinate {{1217.655 1670.305} {1219.170 1718.130}} -no_snap
create_route_guide -name ANA_PIN_4 -no_signal_layers {M2 M3 M4} -coordinate {{208.255 835.925} {755.405 839.405}} -no_snap
create_route_guide -name ANA_PIN_5 -no_signal_layers {M2 M3} -coordinate {{922.355 1463.180} {986.145 1465.180}} -no_snap
create_route_guide -name ANA_PIN_6 -no_signal_layers {M2 M3} -coordinate {{891.370 1328.325} {892.885 1386.475}} -no_snap

set_keepout_margin -all_macros -type hard -outer {10 10 10 10} 
set_keepout_margin -all_macros -type soft -outer {30 30 30 30}

################################################################################
## Connect PG
source -e -v ./connect_pg.tcl
 derive_pg_connection -all 
################################################################################
##Insert Blockages:
source -e -v ./hardblockages.tcl
################################################################################
##PG mesh:
source -e -v ./script/MAPS/pg_0208.tcl
#check_route -drc
verify_pg_nets 
#return
remove_routing_blockage *

################################################################################
##add ENDCAPs
add_end_cap -lib_cell FILLCAP8M -at_va_boundary -ignore_soft_blockage -respect_blockage

################################################################################
## INSERT TAP
remove_stdcell_filler  -tap
add_tap_cell_array -master_cell_name FILLTIEM  -distance 35 -pattern stagger_every_other_row -no_tap_cell_under_layers M1 -ignore_soft_blockage true -right_boundary_extra_tap must_insert  -left_boundary_extra_tap must_insert

################################################################################
##logical connections
source -e -v ./connect_pg.tcl
 derive_pg_connection -all 

source -e -v ./rehardblk.tcl
save_mw_cel -as ${STAGE}
report_placement_utilization
#exit

