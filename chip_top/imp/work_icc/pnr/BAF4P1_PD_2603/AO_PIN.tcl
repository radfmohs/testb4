set CLK {
    */A2D_OSC_OUT
    */A2D_external_clock_I*
    */A2D_external_en_I*
}

set AO {
*/A2D_OSC_OUT
*/A2D_external_clock_I*
*/A2D_SW_POWER_POR*
*/A2D_VDDI_POR*
*/A2D_Wake_UP_i*
*/A2D_external_RESET*
*/A2D_external_en_I*
*/A2D_LOFF_STATN*
*/A2D_LOFF_STATP*
*/A2D_ACLEADOFF*
*/D2A_BIST_EN*
*/D2A_OSC_TRIM*
*/D2A_LDO1V5_VTRIM*
*/D2A_BGH_CTRIM*
*/D2A_BIST_ISEL*
*/D2A_SDM_VIN_SEL*
*/D2A_BGH_VTRIM*
*/D2A_ATM*
*/D2A_EN_PPG_SH*
*/D2A_TIA*
*/D2A_EN_PPG*
*/D2A_PPG*
*/D2A_TSC*
*/D2A_DCLEADOFF*
*/D2A_LED*
*/D2A_RLD_AMP*
*/D2A_VCM1P5_*
*/D2A_PDVREF*
*/D2A_ECGCAL*
*/D2A_ACLEADOFF*
*/D2A_OSC_ISEL*
*/D2A_EN_TIA*
*/D2A_ECG_DDA_CLKSEL*
*/D2A_ECG_DDA_EN*
*/D2A_ECG_DDA_GSEL*
*/D2A_ECG_DDACHOP_EN*
*/D2A_ECG_DDA_ISEL*
*/D2A_ECG_PGA_EN*
*/D2A_ECG_LPF_EN*
*/D2A_ECG_PGA_GSEL*
}

set PCLK [get_flat_pins $CLK]
set PAO [get_flat_pins $AO]

if {[sizeof_col [get_flat_cells -q *ANA_BUF*]]!=0} {return}

set cmd {}
set cnt 0
foreach_in_col p $PAO {
    set chk  [get_flat_pins -q -filter full_name=~top_dig_always_on_inst/* -of [get_nets -of $p]]
    if {[sizeof_col $chk]==0} {continue}
    incr cnt
    
    ## ANA_BUF
    set center [get_att $p center]
    set name  [get_att $p full_name]
    set type  [get_att [get_nets -of $p] net_type]
    set i "insert_buffer -new_net_names n_ANA_BUF_${cnt} -new_cell_names ANA_BUF_${cnt} -location {$center} \[get_pins {$name}\] BUFX8M"
    
    ## CLK BUF
    if {$name=="u_top_ana/A2D_OSC_OUT"} {
        set new_cel "ANA_BUF_CK_${cnt}_1 ANA_BUF_CK_${cnt}_2 ANA_BUF_CK_${cnt}_3 ANA_BUF_CK_${cnt}_4 "
        set new_net "n_ANA_BUF_CK_${cnt}_1 n_ANA_BUF_CK_${cnt}_2 n_ANA_BUF_CK_${cnt}_3 n_ANA_BUF_CK_${cnt}_4 "
        set center  "715.230 848.660  484.400 848.660 226.510 1244.720  227.330 1709.660"
        set i "insert_buffer -no_of_cells 4 -new_net_names {$new_net} -new_cell_names {$new_cel} -location {$center} \[get_pins {$name}\] CLKBUFX8M"
    }
    if {$name=="u_top_ana/A2D_external_clock_I"} {
        set new_cel "ANA_BUF_CK_${cnt}_1 ANA_BUF_CK_${cnt}_2 ANA_BUF_CK_${cnt}_3"
        set new_net "n_ANA_BUF_CK_${cnt}_1 n_ANA_BUF_CK_${cnt}_2 n_ANA_BUF_CK_${cnt}_3"
        set center  "522.530 848.660  226.510 1267.680  235.940 1715.400"
        set i "insert_buffer -no_of_cells 3 -new_net_names {$new_net} -new_cell_names {$new_cel} -location {$center} \[get_pins {$name}\] CLKBUFX8M"
    }
    if {$name=="u_top_ana/A2D_external_en_I"} {
        set new_cel "ANA_BUF_CK_${cnt}_1 ANA_BUF_CK_${cnt}_2 ANA_BUF_CK_${cnt}_3"
        set new_net "n_ANA_BUF__${cnt}_1 n_ANA_BUF_CK_${cnt}_2 n_ANA_BUF_CK_${cnt}_3"
        set center  "521.710 842.920 227.330 1279.160 251.520 1709.660"
        set i "insert_buffer -no_of_cells 3 -new_net_names {$new_net} -new_cell_names {$new_cel} -location {$center} \[get_pins {$name}\] CLKBUFX8M"
    }
    lappend cmd $i
    #eval $i
    
}
foreach x $cmd {eval $x}

#set_attribute [get_placement_blockages AO_BUF*] type {soft}
set_keepout_margin -outer {1 0 1 0} BUFX8M -type hard
set_att  [get_flat_cells *ANA_BUF_CK*]  is_fixed   true
magnet_placement -mark_soft_fixed  -cells [get_flat_cells ANA_BUF*]  [get_cells u_top_ana]
legalize_placement -cells [get_flat_cells ANA_BUF*]
set_att  [get_flat_cells *ANA_*BUF*]   dont_touch true
set_att  [get_flat_cells *ANA_*BUF*]  is_fixed   true
set_att  [get_nets -segment -of [get_flat_cells *ANA_*BUF*]]   dont_touch true
#move_objects -delta "0 0" -ignore_fixed [get_cells -hierarchical ANA_BUF_CK*]
remove_keepout_margin BUFX8M
set AO_spare {
*/D2A_SPARE_TRIM_SW1*
}
set PAO [get_flat_pins $AO_spare]

set cmd {}
set cnt 0
foreach_in_col p $PAO {
    set chk  [get_flat_pins -q -of [get_nets -of $p]]
    if {[sizeof_col $chk]==0} {continue}
    incr cnt
    
    ## ANA_BUF
    set center [get_att $p center]
    set name  [get_att $p full_name]
    set type  [get_att [get_nets -of $p] net_type]
    set i "insert_buffer -new_net_names n_ANA_BUF_spare_${cnt} -new_cell_names ANA_BUF_spare_${cnt} -location {$center} \[get_pins {$name}\] BUFX3M"
    lappend cmd $i
    #eval $i
    
}
foreach x $cmd {eval $x}
source -e -v ./ao_spare_FP.tcl
set_att  [get_flat_cells *ANA_*BUF*]   dont_touch true
set_att  [get_flat_cells *ANA_*BUF*]  is_fixed   true
set_att  [get_nets -segment -of [get_flat_cells *ANA_*BUF*]]   dont_touch true


