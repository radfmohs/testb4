/*--------------------------------------------------------------------------------------
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_env.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: SOC Top Environment                                      
// Designer	: ddang@nanochap.com                                                                 
// Date		: 16-10-2023                                                                    
// Revision	: 0.1                                 
--------------------------------------------------------------------------------------*/
class soc_env extends nnc_env;

    soc_virtual_sequencer      top_sqr;
    nnc_spi_env                spi_env_i;
    soc_chip_cfg               top_cfg;
    soc_fifo_mon               spi_fifo_mon;

`ifdef FLASH_BLOCK_ENABLE
    nnc_flash_env              flash_env;
`else
    nnc_eprom_env              eprom_env;
`endif

    nnc_sysc_environment       sysc_env;

    nnc_imeas_filter_environment   imeas_filter_env;

    nnc_spi_mon_env            spi_mon_env_i;

    nnc_ppg_env                ppg_env;

    nnc_analog_env             ana_env;

    nnc_lead_off_env           lead_off_env;

    virtual  nnc_spi_if        spi_mon_if;                       
    virtual  nnc_reg_interface spi_reg_if;
    virtual  nnc_imeas_filter_mon_interface imeas_filter_mon_if;
    virtual  nnc_lead_off_interface vif;

    
    `nnc_component_utils(soc_env)

    function new(string name, nnc_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(nnc_phase phase);
        `nnc_info(get_name(), "Build phase is starting", UVM_HIGH);
        super.build_phase(phase);
        
        top_cfg = new("top_cfg");
        top_sqr = soc_virtual_sequencer::type_id::create("top_sqr", this);

`ifdef FLASH_BLOCK_ENABLE
        flash_env = nnc_flash_env::type_id::create("flash_env", this);
`else
        eprom_env = nnc_eprom_env::type_id::create("eprom_env", this);
`endif

        ana_env = nnc_analog_env::type_id::create("ana_env",this);          

        spi_env_i = nnc_spi_env::type_id::create("spi_env_i", this);
        sysc_env = nnc_sysc_environment::type_id::create("sysc_env", this);
        imeas_filter_env = nnc_imeas_filter_environment::type_id::create("imeas_filter_env", this);
        spi_mon_env_i = nnc_spi_mon_env::type_id::create("spi_mon_env_i", this);
        spi_fifo_mon = soc_fifo_mon::type_id::create("spi_fifo_mon", this);
        ppg_env = nnc_ppg_env::type_id::create("ppg_env", this);
        lead_off_env = nnc_lead_off_env::type_id::create("lead_off_env", this);

        if (!nnc_config_db#(soc_chip_cfg)::get(this, "", "top_cfg", top_cfg))
          `nnc_fatal("TOP_ENV_BUILD_PHASE", "Can't get top_cfg")
        nnc_config_db#(soc_chip_cfg)::set(this, "*", "top_cfg", top_cfg);

`ifdef FLASH_BLOCK_ENABLE
        nnc_config_db#(nnc_flash_config)::set(this, "flash_env", "flash_cfg", top_cfg.flash_cfg);
`else
        nnc_config_db#(nnc_eprom_config)::set(this, "eprom_env", "eprom_cfg", top_cfg.eprom_cfg);     
`endif

        nnc_config_db#(nnc_analog_config)::set(this, "ana_env.*","ana_cfg", top_cfg.ana_cfg);
        //nnc_config_db#(ao_an_sw_config)::set(this, "ao_an_sw_scoreboard_i","ao_an_sw_cfg", top_cfg.ao_an_sw_cfg);
        nnc_config_db#(nnc_sysc_config)::set(this, "sysc_env.*", "sysc_cfg", top_cfg.sysc_cfg);          
        nnc_config_db#(nnc_imeas_filter_config)::set(this, "*", "imeas_filter_cfg", top_cfg.imeas_filter_cfg);          
        nnc_config_db#(nnc_spi_monitor_config)::set(this, "spi_mon_env_i", "spi_mon_cfg", top_cfg.spi_cfg);
        nnc_config_db#(nnc_ppg_config)::set(this, "ppg_env.*", "cfg", top_cfg.ppg_cfg);
        nnc_config_db#(nnc_lead_off_config)::set(this, "lead_off_env.*", "lead_off_cfg", top_cfg.lead_off_cfg);

        if (!nnc_config_db#(virtual nnc_spi_if)::get(this, "", "spi_mon_if", spi_mon_if))
          `nnc_fatal("ENS3_CHIP_ENV", "Can't get spi_mon_if")
        nnc_config_db#(virtual nnc_spi_if)::set(this, "spi_mon_env_i.*", "spi_mon_if", spi_mon_if);

        if (!nnc_config_db#(virtual nnc_imeas_filter_mon_interface)::get(this, "", "imeas_filter_mon_if", imeas_filter_mon_if))
          `nnc_fatal("BAF4P1_CHIP_ENV", "Can't get imeas_filter_mon_if")
        nnc_config_db#(virtual nnc_imeas_filter_mon_interface)::set(this, "imeas_filter_env.*", "imeas_filter_mon_if", imeas_filter_mon_if);

        if (!nnc_config_db#(virtual nnc_reg_interface)::get(this, "", "spi_reg_if", spi_reg_if))
          `nnc_fatal("ENS3_CHIP_ENV", "Can't get spi_reg_if")
        nnc_config_db#(virtual nnc_reg_interface)::set(this, "spi_mon_env_i.*", "spi_reg_if", spi_reg_if);

        if (!nnc_config_db#(virtual nnc_lead_off_interface)::get(this, "", "vif", vif))
          `nnc_fatal("ENS3_CHIP_ENV", "Can't get vif")
        nnc_config_db#(virtual nnc_lead_off_interface)::set(this, "lead_off_env.*", "vif", vif);

        //if (!nnc_config_db#(virtual spi_master_if)::get(this, "", "m_spiif", m_spiif))
        //  `nnc_fatal("ENS3_CHIP_ENV", "Can't get m_spiif")

        //nnc_config_db#(virtual spi_master_if)::set(this, "spi_mon_env_i", "m_spiif", m_spiif);

        //if (!nnc_config_db#(virtual spi_slave_if)::get(this, "", "s_spiif", s_spiif))
        //  `nnc_fatal("ENS3_CHIP_ENV", "Can't get s_spiif")

        //nnc_config_db#(virtual spi_slave_if)::set(this, "spi_mon_env_i", "s_spiif", s_spiif);

        //if (!nnc_config_db#(virtual spi_AO_if)::get(this, "", "a_spiif", a_spiif))
        //  `nnc_fatal("ENS3_CHIP_ENV", "Can't get a_spiif")

        //nnc_config_db#(virtual spi_AO_if)::set(this, "spi_mon_env_i", "a_spiif", a_spiif);

        //if (!nnc_config_db#(virtual timer_if)::get(this, "", "vif", vif))
        //  `nnc_fatal("ENS3_CHIP_ENV", "Can't get vif")

        //nnc_config_db#(virtual timer_if)::set(this, "timer_env_i", "vif", vif);

    endfunction

    virtual function void connect_phase(nnc_phase phase);
        `nnc_info(get_name(), "Connect phase is starting", UVM_HIGH);
        super.connect_phase(phase);
    endfunction

endclass
