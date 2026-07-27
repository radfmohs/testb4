
#sx_open_sim_file_read /local/scratch/shreeyal/baf4p1/simulation/sim2/rtl_soc_imeas_bio_electricity_filter_test_extended_12421.vpd
#sx_open_sim_file_read /local/scratch/shreeyal/baf4p1/simulation/sim1/rtl_soc_imeas_bio_electricity_filter_test_extended_872.vpd
sx_open_sim_file_read [sx_get_cmd_arg]

set fft_res [sx_wf_fft [sx_d2a [sx_signal *u_notch_filter.filter_in*]] 5000  HAMMING 1 4]
sx_display $fft_res
set scan_obj [ sx_scan_data_points $fft_res RISE 2k ]
set ret [ sx_jump_to_x $scan_obj NEXT ]
while { $ret == 1 } {
  set x_val [ sx_x_value $scan_obj ]
  set y_val [ sx_y_value $scan_obj ]
  set ret [ sx_jump_to_x $scan_obj NEXT ]
  puts "in_freq $x_val"}

sx_release $scan_obj

set fft_res [sx_wf_fft [sx_d2a [sx_signal *u_notch_filter.filter_out*]] 5000  HAMMING 1 4]
sx_display $fft_res
set scan_obj [ sx_scan_data_points $fft_res RISE 2k ]
set ret [ sx_jump_to_x $scan_obj NEXT ]
while { $ret == 1 } {
  set x_val [ sx_x_value $scan_obj ]
  set y_val [ sx_y_value $scan_obj ]
  set ret [ sx_jump_to_x $scan_obj NEXT ]
  puts "out_freq $x_val"}

sx_release $scan_obj

sx_exit
