/*--------------------------------------------------------------------------------------
// Copyright 1616 Nanochap, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_imeas_bio_electricity_filter_test.sv                                                   
// Project	: Nanochap BAF4P1                                  		        
// Description	: Testcase soc_imeas_bio_electricity_filter_test                                             
// Designer	: ophina@nanochap.com                                                                 
// Date		: 06-06-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
--------------------------------------------------------------------------------------*/
`define TESTNAME soc_imeas_bio_electricity_filter_test
`define TESTCFG soc_imeas_bio_electricity_filter_test_cfg

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // -----------------------------------------------
  // Adding your new varialbles in config test
  // -----------------------------------------------
  rand logic [2:0] cic_rate;
  rand logic [1:0] imeas_input_format;
  rand logic [1:0] ch_mode;
  rand logic       format_sel;
  rand logic [3:0] ch_num;
  rand logic       int_en;
  rand logic       restart_en;
  rand logic       bio_int_en;
  rand logic       ppg_mode;
  rand logic [15:0] checkclk_div_reg;
       logic [7:0] int_sts;
  //------------------------------------------------------------------------------
  //---------------------------- SPI ---------------------------------------------
  rand logic [7:0] mask;
  rand logic [7:0] pads;
  rand logic [7:0] no_of_bytes;
  rand logic [7:0] wr_data[256];
  rand logic [7:0] rd_data;
  rand logic [7:0] rd_data_reg[];

  //------------------------------------------------------------------------------
  // -----------------------------------------------
  // End of decalration of new variables 
  // -----------------------------------------------

  function new (string name = "soc_imeas_bio_electricity_filter_test_cfg");
    super.new(name);    
  endfunction: new

  // -----------------------------------------------
  // Adding constraints of randomization
  // -----------------------------------------------
  // top_test_cfg.top_test_cfg.pads values
  constraint c_pads           { soft pads == 8'h00; }
  // top_test_cfg.top_test_cfg.mask values
  constraint c_mask           { soft mask == 8'hFF; }
  // top_test_cfg.top_test_cfg.pclk_sel values
  constraint c_pclk_sel       { soft pclk_sel == 0; }
  // top_test_cfg.top_test_cfg.iclk_sel values
  constraint c_iclk_sel       { soft iclk_sel == 0; }
  // top_test_cfg.top_test_cfg.ch_mode values
  constraint c_ch_mode        { soft ch_mode == `IMEAS_CHA_MODE_SINGLE; }//single channel mode
  // top_test_cfg.top_test_cfg.ch_num values
  constraint c_ch_num         { soft ch_num inside {[0:0]}; }
  // top_test_cfg.top_test_cfg.imeas_input_format values
  constraint c_imeas_input_format { soft imeas_input_format != 0; }
  // top_test_cfg.top_test_cfg.format_sel values
  constraint c_format_sel     { soft format_sel == `IMEAS_CHA_FORMAT_SIGNED; }
  // top_test_cfg.top_test_cfg.int_en values
  constraint c_int_en         { soft int_en == 1'b0; }//eoc interrupt disabled
  // top_test_cfg.top_test_cfg.bio_int_en values
  constraint c_bio_int_en     { soft bio_int_en == 1'b1; }//bio interrupt enabled
  // top_test_cfg.top_test_cfg.restart_en values
  constraint c_restart_en     { soft restart_en == 1'b0; }//restart disabled
  // top_test_cfg.top_test_cfg.ppg_mode values
  constraint c_ppg_mode       { soft ppg_mode == 1'b0; }//ppg mode disabled
  // top_test_cfg.top_test_cfg.cic_rate values
  constraint c_cic_rate       { soft cic_rate inside {[2:5]}; }//supports 128 OSR (Fs=1000Hz), 256 OSR (Fs=500Hz), 512 OSR (Fs=250Hz) and 1024 OSR (Fs=125Hz)
  // top_test_cfg.top_test_cfg.checkclk_div_reg values
  constraint c_checkclk_reg   { checkclk_div_reg inside {49,61,124,249,499,999}; }
  // top_test_cfg.top_test_cfg.imeas_sin_gen_en values
  constraint c_imeas_sin_gen_en       { soft imeas_sin_gen_en == 1'b1; }
  constraint c_imeas_24Hz_in          { soft imeas_24Hz_in == 1'b0; }
  //constraint c_imeas_sin_amp          { soft imeas_sin_amp == 15'h7FFF; }
  //constraint c_imeas_sin_offset       { imeas_sin_offset == 0;}
  //constraint c_imeas_sin_expected_freq{ imeas_sin_expected_freq inside {[48:52], [1:1000]};}
  constraint c_hfosc_jitter           { soft hfosc_jitter inside {[0:0]};}        // 1* - 5%
  constraint c_hfosc_variation        { soft hfosc_variation inside {[100:100]}; } // 90% - 110%
  constraint c_disable_init_flash     { soft disable_init_flash == 1'b1; }
  //constraint c_disable_step_check     { soft disable_step_check == 1'b0; }
  // -----------------------------------------------
  // End of adding constraints of randomization
  // -----------------------------------------------  
endclass : `TESTCFG

class `TESTNAME extends soc_base_test;

  `nnc_component_utils(`TESTNAME)

  `TESTCFG top_test_cfg;
   
  function new(string name, nnc_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(nnc_phase phase);
    super.build_phase(phase);
    uvm_top.set_timeout(10s);
    top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);
  endfunction

  virtual task pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);

    super.pre_reset_phase(phase);

    assert(top_test_cfg.randomize() with { imeas_sin_expected_freq inside {[48:52], [1:1000]}; imeas_sin_expected_freq < 256000/(5 * 2**(iclk_sel+1+cic_rate+5)); });

    `DUT_IF.pclk_sel = top_test_cfg.pclk_sel;

    `DUT_IF.iclk_sel = top_test_cfg.iclk_sel;

    `DUT_IF.mclk_sel = top_test_cfg.mclk_sel;

    `DUT_IF.spi_sclk_freq = top_test_cfg.spi_sclk_freq;

    `DUT_IF.imeas_cic_rate = top_test_cfg.cic_rate;

    `DUT_IF.imeas_input_format = top_test_cfg.imeas_input_format;

    `DUT_IF.imeas_sin_gen_en = top_test_cfg.imeas_sin_gen_en;

    //`DUT_IF.imeas_sin_amp = top_test_cfg.imeas_sin_amp;

    //`DUT_IF.imeas_sin_offset = top_test_cfg.imeas_sin_offset;

    `DUT_IF.imeas_sin_expected_freq = top_test_cfg.imeas_sin_expected_freq;

    `DUT_IF.imeas_sampling_rate = top_test_cfg.imeas_sampling_rate;

    `DUT_IF.imeas_sin_freq = top_test_cfg.imeas_sin_freq;

    `DUT_IF.imeas_24Hz_in = top_test_cfg.imeas_24Hz_in;
    // 256 Khz jitter clock for both internal/external clock
    `DUT_IF.hfosc_jitter = top_test_cfg.hfosc_jitter;

    `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;

    `DUT_IF.disable_init_flash = top_test_cfg.disable_init_flash;

    // ==================
    // Scoreboard enables
    // ==================
    `SPI_SCB_EN = 1'b0;
    `DUT_IF.imeas_sb_en = 1'b1;
    `DUT_IF.imeas_bio_en = 1'b1;

    `nnc_info("SOC_TEST", "Enable SB from test ", UVM_LOW)
    en_dis_scoreboard(1);

    phase.drop_objection(this);
  endtask : pre_reset_phase

  virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);

    `nnc_info("SOC_TEST", "soc_imeas_bio_electricity_filter_test start", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // Please add your code of your test here
    // ----------------------------------------------------------------------------------  
    `nnc_info("SOC_TEST",$sformatf("Simulation Begin!!!"),UVM_LOW);
    `nnc_info("SOC_TEST",$sformatf("Imeas single channel bio-electricity flow test"),UVM_LOW);
    do_run;
    
    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ----------------------------------------------------------------------------------
    phase.drop_objection(this);
  endtask: main_phase

  virtual task do_run;
    begin

      force `SOC_TB.u_imeas_ch0_refmodel.ADCDec.decIA.Din = `ANA_TOP.A2D_SDM_OUT;//only ch0 considered in this test

      if(256000/(2**(`DUT_IF.iclk_sel+1+`DUT_IF.imeas_cic_rate+5))===125) begin
	 `nnc_info("SOC_TEST", "Sample Rate is selected FS=125Hz!", UVM_LOW)
         prog_coeff(
           `SCALECONST1_FS125, 
           `COEF_B1_SESSION1_FS125, 
           `COEF_B2_SESSION1_FS125, 
           `COEF_B3_SESSION1_FS125, 
           `COEF_A2_SESSION1_FS125, 
           `COEF_A3_SESSION1_FS125, 
           `SCALECONST2_FS125, 
           `COEF_B1_SESSION2_FS125, 
           `COEF_B2_SESSION2_FS125, 
           `COEF_B3_SESSION2_FS125, 
           `COEF_A2_SESSION2_FS125, 
           `COEF_A3_SESSION2_FS125
         );
	 `nnc_info("SOC_TEST", "Sample Rate FS=125Hz is configured successfully!", UVM_LOW)
      end else if(256000/(2**(`DUT_IF.iclk_sel+1+`DUT_IF.imeas_cic_rate+5))===250) begin
	`nnc_info("SOC_TEST", "Sample Rate is selected FS=250Hz!", UVM_LOW)
         prog_coeff(
           `SCALECONST1_FS250, 
           `COEF_B1_SESSION1_FS250, 
           `COEF_B2_SESSION1_FS250, 
           `COEF_B3_SESSION1_FS250, 
           `COEF_A2_SESSION1_FS250, 
           `COEF_A3_SESSION1_FS250, 
           `SCALECONST2_FS250, 
           `COEF_B1_SESSION2_FS250, 
           `COEF_B2_SESSION2_FS250, 
           `COEF_B3_SESSION2_FS250, 
           `COEF_A2_SESSION2_FS250, 
           `COEF_A3_SESSION2_FS250
         );
	 `nnc_info("SOC_TEST", "Sample Rate FS=250Hz is configured successfully!", UVM_LOW)
      end else if(256000/(2**(`DUT_IF.iclk_sel+1+`DUT_IF.imeas_cic_rate+5))===1000) begin
	`nnc_info("SOC_TEST", "Sample Rate is selected FS=1000Hz!", UVM_LOW)
        prog_coeff(
           `SCALECONST1_FS1000, 
           `COEF_B1_SESSION1_FS1000, 
           `COEF_B2_SESSION1_FS1000, 
           `COEF_B3_SESSION1_FS1000, 
           `COEF_A2_SESSION1_FS1000, 
           `COEF_A3_SESSION1_FS1000, 
           `SCALECONST2_FS1000, 
           `COEF_B1_SESSION2_FS1000, 
           `COEF_B2_SESSION2_FS1000, 
           `COEF_B3_SESSION2_FS1000, 
           `COEF_A2_SESSION2_FS1000, 
           `COEF_A3_SESSION2_FS1000
         );
	 `nnc_info("SOC_TEST", "Sample Rate FS=1000Hz is configured successfully!", UVM_LOW)
      end else begin
	 `nnc_info("SOC_TEST", "Sample Rate is selected FS=500Hz!", UVM_LOW)
	 `nnc_info("SOC_TEST", "Sample Rate FS=500Hz is not needed to configure and use the default value!", UVM_LOW)
      end
     
      // Set notch enable
      `WR_NORMAL_REG(`SOC_NOTCH_FILTER_EN, {5'h0, `DUT_IF.filter_gain_mult, 1'b1}, top_test_cfg.pads);

   //Set check_clk_div
    ////------------- to write in to the SOC_CHECK_CLK_DIV_LO_REG reg--------------//
      `WR_NORMAL_REG(`SOC_CHECK_CLK_DIV_LO_REG, top_test_cfg.checkclk_div_reg[7:0], top_test_cfg.pads);

    ////------------- to write in to the SOC_CHECK_CLK_DIV_HI_REG reg--------------//
      `WR_NORMAL_REG(`SOC_CHECK_CLK_DIV_HI_REG, top_test_cfg.checkclk_div_reg[15:8], top_test_cfg.pads);

       top_test_cfg.wr_data[0] = 8'h01;
   //Enable IMEAS
    ////------------- to write in to the SOC_IMEAS_EN reg--------------//
       `WR_NORMAL_REG(`SOC_IMEAS_EN, top_test_cfg.wr_data[0], top_test_cfg.pads);

    ///-------------to read from the SOC_IMEAS_EN reg-------------------//
       `RD_NORMAL_REG(`SOC_IMEAS_EN,top_test_cfg.pads,top_test_cfg.rd_data);

       //Check imeas enabled
       if(top_test_cfg.rd_data[0] !== top_test_cfg.wr_data[0][0])
	  `nnc_error("SOC_TEST", "[ERROR][0] imeas not enabled!")
       else
	   `nnc_info("SOC_TEST", "imeas enabled!", UVM_LOW)

       top_test_cfg.wr_data[0] = {6'b0,`DUT_IF.imeas_input_format};
       `nnc_info("SOC_TEST", $sformatf("imeas input format: (0x%x)",`DUT_IF.imeas_input_format),UVM_LOW)
    //Set IMEAS input format
    ////------------- to write in to the SOC_IMEAS_INPUT_FORMAT reg--------------//
       `WR_NORMAL_REG(`SOC_IMEAS_INPUT_FORMAT, top_test_cfg.wr_data[0], top_test_cfg.pads);

       `nnc_info("SOC_TEST", "Configure Imeas!", UVM_LOW)
       `nnc_info("SOC_TEST",$sformatf("CIC_RATE: %d", (32 * 2**`DUT_IF.imeas_cic_rate)),UVM_LOW)
       `nnc_info("SOC_TEST",$sformatf("CIC_SAMP_FREQ: %d", (128000/(32 * 2**`DUT_IF.imeas_cic_rate))),UVM_LOW)
       `nnc_info("SOC_TEST", "Enable imeas bio interrupt!", UVM_LOW)
       top_test_cfg.wr_data[0] = {top_test_cfg.ppg_mode,`DUT_IF.imeas_cic_rate,1'b0,top_test_cfg.bio_int_en,top_test_cfg.restart_en,top_test_cfg.int_en};
    ////------------- to write in to the SOC_IMEAS_REG_CTRL_0 reg--------------//
       `WR_NORMAL_REG(`SOC_IMEAS_REG_CTRL_0, top_test_cfg.wr_data[0], top_test_cfg.pads);

    ///-------------to read from the SOC_IMEAS_REG_CTRL_0 reg-------------------//
       `RD_NORMAL_REG(`SOC_IMEAS_REG_CTRL_0,top_test_cfg.pads,top_test_cfg.rd_data);

       `nnc_info("SOC_TEST", $sformatf("imeas control set as: (0x%x)",top_test_cfg.rd_data),UVM_LOW)
       if(top_test_cfg.rd_data[6:4] !== `DUT_IF.imeas_cic_rate)
         `nnc_error("SOC_TEST", "[ERROR][1] imeas_ctrl_sts[6:4] is not expected!")
       if(top_test_cfg.rd_data[0] !== top_test_cfg.int_en)
         `nnc_error("SOC_TEST", "[ERROR][2] imeas_ctrl_sts[0] is not expected!")
         
       `nnc_info("SOC_TEST", "Configure Channel!", UVM_LOW)
       top_test_cfg.wr_data[0] = {top_test_cfg.ch_num,1'b0,top_test_cfg.format_sel,top_test_cfg.ch_mode};
     ////------------- to write in to the SOC_IMEAS_MODE_REG reg--------------//
       `WR_NORMAL_REG(`SOC_IMEAS_MODE_REG, top_test_cfg.wr_data[0], top_test_cfg.pads);
       
       #1000;
       top_test_cfg.wr_data[0] = 8'h00;
       `nnc_info("SOC_TEST", "Start measure!", UVM_LOW)
     ////------------- to write in to the SOC_IMEAS_REG_SEQ, reg--------------//
       `WR_NORMAL_REG(`SOC_IMEAS_REG_SEQ, top_test_cfg.wr_data[0], top_test_cfg.pads);

       top_test_cfg.no_of_bytes = 8'h06;
       top_test_cfg.rd_data_reg = new[top_test_cfg.no_of_bytes];

    repeat(1) begin
    //Wait for imeas interrupt
       wait(`SOC_TB.IOBUF_PAD[4] === 1'b1);
    ///-------------to read from the SOC_IMEAS_STATUS reg-------------------//
       `RD_NORMAL_REG(`SOC_IMEAS_STATUS,top_test_cfg.pads,top_test_cfg.int_sts);
       
    //Check int status
       if(top_test_cfg.int_sts[3] !== 1'b1)
	  `nnc_error("SOC_TEST", "[ERROR][3] imeas bio interrupt failed!")
       else
	  `nnc_info("SOC_TEST", "imeas bio interrupt occurred!", UVM_LOW)

    ///-------------to read burst starting from the SOC_IMEAS_CH0DATA_MAX_0 reg-------------------//
       `RD_BURST_NORMAL_REG(`SOC_IMEAS_CH0DATA_MAX_0, top_test_cfg.no_of_bytes, top_test_cfg.rd_data_reg);

       `DUT_IF.ch0_data_max[7:0]   = top_test_cfg.rd_data_reg[5];
       `DUT_IF.ch0_data_max[15:8]  = top_test_cfg.rd_data_reg[4];
       `DUT_IF.ch0_data_min[7:0]   = top_test_cfg.rd_data_reg[3];
       `DUT_IF.ch0_data_min[15:8]  = top_test_cfg.rd_data_reg[2];
       `DUT_IF.ch0_data_delta[7:0] = top_test_cfg.rd_data_reg[1];
       `DUT_IF.ch0_data_delta[15:8]= top_test_cfg.rd_data_reg[0];

    ////------------- to write in to the SOC_IMEAS_STATUS reg--------------//
       `WR_NORMAL_REG(`SOC_IMEAS_STATUS, top_test_cfg.int_sts, top_test_cfg.pads);

     ///-------------to read from the SOC_IMEAS_STATUS reg-------------------//
       `RD_NORMAL_REG(`SOC_IMEAS_STATUS,top_test_cfg.pads,top_test_cfg.int_sts);

    //Check int status
       if(top_test_cfg.int_sts[3] !== 1'b0)
           `nnc_error("SOC_TEST", "[ERROR][4] imeas bio interrupt not cleared!")
       else
	   `nnc_info("SOC_TEST", "imeas bio interrupt cleared!", UVM_LOW)
    //end of repeat loop
    end

   if (`DUT_IF.disable_step_check === 1) begin
    #4s;
   end else begin 
     //#1.5s;
     //`FILTER_SCOREBOARD_EN = 1;
     //repeat(5) begin
     for(int i = 0; i< 5;i++)begin
       if(i==0)begin
         #2s;
         `nnc_info("SOC_TEST", "Disable SB from test ", UVM_LOW)
         en_dis_scoreboard(0);
       end
       else begin
         #0.5s;
       end
       assert(top_test_cfg.randomize());
      `DUT_IF.imeas_sin_amp = top_test_cfg.imeas_sin_amp;
      `DUT_IF.imeas_sin_offset = top_test_cfg.imeas_sin_offset;
      `DUT_IF.filter_gain_mult = top_test_cfg.filter_gain_mult;
      `WR_NORMAL_REG(`SOC_NOTCH_FILTER_EN, {5'h0, `DUT_IF.filter_gain_mult, 1'b1}, top_test_cfg.pads);
     end
       #0.5s;
   end

       top_test_cfg.wr_data[0] = 8'h04;
       `nnc_info("SOC_TEST", "Stop filter!", UVM_LOW)
    ////------------- to write in to the SOC_IMEAS_REG_SEQ, reg--------------//
       `WR_NORMAL_REG(`SOC_IMEAS_REG_SEQ, top_test_cfg.wr_data[0], top_test_cfg.pads);

   end
  endtask
     
  function en_dis_scoreboard(bit en_dis);
    if((`DUT_IF.imeas_sin_expected_freq >= 49 && `DUT_IF.imeas_sin_expected_freq <= 51))begin // 50Hz 
     `FILTER_PEAK_TO_PEAK_SB_EN = en_dis;
      `nnc_info(get_full_name(), $sformatf("peak to peak sb en_dis = %0d ",en_dis),UVM_LOW);
    end
    else begin
     `FILTER_POINT_TO_POINT_SB_EN = en_dis;
      `nnc_info(get_full_name(), $sformatf("point to point sb en_dis = %0d ",en_dis),UVM_LOW);
    end
  endfunction :en_dis_scoreboard

  task prog_coeff(logic [15:0] coeff0, coeff1, coeff2, coeff3, coeff4, coeff5, coeff6, coeff7, coeff8, coeff9, coeff10, coeff11 );
    // **********************Prepare for coefficients - key cofficient ************************
    logic [7:0] coeff_flash_wdata[23:0];
    logic [7:0] addr;

    top_test_cfg.rd_data = 8'h00;
    `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.rd_data);
    while (top_test_cfg.rd_data[6] === 1) begin
      `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.rd_data);
    end
    
    `nnc_info(get_full_name(), $sformatf(" ****** Writing to filter coeff with external clock*******"),UVM_LOW);
    coeff_flash_wdata = '{coeff11[15:8], coeff11[7:0], coeff10[15:8], coeff10[7:0], coeff9[15:8], coeff9[7:0], coeff8[15:8], coeff8[7:0], coeff7[15:8], coeff7[7:0], coeff6[15:8], coeff6[7:0], coeff5[15:8], coeff5[7:0], coeff4[15:8], coeff4[7:0], coeff3[15:8], coeff3[7:0], coeff2[15:8], coeff2[7:0], coeff1[15:8], coeff1[7:0], coeff0[15:8], coeff0[7:0]}; 

     assert(top_test_cfg.randomize() with {ext_clk_en==1;ext_clk_sel==3; hfosc_variation == 100;});
     `DUT_IF.ext_clk_en =top_test_cfg.ext_clk_en;
     `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel; //1MHz
     `DUT_IF.hfosc_fixed_gnd_en = top_test_cfg.hfosc_fixed_gnd_en;
     `DUT_IF.ext_hfosc_fixed_gnd_en = top_test_cfg.ext_hfosc_fixed_gnd_en;
     `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;
     #10us;

    `WR_NORMAL_REG(`SOC_FLASH_TRIMDATA0, 'h5A, top_test_cfg.pads);

    `WR_NORMAL_REG(`SOC_FLASH_UNLOCK, {`KEY_TRIM, 3'b001}, top_test_cfg.pads);
    // wait for to flash load complete
    top_test_cfg.rd_data = 8'h00;
    `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,top_test_cfg.rd_data);
    while (top_test_cfg.rd_data[0] === 1) begin
     `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,top_test_cfg.rd_data);
    end

    for(int i = 0; i< 24;i++)begin
      //wr_data = $urandom_range(255,1);  //can not be 0
      addr = i;
      `nnc_info(get_full_name(), $sformatf(" ****** wr_data=%0h , addr=%0h*******",coeff_flash_wdata[i],addr),UVM_DEBUG);

      // write addr
      `WR_NORMAL_REG(`SOC_FLASH_ADDR, addr, top_test_cfg.pads);
      // write data
      `WR_NORMAL_REG(`SOC_FLASH_DATA, coeff_flash_wdata[i], top_test_cfg.pads);
      // write unlock reg bit 0 
      `WR_NORMAL_REG(`SOC_FLASH_UNLOCK, {`KEY_COEFFI, 3'b001}, top_test_cfg.pads);

      // Wait for unlock bit to be deasserted
      top_test_cfg.rd_data = 8'h00;
      `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,top_test_cfg.rd_data);
      //if (key_coeff === `KEY_COEFFI) begin
        while (top_test_cfg.rd_data[0] === 1) begin
         `RD_NORMAL_REG(`SOC_FLASH_UNLOCK,top_test_cfg.pads,top_test_cfg.rd_data);
        end
      //end
      //else #10us;
    end

    // changing to internal clock again
    assert(top_test_cfg.randomize() with {ext_clk_en==0; ext_clk_sel==2'b00;});
    `DUT_IF.ext_clk_en =top_test_cfg.ext_clk_en;
    `DUT_IF.ext_clk_sel = top_test_cfg.ext_clk_sel;
    `DUT_IF.hfosc_fixed_gnd_en = top_test_cfg.hfosc_fixed_gnd_en;
    `DUT_IF.ext_hfosc_fixed_gnd_en = top_test_cfg.ext_hfosc_fixed_gnd_en;
    `DUT_IF.hfosc_variation = top_test_cfg.hfosc_variation;
    
    `DUT_IF.wake_up_en = 0;
    #1000000
    //repeat(200) @(posedge `DUT_IF.sys_clk);

    $display ("\n Enter Active mode");
    `DUT_IF.wake_up_en = 1;

    wait(`RESETN);

    top_test_cfg.rd_data = 8'h00;
    `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.rd_data);
    while (top_test_cfg.rd_data[6] === 1) begin
    `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.rd_data);
    end
   #10us;

   if (`DUT_IF.pclk_sel !== 2'b00  || `DUT_IF.iclk_sel !== 3'b010) begin
          `nnc_info("SOC_TEST", "Program ICLK and PCLK again after reset!", UVM_LOW)
          top_test_cfg.no_of_bytes = 8'h0;
          top_test_cfg.data[0] = {2'b0,`DUT_IF.iclk_sel, `DUT_IF.pclk_sel, 1'b0};
          `nnc_info("SOC_TEST", "Single Writing to CLK_CTRL Register", UVM_LOW)
          //`WR_WAVEGEN_REG(top_test_cfg.reg_addr, top_test_cfg.wr_data[0], top_test_cfg.pads);
          `WR_NORMAL_REG(`SOC_CLK_CTRL_REG, top_test_cfg.data[0], 8'h00);
   end
   if (`DUT_IF.mclk_sel !== `SOC_MCLK_DIV_REG_INIT) begin
         `nnc_info("SOC_TEST", "Program MCLK again after reset!", UVM_LOW)
          top_test_cfg.no_of_bytes = 8'h0;
          top_test_cfg.data[0] = `DUT_IF.mclk_sel;
          `nnc_info("SOC_TEST", "Single Writing to a MCLK_DIV Register", UVM_LOW)
          `WR_NORMAL_REG(`SOC_MCLK_DIV_REG, top_test_cfg.data[0], 8'h00);
   end

  endtask

  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction
endclass : `TESTNAME
