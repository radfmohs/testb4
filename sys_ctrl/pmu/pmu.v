/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/* File Name	: cmsdk_mcu_pmu.v                                                       */
/* Project	: Nanochap Glucose Chip                                                     */
/* Description	: power management  unit                                                */
/* Designer	: Daniel Wang                                                               */
/* Date		: 05/30/2019                                                                */
/* Revision	:                                                                           */
/* R001 first draft                 05/30/2019                                          */
/* R002 add flash_dpstb             07/30/2019                                          */
/* R003 add psw_wake event          11/19/2019                                          */
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
module pmu (
input  wire         hfosc_atpg,                 // high frequency clock
input  wire         poresetn_hf,             // global reset hfclk domain
input  wire         atpg_en,              // atpg enable
input  wire         pmuenable,            // pmu enable
input  wire         hresetreq,            // system reset request
input  wire         sleepdeep,            // system enters deep-sleep state
input  wire         flash_dpstb_en,       // flash deep power down standby mode enable
input  wire         flash_por_resetn,     // flash por reset

input  wire 	    ppg_ctrl_disable,
output wire 	    ppg_ctrl_en,
input  wire 	    bio_disable,
output wire 	    bio_enable,

output wire         pmu_fclk_en,          // fclk enable when in idle state
output wire         flash_dpstb           // flash deep power down standby mode
);

parameter  IDLE             = 2'b00;
parameter  DEEP_SLEEP       = 2'b01;
parameter  WAIT_CLK_STABLE  = 2'b10;

parameter  WAIT_COUNT  = 8'b10000;

wire  wakeup_all;
wire  enter_dpslp;

reg   [1:0]   pmu_cur;
reg   [1:0]   pmu_nxt;

reg   [7:0]  clk_stable_cnt;
wire          cnt_done;
wire          pmu_idle;
wire          pmu_dpslp;
wire          pmu_wait_stclk;

//reg           reg_hfosc_en;

reg           flash_dpstb_reg;

wire		hresetreq_sync;
wire		pmuenable_sync;
wire		sleepdeep_sync;

// hresetreq cdc
common_sync_bit u_hresetreq_cdc(
.async_in(hresetreq),
.clk(hfosc_atpg),
.rst_(poresetn_hf),
.sync_out(hresetreq_sync)
);

// all wakeup event for deep-sleep mode
assign wakeup_all = hresetreq_sync;

// pmuenable cdc
common_sync_bit u_pmuenable_cdc(
.async_in(pmuenable),
.clk(hfosc_atpg),
.rst_(poresetn_hf),
.sync_out(pmuenable_sync)
);

// sleepdeep cdc
common_sync_bit u_sleepdeep_cdc(
.async_in(sleepdeep),
.clk(hfosc_atpg),
.rst_(poresetn_hf),
.sync_out(sleepdeep_sync)
);

wire flash_dpstb_en_sync;
common_sync_bit u_flash_dpstb_en_cdc(
.async_in(flash_dpstb_en),
.clk(hfosc_atpg),
.rst_(poresetn_hf),
.sync_out(flash_dpstb_en_sync)
);

common_sync_bit u_ppg_ctrl_cdc(
.async_in(~ppg_ctrl_disable),
.clk(hfosc_atpg),
.rst_(poresetn_hf),
.sync_out(ppg_ctrl_en)
);

common_sync_bit u_bio_cdc(
.async_in(~bio_disable),
.clk(hfosc_atpg),
.rst_(poresetn_hf),
.sync_out(bio_enable)
);

// enter deep sleep condition
assign enter_dpslp = pmuenable_sync & sleepdeep_sync & ~wakeup_all;
// pmu state fsm
always @ (posedge hfosc_atpg or negedge poresetn_hf) begin
  if (~poresetn_hf)
    pmu_cur <= IDLE;
  else
    pmu_cur <= pmu_nxt;
end

always @ (*) begin
  case (pmu_cur)
  IDLE: begin
    if (enter_dpslp)
      pmu_nxt = DEEP_SLEEP;
    else
      pmu_nxt = IDLE;
  end
  DEEP_SLEEP: begin
    if (wakeup_all)
      pmu_nxt = WAIT_CLK_STABLE;
    else
      pmu_nxt = DEEP_SLEEP;
  end
  WAIT_CLK_STABLE: begin
    if (cnt_done)
      pmu_nxt = IDLE;
    else
      pmu_nxt = WAIT_CLK_STABLE;
  end
  default: pmu_nxt = IDLE;
  endcase
end

assign pmu_idle       = (pmu_cur == IDLE);
assign pmu_dpslp      = (pmu_cur == DEEP_SLEEP);
assign pmu_wait_stclk = (pmu_cur == WAIT_CLK_STABLE);

// wait clock stable count
assign cnt_done = (clk_stable_cnt == WAIT_COUNT);

always @ (posedge hfosc_atpg or negedge poresetn_hf) begin
  if (~poresetn_hf)
    clk_stable_cnt <= 8'b0;
  else if (cnt_done)
    clk_stable_cnt <= 8'b0;
  else if (pmu_wait_stclk)
    clk_stable_cnt <= clk_stable_cnt + 1'b1;
  else
    clk_stable_cnt <= clk_stable_cnt;
end

// flash deep power down standby mode
always @(posedge hfosc_atpg or negedge flash_por_resetn) begin
  if (~flash_por_resetn)
    flash_dpstb_reg <= 1'b0;
  else
    //flash_dpstb_reg <= pmu_dpslp & flash_dpstb_en; 
    flash_dpstb_reg <= pmu_dpslp & flash_dpstb_en_sync; 
end

assign flash_dpstb = atpg_en ? 1'b0 : flash_dpstb_reg;

// pmu_fclk_en_ cdc
/*
common_sync_bit u_pmu_sclk_en_cdc(
.async_in(pmu_idle),
.clk(hfosc_atpg),
.rst_(poresetn_hf),
.sync_out(pmu_fclk_en)
);
*/
assign pmu_fclk_en = pmu_idle;

endmodule

