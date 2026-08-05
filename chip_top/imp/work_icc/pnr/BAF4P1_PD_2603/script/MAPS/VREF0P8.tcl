create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 516.525 -origin {194.655 1027.95}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 26.24 -origin {194.735 1544.345}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 805.595 -origin {220.975 1854.305}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 309.96 -origin {220.975 1544.345}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M2 -datatype 0 -path_type 2 -width 0.28 -route_type signal_route -length 11.48 -origin {1026.48 1854.305}
create_via -no_snap -type via -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {194.655 1544.345} -orient N
create_via -no_snap -type via -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {220.975 1544.345} -orient N
create_via -no_snap -type via -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {220.975 1854.305} -orient N
create_via -no_snap -type via -net VREF0P8 -master MV2_0_VH_F0 -route_type signal_route -at {1026.48 1854.305} -orient N
create_via -no_snap -type via -net VREF0P8 -master MV3_0_HV_F0 -route_type signal_route -at {1026.48 1854.305} -orient N
create_via -no_snap -type via -net VREF0P8 -master MV4_0_VH_F0 -route_type signal_route -at {1026.48 1854.305} -orient N
