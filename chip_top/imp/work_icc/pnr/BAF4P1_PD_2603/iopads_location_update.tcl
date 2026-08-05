###################################################################

# Created by write_floorplan on Mon Aug  3 13:30:46 2026

###################################################################
undo_config -disable
set oldSnapState [set_object_snap_type -enabled false]

#*************
#    IOs    
# obj#: 32 
# objects are in clockwise ordering 
#*************


set obj [get_cells {"u_iopad_plvssh_0"} -all]
set_attribute -quiet $obj orientation W
set_attribute -quiet $obj origin {162.000 691.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plvddhi"} -all]
set_attribute -quiet $obj orientation W
set_attribute -quiet $obj origin {162.000 791.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plvdd"} -all]
set_attribute -quiet $obj orientation W
set_attribute -quiet $obj origin {162.000 891.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plar"} -all]
set_attribute -quiet $obj orientation W
set_attribute -quiet $obj origin {162.000 991.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plvss"} -all]
set_attribute -quiet $obj orientation W
set_attribute -quiet $obj origin {162.000 1091.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plvddi1"} -all]
set_attribute -quiet $obj orientation W
set_attribute -quiet $obj origin {162.000 1191.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plvddi0"} -all]
set_attribute -quiet $obj orientation W
set_attribute -quiet $obj origin {162.000 1391.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plvpp"} -all]
set_attribute -quiet $obj orientation W
set_attribute -quiet $obj origin {162.000 1591.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_10_"} -all]
set_attribute -quiet $obj orientation W
set_attribute -quiet $obj origin {162.000 1691.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_9_"} -all]
set_attribute -quiet $obj orientation W
set_attribute -quiet $obj origin {162.000 1791.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_18_"} -all]
set_attribute -quiet $obj orientation W
set_attribute -quiet $obj origin {162.000 1891.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_17_"} -all]
set_attribute -quiet $obj orientation W
set_attribute -quiet $obj origin {162.000 1991.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_16_"} -all]
set_attribute -quiet $obj orientation W
set_attribute -quiet $obj origin {162.000 2091.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_15_"} -all]
set_attribute -quiet $obj orientation W
set_attribute -quiet $obj origin {162.000 2191.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_14_"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {184.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plvddh"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {284.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_13_"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {384.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_12_"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {484.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_11_"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {584.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_4_"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {684.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_3_"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {784.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_1_"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {884.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_2_"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {984.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_0_"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1084.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_testmode1"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1184.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_exresetn"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1284.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_testmode0"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1384.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_8_"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1484.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_7_"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1584.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_6_"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1684.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_gpio_5_"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1784.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"u_iopad_plvssh_1"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1884.000 2288.000}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set_object_snap_type -enabled $oldSnapState
undo_config -enable
