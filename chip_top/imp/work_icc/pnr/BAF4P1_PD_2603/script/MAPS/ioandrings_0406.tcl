create_route_guide -no_snap -coordinate {{20 2314} {187 2481}} -no_signal_layer {M1 M2 M3 M4 M5} -name CORNER 
create_route_guide -no_snap -coordinate {{780.625 1044.645} {786.775 1458.965}} -no_signal_layer {M2 M3} -name ANA_PIN_1 
create_route_guide -no_snap -coordinate {{1371.475 1780.085} {1372.295 1829.935}} -no_signal_layer {M2 M3} -name ANA_PIN_2 
create_route_guide -no_snap -coordinate {{1493.93 2102.41} {1494.75 2119.805}} -no_signal_layer {M2 M3} -name ANA_PIN_3 
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 55.915 -origin {479.55 905.69}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 55.915 -origin {479.55 911.43}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 55.425 -origin {689.705 913.07}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 55.425 -origin {689.705 907.33}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 1 -route_type pg_macro_io_pin_conn -length 28.86 -origin {530.525 892.365}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 6.125 -origin {1485.945 2102.91}
create_net_shape -no_snap -type wire -net VSSIO -layer M3 -datatype 0 -path_type 2 -width 3.06 -route_type pg_macro_io_pin_conn -length 15.68 -origin {31.44 920.08}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 1971.305 -origin {195.28 2304.37}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 1965.065 -origin {201.52 2296.99}
create_net_shape -no_snap -type wire -net DVDD_1P5_ANA -layer M3 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 7.01 -origin {181.515 1049.47}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 1958.825 -origin {207.76 2289.61}
create_net_shape -no_snap -type wire -net DVDD_1P5_ANA -layer M3 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 20.135 -origin {183.115 894.535}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 7 -route_type pg_ring -length 1952.585 -origin {214 2282.23}
create_net_shape -no_snap -type wire -net POC -layer M3 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 0.495 -origin {149.55 919.36}
create_net_shape -no_snap -type wire -net POC -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 388.13 -origin {149.965 890.93}
create_net_shape -no_snap -type wire -net VDDIO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 62.655 -origin {223.885 1694.36}
create_net_shape -no_snap -type wire -net VDDIO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 102.235 -origin {223.885 2269.35}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 9.595 -origin {181.45 1151.825}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 91.205 -origin {184.43 1151.825}
create_net_shape -no_snap -type wire -net VDD_DIG_AFSW -layer M3 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 9.325 -origin {181.31 1559.06}
create_net_shape -no_snap -type wire -net VDD_DIG_AFSW -layer M5 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 81.75 -origin {183.355 1559.06}
create_net_shape -no_snap -type wire -net VPP -layer M3 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 5.74 -origin {182.435 1847.755}
create_net_shape -no_snap -type wire -net VPP -layer M5 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 706.625 -origin {187.98 1843.77}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M3 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 2.87 -origin {181.615 1256.935}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 10.26 -origin {184.485 1258.37}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 16.1 -origin {194.555 899.38}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 8 -route_type pg_macro_io_pin_conn -length 8.24 -origin {181.5 1373.375}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 8 -route_type pg_macro_io_pin_conn -length 330.4 -origin {184.07 1373.17}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 20.475 -origin {180.82 1780.5}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 18.965 -origin {194.735 1780.5}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 20.475 -origin {180.82 1759.475}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 18.965 -origin {194.735 1759.475}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 20.475 -origin {180.82 1478.55}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 18.965 -origin {194.735 1478.55}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 20.475 -origin {180.82 1457.525}
create_net_shape -no_snap -type wire -net VSS_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 18.965 -origin {194.735 1457.525}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 26.625 -origin {180.82 1678.55}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 19.055 -origin {200.885 1678.55}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 26.625 -origin {180.82 1636.5}
create_net_shape -no_snap -type wire -net VDD_DIG_SW -layer M5 -datatype 0 -path_type 0 -width 10 -route_type pg_macro_io_pin_conn -length 19.055 -origin {200.885 1636.5}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 1 -route_type pg_macro_io_pin_conn -length 24.945 -origin {532.45 896.055}
create_net_shape -no_snap -type wire -net IOBUF_YA[6] -layer M2 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 4.1 -origin {778.165 1454.395}
create_net_shape -no_snap -type wire -net IOBUF_YA[6] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 453.99 -origin {778.165 1647.79}
create_net_shape -no_snap -type wire -net IOBUF_YA[6] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 635.25 -origin {1232.155 2311.275}
create_net_shape -no_snap -type wire -net IOBUF_YA[6] -layer M3 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 0.82 -origin {1867.32 2316.81}
create_net_shape -no_snap -type wire -net IOBUF_YA[7] -layer M3 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 1.08 -origin {1771.385 2318.675}
create_net_shape -no_snap -type wire -net IOBUF_YA[7] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 540.53 -origin {1230.925 2313.085}
create_net_shape -no_snap -type wire -net IOBUF_YA[7] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 453.99 -origin {776.935 1649.43}
create_net_shape -no_snap -type wire -net IOBUF_YA[7] -layer M2 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 5.33 -origin {776.935 1452.485}
create_net_shape -no_snap -type wire -net IOBUF_YA[8] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 446.855 -origin {1229.695 2314.52}
create_net_shape -no_snap -type wire -net IOBUF_YA[8] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 453.99 -origin {775.705 1651.07}
create_net_shape -no_snap -type wire -net IOBUF_YA[8] -layer M2 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 6.53 -origin {775.705 1450.545}
create_net_shape -no_snap -type wire -net IOBUF_YA[9] -layer M3 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 1.575 -origin {1580.95 2318.21}
create_net_shape -no_snap -type wire -net IOBUF_YA[9] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 352.99 -origin {1228.055 2316.16}
create_net_shape -no_snap -type wire -net IOBUF_YA[9] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 453.58 -origin {774.475 1652.71}
create_net_shape -no_snap -type wire -net IOBUF_YA[9] -layer M3 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 3.28 -origin {774.475 1456.525}
create_net_shape -no_snap -type wire -net IOBUF_YA[9] -layer M2 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 4.375 -origin {777.755 1456.525}
create_net_shape -no_snap -type wire -net IOBUF_YA[10] -layer M3 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 1.195 -origin {1486.32 2318.62}
create_net_shape -no_snap -type wire -net IOBUF_YA[10] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 260 -origin {1226.415 2317.39}
create_net_shape -no_snap -type wire -net IOBUF_YA[10] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 453.17 -origin {773.245 1654.35}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 1 -route_type pg_macro_io_pin_conn -length 11.59 -origin {469.37 895.895}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M3 -datatype 0 -path_type 2 -width 1 -route_type pg_macro_io_pin_conn -length 13.5 -origin {469.37 892.615}
create_net_shape -no_snap -type wire -net IOBUF_YA[10] -layer M3 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 4.33 -origin {773.245 1458.45}
create_net_shape -no_snap -type wire -net IOBUF_YA[10] -layer M2 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 4.625 -origin {777.56 1458.45}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.12 -origin {1491.14 2102.91}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 5.745 -origin {1485.895 2119.305}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 3.5 -origin {1490.74 2119.305}
create_net_shape -no_snap -type wire -net IOBUF_YA[8] -layer M3 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 1.08 -origin {1676.465 2318.675}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 9.455 -origin {772.87 1221.69}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 9.55 -origin {772.795 1223.69}
create_net_shape -no_snap -type wire -net VREF0P8 -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 831.83 -origin {194.655 1855.955}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.345 -origin {755.205 1263.86}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.345 -origin {755.205 1258.12}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.345 -origin {755.205 1203.44}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 19.345 -origin {755.205 1197.7}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 45.24 -origin {1068.855 1637.13}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 45.24 -origin {1068.855 1631.39}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 80 -origin {1283.805 1721.59}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 80 -origin {1283.805 1715.85}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 12.35 -origin {1474.755 2117.65}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 12.35 -origin {1474.755 2111.91}
create_net_shape -no_snap -type wire -net VSS_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 92.71 -origin {1121.335 2264.43}
create_net_shape -no_snap -type wire -net VDD_DIG_AO -layer M5 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 92.71 -origin {1121.335 2258.69}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 1391.11 -origin {210.76 902}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 1383.73 -origin {217 902}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 18.245 -origin {210.56 881.135}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 956.615 -origin {194.655 899.345}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 1.435 -origin {184.485 1256.935}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 15.1 -origin {469.37 881.295}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 15.225 -origin {556.965 881.295}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 18.125 -origin {532.45 895.235}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 18.125 -origin {480.96 895.235}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 21.43 -origin {482.87 891.955}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 34.275 -origin {700.7 881.295}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 34.275 -origin {698.7 881.295}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[10] -layer M2 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 1.1 -origin {1487.515 2318.62}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[10] -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 1.23 -origin {1486.32 2317.39}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[10] -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 53.04 -origin {1226.415 2256.37}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[10] -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 2.345 -origin {773.245 1458.45}
create_net_shape -no_snap -type wire -vertical -net VSSIO -layer M3 -datatype 0 -path_type 2 -width 18.74 -route_type signal_route -length 20.5 -origin {39.345 890.315}
create_net_shape -no_snap -type wire -vertical -net DVDD_1P5_ANA -layer M3 -datatype 0 -path_type 2 -width 5 -route_type pg_macro_io_pin_conn -length 10.985 -origin {200.75 883.55}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 6.305 -origin {591.965 881.13}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 32.04 -origin {591.965 882.525}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[6] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 193.52 -origin {778.165 1454.27}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[8] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 200.6 -origin {775.705 1450.47}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[7] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 196.945 -origin {776.935 1452.485}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[10] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 193.635 -origin {773.245 1460.715}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[9] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 196.425 -origin {774.475 1456.285}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[6] -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 31.495 -origin {1232.155 2256.37}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[6] -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 5.535 -origin {1867.32 2311.275}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[6] -layer M2 -datatype 0 -path_type 2 -width 0.2 -route_type user_enter -length 2.805 -origin {1867.54 2316.925}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[7] -layer M2 -datatype 0 -path_type 2 -width 0.2 -route_type user_enter -length 1.275 -origin {1772.465 2318.675}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[7] -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 5.59 -origin {1771.385 2313.085}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[7] -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 53.04 -origin {1230.925 2256.37}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[9] -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 1.435 -origin {774.475 1455.91}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[9] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 603.66 -origin {1228.055 1652.71}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 23.89 -origin {1287.055 1701.96}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[9] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 6.78 -origin {1228.055 2309.38}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[6] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 608.58 -origin {1232.155 1647.79}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[6] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 23.41 -origin {1232.155 2287.865}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[10] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 602.02 -origin {1226.415 1654.35}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[10] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 8.01 -origin {1226.415 2309.38}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[7] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 606.94 -origin {1230.925 1649.43}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[7] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 3.705 -origin {1230.925 2309.38}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[8] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 605.3 -origin {1229.695 1651.07}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[8] -layer M5 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 5.14 -origin {1229.695 2309.38}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[8] -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 53.04 -origin {1229.695 2256.37}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[9] -layer M2 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 1.48 -origin {1582.525 2318.21}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[9] -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 2.05 -origin {1580.95 2316.16}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[9] -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 53.04 -origin {1228.055 2256.37}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 9 -route_type pg_macro_io_pin_conn -length 21.54 -origin {699.075 1862.205}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 9 -route_type pg_macro_io_pin_conn -length 21.05 -origin {715.575 1862.695}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 11.92 -origin {558.965 881.295}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 21.43 -origin {530.525 891.955}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 34.8 -origin {744.6 881.295}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 34.68 -origin {742.6 881.295}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 23.345 -origin {1324.855 1701.705}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 11.82 -origin {471.37 881.295}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M3 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 6.305 -origin {551.965 881.13}
create_net_shape -no_snap -type wire -vertical -net DVDD_1P5_ANA -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 160.145 -origin {185.925 892.035}
create_net_shape -no_snap -type wire -vertical -net POC -layer M3 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 1.23 -origin {538.005 881.295}
create_net_shape -no_snap -type wire -vertical -net POC -layer M3 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 2.24 -origin {149.55 919.36}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 17 -route_type pg_macro_io_pin_conn -length 281.015 -origin {231.5 881.17}
create_net_shape -no_snap -type wire -vertical -net POC -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 8.47 -origin {538.005 882.525}
create_net_shape -no_snap -type wire -vertical -net POC -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 28.46 -origin {150.045 890.9}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M3 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 7.65 -origin {323.62 2312.255}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AFSW -layer M4 -datatype 0 -path_type 0 -width 20 -route_type pg_macro_io_pin_conn -length 688.21 -origin {255 881.11}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 16.485 -origin {283.9 881.135}
create_net_shape -no_snap -type wire -vertical -net VPP -layer M2 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 13.275 -origin {894.465 1870.06}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 50.065 -origin {323.62 2266.815}
create_net_shape -no_snap -type wire -vertical -net VPP -layer M4 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 5.685 -origin {188.115 1842.13}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 580.085 -origin {226.385 1691.86}
create_net_shape -no_snap -type wire -vertical -net VPP -layer M4 -datatype 0 -path_type 2 -width 3 -route_type user_enter -length 27.12 -origin {894.465 1843.77}
create_net_shape -no_snap -type wire -vertical -net VDDIO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 803.33 -origin {283.9 893.53}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 32.04 -origin {551.965 882.525}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_macro_io_pin_conn -length 730.97 -origin {272.635 1141.42}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M5 -datatype 0 -path_type 2 -width 0.58 -route_type user_enter -length 0.53 -origin {210.56 881.34}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M3 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 5.96 -origin {511.965 881.295}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 5 -route_type pg_macro_io_pin_conn -length 495.055 -origin {511.965 882.115}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_macro_io_pin_conn -length 503.22 -origin {279.605 1369.17}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 1405.87 -origin {198.28 902}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_SW -layer M4 -datatype 0 -path_type 0 -width 6 -route_type pg_ring -length 1398.49 -origin {204.52 902}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[8] -layer M2 -datatype 0 -path_type 2 -width 0.2 -route_type user_enter -length 1.275 -origin {1677.545 2318.675}
create_net_shape -no_snap -type wire -vertical -net IOBUF_YA[8] -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 4.195 -origin {1676.465 2314.48}
create_net_shape -no_snap -type wire -vertical -net VSS_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 20.485 -origin {1078.775 1619.915}
create_net_shape -no_snap -type wire -vertical -net VDD_DIG_AO -layer M2 -datatype 0 -path_type 0 -width 1 -route_type pg_macro_io_pin_conn -length 20.11 -origin {1107.98 1619.93}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M4 -datatype 0 -path_type 2 -width 0.4 -route_type user_enter -length 25.355 -origin {1026.485 1855.95}
create_net_shape -no_snap -type wire -vertical -net u_top_dig/flash_ctrl_top_inst/n4 -layer M2 -datatype 0 -path_type 2 -width 0.2 -route_type signal_route -length 1.89 -origin {1026.47 1881.085}
create_net_shape -no_snap -type wire -vertical -net VREF0P8 -layer M3 -datatype 0 -path_type 2 -width 0.2 -route_type signal_route -length 0.17 -origin {1026.47 1881.21}
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {1491.19 2119.305} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {1491.605 2102.91} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_AFSW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {186.995 1559.06} -orient N -col 23 -row 49 -x_pitch 0.41 -y_pitch 0.41
create_via -no_snap -type via_array -net VDD_DIG_AFSW -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {186.995 1559.06} -orient N -col 13 -row 28 -x_pitch 0.72 -y_pitch 0.72
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {186.905 1373.375} -orient W -col 19 -row 19 -x_pitch 0.42 -y_pitch 0.42
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {186.905 1373.17} -orient W -col 11 -row 11 -x_pitch 0.74 -y_pitch 0.75
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {279.605 1373.17} -orient N -col 8 -row 11 -x_pitch 0.77 -y_pitch 0.75
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {511.965 884.985} -orient W -col 12 -row 12 -x_pitch 0.42 -y_pitch 0.42
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {511.965 1373.17} -orient N -col 7 -row 11 -x_pitch 0.73 -y_pitch 0.75
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {532.45 896.055} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {556.975 896.055} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {480.96 896.055} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {226.385 1694.36} -orient N -col 7 -row 7 -x_pitch 0.73 -y_pitch 0.75
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {226.385 2269.33} -orient N -col 7 -row 7 -x_pitch 0.73 -y_pitch 0.75
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {283.9 1694.36} -orient N -col 7 -row 7 -x_pitch 0.73 -y_pitch 0.75
create_via -no_snap -type via_array -net VDDIO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {323.62 2269.335} -orient N -col 7 -row 7 -x_pitch 0.73 -y_pitch 0.75
create_via -no_snap -type via_array -net VDDIO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {323.62 2314.565} -orient W -col 12 -row 12 -x_pitch 0.42 -y_pitch 0.42
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {591.965 884.985} -orient W -col 12 -row 12 -x_pitch 0.42 -y_pitch 0.42
create_via -no_snap -type via_array -net VPP -master MV2_0_VH_F0 -route_type user_enter -at {894.465 1870.475} -orient W -col 7 -row 7 -x_pitch 0.45 -y_pitch 0.45
create_via -no_snap -type via_array -net VPP -master MV3_0_HV_F0 -route_type user_enter -at {894.465 1870.475} -orient W -col 7 -row 7 -x_pitch 0.45 -y_pitch 0.45
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {198.28 2304.37} -orient N -col 8 -row 10 -x_pitch 0.77 -y_pitch 0.72
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {210.76 2289.61} -orient N -col 8 -row 10 -x_pitch 0.77 -y_pitch 0.72
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {204.52 2296.99} -orient N -col 8 -row 10 -x_pitch 0.77 -y_pitch 0.72
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {217 2282.23} -orient N -col 8 -row 10 -x_pitch 0.77 -y_pitch 0.72
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {187.765 1151.975} -orient N -col 13 -row 28 -x_pitch 0.75 -y_pitch 0.72
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {231.635 1373.17} -orient N -col 7 -row 11 -x_pitch 0.73 -y_pitch 0.75
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {511.965 911.43} -orient N -col 7 -row 7 -x_pitch 0.73 -y_pitch 0.75
create_via -no_snap -type via_array -net VPP -master MV4_0_VH_F0 -route_type user_enter -at {188.175 1843.77} -orient N -col 4 -row 4 -x_pitch 0.8 -y_pitch 0.84
create_via -no_snap -type via_array -net VPP -master MV4_0_VH_F0 -route_type user_enter -at {894.605 1843.77} -orient N -col 4 -row 4 -x_pitch 0.8 -y_pitch 0.84
create_via -no_snap -type via_array -net VPP -master MV3_0_HV_F0 -route_type user_enter -at {188.175 1847.745} -orient N -col 7 -row 7 -x_pitch 0.45 -y_pitch 0.45
create_via -no_snap -type via_array -net VSS_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {469.37 895.895} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {471.37 892.615} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {482.87 892.365} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net DVDD_1P5_ANA -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {185.925 894.535} -orient N -col 12 -row 12 -x_pitch 0.42 -y_pitch 0.42
create_via -no_snap -type via_array -net DVDD_1P5_ANA -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {185.925 1049.47} -orient N -col 12 -row 12 -x_pitch 0.42 -y_pitch 0.42
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {231.5 1151.825} -orient N -col 24 -row 28 -x_pitch 0.71 -y_pitch 0.72
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {272.635 1151.825} -orient N -col 8 -row 28 -x_pitch 0.77 -y_pitch 0.72
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {530.525 892.365} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV2_0_VH_F0 -route_type pg_macro_io_pin_conn -at {558.965 892.365} -orient N -col 2 -row 2 -x_pitch 0.71 -y_pitch 0.71
create_via -no_snap -type via_array -net VDD_DIG_AFSW -master MV4_0_VH_F0 -route_type pg_macro_io_pin_conn -at {255 1559.06} -orient N -col 28 -row 28 -x_pitch 0.71 -y_pitch 0.72
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_ring -at {204.48 1636.5} -orient N -col 14 -row 24 -x_pitch 0.43 -y_pitch 0.42
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {204.48 1636.5} -orient N -col 8 -row 14 -x_pitch 0.77 -y_pitch 0.73
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_ring -at {204.48 1678.55} -orient N -col 14 -row 24 -x_pitch 0.43 -y_pitch 0.42
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {204.48 1678.55} -orient N -col 8 -row 14 -x_pitch 0.77 -y_pitch 0.73
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_ring -at {204.52 1636.5} -orient N -col 14 -row 24 -x_pitch 0.43 -y_pitch 0.42
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {204.52 1636.5} -orient N -col 8 -row 14 -x_pitch 0.77 -y_pitch 0.73
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_ring -at {204.52 1678.55} -orient N -col 14 -row 24 -x_pitch 0.43 -y_pitch 0.42
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {204.52 1678.55} -orient N -col 8 -row 14 -x_pitch 0.77 -y_pitch 0.73
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {216.97 1636.5} -orient N -col 8 -row 14 -x_pitch 0.77 -y_pitch 0.73
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {216.97 1678.55} -orient N -col 8 -row 14 -x_pitch 0.77 -y_pitch 0.73
create_via -no_snap -type via_array -net VDD_DIG_SW -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {551.965 884.985} -orient W -col 12 -row 12 -x_pitch 0.42 -y_pitch 0.42
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_ring -at {198.28 1457.525} -orient N -col 14 -row 24 -x_pitch 0.43 -y_pitch 0.42
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {198.28 1457.525} -orient N -col 8 -row 14 -x_pitch 0.77 -y_pitch 0.73
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_ring -at {198.28 1478.55} -orient N -col 14 -row 24 -x_pitch 0.43 -y_pitch 0.42
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {198.28 1478.55} -orient N -col 8 -row 14 -x_pitch 0.77 -y_pitch 0.73
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_ring -at {198.28 1759.475} -orient N -col 14 -row 24 -x_pitch 0.43 -y_pitch 0.42
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {198.28 1759.475} -orient N -col 8 -row 14 -x_pitch 0.77 -y_pitch 0.73
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV3_0_HV_F0 -route_type pg_ring -at {198.28 1780.5} -orient N -col 14 -row 24 -x_pitch 0.43 -y_pitch 0.42
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {198.28 1780.5} -orient N -col 8 -row 14 -x_pitch 0.77 -y_pitch 0.73
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {210.73 1457.525} -orient N -col 8 -row 14 -x_pitch 0.77 -y_pitch 0.73
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {210.73 1478.55} -orient N -col 8 -row 14 -x_pitch 0.77 -y_pitch 0.73
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {210.73 1759.475} -orient N -col 8 -row 14 -x_pitch 0.77 -y_pitch 0.73
create_via -no_snap -type via_array -net VSS_DIG_SW -master MV4_0_VH_F0 -route_type pg_ring -at {210.73 1780.5} -orient N -col 8 -row 14 -x_pitch 0.77 -y_pitch 0.73
create_via -no_snap -type via_array -net VDD_DIG_AO -master MV3_0_HV_F0 -route_type pg_macro_io_pin_conn -at {187.765 1151.975} -orient N -col 23 -row 49 -x_pitch 0.42 -y_pitch 0.41
create_via -no_snap -type via -net POC -master MV3_0_HV_F0 -route_type user_enter -at {150.045 919.36} -orient N
create_via -no_snap -type via -net POC -master MV4_0_VH_F0 -route_type user_enter -at {150.045 890.93} -orient N
create_via -no_snap -type via -net POC -master MV3_0_HV_F0 -route_type user_enter -at {538.005 882.525} -orient N
create_via -no_snap -type via -net POC -master MV4_0_VH_F0 -route_type user_enter -at {538.005 890.93} -orient N
create_via -no_snap -type via -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {210.56 899.38} -orient N
create_via -no_snap -type via -net VREF0P8 -master MV3_0_HV_F0 -route_type user_enter -at {184.485 1256.935} -orient N
create_via -no_snap -type via -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {184.485 1258.37} -orient N
create_via -no_snap -type via -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {194.655 899.38} -orient N
create_via -no_snap -type via -net IOBUF_YA[8] -master MV4_0_VH_F0 -route_type user_enter -at {1229.695 2309.38} -orient N
create_via -no_snap -type via -net IOBUF_YA[6] -master MV4_0_VH_F0 -route_type user_enter -at {1867.32 2311.275} -orient N
create_via -no_snap -type via -net IOBUF_YA[6] -master MV3_0_HV_F0 -route_type user_enter -at {1867.32 2316.81} -orient N
create_via -no_snap -type via -net IOBUF_YA[6] -master MV2_0_VH_F0 -route_type user_enter -at {1867.54 2316.81} -orient N
create_via -no_snap -type via -net IOBUF_YA[7] -master MV2_0_VH_F0 -route_type user_enter -at {1772.465 2318.675} -orient N
create_via -no_snap -type via -net IOBUF_YA[7] -master MV3_0_HV_F0 -route_type user_enter -at {1771.385 2318.675} -orient N
create_via -no_snap -type via -net IOBUF_YA[7] -master MV4_0_VH_F0 -route_type user_enter -at {1771.385 2313.085} -orient N
create_via -no_snap -type via -net IOBUF_YA[9] -master MV2_0_VH_F0 -route_type user_enter -at {1582.525 2318.21} -orient N
create_via -no_snap -type via -net IOBUF_YA[9] -master MV3_0_HV_F0 -route_type user_enter -at {1580.95 2318.21} -orient N
create_via -no_snap -type via -net IOBUF_YA[9] -master MV4_0_VH_F0 -route_type user_enter -at {1580.95 2316.16} -orient N
create_via -no_snap -type via -net IOBUF_YA[7] -master MV3_0_HV_F0 -route_type user_enter -at {776.935 1452.485} -orient N
create_via -no_snap -type via -net IOBUF_YA[7] -master MV4_0_VH_F0 -route_type user_enter -at {776.935 1452.485} -orient N
create_via -no_snap -type via -net IOBUF_YA[8] -master MV3_0_HV_F0 -route_type user_enter -at {775.705 1450.545} -orient N
create_via -no_snap -type via -net IOBUF_YA[8] -master MV4_0_VH_F0 -route_type user_enter -at {775.705 1450.545} -orient N
create_via -no_snap -type via -net IOBUF_YA[6] -master MV3_0_HV_F0 -route_type user_enter -at {778.165 1454.395} -orient N
create_via -no_snap -type via -net IOBUF_YA[6] -master MV4_0_VH_F0 -route_type user_enter -at {778.165 1454.395} -orient N
create_via -no_snap -type via -net IOBUF_YA[9] -master MV4_0_VH_F0 -route_type user_enter -at {774.475 1457.55} -orient N
create_via -no_snap -type via -net IOBUF_YA[9] -master MV3_0_HV_F0 -route_type user_enter -at {774.475 1456.525} -orient N
create_via -no_snap -type via -net IOBUF_YA[10] -master MV2_0_VH_F0 -route_type user_enter -at {1487.515 2318.62} -orient N
create_via -no_snap -type via -net IOBUF_YA[10] -master MV3_0_HV_F0 -route_type user_enter -at {1486.32 2318.62} -orient N
create_via -no_snap -type via -net IOBUF_YA[9] -master MV4_0_VH_F0 -route_type user_enter -at {1228.055 2309.38} -orient N
create_via -no_snap -type via -net IOBUF_YA[10] -master MV4_0_VH_F0 -route_type user_enter -at {1486.32 2317.39} -orient N
create_via -no_snap -type via -net IOBUF_YA[6] -master MV4_0_VH_F0 -route_type user_enter -at {1232.155 2287.865} -orient N
create_via -no_snap -type via -net IOBUF_YA[10] -master MV4_0_VH_F0 -route_type user_enter -at {773.245 1460.705} -orient N
create_via -no_snap -type via -net IOBUF_YA[10] -master MV3_0_HV_F0 -route_type user_enter -at {773.245 1458.45} -orient N
create_via -no_snap -type via -net IOBUF_YA[10] -master MV4_0_VH_F0 -route_type user_enter -at {1226.415 2309.38} -orient N
create_via -no_snap -type via -net IOBUF_YA[7] -master MV4_0_VH_F0 -route_type user_enter -at {1230.925 2309.38} -orient N
create_via -no_snap -type via -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {210.56 881.34} -orient N
create_via -no_snap -type via -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {194.655 1258.37} -orient N
create_via -no_snap -type via -net IOBUF_YA[6] -master MV2_0_VH_F0 -route_type user_enter -at {778.165 1454.395} -orient N
create_via -no_snap -type via -net IOBUF_YA[6] -master MV3_0_HV_F0 -route_type user_enter -at {778.165 1454.395} -orient N
create_via -no_snap -type via -net IOBUF_YA[6] -master MV4_0_VH_F0 -route_type user_enter -at {778.165 1454.395} -orient N
create_via -no_snap -type via -net IOBUF_YA[9] -master MV2_0_VH_F0 -route_type user_enter -at {777.755 1456.525} -orient N
create_via -no_snap -type via -net IOBUF_YA[7] -master MV2_0_VH_F0 -route_type user_enter -at {776.935 1452.425} -orient N
create_via -no_snap -type via -net IOBUF_YA[7] -master MV3_0_HV_F0 -route_type user_enter -at {776.935 1452.425} -orient N
create_via -no_snap -type via -net IOBUF_YA[7] -master MV4_0_VH_F0 -route_type user_enter -at {776.935 1452.425} -orient N
create_via -no_snap -type via -net IOBUF_YA[8] -master MV2_0_VH_F0 -route_type user_enter -at {775.705 1450.545} -orient N
create_via -no_snap -type via -net IOBUF_YA[8] -master MV3_0_HV_F0 -route_type user_enter -at {775.705 1450.545} -orient N
create_via -no_snap -type via -net IOBUF_YA[8] -master MV4_0_VH_F0 -route_type user_enter -at {775.705 1450.545} -orient N
create_via -no_snap -type via -net IOBUF_YA[10] -master MV2_0_VH_F0 -route_type user_enter -at {777.565 1458.45} -orient N
create_via -no_snap -type via -net IOBUF_YA[8] -master MV2_0_VH_F0 -route_type user_enter -at {1677.545 2318.675} -orient N
create_via -no_snap -type via -net IOBUF_YA[8] -master MV3_0_HV_F0 -route_type user_enter -at {1676.465 2318.675} -orient N
create_via -no_snap -type via -net IOBUF_YA[8] -master MV4_0_VH_F0 -route_type user_enter -at {1676.465 2314.52} -orient N
create_via -no_snap -type via -net VREF0P8 -master MV4_0_VH_F0 -route_type user_enter -at {1026.485 1855.955} -orient N
create_via -no_snap -type via -net VREF0P8 -master MV3_0_HV_F0 -route_type signal_route -at {1026.47 1881.205} -orient N
