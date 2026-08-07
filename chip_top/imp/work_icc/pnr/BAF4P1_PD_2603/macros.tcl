###################################################################

# Created by write_floorplan on Thu May 16 09:34:16 2024

###################################################################
undo_config -disable
set oldSnapState [set_object_snap_type -enabled false]

#**************
# Hard Macro 
# obj#: 1 
# objects are in alphabetical ordering 
#**************


set obj [get_cells {"u_top_dig/flash_ctrl_top_inst/u_32k"} -all]
set_attribute -quiet $obj orientation N
#set_attribute -quiet $obj origin {381.000 1882.390}
set_attribute -quiet $obj origin {392.000 1830.020}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed false
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set_object_snap_type -enabled $oldSnapState
undo_config -enable
