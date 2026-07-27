#fsdbDumpfile "top_fpga.fsdb"
#fsdbDumpvars 0
#fsdbDumpon
set list_of_reg [search -instances  {soc_top_tb.u_Nanochap_BAF4P1.u_top_dig.rst_ctrl_inst.por_cnt_reg_*}]

foreach k $list_of_reg {
        tcheck $k RECREM -xgen -msg -disable
}

tcheck {soc_top_tb.u_Nanochap_BAF4P1.u_top_dig.u_ppg_controller.u_ppg_enable_sync.async_in_d1_reg} SETUPHOLD -xgen -msg -disable
tcheck {soc_top_tb.u_Nanochap_BAF4P1.u_top_dig.fifo_top.fifo_cntl_inst.u_fifo_flush_n_sync.async_in_d1_reg} SETUPHOLD -xgen -msg -disable

run
