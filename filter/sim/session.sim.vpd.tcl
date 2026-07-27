# Begin_DVE_Session_Save_Info
# DVE full session
# Saved on Fri Aug 2 15:56:45 2024
# Designs open: 1
#   V1: sim.vpd
# Toplevel windows open: 2
# 	TopLevel.3
# 	TopLevel.4
#   Source.1: filter_tb_top.filter_chip_1000.u_notch_filter
#   Wave.1: 9 signals
#   Group count = 4
#   Group Group1 signal count = 4
#   Group Group2 signal count = 2
#   Group Group3 signal count = 1
#   Group Group4 signal count = 8
# End_DVE_Session_Save_Info

# DVE version: S-2021.09-SP2_Full64
# DVE build date: Feb 24 2022 21:31:00


#<Session mode="Full" path="/projects/libs/baf4p1/digital_work/DD_BAF4P1_DIG/digital_design/logical/filter/sim/session.sim.vpd.tcl" type="Debug">

gui_set_loading_session_type Post
gui_continuetime_set

# Close design
if { [gui_sim_state -check active] } {
    gui_sim_terminate
}
gui_close_db -all
gui_expr_clear_all

# Close all windows
gui_close_window -type Console
gui_close_window -type Wave
gui_close_window -type Source
gui_close_window -type Schematic
gui_close_window -type Data
gui_close_window -type DriverLoad
gui_close_window -type List
gui_close_window -type Memory
gui_close_window -type HSPane
gui_close_window -type DLPane
gui_close_window -type Assertion
gui_close_window -type CovHier
gui_close_window -type CoverageTable
gui_close_window -type CoverageMap
gui_close_window -type CovDetail
gui_close_window -type Local
gui_close_window -type Stack
gui_close_window -type Watch
gui_close_window -type Group
gui_close_window -type Transaction



# Application preferences
gui_set_pref_value -key app_default_font -value {Helvetica,10,-1,5,50,0,0,0,0,0}
gui_src_preferences -tabstop 8 -maxbits 24 -windownumber 1
#<WindowLayout>

# DVE top-level session


# Create and position top-level window: TopLevel.3

if {![gui_exist_window -window TopLevel.3]} {
    set TopLevel.3 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.3 TopLevel.3
}
gui_show_window -window ${TopLevel.3} -show_state normal -rect {{295 131} {1625 970}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_hide_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_hide_toolbar -toolbar {CopyPaste}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_hide_toolbar -toolbar {TraceInstance}
gui_hide_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}
gui_set_toolbar_attributes -toolbar {Simulator} -dock_state top
gui_set_toolbar_attributes -toolbar {Simulator} -offset 0
gui_show_toolbar -toolbar {Simulator}
gui_set_toolbar_attributes -toolbar {Interactive Rewind} -dock_state top
gui_set_toolbar_attributes -toolbar {Interactive Rewind} -offset 0
gui_show_toolbar -toolbar {Interactive Rewind}
gui_set_toolbar_attributes -toolbar {Testbench} -dock_state top
gui_set_toolbar_attributes -toolbar {Testbench} -offset 0
gui_show_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
set HSPane.1 [gui_create_window -type HSPane -parent ${TopLevel.3} -dock_state left -dock_on_new_line true -dock_extent 463]
catch { set Hier.1 [gui_share_window -id ${HSPane.1} -type Hier] }
gui_set_window_pref_key -window ${HSPane.1} -key dock_width -value_type integer -value 463
gui_set_window_pref_key -window ${HSPane.1} -key dock_height -value_type integer -value -1
gui_set_window_pref_key -window ${HSPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${HSPane.1} {{left 0} {top 0} {width 462} {height 561} {dock_state left} {dock_on_new_line true} {child_hier_colhier 278} {child_hier_coltype 181} {child_hier_colpd 0} {child_hier_col1 0} {child_hier_col2 1} {child_hier_col3 -1}}
set DLPane.1 [gui_create_window -type DLPane -parent ${TopLevel.3} -dock_state left -dock_on_new_line true -dock_extent 483]
catch { set Data.1 [gui_share_window -id ${DLPane.1} -type Data] }
gui_set_window_pref_key -window ${DLPane.1} -key dock_width -value_type integer -value 483
gui_set_window_pref_key -window ${DLPane.1} -key dock_height -value_type integer -value 552
gui_set_window_pref_key -window ${DLPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${DLPane.1} {{left 0} {top 0} {width 482} {height 561} {dock_state left} {dock_on_new_line true} {child_data_colvariable 190} {child_data_colvalue 150} {child_data_coltype 141} {child_data_col1 0} {child_data_col2 1} {child_data_col3 2}}
set DriverLoad.1 [gui_create_window -type DriverLoad -parent ${TopLevel.3} -dock_state bottom -dock_on_new_line false -dock_extent 180]
gui_set_window_pref_key -window ${DriverLoad.1} -key dock_width -value_type integer -value 150
gui_set_window_pref_key -window ${DriverLoad.1} -key dock_height -value_type integer -value 180
gui_set_window_pref_key -window ${DriverLoad.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${DriverLoad.1} {{left 0} {top 0} {width 1330} {height 179} {dock_state bottom} {dock_on_new_line false}}
#### Start - Readjusting docked view's offset / size
set dockAreaList { top left right bottom }
foreach dockArea $dockAreaList {
  set viewList [gui_ekki_get_window_ids -active_parent -dock_area $dockArea]
  foreach view $viewList {
      if {[lsearch -exact [gui_get_window_pref_keys -window $view] dock_width] != -1} {
        set dockWidth [gui_get_window_pref_value -window $view -key dock_width]
        set dockHeight [gui_get_window_pref_value -window $view -key dock_height]
        set offset [gui_get_window_pref_value -window $view -key dock_offset]
        if { [string equal "top" $dockArea] || [string equal "bottom" $dockArea]} {
          gui_set_window_attributes -window $view -dock_offset $offset -width $dockWidth
        } else {
          gui_set_window_attributes -window $view -dock_offset $offset -height $dockHeight
        }
      }
  }
}
#### End - Readjusting docked view's offset / size
gui_sync_global -id ${TopLevel.3} -option true

# MDI window settings
set Source.1 [gui_create_window -type {Source}  -parent ${TopLevel.3}]
gui_show_window -window ${Source.1} -show_state maximized
gui_update_layout -id ${Source.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false}}

# End MDI window settings


# Create and position top-level window: TopLevel.4

if {![gui_exist_window -window TopLevel.4]} {
    set TopLevel.4 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.4 TopLevel.4
}
gui_show_window -window ${TopLevel.4} -show_state maximized -rect {{21 66} {1940 1042}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_hide_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_hide_toolbar -toolbar {CopyPaste}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_hide_toolbar -toolbar {TraceInstance}
gui_hide_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}
gui_set_toolbar_attributes -toolbar {Simulator} -dock_state top
gui_set_toolbar_attributes -toolbar {Simulator} -offset 0
gui_show_toolbar -toolbar {Simulator}
gui_set_toolbar_attributes -toolbar {Interactive Rewind} -dock_state top
gui_set_toolbar_attributes -toolbar {Interactive Rewind} -offset 0
gui_show_toolbar -toolbar {Interactive Rewind}
gui_set_toolbar_attributes -toolbar {Testbench} -dock_state top
gui_set_toolbar_attributes -toolbar {Testbench} -offset 0
gui_show_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
gui_sync_global -id ${TopLevel.4} -option true

# MDI window settings
set Wave.1 [gui_create_window -type {Wave}  -parent ${TopLevel.4}]
gui_show_window -window ${Wave.1} -show_state maximized
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 557} {child_wave_right 1357} {child_wave_colname 276} {child_wave_colvalue 277} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings

gui_set_env TOPLEVELS::TARGET_FRAME(Source) none
gui_set_env TOPLEVELS::TARGET_FRAME(Schematic) none
gui_set_env TOPLEVELS::TARGET_FRAME(PathSchematic) none
gui_set_env TOPLEVELS::TARGET_FRAME(Wave) none
gui_set_env TOPLEVELS::TARGET_FRAME(List) none
gui_set_env TOPLEVELS::TARGET_FRAME(Memory) none
gui_set_env TOPLEVELS::TARGET_FRAME(DriverLoad) none
gui_update_statusbar_target_frame ${TopLevel.3}
gui_update_statusbar_target_frame ${TopLevel.4}

#</WindowLayout>

#<Database>

# DVE Open design session: 

if { ![gui_is_db_opened -db {sim.vpd}] } {
	gui_open_db -design V1 -file sim.vpd -nosource
}
gui_set_precision 1ps
gui_set_time_units 1s
#</Database>

# DVE Global setting session: 


# Global: Bus

# Global: Expressions

# Global: Signal Time Shift

# Global: Signal Compare

# Global: Signal Groups
gui_load_child_values {filter_tb_top.filter_chip_500.u_notch_filter}


set _session_group_143 Group1
gui_sg_create "$_session_group_143"
set Group1 "$_session_group_143"

gui_sg_addsignal -group "$_session_group_143" { filter_tb_top.filter_chip_500.u_notch_filter.filter_in filter_tb_top.filter_chip_500.u_notch_filter.filter_out filter_tb_top.filter_chip_1000.u_notch_filter.filter_in filter_tb_top.filter_chip_1000.u_notch_filter.filter_out }
gui_sg_set_analog_property -group "$_session_group_143" -color #ff0000 -pos -1 -origGroup {} V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_in
gui_set_radix -radix {hex} -signals {V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_in}
gui_set_radix -radix {unsigned} -signals {V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_in}
gui_set_display_scheme -scheme analog -signal {V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_in}
gui_sg_set_analog_property -group "$_session_group_143" -color #8135ff -pos -1 -origGroup {} V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_out
gui_set_radix -radix {hex} -signals {V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_out}
gui_set_radix -radix {unsigned} -signals {V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_out}
gui_set_display_scheme -scheme analog -signal {V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_out}
gui_sg_set_analog_property -group "$_session_group_143" -color #ffff00 -pos -1 -origGroup {} V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_in
gui_set_radix -radix {hex} -signals {V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_in}
gui_set_radix -radix {unsigned} -signals {V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_in}
gui_set_display_scheme -scheme analog -signal {V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_in}
gui_sg_set_analog_property -group "$_session_group_143" -color #00ff00 -pos -1 -origGroup {} V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_out
gui_set_radix -radix {hex} -signals {V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_out}
gui_set_radix -radix {unsigned} -signals {V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_out}
gui_set_display_scheme -scheme analog -signal {V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_out}

set _session_group_144 Group2
gui_sg_create "$_session_group_144"
set Group2 "$_session_group_144"

gui_sg_addsignal -group "$_session_group_144" { filter_tb_top.filter_chip_250.u_notch_filter.filter_in filter_tb_top.filter_chip_250.u_notch_filter.filter_out }
gui_sg_set_analog_property -group "$_session_group_144" -color #0080ff -pos -1 -origGroup {} V1:filter_tb_top.filter_chip_250.u_notch_filter.filter_in
gui_set_display_scheme -scheme analog -signal {V1:filter_tb_top.filter_chip_250.u_notch_filter.filter_in}
gui_sg_set_analog_property -group "$_session_group_144" -color #8000ff -pos -1 -origGroup {} V1:filter_tb_top.filter_chip_250.u_notch_filter.filter_out
gui_set_display_scheme -scheme analog -signal {V1:filter_tb_top.filter_chip_250.u_notch_filter.filter_out}

set _session_group_145 Group3
gui_sg_create "$_session_group_145"
set Group3 "$_session_group_145"

gui_sg_addsignal -group "$_session_group_145" { filter_tb_top.filter_chip_1000.u_notch_filter.clk_enable }

set _session_group_146 Group4
gui_sg_create "$_session_group_146"
set Group4 "$_session_group_146"

gui_sg_addsignal -group "$_session_group_146" { filter_tb_top.filter_chip_125.u_notch_filter.filter_in filter_tb_top.filter_chip_125.u_notch_filter.filter_out filter_tb_top.filter_chip_250.u_notch_filter.filter_in filter_tb_top.filter_chip_250.u_notch_filter.filter_out filter_tb_top.filter_chip_500.u_notch_filter.filter_in filter_tb_top.filter_chip_500.u_notch_filter.filter_out filter_tb_top.filter_chip_1000.u_notch_filter.filter_in filter_tb_top.filter_chip_1000.u_notch_filter.filter_out }
gui_sg_set_analog_property -group "$_session_group_146" -color #008000 -pos -1 -origGroup {} V1:filter_tb_top.filter_chip_125.u_notch_filter.filter_in
gui_set_display_scheme -scheme analog -signal {V1:filter_tb_top.filter_chip_125.u_notch_filter.filter_in}
gui_sg_set_analog_property -group "$_session_group_146" -color #ff8090 -pos -1 -origGroup {} V1:filter_tb_top.filter_chip_125.u_notch_filter.filter_out
gui_set_display_scheme -scheme analog -signal {V1:filter_tb_top.filter_chip_125.u_notch_filter.filter_out}
gui_sg_set_analog_property -group "$_session_group_146" -color #8000ff -pos -1 -origGroup {} V1:filter_tb_top.filter_chip_250.u_notch_filter.filter_in
gui_set_display_scheme -scheme analog -signal {V1:filter_tb_top.filter_chip_250.u_notch_filter.filter_in}
gui_sg_set_analog_property -group "$_session_group_146" -color #648080 -pos -1 -origGroup {} V1:filter_tb_top.filter_chip_250.u_notch_filter.filter_out
gui_set_display_scheme -scheme analog -signal {V1:filter_tb_top.filter_chip_250.u_notch_filter.filter_out}
gui_sg_set_analog_property -group "$_session_group_146" -color #80ff00 -pos -1 -origGroup {} V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_in
gui_set_radix -radix {hex} -signals {V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_in}
gui_set_radix -radix {unsigned} -signals {V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_in}
gui_set_display_scheme -scheme analog -signal {V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_in}
gui_sg_set_analog_property -group "$_session_group_146" -color #808000 -pos -1 -origGroup {} V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_out
gui_set_radix -radix {hex} -signals {V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_out}
gui_set_radix -radix {unsigned} -signals {V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_out}
gui_set_display_scheme -scheme analog -signal {V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_out}
gui_sg_set_analog_property -group "$_session_group_146" -color #ff8000 -pos 1 -origGroup Group3 V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_in
gui_set_radix -radix {hex} -signals {V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_in}
gui_set_radix -radix {unsigned} -signals {V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_in}
gui_set_display_scheme -scheme analog -signal {V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_in}
gui_sg_set_analog_property -group "$_session_group_146" -color #00ff80 -pos 1 -origGroup Group3 V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_out
gui_set_radix -radix {hex} -signals {V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_out}
gui_set_radix -radix {unsigned} -signals {V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_out}
gui_set_display_scheme -scheme analog -signal {V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_out}

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 1.783



# Save global setting...

# Wave/List view global setting
gui_cov_show_value -switch false

# Close all empty TopLevel windows
foreach __top [gui_ekki_get_window_ids -type TopLevel] {
    if { [llength [gui_ekki_get_window_ids -parent $__top]] == 0} {
        gui_close_window -window $__top
    }
}
gui_set_loading_session_type noSession
# DVE View/pane content session: 


# DriverLoad 'DriverLoad.1'
gui_get_drivers -session -id ${DriverLoad.1} -signal {filter_tb_top.filter_chip_1000.u_notch_filter.filter_out[15:0]} -time 0.154 -starttime 0.154

# Source 'Source.1'
gui_src_value_annotate -id ${Source.1} -switch false
gui_set_env TOGGLE::VALUEANNOTATE 0
gui_open_source -id ${Source.1}  -replace -active filter_tb_top.filter_chip_1000.u_notch_filter /projects/libs/baf4p1/digital_work/DD_BAF4P1_DIG/digital_design/logical/notch_filter/filter.v
gui_view_scroll -id ${Source.1} -vertical -set 4380
gui_src_set_reusable -id ${Source.1}

# Hier 'Hier.1'
gui_show_window -window ${Hier.1}
gui_list_set_filter -id ${Hier.1} -list { {Package 1} {All 0} {Process 1} {VirtPowSwitch 0} {UnnamedProcess 1} {UDP 0} {Function 1} {Block 1} {SrsnAndSpaCell 0} {OVA Unit 1} {LeafScCell 1} {LeafVlgCell 1} {Interface 1} {LeafVhdCell 1} {$unit 1} {NamedBlock 1} {Task 1} {VlgPackage 1} {ClassDef 1} {VirtIsoCell 0} }
gui_list_set_filter -id ${Hier.1} -text {*}
gui_hier_list_init -id ${Hier.1}
gui_change_design -id ${Hier.1} -design V1
catch {gui_list_expand -id ${Hier.1} filter_tb_top}
catch {gui_list_expand -id ${Hier.1} filter_tb_top.filter_chip_500}
catch {gui_list_select -id ${Hier.1} {filter_tb_top.filter_chip_500.u_notch_filter}}
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {filter_tb_top.filter_chip_500.u_notch_filter}
gui_show_window -window ${Data.1}
catch { gui_list_select -id ${Data.1} {filter_tb_top.filter_chip_500.u_notch_filter.filter_in filter_tb_top.filter_chip_500.u_notch_filter.filter_out }}
gui_view_scroll -id ${Data.1} -vertical -set 0
gui_view_scroll -id ${Data.1} -horizontal -set 0
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# View 'Wave.1'
gui_wv_sync -id ${Wave.1} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_marker_set_ref -id ${Wave.1}  C1
gui_wv_zoom_timerange -id ${Wave.1} 0 4.646
gui_list_add_group -id ${Wave.1} -after {New Group} {Group3}
gui_list_add_group -id ${Wave.1} -after {New Group} {Group4}
gui_list_select -id ${Wave.1} {filter_tb_top.filter_chip_1000.u_notch_filter.filter_out }
gui_seek_criteria -id ${Wave.1} {Any Edge}

gui_set_display_scheme -id ${Wave.1} -scheme analog -signal {V1:filter_tb_top.filter_chip_125.u_notch_filter.filter_in}
gui_set_analog_wave_options -id ${Wave.1} -name V1:filter_tb_top.filter_chip_125.u_notch_filter.filter_in -mark_samples 0 -mark_sample_shape Cross -mark_sample_size 3 -yrange full -ymin 0 -ymax 65535 -yscale lin -yaxis_left 1 -yaxis_right 0
gui_list_set_height -id ${Wave.1} -height 76  -name V1:filter_tb_top.filter_chip_125.u_notch_filter.filter_in -occurrence 1 -group ${Group4} 
gui_set_display_scheme -id ${Wave.1} -scheme analog -signal {V1:filter_tb_top.filter_chip_125.u_notch_filter.filter_out}
gui_set_analog_wave_options -id ${Wave.1} -name V1:filter_tb_top.filter_chip_125.u_notch_filter.filter_out -mark_samples 0 -mark_sample_shape Cross -mark_sample_size 3 -yrange full -ymin 0 -ymax 65535 -yscale lin -yaxis_left 1 -yaxis_right 0
gui_list_set_height -id ${Wave.1} -height 82  -name V1:filter_tb_top.filter_chip_125.u_notch_filter.filter_out -occurrence 1 -group ${Group4} 
gui_set_display_scheme -id ${Wave.1} -scheme analog -signal {V1:filter_tb_top.filter_chip_250.u_notch_filter.filter_in}
gui_set_analog_wave_options -id ${Wave.1} -name V1:filter_tb_top.filter_chip_250.u_notch_filter.filter_in -mark_samples 0 -mark_sample_shape Cross -mark_sample_size 3 -yrange full -ymin 0 -ymax 65535 -yscale lin -yaxis_left 1 -yaxis_right 0
gui_list_set_height -id ${Wave.1} -height 75  -name V1:filter_tb_top.filter_chip_250.u_notch_filter.filter_in -occurrence 1 -group ${Group4} 
gui_set_display_scheme -id ${Wave.1} -scheme analog -signal {V1:filter_tb_top.filter_chip_250.u_notch_filter.filter_out}
gui_set_analog_wave_options -id ${Wave.1} -name V1:filter_tb_top.filter_chip_250.u_notch_filter.filter_out -mark_samples 0 -mark_sample_shape Cross -mark_sample_size 3 -yrange full -ymin 0 -ymax 65535 -yscale lin -yaxis_left 1 -yaxis_right 0
gui_list_set_height -id ${Wave.1} -height 75  -name V1:filter_tb_top.filter_chip_250.u_notch_filter.filter_out -occurrence 1 -group ${Group4} 
gui_set_display_scheme -id ${Wave.1} -scheme analog -signal {V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_in}
gui_set_analog_wave_options -id ${Wave.1} -name V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_in -mark_samples 0 -mark_sample_shape Cross -mark_sample_size 3 -yrange full -ymin 0 -ymax 65535 -yscale lin -yaxis_left 1 -yaxis_right 0
gui_list_set_height -id ${Wave.1} -height 75  -name V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_in -occurrence 1 -group ${Group4} 
gui_set_display_scheme -id ${Wave.1} -scheme analog -signal {V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_out}
gui_set_analog_wave_options -id ${Wave.1} -name V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_out -mark_samples 0 -mark_sample_shape Cross -mark_sample_size 3 -yrange full -ymin 0 -ymax 65535 -yscale lin -yaxis_left 1 -yaxis_right 0
gui_list_set_height -id ${Wave.1} -height 75  -name V1:filter_tb_top.filter_chip_500.u_notch_filter.filter_out -occurrence 1 -group ${Group4} 
gui_set_display_scheme -id ${Wave.1} -scheme analog -signal {V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_in}
gui_set_analog_wave_options -id ${Wave.1} -name V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_in -mark_samples 0 -mark_sample_shape Cross -mark_sample_size 3 -yrange usr -ymin 32366.7 -ymax 90034.2 -yscale lin -yaxis_left 1 -yaxis_right 0
gui_list_set_height -id ${Wave.1} -height 111  -name V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_in -occurrence 1 -group ${Group4} 
gui_set_display_scheme -id ${Wave.1} -scheme analog -signal {V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_out}
gui_set_analog_wave_options -id ${Wave.1} -name V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_out -mark_samples 0 -mark_sample_shape Cross -mark_sample_size 3 -yrange usr -ymin 12029.6 -ymax 102716 -yscale lin -yaxis_left 1 -yaxis_right 0
gui_list_set_height -id ${Wave.1} -height 115  -name V1:filter_tb_top.filter_chip_1000.u_notch_filter.filter_out -occurrence 1 -group ${Group4} 


gui_set_env TOGGLE::DEFAULT_WAVE_WINDOW ${Wave.1}
gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.1} -text {*}
gui_list_set_insertion_bar  -id ${Wave.1} -group Group4  -item {filter_tb_top.filter_chip_1000.u_notch_filter.filter_out[15:0]} -position below

gui_marker_move -id ${Wave.1} {C1} 1.783
gui_view_scroll -id ${Wave.1} -vertical -set 16
gui_show_grid -id ${Wave.1} -enable false
# Restore toplevel window zorder
# The toplevel window could be closed if it has no view/pane
if {[gui_exist_window -window ${TopLevel.3}]} {
	gui_set_active_window -window ${TopLevel.3}
	gui_set_active_window -window ${Source.1}
	gui_set_active_window -window ${DLPane.1}
}
if {[gui_exist_window -window ${TopLevel.4}]} {
	gui_set_active_window -window ${TopLevel.4}
	gui_set_active_window -window ${Wave.1}
}
#</Session>

