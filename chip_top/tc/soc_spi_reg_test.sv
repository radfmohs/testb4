/*======================================================================================
// Copyright 2021 Nanochap Electronics, Inc.
// All Rights Reserved Worldwide
//--------------------------------------------------------------------------------------
// File Name	: soc_spi_reg_test.sv                                                   
// Project	: Nanochap ENS3                                  		        
// Description	: Testcase soc_spi_reg_test                                             
// Designer	: shreeyal@nanochap.com                                                                 
// Date		: 28-05-2024                                                                     
// Revision	: 0.1 Initial version created by script                                 
// ====================================================================================*/

// =================================================
// Testcase name is defined
// -------------------------------------------------
`define TESTNAME soc_spi_reg_test
`define TESTCFG soc_spi_reg_test_cfg

class `TESTCFG extends soc_base_test_cfg;

  `nnc_object_utils(`TESTCFG)

  // ===============================================
  // Adding your new varialbles in config test
  // -----------------------------------------------

  //rand logic [7:0] wr_data[256];
  rand logic [7:0] wr_data;
  rand int         no_of_bytes; 
  rand logic [7:0] reg_addr;
  rand logic [7:0] pads;
  rand logic [7:0] mask;
  rand logic [7:0] expected_data;
  logic [7:0]      rd_data;
  logic [7:0] rd_data_reg[];
  logic [7:0] flash_debug_status;

  // -----------------------------------------------
  // End of decalration of new variables 
  // ===============================================

  function new (string name = "soc_spi_reg_test_cfg");
    super.new(name);
    
  endfunction: new

  // ===============================================
  // Adding constraints of randomization
  // -----------------------------------------------

  // testmode_sel[1:0] : 00-Normal mode, 01: Scanmode, 10: BIST mode, 11 atm0/1/2/3/4
  constraint c_testmode_sel { soft testmode_sel == 2'b00; }

  // spimode_sel[1:0] :  
  constraint c_spimode_sel { spimode_sel == 2'b00; }

  // No of bytes in a burst
  constraint c_no_of_bytes { soft no_of_bytes == 2; }

  // pads values
  constraint c_pads        { soft pads == 8'h00; }

  // mask values
  constraint c_mask        { soft mask == 8'hff; }

  // do not config in base test pre reset phase 
  constraint c_config_in_base_test_en { soft config_in_base_test_en == 1'b0; }

  // -----------------------------------------------
  // End of adding constraints of randomization
  // ===============================================

endclass : `TESTCFG

// ===============================================
// Main Testcase is defined
// -----------------------------------------------
class `TESTNAME extends soc_base_test;
   
  `nnc_component_utils(`TESTNAME)

  `TESTCFG top_test_cfg;

   nnc_register nnc_normal_reg[];

  // -----------------------------------------
  // Declare the new function 
  // -----------------------------------------
  function new(string name, nnc_component parent);
    super.new(name, parent);
  endfunction

  // -----------------------------------------
  // Declare the build_phase function 
  // -----------------------------------------
  virtual function void build_phase(nnc_phase phase);
    super.build_phase(phase);
    uvm_top.set_timeout(2s);
    top_test_cfg = `TESTCFG::type_id::create("top_test_cfg", this);
  endfunction

  // -----------------------------------------
  // Declare the pre_reset_phase task 
  // -----------------------------------------
  virtual task pre_reset_phase(nnc_phase phase);
    phase.raise_objection(this);

    super.pre_reset_phase(phase);

    assert(top_test_cfg.randomize());

    `DUT_IF.testmode_sel = top_test_cfg.testmode_sel;

    `DUT_IF.spimode_sel = top_test_cfg.spimode_sel;

    `DUT_IF.config_in_base_test_en = top_test_cfg.config_in_base_test_en;

    // -------------------
    // Scoreboard enables
    // -------------------
    // `FLASH_SCOREBOARD_EN = 1;
    // `SPIM_SCOREBOARD_EN = 1;
    // `ANALOG_SCOREBOARD_EN = 1;
    // `IMEAS_SCOREBOARD_EN = 1;
    // `CLKRST_SCOREBOARD_EN = 1;

    phase.drop_objection(this);
  endtask : pre_reset_phase

  // -----------------------------------------
  // Declare the main_phase task of your test
  // -----------------------------------------
  virtual task main_phase(nnc_phase phase);

    logic [7:0] default_val;
    logic [7:0] mask_val;
    logic [7:0] wg_addr;
    logic [7:0] addr;
    logic [1:0] access;

    phase.raise_objection(this);

    super.main_phase(phase);

    `nnc_info("SOC_TEST", "soc_spi_reg_test start", UVM_LOW)

    // ==================================================================================
    // Please add your code of your test here
    // ---------------------------------------------------------------------------------- 

    //`RD_NORMAL_REG(`SOC_SYSTEM_AO_STATUS, top_test_cfg.pads, top_test_cfg.rd_data);
    //while ( top_test_cfg.rd_data[0] !== 1'b1) begin
    //  `RD_NORMAL_REG(`SOC_SYSTEM_AO_STATUS, top_test_cfg.pads, top_test_cfg.rd_data);
    //end
    
    // --------------------------------------------------------------
    // Created object and initialize Normal register again if needed
    // --------------------------------------------------------------
    nnc_normal_reg = new[`NORMAL_REG_NUM+1] ;
    for(int i=1 ; i< nnc_normal_reg.size();i++)begin
      addr = `DUT_IF.reg_normal[i][39:32];
      mask_val = `DUT_IF.reg_normal[i][23:16];
      access = `DUT_IF.reg_normal[i][1:0];
      default_val = `DUT_IF.reg_normal[i][31:24];

      //if (i ==`SOC_OTP_DEBUG_1_REG) begin
      //  if(`DUT_IF.altf_sel != 2'b00) default_val = `DUT_IF.reg_normal[i][31:24] || 8'h20;
      //end

      `nnc_info("SOC_TEST - NORMAL", $sformatf("addr = %0h,default_val = %0d, mask_val = %0d, access = %0d",addr,default_val,mask_val,access), NNC_LOW)
      nnc_normal_reg[i] = nnc_register::new($sformatf("normal_reg_%0d",i), addr, default_val, mask_val, access[1:0]);
    end

    // --------------------------------------------------
    // check init read
    // --------------------------------------------------
    // Cheking Initial values of normal registers
    // --------------------------------------------------
    `nnc_info("SOC_TEST - PART I", "STARTING TO CHECK THE RESET VALUE OF NORMAL REGISTERS", UVM_LOW)

    `nnc_info("SOC_TEST", $sformatf("***********************************************************"), NNC_LOW)
    `nnc_info("SOC_TEST", $sformatf("NORMAL REG: Checking intial values and compare with Spec"), NNC_LOW)
    `nnc_info("SOC_TEST", $sformatf("************************************************************\n"), NNC_LOW)
    for(int i=1 ; i<nnc_normal_reg.size();i++)begin
       //if(i == 105) continue; // address 8'h69 TSC_VDAC_NOR
       nnc_normal_reg[i].read_init();
    end


    // ---------------------------------------------------------------------------
    // Checking Write 0 to registers
    // --------------------------------------------------------------------------- 

    // ******************************************************* 
    // check write/read to all bits as 0 to normal registers
    // *******************************************************
    //if ((`DUT_IF.normal_reg_en == 1'b1) && (`DUT_IF.default_only_en !== 1'b1)) begin // 1
    `nnc_info("SOC_TEST", $sformatf("***********************************************************"), NNC_LOW)
    `nnc_info("SOC_TEST", $sformatf("NORMAL REG: write 0 to each bit of each register and compare"), NNC_LOW)
    `nnc_info("SOC_TEST", $sformatf("************************************************************\n"), NNC_LOW)
    for(int i=1 ; i<nnc_normal_reg.size();i++)begin
      top_test_cfg.wr_data[0] = 'h0;
      //if(i== `SOC_GPIO_PD_CTRL_REG) continue;
      nnc_normal_reg[i].write_read(top_test_cfg.wr_data[0]);
    end

    // ---------------------------------------------------------------------------
    // Checking Write 1 to registers
    // ---------------------------------------------------------------------------

    // **************************************
    // check write/read to all bits as 1
    // **************************************
    `nnc_info("SOC_TEST", $sformatf("***********************************************************"), NNC_LOW)
    `nnc_info("SOC_TEST", $sformatf("NORMAL REG: write 1 to each bit of each register and compare"), NNC_LOW)
    `nnc_info("SOC_TEST", $sformatf("************************************************************\n"), NNC_LOW)
    for(int i=1 ; i<nnc_normal_reg.size();i++)begin
      top_test_cfg.wr_data[0] = 8'hFF;
      //if(i== `SOC_GPIO_PD_CTRL_REG) continue;

      /*if (i == `SOC_STIM_MON_INT) begin 
	 `WR_NORMAL_REG(`SOC_STIM_MON_INT, 8'hff, top_test_cfg.pads);
	 `RD_NORMAL_REG(`SOC_STIM_MON_INT, top_test_cfg.pads, top_test_cfg.rd_data);
	 if(top_test_cfg.rd_data !== 8'hf8)
           `nnc_error("SOC_STIM_MON_INT TEST", $sformatf("read value of register %0h is read_data=%0h not the same as exp=8'hf8",`SOC_STIM_MON_INT, top_test_cfg.rd_data))   
      end
      else*/ begin
        nnc_normal_reg[i].write_read(top_test_cfg.wr_data[0]);
      end
    end

    // ---------------------------------------------------------------------------
    // Checking Write random to registers
    // ---------------------------------------------------------------------------
    // ************************************************
    // check write/read to all bits for random value
    // ************************************************
    `nnc_info("SOC_TEST", $sformatf("******************************************************************"), NNC_LOW)
    `nnc_info("SOC_TEST", $sformatf("NORMAL REG: write random to each bit of each register and compare"), NNC_LOW)
    `nnc_info("SOC_TEST", $sformatf("*******************************************************************\n"), NNC_LOW)
    for(int i=1 ; i<nnc_normal_reg.size();i++)begin
      top_test_cfg.wr_data[0] = $random();
      //if(i== `SOC_GPIO_PD_CTRL_REG) continue;
 
      /*if (i == `SOC_STIM_MON_INT) begin 
	      `WR_NORMAL_REG(`SOC_STIM_MON_INT, top_test_cfg.wr_data[0], top_test_cfg.pads);
	      `RD_NORMAL_REG(`SOC_STIM_MON_INT, top_test_cfg.pads, top_test_cfg.rd_data);
	       if(top_test_cfg.rd_data !== top_test_cfg.wr_data[0] & 8'hf8)
           `nnc_error("SOC_STIM_MON_INT TEST", $sformatf("read value of register %0h is read_data=%0h not the same as exp=%0h",`SOC_STIM_MON_INT, top_test_cfg.rd_data, top_test_cfg.wr_data[0] & 8'hf8))   
      end
      else */begin
        nnc_normal_reg[i].write_read(top_test_cfg.wr_data[0]);
      end
    end

    // **************************************************
    // check reserved reg
    // **************************************************
    // --------------------------------------------------
    // Checking normal register
    // --------------------------------------------------
    `nnc_info("SOC_TEST", $sformatf("******************************************************************"), NNC_LOW)
    `nnc_info("SOC_TEST", $sformatf("NORMAL REG: CHECK RESERVED REGS"), NNC_LOW)
    `nnc_info("SOC_TEST", $sformatf("*******************************************************************\n"), NNC_LOW)

    for(int i=1 ; i<nnc_normal_reg.size();i++)begin
      top_test_cfg.wr_data[0] = $random();
      if(^nnc_normal_reg[i].address === 1'bx)begin
        nnc_normal_reg[i].check_reserved_regs(i,top_test_cfg.wr_data[0]);
      end
    end

/*
    if(`DUT_IF.spi_sclk_freq > 20)begin // if SPI freq is too low than flash will be get loaded and SPI is so slow that it can not get default values, it will only get updated reload values
    for(int i=`SOC_FLASH_TRIMDATA0; i<=`SOC_FLASH_TRIMDATA20; i++) begin
      `nnc_info(get_full_name(), $sformatf("will read reg %0h", i),UVM_LOW);
      `RD_RESET_CHK_NORMAL_REG(i, 'h0, top_test_cfg.pads);
      `nnc_info(get_full_name(), $sformatf("done read reg %0h", i),UVM_LOW);
      wait(`DUT_IF.flash_recall_done);
      force `ANA_TOP.A2D_Wake_UP_i = 1'b0;
      // give reset to keep all registers in their default state so flash can not reload
      `nnc_info(get_full_name(), $sformatf("will assert rst"),UVM_LOW);
      force `SOC_TB.iopad_resetn = 0 ;
      #10000;
      release `ANA_TOP.A2D_Wake_UP_i; 
      release `SOC_TB.iopad_resetn;
      `nnc_info(get_full_name(), $sformatf("release assert rst"),UVM_LOW);
      wait(`DUT_IF.soc_resetn); // SOC Reset
      `nnc_info(get_type_name(), "Reset is done", UVM_LOW)
    end 
    #5ms;
    end 
    //Wait for flash busy to go low, when update trim via SPI
    top_test_cfg.flash_debug_status = 8'h00;
    `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.flash_debug_status);
    while (top_test_cfg.flash_debug_status[6] === 1) begin
    `RD_NORMAL_REG(`SOC_FLASH_DEBUG2,top_test_cfg.pads,top_test_cfg.flash_debug_status);
    end
    //wait(`DIG_TOP.FLASH_Reset_Done);
    `nnc_info("SOC_TEST", "Flash reset done!", UVM_LOW)

    // calling task for checking reg init values
    check_reg_init_values();

    // --------------------------------------------------------
    // Part III: Checking the W/R values of all of normal registers by using WR_RD_CHK_NORMAL_REG
    // --------------------------------------------------------
    `nnc_info("SOC_TEST - PART II", "STARTING TO CHECK THE R/W OF NORMAL REGISTERS", UVM_LOW)
    assert(top_test_cfg.randomize() with {reg_addr == `SOC_FIFO_WR_PTR_REG; mask == 8'hff;}); //read only reg
    `WR_RD_CHK_NORMAL_REG(top_test_cfg.reg_addr, 'h0, top_test_cfg.pads, top_test_cfg.mask);

    // calling task for checking reg wr rd values
    check_reg_wr_rd_values();
*/   
    // --------------------------------------------------------
    // End of test and add any needed delay time 
    // --------------------------------------------------------
    #10000ns;
    `nnc_info("SOC_TEST", "soc_spi_reg_test end now", UVM_LOW)

    // ----------------------------------------------------------------------------------
    // End of adding test 
    // ==================================================================================

    phase.drop_objection(this);
  endtask: main_phase

  // Task to check the initial values of regs
  task check_reg_init_values();
    logic [7:0]      init_value;
    `nnc_info("SOC_TEST - PART II", "Calling check_reg_init_values task ", UVM_LOW)


  for (integer i = 1; i<=`SOC_ALWAYS_ON_ANA_TRIM10;i++) begin
    //$display("for loop i=%d",i);
    case (i)
      /*8'h01*/  `SOC_IMEAS_REG_CTRL_0     : init_value = `SOC_IMEAS_REG_CTRL_0_INIT;
      /*8'h02*/  `SOC_IMEAS_REG_CTRL_1     : init_value = `SOC_IMEAS_REG_CTRL_1_INIT;
      /*8'h05*/  `SOC_IMEAS_REG_SEQ        : init_value = `SOC_IMEAS_REG_SEQ_INIT;
      /*8'h06*/  `SOC_IMEAS_REG_RSTVAL     : init_value = `SOC_IMEAS_REG_RSTVAL_INIT;
      /*8'h0e*/  `SOC_IMEAS_CHA_NUM_LO     : init_value = `SOC_IMEAS_CHA_NUM_LO_INIT;
      /*8'h0f*/  `SOC_IMEAS_CHA_NUM_HI     : init_value = `SOC_IMEAS_CHA_NUM_HI_INIT;
      /*8'h12*/  `SOC_IMEAS_THRESHOLD_HI_0 : init_value = `SOC_IMEAS_THRESHOLD_HI_0_INIT;
      /*8'h13*/  `SOC_IMEAS_THRESHOLD_HI_1 : init_value = `SOC_IMEAS_THRESHOLD_HI_1_INIT;
      /*8'h16*/  `SOC_IMEAS_INPUT_FORMAT   : init_value = `SOC_IMEAS_INPUT_FORMAT_INIT;
      /*8'h22*/  `SOC_ZMEAS_REG_CTRL_2     : init_value = `SOC_ZMEAS_REG_CTRL_2_INIT;
      /*8'h41*/  `SOC_MEAS_SYNC_EN         : init_value = `SOC_MEAS_SYNC_EN_INIT; 
      /*8'h4A*/  `SOC_LEADOFF_CLK_REG      : init_value = `SOC_LEADOFF_CLK_REG_INIT;
      /*8'h4B*/  `SOC_MCLK_DIV_REG         : init_value = `SOC_MCLK_DIV_REG_INIT;
      /*8'h4C*/  `SOC_CHECK_CLK_DIV_HI_REG      : init_value = `SOC_CHECK_CLK_DIV_HI_INIT;
      /*8'h4D*/  `SOC_CHECK_CLK_DIV_LO_REG      : init_value = `SOC_CHECK_CLK_DIV_LO_INIT;
      /*8'h4E*/  `SOC_CLK_CTRL_REG         : init_value = `SOC_CLK_CTRL_REG_INIT;
      /*8'h4F*/  `SOC_PMU_REG0             : init_value = `SOC_PMU_REG0_INIT;
      /*8'h50*/  `SOC_FLASH_DEBUG1         : init_value = `SOC_FLASH_DEBUG1_INIT;    
      /*8'h51*/  `SOC_FLASH_DEBUG2         : init_value = 8'h02; // PORn of Flash is happened after BAF4P1 reset. Then, it is changed from 0 to 1. bit[1]
      /*8'h52*/  `SOC_FLASH_TRIMDATA0      : init_value = `SOC_FLASH_TRIMDATA0_RELOAD_INIT;    
      /*8'h53*/  `SOC_FLASH_TRIMDATA1      : init_value = `SOC_FLASH_TRIMDATA1_RELOAD_INIT;    
      /*8'h54*/  `SOC_FLASH_TRIMDATA2      : init_value = `SOC_FLASH_TRIMDATA2_RELOAD_INIT;    
      /*8'h55*/  `SOC_FLASH_TRIMDATA3      : init_value = `SOC_FLASH_TRIMDATA3_RELOAD_INIT;    
      /*8'h56*/  `SOC_FLASH_TRIMDATA4      : init_value = `SOC_FLASH_TRIMDATA4_RELOAD_INIT;    
      /*8'h57*/  `SOC_FLASH_TRIMDATA5      : init_value = `SOC_FLASH_TRIMDATA5_RELOAD_INIT;    
      /*8'h5A*/  `SOC_FLASH_TRIMDATA8      : init_value = `SOC_FLASH_TRIMDATA8_RELOAD_INIT;    
      /*8'h5B*/  `SOC_FLASH_TRIMDATA9      : init_value = `SOC_FLASH_TRIMDATA9_RELOAD_INIT;    
      /*8'h5C*/  `SOC_FLASH_TRIMDATA10      : init_value = `SOC_FLASH_TRIMDATA10_RELOAD_INIT;    
      /*8'h5C*/  `SOC_FLASH_TRIMDATA11      : init_value = `SOC_FLASH_TRIMDATA11_RELOAD_INIT;    
      /*8'h5C*/  `SOC_FLASH_TRIMDATA13      : init_value = `SOC_FLASH_TRIMDATA13_RELOAD_INIT;    
      /*8'h71*/  `SOC_DEVICE_INT_STATUS_1     : init_value = `SOC_DEVICE_INT_STATUS_1_INIT;
      ///*8'h7C*/  `SOC_SQU_DATA_H_1            : init_value = `SOC_SQU_DATA_H_1_INIT;
      /*8'h7D*/  `SOC_SQU_CLK_DIV_0           : init_value = `SOC_SQU_CLK_DIV_0_INIT;
      /*8'h84*/  `SOC_FIFO_CONFIG_1_REG    : init_value = `SOC_FIFO_CONFIG_1_REG_INIT;
      /*8'h85*/  `SOC_FIFO_CONFIG_2_REG    : init_value = `SOC_FIFO_CONFIG_2_REG_INIT;
      /*8'h87*/  `SOC_FIFO_STATUS_REG      : init_value = `SOC_FIFO_STATUS_REG_INIT; // bit 6,bit 4 : fifo almost empty status,fifo empty status are set after BAF4P1 reset
      /*8'h90*/  `SOC_GPIO_PU_CTR             : init_value = `SOC_GPIO_PU_CTR_INIT;
      /*8'h91*/  `SOC_GPIO_PU_RESETN          : init_value = `SOC_GPIO_PU_RESETN_INIT;
      /*8'h92*/  `SOC_GPIO_PD_TESTMODE        : init_value = `SOC_GPIO_PD_TESTMODE_INIT;
      /*8'h7A*/  `SOC_DC_DATA_REG_1           : init_value = `SOC_DC_DATA_REG_1_INIT;
      /*8'h94*/  `SOC_LEADOFF_TGT_0           : init_value = `SOC_LEADOFF_TGT_0_INIT;
      /*8'h96*/  `SOC_LEADOFF_SWITCH_TGT      : init_value = `SOC_LEADOFF_SWITCH_TGT_INIT;
      /*8'hA1*/  `SOC_ANA_ECG_CTRL1           : init_value = `SOC_ANA_ECG_CTRL1_INIT;
      /*8'hA2*/  `SOC_ANA_ECG_CTRL2           : init_value = `SOC_ANA_ECG_CTRL2_INIT;
      /*8'hC0*/  `SOC_ALWAYS_ON_ANA_TRIM1    : init_value = `SOC_ALWAYS_ON_ANA_TRIM1_INIT;
      /*8'hC1*/  `SOC_ALWAYS_ON_ANA_TRIM2    : init_value = `SOC_ALWAYS_ON_ANA_TRIM2_INIT;
      /*8'hC2*/  `SOC_ALWAYS_ON_ANA_TRIM3    : init_value = `SOC_ALWAYS_ON_ANA_TRIM3_INIT;
      /*8'hC3*/  `SOC_ALWAYS_ON_ANA_TRIM4    : init_value = `SOC_ALWAYS_ON_ANA_TRIM4_INIT;
      /*8'hC4*/  `SOC_ALWAYS_ON_ANA_TRIM5    : init_value = `SOC_ALWAYS_ON_ANA_TRIM5_INIT;
      /*8'hC7*/  `SOC_ALWAYS_ON_ANA_TRIM8    : init_value = `SOC_ALWAYS_ON_ANA_TRIM8_INIT;
      /*8'hC8*/  `SOC_ALWAYS_ON_ANA_TRIM9    : init_value = `SOC_ALWAYS_ON_ANA_TRIM9_INIT;
      /*8'hC9*/  `SOC_ALWAYS_ON_ANA_TRIM10    : init_value = `SOC_ALWAYS_ON_ANA_TRIM10_INIT;
      default: init_value = 8'h00;
    endcase
      assert(top_test_cfg.randomize() with {reg_addr == i; expected_data == init_value;});
      //if (`DUT_IF.pclk_sel == 3'b000)
        `RD_RESET_CHK_NORMAL_REG(top_test_cfg.reg_addr, top_test_cfg.expected_data, top_test_cfg.pads);
    end

    `nnc_info("SOC_TEST - PART II", "Calling done for check_reg_init_values task ", UVM_LOW)


  endtask : check_reg_init_values

  // Task to check the write/read values of regs
  task check_reg_wr_rd_values();
    bit [7:0] rd_data_before_wr;
    bit [7:0] rd_data_after_wr;
    bit [7:0] mask_local;
    bit [7:0] wr_data_local;

    `nnc_info("SOC_TEST - PART II", "Calling check_reg_wr_rd_values task ", UVM_LOW)

    for (integer i = 1; i<=`SOC_ALWAYS_ON_ANA_TRIM10;i++) begin
      wr_data_local = $urandom_range(8'hFF,8'h0);
      // registers are read only, compare them with their default values after writing
      // 87 is RO and w1c reg
      if(i==`SOC_FIFO_STATUS_REG) begin
        wr_data_local = 'hFF;
        `WR_NORMAL_REG(i,wr_data_local,top_test_cfg.pads);    
        `RD_NORMAL_REG(i, top_test_cfg.pads, rd_data_after_wr);
        if (rd_data_after_wr[2:0]==wr_data_local[2:0]) begin // rest bits are w1c , they are checked in FIFO specific tests . , rest bits are read only
          `nnc_error(get_full_name(), $sformatf("READ ONLY REGISTER's value got changed after writing rd_data_after_wr:%0h, wr_data_local:%0h", rd_data_after_wr,wr_data_local));
        end
      end
      // // 5A to 5B,87,c0 to c3 
      else if(i==`SOC_FLASH_DEBUG2 || i== `SOC_FLASH_DEBUG1 
       || (i>=`SOC_IMEAS_CH0DATA_MAX_0 && i<=`SOC_IMEAS_CH0DATA_DELTA_1) || i== `SOC_DEVICE_INT_STATUS_0 || i==`SOC_DEVICE_INT_STATUS_1 || (i>=`SOC_ALWAYS_ON_ANA_TRIM1 && i<=`SOC_ALWAYS_ON_ANA_TRIM10)) begin
        `RD_NORMAL_REG(i, top_test_cfg.pads, rd_data_before_wr);
        `WR_NORMAL_REG(i,wr_data_local,top_test_cfg.pads);    
        `RD_NORMAL_REG(i, top_test_cfg.pads, rd_data_after_wr);
        if (rd_data_before_wr != rd_data_after_wr) begin
          `nnc_error(get_full_name(), $sformatf("READ ONLY REGISTER's value got changed after writing rd_data_before_wr:%0h,rd_data_after_wr=%0h ", rd_data_before_wr,rd_data_after_wr));
        end
      end
      // do nothing, removed reg from design doc, but still present in design
      else if((i>`SOC_NOTCH_FILTER_EN && i<`SOC_ZMEAS_REG_CTRL_0) || (i> `SOC_ANA_Z_ADC_DAC_EN_SEL && i<`SOC_RLD_CLK_REG) || (i>`SOC_PMU_REG0 && i<`SOC_FLASH_DEBUG1) || (i>`SOC_FLASH_UNLOCK && i<`SOC_DEVICE_INT_STATUS_0) || (i>`SOC_DC_DATA_REG_1 && i<`SOC_SQU_CLK_DIV_0) ||(i>`SOC_SQU_CLK_DIV_1 && i<`SOC_FIFO_WR_PTR_REG)|| (i>`SOC_FIFO_DATA_REG2 && i<`SOC_GPIO_PU_CTR)|| (i>`SOC_LEADOFF_SWITCH_TGT && i<`SOC_ANA_BUFFER)|| (i>`SOC_A2D_SPARE_REG0 && i<`SOC_ALWAYS_ON_ANA_TRIM1) || (i>`SOC_FLASH_TRIMDATA14 && i<`SOC_FLASH_UNLOCK))begin
      end
      else begin
        mask_local = 8'hff;
        case (i)
        /*8'h01*/  `SOC_IMEAS_REG_CTRL_0     : mask_local[3] = 0; 
        /*8'h04*/  `SOC_IMEAS_STATUS         : mask_local = 0; 
        /*8'h05*/  `SOC_IMEAS_REG_SEQ        : mask_local[7:3] = 0;
        ///*8'h06*/  `SOC_IMEAS_REG_RSTVAL     : mask_local = 0; 
        /*8'h07*/  `SOC_IMEAS_CH0DATA_0      : mask_local = 0; 
        /*8'h08*/  `SOC_IMEAS_CH0DATA_1      : mask_local = 0; 
        /*8'h09*/  `SOC_IMEAS_CH1DATA_0      : mask_local = 0; 
        /*8'h0a*/  `SOC_IMEAS_CH1DATA_1      : mask_local = 0; 
        /*8'h0b*/  `SOC_IMEAS_CH2DATA_0      : mask_local = 0; 
        /*8'h0c*/  `SOC_IMEAS_CH2DATA_1      : mask_local = 0; 
        /*8'h0d*/  `SOC_IMEAS_GRP_CTL        : mask_local[7:1] = 0; 
        /*8'h0f*/  `SOC_IMEAS_CHA_NUM_HI     : mask_local[7:4] = 0; 
        /*8'h10*/  `SOC_IMEAS_ALARM_INT      : mask_local = 0; 
        /*8'h11*/  `SOC_IMEAS_ALARM_INT_EN   : mask_local[7:1] = 0; 
        /*8'h16*/  `SOC_IMEAS_INPUT_FORMAT   : mask_local[7:2] = 0;
        /*8'h17*/  `SOC_IMEAS_EN             : mask_local[7:1] = 0;
        /*8'h1e*/  `SOC_NOTCH_FILTER_EN      : mask_local[7:3] = 0;
        /*8'h20*/  `SOC_ZMEAS_REG_CTRL_0     : begin
                                                 mask_local[1] = 0;
                                                 mask_local[3] = 0;
                                               end
        /*8'h21*/  `SOC_ZMEAS_REG_CTRL_1     : begin
                                                 mask_local[1] = 0;
                                                 mask_local[3] = 0;
                                               end
        /*8'h22*/  `SOC_ZMEAS_REG_CTRL_2     : mask_local[3] = 0;
      //  /*8'h1C*/  `SOC_ZMEAS_REG_CTRL_3     : mask_local[3] = 0;
        /*8'h25*/  `SOC_ZMEAS_REG_STATUS_0   : mask_local = 0; 
        /*8'h25*/  `SOC_ZMEAS_REG_STATUS_1   : mask_local = 0; 
        /*8'h26*/  `SOC_ZMEAS_REG_DATAOUT_0  : mask_local = 0; 
        /*8'h27*/  `SOC_ZMEAS_REG_DATAOUT_1  : mask_local = 0; 
        /*8'h28*/  `SOC_ZMEAS_REG_DATAOUT_2  : mask_local = 0; 
        /*8'h29*/  `SOC_ZMEAS_REG_DATAOUT_3  : mask_local = 0; 
        /*8'h2A*/  `SOC_ZMEAS_ADC_ROM_REG_0  : mask_local = 0; 
        /*8'h2B*/  `SOC_ZMEAS_ADC_ROM_REG_1  : mask_local = 0; 
        /*8'h2C*/  `SOC_ZMEAS_ADC_ROM_REG_2  : mask_local = 0; 
        /*8'h2D*/  `SOC_ZMEAS_ADC_ROM_REG_3  : mask_local = 0; 
        /*8'h2E*/  `SOC_ZMEAS_SUM_OFFSET_FORREAL_0  : mask_local = 0; 
        /*8'h2F*/  `SOC_ZMEAS_SUM_OFFSET_FORREAL_1  : mask_local = 0; 
        /*8'h30*/  `SOC_ZMEAS_SUM_OFFSET_FORREAL_2  : mask_local = 0; 
        /*8'h31*/  `SOC_ZMEAS_SUM_OFFSET_FORREAL_3  : mask_local = 0; 
        /*8'h32*/  `SOC_ZMEAS_SUM_REAL_0   : mask_local = 0; 
        /*8'h33*/  `SOC_ZMEAS_SUM_REAL_1   : mask_local = 0; 
        /*8'h34*/  `SOC_ZMEAS_SUM_REAL_2   : mask_local = 0; 
        /*8'h35*/  `SOC_ZMEAS_SUM_REAL_3   : mask_local = 0; 
        /*8'h36*/  `SOC_ZMEAS_SUM_IMAG_0   : mask_local = 0; 
        /*8'h37*/  `SOC_ZMEAS_SUM_IMAG_1   : mask_local = 0; 
        /*8'h38*/  `SOC_ZMEAS_SUM_IMAG_2   : mask_local = 0; 
        /*8'h39*/  `SOC_ZMEAS_SUM_IMAG_3   : mask_local = 0; 
        /*8'h3A*/  `SOC_ZMEAS_SUM_SHIFT_0  : mask_local = 0; 
        /*8'h3B*/  `SOC_ZMEAS_SUM_SHIFT_1  : mask_local = 0; 
        /*8'h3C*/  `SOC_ZMEAS_SUM_SHIFT_2  : mask_local = 0; 
        /*8'h3D*/  `SOC_ZMEAS_SUM_SHIFT_3  : mask_local = 0; 
        /*8'h3E*/  `SOC_ZMEAS_INT          : mask_local = 0; 
        /*8'h3F*/  `SOC_ZMEAS_ADC_INT      : mask_local = 0; 
        /*8'h40*/  `SOC_ZMEAS_EN           : mask_local[7:2] = 0; 
        /*8'h41*/  `SOC_MEAS_SYNC_EN         : mask_local[7:1] = 0;  
        /*8'h42*/  `SOC_ANA_Z_ADC_DAC_EN   : mask_local[7:1] = 0; 
        /*8'h43*/  `SOC_ANA_Z_ADC_DAC_EN_SEL : mask_local[7:1] = 0; 
        /*8'h49*/  `SOC_RLD_CLK_REG : mask_local[7:2] = 0; 
	/*8'h50*/  `SOC_LEADOFF_CLK_REG    : mask_local[7:3] = 0;
        /*8'h55*/  `SOC_PMU_REG0           : mask_local[7] = 0; 
        /*8'h6C*/  `SOC_FLASH_UNLOCK       : begin 
                                               //mask_local[7:2] = 0;
                                               wr_data_local[0] = 0;
                                             end 
        /*8'h72*/  `SOC_PPG_CTRL_1_REG     : mask_local[7:6] = 0;
        /*8'h76*/  `SOC_DATA_TYPE_SEL      : mask_local[7:2] = 0; 
        /*8'h78*/  `SOC_DC_DATA_REG_1      : mask_local[7:2] = 0; 
        ///*8'h7A*/  `SOC_SQU_DATA_L_1      : mask_local[7:2] = 0; 
        ///*8'h7C*/  `SOC_SQU_DATA_H_1      : mask_local[7:2] = 0; 
        /*8'h80*/  `SOC_FIFO_WR_PTR_REG    : mask_local = 0; 
        /*8'h81*/  `SOC_FIFO_RD_PTR_REG    : mask_local = 0; 
        /*8'h82*/  `SOC_FIFO_COUNTER_1_REG : mask_local = 0; 
        /*8'h83*/  `SOC_FIFO_COUNTER_2_REG : mask_local = 0; 
        /*8'h88*/  `SOC_FIFO_DATA_REG1     : mask_local = 0; 
        /*8'h89*/  `SOC_FIFO_DATA_REG2     : mask_local = 0; 
        /*8'h90*/  `SOC_GPIO_PU_CTR        : mask_local[7:3] = 0; 
        /*8'h91*/  `SOC_GPIO_PU_RESETN     : begin 
                                               mask_local[7:1] = 0;
                                               `DUT_IF.gpio_pu_en[21] = wr_data_local[0];
                                             end   
        /*8'h92*/  `SOC_GPIO_PD_TESTMODE   : begin 
                                               mask_local[7:2] = 0; 
                                               `DUT_IF.gpio_pd_en[20:19] = wr_data_local[1:0]; 
                                             end 
	/*8'h93*/  `SOC_LEADOFF_CTRL       : mask_local[7:4] = 0; 
        /*8'h73*/  `SOC_PPG_LED_TIME_SEL   : mask_local[7:4] = 0; 
        /*8'h74*/  `SOC_PPG_LED_FREQ_SEL   : mask_local[7:4] = 0; 
        /*8'h75*/  `SOC_PPG_LED_STATUS     : mask_local = 0; 
        /*8'hA0*/  `SOC_ANA_BUFFER         : mask_local[7:5] = 0;
        /*8'hA2*/  `SOC_ANA_ECG_CTRL2      : mask_local[7] = 0; 
	/*8'hA3*/  `SOC_ANA_LEAD_OFF       : mask_local[7:2] = 0; 
        /*8'hA5*/  `SOC_ANA_PPG_LED_SEL    : mask_local[7:3] = 0; 
        /*8'hA7*/  `SOC_ANA_PPG_DAC0_CTRL_REG1  : mask_local[7:5] = 0; 
        /*8'hA9*/  `SOC_ANA_PPG_DAC1_CTRL_REG1  : mask_local[7:5] = 0; 
        /*8'hAB*/  `SOC_ANA_PPG_TIA_GAIN : mask_local[7:4] = 0; 
        /*8'hAC*/  `SOC_ANA_PPG_TEST     : mask_local[7:6] = 0; 
        /*8'hAD*/  `SOC_ANA_PPG_LED_EN   : mask_local[7:6] = 0; 
        /*8'hAE*/  `SOC_ANA_PPG_CTRL     : mask_local[7:3] = 0; 
        /*8'hAF*/  `SOC_ANA_SDM          : mask_local[7:3] = 0; 
        /*8'hB0*/  `SOC_ANA_BIST         : mask_local[7:4] = 0; 
        /*8'hB1*/  `SOC_ANA_LEAD_OFF_EN  : mask_local[7:2] = 0; 
        default: mask_local=8'hff; // make specifc bits to 0 for read only reserved bits
        endcase
        if(i==`SOC_A2D_SPARE_REG0) begin  // connectivity check between analog and digital reg     
          wr_data_local=$urandom;
          `DUT_IF.A2D_SPARE_TRIM_SW0[7:0] = wr_data_local;
          `RD_NORMAL_REG(i, top_test_cfg.pads, top_test_cfg.rd_data);
          if(top_test_cfg.rd_data != wr_data_local)begin
            `nnc_error(get_full_name(), $sformatf("A2D SPARE REG VALUE MISMATCH!!! addr=%0h, wr_data_local = %h, rd_data=%h", i, wr_data_local, top_test_cfg.rd_data));
          end
          //release `ANA_TOP.A2D_SPARE_TRIM_SW0;
        end
        else begin
          if(i==`SOC_IMEAS_MODE_REG) begin  // connectivity check between analog and digital reg     
	    `RD_NORMAL_REG(`SOC_IMEAS_MODE_REG, top_test_cfg.pads, top_test_cfg.rd_data);
            if(top_test_cfg.rd_data[2] !== `DUT_IF.sign_en)begin // rd_data[2] : format_sel
	    `nnc_error(get_full_name(), $sformatf(" MISMATCH in sign_en connectivity , reg value=%0d, Imeas signal value%0d ", top_test_cfg.rd_data[2],`DUT_IF.sign_en));
            end
          end

          assert(top_test_cfg.randomize() with {reg_addr == i;mask == mask_local; wr_data == wr_data_local;});
          `WR_RD_CHK_NORMAL_REG(top_test_cfg.reg_addr, top_test_cfg.wr_data, top_test_cfg.pads,top_test_cfg.mask);
        end
      end
    end

    `nnc_info("SOC_TEST - PART II", "Calling done for check_reg_wr_rd_values task ", UVM_LOW)

  endtask : check_reg_wr_rd_values

  // ------------------------------
  // Declare the report_phase task
  // ------------------------------
  function void report_phase(nnc_phase phase) ;
  super.report_phase(phase);
  endfunction

endclass : `TESTNAME
