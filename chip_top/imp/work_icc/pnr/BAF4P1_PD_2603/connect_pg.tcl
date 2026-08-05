#################################################################
## RCMCU_PLVDDH    u_iopad_plvddh    vddh(VDDIO)           
## RCMCU_PLVPP     u_iopad_plvpp     VPP(VPP)              
## RCMCU_PLVDDI    u_iopad_plvddi0   vddi(VDD_DIG),        .vssi(VSS_DIG)  
## RCMCU_PLVDDI    u_iopad_plvddi1   vddi(VDD_DIG_AFSW),     .vssi(VSS_DIG)
## RCMCU_PLVSSH    u_iopad_plvssh_0  vssh(VSSIO)           
## RCMCU_PLVSSH    u_iopad_plvssh_1  vssh(VSSIO)           
## RCMCU_PLVSS     u_iopad_plvss     gnd(VSS_DIG_AO)       
## RCMCU_PLVDD     u_iopad_plvdd     vdd(VDD_DIG_AO)       
## RCMCU_PLVDDHIS  u_iopad_plvddhi   vddhis(DVDD_1P5_ANA)  
## RCMCU_PLAR      u_iopad_plar      P(flash_ref) YA(VREF0P8)    
#################################################################

## CORE ALWAYS ON
#g derive_pg_connection -reconnect -power_net  VDD_DIG_AO  -power_pin   VDD  -cells [get_flat_cells  top_dig_always_on_inst*]
#g derive_pg_connection -reconnect -ground_net VSS_DIG_AO  -ground_pin  VSS  -cells [get_flat_cells  top_dig_always_on_inst*]
#g derive_pg_connection -reconnect -ground_net VSS_DIG_AO  -ground_pin  VSS  -cells [get_flat_cells  IO_PREBUF*]
#g derive_pg_connection -reconnect -power_net  VDD_DIG_AO  -power_pin   VDD  -cells [get_flat_cells -all xoendcap*]
#g derive_pg_connection -reconnect -ground_net VSS_DIG_AO  -ground_pin  VSS  -cells [get_flat_cells -all xoendcap*]
#g derive_pg_connection -reconnect -power_net  VDD_DIG_AO  -power_pin   VDD  -cells [get_flat_cells -all tapfiller*]
#g derive_pg_connection -reconnect -ground_net VSS_DIG_AO  -ground_pin  VSS  -cells [get_flat_cells -all tapfiller*]

derive_pg_connection -reconnect -power_net  VDD_DIG_AO  -power_pin   VDD
derive_pg_connection -reconnect -ground_net VSS_DIG_AO  -ground_pin  VSS 

## CORE 
derive_pg_connection -reconnect -power_net  VDD_DIG_SW  -power_pin   VDD  -cells [get_flat_cells -all u_top_dig/*]
derive_pg_connection -reconnect -ground_net VSS_DIG_SW  -ground_pin  VSS  -cells [get_flat_cells -all u_top_dig/*]

## IO 
derive_pg_connection -reconnect -power_net  VDD_DIG_SW    -power_pin    vddi  -cells [get_flat_cells  u_iopad_plvddi0]
derive_pg_connection -reconnect -power_net  VDD_DIG_AFSW -power_pin    vddi  -cells [get_flat_cells  u_iopad_plvddi1]
derive_pg_connection -reconnect -ground_net VSS_DIG_SW    -ground_pin   vssi

#derive_pg_connection -reconnect -power_net  VDD_DIG_AO  -power_pin   VDD  -cells [get_cells icc_ctsCLKBUFX20M_G3B1I1]
#derive_pg_connection -reconnect -ground_net VSS_DIG_AO  -ground_pin  VSS  -cells [get_cells icc_ctsCLKBUFX20M_G3B1I1]
## IO ALWAYS ON
#vddh vdd gnd vssh POC
#derive_pg_connection -reconnect -power_net  VDD_DIG_AO  -power_pin   vdd  -cells [get_cells -all -filter mask_layout_type==io_pad u_iopad_plvdd]
#derive_pg_connection -reconnect -ground_net VSS_DIG_AO  -ground_pin  gnd  -cells [get_cells -all -filter mask_layout_type==io_pad u_iopad_plvss]
derive_pg_connection -reconnect -power_net  VDD_DIG_AO  -power_pin   vdd  -cells [get_cells -all -filter mask_layout_type=~*pad*]
derive_pg_connection -reconnect -ground_net VSS_DIG_AO  -ground_pin  gnd  -cells [get_cells -all -filter mask_layout_type=~*pad*]
derive_pg_connection -reconnect -power_net  VDDIO       -power_pin   vddh -cells [get_cells -all -filter mask_layout_type=~*pad*]
derive_pg_connection -reconnect -ground_net VSSIO       -ground_pin  vssh -cells [get_cells -all -filter mask_layout_type=~*pad*]
derive_pg_connection -reconnect -power_net  VDDIO       -power_pin   vddxa -cells [get_cells -all -filter mask_layout_type=~*pad*]
derive_pg_connection -reconnect -ground_net VSSIO       -ground_pin  vssxa -cells [get_cells -all -filter mask_layout_type=~*pad*]
derive_pg_connection -reconnect -power_net  DVDD_1P5_ANA    -power_pin  vddhis 

#Isolated pad of vss_dig_dw:
#derive_pg_connection -reconnect -ground_net VSS_DIG_SW  -ground_pin  gnd  -cells [get_cells -all u_iopad_plvss_sw]
derive_pg_connection -reconnect -power_net POC         -power_pin  POC  -cells [get_cells -all -filter mask_layout_type=~*pad*]

## FLASH
derive_pg_connection -reconnect -power_net  VDD_DIG_SW    -power_pin  vdd  -cells [get_cells u_top_dig/flash_ctrl_top_inst/u_32k]
derive_pg_connection -reconnect -ground_net VSS_DIG_SW    -ground_pin gnd  -cells [get_cells u_top_dig/flash_ctrl_top_inst/u_32k]
#derive_pg_connection -reconnect -power_net VREF0P8	  -power_pin  VREF  -cells [get_cells u_top_dig/flash_ctrl_top_inst/u_32k] 
## ANA
#gderive_pg_connection -reconnect -power_net  DVDD_1P5_ANA    -power_pin  DVDD1P5_ANA 
#gderive_pg_connection -reconnect -power_net  VDD_DIG_AFSW    -power_pin  VDD_DIG_AFSW 
#derive_pg_connection -reconnect -ground_net VSS_DIG_AO    -ground_pin VSS2   -cells [get_cells u_top_ana] 
#derive_pg_connection -reconnect -ground_net VSS_DIG_AO    -ground_pin VSS1   -cells [get_cells u_top_ana]
derive_pg_connection -reconnect -power_net POC         -power_pin  POC  -cells [get_cells u_top_ana]
#g derive_pg_connection -reconnect -ground_net  VSS_DIG_SW  -ground_pin   VSS  -cells [get_flat_cells -all u_top_dig/tapfiller_FILLTIEM_4838]
#g derive_pg_connection -reconnect -power_net  VDD_DIG_SW  -power_pin   VDD  -cells [get_flat_cells -all u_top_dig/tapfiller_FILLTIEM_4838]


## vdd,     u_top_dig/flash_ctrl_top_inst/u_32k/vdd,     
## gnd,     u_top_dig/flash_ctrl_top_inst/u_32k/gnd,     
## TM0VPP,  u_top_dig/flash_ctrl_top_inst/u_32k/TM0VPP,  
## VREF,    u_top_dig/flash_ctrl_top_inst/u_32k/VREF,    
