/*--------------------------------------------------------------------------------------
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_base_test.sv                                                   
// Project	: Nanochap SOC                                  		        
// Description	: Testcase soc_base_test is base test class of SOC                                           
// Designer	: ddang@nanochap.com                                                                 
// Date		: 18-03-2024                                                                    
// Revision	: 0.1                                 
--------------------------------------------------------------------------------------*/
`ifndef SOC_BASE_TEST__SV
`define SOC_BASE_TEST__SV

 import nnc_uvm_pkg::*;
 `include "nnc_uvm_methodology.svh"

`define TESTNAME soc_base_test
`define TESTCFG soc_base_test_cfg

// Register Defines
`define  SOC_IMEAS_REG_CTRL_0 	        8'h01 // Checked
`define  SOC_IMEAS_REG_CTRL_0_INIT      8'h10

`define  SOC_IMEAS_REG_CTRL_1 	        8'h02 // Checked
`define  SOC_IMEAS_REG_CTRL_1_INIT 	8'h00

`define  SOC_IMEAS_MODE_REG 		8'h03 // Checked
`define  SOC_IMEAS_MODE_REG_INIT        8'h00

`define  SOC_IMEAS_STATUS 	        8'h04 // Checked
`define  SOC_IMEAS_STATUS_INIT          8'h00

`define  SOC_IMEAS_REG_SEQ 	        8'h05 // Checked
`define  SOC_IMEAS_REG_SEQ_INIT         8'h07

`define  SOC_IMEAS_REG_RSTVAL 	        8'h06 // Checked
`define  SOC_IMEAS_REG_RSTVAL_INIT      8'h50

`define  SOC_IMEAS_CH0DATA_0 	        8'h07 // Checked
`define  SOC_IMEAS_CH0DATA_0_INIT       8'h00

`define  SOC_IMEAS_CH0DATA_1 	        8'h08 // Checked
`define  SOC_IMEAS_CH0DATA_1_INIT       8'h00

`define  SOC_IMEAS_CH1DATA_0 	        8'h09 // Checked
`define  SOC_IMEAS_CH1DATA_0_INIT       8'h00

`define  SOC_IMEAS_CH1DATA_1 	        8'h0A // Checked
`define  SOC_IMEAS_CH1DATA_1_INIT       8'h00

`define  SOC_IMEAS_CH2DATA_0 	        8'h0B // Checked
`define  SOC_IMEAS_CH2DATA_0_INIT       8'h00

`define  SOC_IMEAS_CH2DATA_1 	        8'h0C // Checked
`define  SOC_IMEAS_CH2DATA_1_INIT       8'h00

`define  SOC_IMEAS_GRP_CTL 	        8'h0D // Checked
`define  SOC_IMEAS_GRP_CTL_INIT         8'h00

`define  SOC_IMEAS_CHA_NUM_LO           8'h0E // Checked
`define  SOC_IMEAS_CHA_NUM_LO_INIT      8'h10

`define  SOC_IMEAS_CHA_NUM_HI           8'h0F // Checked
`define  SOC_IMEAS_CHA_NUM_HI_INIT      8'h02

`define  SOC_IMEAS_ALARM_INT 		8'h10 // Checked
`define  SOC_IMEAS_ALARM_INT_INIT 	8'h00

`define  SOC_IMEAS_ALARM_INT_EN 	8'h11 // Checked
`define  SOC_IMEAS_ALARM_INT_EN_INIT 	8'h00

`define  SOC_IMEAS_THRESHOLD_HI_0 	8'h12 // Checked
`define  SOC_IMEAS_THRESHOLD_HI_0_INIT 	8'hff

`define  SOC_IMEAS_THRESHOLD_HI_1 	8'h13 // Checked
`define  SOC_IMEAS_THRESHOLD_HI_1_INIT 	8'hff

`define  SOC_IMEAS_THRESHOLD_LO_0 	8'h14  // Checked
`define  SOC_IMEAS_THRESHOLD_LO_0_INIT 	8'h00

`define  SOC_IMEAS_THRESHOLD_LO_1 	8'h15  // Checked
`define  SOC_IMEAS_THRESHOLD_LO_1_INIT 	8'h00

`define  SOC_IMEAS_INPUT_FORMAT 	8'h16  // Checked
`define  SOC_IMEAS_INPUT_FORMAT_INIT 	8'h02

`define  SOC_IMEAS_EN 	                8'h17  // Checked
`define  SOC_IMEAS_EN_INIT 	        8'h00

`define  SOC_IMEAS_CH0DATA_MAX_0                     8'h18  // Checked
`define  SOC_IMEAS_CH0DATA_MAX_0_INIT                8'h00

`define  SOC_IMEAS_CH0DATA_MAX_1                     8'h19  // Checked
`define  SOC_IMEAS_CH0DATA_MAX_1_INIT                8'h00

`define  SOC_IMEAS_CH0DATA_MIN_0                     8'h1A  // Checked
`define  SOC_IMEAS_CH0DATA_MIN_0_INIT                8'h00

`define  SOC_IMEAS_CH0DATA_MIN_1                     8'h1B  // Checked
`define  SOC_IMEAS_CH0DATA_MIN_1_INIT                8'h00

`define  SOC_IMEAS_CH0DATA_DELTA_0                   8'h1C  // Checked
`define  SOC_IMEAS_CH0DATA_DELTA_0_INIT              8'h00

`define  SOC_IMEAS_CH0DATA_DELTA_1                   8'h1D  // Checked
`define  SOC_IMEAS_CH0DATA_DELTA_1_INIT              8'h00

`define  SOC_NOTCH_FILTER_EN                         8'h1E
`define  SOC_NOTCH_FILTER_EN_INIT                    8'h00

`define  SOC_ZMEAS_REG_CTRL_0 	                     8'h20
`define  SOC_ZMEAS_REG_CTRL_0_INIT 	             8'h00

`define  SOC_ZMEAS_REG_CTRL_1 	                     8'h21
`define  SOC_ZMEAS_REG_CTRL_1_INIT 	             8'h00

`define  SOC_ZMEAS_REG_CTRL_2 	                     8'h22
`define  SOC_ZMEAS_REG_CTRL_2_INIT 	             8'h01

`define  SOC_ZMEAS_REG_CTRL_3 	                     8'h23
`define  SOC_ZMEAS_REG_CTRL_3_INIT 	             8'h00

`define  SOC_ZMEAS_REG_STATUS_0                      8'h24
`define  SOC_ZMEAS_REG_STATUS_0_INIT                 8'h00

`define  SOC_ZMEAS_REG_STATUS_1 	             8'h25
`define  SOC_ZMEAS_REG_STATUS_1_INIT 	             8'h00

`define  SOC_ZMEAS_REG_DATAOUT_0 	             8'h26
`define  SOC_ZMEAS_REG_DATAOUT_0_INIT 	             8'h00

`define  SOC_ZMEAS_REG_DATAOUT_1 	             8'h27
`define  SOC_ZMEAS_REG_DATAOUT_1_INIT 	             8'h00

`define  SOC_ZMEAS_REG_DATAOUT_2 	             8'h28
`define  SOC_ZMEAS_REG_DATAOUT_2_INIT 	             8'h00

`define  SOC_ZMEAS_REG_DATAOUT_3 	             8'h29
`define  SOC_ZMEAS_REG_DATAOUT_3_INIT 	             8'h00

`define  SOC_ZMEAS_ADC_ROM_REG_0 	             8'h2A
`define  SOC_ZMEAS_ADC_ROM_REG_0_INIT 	             8'h00

`define  SOC_ZMEAS_ADC_ROM_REG_1 	             8'h2B
`define  SOC_ZMEAS_ADC_ROM_REG_1_INIT 	             8'h00

`define  SOC_ZMEAS_ADC_ROM_REG_2 	             8'h2C
`define  SOC_ZMEAS_ADC_ROM_REG_2_INIT 	             8'h00

`define  SOC_ZMEAS_ADC_ROM_REG_3 	             8'h2D
`define  SOC_ZMEAS_ADC_ROM_REG_3_INIT 	             8'h00

`define  SOC_ZMEAS_SUM_OFFSET_FORREAL_0              8'h2E
`define  SOC_ZMEAS_SUM_OFFSET_FORREAL_0_INIT         8'h00

`define  SOC_ZMEAS_SUM_OFFSET_FORREAL_1              8'h2F
`define  SOC_ZMEAS_SUM_OFFSET_FORREAL_1_INIT         8'h00

`define  SOC_ZMEAS_SUM_OFFSET_FORREAL_2              8'h30
`define  SOC_ZMEAS_SUM_OFFSET_FORREAL_2_INIT         8'h00

`define  SOC_ZMEAS_SUM_OFFSET_FORREAL_3              8'h31
`define  SOC_ZMEAS_SUM_OFFSET_FORREAL_3_INIT         8'h00

`define  SOC_ZMEAS_SUM_REAL_0 	                     8'h32
`define  SOC_ZMEAS_SUM_REAL_0_INIT 	             8'h00

`define  SOC_ZMEAS_SUM_REAL_1 	                     8'h33
`define  SOC_ZMEAS_SUM_REAL_1_INIT 	             8'h00

`define  SOC_ZMEAS_SUM_REAL_2 	                     8'h34
`define  SOC_ZMEAS_SUM_REAL_2_INIT 	             8'h00

`define  SOC_ZMEAS_SUM_REAL_3 	                     8'h35
`define  SOC_ZMEAS_SUM_REAL_3_INIT 	             8'h00

`define  SOC_ZMEAS_SUM_IMAG_0 	                     8'h36
`define  SOC_ZMEAS_SUM_IMAG_0_INIT 	             8'h00

`define  SOC_ZMEAS_SUM_IMAG_1 	                     8'h37
`define  SOC_ZMEAS_SUM_IMAG_1_INIT 	             8'h00

`define  SOC_ZMEAS_SUM_IMAG_2 	                     8'h38
`define  SOC_ZMEAS_SUM_IMAG_2_INIT 	             8'h00

`define  SOC_ZMEAS_SUM_IMAG_3 	                     8'h39
`define  SOC_ZMEAS_SUM_IMAG_3_INIT 	             8'h00

`define  SOC_ZMEAS_SUM_SHIFT_0 	                     8'h3A
`define  SOC_ZMEAS_SUM_SHIFT_0_INIT 	             8'h00

`define  SOC_ZMEAS_SUM_SHIFT_1 	                     8'h3B
`define  SOC_ZMEAS_SUM_SHIFT_1_INIT 	             8'h00

`define  SOC_ZMEAS_SUM_SHIFT_2 	                     8'h3C
`define  SOC_ZMEAS_SUM_SHIFT_2_INIT 	             8'h00

`define  SOC_ZMEAS_SUM_SHIFT_3 	                     8'h3D
`define  SOC_ZMEAS_SUM_SHIFT_3_INIT 	             8'h00

`define  SOC_ZMEAS_INT 			             8'h3E
`define  SOC_ZMEAS_INT_INIT 			     8'h00

`define  SOC_ZMEAS_ADC_INT 		             8'h3F
`define  SOC_ZMEAS_ADC_INT_INIT 		     8'h00

`define  SOC_ZMEAS_EN 	        	             8'h40
`define  SOC_ZMEAS_EN_INIT 	        	     8'h00

`define  SOC_MEAS_SYNC_EN 	                     8'h41 // Checked now
`define  SOC_MEAS_SYNC_EN_INIT                       8'h01

`define  SOC_ANA_Z_ADC_DAC_EN                        8'h42
`define  SOC_ANA_Z_ADC_DAC_EN_INIT                   8'h00

`define  SOC_ANA_Z_ADC_DAC_EN_SEL                    8'h43
`define  SOC_ANA_Z_ADC_DAC_EN_SEL_INIT               8'h00

`define  SOC_RLD_CLK_REG                             8'h49
`define  SOC_RLD_CLK_REGINIT                         8'h00

`define  SOC_LEADOFF_CLK_REG 	        	     8'h4A
`define  SOC_LEADOFF_CLK_REG_INIT 	             8'h02

`define  SOC_MCLK_DIV_REG 	        	     8'h4B
`define  SOC_MCLK_DIV_REG_INIT 	                     8'h13

`define  SOC_CHECK_CLK_DIV_HI_REG 	             8'h4C
`define  SOC_CHECK_CLK_DIV_HI_INIT 	             8'h03

`define  SOC_CHECK_CLK_DIV_LO_REG 	             8'h4D
`define  SOC_CHECK_CLK_DIV_LO_INIT 	             8'hE7

`define  SOC_CLK_CTRL_REG                            8'h4E
`define  SOC_CLK_CTRL_REG_INIT                       8'h10 // Checked

`define  SOC_PMU_REG0		                     8'h4F 
`define  SOC_PMU_REG0_INIT		             8'h01 // Checked

`define  SOC_FLASH_DEBUG1                            8'h50 
`define  SOC_FLASH_DEBUG1_INIT                       8'h43 // Checked

`define  SOC_FLASH_DEBUG2                            8'h51
`define  SOC_FLASH_DEBUG2_INIT                       8'h00 // Checked

`define  SOC_FLASH_TRIMDATA0                         8'h52
`define  SOC_FLASH_TRIMDATA0_INIT                    8'h00 // Checked
`define  SOC_FLASH_TRIMDATA0_RELOAD_INIT             8'h5A // Checked

`define  SOC_FLASH_TRIMDATA1                         8'h53
`define  SOC_FLASH_TRIMDATA1_INIT                    8'h00 // Checked 
`define  SOC_FLASH_TRIMDATA1_RELOAD_INIT             8'h10 // Checked 

`define  SOC_FLASH_TRIMDATA2                         8'h54
`define  SOC_FLASH_TRIMDATA2_INIT                    8'h00 // Checked 
`define  SOC_FLASH_TRIMDATA2_RELOAD_INIT             8'h40 // Checked 

`define  SOC_FLASH_TRIMDATA3                         8'h55
`define  SOC_FLASH_TRIMDATA3_INIT                    8'h00 // Checked 
`define  SOC_FLASH_TRIMDATA3_RELOAD_INIT             8'h02 // Checked 

`define  SOC_FLASH_TRIMDATA4                         8'h56
`define  SOC_FLASH_TRIMDATA4_INIT                    8'h00 // Checked
`define  SOC_FLASH_TRIMDATA4_RELOAD_INIT             8'h20 // Checked

`define  SOC_FLASH_TRIMDATA5                         8'h57
`define  SOC_FLASH_TRIMDATA5_INIT                    8'h00 // Checked
`define  SOC_FLASH_TRIMDATA5_RELOAD_INIT             8'h01 // Checked

`define  SOC_FLASH_TRIMDATA6                         8'h58
`define  SOC_FLASH_TRIMDATA6_INIT                    8'h00 // Checked
`define  SOC_FLASH_TRIMDATA6_RELOAD_INIT             8'h00 // Checked

`define  SOC_FLASH_TRIMDATA7                         8'h59
`define  SOC_FLASH_TRIMDATA7_INIT                    8'h00 // Checked
`define  SOC_FLASH_TRIMDATA7_RELOAD_INIT             8'h00 // Checked

`define  SOC_FLASH_TRIMDATA8                         8'h5A
`define  SOC_FLASH_TRIMDATA8_INIT                    8'h00 // Checked
`define  SOC_FLASH_TRIMDATA8_RELOAD_INIT             8'h04 // Checked

`define  SOC_FLASH_TRIMDATA9                         8'h5B
`define  SOC_FLASH_TRIMDATA9_INIT                    8'h00 // Checked
`define  SOC_FLASH_TRIMDATA9_RELOAD_INIT             8'h04 // Checked

`define  SOC_FLASH_TRIMDATA10                        8'h5C
`define  SOC_FLASH_TRIMDATA10_INIT                   8'h00 // Checked
`define  SOC_FLASH_TRIMDATA10_RELOAD_INIT            8'h01 // Checked

`define  SOC_FLASH_TRIMDATA11                        8'h5D
`define  SOC_FLASH_TRIMDATA11_INIT                   8'h00 // Checked
`define  SOC_FLASH_TRIMDATA11_RELOAD_INIT            8'hC0 // Checked

`define  SOC_FLASH_TRIMDATA12                        8'h5E
`define  SOC_FLASH_TRIMDATA12_INIT                   8'h00 // Checked
`define  SOC_FLASH_TRIMDATA12_RELOAD_INIT            8'h00 // Checked

`define  SOC_FLASH_TRIMDATA13                        8'h5F
`define  SOC_FLASH_TRIMDATA13_INIT                   8'h00 // Checked
`define  SOC_FLASH_TRIMDATA13_RELOAD_INIT            8'h80 // Checked

`define  SOC_FLASH_TRIMDATA14                        8'h60
`define  SOC_FLASH_TRIMDATA14_INIT                   8'h00 // Checked
`define  SOC_FLASH_TRIMDATA14_RELOAD_INIT            8'h00 // Checked

`define  SOC_FLASH_TRIMDATA15                        8'h61
`define  SOC_FLASH_TRIMDATA15_INIT                   8'h00 // Checked

`define  SOC_FLASH_TRIMDATA16                        8'h62
`define  SOC_FLASH_TRIMDATA16_INIT                   8'h00 // Checked

`define  SOC_FLASH_TRIMDATA17                        8'h63
`define  SOC_FLASH_TRIMDATA17_INIT                   8'h00 // Checked

`define  SOC_FLASH_TRIMDATA18                        8'h64
`define  SOC_FLASH_TRIMDATA18_INIT                   8'h00 // Checked

`define  SOC_FLASH_TRIMDATA19                        8'h65
`define  SOC_FLASH_TRIMDATA19_INIT                   8'h00 // Checked

`define  SOC_FLASH_TRIMDATA20                        8'h66
`define  SOC_FLASH_TRIMDATA20_INIT                   8'h00 // Checked


//Vu Changed 21/07/2026 according to new manual
`define  SOC_FLASH_UNLOCK                            8'h67
`define  SOC_FLASH_UNLOCK_INIT                       8'h00 // Checked

`define  SOC_FLASH_CTRL                              8'h68
`define  SOC_FLASH_CTRL_INIT                         8'h00 // Checked

`define  SOC_FLASH_DATA00                            8'h69
`define  SOC_FLASH_DATA00_INIT                       8'h00 // Checked

`define  SOC_FLASH_ADDR00                            8'h6A
`define  SOC_FLASH_ADDR00_INIT                       8'h00 // Checked

`define  SOC_FLASH_ADDR01                            8'h6B
`define  SOC_FLASH_ADDR01_INIT                       8'h00 // Checked

`define  SOC_FLASH_EME_DATA                          8'h6C
`define  SOC_FLASH_EME_DATA_INIT                     8'h00 // Checked

`define  SOC_FLASH_RND_ADDR                          8'h6D
`define  SOC_FLASH_RND_ADDR_INIT                     8'h00 // Checked

`define  SOC_FLASH_NVR_PRO_BYTE00                    8'h6E
`define  SOC_FLASH_NVR_PRO_BYTE00_INIT               8'h00
    
`define  SOC_FLASH_NVR_PRO_BYTE01                    8'h6F
`define  SOC_FLASH_NVR_PRO_BYTE01_INIT               8'h00
    
`define  SOC_FLASH_UNLOCK_PRO                        8'h70
`define  SOC_FLASH_UNLOCK_PRO_INIT                   8'h00


//Should Remove    
`define  SOC_FLASH_ADDR                              8'h6A
`define  SOC_FLASH_ADDR_INIT                         8'h00 // Checked

`define  SOC_FLASH_DATA                              8'h6A
`define  SOC_FLASH_DATA_INIT                         8'h00 // Checked

`define  SOC_DEVICE_INT_STATUS_0                     8'h70
`define  SOC_DEVICE_INT_STATUS_0_INIT                8'h00

`define  SOC_DEVICE_INT_STATUS_1                     8'h71
`define  SOC_DEVICE_INT_STATUS_1_INIT                8'h0a


`define  SOC_PPG_CTRL_1_REG                          8'H72
`define  SOC_PPG_CTRL_1_REG_INIT                     8'h00 // Checked

`define  SOC_PPG_LED_TIME_SEL                        8'H73
`define  SOC_PPG_LED_TIME_SEL_INIT                   8'h00 // Checked

`define  SOC_PPG_LED_FREQ_SEL                        8'H74
`define  SOC_PPG_LED_FREQ_SEL_INIT                   8'h00 // Checked

`define  SOC_PPG_LED_STATUS                          8'H75
`define  SOC_PPG_LED_STATUS_INIT                     8'h00 // Checked

`define  SOC_DATA_TYPE_SEL                           8'h76
`define  SOC_DATA_TYPE_SEL_INIT                      8'h00

`define  SOC_DC_DATA_REG_0                           8'h77
`define  SOC_DC_DATA_REG_0_INIT                      8'h00

`define  SOC_DC_DATA_REG_1                           8'h78
`define  SOC_DC_DATA_REG_1_INIT                      8'h01

//`define  SOC_SQU_DATA_L_0                            8'h79
//`define  SOC_SQU_DATA_L_0_INIT                       8'h00
//
//`define  SOC_SQU_DATA_L_1                            8'h7A
//`define  SOC_SQU_DATA_L_1_INIT                       8'h00
//
//`define  SOC_SQU_DATA_H_0                            8'h7B
//`define  SOC_SQU_DATA_H_0_INIT                       8'h00
//
//`define  SOC_SQU_DATA_H_1                            8'h7C // Checked
//`define  SOC_SQU_DATA_H_1_INIT                       8'h01

`define  SOC_SQU_CLK_DIV_0                           8'H79
`define  SOC_SQU_CLK_DIV_0_INIT                      8'h0f // Checked

`define  SOC_SQU_CLK_DIV_1                           8'H7A
`define  SOC_SQU_CLK_DIV_1_INIT                      8'h00 // Checked

`define  SOC_FIFO_WR_PTR_REG                         8'h80
`define  SOC_FIFO_WR_PTR_REG_INIT                    8'h00

`define  SOC_FIFO_RD_PTR_REG                         8'h81
`define  SOC_FIFO_RD_PTR_REG_INIT                    8'h00

`define  SOC_FIFO_COUNTER_1_REG                      8'h82
`define  SOC_FIFO_COUNTER_1_REG_INIT                 8'h00

`define  SOC_FIFO_COUNTER_2_REG                      8'h83
`define  SOC_FIFO_COUNTER_2_REG_INIT                 8'h00

`define  SOC_FIFO_CONFIG_1_REG                       8'h84
`define  SOC_FIFO_CONFIG_1_REG_INIT                  8'h5F  // checked

`define  SOC_FIFO_CONFIG_2_REG                       8'h85
`define  SOC_FIFO_CONFIG_2_REG_INIT                  8'h1f

`define  SOC_FIFO_CONFIG_3_REG                       8'h86
`define  SOC_FIFO_CONFIG_3_REG_INIT                  8'h00

`define  SOC_FIFO_STATUS_REG                         8'h87
`define  SOC_FIFO_STATUS_REG_INIT                    8'h50

`define  SOC_FIFO_DATA_REG1                          8'h88
`define  SOC_FIFO_DATA_REG1_INIT                     8'h00

`define  SOC_FIFO_DATA_REG2		             8'h89
`define  SOC_FIFO_DATA_REG2_INIT		     8'h00

`define  SOC_GPIO_PU_CTR               	             8'h90
`ifdef POSTLAYOUT_PG
`define  SOC_GPIO_PU_CTR_INIT                	     8'h00
`else
`define  SOC_GPIO_PU_CTR_INIT                	     8'h07
`endif

`define  SOC_GPIO_PU_RESETN                          8'h91
`define  SOC_GPIO_PU_RESETN_INIT                     8'H01

`define  SOC_GPIO_PD_TESTMODE			     8'h92	
`define  SOC_GPIO_PD_TESTMODE_INIT	             8'H03

`define  SOC_LEADOFF_CTRL                            8'H93
`define  SOC_LEADOFF_CTRL_INIT                       8'h00 // Checked

`define  SOC_LEADOFF_TGT_0                           8'H94
`define  SOC_LEADOFF_TGT_0_INIT                      8'hff // Checked

`define  SOC_LEADOFF_TGT_1                           8'H95
`define  SOC_LEADOFF_TGT_1_INIT                      8'h00 // Checked

`define  SOC_LEADOFF_SWITCH_TGT                      8'H96
`define  SOC_LEADOFF_SWITCH_TGT_INIT                 8'h3f // Checked

`define  SOC_ANA_TSC_1                               8'h9F
`define  SOC_ANA_TSC_1_INIT                          8'h00 // Checked

`define  SOC_ANA_BUFFER                              8'hA0
`define  SOC_ANA_BUFFER_INIT                         8'h00 // Checked

`define  SOC_ANA_ECG_CTRL1                           8'hA1
`define  SOC_ANA_ECG_CTRL1_INIT                      8'h03 // Checked

`define  SOC_ANA_ECG_CTRL2                           8'hA2
`define  SOC_ANA_ECG_CTRL2_INIT                      8'h04 // Checked

`define  SOC_ANA_LEAD_OFF                            8'hA3
`define  SOC_ANA_LEAD_OFF_INIT                       8'h00 // Checked

`define  SOC_ANA_TSC                                 8'hA4
`define  SOC_ANA_TSC_INIT                            8'h00 // Checked

`define  SOC_ANA_PPG_LED_SEL                         8'hA5
`define  SOC_ANA_PPG_LED_SEL_INIT                    8'h00 // Checked

`define  SOC_ANA_PPG_DAC0_CTRL_REG0                  8'hA6
`define  SOC_ANA_PPG_DAC0_CTRL_REG0_INIT             8'h00 // Checked

`define  SOC_ANA_PPG_DAC0_CTRL_REG1                  8'hA7
`define  SOC_ANA_PPG_DAC0_CTRL_REG1_INIT             8'h00 // Checked

`define  SOC_ANA_PPG_DAC1_CTRL_REG0                  8'hA8
`define  SOC_ANA_PPG_DAC1_CTRL_REG0_INIT             8'h00 // Checked

`define  SOC_ANA_PPG_DAC1_CTRL_REG1                  8'hA9
`define  SOC_ANA_PPG_DAC1_CTRL_REG1_INIT             8'h00 // Checked

`define  SOC_ANA_PPG_TIA_IDAC                        8'hAA
`define  SOC_ANA_PPG_TIA_IDAC_INIT                   8'h00 // Checked

`define  SOC_ANA_PPG_TIA_GAIN                        8'hAB
`define  SOC_ANA_PPG_TIA_GAIN_INIT                   8'h00 // Checked

`define  SOC_ANA_PPG_TEST                            8'hAC
`define  SOC_ANA_PPG_TEST_INIT                       8'h00 // Checked

`define  SOC_ANA_PPG_LED_EN                          8'hAD
`define  SOC_ANA_PPG_LED_INIT                        8'h00 // Checked

`define  SOC_ANA_PPG_CTRL                            8'hAE
`define  SOC_ANA_PPG_CTRL_INIT                       8'h00 // Checked

`define  SOC_ANA_SDM                                 8'hAF
`define  SOC_ANA_SDM_INIT                            8'h00 // Checked

`define  SOC_ANA_BIST                                8'hB0
`define  SOC_ANA_BIST_INIT                           8'h00 // Checked

`define  SOC_ANA_LEAD_OFF_EN                         8'hB1
`define  SOC_ANA_LEAD_OFF_EN_INIT                    8'h00 // Checked

`define  SOC_A2D_SPARE_REG0                          8'hB2
`define  SOC_A2D_SPARE_REG0_INIT                     8'h00

`define  SOC_A2D_LOFF_STATN                          8'hB3
`define  SOC_A2D_LOFF_STATN_INIT                     8'h00 // Checked

`define  SOC_A2D_LOFF_STATP                          8'hB4
`define  SOC_A2D_LOFF_STATP_INIT                     8'h00 // Checked

`define  SOC_A2D_ACLEADOFF_STATN                     8'hB5
`define  SOC_A2D_ACLEADOFF_STATN_INIT                8'h00 // Checked

`define  SOC_A2D_ACLEADOFF_STATP                     8'hB6
`define  SOC_A2D_ACLEADOFF_STATP_INIT                8'h00 // Checked

/*
`define  SOC_ALWAYS_ON_ANA_BGH_CTRIM_DEBUG           8'hC0
`define  SOC_ALWAYS_ON_ANA_BGH_CTRIM_DEBUG_INIT      8'h10

`define  SOC_ALWAYS_ON_ANA_BGH_VTRIM_DEBUG           8'hC1
`define  SOC_ALWAYS_ON_ANA_BGH_VTRIM_DEBUG_INIT      8'h40

`define  SOC_ALWAYS_ON_ANA_LDOL1V5_TRIM_DEBUG        8'hC2
`define  SOC_ALWAYS_ON_ANA_LDOL1V5_TRIM_DEBUG_INIT   8'h02

`define  SOC_ALWAYS_ON_ANA_OSC_TRIM_DEBUG            8'hC3
`define  SOC_ALWAYS_ON_ANA_OSC_TRIM_DEBUG_INIT       8'h20

`define  SOC_ALWAYS_ON_ANA_OSC_ISEL                  8'hC4
`define  SOC_ALWAYS_ON_ANA_OSC_ISEL_INIT             8'h01

`define  SOC_ALWAYS_ON_ANA_DCLEADOFF_COMP_TH         8'hC5
`define  SOC_ALWAYS_ON_ANA_DCLEADOFF_COMP_TH_INIT    8'h00

`define  SOC_ALWAYS_ON_ANA_DCLEADOFF_ISEL            8'hC6
`define  SOC_ALWAYS_ON_ANA_DCLEADOFF_ISEL_INIT       8'h00

`define  SOC_ALWAYS_ON_ANA_DCLEADOFF_VTHNSEL         8'hC7
`define  SOC_ALWAYS_ON_ANA_DCLEADOFF_VTHNSEL_INIT    8'h00

`define  SOC_ALWAYS_ON_ANA_DCLEADOFF_VTHPSEL         8'hC8
`define  SOC_ALWAYS_ON_ANA_DCLEADOFF_VTHPSEL_INIT    8'h00

`define  SOC_ALWAYS_ON_ANA_ACLEADOFF_ISEL            8'hC9
`define  SOC_ALWAYS_ON_ANA_ACLEADOFF_ISEL_INIT       8'h00
*/

`define  SOC_ALWAYS_ON_ANA_TRIM1                         8'hC0
`define  SOC_ALWAYS_ON_ANA_TRIM1_INIT                    8'h10

`define  SOC_ALWAYS_ON_ANA_TRIM2                         8'hC1
`define  SOC_ALWAYS_ON_ANA_TRIM2_INIT                    8'h40

`define  SOC_ALWAYS_ON_ANA_TRIM3                         8'hC2
`define  SOC_ALWAYS_ON_ANA_TRIM3_INIT                    8'h02

`define  SOC_ALWAYS_ON_ANA_TRIM4                         8'hC3
`define  SOC_ALWAYS_ON_ANA_TRIM4_INIT                    8'h20

`define  SOC_ALWAYS_ON_ANA_TRIM5                         8'hC4
`define  SOC_ALWAYS_ON_ANA_TRIM5_INIT                    8'h01

`define  SOC_ALWAYS_ON_ANA_TRIM6                         8'hC5
`define  SOC_ALWAYS_ON_ANA_TRIM6_INIT                    8'h00

`define  SOC_ALWAYS_ON_ANA_TRIM7                         8'hC6
`define  SOC_ALWAYS_ON_ANA_TRIM7_INIT                    8'h00

`define  SOC_ALWAYS_ON_ANA_TRIM8                         8'hC7
`define  SOC_ALWAYS_ON_ANA_TRIM8_INIT                    8'h04

`define  SOC_ALWAYS_ON_ANA_TRIM9                         8'hC8
`define  SOC_ALWAYS_ON_ANA_TRIM9_INIT                    8'h04

`define  SOC_ALWAYS_ON_ANA_TRIM10                        8'hC9
`define  SOC_ALWAYS_ON_ANA_TRIM10_INIT                   8'h01

`define PGMCB_WR     4'b0010
`define PGMCB_WR32   4'b1000
`define PGMICB_WR    4'b0011
`define PGMICB_WR32  4'b1001


`define KEY_TRIM    5'b10101
`define KEY_SPI     5'b01010
`define KEY_COEFFI  5'b01110

`define SCALECONST1_FS125        16'b0111001000010010  
`define COEF_B1_SESSION1_FS125   16'b0100000000000000  
`define COEF_B2_SESSION1_FS125   16'b0110011110010000  
`define COEF_B3_SESSION1_FS125   16'b0100000000000000  
`define COEF_A2_SESSION1_FS125   16'b0101001001000010  
`define COEF_A3_SESSION1_FS125   16'b0011000011111111  
`define SCALECONST2_FS125        16'b0111001000010010  
`define COEF_B1_SESSION2_FS125   16'b0100000000000000  
`define COEF_B2_SESSION2_FS125   16'b0110011110010000  
`define COEF_B3_SESSION2_FS125   16'b0100000000000000  
`define COEF_A2_SESSION2_FS125   16'b0110010101010111  
`define COEF_A3_SESSION2_FS125   16'b0011010011000100  

`define SCALECONST1_FS250        16'b0111100100000011   // Verified
`define COEF_B1_SESSION1_FS250   16'b0100000000000000  
`define COEF_B2_SESSION1_FS250   16'b1101100001101100  
`define COEF_B3_SESSION1_FS250   16'b0100000000000000  
`define COEF_A2_SESSION1_FS250   16'b1110000100101001  
`define COEF_A3_SESSION1_FS250   16'b0011100100010110  
`define SCALECONST2_FS250        16'b0111100100000011  
`define COEF_B1_SESSION2_FS250   16'b0100000000000000  
`define COEF_B2_SESSION2_FS250   16'b1101100001101100  
`define COEF_B3_SESSION2_FS250   16'b0100000000000000  
`define COEF_A2_SESSION2_FS250   16'b1101010000011110  
`define COEF_A3_SESSION2_FS250   16'b0011100101010010  

`define SCALECONST1_FS500        16'b0111110001101101   // Verified
`define COEF_B1_SESSION1_FS500   16'b0100000000000000  
`define COEF_B2_SESSION1_FS500   16'b1001100001110011  
`define COEF_B3_SESSION1_FS500   16'b0100000000000000  
`define COEF_A2_SESSION1_FS500   16'b1001110110010000  
`define COEF_A3_SESSION1_FS500   16'b0011110001011000  
`define SCALECONST2_FS500        16'b0111110001101101  
`define COEF_B1_SESSION2_FS500   16'b0100000000000000  
`define COEF_B2_SESSION2_FS500   16'b1001100001110011  
`define COEF_B3_SESSION2_FS500   16'b0100000000000000  
`define COEF_A2_SESSION2_FS500   16'b1001100100110001  
`define COEF_A3_SESSION2_FS500   16'b0011110010011100  

`define SCALECONST1_FS1000       16'b0111111000110100   // Verified
`define COEF_B1_SESSION1_FS1000  16'b0100000000000000  
`define COEF_B2_SESSION1_FS1000  16'b1000011001000100  
`define COEF_B3_SESSION1_FS1000  16'b0100000000000000  
`define COEF_A2_SESSION1_FS1000  16'b1000100010011100  
`define COEF_A3_SESSION1_FS1000  16'b0011111000100100  
`define SCALECONST2_FS1000       16'b0111111000110100  
`define COEF_B1_SESSION2_FS1000  16'b0100000000000000  
`define COEF_B2_SESSION2_FS1000  16'b1000011001000100  
`define COEF_B3_SESSION2_FS1000  16'b0100000000000000  
`define COEF_A2_SESSION2_FS1000  16'b1000011101011100  
`define COEF_A3_SESSION2_FS1000  16'b0011111001001011  

`define SCALECONST1         `SCALECONST1_FS500            
`define COEF_B1_SESSION1    `COEF_B1_SESSION1_FS500
`define COEF_B2_SESSION1    `COEF_B2_SESSION1_FS500
`define COEF_B3_SESSION1    `COEF_B3_SESSION1_FS500
`define COEF_A2_SESSION1    `COEF_A2_SESSION1_FS500
`define COEF_A3_SESSION1    `COEF_A3_SESSION1_FS500
`define SCALECONST2         `SCALECONST2_FS500
`define COEF_B1_SESSION2    `COEF_B1_SESSION2_FS500
`define COEF_B2_SESSION2    `COEF_B2_SESSION2_FS500
`define COEF_B3_SESSION2    `COEF_B3_SESSION2_FS500
`define COEF_A2_SESSION2    `COEF_A2_SESSION2_FS500
`define COEF_A3_SESSION2    `COEF_A3_SESSION2_FS500

   typedef enum { PIN, CMD }           start_src_t;

class `TESTCFG extends nnc_object;

   `nnc_object_utils(`TESTCFG)

    rand  integer        rand_num;

    rand logic [7:0]     data[256];
    rand int             no_of_bytes; 

    rand  bit [1:0]      testmode_sel;
    rand  bit [1:0]      spimode_sel; 
    rand  bit [1:0]      altf_sel; 
    rand  bit            wait_reset_en;
    rand  bit [1:0]      pclk_sel;              // f(pclk) = 256Khz/(2^pclk_sel)
    rand  bit [2:0]      iclk_sel;              // f(iclk) = 256Khz/(2^iclk_sel)
    rand  bit [7:0]      mclk_sel;              // f(mclk) = 256Khz/(mclk_sel+1)
    rand  bit [15:0]     spi_sclk_freq;         // unit is Khz (1Khz to 16.000Khz)
    rand  bit [6:0]      spi_clk_jitter;        // unut is percentage (0-100)
    rand  bit [6:0]      spi_sclk_jitter;       // unut is percentage (0-100)

    rand  bit		 fault_stuck0_clk_en;	// 1: internal 32KHZ and 300KHZ will be LOW (can used when we set ext_clk_en) 	

    logic [7:0]          clk_data[];

    rand  bit	         ext_clk_en;            // 1: using external clock and 0: using Internal clock
    rand  bit [1:0]      ext_clk_sel;           // 0: 256Khz, 1: 1Mhz; 2: 512Khz; 3: 768Khz

    rand  logic  [6:0]   hfosc_jitter;
    rand  logic  [6:0]   hfosc_variation;

    rand  bit            hfosc_fixed_gnd_en; 
    rand  bit            ext_hfosc_fixed_gnd_en;

    rand  bit [15:0]     tcssc;                 // min is 400ns
    rand  bit [15:0]     tsccs;                 // min is 400ns
    rand  bit [15:0]     tcsh;                  // min is 500ns
    rand  bit [6:0]      tdist;                 // min is 10ns - percentage from 0 -> 100
    rand  bit [6:0]      tch;                   // percentage from 0 -> 100

    rand  bit [15:0]     flash_bist_freq;               // unit is Khz (1Khz to 20.000Khz)
    rand  bit            config_in_base_test_en;        // 0: Enable config clock in base test 1: disable config in base test

    rand  bit [2:0]      wg_drv_sel;		//to select among 8 wavegen drivers
    rand  logic [31:0]   hlf_wave_per;          //half wave period setting of waveform
    rand  bit            dont_check_conf_first_en;

    rand  bit [1:0]      A2D_comp_sel;		//select the A2D_comp for lead_off_detection

    rand logic [1:0]     OTP_SEL = 0;
    rand logic [6:0]     ADDR = 0;

    randc logic [1:0]    TCK_SEL;
    rand logic [4:0]     ctrl_bit;
    rand logic           SRL;
    rand logic [7:0]     data_in;
    rand int             tPGM , tPGM_RC;
    rand int             vpp_pos_cnt, vpp_neg_cnt;
    rand int             vpp_pos_cnt_mult, vpp_neg_cnt_mult;
    rand int             vpp_width, vpp_width_mult;
    rand bit             bist_vpp_pin_en;       //control vpp by bist_vpp_en or timing
    rand bit             disable_init_flash;
    rand bit             imeas_sb_en;
    rand bit             imeas_ppg_en;
    rand bit             imeas_bio_en;
    rand bit             wake_up_en;
    rand bit             imeas_24Hz_in;

    rand bit   [1:0]     zmeas_freq_sel;        // zmeas adc freq sel (2'b00: 1Khz, 2'b01: 2Khz, 2'b10: 4Khz, 2'b11: No readmem)
    rand bit   [2:0]     zmeas_freq_val;        // zmeas dds freq sel  (For mclk 256Khz; 3'b001: 500hz, 3'b010: 1Khz, 3'b011: 2Khz, 3'b100: 4Khz, 3'b000: No freq)
    rand bit   [1:0]     zmeas_dds_wave_sel;    // zmeas dds wave type (2'b00: sine, 2'b01: dc, 2'b10: square, 2'b11: sine)
    rand logic [9:0]     dc_data_val;
    rand logic [9:0]     sq_data_lval;
    rand logic [9:0]     sq_data_hval;
    rand logic [15:0]    sq_wave_div;
    rand logic [3:0]     shr_man_val;
    rand bit             shr_man_en;
    rand bit             flash_check_conf_first_disable;

    rand logic           imeas_sin_gen_en; 
    rand logic [14:0]    imeas_sin_amp;
    rand logic [14:0]    imeas_out_diff_amp;
    rand logic [14:0]    filter_gain;
    rand logic [14:0]    imeas_sin_expected_freq; // Create wavegen with expected freqency
    rand logic [14:0]    imeas_sin_offset;
    rand logic [19:0]    imeas_sampling_rate;
    rand logic [19:0]    imeas_sin_freq;
    rand logic [2:0]     imeas_cic_rate;
    rand logic [1:0]     imeas_input_format;
    rand bit             imeas_rtl_bypass_en;
    rand bit             disable_step_check;
    rand logic [1:0]     filter_gain_mult;
    rand logic [21:0]    gpio_pu_en;      // 21: RESET [20:19]: TESTMODE[1:0], [18:0]: GPI0 
    rand logic [21:0]    gpio_pd_en;      // 21: RESET [20:19]: TESTMODE[1:0], [18:0]: GPI0

    function new (string name = "soc_base_test_cfg");
      super.new(name);
    endfunction: new

    constraint c_gpio_pu_en             { soft gpio_pu_en == 22'b1_00_000_0000_0000_0000_0000; }
    constraint c_gpio_pd_en             { soft gpio_pd_en == 22'b0_11_000_0000_0000_0000_0000; }

    constraint c_disable_step_check     { soft disable_step_check == 1'b0; }
    constraint c_imeas_rtl_bypass_en    { soft imeas_rtl_bypass_en == 1'b0; }
    constraint c_imeas_sin_gen_en       { soft imeas_sin_gen_en == 1'b0; }
    constraint c_imeas_out_diff_amp     { soft imeas_out_diff_amp == 10; }
    constraint c_filter_gain            { soft filter_gain == 1; } // Unit of 1
    constraint c_imeas_sin_expected_freq{ soft imeas_sin_expected_freq inside {[1:1000]}; }
    constraint c_imeas_sin_amp          { soft imeas_sin_amp inside {[1:15'h3FFF]};} 
    constraint c_filter_gain_mult       { (imeas_sin_amp < 15'h1000) -> filter_gain_mult inside {[0:3]};
                                         ((imeas_sin_amp < 15'h2000) && (imeas_sin_amp > 15'h0fff)) -> filter_gain_mult inside {0, 1, 3};
                                         ((imeas_sin_amp < 15'h4000) && (imeas_sin_amp > 15'h1fff)) -> filter_gain_mult inside {0, 3};
                                        }
    constraint c_imeas_sin_offset       { solve filter_gain_mult before imeas_sin_offset; 
                                          solve imeas_sin_amp before imeas_sin_offset; 
                                          imeas_sin_offset > 0; 
                                          ((filter_gain_mult == 0) || (filter_gain_mult == 3)) -> imeas_sin_offset < 16'h7FFF - imeas_sin_amp;
                                          (filter_gain_mult == 1) -> imeas_sin_offset < (16'h7FFF - imeas_sin_amp*2)/2;
                                          (filter_gain_mult == 2) -> imeas_sin_offset < (16'h7FFF - imeas_sin_amp*4)/4;
}
    constraint c_imeas_sampling_rate    { solve imeas_sin_expected_freq before imeas_sampling_rate; imeas_sampling_rate == (1000000/imeas_sin_expected_freq); }
    //constraint c_imeas_sin_freq       { solve imeas_sampling_rate before imeas_sin_freq; imeas_sin_freq < imeas_sampling_rate / 2; }
    constraint c_imeas_sin_freq         { imeas_sin_freq == 1; }
    constraint c_imeas_cic_rate         { soft imeas_cic_rate == 3'b001; }
    constraint c_imeas_input_format     { soft imeas_input_format == 2'b10; }

    constraint c_flash_check_conf_first_disable { soft flash_check_conf_first_disable == 1'b0; }
    constraint c_wake_up_en             { soft wake_up_en == 1'b1; }
    constraint c_disable_init_flash     { soft disable_init_flash == 1'b0; }
    constraint c_imeas_sb_en            { soft imeas_sb_en == 1'b0; }
    constraint c_imeas_ppg_en           { soft imeas_ppg_en == 1'b0; }
    constraint c_imeas_bio_en           { soft imeas_bio_en == 1'b0; }
    constraint c_imeas_24Hz_in          { soft imeas_24Hz_in == 1'b0; }
    constraint c_zmeas_freq_sel         { soft zmeas_freq_sel == 2'b00; }
    constraint c_zmeas_freq_val         { soft zmeas_freq_val == 3'b000; }
    constraint c_zmeas_dds_wave_sel     { soft zmeas_dds_wave_sel == 2'b00; }
    constraint c_dc_data_val            { soft dc_data_val == 10'h100; }
    constraint c_sq_data_lval           { soft sq_data_lval == 10'h0; }
    constraint c_sq_data_hval           { soft sq_data_hval == 10'h100; }
    constraint c_sq_wave_div            { soft sq_wave_div == 16'h000f; }
    constraint c_shr_man_val            { soft shr_man_val == 4'h0; }
    constraint c_shr_man_en             { soft shr_man_en == 1'b0; }

    constraint c_altf_sel               { soft altf_sel inside {[0:0]}; } 
    constraint c_wait_reset_en          { soft wait_reset_en == 1'b1;}
    constraint c_spimode_sel            { soft spimode_sel inside {[0:0]};}        // ; cpol=0 & cpha = 0; cpol=0 & cpha = 1; cpol=1 & cpha = 2; cpol=1 & cpha = 3
    constraint c_testmode_sel           { soft testmode_sel == 2'b00;}

    constraint c_config_in_base_test_en { soft config_in_base_test_en == 1'b1; }

`ifndef MIXSIM
    constraint c_ext_clk_en             { soft ext_clk_en inside {[0:1]};}
`else
    constraint c_ext_clk_en             { soft ext_clk_en == 0;}
`endif
    constraint c_ext_clk_sel            { soft ext_clk_sel == 2'b00; } 

    constraint c_hfosc_jitter           { soft hfosc_jitter inside {[1:5]};}        // 1* - 5%
    constraint c_hfosc_variation        { soft hfosc_variation inside {[90:110]}; } // 90% - 110%

    constraint c_hfosc_fixed_gnd_en     { soft hfosc_fixed_gnd_en == ext_clk_en; }
    constraint c_ext_hfosc_fixed_gnd_en { soft ext_hfosc_fixed_gnd_en == !ext_clk_en; }

    constraint c_spi_sclk_jitter        { soft spi_sclk_jitter inside {[1:5]};}     // 1%-5%

    constraint c_spi_clk_jitter         { soft spi_clk_jitter inside {[1:5]};}

    constraint c_pclk_sel               { soft pclk_sel inside {[0:3]};}
                                        // 0: 256Khz, 1: 128Khz, 2: 64Khz, 3: 32Khz
                                          
    constraint c_iclk_sel               { (pclk_sel == 2'b00) -> iclk_sel inside {[0:7]};
                                          (pclk_sel == 2'b01) -> iclk_sel inside {[1:7]};
                                          (pclk_sel == 2'b10) -> iclk_sel inside {[2:7]};
                                          (pclk_sel == 2'b11) -> iclk_sel inside {[3:7]};}

    constraint c_mclk_sel               { (pclk_sel == 2'b00) -> mclk_sel inside {[0:255]};
                                          (pclk_sel == 2'b01) -> mclk_sel inside {[1:255]};
                                          (pclk_sel == 2'b10) -> mclk_sel inside {[3:255]};
                                          (pclk_sel == 2'b11) -> mclk_sel inside {[7:255]};
                                        }

    constraint c_spi_sclk_freq          { solve pclk_sel before spi_sclk_freq; spi_sclk_freq inside {[/* 256/(2**pclk_sel) */ 10 : 4*256/(2**pclk_sel)]};                                      
                                        }

    constraint c_flash_bist_freq        { soft flash_bist_freq == 10000;} // 10Mhz

    constraint c_tch                    { solve spi_sclk_freq before tch;
                                          tch inside {[40:60]};
                                          tch <= (100 - spi_sclk_freq/500);
                                          tch >= spi_sclk_freq/500; }      // percent : tch >= 400ns, tCL >= 400ns

    constraint c_tcsh                   { solve tch before tcsh; solve spi_sclk_freq before tcsh; tcsh <= 4000; tcsh >= 500;
                                          (tch >= 50) -> tcsh > 100*tch/spi_sclk_freq;
                                          (tch <  50) -> tcsh > 100*(100 - tch)/spi_sclk_freq;
                                        }   // ~tCSPW (Min 400ns)

//    constraint c_tcssc                  { soft tcssc    inside {[400:4000]};}   // ~tCSSO (Min 400ns)
//    constraint c_tsccs                  { soft tsccs    inside {[400:4000]};}   // ~tCSH1 (Min 400ns)
    constraint c_tsccs                  { solve tch before tsccs; solve spi_sclk_freq before tsccs; tsccs <= 4000; tsccs >= 400;
                                          (tch >= 50) -> tsccs > 100*tch/spi_sclk_freq;
                                          (tch <  50) -> tsccs > 100*(100 - tch)/spi_sclk_freq;
                                        }   // ~tCSH1 (Min 400ns)


//    constraint c_tcsh                   { soft tcsh     inside {[500:4000]};}   // ~tCSPW (Min 500ns)
    constraint c_tdist                  { soft tdist    inside {[0:0]};}        // percent : tdist * (Period_SCK/2 - 10):
//    constraint c_tch                    { soft tch      inside {[40:60]};}      // percent : tch = tch * Period_SCK:

    constraint c_fault_stuck0_clk_en    { soft fault_stuck0_clk_en == 1'b0;} // 1: internal 32KHZ and 300KHZ will be LOW (can used when we set ext_clk_en)

    constraint c_wg_drv_sel             { soft wg_drv_sel == 0;}

    constraint c_hlf_wave_per           { soft hlf_wave_per == 0;}

    constraint c_dont_check_conf_first_en { soft dont_check_conf_first_en == 0; }// Using for Flash BIST

    constraint c_A2D_comp_sel           { soft A2D_comp_sel == 0;}

    constraint c_ctrl_bit   { ctrl_bit[0] == SRL;}
    constraint c_OTP_SEL    { OTP_SEL == 0;}

    constraint c_tPGM       {TCK_SEL == 2'b00 -> tPGM == 325;
                             TCK_SEL == 2'b01 -> tPGM == 3250;
                             TCK_SEL == 2'b10 -> tPGM == 6500;
                             TCK_SEL == 2'b11 -> tPGM == 10400;}
    constraint c_tPGM_RC    {TCK_SEL == 2'b00 -> tPGM_RC == 12;
                             TCK_SEL == 2'b01 -> tPGM_RC == 120;
                             TCK_SEL == 2'b10 -> tPGM_RC == 240;
                             TCK_SEL == 2'b11 -> tPGM_RC == 384;}  

    constraint c_vpp_pos_cnt      {vpp_pos_cnt inside {[4:24]};}
    constraint c_vpp_neg_cnt      {vpp_neg_cnt inside {[27+tPGM:42+tPGM]};}
    constraint c_vpp_pos_cnt_mult {vpp_pos_cnt_mult inside {[4:24]};}
    constraint c_vpp_neg_cnt_mult {vpp_neg_cnt_mult inside {[24+(tPGM+3)*128:24+(tPGM+3)*128+18]};}
    constraint c_no_of_bytes      { soft no_of_bytes == 2; }
    constraint c_vpp_width        {vpp_width == (vpp_neg_cnt - vpp_pos_cnt);}
    constraint c_vpp_width_mult   {vpp_width_mult == (vpp_neg_cnt_mult - vpp_pos_cnt_mult);}

endclass : `TESTCFG

class `TESTNAME extends nnc_test;

  `nnc_component_utils(`TESTNAME)

  soc_env                   top_env;
  soc_chip_cfg              top_cfg;
  `TESTCFG                  top_test_cfg;

  nnc_report_server         server;

  function new(string name = "soc_base_test", nnc_component parent=null);
    super.new(name,parent);
  endfunction: new

  extern virtual function void build_phase(nnc_phase phase);
  extern function void end_of_elaboration_phase(nnc_phase phase);
  extern virtual task pre_reset_phase(nnc_phase phase);
  extern virtual task reset_phase(nnc_phase phase);
  extern virtual task pre_main_phase(nnc_phase phase);
  extern virtual task main_phase(nnc_phase phase);
  extern virtual function void report_phase(nnc_phase phase) ;

endclass : `TESTNAME

function void `TESTNAME::build_phase(nnc_phase phase);	
  
  phase.raise_objection(this);

  super.build_phase(phase);

  `nnc_info ("build_phase", "Entered test...", NNC_HIGH)

  `nnc_top.set_timeout(2s);
  
  // nnc top config
  top_cfg = soc_chip_cfg::type_id::create("top_cfg", this);

  top_env = soc_env::type_id::create("top_env", this);

  nnc_config_db#(soc_chip_cfg)::set(this, "top_env", "top_cfg", this.top_cfg);

  top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);

  nnc_config_db#(nnc_object_wrapper)::set(this, "top_env.top_sqr.main_phase", "default_sequence", null);

  `nnc_info ("build_phase", "Exiting...", NNC_HIGH)
  phase.drop_objection(this);

endfunction : build_phase
  
function void `TESTNAME::end_of_elaboration_phase(nnc_phase phase);

  phase.raise_objection(this);
  `nnc_info("end_of_elaboration_phase", "Entered...",NNC_HIGH);

  super.end_of_elaboration_phase(phase);
  `nnc_top.print_topology();

  `nnc_info("end_of_elaboration_phase", "Exiting...",NNC_HIGH)
  phase.drop_objection(this);

endfunction

task `TESTNAME::pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);
  
    super.pre_reset_phase(phase); 
    `SPI_SCB_EN = 1'b1;

    /*
    `DUT_IF.print_msg_disable = 0;

    // Disable scoreboard of eeprom
    `EEPROM_SCOREBOARD_EN = 1'b0;
    */
    // Enable scoreboard of analog
    `ANALOG_SCOREBOARD_EN = 1'b1;
    // Enable checker of ao_top
    `ALWAYSON_CHECK_EN    = 1'b1;
    `FILTER_POINT_TO_POINT_SB_EN = 1'b0;
    `FILTER_PEAK_TO_PEAK_SB_EN = 1'b0;
    `FILTER_OFFSET_SB_EN = 1'b0;

    assert(top_test_cfg.randomize());

    // Enable reset waiting
    `DUT_IF.wait_reset_en = top_test_cfg.wait_reset_en;

    // Set PCLK Clocks
    `DUT_IF.pclk_sel = top_test_cfg.pclk_sel;
    `DUT_IF.iclk_sel = top_test_cfg.iclk_sel;

    // Set SCLK clock
    `DUT_IF.spi_sclk_freq = top_test_cfg.spi_sclk_freq;

    // Set Flash BIST clock
    `DUT_IF.flash_bist_freq = top_test_cfg.flash_bist_freq;

    // Select Polarity of CLK 
    `DUT_IF.spimode_sel = top_test_cfg.spimode_sel;

    // Select Operation mode for SOC 
    `DUT_IF.testmode_sel = top_test_cfg.testmode_sel;

    // Select ALTF mode for SOC PIN Configuration 
    `DUT_IF.altf_sel = top_test_cfg.altf_sel;

    // Set Jitter for PCLK 
    `DUT_IF.spi_clk_jitter = top_test_cfg.spi_clk_jitter;

    // Set Jitter for SCK
    `DUT_IF.spi_sclk_jitter  = top_test_cfg.spi_sclk_jitter;

    // Select internal/external clock sources
    `DUT_IF.ext_clk_en = top_test_cfg.ext_clk_en;			// 1: external EXT_300KHZ and EXT_32KHZ will be driven to SOC from model

    // Select frequency for external clock
    `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel;

    // 256 Khz jitter clock for both internal/external clock
    `DUT_IF.hfosc_jitter = top_test_cfg.hfosc_jitter; 

    `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;

    // enable to fix 1'b0 to internal clk
    `DUT_IF.hfosc_fixed_gnd_en = top_test_cfg.hfosc_fixed_gnd_en;

    // enable to fix 1'b0 to ext clk
    `DUT_IF.ext_hfosc_fixed_gnd_en = top_test_cfg.ext_hfosc_fixed_gnd_en;

    `DUT_IF.fault_stuck0_clk_en = top_test_cfg.fault_stuck0_clk_en;     // 1: internal 32KHZ and 300KHZ will be LOW (can used when we set ext_clk_en)

    `DUT_IF.tcssc    = top_test_cfg.tcssc;
    `DUT_IF.tsccs    = top_test_cfg.tsccs;
    `DUT_IF.tcsh     = top_test_cfg.tcsh;
    `DUT_IF.tdist    = top_test_cfg.tdist;  
    `DUT_IF.tch      = top_test_cfg.tch; 

    `DUT_IF.config_in_base_test_en = top_test_cfg.config_in_base_test_en;

    `DUT_IF.wg_drv_sel = top_test_cfg.wg_drv_sel;

    `DUT_IF.hlf_wave_per = top_test_cfg.hlf_wave_per;

    `DUT_IF.dont_check_conf_first_en = top_test_cfg.dont_check_conf_first_en;

    `DUT_IF.A2D_comp_sel = top_test_cfg.A2D_comp_sel;

    `DUT_IF.altf_gpio_sel = 2'b00;

    `DUT_IF.TCK_SEL = top_test_cfg.TCK_SEL;

    `DUT_IF.bist_vpp_pin_en = top_test_cfg.bist_vpp_pin_en;

    `DUT_IF.disable_init_flash = top_test_cfg.disable_init_flash;

    `DUT_IF.zmeas_freq_sel = top_test_cfg.zmeas_freq_sel;

    `DUT_IF.zmeas_freq_val = top_test_cfg.zmeas_freq_val;

    `DUT_IF.zmeas_dds_wave_sel = top_test_cfg.zmeas_dds_wave_sel;

    `DUT_IF.dc_data_val = top_test_cfg.dc_data_val;

    `DUT_IF.sq_data_lval = top_test_cfg.sq_data_lval;

    `DUT_IF.sq_data_hval = top_test_cfg.sq_data_hval;

    `DUT_IF.sq_wave_div = top_test_cfg.sq_wave_div;

    `DUT_IF.shr_man_val = top_test_cfg.shr_man_val;

    `DUT_IF.shr_man_en = top_test_cfg.shr_man_en;

    `DUT_IF.imeas_sb_en = top_test_cfg.imeas_sb_en;

    `DUT_IF.imeas_ppg_en = top_test_cfg.imeas_ppg_en;

    `DUT_IF.imeas_bio_en = top_test_cfg.imeas_bio_en;

    `DUT_IF.imeas_24Hz_in = top_test_cfg.imeas_24Hz_in;

    `DUT_IF.wake_up_en = top_test_cfg.wake_up_en;

    `DUT_IF.mclk_sel = top_test_cfg.mclk_sel;

    `DUT_IF.flash_check_conf_first_disable = top_test_cfg.flash_check_conf_first_disable;

    `DUT_IF.imeas_sin_gen_en = top_test_cfg.imeas_sin_gen_en;

    `DUT_IF.imeas_sin_amp = top_test_cfg.imeas_sin_amp;

    `DUT_IF.imeas_sin_offset = top_test_cfg.imeas_sin_offset;

    `DUT_IF.imeas_sampling_rate = top_test_cfg.imeas_sampling_rate;

    `DUT_IF.imeas_sin_freq = top_test_cfg.imeas_sin_freq;

    `DUT_IF.imeas_cic_rate = top_test_cfg.imeas_cic_rate;

    `DUT_IF.imeas_input_format = top_test_cfg.imeas_input_format;

    `DUT_IF.imeas_out_diff_amp = top_test_cfg.imeas_out_diff_amp;

    `DUT_IF.filter_gain = top_test_cfg.filter_gain;

    `DUT_IF.imeas_sin_expected_freq = top_test_cfg.imeas_sin_expected_freq; 

    `DUT_IF.imeas_rtl_bypass_en = top_test_cfg.imeas_rtl_bypass_en;

    `DUT_IF.disable_step_check = top_test_cfg.disable_step_check;

    `DUT_IF.filter_gain_mult = top_test_cfg.filter_gain_mult;

    `DUT_IF.gpio_pu_en = top_test_cfg.gpio_pu_en;
    `DUT_IF.gpio_pd_en = top_test_cfg.gpio_pd_en;

    phase.drop_objection(this);
endtask : pre_reset_phase

task `TESTNAME::reset_phase(nnc_phase phase);
    phase.raise_objection(this);
    super.reset_phase(phase);
/*
    if (`DUT_IF.altf_sel !== 2'b00) begin      
       assert(top_test_cfg.randomize() with { testmode_sel == 2'b10; ADDR == 8'h00; data_in == 8'h5A; });
       // Change to Bist mode for SOC
       `DUT_IF.testmode_sel = top_test_cfg.testmode_sel;
        #150us;
        `EPROM_BIST_MASTER_VIP.set_freq_sel(top_test_cfg.TCK_SEL);   //2'b00->1M  ;  2'b01->10M ;  2'b10 -> 20M ;  2'b11 -> 32M
        top_test_cfg.TCK_SEL.rand_mode(0);

       `nnc_info("SOC_TEST", "[EPROM BIST MASTER][0] Sending Reset Command to EPROM", NNC_LOW);
       `EPROM_BIST_MASTER_VIP.reset;
       `nnc_info("SOC_TEST", "[EPROM BIST MASTER] Complete successully this phase", NNC_LOW);

       // Program OTP
       `EPROM_BIST_MASTER_VIP.single_program_eprom(top_test_cfg.ADDR, top_test_cfg.data_in, top_test_cfg.OTP_SEL);
       assert(top_test_cfg.randomize() with { ADDR == 8'h0A; data_in == {6'h0, `DUT_IF.altf_sel}; });
       `EPROM_BIST_MASTER_VIP.single_program_eprom(top_test_cfg.ADDR, top_test_cfg.data_in, top_test_cfg.OTP_SEL);

       `nnc_info("SOC_TEST", "[EPROM BIST MASTER][0] Sending Reset Command to EPROM", NNC_LOW);
       `EPROM_BIST_MASTER_VIP.reset;
       `nnc_info("SOC_TEST", "[EPROM BIST MASTER] Complete successully this phase", NNC_LOW);
       
       assert(top_test_cfg.randomize() with { testmode_sel == 2'b00;} );
       // Change to Normal mode for SOC
       `DUT_IF.testmode_sel = top_test_cfg.testmode_sel;  
     
       `nnc_info("SOC_TEST", "Apply Reset via pin", NNC_LOW)
       `SOC_TB.ext_resetn=1'b0;
       #10us;
       `SOC_TB.ext_resetn=1'b1;
       #100us;      
       //`RD_NORMAL_REG(`SOC_EEPROM_DEBUG_1_REG, 0, top_test_cfg.data[0]);
       //while (top_test_cfg.data[0][5] != 0) `RD_NORMAL_REG(`SOC_EEPROM_DEBUG_1_REG, 0, top_test_cfg.data[0]);
       `DUT_IF.altf_gpio_sel = `DUT_IF.altf_sel;

    end
*/
    if (`DUT_IF.testmode_sel === 2'b00) begin

     // fork
      if (`DUT_IF.wait_reset_en) begin
        `nnc_info("TOP", "Waiting for reset operation completely", NNC_LOW)
         wait(`DUT_IF.soc_resetn); // SOC Reset
        `nnc_info(get_type_name(), "Reset is done", NNC_MEDIUM)
        #1000ns;
      end
 
      if (`DUT_IF.config_in_base_test_en === 1'b1) begin 
        if (`DUT_IF.pclk_sel !== 2'b00  || `DUT_IF.iclk_sel !== 3'b010) begin
          top_test_cfg.no_of_bytes = 8'h0;
          top_test_cfg.data[0] = {2'b0,`DUT_IF.iclk_sel, `DUT_IF.pclk_sel, 1'b0};
          `nnc_info("SOC_TEST", "Single Writing to CLK_CTRL Register", NNC_LOW)
          //`WR_WAVEGEN_REG(top_test_cfg.reg_addr, top_test_cfg.wr_data[0], top_test_cfg.pads);
          `WR_NORMAL_REG(`SOC_CLK_CTRL_REG, top_test_cfg.data[0], 8'h00);
        end
        if (`DUT_IF.mclk_sel !== `SOC_MCLK_DIV_REG_INIT) begin
          top_test_cfg.no_of_bytes = 8'h0;
          top_test_cfg.data[0] = `DUT_IF.mclk_sel;
          `nnc_info("SOC_TEST", "Single Writing to a MCLK_DIV Register", NNC_LOW)
          `WR_NORMAL_REG(`SOC_MCLK_DIV_REG, top_test_cfg.data[0], 8'h00);
        end
      end

    end
    else
      if (`DUT_IF.wait_reset_en) begin
        `nnc_info("TOP", "Waiting for reset operation completely", NNC_LOW)
        wait(`DUT_IF.resetn);// SPIS Reset
        `nnc_info(get_type_name(), "Reset is done", NNC_MEDIUM)
      end
    `DUT_IF.print_msg_disable = 1;

    phase.drop_objection(this);
endtask : reset_phase
/*
task `TESTNAME::post_reset_phase(nnc_phase phase);
    phase.raise_objection(this);
    phase.drop_objection(this);
endtask : post_reset_phase
*/
task `TESTNAME::pre_main_phase(nnc_phase phase);
    phase.raise_objection(this);
    super.pre_main_phase(phase);

    // Disable scoreboard of SPIS
   `ifndef BEHAVIORAL 
  //  `SPIS_SCOREBOARD_EN = 1'b0;
   `endif

    `nnc_info ("pre_main_phase", "Exiting...", NNC_HIGH)
    phase.drop_objection(this);
endtask

task `TESTNAME::main_phase(nnc_phase phase);

  phase.raise_objection(this);
  super.main_phase(phase);
  `nnc_info("main_phase", "Entered...",NNC_HIGH);
/*
  fork
    begin
      #300ms;
      `nnc_info ("main_phase", "timeout...", NNC_LOW)
      $finish;
    end
  join_none
*/
  `nnc_info ("main_phase", "Exiting...", NNC_HIGH)
  phase.drop_objection(this);

endtask

function void `TESTNAME::report_phase(nnc_phase phase);
 
  nnc_report_server report;
 
  phase.raise_objection(this);

  super.report_phase(phase);

  `nnc_info("report_phase", "Entered...", NNC_HIGH)

  report = nnc_report_server::get_server();

  if (top_env.top_sqr.dut_if.err_cnt != 0)
    `nnc_error("TEST", $sformatf("ERROR is happened during the test simulation with no of err_cnt = %d", top_env.top_sqr.dut_if.err_cnt))
    
  if((report.get_severity_count(NNC_ERROR) == 0) && (report.get_severity_count(NNC_FATAL) == 0)) begin
      $display("\n\n");
      $display("\t                    _____________________________________                    ");
      $display("\t                   /                                     \                   ");
      $display("\t ////////////////////.          TEST PASSED            ./////////////////////");
      $display("\t                   \_____________________________________/                   ");
  end
  else begin
      $display("\n");
      $display("\t                          _________________________                          ");
      $display("\t                         X                         X                         ");
      $display("\t///////////////////XXXXXX       TEST FAILED         XXXXXX///////////////////");
      $display("\t                         X_________________________X                         ");
      $display("\n");
  end
      $display("\n");
      $display("                              Summary                                        ");
      $display("-----------------------------------------------------------------------------");
      $display("   NNC_FATAL Count   :  %3d",report.get_severity_count(NNC_FATAL));
      $display("   NNC_ERROR Count   :  %3d",report.get_severity_count(NNC_ERROR));
      $display("   NNC_WARNING Count :  %3d",report.get_severity_count(NNC_WARNING));
      $display("   NNC_INFO  Count   :  %3d",report.get_severity_count(NNC_INFO));
   phase.drop_objection(this);

endfunction
`endif

