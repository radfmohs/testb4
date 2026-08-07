# PD_SW +20%: ana dig-facing keepouts pulled back 70um; left VA=198 for PG rings
create_placement_blockage -coordinate {{0.000 0.000} {2500.000 679.500}} -name hard_ana1 -type hard
create_placement_blockage -coordinate {{278.000 679.500} {2500.000 835.000}} -name hard_ana2 -type hard
create_placement_blockage -coordinate {{844.730 834.550} {2500.000 1242.590}} -name hard_ana3 -type hard
create_placement_blockage -coordinate {{954.550 1242.590} {2500.000 1471.420}} -name hard_ana4 -type hard
create_placement_blockage -coordinate {{1106.000 1471.420} {2500.000 1653.240}} -name hard_ana5 -type hard
create_placement_blockage -coordinate {{1282.040 1653.240} {2500.000 2285.000}} -name hard_ana6 -type hard
create_placement_blockage -coordinate {{1959.625 2285.000} {2500.000 2450.000}} -name hard_ana7 -type hard
create_placement_blockage -type hard -bbox {{222.000 1820.020} {1134.315 2232.000}} -name hard_flsh
create_placement_blockage -coordinate {{0.000 679.500} {198.000 2450.000}} -name hard_left_pg_channel -type hard
create_placement_blockage -coordinate {{780 1110} {845 1195}} -name soft_ana_pin_0 -type soft
create_placement_blockage -coordinate {{780 890} {845 935}} -name soft_ana_pin_1 -type soft
create_placement_blockage -coordinate {{710 842.6} {780 855}} -name soft_ana_pin_2 -type soft
create_placement_blockage -coordinate {{490 842.6} {580 852}} -name soft_ana_pin_3 -type soft
create_placement_blockage -coordinate {{1140 1655} {1250 1673}} -name soft_ana_pin_4 -type soft
create_placement_blockage -coordinate {{1200 2205} {1320 2265}} -name soft_ana_pin_5 -type soft
