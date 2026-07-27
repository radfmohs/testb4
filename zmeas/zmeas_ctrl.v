////////
// Design     	: zmeas_control_block
// Project      : glucose_chip
// Dependencies	: 
//              : 
// Description	: control block between register block and zmeas modules : 
//              : deciphering the register memory loaded by firmware and
//              : providing/accepting control/update signals to/from ph accumulator and
//              : zmeas_bwdctrl
//              : THIS MODULE IS TO BE IMPLEMENTED AS ALWAYS ON POWER DOMAIN
// Testbech   	: 
// Rev       	: 1.0 :  26april2019
//              : 1.1 :  1May2019: shifted freq-select to phjmp_ctrl from
//                                 eugeenc/dds_phacc.v to this level
//              : 1.2 :  17may 2019: qualified analog through signals like pga_gain on
//              :        INIT state
//              : 1.3 :  22may 2019: clcock gating, power gating
//              : 1.4 : 29 may2019: changed repeat cycle config option to have
//              : effect only during init phase
//              : 1.5 : reg status is now available even in powerdown and
//              :       standbby because digital is not really powered down so i dont
//              :       need to keep is always on type
//              : 1.6 : adc clock is tapped from mclkg instead of separate clk
//              :     : gate at the root to prevent different clk latencies
//              : 1.7 : bist bypass, reg_settling_time_val_init, separate adc clk gate
//              :     : removed. adc_clk=mclkg
//              : 1.8 : aug30 :: MAJOR CHANGE: settling time between init and
//              :     : calc to be calculated based on user intended freq (also jitter
//              :     : affects this). added separate counter for this delay.
//              :     : the jitter values(+-80khz on 4mhz) are incorporated in lil bit extra count. 
//              :     : SA confirmed that this won't hurt
//              : 1.9 : oct25 -- Replace zmeas_clock_gate from local rtl_zmeas_topinteg with common_clock_gate
//              :     : from TOP_CHIP/rtl/common_cells based on Daniel's recommendation
//              :     : No functional change just cell change
// Company    	: Nanochap
// Author     	: RS
////////

`include "zmeas_parameters.vh"

module zmeas_ctrl (
	//clk and reset
	input mclk, 
	input pclk, 
	output mclkg, 
	output wire mclkg_invert,
	input nrst, 
	input atpg_en,
	input scan_en,  //Tri add
	//input from f/w through apb interface
	input [15:0] reg_ctrl,
	input [2:0] reg_freq_val, 
	input [3:0] reg_number_of_repeat_cycle_val,
	input [7:0] reg_settling_time_val,
	//input from zmeas_bwdctrl
	input freq_meas_done,
	input [15:0] reg_real_data_val,
	input [15:0] reg_imag_data_val,
	//output to zmeas_rom, zmeas_bwdctrl and ph_acc
	output reg adc_enable,
	output wire adc_clk,
        output reg dds_enable,
        output reg [8:0] number_of_repeats_decoded,
        //output fwd_bwd_indicator, 
        //output [11:0]rom_addrs, 
	output reg [`PHJMP_BITS-1:0] freq_phjmp_reg,
	output reg [`PH_JMPDFT_BITS-1:0] freq_phjmpdft_reg,
	output reg [15:0] reg_status,
	//output to analog dds
        output reg measure_calibrate, //decided to accept values only during init phase and then keep unchanged 20may
        output reg [1:0] config_output_voltage_range, //ref:md on 29may
	output reg [31:0] reg_dataout,
        output reg pga_gain,
	//output reg [7:0] reg_settling_time_val_init,
        output reg zmeas_power_en
);

//reg
reg init_failed;
reg mclken;
reg start_counting_settling_time;
reg settling_time_flag;
reg [`USER_FREQ_OPTIONS_WIDTH-1:0] start_settling_time_counter;  //6 freq options. [32 16 8 4 2 1] = start_settling_time_counter [5 4 3 2 1 0]
reg [7:0] reg_settling_time_val_init;

//combo//

 // Gated mclk (mclkg) generation
 /*
  zmeas_clock_gate u_zmeas_clock_gate_mclkg(
    .clk       (mclk),
    .clkenable (mclken),
    .disableg  (atpg_en),
    .gatedclk  (mclkg));*/

 //Replace zmeas_clock_gate with common_clock_gate
 //V1.9 -- Oct25
  common_clock_gate u_zmeas_clock_gate_mclkg(
    .clk       (mclk),
    .enable    (mclken),
    .bypass    (scan_en),   //Tri change
    .gated_clk (mclkg));

assign adc_clk = mclkg;
//assign mclkg_invert = (atpg_en) ? mclkg : ~mclkg;
CLKMX2X4M DNT_ZMEAS_MCLKG_ATPG (.A(~mclkg), .B(mclkg), .S0(atpg_en), .Y(mclkg_invert));


//seq//

//START OF USER MODE (NOOP,INIT,START_CALC,STANDBY)CONTROLLED STATE MACHINE A
//1. to control dds_enable depending on ctrl_initialize and status_freq_calc_complete from f/w
//2. to control adc_enable depending on ctrl_start_calc and status_freq_calc_complete from f/w
//3. to set status register


//always @(posedge mclk or negedge nrst) begin
always @(posedge pclk or negedge nrst) begin //may 22: not tested yet
	if(!nrst) begin
		dds_enable <= 0;
		reg_status <= 0;
		adc_enable <= 0;
		freq_phjmp_reg <= 0;
		freq_phjmpdft_reg <= 0;
		init_failed <= 1;
                measure_calibrate <= 0;
                config_output_voltage_range[1:0] <= 0;
		reg_dataout <= 0;
                pga_gain <= 0;
		mclken <= 0;
		zmeas_power_en <= 0;
		number_of_repeats_decoded <= 0;
		reg_settling_time_val_init <= 0;
		start_counting_settling_time <= 0;
		start_settling_time_counter <= 0;
		//init_done  <= 0;
	end
	else begin
		case(reg_ctrl[15:13])
			`CTRL_INIT : begin
				start_counting_settling_time <= 0;
				if(reg_ctrl[0]==1) begin //if during calculataion, there is a request for reset measurement (i.e. DFT measurement):: on May 7: decided to reset whole zmeas block and start from init again after receiving this interrupt
						dds_enable <= 0;
						adc_enable <= 0;
				                reg_status <= 0;
                                                measure_calibrate <= 0;
                                                config_output_voltage_range[1:0] <= 0;
                                                pga_gain <= 0;
					end
				else begin
					if(mclken) begin //only if clk is active that is user followed correct seq of standby->noop->init->start_calc->f/w read->standby
				            dds_enable <= 1;
				            reg_status[15:0]  <= {{2{1'b0}},reg_number_of_repeat_cycle_val[3:0],reg_freq_val[2:0], reg_ctrl[5:4], reg_ctrl[6], reg_ctrl[2], 1'b0, 1'b0, 1'b0} ;
				            adc_enable <= 0;
					    init_failed <= 0;
                                            measure_calibrate <= reg_ctrl[6];
                                            config_output_voltage_range[1:0] <= reg_ctrl[5:4];
                                            pga_gain <= reg_ctrl[2];
                                            number_of_repeats_decoded <= (reg_ctrl[12]==1'b1) ? ((reg_number_of_repeat_cycle_val[3:0]==4'b0001) ? 9'b000000010 : ((reg_number_of_repeat_cycle_val[3:0]==4'b0010) ? 9'b000000100 : ((reg_number_of_repeat_cycle_val[3:0]==4'b0011) ? 9'b000001000 : ((reg_number_of_repeat_cycle_val[3:0]==4'b0100) ? 9'b000010000 : ((reg_number_of_repeat_cycle_val[3:0]==4'b0101) ? 9'b000100000 : ((reg_number_of_repeat_cycle_val[3:0]==4'b0110) ? 9'b001000000 : ((reg_number_of_repeat_cycle_val[3:0]==4'b0111) ? 9'b010000000 : ((reg_number_of_repeat_cycle_val[3:0]==4'b1000) ? 9'b100000000 : 9'b1)))))))) : 9'b1; 
					    reg_settling_time_val_init       <= reg_settling_time_val;
                                            case (reg_freq_val[2:0])
                                              `FREQ_SEL_500HZ    :  begin
                                                freq_phjmp_reg    <= `FREQ_500HZ_PHJMP;
                                                freq_phjmpdft_reg <= `FREQ_500HZ_PHJMPDFT;
                                                start_settling_time_counter <= 6'b000001;
                                               end
                                              `FREQ_SEL_1KHZ 	:  begin
                                                freq_phjmp_reg    <= `FREQ_1KHZ_PHJMP;
                                                freq_phjmpdft_reg <= `FREQ_1KHZ_PHJMPDFT;
						start_settling_time_counter <= 6'b000010;
                                               end
                                              `FREQ_SEL_2KHZ 	: begin
                                                freq_phjmp_reg <= `FREQ_2KHZ_PHJMP;
                                                freq_phjmpdft_reg <= `FREQ_2KHZ_PHJMPDFT;
						start_settling_time_counter <= 6'b000100;
                                               end
                                              `FREQ_SEL_4KHZ 	: begin
                                                freq_phjmp_reg <= `FREQ_4KHZ_PHJMP;
                                                freq_phjmpdft_reg <= `FREQ_4KHZ_PHJMPDFT;
						start_settling_time_counter <= 6'b001000;
                                               end
					      `FREQ_SEL_noop    : begin
                                                freq_phjmp_reg <= `FREQ_NOOP_PHJMP;
                                                freq_phjmpdft_reg <= `FREQ_NOOP_PHJMPDFT;
						start_settling_time_counter <= 6'b000000;
                                               end
                                              default		: begin
                                                freq_phjmp_reg <= `FREQ_NOOP_PHJMP;
                                                freq_phjmpdft_reg <= `FREQ_NOOP_PHJMPDFT;
						start_settling_time_counter <= 6'b000000;
                                               end
                                            endcase
				        end
					else begin
						dds_enable <= 0;
						adc_enable <= 0;
                                                measure_calibrate <= 0;
                                                config_output_voltage_range[1:0] <= 0;
                                                pga_gain <= 0;
					end
			        end
			end
			`CTRL_START_CALC : begin
				if(reg_ctrl[0]==1) begin 
						dds_enable <= 0;
						adc_enable <= 0;
				                reg_status[15:0]  <= {reg_status[15:3], 1'b0, 1'b0, 1'b0} ;
                                                measure_calibrate <= 0;
                                                config_output_voltage_range[1:0] <= 0;
                                                pga_gain <= 0;
						start_counting_settling_time <= 0;
				end
				else begin 
					if(dds_enable==1 && adc_enable == 0 && init_failed==0) begin
					        dds_enable <= dds_enable;
				                reg_status[15:0]  <= {reg_status[15:3], 1'b0, 1'b0, 1'b0} ;
						start_counting_settling_time <=  (settling_time_flag==1'b0)? 1'b1 : 1'b0;
					        adc_enable <= (settling_time_flag==1'b1) ? 1'b1 : 1'b0;
				        end
				        else if(dds_enable == 1 && adc_enable==1 && init_failed==0) begin
				        	if(freq_meas_done) begin
				        		dds_enable <= 0;
				                        reg_status[15:0]  <= {reg_status[15:3], 1'b1, 1'b1, 1'b1} ;
							reg_dataout <= {reg_imag_data_val,reg_real_data_val};
				        		adc_enable <= 0;
						        start_counting_settling_time <= 0;
				        	end
				        	else begin
				        		dds_enable <= dds_enable;
				        		reg_status[15:0] <= reg_status[15:0];
				        		adc_enable <= adc_enable;
						        start_counting_settling_time <= 0;
				        	end
				        end
				        else begin
				        	init_failed <= 1;
				        	dds_enable <= dds_enable;
				        	reg_status[15:0] <= reg_status[15:0];
				        	adc_enable <= adc_enable;
						start_counting_settling_time <= 0;
				        end
				end

			end
			`CTRL_PWR_DWN: begin
				dds_enable <= 0;
				adc_enable <= 0;				
				//reg_status <= 0;//since digital is not really powered down, decided to maintain status of last calculation even in power down
                                measure_calibrate <= 0;
                                config_output_voltage_range[1:0] <= 0;
                                pga_gain <= 0;
				mclken <= 0;//<disactivate_clock>;
				zmeas_power_en <= 0;//<disactivate_power>;
				start_counting_settling_time <= 0;
			end
			`CTRL_STANDBY: begin
				dds_enable <= 0;
				adc_enable <= 0;
                                measure_calibrate <= 0;
                                config_output_voltage_range[1:0] <= 0;
                                pga_gain <= 0;
				mclken <= 0;//<disactivate_clock>;
				start_counting_settling_time <= 0;
			end
			`CTRL_NO_OP : begin
				dds_enable <= 0;
				adc_enable <= 0;
				reg_status <= 0; //this indicates user want to start fresh calculation and has already read all the previous status. so noop is good point to reset the previous status
                                measure_calibrate <= 0;
                                config_output_voltage_range[1:0] <= 0;
                                pga_gain <= 0;
				mclken <= 1;//<activate_clock>;
				zmeas_power_en <= 1;//<activate_power>;
				start_counting_settling_time <= 0;
			end
			default: begin
				dds_enable <= 0;
				adc_enable <= 0;
				//reg_status <= 0; //maintain
                                measure_calibrate <= 0;
                                config_output_voltage_range[1:0] <= 0;
                                pga_gain <= 0;
				start_counting_settling_time <= 0;
			end
		endcase
	end //nrst
end //always


//START OF SETTLING TIME COUNTER TO ACCOMMODATE VARIATION IN SETTLING TIME TO REACH STEADY STATE AFTER DDS EXCITATION DUE TO
//DIFFERENT SKIN TYPE AND OUR CLOCK JITTER
//this counter works on mclkg because intention is only when INIT is done and user wants to start calculation,
//I want to wait for stimulation to settle so I start counting after that to enable adc  more so settling time is decided as per 4mhz

parameter IDLE          = 2'b00; 
parameter LOAD_WAIT_TIME= 2'b01;
parameter WAITING_COUNT = 2'b11;
//unused 2'b10;
reg [1:0] next_state;
reg [`USER_SETTLING_TIME_WAIT_COUNTER_LENGTH-1:0] wait_time;

always @(posedge mclkg or negedge nrst) begin //aug 30: not tested yet
	if(!nrst) begin
	  next_state <= IDLE;
          settling_time_flag <= 0;
	  wait_time <= 0;
	end
	else begin
		case(next_state)
			IDLE: begin
				next_state <= (start_counting_settling_time) ? LOAD_WAIT_TIME : IDLE;
		                settling_time_flag <= 0;
			end
			LOAD_WAIT_TIME: begin
		                settling_time_flag <= 0;
                                case(start_settling_time_counter)
                                        6'b000001: begin
                                                wait_time <= `SETTLING_TIME_FOR_500HZ * reg_settling_time_val_init;  //large multiplier in one cycle
                                                next_state <= WAITING_COUNT;
                                        end
	                                6'b000010: begin
						wait_time <= `SETTLING_TIME_FOR_1KHZ * reg_settling_time_val_init;  //large multiplier in one cycle
						next_state <= WAITING_COUNT;
	                                end
	                                6'b000100: begin
						wait_time <= `SETTLING_TIME_FOR_2KHZ * reg_settling_time_val_init;
						next_state <= WAITING_COUNT;
	                                end
	                                6'b001000: begin
						wait_time <= `SETTLING_TIME_FOR_4KHZ * reg_settling_time_val_init;
						next_state <= WAITING_COUNT;
	                                end
                                        default: begin
						wait_time <= {21{1'b0}};
						next_state <= IDLE;
	                                end
	                        endcase //settling_time_counter
			end //load
			WAITING_COUNT: begin
				if (wait_time == {21{1'b0}}) begin
					settling_time_flag <= 1;             // indication that user settling time for user freq is done and we can start calc
					next_state <= (adc_enable) ? IDLE : WAITING_COUNT; //adc enable makes sure that even if pclk is slower than mclk, the counter waits in this state
				end
				else if (start_counting_settling_time) begin
                                        wait_time <= wait_time - {21'b1}; // Decrement
					settling_time_flag <= 0;             
					next_state <= WAITING_COUNT;
				end
				else begin
					settling_time_flag <= 0;
					next_state <= IDLE;
				end
			end //waiting_count
			default: begin
				next_state <= IDLE;
		                settling_time_flag <= 0;
			end
		endcase //next_state
	end //nrst
end //always

endmodule
