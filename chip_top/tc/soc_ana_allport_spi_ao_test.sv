/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_ana_allport_spi_ao_test.sv                                                   
// Project	: Nanochap  BAF4P1                                  		        
// Description	: Testcase soc_ana_allport_spi_ao_test                                             
// Designer	: zhenghong.yu@nanochap.com(zion)                                                                
// Date		: 29-11-1623                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_ana_allport_spi_ao_test
`define TESTCFG soc_ana_allport_spi_ao_test_cfg

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // -----------------------------------------------
  // Adding your new varialbles in config test
  // -----------------------------------------------
  logic [11:0]  atm;
 
  // -----------------------------------------------
  // End of decalration of new variables 
  // -----------------------------------------------

  function new (string name = "soc_ana_allport_spi_ao_test_cfg");
    super.new(name);
    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // testmode_sel[1:0] : 00-Normal mode, 01: Scanmode, 10: BIST mode, 11 atm0/1/2/3/4
  constraint c_testmode_sel { soft testmode_sel == 2'b00; }

  // -----------------------------------------------
  // End of adding constraints of randomization
  // -----------------------------------------------

endclass : `TESTCFG

class `TESTNAME extends soc_base_test;
  static bit rand_bit;   
  static logic [20:0] rand_num;   
  `nnc_component_utils(`TESTNAME)

  `TESTCFG top_test_cfg;
  
  function new(string name, nnc_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(nnc_phase phase);
    super.build_phase(phase);
    uvm_top.set_timeout(2s);
    top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);
  endfunction

  virtual task pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);

    super.pre_reset_phase(phase);

    assert(top_test_cfg.randomize());

    `DUT_IF.testmode_sel = top_test_cfg.testmode_sel;

    `SPI_SCB_EN = 1'b0;
    `ANALOG_SCOREBOARD_EN = 1'b0;

    // ==================
    // Scoreboard enables
    // ==================

    phase.drop_objection(this);
  endtask : pre_reset_phase

  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_ana_allport_spi_ao_test start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 
    // This is sample to write a data to Register
`ifdef BEHAVIORAL
    force `ALWAYSON_SHADOW_REGS.spi_write_rising_edge = 1'b1;
`endif
    do_run; 
    
    //#100000;
    //do_run1; 

            
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

  virtual task do_run;
    begin
//`ifndef POSTSCAN  
    // Checking pin bg1p2_buf_en 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_BG1P2_BUF_EN= $random;
        #10000;
        rand_bit = `SPI_TOP.o_BG1P2_BUF_EN;
        if (`ALWAYSON_TOP.bg1p2_buf_en !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("bg1p2_buf_en - `ALWAYSON_TOP.bg1p2_buf_en = %b is not as expectation SPI %b", `ALWAYSON_TOP.bg1p2_buf_en , `SPI_TOP.o_BG1P2_BUF_EN));
        end
        release `SPI_TOP.o_BG1P2_BUF_EN;
        #10000;
    end

    // Checking pin o_RLD_AMP_EN
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_RLD_AMP_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_RLD_AMP_EN;
        if (`ALWAYSON_TOP.rld_amp_en !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_RLD_EN - `ALWAYSON_TOP.D2A_RLD_EN = %b is not as expectation SPI %b", `ALWAYSON_TOP.rld_amp_en , `SPI_TOP.o_RLD_AMP_EN));
        end
        release `SPI_TOP.o_RLD_AMP_EN;
        #10000;
    end

    // Checking pin o_ECG_DDA_GSEL 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_ECG_DDA_GSEL = $random;
        #10000;
        rand_num[2:0] = `SPI_TOP.o_ECG_DDA_GSEL;
        if (`ALWAYSON_TOP.ecg_dda_gsel !== rand_num[2:0]) begin
            `nnc_error("ANALOG",$sformatf("D2A_ECG_DDA_GSEL - `ALWAYSON_TOP.ecg_dda_gsel = %b is not as expectation SPI %b", `ALWAYSON_TOP.ecg_dda_gsel , `SPI_TOP.o_ECG_DDA_GSEL));
        end
        release `SPI_TOP.o_ECG_DDA_GSEL;
        #10000;
    end

    // Checking pin D2A_ECG_PGA_GSEL 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_ECG_PGA_GSEL = $random;
        #10000;
        rand_num[2:0] = `SPI_TOP.o_ECG_PGA_GSEL;
        if (`ALWAYSON_TOP.ecg_pga_gsel !== rand_num[2:0]) begin
            `nnc_error("ANALOG",$sformatf("D2A_ECG_PGA_GSEL - `ALWAYSON_TOP.ecg_pga_gsel = %b is not as expectation SPI %b", `ALWAYSON_TOP.ecg_pga_gsel , `SPI_TOP.o_ECG_PGA_GSEL));
        end
        release `SPI_TOP.o_ECG_PGA_GSEL;
        #10000;
    end

    // Checking pin D2A_ECG_LPF_EN 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_ECG_LPF_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_ECG_LPF_EN;
        if (`ALWAYSON_TOP.ecg_lpf_en !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_ECG_LPF_EN - `ALWAYSON_TOP.ecg_lpf_en = %b is not as expectation SPI %b", `ALWAYSON_TOP.ecg_lpf_en , `SPI_TOP.o_ECG_LPF_EN));
        end
        release `SPI_TOP.o_ECG_LPF_EN;
        #10000;
    end

    // Checking pin D2A_ECG_PGA_EN 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_ECG_PGA_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_ECG_PGA_EN;
        if (`ALWAYSON_TOP.ecg_pga_en !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_ECG_PGA_EN - `ALWAYSON_TOP.ecg_pga_en = %b is not as expectation SPI %b", `ALWAYSON_TOP.ecg_pga_en , `SPI_TOP.o_ECG_PGA_EN));
        end
        release `SPI_TOP.o_ECG_PGA_EN;
        #10000;
    end

    // Checking pin D2A_ECG_DDA_ISEL 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_ECG_DDA_ISEL = $random;
        #10000;
        rand_num[1:0] = `SPI_TOP.o_ECG_DDA_ISEL;
        if (`ALWAYSON_TOP.ecg_dda_isel !== rand_num[1:0]) begin
            `nnc_error("ANALOG",$sformatf("D2A_ECG_DDA_ISEL - `ALWAYSON_TOP.ecg_dda_isel = %b is not as expectation SPI %b", `ALWAYSON_TOP.ecg_dda_isel , `SPI_TOP.o_ECG_DDA_ISEL));
        end
        release `SPI_TOP.o_ECG_DDA_ISEL;
        #10000;
    end

    // Checking pin D2A_ECG_DDACHOP_EN 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_ECG_DDACHOP_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_ECG_DDACHOP_EN;
        if (`ALWAYSON_TOP.ecg_ddachop_en !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_ECG_DDACHOP_EN - `ALWAYSON_TOP.ecg_ddachop_en = %b is not as expectation SPI %b", `ALWAYSON_TOP.ecg_ddachop_en , `SPI_TOP.o_ECG_DDACHOP_EN));
        end
        release `SPI_TOP.o_ECG_DDACHOP_EN;
        #10000;
    end

    // Checking pin D2A_ECG_DDA_EN 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_ECG_DDA_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_ECG_DDA_EN;
        if (`ALWAYSON_TOP.ecg_dda_en !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_ECG_DDA_EN - `ALWAYSON_TOP.ecg_dda_en = %b is not as expectation SPI %b", `ALWAYSON_TOP.ecg_dda_en , `SPI_TOP.o_ECG_DDA_EN));
        end
        release `SPI_TOP.o_ECG_DDA_EN;
        #10000;
    end

    // Checking pin D2A_ECG_DDA_CLKSEL 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_ECG_DDA_CLKSEL = $random;
        #10000;
        rand_num[1:0] = `SPI_TOP.o_ECG_DDA_CLKSEL;
        if (`ALWAYSON_TOP.ecg_dda_clksel !== rand_num[1:0]) begin
            `nnc_error("ANALOG",$sformatf("D2A_ECG_DDA_CLKSEL - `ALWAYSON_TOP.ecg_dda_clksel = %b is not as expectation SPI %b", `ALWAYSON_TOP.ecg_dda_clksel , `SPI_TOP.o_ECG_DDA_CLKSEL));
        end
        release `SPI_TOP.o_ECG_DDA_CLKSEL;
        #10000;
    end

    // Checking pin D2A_DCLEADOFF_VINFLIP 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_DC_LEAD_OFF_VIN_FLIP = $random;
        #10000;
        rand_bit = `SPI_TOP.o_DC_LEAD_OFF_VIN_FLIP;
        if (`ALWAYSON_TOP.dc_lead_off_vin_flip !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_DCLEADOFF_VINFLIP - `ALWAYSON_TOP.dc_lead_off_vin_flip = %b is not as expectation SPI %b", `ALWAYSON_TOP.dc_lead_off_vin_flip , `SPI_TOP.o_DC_LEAD_OFF_VIN_FLIP));
        end
        release `SPI_TOP.o_DC_LEAD_OFF_VIN_FLIP;
        #10000;
    end

    // Checking pin D2A_DCLEADOFF_RMODE_EN 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_DC_LEAD_OFF_RMODE_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_DC_LEAD_OFF_RMODE_EN;
        if (`ALWAYSON_TOP.dc_lead_off_rmode_en !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_DCLEADOFF_RMODE_EN - `ALWAYSON_TOP.dc_lead_off_rmode_en = %b is not as expectation SPI %b", `ALWAYSON_TOP.dc_lead_off_rmode_en , `SPI_TOP.o_DC_LEAD_OFF_RMODE_EN));
        end
        release `SPI_TOP.o_DC_LEAD_OFF_RMODE_EN;
        #10000;
    end

    // Checking pin D2A_BIST_EN 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_BIST_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_BIST_EN;
        if (`ALWAYSON_TOP.bist_en !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_BIST_EN - `ALWAYSON_TOP.bist_en = %b is not as expectation SPI %b", `ALWAYSON_TOP.bist_en , `SPI_TOP.o_BIST_EN));
        end
        release `SPI_TOP.o_BIST_EN;
        #10000;
    end

    // Checking pin D2A_BIST_ISEL 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_BIST_ISEL = $random;
        #10000;
        rand_num[2:0] = `SPI_TOP.o_BIST_ISEL;
        if (`ALWAYSON_TOP.bist_isel !== rand_num[2:0]) begin
            `nnc_error("ANALOG",$sformatf("D2A_BIST_ISEL - `ALWAYSON_TOP.bist_isel = %b is not as expectation SPI %b", `ALWAYSON_TOP.bist_isel , `SPI_TOP.o_BIST_ISEL));
        end
        release `SPI_TOP.o_BIST_ISEL;
        #10000;
    end
//`endif
        
    // Checking pin D2A_TSC_INA_GSEL 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_TSC_INA_GEL = $random;
        #10000;
        rand_num[2:0] = `SPI_TOP.o_TSC_INA_GEL;
        if (`ANA_TOP.D2A_TSC_INA_GSEL !== rand_num[2:0]) begin
            `nnc_error("ANALOG",$sformatf("D2A_TSC_INA_GSEL - `ANA_TOP.D2A_TSC_INA_GSEL = %b is not as expectation SPI %b", `ANA_TOP.D2A_TSC_INA_GSEL , `SPI_TOP.o_TSC_INA_GEL));
        end
        release `SPI_TOP.o_TSC_INA_GEL;
        #10000;
    end

    // Checking pin D2A_TSC_EN 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_TSC_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_TSC_EN;
        if (`ANA_TOP.D2A_TSC_EN !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_TSC_EN - `ANA_TOP.D2A_TSC_EN = %b is not as expectation SPI %b", `ANA_TOP.D2A_TSC_EN , `SPI_TOP.o_TSC_EN));
        end
        release `SPI_TOP.o_TSC_EN;
        #10000;
    end
        
    // Checking pin D2A_TSC_BJT_SEL 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_TSC_BJT_SEL = $random;
        #10000;
        rand_num[2:0] = `SPI_TOP.o_TSC_BJT_SEL;
        if (`ANA_TOP.D2A_TSC_BJT_SEL !== rand_num[2:0]) begin
            `nnc_error("ANALOG",$sformatf("D2A_TSC_BJT_SEL - `ANA_TOP.D2A_TSC_BJT_SEL = %b is not as expectation SPI %b", `ANA_TOP.D2A_TSC_BJT_SEL , `SPI_TOP.o_TSC_BJT_SEL));
        end
        release `SPI_TOP.o_TSC_BJT_SEL;
        #10000;
    end

    // Checking pin D2A_TSC_OUT_SEL 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_TSC_OUT_SEL = $random;
        #10000;
        rand_bit = `SPI_TOP.o_TSC_OUT_SEL;
        if (`ANA_TOP.D2A_TSC_OUT_SEL !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_TSC_OUT_SEL - `ANA_TOP.D2A_TSC_OUT_SEL = %b is not as expectation SPI %b", `ANA_TOP.D2A_TSC_OUT_SEL , `SPI_TOP.o_TSC_OUT_SEL));
        end
        release `SPI_TOP.o_TSC_OUT_SEL;
        #10000;
    end
         
    // Checking pin D2A_PPGDAC0_VSEL 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_PPG_DAC0_VSEL = $random;
        #10000;
        rand_num[11:0] = `SPI_TOP.o_PPG_DAC0_VSEL;
        if (`ANA_TOP.D2A_PPGDAC0_VSEL !== rand_num[11:0]) begin
            `nnc_error("ANALOG",$sformatf("D2A_PPGDAC0_VSEL - `ANA_TOP.D2A_PPGDAC0_VSEL = %b is not as expectation SPI %b", `ANA_TOP.D2A_PPGDAC0_VSEL , `SPI_TOP.o_PPG_DAC0_VSEL));
        end
        release `SPI_TOP.o_PPG_DAC0_VSEL;
        #10000;
    end
         
    // Checking pin D2A_PPG_TEST_IN 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_PPG_TEST_IN = $random;
        #10000;
        rand_num[11:0] = `SPI_TOP.o_PPG_TEST_IN;
        if (`ANA_TOP.D2A_PPG_TEST_IN !== rand_num[11:0]) begin
            `nnc_error("ANALOG",$sformatf("D2A_PPG_TEST_IN - `ANA_TOP.D2A_PPG_TEST_IN = %b is not as expectation SPI %b", `ANA_TOP.D2A_PPG_TEST_IN , `SPI_TOP.o_PPG_TEST_IN));
        end
        release `SPI_TOP.o_PPG_TEST_IN;
        #10000;
    end
         
    // Checking pin D2A_PPGDAC1_VSEL 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_PPG_DAC1_VSEL = $random;
        #10000;
        rand_num[11:0] = `SPI_TOP.o_PPG_DAC1_VSEL;
        if (`ANA_TOP.D2A_PPGDAC1_VSEL !== rand_num[11:0]) begin
            `nnc_error("ANALOG",$sformatf("D2A_PPGDAC1_VSEL - `ANA_TOP.D2A_PPGDAC1_VSEL = %b is not as expectation SPI %b", `ANA_TOP.D2A_PPGDAC1_VSEL , `SPI_TOP.o_PPG_DAC1_VSEL));
        end
        release `SPI_TOP.o_PPG_DAC1_VSEL;
        #10000;
    end
         
    // Checking pin D2A_PPG_TEST_OUT 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_PPG_TEST_OUT = $random;
        #10000;
        rand_num[11:0] = `SPI_TOP.o_PPG_TEST_OUT;
        if (`ANA_TOP.D2A_PPG_TEST_OUT !== rand_num[11:0]) begin
            `nnc_error("ANALOG",$sformatf("D2A_o_PPG_TEST_OUT - `ANA_TOP.D2A_PPG_TEST_OUT = %b is not as expectation SPI %b", `ANA_TOP.D2A_PPG_TEST_OUT , `SPI_TOP.o_PPG_TEST_OUT));
        end
        release `SPI_TOP.o_PPG_TEST_OUT;
    end

    // Checking pin D2A_PPG_SH_CK 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_PPG_SH_CK = $random;
        #10000;
        rand_bit = `SPI_TOP.o_PPG_SH_CK;
        if (`ANA_TOP.D2A_PPG_SH_CK !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_PPG_SH_CK - `ANA_TOP.D2A_PPG_SH_CK = %b is not as expectation SPI %b", `ANA_TOP.D2A_PPG_SH_CK , `SPI_TOP.o_PPG_SH_CK));
        end
        release `SPI_TOP.o_PPG_SH_CK;
        #10000;
    end

    // Checking pin D2A_PPGDAC0_EN 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_PPG_DAC0_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_PPG_DAC0_EN;
        if (`ANA_TOP.D2A_PPGDAC0_EN !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_PPGDAC0_EN - `ANA_TOP.D2A_PPGDAC0_EN = %b is not as expectation SPI %b", `ANA_TOP.D2A_PPGDAC0_EN , `SPI_TOP.o_PPG_DAC0_EN));
        end
        release `SPI_TOP.o_PPG_DAC0_EN;
        #10000;
    end

    // Checking pin D2A_PPGDAC1_EN 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_PPG_DAC1_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_PPG_DAC1_EN;
        if (`ANA_TOP.D2A_PPGDAC1_EN !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_PPGDAC1_EN - `ANA_TOP.D2A_PPGDAC1_EN = %b is not as expectation SPI %b", `ANA_TOP.D2A_PPGDAC1_EN , `SPI_TOP.o_PPG_DAC1_EN));
        end
        release `SPI_TOP.o_PPG_DAC1_EN;
        #10000;
    end

    // Checking pin D2A_EN_PPG_SH 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_PPG_SH_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_PPG_SH_EN;
        if (`ANA_TOP.D2A_EN_PPG_SH !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_EN_PPG_SH - `ANA_TOP.D2A_EN_PPG_SH = %b is not as expectation SPI %b", `ANA_TOP.D2A_EN_PPG_SH , `SPI_TOP.o_PPG_SH_EN));
        end
        release `SPI_TOP.o_PPG_SH_EN;
        #10000;
    end

    // Checking pin D2A_EN_PPG_BUFFER 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_PPG_BUFFER_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_PPG_BUFFER_EN;
        if (`ANA_TOP.D2A_EN_PPG_BUFFER !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_EN_PPG_BUFFER - `ANA_TOP.D2A_EN_PPG_BUFFER = %b is not as expectation SPI %b", `ANA_TOP.D2A_EN_PPG_BUFFER , `SPI_TOP.o_PPG_BUFFER_EN));
        end
        release `SPI_TOP.o_PPG_BUFFER_EN;
        #10000;
    end

    // Checking pin D2A_EN_PPG_AF 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_PPG_AF_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_PPG_AF_EN;
        if (`ANA_TOP.D2A_EN_PPG_AF !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_EN_PPG_AF - `ANA_TOP.D2A_EN_PPG_AF = %b is not as expectation SPI %b", `ANA_TOP.D2A_EN_PPG_AF , `SPI_TOP.o_PPG_AF_EN));
        end
        release `SPI_TOP.o_PPG_AF_EN;
        #10000;
    end

    // Checking pin D2A_EN_PPGDAC_BUFFER 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_PPG_DAC_BUFFER_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_PPG_DAC_BUFFER_EN;
        if (`ANA_TOP.D2A_EN_PPGDAC_BUFFER !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_EN_PPGDAC_BUFFER - `ANA_TOP.D2A_EN_PPGDAC_BUFFER = %b is not as expectation SPI %b", `ANA_TOP.D2A_EN_PPGDAC_BUFFER , `SPI_TOP.o_PPG_DAC_BUFFER_EN));
        end
        release `SPI_TOP.o_PPG_DAC_BUFFER_EN;
        #10000;
    end
         
    // Checking pin D2A_SDM_BIAS 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_SDM_BIAS = $random;
        #10000;
        rand_num[11:0] = `SPI_TOP.o_SDM_BIAS;
        if (`ANA_TOP.D2A_SDM_BIAS !== rand_num[11:0]) begin
            `nnc_error("ANALOG",$sformatf("D2A_o_SDM_BIAS - `ANA_TOP.D2A_SDM_BIAS = %b is not as expectation SPI %b", `ANA_TOP.D2A_SDM_BIAS , `SPI_TOP.o_SDM_BIAS));
        end
        release `SPI_TOP.o_SDM_BIAS;
    end
         
    // Checking pin D2A_EN_TIA 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_PPG_TIA_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_PPG_TIA_EN;
        if (`ANA_TOP.D2A_EN_TIA !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_o_PPG_TIA_EN - `ANA_TOP.D2A_EN_TIA = %b is not as expectation SPI %b", `ANA_TOP.D2A_EN_TIA , `SPI_TOP.o_PPG_TIA_EN));
        end
        release `SPI_TOP.o_PPG_TIA_EN;
    end
         
    // Checking pin D2A_EN_TIA_VREFBUFFER 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_PPG_TIA_VREF_BUFFER_EN = $random;
        #10000;
        rand_bit = `SPI_TOP.o_PPG_TIA_VREF_BUFFER_EN;
        if (`ANA_TOP.D2A_EN_TIA_VREFBUFFER !== rand_bit) begin
            `nnc_error("ANALOG",$sformatf("D2A_o_PPG_TIA_VREF_BUFFER_EN - `ANA_TOP.D2A_EN_TIA_VREFBUFFER = %b is not as expectation SPI %b", `ANA_TOP.D2A_EN_TIA_VREFBUFFER , `SPI_TOP.o_PPG_TIA_VREF_BUFFER_EN));
        end
        release `SPI_TOP.o_PPG_TIA_VREF_BUFFER_EN;
    end
         
    // Checking pin D2A_TIA_IDAC 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_PPG_TIA_IDAC = $random;
        #10000;
        rand_num[7:0] = `SPI_TOP.o_PPG_TIA_IDAC;
        if (`ANA_TOP.D2A_TIA_IDAC !== rand_num[7:0]) begin
            `nnc_error("ANALOG",$sformatf("D2A_o_PPG_TIA_IDAC - `ANA_TOP.D2A_TIA_IDAC = %b is not as expectation SPI %b", `ANA_TOP.D2A_TIA_IDAC , `SPI_TOP.o_PPG_TIA_IDAC));
        end
        release `SPI_TOP.o_PPG_TIA_IDAC;
    end

    // Checking pin D2A_TIA_GAIN 
    for (int i=0; i < 100; i++) begin
        force  `SPI_TOP.o_PPG_TIA_GAIN = $random;
        #10000;
        rand_num[3:0] = `SPI_TOP.o_PPG_TIA_GAIN;
        if (`ANA_TOP.D2A_TIA_GAIN !== rand_num[3:0]) begin
            `nnc_error("ANALOG",$sformatf("D2A_o_PPG_TIA_GAIN - `ANA_TOP.D2A_TIA_GAIN = %b is not as expectation SPI %b", `ANA_TOP.D2A_TIA_GAIN , `SPI_TOP.o_PPG_TIA_GAIN));
        end
        release `SPI_TOP.o_PPG_TIA_GAIN;
    end
    end
  endtask  


  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME    
