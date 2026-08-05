###################################################################

# Created by write_floorplan on Thu Aug  1 11:17:28 2024

###################################################################
undo_config -disable
set oldSnapState [set_object_snap_type -enabled false]

#**************
#  std cell  
# obj#: 8 
# objects are in alphabetical ordering 
#**************


set obj [get_cells {"ANA_BUF_spare_1"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {759.920 1193.060}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed false
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"ANA_BUF_spare_2"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {764.020 1193.060}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed false
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"ANA_BUF_spare_3"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {761.970 1198.800}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed false
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"ANA_BUF_spare_4"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {755.820 1187.320}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed false
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"ANA_BUF_spare_5"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {757.870 1198.800}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed false
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"ANA_BUF_spare_6"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {755.410 1193.060}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed false
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"ANA_BUF_spare_7"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {766.070 1198.800}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed false
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"ANA_BUF_spare_8"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {755.820 1181.580}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed false
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set_object_snap_type -enabled $oldSnapState
undo_config -enable
