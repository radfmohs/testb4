# ------------------------------------------------------------------------------
# Purpose :  Synthesis Script - Scan (S4) Constraints (BAF4)
#

#scan clock
set scan_clock_period     400.000
set scan_clock_period_jitter  [expr {$scan_clock_period * 0.01}]

set scan_max_delay [expr {0.15 * ${scan_clock_period}}]
set scan_min_delay 1.5

create_clock -name scan_clk [get_ports IOBUF_PAD[2]] \
-period [expr {${scan_clock_period} - ${scan_clock_period_jitter}}] -waveform {45 95}
set_clock_uncertainty -setup                   [expr {${setup_margin} + $pre_cts_clock_skew_estimate}]     [get_clocks scan_clk]
set_clock_uncertainty -hold                    [expr {${hold_margin} + $pre_cts_clock_skew_estimate}]      [get_clocks scan_clk]
set_clock_latency $pre_cts_clock_latency_estimate                                                          [get_clocks scan_clk]

set_clock_transition -max 0.8 [get_clocks scan_clk]

set_case_analysis 1 [get_pins u_top_dig/u_pinmux/u_scan_mode/Y]
set_case_analysis 1 [get_pins u_top_dig/u_pinmux/atpg_en]
set_case_analysis 1 [get_pins top_dig_always_on_inst/DNT_ATPG_AL_ON/Y]
set_case_analysis 1 iopad_testmode0
set_case_analysis 0 iopad_testmode1

# -----------------------------------------------------------------------------
# Model asynchronous clock domains crossings
# -----------------------------------------------------------------------------
set_clock_groups -asynchronous -name scan_clk_group \
        -group {scan_clk}

# ------------------------------------------------------------------------------
# Scan port input/output delay
# ------------------------------------------------------------------------------
# Scan data-in pads + scan-enable pad
set scan_inputs [list IOBUF_PAD[3] IOBUF_PAD[4] IOBUF_PAD[5] IOBUF_PAD[7] \
                      IOBUF_PAD[8] IOBUF_PAD[9] IOBUF_PAD[10] IOBUF_PAD[11] IOBUF_PAD[12]]

# Scan data-out pads
set scan_outputs [list IOBUF_PAD[0] IOBUF_PAD[1] IOBUF_PAD[13] IOBUF_PAD[14] \
                       IOBUF_PAD[15] IOBUF_PAD[16] IOBUF_PAD[17] IOBUF_PAD[18]]

# Apply Input Delays
foreach in_pin $scan_inputs {
    set_input_delay -clock scan_clk -max $scan_max_delay [get_ports $in_pin] -add_delay
    set_input_delay -clock scan_clk -min $scan_min_delay [get_ports $in_pin] -add_delay
}

# Apply Output Delays
foreach out_pin $scan_outputs {
    set_output_delay -clock scan_clk -max $scan_max_delay [get_ports $out_pin] -add_delay
    set_output_delay -clock scan_clk -min 0.0            [get_ports $out_pin] -add_delay
}

set_false_path -through [get_ports IOBUF_PAD[6]];#scan_compression enable pin
set_false_path -through [get_ports iopad_testmode*]
set_false_path -through [get_pins u_top_dig/flash_ctrl_top_inst/u_32k/*]

# scan_compression_in pin relaxed timing
set_max_delay [expr {2 * ${scan_clock_period}}] -from [get_ports IOBUF_PAD[6]]

# ------------------------------------------------------------------------------
# End of File
# ------------------------------------------------------------------------------
