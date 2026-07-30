/*--------------------------------------------------------------------------------------
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_top_pkg.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: SOC Top Package                                        
// Designer	: ddang@nanochap.com                                                                 
// Date		: 10-04-2023                                                                    
// Revision	: 0.1                                 
--------------------------------------------------------------------------------------*/
`ifndef soc_top_pkg__SV
`define soc_top_pkg__SV
`include "soc_dut_interface.sv"
package soc_top_pkg;

 import nnc_uvm_pkg::*;
 import nnc_spi_pkg::*;
 import nnc_sysc_pkg::*;
 import nnc_imeas_filter_pkg::*;
`ifdef FLASH_BLOCK_ENABLE
 import nnc_flash_pkg::*;
`else
 import nnc_eprom_pkg::*; 
`endif
 import nnc_spi_mon_pkg::*;
 import nnc_ppg_pkg::*;
 import nnc_analog_pkg::*;
 import nnc_lead_off_pkg::*;

 `include "nnc_uvm_methodology.svh"
//  import timer_pkg::*;
//  import ao_sysc_pkg::*;  
//  import soc_analog_pkg::*;
//  import ao_an_sw_pkg::*;
 `include "soc_chip_cfg.sv"
 `include "soc_fifo_mon.sv"

 `include "soc_virtual_sequencer.sv"
  //`include "soc_chip_base_sequence.sv"
  `include "soc_scoreboard.sv"
  `include "soc_env.sv"

endpackage: soc_top_pkg
`endif
