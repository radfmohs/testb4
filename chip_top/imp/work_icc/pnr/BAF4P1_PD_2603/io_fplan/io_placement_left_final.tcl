set oldSnapState [set_object_snap_type -enabled false]

#set port "VSS_DIG VDD_DIG VSS_DIG_AO DVDD_1P5_ANA VSSIO VDDIO VDD_DIG_AO VDD_DIG_SW"
#foreach_in_collection i $a {
#    set name [get_object_name [get_nets -all -of [get_pins -all -of $i ]]]  
#    set box [get_att $i bbox]
#    puts "create_terminal -port $name -layer M5   -name $name -bbox {$box}"
#}

###################################################################

# Created by write_floorplan on Fri Jul  5 15:01:57 2024

###################################################################
undo_config -disable
set oldSnapState [set_object_snap_type -enabled false]

#*************
#    IOs    
# obj#: 14 
# objects are in clockwise ordering 
#*************


set obj [get_cells {"u_iopad_gpio_15_"} -all]
set_attribute -quiet $obj orientation FW
set_attribute -quiet $obj origin {0.000 2191.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_16_"} -all]
set_attribute -quiet $obj orientation FW
set_attribute -quiet $obj origin {0.000 2091.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_17_"} -all]
set_attribute -quiet $obj orientation FW
set_attribute -quiet $obj origin {0.000 1991.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_18_"} -all]
set_attribute -quiet $obj orientation FW
set_attribute -quiet $obj origin {0.000 1891.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_9_"} -all]
set_attribute -quiet $obj orientation FW
set_attribute -quiet $obj origin {0.000 1791.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_10_"} -all]
set_attribute -quiet $obj orientation FW
set_attribute -quiet $obj origin {0.000 1691.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plvpp"} -all]
set_attribute -quiet $obj orientation FW
set_attribute -quiet $obj origin {0.000 1591.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plvddi0"} -all]
set_attribute -quiet $obj orientation FW
set_attribute -quiet $obj origin {0.000 1391.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plvddi1"} -all]
set_attribute -quiet $obj orientation FW
set_attribute -quiet $obj origin {0.000 1191.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plvss"} -all]
set_attribute -quiet $obj orientation FW
set_attribute -quiet $obj origin {0.000 1091.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plar"} -all]
set_attribute -quiet $obj orientation FW
set_attribute -quiet $obj origin {0.000 991.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plvdd"} -all]
set_attribute -quiet $obj orientation FW
set_attribute -quiet $obj origin {0.000 891.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plvddhi"} -all]
set_attribute -quiet $obj orientation FW
set_attribute -quiet $obj origin {0.000 791.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plvssh_0"} -all]
set_attribute -quiet $obj orientation FW
set_attribute -quiet $obj origin {0.000 691.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

#********************
#    Terminals     
# obj#: 16 
# objects are in clockwise ordering 
#********************


set obj [get_terminal {"flash_ref"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {flash_ref}
set_attribute -quiet $obj bbox {{10.500 995.500} {110.500 1061.500}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set obj [get_terminal {"VPP"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {VPP}
set_attribute -quiet $obj bbox {{10.500 1595.415} {110.500 1661.415}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set obj [get_terminal {"IOBUF_PAD[10]"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {IOBUF_PAD[10]}
set_attribute -quiet $obj bbox {{10.500 1695.535} {110.500 1761.535}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set obj [get_terminal {"IOBUF_PAD[9]"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {IOBUF_PAD[9]}
set_attribute -quiet $obj bbox {{10.500 1795.655} {110.500 1861.655}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set obj [get_terminal {"IOBUF_PAD[18]"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {IOBUF_PAD[18]}
set_attribute -quiet $obj bbox {{10.500 1895.775} {110.500 1961.775}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set obj [get_terminal {"IOBUF_PAD[17]"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {IOBUF_PAD[17]}
set_attribute -quiet $obj bbox {{10.500 1995.895} {110.500 2061.895}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set obj [get_terminal {"IOBUF_PAD[16]"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {IOBUF_PAD[16]}
set_attribute -quiet $obj bbox {{10.500 2095.195} {110.500 2161.195}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set obj [get_terminal {"IOBUF_PAD[15]"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {IOBUF_PAD[15]}
set_attribute -quiet $obj bbox {{10.500 2195.315} {110.500 2261.315}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set obj [get_terminal {"VSSIO"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {VSSIO}
set_attribute -quiet $obj bbox {{30.500 695.500} {130.500 761.500}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set obj [get_terminal {"DVDD_1P5_ANA"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {DVDD_1P5_ANA}
set_attribute -quiet $obj bbox {{30.500 795.500} {130.500 861.500}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set obj [get_terminal {"VDD_DIG_AO"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {VDD_DIG_AO}
set_attribute -quiet $obj bbox {{30.500 895.500} {130.500 961.500}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set obj [get_terminal {"VSS_DIG_AO"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {VSS_DIG_AO}
set_attribute -quiet $obj bbox {{30.500 1095.500} {130.500 1161.500}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set obj [get_terminal {"VSS_DIG_SW"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {VSS_DIG_SW}
set_attribute -quiet $obj bbox {{30.500 1195.500} {130.500 1261.500}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set obj [get_terminal {"VDD_DIG_AFSW"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {VDD_DIG_AFSW}
set_attribute -quiet $obj bbox {{30.500 1295.500} {130.500 1361.500}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set obj [get_terminal {"VDD_DIG_SW"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {VDD_DIG_SW}
set_attribute -quiet $obj bbox {{30.500 1395.500} {130.500 1461.500}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set obj [get_terminal {"VSS_DIG_SW 1"}]
set_attribute -quiet $obj layer  M5
set_attribute -quiet $obj owner_port  {VSS_DIG_SW}
set_attribute -quiet $obj bbox {{30.500 1495.500} {130.500 1561.500}}
set_attribute -quiet $obj status Placed
set_attribute -quiet $obj direction inout
set_attribute -quiet $obj eeq_class 0

set_object_snap_type -enabled $oldSnapState
undo_config -enable
