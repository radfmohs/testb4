create_route_guide -no_snap -coordinate {{20 2264} {187 2431}} -no_signal_layer {M1 M2 M3 M4 M5} -name CORNER 
create_route_guide -no_snap -coordinate {{780.625 868.04} {783 1458.965}} -no_signal_layer {M2 M3} -name ANA_PIN_1 
create_route_guide -no_snap -coordinate {{793.52 1644.985} {1167.72 1646.985}} -no_signal_layer {M2 M3} -name ANA_PIN_2 
create_route_guide -no_snap -coordinate {{1217.655 1670.305} {1219.17 1718.13}} -no_signal_layer {M2 M3} -name ANA_PIN_3 
create_net_shape -no_snap -type wire -net VPP -layer M3 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 5.74 -origin {182.435 1628.685}
create_net_shape -no_snap -type wire -net VPP -layer M3 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 5.74 -origin {182.435 1641.395}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 13.27 -origin {762.785 1431.365}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M5 -datatype 0 -path_type 2 -width 5 -route_type user_enter -length 81.165 -origin {191.455 876.72}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 332.875 -origin {181.595 1128.485}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 32.54 -origin {180.82 1550.375}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 31.98 -origin {180.82 1508.965}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 29.625 -origin {180.82 1234.675}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 29.625 -origin {180.82 1213.765}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 38.54 -origin {180.82 1448.285}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 38.54 -origin {180.82 1407.285}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 22.92 -origin {757.455 1434.235}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.12 -origin {779.17 1432.185}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 4.495 -origin {775.145 1430.135}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.5 -origin {778.69 1430.135}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M5 -datatype 0 -path_type 2 -width 2 -route_type user_enter -length 846.135 -origin {191.345 1816.49}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 21.815 -origin {758.53 1137.335}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.01 -origin {755.72 938.985}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.12 -origin {779.14 1137.335}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.01 -origin {755.72 933.245}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 15.7 -origin {763.86 1139.335}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 26.395 -origin {748.335 1190.725}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.5 -origin {778.66 1139.335}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 26.395 -origin {748.335 1184.985}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 19.19 -origin {761.3 909.42}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 352.71 -origin {854.85 1665.6}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.12 -origin {779.285 908.605}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 347.48 -origin {854.75 1659.86}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 13.075 -origin {766.63 906.605}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.5 -origin {778.805 906.605}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 73.82 -origin {1134.455 2214.19}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 73.82 -origin {1134.455 2208.45}
create_net_shape -no_snap -type wire -net POC -layer M3 -datatype 0 -path_type 2 -width 1 -route_type user_enter -length 53.795 -origin {149.6 688.145}
create_net_shape -no_snap -type wire -net POC -layer M3 -datatype 0 -path_type 2 -width 1 -route_type user_enter -length 334.62 -origin {203.345 867.265}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.01 -origin {755.72 894.705}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.01 -origin {755.72 888.965}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 32.145 -origin {742.585 1450.885}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 32.255 -origin {742.475 1445.145}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 32.255 -origin {742.475 1421.365}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 32.255 -origin {742.475 1415.625}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 88.405 -origin {766.445 1665.6}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 93.985 -origin {761.115 1659.86}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 70.475 -origin {467.38 845.475}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_std_cell_pin_conn -length 16.85 -origin {222.005 1266.17}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 70.325 -origin {467.38 851.215}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_std_cell_pin_conn -length 16.875 -origin {221.995 1260.43}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 233.93 -origin {537.515 851.215}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M3 -datatype 0 -path_type 2 -width 4.52 -route_type user_enter -length 7.88 -origin {183.62 1026.315}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 228.6 -origin {537.515 845.475}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 1751.2 -origin {206.85 2247.99}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 1744.715 -origin {213.335 2239.79}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 538.855 -origin {195.22 1809.15}
create_net_shape -no_snap -type wire -net DVDD_1P5_ANA -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 31.305 -origin {180.82 817.83}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 518.04 -origin {199.935 1801.73}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 58.575 -origin {181.45 930.865}
create_net_shape -no_snap -type wire -net VDD_DIG_AFSW -layer M3 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 83.695 -origin {181.31 1331.025}
create_net_shape -no_snap -type wire -net VPP -layer M3 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 5.74 -origin {182.435 1618.435}
create_net_shape -no_snap -type wire -net VPP -layer M5 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 717.645 -origin {187.98 1791.07}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M3 -datatype 0 -path_type 2 -width 4 -route_type user_enter -length 6.99 -origin {183.455 1031.13}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 6 -route_type pg_strap -length 139.715 -origin {222 1776.91}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 6 -route_type pg_strap -length 139.715 -origin {222 1699.58}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 6 -route_type pg_strap -length 139.715 -origin {222 1770.4}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 6 -route_type pg_strap -length 139.715 -origin {222 1693.07}
create_net_shape -no_snap -type wire -net VDDIO -layer M5 -datatype 0 -path_type 2 -width 5 -route_type pg_macro_io_pin_conn -length 23.08 -origin {283.585 1007.43}
create_net_shape -no_snap -type wire -net VDDIO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 105.12 -origin {221 2227.49}
create_net_shape -no_snap -type wire -net VDDIO -layer M5 -datatype 0 -path_type 2 -width 5 -route_type pg_macro_io_pin_conn -length 83.27 -origin {223.395 1721.37}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 26.395 -origin {748.335 1127.16}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 26.395 -origin {748.335 1121.42}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 2 -width 5 -route_type pg_macro_io_pin_conn -length 246.065 -origin {229.615 948.46}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M3 -datatype 0 -path_type 2 -width 5 -route_type signal_route -length 23.75 -origin {1191.81 1698.28}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M3 -datatype 0 -path_type 2 -width 1 -route_type signal_route -length 0.635 -origin {1037.48 1827.98}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AFSW -layer M5 -datatype 0 -path_type 2 -width 20 -route_type signal_route -length 15.36 -origin {255 846.035}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 15 -route_type pg_macro_io_pin_conn -length 25.655 -origin {454.475 1805.61}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 2 -width 20 -route_type signal_route -length 12.645 -origin {230 846.1}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 15 -route_type pg_macro_io_pin_conn -length 33.075 -origin {470.975 1798.23}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M3 -datatype 0 -path_type 2 -width 5 -route_type user_enter -length 6.045 -origin {272.5 838.54}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 403.18 -origin {202.935 1402.28}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 2.52 -route_type signal_route -length 1.475 -origin {1959.57 2367.6}
create_net_shape -no_snap -type wire -vertical -net POC -layer M4 -datatype 0 -path_type 2 -width 1 -route_type user_enter -length 179.12 -origin {203.345 688.145}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 529.83 -origin {1204.99 1663.185}
create_net_shape -no_snap -type wire -vertical -net POC -layer M3 -datatype 0 -path_type 2 -width 1 -route_type user_enter -length 30.7 -origin {537.965 836.565}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 535.945 -origin {1199.73 1657.36}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 2 -route_type user_enter -length 10.855 -origin {1037.48 1816.49}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M2 -datatype 0 -path_type 2 -width 0.28 -route_type signal_route -length 1.8 -origin {1037.48 1828.8}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 5 -route_type signal_route -length 3.305 -origin {511.965 838.555}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 701.535 -origin {236.27 1118.485}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 21.31 -origin {723.765 835.925}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 19.155 -origin {790.65 1653.24}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 21.31 -origin {721.765 835.925}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 19.08 -origin {785.32 1653.24}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 2 -route_type user_enter -length 786.41 -origin {191.455 1030.09}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 22.225 -origin {794.055 1646.865}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 22.155 -origin {796.055 1646.935}
create_net_shape -no_snap -type wire -vertical -net VSSIO -layer M3 -datatype 0 -path_type 2 -width 16.83 -route_type signal_route -length 0.94 -origin {40.235 682.925}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 4 -route_type signal_route -length 13.36 -origin {81.66 676.44}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 1 -route_type pg_macro_io_pin_conn -length 0.825 -origin {780.14 908.6}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 1 -route_type pg_macro_io_pin_conn -length 1.93 -origin {779.97 1432.185}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 1 -route_type pg_macro_io_pin_conn -length 1.025 -origin {775.645 1430.135}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 39.13 -origin {1204.99 2192.87}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 454.26 -origin {768.945 1213.84}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 448.53 -origin {763.615 1213.865}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 17.73 -origin {852.055 1646.85}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 17.785 -origin {854.055 1646.795}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 270.29 -origin {768.945 944.01}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 266.555 -origin {763.615 947.745}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 103.945 -origin {768.945 848.715}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 109.685 -origin {763.615 842.975}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 14.625 -origin {712.88 842.61}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 14.625 -origin {707.55 842.61}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 11.755 -origin {481.005 842.61}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 108.425 -origin {475.675 842.61}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 11.88 -origin {517.54 842.485}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 1408.75 -origin {209.8 842.74}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 1400.55 -origin {216.36 842.74}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 5 -route_type user_enter -length 33.365 -origin {272.53 843.355}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 5 -route_type user_enter -length 149.385 -origin {191.455 876.69}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 18.29 -origin {469.37 836.075}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 18.33 -origin {471.37 836.035}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 21.31 -origin {693.745 835.925}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 21.31 -origin {691.745 835.925}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 15 -route_type pg_macro_io_pin_conn -length 33.075 -origin {710.075 1798.23}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 15 -route_type pg_macro_io_pin_conn -length 25.655 -origin {726.575 1805.61}
create_net_shape -no_snap -type wire -vertical -net POC -layer M3 -datatype 0 -path_type 2 -width 0.9 -route_type user_enter -length 3.35 -origin {149.55 688.145}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 90.795 -origin {230 850.205}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AFSW -layer M4 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 492.415 -origin {255 848.61}
create_net_shape -no_snap -type wire -vertical -net VPP -layer M2 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 12.665 -origin {905.465 1817.73}
create_net_shape -no_snap -type wire -vertical -net VPP -layer M4 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 172.69 -origin {188.115 1618.43}
create_net_shape -no_snap -type wire -vertical -net VPP -layer M4 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 27.135 -origin {905.465 1790.95}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_macro_io_pin_conn -length 879.61 -origin {229.83 940.41}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 301.48 -origin {511.965 837.005}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 308.845 -origin {195.965 1503.96}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 27.925 -origin {1165.055 1646.805}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 27.955 -origin {1167.055 1646.785}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 170.06 -origin {294.52 1649.96}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 170.06 -origin {289.19 1649.96}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 19.155 -origin {850.645 1653.24}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 19.155 -origin {845.315 1653.24}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 30.865 -origin {1086.225 1653.24}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 30.865 -origin {1080.895 1653.24}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 170.06 -origin {355.865 1649.96}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 170.06 -origin {350.535 1649.96}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M3 -datatype 0 -path_type 2 -width 5 -route_type signal_route -length 6.065 -origin {283.9 838.485}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M3 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 6.56 -origin {323.62 2262.545}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 41.815 -origin {323.62 2225.235}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M4 -datatype 0 -path_type 2 -width 5 -route_type pg_macro_io_pin_conn -length 163.88 -origin {283.9 843.805}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 512.03 -origin {223.5 1717.96}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 719.145 -origin {306.665 1004.815}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 30.865 -origin {1154.135 1653.24}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 30.865 -origin {1148.805 1653.24}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 39.13 -origin {1199.73 2192.87}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 38.79 -origin {1154.135 2193.21}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 38.79 -origin {1148.805 2193.21}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M3 -datatype 0 -path_type 2 -width 5 -route_type signal_route -length 13.42 -origin {551.97 838.505}
create_net_shape -no_snap -type path -net VSSIO -layer M3 -datatype 0 -path_type 2 -width 2.5 -route_type signal_route -points {{1959.63 2402.6}  {1959.63 2418.84}}
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1201.575 1661.5} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1199.115 1661.5} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1201.575 1658.955} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1199.115 1658.955} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1206.905 1667.24} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1204.445 1667.24} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1206.905 1664.715} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1204.445 1664.715} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.485 1128.95} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.155 1120.49} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.755 1126.23} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.485 1126.23} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.425 1123.21} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.155 1123.21} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.755 1128.95} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.425 1120.49} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.645 893.83} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {229.83 948.46} -orient N -col 7 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {475.635 948.46} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1201.61 2210.12} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {209.905 1550.375} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {477.485 847.115} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1199.15 2210.135} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {475.215 847.115} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VPP -master MV3_0_HV_F0 -route_type user_enter -at {188.115 1618.425} -orient N -col 6 -row 6 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1201.61 2207.61} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {477.485 844.595} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1199.15 2207.605} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {517.08 844.585} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1207.04 2215.925} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1204.58 2215.925} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VPP -master MV2_0_VH_F0 -route_type user_enter -at {905.465 1818.02} -orient W -col 6 -row 6 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_std_cell_pin_conn -at {270.265 880.05} -orient N -col 2 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VPP -master MV3_0_HV_F0 -route_type user_enter -at {905.465 1818.02} -orient W -col 6 -row 6 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {519.35 847.115} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {517.08 847.115} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1207.04 2213.33} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {519.35 844.585} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {513.805 852.855} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VPP -master MV4_0_VH_F0 -route_type user_enter -at {188.175 1791.07} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {511.535 852.855} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {513.805 850.32} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {511.535 850.32} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {779.11 1139.335} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {779.96 1137.335} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {779.255 906.605} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {780.105 908.605} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.755 1192.515} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.485 1192.515} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {323.635 2227.49} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {323.62 2264.595} -orient W -col 10 -row 10 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {306.61 1007.47} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {283.87 1007.47} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {306.61 1721.37} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {223.435 1721.37} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {283.9 843.95} -orient W -col 10 -row 9 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {223.5 2227.49} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1148.395 1661.5} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1150.855 1658.955} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1148.395 1658.955} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1156.185 1667.24} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1153.725 1667.24} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1156.185 1664.715} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1153.725 1664.715} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1150.855 1661.5} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.755 1189.795} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.485 1189.795} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.425 1186.775} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.155 1186.775} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1085.815 1664.715} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.425 1184.055} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1082.945 1661.5} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.155 1184.055} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1080.485 1661.5} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.425 935.02} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1082.945 1658.955} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.155 935.02} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1080.485 1658.955} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.425 932.3} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1088.275 1667.24} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.155 932.3} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1085.815 1667.24} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.755 940.76} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1088.275 1664.715} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.485 940.76} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {844.745 1661.655} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net POC -master MV3_0_HV_F0 -route_type user_enter -at {203.345 688.145} -orient N -col 2 -row 2 -x_pitch 0.61 -y_pitch 0.61
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.755 938.04} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {847.015 1658.935} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net POC -master MV3_0_HV_F0 -route_type user_enter -at {203.345 867.265} -orient N -col 2 -row 2 -x_pitch 0.61 -y_pitch 0.61
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.485 938.04} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {844.745 1658.935} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV3_0_HV_F0 -route_type signal_route -at {1037.425 1827.925} -orient W -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.595 890.81} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {784.86 1661.655} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {852.345 1667.395} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {216.36 2239.79} -orient N -col 7 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.325 890.81} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {787.13 1658.935} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {850.075 1667.395} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {209.86 2247.99} -orient N -col 7 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.595 888.09} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {784.86 1658.935} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {852.345 1664.675} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {195.965 1809.15} -orient N -col 7 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.325 888.09} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {792.46 1667.395} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {454.475 1809.15} -orient N -col 17 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.925 896.55} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {790.19 1667.395} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {726.575 1809.15} -orient N -col 17 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.655 896.55} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {792.46 1664.675} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {202.935 1801.73} -orient N -col 7 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.925 893.83} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {790.19 1664.675} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {470.975 1801.73} -orient N -col 17 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {787.13 1661.655} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {710.485 1801.73} -orient N -col 17 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV3_0_HV_F0 -route_type user_enter -at {272.515 844.195} -orient W -col 11 -row 9 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {714.69 852.995} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1156.005 2215.83} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {230.19 858.91} -orient N -col 22 -row 19 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {712.42 852.995} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1153.725 2215.83} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AFSW -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {255 859.255} -orient W -col 23 -row 22 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_std_cell_pin_conn -at {269.15 880.05} -orient N -col 3 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_std_cell_pin_conn -at {267.83 880.05} -orient N -col 3 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1204.58 2213.33} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {480.545 850.32} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {296.33 1701.39} -orient N -col 1 -row 3 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {294.06 1701.39} -orient N -col 4 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {296.33 1698.22} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {294.06 1698.22} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {291 1694.88} -orient N -col 1 -row 3 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {288.73 1694.88} -orient N -col 4 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {291 1691.71} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {288.73 1691.71} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {714.69 850.275} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1156.01 2213.315} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {272.53 876.72} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {712.42 850.275} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1153.725 2213.32} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {191.475 876.72} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {709.36 847.255} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1150.65 2210.15} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {707.09 847.255} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1148.395 2210.225} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {511.965 839.31} -orient W -col 9 -row 9 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {709.36 844.535} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1150.65 2207.63} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {707.09 844.535} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {475.215 844.585} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1148.395 2207.63} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {231.5 930.865} -orient N -col 32 -row 38 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {482.815 852.855} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV3_0_HV_F0 -route_type user_enter -at {191.455 1026.315} -orient N -col 9 -row 9 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {480.545 852.855} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV3_0_HV_F0 -route_type user_enter -at {191.445 1031.135} -orient N -col 4 -row 8 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {482.815 850.32} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {191.345 1816.49} -orient N -col 2 -row 2 -x_pitch 1.42 -y_pitch 1.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {850.075 1664.675} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {209.8 1213.765} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {847.015 1661.655} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.755 1452.675} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {209.8 1234.675} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.485 1452.675} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AFSW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {255 1331.025} -orient N -col 37 -row 37 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.755 1449.955} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {511.965 1128.485} -orient N -col 9 -row 37 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.485 1449.955} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {236.31 1128.485} -orient N -col 9 -row 37 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.425 1446.935} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {216.465 1407.285} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.155 1446.935} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {202.935 1407.285} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.425 1444.215} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {202.935 1448.285} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.155 1444.215} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {779.185 1430.135} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {216.465 1448.285} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {779.99 1432.185} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {209.905 1508.965} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {195.965 1508.965} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {195.965 1550.375} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV2_0_VH_F0 -route_type pg_std_cell_pin_conn -at {270.265 880.05} -orient N -col 2 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV2_0_VH_F0 -route_type pg_std_cell_pin_conn -at {267.83 880.05} -orient N -col 3 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV2_0_VH_F0 -route_type pg_std_cell_pin_conn -at {269.15 880.05} -orient N -col 3 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV1_0_HV_F0 -route_type pg_std_cell_pin_conn -at {270.265 880.05} -orient N -col 2 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV1_0_HV_F0 -route_type pg_std_cell_pin_conn -at {269.15 880.05} -orient N -col 3 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV1_0_HV_F0 -route_type pg_std_cell_pin_conn -at {267.83 880.05} -orient N -col 3 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {780.14 908.605} -orient W -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {238.08 1701.39} -orient N -col 1 -row 3 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {235.81 1701.39} -orient N -col 4 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {238.08 1698.22} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {235.81 1698.22} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {231.64 1694.88} -orient N -col 3 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {228.47 1694.88} -orient N -col 4 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {231.64 1691.71} -orient N -col 3 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {228.47 1691.71} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {296.33 1778.72} -orient N -col 1 -row 3 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {294.06 1778.72} -orient N -col 4 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {296.33 1775.55} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {294.06 1775.55} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {291 1772.21} -orient N -col 1 -row 3 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {288.73 1772.21} -orient N -col 4 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {291 1769.04} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {288.73 1769.04} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {238.08 1778.72} -orient N -col 1 -row 3 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {235.81 1778.72} -orient N -col 4 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {238.08 1775.55} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {235.81 1775.55} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {231.64 1772.21} -orient N -col 3 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {228.47 1772.21} -orient N -col 4 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {231.64 1769.04} -orient N -col 3 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {228.47 1769.04} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {355.45 1775.55} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {355.45 1698.22} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {352.39 1772.21} -orient N -col 1 -row 3 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {352.39 1694.88} -orient N -col 1 -row 3 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {350.12 1772.21} -orient N -col 4 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {350.12 1694.88} -orient N -col 4 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {352.39 1769.04} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {352.39 1691.71} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {350.12 1769.04} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {350.12 1691.71} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {357.72 1778.72} -orient N -col 1 -row 3 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {357.72 1701.39} -orient N -col 1 -row 3 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {355.45 1778.72} -orient N -col 4 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {355.45 1701.39} -orient N -col 4 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {357.72 1775.55} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {357.72 1698.22} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {229.83 1260.43} -orient N -col 7 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {236.27 1266.17} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {779.97 1432.185} -orient W -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VPP -master MV3_0_HV_F0 -route_type user_enter -at {188.165 1628.675} -orient N -col 6 -row 6 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VPP -master MV3_0_HV_F0 -route_type user_enter -at {188.165 1641.405} -orient N -col 6 -row 6 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.755 1423.17} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.485 1423.17} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.755 1420.45} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.485 1420.45} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.425 1417.43} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.155 1417.43} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.425 1414.71} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.155 1414.71} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {1037.48 1816.49} -orient N -col 2 -row 2 -x_pitch 1.42 -y_pitch 1.54
create_via -no_snap -type via_array -net VPP -master MV4_0_VH_F0 -route_type user_enter -at {905.475 1791.07} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via -net VREF0P8 -master MV2_0_VH_F0 -route_type signal_route -at {1037.48 1828.8} -orient N
