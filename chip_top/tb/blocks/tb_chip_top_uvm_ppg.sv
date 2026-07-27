
nnc_ppg_input_interface               ppg_vif();

assign   ppg_vif.sys_clk                                          =    `PPG_TOP.OSC_256K           ;
assign   ppg_vif.soc_resetn                                       =    `PPG_TOP.rst_n              ;  
assign   ppg_vif.TIA_IDAC                                         =    `PPG_TOP.ppg_TIA_IDAC       ;   
assign   ppg_vif.IDAC_LEDSEL                                      =    `PPG_TOP.ppg_IDAC_LED_SEL   ;   
assign   ppg_vif.sig_sel                                          =    `PPG_TOP.ppg_enable         ;   
assign   ppg_vif.mode_sel                                         =    `PPG_TOP.ppg_Mode_sel       ;   
assign   ppg_vif.TIA_GAIN                                         =    `PPG_TOP.ppg_TIA_GAIN       ;   
assign   ppg_vif.on_time_sel                                      =    `PPG_TOP.ppg_led_time_sel   ;
assign   ppg_vif.freq_ctrl                                        =    `PPG_TOP.ppg_led_Freq_sel   ;   
assign   ppg_vif.sync_en                                          =    `PPG_TOP.sync_by_pass       ;
assign   ppg_vif.nnc_ppg_led_scb_en                               =     1'b0 ;               


// =================================
// PPG_LED virtual interface 
// =================================
                    
  nnc_ppg_led_interface       out_if();                    

                     
assign out_if.EN_PPG_AF_out             =  /*`PPG_TOP.D2A_EN_PPG_AF           ;*/`ANA_TOP.D2A_EN_PPG_AF           ;      
assign out_if.EN_PPG_BUFFER_out         =  /*`PPG_TOP.D2A_EN_PPG_BUFFER       ;*/`ANA_TOP.D2A_EN_PPG_BUFFER       ;      
assign out_if.EN_PPGDAC_BUFFER_out      =  /*`PPG_TOP.D2A_EN_PPGDAC_BUFFER    ;*/`ANA_TOP.D2A_EN_PPGDAC_BUFFER    ; //
assign out_if.EN_PPG_SH_out             =  /*`PPG_TOP.D2A_EN_PPG_SH           ;*/`ANA_TOP.D2A_EN_PPG_SH           ;      
assign out_if.EN_TIA_out                =  /*`PPG_TOP.D2A_EN_TIA              ;*/`ANA_TOP.D2A_EN_TIA              ;      
assign out_if.EN_TIA_BUFFER_out         =  /*`PPG_TOP.D2A_EN_TIA_VREFBUFFER   ;*/`ANA_TOP.D2A_EN_TIA_VREFBUFFER   ;      
assign out_if.TIA_IDAC_out              =  /*`PPG_TOP.D2A_TIA_IDAC            ;*/`ANA_TOP.D2A_TIA_IDAC            ;      
assign out_if.PPG_SH_CK_out             =  /*`PPG_TOP.D2A_PPG_SH_CK           ;*/`ANA_TOP.D2A_PPG_SH_CK           ;      
assign out_if.LED_STANDBY_out           =  /*`PPG_TOP.D2A_LED_STANDBYEN       ;*/`ANA_TOP.D2A_LED_STANDBYEN       ;      
assign out_if.LED_EN_out                =  /*`PPG_TOP.D2A_LED_EN              ;*/`ANA_TOP.D2A_LED_EN              ;      
assign out_if.LEDSEL_out                =  /*`PPG_TOP.D2A_LEDSEL              ;*/`ANA_TOP.D2A_LEDSEL              ;      
assign out_if.LED_STATUS                =  IOBUF_PAD[18]   /*`PPG_TOP.LED_STATUS*/          ;//`ANA_TOP.D2A_LED_STATUS          ; 
assign out_if.D2A_LEDDAC_SEL            =  /*`PPG_TOP.D2A_LEDDAC_SEL          ;*/`ANA_TOP.D2A_LEDDAC_SEL          ;
assign out_if.TIA_GAIN_out              =  /*`PPG_TOP.D2A_TIA_GAIN            ;*/`ANA_TOP.D2A_TIA_GAIN            ;


assign out_if.ppg_EN_PPG_AF             =   `PPG_TOP.spi_to_ppg_EN_PPG_AF            ;
assign out_if.ppg_EN_PPG_BUFFER         =   `PPG_TOP.spi_to_ppg_EN_PPG_BUFFER        ;
assign out_if.ppg_EN_PPGDAC_BUFFER      =   `PPG_TOP.spi_to_ppg_EN_PPGDAC_BUFFER     ;
assign out_if.ppg_EN_PPG_SH             =   `PPG_TOP.spi_to_ppg_EN_PPG_SH            ;
assign out_if.ppg_EN_TIA                =   `PPG_TOP.spi_to_ppg_EN_TIA               ;
assign out_if.ppg_EN_TIA_VREFBUFFER     =   `PPG_TOP.spi_to_ppg_EN_TIA_VREFBUFFER    ;
assign out_if.ppg_TIA_GAIN              =   `PPG_TOP.spi_to_ppg_TIA_GAIN             ;
assign out_if.ppg_TIA_IDAC              =   `PPG_TOP.spi_to_ppg_TIA_IDAC             ;
assign out_if.ppg_PPG_SH_CK             =   `PPG_TOP.spi_to_ppg_PPG_SH_CK            ;
assign out_if.ppg_LED_STANDBYEN         =   `PPG_TOP.spi_to_ppg_LED_STANDBYEN        ;
assign out_if.ppg_LED_EN                =   `PPG_TOP.spi_to_ppg_LED_EN               ;
assign out_if.ppg_LEDSEL                =   `PPG_TOP.spi_to_ppg_LEDSEL               ;
assign out_if.ppg_LEDDAC_SEL            =   `PPG_TOP.spi_to_ppg_LEDDAC_SEL           ; 
assign out_if.sys_clk                   =   `PPG_TOP.OSC_256K                        ;

assign out_if.EXP_EN_PPG_AF_out         =  '{ 'bz,     ppg_vif.sync_en? out_if.ppg_EN_PPG_AF         :out_if.mon.ppg_EN_PPG_AF        };       //ppg_vif.EN_PPG_AF      ;         
assign out_if.EXP_EN_PPG_BUFFER_out     =  '{ 'bz,     ppg_vif.sync_en? out_if.ppg_EN_PPG_BUFFER     :out_if.mon.ppg_EN_PPG_BUFFER    };       //ppg_vif.EN_PPG_BUFFER  ;        
assign out_if.EXP_EN_PPGDAC_BUFFER_out  =  '{ 'bz,     ppg_vif.sync_en? out_if.ppg_EN_PPGDAC_BUFFER  :out_if.mon.ppg_EN_PPGDAC_BUFFER };       //
assign out_if.EXP_EN_PPG_SH_out         =  '{ 'bz,     ppg_vif.sync_en? out_if.ppg_EN_PPG_SH         :out_if.mon.ppg_EN_PPG_SH        };       //ppg_vif.EN_PPG_SH      ;         
assign out_if.EXP_EN_TIA_out            =  '{ 'bz,     ppg_vif.sync_en? out_if.ppg_EN_TIA            :out_if.mon.ppg_EN_TIA           };       //ppg_vif.EN_TIA         ;         
assign out_if.EXP_EN_TIA_BUFFER_out     =  '{ 'bz,     ppg_vif.sync_en? out_if.ppg_EN_TIA_VREFBUFFER :out_if.mon.ppg_EN_TIA_VREFBUFFER    };       //ppg_vif.EN_TIA_VREFBUFFER  ;        
assign out_if.EXP_TIA_GAIN_out          =  '{ 'bz,     ppg_vif.sync_en? out_if.ppg_TIA_GAIN          :out_if.mon.ppg_TIA_GAIN         };
assign out_if.EXP_TIA_IDAC_out          =  '{ 'bz,     ppg_vif.sync_en? out_if.ppg_TIA_IDAC          :out_if.mon.ppg_TIA_IDAC         };       //ppg_vif.TIA_IDAC       ;         
assign out_if.EXP_PPG_SH_CK_out         =  '{ 'bz,     ppg_vif.sync_en? out_if.ppg_PPG_SH_CK         :out_if.mon.ppg_PPG_SH_CK        };       //ppg_vif.PPG_SH_CK      ;   
assign out_if.EXP_LED_STANDBY_out       =  '{ 'bz,     ppg_vif.sync_en? out_if.ppg_LED_STANDBYEN     :out_if.mon.ppg_LED_STANDBYEN      };       //ppg_vif.LED_STANDBY    ;         
assign out_if.EXP_LED_EN_out            =  '{ 'bz,     ppg_vif.sync_en? out_if.ppg_LED_EN            :out_if.mon.ppg_LED_EN           };       //ppg_vif.LED_EN         ;         
assign out_if.EXP_LEDSEL_out            =  '{ 'bz,     ppg_vif.sync_en? out_if.ppg_LEDSEL            :out_if.mon.ppg_LEDSEL           };       //ppg_vif.LED1SEL        ;      
assign out_if.EXP_LED_STATUS            =  '{ 'bz,      /*spi_to_ppg_LED_STATUS*/  'b0       };                
assign out_if.EXP_D2A_LEDDAC_SEL        =  '{ 'bz,     ppg_vif.sync_en? out_if.ppg_LEDDAC_SEL        :out_if.mon.ppg_LEDDAC_SEL }              ;

//run_checker         ppg_checker(ppg_vif, out_if);

initial begin
    nnc_config_db#(virtual nnc_ppg_input_interface)::set(uvm_root::get(), "uvm_test_top.top_env.ppg_env.ppg_mon", "ppg_vif", ppg_vif);
    nnc_config_db#(virtual nnc_ppg_led_interface)::set(uvm_root::get(), "uvm_test_top.top_env.ppg_env.ppg_mon", "out_if", out_if);
end

`define PPG_SCOREBOARD_EN  top_env.top_cfg.ppg_cfg.nnc_ppg_scoreboard_en
