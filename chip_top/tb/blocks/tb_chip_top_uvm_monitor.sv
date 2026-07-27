/*--------------------------------------------------------------------------------------*/
// Copyright 2021 Nanochap, Inc.
// All Rights Reserved Worldwide
// --------------------------------------------------------------------------------------
// Project      : Nanochap BAF4P1
// File         : tb_chip_top_uvm_monitor.sv
// Description  : USEFUL DISPLAY for TOP TB (included file) 
// Designer     : Daniel Dang
// Date         : 22/11/2023
// Revision     : 0.1
/*--------------------------------------------------------------------------------------*/

/*
wire bist_en = (dut_vif.testmode_sel[2:0] === 3'b010);
reg disable_1200ns_after_bist = 1'b0;
always @(posedge bist_en)
  begin
      disable_1200ns_after_bist = 1'b1;
      $display("SOC is entering BIST now and EEPROM_TOP is disabled for 1200ns");
      $disable_warnings(`EEPROM_TOP);
      #1200ns;
      $enable_warnings(`EEPROM_TOP);
      $display("SOC is entering BIST now and EEPROM_TOP is enabled again after 1200ns");
      disable_1200ns_after_bist = 1'b0;
  end

// 
initial
 begin
   if (!`ANA_TOP.VSWLDO1P8) begin
      $disable_warnings(`DIG_TOP.u_clk_ctrl); 
      $disable_warnings(`DIG_TOP.u_eeprom_ctrl_top); 
      $disable_warnings(`DIG_TOP.u_spi_slave_top);
      $disable_warnings(`DIG_TOP.u_pinmux);
      $disable_warnings(`DIG_TOP.u_reset_ctrl);
      $disable_warnings(`DIG_TOP.u_temp_avg);
      $disable_warnings(`DIG_TOP.u_temp_cal_lrm);
      $disable_warnings(`DIG_TOP.u_temp_sensor_filter);
   end
`ifndef MIXSIM
   if (!`CHIP_A_ANA_TOP.VSWLDO1P8) begin
      $disable_warnings(`CHIP_A_DIG_TOP.u_clk_ctrl); 
      $disable_warnings(`CHIP_A_DIG_TOP.u_eeprom_ctrl_top); 
      $disable_warnings(`CHIP_A_DIG_TOP.u_spi_slave_top);
      $disable_warnings(`CHIP_A_DIG_TOP.u_pinmux);
      $disable_warnings(`CHIP_A_DIG_TOP.u_reset_ctrl);
      $disable_warnings(`CHIP_A_DIG_TOP.u_temp_avg);
      $disable_warnings(`CHIP_A_DIG_TOP.u_temp_cal_lrm);
      $disable_warnings(`CHIP_A_DIG_TOP.u_temp_sensor_filter);
   end
   if (!`CHIP_B_ANA_TOP.VSWLDO1P8) begin
      $disable_warnings(`CHIP_B_DIG_TOP.u_clk_ctrl); 
      $disable_warnings(`CHIP_B_DIG_TOP.u_eeprom_ctrl_top); 
      $disable_warnings(`CHIP_B_DIG_TOP.u_spi_slave_top);
      $disable_warnings(`CHIP_B_DIG_TOP.u_pinmux);
      $disable_warnings(`CHIP_B_DIG_TOP.u_reset_ctrl);
      $disable_warnings(`CHIP_B_DIG_TOP.u_temp_avg);
      $disable_warnings(`CHIP_B_DIG_TOP.u_temp_cal_lrm);
      $disable_warnings(`CHIP_B_DIG_TOP.u_temp_sensor_filter);
   end
   if (!`CHIP_C_ANA_TOP.VSWLDO1P8) begin
      $disable_warnings(`CHIP_C_DIG_TOP.u_clk_ctrl); 
      $disable_warnings(`CHIP_C_DIG_TOP.u_eeprom_ctrl_top); 
      $disable_warnings(`CHIP_C_DIG_TOP.u_spi_slave_top);
      $disable_warnings(`CHIP_C_DIG_TOP.u_pinmux);
      $disable_warnings(`CHIP_C_DIG_TOP.u_reset_ctrl);
      $disable_warnings(`CHIP_C_DIG_TOP.u_temp_avg);
      $disable_warnings(`CHIP_C_DIG_TOP.u_temp_cal_lrm);
      $disable_warnings(`CHIP_C_DIG_TOP.u_temp_sensor_filter);
    end
`endif
  end
// =================================
// Detect LowPower during Simulation
// =================================
always @(negedge `ANA_TOP.VSWLDO1P8)
  begin
     if (dut_vif.testmode_sel === 3'b000) begin
      $display("===========================================================================================");
      $display("===== SOC is entering to LOWPOWER mode now and disable timing check for SW blocks");
      $display("===========================================================================================");
      $disable_warnings(`DIG_TOP.u_clk_ctrl); 
      $disable_warnings(`DIG_TOP.u_eeprom_ctrl_top); 
      $disable_warnings(`DIG_TOP.u_spi_slave_top);
      $disable_warnings(`DIG_TOP.u_pinmux);
      $disable_warnings(`DIG_TOP.u_reset_ctrl);
      $disable_warnings(`DIG_TOP.u_temp_avg);
      $disable_warnings(`DIG_TOP.u_temp_cal_lrm);
      $disable_warnings(`DIG_TOP.u_temp_sensor_filter);
     end
  end

`ifndef MIXSIM
always @(negedge `CHIP_A_ANA_TOP.VSWLDO1P8)
  begin
     if (dut_vif.testmode_sel === 3'b000) begin
      $display("===========================================================================================");
      $display("===== CHIP_A is entering to LOWPOWER mode now and disable timing check for SW blocks");
      $display("===========================================================================================");
      $disable_warnings(`CHIP_A_DIG_TOP.u_clk_ctrl); 
      $disable_warnings(`CHIP_A_DIG_TOP.u_eeprom_ctrl_top); 
      $disable_warnings(`CHIP_A_DIG_TOP.u_spi_slave_top);
      $disable_warnings(`CHIP_A_DIG_TOP.u_pinmux);
      $disable_warnings(`CHIP_A_DIG_TOP.u_reset_ctrl);
      $disable_warnings(`CHIP_A_DIG_TOP.u_temp_avg);
      $disable_warnings(`CHIP_A_DIG_TOP.u_temp_cal_lrm);
      $disable_warnings(`CHIP_A_DIG_TOP.u_temp_sensor_filter);
     end
  end

always @(negedge `CHIP_B_ANA_TOP.VSWLDO1P8)
  begin
     if (dut_vif.testmode_sel === 3'b000) begin
      $display("===========================================================================================");
      $display("===== CHIP_B is entering to LOWPOWER mode now and disable timing check for SW blocks");
      $display("===========================================================================================");
      $disable_warnings(`CHIP_B_DIG_TOP.u_clk_ctrl); 
      $disable_warnings(`CHIP_B_DIG_TOP.u_eeprom_ctrl_top); 
      $disable_warnings(`CHIP_B_DIG_TOP.u_spi_slave_top);
      $disable_warnings(`CHIP_B_DIG_TOP.u_pinmux);
      $disable_warnings(`CHIP_B_DIG_TOP.u_reset_ctrl);
      $disable_warnings(`CHIP_B_DIG_TOP.u_temp_avg);
      $disable_warnings(`CHIP_B_DIG_TOP.u_temp_cal_lrm);
      $disable_warnings(`CHIP_B_DIG_TOP.u_temp_sensor_filter);
     end
  end

always @(negedge `CHIP_C_ANA_TOP.VSWLDO1P8)
  begin
     if (dut_vif.testmode_sel === 3'b000) begin
      $display("===========================================================================================");
      $display("===== CHIP_C is entering to LOWPOWER mode now and disable timing check for SW blocks");
      $display("===========================================================================================");
      $disable_warnings(`CHIP_C_DIG_TOP.u_clk_ctrl); 
      $disable_warnings(`CHIP_C_DIG_TOP.u_eeprom_ctrl_top); 
      $disable_warnings(`CHIP_C_DIG_TOP.u_spi_slave_top);
      $disable_warnings(`CHIP_C_DIG_TOP.u_pinmux);
      $disable_warnings(`CHIP_C_DIG_TOP.u_reset_ctrl);
      $disable_warnings(`CHIP_C_DIG_TOP.u_temp_avg);
      $disable_warnings(`CHIP_C_DIG_TOP.u_temp_cal_lrm);
      $disable_warnings(`CHIP_C_DIG_TOP.u_temp_sensor_filter);
     end
  end

`endif

always @(posedge `ANA_TOP.VSWLDO1P8)
  begin
     if (dut_vif.testmode_sel === 3'b000) begin
      $display("===========================================================================================");
      $display("===== SOC is entering to WAKEUP (Active) mode now and enable timing check for SW blocks");
      $display("===========================================================================================");
      $enable_warnings(`DIG_TOP.u_clk_ctrl); 
      $enable_warnings(`DIG_TOP.u_eeprom_ctrl_top); 
      $enable_warnings(`DIG_TOP.u_spi_slave_top);
      $enable_warnings(`DIG_TOP.u_pinmux);
      $enable_warnings(`DIG_TOP.u_reset_ctrl);
      $enable_warnings(`DIG_TOP.u_temp_avg);
      $enable_warnings(`DIG_TOP.u_temp_cal_lrm);
      $enable_warnings(`DIG_TOP.u_temp_sensor_filter);
     end
  end

`ifndef MIXSIM
always @(posedge `CHIP_A_ANA_TOP.VSWLDO1P8)
  begin
     if (dut_vif.testmode_sel === 3'b000) begin
      $display("=============================================================================================");
      $display("===== CHIP_A is entering to WAKEUP (Active) mode now and enable timing check for SW blocks");
      $display("=============================================================================================");
      $enable_warnings(`CHIP_A_DIG_TOP.u_clk_ctrl); 
      $enable_warnings(`CHIP_A_DIG_TOP.u_eeprom_ctrl_top); 
      $enable_warnings(`CHIP_A_DIG_TOP.u_spi_slave_top);
      $enable_warnings(`CHIP_A_DIG_TOP.u_pinmux);
      $enable_warnings(`CHIP_A_DIG_TOP.u_reset_ctrl);
      $enable_warnings(`CHIP_A_DIG_TOP.u_temp_avg);
      $enable_warnings(`CHIP_A_DIG_TOP.u_temp_cal_lrm);
      $enable_warnings(`CHIP_A_DIG_TOP.u_temp_sensor_filter);
     end
  end

always @(posedge `CHIP_B_ANA_TOP.VSWLDO1P8)
  begin
     if (dut_vif.testmode_sel === 3'b000) begin
      $display("=============================================================================================");
      $display("===== CHIP_B is entering to WAKEUP (Active) mode now and enable timing check for SW blocks");
      $display("=============================================================================================");
      $enable_warnings(`CHIP_B_DIG_TOP.u_clk_ctrl); 
      $enable_warnings(`CHIP_B_DIG_TOP.u_eeprom_ctrl_top); 
      $enable_warnings(`CHIP_B_DIG_TOP.u_spi_slave_top);
      $enable_warnings(`CHIP_B_DIG_TOP.u_pinmux);
      $enable_warnings(`CHIP_B_DIG_TOP.u_reset_ctrl);
      $enable_warnings(`CHIP_B_DIG_TOP.u_temp_avg);
      $enable_warnings(`CHIP_B_DIG_TOP.u_temp_cal_lrm);
      $enable_warnings(`CHIP_B_DIG_TOP.u_temp_sensor_filter);
     end
  end

always @(posedge `CHIP_C_ANA_TOP.VSWLDO1P8)
  begin
     if (dut_vif.testmode_sel === 3'b000) begin
      $display("=============================================================================================");
      $display("===== CHIP_C is entering to WAKEUP (Active) mode now and enable timing check for SW blocks");
      $display("=============================================================================================");
      $enable_warnings(`CHIP_C_DIG_TOP.u_clk_ctrl); 
      $enable_warnings(`CHIP_C_DIG_TOP.u_eeprom_ctrl_top); 
      $enable_warnings(`CHIP_C_DIG_TOP.u_spi_slave_top);
      $enable_warnings(`CHIP_C_DIG_TOP.u_pinmux);
      $enable_warnings(`CHIP_C_DIG_TOP.u_reset_ctrl);
      $enable_warnings(`CHIP_C_DIG_TOP.u_temp_avg);
      $enable_warnings(`CHIP_C_DIG_TOP.u_temp_cal_lrm);
      $enable_warnings(`CHIP_C_DIG_TOP.u_temp_sensor_filter);
     end
  end
`endif
*/
real tDR_period;
real tCLK_period;

initial begin
#1;
      $display("#################################################################################");
      $display("## --------------------------------------------------------------------------- ##"); 
      $display("##           WELCOME TO BAF4P1 PROJECT - NANOCHAP ELECTRONICS CORP               ##");
      $display("## --------------------------------------------------------------------------- ##");
      $display("##         THIS IS CONFIGURATION OF CURRENT HARWARE IN SIMULATION              ##");      
      $display("## --------------------------------------------------------------------------- ##");    
      $display("## PLEASE DON'T FORGET TO DELETE OLD & UNUSED FILES IN THE SCRATCH DIRECTORY   ##");      
      $display("## --------------------------------------------------------------------------- ##");  
`ifdef POSTLAYOUT_PG
   `ifdef SDFANNOTATE_MAX
      $display("##          WE ARE RUNNING POSTLAYOUT_PG SDF_MAX SIMULATION MODE               ##");
   `elsif SDFANNOTATE_MIN
      $display("##          WE ARE RUNNING POSTLAYOUT_PG SDF_MIN SIMULATION MODE               ##");
   `elsif SDFANNOTATE_TYP
      $display("##          WE ARE RUNNING POSTLAYOUT_PG SDF_TYP SIMULATION MODE               ##");
   `else
      $display("##          WE ARE RUNNING POSTLAYOUT_PG NO SDF SIMULATION MODE                ##"); 
   `endif
`elsif POSTLAYOUT
      $display("##                WE ARE RUNNING POSTLAYOUT SIMULATION MODE                    ##");
`elsif POSTSCAN_PG
   `ifdef SDFANNOTATE_MAX
      $display("##           WE ARE RUNNING POSTSCAN_PG SDF_MAX SIMULATION MODE                ##");
   `elsif SDFANNOTATE_MIN
      $display("##           WE ARE RUNNING POSTSCAN_PG SDF_MIN SIMULATION MODE                ##");
   `elsif SDFANNOTATE_TYP
      $display("##           WE ARE RUNNING POSTSCAN_PG SDF_TYP SIMULATION MODE                ##");
   `else 
      $display("##           WE ARE RUNNING POSTSCAN_PG NO SDF SIMULATION MODE                 ##"); 
   `endif     
`elsif POSTSCAN
      $display("##                 WE ARE RUNNING POSTSCAN SIMULATION MODE                     ##");
`elsif PRESCAN
      $display("##                WE ARE RUNNING PRESCAN SIMULATION MODE                       ##");
`else
      $display("##                 WE ARE RUNNING RTL SIMULATION MODE                          ##");
`endif  
      $display("## --------------------------------------------------------------------------- ##");
      $display("##             ENJOY YOUR WORK AND HAVE A NICE WORKRING DAY                    ##");      
      $display("## --------------------------------------------------------------------------- ##");             
      $display("#################################################################################");
      $display("");
end

// ================================
// This part is for Clock display
// Print at the initial of setting
always @(dut_vif.ext_clk_en or dut_vif.ext_clk_sel or dut_vif.spimode_sel or dut_vif.spi_clk_jitter or dut_vif.spi_sclk_jitter or dut_vif.spi_sclk_freq or dut_vif.tdist or dut_vif.tcssc or dut_vif.tsccs or dut_vif.tcsh or dut_vif.pclk_sel or dut_vif.iclk_sel or dut_vif.mclk_sel)
  begin
   #2;
   //wait(!dut_vif.resetn);
        $display("=============================================================================");
      if(dut_vif.ext_clk_en === 1'b1) begin
        $display("== SOC EXT_CLK_EN: %d CONFIGURED to RUN ON EXTERNAL SYSTEM CLOCK", dut_vif.ext_clk_en);
        case (dut_vif.ext_clk_sel) 
          0: $display("== External Clock is running: 256Khz");
          1: $display("== External Clock is running: 1Mhz");
          2: $display("== External Clock is running: 512Khz");
          3: $display("== External Clock is running: 768Khz");
          default: `nnc_error("Clock Monitor", $sformatf("Configuration from TESTCASE for EXT_CLK_SEL=%h", dut_vif.ext_clk_sel))
        endcase
      end else
        $display("== EXT_CLK_EN: %d CONFIGURED to run on INTERNAL SYSTEM CLOCK with HFOSC=256Khz", dut_vif.ext_clk_en);

      if (dut_vif.pclk_sel === 3'h0) 
         $display("== PCLK Clock Configuration: 256Khz - Jitter: %d percent", dut_vif.spi_clk_jitter);
      else if (dut_vif.pclk_sel === 3'h1)
         $display("== PCLK Clock Configuration: 128Khz - Jitter: %d percent", dut_vif.spi_clk_jitter);
      else if (dut_vif.pclk_sel === 3'h2)
         $display("== PCLK Clock Configuration: 64Khz - Jitter: %d percent", dut_vif.spi_clk_jitter);
      else if (dut_vif.pclk_sel === 3'h3)
         $display("== PCLK Clock Configuration: 32Khz - Jitter: %d percent", dut_vif.spi_clk_jitter);
      else if (dut_vif.pclk_sel === 3'h4)
         $display("== PCLK Clock Configuration: 16Khz - Jitter: %d percent", dut_vif.spi_clk_jitter);
      else if (dut_vif.pclk_sel === 3'h5)
         $display("== PCLK Clock Configuration: 8Khz - Jitter: %d percent", dut_vif.spi_clk_jitter);
      else if (dut_vif.pclk_sel === 3'h6)
         $display("== PCLK Clock Configuration: 4Khz - Jitter: %d percent", dut_vif.spi_clk_jitter);
      else if (dut_vif.pclk_sel === 3'h7)
         $display("== PCLK Clock Configuration: 2Khz - Jitter: %d percent", dut_vif.spi_clk_jitter);
      else
        `nnc_error("PCLK Monitor", $sformatf("Configuration from TESTCASE for PCLK=%h", dut_vif.pclk_sel))

      if (dut_vif.iclk_sel === 3'h0) 
         $display("== ADC CLK Clock Configuration: 128Khz");
      else if (dut_vif.iclk_sel === 3'h1)
         $display("== ADC CLK Clock Configuration: 64Khz");
      else if (dut_vif.iclk_sel === 3'h2)
         $display("== ADC CLK Clock Configuration: 32Khz");
      else if (dut_vif.iclk_sel === 3'h3)
         $display("== ADC_CLK Clock Configuration: 16Khz");
      else if (dut_vif.iclk_sel === 3'h4)
         $display("== ADC_CLK Clock Configuration: 8Khz");
      else if (dut_vif.iclk_sel === 3'h5)
         $display("== ADC_CLK Clock Configuration: 4Khz");
      else if (dut_vif.iclk_sel === 3'h6)
         $display("== ADC_CLK Clock Configuration: 2Khz");
      else if (dut_vif.iclk_sel === 3'h7)
         $display("== ADC_CLK Clock Configuration: 1Khz");
      else
        `nnc_error("ADC_CLK Monitor", $sformatf("Configuration from TESTCASE for ADC_CLK=%h", dut_vif.iclk_sel))

      if ((dut_vif.mclk_sel !== 8'hzz) || (dut_vif.mclk_sel !== 8'hxx))
        $display("== MCLK Clock Configuration: %d KHz", 256/(1 + dut_vif.mclk_sel));   
      else
        `nnc_error("MCLK_CLK Monitor", $sformatf("Configuration from TESTCASE for MCLK=%h", dut_vif.mclk_sel))

      $display("------------------------------------------------------------------------------");
      $display("== SPI SCLK Clock Configuration CPOL: %d CPHA: %d", dut_vif.spimode_sel[1], dut_vif.spimode_sel[0]);
      $display("== SPI SCLK Clock Configuration: %dKhz - Jitter: %d percent", dut_vif.spi_sclk_freq, dut_vif.spi_sclk_jitter);
      $display("== SPI Timming Configuration: tcssc: %d ns", dut_vif.tcssc);
      $display("== SPI Timming Configuration: tsccs: %d ns", dut_vif.tsccs);
      $display("== SPI Timming Configuration: tcsh: %d ns", dut_vif.tcsh);
      $display("== SPI Timming Configuration: tdist: %d ns and percent: %d", (10**6)/(2*dut_vif.spi_sclk_freq) - (((10**6)/(2*dut_vif.spi_sclk_freq) - 10)*(dut_vif.tdist)/100), dut_vif.tdist);
      $display("------------------------------------------------------------------------------");
      $display("== FLASH BIST Clock Configuration: TCK = 1Mhz");
      $display("== SOC RUNS ON FLASH CONTROLLER IN ATM MODE : 1Mhz");
      $display("=============================================================================");
  end

// ================================
// This part is for BAF4P1 Mode
// Print when it is changed during the tests
always @(* /*dut_vif.testmode_sel or dut_vif.iopad_gpio[9:6] or posedge dut_vif.soc_resetn*/)
  begin
    case (`SOC_TB.TESTMODE)
      2'b00: begin
        $display("=============================================================================");
        $display("===== SOC IS RUNNING IN NORMAL MODE");
        $display("=============================================================================");
      end
      2'b01: begin
        $display("=============================================================================");
        $display("===== SOC IS RUNNING IN SCAN MODE");
        $display("=============================================================================");
      end
      2'b10: begin
        $display("=============================================================================");
        $display("===== SOC IS RUNNING IN FLASH BIST MODE");
        $display("=============================================================================");
      end
      2'b11: begin
        case(`SOC_TB.IOBUF_PAD[9:6])
          4'b0001: begin
             $display("=============================================================================");
             $display("===== SOC IS RUNNING IN ATM0 MODE");
             $display("=============================================================================");
          end
          4'b0010: begin
             $display("=============================================================================");
             $display("===== SOC IS RUNNING IN ATM1 MODE");
             $display("=============================================================================");
          end
          4'b0011: begin
             $display("=============================================================================");
             $display("===== SOC IS RUNNING IN ATM2 MODE");
             $display("=============================================================================");
          end
          4'b0100: begin
             $display("=============================================================================");
             $display("===== SOC IS RUNNING IN ATM3 MODE");
             $display("=============================================================================");
          end
          4'b0101: begin
             $display("=============================================================================");
             $display("===== SOC IS RUNNING IN ATM4 MODE");
             $display("=============================================================================");
          end
          4'b0110: begin
             $display("=============================================================================");
             $display("===== SOC IS RUNNING IN ATM5 MODE");
             $display("=============================================================================");
          end
          4'b0111: begin
             $display("=============================================================================");
             $display("===== SOC IS RUNNING IN ATM6 MODE");
             $display("=============================================================================");
          end
          4'b1000: begin
             $display("=============================================================================");
             $display("===== SOC IS RUNNING IN ATM7 MODE");
             $display("=============================================================================");
          end
          4'b1001: begin
             $display("=============================================================================");
             $display($time,"===== SOC IS RUNNING IN ATM8 MODE");
             $display("=============================================================================");
          end
          4'b1010: begin
             $display("=============================================================================");
             $display($time,"===== SOC IS RUNNING IN ATM9 MODE");
             $display("=============================================================================");
          end
          4'b1011: begin
             $display("=============================================================================");
             $display($time,"===== SOC IS RUNNING IN ATM10 MODE");
             $display("=============================================================================");
          end
          4'b1100: begin
             $display("=============================================================================");
             $display($time,"===== SOC IS RUNNING IN ATM11 MODE");
             $display("=============================================================================");
          end
          4'b1101: begin
             $display("=============================================================================");
             $display($time,"===== SOC IS RUNNING IN ATM12 MODE");
             $display("=============================================================================");
          end
          default: begin
            `nnc_error("SOC Configuration", $sformatf("Error in configuration of dut_vif.iopad_gpio[9:6]: %h", `SOC_TB.IOBUF_PAD[9:6]))
          end
        endcase 
      end
    endcase
  end
