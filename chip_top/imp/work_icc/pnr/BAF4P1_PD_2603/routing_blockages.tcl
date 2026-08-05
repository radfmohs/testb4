set a [get_attribute [get_placement_blockages hard_ana1] bbox]
set b [get_attribute [get_placement_blockages hard_ana2] bbox]
set c [get_attribute [get_placement_blockages hard_ana3] bbox]
set d [get_attribute [get_placement_blockages hard_ana4] bbox]
set e [get_attribute [get_placement_blockages hard_ana5] bbox]
set f [get_attribute [get_placement_blockages hard_ana6] bbox]
set g [get_attribute [get_placement_blockages hard_ana7] bbox]
set h [get_attribute [get_placement_blockages hard_flsh] bbox]
#set i [get_attribute [get_placement_blockages ioright] bbox]

create_routing_blockage -bbox $a -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage  }
create_routing_blockage -bbox $b -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage }
create_routing_blockage -bbox $c -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage via5Blockage metal6Blockage}
create_routing_blockage -bbox $d -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage via5Blockage metal6Blockage}
create_routing_blockage -bbox $e -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage via5Blockage metal6Blockage}
create_routing_blockage -bbox $f -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage via5Blockage metal6Blockage}
create_routing_blockage -bbox $g -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage via5Blockage metal6Blockage}
create_routing_blockage -bbox $h -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage via5Blockage metal6Blockage}
#create_routing_blockage -bbox $i -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage via5Blockage metal6Blockage}
#g create_routing_blockage -bbox {{2288.885 395.400} {5787.510 1115.845}} -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage via5Blockage metal6Blockage}
#create_routing_blockage -bbox $h -layers {metal1Blockage via1Blockage metal2Blockage via2Blockage metal3Blockage via3Blockage metal4Blockage via4Blockage metal5Blockage via5Blockage metal6Blockage}

