###############################################################################
# Change list, formatted for dc_shell -tcl
#
# NOTE - Assumes dc_shell is already in incremental mode
#
#
# 
#
###############################################################################
current_instance
current_instance {top_dig_always_on_inst/pinmux_always_on_inst}
insert_buffer [get_pins {DNT_MUX2_IOBUF_Y_1_/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1} -new_cell_names {U_PTECO_HOLD_BUF1}
insert_buffer [get_pins {DNT_MUX2_IOBUF_Y_0_/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2} -new_cell_names {U_PTECO_HOLD_BUF2}
current_instance
current_instance {top_dig_always_on_inst/reset_ctrl_always_on_inst}
insert_buffer [get_pins {U40/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET3} -new_cell_names {U_PTECO_HOLD_BUF3}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U440/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET4} -new_cell_names {U_PTECO_HOLD_BUF4}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U440/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET5} -new_cell_names {U_PTECO_HOLD_BUF5}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U442/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET6} -new_cell_names {U_PTECO_HOLD_BUF6}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U31/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET7} -new_cell_names {U_PTECO_HOLD_BUF7}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U443/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET8} -new_cell_names {U_PTECO_HOLD_BUF8}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U5/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET9} -new_cell_names {U_PTECO_HOLD_BUF9}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U299/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET10} -new_cell_names {U_PTECO_HOLD_BUF10}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {integ1_reg_1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET11} -new_cell_names {U_PTECO_HOLD_BUF11}
insert_buffer [get_pins {U509/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET12} -new_cell_names {U_PTECO_HOLD_BUF12}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U491/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET13} -new_cell_names {U_PTECO_HOLD_BUF13}
insert_buffer [get_pins {integ1_reg_1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET14} -new_cell_names {U_PTECO_HOLD_BUF14}
insert_buffer [get_pins {U509/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET15} -new_cell_names {U_PTECO_HOLD_BUF15}
insert_buffer [get_pins {integ1_reg_8_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET16} -new_cell_names {U_PTECO_HOLD_BUF16}
insert_buffer [get_pins {U503/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET17} -new_cell_names {U_PTECO_HOLD_BUF17}
insert_buffer [get_pins {U457/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET18} -new_cell_names {U_PTECO_HOLD_BUF18}
current_instance
current_instance {u_top_dig}
insert_buffer [get_pins {U41/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET19} -new_cell_names {U_PTECO_HOLD_BUF19}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U108/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET20} -new_cell_names {U_PTECO_HOLD_BUF20}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U449/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET21} -new_cell_names {U_PTECO_HOLD_BUF21}
insert_buffer [get_pins {U445/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET22} -new_cell_names {U_PTECO_HOLD_BUF22}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U509/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET23} -new_cell_names {U_PTECO_HOLD_BUF23}
insert_buffer [get_pins {U508/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET24} -new_cell_names {U_PTECO_HOLD_BUF24}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U508/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET25} -new_cell_names {U_PTECO_HOLD_BUF25}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U441/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET26} -new_cell_names {U_PTECO_HOLD_BUF26}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U506/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET27} -new_cell_names {U_PTECO_HOLD_BUF27}
insert_buffer [get_pins {U507/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET28} -new_cell_names {U_PTECO_HOLD_BUF28}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U506/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET29} -new_cell_names {U_PTECO_HOLD_BUF29}
insert_buffer [get_pins {U507/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET30} -new_cell_names {U_PTECO_HOLD_BUF30}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U505/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET31} -new_cell_names {U_PTECO_HOLD_BUF31}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U505/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET32} -new_cell_names {U_PTECO_HOLD_BUF32}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U508/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET33} -new_cell_names {U_PTECO_HOLD_BUF33}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U504/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET34} -new_cell_names {U_PTECO_HOLD_BUF34}
insert_buffer [get_pins {U595/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET35} -new_cell_names {U_PTECO_HOLD_BUF35}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U506/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET36} -new_cell_names {U_PTECO_HOLD_BUF36}
insert_buffer [get_pins {U507/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET37} -new_cell_names {U_PTECO_HOLD_BUF37}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U504/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET38} -new_cell_names {U_PTECO_HOLD_BUF38}
insert_buffer [get_pins {U595/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET39} -new_cell_names {U_PTECO_HOLD_BUF39}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U505/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET40} -new_cell_names {U_PTECO_HOLD_BUF40}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U503/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET41} -new_cell_names {U_PTECO_HOLD_BUF41}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U503/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET42} -new_cell_names {U_PTECO_HOLD_BUF42}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U502/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET43} -new_cell_names {U_PTECO_HOLD_BUF43}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U504/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET44} -new_cell_names {U_PTECO_HOLD_BUF44}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U501/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET45} -new_cell_names {U_PTECO_HOLD_BUF45}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U502/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET46} -new_cell_names {U_PTECO_HOLD_BUF46}
insert_buffer [get_pins {U501/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET47} -new_cell_names {U_PTECO_HOLD_BUF47}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U500/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET48} -new_cell_names {U_PTECO_HOLD_BUF48}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U500/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET49} -new_cell_names {U_PTECO_HOLD_BUF49}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U455/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET50} -new_cell_names {U_PTECO_HOLD_BUF50}
insert_buffer [get_pins {U502/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET51} -new_cell_names {U_PTECO_HOLD_BUF51}
insert_buffer [get_pins {U501/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET52} -new_cell_names {U_PTECO_HOLD_BUF52}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U499/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET53} -new_cell_names {U_PTECO_HOLD_BUF53}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U499/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET54} -new_cell_names {U_PTECO_HOLD_BUF54}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U498/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET55} -new_cell_names {U_PTECO_HOLD_BUF55}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U498/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET56} -new_cell_names {U_PTECO_HOLD_BUF56}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U500/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET57} -new_cell_names {U_PTECO_HOLD_BUF57}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U497/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET58} -new_cell_names {U_PTECO_HOLD_BUF58}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U497/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET59} -new_cell_names {U_PTECO_HOLD_BUF59}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U499/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET60} -new_cell_names {U_PTECO_HOLD_BUF60}
insert_buffer [get_pins {U498/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET61} -new_cell_names {U_PTECO_HOLD_BUF61}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U496/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET62} -new_cell_names {U_PTECO_HOLD_BUF62}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U496/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET63} -new_cell_names {U_PTECO_HOLD_BUF63}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U574/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET64} -new_cell_names {U_PTECO_HOLD_BUF64}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U497/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET65} -new_cell_names {U_PTECO_HOLD_BUF65}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U574/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET66} -new_cell_names {U_PTECO_HOLD_BUF66}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U576/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET67} -new_cell_names {U_PTECO_HOLD_BUF67}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U576/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET68} -new_cell_names {U_PTECO_HOLD_BUF68}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U496/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET69} -new_cell_names {U_PTECO_HOLD_BUF69}
insert_buffer [get_pins {U574/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET70} -new_cell_names {U_PTECO_HOLD_BUF70}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U594/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET71} -new_cell_names {U_PTECO_HOLD_BUF71}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U594/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET72} -new_cell_names {U_PTECO_HOLD_BUF72}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U576/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET73} -new_cell_names {U_PTECO_HOLD_BUF73}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {U347/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET74} -new_cell_names {U_PTECO_HOLD_BUF74}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U593/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET75} -new_cell_names {U_PTECO_HOLD_BUF75}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U593/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET76} -new_cell_names {U_PTECO_HOLD_BUF76}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U594/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET77} -new_cell_names {U_PTECO_HOLD_BUF77}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U592/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET78} -new_cell_names {U_PTECO_HOLD_BUF78}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U592/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET79} -new_cell_names {U_PTECO_HOLD_BUF79}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U593/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET80} -new_cell_names {U_PTECO_HOLD_BUF80}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U591/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET81} -new_cell_names {U_PTECO_HOLD_BUF81}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U591/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET82} -new_cell_names {U_PTECO_HOLD_BUF82}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U590/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET83} -new_cell_names {U_PTECO_HOLD_BUF83}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U590/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET84} -new_cell_names {U_PTECO_HOLD_BUF84}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U592/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET85} -new_cell_names {U_PTECO_HOLD_BUF85}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U589/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET86} -new_cell_names {U_PTECO_HOLD_BUF86}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U589/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET87} -new_cell_names {U_PTECO_HOLD_BUF87}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U591/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET88} -new_cell_names {U_PTECO_HOLD_BUF88}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U588/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET89} -new_cell_names {U_PTECO_HOLD_BUF89}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U588/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET90} -new_cell_names {U_PTECO_HOLD_BUF90}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U590/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET91} -new_cell_names {U_PTECO_HOLD_BUF91}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U587/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET92} -new_cell_names {U_PTECO_HOLD_BUF92}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U587/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET93} -new_cell_names {U_PTECO_HOLD_BUF93}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_24_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET94} -new_cell_names {U_PTECO_HOLD_BUF94}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U586/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET95} -new_cell_names {U_PTECO_HOLD_BUF95}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U586/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET96} -new_cell_names {U_PTECO_HOLD_BUF96}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_25_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET97} -new_cell_names {U_PTECO_HOLD_BUF97}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U585/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET98} -new_cell_names {U_PTECO_HOLD_BUF98}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U585/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET99} -new_cell_names {U_PTECO_HOLD_BUF99}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_26_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET100} -new_cell_names {U_PTECO_HOLD_BUF100}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U584/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET101} -new_cell_names {U_PTECO_HOLD_BUF101}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U584/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET102} -new_cell_names {U_PTECO_HOLD_BUF102}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_27_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET103} -new_cell_names {U_PTECO_HOLD_BUF103}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U583/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET104} -new_cell_names {U_PTECO_HOLD_BUF104}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U583/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET105} -new_cell_names {U_PTECO_HOLD_BUF105}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_28_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET106} -new_cell_names {U_PTECO_HOLD_BUF106}
insert_buffer [get_pins {integ1_reg_29_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET107} -new_cell_names {U_PTECO_HOLD_BUF107}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U582/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET108} -new_cell_names {U_PTECO_HOLD_BUF108}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U582/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET109} -new_cell_names {U_PTECO_HOLD_BUF109}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_30_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET110} -new_cell_names {U_PTECO_HOLD_BUF110}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U581/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET111} -new_cell_names {U_PTECO_HOLD_BUF111}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U581/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET112} -new_cell_names {U_PTECO_HOLD_BUF112}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_analog_test_mode_sync}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET113} -new_cell_names {U_PTECO_HOLD_BUF113}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_33_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET114} -new_cell_names {U_PTECO_HOLD_BUF114}
insert_buffer [get_pins {U579/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET115} -new_cell_names {U_PTECO_HOLD_BUF115}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl}
insert_buffer [get_pins {dds_enable_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET116} -new_cell_names {U_PTECO_HOLD_BUF116}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_31_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET117} -new_cell_names {U_PTECO_HOLD_BUF117}
current_instance
current_instance {u_top_dig/rst_ctrl_inst/u_presetn_sync}
insert_buffer [get_pins {U3/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET118} -new_cell_names {U_PTECO_HOLD_BUF118}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_unlock_gpio_sync}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET119} -new_cell_names {U_PTECO_HOLD_BUF119}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U580/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET120} -new_cell_names {U_PTECO_HOLD_BUF120}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U580/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET121} -new_cell_names {U_PTECO_HOLD_BUF121}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_32_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET122} -new_cell_names {U_PTECO_HOLD_BUF122}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_unlock_sync}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET123} -new_cell_names {U_PTECO_HOLD_BUF123}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_spi_wr_command_sync}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET124} -new_cell_names {U_PTECO_HOLD_BUF124}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_spi_ser_sync}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET125} -new_cell_names {U_PTECO_HOLD_BUF125}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_spi_cer_sync}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET126} -new_cell_names {U_PTECO_HOLD_BUF126}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {a_empty_n_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET127} -new_cell_names {U_PTECO_HOLD_BUF127}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U579/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET128} -new_cell_names {U_PTECO_HOLD_BUF128}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U579/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET129} -new_cell_names {U_PTECO_HOLD_BUF129}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_0__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET130} -new_cell_names {U_PTECO_HOLD_BUF130}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_14_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET131} -new_cell_names {U_PTECO_HOLD_BUF131}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_0__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET132} -new_cell_names {U_PTECO_HOLD_BUF132}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_15_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET133} -new_cell_names {U_PTECO_HOLD_BUF133}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_17_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET134} -new_cell_names {U_PTECO_HOLD_BUF134}
current_instance
current_instance {top_dig_always_on_inst/reset_ctrl_always_on_inst}
insert_buffer [get_pins {U42/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET135} -new_cell_names {U_PTECO_HOLD_BUF135}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_1_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET136} -new_cell_names {U_PTECO_HOLD_BUF136}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_read_sync}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET137} -new_cell_names {U_PTECO_HOLD_BUF137}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {integ1_reg_0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET138} -new_cell_names {U_PTECO_HOLD_BUF138}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET139} -new_cell_names {U_PTECO_HOLD_BUF139}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_flash_cer}
insert_buffer [get_pins {data_reg_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET140} -new_cell_names {U_PTECO_HOLD_BUF140}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_wr_spi}
insert_buffer [get_pins {U5/B0N}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET141} -new_cell_names {U_PTECO_HOLD_BUF141}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_3_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET142} -new_cell_names {U_PTECO_HOLD_BUF142}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_11_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET143} -new_cell_names {U_PTECO_HOLD_BUF143}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_2_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET144} -new_cell_names {U_PTECO_HOLD_BUF144}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {rx_buf_reg_5_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET145} -new_cell_names {U_PTECO_HOLD_BUF145}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_8_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET146} -new_cell_names {U_PTECO_HOLD_BUF146}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U579/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET147} -new_cell_names {U_PTECO_HOLD_BUF147}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_flash_ser}
insert_buffer [get_pins {data_reg_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET148} -new_cell_names {U_PTECO_HOLD_BUF148}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {rx_buf_reg_7_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET149} -new_cell_names {U_PTECO_HOLD_BUF149}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_9_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET150} -new_cell_names {U_PTECO_HOLD_BUF150}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_rw_ctrl/u_flash_rw_fsm/u_flash_dslp_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET151} -new_cell_names {U_PTECO_HOLD_BUF151}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {rx_buf_reg_6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET152} -new_cell_names {U_PTECO_HOLD_BUF152}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_4_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET153} -new_cell_names {U_PTECO_HOLD_BUF153}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_7_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET154} -new_cell_names {U_PTECO_HOLD_BUF154}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_spi_nvr_sync}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET155} -new_cell_names {U_PTECO_HOLD_BUF155}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_16_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET156} -new_cell_names {U_PTECO_HOLD_BUF156}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {a_full_local_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET157} -new_cell_names {U_PTECO_HOLD_BUF157}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cdc}
insert_buffer [get_pins {filter1_en_sync_pclk_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET158} -new_cell_names {U_PTECO_HOLD_BUF158}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_phase_accumulator}
insert_buffer [get_pins {U24/B0}] BUFX4M -new_net_names {net_PTECO_HOLD_NET159} -new_cell_names {U_PTECO_HOLD_BUF159}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_rd_spi}
insert_buffer [get_pins {U5/B0N}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET160} -new_cell_names {U_PTECO_HOLD_BUF160}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U943/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET161} -new_cell_names {U_PTECO_HOLD_BUF161}
insert_buffer [get_pins {U942/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET162} -new_cell_names {U_PTECO_HOLD_BUF162}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_phase_accumulator}
insert_buffer [get_pins {freq_phjmp_reg_reg_6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET163} -new_cell_names {U_PTECO_HOLD_BUF163}
insert_buffer [get_pins {freq_phjmp_reg_reg_10_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET164} -new_cell_names {U_PTECO_HOLD_BUF164}
insert_buffer [get_pins {freq_phjmp_reg_reg_11_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET165} -new_cell_names {U_PTECO_HOLD_BUF165}
insert_buffer [get_pins {freq_phjmp_reg_reg_2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET166} -new_cell_names {U_PTECO_HOLD_BUF166}
insert_buffer [get_pins {freq_phjmp_reg_reg_3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET167} -new_cell_names {U_PTECO_HOLD_BUF167}
insert_buffer [get_pins {freq_phjmp_reg_reg_4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET168} -new_cell_names {U_PTECO_HOLD_BUF168}
insert_buffer [get_pins {freq_phjmp_reg_reg_5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET169} -new_cell_names {U_PTECO_HOLD_BUF169}
insert_buffer [get_pins {freq_phjmp_reg_reg_8_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET170} -new_cell_names {U_PTECO_HOLD_BUF170}
insert_buffer [get_pins {freq_phjmp_reg_reg_7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET171} -new_cell_names {U_PTECO_HOLD_BUF171}
insert_buffer [get_pins {freq_phjmp_reg_reg_9_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET172} -new_cell_names {U_PTECO_HOLD_BUF172}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U943/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET173} -new_cell_names {U_PTECO_HOLD_BUF173}
insert_buffer [get_pins {U942/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET174} -new_cell_names {U_PTECO_HOLD_BUF174}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_phase_accumulator}
insert_buffer [get_pins {U80/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET175} -new_cell_names {U_PTECO_HOLD_BUF175}
insert_buffer [get_pins {U79/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET176} -new_cell_names {U_PTECO_HOLD_BUF176}
insert_buffer [get_pins {U74/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET177} -new_cell_names {U_PTECO_HOLD_BUF177}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {U439/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET178} -new_cell_names {U_PTECO_HOLD_BUF178}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch0data_en_reg_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET179} -new_cell_names {U_PTECO_HOLD_BUF179}
current_instance
current_instance {u_top_dig/u_imeas/u_acSTATP_sync_pclk}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET180} -new_cell_names {U_PTECO_HOLD_BUF180}
current_instance
current_instance {u_top_dig/u_imeas/u_acSTATN_sync_pclk}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET181} -new_cell_names {U_PTECO_HOLD_BUF181}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U31/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET182} -new_cell_names {U_PTECO_HOLD_BUF182}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {U20/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET183} -new_cell_names {U_PTECO_HOLD_BUF183}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {o_addr_reg_7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET184} -new_cell_names {U_PTECO_HOLD_BUF184}
insert_buffer [get_pins {o_addr_reg_5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET185} -new_cell_names {U_PTECO_HOLD_BUF185}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_3_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET186} -new_cell_names {U_PTECO_HOLD_BUF186}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {o_addr_reg_6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET187} -new_cell_names {U_PTECO_HOLD_BUF187}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_phase_accumulator}
insert_buffer [get_pins {freq_phjmp_reg_reg_1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET188} -new_cell_names {U_PTECO_HOLD_BUF188}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U269/A1N}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET189} -new_cell_names {U_PTECO_HOLD_BUF189}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_phase_accumulator}
insert_buffer [get_pins {freq_phjmp_reg_reg_20_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET190} -new_cell_names {U_PTECO_HOLD_BUF190}
insert_buffer [get_pins {freq_phjmp_reg_reg_0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET191} -new_cell_names {U_PTECO_HOLD_BUF191}
insert_buffer [get_pins {freq_phjmp_reg_reg_16_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET192} -new_cell_names {U_PTECO_HOLD_BUF192}
insert_buffer [get_pins {freq_phjmp_reg_reg_19_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET193} -new_cell_names {U_PTECO_HOLD_BUF193}
insert_buffer [get_pins {freq_phjmp_reg_reg_15_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET194} -new_cell_names {U_PTECO_HOLD_BUF194}
insert_buffer [get_pins {freq_phjmp_reg_reg_14_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET195} -new_cell_names {U_PTECO_HOLD_BUF195}
insert_buffer [get_pins {freq_phjmp_reg_reg_13_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET196} -new_cell_names {U_PTECO_HOLD_BUF196}
insert_buffer [get_pins {U10/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET197} -new_cell_names {U_PTECO_HOLD_BUF197}
insert_buffer [get_pins {dds_phase_add_reg_0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET198} -new_cell_names {U_PTECO_HOLD_BUF198}
insert_buffer [get_pins {dds_phase_add_reg_1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET199} -new_cell_names {U_PTECO_HOLD_BUF199}
current_instance
current_instance {u_top_dig/u_imeas/u_filter0_sync_adcclk}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET200} -new_cell_names {U_PTECO_HOLD_BUF200}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U264/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET201} -new_cell_names {U_PTECO_HOLD_BUF201}
current_instance
current_instance {u_top_dig/u_imeas/u_filter1_sync_adcclk}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET202} -new_cell_names {U_PTECO_HOLD_BUF202}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_phase_accumulator}
insert_buffer [get_pins {U74/A0}] BUFX4M -new_net_names {net_PTECO_HOLD_NET203} -new_cell_names {U_PTECO_HOLD_BUF203}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {sd16eoc_sync_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET204} -new_cell_names {U_PTECO_HOLD_BUF204}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_enable_sync}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET205} -new_cell_names {U_PTECO_HOLD_BUF205}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U180/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET206} -new_cell_names {U_PTECO_HOLD_BUF206}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {U441/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET207} -new_cell_names {U_PTECO_HOLD_BUF207}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {Freq_ctrl_temp_reg_3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET208} -new_cell_names {U_PTECO_HOLD_BUF208}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_phase_accumulator}
insert_buffer [get_pins {dds_phase_add_reg_2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET209} -new_cell_names {U_PTECO_HOLD_BUF209}
insert_buffer [get_pins {dds_phase_add_reg_14_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET210} -new_cell_names {U_PTECO_HOLD_BUF210}
insert_buffer [get_pins {dds_phase_add_reg_9_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET211} -new_cell_names {U_PTECO_HOLD_BUF211}
insert_buffer [get_pins {dds_phase_add_reg_13_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET212} -new_cell_names {U_PTECO_HOLD_BUF212}
insert_buffer [get_pins {dds_phase_add_reg_10_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET213} -new_cell_names {U_PTECO_HOLD_BUF213}
insert_buffer [get_pins {dds_phase_add_reg_12_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET214} -new_cell_names {U_PTECO_HOLD_BUF214}
insert_buffer [get_pins {dds_phase_add_reg_11_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET215} -new_cell_names {U_PTECO_HOLD_BUF215}
insert_buffer [get_pins {dds_phase_add_reg_8_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET216} -new_cell_names {U_PTECO_HOLD_BUF216}
insert_buffer [get_pins {dds_phase_add_reg_18_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET217} -new_cell_names {U_PTECO_HOLD_BUF217}
insert_buffer [get_pins {dds_phase_add_reg_6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET218} -new_cell_names {U_PTECO_HOLD_BUF218}
insert_buffer [get_pins {dds_phase_add_reg_16_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET219} -new_cell_names {U_PTECO_HOLD_BUF219}
insert_buffer [get_pins {dds_phase_add_reg_17_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET220} -new_cell_names {U_PTECO_HOLD_BUF220}
insert_buffer [get_pins {dds_phase_add_reg_7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET221} -new_cell_names {U_PTECO_HOLD_BUF221}
insert_buffer [get_pins {dds_phase_add_reg_3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET222} -new_cell_names {U_PTECO_HOLD_BUF222}
insert_buffer [get_pins {dds_phase_add_reg_15_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET223} -new_cell_names {U_PTECO_HOLD_BUF223}
insert_buffer [get_pins {dds_phase_add_reg_5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET224} -new_cell_names {U_PTECO_HOLD_BUF224}
insert_buffer [get_pins {dds_phase_add_reg_19_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET225} -new_cell_names {U_PTECO_HOLD_BUF225}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {A2D_ACLOFF_STATN_sync_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET226} -new_cell_names {U_PTECO_HOLD_BUF226}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {rx_buf_reg_1_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET227} -new_cell_names {U_PTECO_HOLD_BUF227}
insert_buffer [get_pins {fifo_rd_data_sync_reg_12_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET228} -new_cell_names {U_PTECO_HOLD_BUF228}
insert_buffer [get_pins {fifo_rd_data_sync_reg_13_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET229} -new_cell_names {U_PTECO_HOLD_BUF229}
insert_buffer [get_pins {fifo_rd_data_sync_reg_1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET230} -new_cell_names {U_PTECO_HOLD_BUF230}
insert_buffer [get_pins {fifo_rd_data_sync_reg_2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET231} -new_cell_names {U_PTECO_HOLD_BUF231}
insert_buffer [get_pins {fifo_rd_data_sync_reg_5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET232} -new_cell_names {U_PTECO_HOLD_BUF232}
insert_buffer [get_pins {fifo_rd_data_sync_reg_6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET233} -new_cell_names {U_PTECO_HOLD_BUF233}
insert_buffer [get_pins {fifo_rd_data_sync_reg_10_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET234} -new_cell_names {U_PTECO_HOLD_BUF234}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_0_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET235} -new_cell_names {U_PTECO_HOLD_BUF235}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {checking_clk_div_cnt_reg_1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET236} -new_cell_names {U_PTECO_HOLD_BUF236}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {rx_buf_reg_0_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET237} -new_cell_names {U_PTECO_HOLD_BUF237}
insert_buffer [get_pins {o_addr_reg_1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET238} -new_cell_names {U_PTECO_HOLD_BUF238}
insert_buffer [get_pins {o_addr_reg_0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET239} -new_cell_names {U_PTECO_HOLD_BUF239}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {checking_clk_div_cnt_reg_3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET240} -new_cell_names {U_PTECO_HOLD_BUF240}
insert_buffer [get_pins {checking_clk_div_cnt_reg_7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET241} -new_cell_names {U_PTECO_HOLD_BUF241}
current_instance
current_instance {top_dig_always_on_inst/reset_ctrl_always_on_inst/u_por_resetn_sync}
insert_buffer [get_pins {rst_sync1_n_reg/RN}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET242} -new_cell_names {U_PTECO_HOLD_BUF242}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {flg_ch_chg_d2_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET243} -new_cell_names {U_PTECO_HOLD_BUF243}
current_instance
current_instance {u_top_dig/u_imeas/u_STATN_sync_pclk}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET244} -new_cell_names {U_PTECO_HOLD_BUF244}
current_instance
current_instance {u_top_dig/u_imeas/u_STATP_sync_pclk}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET245} -new_cell_names {U_PTECO_HOLD_BUF245}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {checking_clk_div_cnt_reg_11_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET246} -new_cell_names {U_PTECO_HOLD_BUF246}
insert_buffer [get_pins {checking_clk_div_cnt_reg_12_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET247} -new_cell_names {U_PTECO_HOLD_BUF247}
insert_buffer [get_pins {U450/A2}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET248} -new_cell_names {U_PTECO_HOLD_BUF248}
insert_buffer [get_pins {U437/A2}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET249} -new_cell_names {U_PTECO_HOLD_BUF249}
insert_buffer [get_pins {U330/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET250} -new_cell_names {U_PTECO_HOLD_BUF250}
insert_buffer [get_pins {U311/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET251} -new_cell_names {U_PTECO_HOLD_BUF251}
insert_buffer [get_pins {U324/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET252} -new_cell_names {U_PTECO_HOLD_BUF252}
insert_buffer [get_pins {U319/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET253} -new_cell_names {U_PTECO_HOLD_BUF253}
insert_buffer [get_pins {checking_clk_div_cnt_reg_13_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET254} -new_cell_names {U_PTECO_HOLD_BUF254}
insert_buffer [get_pins {checking_clk_div_cnt_reg_15_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET255} -new_cell_names {U_PTECO_HOLD_BUF255}
insert_buffer [get_pins {checking_clk_div_cnt_reg_0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET256} -new_cell_names {U_PTECO_HOLD_BUF256}
current_instance
current_instance {u_top_dig/clk_ctrl_inst/u_zmeas_gen_clk_sync}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET257} -new_cell_names {U_PTECO_HOLD_BUF257}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {a_empty_sts_reg/D}] BUFX8M -new_net_names {net_PTECO_HOLD_NET258} -new_cell_names {U_PTECO_HOLD_BUF258}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {chnum_reg_d1_reg_0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET259} -new_cell_names {U_PTECO_HOLD_BUF259}
insert_buffer [get_pins {chnum_reg_d1_reg_2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET260} -new_cell_names {U_PTECO_HOLD_BUF260}
current_instance
current_instance {u_top_dig/rst_ctrl_inst}
insert_buffer [get_pins {U31/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET261} -new_cell_names {U_PTECO_HOLD_BUF261}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {U443/B1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET262} -new_cell_names {U_PTECO_HOLD_BUF262}
current_instance
current_instance {top_dig_always_on_inst/reset_ctrl_always_on_inst/u_sw_por_resetn_sync}
insert_buffer [get_pins {U6/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET263} -new_cell_names {U_PTECO_HOLD_BUF263}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {checking_clk_reg_reg/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET264} -new_cell_names {U_PTECO_HOLD_BUF264}
insert_buffer [get_pins {checking_clk_div_cnt_reg_2_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET265} -new_cell_names {U_PTECO_HOLD_BUF265}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {U442/B1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET266} -new_cell_names {U_PTECO_HOLD_BUF266}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {U2906/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET267} -new_cell_names {U_PTECO_HOLD_BUF267}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {rx_buf_reg_0_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET268} -new_cell_names {U_PTECO_HOLD_BUF268}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U440/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET269} -new_cell_names {U_PTECO_HOLD_BUF269}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U299/AN}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET270} -new_cell_names {U_PTECO_HOLD_BUF270}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U595/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET273} -new_cell_names {U_PTECO_HOLD_BUF273}
insert_buffer [get_pins {U589/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET274} -new_cell_names {U_PTECO_HOLD_BUF274}
insert_buffer [get_pins {U588/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET275} -new_cell_names {U_PTECO_HOLD_BUF275}
insert_buffer [get_pins {U587/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET276} -new_cell_names {U_PTECO_HOLD_BUF276}
insert_buffer [get_pins {U586/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET277} -new_cell_names {U_PTECO_HOLD_BUF277}
insert_buffer [get_pins {U585/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET278} -new_cell_names {U_PTECO_HOLD_BUF278}
insert_buffer [get_pins {U584/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET279} -new_cell_names {U_PTECO_HOLD_BUF279}
insert_buffer [get_pins {U583/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET280} -new_cell_names {U_PTECO_HOLD_BUF280}
insert_buffer [get_pins {U582/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET281} -new_cell_names {U_PTECO_HOLD_BUF281}
insert_buffer [get_pins {U581/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET282} -new_cell_names {U_PTECO_HOLD_BUF282}
insert_buffer [get_pins {U580/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET283} -new_cell_names {U_PTECO_HOLD_BUF283}
current_instance
current_instance {top_dig_always_on_inst/shadow_regs_always_on_inst}
insert_buffer [get_pins {trim8_always_on_reg_2_/SN}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET284} -new_cell_names {U_PTECO_HOLD_BUF284}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U310/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET285} -new_cell_names {U_PTECO_HOLD_BUF285}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {U68/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET287} -new_cell_names {U_PTECO_HOLD_BUF287}
current_instance
current_instance {top_dig_always_on_inst/pinmux_always_on_inst}
insert_buffer [get_pins {DNT_MUX2_IOBUF_Y_5_/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET288} -new_cell_names {U_PTECO_HOLD_BUF288}
current_instance
current_instance {u_top_dig/u_ppg_controller}
insert_buffer [get_pins {U87/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET289} -new_cell_names {U_PTECO_HOLD_BUF289}
current_instance
current_instance {top_dig_always_on_inst/pinmux_always_on_inst}
insert_buffer [get_pins {DNT_MUX2_IOBUF_Y_3_/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET290} -new_cell_names {U_PTECO_HOLD_BUF290}
insert_buffer [get_pins {DNT_MUX2_IOBUF_Y_10_/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET291} -new_cell_names {U_PTECO_HOLD_BUF291}
insert_buffer [get_pins {DNT_MUX2_IOBUF_Y_4_/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET292} -new_cell_names {U_PTECO_HOLD_BUF292}
insert_buffer [get_pins {DNT_MUX2_IOBUF_Y_8_/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET293} -new_cell_names {U_PTECO_HOLD_BUF293}
insert_buffer [get_pins {DNT_MUX2_IOBUF_Y_7_/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET294} -new_cell_names {U_PTECO_HOLD_BUF294}
insert_buffer [get_pins {DNT_MUX2_IOBUF_Y_9_/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET295} -new_cell_names {U_PTECO_HOLD_BUF295}
insert_buffer [get_pins {DNT_MUX2_IOBUF_Y_12_/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET296} -new_cell_names {U_PTECO_HOLD_BUF296}
insert_buffer [get_pins {DNT_MUX2_IOBUF_Y_11_/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET297} -new_cell_names {U_PTECO_HOLD_BUF297}
current_instance
current_instance {top_dig_always_on_inst}
insert_buffer [get_pins {DNT_SCAN_EN_AL_ON_TMP/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET298} -new_cell_names {U_PTECO_HOLD_BUF298}
current_instance
current_instance {top_dig_always_on_inst/reset_ctrl_always_on_inst}
insert_buffer [get_pins {sw_por_tmout_resetn_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET299} -new_cell_names {U_PTECO_HOLD_BUF299}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_imeas}
insert_buffer [get_pins {imeas_reg_ctrl_0_reg_7_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET300} -new_cell_names {U_PTECO_HOLD_BUF300}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_spi_wr_sync}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET301} -new_cell_names {U_PTECO_HOLD_BUF301}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch_cnt_reg_reg_2_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET302} -new_cell_names {U_PTECO_HOLD_BUF302}
insert_buffer [get_pins {ch_cnt_reg_reg_1_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET303} -new_cell_names {U_PTECO_HOLD_BUF303}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {ana_ppg_dac1_ctrl_reg0_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET304} -new_cell_names {U_PTECO_HOLD_BUF304}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {dft_data_r_reg_6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET305} -new_cell_names {U_PTECO_HOLD_BUF305}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {filter0_en_sync_adcclk_d1_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET306} -new_cell_names {U_PTECO_HOLD_BUF306}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_16__5_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET307} -new_cell_names {U_PTECO_HOLD_BUF307}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U325/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET308} -new_cell_names {U_PTECO_HOLD_BUF308}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U781/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET309} -new_cell_names {U_PTECO_HOLD_BUF309}
insert_buffer [get_pins {U774/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET310} -new_cell_names {U_PTECO_HOLD_BUF310}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_19__5_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET311} -new_cell_names {U_PTECO_HOLD_BUF311}
insert_buffer [get_pins {trim_reg_reg_20__5_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET312} -new_cell_names {U_PTECO_HOLD_BUF312}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U320/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET313} -new_cell_names {U_PTECO_HOLD_BUF313}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_19__1_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET314} -new_cell_names {U_PTECO_HOLD_BUF314}
insert_buffer [get_pins {trim_reg_reg_16__1_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET315} -new_cell_names {U_PTECO_HOLD_BUF315}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U326/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET316} -new_cell_names {U_PTECO_HOLD_BUF316}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_18__2_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET317} -new_cell_names {U_PTECO_HOLD_BUF317}
insert_buffer [get_pins {trim_reg_reg_19__2_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET318} -new_cell_names {U_PTECO_HOLD_BUF318}
insert_buffer [get_pins {trim_reg_reg_20__1_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET319} -new_cell_names {U_PTECO_HOLD_BUF319}
insert_buffer [get_pins {trim_reg_reg_17__2_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET320} -new_cell_names {U_PTECO_HOLD_BUF320}
insert_buffer [get_pins {trim_reg_reg_16__2_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET321} -new_cell_names {U_PTECO_HOLD_BUF321}
insert_buffer [get_pins {trim_reg_reg_16__0_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET322} -new_cell_names {U_PTECO_HOLD_BUF322}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U756/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET323} -new_cell_names {U_PTECO_HOLD_BUF323}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_20__2_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET324} -new_cell_names {U_PTECO_HOLD_BUF324}
insert_buffer [get_pins {trim_reg_reg_19__0_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET325} -new_cell_names {U_PTECO_HOLD_BUF325}
insert_buffer [get_pins {trim_reg_reg_20__0_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET326} -new_cell_names {U_PTECO_HOLD_BUF326}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U322/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET327} -new_cell_names {U_PTECO_HOLD_BUF327}
insert_buffer [get_pins {dft_data_r_reg_5_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET328} -new_cell_names {U_PTECO_HOLD_BUF328}
insert_buffer [get_pins {U323/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET329} -new_cell_names {U_PTECO_HOLD_BUF329}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U789/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET330} -new_cell_names {U_PTECO_HOLD_BUF330}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_16__3_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET331} -new_cell_names {U_PTECO_HOLD_BUF331}
insert_buffer [get_pins {trim_reg_reg_20__7_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET332} -new_cell_names {U_PTECO_HOLD_BUF332}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U760/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET333} -new_cell_names {U_PTECO_HOLD_BUF333}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_20__3_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET334} -new_cell_names {U_PTECO_HOLD_BUF334}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U324/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET335} -new_cell_names {U_PTECO_HOLD_BUF335}
insert_buffer [get_pins {dft_data_r_reg_2_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET336} -new_cell_names {U_PTECO_HOLD_BUF336}
insert_buffer [get_pins {dft_data_r_reg_0_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET337} -new_cell_names {U_PTECO_HOLD_BUF337}
insert_buffer [get_pins {U319/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET338} -new_cell_names {U_PTECO_HOLD_BUF338}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {U195/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET339} -new_cell_names {U_PTECO_HOLD_BUF339}
insert_buffer [get_pins {U199/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET340} -new_cell_names {U_PTECO_HOLD_BUF340}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_20__4_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET341} -new_cell_names {U_PTECO_HOLD_BUF341}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U132/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET342} -new_cell_names {U_PTECO_HOLD_BUF342}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {checking_clk_reg_sync_d1_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET343} -new_cell_names {U_PTECO_HOLD_BUF343}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U662/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET344} -new_cell_names {U_PTECO_HOLD_BUF344}
insert_buffer [get_pins {U536/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET345} -new_cell_names {U_PTECO_HOLD_BUF345}
insert_buffer [get_pins {U785/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET346} -new_cell_names {U_PTECO_HOLD_BUF346}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_25__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET347} -new_cell_names {U_PTECO_HOLD_BUF347}
current_instance
current_instance {u_top_dig/clk_ctrl_inst/u_checking_clk_reg_pclk}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET348} -new_cell_names {U_PTECO_HOLD_BUF348}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section4_reg_0__19_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET349} -new_cell_names {U_PTECO_HOLD_BUF349}
insert_buffer [get_pins {delay_section4_reg_0__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET350} -new_cell_names {U_PTECO_HOLD_BUF350}
insert_buffer [get_pins {delay_section4_reg_0__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET351} -new_cell_names {U_PTECO_HOLD_BUF351}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_18__6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET352} -new_cell_names {U_PTECO_HOLD_BUF352}
insert_buffer [get_pins {trim_reg_reg_19__6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET353} -new_cell_names {U_PTECO_HOLD_BUF353}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U685/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET354} -new_cell_names {U_PTECO_HOLD_BUF354}
insert_buffer [get_pins {U668/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET355} -new_cell_names {U_PTECO_HOLD_BUF355}
insert_buffer [get_pins {U290/C0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET356} -new_cell_names {U_PTECO_HOLD_BUF356}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_17__5_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET357} -new_cell_names {U_PTECO_HOLD_BUF357}
insert_buffer [get_pins {trim_reg_reg_16__6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET358} -new_cell_names {U_PTECO_HOLD_BUF358}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U683/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET359} -new_cell_names {U_PTECO_HOLD_BUF359}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_17__6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET360} -new_cell_names {U_PTECO_HOLD_BUF360}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U814/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET361} -new_cell_names {U_PTECO_HOLD_BUF361}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_2__5_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET362} -new_cell_names {U_PTECO_HOLD_BUF362}
insert_buffer [get_pins {trim_reg_reg_4__6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET363} -new_cell_names {U_PTECO_HOLD_BUF363}
insert_buffer [get_pins {trim_reg_reg_15__6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET364} -new_cell_names {U_PTECO_HOLD_BUF364}
insert_buffer [get_pins {trim_reg_reg_12__6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET365} -new_cell_names {U_PTECO_HOLD_BUF365}
insert_buffer [get_pins {trim_reg_reg_3__6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET366} -new_cell_names {U_PTECO_HOLD_BUF366}
insert_buffer [get_pins {trim_reg_reg_14__5_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET367} -new_cell_names {U_PTECO_HOLD_BUF367}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U787/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET368} -new_cell_names {U_PTECO_HOLD_BUF368}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_20__6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET369} -new_cell_names {U_PTECO_HOLD_BUF369}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U725/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET370} -new_cell_names {U_PTECO_HOLD_BUF370}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_3__5_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET371} -new_cell_names {U_PTECO_HOLD_BUF371}
insert_buffer [get_pins {trim_reg_reg_17__0_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET372} -new_cell_names {U_PTECO_HOLD_BUF372}
insert_buffer [get_pins {trim_reg_reg_2__0_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET373} -new_cell_names {U_PTECO_HOLD_BUF373}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U517/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET374} -new_cell_names {U_PTECO_HOLD_BUF374}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_4__0_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET375} -new_cell_names {U_PTECO_HOLD_BUF375}
insert_buffer [get_pins {trim_reg_reg_3__0_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET376} -new_cell_names {U_PTECO_HOLD_BUF376}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U670/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET377} -new_cell_names {U_PTECO_HOLD_BUF377}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_14__2_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET378} -new_cell_names {U_PTECO_HOLD_BUF378}
insert_buffer [get_pins {trim_reg_reg_3__2_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET379} -new_cell_names {U_PTECO_HOLD_BUF379}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U664/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET380} -new_cell_names {U_PTECO_HOLD_BUF380}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_17__1_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET381} -new_cell_names {U_PTECO_HOLD_BUF381}
insert_buffer [get_pins {trim_reg_reg_2__1_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET382} -new_cell_names {U_PTECO_HOLD_BUF382}
insert_buffer [get_pins {trim_reg_reg_17__3_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET383} -new_cell_names {U_PTECO_HOLD_BUF383}
insert_buffer [get_pins {trim_reg_reg_12__1_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET384} -new_cell_names {U_PTECO_HOLD_BUF384}
insert_buffer [get_pins {trim_reg_reg_2__3_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET385} -new_cell_names {U_PTECO_HOLD_BUF385}
insert_buffer [get_pins {trim_reg_reg_3__3_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET386} -new_cell_names {U_PTECO_HOLD_BUF386}
insert_buffer [get_pins {trim_reg_reg_12__3_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET387} -new_cell_names {U_PTECO_HOLD_BUF387}
insert_buffer [get_pins {trim_reg_reg_4__3_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET388} -new_cell_names {U_PTECO_HOLD_BUF388}
insert_buffer [get_pins {trim_reg_reg_18__7_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET389} -new_cell_names {U_PTECO_HOLD_BUF389}
insert_buffer [get_pins {trim_reg_reg_12__7_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET390} -new_cell_names {U_PTECO_HOLD_BUF390}
insert_buffer [get_pins {trim_reg_reg_17__7_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET391} -new_cell_names {U_PTECO_HOLD_BUF391}
insert_buffer [get_pins {trim_reg_reg_18__4_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET392} -new_cell_names {U_PTECO_HOLD_BUF392}
insert_buffer [get_pins {trim_reg_reg_3__7_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET393} -new_cell_names {U_PTECO_HOLD_BUF393}
insert_buffer [get_pins {trim_reg_reg_17__4_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET394} -new_cell_names {U_PTECO_HOLD_BUF394}
insert_buffer [get_pins {trim_reg_reg_3__4_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET395} -new_cell_names {U_PTECO_HOLD_BUF395}
insert_buffer [get_pins {trim_reg_reg_6__6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET396} -new_cell_names {U_PTECO_HOLD_BUF396}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_imeas}
insert_buffer [get_pins {imeas_reg_ch_reg_2_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET397} -new_cell_names {U_PTECO_HOLD_BUF397}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_2__6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET398} -new_cell_names {U_PTECO_HOLD_BUF398}
insert_buffer [get_pins {trim_reg_reg_14__6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET399} -new_cell_names {U_PTECO_HOLD_BUF399}
insert_buffer [get_pins {trim_reg_reg_4__5_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET400} -new_cell_names {U_PTECO_HOLD_BUF400}
insert_buffer [get_pins {trim_reg_reg_3__1_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET401} -new_cell_names {U_PTECO_HOLD_BUF401}
insert_buffer [get_pins {trim_reg_reg_0__3_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET402} -new_cell_names {U_PTECO_HOLD_BUF402}
insert_buffer [get_pins {trim_reg_reg_14__3_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET403} -new_cell_names {U_PTECO_HOLD_BUF403}
insert_buffer [get_pins {trim_reg_reg_14__7_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET404} -new_cell_names {U_PTECO_HOLD_BUF404}
insert_buffer [get_pins {trim_reg_reg_2__4_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET405} -new_cell_names {U_PTECO_HOLD_BUF405}
insert_buffer [get_pins {trim_reg_reg_14__4_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET406} -new_cell_names {U_PTECO_HOLD_BUF406}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_5__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET407} -new_cell_names {U_PTECO_HOLD_BUF407}
insert_buffer [get_pins {trim_regs_reg_5__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET408} -new_cell_names {U_PTECO_HOLD_BUF408}
insert_buffer [get_pins {trim_regs_reg_17__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET409} -new_cell_names {U_PTECO_HOLD_BUF409}
insert_buffer [get_pins {trim_regs_reg_10__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET410} -new_cell_names {U_PTECO_HOLD_BUF410}
insert_buffer [get_pins {trim_regs_reg_8__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET411} -new_cell_names {U_PTECO_HOLD_BUF411}
insert_buffer [get_pins {trim_regs_reg_5__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET412} -new_cell_names {U_PTECO_HOLD_BUF412}
insert_buffer [get_pins {trim_regs_reg_7__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET413} -new_cell_names {U_PTECO_HOLD_BUF413}
insert_buffer [get_pins {trim_regs_reg_10__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET414} -new_cell_names {U_PTECO_HOLD_BUF414}
insert_buffer [get_pins {trim_regs_reg_5__7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET415} -new_cell_names {U_PTECO_HOLD_BUF415}
insert_buffer [get_pins {trim_regs_reg_10__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET416} -new_cell_names {U_PTECO_HOLD_BUF416}
insert_buffer [get_pins {trim_regs_reg_16__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET417} -new_cell_names {U_PTECO_HOLD_BUF417}
insert_buffer [get_pins {trim_regs_reg_5__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET418} -new_cell_names {U_PTECO_HOLD_BUF418}
insert_buffer [get_pins {trim_regs_reg_16__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET419} -new_cell_names {U_PTECO_HOLD_BUF419}
insert_buffer [get_pins {trim_regs_reg_7__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET420} -new_cell_names {U_PTECO_HOLD_BUF420}
insert_buffer [get_pins {trim_regs_reg_5__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET421} -new_cell_names {U_PTECO_HOLD_BUF421}
insert_buffer [get_pins {trim_regs_reg_15__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET422} -new_cell_names {U_PTECO_HOLD_BUF422}
insert_buffer [get_pins {trim_regs_reg_11__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET423} -new_cell_names {U_PTECO_HOLD_BUF423}
insert_buffer [get_pins {trim_regs_reg_9__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET424} -new_cell_names {U_PTECO_HOLD_BUF424}
insert_buffer [get_pins {U284/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET425} -new_cell_names {U_PTECO_HOLD_BUF425}
insert_buffer [get_pins {trim_regs_reg_9__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET426} -new_cell_names {U_PTECO_HOLD_BUF426}
insert_buffer [get_pins {trim_regs_reg_5__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET428} -new_cell_names {U_PTECO_HOLD_BUF428}
insert_buffer [get_pins {trim_regs_reg_12__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET429} -new_cell_names {U_PTECO_HOLD_BUF429}
insert_buffer [get_pins {trim_regs_reg_18__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET430} -new_cell_names {U_PTECO_HOLD_BUF430}
insert_buffer [get_pins {trim_regs_reg_5__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET431} -new_cell_names {U_PTECO_HOLD_BUF431}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_11__3_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET432} -new_cell_names {U_PTECO_HOLD_BUF432}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_10__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET433} -new_cell_names {U_PTECO_HOLD_BUF433}
insert_buffer [get_pins {trim_regs_reg_11__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET434} -new_cell_names {U_PTECO_HOLD_BUF434}
insert_buffer [get_pins {trim_regs_reg_10__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET435} -new_cell_names {U_PTECO_HOLD_BUF435}
insert_buffer [get_pins {trim_regs_reg_5__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET436} -new_cell_names {U_PTECO_HOLD_BUF436}
insert_buffer [get_pins {rnd_regs_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET437} -new_cell_names {U_PTECO_HOLD_BUF437}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_empty_level_sync_6_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET438} -new_cell_names {U_PTECO_HOLD_BUF438}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U215/C}] BUFX4M -new_net_names {net_PTECO_HOLD_NET439} -new_cell_names {U_PTECO_HOLD_BUF439}
insert_buffer [get_pins {reg_confen_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET440} -new_cell_names {U_PTECO_HOLD_BUF440}
insert_buffer [get_pins {reg_confen_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET441} -new_cell_names {U_PTECO_HOLD_BUF441}
insert_buffer [get_pins {trim_regs_reg_8__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET442} -new_cell_names {U_PTECO_HOLD_BUF442}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {led_on_reg_10_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET443} -new_cell_names {U_PTECO_HOLD_BUF443}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_11__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET444} -new_cell_names {U_PTECO_HOLD_BUF444}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {led_on_reg_13_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET445} -new_cell_names {U_PTECO_HOLD_BUF445}
insert_buffer [get_pins {led_freq_reg_13_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET446} -new_cell_names {U_PTECO_HOLD_BUF446}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_11__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET447} -new_cell_names {U_PTECO_HOLD_BUF447}
insert_buffer [get_pins {trim_regs_reg_10__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET448} -new_cell_names {U_PTECO_HOLD_BUF448}
insert_buffer [get_pins {trim_regs_reg_10__3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET449} -new_cell_names {U_PTECO_HOLD_BUF449}
insert_buffer [get_pins {trim_regs_reg_10__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET450} -new_cell_names {U_PTECO_HOLD_BUF450}
insert_buffer [get_pins {trim_regs_reg_19__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET451} -new_cell_names {U_PTECO_HOLD_BUF451}
insert_buffer [get_pins {trim_regs_reg_18__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET452} -new_cell_names {U_PTECO_HOLD_BUF452}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {fifo_intr_local_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET453} -new_cell_names {U_PTECO_HOLD_BUF453}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_8__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET454} -new_cell_names {U_PTECO_HOLD_BUF454}
insert_buffer [get_pins {trim_regs_reg_5__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET455} -new_cell_names {U_PTECO_HOLD_BUF455}
insert_buffer [get_pins {trim_regs_reg_8__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET456} -new_cell_names {U_PTECO_HOLD_BUF456}
insert_buffer [get_pins {trim_regs_reg_10__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET457} -new_cell_names {U_PTECO_HOLD_BUF457}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_11_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET458} -new_cell_names {U_PTECO_HOLD_BUF458}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U562/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET459} -new_cell_names {U_PTECO_HOLD_BUF459}
insert_buffer [get_pins {trim_regs_reg_1__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET460} -new_cell_names {U_PTECO_HOLD_BUF460}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_9__5_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET461} -new_cell_names {U_PTECO_HOLD_BUF461}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_13__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET462} -new_cell_names {U_PTECO_HOLD_BUF462}
insert_buffer [get_pins {trim_regs_reg_5__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET463} -new_cell_names {U_PTECO_HOLD_BUF463}
insert_buffer [get_pins {trim_regs_reg_3__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET464} -new_cell_names {U_PTECO_HOLD_BUF464}
insert_buffer [get_pins {trim_regs_reg_44__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET465} -new_cell_names {U_PTECO_HOLD_BUF465}
insert_buffer [get_pins {regs_confen_data_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET466} -new_cell_names {U_PTECO_HOLD_BUF466}
insert_buffer [get_pins {trim_regs_reg_13__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET467} -new_cell_names {U_PTECO_HOLD_BUF467}
insert_buffer [get_pins {DFT_3/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET468} -new_cell_names {U_PTECO_HOLD_BUF468}
insert_buffer [get_pins {trim_regs_reg_13__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET469} -new_cell_names {U_PTECO_HOLD_BUF469}
insert_buffer [get_pins {DFT_4/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET470} -new_cell_names {U_PTECO_HOLD_BUF470}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_freq_temp_reg_9_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET471} -new_cell_names {U_PTECO_HOLD_BUF471}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_7__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET472} -new_cell_names {U_PTECO_HOLD_BUF472}
insert_buffer [get_pins {trim_regs_reg_4__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET473} -new_cell_names {U_PTECO_HOLD_BUF473}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_freq_temp_reg_10_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET474} -new_cell_names {U_PTECO_HOLD_BUF474}
insert_buffer [get_pins {led_freq_temp_reg_8_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET475} -new_cell_names {U_PTECO_HOLD_BUF475}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_13__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET476} -new_cell_names {U_PTECO_HOLD_BUF476}
insert_buffer [get_pins {trim_regs_reg_1__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET477} -new_cell_names {U_PTECO_HOLD_BUF477}
insert_buffer [get_pins {trim_regs_reg_11__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET478} -new_cell_names {U_PTECO_HOLD_BUF478}
insert_buffer [get_pins {trim_regs_reg_1__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET479} -new_cell_names {U_PTECO_HOLD_BUF479}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_14/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET480} -new_cell_names {U_PTECO_HOLD_BUF480}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_11_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET481} -new_cell_names {U_PTECO_HOLD_BUF481}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET482} -new_cell_names {U_PTECO_HOLD_BUF482}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_18/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET483} -new_cell_names {U_PTECO_HOLD_BUF483}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_1__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET484} -new_cell_names {U_PTECO_HOLD_BUF484}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET485} -new_cell_names {U_PTECO_HOLD_BUF485}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {led_freq_reg_8_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET486} -new_cell_names {U_PTECO_HOLD_BUF486}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_13__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET487} -new_cell_names {U_PTECO_HOLD_BUF487}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_wr_spi}
insert_buffer [get_pins {data_reg_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET488} -new_cell_names {U_PTECO_HOLD_BUF488}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_read_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET489} -new_cell_names {U_PTECO_HOLD_BUF489}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_EN_sync}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET490} -new_cell_names {U_PTECO_HOLD_BUF490}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_13__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET491} -new_cell_names {U_PTECO_HOLD_BUF491}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET492} -new_cell_names {U_PTECO_HOLD_BUF492}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_5__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET493} -new_cell_names {U_PTECO_HOLD_BUF493}
insert_buffer [get_pins {U528/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET494} -new_cell_names {U_PTECO_HOLD_BUF494}
insert_buffer [get_pins {trim_regs_reg_10__7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET495} -new_cell_names {U_PTECO_HOLD_BUF495}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_12_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET496} -new_cell_names {U_PTECO_HOLD_BUF496}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_14__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET497} -new_cell_names {U_PTECO_HOLD_BUF497}
insert_buffer [get_pins {trim_regs_reg_12__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET498} -new_cell_names {U_PTECO_HOLD_BUF498}
insert_buffer [get_pins {trim_regs_reg_40__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET499} -new_cell_names {U_PTECO_HOLD_BUF499}
insert_buffer [get_pins {U460/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET500} -new_cell_names {U_PTECO_HOLD_BUF500}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_empty_level_sync_7_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET501} -new_cell_names {U_PTECO_HOLD_BUF501}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET502} -new_cell_names {U_PTECO_HOLD_BUF502}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET503} -new_cell_names {U_PTECO_HOLD_BUF503}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_37__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET504} -new_cell_names {U_PTECO_HOLD_BUF504}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET505} -new_cell_names {U_PTECO_HOLD_BUF505}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {led_on_reg_11_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET506} -new_cell_names {U_PTECO_HOLD_BUF506}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {spi_data_all00_reg_4_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET507} -new_cell_names {U_PTECO_HOLD_BUF507}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_EN_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET508} -new_cell_names {U_PTECO_HOLD_BUF508}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {ana_ppg_tia_gain_reg_3_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET509} -new_cell_names {U_PTECO_HOLD_BUF509}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_10_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET510} -new_cell_names {U_PTECO_HOLD_BUF510}
insert_buffer [get_pins {led_on_temp_reg_13_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET511} -new_cell_names {U_PTECO_HOLD_BUF511}
insert_buffer [get_pins {led_freq_temp_reg_13_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET512} -new_cell_names {U_PTECO_HOLD_BUF512}
insert_buffer [get_pins {led_freq_temp_reg_3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET513} -new_cell_names {U_PTECO_HOLD_BUF513}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U739/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET514} -new_cell_names {U_PTECO_HOLD_BUF514}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_freq_temp_reg_11_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET515} -new_cell_names {U_PTECO_HOLD_BUF515}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U714/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET516} -new_cell_names {U_PTECO_HOLD_BUF516}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET517} -new_cell_names {U_PTECO_HOLD_BUF517}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_freq_temp_reg_4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET518} -new_cell_names {U_PTECO_HOLD_BUF518}
insert_buffer [get_pins {led_freq_temp_reg_5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET519} -new_cell_names {U_PTECO_HOLD_BUF519}
insert_buffer [get_pins {led_freq_temp_reg_7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET520} -new_cell_names {U_PTECO_HOLD_BUF520}
insert_buffer [get_pins {led_freq_temp_reg_2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET521} -new_cell_names {U_PTECO_HOLD_BUF521}
insert_buffer [get_pins {led_freq_temp_reg_6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET522} -new_cell_names {U_PTECO_HOLD_BUF522}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_33__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET523} -new_cell_names {U_PTECO_HOLD_BUF523}
insert_buffer [get_pins {trim_regs_reg_47__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET524} -new_cell_names {U_PTECO_HOLD_BUF524}
insert_buffer [get_pins {trim_regs_reg_48__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET525} -new_cell_names {U_PTECO_HOLD_BUF525}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {led_freq_reg_4_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET526} -new_cell_names {U_PTECO_HOLD_BUF526}
insert_buffer [get_pins {led_freq_reg_6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET527} -new_cell_names {U_PTECO_HOLD_BUF527}
insert_buffer [get_pins {led_freq_reg_2_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET528} -new_cell_names {U_PTECO_HOLD_BUF528}
insert_buffer [get_pins {led_freq_reg_7_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET529} -new_cell_names {U_PTECO_HOLD_BUF529}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_8_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET530} -new_cell_names {U_PTECO_HOLD_BUF530}
insert_buffer [get_pins {led_freq_temp_reg_0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET531} -new_cell_names {U_PTECO_HOLD_BUF531}
insert_buffer [get_pins {led_on_temp_reg_9_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET532} -new_cell_names {U_PTECO_HOLD_BUF532}
insert_buffer [get_pins {led_on_temp_reg_7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET533} -new_cell_names {U_PTECO_HOLD_BUF533}
insert_buffer [get_pins {led_on_temp_reg_5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET534} -new_cell_names {U_PTECO_HOLD_BUF534}
insert_buffer [get_pins {led_freq_temp_reg_12_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET535} -new_cell_names {U_PTECO_HOLD_BUF535}
insert_buffer [get_pins {led_on_temp_reg_6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET536} -new_cell_names {U_PTECO_HOLD_BUF536}
insert_buffer [get_pins {led_on_temp_reg_3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET537} -new_cell_names {U_PTECO_HOLD_BUF537}
insert_buffer [get_pins {led_on_temp_reg_4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET538} -new_cell_names {U_PTECO_HOLD_BUF538}
insert_buffer [get_pins {led_on_temp_reg_2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET539} -new_cell_names {U_PTECO_HOLD_BUF539}
insert_buffer [get_pins {led_freq_temp_reg_1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET540} -new_cell_names {U_PTECO_HOLD_BUF540}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_46__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET541} -new_cell_names {U_PTECO_HOLD_BUF541}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {lost_item_count_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET542} -new_cell_names {U_PTECO_HOLD_BUF542}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_acloff_statn/u_dur_sync_pclk}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET543} -new_cell_names {U_PTECO_HOLD_BUF543}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_5__3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET544} -new_cell_names {U_PTECO_HOLD_BUF544}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {led_freq_reg_0_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET545} -new_cell_names {U_PTECO_HOLD_BUF545}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_16/A0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET546} -new_cell_names {U_PTECO_HOLD_BUF546}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {led_on_reg_1_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET547} -new_cell_names {U_PTECO_HOLD_BUF547}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_13/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET548} -new_cell_names {U_PTECO_HOLD_BUF548}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_9__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET549} -new_cell_names {U_PTECO_HOLD_BUF549}
insert_buffer [get_pins {trim_regs_reg_8__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET550} -new_cell_names {U_PTECO_HOLD_BUF550}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {DFT_11/A0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET551} -new_cell_names {U_PTECO_HOLD_BUF551}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {reg_ppg_LED_FREQ_SEL_reg_1_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET552} -new_cell_names {U_PTECO_HOLD_BUF552}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U508/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET553} -new_cell_names {U_PTECO_HOLD_BUF553}
insert_buffer [get_pins {trim_regs_reg_42__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET554} -new_cell_names {U_PTECO_HOLD_BUF554}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {ana_ppg_led_sel_reg_reg_0_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET555} -new_cell_names {U_PTECO_HOLD_BUF555}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U484/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET556} -new_cell_names {U_PTECO_HOLD_BUF556}
insert_buffer [get_pins {U519/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET557} -new_cell_names {U_PTECO_HOLD_BUF557}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_123__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET558} -new_cell_names {U_PTECO_HOLD_BUF558}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U693/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET559} -new_cell_names {U_PTECO_HOLD_BUF559}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {Freq_ctrl_temp_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET560} -new_cell_names {U_PTECO_HOLD_BUF560}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_26/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET561} -new_cell_names {U_PTECO_HOLD_BUF561}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_delta_final_reg_13_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET562} -new_cell_names {U_PTECO_HOLD_BUF562}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_acloff_statn}
insert_buffer [get_pins {leadoff_switch_tgt_cnt_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET563} -new_cell_names {U_PTECO_HOLD_BUF563}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_delta_final_reg_15_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET564} -new_cell_names {U_PTECO_HOLD_BUF564}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {ana_ppg_dac0_ctrl_reg1_reg_2_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET565} -new_cell_names {U_PTECO_HOLD_BUF565}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst/u_fifo_flush_n_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET566} -new_cell_names {U_PTECO_HOLD_BUF566}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U695/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET567} -new_cell_names {U_PTECO_HOLD_BUF567}
insert_buffer [get_pins {trim_regs_reg_13__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET568} -new_cell_names {U_PTECO_HOLD_BUF568}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_acloff_statn}
insert_buffer [get_pins {leadoff_switch_tgt_cnt_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET569} -new_cell_names {U_PTECO_HOLD_BUF569}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_delta_final_reg_10_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET570} -new_cell_names {U_PTECO_HOLD_BUF570}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_7_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET571} -new_cell_names {U_PTECO_HOLD_BUF571}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {ana_ppg_tia_idac_reg_6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET572} -new_cell_names {U_PTECO_HOLD_BUF572}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {spi_addr_all00_reg_1_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET573} -new_cell_names {U_PTECO_HOLD_BUF573}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_delta_final_reg_11_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET574} -new_cell_names {U_PTECO_HOLD_BUF574}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_6__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET575} -new_cell_names {U_PTECO_HOLD_BUF575}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statp/u_dur_sync_pclk}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET576} -new_cell_names {U_PTECO_HOLD_BUF576}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statp/u_switch_rstn_sync}
insert_buffer [get_pins {rst_sync1_n_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET577} -new_cell_names {U_PTECO_HOLD_BUF577}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {ana_ppg_tia_idac_reg_0_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET578} -new_cell_names {U_PTECO_HOLD_BUF578}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_7__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET579} -new_cell_names {U_PTECO_HOLD_BUF579}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statp/u_dur_sync_pclk}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET580} -new_cell_names {U_PTECO_HOLD_BUF580}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U701/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET581} -new_cell_names {U_PTECO_HOLD_BUF581}
insert_buffer [get_pins {U543/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET582} -new_cell_names {U_PTECO_HOLD_BUF582}
insert_buffer [get_pins {U744/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET583} -new_cell_names {U_PTECO_HOLD_BUF583}
insert_buffer [get_pins {trim_regs_reg_1__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET584} -new_cell_names {U_PTECO_HOLD_BUF584}
insert_buffer [get_pins {trim_regs_reg_14__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET585} -new_cell_names {U_PTECO_HOLD_BUF585}
insert_buffer [get_pins {trim_regs_reg_7__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET586} -new_cell_names {U_PTECO_HOLD_BUF586}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_10__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET587} -new_cell_names {U_PTECO_HOLD_BUF587}
insert_buffer [get_pins {trim_reg_reg_10__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET588} -new_cell_names {U_PTECO_HOLD_BUF588}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET589} -new_cell_names {U_PTECO_HOLD_BUF589}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_105__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET590} -new_cell_names {U_PTECO_HOLD_BUF590}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_10_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET591} -new_cell_names {U_PTECO_HOLD_BUF591}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_Freq_sel_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET592} -new_cell_names {U_PTECO_HOLD_BUF592}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {word_count_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET593} -new_cell_names {U_PTECO_HOLD_BUF593}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_11__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET594} -new_cell_names {U_PTECO_HOLD_BUF594}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {flash_nvr_pro00_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET595} -new_cell_names {U_PTECO_HOLD_BUF595}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET596} -new_cell_names {U_PTECO_HOLD_BUF596}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {ana_ppg_dac1_ctrl_reg0_reg_7_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET597} -new_cell_names {U_PTECO_HOLD_BUF597}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_48__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET598} -new_cell_names {U_PTECO_HOLD_BUF598}
insert_buffer [get_pins {trim_regs_reg_48__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET599} -new_cell_names {U_PTECO_HOLD_BUF599}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET600} -new_cell_names {U_PTECO_HOLD_BUF600}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET601} -new_cell_names {U_PTECO_HOLD_BUF601}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_15__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET602} -new_cell_names {U_PTECO_HOLD_BUF602}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET603} -new_cell_names {U_PTECO_HOLD_BUF603}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_8__3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET604} -new_cell_names {U_PTECO_HOLD_BUF604}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {a_empty_n_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET605} -new_cell_names {U_PTECO_HOLD_BUF605}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {DFT_10/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET606} -new_cell_names {U_PTECO_HOLD_BUF606}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET607} -new_cell_names {U_PTECO_HOLD_BUF607}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_104__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET608} -new_cell_names {U_PTECO_HOLD_BUF608}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_9__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET609} -new_cell_names {U_PTECO_HOLD_BUF609}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {empty_n_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET610} -new_cell_names {U_PTECO_HOLD_BUF610}
insert_buffer [get_pins {lost_item_count_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET611} -new_cell_names {U_PTECO_HOLD_BUF611}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_11__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET612} -new_cell_names {U_PTECO_HOLD_BUF612}
insert_buffer [get_pins {trim_regs_reg_9__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET613} -new_cell_names {U_PTECO_HOLD_BUF613}
insert_buffer [get_pins {trim_regs_reg_35__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET614} -new_cell_names {U_PTECO_HOLD_BUF614}
insert_buffer [get_pins {trim_regs_reg_35__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET615} -new_cell_names {U_PTECO_HOLD_BUF615}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_min_final_reg_15_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET616} -new_cell_names {U_PTECO_HOLD_BUF616}
insert_buffer [get_pins {ch0data_max_final_reg_9_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET617} -new_cell_names {U_PTECO_HOLD_BUF617}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_SH_CK_sync}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET618} -new_cell_names {U_PTECO_HOLD_BUF618}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_spi_cer_edge}
insert_buffer [get_pins {d_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET619} -new_cell_names {U_PTECO_HOLD_BUF619}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_44__3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET620} -new_cell_names {U_PTECO_HOLD_BUF620}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET621} -new_cell_names {U_PTECO_HOLD_BUF621}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_delta_final_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET622} -new_cell_names {U_PTECO_HOLD_BUF622}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch1data_reg_reg_15_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET623} -new_cell_names {U_PTECO_HOLD_BUF623}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_8_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET624} -new_cell_names {U_PTECO_HOLD_BUF624}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_EN_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET625} -new_cell_names {U_PTECO_HOLD_BUF625}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_updated_reg_18_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET626} -new_cell_names {U_PTECO_HOLD_BUF626}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_39__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET627} -new_cell_names {U_PTECO_HOLD_BUF627}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_delta_final_reg_8_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET628} -new_cell_names {U_PTECO_HOLD_BUF628}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET629} -new_cell_names {U_PTECO_HOLD_BUF629}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch0data_en_reg_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET630} -new_cell_names {U_PTECO_HOLD_BUF630}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET631} -new_cell_names {U_PTECO_HOLD_BUF631}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_4_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET632} -new_cell_names {U_PTECO_HOLD_BUF632}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET633} -new_cell_names {U_PTECO_HOLD_BUF633}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_20/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET634} -new_cell_names {U_PTECO_HOLD_BUF634}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET635} -new_cell_names {U_PTECO_HOLD_BUF635}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_SH_CK_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET636} -new_cell_names {U_PTECO_HOLD_BUF636}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_72__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET637} -new_cell_names {U_PTECO_HOLD_BUF637}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_EN_PPG_AF_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET638} -new_cell_names {U_PTECO_HOLD_BUF638}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_phase_accumulator}
insert_buffer [get_pins {dds_phase_add_reg_18_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET639} -new_cell_names {U_PTECO_HOLD_BUF639}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {spi_data_all00_reg_1_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET640} -new_cell_names {U_PTECO_HOLD_BUF640}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {ana_ppg_dac0_ctrl_reg0_reg_1_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET641} -new_cell_names {U_PTECO_HOLD_BUF641}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_40__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET642} -new_cell_names {U_PTECO_HOLD_BUF642}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch1data_reg_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET643} -new_cell_names {U_PTECO_HOLD_BUF643}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_35__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET644} -new_cell_names {U_PTECO_HOLD_BUF644}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_63__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET645} -new_cell_names {U_PTECO_HOLD_BUF645}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_EN_PPG_SH_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET646} -new_cell_names {U_PTECO_HOLD_BUF646}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_6_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET647} -new_cell_names {U_PTECO_HOLD_BUF647}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_9_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET648} -new_cell_names {U_PTECO_HOLD_BUF648}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_9_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET649} -new_cell_names {U_PTECO_HOLD_BUF649}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_11_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET650} -new_cell_names {U_PTECO_HOLD_BUF650}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_10_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET651} -new_cell_names {U_PTECO_HOLD_BUF651}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET652} -new_cell_names {U_PTECO_HOLD_BUF652}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_Freq_sel_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET653} -new_cell_names {U_PTECO_HOLD_BUF653}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {ana_ppg_dac1_ctrl_reg1_reg_0_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET654} -new_cell_names {U_PTECO_HOLD_BUF654}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {fsm_counter_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET655} -new_cell_names {U_PTECO_HOLD_BUF655}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch2data_reg_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET656} -new_cell_names {U_PTECO_HOLD_BUF656}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_34__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET657} -new_cell_names {U_PTECO_HOLD_BUF657}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statp}
insert_buffer [get_pins {leadoff_duration_tgt_cnt_reg_1_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET658} -new_cell_names {U_PTECO_HOLD_BUF658}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch0data_reg_reg_13_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET659} -new_cell_names {U_PTECO_HOLD_BUF659}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_30__3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET660} -new_cell_names {U_PTECO_HOLD_BUF660}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LED_STANDBYEN_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET661} -new_cell_names {U_PTECO_HOLD_BUF661}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {Freq_ctrl_temp_reg_6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET662} -new_cell_names {U_PTECO_HOLD_BUF662}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U953/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET663} -new_cell_names {U_PTECO_HOLD_BUF663}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {ana_ppg_dac0_ctrl_reg0_reg_5_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET664} -new_cell_names {U_PTECO_HOLD_BUF664}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET665} -new_cell_names {U_PTECO_HOLD_BUF665}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_22/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET666} -new_cell_names {U_PTECO_HOLD_BUF666}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET667} -new_cell_names {U_PTECO_HOLD_BUF667}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET668} -new_cell_names {U_PTECO_HOLD_BUF668}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {DFT_20/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET669} -new_cell_names {U_PTECO_HOLD_BUF669}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_4_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET670} -new_cell_names {U_PTECO_HOLD_BUF670}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_5_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET671} -new_cell_names {U_PTECO_HOLD_BUF671}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_7_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET672} -new_cell_names {U_PTECO_HOLD_BUF672}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_61__13_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET673} -new_cell_names {U_PTECO_HOLD_BUF673}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_flash_cer}
insert_buffer [get_pins {data_reg_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET674} -new_cell_names {U_PTECO_HOLD_BUF674}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {Freq_ctrl_temp_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET675} -new_cell_names {U_PTECO_HOLD_BUF675}
insert_buffer [get_pins {fsm_counter_reg_10_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET676} -new_cell_names {U_PTECO_HOLD_BUF676}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U951/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET677} -new_cell_names {U_PTECO_HOLD_BUF677}
insert_buffer [get_pins {U950/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET678} -new_cell_names {U_PTECO_HOLD_BUF678}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statn/u_switch_rstn_sync}
insert_buffer [get_pins {rst_sync1_n_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET679} -new_cell_names {U_PTECO_HOLD_BUF679}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_36__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET680} -new_cell_names {U_PTECO_HOLD_BUF680}
insert_buffer [get_pins {trim_regs_reg_32__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET681} -new_cell_names {U_PTECO_HOLD_BUF681}
insert_buffer [get_pins {cunter_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET682} -new_cell_names {U_PTECO_HOLD_BUF682}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_19/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET683} -new_cell_names {U_PTECO_HOLD_BUF683}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_45__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET684} -new_cell_names {U_PTECO_HOLD_BUF684}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {fsm_counter_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET685} -new_cell_names {U_PTECO_HOLD_BUF685}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U850/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET686} -new_cell_names {U_PTECO_HOLD_BUF686}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_Freq_sel_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET687} -new_cell_names {U_PTECO_HOLD_BUF687}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_Freq_sel_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET688} -new_cell_names {U_PTECO_HOLD_BUF688}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET689} -new_cell_names {U_PTECO_HOLD_BUF689}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section4_reg_0__17_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET690} -new_cell_names {U_PTECO_HOLD_BUF690}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U860/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET691} -new_cell_names {U_PTECO_HOLD_BUF691}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {DFT_6/A0}] BUFX4M -new_net_names {net_PTECO_HOLD_NET692} -new_cell_names {U_PTECO_HOLD_BUF692}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U845/A1N}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET693} -new_cell_names {U_PTECO_HOLD_BUF693}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET694} -new_cell_names {U_PTECO_HOLD_BUF694}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET695} -new_cell_names {U_PTECO_HOLD_BUF695}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U878/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET696} -new_cell_names {U_PTECO_HOLD_BUF696}
insert_buffer [get_pins {flash_data_otp_reg_4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET697} -new_cell_names {U_PTECO_HOLD_BUF697}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {zmeas_reg_ctrl_2_reg_0_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET698} -new_cell_names {U_PTECO_HOLD_BUF698}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {DFT_14/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET699} -new_cell_names {U_PTECO_HOLD_BUF699}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {fsm_counter_reg_12_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET700} -new_cell_names {U_PTECO_HOLD_BUF700}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {byte_bit_count_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET701} -new_cell_names {U_PTECO_HOLD_BUF701}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {DFT_4/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET702} -new_cell_names {U_PTECO_HOLD_BUF702}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_34__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET703} -new_cell_names {U_PTECO_HOLD_BUF703}
insert_buffer [get_pins {trim_regs_reg_39__3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET704} -new_cell_names {U_PTECO_HOLD_BUF704}
insert_buffer [get_pins {flash_addr_reg_1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET705} -new_cell_names {U_PTECO_HOLD_BUF705}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {fifo_rd_data_sync_reg_14_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET706} -new_cell_names {U_PTECO_HOLD_BUF706}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U954/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET707} -new_cell_names {U_PTECO_HOLD_BUF707}
insert_buffer [get_pins {U955/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET708} -new_cell_names {U_PTECO_HOLD_BUF708}
insert_buffer [get_pins {U948/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET709} -new_cell_names {U_PTECO_HOLD_BUF709}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {chnum_reg_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET710} -new_cell_names {U_PTECO_HOLD_BUF710}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_39__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET711} -new_cell_names {U_PTECO_HOLD_BUF711}
insert_buffer [get_pins {trim_regs_reg_42__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET712} -new_cell_names {U_PTECO_HOLD_BUF712}
insert_buffer [get_pins {trim_regs_reg_34__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET713} -new_cell_names {U_PTECO_HOLD_BUF713}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch2data_reg_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET714} -new_cell_names {U_PTECO_HOLD_BUF714}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U731/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET715} -new_cell_names {U_PTECO_HOLD_BUF715}
insert_buffer [get_pins {U883/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET716} -new_cell_names {U_PTECO_HOLD_BUF716}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {reg_ppg_ctrl_1_reg_6_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET717} -new_cell_names {U_PTECO_HOLD_BUF717}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_Mode_sel_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET718} -new_cell_names {U_PTECO_HOLD_BUF718}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U868/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET719} -new_cell_names {U_PTECO_HOLD_BUF719}
insert_buffer [get_pins {trim_regs_reg_34__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET720} -new_cell_names {U_PTECO_HOLD_BUF720}
insert_buffer [get_pins {reload_trim_en_lock_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET721} -new_cell_names {U_PTECO_HOLD_BUF721}
insert_buffer [get_pins {U855/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET722} -new_cell_names {U_PTECO_HOLD_BUF722}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET723} -new_cell_names {U_PTECO_HOLD_BUF723}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_max_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET724} -new_cell_names {U_PTECO_HOLD_BUF724}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U481/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET725} -new_cell_names {U_PTECO_HOLD_BUF725}
insert_buffer [get_pins {U909/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET726} -new_cell_names {U_PTECO_HOLD_BUF726}
insert_buffer [get_pins {trim_regs_reg_2__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET727} -new_cell_names {U_PTECO_HOLD_BUF727}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {fsm_counter_reg_9_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET728} -new_cell_names {U_PTECO_HOLD_BUF728}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U887/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET729} -new_cell_names {U_PTECO_HOLD_BUF729}
current_instance
current_instance {u_top_dig/u_imeas/u_filter1_sync_adcclk}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET730} -new_cell_names {U_PTECO_HOLD_BUF730}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_reg}
insert_buffer [get_pins {U15/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET731} -new_cell_names {U_PTECO_HOLD_BUF731}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {fifo_intr_local_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET732} -new_cell_names {U_PTECO_HOLD_BUF732}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_8_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET733} -new_cell_names {U_PTECO_HOLD_BUF733}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led1_working_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET734} -new_cell_names {U_PTECO_HOLD_BUF734}
insert_buffer [get_pins {cur_state_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET735} -new_cell_names {U_PTECO_HOLD_BUF735}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cdc/u_filter0_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET736} -new_cell_names {U_PTECO_HOLD_BUF736}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_60__16_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET737} -new_cell_names {U_PTECO_HOLD_BUF737}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U872/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET738} -new_cell_names {U_PTECO_HOLD_BUF738}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section1_reg_1__22_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET739} -new_cell_names {U_PTECO_HOLD_BUF739}
insert_buffer [get_pins {delay_section4_reg_0__23_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET740} -new_cell_names {U_PTECO_HOLD_BUF740}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cdc/u_ppg_sh_ck_sync}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET741} -new_cell_names {U_PTECO_HOLD_BUF741}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_Mode_sel_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET742} -new_cell_names {U_PTECO_HOLD_BUF742}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_0_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET743} -new_cell_names {U_PTECO_HOLD_BUF743}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section2_reg_1__22_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET744} -new_cell_names {U_PTECO_HOLD_BUF744}
insert_buffer [get_pins {delay_section2_reg_0__21_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET745} -new_cell_names {U_PTECO_HOLD_BUF745}
insert_buffer [get_pins {delay_section2_reg_1__20_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET746} -new_cell_names {U_PTECO_HOLD_BUF746}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_7_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET747} -new_cell_names {U_PTECO_HOLD_BUF747}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_PDV_REF_SEL_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET748} -new_cell_names {U_PTECO_HOLD_BUF748}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET749} -new_cell_names {U_PTECO_HOLD_BUF749}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_6_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET750} -new_cell_names {U_PTECO_HOLD_BUF750}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LEDSEL_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET751} -new_cell_names {U_PTECO_HOLD_BUF751}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_43__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET752} -new_cell_names {U_PTECO_HOLD_BUF752}
insert_buffer [get_pins {trim_regs_reg_43__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET753} -new_cell_names {U_PTECO_HOLD_BUF753}
insert_buffer [get_pins {U602/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET754} -new_cell_names {U_PTECO_HOLD_BUF754}
insert_buffer [get_pins {U608/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET755} -new_cell_names {U_PTECO_HOLD_BUF755}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section3_reg_0__20_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET756} -new_cell_names {U_PTECO_HOLD_BUF756}
insert_buffer [get_pins {delay_section3_reg_0__21_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET757} -new_cell_names {U_PTECO_HOLD_BUF757}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cdc/u_filter0_sync}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET758} -new_cell_names {U_PTECO_HOLD_BUF758}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cdc/u_ppg_sh_ck_sync}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET759} -new_cell_names {U_PTECO_HOLD_BUF759}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LED_EN_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET760} -new_cell_names {U_PTECO_HOLD_BUF760}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET761} -new_cell_names {U_PTECO_HOLD_BUF761}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LEDSEL_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET762} -new_cell_names {U_PTECO_HOLD_BUF762}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U864/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET763} -new_cell_names {U_PTECO_HOLD_BUF763}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {Freq_ctrl_temp_reg_5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET764} -new_cell_names {U_PTECO_HOLD_BUF764}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U606/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET765} -new_cell_names {U_PTECO_HOLD_BUF765}
insert_buffer [get_pins {U890/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET766} -new_cell_names {U_PTECO_HOLD_BUF766}
insert_buffer [get_pins {U875/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET767} -new_cell_names {U_PTECO_HOLD_BUF767}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_11_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET768} -new_cell_names {U_PTECO_HOLD_BUF768}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_24__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET769} -new_cell_names {U_PTECO_HOLD_BUF769}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {U55/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET770} -new_cell_names {U_PTECO_HOLD_BUF770}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {DFT_18/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET771} -new_cell_names {U_PTECO_HOLD_BUF771}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET772} -new_cell_names {U_PTECO_HOLD_BUF772}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_62__15_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET773} -new_cell_names {U_PTECO_HOLD_BUF773}
insert_buffer [get_pins {mem_reg_62__14_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET774} -new_cell_names {U_PTECO_HOLD_BUF774}
insert_buffer [get_pins {mem_reg_63__12_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET775} -new_cell_names {U_PTECO_HOLD_BUF775}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch2data_reg_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET776} -new_cell_names {U_PTECO_HOLD_BUF776}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_3_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET777} -new_cell_names {U_PTECO_HOLD_BUF777}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statn/u_switch_rstn_sync}
insert_buffer [get_pins {rst_sync0_n_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET778} -new_cell_names {U_PTECO_HOLD_BUF778}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U706/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET779} -new_cell_names {U_PTECO_HOLD_BUF779}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {square_clk_div_1_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET780} -new_cell_names {U_PTECO_HOLD_BUF780}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_4_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET781} -new_cell_names {U_PTECO_HOLD_BUF781}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET782} -new_cell_names {U_PTECO_HOLD_BUF782}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U727/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET783} -new_cell_names {U_PTECO_HOLD_BUF783}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {dc_data_reg_0_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET784} -new_cell_names {U_PTECO_HOLD_BUF784}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_bwdctrl}
insert_buffer [get_pins {sinrom_reg1_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET785} -new_cell_names {U_PTECO_HOLD_BUF785}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_4_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET786} -new_cell_names {U_PTECO_HOLD_BUF786}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_TEST_OUT_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET787} -new_cell_names {U_PTECO_HOLD_BUF787}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_bwdctrl}
insert_buffer [get_pins {sinrom_reg1_reg_7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET788} -new_cell_names {U_PTECO_HOLD_BUF788}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_Mode_sel_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET789} -new_cell_names {U_PTECO_HOLD_BUF789}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section3_reg_0__22_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET790} -new_cell_names {U_PTECO_HOLD_BUF790}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_PDV_REF_SEL_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET791} -new_cell_names {U_PTECO_HOLD_BUF791}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_TEST_IN_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET792} -new_cell_names {U_PTECO_HOLD_BUF792}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_102__14_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET793} -new_cell_names {U_PTECO_HOLD_BUF793}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_TEST_IN_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET794} -new_cell_names {U_PTECO_HOLD_BUF794}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_TEST_OUT_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET795} -new_cell_names {U_PTECO_HOLD_BUF795}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ3_reg_27_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET796} -new_cell_names {U_PTECO_HOLD_BUF796}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_bwdctrl}
insert_buffer [get_pins {sinrom_reg1_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET797} -new_cell_names {U_PTECO_HOLD_BUF797}
insert_buffer [get_pins {summation_real_reg_26_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET798} -new_cell_names {U_PTECO_HOLD_BUF798}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U895/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET799} -new_cell_names {U_PTECO_HOLD_BUF799}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_rw_ctrl/u_flash_rw_fsm/u_flash_dslp_sync}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET800} -new_cell_names {U_PTECO_HOLD_BUF800}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U741/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET801} -new_cell_names {U_PTECO_HOLD_BUF801}
insert_buffer [get_pins {trim_regs_reg_14__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET802} -new_cell_names {U_PTECO_HOLD_BUF802}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {cur_state_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET803} -new_cell_names {U_PTECO_HOLD_BUF803}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statn/u_dur_sync_pclk}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET804} -new_cell_names {U_PTECO_HOLD_BUF804}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET805} -new_cell_names {U_PTECO_HOLD_BUF805}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_bwdctrl}
insert_buffer [get_pins {summation_offset_forreal_reg_14_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET806} -new_cell_names {U_PTECO_HOLD_BUF806}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_rw_ctrl/u_flash_rw_fsm}
insert_buffer [get_pins {timer_cnt_reg_reg_15_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET807} -new_cell_names {U_PTECO_HOLD_BUF807}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {mode_cunter_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET808} -new_cell_names {U_PTECO_HOLD_BUF808}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET809} -new_cell_names {U_PTECO_HOLD_BUF809}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {chnum_reg_reg_2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET810} -new_cell_names {U_PTECO_HOLD_BUF810}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_reg}
insert_buffer [get_pins {U16/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET811} -new_cell_names {U_PTECO_HOLD_BUF811}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {clk_ctrl_reg_reg_7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET812} -new_cell_names {U_PTECO_HOLD_BUF812}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {iclk_div_cnt_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET813} -new_cell_names {U_PTECO_HOLD_BUF813}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_109__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET814} -new_cell_names {U_PTECO_HOLD_BUF814}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_6_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET815} -new_cell_names {U_PTECO_HOLD_BUF815}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {storage_state_in4_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET816} -new_cell_names {U_PTECO_HOLD_BUF816}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_0__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET817} -new_cell_names {U_PTECO_HOLD_BUF817}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {ana_tsc_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET818} -new_cell_names {U_PTECO_HOLD_BUF818}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U724/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET819} -new_cell_names {U_PTECO_HOLD_BUF819}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_rw_ctrl/u_flash_rw_fsm}
insert_buffer [get_pins {state_reg_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET820} -new_cell_names {U_PTECO_HOLD_BUF820}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_1_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET821} -new_cell_names {U_PTECO_HOLD_BUF821}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_EN_TIA_VREFBUFFER_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET822} -new_cell_names {U_PTECO_HOLD_BUF822}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl}
insert_buffer [get_pins {settling_time_flag_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET823} -new_cell_names {U_PTECO_HOLD_BUF823}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_reg}
insert_buffer [get_pins {U11/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET824} -new_cell_names {U_PTECO_HOLD_BUF824}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_123__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET825} -new_cell_names {U_PTECO_HOLD_BUF825}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_EN_PPGDAC_BUFFER_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET826} -new_cell_names {U_PTECO_HOLD_BUF826}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_9__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET827} -new_cell_names {U_PTECO_HOLD_BUF827}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET828} -new_cell_names {U_PTECO_HOLD_BUF828}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_78__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET829} -new_cell_names {U_PTECO_HOLD_BUF829}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {comb1_reg_25_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET830} -new_cell_names {U_PTECO_HOLD_BUF830}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {flash_unlock_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET831} -new_cell_names {U_PTECO_HOLD_BUF831}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl}
insert_buffer [get_pins {freq_phjmp_reg_reg_12_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET832} -new_cell_names {U_PTECO_HOLD_BUF832}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {U247/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET833} -new_cell_names {U_PTECO_HOLD_BUF833}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_delta_final_reg_14_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET834} -new_cell_names {U_PTECO_HOLD_BUF834}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {lost_item_count_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET835} -new_cell_names {U_PTECO_HOLD_BUF835}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_ovf_cnt_sync_0_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET836} -new_cell_names {U_PTECO_HOLD_BUF836}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {flash_nvr_pro01_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET837} -new_cell_names {U_PTECO_HOLD_BUF837}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section2_reg_1__19_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET838} -new_cell_names {U_PTECO_HOLD_BUF838}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_27__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET839} -new_cell_names {U_PTECO_HOLD_BUF839}
insert_buffer [get_pins {trim_regs_reg_26__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET840} -new_cell_names {U_PTECO_HOLD_BUF840}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_reg}
insert_buffer [get_pins {int_sts_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET841} -new_cell_names {U_PTECO_HOLD_BUF841}
insert_buffer [get_pins {int_sts0_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET842} -new_cell_names {U_PTECO_HOLD_BUF842}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {lost_item_count_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET843} -new_cell_names {U_PTECO_HOLD_BUF843}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_6_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET844} -new_cell_names {U_PTECO_HOLD_BUF844}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_imeas}
insert_buffer [get_pins {leadoff_tgt_1_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET845} -new_cell_names {U_PTECO_HOLD_BUF845}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {pmu_reg0_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET846} -new_cell_names {U_PTECO_HOLD_BUF846}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl}
insert_buffer [get_pins {start_counting_settling_time_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET847} -new_cell_names {U_PTECO_HOLD_BUF847}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_3__9_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET848} -new_cell_names {U_PTECO_HOLD_BUF848}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_Mode_sel_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET849} -new_cell_names {U_PTECO_HOLD_BUF849}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_17__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET850} -new_cell_names {U_PTECO_HOLD_BUF850}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET851} -new_cell_names {U_PTECO_HOLD_BUF851}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_124__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET852} -new_cell_names {U_PTECO_HOLD_BUF852}
insert_buffer [get_pins {mem_reg_27__14_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET853} -new_cell_names {U_PTECO_HOLD_BUF853}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_bwdctrl}
insert_buffer [get_pins {summation_real_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET854} -new_cell_names {U_PTECO_HOLD_BUF854}
insert_buffer [get_pins {cosrom_reg1_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET855} -new_cell_names {U_PTECO_HOLD_BUF855}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET856} -new_cell_names {U_PTECO_HOLD_BUF856}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_bwdctrl}
insert_buffer [get_pins {summation_imag_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET857} -new_cell_names {U_PTECO_HOLD_BUF857}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_delta_final_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET858} -new_cell_names {U_PTECO_HOLD_BUF858}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_reg}
insert_buffer [get_pins {int_sts1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET859} -new_cell_names {U_PTECO_HOLD_BUF859}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_bwdctrl}
insert_buffer [get_pins {summation_offset_forreal_reg_8_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET860} -new_cell_names {U_PTECO_HOLD_BUF860}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statp}
insert_buffer [get_pins {leadoff_switch_tgt_cnt_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET861} -new_cell_names {U_PTECO_HOLD_BUF861}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_bwdctrl}
insert_buffer [get_pins {shiftedimag_inter_reg_13_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET862} -new_cell_names {U_PTECO_HOLD_BUF862}
insert_buffer [get_pins {shiftedimag_inter_reg_15_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET863} -new_cell_names {U_PTECO_HOLD_BUF863}
insert_buffer [get_pins {sinrom_reg1_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET864} -new_cell_names {U_PTECO_HOLD_BUF864}
insert_buffer [get_pins {shiftedimag_inter_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET865} -new_cell_names {U_PTECO_HOLD_BUF865}
insert_buffer [get_pins {xn_data_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET866} -new_cell_names {U_PTECO_HOLD_BUF866}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {zmeas_reg_ctrl_3_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET867} -new_cell_names {U_PTECO_HOLD_BUF867}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_bwdctrl}
insert_buffer [get_pins {shiftedreal_inter_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET868} -new_cell_names {U_PTECO_HOLD_BUF868}
insert_buffer [get_pins {xn_data_reg_7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET869} -new_cell_names {U_PTECO_HOLD_BUF869}
insert_buffer [get_pins {shiftedimag_inter_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET870} -new_cell_names {U_PTECO_HOLD_BUF870}
insert_buffer [get_pins {shiftedimag_inter_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET871} -new_cell_names {U_PTECO_HOLD_BUF871}
insert_buffer [get_pins {shiftedimag_inter_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET872} -new_cell_names {U_PTECO_HOLD_BUF872}
insert_buffer [get_pins {xn_data_reg_9_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET873} -new_cell_names {U_PTECO_HOLD_BUF873}
insert_buffer [get_pins {shiftedimag_inter_reg_8_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET874} -new_cell_names {U_PTECO_HOLD_BUF874}
insert_buffer [get_pins {shiftedreal_inter_reg_11_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET875} -new_cell_names {U_PTECO_HOLD_BUF875}
insert_buffer [get_pins {cosrom_reg1_reg_9_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET876} -new_cell_names {U_PTECO_HOLD_BUF876}
insert_buffer [get_pins {shiftedimag_inter_reg_9_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET877} -new_cell_names {U_PTECO_HOLD_BUF877}
insert_buffer [get_pins {shiftedimag_inter_reg_7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET878} -new_cell_names {U_PTECO_HOLD_BUF878}
insert_buffer [get_pins {summation_offset_forreal_reg_16_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET879} -new_cell_names {U_PTECO_HOLD_BUF879}
insert_buffer [get_pins {summation_offset_forreal_reg_24_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET880} -new_cell_names {U_PTECO_HOLD_BUF880}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {spi_addr_all00_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET881} -new_cell_names {U_PTECO_HOLD_BUF881}
insert_buffer [get_pins {flash_ctrl_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET882} -new_cell_names {U_PTECO_HOLD_BUF882}
insert_buffer [get_pins {spi_addr_all01_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET883} -new_cell_names {U_PTECO_HOLD_BUF883}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {square_clk_div_0_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET884} -new_cell_names {U_PTECO_HOLD_BUF884}
insert_buffer [get_pins {led_on_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET885} -new_cell_names {U_PTECO_HOLD_BUF885}
insert_buffer [get_pins {led_on_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET886} -new_cell_names {U_PTECO_HOLD_BUF886}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_empty_level_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET887} -new_cell_names {U_PTECO_HOLD_BUF887}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {square_clk_div_0_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET888} -new_cell_names {U_PTECO_HOLD_BUF888}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {spi_addr_all01_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET889} -new_cell_names {U_PTECO_HOLD_BUF889}
insert_buffer [get_pins {spi_addr_all01_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET890} -new_cell_names {U_PTECO_HOLD_BUF890}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {square_clk_div_1_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET891} -new_cell_names {U_PTECO_HOLD_BUF891}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET892} -new_cell_names {U_PTECO_HOLD_BUF892}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_empty_level_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET893} -new_cell_names {U_PTECO_HOLD_BUF893}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET894} -new_cell_names {U_PTECO_HOLD_BUF894}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_TIA_IDAC_sync_5_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET895} -new_cell_names {U_PTECO_HOLD_BUF895}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_data_cnt_sync_4_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET896} -new_cell_names {U_PTECO_HOLD_BUF896}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_rd_ptr_sync_0_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET897} -new_cell_names {U_PTECO_HOLD_BUF897}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_data_cnt_sync_2_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET898} -new_cell_names {U_PTECO_HOLD_BUF898}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_ovf_cnt_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET899} -new_cell_names {U_PTECO_HOLD_BUF899}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_124__14_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET900} -new_cell_names {U_PTECO_HOLD_BUF900}
insert_buffer [get_pins {mem_reg_125__13_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET901} -new_cell_names {U_PTECO_HOLD_BUF901}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_data_cnt_sync_5_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET902} -new_cell_names {U_PTECO_HOLD_BUF902}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {U55/A0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET903} -new_cell_names {U_PTECO_HOLD_BUF903}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_wr_ptr_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET904} -new_cell_names {U_PTECO_HOLD_BUF904}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET905} -new_cell_names {U_PTECO_HOLD_BUF905}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_roll_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET906} -new_cell_names {U_PTECO_HOLD_BUF906}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {storage_state_in3_reg_22_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET907} -new_cell_names {U_PTECO_HOLD_BUF907}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_TIA_IDAC_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET908} -new_cell_names {U_PTECO_HOLD_BUF908}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_7_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET909} -new_cell_names {U_PTECO_HOLD_BUF909}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {U271/A0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET910} -new_cell_names {U_PTECO_HOLD_BUF910}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_33__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET911} -new_cell_names {U_PTECO_HOLD_BUF911}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {storage_state_in1_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET912} -new_cell_names {U_PTECO_HOLD_BUF912}
insert_buffer [get_pins {delay_section1_reg_1__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET913} -new_cell_names {U_PTECO_HOLD_BUF913}
current_instance
current_instance {top_dig_always_on_inst/reset_ctrl_always_on_inst/u_por_resetn_sync}
insert_buffer [get_pins {rst_sync1_n_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET914} -new_cell_names {U_PTECO_HOLD_BUF914}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {flash_nvr_pro00_reg_7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET915} -new_cell_names {U_PTECO_HOLD_BUF915}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_109__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET916} -new_cell_names {U_PTECO_HOLD_BUF916}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_outdrv/u_leddca_sel}
insert_buffer [get_pins {outreg_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET917} -new_cell_names {U_PTECO_HOLD_BUF917}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_empty_level_sync_4_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET918} -new_cell_names {U_PTECO_HOLD_BUF918}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET919} -new_cell_names {U_PTECO_HOLD_BUF919}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_empty_level_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET920} -new_cell_names {U_PTECO_HOLD_BUF920}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {prev_stg_op1_reg_12_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET921} -new_cell_names {U_PTECO_HOLD_BUF921}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_4_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET922} -new_cell_names {U_PTECO_HOLD_BUF922}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_empty_level_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET923} -new_cell_names {U_PTECO_HOLD_BUF923}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_outdrv/u_standby}
insert_buffer [get_pins {outreg_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET924} -new_cell_names {U_PTECO_HOLD_BUF924}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {DFT_9/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET925} -new_cell_names {U_PTECO_HOLD_BUF925}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {U55/C1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET926} -new_cell_names {U_PTECO_HOLD_BUF926}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_phase_accumulator}
insert_buffer [get_pins {freq_phjmp_reg_reg_12_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET927} -new_cell_names {U_PTECO_HOLD_BUF927}
insert_buffer [get_pins {freq_phjmp_reg_reg_8_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET928} -new_cell_names {U_PTECO_HOLD_BUF928}
insert_buffer [get_pins {freq_phjmp_reg_reg_15_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET929} -new_cell_names {U_PTECO_HOLD_BUF929}
insert_buffer [get_pins {freq_phjmp_reg_reg_13_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET930} -new_cell_names {U_PTECO_HOLD_BUF930}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_BIS_016K29DE/u_data_generator}
insert_buffer [get_pins {s2p_data_reg_12_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET931} -new_cell_names {U_PTECO_HOLD_BUF931}
insert_buffer [get_pins {s2p_sreg_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET932} -new_cell_names {U_PTECO_HOLD_BUF932}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_flush_n_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET933} -new_cell_names {U_PTECO_HOLD_BUF933}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl}
insert_buffer [get_pins {config_output_voltage_range_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET934} -new_cell_names {U_PTECO_HOLD_BUF934}
insert_buffer [get_pins {measure_calibrate_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET935} -new_cell_names {U_PTECO_HOLD_BUF935}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_rd_ptr_sync_5_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET936} -new_cell_names {U_PTECO_HOLD_BUF936}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET937} -new_cell_names {U_PTECO_HOLD_BUF937}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_EN_TIA_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET938} -new_cell_names {U_PTECO_HOLD_BUF938}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_empty_level_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET939} -new_cell_names {U_PTECO_HOLD_BUF939}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LED_EN_sync}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET940} -new_cell_names {U_PTECO_HOLD_BUF940}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_TEST_IN_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET941} -new_cell_names {U_PTECO_HOLD_BUF941}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {mclk_div_reg_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET942} -new_cell_names {U_PTECO_HOLD_BUF942}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {leadclk_div_cnt_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET943} -new_cell_names {U_PTECO_HOLD_BUF943}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_EN_PPG_BUFFER_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET944} -new_cell_names {U_PTECO_HOLD_BUF944}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {dc_data_reg_0_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET945} -new_cell_names {U_PTECO_HOLD_BUF945}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {acleadoff_clk_reg_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET946} -new_cell_names {U_PTECO_HOLD_BUF946}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl}
insert_buffer [get_pins {pga_gain_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET947} -new_cell_names {U_PTECO_HOLD_BUF947}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {mclk_div_cnt_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET948} -new_cell_names {U_PTECO_HOLD_BUF948}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_common_sync_bit}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET949} -new_cell_names {U_PTECO_HOLD_BUF949}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {checking_clk_div_reg_hi_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET950} -new_cell_names {U_PTECO_HOLD_BUF950}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_imeas}
insert_buffer [get_pins {threshold_lo_0_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET951} -new_cell_names {U_PTECO_HOLD_BUF951}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl}
insert_buffer [get_pins {reg_status_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET952} -new_cell_names {U_PTECO_HOLD_BUF952}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_rom}
insert_buffer [get_pins {rom_data_out_dac_reg_7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET953} -new_cell_names {U_PTECO_HOLD_BUF953}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {checking_clk_div_reg_hi_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET954} -new_cell_names {U_PTECO_HOLD_BUF954}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET955} -new_cell_names {U_PTECO_HOLD_BUF955}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET956} -new_cell_names {U_PTECO_HOLD_BUF956}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_28__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET957} -new_cell_names {U_PTECO_HOLD_BUF957}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_0__9_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET958} -new_cell_names {U_PTECO_HOLD_BUF958}
insert_buffer [get_pins {mem_reg_3__14_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET959} -new_cell_names {U_PTECO_HOLD_BUF959}
insert_buffer [get_pins {mem_reg_0__11_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET960} -new_cell_names {U_PTECO_HOLD_BUF960}
insert_buffer [get_pins {mem_reg_124__11_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET961} -new_cell_names {U_PTECO_HOLD_BUF961}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_1_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET962} -new_cell_names {U_PTECO_HOLD_BUF962}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_3__3_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET963} -new_cell_names {U_PTECO_HOLD_BUF963}
insert_buffer [get_pins {mem_reg_0__13_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET964} -new_cell_names {U_PTECO_HOLD_BUF964}
insert_buffer [get_pins {mem_reg_0__10_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET965} -new_cell_names {U_PTECO_HOLD_BUF965}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_3_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET966} -new_cell_names {U_PTECO_HOLD_BUF966}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_0__12_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET967} -new_cell_names {U_PTECO_HOLD_BUF967}
insert_buffer [get_pins {mem_reg_27__7_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET968} -new_cell_names {U_PTECO_HOLD_BUF968}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_rom}
insert_buffer [get_pins {rom_data_out_dac_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET969} -new_cell_names {U_PTECO_HOLD_BUF969}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_38__3_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET970} -new_cell_names {U_PTECO_HOLD_BUF970}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_max_final_reg_13_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET971} -new_cell_names {U_PTECO_HOLD_BUF971}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {square_clk_div_0_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET972} -new_cell_names {U_PTECO_HOLD_BUF972}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LED_EN_sync}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET973} -new_cell_names {U_PTECO_HOLD_BUF973}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_32__7_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET974} -new_cell_names {U_PTECO_HOLD_BUF974}
insert_buffer [get_pins {U334/B0}] BUFX8M -new_net_names {net_PTECO_HOLD_NET975} -new_cell_names {U_PTECO_HOLD_BUF975}
insert_buffer [get_pins {trim_regs_reg_31__3_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET976} -new_cell_names {U_PTECO_HOLD_BUF976}
insert_buffer [get_pins {U315/B0}] BUFX8M -new_net_names {net_PTECO_HOLD_NET977} -new_cell_names {U_PTECO_HOLD_BUF977}
insert_buffer [get_pins {trim_regs_reg_40__3_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET978} -new_cell_names {U_PTECO_HOLD_BUF978}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_0_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET979} -new_cell_names {U_PTECO_HOLD_BUF979}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_sync_by_pass_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET980} -new_cell_names {U_PTECO_HOLD_BUF980}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {storage_state_in2_reg_9_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET981} -new_cell_names {U_PTECO_HOLD_BUF981}
insert_buffer [get_pins {storage_state_in2_reg_8_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET982} -new_cell_names {U_PTECO_HOLD_BUF982}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_13__4_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET983} -new_cell_names {U_PTECO_HOLD_BUF983}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LEDSEL_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX8M -new_net_names {net_PTECO_HOLD_NET984} -new_cell_names {U_PTECO_HOLD_BUF984}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_0__6_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET985} -new_cell_names {U_PTECO_HOLD_BUF985}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section1_reg_0__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET986} -new_cell_names {U_PTECO_HOLD_BUF986}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_PDV_REF_SEL_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX8M -new_net_names {net_PTECO_HOLD_NET987} -new_cell_names {U_PTECO_HOLD_BUF987}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_46__1_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET988} -new_cell_names {U_PTECO_HOLD_BUF988}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_outdrv}
insert_buffer [get_pins {IDAC_LEDSEL_sync3_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET989} -new_cell_names {U_PTECO_HOLD_BUF989}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_BIS_016K29DE/u_data_generator}
insert_buffer [get_pins {dg_data_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET990} -new_cell_names {U_PTECO_HOLD_BUF990}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LEDSEL_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET991} -new_cell_names {U_PTECO_HOLD_BUF991}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_42__4_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET992} -new_cell_names {U_PTECO_HOLD_BUF992}
insert_buffer [get_pins {trim_regs_reg_1__7_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET993} -new_cell_names {U_PTECO_HOLD_BUF993}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch2data_reg_reg_2_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET994} -new_cell_names {U_PTECO_HOLD_BUF994}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_0__0_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET995} -new_cell_names {U_PTECO_HOLD_BUF995}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {mclk_reg_reg/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET996} -new_cell_names {U_PTECO_HOLD_BUF996}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cdc/u_filter0_sync}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET997} -new_cell_names {U_PTECO_HOLD_BUF997}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cdc/u_filter1_sync}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET998} -new_cell_names {U_PTECO_HOLD_BUF998}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {lost_item_count_reg_4_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET999} -new_cell_names {U_PTECO_HOLD_BUF999}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_TIA_GAIN_sync_1_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1000} -new_cell_names {U_PTECO_HOLD_BUF1000}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {C659/B}] BUFX8M -new_net_names {net_PTECO_HOLD_NET1001} -new_cell_names {U_PTECO_HOLD_BUF1001}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_TIA_GAIN_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1002} -new_cell_names {U_PTECO_HOLD_BUF1002}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_max_final_reg_14_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1003} -new_cell_names {U_PTECO_HOLD_BUF1003}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl}
insert_buffer [get_pins {config_output_voltage_range_reg_1_/D}] BUFX8M -new_net_names {net_PTECO_HOLD_NET1004} -new_cell_names {U_PTECO_HOLD_BUF1004}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_38__5_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1005} -new_cell_names {U_PTECO_HOLD_BUF1005}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {rd_addr_local_reg_5_/SI}] BUFX8M -new_net_names {net_PTECO_HOLD_NET1006} -new_cell_names {U_PTECO_HOLD_BUF1006}
insert_buffer [get_pins {wr_addr_local_reg_4_/SI}] BUFX8M -new_net_names {net_PTECO_HOLD_NET1007} -new_cell_names {U_PTECO_HOLD_BUF1007}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {fifo_rd_data_sync_reg_12_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1008} -new_cell_names {U_PTECO_HOLD_BUF1008}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {square_data_temp_reg_reg_2_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1009} -new_cell_names {U_PTECO_HOLD_BUF1009}
insert_buffer [get_pins {square_data_temp_reg_reg_0_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1010} -new_cell_names {U_PTECO_HOLD_BUF1010}
insert_buffer [get_pins {square_data_temp_reg_reg_3_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1011} -new_cell_names {U_PTECO_HOLD_BUF1011}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {fifo_rd_data_sync_reg_6_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1012} -new_cell_names {U_PTECO_HOLD_BUF1012}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {rd_addr_local_reg_6_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1013} -new_cell_names {U_PTECO_HOLD_BUF1013}
insert_buffer [get_pins {rd_addr_local_reg_3_/SI}] BUFX8M -new_net_names {net_PTECO_HOLD_NET1014} -new_cell_names {U_PTECO_HOLD_BUF1014}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {acrldoff_clk_reg_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1015} -new_cell_names {U_PTECO_HOLD_BUF1015}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_BIS_016K29DE/u_data_generator}
insert_buffer [get_pins {s2p_data_reg_19_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1016} -new_cell_names {U_PTECO_HOLD_BUF1016}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {accum_reg_reg_13_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1017} -new_cell_names {U_PTECO_HOLD_BUF1017}
insert_buffer [get_pins {accum_reg_reg_9_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1018} -new_cell_names {U_PTECO_HOLD_BUF1018}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {word_count_reg_3_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1019} -new_cell_names {U_PTECO_HOLD_BUF1019}
insert_buffer [get_pins {wr_addr_local_reg_1_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1020} -new_cell_names {U_PTECO_HOLD_BUF1020}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {dc_data_reg_0_reg_6_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1021} -new_cell_names {U_PTECO_HOLD_BUF1021}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl}
insert_buffer [get_pins {reg_status_reg_11_/D}] BUFX8M -new_net_names {net_PTECO_HOLD_NET1022} -new_cell_names {U_PTECO_HOLD_BUF1022}
insert_buffer [get_pins {reg_status_reg_12_/D}] BUFX8M -new_net_names {net_PTECO_HOLD_NET1023} -new_cell_names {U_PTECO_HOLD_BUF1023}
insert_buffer [get_pins {reg_status_reg_10_/D}] BUFX8M -new_net_names {net_PTECO_HOLD_NET1024} -new_cell_names {U_PTECO_HOLD_BUF1024}
insert_buffer [get_pins {reg_status_reg_13_/D}] BUFX8M -new_net_names {net_PTECO_HOLD_NET1025} -new_cell_names {U_PTECO_HOLD_BUF1025}
insert_buffer [get_pins {config_output_voltage_range_reg_0_/D}] BUFX8M -new_net_names {net_PTECO_HOLD_NET1026} -new_cell_names {U_PTECO_HOLD_BUF1026}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {word_count_reg_7_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1027} -new_cell_names {U_PTECO_HOLD_BUF1027}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_56__15_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1028} -new_cell_names {U_PTECO_HOLD_BUF1028}
insert_buffer [get_pins {mem_reg_27__10_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1029} -new_cell_names {U_PTECO_HOLD_BUF1029}
insert_buffer [get_pins {mem_reg_57__17_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1030} -new_cell_names {U_PTECO_HOLD_BUF1030}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_TIA_IDAC_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX8M -new_net_names {net_PTECO_HOLD_NET1031} -new_cell_names {U_PTECO_HOLD_BUF1031}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {storage_state_in2_reg_11_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1032} -new_cell_names {U_PTECO_HOLD_BUF1032}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl}
insert_buffer [get_pins {adc_enable_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1033} -new_cell_names {U_PTECO_HOLD_BUF1033}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {checking_clk_div_reg_lo_reg_3_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1034} -new_cell_names {U_PTECO_HOLD_BUF1034}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {input_register_reg_10_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1035} -new_cell_names {U_PTECO_HOLD_BUF1035}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_26__2_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1036} -new_cell_names {U_PTECO_HOLD_BUF1036}
insert_buffer [get_pins {mem_reg_27__0_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1037} -new_cell_names {U_PTECO_HOLD_BUF1037}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {mclk_div_cnt_reg_2_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1038} -new_cell_names {U_PTECO_HOLD_BUF1038}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section1_reg_0__26_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1039} -new_cell_names {U_PTECO_HOLD_BUF1039}
insert_buffer [get_pins {delay_section3_reg_0__23_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1040} -new_cell_names {U_PTECO_HOLD_BUF1040}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_56__16_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1041} -new_cell_names {U_PTECO_HOLD_BUF1041}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_acloff_statn/u_dur_sync_pclk}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1042} -new_cell_names {U_PTECO_HOLD_BUF1042}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_58__7_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1043} -new_cell_names {U_PTECO_HOLD_BUF1043}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_8__7_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1044} -new_cell_names {U_PTECO_HOLD_BUF1044}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_1_}
insert_buffer [get_pins {async_in_d2_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1045} -new_cell_names {U_PTECO_HOLD_BUF1045}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_24__15_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1046} -new_cell_names {U_PTECO_HOLD_BUF1046}
insert_buffer [get_pins {mem_reg_25__13_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1047} -new_cell_names {U_PTECO_HOLD_BUF1047}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section3_reg_1__24_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1048} -new_cell_names {U_PTECO_HOLD_BUF1048}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_25__0_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1049} -new_cell_names {U_PTECO_HOLD_BUF1049}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl}
insert_buffer [get_pins {reg_status_reg_9_/SI}] BUFX8M -new_net_names {net_PTECO_HOLD_NET1050} -new_cell_names {U_PTECO_HOLD_BUF1050}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_27__9_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1051} -new_cell_names {U_PTECO_HOLD_BUF1051}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statp}
insert_buffer [get_pins {leadoff_switch_tgt_cnt_reg_1_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1052} -new_cell_names {U_PTECO_HOLD_BUF1052}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_26__13_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1053} -new_cell_names {U_PTECO_HOLD_BUF1053}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_8__4_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1054} -new_cell_names {U_PTECO_HOLD_BUF1054}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {ana_tsc_reg_6_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1055} -new_cell_names {U_PTECO_HOLD_BUF1055}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_updated_reg_7_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1056} -new_cell_names {U_PTECO_HOLD_BUF1056}
insert_buffer [get_pins {trim_reg_updated_reg_15_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1057} -new_cell_names {U_PTECO_HOLD_BUF1057}
current_instance
current_instance {u_top_dig/u_ppg_controller}
insert_buffer [get_pins {Sig_Sel_sync1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1058} -new_cell_names {U_PTECO_HOLD_BUF1058}
current_instance
current_instance {u_top_dig/u_zmeas}
insert_buffer [get_pins {U188/B0}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1059} -new_cell_names {U_PTECO_HOLD_BUF1059}
insert_buffer [get_pins {U171/B0}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1060} -new_cell_names {U_PTECO_HOLD_BUF1060}
insert_buffer [get_pins {U52/B0}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1061} -new_cell_names {U_PTECO_HOLD_BUF1061}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statp}
insert_buffer [get_pins {leadoff_switch_tgt_cnt_reg_7_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1062} -new_cell_names {U_PTECO_HOLD_BUF1062}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_BIS_016K29DE/u_data_generator}
insert_buffer [get_pins {serout_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1063} -new_cell_names {U_PTECO_HOLD_BUF1063}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_acloff_statn}
insert_buffer [get_pins {leadoff_duration_tgt_cnt_reg_14_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1064} -new_cell_names {U_PTECO_HOLD_BUF1064}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_full_sync}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1065} -new_cell_names {U_PTECO_HOLD_BUF1065}
current_instance
current_instance {u_top_dig/u_zmeas}
insert_buffer [get_pins {U210/B0}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1066} -new_cell_names {U_PTECO_HOLD_BUF1066}
insert_buffer [get_pins {U253/B0}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1067} -new_cell_names {U_PTECO_HOLD_BUF1067}
insert_buffer [get_pins {U220/B0}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1068} -new_cell_names {U_PTECO_HOLD_BUF1068}
insert_buffer [get_pins {U156/B0}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1069} -new_cell_names {U_PTECO_HOLD_BUF1069}
insert_buffer [get_pins {U200/B0}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1070} -new_cell_names {U_PTECO_HOLD_BUF1070}
insert_buffer [get_pins {U239/B0}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1071} -new_cell_names {U_PTECO_HOLD_BUF1071}
insert_buffer [get_pins {U230/B0}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1072} -new_cell_names {U_PTECO_HOLD_BUF1072}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_acloff_statn}
insert_buffer [get_pins {which_switch_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1073} -new_cell_names {U_PTECO_HOLD_BUF1073}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_BIS_016K29DE/u_data_generator}
insert_buffer [get_pins {s2p_data_reg_9_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1074} -new_cell_names {U_PTECO_HOLD_BUF1074}
insert_buffer [get_pins {s2p_sreg_reg_18_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1075} -new_cell_names {U_PTECO_HOLD_BUF1075}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section2_reg_0__25_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1076} -new_cell_names {U_PTECO_HOLD_BUF1076}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_BIS_016K29DE/u_data_generator}
insert_buffer [get_pins {s2p_sreg_reg_34_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1077} -new_cell_names {U_PTECO_HOLD_BUF1077}
insert_buffer [get_pins {s2p_sreg_reg_9_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1078} -new_cell_names {U_PTECO_HOLD_BUF1078}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {leadoff_clk_reg_reg_1_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1079} -new_cell_names {U_PTECO_HOLD_BUF1079}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_IDAC_LED_SEL_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1080} -new_cell_names {U_PTECO_HOLD_BUF1080}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_15/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1081} -new_cell_names {U_PTECO_HOLD_BUF1081}
insert_buffer [get_pins {DFT_4/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1082} -new_cell_names {U_PTECO_HOLD_BUF1082}
insert_buffer [get_pins {DFT_8/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1083} -new_cell_names {U_PTECO_HOLD_BUF1083}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_acloff_statn}
insert_buffer [get_pins {leadoff_duration_tgt_cnt_reg_8_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1084} -new_cell_names {U_PTECO_HOLD_BUF1084}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U867/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1085} -new_cell_names {U_PTECO_HOLD_BUF1085}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {notch_filter_enable_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1086} -new_cell_names {U_PTECO_HOLD_BUF1086}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_BIS_016K29DE/u_command_detector}
insert_buffer [get_pins {state_reg_3_/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1087} -new_cell_names {U_PTECO_HOLD_BUF1087}
current_instance
current_instance {top_dig_always_on_inst/pinmux_always_on_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1088} -new_cell_names {U_PTECO_HOLD_BUF1088}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1089} -new_cell_names {U_PTECO_HOLD_BUF1089}
current_instance
current_instance {top_dig_always_on_inst/reset_ctrl_always_on_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF3/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1090} -new_cell_names {U_PTECO_HOLD_BUF1090}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF5/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1091} -new_cell_names {U_PTECO_HOLD_BUF1091}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF4/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1092} -new_cell_names {U_PTECO_HOLD_BUF1092}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF7/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1094} -new_cell_names {U_PTECO_HOLD_BUF1094}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF8/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1095} -new_cell_names {U_PTECO_HOLD_BUF1095}
insert_buffer [get_pins {U_PTECO_HOLD_BUF13/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1096} -new_cell_names {U_PTECO_HOLD_BUF1096}
insert_buffer [get_pins {U_PTECO_HOLD_BUF18/A}] BUFX24M -new_net_names {net_PTECO_HOLD_NET1097} -new_cell_names {U_PTECO_HOLD_BUF1097}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF11/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1098} -new_cell_names {U_PTECO_HOLD_BUF1098}
insert_buffer [get_pins {U_PTECO_HOLD_BUF12/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1099} -new_cell_names {U_PTECO_HOLD_BUF1099}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF21/A}] BUFX24M -new_net_names {net_PTECO_HOLD_NET1100} -new_cell_names {U_PTECO_HOLD_BUF1100}
insert_buffer [get_pins {U_PTECO_HOLD_BUF14/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1101} -new_cell_names {U_PTECO_HOLD_BUF1101}
insert_buffer [get_pins {U_PTECO_HOLD_BUF15/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1102} -new_cell_names {U_PTECO_HOLD_BUF1102}
insert_buffer [get_pins {U_PTECO_HOLD_BUF22/A}] BUFX24M -new_net_names {net_PTECO_HOLD_NET1103} -new_cell_names {U_PTECO_HOLD_BUF1103}
insert_buffer [get_pins {U_PTECO_HOLD_BUF16/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1104} -new_cell_names {U_PTECO_HOLD_BUF1104}
insert_buffer [get_pins {U_PTECO_HOLD_BUF17/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1105} -new_cell_names {U_PTECO_HOLD_BUF1105}
insert_buffer [get_pins {U_PTECO_HOLD_BUF26/A}] BUFX24M -new_net_names {net_PTECO_HOLD_NET1106} -new_cell_names {U_PTECO_HOLD_BUF1106}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF25/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1107} -new_cell_names {U_PTECO_HOLD_BUF1107}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF23/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1108} -new_cell_names {U_PTECO_HOLD_BUF1108}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF30/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1109} -new_cell_names {U_PTECO_HOLD_BUF1109}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF24/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1110} -new_cell_names {U_PTECO_HOLD_BUF1110}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF29/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1111} -new_cell_names {U_PTECO_HOLD_BUF1111}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF28/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1112} -new_cell_names {U_PTECO_HOLD_BUF1112}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF32/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1113} -new_cell_names {U_PTECO_HOLD_BUF1113}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF27/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1114} -new_cell_names {U_PTECO_HOLD_BUF1114}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF38/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1115} -new_cell_names {U_PTECO_HOLD_BUF1115}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF31/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1116} -new_cell_names {U_PTECO_HOLD_BUF1116}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF39/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1117} -new_cell_names {U_PTECO_HOLD_BUF1117}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF34/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1118} -new_cell_names {U_PTECO_HOLD_BUF1118}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF42/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1119} -new_cell_names {U_PTECO_HOLD_BUF1119}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF35/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1120} -new_cell_names {U_PTECO_HOLD_BUF1120}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF33/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1121} -new_cell_names {U_PTECO_HOLD_BUF1121}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF46/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1122} -new_cell_names {U_PTECO_HOLD_BUF1122}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF41/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1123} -new_cell_names {U_PTECO_HOLD_BUF1123}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF37/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1124} -new_cell_names {U_PTECO_HOLD_BUF1124}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF47/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1125} -new_cell_names {U_PTECO_HOLD_BUF1125}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF36/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1126} -new_cell_names {U_PTECO_HOLD_BUF1126}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF43/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1127} -new_cell_names {U_PTECO_HOLD_BUF1127}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF49/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1128} -new_cell_names {U_PTECO_HOLD_BUF1128}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF40/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1129} -new_cell_names {U_PTECO_HOLD_BUF1129}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF45/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1130} -new_cell_names {U_PTECO_HOLD_BUF1130}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF54/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1131} -new_cell_names {U_PTECO_HOLD_BUF1131}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF48/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1132} -new_cell_names {U_PTECO_HOLD_BUF1132}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1133} -new_cell_names {U_PTECO_HOLD_BUF1133}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF56/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1134} -new_cell_names {U_PTECO_HOLD_BUF1134}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF53/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1135} -new_cell_names {U_PTECO_HOLD_BUF1135}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF59/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1136} -new_cell_names {U_PTECO_HOLD_BUF1136}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF55/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1137} -new_cell_names {U_PTECO_HOLD_BUF1137}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF51/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1138} -new_cell_names {U_PTECO_HOLD_BUF1138}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF63/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1139} -new_cell_names {U_PTECO_HOLD_BUF1139}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U455/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1140} -new_cell_names {U_PTECO_HOLD_BUF1140}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF58/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1141} -new_cell_names {U_PTECO_HOLD_BUF1141}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF52/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1142} -new_cell_names {U_PTECO_HOLD_BUF1142}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF66/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1143} -new_cell_names {U_PTECO_HOLD_BUF1143}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF57/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1144} -new_cell_names {U_PTECO_HOLD_BUF1144}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF62/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1145} -new_cell_names {U_PTECO_HOLD_BUF1145}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF68/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1146} -new_cell_names {U_PTECO_HOLD_BUF1146}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF60/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1147} -new_cell_names {U_PTECO_HOLD_BUF1147}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF64/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1148} -new_cell_names {U_PTECO_HOLD_BUF1148}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF61/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1149} -new_cell_names {U_PTECO_HOLD_BUF1149}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF67/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1150} -new_cell_names {U_PTECO_HOLD_BUF1150}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF72/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1151} -new_cell_names {U_PTECO_HOLD_BUF1151}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF65/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1152} -new_cell_names {U_PTECO_HOLD_BUF1152}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF76/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1153} -new_cell_names {U_PTECO_HOLD_BUF1153}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF71/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1154} -new_cell_names {U_PTECO_HOLD_BUF1154}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF69/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1155} -new_cell_names {U_PTECO_HOLD_BUF1155}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF79/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1156} -new_cell_names {U_PTECO_HOLD_BUF1156}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF75/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1157} -new_cell_names {U_PTECO_HOLD_BUF1157}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF70/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1158} -new_cell_names {U_PTECO_HOLD_BUF1158}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF82/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1159} -new_cell_names {U_PTECO_HOLD_BUF1159}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF78/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1160} -new_cell_names {U_PTECO_HOLD_BUF1160}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF73/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1161} -new_cell_names {U_PTECO_HOLD_BUF1161}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF84/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1162} -new_cell_names {U_PTECO_HOLD_BUF1162}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF81/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1163} -new_cell_names {U_PTECO_HOLD_BUF1163}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF77/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1164} -new_cell_names {U_PTECO_HOLD_BUF1164}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF83/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1165} -new_cell_names {U_PTECO_HOLD_BUF1165}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF87/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1166} -new_cell_names {U_PTECO_HOLD_BUF1166}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF86/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1167} -new_cell_names {U_PTECO_HOLD_BUF1167}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF90/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1168} -new_cell_names {U_PTECO_HOLD_BUF1168}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_20_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1169} -new_cell_names {U_PTECO_HOLD_BUF1169}
current_instance
current_instance {u_top_dig}
insert_buffer [get_pins {U_PTECO_HOLD_BUF19/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1170} -new_cell_names {U_PTECO_HOLD_BUF1170}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF9/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1171} -new_cell_names {U_PTECO_HOLD_BUF1171}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF89/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1172} -new_cell_names {U_PTECO_HOLD_BUF1172}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_21_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1173} -new_cell_names {U_PTECO_HOLD_BUF1173}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF93/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1174} -new_cell_names {U_PTECO_HOLD_BUF1174}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF20/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1175} -new_cell_names {U_PTECO_HOLD_BUF1175}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF92/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1176} -new_cell_names {U_PTECO_HOLD_BUF1176}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_22_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1177} -new_cell_names {U_PTECO_HOLD_BUF1177}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF96/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1178} -new_cell_names {U_PTECO_HOLD_BUF1178}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_23_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1179} -new_cell_names {U_PTECO_HOLD_BUF1179}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF95/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1180} -new_cell_names {U_PTECO_HOLD_BUF1180}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF99/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1181} -new_cell_names {U_PTECO_HOLD_BUF1181}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF94/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1182} -new_cell_names {U_PTECO_HOLD_BUF1182}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF98/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1183} -new_cell_names {U_PTECO_HOLD_BUF1183}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF102/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1184} -new_cell_names {U_PTECO_HOLD_BUF1184}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF97/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1185} -new_cell_names {U_PTECO_HOLD_BUF1185}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF101/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1186} -new_cell_names {U_PTECO_HOLD_BUF1186}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF100/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1187} -new_cell_names {U_PTECO_HOLD_BUF1187}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF105/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1188} -new_cell_names {U_PTECO_HOLD_BUF1188}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF104/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1189} -new_cell_names {U_PTECO_HOLD_BUF1189}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF103/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1190} -new_cell_names {U_PTECO_HOLD_BUF1190}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF109/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1191} -new_cell_names {U_PTECO_HOLD_BUF1191}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF106/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1192} -new_cell_names {U_PTECO_HOLD_BUF1192}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF108/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1193} -new_cell_names {U_PTECO_HOLD_BUF1193}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF107/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1194} -new_cell_names {U_PTECO_HOLD_BUF1194}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF112/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1195} -new_cell_names {U_PTECO_HOLD_BUF1195}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF111/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1196} -new_cell_names {U_PTECO_HOLD_BUF1196}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF110/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1197} -new_cell_names {U_PTECO_HOLD_BUF1197}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF121/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1198} -new_cell_names {U_PTECO_HOLD_BUF1198}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF114/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1199} -new_cell_names {U_PTECO_HOLD_BUF1199}
insert_buffer [get_pins {U_PTECO_HOLD_BUF115/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1200} -new_cell_names {U_PTECO_HOLD_BUF1200}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF120/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1201} -new_cell_names {U_PTECO_HOLD_BUF1201}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF117/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1202} -new_cell_names {U_PTECO_HOLD_BUF1202}
insert_buffer [get_pins {U_PTECO_HOLD_BUF122/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1203} -new_cell_names {U_PTECO_HOLD_BUF1203}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF128/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1204} -new_cell_names {U_PTECO_HOLD_BUF1204}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF129/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1205} -new_cell_names {U_PTECO_HOLD_BUF1205}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_14_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF131/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1206} -new_cell_names {U_PTECO_HOLD_BUF1206}
current_instance
current_instance {u_top_dig/rst_ctrl_inst/u_presetn_sync}
insert_buffer [get_pins {U3/A0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1207} -new_cell_names {U_PTECO_HOLD_BUF1207}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_15_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF133/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1208} -new_cell_names {U_PTECO_HOLD_BUF1208}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_17_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF134/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1209} -new_cell_names {U_PTECO_HOLD_BUF1209}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF138/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1210} -new_cell_names {U_PTECO_HOLD_BUF1210}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF139/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1211} -new_cell_names {U_PTECO_HOLD_BUF1211}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_unlock_sync}
insert_buffer [get_pins {U_PTECO_HOLD_BUF123/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1212} -new_cell_names {U_PTECO_HOLD_BUF1212}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_spi_wr_command_sync}
insert_buffer [get_pins {U_PTECO_HOLD_BUF124/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1213} -new_cell_names {U_PTECO_HOLD_BUF1213}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF147/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1214} -new_cell_names {U_PTECO_HOLD_BUF1214}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_empty_level_sync_7_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF501/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1215} -new_cell_names {U_PTECO_HOLD_BUF1215}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_empty_level_sync_6_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF438/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1216} -new_cell_names {U_PTECO_HOLD_BUF1216}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_3_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF142/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1217} -new_cell_names {U_PTECO_HOLD_BUF1217}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_11_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF143/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1218} -new_cell_names {U_PTECO_HOLD_BUF1218}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_spi_ser_sync}
insert_buffer [get_pins {U_PTECO_HOLD_BUF125/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1219} -new_cell_names {U_PTECO_HOLD_BUF1219}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_8_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF146/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1220} -new_cell_names {U_PTECO_HOLD_BUF1220}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_rw_ctrl/u_flash_rw_fsm/u_flash_dslp_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1221} -new_cell_names {U_PTECO_HOLD_BUF1221}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF149/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1222} -new_cell_names {U_PTECO_HOLD_BUF1222}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_atm_unlock_edge}
insert_buffer [get_pins {d_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1223} -new_cell_names {U_PTECO_HOLD_BUF1223}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_4_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF153/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1224} -new_cell_names {U_PTECO_HOLD_BUF1224}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_9_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF150/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1225} -new_cell_names {U_PTECO_HOLD_BUF1225}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_spi_cer_edge}
insert_buffer [get_pins {d_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1226} -new_cell_names {U_PTECO_HOLD_BUF1226}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_spi_rd_command_sync_edge}
insert_buffer [get_pins {d_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1227} -new_cell_names {U_PTECO_HOLD_BUF1227}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_7_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF154/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1228} -new_cell_names {U_PTECO_HOLD_BUF1228}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_16_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF156/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1229} -new_cell_names {U_PTECO_HOLD_BUF1229}
current_instance
current_instance {u_top_dig/u_imeas/u_acSTATP_sync_pclk}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1230} -new_cell_names {U_PTECO_HOLD_BUF1230}
current_instance
current_instance {u_top_dig/u_imeas/u_acSTATN_sync_pclk}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1231} -new_cell_names {U_PTECO_HOLD_BUF1231}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_analog_test_mode_sync}
insert_buffer [get_pins {U_PTECO_HOLD_BUF113/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1232} -new_cell_names {U_PTECO_HOLD_BUF1232}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_phase_accumulator}
insert_buffer [get_pins {dds_state_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1233} -new_cell_names {U_PTECO_HOLD_BUF1233}
insert_buffer [get_pins {freq_phjmp_reg_reg_1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1234} -new_cell_names {U_PTECO_HOLD_BUF1234}
insert_buffer [get_pins {freq_phjmp_reg_reg_10_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1235} -new_cell_names {U_PTECO_HOLD_BUF1235}
insert_buffer [get_pins {freq_phjmp_reg_reg_3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1236} -new_cell_names {U_PTECO_HOLD_BUF1236}
insert_buffer [get_pins {freq_phjmp_reg_reg_2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1237} -new_cell_names {U_PTECO_HOLD_BUF1237}
insert_buffer [get_pins {freq_phjmp_reg_reg_19_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1238} -new_cell_names {U_PTECO_HOLD_BUF1238}
insert_buffer [get_pins {freq_phjmp_reg_reg_8_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1239} -new_cell_names {U_PTECO_HOLD_BUF1239}
insert_buffer [get_pins {freq_phjmp_reg_reg_0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1240} -new_cell_names {U_PTECO_HOLD_BUF1240}
insert_buffer [get_pins {freq_phjmp_reg_reg_5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1241} -new_cell_names {U_PTECO_HOLD_BUF1241}
insert_buffer [get_pins {freq_phjmp_reg_reg_7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1242} -new_cell_names {U_PTECO_HOLD_BUF1242}
insert_buffer [get_pins {freq_phjmp_reg_reg_20_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1243} -new_cell_names {U_PTECO_HOLD_BUF1243}
insert_buffer [get_pins {freq_phjmp_reg_reg_9_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1244} -new_cell_names {U_PTECO_HOLD_BUF1244}
insert_buffer [get_pins {freq_phjmp_reg_reg_4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1245} -new_cell_names {U_PTECO_HOLD_BUF1245}
insert_buffer [get_pins {freq_phjmp_reg_reg_16_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1246} -new_cell_names {U_PTECO_HOLD_BUF1246}
insert_buffer [get_pins {freq_phjmp_reg_reg_13_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1247} -new_cell_names {U_PTECO_HOLD_BUF1247}
insert_buffer [get_pins {freq_phjmp_reg_reg_15_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1248} -new_cell_names {U_PTECO_HOLD_BUF1248}
insert_buffer [get_pins {freq_phjmp_reg_reg_14_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1249} -new_cell_names {U_PTECO_HOLD_BUF1249}
insert_buffer [get_pins {U74/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1250} -new_cell_names {U_PTECO_HOLD_BUF1250}
insert_buffer [get_pins {U80/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1251} -new_cell_names {U_PTECO_HOLD_BUF1251}
insert_buffer [get_pins {U79/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1252} -new_cell_names {U_PTECO_HOLD_BUF1252}
insert_buffer [get_pins {freq_phjmp_reg_reg_11_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1253} -new_cell_names {U_PTECO_HOLD_BUF1253}
insert_buffer [get_pins {freq_phjmp_reg_reg_6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1254} -new_cell_names {U_PTECO_HOLD_BUF1254}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_empty_level_sync_5_}
insert_buffer [get_pins {async_in_d2_reg/Q}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1255} -new_cell_names {U_PTECO_HOLD_BUF1255}
current_instance
current_instance {top_dig_always_on_inst/reset_ctrl_always_on_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF135/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1256} -new_cell_names {U_PTECO_HOLD_BUF1256}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF152/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1257} -new_cell_names {U_PTECO_HOLD_BUF1257}
insert_buffer [get_pins {U_PTECO_HOLD_BUF145/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1258} -new_cell_names {U_PTECO_HOLD_BUF1258}
current_instance
current_instance {u_top_dig/rst_ctrl_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF261/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1259} -new_cell_names {U_PTECO_HOLD_BUF1259}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_spi_nvr_sync}
insert_buffer [get_pins {U_PTECO_HOLD_BUF155/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1260} -new_cell_names {U_PTECO_HOLD_BUF1260}
current_instance
current_instance {top_dig_always_on_inst/reset_ctrl_always_on_inst/u_sw_por_resetn_sync}
insert_buffer [get_pins {U6/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1261} -new_cell_names {U_PTECO_HOLD_BUF1261}
current_instance
current_instance {top_dig_always_on_inst/reset_ctrl_always_on_inst/u_por_resetn_sync}
insert_buffer [get_pins {rst_sync2_n_reg/RN}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1262} -new_cell_names {U_PTECO_HOLD_BUF1262}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {fifo_rd_data_sync_reg_0_/D}] BUFX8M -new_net_names {net_PTECO_HOLD_NET1263} -new_cell_names {U_PTECO_HOLD_BUF1263}
current_instance
current_instance {u_top_dig/u_imeas/u_STATN_sync_pclk}
insert_buffer [get_pins {async_in_d1_reg/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1264} -new_cell_names {U_PTECO_HOLD_BUF1264}
current_instance
current_instance {u_top_dig/u_imeas/u_STATP_sync_pclk}
insert_buffer [get_pins {async_in_d1_reg/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1265} -new_cell_names {U_PTECO_HOLD_BUF1265}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {checking_clk_div_cnt_reg_11_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1266} -new_cell_names {U_PTECO_HOLD_BUF1266}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {o_wr_data_reg_1_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1267} -new_cell_names {U_PTECO_HOLD_BUF1267}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {checking_clk_div_cnt_reg_12_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1268} -new_cell_names {U_PTECO_HOLD_BUF1268}
insert_buffer [get_pins {U_PTECO_HOLD_BUF248/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1269} -new_cell_names {U_PTECO_HOLD_BUF1269}
insert_buffer [get_pins {U_PTECO_HOLD_BUF249/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1270} -new_cell_names {U_PTECO_HOLD_BUF1270}
insert_buffer [get_pins {checking_clk_div_cnt_reg_10_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1271} -new_cell_names {U_PTECO_HOLD_BUF1271}
insert_buffer [get_pins {U_PTECO_HOLD_BUF250/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1272} -new_cell_names {U_PTECO_HOLD_BUF1272}
insert_buffer [get_pins {U_PTECO_HOLD_BUF252/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1273} -new_cell_names {U_PTECO_HOLD_BUF1273}
insert_buffer [get_pins {U_PTECO_HOLD_BUF253/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1274} -new_cell_names {U_PTECO_HOLD_BUF1274}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {U442/B1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1275} -new_cell_names {U_PTECO_HOLD_BUF1275}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {fifo_rd_data_sync_reg_1_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1276} -new_cell_names {U_PTECO_HOLD_BUF1276}
insert_buffer [get_pins {fifo_rd_data_sync_reg_12_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1277} -new_cell_names {U_PTECO_HOLD_BUF1277}
insert_buffer [get_pins {fifo_rd_data_sync_reg_2_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1278} -new_cell_names {U_PTECO_HOLD_BUF1278}
insert_buffer [get_pins {fifo_rd_data_sync_reg_13_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1279} -new_cell_names {U_PTECO_HOLD_BUF1279}
insert_buffer [get_pins {fifo_rd_data_sync_reg_5_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1280} -new_cell_names {U_PTECO_HOLD_BUF1280}
insert_buffer [get_pins {fifo_rd_data_sync_reg_6_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1281} -new_cell_names {U_PTECO_HOLD_BUF1281}
insert_buffer [get_pins {fifo_rd_data_sync_reg_10_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1282} -new_cell_names {U_PTECO_HOLD_BUF1282}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U593/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1283} -new_cell_names {U_PTECO_HOLD_BUF1283}
insert_buffer [get_pins {U453/Y}] BUFX32M -new_net_names {net_PTECO_HOLD_NET1284} -new_cell_names {U_PTECO_HOLD_BUF1284}
insert_buffer [get_pins {U_PTECO_HOLD_BUF273/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1285} -new_cell_names {U_PTECO_HOLD_BUF1285}
insert_buffer [get_pins {U_PTECO_HOLD_BUF44/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1286} -new_cell_names {U_PTECO_HOLD_BUF1286}
insert_buffer [get_pins {U_PTECO_HOLD_BUF80/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1287} -new_cell_names {U_PTECO_HOLD_BUF1287}
current_instance
current_instance {top_dig_always_on_inst/pinmux_always_on_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF290/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1288} -new_cell_names {U_PTECO_HOLD_BUF1288}
insert_buffer [get_pins {U_PTECO_HOLD_BUF291/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1289} -new_cell_names {U_PTECO_HOLD_BUF1289}
insert_buffer [get_pins {U_PTECO_HOLD_BUF288/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1290} -new_cell_names {U_PTECO_HOLD_BUF1290}
insert_buffer [get_pins {U_PTECO_HOLD_BUF292/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1291} -new_cell_names {U_PTECO_HOLD_BUF1291}
insert_buffer [get_pins {U_PTECO_HOLD_BUF293/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1292} -new_cell_names {U_PTECO_HOLD_BUF1292}
insert_buffer [get_pins {U_PTECO_HOLD_BUF294/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1293} -new_cell_names {U_PTECO_HOLD_BUF1293}
insert_buffer [get_pins {U_PTECO_HOLD_BUF295/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1294} -new_cell_names {U_PTECO_HOLD_BUF1294}
insert_buffer [get_pins {U_PTECO_HOLD_BUF296/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1295} -new_cell_names {U_PTECO_HOLD_BUF1295}
insert_buffer [get_pins {U_PTECO_HOLD_BUF297/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1296} -new_cell_names {U_PTECO_HOLD_BUF1296}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF338/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1297} -new_cell_names {U_PTECO_HOLD_BUF1297}
insert_buffer [get_pins {U_PTECO_HOLD_BUF305/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1298} -new_cell_names {U_PTECO_HOLD_BUF1298}
insert_buffer [get_pins {U_PTECO_HOLD_BUF335/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1299} -new_cell_names {U_PTECO_HOLD_BUF1299}
insert_buffer [get_pins {U_PTECO_HOLD_BUF313/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1300} -new_cell_names {U_PTECO_HOLD_BUF1300}
insert_buffer [get_pins {U_PTECO_HOLD_BUF329/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1301} -new_cell_names {U_PTECO_HOLD_BUF1301}
insert_buffer [get_pins {U_PTECO_HOLD_BUF328/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1302} -new_cell_names {U_PTECO_HOLD_BUF1302}
insert_buffer [get_pins {U_PTECO_HOLD_BUF336/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1303} -new_cell_names {U_PTECO_HOLD_BUF1303}
insert_buffer [get_pins {U_PTECO_HOLD_BUF337/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1304} -new_cell_names {U_PTECO_HOLD_BUF1304}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section4_reg_0__19_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1305} -new_cell_names {U_PTECO_HOLD_BUF1305}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_25__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1306} -new_cell_names {U_PTECO_HOLD_BUF1306}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section4_reg_0__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1307} -new_cell_names {U_PTECO_HOLD_BUF1307}
insert_buffer [get_pins {delay_section4_reg_0__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1308} -new_cell_names {U_PTECO_HOLD_BUF1308}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_24__12_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1309} -new_cell_names {U_PTECO_HOLD_BUF1309}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_17__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1310} -new_cell_names {U_PTECO_HOLD_BUF1310}
insert_buffer [get_pins {trim_regs_reg_17__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1311} -new_cell_names {U_PTECO_HOLD_BUF1311}
insert_buffer [get_pins {trim_regs_reg_9__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1312} -new_cell_names {U_PTECO_HOLD_BUF1312}
insert_buffer [get_pins {trim_regs_reg_16__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1313} -new_cell_names {U_PTECO_HOLD_BUF1313}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF443/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1314} -new_cell_names {U_PTECO_HOLD_BUF1314}
insert_buffer [get_pins {U_PTECO_HOLD_BUF445/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1315} -new_cell_names {U_PTECO_HOLD_BUF1315}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_5__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1316} -new_cell_names {U_PTECO_HOLD_BUF1316}
insert_buffer [get_pins {trim_regs_reg_16__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1317} -new_cell_names {U_PTECO_HOLD_BUF1317}
insert_buffer [get_pins {trim_regs_reg_5__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1318} -new_cell_names {U_PTECO_HOLD_BUF1318}
insert_buffer [get_pins {trim_regs_reg_16__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1319} -new_cell_names {U_PTECO_HOLD_BUF1319}
insert_buffer [get_pins {trim_regs_reg_16__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1320} -new_cell_names {U_PTECO_HOLD_BUF1320}
insert_buffer [get_pins {trim_regs_reg_18__7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1321} -new_cell_names {U_PTECO_HOLD_BUF1321}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {U_PTECO_HOLD_BUF432/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1322} -new_cell_names {U_PTECO_HOLD_BUF1322}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF446/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1323} -new_cell_names {U_PTECO_HOLD_BUF1323}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {rnd_regs_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1324} -new_cell_names {U_PTECO_HOLD_BUF1324}
insert_buffer [get_pins {trim_regs_reg_5__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1325} -new_cell_names {U_PTECO_HOLD_BUF1325}
insert_buffer [get_pins {reg_confen_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1326} -new_cell_names {U_PTECO_HOLD_BUF1326}
insert_buffer [get_pins {reg_confen_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1327} -new_cell_names {U_PTECO_HOLD_BUF1327}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {U_PTECO_HOLD_BUF352/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1328} -new_cell_names {U_PTECO_HOLD_BUF1328}
insert_buffer [get_pins {U_PTECO_HOLD_BUF353/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1329} -new_cell_names {U_PTECO_HOLD_BUF1329}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF459/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1330} -new_cell_names {U_PTECO_HOLD_BUF1330}
insert_buffer [get_pins {U734/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1331} -new_cell_names {U_PTECO_HOLD_BUF1331}
insert_buffer [get_pins {trim_regs_reg_8__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1332} -new_cell_names {U_PTECO_HOLD_BUF1332}
insert_buffer [get_pins {trim_regs_reg_10__3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1333} -new_cell_names {U_PTECO_HOLD_BUF1333}
insert_buffer [get_pins {trim_regs_reg_10__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1334} -new_cell_names {U_PTECO_HOLD_BUF1334}
insert_buffer [get_pins {regs_confen_data_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1335} -new_cell_names {U_PTECO_HOLD_BUF1335}
insert_buffer [get_pins {trim_regs_reg_10__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1336} -new_cell_names {U_PTECO_HOLD_BUF1336}
insert_buffer [get_pins {trim_regs_reg_18__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1337} -new_cell_names {U_PTECO_HOLD_BUF1337}
insert_buffer [get_pins {trim_regs_reg_16__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1338} -new_cell_names {U_PTECO_HOLD_BUF1338}
insert_buffer [get_pins {trim_regs_reg_5__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1339} -new_cell_names {U_PTECO_HOLD_BUF1339}
insert_buffer [get_pins {trim_regs_reg_44__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1340} -new_cell_names {U_PTECO_HOLD_BUF1340}
insert_buffer [get_pins {trim_regs_reg_9__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1341} -new_cell_names {U_PTECO_HOLD_BUF1341}
insert_buffer [get_pins {trim_regs_reg_18__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1342} -new_cell_names {U_PTECO_HOLD_BUF1342}
insert_buffer [get_pins {U_PTECO_HOLD_BUF468/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1343} -new_cell_names {U_PTECO_HOLD_BUF1343}
insert_buffer [get_pins {trim_regs_reg_19__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1344} -new_cell_names {U_PTECO_HOLD_BUF1344}
insert_buffer [get_pins {DFT_4/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1345} -new_cell_names {U_PTECO_HOLD_BUF1345}
insert_buffer [get_pins {trim_regs_reg_12__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1346} -new_cell_names {U_PTECO_HOLD_BUF1346}
insert_buffer [get_pins {trim_regs_reg_16__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1347} -new_cell_names {U_PTECO_HOLD_BUF1347}
insert_buffer [get_pins {trim_regs_reg_19__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1348} -new_cell_names {U_PTECO_HOLD_BUF1348}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_freq_temp_reg_9_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1349} -new_cell_names {U_PTECO_HOLD_BUF1349}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_5__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1350} -new_cell_names {U_PTECO_HOLD_BUF1350}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_freq_temp_reg_10_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1351} -new_cell_names {U_PTECO_HOLD_BUF1351}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_19__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1352} -new_cell_names {U_PTECO_HOLD_BUF1352}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1353} -new_cell_names {U_PTECO_HOLD_BUF1353}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U691/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1354} -new_cell_names {U_PTECO_HOLD_BUF1354}
insert_buffer [get_pins {U718/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1355} -new_cell_names {U_PTECO_HOLD_BUF1355}
insert_buffer [get_pins {trim_regs_reg_19__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1356} -new_cell_names {U_PTECO_HOLD_BUF1356}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1357} -new_cell_names {U_PTECO_HOLD_BUF1357}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF486/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1358} -new_cell_names {U_PTECO_HOLD_BUF1358}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF368/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1359} -new_cell_names {U_PTECO_HOLD_BUF1359}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U287/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1360} -new_cell_names {U_PTECO_HOLD_BUF1360}
insert_buffer [get_pins {led_on_temp_reg_12_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1361} -new_cell_names {U_PTECO_HOLD_BUF1361}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_14__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1362} -new_cell_names {U_PTECO_HOLD_BUF1362}
insert_buffer [get_pins {trim_regs_reg_16__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1363} -new_cell_names {U_PTECO_HOLD_BUF1363}
insert_buffer [get_pins {trim_regs_reg_16__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1364} -new_cell_names {U_PTECO_HOLD_BUF1364}
insert_buffer [get_pins {trim_regs_reg_17__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1365} -new_cell_names {U_PTECO_HOLD_BUF1365}
insert_buffer [get_pins {trim_regs_reg_17__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1366} -new_cell_names {U_PTECO_HOLD_BUF1366}
insert_buffer [get_pins {trim_regs_reg_19__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1367} -new_cell_names {U_PTECO_HOLD_BUF1367}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_EN_sync}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1368} -new_cell_names {U_PTECO_HOLD_BUF1368}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U560/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1369} -new_cell_names {U_PTECO_HOLD_BUF1369}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_14/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1370} -new_cell_names {U_PTECO_HOLD_BUF1370}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_40__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1371} -new_cell_names {U_PTECO_HOLD_BUF1371}
insert_buffer [get_pins {U708/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1372} -new_cell_names {U_PTECO_HOLD_BUF1372}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_18/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1373} -new_cell_names {U_PTECO_HOLD_BUF1373}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_8__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1374} -new_cell_names {U_PTECO_HOLD_BUF1374}
insert_buffer [get_pins {trim_regs_reg_17__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1375} -new_cell_names {U_PTECO_HOLD_BUF1375}
insert_buffer [get_pins {trim_regs_reg_16__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1376} -new_cell_names {U_PTECO_HOLD_BUF1376}
insert_buffer [get_pins {trim_regs_reg_17__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1377} -new_cell_names {U_PTECO_HOLD_BUF1377}
insert_buffer [get_pins {trim_regs_reg_37__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1378} -new_cell_names {U_PTECO_HOLD_BUF1378}
insert_buffer [get_pins {trim_regs_reg_17__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1379} -new_cell_names {U_PTECO_HOLD_BUF1379}
insert_buffer [get_pins {trim_regs_reg_17__7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1380} -new_cell_names {U_PTECO_HOLD_BUF1380}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {U_PTECO_HOLD_BUF390/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1381} -new_cell_names {U_PTECO_HOLD_BUF1381}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_12__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1382} -new_cell_names {U_PTECO_HOLD_BUF1382}
insert_buffer [get_pins {trim_regs_reg_10__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1383} -new_cell_names {U_PTECO_HOLD_BUF1383}
insert_buffer [get_pins {trim_regs_reg_10__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1384} -new_cell_names {U_PTECO_HOLD_BUF1384}
insert_buffer [get_pins {trim_regs_reg_17__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1385} -new_cell_names {U_PTECO_HOLD_BUF1385}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_11_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1386} -new_cell_names {U_PTECO_HOLD_BUF1386}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1387} -new_cell_names {U_PTECO_HOLD_BUF1387}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_18__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1388} -new_cell_names {U_PTECO_HOLD_BUF1388}
insert_buffer [get_pins {U_PTECO_HOLD_BUF494/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1389} -new_cell_names {U_PTECO_HOLD_BUF1389}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1390} -new_cell_names {U_PTECO_HOLD_BUF1390}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U298/A1N}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1391} -new_cell_names {U_PTECO_HOLD_BUF1391}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_12__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1392} -new_cell_names {U_PTECO_HOLD_BUF1392}
insert_buffer [get_pins {trim_regs_reg_18__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1393} -new_cell_names {U_PTECO_HOLD_BUF1393}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1394} -new_cell_names {U_PTECO_HOLD_BUF1394}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_EN_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1395} -new_cell_names {U_PTECO_HOLD_BUF1395}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_6__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1396} -new_cell_names {U_PTECO_HOLD_BUF1396}
insert_buffer [get_pins {trim_regs_reg_7__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1397} -new_cell_names {U_PTECO_HOLD_BUF1397}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_freq_temp_reg_11_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1398} -new_cell_names {U_PTECO_HOLD_BUF1398}
insert_buffer [get_pins {led_freq_temp_reg_3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1399} -new_cell_names {U_PTECO_HOLD_BUF1399}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U827/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1400} -new_cell_names {U_PTECO_HOLD_BUF1400}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_freq_temp_reg_5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1401} -new_cell_names {U_PTECO_HOLD_BUF1401}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_47__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1402} -new_cell_names {U_PTECO_HOLD_BUF1402}
insert_buffer [get_pins {trim_regs_reg_18__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1403} -new_cell_names {U_PTECO_HOLD_BUF1403}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {lost_item_count_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1404} -new_cell_names {U_PTECO_HOLD_BUF1404}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_12__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1405} -new_cell_names {U_PTECO_HOLD_BUF1405}
insert_buffer [get_pins {nvr2_trim_tag_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1406} -new_cell_names {U_PTECO_HOLD_BUF1406}
insert_buffer [get_pins {trim_regs_reg_48__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1407} -new_cell_names {U_PTECO_HOLD_BUF1407}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_16/A0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1408} -new_cell_names {U_PTECO_HOLD_BUF1408}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_6__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1409} -new_cell_names {U_PTECO_HOLD_BUF1409}
insert_buffer [get_pins {trim_regs_reg_16__7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1410} -new_cell_names {U_PTECO_HOLD_BUF1410}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_8_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1411} -new_cell_names {U_PTECO_HOLD_BUF1411}
insert_buffer [get_pins {led_freq_temp_reg_12_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1412} -new_cell_names {U_PTECO_HOLD_BUF1412}
insert_buffer [get_pins {led_on_temp_reg_5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1413} -new_cell_names {U_PTECO_HOLD_BUF1413}
insert_buffer [get_pins {led_on_temp_reg_9_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1414} -new_cell_names {U_PTECO_HOLD_BUF1414}
insert_buffer [get_pins {led_on_temp_reg_7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1415} -new_cell_names {U_PTECO_HOLD_BUF1415}
insert_buffer [get_pins {led_on_temp_reg_6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1416} -new_cell_names {U_PTECO_HOLD_BUF1416}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U611/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1417} -new_cell_names {U_PTECO_HOLD_BUF1417}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1418} -new_cell_names {U_PTECO_HOLD_BUF1418}
insert_buffer [get_pins {led_on_temp_reg_4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1419} -new_cell_names {U_PTECO_HOLD_BUF1419}
insert_buffer [get_pins {led_on_temp_reg_3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1420} -new_cell_names {U_PTECO_HOLD_BUF1420}
insert_buffer [get_pins {led_freq_temp_reg_1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1421} -new_cell_names {U_PTECO_HOLD_BUF1421}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1422} -new_cell_names {U_PTECO_HOLD_BUF1422}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF509/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1423} -new_cell_names {U_PTECO_HOLD_BUF1423}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {fifo_intr_local_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1424} -new_cell_names {U_PTECO_HOLD_BUF1424}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF555/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1425} -new_cell_names {U_PTECO_HOLD_BUF1425}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_19__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1426} -new_cell_names {U_PTECO_HOLD_BUF1426}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF526/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1427} -new_cell_names {U_PTECO_HOLD_BUF1427}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U719/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1428} -new_cell_names {U_PTECO_HOLD_BUF1428}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF527/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1429} -new_cell_names {U_PTECO_HOLD_BUF1429}
insert_buffer [get_pins {U_PTECO_HOLD_BUF529/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1430} -new_cell_names {U_PTECO_HOLD_BUF1430}
insert_buffer [get_pins {U_PTECO_HOLD_BUF528/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1431} -new_cell_names {U_PTECO_HOLD_BUF1431}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_6__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1432} -new_cell_names {U_PTECO_HOLD_BUF1432}
insert_buffer [get_pins {trim_regs_reg_9__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1433} -new_cell_names {U_PTECO_HOLD_BUF1433}
insert_buffer [get_pins {trim_regs_reg_6__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1434} -new_cell_names {U_PTECO_HOLD_BUF1434}
insert_buffer [get_pins {U_PTECO_HOLD_BUF516/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1435} -new_cell_names {U_PTECO_HOLD_BUF1435}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1436} -new_cell_names {U_PTECO_HOLD_BUF1436}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_13/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1437} -new_cell_names {U_PTECO_HOLD_BUF1437}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF552/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1438} -new_cell_names {U_PTECO_HOLD_BUF1438}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_33__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1439} -new_cell_names {U_PTECO_HOLD_BUF1439}
insert_buffer [get_pins {U738/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1440} -new_cell_names {U_PTECO_HOLD_BUF1440}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst/u_fifo_flush_n_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1441} -new_cell_names {U_PTECO_HOLD_BUF1441}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF567/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1442} -new_cell_names {U_PTECO_HOLD_BUF1442}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_123__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1443} -new_cell_names {U_PTECO_HOLD_BUF1443}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statp/u_dur_sync_pclk}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1444} -new_cell_names {U_PTECO_HOLD_BUF1444}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statp/u_switch_rstn_sync}
insert_buffer [get_pins {rst_sync1_n_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1445} -new_cell_names {U_PTECO_HOLD_BUF1445}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_acloff_statn}
insert_buffer [get_pins {leadoff_switch_tgt_cnt_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1446} -new_cell_names {U_PTECO_HOLD_BUF1446}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_8__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1447} -new_cell_names {U_PTECO_HOLD_BUF1447}
insert_buffer [get_pins {trim_regs_reg_46__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1448} -new_cell_names {U_PTECO_HOLD_BUF1448}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF572/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1449} -new_cell_names {U_PTECO_HOLD_BUF1449}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {Freq_ctrl_temp_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1450} -new_cell_names {U_PTECO_HOLD_BUF1450}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF545/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1451} -new_cell_names {U_PTECO_HOLD_BUF1451}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_10__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1452} -new_cell_names {U_PTECO_HOLD_BUF1452}
insert_buffer [get_pins {trim_reg_reg_10__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1453} -new_cell_names {U_PTECO_HOLD_BUF1453}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF578/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1454} -new_cell_names {U_PTECO_HOLD_BUF1454}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF581/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1455} -new_cell_names {U_PTECO_HOLD_BUF1455}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_wr_spi}
insert_buffer [get_pins {data_reg_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1456} -new_cell_names {U_PTECO_HOLD_BUF1456}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_10_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1457} -new_cell_names {U_PTECO_HOLD_BUF1457}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U689/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1458} -new_cell_names {U_PTECO_HOLD_BUF1458}
insert_buffer [get_pins {U700/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1459} -new_cell_names {U_PTECO_HOLD_BUF1459}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1460} -new_cell_names {U_PTECO_HOLD_BUF1460}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_acloff_statn}
insert_buffer [get_pins {leadoff_switch_tgt_cnt_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1461} -new_cell_names {U_PTECO_HOLD_BUF1461}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF553/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1462} -new_cell_names {U_PTECO_HOLD_BUF1462}
insert_buffer [get_pins {U_PTECO_HOLD_BUF556/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1463} -new_cell_names {U_PTECO_HOLD_BUF1463}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_delta_final_reg_13_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1464} -new_cell_names {U_PTECO_HOLD_BUF1464}
insert_buffer [get_pins {ch0data_delta_final_reg_15_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1465} -new_cell_names {U_PTECO_HOLD_BUF1465}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U679/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1466} -new_cell_names {U_PTECO_HOLD_BUF1466}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_delta_final_reg_10_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1467} -new_cell_names {U_PTECO_HOLD_BUF1467}
insert_buffer [get_pins {ch0data_delta_final_reg_11_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1468} -new_cell_names {U_PTECO_HOLD_BUF1468}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_8__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1469} -new_cell_names {U_PTECO_HOLD_BUF1469}
insert_buffer [get_pins {trim_regs_reg_13__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1470} -new_cell_names {U_PTECO_HOLD_BUF1470}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_105__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1471} -new_cell_names {U_PTECO_HOLD_BUF1471}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_42__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1472} -new_cell_names {U_PTECO_HOLD_BUF1472}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_7_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1473} -new_cell_names {U_PTECO_HOLD_BUF1473}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {lost_item_count_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1474} -new_cell_names {U_PTECO_HOLD_BUF1474}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_11__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1475} -new_cell_names {U_PTECO_HOLD_BUF1475}
insert_buffer [get_pins {U743/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1476} -new_cell_names {U_PTECO_HOLD_BUF1476}
insert_buffer [get_pins {U_PTECO_HOLD_BUF323/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1477} -new_cell_names {U_PTECO_HOLD_BUF1477}
insert_buffer [get_pins {trim_regs_reg_2__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1478} -new_cell_names {U_PTECO_HOLD_BUF1478}
insert_buffer [get_pins {U543/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1479} -new_cell_names {U_PTECO_HOLD_BUF1479}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {flash_nvr_pro00_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1480} -new_cell_names {U_PTECO_HOLD_BUF1480}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {empty_n_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1481} -new_cell_names {U_PTECO_HOLD_BUF1481}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_6__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1482} -new_cell_names {U_PTECO_HOLD_BUF1482}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_104__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1483} -new_cell_names {U_PTECO_HOLD_BUF1483}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U703/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1484} -new_cell_names {U_PTECO_HOLD_BUF1484}
insert_buffer [get_pins {trim_regs_reg_20__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1485} -new_cell_names {U_PTECO_HOLD_BUF1485}
insert_buffer [get_pins {trim_regs_reg_20__7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1486} -new_cell_names {U_PTECO_HOLD_BUF1486}
insert_buffer [get_pins {trim_regs_reg_2__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1487} -new_cell_names {U_PTECO_HOLD_BUF1487}
insert_buffer [get_pins {trim_regs_reg_20__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1488} -new_cell_names {U_PTECO_HOLD_BUF1488}
insert_buffer [get_pins {trim_regs_reg_11__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1489} -new_cell_names {U_PTECO_HOLD_BUF1489}
insert_buffer [get_pins {trim_regs_reg_11__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1490} -new_cell_names {U_PTECO_HOLD_BUF1490}
insert_buffer [get_pins {trim_regs_reg_2__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1491} -new_cell_names {U_PTECO_HOLD_BUF1491}
insert_buffer [get_pins {trim_regs_reg_20__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1492} -new_cell_names {U_PTECO_HOLD_BUF1492}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_updated_reg_18_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1493} -new_cell_names {U_PTECO_HOLD_BUF1493}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_delta_final_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1494} -new_cell_names {U_PTECO_HOLD_BUF1494}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U494/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1495} -new_cell_names {U_PTECO_HOLD_BUF1495}
insert_buffer [get_pins {trim_regs_reg_2__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1496} -new_cell_names {U_PTECO_HOLD_BUF1496}
insert_buffer [get_pins {trim_regs_reg_48__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1497} -new_cell_names {U_PTECO_HOLD_BUF1497}
insert_buffer [get_pins {trim_regs_reg_48__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1498} -new_cell_names {U_PTECO_HOLD_BUF1498}
insert_buffer [get_pins {trim_regs_reg_5__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1499} -new_cell_names {U_PTECO_HOLD_BUF1499}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1500} -new_cell_names {U_PTECO_HOLD_BUF1500}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_72__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1501} -new_cell_names {U_PTECO_HOLD_BUF1501}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U514/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1502} -new_cell_names {U_PTECO_HOLD_BUF1502}
insert_buffer [get_pins {U526/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1503} -new_cell_names {U_PTECO_HOLD_BUF1503}
insert_buffer [get_pins {trim_regs_reg_8__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1504} -new_cell_names {U_PTECO_HOLD_BUF1504}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1505} -new_cell_names {U_PTECO_HOLD_BUF1505}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_10__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1506} -new_cell_names {U_PTECO_HOLD_BUF1506}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_Freq_sel_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1507} -new_cell_names {U_PTECO_HOLD_BUF1507}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_20__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1508} -new_cell_names {U_PTECO_HOLD_BUF1508}
insert_buffer [get_pins {U490/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1509} -new_cell_names {U_PTECO_HOLD_BUF1509}
insert_buffer [get_pins {U532/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1510} -new_cell_names {U_PTECO_HOLD_BUF1510}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_10_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1511} -new_cell_names {U_PTECO_HOLD_BUF1511}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_EN_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1512} -new_cell_names {U_PTECO_HOLD_BUF1512}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_8_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1513} -new_cell_names {U_PTECO_HOLD_BUF1513}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_phase_accumulator}
insert_buffer [get_pins {dds_phase_add_reg_18_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1514} -new_cell_names {U_PTECO_HOLD_BUF1514}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_7_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1515} -new_cell_names {U_PTECO_HOLD_BUF1515}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {word_count_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1516} -new_cell_names {U_PTECO_HOLD_BUF1516}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1517} -new_cell_names {U_PTECO_HOLD_BUF1517}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_8_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1518} -new_cell_names {U_PTECO_HOLD_BUF1518}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1519} -new_cell_names {U_PTECO_HOLD_BUF1519}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_4_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1520} -new_cell_names {U_PTECO_HOLD_BUF1520}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1521} -new_cell_names {U_PTECO_HOLD_BUF1521}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U836/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1522} -new_cell_names {U_PTECO_HOLD_BUF1522}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {DFT_6/A0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1523} -new_cell_names {U_PTECO_HOLD_BUF1523}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_atm_unlock_edge}
insert_buffer [get_pins {d_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1524} -new_cell_names {U_PTECO_HOLD_BUF1524}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_44__3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1525} -new_cell_names {U_PTECO_HOLD_BUF1525}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch0data_en_reg_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1526} -new_cell_names {U_PTECO_HOLD_BUF1526}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_11__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1527} -new_cell_names {U_PTECO_HOLD_BUF1527}
insert_buffer [get_pins {trim_regs_reg_4__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1528} -new_cell_names {U_PTECO_HOLD_BUF1528}
insert_buffer [get_pins {trim_regs_reg_4__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1529} -new_cell_names {U_PTECO_HOLD_BUF1529}
insert_buffer [get_pins {trim_regs_reg_20__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1530} -new_cell_names {U_PTECO_HOLD_BUF1530}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_9_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1531} -new_cell_names {U_PTECO_HOLD_BUF1531}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_6_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1532} -new_cell_names {U_PTECO_HOLD_BUF1532}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_9_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1533} -new_cell_names {U_PTECO_HOLD_BUF1533}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1534} -new_cell_names {U_PTECO_HOLD_BUF1534}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_11_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1535} -new_cell_names {U_PTECO_HOLD_BUF1535}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_10_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1536} -new_cell_names {U_PTECO_HOLD_BUF1536}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1537} -new_cell_names {U_PTECO_HOLD_BUF1537}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_EN_PPG_SH_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1538} -new_cell_names {U_PTECO_HOLD_BUF1538}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_EN_PPG_AF_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1539} -new_cell_names {U_PTECO_HOLD_BUF1539}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_63__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1540} -new_cell_names {U_PTECO_HOLD_BUF1540}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LED_STANDBYEN_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1541} -new_cell_names {U_PTECO_HOLD_BUF1541}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_SH_CK_sync}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1542} -new_cell_names {U_PTECO_HOLD_BUF1542}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_22/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1543} -new_cell_names {U_PTECO_HOLD_BUF1543}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statn/u_switch_rstn_sync}
insert_buffer [get_pins {rst_sync1_n_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1544} -new_cell_names {U_PTECO_HOLD_BUF1544}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_35__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1545} -new_cell_names {U_PTECO_HOLD_BUF1545}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1546} -new_cell_names {U_PTECO_HOLD_BUF1546}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U747/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1547} -new_cell_names {U_PTECO_HOLD_BUF1547}
insert_buffer [get_pins {U949/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1548} -new_cell_names {U_PTECO_HOLD_BUF1548}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_19/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1549} -new_cell_names {U_PTECO_HOLD_BUF1549}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1550} -new_cell_names {U_PTECO_HOLD_BUF1550}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {U_PTECO_HOLD_BUF402/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1551} -new_cell_names {U_PTECO_HOLD_BUF1551}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_spi_cer_edge}
insert_buffer [get_pins {d_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1552} -new_cell_names {U_PTECO_HOLD_BUF1552}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_34__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1553} -new_cell_names {U_PTECO_HOLD_BUF1553}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {byte_bit_count_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1554} -new_cell_names {U_PTECO_HOLD_BUF1554}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_7_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1555} -new_cell_names {U_PTECO_HOLD_BUF1555}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_3__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1556} -new_cell_names {U_PTECO_HOLD_BUF1556}
insert_buffer [get_pins {trim_regs_reg_35__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1557} -new_cell_names {U_PTECO_HOLD_BUF1557}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch0data_reg_reg_13_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1558} -new_cell_names {U_PTECO_HOLD_BUF1558}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {Freq_ctrl_temp_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1559} -new_cell_names {U_PTECO_HOLD_BUF1559}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_39__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1560} -new_cell_names {U_PTECO_HOLD_BUF1560}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch1data_reg_reg_15_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1561} -new_cell_names {U_PTECO_HOLD_BUF1561}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_Freq_sel_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1562} -new_cell_names {U_PTECO_HOLD_BUF1562}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_61__13_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1563} -new_cell_names {U_PTECO_HOLD_BUF1563}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_3__7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1564} -new_cell_names {U_PTECO_HOLD_BUF1564}
insert_buffer [get_pins {trim_regs_reg_12__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1565} -new_cell_names {U_PTECO_HOLD_BUF1565}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {fsm_counter_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1566} -new_cell_names {U_PTECO_HOLD_BUF1566}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_Freq_sel_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1567} -new_cell_names {U_PTECO_HOLD_BUF1567}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1568} -new_cell_names {U_PTECO_HOLD_BUF1568}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_Freq_sel_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1569} -new_cell_names {U_PTECO_HOLD_BUF1569}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1570} -new_cell_names {U_PTECO_HOLD_BUF1570}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_35__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1571} -new_cell_names {U_PTECO_HOLD_BUF1571}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_5_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1572} -new_cell_names {U_PTECO_HOLD_BUF1572}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_4_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1573} -new_cell_names {U_PTECO_HOLD_BUF1573}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U721/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1574} -new_cell_names {U_PTECO_HOLD_BUF1574}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {fsm_counter_reg_10_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1575} -new_cell_names {U_PTECO_HOLD_BUF1575}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF641/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1576} -new_cell_names {U_PTECO_HOLD_BUF1576}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1577} -new_cell_names {U_PTECO_HOLD_BUF1577}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1578} -new_cell_names {U_PTECO_HOLD_BUF1578}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1579} -new_cell_names {U_PTECO_HOLD_BUF1579}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section4_reg_0__17_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1580} -new_cell_names {U_PTECO_HOLD_BUF1580}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_SH_CK_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1581} -new_cell_names {U_PTECO_HOLD_BUF1581}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U735/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1582} -new_cell_names {U_PTECO_HOLD_BUF1582}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch2data_reg_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1583} -new_cell_names {U_PTECO_HOLD_BUF1583}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {fsm_counter_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1584} -new_cell_names {U_PTECO_HOLD_BUF1584}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1585} -new_cell_names {U_PTECO_HOLD_BUF1585}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1586} -new_cell_names {U_PTECO_HOLD_BUF1586}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch1data_reg_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1587} -new_cell_names {U_PTECO_HOLD_BUF1587}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1588} -new_cell_names {U_PTECO_HOLD_BUF1588}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF696/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1589} -new_cell_names {U_PTECO_HOLD_BUF1589}
insert_buffer [get_pins {U_PTECO_HOLD_BUF691/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1590} -new_cell_names {U_PTECO_HOLD_BUF1590}
insert_buffer [get_pins {trim_regs_reg_39__3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1591} -new_cell_names {U_PTECO_HOLD_BUF1591}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {a_empty_n_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1592} -new_cell_names {U_PTECO_HOLD_BUF1592}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_15__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1593} -new_cell_names {U_PTECO_HOLD_BUF1593}
insert_buffer [get_pins {trim_regs_reg_3__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1594} -new_cell_names {U_PTECO_HOLD_BUF1594}
insert_buffer [get_pins {trim_regs_reg_3__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1595} -new_cell_names {U_PTECO_HOLD_BUF1595}
insert_buffer [get_pins {trim_regs_reg_3__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1596} -new_cell_names {U_PTECO_HOLD_BUF1596}
insert_buffer [get_pins {trim_regs_reg_3__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1597} -new_cell_names {U_PTECO_HOLD_BUF1597}
insert_buffer [get_pins {trim_regs_reg_12__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1598} -new_cell_names {U_PTECO_HOLD_BUF1598}
insert_buffer [get_pins {trim_regs_reg_3__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1599} -new_cell_names {U_PTECO_HOLD_BUF1599}
insert_buffer [get_pins {trim_regs_reg_4__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1600} -new_cell_names {U_PTECO_HOLD_BUF1600}
insert_buffer [get_pins {U666/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1601} -new_cell_names {U_PTECO_HOLD_BUF1601}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1602} -new_cell_names {U_PTECO_HOLD_BUF1602}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {a_empty_sts_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1603} -new_cell_names {U_PTECO_HOLD_BUF1603}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_39__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1604} -new_cell_names {U_PTECO_HOLD_BUF1604}
insert_buffer [get_pins {trim_regs_reg_42__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1605} -new_cell_names {U_PTECO_HOLD_BUF1605}
insert_buffer [get_pins {trim_regs_reg_34__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1606} -new_cell_names {U_PTECO_HOLD_BUF1606}
insert_buffer [get_pins {trim_regs_reg_34__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1607} -new_cell_names {U_PTECO_HOLD_BUF1607}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1608} -new_cell_names {U_PTECO_HOLD_BUF1608}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm/u_cmsdk_clock_gate_prog}
insert_buffer [get_pins {DNT_ICG_CELL/E}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1609} -new_cell_names {U_PTECO_HOLD_BUF1609}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cdc/u_ppg_sh_ck_sync}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1610} -new_cell_names {U_PTECO_HOLD_BUF1610}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {square_clk_div_1_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1611} -new_cell_names {U_PTECO_HOLD_BUF1611}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_0_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1612} -new_cell_names {U_PTECO_HOLD_BUF1612}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {chnum_reg_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1613} -new_cell_names {U_PTECO_HOLD_BUF1613}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_flash_cer}
insert_buffer [get_pins {data_reg_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1614} -new_cell_names {U_PTECO_HOLD_BUF1614}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {reload_trim_en_lock_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1615} -new_cell_names {U_PTECO_HOLD_BUF1615}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led1_working_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1616} -new_cell_names {U_PTECO_HOLD_BUF1616}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cdc/u_ppg_sh_ck_sync}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1617} -new_cell_names {U_PTECO_HOLD_BUF1617}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {cur_state_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1618} -new_cell_names {U_PTECO_HOLD_BUF1618}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_60__16_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1619} -new_cell_names {U_PTECO_HOLD_BUF1619}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_Mode_sel_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1620} -new_cell_names {U_PTECO_HOLD_BUF1620}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_Mode_sel_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1621} -new_cell_names {U_PTECO_HOLD_BUF1621}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {fsm_counter_reg_9_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1622} -new_cell_names {U_PTECO_HOLD_BUF1622}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_62__14_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1623} -new_cell_names {U_PTECO_HOLD_BUF1623}
insert_buffer [get_pins {mem_reg_62__15_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1624} -new_cell_names {U_PTECO_HOLD_BUF1624}
insert_buffer [get_pins {mem_reg_63__12_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1625} -new_cell_names {U_PTECO_HOLD_BUF1625}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statn/u_switch_rstn_sync}
insert_buffer [get_pins {rst_sync0_n_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1626} -new_cell_names {U_PTECO_HOLD_BUF1626}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {dc_data_reg_0_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1627} -new_cell_names {U_PTECO_HOLD_BUF1627}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section3_reg_0__20_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1628} -new_cell_names {U_PTECO_HOLD_BUF1628}
insert_buffer [get_pins {delay_section3_reg_0__21_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1629} -new_cell_names {U_PTECO_HOLD_BUF1629}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_7_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1630} -new_cell_names {U_PTECO_HOLD_BUF1630}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_6_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1631} -new_cell_names {U_PTECO_HOLD_BUF1631}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1632} -new_cell_names {U_PTECO_HOLD_BUF1632}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_3_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1633} -new_cell_names {U_PTECO_HOLD_BUF1633}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LEDSEL_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1634} -new_cell_names {U_PTECO_HOLD_BUF1634}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_1_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF723/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1635} -new_cell_names {U_PTECO_HOLD_BUF1635}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LED_EN_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1636} -new_cell_names {U_PTECO_HOLD_BUF1636}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LEDSEL_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1637} -new_cell_names {U_PTECO_HOLD_BUF1637}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_bwdctrl}
insert_buffer [get_pins {sinrom_reg1_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1638} -new_cell_names {U_PTECO_HOLD_BUF1638}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1639} -new_cell_names {U_PTECO_HOLD_BUF1639}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {iclk_div_cnt_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1640} -new_cell_names {U_PTECO_HOLD_BUF1640}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_bwdctrl}
insert_buffer [get_pins {sinrom_reg1_reg_7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1641} -new_cell_names {U_PTECO_HOLD_BUF1641}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {ana_tsc_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1642} -new_cell_names {U_PTECO_HOLD_BUF1642}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1643} -new_cell_names {U_PTECO_HOLD_BUF1643}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ3_reg_27_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1644} -new_cell_names {U_PTECO_HOLD_BUF1644}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {clk_ctrl_reg_reg_7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1645} -new_cell_names {U_PTECO_HOLD_BUF1645}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1646} -new_cell_names {U_PTECO_HOLD_BUF1646}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_4_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1647} -new_cell_names {U_PTECO_HOLD_BUF1647}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_bwdctrl}
insert_buffer [get_pins {summation_real_reg_26_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1648} -new_cell_names {U_PTECO_HOLD_BUF1648}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_17__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1649} -new_cell_names {U_PTECO_HOLD_BUF1649}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_102__14_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1650} -new_cell_names {U_PTECO_HOLD_BUF1650}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {ana_tsc_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1651} -new_cell_names {U_PTECO_HOLD_BUF1651}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_11_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1652} -new_cell_names {U_PTECO_HOLD_BUF1652}
current_instance
current_instance {u_top_dig/u_imeas/u_filter1_sync_adcclk}
insert_buffer [get_pins {U_PTECO_HOLD_BUF730/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1653} -new_cell_names {U_PTECO_HOLD_BUF1653}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statn/u_dur_sync_pclk}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1654} -new_cell_names {U_PTECO_HOLD_BUF1654}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1655} -new_cell_names {U_PTECO_HOLD_BUF1655}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {cur_state_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1656} -new_cell_names {U_PTECO_HOLD_BUF1656}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_rw_ctrl/u_flash_rw_fsm/u_flash_dslp_sync}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1657} -new_cell_names {U_PTECO_HOLD_BUF1657}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_Mode_sel_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1658} -new_cell_names {U_PTECO_HOLD_BUF1658}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_7__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1659} -new_cell_names {U_PTECO_HOLD_BUF1659}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_4_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1660} -new_cell_names {U_PTECO_HOLD_BUF1660}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_TEST_IN_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1661} -new_cell_names {U_PTECO_HOLD_BUF1661}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_11_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1662} -new_cell_names {U_PTECO_HOLD_BUF1662}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_PDV_REF_SEL_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1663} -new_cell_names {U_PTECO_HOLD_BUF1663}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_TEST_OUT_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1664} -new_cell_names {U_PTECO_HOLD_BUF1664}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_PDV_REF_SEL_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1665} -new_cell_names {U_PTECO_HOLD_BUF1665}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_TEST_OUT_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1666} -new_cell_names {U_PTECO_HOLD_BUF1666}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_TEST_IN_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1667} -new_cell_names {U_PTECO_HOLD_BUF1667}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_7__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1668} -new_cell_names {U_PTECO_HOLD_BUF1668}
insert_buffer [get_pins {trim_regs_reg_13__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1669} -new_cell_names {U_PTECO_HOLD_BUF1669}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_bwdctrl}
insert_buffer [get_pins {summation_offset_forreal_reg_14_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1670} -new_cell_names {U_PTECO_HOLD_BUF1670}
insert_buffer [get_pins {sinrom_reg1_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1671} -new_cell_names {U_PTECO_HOLD_BUF1671}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_rw_ctrl/u_flash_rw_fsm}
insert_buffer [get_pins {timer_cnt_reg_reg_15_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1672} -new_cell_names {U_PTECO_HOLD_BUF1672}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_15__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1673} -new_cell_names {U_PTECO_HOLD_BUF1673}
insert_buffer [get_pins {trim_regs_reg_11__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1674} -new_cell_names {U_PTECO_HOLD_BUF1674}
insert_buffer [get_pins {trim_regs_reg_11__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1675} -new_cell_names {U_PTECO_HOLD_BUF1675}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cdc/u_filter0_sync}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1676} -new_cell_names {U_PTECO_HOLD_BUF1676}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {U189/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1677} -new_cell_names {U_PTECO_HOLD_BUF1677}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_40__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1678} -new_cell_names {U_PTECO_HOLD_BUF1678}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cdc/u_filter0_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1679} -new_cell_names {U_PTECO_HOLD_BUF1679}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_30__3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1680} -new_cell_names {U_PTECO_HOLD_BUF1680}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_1_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1681} -new_cell_names {U_PTECO_HOLD_BUF1681}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_45__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1682} -new_cell_names {U_PTECO_HOLD_BUF1682}
insert_buffer [get_pins {U459/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1683} -new_cell_names {U_PTECO_HOLD_BUF1683}
insert_buffer [get_pins {trim_regs_reg_36__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1684} -new_cell_names {U_PTECO_HOLD_BUF1684}
insert_buffer [get_pins {trim_regs_reg_32__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1685} -new_cell_names {U_PTECO_HOLD_BUF1685}
insert_buffer [get_pins {cunter_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1686} -new_cell_names {U_PTECO_HOLD_BUF1686}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1687} -new_cell_names {U_PTECO_HOLD_BUF1687}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_6_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1688} -new_cell_names {U_PTECO_HOLD_BUF1688}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {flash_unlock_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1689} -new_cell_names {U_PTECO_HOLD_BUF1689}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_34__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1690} -new_cell_names {U_PTECO_HOLD_BUF1690}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_ovf_cnt_sync_0_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1691} -new_cell_names {U_PTECO_HOLD_BUF1691}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_13__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1692} -new_cell_names {U_PTECO_HOLD_BUF1692}
insert_buffer [get_pins {trim_regs_reg_1__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1693} -new_cell_names {U_PTECO_HOLD_BUF1693}
insert_buffer [get_pins {trim_regs_reg_1__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1694} -new_cell_names {U_PTECO_HOLD_BUF1694}
insert_buffer [get_pins {trim_regs_reg_1__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1695} -new_cell_names {U_PTECO_HOLD_BUF1695}
insert_buffer [get_pins {trim_regs_reg_1__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1696} -new_cell_names {U_PTECO_HOLD_BUF1696}
insert_buffer [get_pins {U950/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1697} -new_cell_names {U_PTECO_HOLD_BUF1697}
insert_buffer [get_pins {U953/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1698} -new_cell_names {U_PTECO_HOLD_BUF1698}
insert_buffer [get_pins {U951/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1699} -new_cell_names {U_PTECO_HOLD_BUF1699}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U_PTECO_HOLD_BUF700/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1700} -new_cell_names {U_PTECO_HOLD_BUF1700}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U845/A1N}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1701} -new_cell_names {U_PTECO_HOLD_BUF1701}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {pmu_reg0_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1702} -new_cell_names {U_PTECO_HOLD_BUF1702}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {comb1_reg_25_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1703} -new_cell_names {U_PTECO_HOLD_BUF1703}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_13__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1704} -new_cell_names {U_PTECO_HOLD_BUF1704}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_EN_PPGDAC_BUFFER_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1705} -new_cell_names {U_PTECO_HOLD_BUF1705}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_EN_TIA_VREFBUFFER_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1706} -new_cell_names {U_PTECO_HOLD_BUF1706}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_13__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1707} -new_cell_names {U_PTECO_HOLD_BUF1707}
insert_buffer [get_pins {trim_regs_reg_13__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1708} -new_cell_names {U_PTECO_HOLD_BUF1708}
insert_buffer [get_pins {trim_regs_reg_13__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1709} -new_cell_names {U_PTECO_HOLD_BUF1709}
insert_buffer [get_pins {trim_regs_reg_13__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1710} -new_cell_names {U_PTECO_HOLD_BUF1710}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {flash_nvr_pro01_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1711} -new_cell_names {U_PTECO_HOLD_BUF1711}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl}
insert_buffer [get_pins {freq_phjmp_reg_reg_12_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1712} -new_cell_names {U_PTECO_HOLD_BUF1712}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section1_reg_1__22_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1713} -new_cell_names {U_PTECO_HOLD_BUF1713}
insert_buffer [get_pins {delay_section4_reg_0__23_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1714} -new_cell_names {U_PTECO_HOLD_BUF1714}
insert_buffer [get_pins {delay_section2_reg_1__22_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1715} -new_cell_names {U_PTECO_HOLD_BUF1715}
insert_buffer [get_pins {delay_section2_reg_0__21_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1716} -new_cell_names {U_PTECO_HOLD_BUF1716}
insert_buffer [get_pins {delay_section2_reg_1__20_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1717} -new_cell_names {U_PTECO_HOLD_BUF1717}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_9__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1718} -new_cell_names {U_PTECO_HOLD_BUF1718}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_imeas}
insert_buffer [get_pins {leadoff_tgt_1_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1719} -new_cell_names {U_PTECO_HOLD_BUF1719}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_14__2_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1720} -new_cell_names {U_PTECO_HOLD_BUF1720}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_3_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1721} -new_cell_names {U_PTECO_HOLD_BUF1721}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_5__3_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1722} -new_cell_names {U_PTECO_HOLD_BUF1722}
insert_buffer [get_pins {trim_regs_reg_8__3_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1723} -new_cell_names {U_PTECO_HOLD_BUF1723}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_reg_17__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1724} -new_cell_names {U_PTECO_HOLD_BUF1724}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_9__7_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1725} -new_cell_names {U_PTECO_HOLD_BUF1725}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {acrldoff_clk_reg_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1726} -new_cell_names {U_PTECO_HOLD_BUF1726}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_9__6_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1727} -new_cell_names {U_PTECO_HOLD_BUF1727}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF698/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1728} -new_cell_names {U_PTECO_HOLD_BUF1728}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_9__0_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1729} -new_cell_names {U_PTECO_HOLD_BUF1729}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_TIA_IDAC_sync_5_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1730} -new_cell_names {U_PTECO_HOLD_BUF1730}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_38__3_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1731} -new_cell_names {U_PTECO_HOLD_BUF1731}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {DFT_20/B0}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1732} -new_cell_names {U_PTECO_HOLD_BUF1732}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LEDSEL_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1733} -new_cell_names {U_PTECO_HOLD_BUF1733}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_PDV_REF_SEL_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1734} -new_cell_names {U_PTECO_HOLD_BUF1734}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LEDSEL_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1735} -new_cell_names {U_PTECO_HOLD_BUF1735}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U850/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1736} -new_cell_names {U_PTECO_HOLD_BUF1736}
insert_buffer [get_pins {trim_regs_reg_0__4_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1737} -new_cell_names {U_PTECO_HOLD_BUF1737}
insert_buffer [get_pins {trim_regs_reg_1__7_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1738} -new_cell_names {U_PTECO_HOLD_BUF1738}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_20/B0}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1739} -new_cell_names {U_PTECO_HOLD_BUF1739}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_13__4_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1740} -new_cell_names {U_PTECO_HOLD_BUF1740}
insert_buffer [get_pins {trim_regs_reg_43__1_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1741} -new_cell_names {U_PTECO_HOLD_BUF1741}
insert_buffer [get_pins {trim_regs_reg_43__7_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1742} -new_cell_names {U_PTECO_HOLD_BUF1742}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {lost_item_count_reg_4_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1743} -new_cell_names {U_PTECO_HOLD_BUF1743}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_1__4_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1744} -new_cell_names {U_PTECO_HOLD_BUF1744}
insert_buffer [get_pins {trim_regs_reg_2__6_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1745} -new_cell_names {U_PTECO_HOLD_BUF1745}
insert_buffer [get_pins {U883/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1746} -new_cell_names {U_PTECO_HOLD_BUF1746}
insert_buffer [get_pins {U855/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1747} -new_cell_names {U_PTECO_HOLD_BUF1747}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_BIS_016K29DE/u_data_generator}
insert_buffer [get_pins {s2p_data_reg_19_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1748} -new_cell_names {U_PTECO_HOLD_BUF1748}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_0__0_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1749} -new_cell_names {U_PTECO_HOLD_BUF1749}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section3_reg_0__22_/SI}] BUFX8M -new_net_names {net_PTECO_HOLD_NET1750} -new_cell_names {U_PTECO_HOLD_BUF1750}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {dc_data_reg_0_reg_6_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1751} -new_cell_names {U_PTECO_HOLD_BUF1751}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U725/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1752} -new_cell_names {U_PTECO_HOLD_BUF1752}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {rd_addr_local_reg_5_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1753} -new_cell_names {U_PTECO_HOLD_BUF1753}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {zmeas_reg_ctrl_3_reg_1_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1754} -new_cell_names {U_PTECO_HOLD_BUF1754}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U890/B1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1755} -new_cell_names {U_PTECO_HOLD_BUF1755}
insert_buffer [get_pins {U875/B1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1756} -new_cell_names {U_PTECO_HOLD_BUF1756}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_reg}
insert_buffer [get_pins {int_sts_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1757} -new_cell_names {U_PTECO_HOLD_BUF1757}
insert_buffer [get_pins {int_sts0_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1758} -new_cell_names {U_PTECO_HOLD_BUF1758}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_max_final_reg_9_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1759} -new_cell_names {U_PTECO_HOLD_BUF1759}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U872/B1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1760} -new_cell_names {U_PTECO_HOLD_BUF1760}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {storage_state_in4_reg_1_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1761} -new_cell_names {U_PTECO_HOLD_BUF1761}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_38__5_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1762} -new_cell_names {U_PTECO_HOLD_BUF1762}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_63__13_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1763} -new_cell_names {U_PTECO_HOLD_BUF1763}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_TIA_IDAC_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1764} -new_cell_names {U_PTECO_HOLD_BUF1764}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_2__4_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1765} -new_cell_names {U_PTECO_HOLD_BUF1765}
insert_buffer [get_pins {U895/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1766} -new_cell_names {U_PTECO_HOLD_BUF1766}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_min_final_reg_15_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1767} -new_cell_names {U_PTECO_HOLD_BUF1767}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_124__11_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1768} -new_cell_names {U_PTECO_HOLD_BUF1768}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U864/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1769} -new_cell_names {U_PTECO_HOLD_BUF1769}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {checking_clk_div_reg_lo_reg_3_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1770} -new_cell_names {U_PTECO_HOLD_BUF1770}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_0__9_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1771} -new_cell_names {U_PTECO_HOLD_BUF1771}
insert_buffer [get_pins {mem_reg_0__13_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1772} -new_cell_names {U_PTECO_HOLD_BUF1772}
insert_buffer [get_pins {mem_reg_0__11_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1773} -new_cell_names {U_PTECO_HOLD_BUF1773}
insert_buffer [get_pins {mem_reg_3__14_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1774} -new_cell_names {U_PTECO_HOLD_BUF1774}
insert_buffer [get_pins {mem_reg_0__10_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1775} -new_cell_names {U_PTECO_HOLD_BUF1775}
insert_buffer [get_pins {mem_reg_3__3_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1776} -new_cell_names {U_PTECO_HOLD_BUF1776}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {wr_addr_local_reg_4_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1777} -new_cell_names {U_PTECO_HOLD_BUF1777}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_27__7_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1778} -new_cell_names {U_PTECO_HOLD_BUF1778}
insert_buffer [get_pins {mem_reg_0__12_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1779} -new_cell_names {U_PTECO_HOLD_BUF1779}
insert_buffer [get_pins {mem_reg_26__2_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1780} -new_cell_names {U_PTECO_HOLD_BUF1780}
insert_buffer [get_pins {mem_reg_25__13_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1781} -new_cell_names {U_PTECO_HOLD_BUF1781}
insert_buffer [get_pins {mem_reg_25__0_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1782} -new_cell_names {U_PTECO_HOLD_BUF1782}
insert_buffer [get_pins {mem_reg_24__15_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1783} -new_cell_names {U_PTECO_HOLD_BUF1783}
insert_buffer [get_pins {mem_reg_27__10_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1784} -new_cell_names {U_PTECO_HOLD_BUF1784}
insert_buffer [get_pins {mem_reg_56__15_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1785} -new_cell_names {U_PTECO_HOLD_BUF1785}
insert_buffer [get_pins {mem_reg_27__0_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1786} -new_cell_names {U_PTECO_HOLD_BUF1786}
insert_buffer [get_pins {mem_reg_57__17_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1787} -new_cell_names {U_PTECO_HOLD_BUF1787}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {rd_addr_local_reg_3_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1788} -new_cell_names {U_PTECO_HOLD_BUF1788}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section1_reg_0__26_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1789} -new_cell_names {U_PTECO_HOLD_BUF1789}
insert_buffer [get_pins {accum_reg_reg_13_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1790} -new_cell_names {U_PTECO_HOLD_BUF1790}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {U248/B1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1791} -new_cell_names {U_PTECO_HOLD_BUF1791}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_data_cnt_sync_4_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1792} -new_cell_names {U_PTECO_HOLD_BUF1792}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_wr_ptr_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1793} -new_cell_names {U_PTECO_HOLD_BUF1793}
current_instance
current_instance {u_top_dig/clk_ctrl_inst}
insert_buffer [get_pins {mclk_div_cnt_reg_2_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1794} -new_cell_names {U_PTECO_HOLD_BUF1794}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_reg}
insert_buffer [get_pins {U16/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1795} -new_cell_names {U_PTECO_HOLD_BUF1795}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {accum_reg_reg_9_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1796} -new_cell_names {U_PTECO_HOLD_BUF1796}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_rd_ptr_sync_0_}
insert_buffer [get_pins {async_in_d2_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1797} -new_cell_names {U_PTECO_HOLD_BUF1797}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_data_cnt_sync_5_}
insert_buffer [get_pins {async_in_d2_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1798} -new_cell_names {U_PTECO_HOLD_BUF1798}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_max_final_reg_14_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1799} -new_cell_names {U_PTECO_HOLD_BUF1799}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {delay_section3_reg_0__23_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1800} -new_cell_names {U_PTECO_HOLD_BUF1800}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_data_cnt_sync_2_}
insert_buffer [get_pins {async_in_d2_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1801} -new_cell_names {U_PTECO_HOLD_BUF1801}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_ovf_cnt_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1802} -new_cell_names {U_PTECO_HOLD_BUF1802}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_fifo_wr_ptr_sync_5_}
insert_buffer [get_pins {async_in_d2_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1803} -new_cell_names {U_PTECO_HOLD_BUF1803}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_TIA_IDAC_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1804} -new_cell_names {U_PTECO_HOLD_BUF1804}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {square_clk_div_1_reg_1_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1805} -new_cell_names {U_PTECO_HOLD_BUF1805}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {storage_state_in2_reg_11_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1806} -new_cell_names {U_PTECO_HOLD_BUF1806}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_updated_reg_15_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1807} -new_cell_names {U_PTECO_HOLD_BUF1807}
insert_buffer [get_pins {trim_reg_updated_reg_7_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1808} -new_cell_names {U_PTECO_HOLD_BUF1808}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1809} -new_cell_names {U_PTECO_HOLD_BUF1809}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl}
insert_buffer [get_pins {reg_status_reg_9_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1810} -new_cell_names {U_PTECO_HOLD_BUF1810}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1811} -new_cell_names {U_PTECO_HOLD_BUF1811}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_1_}
insert_buffer [get_pins {async_in_d2_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1812} -new_cell_names {U_PTECO_HOLD_BUF1812}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl}
insert_buffer [get_pins {reg_status_reg_13_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1813} -new_cell_names {U_PTECO_HOLD_BUF1813}
insert_buffer [get_pins {reg_status_reg_12_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1814} -new_cell_names {U_PTECO_HOLD_BUF1814}
insert_buffer [get_pins {config_output_voltage_range_reg_1_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1815} -new_cell_names {U_PTECO_HOLD_BUF1815}
insert_buffer [get_pins {reg_status_reg_10_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1816} -new_cell_names {U_PTECO_HOLD_BUF1816}
insert_buffer [get_pins {reg_status_reg_11_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1817} -new_cell_names {U_PTECO_HOLD_BUF1817}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_delta_final_reg_8_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1818} -new_cell_names {U_PTECO_HOLD_BUF1818}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_ctrl}
insert_buffer [get_pins {config_output_voltage_range_reg_0_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1819} -new_cell_names {U_PTECO_HOLD_BUF1819}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {ana_tsc_reg_6_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1820} -new_cell_names {U_PTECO_HOLD_BUF1820}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statp}
insert_buffer [get_pins {leadoff_switch_tgt_cnt_reg_1_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1821} -new_cell_names {U_PTECO_HOLD_BUF1821}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {cic_rst_reg_reg/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1822} -new_cell_names {U_PTECO_HOLD_BUF1822}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_empty_level_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1823} -new_cell_names {U_PTECO_HOLD_BUF1823}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {led_on_reg_5_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1824} -new_cell_names {U_PTECO_HOLD_BUF1824}
insert_buffer [get_pins {led_on_reg_0_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1825} -new_cell_names {U_PTECO_HOLD_BUF1825}
insert_buffer [get_pins {square_clk_div_0_reg_4_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1826} -new_cell_names {U_PTECO_HOLD_BUF1826}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1827} -new_cell_names {U_PTECO_HOLD_BUF1827}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_empty_level_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1828} -new_cell_names {U_PTECO_HOLD_BUF1828}
current_instance
current_instance {u_top_dig/fifo_top/u_fifo_a_full_level_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1829} -new_cell_names {U_PTECO_HOLD_BUF1829}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {square_clk_div_0_reg_6_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1830} -new_cell_names {U_PTECO_HOLD_BUF1830}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_5__7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1831} -new_cell_names {U_PTECO_HOLD_BUF1831}
insert_buffer [get_pins {trim_regs_reg_7__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1832} -new_cell_names {U_PTECO_HOLD_BUF1832}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {DFT_4/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1833} -new_cell_names {U_PTECO_HOLD_BUF1833}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_15/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1834} -new_cell_names {U_PTECO_HOLD_BUF1834}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF310/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1835} -new_cell_names {U_PTECO_HOLD_BUF1835}
insert_buffer [get_pins {trim_regs_reg_7__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1836} -new_cell_names {U_PTECO_HOLD_BUF1836}
insert_buffer [get_pins {U678/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1837} -new_cell_names {U_PTECO_HOLD_BUF1837}
insert_buffer [get_pins {trim_regs_reg_5__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1838} -new_cell_names {U_PTECO_HOLD_BUF1838}
insert_buffer [get_pins {trim_regs_reg_5__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1839} -new_cell_names {U_PTECO_HOLD_BUF1839}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {DFT_5/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1840} -new_cell_names {U_PTECO_HOLD_BUF1840}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U835/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1841} -new_cell_names {U_PTECO_HOLD_BUF1841}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_4/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1842} -new_cell_names {U_PTECO_HOLD_BUF1842}
insert_buffer [get_pins {DFT_8/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1843} -new_cell_names {U_PTECO_HOLD_BUF1843}
current_instance
current_instance {top_dig_always_on_inst/pinmux_always_on_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1088/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1844} -new_cell_names {U_PTECO_HOLD_BUF1844}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1089/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1845} -new_cell_names {U_PTECO_HOLD_BUF1845}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF5/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1846} -new_cell_names {U_PTECO_HOLD_BUF1846}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF4/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1847} -new_cell_names {U_PTECO_HOLD_BUF1847}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF7/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1849} -new_cell_names {U_PTECO_HOLD_BUF1849}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF8/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1850} -new_cell_names {U_PTECO_HOLD_BUF1850}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1284/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1851} -new_cell_names {U_PTECO_HOLD_BUF1851}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1098/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1852} -new_cell_names {U_PTECO_HOLD_BUF1852}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1099/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1853} -new_cell_names {U_PTECO_HOLD_BUF1853}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1097/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1854} -new_cell_names {U_PTECO_HOLD_BUF1854}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1101/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1855} -new_cell_names {U_PTECO_HOLD_BUF1855}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1102/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1856} -new_cell_names {U_PTECO_HOLD_BUF1856}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1100/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1857} -new_cell_names {U_PTECO_HOLD_BUF1857}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1108/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1858} -new_cell_names {U_PTECO_HOLD_BUF1858}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1109/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1859} -new_cell_names {U_PTECO_HOLD_BUF1859}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1107/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1860} -new_cell_names {U_PTECO_HOLD_BUF1860}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1110/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1861} -new_cell_names {U_PTECO_HOLD_BUF1861}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1111/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1862} -new_cell_names {U_PTECO_HOLD_BUF1862}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1112/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1863} -new_cell_names {U_PTECO_HOLD_BUF1863}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1113/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1864} -new_cell_names {U_PTECO_HOLD_BUF1864}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1114/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1865} -new_cell_names {U_PTECO_HOLD_BUF1865}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1115/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1866} -new_cell_names {U_PTECO_HOLD_BUF1866}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1116/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1867} -new_cell_names {U_PTECO_HOLD_BUF1867}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1117/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1868} -new_cell_names {U_PTECO_HOLD_BUF1868}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1118/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1869} -new_cell_names {U_PTECO_HOLD_BUF1869}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1119/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1870} -new_cell_names {U_PTECO_HOLD_BUF1870}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1120/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1871} -new_cell_names {U_PTECO_HOLD_BUF1871}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1122/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1872} -new_cell_names {U_PTECO_HOLD_BUF1872}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1121/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1873} -new_cell_names {U_PTECO_HOLD_BUF1873}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1123/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1874} -new_cell_names {U_PTECO_HOLD_BUF1874}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1125/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1875} -new_cell_names {U_PTECO_HOLD_BUF1875}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1124/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1876} -new_cell_names {U_PTECO_HOLD_BUF1876}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1126/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1877} -new_cell_names {U_PTECO_HOLD_BUF1877}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1127/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1878} -new_cell_names {U_PTECO_HOLD_BUF1878}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1128/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1879} -new_cell_names {U_PTECO_HOLD_BUF1879}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1129/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1880} -new_cell_names {U_PTECO_HOLD_BUF1880}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1130/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1881} -new_cell_names {U_PTECO_HOLD_BUF1881}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1131/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1882} -new_cell_names {U_PTECO_HOLD_BUF1882}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1286/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1883} -new_cell_names {U_PTECO_HOLD_BUF1883}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1132/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1884} -new_cell_names {U_PTECO_HOLD_BUF1884}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1285/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1885} -new_cell_names {U_PTECO_HOLD_BUF1885}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1134/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1886} -new_cell_names {U_PTECO_HOLD_BUF1886}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_19_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1887} -new_cell_names {U_PTECO_HOLD_BUF1887}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1287/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1888} -new_cell_names {U_PTECO_HOLD_BUF1888}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1135/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1889} -new_cell_names {U_PTECO_HOLD_BUF1889}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1105/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1890} -new_cell_names {U_PTECO_HOLD_BUF1890}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1136/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1891} -new_cell_names {U_PTECO_HOLD_BUF1891}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1103/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1892} -new_cell_names {U_PTECO_HOLD_BUF1892}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1137/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1893} -new_cell_names {U_PTECO_HOLD_BUF1893}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1139/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1894} -new_cell_names {U_PTECO_HOLD_BUF1894}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1138/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1895} -new_cell_names {U_PTECO_HOLD_BUF1895}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1142/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1896} -new_cell_names {U_PTECO_HOLD_BUF1896}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1141/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1897} -new_cell_names {U_PTECO_HOLD_BUF1897}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1143/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1898} -new_cell_names {U_PTECO_HOLD_BUF1898}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1144/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1899} -new_cell_names {U_PTECO_HOLD_BUF1899}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1145/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1900} -new_cell_names {U_PTECO_HOLD_BUF1900}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1146/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1901} -new_cell_names {U_PTECO_HOLD_BUF1901}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1106/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1902} -new_cell_names {U_PTECO_HOLD_BUF1902}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1147/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1903} -new_cell_names {U_PTECO_HOLD_BUF1903}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1148/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1904} -new_cell_names {U_PTECO_HOLD_BUF1904}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1149/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1905} -new_cell_names {U_PTECO_HOLD_BUF1905}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1151/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1906} -new_cell_names {U_PTECO_HOLD_BUF1906}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1150/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1907} -new_cell_names {U_PTECO_HOLD_BUF1907}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1153/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1908} -new_cell_names {U_PTECO_HOLD_BUF1908}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1152/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1909} -new_cell_names {U_PTECO_HOLD_BUF1909}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1154/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1910} -new_cell_names {U_PTECO_HOLD_BUF1910}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1155/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1911} -new_cell_names {U_PTECO_HOLD_BUF1911}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1156/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1912} -new_cell_names {U_PTECO_HOLD_BUF1912}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1158/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1913} -new_cell_names {U_PTECO_HOLD_BUF1913}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1159/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1914} -new_cell_names {U_PTECO_HOLD_BUF1914}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1157/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1915} -new_cell_names {U_PTECO_HOLD_BUF1915}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1160/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1916} -new_cell_names {U_PTECO_HOLD_BUF1916}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1161/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1917} -new_cell_names {U_PTECO_HOLD_BUF1917}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1162/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1918} -new_cell_names {U_PTECO_HOLD_BUF1918}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1163/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1919} -new_cell_names {U_PTECO_HOLD_BUF1919}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1166/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1920} -new_cell_names {U_PTECO_HOLD_BUF1920}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1165/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1921} -new_cell_names {U_PTECO_HOLD_BUF1921}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1168/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1922} -new_cell_names {U_PTECO_HOLD_BUF1922}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1167/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1923} -new_cell_names {U_PTECO_HOLD_BUF1923}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1174/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1924} -new_cell_names {U_PTECO_HOLD_BUF1924}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U593/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1925} -new_cell_names {U_PTECO_HOLD_BUF1925}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1172/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1926} -new_cell_names {U_PTECO_HOLD_BUF1926}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1173/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1927} -new_cell_names {U_PTECO_HOLD_BUF1927}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1178/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1928} -new_cell_names {U_PTECO_HOLD_BUF1928}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1176/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1929} -new_cell_names {U_PTECO_HOLD_BUF1929}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1177/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1930} -new_cell_names {U_PTECO_HOLD_BUF1930}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1180/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1931} -new_cell_names {U_PTECO_HOLD_BUF1931}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1181/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1932} -new_cell_names {U_PTECO_HOLD_BUF1932}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1179/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1933} -new_cell_names {U_PTECO_HOLD_BUF1933}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1182/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1934} -new_cell_names {U_PTECO_HOLD_BUF1934}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1183/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1935} -new_cell_names {U_PTECO_HOLD_BUF1935}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1184/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1936} -new_cell_names {U_PTECO_HOLD_BUF1936}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1185/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1937} -new_cell_names {U_PTECO_HOLD_BUF1937}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1186/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1938} -new_cell_names {U_PTECO_HOLD_BUF1938}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1188/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1939} -new_cell_names {U_PTECO_HOLD_BUF1939}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1187/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1940} -new_cell_names {U_PTECO_HOLD_BUF1940}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1189/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1941} -new_cell_names {U_PTECO_HOLD_BUF1941}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1190/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1942} -new_cell_names {U_PTECO_HOLD_BUF1942}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1191/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1943} -new_cell_names {U_PTECO_HOLD_BUF1943}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1192/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1944} -new_cell_names {U_PTECO_HOLD_BUF1944}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1193/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1945} -new_cell_names {U_PTECO_HOLD_BUF1945}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1195/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1946} -new_cell_names {U_PTECO_HOLD_BUF1946}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1194/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1947} -new_cell_names {U_PTECO_HOLD_BUF1947}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1196/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1948} -new_cell_names {U_PTECO_HOLD_BUF1948}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1197/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1949} -new_cell_names {U_PTECO_HOLD_BUF1949}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1198/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1950} -new_cell_names {U_PTECO_HOLD_BUF1950}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1199/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1951} -new_cell_names {U_PTECO_HOLD_BUF1951}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1200/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1952} -new_cell_names {U_PTECO_HOLD_BUF1952}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1201/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1953} -new_cell_names {U_PTECO_HOLD_BUF1953}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1202/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1954} -new_cell_names {U_PTECO_HOLD_BUF1954}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1204/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1955} -new_cell_names {U_PTECO_HOLD_BUF1955}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1203/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1956} -new_cell_names {U_PTECO_HOLD_BUF1956}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1205/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1957} -new_cell_names {U_PTECO_HOLD_BUF1957}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1171/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1958} -new_cell_names {U_PTECO_HOLD_BUF1958}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_14_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1206/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1959} -new_cell_names {U_PTECO_HOLD_BUF1959}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1211/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1960} -new_cell_names {U_PTECO_HOLD_BUF1960}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1210/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1961} -new_cell_names {U_PTECO_HOLD_BUF1961}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_15_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1208/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1962} -new_cell_names {U_PTECO_HOLD_BUF1962}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_17_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1209/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1963} -new_cell_names {U_PTECO_HOLD_BUF1963}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF20/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1964} -new_cell_names {U_PTECO_HOLD_BUF1964}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1214/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1965} -new_cell_names {U_PTECO_HOLD_BUF1965}
current_instance
current_instance {u_top_dig/rst_ctrl_inst/u_presetn_sync}
insert_buffer [get_pins {U3/A0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1966} -new_cell_names {U_PTECO_HOLD_BUF1966}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_rw_ctrl/u_flash_rw_fsm/u_flash_dslp_sync}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1221/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1967} -new_cell_names {U_PTECO_HOLD_BUF1967}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1968} -new_cell_names {U_PTECO_HOLD_BUF1968}
current_instance
current_instance {u_top_dig/u_imeas/u_acSTATP_sync_pclk}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1969} -new_cell_names {U_PTECO_HOLD_BUF1969}
current_instance
current_instance {u_top_dig/u_imeas/u_acSTATN_sync_pclk}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1970} -new_cell_names {U_PTECO_HOLD_BUF1970}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_spi_wr_command_sync}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1213/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1971} -new_cell_names {U_PTECO_HOLD_BUF1971}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_trim_value/u_unlock_sync}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1212/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1972} -new_cell_names {U_PTECO_HOLD_BUF1972}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_spi_ser_edge}
insert_buffer [get_pins {d_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1973} -new_cell_names {U_PTECO_HOLD_BUF1973}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_spi_cer_edge}
insert_buffer [get_pins {d_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1974} -new_cell_names {U_PTECO_HOLD_BUF1974}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_spi_rd_command_sync_edge}
insert_buffer [get_pins {d_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1975} -new_cell_names {U_PTECO_HOLD_BUF1975}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_atm_unlock_edge}
insert_buffer [get_pins {d_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1976} -new_cell_names {U_PTECO_HOLD_BUF1976}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_phase_accumulator}
insert_buffer [get_pins {dds_state_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1977} -new_cell_names {U_PTECO_HOLD_BUF1977}
current_instance
current_instance {top_dig_always_on_inst/reset_ctrl_always_on_inst}
insert_buffer [get_pins {U43/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1978} -new_cell_names {U_PTECO_HOLD_BUF1978}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {fifo_rd_data_sync_reg_0_/D}] BUFX4M -new_net_names {net_PTECO_HOLD_NET1979} -new_cell_names {U_PTECO_HOLD_BUF1979}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U594/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1980} -new_cell_names {U_PTECO_HOLD_BUF1980}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1164/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1981} -new_cell_names {U_PTECO_HOLD_BUF1981}
current_instance
current_instance {top_dig_always_on_inst/pinmux_always_on_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1288/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1982} -new_cell_names {U_PTECO_HOLD_BUF1982}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1289/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1983} -new_cell_names {U_PTECO_HOLD_BUF1983}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1290/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1984} -new_cell_names {U_PTECO_HOLD_BUF1984}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1291/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1985} -new_cell_names {U_PTECO_HOLD_BUF1985}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1292/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1986} -new_cell_names {U_PTECO_HOLD_BUF1986}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1293/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1987} -new_cell_names {U_PTECO_HOLD_BUF1987}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1294/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1988} -new_cell_names {U_PTECO_HOLD_BUF1988}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1295/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1989} -new_cell_names {U_PTECO_HOLD_BUF1989}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1296/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1990} -new_cell_names {U_PTECO_HOLD_BUF1990}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_24__12_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1991} -new_cell_names {U_PTECO_HOLD_BUF1991}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1310/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1992} -new_cell_names {U_PTECO_HOLD_BUF1992}
insert_buffer [get_pins {trim_regs_reg_17__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1993} -new_cell_names {U_PTECO_HOLD_BUF1993}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1312/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1994} -new_cell_names {U_PTECO_HOLD_BUF1994}
insert_buffer [get_pins {trim_regs_reg_9__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1995} -new_cell_names {U_PTECO_HOLD_BUF1995}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1316/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1996} -new_cell_names {U_PTECO_HOLD_BUF1996}
insert_buffer [get_pins {trim_regs_reg_5__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1997} -new_cell_names {U_PTECO_HOLD_BUF1997}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1318/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1998} -new_cell_names {U_PTECO_HOLD_BUF1998}
insert_buffer [get_pins {trim_regs_reg_5__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET1999} -new_cell_names {U_PTECO_HOLD_BUF1999}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF338/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2000} -new_cell_names {U_PTECO_HOLD_BUF2000}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1325/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2001} -new_cell_names {U_PTECO_HOLD_BUF2001}
insert_buffer [get_pins {trim_regs_reg_5__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2002} -new_cell_names {U_PTECO_HOLD_BUF2002}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1319/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2003} -new_cell_names {U_PTECO_HOLD_BUF2003}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1321/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2004} -new_cell_names {U_PTECO_HOLD_BUF2004}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1322/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2005} -new_cell_names {U_PTECO_HOLD_BUF2005}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_16__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2006} -new_cell_names {U_PTECO_HOLD_BUF2006}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1324/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2007} -new_cell_names {U_PTECO_HOLD_BUF2007}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1320/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2008} -new_cell_names {U_PTECO_HOLD_BUF2008}
insert_buffer [get_pins {rnd_regs_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2009} -new_cell_names {U_PTECO_HOLD_BUF2009}
insert_buffer [get_pins {trim_regs_reg_16__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2010} -new_cell_names {U_PTECO_HOLD_BUF2010}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1335/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2011} -new_cell_names {U_PTECO_HOLD_BUF2011}
insert_buffer [get_pins {regs_confen_data_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2012} -new_cell_names {U_PTECO_HOLD_BUF2012}
insert_buffer [get_pins {trim_regs_reg_18__7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2013} -new_cell_names {U_PTECO_HOLD_BUF2013}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1326/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2014} -new_cell_names {U_PTECO_HOLD_BUF2014}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1327/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2015} -new_cell_names {U_PTECO_HOLD_BUF2015}
insert_buffer [get_pins {reg_confen_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2016} -new_cell_names {U_PTECO_HOLD_BUF2016}
insert_buffer [get_pins {reg_confen_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2017} -new_cell_names {U_PTECO_HOLD_BUF2017}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1314/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2018} -new_cell_names {U_PTECO_HOLD_BUF2018}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1333/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2019} -new_cell_names {U_PTECO_HOLD_BUF2019}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1334/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2020} -new_cell_names {U_PTECO_HOLD_BUF2020}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1315/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2021} -new_cell_names {U_PTECO_HOLD_BUF2021}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1332/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2022} -new_cell_names {U_PTECO_HOLD_BUF2022}
insert_buffer [get_pins {trim_regs_reg_10__3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2023} -new_cell_names {U_PTECO_HOLD_BUF2023}
insert_buffer [get_pins {trim_regs_reg_10__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2024} -new_cell_names {U_PTECO_HOLD_BUF2024}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1340/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2025} -new_cell_names {U_PTECO_HOLD_BUF2025}
insert_buffer [get_pins {trim_regs_reg_8__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2026} -new_cell_names {U_PTECO_HOLD_BUF2026}
insert_buffer [get_pins {trim_regs_reg_44__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2027} -new_cell_names {U_PTECO_HOLD_BUF2027}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1311/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2028} -new_cell_names {U_PTECO_HOLD_BUF2028}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1341/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2029} -new_cell_names {U_PTECO_HOLD_BUF2029}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1336/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2030} -new_cell_names {U_PTECO_HOLD_BUF2030}
insert_buffer [get_pins {trim_regs_reg_17__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2031} -new_cell_names {U_PTECO_HOLD_BUF2031}
insert_buffer [get_pins {trim_regs_reg_10__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2032} -new_cell_names {U_PTECO_HOLD_BUF2032}
insert_buffer [get_pins {trim_regs_reg_9__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2033} -new_cell_names {U_PTECO_HOLD_BUF2033}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1339/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2034} -new_cell_names {U_PTECO_HOLD_BUF2034}
insert_buffer [get_pins {trim_regs_reg_5__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2035} -new_cell_names {U_PTECO_HOLD_BUF2035}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1317/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2036} -new_cell_names {U_PTECO_HOLD_BUF2036}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1323/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2037} -new_cell_names {U_PTECO_HOLD_BUF2037}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1313/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2038} -new_cell_names {U_PTECO_HOLD_BUF2038}
insert_buffer [get_pins {trim_regs_reg_16__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2039} -new_cell_names {U_PTECO_HOLD_BUF2039}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1337/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2040} -new_cell_names {U_PTECO_HOLD_BUF2040}
insert_buffer [get_pins {trim_regs_reg_16__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2041} -new_cell_names {U_PTECO_HOLD_BUF2041}
insert_buffer [get_pins {trim_regs_reg_18__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2042} -new_cell_names {U_PTECO_HOLD_BUF2042}
insert_buffer [get_pins {U789/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2043} -new_cell_names {U_PTECO_HOLD_BUF2043}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1361/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2044} -new_cell_names {U_PTECO_HOLD_BUF2044}
insert_buffer [get_pins {led_on_temp_reg_12_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2045} -new_cell_names {U_PTECO_HOLD_BUF2045}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_14/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2046} -new_cell_names {U_PTECO_HOLD_BUF2046}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1371/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2047} -new_cell_names {U_PTECO_HOLD_BUF2047}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_0_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1353/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2048} -new_cell_names {U_PTECO_HOLD_BUF2048}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_40__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2049} -new_cell_names {U_PTECO_HOLD_BUF2049}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_18/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2050} -new_cell_names {U_PTECO_HOLD_BUF2050}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2051} -new_cell_names {U_PTECO_HOLD_BUF2051}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1349/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2052} -new_cell_names {U_PTECO_HOLD_BUF2052}
insert_buffer [get_pins {led_freq_temp_reg_9_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2053} -new_cell_names {U_PTECO_HOLD_BUF2053}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1351/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2054} -new_cell_names {U_PTECO_HOLD_BUF2054}
insert_buffer [get_pins {led_freq_temp_reg_10_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2055} -new_cell_names {U_PTECO_HOLD_BUF2055}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_1_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1357/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2056} -new_cell_names {U_PTECO_HOLD_BUF2056}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2057} -new_cell_names {U_PTECO_HOLD_BUF2057}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1342/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2058} -new_cell_names {U_PTECO_HOLD_BUF2058}
insert_buffer [get_pins {trim_regs_reg_19__3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2059} -new_cell_names {U_PTECO_HOLD_BUF2059}
insert_buffer [get_pins {trim_regs_reg_7__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2060} -new_cell_names {U_PTECO_HOLD_BUF2060}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U321/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2061} -new_cell_names {U_PTECO_HOLD_BUF2061}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_EN_sync}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1368/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2062} -new_cell_names {U_PTECO_HOLD_BUF2062}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1378/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2063} -new_cell_names {U_PTECO_HOLD_BUF2063}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_EN_sync}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2064} -new_cell_names {U_PTECO_HOLD_BUF2064}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_37__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2065} -new_cell_names {U_PTECO_HOLD_BUF2065}
insert_buffer [get_pins {trim_regs_reg_18__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2066} -new_cell_names {U_PTECO_HOLD_BUF2066}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1360/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2067} -new_cell_names {U_PTECO_HOLD_BUF2067}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1344/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2068} -new_cell_names {U_PTECO_HOLD_BUF2068}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1352/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2069} -new_cell_names {U_PTECO_HOLD_BUF2069}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U287/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2070} -new_cell_names {U_PTECO_HOLD_BUF2070}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_19__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2071} -new_cell_names {U_PTECO_HOLD_BUF2071}
insert_buffer [get_pins {trim_regs_reg_19__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2072} -new_cell_names {U_PTECO_HOLD_BUF2072}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1391/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2073} -new_cell_names {U_PTECO_HOLD_BUF2073}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF329/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2074} -new_cell_names {U_PTECO_HOLD_BUF2074}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1363/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2075} -new_cell_names {U_PTECO_HOLD_BUF2075}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1347/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2076} -new_cell_names {U_PTECO_HOLD_BUF2076}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U298/A1N}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2077} -new_cell_names {U_PTECO_HOLD_BUF2077}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_16__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2078} -new_cell_names {U_PTECO_HOLD_BUF2078}
insert_buffer [get_pins {trim_regs_reg_16__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2079} -new_cell_names {U_PTECO_HOLD_BUF2079}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1406/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2080} -new_cell_names {U_PTECO_HOLD_BUF2080}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1404/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2081} -new_cell_names {U_PTECO_HOLD_BUF2081}
insert_buffer [get_pins {lost_item_count_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2082} -new_cell_names {U_PTECO_HOLD_BUF2082}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1364/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2083} -new_cell_names {U_PTECO_HOLD_BUF2083}
insert_buffer [get_pins {nvr2_trim_tag_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2084} -new_cell_names {U_PTECO_HOLD_BUF2084}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LEDDAC_SEL_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2085} -new_cell_names {U_PTECO_HOLD_BUF2085}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_16__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2086} -new_cell_names {U_PTECO_HOLD_BUF2086}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1358/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2087} -new_cell_names {U_PTECO_HOLD_BUF2087}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF313/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2088} -new_cell_names {U_PTECO_HOLD_BUF2088}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2089} -new_cell_names {U_PTECO_HOLD_BUF2089}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1402/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2090} -new_cell_names {U_PTECO_HOLD_BUF2090}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1398/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2091} -new_cell_names {U_PTECO_HOLD_BUF2091}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1407/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2092} -new_cell_names {U_PTECO_HOLD_BUF2092}
insert_buffer [get_pins {trim_regs_reg_47__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2093} -new_cell_names {U_PTECO_HOLD_BUF2093}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_freq_temp_reg_11_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2094} -new_cell_names {U_PTECO_HOLD_BUF2094}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1399/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2095} -new_cell_names {U_PTECO_HOLD_BUF2095}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_48__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2096} -new_cell_names {U_PTECO_HOLD_BUF2096}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_freq_temp_reg_3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2097} -new_cell_names {U_PTECO_HOLD_BUF2097}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1401/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2098} -new_cell_names {U_PTECO_HOLD_BUF2098}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1382/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2099} -new_cell_names {U_PTECO_HOLD_BUF2099}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_freq_temp_reg_5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2100} -new_cell_names {U_PTECO_HOLD_BUF2100}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_12__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2101} -new_cell_names {U_PTECO_HOLD_BUF2101}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1394/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2102} -new_cell_names {U_PTECO_HOLD_BUF2102}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1411/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2103} -new_cell_names {U_PTECO_HOLD_BUF2103}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1412/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2104} -new_cell_names {U_PTECO_HOLD_BUF2104}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1413/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2105} -new_cell_names {U_PTECO_HOLD_BUF2105}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1414/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2106} -new_cell_names {U_PTECO_HOLD_BUF2106}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1415/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2107} -new_cell_names {U_PTECO_HOLD_BUF2107}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1416/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2108} -new_cell_names {U_PTECO_HOLD_BUF2108}
insert_buffer [get_pins {led_on_temp_reg_11_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2109} -new_cell_names {U_PTECO_HOLD_BUF2109}
insert_buffer [get_pins {led_on_temp_reg_0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2110} -new_cell_names {U_PTECO_HOLD_BUF2110}
insert_buffer [get_pins {led_on_temp_reg_8_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2111} -new_cell_names {U_PTECO_HOLD_BUF2111}
insert_buffer [get_pins {led_freq_temp_reg_12_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2112} -new_cell_names {U_PTECO_HOLD_BUF2112}
insert_buffer [get_pins {led_on_temp_reg_5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2113} -new_cell_names {U_PTECO_HOLD_BUF2113}
insert_buffer [get_pins {led_on_temp_reg_9_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2114} -new_cell_names {U_PTECO_HOLD_BUF2114}
insert_buffer [get_pins {led_on_temp_reg_7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2115} -new_cell_names {U_PTECO_HOLD_BUF2115}
insert_buffer [get_pins {led_on_temp_reg_6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2116} -new_cell_names {U_PTECO_HOLD_BUF2116}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1452/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2117} -new_cell_names {U_PTECO_HOLD_BUF2117}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1453/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2118} -new_cell_names {U_PTECO_HOLD_BUF2118}
insert_buffer [get_pins {trim_reg_reg_10__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2119} -new_cell_names {U_PTECO_HOLD_BUF2119}
insert_buffer [get_pins {trim_reg_reg_10__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2120} -new_cell_names {U_PTECO_HOLD_BUF2120}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF335/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2121} -new_cell_names {U_PTECO_HOLD_BUF2121}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1362/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2122} -new_cell_names {U_PTECO_HOLD_BUF2122}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1418/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2123} -new_cell_names {U_PTECO_HOLD_BUF2123}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1419/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2124} -new_cell_names {U_PTECO_HOLD_BUF2124}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1420/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2125} -new_cell_names {U_PTECO_HOLD_BUF2125}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1421/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2126} -new_cell_names {U_PTECO_HOLD_BUF2126}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2127} -new_cell_names {U_PTECO_HOLD_BUF2127}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_on_temp_reg_2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2128} -new_cell_names {U_PTECO_HOLD_BUF2128}
insert_buffer [get_pins {led_on_temp_reg_4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2129} -new_cell_names {U_PTECO_HOLD_BUF2129}
insert_buffer [get_pins {led_on_temp_reg_3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2130} -new_cell_names {U_PTECO_HOLD_BUF2130}
insert_buffer [get_pins {led_freq_temp_reg_1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2131} -new_cell_names {U_PTECO_HOLD_BUF2131}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch2data_en_reg_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2132} -new_cell_names {U_PTECO_HOLD_BUF2132}
insert_buffer [get_pins {rst_cnt_reg_7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2133} -new_cell_names {U_PTECO_HOLD_BUF2133}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {nvr2_trim_tag_lock_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2134} -new_cell_names {U_PTECO_HOLD_BUF2134}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1443/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2135} -new_cell_names {U_PTECO_HOLD_BUF2135}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_14__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2136} -new_cell_names {U_PTECO_HOLD_BUF2136}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1381/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2137} -new_cell_names {U_PTECO_HOLD_BUF2137}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1365/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2138} -new_cell_names {U_PTECO_HOLD_BUF2138}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1377/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2139} -new_cell_names {U_PTECO_HOLD_BUF2139}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1380/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2140} -new_cell_names {U_PTECO_HOLD_BUF2140}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1385/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2141} -new_cell_names {U_PTECO_HOLD_BUF2141}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1379/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2142} -new_cell_names {U_PTECO_HOLD_BUF2142}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1375/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2143} -new_cell_names {U_PTECO_HOLD_BUF2143}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1366/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2144} -new_cell_names {U_PTECO_HOLD_BUF2144}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1356/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2145} -new_cell_names {U_PTECO_HOLD_BUF2145}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1376/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2146} -new_cell_names {U_PTECO_HOLD_BUF2146}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1367/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2147} -new_cell_names {U_PTECO_HOLD_BUF2147}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_123__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2148} -new_cell_names {U_PTECO_HOLD_BUF2148}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2149} -new_cell_names {U_PTECO_HOLD_BUF2149}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst/u_fifo_flush_n_sync}
insert_buffer [get_pins {U_PTECO_HOLD_BUF566/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2150} -new_cell_names {U_PTECO_HOLD_BUF2150}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2151} -new_cell_names {U_PTECO_HOLD_BUF2151}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statp/u_switch_rstn_sync}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1445/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2152} -new_cell_names {U_PTECO_HOLD_BUF2152}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statp/u_dur_sync_pclk}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1444/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2153} -new_cell_names {U_PTECO_HOLD_BUF2153}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_17__6_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2154} -new_cell_names {U_PTECO_HOLD_BUF2154}
insert_buffer [get_pins {trim_regs_reg_17__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2155} -new_cell_names {U_PTECO_HOLD_BUF2155}
insert_buffer [get_pins {trim_regs_reg_17__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2156} -new_cell_names {U_PTECO_HOLD_BUF2156}
insert_buffer [get_pins {trim_regs_reg_17__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2157} -new_cell_names {U_PTECO_HOLD_BUF2157}
insert_buffer [get_pins {trim_regs_reg_17__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2158} -new_cell_names {U_PTECO_HOLD_BUF2158}
insert_buffer [get_pins {trim_regs_reg_17__7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2159} -new_cell_names {U_PTECO_HOLD_BUF2159}
insert_buffer [get_pins {trim_regs_reg_17__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2160} -new_cell_names {U_PTECO_HOLD_BUF2160}
insert_buffer [get_pins {trim_regs_reg_19__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2161} -new_cell_names {U_PTECO_HOLD_BUF2161}
insert_buffer [get_pins {trim_regs_reg_19__5_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2162} -new_cell_names {U_PTECO_HOLD_BUF2162}
insert_buffer [get_pins {trim_regs_reg_16__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2163} -new_cell_names {U_PTECO_HOLD_BUF2163}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch0data_reg_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2164} -new_cell_names {U_PTECO_HOLD_BUF2164}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statp/u_switch_rstn_sync}
insert_buffer [get_pins {rst_sync1_n_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2165} -new_cell_names {U_PTECO_HOLD_BUF2165}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statp/u_dur_sync_pclk}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2166} -new_cell_names {U_PTECO_HOLD_BUF2166}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_acloff_statn}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1446/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2167} -new_cell_names {U_PTECO_HOLD_BUF2167}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1447/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2168} -new_cell_names {U_PTECO_HOLD_BUF2168}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_acloff_statn}
insert_buffer [get_pins {leadoff_switch_tgt_cnt_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2169} -new_cell_names {U_PTECO_HOLD_BUF2169}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1450/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2170} -new_cell_names {U_PTECO_HOLD_BUF2170}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_8__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2171} -new_cell_names {U_PTECO_HOLD_BUF2171}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {Freq_ctrl_temp_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2172} -new_cell_names {U_PTECO_HOLD_BUF2172}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_EN_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2173} -new_cell_names {U_PTECO_HOLD_BUF2173}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U662/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2174} -new_cell_names {U_PTECO_HOLD_BUF2174}
insert_buffer [get_pins {trim_regs_reg_33__0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2175} -new_cell_names {U_PTECO_HOLD_BUF2175}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_acloff_statn}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1461/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2176} -new_cell_names {U_PTECO_HOLD_BUF2176}
insert_buffer [get_pins {leadoff_switch_tgt_cnt_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2177} -new_cell_names {U_PTECO_HOLD_BUF2177}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_2_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1422/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2178} -new_cell_names {U_PTECO_HOLD_BUF2178}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U611/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2179} -new_cell_names {U_PTECO_HOLD_BUF2179}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2180} -new_cell_names {U_PTECO_HOLD_BUF2180}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1465/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2181} -new_cell_names {U_PTECO_HOLD_BUF2181}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1464/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2182} -new_cell_names {U_PTECO_HOLD_BUF2182}
insert_buffer [get_pins {ch0data_delta_final_reg_13_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2183} -new_cell_names {U_PTECO_HOLD_BUF2183}
insert_buffer [get_pins {ch0data_delta_final_reg_15_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2184} -new_cell_names {U_PTECO_HOLD_BUF2184}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1467/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2185} -new_cell_names {U_PTECO_HOLD_BUF2185}
insert_buffer [get_pins {ch0data_delta_final_reg_10_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2186} -new_cell_names {U_PTECO_HOLD_BUF2186}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1468/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2187} -new_cell_names {U_PTECO_HOLD_BUF2187}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {empty_sts_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2188} -new_cell_names {U_PTECO_HOLD_BUF2188}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {ch0data_delta_final_reg_11_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2189} -new_cell_names {U_PTECO_HOLD_BUF2189}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs/u_wr_spi}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1456/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2190} -new_cell_names {U_PTECO_HOLD_BUF2190}
insert_buffer [get_pins {data_reg_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2191} -new_cell_names {U_PTECO_HOLD_BUF2191}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_46__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2192} -new_cell_names {U_PTECO_HOLD_BUF2192}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {a_full_local_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2193} -new_cell_names {U_PTECO_HOLD_BUF2193}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_101__10_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2194} -new_cell_names {U_PTECO_HOLD_BUF2194}
insert_buffer [get_pins {mem_reg_101__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2195} -new_cell_names {U_PTECO_HOLD_BUF2195}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {fsm_counter_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2196} -new_cell_names {U_PTECO_HOLD_BUF2196}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U664/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2197} -new_cell_names {U_PTECO_HOLD_BUF2197}
insert_buffer [get_pins {U668/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2198} -new_cell_names {U_PTECO_HOLD_BUF2198}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1493/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2199} -new_cell_names {U_PTECO_HOLD_BUF2199}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_10_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1457/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2200} -new_cell_names {U_PTECO_HOLD_BUF2200}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {trim_reg_updated_reg_18_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2201} -new_cell_names {U_PTECO_HOLD_BUF2201}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1427/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2202} -new_cell_names {U_PTECO_HOLD_BUF2202}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1429/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2203} -new_cell_names {U_PTECO_HOLD_BUF2203}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1430/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2204} -new_cell_names {U_PTECO_HOLD_BUF2204}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1431/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2205} -new_cell_names {U_PTECO_HOLD_BUF2205}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {fsm_counter_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2206} -new_cell_names {U_PTECO_HOLD_BUF2206}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_18__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2207} -new_cell_names {U_PTECO_HOLD_BUF2207}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_10_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2208} -new_cell_names {U_PTECO_HOLD_BUF2208}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_13__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2209} -new_cell_names {U_PTECO_HOLD_BUF2209}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_6_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2210} -new_cell_names {U_PTECO_HOLD_BUF2210}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1474/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2211} -new_cell_names {U_PTECO_HOLD_BUF2211}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_105__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2212} -new_cell_names {U_PTECO_HOLD_BUF2212}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2213} -new_cell_names {U_PTECO_HOLD_BUF2213}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {fsm_counter_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2214} -new_cell_names {U_PTECO_HOLD_BUF2214}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {lost_item_count_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2215} -new_cell_names {U_PTECO_HOLD_BUF2215}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_42__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2216} -new_cell_names {U_PTECO_HOLD_BUF2216}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_95__12_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2217} -new_cell_names {U_PTECO_HOLD_BUF2217}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF407/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2218} -new_cell_names {U_PTECO_HOLD_BUF2218}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1451/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2219} -new_cell_names {U_PTECO_HOLD_BUF2219}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1480/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2220} -new_cell_names {U_PTECO_HOLD_BUF2220}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2221} -new_cell_names {U_PTECO_HOLD_BUF2221}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {flash_nvr_pro00_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2222} -new_cell_names {U_PTECO_HOLD_BUF2222}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1481/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2223} -new_cell_names {U_PTECO_HOLD_BUF2223}
insert_buffer [get_pins {empty_n_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2224} -new_cell_names {U_PTECO_HOLD_BUF2224}
current_instance
current_instance {u_top_dig/u_imeas}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1494/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2225} -new_cell_names {U_PTECO_HOLD_BUF2225}
insert_buffer [get_pins {ch0data_delta_final_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2226} -new_cell_names {U_PTECO_HOLD_BUF2226}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_104__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2227} -new_cell_names {U_PTECO_HOLD_BUF2227}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {rst_cnt_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2228} -new_cell_names {U_PTECO_HOLD_BUF2228}
current_instance
current_instance {u_top_dig/u_zmeas/u_zmeas_top/u_zmeas_phase_accumulator}
insert_buffer [get_pins {dds_phase_add_reg_18_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2229} -new_cell_names {U_PTECO_HOLD_BUF2229}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {rst_cnt_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2230} -new_cell_names {U_PTECO_HOLD_BUF2230}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_72__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2231} -new_cell_names {U_PTECO_HOLD_BUF2231}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch_cnt_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2232} -new_cell_names {U_PTECO_HOLD_BUF2232}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_7_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1473/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2233} -new_cell_names {U_PTECO_HOLD_BUF2233}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_8_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1518/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2234} -new_cell_names {U_PTECO_HOLD_BUF2234}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {DFT_4/B1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2235} -new_cell_names {U_PTECO_HOLD_BUF2235}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_7_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2236} -new_cell_names {U_PTECO_HOLD_BUF2236}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_8_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2237} -new_cell_names {U_PTECO_HOLD_BUF2237}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_48__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2238} -new_cell_names {U_PTECO_HOLD_BUF2238}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {word_count_reg_0_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2239} -new_cell_names {U_PTECO_HOLD_BUF2239}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_48__2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2240} -new_cell_names {U_PTECO_HOLD_BUF2240}
current_instance
current_instance {u_top_dig/u_imeas/u_leadoff_chk_loff_statn/u_switch_rstn_sync}
insert_buffer [get_pins {rst_sync1_n_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2241} -new_cell_names {U_PTECO_HOLD_BUF2241}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_4__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2242} -new_cell_names {U_PTECO_HOLD_BUF2242}
insert_buffer [get_pins {trim_regs_reg_4__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2243} -new_cell_names {U_PTECO_HOLD_BUF2243}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_8_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2244} -new_cell_names {U_PTECO_HOLD_BUF2244}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_EN_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2245} -new_cell_names {U_PTECO_HOLD_BUF2245}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch0data_en_reg_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2246} -new_cell_names {U_PTECO_HOLD_BUF2246}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U781/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2247} -new_cell_names {U_PTECO_HOLD_BUF2247}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_4_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2248} -new_cell_names {U_PTECO_HOLD_BUF2248}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2249} -new_cell_names {U_PTECO_HOLD_BUF2249}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2250} -new_cell_names {U_PTECO_HOLD_BUF2250}
current_instance
current_instance {u_top_dig/spi_top_u/spi_slv_ctrl_u}
insert_buffer [get_pins {byte_bit_count_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2251} -new_cell_names {U_PTECO_HOLD_BUF2251}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1438/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2252} -new_cell_names {U_PTECO_HOLD_BUF2252}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_16/A0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2253} -new_cell_names {U_PTECO_HOLD_BUF2253}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_9_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2254} -new_cell_names {U_PTECO_HOLD_BUF2254}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_9_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2255} -new_cell_names {U_PTECO_HOLD_BUF2255}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_6_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2256} -new_cell_names {U_PTECO_HOLD_BUF2256}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_11_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2257} -new_cell_names {U_PTECO_HOLD_BUF2257}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_10_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2258} -new_cell_names {U_PTECO_HOLD_BUF2258}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_EN_PPG_SH_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2259} -new_cell_names {U_PTECO_HOLD_BUF2259}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_EN_PPG_AF_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2260} -new_cell_names {U_PTECO_HOLD_BUF2260}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2261} -new_cell_names {U_PTECO_HOLD_BUF2261}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_Freq_sel_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2262} -new_cell_names {U_PTECO_HOLD_BUF2262}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2263} -new_cell_names {U_PTECO_HOLD_BUF2263}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_SH_CK_sync}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2264} -new_cell_names {U_PTECO_HOLD_BUF2264}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_7_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2265} -new_cell_names {U_PTECO_HOLD_BUF2265}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LED_STANDBYEN_sync}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2266} -new_cell_names {U_PTECO_HOLD_BUF2266}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {fifo_intr_local_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2267} -new_cell_names {U_PTECO_HOLD_BUF2267}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U814/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2268} -new_cell_names {U_PTECO_HOLD_BUF2268}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2269} -new_cell_names {U_PTECO_HOLD_BUF2269}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_5_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2270} -new_cell_names {U_PTECO_HOLD_BUF2270}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2271} -new_cell_names {U_PTECO_HOLD_BUF2271}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U719/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2272} -new_cell_names {U_PTECO_HOLD_BUF2272}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_IDAC_sync_7_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2273} -new_cell_names {U_PTECO_HOLD_BUF2273}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_Freq_sel_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2274} -new_cell_names {U_PTECO_HOLD_BUF2274}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2275} -new_cell_names {U_PTECO_HOLD_BUF2275}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2276} -new_cell_names {U_PTECO_HOLD_BUF2276}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_Freq_sel_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2277} -new_cell_names {U_PTECO_HOLD_BUF2277}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_time_sel_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2278} -new_cell_names {U_PTECO_HOLD_BUF2278}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U760/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2279} -new_cell_names {U_PTECO_HOLD_BUF2279}
insert_buffer [get_pins {U785/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2280} -new_cell_names {U_PTECO_HOLD_BUF2280}
insert_buffer [get_pins {U691/A1}] BUFX8M -new_net_names {net_PTECO_HOLD_NET2281} -new_cell_names {U_PTECO_HOLD_BUF2281}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_led_Freq_sel_sync_1_}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2282} -new_cell_names {U_PTECO_HOLD_BUF2282}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_4_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2283} -new_cell_names {U_PTECO_HOLD_BUF2283}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC0_VSEL_sync_5_}
insert_buffer [get_pins {async_in_d2_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2284} -new_cell_names {U_PTECO_HOLD_BUF2284}
insert_buffer [get_pins {async_in_d1_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2285} -new_cell_names {U_PTECO_HOLD_BUF2285}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U708/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2286} -new_cell_names {U_PTECO_HOLD_BUF2286}
insert_buffer [get_pins {U560/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2287} -new_cell_names {U_PTECO_HOLD_BUF2287}
insert_buffer [get_pins {trim_regs_reg_2__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2288} -new_cell_names {U_PTECO_HOLD_BUF2288}
insert_buffer [get_pins {trim_regs_reg_2__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2289} -new_cell_names {U_PTECO_HOLD_BUF2289}
insert_buffer [get_pins {trim_regs_reg_2__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2290} -new_cell_names {U_PTECO_HOLD_BUF2290}
insert_buffer [get_pins {trim_regs_reg_20__4_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2291} -new_cell_names {U_PTECO_HOLD_BUF2291}
insert_buffer [get_pins {trim_regs_reg_20__2_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2292} -new_cell_names {U_PTECO_HOLD_BUF2292}
insert_buffer [get_pins {trim_regs_reg_20__3_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2293} -new_cell_names {U_PTECO_HOLD_BUF2293}
insert_buffer [get_pins {trim_regs_reg_20__7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2294} -new_cell_names {U_PTECO_HOLD_BUF2294}
insert_buffer [get_pins {trim_regs_reg_20__1_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2295} -new_cell_names {U_PTECO_HOLD_BUF2295}
insert_buffer [get_pins {trim_regs_reg_20__0_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2296} -new_cell_names {U_PTECO_HOLD_BUF2296}
insert_buffer [get_pins {U827/A1}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2297} -new_cell_names {U_PTECO_HOLD_BUF2297}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch0data_reg_reg_13_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2298} -new_cell_names {U_PTECO_HOLD_BUF2298}
insert_buffer [get_pins {ch1data_reg_reg_15_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2299} -new_cell_names {U_PTECO_HOLD_BUF2299}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {trim_regs_reg_44__3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2300} -new_cell_names {U_PTECO_HOLD_BUF2300}
insert_buffer [get_pins {trim_regs_reg_6__6_/D}] BUFX8M -new_net_names {net_PTECO_HOLD_NET2301} -new_cell_names {U_PTECO_HOLD_BUF2301}
insert_buffer [get_pins {U_PTECO_HOLD_BUF423/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2302} -new_cell_names {U_PTECO_HOLD_BUF2302}
insert_buffer [get_pins {U_PTECO_HOLD_BUF444/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2303} -new_cell_names {U_PTECO_HOLD_BUF2303}
insert_buffer [get_pins {trim_regs_reg_2__0_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2304} -new_cell_names {U_PTECO_HOLD_BUF2304}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {Freq_ctrl_temp_reg_4_/SI}] BUFX8M -new_net_names {net_PTECO_HOLD_NET2305} -new_cell_names {U_PTECO_HOLD_BUF2305}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U494/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2306} -new_cell_names {U_PTECO_HOLD_BUF2306}
insert_buffer [get_pins {U703/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2307} -new_cell_names {U_PTECO_HOLD_BUF2307}
insert_buffer [get_pins {U490/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2308} -new_cell_names {U_PTECO_HOLD_BUF2308}
insert_buffer [get_pins {U536/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2309} -new_cell_names {U_PTECO_HOLD_BUF2309}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_2_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2310} -new_cell_names {U_PTECO_HOLD_BUF2310}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U532/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2311} -new_cell_names {U_PTECO_HOLD_BUF2311}
insert_buffer [get_pins {U514/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2312} -new_cell_names {U_PTECO_HOLD_BUF2312}
insert_buffer [get_pins {U526/A1}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2313} -new_cell_names {U_PTECO_HOLD_BUF2313}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cdc/u_ppg_sh_ck_sync}
insert_buffer [get_pins {async_in_d2_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2314} -new_cell_names {U_PTECO_HOLD_BUF2314}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {fsm_counter_reg_1_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2315} -new_cell_names {U_PTECO_HOLD_BUF2315}
insert_buffer [get_pins {fsm_counter_reg_0_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2316} -new_cell_names {U_PTECO_HOLD_BUF2316}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF455/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2317} -new_cell_names {U_PTECO_HOLD_BUF2317}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_0_}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2318} -new_cell_names {U_PTECO_HOLD_BUF2318}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cdc/u_ppg_sh_ck_sync}
insert_buffer [get_pins {async_in_d1_reg/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2319} -new_cell_names {U_PTECO_HOLD_BUF2319}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u}
insert_buffer [get_pins {square_clk_div_1_reg_6_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2320} -new_cell_names {U_PTECO_HOLD_BUF2320}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {fsm_counter_reg_10_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2321} -new_cell_names {U_PTECO_HOLD_BUF2321}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {DFT_4/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2322} -new_cell_names {U_PTECO_HOLD_BUF2322}
current_instance
current_instance {u_top_dig/spi_top_u/spi_reg_u/u_spi_reg_flash}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1322/Y}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2323} -new_cell_names {U_PTECO_HOLD_BUF2323}
current_instance
current_instance {top_dig_always_on_inst/pinmux_always_on_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1845/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2324} -new_cell_names {U_PTECO_HOLD_BUF2324}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1844/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2325} -new_cell_names {U_PTECO_HOLD_BUF2325}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1846/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2326} -new_cell_names {U_PTECO_HOLD_BUF2326}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1847/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2327} -new_cell_names {U_PTECO_HOLD_BUF2327}
insert_buffer [get_pins {U_PTECO_HOLD_BUF6/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2328} -new_cell_names {U_PTECO_HOLD_BUF2328}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1849/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2329} -new_cell_names {U_PTECO_HOLD_BUF2329}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1850/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2330} -new_cell_names {U_PTECO_HOLD_BUF2330}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1852/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2331} -new_cell_names {U_PTECO_HOLD_BUF2331}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1853/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2332} -new_cell_names {U_PTECO_HOLD_BUF2332}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF18/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2333} -new_cell_names {U_PTECO_HOLD_BUF2333}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1855/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2334} -new_cell_names {U_PTECO_HOLD_BUF2334}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1856/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2335} -new_cell_names {U_PTECO_HOLD_BUF2335}
insert_buffer [get_pins {U_PTECO_HOLD_BUF21/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2336} -new_cell_names {U_PTECO_HOLD_BUF2336}
insert_buffer [get_pins {U_PTECO_HOLD_BUF22/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2337} -new_cell_names {U_PTECO_HOLD_BUF2337}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1902/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2338} -new_cell_names {U_PTECO_HOLD_BUF2338}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1858/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2339} -new_cell_names {U_PTECO_HOLD_BUF2339}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1859/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2340} -new_cell_names {U_PTECO_HOLD_BUF2340}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1860/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2341} -new_cell_names {U_PTECO_HOLD_BUF2341}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1861/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2342} -new_cell_names {U_PTECO_HOLD_BUF2342}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1284/Y}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2343} -new_cell_names {U_PTECO_HOLD_BUF2343}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1862/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2344} -new_cell_names {U_PTECO_HOLD_BUF2344}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1863/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2345} -new_cell_names {U_PTECO_HOLD_BUF2345}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1864/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2346} -new_cell_names {U_PTECO_HOLD_BUF2346}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1865/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2347} -new_cell_names {U_PTECO_HOLD_BUF2347}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1866/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2348} -new_cell_names {U_PTECO_HOLD_BUF2348}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1867/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2349} -new_cell_names {U_PTECO_HOLD_BUF2349}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1868/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2350} -new_cell_names {U_PTECO_HOLD_BUF2350}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1869/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2351} -new_cell_names {U_PTECO_HOLD_BUF2351}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1870/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2352} -new_cell_names {U_PTECO_HOLD_BUF2352}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1871/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2353} -new_cell_names {U_PTECO_HOLD_BUF2353}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1872/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2354} -new_cell_names {U_PTECO_HOLD_BUF2354}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1874/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2355} -new_cell_names {U_PTECO_HOLD_BUF2355}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1875/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2356} -new_cell_names {U_PTECO_HOLD_BUF2356}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1873/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2357} -new_cell_names {U_PTECO_HOLD_BUF2357}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1878/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2358} -new_cell_names {U_PTECO_HOLD_BUF2358}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1879/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2359} -new_cell_names {U_PTECO_HOLD_BUF2359}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1876/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2360} -new_cell_names {U_PTECO_HOLD_BUF2360}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1881/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2361} -new_cell_names {U_PTECO_HOLD_BUF2361}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1877/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2362} -new_cell_names {U_PTECO_HOLD_BUF2362}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1882/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2363} -new_cell_names {U_PTECO_HOLD_BUF2363}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1884/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2364} -new_cell_names {U_PTECO_HOLD_BUF2364}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1880/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2365} -new_cell_names {U_PTECO_HOLD_BUF2365}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1886/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2366} -new_cell_names {U_PTECO_HOLD_BUF2366}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1889/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2367} -new_cell_names {U_PTECO_HOLD_BUF2367}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1883/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2368} -new_cell_names {U_PTECO_HOLD_BUF2368}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1891/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2369} -new_cell_names {U_PTECO_HOLD_BUF2369}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1885/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2370} -new_cell_names {U_PTECO_HOLD_BUF2370}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1893/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2371} -new_cell_names {U_PTECO_HOLD_BUF2371}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1894/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2372} -new_cell_names {U_PTECO_HOLD_BUF2372}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1890/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2373} -new_cell_names {U_PTECO_HOLD_BUF2373}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1897/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2374} -new_cell_names {U_PTECO_HOLD_BUF2374}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1895/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2375} -new_cell_names {U_PTECO_HOLD_BUF2375}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1898/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2376} -new_cell_names {U_PTECO_HOLD_BUF2376}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1896/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2377} -new_cell_names {U_PTECO_HOLD_BUF2377}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1901/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2378} -new_cell_names {U_PTECO_HOLD_BUF2378}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1900/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2379} -new_cell_names {U_PTECO_HOLD_BUF2379}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1899/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2380} -new_cell_names {U_PTECO_HOLD_BUF2380}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1904/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2381} -new_cell_names {U_PTECO_HOLD_BUF2381}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1903/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2382} -new_cell_names {U_PTECO_HOLD_BUF2382}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1906/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2383} -new_cell_names {U_PTECO_HOLD_BUF2383}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1907/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2384} -new_cell_names {U_PTECO_HOLD_BUF2384}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1908/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2385} -new_cell_names {U_PTECO_HOLD_BUF2385}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1905/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2386} -new_cell_names {U_PTECO_HOLD_BUF2386}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1912/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2387} -new_cell_names {U_PTECO_HOLD_BUF2387}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1909/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2388} -new_cell_names {U_PTECO_HOLD_BUF2388}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1910/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2389} -new_cell_names {U_PTECO_HOLD_BUF2389}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1911/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2390} -new_cell_names {U_PTECO_HOLD_BUF2390}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1914/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2391} -new_cell_names {U_PTECO_HOLD_BUF2391}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1915/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2392} -new_cell_names {U_PTECO_HOLD_BUF2392}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1913/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2393} -new_cell_names {U_PTECO_HOLD_BUF2393}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1916/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2394} -new_cell_names {U_PTECO_HOLD_BUF2394}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1918/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2395} -new_cell_names {U_PTECO_HOLD_BUF2395}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1919/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2396} -new_cell_names {U_PTECO_HOLD_BUF2396}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1917/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2397} -new_cell_names {U_PTECO_HOLD_BUF2397}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1920/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2398} -new_cell_names {U_PTECO_HOLD_BUF2398}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1921/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2399} -new_cell_names {U_PTECO_HOLD_BUF2399}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1981/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2400} -new_cell_names {U_PTECO_HOLD_BUF2400}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1922/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2401} -new_cell_names {U_PTECO_HOLD_BUF2401}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1923/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2402} -new_cell_names {U_PTECO_HOLD_BUF2402}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1888/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2403} -new_cell_names {U_PTECO_HOLD_BUF2403}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1924/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2404} -new_cell_names {U_PTECO_HOLD_BUF2404}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U594/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2405} -new_cell_names {U_PTECO_HOLD_BUF2405}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1926/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2406} -new_cell_names {U_PTECO_HOLD_BUF2406}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1925/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2407} -new_cell_names {U_PTECO_HOLD_BUF2407}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1928/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2408} -new_cell_names {U_PTECO_HOLD_BUF2408}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1927/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2409} -new_cell_names {U_PTECO_HOLD_BUF2409}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1929/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2410} -new_cell_names {U_PTECO_HOLD_BUF2410}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1932/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2411} -new_cell_names {U_PTECO_HOLD_BUF2411}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1930/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2412} -new_cell_names {U_PTECO_HOLD_BUF2412}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1931/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2413} -new_cell_names {U_PTECO_HOLD_BUF2413}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1933/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2414} -new_cell_names {U_PTECO_HOLD_BUF2414}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1936/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2415} -new_cell_names {U_PTECO_HOLD_BUF2415}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1935/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2416} -new_cell_names {U_PTECO_HOLD_BUF2416}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1934/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2417} -new_cell_names {U_PTECO_HOLD_BUF2417}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1938/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2418} -new_cell_names {U_PTECO_HOLD_BUF2418}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1939/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2419} -new_cell_names {U_PTECO_HOLD_BUF2419}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1937/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2420} -new_cell_names {U_PTECO_HOLD_BUF2420}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1940/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2421} -new_cell_names {U_PTECO_HOLD_BUF2421}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1941/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2422} -new_cell_names {U_PTECO_HOLD_BUF2422}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1943/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2423} -new_cell_names {U_PTECO_HOLD_BUF2423}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1942/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2424} -new_cell_names {U_PTECO_HOLD_BUF2424}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1945/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2425} -new_cell_names {U_PTECO_HOLD_BUF2425}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1944/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2426} -new_cell_names {U_PTECO_HOLD_BUF2426}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1946/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2427} -new_cell_names {U_PTECO_HOLD_BUF2427}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1947/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2428} -new_cell_names {U_PTECO_HOLD_BUF2428}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1948/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2429} -new_cell_names {U_PTECO_HOLD_BUF2429}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1950/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2430} -new_cell_names {U_PTECO_HOLD_BUF2430}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1949/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2431} -new_cell_names {U_PTECO_HOLD_BUF2431}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1951/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2432} -new_cell_names {U_PTECO_HOLD_BUF2432}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1952/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2433} -new_cell_names {U_PTECO_HOLD_BUF2433}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1953/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2434} -new_cell_names {U_PTECO_HOLD_BUF2434}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1954/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2435} -new_cell_names {U_PTECO_HOLD_BUF2435}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1955/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2436} -new_cell_names {U_PTECO_HOLD_BUF2436}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1956/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2437} -new_cell_names {U_PTECO_HOLD_BUF2437}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1957/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2438} -new_cell_names {U_PTECO_HOLD_BUF2438}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1960/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2439} -new_cell_names {U_PTECO_HOLD_BUF2439}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1961/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2440} -new_cell_names {U_PTECO_HOLD_BUF2440}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_14_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1959/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2441} -new_cell_names {U_PTECO_HOLD_BUF2441}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF147/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2442} -new_cell_names {U_PTECO_HOLD_BUF2442}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_15_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1962/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2443} -new_cell_names {U_PTECO_HOLD_BUF2443}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_17_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1963/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2444} -new_cell_names {U_PTECO_HOLD_BUF2444}
current_instance
current_instance {u_top_dig/u_imeas/u_acSTATP_sync_pclk}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1230/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2445} -new_cell_names {U_PTECO_HOLD_BUF2445}
current_instance
current_instance {u_top_dig/u_imeas/u_acSTATN_sync_pclk}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1231/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2446} -new_cell_names {U_PTECO_HOLD_BUF2446}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1958/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2447} -new_cell_names {U_PTECO_HOLD_BUF2447}
insert_buffer [get_pins {U_PTECO_HOLD_BUF20/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2448} -new_cell_names {U_PTECO_HOLD_BUF2448}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U592/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2449} -new_cell_names {U_PTECO_HOLD_BUF2449}
insert_buffer [get_pins {U_PTECO_HOLD_BUF85/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2450} -new_cell_names {U_PTECO_HOLD_BUF2450}
current_instance
current_instance {top_dig_always_on_inst/pinmux_always_on_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1982/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2451} -new_cell_names {U_PTECO_HOLD_BUF2451}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1983/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2452} -new_cell_names {U_PTECO_HOLD_BUF2452}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1984/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2453} -new_cell_names {U_PTECO_HOLD_BUF2453}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1986/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2454} -new_cell_names {U_PTECO_HOLD_BUF2454}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1987/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2455} -new_cell_names {U_PTECO_HOLD_BUF2455}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1985/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2456} -new_cell_names {U_PTECO_HOLD_BUF2456}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1988/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2457} -new_cell_names {U_PTECO_HOLD_BUF2457}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1989/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2458} -new_cell_names {U_PTECO_HOLD_BUF2458}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1990/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2459} -new_cell_names {U_PTECO_HOLD_BUF2459}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1312/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2460} -new_cell_names {U_PTECO_HOLD_BUF2460}
insert_buffer [get_pins {trim_regs_reg_9__4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2461} -new_cell_names {U_PTECO_HOLD_BUF2461}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1310/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2462} -new_cell_names {U_PTECO_HOLD_BUF2462}
insert_buffer [get_pins {trim_regs_reg_17__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2463} -new_cell_names {U_PTECO_HOLD_BUF2463}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1316/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2464} -new_cell_names {U_PTECO_HOLD_BUF2464}
insert_buffer [get_pins {trim_regs_reg_5__7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2465} -new_cell_names {U_PTECO_HOLD_BUF2465}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1318/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2466} -new_cell_names {U_PTECO_HOLD_BUF2466}
insert_buffer [get_pins {trim_regs_reg_5__5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2467} -new_cell_names {U_PTECO_HOLD_BUF2467}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1325/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2468} -new_cell_names {U_PTECO_HOLD_BUF2468}
insert_buffer [get_pins {trim_regs_reg_5__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2469} -new_cell_names {U_PTECO_HOLD_BUF2469}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1324/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2470} -new_cell_names {U_PTECO_HOLD_BUF2470}
insert_buffer [get_pins {rnd_regs_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2471} -new_cell_names {U_PTECO_HOLD_BUF2471}
current_instance
current_instance {u_top_dig/u_imeas/u_filter}
insert_buffer [get_pins {DFT_14/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2472} -new_cell_names {U_PTECO_HOLD_BUF2472}
insert_buffer [get_pins {DFT_18/B0}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2473} -new_cell_names {U_PTECO_HOLD_BUF2473}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1327/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2474} -new_cell_names {U_PTECO_HOLD_BUF2474}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1326/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2475} -new_cell_names {U_PTECO_HOLD_BUF2475}
insert_buffer [get_pins {reg_confen_reg_6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2476} -new_cell_names {U_PTECO_HOLD_BUF2476}
insert_buffer [get_pins {reg_confen_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2477} -new_cell_names {U_PTECO_HOLD_BUF2477}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1335/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2478} -new_cell_names {U_PTECO_HOLD_BUF2478}
insert_buffer [get_pins {regs_confen_data_reg_5_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2479} -new_cell_names {U_PTECO_HOLD_BUF2479}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1333/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2480} -new_cell_names {U_PTECO_HOLD_BUF2480}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1334/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2481} -new_cell_names {U_PTECO_HOLD_BUF2481}
insert_buffer [get_pins {trim_regs_reg_10__3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2482} -new_cell_names {U_PTECO_HOLD_BUF2482}
insert_buffer [get_pins {trim_regs_reg_10__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2483} -new_cell_names {U_PTECO_HOLD_BUF2483}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_freq_temp_reg_9_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2484} -new_cell_names {U_PTECO_HOLD_BUF2484}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1332/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2485} -new_cell_names {U_PTECO_HOLD_BUF2485}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_freq_temp_reg_10_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2486} -new_cell_names {U_PTECO_HOLD_BUF2486}
insert_buffer [get_pins {led_freq_temp_reg_8_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2487} -new_cell_names {U_PTECO_HOLD_BUF2487}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1340/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2488} -new_cell_names {U_PTECO_HOLD_BUF2488}
insert_buffer [get_pins {trim_regs_reg_44__6_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2489} -new_cell_names {U_PTECO_HOLD_BUF2489}
insert_buffer [get_pins {trim_regs_reg_19__3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2490} -new_cell_names {U_PTECO_HOLD_BUF2490}
insert_buffer [get_pins {trim_regs_reg_7__1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2491} -new_cell_names {U_PTECO_HOLD_BUF2491}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1319/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2492} -new_cell_names {U_PTECO_HOLD_BUF2492}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1339/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2493} -new_cell_names {U_PTECO_HOLD_BUF2493}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1336/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2494} -new_cell_names {U_PTECO_HOLD_BUF2494}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1320/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2495} -new_cell_names {U_PTECO_HOLD_BUF2495}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_LEDDAC_SEL_sync}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2085/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2496} -new_cell_names {U_PTECO_HOLD_BUF2496}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2497} -new_cell_names {U_PTECO_HOLD_BUF2497}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_3_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2089/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2498} -new_cell_names {U_PTECO_HOLD_BUF2498}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1341/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2499} -new_cell_names {U_PTECO_HOLD_BUF2499}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_TIA_GAIN_sync_3_}
insert_buffer [get_pins {async_in_d1_reg/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2500} -new_cell_names {U_PTECO_HOLD_BUF2500}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1337/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2501} -new_cell_names {U_PTECO_HOLD_BUF2501}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2044/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2502} -new_cell_names {U_PTECO_HOLD_BUF2502}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1371/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2503} -new_cell_names {U_PTECO_HOLD_BUF2503}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch2data_en_reg_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2504} -new_cell_names {U_PTECO_HOLD_BUF2504}
insert_buffer [get_pins {rst_cnt_reg_7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2505} -new_cell_names {U_PTECO_HOLD_BUF2505}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {nvr2_trim_tag_lock_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2506} -new_cell_names {U_PTECO_HOLD_BUF2506}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_0_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1353/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2507} -new_cell_names {U_PTECO_HOLD_BUF2507}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch0data_reg_reg_1_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2508} -new_cell_names {U_PTECO_HOLD_BUF2508}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_VSEL_sync_1_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1357/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2509} -new_cell_names {U_PTECO_HOLD_BUF2509}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_spi_to_ppg_PPG_DAC1_EN_sync}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1368/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2510} -new_cell_names {U_PTECO_HOLD_BUF2510}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {fsm_counter_reg_3_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2511} -new_cell_names {U_PTECO_HOLD_BUF2511}
insert_buffer [get_pins {fsm_counter_reg_2_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2512} -new_cell_names {U_PTECO_HOLD_BUF2512}
insert_buffer [get_pins {fsm_counter_reg_4_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2513} -new_cell_names {U_PTECO_HOLD_BUF2513}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {empty_sts_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2514} -new_cell_names {U_PTECO_HOLD_BUF2514}
insert_buffer [get_pins {a_full_local_reg/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2515} -new_cell_names {U_PTECO_HOLD_BUF2515}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_101__5_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2516} -new_cell_names {U_PTECO_HOLD_BUF2516}
insert_buffer [get_pins {mem_reg_101__10_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2517} -new_cell_names {U_PTECO_HOLD_BUF2517}
current_instance
current_instance {u_top_dig/fifo_top/fifo_cntl_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1404/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2518} -new_cell_names {U_PTECO_HOLD_BUF2518}
current_instance
current_instance {u_top_dig/fifo_top/fifo_mem_inst}
insert_buffer [get_pins {mem_reg_95__12_/SI}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2519} -new_cell_names {U_PTECO_HOLD_BUF2519}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1378/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2520} -new_cell_names {U_PTECO_HOLD_BUF2520}
current_instance
current_instance {top_dig_always_on_inst/pinmux_always_on_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2324/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2521} -new_cell_names {U_PTECO_HOLD_BUF2521}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2326/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2522} -new_cell_names {U_PTECO_HOLD_BUF2522}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2327/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2523} -new_cell_names {U_PTECO_HOLD_BUF2523}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2328/Y}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2524} -new_cell_names {U_PTECO_HOLD_BUF2524}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1851/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2525} -new_cell_names {U_PTECO_HOLD_BUF2525}
insert_buffer [get_pins {U592/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2526} -new_cell_names {U_PTECO_HOLD_BUF2526}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2412/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2527} -new_cell_names {U_PTECO_HOLD_BUF2527}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2329/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2528} -new_cell_names {U_PTECO_HOLD_BUF2528}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2414/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2529} -new_cell_names {U_PTECO_HOLD_BUF2529}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2351/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2530} -new_cell_names {U_PTECO_HOLD_BUF2530}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2417/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2531} -new_cell_names {U_PTECO_HOLD_BUF2531}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2330/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2532} -new_cell_names {U_PTECO_HOLD_BUF2532}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2420/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2533} -new_cell_names {U_PTECO_HOLD_BUF2533}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2421/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2534} -new_cell_names {U_PTECO_HOLD_BUF2534}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2424/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2535} -new_cell_names {U_PTECO_HOLD_BUF2535}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2331/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2536} -new_cell_names {U_PTECO_HOLD_BUF2536}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2332/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2537} -new_cell_names {U_PTECO_HOLD_BUF2537}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2334/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2538} -new_cell_names {U_PTECO_HOLD_BUF2538}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2335/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2539} -new_cell_names {U_PTECO_HOLD_BUF2539}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2426/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2540} -new_cell_names {U_PTECO_HOLD_BUF2540}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2428/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2541} -new_cell_names {U_PTECO_HOLD_BUF2541}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1106/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2542} -new_cell_names {U_PTECO_HOLD_BUF2542}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2337/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2543} -new_cell_names {U_PTECO_HOLD_BUF2543}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2431/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2544} -new_cell_names {U_PTECO_HOLD_BUF2544}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2339/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2545} -new_cell_names {U_PTECO_HOLD_BUF2545}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2336/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2546} -new_cell_names {U_PTECO_HOLD_BUF2546}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2333/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2547} -new_cell_names {U_PTECO_HOLD_BUF2547}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2432/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2548} -new_cell_names {U_PTECO_HOLD_BUF2548}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2433/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2549} -new_cell_names {U_PTECO_HOLD_BUF2549}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2367/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2550} -new_cell_names {U_PTECO_HOLD_BUF2550}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2358/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2551} -new_cell_names {U_PTECO_HOLD_BUF2551}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2345/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2552} -new_cell_names {U_PTECO_HOLD_BUF2552}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2389/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2553} -new_cell_names {U_PTECO_HOLD_BUF2553}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2379/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2554} -new_cell_names {U_PTECO_HOLD_BUF2554}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2435/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2555} -new_cell_names {U_PTECO_HOLD_BUF2555}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2383/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2556} -new_cell_names {U_PTECO_HOLD_BUF2556}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2437/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2557} -new_cell_names {U_PTECO_HOLD_BUF2557}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2373/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2558} -new_cell_names {U_PTECO_HOLD_BUF2558}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2439/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2559} -new_cell_names {U_PTECO_HOLD_BUF2559}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2440/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2560} -new_cell_names {U_PTECO_HOLD_BUF2560}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2353/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2561} -new_cell_names {U_PTECO_HOLD_BUF2561}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2376/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2562} -new_cell_names {U_PTECO_HOLD_BUF2562}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2442/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2563} -new_cell_names {U_PTECO_HOLD_BUF2563}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2355/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2564} -new_cell_names {U_PTECO_HOLD_BUF2564}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2366/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2565} -new_cell_names {U_PTECO_HOLD_BUF2565}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2356/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2566} -new_cell_names {U_PTECO_HOLD_BUF2566}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2344/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2567} -new_cell_names {U_PTECO_HOLD_BUF2567}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2378/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2568} -new_cell_names {U_PTECO_HOLD_BUF2568}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2350/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2569} -new_cell_names {U_PTECO_HOLD_BUF2569}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2405/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2570} -new_cell_names {U_PTECO_HOLD_BUF2570}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2369/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2571} -new_cell_names {U_PTECO_HOLD_BUF2571}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2359/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2572} -new_cell_names {U_PTECO_HOLD_BUF2572}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2346/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2573} -new_cell_names {U_PTECO_HOLD_BUF2573}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2352/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2574} -new_cell_names {U_PTECO_HOLD_BUF2574}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U593/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2575} -new_cell_names {U_PTECO_HOLD_BUF2575}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2393/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2576} -new_cell_names {U_PTECO_HOLD_BUF2576}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2386/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2577} -new_cell_names {U_PTECO_HOLD_BUF2577}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2362/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2578} -new_cell_names {U_PTECO_HOLD_BUF2578}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2377/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2579} -new_cell_names {U_PTECO_HOLD_BUF2579}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2397/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2580} -new_cell_names {U_PTECO_HOLD_BUF2580}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2388/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2581} -new_cell_names {U_PTECO_HOLD_BUF2581}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2380/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2582} -new_cell_names {U_PTECO_HOLD_BUF2582}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2365/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2583} -new_cell_names {U_PTECO_HOLD_BUF2583}
current_instance
current_instance {u_top_dig/u_imeas/u_acSTATN_sync_pclk}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2446/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2584} -new_cell_names {U_PTECO_HOLD_BUF2584}
current_instance
current_instance {u_top_dig/u_imeas/u_acSTATP_sync_pclk}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2445/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2585} -new_cell_names {U_PTECO_HOLD_BUF2585}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U591/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2586} -new_cell_names {U_PTECO_HOLD_BUF2586}
insert_buffer [get_pins {U_PTECO_HOLD_BUF88/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2587} -new_cell_names {U_PTECO_HOLD_BUF2587}
current_instance
current_instance {top_dig_always_on_inst/pinmux_always_on_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2454/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2588} -new_cell_names {U_PTECO_HOLD_BUF2588}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2455/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2589} -new_cell_names {U_PTECO_HOLD_BUF2589}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2457/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2590} -new_cell_names {U_PTECO_HOLD_BUF2590}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2459/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2591} -new_cell_names {U_PTECO_HOLD_BUF2591}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_ctrl}
insert_buffer [get_pins {ch1data_reg_reg_7_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2592} -new_cell_names {U_PTECO_HOLD_BUF2592}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_14_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1959/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2593} -new_cell_names {U_PTECO_HOLD_BUF2593}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_15_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1962/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2594} -new_cell_names {U_PTECO_HOLD_BUF2594}
current_instance
current_instance {u_top_dig/spi_top_u/u_rd_fifo_data_sync_17_}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1963/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2595} -new_cell_names {U_PTECO_HOLD_BUF2595}
current_instance
current_instance {u_top_dig/u_ppg_controller/u_ppg_fsm}
insert_buffer [get_pins {led_freq_temp_reg_10_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2596} -new_cell_names {U_PTECO_HOLD_BUF2596}
insert_buffer [get_pins {led_freq_temp_reg_8_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2597} -new_cell_names {U_PTECO_HOLD_BUF2597}
insert_buffer [get_pins {led_freq_temp_reg_9_/SI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2598} -new_cell_names {U_PTECO_HOLD_BUF2598}
current_instance
current_instance {u_top_dig/flash_ctrl_top_inst/u_flash_regs}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2460/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2599} -new_cell_names {U_PTECO_HOLD_BUF2599}
current_instance
current_instance {top_dig_always_on_inst/pinmux_always_on_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2451/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2600} -new_cell_names {U_PTECO_HOLD_BUF2600}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2452/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2601} -new_cell_names {U_PTECO_HOLD_BUF2601}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2453/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2602} -new_cell_names {U_PTECO_HOLD_BUF2602}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2456/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2603} -new_cell_names {U_PTECO_HOLD_BUF2603}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2458/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2604} -new_cell_names {U_PTECO_HOLD_BUF2604}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2521/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2605} -new_cell_names {U_PTECO_HOLD_BUF2605}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2522/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2606} -new_cell_names {U_PTECO_HOLD_BUF2606}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2523/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2607} -new_cell_names {U_PTECO_HOLD_BUF2607}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2524/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2608} -new_cell_names {U_PTECO_HOLD_BUF2608}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2525/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2609} -new_cell_names {U_PTECO_HOLD_BUF2609}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2528/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2610} -new_cell_names {U_PTECO_HOLD_BUF2610}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2532/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2611} -new_cell_names {U_PTECO_HOLD_BUF2611}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2536/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2612} -new_cell_names {U_PTECO_HOLD_BUF2612}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2537/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2613} -new_cell_names {U_PTECO_HOLD_BUF2613}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2538/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2614} -new_cell_names {U_PTECO_HOLD_BUF2614}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2539/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2615} -new_cell_names {U_PTECO_HOLD_BUF2615}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2542/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2616} -new_cell_names {U_PTECO_HOLD_BUF2616}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2545/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2617} -new_cell_names {U_PTECO_HOLD_BUF2617}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2543/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2618} -new_cell_names {U_PTECO_HOLD_BUF2618}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2546/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2619} -new_cell_names {U_PTECO_HOLD_BUF2619}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2547/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2620} -new_cell_names {U_PTECO_HOLD_BUF2620}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2553/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2621} -new_cell_names {U_PTECO_HOLD_BUF2621}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2548/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2622} -new_cell_names {U_PTECO_HOLD_BUF2622}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2549/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2623} -new_cell_names {U_PTECO_HOLD_BUF2623}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2559/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2624} -new_cell_names {U_PTECO_HOLD_BUF2624}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2560/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2625} -new_cell_names {U_PTECO_HOLD_BUF2625}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2563/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2626} -new_cell_names {U_PTECO_HOLD_BUF2626}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1933/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2627} -new_cell_names {U_PTECO_HOLD_BUF2627}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2570/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2628} -new_cell_names {U_PTECO_HOLD_BUF2628}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1942/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2629} -new_cell_names {U_PTECO_HOLD_BUF2629}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1937/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2630} -new_cell_names {U_PTECO_HOLD_BUF2630}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1940/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2631} -new_cell_names {U_PTECO_HOLD_BUF2631}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1956/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2632} -new_cell_names {U_PTECO_HOLD_BUF2632}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1934/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2633} -new_cell_names {U_PTECO_HOLD_BUF2633}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1944/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2634} -new_cell_names {U_PTECO_HOLD_BUF2634}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1949/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2635} -new_cell_names {U_PTECO_HOLD_BUF2635}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1954/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2636} -new_cell_names {U_PTECO_HOLD_BUF2636}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1947/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2637} -new_cell_names {U_PTECO_HOLD_BUF2637}
insert_buffer [get_pins {U591/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2638} -new_cell_names {U_PTECO_HOLD_BUF2638}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2575/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2639} -new_cell_names {U_PTECO_HOLD_BUF2639}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2526/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2640} -new_cell_names {U_PTECO_HOLD_BUF2640}
insert_buffer [get_pins {U590/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2641} -new_cell_names {U_PTECO_HOLD_BUF2641}
insert_buffer [get_pins {U594/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2642} -new_cell_names {U_PTECO_HOLD_BUF2642}
current_instance
current_instance {top_dig_always_on_inst/pinmux_always_on_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2591/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2643} -new_cell_names {U_PTECO_HOLD_BUF2643}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2600/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2644} -new_cell_names {U_PTECO_HOLD_BUF2644}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2602/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2645} -new_cell_names {U_PTECO_HOLD_BUF2645}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2601/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2646} -new_cell_names {U_PTECO_HOLD_BUF2646}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2603/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2647} -new_cell_names {U_PTECO_HOLD_BUF2647}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2588/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2648} -new_cell_names {U_PTECO_HOLD_BUF2648}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2589/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2649} -new_cell_names {U_PTECO_HOLD_BUF2649}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2590/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2650} -new_cell_names {U_PTECO_HOLD_BUF2650}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2604/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2651} -new_cell_names {U_PTECO_HOLD_BUF2651}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2606/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2652} -new_cell_names {U_PTECO_HOLD_BUF2652}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2607/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2653} -new_cell_names {U_PTECO_HOLD_BUF2653}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2608/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2654} -new_cell_names {U_PTECO_HOLD_BUF2654}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2609/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2655} -new_cell_names {U_PTECO_HOLD_BUF2655}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2610/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2656} -new_cell_names {U_PTECO_HOLD_BUF2656}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2611/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2657} -new_cell_names {U_PTECO_HOLD_BUF2657}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2612/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2658} -new_cell_names {U_PTECO_HOLD_BUF2658}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2613/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2659} -new_cell_names {U_PTECO_HOLD_BUF2659}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2614/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2660} -new_cell_names {U_PTECO_HOLD_BUF2660}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2615/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2661} -new_cell_names {U_PTECO_HOLD_BUF2661}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1902/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2662} -new_cell_names {U_PTECO_HOLD_BUF2662}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1103/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2663} -new_cell_names {U_PTECO_HOLD_BUF2663}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1100/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2664} -new_cell_names {U_PTECO_HOLD_BUF2664}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1097/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2665} -new_cell_names {U_PTECO_HOLD_BUF2665}
insert_buffer [get_pins {U_PTECO_HOLD_BUF1214/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2668} -new_cell_names {U_PTECO_HOLD_BUF2668}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2640/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2669} -new_cell_names {U_PTECO_HOLD_BUF2669}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2639/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2670} -new_cell_names {U_PTECO_HOLD_BUF2670}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2405/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2671} -new_cell_names {U_PTECO_HOLD_BUF2671}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2638/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2672} -new_cell_names {U_PTECO_HOLD_BUF2672}
insert_buffer [get_pins {U590/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2673} -new_cell_names {U_PTECO_HOLD_BUF2673}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2630/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2674} -new_cell_names {U_PTECO_HOLD_BUF2674}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2631/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2675} -new_cell_names {U_PTECO_HOLD_BUF2675}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2629/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2676} -new_cell_names {U_PTECO_HOLD_BUF2676}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2633/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2677} -new_cell_names {U_PTECO_HOLD_BUF2677}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2637/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2678} -new_cell_names {U_PTECO_HOLD_BUF2678}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2635/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2679} -new_cell_names {U_PTECO_HOLD_BUF2679}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2632/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2680} -new_cell_names {U_PTECO_HOLD_BUF2680}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2634/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2681} -new_cell_names {U_PTECO_HOLD_BUF2681}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2636/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2682} -new_cell_names {U_PTECO_HOLD_BUF2682}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2432/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2683} -new_cell_names {U_PTECO_HOLD_BUF2683}
insert_buffer [get_pins {U589/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2684} -new_cell_names {U_PTECO_HOLD_BUF2684}
current_instance
current_instance {top_dig_always_on_inst/pinmux_always_on_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2645/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2685} -new_cell_names {U_PTECO_HOLD_BUF2685}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2646/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2686} -new_cell_names {U_PTECO_HOLD_BUF2686}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2648/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2687} -new_cell_names {U_PTECO_HOLD_BUF2687}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2649/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2688} -new_cell_names {U_PTECO_HOLD_BUF2688}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2650/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2689} -new_cell_names {U_PTECO_HOLD_BUF2689}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2643/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2690} -new_cell_names {U_PTECO_HOLD_BUF2690}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2652/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2691} -new_cell_names {U_PTECO_HOLD_BUF2691}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2653/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2692} -new_cell_names {U_PTECO_HOLD_BUF2692}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2654/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2693} -new_cell_names {U_PTECO_HOLD_BUF2693}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2656/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2694} -new_cell_names {U_PTECO_HOLD_BUF2694}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2657/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2695} -new_cell_names {U_PTECO_HOLD_BUF2695}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2658/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2696} -new_cell_names {U_PTECO_HOLD_BUF2696}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2659/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2697} -new_cell_names {U_PTECO_HOLD_BUF2697}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2660/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2698} -new_cell_names {U_PTECO_HOLD_BUF2698}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2661/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2699} -new_cell_names {U_PTECO_HOLD_BUF2699}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2662/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2700} -new_cell_names {U_PTECO_HOLD_BUF2700}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2655/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2701} -new_cell_names {U_PTECO_HOLD_BUF2701}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2663/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2702} -new_cell_names {U_PTECO_HOLD_BUF2702}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2664/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2703} -new_cell_names {U_PTECO_HOLD_BUF2703}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2665/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2704} -new_cell_names {U_PTECO_HOLD_BUF2704}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2668/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2707} -new_cell_names {U_PTECO_HOLD_BUF2707}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2549/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2708} -new_cell_names {U_PTECO_HOLD_BUF2708}
insert_buffer [get_pins {U596/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2709} -new_cell_names {U_PTECO_HOLD_BUF2709}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U596/CI}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2710} -new_cell_names {U_PTECO_HOLD_BUF2710}
current_instance
current_instance {top_dig_always_on_inst/pinmux_always_on_inst}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2687/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2711} -new_cell_names {U_PTECO_HOLD_BUF2711}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2689/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2712} -new_cell_names {U_PTECO_HOLD_BUF2712}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2690/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2713} -new_cell_names {U_PTECO_HOLD_BUF2713}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2328/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2714} -new_cell_names {U_PTECO_HOLD_BUF2714}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2691/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2715} -new_cell_names {U_PTECO_HOLD_BUF2715}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2692/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2716} -new_cell_names {U_PTECO_HOLD_BUF2716}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2559/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2717} -new_cell_names {U_PTECO_HOLD_BUF2717}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2560/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2718} -new_cell_names {U_PTECO_HOLD_BUF2718}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2700/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2719} -new_cell_names {U_PTECO_HOLD_BUF2719}
insert_buffer [get_pins {U576/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2720} -new_cell_names {U_PTECO_HOLD_BUF2720}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U576/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2721} -new_cell_names {U_PTECO_HOLD_BUF2721}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U595/B}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2722} -new_cell_names {U_PTECO_HOLD_BUF2722}
insert_buffer [get_pins {integ1_reg_7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2723} -new_cell_names {U_PTECO_HOLD_BUF2723}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2702/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2724} -new_cell_names {U_PTECO_HOLD_BUF2724}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2704/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2725} -new_cell_names {U_PTECO_HOLD_BUF2725}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2703/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2726} -new_cell_names {U_PTECO_HOLD_BUF2726}
insert_buffer [get_pins {U444/B}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2727} -new_cell_names {U_PTECO_HOLD_BUF2727}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U444/B}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2728} -new_cell_names {U_PTECO_HOLD_BUF2728}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2707/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2729} -new_cell_names {U_PTECO_HOLD_BUF2729}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2714/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2730} -new_cell_names {U_PTECO_HOLD_BUF2730}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2717/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2731} -new_cell_names {U_PTECO_HOLD_BUF2731}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2718/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2732} -new_cell_names {U_PTECO_HOLD_BUF2732}
insert_buffer [get_pins {U579/B}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2733} -new_cell_names {U_PTECO_HOLD_BUF2733}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {integ1_reg_7_/D}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2734} -new_cell_names {U_PTECO_HOLD_BUF2734}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2720/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2735} -new_cell_names {U_PTECO_HOLD_BUF2735}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2721/A}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2736} -new_cell_names {U_PTECO_HOLD_BUF2736}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2730/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2737} -new_cell_names {U_PTECO_HOLD_BUF2737}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2732/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2738} -new_cell_names {U_PTECO_HOLD_BUF2738}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2731/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2739} -new_cell_names {U_PTECO_HOLD_BUF2739}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U579/B}] BUFX4M -new_net_names {net_PTECO_HOLD_NET2740} -new_cell_names {U_PTECO_HOLD_BUF2740}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_0}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2737/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2741} -new_cell_names {U_PTECO_HOLD_BUF2741}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_2}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2738/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2742} -new_cell_names {U_PTECO_HOLD_BUF2742}
current_instance
current_instance {u_top_dig/u_imeas/u_imeas_cic_1}
insert_buffer [get_pins {U_PTECO_HOLD_BUF2739/A}] DLY4X4M -new_net_names {net_PTECO_HOLD_NET2743} -new_cell_names {U_PTECO_HOLD_BUF2743}
current_instance
