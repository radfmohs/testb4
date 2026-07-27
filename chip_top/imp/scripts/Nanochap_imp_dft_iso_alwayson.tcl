
current_design Nanochap_BAF4P1_top_dig_always_on_0


#tmp if {${dc_sel} == "DCT"} {
#tmp     #set v [get_ports * -filter "port_direction == in"]
     set v [get_ports * -filter {port_direction == in && name =~ "test_si*"}]
     
     set index 0
     foreach_in_collection a $v { 
         set name [get_object_name $a]
         set net [get_nets -of [get_port $name]]
         create_cell DNT_ISO_CELL_${index}  sc7_l013_base_rvt_ss_TYP_max_1p35v_125c/AND2X4M
         disconnect_net $net [get_port $name ]
         connect_pin -from [get_port $name]                              -to  DNT_ISO_CELL_$index/A
         connect_net [get_nets wakeup_done]                                   DNT_ISO_CELL_$index/B
         connect_net [get_nets $net]                                          [get_pins DNT_ISO_CELL_$index/Y]
         incr index
     }
#tmp 
#tmp } else {
#tmp 
#tmp     set index 0
#tmp     set port "internal_scan_in"
#tmp     create_cell DNT_ISO_CELL_${index}  sc7_l013_base_rvt_ss_TYP_max_1p35v_125c/AND2X4M
#tmp     set net [get_nets -of [get_port $port]]
#tmp     disconnect_net $net [get_port $port ]
#tmp     connect_pin -from [get_port $port]                              -to  DNT_ISO_CELL_$index/A
#tmp     connect_net [get_nets wakeup_done]                                   DNT_ISO_CELL_$index/B
#tmp     connect_net [get_nets $net]                                          [get_pins DNT_ISO_CELL_$index/Y]
#tmp     
#tmp     set index 1
#tmp     set port "compress_scan_in"
#tmp     create_cell DNT_ISO_CELL_${index}  sc7_l013_base_rvt_ss_TYP_max_1p35v_125c/AND2X4M
#tmp     set net [get_nets -of [get_port $port]]
#tmp     disconnect_net $net [get_port $port ]
#tmp     connect_pin -from [get_port $port]                              -to  DNT_ISO_CELL_$index/A
#tmp     connect_net [get_nets wakeup_done]                                   DNT_ISO_CELL_$index/B
#tmp     connect_net [get_nets $net]                                          [get_pins DNT_ISO_CELL_$index/Y]
#tmp }
##set index 2
##set port "test_se"
###create_cell DNT_ISO_CELL_${index}  sc7_ch018ull_base_rvt_ss_typ_max_1p26v_125c/AND2_X4_A7TULL
##create_cell DNT_ISO_CELL_${index}  sc7_ch018ull_base_rvt_ff_typ_min_1p98v_m40c/AND2_X4_A7TULL
##set net [get_nets -of [get_port $port]]
##disconnect_net $net [get_port $port ]
##connect_pin -from [get_port $port]                              -to  DNT_ISO_CELL_$index/A
##connect_net [get_nets wakeup_done]                                   DNT_ISO_CELL_$index/B
##connect_net [get_nets $net]                                          [get_pins DNT_ISO_CELL_$index/Y]

current_design Nanochap_BAF4P1
