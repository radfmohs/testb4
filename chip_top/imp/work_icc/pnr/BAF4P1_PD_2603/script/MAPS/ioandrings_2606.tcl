create_route_guide -no_snap -coordinate {{20 2314} {187 2481}} -no_signal_layer {M1 M2 M3 M4 M5} -name CORNER 
create_route_guide -no_snap -coordinate {{780.625 868.04} {786.775 1458.965}} -no_signal_layer {M2 M3} -name ANA_PIN_1 
create_route_guide -no_snap -coordinate {{1339.865 1780.085} {1340.685 1961.445}} -no_signal_layer {M2 M3} -name ANA_PIN_2 
create_route_guide -no_snap -coordinate {{831.97 1481.68} {920.175 1483.68}} -no_signal_layer {M2 M3} -name ANA_PIN_3 
create_route_guide -no_snap -coordinate {{1016.765 1673.405} {1048.325 1675.405}} -no_signal_layer {M2 M3} -name ANA_PIN_4 
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 68.085 -origin {467.38 843.835}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 68.085 -origin {467.38 849.575}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 47.535 -origin {686.42 851.215}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 47.535 -origin {686.42 845.475}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 9.235 -origin {1329.21 1912.615}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 527.855 -origin {195.22 1862.025}
create_net_shape -no_snap -type wire -net DVDD_1P5_ANA -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 30.58 -origin {181.545 817.83}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 505.065 -origin {201.51 1854.605}
create_net_shape -no_snap -type wire -net VDDIO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 65.475 -origin {221.065 1694.36}
create_net_shape -no_snap -type wire -net VDDIO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 105.12 -origin {221 2269.35}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 58.575 -origin {181.45 933.965}
create_net_shape -no_snap -type wire -net VDD_DIG_AFSW -layer M3 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 83.695 -origin {181.31 1332.69}
create_net_shape -no_snap -type wire -net VPP -layer M3 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 5.74 -origin {182.435 1630.63}
create_net_shape -no_snap -type wire -net VPP -layer M5 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 706.625 -origin {187.98 1843.77}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M3 -datatype 0 -path_type 2 -width 4 -route_type user_enter -length 9.46 -origin {183.455 1031.13}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M5 -datatype 0 -path_type 2 -width 5 -route_type user_enter -length 81.165 -origin {191.455 876.72}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 332.875 -origin {181.595 1131.79}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 33.18 -origin {180.82 1550.5}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 33.18 -origin {180.82 1508.45}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 33.18 -origin {180.82 1236.905}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 32.845 -origin {180.82 1215.88}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 39.18 -origin {180.82 1448.55}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 39.18 -origin {180.82 1406.5}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.12 -origin {1337.24 1912.615}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 8.39 -origin {1329.27 1910.615}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.5 -origin {1336.76 1910.615}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 9.455 -origin {772.87 1208.18}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 9.55 -origin {772.795 1210.18}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M5 -datatype 0 -path_type 2 -width 2 -route_type user_enter -length 832.57 -origin {193.915 1869.235}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.01 -origin {755.72 984.19}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.01 -origin {755.72 978.45}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 23.215 -origin {751.335 1190.725}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 23.1 -origin {751.45 1184.985}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 29.93 -origin {1016.785 1689.39}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 29.93 -origin {1016.785 1683.65}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 28.235 -origin {1305.775 1928.83}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 28.235 -origin {1305.775 1923.09}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 92.71 -origin {1121.335 2264.43}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 92.71 -origin {1121.335 2258.69}
create_net_shape -no_snap -type wire -net POC -layer M3 -datatype 0 -path_type 2 -width 0.9 -route_type user_enter -length 43.825 -origin {149.515 690.365}
create_net_shape -no_snap -type wire -net POC -layer M3 -datatype 0 -path_type 2 -width 0.9 -route_type user_enter -length 344.72 -origin {193.245 867.265}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.01 -origin {755.72 939.91}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.01 -origin {755.72 934.17}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 13.375 -origin {761.355 1477.83}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 13.375 -origin {761.355 1472.09}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 13.375 -origin {761.355 1448.31}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 13.375 -origin {761.355 1442.57}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 47.085 -origin {860.895 1496.69}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 47.085 -origin {860.895 1490.95}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 28.235 -origin {1305.775 1891.93}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 28.235 -origin {1305.775 1886.19}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_std_cell_pin_conn -length 16.85 -origin {222.005 1266.17}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_std_cell_pin_conn -length 16.875 -origin {221.995 1260.43}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M3 -datatype 0 -path_type 2 -width 5 -route_type user_enter -length 7.51 -origin {183.945 1026.37}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 1750.29 -origin {207.76 2289.66}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 1744.05 -origin {214 2282.24}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 1 -route_type signal_route -length 0.77 -origin {1959.425 2418.575}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 1454.565 -origin {210.76 838.545}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 1447.19 -origin {217 838.54}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 5 -route_type user_enter -length 36.85 -origin {272.53 839.87}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 5 -route_type user_enter -length 149.675 -origin {191.455 876.69}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 21.39 -origin {469.37 834.235}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 21.455 -origin {471.37 834.17}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 23.595 -origin {693.745 834.06}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 23.565 -origin {691.745 834.095}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 15 -route_type pg_macro_io_pin_conn -length 32.64 -origin {699.075 1851.105}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 15 -route_type pg_macro_io_pin_conn -length 25.22 -origin {715.575 1858.525}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 6.305 -origin {551.965 834.27}
create_net_shape -no_snap -type wire -vertical -net POC -layer M3 -datatype 0 -path_type 2 -width 0.9 -route_type user_enter -length 1.3 -origin {149.55 690.375}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 17 -route_type pg_macro_io_pin_conn -length 103.895 -origin {231.5 850.205}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M3 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 6.56 -origin {323.62 2312.255}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AFSW -layer M4 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 495.57 -origin {255 847.12}
create_net_shape -no_snap -type wire -vertical -net VPP -layer M2 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 12.665 -origin {894.465 1870.06}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 50.065 -origin {323.62 2266.815}
create_net_shape -no_snap -type wire -vertical -net VPP -layer M4 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 213.28 -origin {188.115 1630.63}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 580.085 -origin {223.5 1691.86}
create_net_shape -no_snap -type wire -vertical -net VPP -layer M4 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 27.12 -origin {894.465 1843.77}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 856.01 -origin {283.9 840.85}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 32.04 -origin {551.965 835.665}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_macro_io_pin_conn -length 921.435 -origin {229.83 950.955}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 305.68 -origin {511.965 836.245}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 654.57 -origin {198.28 1210.88}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 19.805 -origin {1038.535 1674.61}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 19.815 -origin {1040.535 1674.6}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M3 -datatype 0 -path_type 2 -width 1 -route_type signal_route -length 0.635 -origin {1026.48 1880.44}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AFSW -layer M5 -datatype 0 -path_type 2 -width 20 -route_type signal_route -length 17.175 -origin {255 844.22}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 2 -width 20 -route_type signal_route -length 17.165 -origin {230 844.26}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M3 -datatype 0 -path_type 2 -width 5 -route_type user_enter -length 2.805 -origin {272.5 836.775}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M3 -datatype 0 -path_type 2 -width 5 -route_type signal_route -length 7.625 -origin {283.9 836.925}
create_net_shape -no_snap -type wire -vertical -net POC -layer M4 -datatype 0 -path_type 2 -width 0.9 -route_type user_enter -length 176.97 -origin {193.175 690.315}
create_net_shape -no_snap -type wire -vertical -net POC -layer M3 -datatype 0 -path_type 2 -width 0.9 -route_type user_enter -length 32.48 -origin {537.965 834.785}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 2 -route_type user_enter -length 10.64 -origin {1026.485 1869.205}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M2 -datatype 0 -path_type 2 -width 0.28 -route_type signal_route -length 1.8 -origin {1026.48 1881.125}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 2 -width 5 -route_type signal_route -length 0.45 -origin {511.965 836.67}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 750.395 -origin {236.27 1121.85}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 23.595 -origin {723.765 834.06}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 23.565 -origin {721.765 834.095}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 2 -route_type user_enter -length 839.12 -origin {193.915 1030.145}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 15 -route_type pg_macro_io_pin_conn -length 25.22 -origin {443.475 1858.525}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 15 -route_type pg_macro_io_pin_conn -length 32.64 -origin {459.975 1851.105}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 456.645 -origin {204.52 1401.48}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 1 -route_type signal_route -length 20.5 -origin {1960.195 2398.075}
create_net_shape -no_snap -type path -net VSSIO -layer M3 -datatype 0 -path_type 2 -width 2.5 -route_type signal_route -points {{1959.63 2433.26}  {1959.63 2446.14}}
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {198.28 1861.985} -orient N -col 7 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {443.475 1862.1} -orient N -col 17 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {715.615 1862.05} -orient N -col 17 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {204.52 1854.615} -orient N -col 7 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {459.93 1854.505} -orient N -col 17 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {699.105 1854.65} -orient N -col 17 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net POC -master MV3_0_HV_F0 -route_type user_enter -at {193.175 690.365} -orient N -col 2 -row 2 -x_pitch 0.61 -y_pitch 0.61
create_via -no_snap -type via_array -net POC -master MV3_0_HV_F0 -route_type user_enter -at {193.175 867.265} -orient N -col 2 -row 2 -x_pitch 0.61 -y_pitch 0.61
create_via -no_snap -type via_array -net VREF0P8 -master MV3_0_HV_F0 -route_type signal_route -at {1026.48 1880.335} -orient W -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {216.875 2282.25} -orient N -col 7 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {210.805 2289.76} -orient N -col 7 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {223.5 2269.35} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {323.635 2269.345} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {223.575 1694.365} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {283.895 1694.345} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {283.9 843.95} -orient W -col 10 -row 9 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VREF0P8 -master MV3_0_HV_F0 -route_type user_enter -at {272.515 838.96} -orient W -col 11 -row 9 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {231.5 858.905} -orient N -col 19 -row 18 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AFSW -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {255 859.255} -orient W -col 23 -row 22 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {272.53 876.72} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {191.475 876.72} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {511.965 837.93} -orient W -col 9 -row 9 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {511.965 837.93} -orient W -col 9 -row 9 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {551.965 838.12} -orient W -col 9 -row 9 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {231.5 933.965} -orient N -col 32 -row 38 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VREF0P8 -master MV3_0_HV_F0 -route_type user_enter -at {191.455 1026.22} -orient N -col 10 -row 10 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VREF0P8 -master MV3_0_HV_F0 -route_type user_enter -at {193.915 1031.14} -orient N -col 4 -row 8 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {193.915 1869.235} -orient N -col 2 -row 2 -x_pitch 1.42 -y_pitch 1.54
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {198.27 1215.88} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {210.76 1215.88} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {198.27 1236.885} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {210.705 1236.885} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AFSW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {255 1332.69} -orient N -col 37 -row 37 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {511.965 1131.79} -orient N -col 9 -row 37 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {236.31 1131.79} -orient N -col 9 -row 37 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {217 1406.5} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {204.48 1406.5} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {204.48 1448.54} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {216.985 1448.54} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {210.75 1508.425} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {198.3 1508.395} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {198.215 1550.485} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {210.785 1550.485} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VPP -master MV3_0_HV_F0 -route_type user_enter -at {188.115 1630.63} -orient N -col 6 -row 6 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {1337.21 1910.615} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {1338.06 1912.615} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDDIO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {323.62 2314.565} -orient W -col 12 -row 12 -x_pitch 0.42 -y_pitch 0.42
create_via -no_snap -type via_array -net VPP -master MV2_0_VH_F0 -route_type user_enter -at {894.465 1870.475} -orient W -col 7 -row 7 -x_pitch 0.45 -y_pitch 0.45
create_via -no_snap -type via_array -net VPP -master MV3_0_HV_F0 -route_type user_enter -at {894.465 1870.475} -orient W -col 7 -row 7 -x_pitch 0.45 -y_pitch 0.45
create_via -no_snap -type via_array -net VPP -master MV4_0_VH_F0 -route_type user_enter -at {188.175 1843.77} -orient N -col 4 -row 4 -x_pitch 0.8 -y_pitch 0.84
create_via -no_snap -type via_array -net VPP -master MV4_0_VH_F0 -route_type user_enter -at {894.605 1843.77} -orient N -col 4 -row 4 -x_pitch 0.8 -y_pitch 0.84
create_via -no_snap -type via -net VREF0P8 -master MV2_0_VH_F0 -route_type signal_route -at {1026.48 1881.3} -orient N
