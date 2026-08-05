##############################################################
# Checkerboard Partial Blockages (ICC version)
##############################################################
proc add_checkerboard_blkgs {args} {
   # Argument check
   if {[llength $args] != 1} {
       puts "USAGE: add_checkerboard_blkgs <tile_size blocked_percentage>"
       return
   }
   set params [lindex $args 0]
   if {[llength $params] != 2} {
       puts "USAGE: add_checkerboard_blkgs <tile_size blocked_percentage>"
       return
   }
   lassign $params tile blocked_pct
   # Get core area coordinates
   set core_bbox [get_attribute [get_core_area] bbox]
   lassign $core_bbox lx uy
   lassign $lx llx lly
   lassign $uy urx ury
   # Grid loop
   set x $llx
   while {$x < $urx} {
       set y $lly
       while {$y < $ury} {
           set x2 [expr {min($x + $tile, $urx)}]
           set y2 [expr {min($y + $tile, $ury)}]
           # Create partial placement blockage
           create_placement_blockage \
               -type partial \
               -blocked_percentage $blocked_pct \
               -bbox [list [list $x $y] [list $x2 $y2]]
           set y [expr {$y + $tile}]
       }
       set x [expr {$x + $tile}]
   }

   # macro bboxes
   set macro_boxes {}
   foreach m [get_flat_cells -filter "is_hard_macro==true"] {
       set b [get_attribute $m boundary]
   }  
  foreach c $b {
  set ub [get_placement_blockages -within $c -filter name=~PB*]
  remove_placement_blockage $ub
  }
 puts "INFO: Uniform blockages created with tile=$tile and blocked_pct=$blocked_pct%"
}
