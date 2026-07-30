/*--------------------------------------------------------------------------------------*/
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
// --------------------------------------------------------------------------------------
// Project      : Nanochap ENS1p4
// File         : tb_chip_top_uvm_lead_off.sv
// Description  : LEAD OFF DETECTOR TB 
// Designer     : Ophina Correya
// Date         : 10-04-2024
// Revision     : 0.1
/*--------------------------------------------------------------------------------------*/
nnc_lead_off_interface     vif();
assign   vif.pclk                =   `IMEAS_TOP.pclk;
assign   vif.presetn             =   `IMEAS_TOP.presetn;
//assign   vif.int_sts_switch      =   `IMEAS_TOP.int_sts_switch;
//assign   vif.int_sts_duration    =   `IMEAS_TOP.int_sts_duration;
assign   vif.int_sts_switch_loff_statn   = `IMEAS_TOP.int_sts_switch_loff_statn;
assign   vif.int_sts_switch_loff_statp   = `IMEAS_TOP.int_sts_switch_loff_statp;
assign   vif.int_sts_switch_acloff_statn = `IMEAS_TOP.int_sts_switch_acloff_statn;
assign   vif.int_sts_switch_acloff_statp = `IMEAS_TOP.int_sts_switch_acloff_statp;
assign   vif.int_sts_duration_loff_statn    = `IMEAS_TOP.int_sts_duration_loff_statn;
assign   vif.int_sts_duration_loff_statp    = `IMEAS_TOP.int_sts_duration_loff_statp;
assign   vif.int_sts_duration_acloff_statn  = `IMEAS_TOP.int_sts_duration_acloff_statn;
assign   vif.int_sts_duration_acloff_statp  = `IMEAS_TOP.int_sts_duration_acloff_statp;
assign   vif.lead_off_sts_clear  =   `IMEAS_TOP.int_clr;
assign   vif.switch_tgt          =   dut_vif.leadoff_switch_tgt;

`ifndef POSTLAYOUT_PG
assign   vif.switch_tgt_cnt_loff_statn      =   `IMEAS_TOP.u_leadoff_chk_loff_statn.leadoff_switch_tgt_cnt;
assign   vif.switch_tgt_cnt_loff_statp      =   `IMEAS_TOP.u_leadoff_chk_loff_statp.leadoff_switch_tgt_cnt;
assign   vif.switch_tgt_cnt_acloff_statn    =   `IMEAS_TOP.u_leadoff_chk_acloff_statn.leadoff_switch_tgt_cnt;
assign   vif.switch_tgt_cnt_acloff_statp    =   `IMEAS_TOP.u_leadoff_chk_acloff_statp.leadoff_switch_tgt_cnt;
`else
assign   vif.switch_tgt_cnt      = {
                                   `IMEAS_TOP.leadoff_switch_tgt_cnt_reg_7_.Q,
                                   `IMEAS_TOP.leadoff_switch_tgt_cnt_reg_6_.Q,
                                   `IMEAS_TOP.leadoff_switch_tgt_cnt_reg_5_.Q,
                                   `IMEAS_TOP.leadoff_switch_tgt_cnt_reg_4_.Q,
                                   `IMEAS_TOP.leadoff_switch_tgt_cnt_reg_3_.Q,
                                   `IMEAS_TOP.leadoff_switch_tgt_cnt_reg_2_.Q,
                                   `IMEAS_TOP.leadoff_switch_tgt_cnt_reg_1_.Q,
                                   `IMEAS_TOP.leadoff_switch_tgt_cnt_reg_0_.Q
                                   };
`endif

assign   vif.duration_tgt        =   dut_vif.leadoff_duration_tgt;
`ifdef BEHAVIORAL

assign   vif.duration_tgt_cnt_loff_statn    =   `IMEAS_TOP.u_leadoff_chk_loff_statn.leadoff_duration_tgt_cnt;
assign   vif.duration_tgt_cnt_loff_statp    =   `IMEAS_TOP.u_leadoff_chk_loff_statp.leadoff_duration_tgt_cnt;
assign   vif.duration_tgt_cnt_acloff_statn  =   `IMEAS_TOP.u_leadoff_chk_acloff_statn.leadoff_duration_tgt_cnt;
assign   vif.duration_tgt_cnt_acloff_statp  =   `IMEAS_TOP.u_leadoff_chk_acloff_statp.leadoff_duration_tgt_cnt;  
`else
assign   vif.duration_tgt_cnt    = { 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_15_.Q, 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_14_.Q, 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_13_.Q, 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_12_.Q, 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_11_.Q, 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_10_.Q, 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_9_.Q, 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_8_.Q, 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_7_.Q, 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_6_.Q, 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_5_.Q, 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_4_.Q, 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_3_.Q, 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_2_.Q, 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_1_.Q, 
                                   `IMEAS_TOP.leadoff_duration_tgt_cnt_reg_0_.Q};
`endif
assign   vif.type_sel            =   `IMEAS_TOP.leadoff_type_sel_reg;
assign   vif.lead_off_int_en     =   `IMEAS_TOP.leadoff_int_en;
assign   vif.lead_off_det_en     =   `IMEAS_TOP.leadoff_det_en;
assign   vif.dc_loff_en          =   dut_vif.en_ac_dc_lead_off[0];
assign   vif.ac_loff_en          =   dut_vif.en_ac_dc_lead_off[1];
//assign   vif.A2D_LOFF_STATN      =   `IMEAS_TOP.A2D_LOFF_STATN;
//assign   vif.A2D_LOFF_STATP      =   `IMEAS_TOP.A2D_LOFF_STATP;
//assign   vif.A2D_ACLOFF_STATN   =   `IMEAS_TOP.A2D_ACLEADOFF_STATN;
//assign   vif.A2D_ACLOFF_STATP   =   `IMEAS_TOP.A2D_ACLEADOFF_STATP;
assign   vif.A2D_LOFF_STATN     =   (dut_vif.leadoff_high_low_active == 0) ? `IMEAS_TOP.A2D_LOFF_STATN : ~`IMEAS_TOP.A2D_LOFF_STATN;
assign   vif.A2D_LOFF_STATP     =   (dut_vif.leadoff_high_low_active == 0) ? `IMEAS_TOP.A2D_LOFF_STATP : ~`IMEAS_TOP.A2D_LOFF_STATP;
assign   vif.A2D_ACLOFF_STATN   =   (dut_vif.leadoff_high_low_active == 0) ? `IMEAS_TOP.A2D_ACLEADOFF_STATN : ~`IMEAS_TOP.A2D_ACLEADOFF_STATN;
assign   vif.A2D_ACLOFF_STATP   =   (dut_vif.leadoff_high_low_active == 0) ? `IMEAS_TOP.A2D_ACLEADOFF_STATP : ~`IMEAS_TOP.A2D_ACLEADOFF_STATP;

// Connect them to 

// DC Lines
assign `ANA_TOP.A2D_LOFF_STATN = dut_vif.LEAD_OFF_STATN;
assign `ANA_TOP.A2D_LOFF_STATP = dut_vif.LEAD_OFF_STATP;

// AC Lines
assign `ANA_TOP.A2D_ACLEADOFF_STATN = dut_vif.LEAD_AC_OFF_STATN;
assign `ANA_TOP.A2D_ACLEADOFF_STATP = dut_vif.LEAD_AC_OFF_STATP;

initial begin
    nnc_config_db#(virtual nnc_lead_off_interface)::set(uvm_root::get(), "uvm_test_top.top_env", "vif", vif);
end
