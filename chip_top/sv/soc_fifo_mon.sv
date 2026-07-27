/*--------------------------------------------------------------------------------------
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_fifo_mon.sv                                                   
// Project	: Nanochap BAF4P1                                  		        
// Description	:                                     
// Designer	: shreeyal@nanochap.com                                                                 
// Date		: 04-06-2024                                                                    
// Revision	: 0.1                                 
--------------------------------------------------------------------------------------*/
`ifndef SOC_FIFO_MON__SV
`define SOC_FIFO_MON__SV

class soc_fifo_mon extends nnc_monitor;
    
  `nnc_component_utils(soc_fifo_mon)
  soc_chip_cfg               top_cfg;
  virtual  nnc_spi_if        spi_mon_if;                       
  //virtual  nnc_reg_interface spi_reg_if;
  virtual dut_interface           dut_if;
  logic [19:0] removed_elements;

  function new(string name="soc_fifo_mon", nnc_component parent);
      super.new(name, parent);
  endfunction

  virtual function void build_phase(nnc_phase phase);
    `nnc_info(get_name(), "Build phase is starting", UVM_HIGH);
    super.build_phase(phase);
    
    top_cfg = new("top_cfg");

    if (!nnc_config_db#(soc_chip_cfg)::get(this, "", "top_cfg", top_cfg))
      `nnc_fatal(get_full_name(), "Can't get top_cfg")
    nnc_config_db#(soc_chip_cfg)::set(this, "*", "top_cfg", top_cfg);

    if (!nnc_config_db#(virtual nnc_spi_if)::get(this, "", "spi_mon_if", spi_mon_if))
      `nnc_fatal(get_full_name(), "Can't get spi_mon_if")
    nnc_config_db#(virtual nnc_spi_if)::set(this, "spi_mon_env_i.*", "spi_mon_if", spi_mon_if);

    //if (!nnc_config_db#(virtual nnc_reg_interface)::get(this, "", "spi_reg_if", spi_reg_if))
    //  `nnc_fatal(get_full_name(), "Can't get spi_reg_if")
    //nnc_config_db#(virtual nnc_reg_interface)::set(this, "spi_mon_env_i.*", "spi_reg_if", spi_reg_if);

    if (!nnc_config_db#(virtual dut_interface)::get(null, "", "dut_if", dut_if))
    `nnc_fatal(get_full_name(), "Please set interface")

  endfunction

  virtual task main_phase(nnc_phase phase);
    super.main_phase(phase);
    phase.raise_objection(this);

    if(top_cfg.soc_fifo_monitor_en) begin
      fork
        begin
          sample_imeas2fifo_data();
	end
        begin
	  if(top_cfg.soc_fifo_compare_en) begin
            compare_imeas2fifo_spi2fifo_data();
	  end
	end
      join_none
    end
    `nnc_info("get_full_name()", "main_phase done", UVM_LOW)

    phase.drop_objection(this);
  endtask: main_phase

  virtual task sample_imeas2fifo_data();
    forever begin
      @(posedge dut_if.sys_clk);
      if(!dut_if.soc_resetn) begin
        top_cfg.imeas2fifo_mem_cnt = 0;
        top_cfg.imeas2fifo_lost_item = 0;
        top_cfg.imeas2fifo_data_mem.delete();
        `nnc_info("get_full_name()", "Reset is asserted", UVM_MEDIUM)
      end
      else begin
        // Recording all elements written from IMEAS to FIFO
        if (!dut_if.imeas_chdata_en_n) begin
          top_cfg.imeas2fifo_data_mem.push_back({dut_if.fifo_config_a[1], dut_if.fifo_full,dut_if.imeas_chdata});
          top_cfg.imeas2fifo_mem_cnt++; 
          //`nnc_info("get_full_name()", "imeas2fifo_mem_cnt is incrementing", UVM_LOW)
          //$display("imeas2fifo_mem_cnt = %d",top_cfg.imeas2fifo_mem_cnt);

          if (dut_if.fifo_full) begin 
            top_cfg.imeas2fifo_lost_item++;
	    `nnc_info(get_full_name(), $sformatf("imeas2fifo_lost_item : %d ", top_cfg.imeas2fifo_lost_item), UVM_DEBUG);
          end

	  if(top_cfg.imeas2fifo_lost_item > 0 && top_cfg.soc_fifo_min_freq_case == 1)begin
            repeat(top_cfg.imeas2fifo_lost_item)begin
              removed_elements = top_cfg.imeas2fifo_data_mem.pop_back();
	      top_cfg.imeas2fifo_mem_cnt--; 
	      `nnc_info(get_full_name(), $sformatf("imeas2fifo_lost_item : %d so removing those many entries from fifo removed_elements = %0h", top_cfg.imeas2fifo_lost_item, removed_elements), UVM_DEBUG);
            end
            top_cfg.imeas2fifo_lost_item = 0;
          end
        end
      end
    end

  endtask : sample_imeas2fifo_data

  virtual task compare_imeas2fifo_spi2fifo_data();
    logic [19:0] rd_data_imeas2fifo;
    bit [6:0] rptr_temp;

    forever begin
      @(spi_mon_if.rptr); 
      //@(posedge dut_if.sys_clk);
      rptr_temp = spi_mon_if.rptr+127;
      //if(top_cfg.soc_imeas2fifo_spi2fifo_data_check_en) begin
      //  @(spi_mon_if.rptr); 
        //top_cfg.rd_data_fifo = new[top_cfg.no_of_elements_to_match];

        //foreach(top_cfg.rd_data_fifo[i])begin
	//  top_cfg.rd_data_fifo[i] = spi_mon_if.fifo_data[i][15:0];
        //end
        //for (int i = 0; i < top_cfg.no_of_elements_to_match; i++) begin
       // for (int i = 0; i < spi_mon_if.rptr-1; i++) begin
          // Extract from FIFO
          
          rd_data_imeas2fifo = top_cfg.imeas2fifo_data_mem.pop_front();            

          if(spi_mon_if.tag_en===1)begin // tag enable case
            if (spi_mon_if.fifo_data[rptr_temp][17:0] !== rd_data_imeas2fifo[17:0]) begin    
	      `nnc_error(get_full_name(), $sformatf("READ DATA from FIFO Element-%d: %h is NOT EQUAL to THE VALUE from IMEAS to FIFO: %h", rptr_temp, spi_mon_if.fifo_data[rptr_temp][17:0],rd_data_imeas2fifo[17:0]));
            end
            else `nnc_info(get_full_name(), $sformatf("READ DATA from FIFO Element-%d: %h is EQUAL to THE VALUE from IMEAS to FIFO: %h", rptr_temp, spi_mon_if.fifo_data[rptr_temp][17:0],rd_data_imeas2fifo[17:0]), UVM_DEBUG);
          end
          else begin // tag disable case
            if (spi_mon_if.fifo_data[rptr_temp][15:0] !== rd_data_imeas2fifo[15:0]) begin    
	      `nnc_error(get_full_name(), $sformatf("READ DATA from FIFO Element-%d: %h is NOT EQUAL to THE VALUE from IMEAS to FIFO: %h", rptr_temp, spi_mon_if.fifo_data[rptr_temp][15:0],rd_data_imeas2fifo[15:0]));
            end
            else `nnc_info(get_full_name(), $sformatf("READ DATA from FIFO Element-%d: %h is EQUAL to THE VALUE from IMEAS to FIFO: %h", rptr_temp, spi_mon_if.fifo_data[rptr_temp][15:0],rd_data_imeas2fifo[15:0]), UVM_DEBUG);

          end
        //end
	//top_cfg.soc_imeas2fifo_spi2fifo_data_check_en=0;
	//`nnc_info(get_name(), " making soc_imeas2fifo_spi2fifo_data_check_en=0", UVM_LOW)
      //end
    end

  endtask : compare_imeas2fifo_spi2fifo_data
endclass
`endif

