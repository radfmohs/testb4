/////////////////////////////////////////////////////////
////----------------------------------------------------
////-- author:zhen
////
////-- module:ppg_controller
////
////-- discription:ppg controller there are four LED drives in this ppg system:
////                   red-> led A; infred-> led B; green1-> led C; green2-> led D
////
////-- data:11/3/2024
////
////-- version:version
////
////----------------------------------------------------
/////////////////////////////////////////////////////////

module ppg_controller(
//input 
  // clock && reset
input wire       OSC_256K,  //256k clock
input wire       rst_n,     
input wire       scan_en,
  // config signal
input wire [7:0] ppg_TIA_IDAC,
input wire       ppg_enable,
input wire       ppg_IDAC_LED_SEL,
input wire [2:0] ppg_Mode_sel,
input wire [3:0] ppg_TIA_GAIN,
input wire [3:0] ppg_led_time_sel,
input wire [3:0] ppg_led_Freq_sel,
//
//new added by Xin 26Mar2026
input       wire          PPG_LED_PROG_SEL,
input 	wire   [13:0] led_on,
input 	wire   [13:0] led_freq,

//ppg
input wire       sync_by_pass,
input wire [7:0] spi_to_ppg_TIA_IDAC, 
input wire [3:0] spi_to_ppg_TIA_GAIN,
input wire       spi_to_ppg_LEDDAC_SEL       ,
input wire [1:0] spi_to_ppg_LEDSEL           ,
input wire       spi_to_ppg_LED_STANDBYEN    ,
input wire       spi_to_ppg_LED_EN           ,
input wire       spi_to_ppg_EN_PPG_AF        ,
input wire       spi_to_ppg_PPG_SH_CK        ,
input wire       spi_to_ppg_EN_PPG_SH        ,
input wire       spi_to_ppg_EN_TIA           ,
input wire       spi_to_ppg_EN_TIA_VREFBUFFER,
input wire       spi_to_ppg_EN_PPG_BUFFER    ,
input wire       spi_to_ppg_EN_PPGDAC_BUFFER ,

input wire  [11:0] spi_to_ppg_PPG_DAC0_VSEL,
input wire         spi_to_ppg_PPG_DAC0_EN,
input wire  [11:0] spi_to_ppg_PPG_DAC1_VSEL,
input wire         spi_to_ppg_PPG_DAC1_EN,
input wire  [1:0]  spi_to_ppg_PPG_TEST_OUT,
input wire  [1:0]  spi_to_ppg_PPG_TEST_IN,
input wire  [1:0]  spi_to_ppg_PPG_PDV_REF_SEL,

output wire  [11:0] PPG_DAC0_VSEL,
output wire         PPG_DAC0_EN,
output wire  [11:0] PPG_DAC1_VSEL,
output wire         PPG_DAC1_EN,
output wire  [1:0]  PPG_TEST_OUT,
output wire  [1:0]  PPG_TEST_IN,
output wire  [1:0]  PPG_PDV_REF_SEL,
  
output wire [7:0]  D2A_TIA_IDAC,        
output wire	   D2A_LEDDAC_SEL,       
output wire [1:0]  D2A_LEDSEL,           
output wire	   D2A_LED_STANDBYEN,    
output wire	   D2A_LED_EN,           
output wire	   D2A_EN_PPG_AF,        
output wire	   D2A_PPG_SH_CK,        
output wire	   D2A_EN_PPG_SH,        
output wire	   D2A_EN_TIA ,          
output wire	   D2A_EN_TIA_VREFBUFFER,        	                                    
output wire [3:0]  D2A_TIA_GAIN,
output wire        D2A_EN_PPG_BUFFER,
output wire        D2A_EN_PPGDAC_BUFFER,
output wire        LED_STATUS       

);


//-----------------
//signal define
//-----------------

wire       OSC_256K_gate;

wire       EN_PPG_AF_fsm;
wire       EN_PPG_BUFFER_fsm;
wire       EN_PPG_SH_fsm;
wire       EN_TIA_fsm;
wire       EN_TIA_BUFFER_fsm;
wire [7:0] TIA_IDAC_fsm;
wire       PPG_SH_CK_fsm;
wire       LED_STANDBY_fsm;
wire       LED_EN_fsm;
wire [1:0] LEDSEL_fsm;    
wire       LED_STATUS_fsm;
wire       leddca_sel_fsm;
wire [3:0] TIA_GAIN_fsm;

wire       led1_working;
wire       led2_working;
reg Sig_Sel_sync1,Sig_Sel_sync2,Sig_Sel_sync3;
wire       Sig_Sel_sync3_dly;


wire       drvh_standby_en ;
wire       drvh_ledortia_en;
wire       drvh_shck_en    ;
wire       drvh_aforbuff_en;
wire       drvh_status_en  ;

wire       drvl_standby_en ;
wire       drvl_ledortia_en;
wire       drvl_shck_en    ;
wire       drvl_aforbuff_en;
wire       drvl_status_en  ;

wire       sync_by_pass_sync;
wire [7:0] spi_to_ppg_TIA_IDAC_sync;
wire [3:0] spi_to_ppg_TIA_GAIN_sync;
wire       spi_to_ppg_LEDDAC_SEL_sync;       
wire [1:0] spi_to_ppg_LEDSEL_sync;           
wire       spi_to_ppg_LED_STANDBYEN_sync;    
wire       spi_to_ppg_LED_EN_sync;           
wire       spi_to_ppg_EN_PPG_AF_sync;        
wire       spi_to_ppg_PPG_SH_CK_sync;        
wire       spi_to_ppg_EN_PPG_SH_sync;        
wire       spi_to_ppg_EN_TIA_sync;           
wire       spi_to_ppg_EN_TIA_VREFBUFFER_sync;
wire       spi_to_ppg_EN_PPG_BUFFER_sync;    
wire       spi_to_ppg_EN_PPGDAC_BUFFER_sync; 

wire  [11:0] spi_to_ppg_PPG_DAC0_VSEL_sync;
wire         spi_to_ppg_PPG_DAC0_EN_sync;
wire  [11:0] spi_to_ppg_PPG_DAC1_VSEL_sync;
wire         spi_to_ppg_PPG_DAC1_EN_sync;
wire  [1:0]  spi_to_ppg_PPG_TEST_OUT_sync;
wire  [1:0]  spi_to_ppg_PPG_TEST_IN_sync;
wire  [1:0]  spi_to_ppg_PPG_PDV_REF_SEL_sync;

wire [7:0] spi_to_ppg_TIA_IDAC_temp;
wire [3:0] spi_to_ppg_TIA_GAIN_temp;
wire       spi_to_ppg_LEDDAC_SEL_temp;       
wire [1:0] spi_to_ppg_LEDSEL_temp;           
wire       spi_to_ppg_LED_STANDBYEN_temp;    
wire       spi_to_ppg_LED_EN_temp;           
wire       spi_to_ppg_EN_PPG_AF_temp;        
wire       spi_to_ppg_PPG_SH_CK_temp;        
wire       spi_to_ppg_EN_PPG_SH_temp;        
wire       spi_to_ppg_EN_TIA_temp;           
wire       spi_to_ppg_EN_TIA_VREFBUFFER_temp;
wire       spi_to_ppg_EN_PPG_BUFFER_temp;    
wire       spi_to_ppg_EN_PPGDAC_BUFFER_temp; 

wire [7:0] ppg_TIA_IDAC_sync;
wire       ppg_enable_sync;
wire       ppg_IDAC_LED_SEL_sync;
wire [2:0] ppg_Mode_sel_sync;
wire [3:0] ppg_TIA_GAIN_sync;
wire [3:0] ppg_led_time_sel_sync;
wire [3:0] ppg_led_Freq_sel_sync;

wire       OSC_256K_sync_gate;

common_clock_gate u_OSC_256K_sync_gate(
.clk(OSC_256K),
.enable(!sync_by_pass_sync),
.bypass(scan_en),
.gated_clk(OSC_256K_sync_gate) 
);

common_sync_bit     u_ppg_led_Freq_sel_sync[3:0](
.clk(OSC_256K_gate),
.rst_(rst_n),
.async_in(ppg_led_Freq_sel),
.sync_out(ppg_led_Freq_sel_sync)
);

common_sync_bit     u_ppg_led_time_sel_sync[3:0](
.clk(OSC_256K_gate),
.rst_(rst_n),
.async_in(ppg_led_time_sel),
.sync_out(ppg_led_time_sel_sync)
);

common_sync_bit     u_ppg_TIA_GAIN_sync[3:0](
.clk(OSC_256K),
.rst_(rst_n),
.async_in(ppg_TIA_GAIN),
.sync_out(ppg_TIA_GAIN_sync)
);

common_sync_bit     u_ppg_Mode_sel_sync[2:0](
.clk(OSC_256K_gate),
.rst_(rst_n),
.async_in(ppg_Mode_sel),
.sync_out(ppg_Mode_sel_sync)
);

common_sync_bit     u_ppg_IDAC_LED_SEL_sync(
.clk(OSC_256K),
.rst_(rst_n),
.async_in(ppg_IDAC_LED_SEL),
.sync_out(ppg_IDAC_LED_SEL_sync)
);

common_sync_bit     u_ppg_enable_sync(
.clk(OSC_256K),
.rst_(rst_n),
.async_in(ppg_enable),
.sync_out(ppg_enable_sync)
);

common_sync_bit     u_ppg_TIA_IDAC_sync[7:0](
.clk(OSC_256K),
.rst_(rst_n),
.async_in(ppg_TIA_IDAC),
.sync_out(ppg_TIA_IDAC_sync)
);


//ppg spi
common_sync_bit     u_spi_to_ppg_EN_PPGDAC_BUFFER_sync(
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_EN_PPGDAC_BUFFER),
.sync_out(spi_to_ppg_EN_PPGDAC_BUFFER_sync)
);

common_sync_bit     u_spi_to_ppg_EN_PPG_BUFFER_sync(
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_EN_PPG_BUFFER),
.sync_out(spi_to_ppg_EN_PPG_BUFFER_sync)
);

common_sync_bit     u_spi_to_ppg_EN_TIA_VREFBUFFER_sync(
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_EN_TIA_VREFBUFFER),
.sync_out(spi_to_ppg_EN_TIA_VREFBUFFER_sync)
);

common_sync_bit     u_spi_to_ppg_EN_TIA_sync(
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_EN_TIA),
.sync_out(spi_to_ppg_EN_TIA_sync)
);

common_sync_bit     u_spi_to_ppg_EN_PPG_SH_sync(
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_EN_PPG_SH),
.sync_out(spi_to_ppg_EN_PPG_SH_sync)
);

common_sync_bit     u_spi_to_ppg_PPG_SH_CK_sync(
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_PPG_SH_CK),
.sync_out(spi_to_ppg_PPG_SH_CK_sync)
);

common_sync_bit     u_spi_to_ppg_EN_PPG_AF_sync(
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_EN_PPG_AF),
.sync_out(spi_to_ppg_EN_PPG_AF_sync)
);

common_sync_bit     u_spi_to_ppg_LED_EN_sync(
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_LED_EN),
.sync_out(spi_to_ppg_LED_EN_sync)
);

common_sync_bit     u_spi_to_ppg_LED_STANDBYEN_sync(
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_LED_STANDBYEN),
.sync_out(spi_to_ppg_LED_STANDBYEN_sync)
);

common_sync_bit     u_spi_to_ppg_LEDSEL_sync [1:0](
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_LEDSEL),
.sync_out(spi_to_ppg_LEDSEL_sync)
);

common_sync_bit     u_spi_to_ppg_LEDDAC_SEL_sync(
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_LEDDAC_SEL),
.sync_out(spi_to_ppg_LEDDAC_SEL_sync)
);

common_sync_bit     u_spi_to_ppg_TIA_GAIN_sync [3:0](
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_TIA_GAIN),
.sync_out(spi_to_ppg_TIA_GAIN_sync)
);

common_sync_bit     u_spi_to_ppg_TIA_IDAC_sync [7:0](
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_TIA_IDAC),
.sync_out(spi_to_ppg_TIA_IDAC_sync)
);

common_sync_bit     u_sync_by_pass_sync(
.clk(OSC_256K),
.rst_(rst_n),
.async_in(sync_by_pass),
.sync_out(sync_by_pass_sync)
);

//just sync

common_sync_bit     u_spi_to_ppg_PPG_DAC0_VSEL_sync[11:0](
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_PPG_DAC0_VSEL),
.sync_out(spi_to_ppg_PPG_DAC0_VSEL_sync)
);

common_sync_bit     u_spi_to_ppg_PPG_DAC0_EN_sync(
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_PPG_DAC0_EN),
.sync_out(spi_to_ppg_PPG_DAC0_EN_sync)
);

common_sync_bit     u_spi_to_ppg_PPG_DAC1_VSEL_sync[11:0](
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_PPG_DAC1_VSEL),
.sync_out(spi_to_ppg_PPG_DAC1_VSEL_sync)
);

common_sync_bit     u_spi_to_ppg_PPG_DAC1_EN_sync(
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_PPG_DAC1_EN),
.sync_out(spi_to_ppg_PPG_DAC1_EN_sync)
);

common_sync_bit     u_spi_to_ppg_PPG_TEST_OUT_sync[1:0](
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_PPG_TEST_OUT),
.sync_out(spi_to_ppg_PPG_TEST_OUT_sync)
);

common_sync_bit     u_spi_to_ppg_PPG_TEST_IN_sync[1:0](
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_PPG_TEST_IN),
.sync_out(spi_to_ppg_PPG_TEST_IN_sync)
);

common_sync_bit     u_spi_to_ppg_PPG_PDV_REF_SEL_sync[1:0](
.clk(OSC_256K_sync_gate),
.rst_(rst_n),
.async_in(spi_to_ppg_PPG_PDV_REF_SEL),
.sync_out(spi_to_ppg_PPG_PDV_REF_SEL_sync)
);



///by pass
assign spi_to_ppg_TIA_IDAC_temp          = !sync_by_pass_sync? spi_to_ppg_TIA_IDAC_sync          : spi_to_ppg_TIA_IDAC         ; 
assign spi_to_ppg_TIA_GAIN_temp          = !sync_by_pass_sync? spi_to_ppg_TIA_GAIN_sync          : spi_to_ppg_TIA_GAIN         ;
assign spi_to_ppg_LEDDAC_SEL_temp        = !sync_by_pass_sync? spi_to_ppg_LEDDAC_SEL_sync        : spi_to_ppg_LEDDAC_SEL       ; 
assign spi_to_ppg_LEDSEL_temp            = !sync_by_pass_sync? spi_to_ppg_LEDSEL_sync            : spi_to_ppg_LEDSEL           ; 
assign spi_to_ppg_LED_STANDBYEN_temp     = !sync_by_pass_sync? spi_to_ppg_LED_STANDBYEN_sync     : spi_to_ppg_LED_STANDBYEN    ;
assign spi_to_ppg_LED_EN_temp            = !sync_by_pass_sync? spi_to_ppg_LED_EN_sync            : spi_to_ppg_LED_EN           ;
assign spi_to_ppg_EN_PPG_AF_temp         = !sync_by_pass_sync? spi_to_ppg_EN_PPG_AF_sync         : spi_to_ppg_EN_PPG_AF        ;
assign spi_to_ppg_PPG_SH_CK_temp         = !sync_by_pass_sync? spi_to_ppg_PPG_SH_CK_sync         : spi_to_ppg_PPG_SH_CK        ;
assign spi_to_ppg_EN_PPG_SH_temp         = !sync_by_pass_sync? spi_to_ppg_EN_PPG_SH_sync         : spi_to_ppg_EN_PPG_SH        ;
assign spi_to_ppg_EN_TIA_temp            = !sync_by_pass_sync? spi_to_ppg_EN_TIA_sync            : spi_to_ppg_EN_TIA           ;
assign spi_to_ppg_EN_TIA_VREFBUFFER_temp = !sync_by_pass_sync? spi_to_ppg_EN_TIA_VREFBUFFER_sync : spi_to_ppg_EN_TIA_VREFBUFFER;
assign spi_to_ppg_EN_PPG_BUFFER_temp     = !sync_by_pass_sync? spi_to_ppg_EN_PPG_BUFFER_sync     : spi_to_ppg_EN_PPG_BUFFER    ;
assign spi_to_ppg_EN_PPGDAC_BUFFER_temp  = !sync_by_pass_sync? spi_to_ppg_EN_PPGDAC_BUFFER_sync  : spi_to_ppg_EN_PPGDAC_BUFFER ;  
                                 
assign PPG_DAC0_VSEL   = !sync_by_pass_sync? spi_to_ppg_PPG_DAC0_VSEL_sync   : spi_to_ppg_PPG_DAC0_VSEL  ; 
assign PPG_DAC0_EN     = !sync_by_pass_sync? spi_to_ppg_PPG_DAC0_EN_sync     : spi_to_ppg_PPG_DAC0_EN    ; 
assign PPG_DAC1_VSEL   = !sync_by_pass_sync? spi_to_ppg_PPG_DAC1_VSEL_sync   : spi_to_ppg_PPG_DAC1_VSEL  ; 
assign PPG_DAC1_EN     = !sync_by_pass_sync? spi_to_ppg_PPG_DAC1_EN_sync     : spi_to_ppg_PPG_DAC1_EN    ; 
assign PPG_TEST_OUT    = !sync_by_pass_sync? spi_to_ppg_PPG_TEST_OUT_sync    : spi_to_ppg_PPG_TEST_OUT   ; 
assign PPG_TEST_IN     = !sync_by_pass_sync? spi_to_ppg_PPG_TEST_IN_sync     : spi_to_ppg_PPG_TEST_IN    ; 
assign PPG_PDV_REF_SEL = !sync_by_pass_sync? spi_to_ppg_PPG_PDV_REF_SEL_sync : spi_to_ppg_PPG_PDV_REF_SEL; 



//mux fsm with spi

////mux to ppg
assign D2A_TIA_IDAC           =  ppg_enable? TIA_IDAC_fsm         : spi_to_ppg_TIA_IDAC_temp         ;
assign D2A_LEDDAC_SEL         =  ppg_enable? leddca_sel_fsm       : spi_to_ppg_LEDDAC_SEL_temp       ;
assign D2A_LEDSEL             =  ppg_enable? LEDSEL_fsm           : spi_to_ppg_LEDSEL_temp           ;
assign D2A_LED_STANDBYEN      =  ppg_enable? LED_STANDBY_fsm      : spi_to_ppg_LED_STANDBYEN_temp    ;
assign D2A_LED_EN             =  ppg_enable? LED_EN_fsm           : spi_to_ppg_LED_EN_temp           ;
assign D2A_EN_PPG_AF          =  ppg_enable? EN_PPG_AF_fsm        : spi_to_ppg_EN_PPG_AF_temp        ;
assign D2A_PPG_SH_CK          =  ppg_enable? PPG_SH_CK_fsm        : spi_to_ppg_PPG_SH_CK_temp        ;
assign D2A_EN_PPG_SH          =  ppg_enable? EN_PPG_SH_fsm        : spi_to_ppg_EN_PPG_SH_temp        ;
assign D2A_EN_TIA             =  ppg_enable? EN_TIA_fsm           : spi_to_ppg_EN_TIA_temp           ;
assign D2A_EN_TIA_VREFBUFFER  =  ppg_enable? EN_TIA_BUFFER_fsm    : spi_to_ppg_EN_TIA_VREFBUFFER_temp;
assign D2A_TIA_GAIN           =  ppg_enable? TIA_GAIN_fsm         : spi_to_ppg_TIA_GAIN_temp         ;
assign D2A_EN_PPG_BUFFER      =  ppg_enable? EN_PPG_BUFFER_fsm    : spi_to_ppg_EN_PPG_BUFFER_temp    ;
assign D2A_EN_PPGDAC_BUFFER   =  ppg_enable? EN_PPG_BUFFER_fsm    : spi_to_ppg_EN_PPGDAC_BUFFER_temp ;
assign LED_STATUS             =  ppg_enable? LED_STATUS_fsm       : 1'b0;

always @( posedge OSC_256K  or negedge rst_n)begin
    if(!rst_n) begin
    Sig_Sel_sync1 <= 1'b0;
    Sig_Sel_sync2 <= 1'b0; 
    Sig_Sel_sync3 <= 1'b0;   
    end
    else begin
    Sig_Sel_sync1 <= ppg_enable_sync;
    Sig_Sel_sync2 <= Sig_Sel_sync1; 
    Sig_Sel_sync3 <= Sig_Sel_sync2;    
    end    
end

ppg_cell_dly u_cell_dly (.A(Sig_Sel_sync3), .Y(Sig_Sel_sync3_dly));

common_clock_gate u_sysclk(
.clk(OSC_256K),
.enable(Sig_Sel_sync3_dly),
.bypass(scan_en),
.gated_clk(OSC_256K_gate) 
);

//-----------------
//module instance
//-----------------
//fsm
ppg_fsm u_ppg_fsm(
//input
.OSC_256K      (OSC_256K_gate),
.rst_n         (rst_n),
.Freq_ctrl     (ppg_led_Freq_sel_sync),
.Sig_Sel       (ppg_enable_sync),
.on_time_sel   (ppg_led_time_sel_sync),

//new added by Xin 26Mar2026
.scan_en(scan_en),
.PPG_LED_PROG_SEL (PPG_LED_PROG_SEL),
.led_on (led_on),
.led_freq (led_freq),

//output
.led1_working         (led1_working),
.led2_working         (led2_working),

.drvh_standby_en      (drvh_standby_en),
.drvh_ledortia_en     (drvh_ledortia_en),
.drvh_shck_en         (drvh_shck_en),
.drvh_aforbuff_en     (drvh_aforbuff_en),
.drvh_status_en       (drvh_status_en),
.drvl_standby_en      (drvl_standby_en),
.drvl_ledortia_en     (drvl_ledortia_en),
.drvl_shck_en         (drvl_shck_en),
.drvl_aforbuff_en     (drvl_aforbuff_en),
.drvl_status_en       (drvl_status_en)
);

//output
ppg_outdrv u_ppg_outdrv(
.OSC_256K       (OSC_256K),
.OSC_256K_gate  (OSC_256K_gate),
.rst_n          (rst_n),
.IDAC_LEDSEL    (ppg_IDAC_LED_SEL_sync),
.TIA_IDAC_in    (ppg_TIA_IDAC_sync),
.Mode_sel       (ppg_Mode_sel_sync),
.TIA_GAIN_temp  (ppg_TIA_GAIN_sync),

.led1_working         (led1_working),
.led2_working         (led2_working),	
.drvh_standby_en      (drvh_standby_en),
.drvh_ledortia_en     (drvh_ledortia_en),
.drvh_shck_en         (drvh_shck_en),
.drvh_aforbuff_en     (drvh_aforbuff_en),
.drvh_status_en       (drvh_status_en),
.drvl_standby_en      (drvl_standby_en),
.drvl_ledortia_en     (drvl_ledortia_en),
.drvl_shck_en         (drvl_shck_en),
.drvl_aforbuff_en     (drvl_aforbuff_en),
.drvl_status_en       (drvl_status_en),

.EN_PPG_AF_fsm        (EN_PPG_AF_fsm    ),
.EN_PPG_BUFFER_fsm    (EN_PPG_BUFFER_fsm),
.EN_PPG_SH_fsm        (EN_PPG_SH_fsm    ),
.EN_TIA_fsm           (EN_TIA_fsm       ),
.EN_TIA_BUFFER_fsm    (EN_TIA_BUFFER_fsm),
.TIA_IDAC_fsm         (TIA_IDAC_fsm     ),
.PPG_SH_CK_fsm        (PPG_SH_CK_fsm    ),
.LED_STANDBY_fsm      (LED_STANDBY_fsm  ),
.LED_EN_fsm           (LED_EN_fsm       ),
.LEDSEL_fsm           (LEDSEL_fsm      ),
//.LED2SEL_fsm          (LED2SEL_fsm      ),
.leddca_sel           (leddca_sel_fsm   ),
.TIA_GAIN_fsm         (TIA_GAIN_fsm),
.LED_STATUS           (LED_STATUS_fsm   )

);
endmodule

