#get_drc_errors -error_view cali -error_id 29992

#set drcs	[get_drc_errors -error_view drc -f "type=~ANT* && type!=ANT.6"]

set drcs [get_drc_errors -error_view drc -f "type=~ANT.3"]

set out "./ant3.tcl"

set files [open $out w]

puts $files "stop_gui"

set size [sizeof_collection $drcs]
set i 1
gui_stop
foreach_in_collection drc $drcs {
set bbox [get_attribute $drc bbox]
set type [get_attribute $drc type]

set offset 1.2
set golden_net ""
set cell ""

#if {$type=="ANT.3"} {
#	set layer "METAL2"
#} elseif {$type=="ANT.4"} {
#	set layer "METAL2"
#} elseif {$type=="ANT.5"} {
#        set layer "METAL2"
#} 
#elseif {$type=="ANT.6"} {
#        set layer "METAL5"
set layer "METAL2"

#}
### LL
set ll_1 [lindex [lindex $bbox 0] 0]
set urx [expr [lindex [lindex [lindex $bbox 0] 0] 0] + $offset]
set ury [expr [lindex [lindex [lindex $bbox 0] 0] 1] + $offset]
set ur_1 "$urx $ury"
set net1s [get_net_shapes -f "layer==${layer}" -intersect "$ll_1 $ur_1"]


### UL

set llx [expr [lindex [lindex [lindex $bbox 0] 0] 0] + 0]
set lly [expr [lindex [lindex [lindex $bbox 0] 1] 1] - $offset]
set ll_2 "$llx $lly"
set urx [expr [lindex [lindex [lindex $bbox 0] 0] 0] + $offset]
set ury [expr [lindex [lindex [lindex $bbox 0] 1] 1] - 0]
set ur_2 "$urx $ury"
set net2s [get_net_shapes -f "layer==${layer}" -intersect "$ll_2 $ur_2"]


### UR

set ll_3 [lindex [lindex $bbox 0] 1]
set urx [expr [lindex [lindex [lindex $bbox 0] 1] 0] - $offset]
set ury [expr [lindex [lindex [lindex $bbox 0] 1] 1] - $offset]
set ur_3 "$urx $ury"
set net3s [get_net_shapes -f "layer==${layer}" -intersect "$ll_3 $ur_3"]

### LR

set llx [expr [lindex [lindex [lindex $bbox 0] 1] 0] - $offset]
set lly [expr [lindex [lindex [lindex $bbox 0] 0] 1] - 0]
set ll_4 "$llx $lly"
set urx [expr [lindex [lindex [lindex $bbox 0] 1] 0] - 0]
set ury [expr [lindex [lindex [lindex $bbox 0] 0] 1] + $offset]
set ur_4 "$urx $ury"

set net4s [get_net_shapes -f "layer==${layer}" -intersect "$ll_4 $ur_4"]

set net [get_net_shapes -f "layer==${layer}" -within "$bbox"]

if {${net1s}!=""} {
	foreach_in_collection net1 $net1s {
	if {[regexp [get_object_name $net1] [get_object_name $net]]==1} {
		set golden_net [get_object_name $net1]
	}
	}
}
if {${net2s}!=""} {
	foreach_in_collection net2 $net2s {
	if {[regexp [get_object_name $net2] [get_object_name $net]]==1} {
		set golden_net [get_object_name $net2]
	}
	}
}
if {${net3s}!=""} {
	foreach_in_collection net3 $net3s {
	if {[regexp [get_object_name $net3] [get_object_name $net]]==1} {
		set golden_net [get_object_name $net3]
	}
	}
}
if {${net4s}!=""} {
	foreach_in_collection net4 $net4s {
	if {[regexp [get_object_name $net4] [get_object_name $net]]==1} {
		set golden_net [get_object_name $net4]
	}
	}
}


if {$golden_net!=""} {
	set net [get_attribute [get_net_shapes $golden_net] owner_net]
	set out [all_fanout -from [get_nets $net] -flat -only_cells -levels 1]


	foreach_in_collection he $out {
		if {[regexp [get_object_name $he] [get_object_name [get_cells -intersect "$bbox"]]]==1} {
			set cell $he
		}
	}
	set pin [all_fanout -from [get_nets $net] -levels 1 -flat]
	foreach_in_collection hi $pin {
		if {[regexp [get_object_name $cell] [get_object_name $hi]]==1} {
			set pin_diode $hi
		}
	}
	set name [get_attribute [get_pins $pin_diode] name]
	set cell_name [get_attribute [get_cells $cell] full_name]
	if {$cell_name!=""} {
		set cmd "insert_zrt_diodes {{$name $cell_name ANTENNA_A7TULL 1 METAL5 20}}"
		puts $files "$cmd"
		echo "\[Solve $type drc\]: Insert diode ANTENNA_A7TULL at pin $name of cell $cell_name ($i/$size)"
		set i [expr $i + 1]
	}
}
}

puts $files "start_gui"
close $files
gui_start
