create_route_guide -no_snap -coordinate {{20 2314} {187 2481}} -no_signal_layer {M1 M2 M3 M4 M5} -name CORNER 
create_route_guide -no_snap -coordinate {{780.625 868.04} {783 1458.965}} -no_signal_layer {M2 M3} -name ANA_PIN_1 
create_route_guide -no_snap -coordinate {{1339.865 1780.085} {1340.685 1961.445}} -no_signal_layer {M2 M3} -name ANA_PIN_2 
create_route_guide -no_snap -coordinate {{831.97 1481.68} {920.175 1483.68}} -no_signal_layer {M2 M3} -name ANA_PIN_3 
create_route_guide -no_snap -coordinate {{1016.765 1673.405} {1048.325 1675.405}} -no_signal_layer {M2 M3} -name ANA_PIN_4 
create_net_shape -no_snap -type wire -net DVDD_1P5_ANA -layer M3 -datatype 0 -path_type 2 -width 10 -route_type pg_macro_io_pin_conn -length 9.02 -origin {186.125 862.01}
create_net_shape -no_snap -type wire -net VPP -layer M3 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 5.74 -origin {182.435 1678.525}
create_net_shape -no_snap -type wire -net VPP -layer M3 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 5.74 -origin {182.435 1691.235}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 13.27 -origin {762.845 1456.92}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M5 -datatype 0 -path_type 2 -width 5 -route_type user_enter -length 81.165 -origin {191.455 876.72}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 332.875 -origin {181.595 1174.225}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 33.18 -origin {180.82 1600.215}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 33.18 -origin {180.82 1558.805}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 33.18 -origin {180.82 1289.435}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 32.845 -origin {180.82 1268.525}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 39.18 -origin {180.82 1497.715}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 39.18 -origin {180.82 1456.715}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 22.92 -origin {757.515 1459.79}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.12 -origin {1337.24 1912.615}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.12 -origin {779.23 1457.9}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 16.83 -origin {1320.83 1910.615}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 4.495 -origin {775.205 1455.895}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.5 -origin {1336.76 1910.615}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.5 -origin {778.75 1455.9}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M5 -datatype 0 -path_type 2 -width 2 -route_type user_enter -length 843.565 -origin {193.915 1816.49}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 21.815 -origin {758.73 1179.155}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.01 -origin {755.72 984.19}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.12 -origin {779.34 1179.155}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.01 -origin {755.72 978.45}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 15.7 -origin {764.06 1177.155}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 23.215 -origin {751.335 1190.725}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.5 -origin {778.86 1177.155}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 23.1 -origin {751.45 1184.985}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 19.19 -origin {761.3 954.625}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 29.93 -origin {1016.785 1689.39}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.12 -origin {779.285 953.81}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 29.93 -origin {1016.785 1683.65}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 13.075 -origin {766.63 951.81}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 28.235 -origin {1305.835 1918.01}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.5 -origin {778.805 951.81}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 28.235 -origin {1305.835 1912.27}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 191.375 -origin {1134.455 2214.19}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 191.375 -origin {1134.455 2208.45}
create_net_shape -no_snap -type wire -net POC -layer M3 -datatype 0 -path_type 2 -width 0.9 -route_type user_enter -length 56.665 -origin {149.55 737.985}
create_net_shape -no_snap -type wire -net POC -layer M3 -datatype 0 -path_type 2 -width 0.9 -route_type user_enter -length 331.75 -origin {206.215 867.265}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.01 -origin {755.72 939.91}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.01 -origin {755.72 934.17}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 21.365 -origin {753.365 1477.83}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 21.365 -origin {753.365 1472.09}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 21.365 -origin {753.365 1448.31}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 21.365 -origin {753.365 1442.57}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 70.82 -origin {837.16 1496.69}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 70.82 -origin {837.16 1490.95}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 28.235 -origin {1305.775 1882.91}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 28.235 -origin {1305.775 1877.17}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 68.085 -origin {467.38 843.835}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_std_cell_pin_conn -length 16.85 -origin {222.005 1266.17}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 68.085 -origin {467.38 849.575}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_std_cell_pin_conn -length 16.875 -origin {221.995 1260.43}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 47.535 -origin {686.42 851.215}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M3 -datatype 0 -path_type 2 -width 5 -route_type user_enter -length 7.51 -origin {183.945 1076.235}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 47.535 -origin {686.42 845.475}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 1750.29 -origin {207.76 2289.66}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 22.945 -origin {1315.5 1912.615}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 1744.05 -origin {214 2282.24}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 538.855 -origin {195.22 1809.15}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 1 -route_type signal_route -length 0.77 -origin {1959.425 2418.575}
create_net_shape -no_snap -type wire -net DVDD_1P5_ANA -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 21.98 -origin {190.145 817.83}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 516.465 -origin {201.51 1801.73}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 58.575 -origin {181.45 979.475}
create_net_shape -no_snap -type wire -net VDD_DIG_AFSW -layer M3 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 83.695 -origin {181.31 1384.555}
create_net_shape -no_snap -type wire -net VPP -layer M3 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 5.74 -origin {182.435 1668.275}
create_net_shape -no_snap -type wire -net VPP -layer M5 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 717.645 -origin {187.98 1791.07}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M3 -datatype 0 -path_type 2 -width 4 -route_type user_enter -length 9.46 -origin {183.455 1081.155}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 6 -route_type pg_strap -length 19.01 -origin {755.72 957.14}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 6 -route_type pg_strap -length 19.01 -origin {755.72 950.63}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 6 -route_type pg_strap -length 139.715 -origin {222 1776.91}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 6 -route_type pg_strap -length 139.715 -origin {222 1699.58}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 6 -route_type pg_strap -length 139.715 -origin {222 1770.4}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 6 -route_type pg_strap -length 139.715 -origin {222 1693.07}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M3 -datatype 0 -path_type 2 -width 1 -route_type signal_route -length 0.635 -origin {1037.48 1827.98}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AFSW -layer M5 -datatype 0 -path_type 2 -width 20 -route_type signal_route -length 16.845 -origin {255 844.55}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 15 -route_type pg_macro_io_pin_conn -length 25.655 -origin {454.475 1805.61}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 2 -width 20 -route_type signal_route -length 17.165 -origin {230 844.26}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 15 -route_type pg_macro_io_pin_conn -length 33.075 -origin {470.975 1798.23}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M3 -datatype 0 -path_type 2 -width 5 -route_type user_enter -length 7.81 -origin {272.5 836.775}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 353.75 -origin {204.52 1451.71}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 1 -route_type signal_route -length 20.5 -origin {1960.195 2398.075}
create_net_shape -no_snap -type wire -vertical -net POC -layer M4 -datatype 0 -path_type 2 -width 0.9 -route_type user_enter -length 129.3 -origin {206.215 737.985}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 34.535 -origin {1154.135 2192.87}
create_net_shape -no_snap -type wire -vertical -net POC -layer M3 -datatype 0 -path_type 2 -width 0.9 -route_type user_enter -length 32.48 -origin {537.965 834.785}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 34.535 -origin {1148.805 2192.87}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 2 -route_type user_enter -length 10.855 -origin {1037.48 1816.49}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M2 -datatype 0 -path_type 2 -width 0.28 -route_type signal_route -length 1.8 -origin {1037.48 1828.8}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 2 -width 5 -route_type signal_route -length 0.45 -origin {511.965 836.67}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 655.97 -origin {236.27 1164.05}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 23.175 -origin {723.765 834.06}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 13.1 -origin {847.335 1487.055}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 23.14 -origin {721.765 834.095}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 13.1 -origin {842.005 1487.055}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 2 -route_type user_enter -length 736.52 -origin {193.915 1079.98}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 17.38 -origin {869.085 1482.775}
create_net_shape -no_snap -type wire -vertical -net DVDD_1P5_ANA -layer M3 -datatype 0 -path_type 2 -width 10 -route_type pg_macro_io_pin_conn -length 44.28 -origin {195.145 817.73}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 17.39 -origin {871.085 1482.765}
create_net_shape -no_snap -type wire -vertical -net VSSIO -layer M3 -datatype 0 -path_type 2 -width 18.71 -route_type signal_route -length 3.69 -origin {39.295 728.965}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 4 -route_type signal_route -length 18.86 -origin {81.66 721.175}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 1 -route_type pg_macro_io_pin_conn -length 0.825 -origin {780.14 953.805}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 1 -route_type pg_macro_io_pin_conn -length 1.93 -origin {780.03 1457.875}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 1 -route_type pg_macro_io_pin_conn -length 1.025 -origin {775.705 1455.895}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 34.575 -origin {1222.195 2192.87}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 34.575 -origin {1216.865 2192.87}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 364.3 -origin {1323.33 1852.39}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 358.56 -origin {1318 1852.39}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 55.13 -origin {765.345 1430.72}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 55.16 -origin {760.015 1430.69}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 17.38 -origin {891.69 1482.775}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 17.39 -origin {893.69 1482.765}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 56.135 -origin {766.56 1158.165}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 56.135 -origin {761.23 1158.165}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 87.96 -origin {769.13 909.905}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 87.96 -origin {763.8 909.905}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 16.685 -origin {712.88 840.55}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 16.685 -origin {707.55 840.55}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 13.815 -origin {481.005 840.55}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 13.815 -origin {475.675 840.55}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 13.8 -origin {517.54 840.565}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 1450.37 -origin {210.76 842.74}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 1442.99 -origin {217 842.74}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 5 -route_type user_enter -length 33.365 -origin {272.53 843.355}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 5 -route_type user_enter -length 199.545 -origin {191.455 876.69}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 20.13 -origin {469.37 834.235}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 20.195 -origin {471.37 834.17}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 23.175 -origin {693.745 834.06}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 23.14 -origin {691.745 834.095}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 15 -route_type pg_macro_io_pin_conn -length 33.075 -origin {710.075 1798.23}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 15 -route_type pg_macro_io_pin_conn -length 25.655 -origin {726.575 1805.61}
create_net_shape -no_snap -type wire -vertical -net POC -layer M3 -datatype 0 -path_type 2 -width 0.9 -route_type user_enter -length 3.35 -origin {149.55 737.985}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 17 -route_type pg_macro_io_pin_conn -length 141.905 -origin {231.5 850.205}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AFSW -layer M4 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 545.945 -origin {255 848.61}
create_net_shape -no_snap -type wire -vertical -net VPP -layer M2 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 12.665 -origin {905.465 1817.73}
create_net_shape -no_snap -type wire -vertical -net VPP -layer M4 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 122.995 -origin {188.115 1668.27}
create_net_shape -no_snap -type wire -vertical -net VPP -layer M4 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 27.135 -origin {905.465 1790.95}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_macro_io_pin_conn -length 828.17 -origin {229.83 991.85}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 348.155 -origin {511.965 836.245}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 549.285 -origin {198.28 1263.52}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 19.805 -origin {1038.535 1674.61}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 19.815 -origin {1040.535 1674.6}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 170.06 -origin {294.52 1649.96}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 170.06 -origin {289.19 1649.96}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 13.1 -origin {887.225 1487.055}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 13.1 -origin {881.895 1487.055}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 16.41 -origin {1034.415 1678.005}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 16.41 -origin {1029.085 1678.005}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 170.06 -origin {355.865 1649.96}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_strap -length 170.06 -origin {350.535 1649.96}
create_net_shape -no_snap -type path -net VSSIO -layer M3 -datatype 0 -path_type 2 -width 2.5 -route_type signal_route -points {{1959.63 2432.6}  {1959.63 2446.8}}
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
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {780.03 1457.9} -orient W -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VPP -master MV3_0_HV_F0 -route_type user_enter -at {188.165 1678.51} -orient N -col 6 -row 6 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VPP -master MV3_0_HV_F0 -route_type user_enter -at {188.165 1691.255} -orient N -col 6 -row 6 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {767.155 1450.115} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {764.885 1450.115} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {767.155 1447.395} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {764.885 1447.395} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {761.825 1444.375} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {759.555 1444.375} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {761.825 1441.655} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {759.555 1441.655} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {1037.48 1816.49} -orient N -col 2 -row 2 -x_pitch 1.42 -y_pitch 1.54
create_via -no_snap -type via_array -net VPP -master MV4_0_VH_F0 -route_type user_enter -at {905.475 1791.07} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1322.94 2213.32} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1319.865 2210.15} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1317.61 2210.225} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1325.22 2215.83} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1319.865 2207.63} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1322.94 2215.83} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1317.61 2207.63} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1325.225 2213.315} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.94 958.95} -orient N -col 1 -row 3 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.67 958.95} -orient N -col 4 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.94 955.78} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.67 955.78} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.61 952.44} -orient N -col 1 -row 3 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.34 952.44} -orient N -col 4 -row 3 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.61 949.27} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.34 949.27} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
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
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {511.965 837.93} -orient W -col 9 -row 9 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {707.09 847.255} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1148.395 2210.225} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {511.965 837.93} -orient W -col 9 -row 9 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {709.36 844.535} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1150.65 2207.63} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {707.09 844.535} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {475.215 842.905} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1148.395 2207.63} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {231.5 979.475} -orient N -col 32 -row 38 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {482.815 851.365} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV3_0_HV_F0 -route_type user_enter -at {191.455 1076.075} -orient N -col 10 -row 10 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {480.545 851.365} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV3_0_HV_F0 -route_type user_enter -at {193.915 1081.015} -orient N -col 4 -row 8 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {482.815 848.645} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {193.915 1816.49} -orient N -col 2 -row 2 -x_pitch 1.42 -y_pitch 1.54
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {198.27 1268.525} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {886.655 1495.765} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {210.76 1268.525} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {883.595 1492.745} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {198.27 1289.435} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {767.155 1479.62} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {210.705 1289.435} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {764.885 1479.62} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AFSW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {255 1384.555} -orient N -col 37 -row 37 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {767.155 1476.9} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {511.965 1174.225} -orient N -col 9 -row 37 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {764.885 1476.9} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {236.31 1174.225} -orient N -col 9 -row 37 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {761.825 1473.88} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {217 1456.715} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {759.555 1473.88} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {204.48 1456.715} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {761.825 1471.16} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {204.48 1497.715} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {759.555 1471.16} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {779.2 1455.9} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {216.985 1497.715} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {780.05 1457.9} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {210.75 1558.805} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {198.3 1558.805} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {198.215 1600.215} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV2_0_VH_F0 -route_type pg_std_cell_pin_conn -at {270.265 880.05} -orient N -col 2 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV2_0_VH_F0 -route_type pg_std_cell_pin_conn -at {267.83 880.05} -orient N -col 3 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV2_0_VH_F0 -route_type pg_std_cell_pin_conn -at {269.15 880.05} -orient N -col 3 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV1_0_HV_F0 -route_type pg_std_cell_pin_conn -at {270.265 880.05} -orient N -col 2 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV1_0_HV_F0 -route_type pg_std_cell_pin_conn -at {269.15 880.05} -orient N -col 3 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV1_0_HV_F0 -route_type pg_std_cell_pin_conn -at {267.83 880.05} -orient N -col 3 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {780.14 953.81} -orient W -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.37 1189.795} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1322.87 1884.6} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {766.1 1189.795} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1325.225 1882.03} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.04 1186.775} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1322.87 1882.03} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {760.77 1186.775} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1034.04 1688.45} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.04 1184.055} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1030.98 1685.43} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {760.77 1184.055} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1028.71 1685.43} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.61 980.225} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1030.98 1682.71} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.34 980.225} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1028.71 1682.71} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.61 977.505} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1036.31 1691.17} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.34 977.505} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1034.04 1691.17} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.94 985.965} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1036.31 1688.45} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.67 985.965} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {881.325 1492.745} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net POC -master MV3_0_HV_F0 -route_type user_enter -at {206.215 737.985} -orient N -col 2 -row 2 -x_pitch 0.61 -y_pitch 0.61
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {770.94 983.245} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {883.595 1490.025} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net POC -master MV3_0_HV_F0 -route_type user_enter -at {206.215 867.265} -orient N -col 2 -row 2 -x_pitch 0.61 -y_pitch 0.61
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.67 983.245} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {881.325 1490.025} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV3_0_HV_F0 -route_type signal_route -at {1037.425 1827.925} -orient W -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.78 936.015} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {841.545 1492.745} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {888.925 1498.485} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {216.875 2282.25} -orient N -col 7 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.51 936.015} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {843.815 1490.025} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {886.655 1498.485} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {210.805 2289.76} -orient N -col 7 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {765.78 933.295} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {841.545 1490.025} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {888.925 1495.765} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {198.28 1809.15} -orient N -col 7 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {763.51 933.295} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {849.145 1498.485} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {454.475 1809.15} -orient N -col 17 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {771.11 941.755} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {846.875 1498.485} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {726.575 1809.15} -orient N -col 17 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.84 941.755} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {849.145 1495.765} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {204.52 1801.73} -orient N -col 7 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {771.11 939.035} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {846.875 1495.765} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {470.975 1801.73} -orient N -col 17 -row 8 -x_pitch 0.9 -y_pitch 0.9
crcreate_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.84 939.035} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {843.815 1492.745} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {710.485 1801.73} -orient N -col 17 -row 8 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VREF0P8 -master MV3_0_HV_F0 -route_type user_enter -at {272.515 844.195} -orient W -col 11 -row 9 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {714.69 852.995} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1156.005 2215.83} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {231.5 858.905} -orient N -col 19 -row 18 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {712.42 852.995} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1153.725 2215.83} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AFSW -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {255 859.255} -orient W -col 23 -row 22 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_std_cell_pin_conn -at {269.15 880.05} -orient N -col 3 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_std_cell_pin_conn -at {267.83 880.05} -orient N -col 3 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1221.785 2213.33} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {480.545 848.645} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1218.73 2210.12} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {210.785 1600.215} -orient N -col 11 -row 19 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {477.485 845.625} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1216.455 2210.135} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {475.215 845.625} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VPP -master MV3_0_HV_F0 -route_type user_enter -at {188.115 1668.265} -orient N -col 6 -row 6 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1218.75 2207.61} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {477.485 842.905} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {1337.21 1910.615} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1216.455 2207.605} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {1338.06 1912.615} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {517.08 842.92} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1224.04 2215.925} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1221.785 2215.925} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VPP -master MV2_0_VH_F0 -route_type user_enter -at {905.465 1818.02} -orient W -col 6 -row 6 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_std_cell_pin_conn -at {270.265 880.05} -orient N -col 2 -row 1 -x_pitch 0.41 
create_via -no_snap -type via_array -net VPP -master MV3_0_HV_F0 -route_type user_enter -at {905.465 1818.02} -orient W -col 6 -row 6 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {519.35 845.64} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {517.08 845.64} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1224.04 2213.33} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1322.87 1917.19} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {519.35 842.92} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {513.805 851.4} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1319.81 1914.06} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VPP -master MV4_0_VH_F0 -route_type user_enter -at {188.175 1791.07} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1317.54 1914.06} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {511.535 851.4} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {513.805 848.68} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1319.81 1911.34} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {511.535 848.68} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1317.54 1911.34} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {779.31 1177.155} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1325.2 1919.745} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {780.16 1179.155} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1322.87 1919.76} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {779.255 951.81} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1325.225 1917.19} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {780.105 953.81} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1319.81 1878.94} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1317.54 1878.94} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1319.81 1876.22} -orient N -col 1 -row 4 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {768.37 1192.515} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1317.54 1876.22} -orient N -col 4 -row 4 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {766.1 1192.515} -orient N -col 4 -row 2 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_strap -at {1325.2 1884.595} -orient N -col 1 -row 2 -y_pitch 0.9
create_via -no_snap -type via -net VREF0P8 -master MV2_0_VH_F0 -route_type signal_route -at {1037.48 1828.8} -orient N
create_net_shape -no_snap -type wire -net VDDIO -layer M5 -datatype 0 -path_type 2 -width 5 -route_type pg_macro_io_pin_conn -length 23.08 -origin {283.585 1007.43}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M3 -datatype 0 -path_type 2 -width 5 -route_type signal_route -length 7.625 -origin {283.9 836.925}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M3 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 6.56 -origin {323.62 2312.255}
create_net_shape -no_snap -type wire -net VDDIO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 105.12 -origin {221 2269.35}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 50.065 -origin {323.62 2266.815}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M4 -datatype 0 -path_type 2 -width 5 -route_type pg_macro_io_pin_conn -length 163.88 -origin {283.9 843.805}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 553.985 -origin {223.5 1717.96}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 719.145 -origin {306.665 1004.815}
create_net_shape -no_snap -type wire -net VDDIO -layer M5 -datatype 0 -path_type 2 -width 5 -route_type pg_macro_io_pin_conn -length 83.27 -origin {223.395 1721.37}
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {323.635 2269.345} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {323.62 2314.565} -orient W -col 12 -row 12 -x_pitch 0.42 -y_pitch 0.42
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {306.61 1007.47} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {283.87 1007.47} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {306.61 1721.37} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {223.435 1721.37} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
create_via -no_snap -type via_array -net VDDIO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {283.9 843.95} -orient W -col 10 -row 9 -x_pitch 0.54 -y_pitch 0.54
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {223.5 2269.35} -orient N -col 6 -row 6 -x_pitch 0.9 -y_pitch 0.9
