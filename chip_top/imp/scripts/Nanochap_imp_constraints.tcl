 # ------------------------------------------------------------------------------
 # Purpose : Synthesis Script - Clocks and Constraints (BAF4)
 #
 # ------------------------------------------------------------------------------
 # Multi-scenario, single power domain.
 #
 # Scenario naming: SXY_mZZ  (adapted from ENS2, CPHA dropped for BAF4)
 #   X : mode   -> 1 = Normal mode, 2 = CP test Mode, 3 = Bist Mode, 4 = Scan Mode
 #   Y : clock  -> 1 = Internal clock (OSC), 2 = External clock
 #   ZZ: corner -> min / max (handled in Nanochap_imp_scenario_specific.tcl)
 #
 # Functional scenarios built by this file:
 #   S11  Normal mode, internal OSC clock
 #   S12  Normal mode, external clock
 #   S22  CP test mode, external clock (test-mode pins active)
 #   S3   Bist mode
 #

 set hfosc_period       [expr {1000}]      ; # 256 KHz
 set extclk_period      [expr {1000}]      ; # external clock
 set spiclk_period      [expr {1000}]      ; # SPI works mostly at 256 KHz, sometimes 1 MHz for debug
 set mbistclk_period    [expr {100}]       ; # 1 MHz BIST

 set cycle90    [expr {0.90 * ${hfosc_period}}]
 set cycle80    [expr {0.80 * ${hfosc_period}}]
 set cycle70    [expr {0.70 * ${hfosc_period}}]
 set cycle60    [expr {0.60 * ${hfosc_period}}]
 set cycle50    [expr {0.50 * ${hfosc_period}}]
 set cycle40    [expr {0.40 * ${hfosc_period}}]
 set cycle30    [expr {0.30 * ${hfosc_period}}]
 set cycle20    [expr {0.20 * ${hfosc_period}}]
 set cycle10    [expr {0.10 * ${hfosc_period}}]

# ================================================================================================================================
# ===== sys_clk (normal mode, internal OSC)  -- S11
# ================================================================================================================================
if {[string match S11_m?? $i]} {
 create_clock -name sys_clk [get_pins {u_top_ana/A2D_OSC_OUT}] -period $hfosc_period  -add
 set_clock_uncertainty -setup   [expr {0.05 * ${hfosc_period}}]     [get_clocks sys_clk]
 set_clock_uncertainty -hold    0.4      [get_clocks sys_clk]
}

# ================================================================================================================================
# ===== sys_clk (external clock: normal S12 or CP test S22)
# ================================================================================================================================
if {[string match S?2_m?? $i]} {
 create_clock -name sys_clk [get_pins u_top_ana/A2D_external_clock_I] -period $extclk_period  -add
 set_clock_uncertainty -setup   [expr {0.05 * ${extclk_period}}]     [get_clocks sys_clk]
 set_clock_uncertainty -hold    0.4      [get_clocks sys_clk]
}

# ================================================================================================================================
# ===== mbist_clk + mbist virtual clock -- S3 (bist mode)
# ================================================================================================================================
if {[string match S3_m?? $i]} {
 create_clock -name mbist_clk [get_ports IOBUF_PAD[2]] -period $mbistclk_period  -add
 set_clock_uncertainty -setup   [expr {0.05 * ${mbistclk_period}}]     [get_clocks mbist_clk]
 set_clock_uncertainty -hold    0.4      [get_clocks mbist_clk]

 create_clock -name mbist_vclk -period $mbistclk_period
 set_clock_uncertainty -setup   [expr {0.05 * ${mbistclk_period}}]     [get_clocks mbist_vclk]
 set_clock_uncertainty -hold    0.4      [get_clocks mbist_vclk]
}

# ================================================================================================================================
# ===== spi_clk -- normal mode only (S11 / S12).  Shares IOBUF_PAD[2] with mbist,
#       scenario separation keeps them mutually exclusive.
# ================================================================================================================================
if {[string match S1?_m?? $i]} {
 create_clock -name spi_clk [get_ports IOBUF_PAD[2]] -period $spiclk_period  -add
 set_clock_uncertainty -setup   [expr {0.05 * ${spiclk_period}}]     [get_clocks spi_clk]
 set_clock_uncertainty -hold    0.4      [get_clocks spi_clk]
}

# ================================================================================================================================
# ===== Internal clock tree -- all functional non-bist scenarios (S11 / S12 / S22)
#       Sourced from sys_clk so it adapts to OSC or external automatically.
# ================================================================================================================================
if {[string match S3_m?? $i] == 0} {

 # ===== hfosc_atpg -- switched clock from sys_clk
 create_generated_clock -name hfosc_atpg -add -divide_by 1 -master_clock sys_clk \
			-source [get_attribute [get_clocks sys_clk] sources] \
			[get_pins  u_top_dig/clk_ctrl_inst/DNT_HFOSC_ATPG/Y]
 set_clock_uncertainty -setup   [expr {0.05 * ${hfosc_period}}]     [get_clocks hfosc_atpg]
 set_clock_uncertainty -hold    0.4      [get_clocks hfosc_atpg]

 # ===== fclk -- switched from hfosc_atpg
 create_generated_clock -name fclk -comb -add -master_clock hfosc_atpg \
			-source [get_attribute [get_clocks hfosc_atpg] sources] \
			[get_pins  u_top_dig/clk_ctrl_inst/u_cmsdk_clock_gate_hclk/DNT_ICG_CELL/ECK]
 set_clock_uncertainty -setup   [expr {0.05 * ${hfosc_period}}]     [get_clocks fclk]
 set_clock_uncertainty -hold    0.4      [get_clocks fclk]

 # ===== iclk -- switched from fclk
 create_generated_clock -name iclk -add -divide_by 2 -master_clock fclk \
			-source [get_attribute [get_clocks fclk] sources] \
			[get_pins  u_top_dig/clk_ctrl_inst/DNT_DIV_FCLK_ATPG/Y]
 set_clock_uncertainty -setup   [expr {0.05 * ${hfosc_period}}]     [get_clocks iclk]
 set_clock_uncertainty -hold    0.4      [get_clocks iclk]

 # ===== pclk -- switched from fclk
 create_generated_clock -name pclk -add -comb -master_clock fclk \
			-source [get_attribute [get_clocks fclk] sources] \
			[get_pins  u_top_dig/clk_ctrl_inst/u_cmsdk_clock_gate_pclk/DNT_ICG_CELL/ECK]
 set_clock_uncertainty -setup   [expr {0.05 * ${hfosc_period}}]     [get_clocks pclk]
 set_clock_uncertainty -hold    0.4      [get_clocks pclk]

 # ===== 1K clk gen -- switched from fclk
 create_generated_clock -name m1k_atpg -add -divide_by 256 -master_clock fclk \
			-source [get_attribute [get_clocks fclk] sources] \
			[get_pins  u_top_dig/clk_ctrl_inst/DNT_M1KCLK_ATPG/Y]
 set_clock_uncertainty -setup   [expr {0.05 * ${hfosc_period}}]     [get_clocks m1k_atpg]
 set_clock_uncertainty -hold    0.4      [get_clocks m1k_atpg]

 # ===== zmeas clocks -- switched from fclk/pclk
 create_generated_clock -name zmeas_pclk -add -comb -master_clock pclk \
			-source [get_attribute [get_clocks pclk] sources] \
			[get_pins  u_top_dig/clk_ctrl_inst/u_cmsdk_clock_gate_zmeas_pclk/DNT_ICG_CELL/ECK]
 set_clock_uncertainty -setup   [expr {0.05 * ${hfosc_period}}]     [get_clocks zmeas_pclk]
 set_clock_uncertainty -hold    0.4      [get_clocks zmeas_pclk]

 create_generated_clock -name zmeas_mclk -add -comb -master_clock fclk \
			-source [get_attribute [get_clocks fclk] sources] \
			[get_pins  u_top_dig/clk_ctrl_inst/u_cmsdk_clock_gate_zmeas_clk/DNT_ICG_CELL/ECK]
 set_clock_uncertainty -setup   [expr {0.05 * ${hfosc_period}}]     [get_clocks zmeas_mclk]
 set_clock_uncertainty -hold    0.4      [get_clocks zmeas_mclk]

 create_generated_clock -name zmeas_mclkg -add -comb -master_clock zmeas_mclk \
			-source [get_attribute [get_clocks zmeas_mclk] sources] \
			[get_pins u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl/u_zmeas_clock_gate_mclkg/DNT_ICG_CELL/ECK]
 set_clock_uncertainty -setup   [expr {0.05 * ${hfosc_period}}]     [get_clocks zmeas_mclkg]
 set_clock_uncertainty -hold    0.4      [get_clocks zmeas_mclkg]

 create_generated_clock -name zmeas_mclkg_invert \
			-invert -divide_by 1 \
			-source [get_attribute [get_clocks zmeas_mclkg] sources] \
			[get_pins u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl/DNT_ZMEAS_MCLKG_ATPG/Y]
 set_clock_uncertainty -setup   [expr {0.05 * ${hfosc_period}}]     [get_clocks zmeas_mclkg_invert]
 set_clock_uncertainty -hold    0.4      [get_clocks zmeas_mclkg_invert]

 # ===== imeas clocks -- switched from iclk and pclk
 create_generated_clock -name imeas_pclk -add -comb -master_clock pclk \
			-source [get_attribute [get_clocks pclk] sources] \
			[get_pins  u_top_dig/clk_ctrl_inst/u_cmsdk_clock_gate_imeas_pclk/DNT_ICG_CELL/ECK]
 set_clock_uncertainty -setup   [expr {0.05 * ${hfosc_period}}]     [get_clocks imeas_pclk]
 set_clock_uncertainty -hold    0.4      [get_clocks imeas_pclk]

 create_generated_clock -name imeas_dig_adc_clk \
			-divide_by 1 \
			-source [get_attribute [get_clocks iclk] sources] \
			[get_pins u_top_dig/clk_ctrl_inst/u_cmsdk_clock_gate_iadc_clk/DNT_ICG_CELL/ECK]
 set_clock_uncertainty -setup   [expr {0.05 * ${hfosc_period}}]     [get_clocks imeas_dig_adc_clk]
 set_clock_uncertainty -hold    0.4      [get_clocks imeas_dig_adc_clk]

 create_generated_clock -name imeas_adc_clk \
			-invert -divide_by 1 \
			-source [get_attribute [get_clocks imeas_dig_adc_clk] sources] \
			[get_pins u_top_dig/clk_ctrl_inst/DNT_ADC_CLK_INV/Y]
 set_clock_uncertainty -setup   [expr {0.05 * ${hfosc_period}}]     [get_clocks imeas_adc_clk]
 set_clock_uncertainty -hold    0.4      [get_clocks imeas_adc_clk]

 # ===== Virtual clock for sys clk
 create_clock -name vclk -period $hfosc_period
 set_clock_uncertainty -setup   [expr {0.05 * ${hfosc_period}}]     [get_clocks vclk]
 set_clock_uncertainty -hold    0.4      [get_clocks vclk]
}

# ================================================================================================================================
# ===== Clock groups
# ================================================================================================================================
#normal mode: sys/derived clocks async to spi_clk
if {[string match S1?_m?? $i]} {
 set_clock_groups -asynchronous -name async_grp \
        -group [list sys_clk vclk fclk iclk pclk m1k_atpg zmeas_pclk zmeas_mclk zmeas_mclkg zmeas_mclkg_invert imeas_pclk imeas_adc_clk imeas_dig_adc_clk hfosc_atpg] \
        -group [list spi_clk]
}
#bist mode
if {[string match S3_m?? $i]} {
 set_clock_groups -asynchronous -name async_grp_bist \
        -group [list mbist_clk mbist_vclk]
}

# ================================================================================================================================
# ===== Clock-related false paths (functional non-bist)
# ================================================================================================================================
if {[string match S22_m?? $i]} {
 set_sense -stop_propagation -clocks sys_clk   [get_pins -leaf -of_objects {u_top_dig/u_pinmux/OSC_OUT} -filter "full_name =~ u_top_dig/u_pinmux/*"];#clock going out in test_mode doesn't need timing
}

#normal mode only (spi + flash bist through spi_clk)
if {[string match S1?_m?? $i]} {
 set_false_path -from [get_clocks spi_clk] -through [remove_from_collection [get_pins  u_top_dig/flash_ctrl_top_inst/u_BIS_016K29DE/*/*/*] [list [get_pins u_top_dig/flash_ctrl_top_inst/u_BIS_016K29DE/u_data_generator/B_*/*] [get_pins {u_top_dig/flash_ctrl_top_inst/u_BIS_016K29DE/u_command_detector/*/\\*\\*logic_0\\*\\*}]]] -to [get_clocks spi_clk]
 set_false_path -from  IOBUF_PAD[0] -to  IOBUF_PAD[3] -through   u_top_dig/u_pinmux/u_gpio0_pinmux/altf0_y -through   u_top_dig/u_pinmux/u_gpio3_pinmux/altf0_oe;#CS can affect MISO but not timing critical
}

#bist mode only
if {[string match S3_m?? $i]} {
 set_false_path -from [get_clocks mbist_clk] -through [remove_from_collection [get_pins  u_top_dig/u_imeas/*/*/*] [get_pins {u_top_dig/u_imeas/*/*/\\*\\*logic_*\\*\\*}]] -to [get_clocks mbist_clk]
 set_false_path -from [get_clocks mbist_clk] -through [remove_from_collection [get_pins  u_top_dig/spi_top_u/*/*/*] [get_pins {u_top_dig/spi_top_u/spi_reg_u/*/\\*\\*logic_0\\*\\*}]] -to [get_clocks mbist_clk]
}

set_false_path -through iopad_testmode*
#select lines not in timing path (pinmux mode selects)
set_false_path -from IOBUF_PAD[6] -to IOBUF_PAD
set_false_path -from IOBUF_PAD[7] -to IOBUF_PAD
set_false_path -from IOBUF_PAD[8] -to IOBUF_PAD
set_false_path -from IOBUF_PAD[9] -to IOBUF_PAD

# ================================================================================================================================
# Flash multicycle 
# ================================================================================================================================
set_multicycle_path 2 -setup -through [get_pins u_top_dig/flash_ctrl_top_inst/u_32k/DOUT*]
set_multicycle_path 1 -hold  -through [get_pins u_top_dig/flash_ctrl_top_inst/u_32k/DOUT*]

 # --------------------------------------------------------------------------------------------------------------------------------
 # Constraints --Input/Output Delay
 # --------------------------------------------------------------------------------------------------------------------------------
 set inout_ports    [list IOBUF_PAD[*]]
 set input_ports    [list u_iopad_testmode0 u_iopad_testmode1 u_iopad_exresetn]
 set clock_ports    [list IOBUF_PAD[2]]
 set a2d_clock_pins [list u_top_ana/A2D_OSC_OUT u_top_ana/A2D_external_clock_I]
 set d2a_clock_pins [list u_top_ana/D2A_SW_Z_CLK256K u_top_ana/D2A_SDM_CLK]

# ================================================================================================================================
# ===== GPIO + Analog pad delays (functional non-bist)
# ================================================================================================================================
if {[string match S3_m?? $i] == 0} {
 # GPIO Pads
 set_input_delay    -clock vclk  -max $cycle40 [get_ports [all_inputs]]     -add_delay
 set_input_delay    -clock vclk  -min 0.0      [get_ports [all_inputs]]     -add_delay
 set_output_delay   -clock vclk  -max $cycle40 [get_ports [all_outputs]]    -add_delay
 set_output_delay   -clock vclk  -min 0.0      [get_ports [all_outputs]]    -add_delay

 # Analog pins
 set_input_delay    -clock vclk  -max $cycle40 [get_pins [remove_from_collection [get_pins u_top_ana/A2D_*] $a2d_clock_pins]]   -add_delay
 set_input_delay    -clock vclk  -min 0.0      [get_pins [remove_from_collection [get_pins u_top_ana/A2D_*] $a2d_clock_pins]]   -add_delay
 set_output_delay   -clock vclk  -max $cycle40 [get_pins [remove_from_collection [get_pins u_top_ana/D2A_*] $d2a_clock_pins]]   -add_delay
 set_output_delay   -clock vclk  -min 0.0      [get_pins [remove_from_collection [get_pins u_top_ana/D2A_*] $d2a_clock_pins]]   -add_delay

 remove_input_delay u_top_ana/A2D_LOFF_STATP
 remove_input_delay u_top_ana/A2D_LOFF_STATN
 set_input_delay -clock imeas_pclk -min 0         u_top_ana/A2D_LOFF_STATP
 set_input_delay -clock imeas_pclk -max $cycle40  u_top_ana/A2D_LOFF_STATP
 set_input_delay -clock imeas_pclk -min 0         u_top_ana/A2D_LOFF_STATN
 set_input_delay -clock imeas_pclk -max $cycle40  u_top_ana/A2D_LOFF_STATN

 # Flash data-in
 set_output_delay   -clock vclk        -max $cycle40 [get_pins u_top_dig/flash_ctrl_top_inst/u_32k/DIN]
 set_output_delay   -clock vclk        -min 0	     [get_pins u_top_dig/flash_ctrl_top_inst/u_32k/DIN]

 # zmeas / imeas analog timing
 set_output_delay -clock zmeas_mclkg -max $cycle40 [get_pins u_top_ana/D2A_SW_Z_DDS] -add_delay
 set_output_delay -clock zmeas_mclkg -min 0        [get_pins u_top_ana/D2A_SW_Z_DDS] -add_delay

 set_input_delay -clock imeas_adc_clk -max $cycle40 [get_pins u_top_ana/A2D_SDM_OUT] -clock_fall -add_delay
 set_input_delay -clock imeas_adc_clk -min 0        [get_pins u_top_ana/A2D_SDM_OUT] -clock_fall -add_delay
 set_input_delay -clock imeas_adc_clk -max $cycle40 [get_pins u_top_ana/A2D_SDM_OUT] -add_delay
 set_input_delay -clock imeas_adc_clk -min 0        [get_pins u_top_ana/A2D_SDM_OUT] -add_delay
}

# ================================================================================================================================
# ===== SPI port delays (normal mode only)
# ================================================================================================================================
if {[string match S1?_m?? $i]} {
 set_input_delay  -clock spi_clk -max [expr {${spiclk_period}*0.40}] [get_ports IOBUF_PAD[0]] -add_delay
 set_input_delay  -clock spi_clk -min 0.0                            [get_ports IOBUF_PAD[0]] -add_delay
 set_input_delay  -clock spi_clk -max [expr {${spiclk_period}*0.40}] [get_ports IOBUF_PAD[1]] -add_delay
 set_input_delay  -clock spi_clk -min 0.0                            [get_ports IOBUF_PAD[1]] -add_delay
 set_output_delay -clock spi_clk -max [expr {${spiclk_period}*0.40}] [get_ports IOBUF_PAD[3]] -add_delay
 set_output_delay -clock spi_clk -min 0.0                            [get_ports IOBUF_PAD[3]] -add_delay
}

# ================================================================================================================================
# ===== Flash Bist Ports (bist mode only)
# ================================================================================================================================
if {[string match S3_m?? $i]} {
 set_input_delay  -clock mbist_clk -max [expr {0.40 * ${mbistclk_period}}]    [get_ports IOBUF_PAD[3]]       -add_delay
 set_input_delay  -clock mbist_clk -min 0.0                                   [get_ports IOBUF_PAD[3]]       -add_delay
 set_output_delay -clock mbist_clk -max [expr {0.40 * ${mbistclk_period}}]    [get_ports IOBUF_PAD[4]]       -add_delay
 set_output_delay -clock mbist_clk -min 0.0                                   [get_ports IOBUF_PAD[4]]       -add_delay

 set_output_delay   -clock mbist_vclk  -max [expr {0.40 * ${mbistclk_period}}] [get_pins u_top_dig/flash_ctrl_top_inst/u_32k/DIN]
 set_output_delay   -clock mbist_vclk  -min 0	     [get_pins u_top_dig/flash_ctrl_top_inst/u_32k/DIN]
}

# ------------------------------------------------------------------------------
# Exception (functional non-bist)
# ------------------------------------------------------------------------------
if {[string match S3_m?? $i] == 0} {
 set_false_path -from [get_clocks vclk] -through [get_pins u_top_dig/u_pinmux/u_gpio13_pinmux/u_test_a/DNT_MX4_3/S*] -to [get_clocks sys_clk]
 set_false_path -from [get_clocks vclk] -through [get_pins u_top_ana/A2D_Wake_UP_i]
}

set_false_path -through [get_pins u_top_dig/u_pinmux/u_gpio*_pinmux/u_test_*/*]

 # --------------------------------------------------------------------------------------------------------------------------------
 # Constraints --Set Case Analysis
 # --------------------------------------------------------------------------------------------------------------------------------
 # scan is off in all functional (non scan) scenarios
 set_case_analysis 0 [get_pins u_top_dig/u_pinmux/u_scan_mode/Y]
 set_case_analysis 0 [get_pins u_top_dig/u_pinmux/atpg_en]

#normal mode: test-mode pins inactive
if {[string match S1?_m?? $i]} {
 set_case_analysis 0 iopad_testmode0
 set_case_analysis 0 iopad_testmode1
}
#CP test mode (external clock): test-mode pins active
if {[string match S22_m?? $i]} {
 set_case_analysis 1 iopad_testmode0
 set_case_analysis 1 iopad_testmode1
}
#bist mode
if {[string match S3_m?? $i]} {
 set_case_analysis 0 iopad_testmode0
 set_case_analysis 1 iopad_testmode1
}

 # ------------------------------------------------------------------------------
 # End of File
 # ------------------------------------------------------------------------------
