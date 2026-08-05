###################################################################

# Created by write_floorplan on Tue Jul  9 08:18:03 2024

###################################################################
undo_config -disable
set oldSnapState [set_object_snap_type -enabled false]

#**************
#  std cell  
# obj#: 42 
# objects are in alphabetical ordering 
#**************


set obj [get_cells {"IO_PREBUF_12"} -all]
set_attribute -quiet $obj orientation FS
set_attribute -quiet $obj origin {1157.620 2220.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_13"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1160.080 2226.260}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_14"} -all]
set_attribute -quiet $obj orientation FS
set_attribute -quiet $obj origin {1139.170 2214.780}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_16"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1156.800 2203.300}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_17"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1151.880 2197.560}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_18"} -all]
set_attribute -quiet $obj orientation FS
set_attribute -quiet $obj origin {1139.170 2209.040}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_19"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1139.170 2220.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_20"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1195.340 2203.300}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_21"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1180.170 2226.260}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_22"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1194.520 2214.780}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_23"} -all]
set_attribute -quiet $obj orientation S
set_attribute -quiet $obj origin {1203.540 2197.560}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_24"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1181.400 2203.300}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_25"} -all]
set_attribute -quiet $obj orientation FS
set_attribute -quiet $obj origin {1192.060 2197.560}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_26"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1184.270 2197.560}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_27"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1169.100 2197.560}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_28"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1168.690 2214.780}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_30"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1152.290 2209.040}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_32"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1177.300 2214.780}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_33"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1181.400 2220.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_34"} -all]
set_attribute -quiet $obj orientation S
set_attribute -quiet $obj origin {1143.270 2197.560}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_35"} -all]
set_attribute -quiet $obj orientation FS
set_attribute -quiet $obj origin {1139.170 2203.300}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_36"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1164.590 2226.260}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_37"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1175.660 2209.040}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_38"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1169.510 2220.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_39"} -all]
set_attribute -quiet $obj orientation FS
set_attribute -quiet $obj origin {1158.030 2226.260}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_40"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1157.210 2209.040}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_41"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1151.880 2203.300}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_42"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1199.440 2214.780}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_43"} -all]
set_attribute -quiet $obj orientation FS
set_attribute -quiet $obj origin {1183.860 2226.260}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_44"} -all]
set_attribute -quiet $obj orientation FS
set_attribute -quiet $obj origin {1199.440 2203.300}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_45"} -all]
set_attribute -quiet $obj orientation S
set_attribute -quiet $obj origin {1203.540 2209.040}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_CLK_1"} -all]
set_attribute -quiet $obj orientation S
set_attribute -quiet $obj origin {1185.910 2220.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_CLK_10"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1199.850 2226.260}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_CLK_11"} -all]
set_attribute -quiet $obj orientation S
set_attribute -quiet $obj origin {1186.320 2214.780}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_CLK_2"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1150.650 2226.260}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_CLK_3"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1151.880 2214.780}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_CLK_4"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1147.780 2220.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_CLK_5"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1142.860 2226.260}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_CLK_6"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1191.650 2209.040}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_CLK_7"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1194.930 2220.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_CLK_8"} -all]
set_attribute -quiet $obj orientation N
set_attribute -quiet $obj origin {1200.260 2220.520}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set obj [get_cells {"IO_PREBUF_CLK_9"} -all]
set_attribute -quiet $obj orientation FN
set_attribute -quiet $obj origin {1196.160 2226.260}
set_attribute -quiet $obj is_placed true
set_attribute -quiet $obj is_fixed true
set_attribute -quiet $obj is_soft_fixed false
set_attribute -quiet $obj eco_status eco_reset

set_object_snap_type -enabled $oldSnapState
undo_config -enable
