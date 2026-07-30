/*--------------------------------------------------------------------------------------
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_chip_cfg.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: SOC Top Config                                    
// Designer	: ddang@nanochap.com                                                                 
// Date		: 16-10-2023                                                                    
// Revision	: 0.1                                 
--------------------------------------------------------------------------------------*/
`ifndef SOC_CONFIGURATION__SV
`define SOC_CONFIGURATION__SV
class soc_chip_cfg extends nnc_object;
  
  nnc_analog_config               ana_cfg;
  //ao_an_sw_config                 ao_an_sw_cfg;
  //soc_ao_sysc_config		  ao_sysc_cfg;
  nnc_spi_monitor_config          spi_cfg;
  nnc_sysc_config                 sysc_cfg;
  virtual dut_interface           dut_if;
  nnc_ppg_config                  ppg_cfg;
  nnc_lead_off_config             lead_off_cfg;
  nnc_imeas_filter_config         imeas_filter_cfg;


  logic [19:0] imeas2fifo_data_mem [$];
  integer imeas2fifo_mem_cnt;
  integer imeas2fifo_lost_item;
  logic [17:0] rd_data_fifo_reg;
  logic [17:0] spi_fifo_rd_data;
  logic [15:0] rd_data_fifo[];
  int no_of_elements_to_match;


  bit soc_fifo_monitor_en;
  bit soc_fifo_compare_en;
  bit soc_imeas2fifo_spi2fifo_data_check_en;
  bit soc_fifo_min_freq_case;


`ifdef FLASH_BLOCK_ENABLE
  nnc_flash_config                flash_cfg;
`else
  nnc_eprom_config                     eprom_cfg;
`endif

  `nnc_object_utils_begin(soc_chip_cfg)
    //`nnc_field_object(ao_sysc_cfg, UVM_ALL_ON | UVM_DEEP)
  `nnc_object_utils_end

  extern function new (string name = "soc_chip_cfg");

endclass

function soc_chip_cfg::new( string name = "soc_chip_cfg");
  super.new(name);
  //ao_an_sw_cfg = new();
  ana_cfg = new("ana_cfg");
  //ao_sysc_cfg = new();
  spi_cfg = new("spi_cfg");

`ifdef FLASH_BLOCK_ENABLE
  flash_cfg = new("flash_cfg");
`else
  eprom_cfg = new("eprom_cfg");
`endif

  sysc_cfg = new("sysc_cfg");
  ppg_cfg = new("ppg_cfg");
  lead_off_cfg = new("lead_off_cfg");
  imeas_filter_cfg = new("imeas_filter_cfg");
  
  if (!nnc_config_db#(virtual dut_interface)::get(null, "", "dut_if", dut_if))
    `nnc_fatal(get_full_name(), "Please set interface")

  imeas2fifo_mem_cnt = 0;
  imeas2fifo_lost_item = 0;
  soc_fifo_compare_en = 1;
  soc_fifo_min_freq_case = 0;
endfunction: new
`endif
