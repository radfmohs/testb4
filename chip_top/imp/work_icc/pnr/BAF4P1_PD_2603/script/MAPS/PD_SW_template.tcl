template : PD_SW_template {
layer : M5 {
	direction :horizontal
	width : 6
	spacing : minimum
	pitch :77.33
	offset_start : boundary	# user can also specify coordinate as {x y}
	offset_type : edge	# user can also specify centerline 
	trim_strap : false
}
layer : M4 {
	direction : vertical
	width : 5
	spacing : minimum
	pitch :81.955
	offset_start : boundary	# user can also specify coordinate as {x y}
	offset_type : edge	# user can also specify centerline 
	trim_strap : false
}
  # Advanced rules for power plan creation
    advanced_rule : off { #all the advanced rules are turned off
	no_vias : off # do not create vias
	optimize_routing_tracks : on {
		layer : all       #layers to perform optimization
		alignment : true  #align straps to track or half-track
		sizing : true     #further size up straps w/o blocking more tracks
	}
	insert_channel_straps: off {
		layer :           #channel strap layer
		width : minimum   #channel strap width
		spacing : minimum #channel strap spacing
		channel_threshold: #ignore channels narrower than the threshold
		check_one_layer : false #only check straps in the specified layer
		boundary_strap : false #insert straps between region boundary
		honor_placement_blockage : true #honor channels between placement blocakges and macros
		honor_voltage_area : false #honor channels between voltage areas and macros
		honor_keepout_margins : true #honor channels between hard keepout margins
	}
	honor_max_stdcell_strap_distance : off {
		max_distance :    #maximum distance from stdcell to strap
		layer :           #additional strap layer
		offset :          #offset to the nearest straps
	}
	align_straps_with_power_switch : off {
		power_switch :    #specify power switch name to align
		layer :           #strap layer
		width :           #strap width
		direction :       #strap direction
		offset :          #offset from the center of pin
	}
	align_straps_with_stdcell_rail: off {
		layer :           #strap layer
		align_with_rail : false     #align strap with the rail
		put_strap_in_row : false    #put straps inside cell row
	}
	honor_advanced_via_rules : off
	align_straps_with_terminal_pin : off
	align_straps_with_physical_cell: off {
		layer :           #strap layer
		cell :            #lib cell to align
		pin :             #pin to align
		direction :       #strap direction
		width :           #strap width
		offset :          #offset from the center of pin
	}
}
