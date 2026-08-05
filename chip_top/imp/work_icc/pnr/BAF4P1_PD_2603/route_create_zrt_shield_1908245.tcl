set SNPS_ROUTE_AS_CHILD_START_TIME [clock seconds]
set phys_hier_attr_mode DC_ATTR
suppress_message {MV-510 PSYN-024 PSYN-039 PSYN-040 PSYN-058 PSYN-087 PSYN-088 PSYN-850 PWR-18 RCEX-060 TFCHK-049 TFCHK-050 TFCHK-055 ZRT-026 ZRT-027 ZRT-030 }
set_message_info -id ZRT-312 -limit 0
set_message_info -id ZRT-311 -limit 0
set_message_info -id TIM-111 -limit 0
set_message_info -id UCN-32 -limit 0
set_message_info -id PSYN-058 -limit 0
set_message_info -id TIM-113 -limit 0
set_message_info -id FPHSM-1797 -limit 0
set_message_info -id GUI-026 -limit 0
set_message_info -id TIM-112 -limit 0
set_message_info -id RCEX-202 -limit 0
set_message_info -id RCEX-013 -limit 0
set_message_info -id UID-95 -limit 0
set_message_info -id HDUEDIT-104 -limit 0
set_message_info -id MWUI-031 -limit 0
set_message_info -id RCEX-011 -limit 0
set_message_info -id MWDC-287 -limit 0
set_message_info -id UPF-213 -limit 0
set_message_info -id RCEX-015 -limit 0
set_message_info -id MWDC-284 -limit 0
set_message_info -id PSYN-024 -limit 0
set_message_info -id OPT-1022 -limit 0
set_message_info -id TIM-128 -limit 0
set_message_info -id CMD-025 -limit 0
set_message_info -id TIM-164 -limit 0
set_message_info -id LIBSETUP-751 -limit 0
set_message_info -id ZRT-325 -limit 0
set_message_info -id LIBSETUP-754 -limit 0
set_message_info -id UID-1024 -limit 0
set_message_info -id ZRT-444 -limit 0
set_message_info -id IFS-007 -limit 0
set_message_info -id MWUI-225 -limit 0
set_message_info -id SDC-2 -limit 0
set_message_info -id MWUI-003 -limit 0
set_message_info -id RCEX-023 -limit 0
set_message_info -id UID-85 -limit 0
set_message_info -id SI-140 -limit 0
set_message_info -id MWDC-290 -limit 0
set_message_info -id OPT-314 -limit 0
set_message_info -id UID-478 -limit 0
set_message_info -id PSYN-105 -limit 0
set_message_info -id UID-83 -limit 0
set_message_info -id UPF-213d -limit 0
set_message_info -id SEL-004 -limit 0
set_message_info -id UPF-213e -limit 0
set_message_info -id MWDC-217 -limit 0
set_message_info -id UPF-213f -limit 0
set_message_info -id UID-477 -limit 0
set_message_info -id RT-104 -limit 0
set_message_info -id UPF-213a -limit 0
set_message_info -id PSYN-878 -limit 0
set_message_info -id UPF-213b -limit 0
set_message_info -id CMD-036 -limit 0
set_message_info -id UPF-213c -limit 0
set_message_info -id MWLIBP-301 -limit 0
set_message_info -id PSYN-379 -limit 0
set_message_info -id MWLIBP-300 -limit 0
set_message_info -id PWR-536 -limit 0
set_message_info -id TM-002 -limit 0
set_message_info -id ZRT-103 -limit 0
set_message_info -id PSYN-039 -limit 0
set_message_info -id FPHSM-1606 -limit 0
set_message_info -id RCEX-141 -limit 0
set_message_info -id MV-597 -limit 0
set_message_info -id UPF-710 -limit 1
set_message_info -id PSYN-503 -limit 0
set_message_info -id PSYN-086 -limit 0
set_message_info -id CMD-005 -limit 0
set_message_info -id PSYN-040 -limit 0
set_message_info -id UID-1008 -limit 0
set_message_info -id ZRT-305 -limit 0
set_message_info -id CTS-1091 -limit 0
set_message_info -id UID-1006 -limit 0
set_message_info -id UI-74 -limit 0
set_message_info -id ZRT-023 -limit 0
set_message_info -id TIM-182 -limit 0
set_message_info -id ZRT-021 -limit 0
set_message_info -id PWR-824 -limit 0
set_message_info -id ZRT-026 -limit 0
set_message_info -id PSYN-088 -limit 0
set_message_info -id RCEX-043 -limit 0
set_message_info -id RCEX-081 -limit 0
set_message_info -id RCEX-041 -limit 0
set_message_info -id RT-066 -limit 0
set_message_info -id RCEX-040 -limit 0
set_message_info -id OPT-150 -limit 0
set_message_info -id RCEX-047 -limit 0
set_message_info -id OPT-997 -limit 0
set_message_info -id RT-064 -limit 0
set_message_info -id RCEX-007 -limit 0
set_message_info -id UID-348 -limit 0
set_message_info -id OPT-996 -limit 0
set_message_info -id RT-065 -limit 0
set_message_info -id UID-349 -limit 0
set_message_info -id TIM-270 -limit 0
set_message_info -id RCEX-008 -limit 0
set_message_info -id MWUI-068 -limit 0
set_message_info -id MWLIBP-324 -limit 0
set_message_info -id PWR-24 -limit 0
set_message_info -id UID-376 -limit 0
set search_path "/projects/libs/baf4p1/digital_work/GY_BAF4P1_DIG/pnr/lib_inputs/DB"
set physical_library ""
set target_library "sc7_l013_base_rvt_ff_TYP_min_1p65v_m40c.db sc7_l013_base_rvt_ss_TYP_max_1p35v_125c.db BAF4P1_ANA_CHIP_bc.db BAF4P1_ANA_CHIP_wc.db PADLRCMCUDB_min.db PADLRCMCUDB_max.db FPFLE032K09DA_min.db FPFLE032K09DA_max.db"
set link_library "sc7_l013_base_rvt_ff_TYP_min_1p65v_m40c.db sc7_l013_base_rvt_ss_TYP_max_1p35v_125c.db BAF4P1_ANA_CHIP_bc.db BAF4P1_ANA_CHIP_wc.db PADLRCMCUDB_min.db PADLRCMCUDB_max.db FPFLE032K09DA_min.db FPFLE032K09DA_max.db"
set mw_reference_library ""
set enable_set_units FALSE 
open_mw_lib /projects/libs/baf4p1/digital_work/GY_BAF4P1_DIG/pnr/BAF4P1_PD_2603/Nanochap_BAF4P1
open_working_copy_mw_cel 06_route -version 1
set_separate_process_options -routing false
set routeopt_xtalk_reduction_tns true
set_route_zrt_common_options -post_detail_route_fix_soft_violations true
set_route_zrt_common_options -read_user_metal_blockage_layer true
set_route_zrt_common_options -threshold_noise_ratio 0.200000
set_route_zrt_detail_options -antenna true
set_route_zrt_detail_options -antenna_on_iteration 15
set_route_zrt_detail_options -diode_libcell_names {{ANTENNAM} }
set neco_file_name /tmp/neco_63FXam
set_host_options  -max_cores 16
create_zrt_shield  -mode new -with_ground {VSS_DIG_SW} -ignore_shielding_net_pins true -nets {  D2A_SDM_CLK }
pass_working_copy_mw_cel_back
set SNPS_ROUTE_AS_CHILD_END_TIME [clock seconds]
set SNPS_CPUTIME [cputime -self -child]
set SNPS_ELAPSED_TIME [expr $SNPS_ROUTE_AS_CHILD_END_TIME - $SNPS_ROUTE_AS_CHILD_START_TIME]
set SNPS_CPUTIME_hr [expr $SNPS_CPUTIME/3600.0]
set SNPS_ELAPSED_TIME_hr [expr $SNPS_ELAPSED_TIME/3600.0]
set SNPS_MEMORY_Mb [expr [mem]/1024]
set SNPS_CPU_MEM_LOG_FORMAT "%-30s CPU: %6d s (%5.2f hr) ELAPSE: %6d s (%5.2f hr) MEM-PEAK: %5lu Mb "
set SNPS_CPU_MEM_LOG_OUT [format $SNPS_CPU_MEM_LOG_FORMAT "CHILD_PROC: Router" $SNPS_CPUTIME $SNPS_CPUTIME_hr $SNPS_ELAPSED_TIME $SNPS_ELAPSED_TIME_hr $SNPS_MEMORY_Mb ]
 set fileId [open proc_end_1908245 w 0600]
puts $fileId "/projects/libs/baf4p1/digital_work/GY_BAF4P1_DIG/pnr/BAF4P1_PD_2603/route_create_zrt_shield_1908245.tcl $SNPS_CPU_MEM_LOG_OUT"
close $fileId
quit
