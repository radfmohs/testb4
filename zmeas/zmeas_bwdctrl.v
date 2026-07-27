////////
// Design     : zmeas_bwdctrl
// Description: accept data from ADC and calculate real=x(n)*cos(n) and
//            : imaginary=x(n)*sin(n) for n=0:511. data is 16bit 2s complement in case of -ve.  
//            : no decimal (fixed/floating), 
// Testbech   : ../sim/sim_rtl_7thdraft/tb_top-z_module_adcinMATLAB_correlation.v
// Rev        : 1.0 : 8april2019 : 
//            : 5.0 : 7june2019 : adc changed to 10bits, signed calculation ability added 
//            :                 : (offset of x(n)*511 is subtracted from multiplications. 
//            :                 : the number is shifted to 15bits of final register 
//            :                 : with sign value in 16th bit
//            : 6.0 : 26June2019: rtl is based on assumptions given in Note 5 and 6. 
//            :                 : Error condition added (summation_offset[28:0] < 512). 
//            :                 : if offset is too small then error.
//            : 7.0 : 30July2019: if number of repeat cycle > 1, then for same
//            :                 : ADC_in and ROM values, the imag_data is getting halved
//            :                 : every cycle. fixed this bug
//            : 7.1 : 14Aug     : Nc value in formula for cosrom calculation in DFT
//            :                 : changed to Nc=floor(fin*1024/250e3) instead
//            :                 : of Nc=round(fin*1000/250e3): so I am adding
//            :                 : offset of 1 in 16khz and 3 in 32khz freq
//            :                 : jump
//            : 7.2 17aug       : discard first adc_in sample after adc_enable
//            : 7.3 26aug       : adc_eoc available on pclk. converted pulse
//            :                 : to level
//            : 8   30aug	: separate ROM 512by10 for DFT calculation,
//            :                 : changed reg_settling_time meaning
//            : 9 17sep2019	: added mclk_invert so as to avoid scan
//            :                 : capture D14 violations and changed all flops
//            :                 : to posedge
//            : 10 20sep        : added sinrom_flag <= 0 in adc_en=0 condition
// Company    : Nanochap
// Author     : RS
// Notes      : 1. for 1024 point calculation, sine wave, mirrors after 1/4th. so
//            :    we just need 511 calculation and multiply by 2 is taken care in 
//            :    gain factor calculation outside
//            : 2. truncating 36bit to 16bits by right shift and factoring
//            :    that division in gain calculation
//            : 3. sequence for Zmesurement is ::
//            :    initialize -> f/w delay(in ms) -> start_calc(i.e. adc_enable)-> wait for reg_settling_time_val
//            :    -> repetitive cycles of adc_sample and adc_eoc until 512*number_of_repeats_decoded
//            : 4. sin(x)= cos(x+1024) in our case because sinrom is 2^12 addresses
//            :    so sin and cosine folds over every 1024
//            : 5. The resolution after offset subtraction is always guaranteed
//            :    to fit in 15bits. Ref: SA on 20june. so we can safely take running average as given in this code.
//            : 6. Once the final "shiftedreal/shiftedimag" values are -ve,
//            :    they stay -ve even after repeat cycles. It is not likely to get
//            :    +ve value in one dft cycle and -ve in other. Ref: Shamsul on 20June.
////////

`include "zmeas_parameters.vh"

module zmeas_bwdctrl(
	//inputs from clkrst
        
	input mclk,	                                     //mclk is 4MHz 
	input mclk_invert,	                                     //mclk is 4MHz 
        input nrst,                                          //obtained from rst control top block
	
	//inputs from analog and ROM
        
	input [9:0] adc_in,                                   // 10bit SARADC out value
        input [9:0] sinrom,                                   // 10bit value stored in ROM
	input adc_eoc,		                              //obtained from SARADC for every conversion 0-511

	//inputs from register memory map thr zmeas_ctrl
	
	input adc_enable,	                              //obtained from firmware program control.start_calculation
	//input [7:0] reg_settling_time_val,
	input [8:0] number_of_repeats_decoded,                //obtained from firmware program control.repeat_calculations can be between 
	                                                      //[2,3,8,16,32,64,128,256]
	input [`PH_JMPDFT_BITS-1:0] freq_phjmpdft_reg,        //ROM address index dependent on freq_val reg. 7bits

	//outputs
        output reg adc_eoc_level,                              // adc_eoc pulse to level for capturing on pclk at any freq for adc_interrupt	
	output wire signed [15:0] shiftedreal,                        //signed. 2s complement in case -ve 
	output wire signed [15:0] shiftedimag,                 
	output wire [`SINROMDFT_ADDRS_WIDTH-1:0] addrs_in_bwd, //address to access sine/cosine data from ROM for DFT calculation  
	                                                       // Ref: on 29th Aug its decided that we can not share the ROM
	output wire rom_cen,                                   //select line for ROM
	output reg adc_sample,                                 //sample signal for 10b SARADC
	output reg freq_meas_done,                             //1: indicates zmeas block has finished rela/imag calculation, 0: 
	output wire [11:0] dft_cnt,
	output wire [9:0] sine_for_dft,
	output wire [9:0] cosine_for_dft,
        output reg  [28:0] summation_offset_forreal,
        output reg  [28:0] summation_real,                    //10b * 10b = 20bits multiplications added 512 times can go upto 30bit max but 
	                                                      //since the max xn can be only 890 and max cosrom can be 1022, 
					                      //the summation goes upto 29bits so i am alloting only 29bits

        output reg [28:0] summation_imag,
        output reg signed [16:0] shiftedreal_inter,
        output reg [9:0] xn_data                             // 10b-adc_in data will be stored in this for 511p xn*cos(n) and x(n)*sin(n) processing
);

	//registers
        reg [9:0] adc_in_internal;         
	reg adc_eoc_internal;
        reg  [9:0] sinrom_reg;                               // 10b-ROM data out value is registered in this. 
        reg  [9:0] sinrom_reg1;            
        reg  [9:0] cosrom_reg;      
        reg  [9:0] cosrom_reg1;      
        reg  [6:0] cnt_sample;
        reg  [8:0] cnt_number_of_repeats;
	reg  [7:0] cnt_delay;
	reg [11:0] cnt;
	reg [19:0] mult_real;                               //10b * 10b multiplication can go upto 20bit max 
	                            
	reg [19:0] mult_imag;       
	reg [19:0] mult_offset;                            // xn_data*`OFFSET_VALUE_511;  //ADDING another 10*9=19bit multiplier ... :O
	reg [28:0] summation_offset;
	//reg [11:0] addrs_rom;                           //max addrs_rom addrs goes upto 4080 when repeat is 4 input cycles or  freq_phjmpdft_reg is 16. 
	reg [`SINROMDFT_ADDRS_WIDTH-1:0] addrs_rom;       //BUT on 29th aug its decided to use separate ROM which is only 512 by 10bit for DFT

	reg [`SINROMDFT_ADDRS_WIDTH-1:0] addrs_rom_early;  
	reg rom_busy_with_sine;
	//reg [11:0] addrs_rom_cosaccess;
	reg [`SINROMDFT_ADDRS_WIDTH-1:0] addrs_rom_cosaccess;
	reg rom_cen_cosaccess;
	reg rom_cen_sineaccess;
	reg sinrom_flag;
	reg sinrom_reg_ready;
	reg start_rom;

	reg signed [16:0] shiftedimag_inter;                    //12b * 9b multiplications 511 times added signed integer can go upto 28bit max 
	                                                 //then right shifted to fit in 15 bits..bit 16 is for sign flag. 
							 //so if bit 16 is 1 then the number is 2's complement
	//reg signed [16:0] rneuka_exp;

        //wires
	
	wire signed [16:0] summation_offset_forreal_signed; 
	wire signed [16:0] summation_offset_forreal_chopped; 
	wire signed [16:0] summation_offset_signed; 
	wire signed [16:0] summation_offset_chopped; 
	wire signed [16:0] summation_real_signed;
	wire signed [16:0] summation_imag_signed;
	//wire [16:0] subtraction_imag_repeat0;
	//wire [16:0] subtraction_imag;
	//wire [16:0] subtraction_real_repeat0;
	//wire [16:0] subtraction_real;
	//wire signed [6:0] rneuka_exp;
       	
	
	//combo
	assign addrs_in_bwd =  (rom_cen_sineaccess==0) ? addrs_rom : ((rom_cen_cosaccess==0) ? addrs_rom_cosaccess : ((rom_busy_with_sine==0)? addrs_rom_cosaccess : addrs_rom ));  //less switching this way
	assign rom_cen = (rom_cen_sineaccess==1'b0) ? 1'b0 : ((rom_cen_cosaccess==1'b0) ? 1'b0 : 1'b1);

	assign shiftedreal = shiftedreal_inter[15:0];
	assign shiftedimag = shiftedimag_inter[15:0];

	assign summation_offset_forreal_chopped = $signed({1'b0,summation_offset_forreal[28:13]});
	assign summation_offset_forreal_signed = $signed(summation_offset_forreal_chopped);
	assign summation_real_signed =  $signed({1'b0, summation_real[28:13]});

	assign summation_offset_chopped = $signed({1'b0,summation_offset[28:13]});
	assign summation_offset_signed = $signed(summation_offset_chopped);
	assign summation_imag_signed = $signed({1'b0, summation_imag[28:13]});

	assign dft_cnt = cnt;
	assign sine_for_dft[9:0] = sinrom_reg1[9:0];
	assign cosine_for_dft[9:0] = cosrom_reg1[9:0];

	//assign rneuka_exp = $signed(shiftedimag_inter[16:10]) >>> 1;

        //assign subtraction_imag_repeat0 = ( ((summation_offset[28:0] < 512) ? 0 :((summation_imag_signed) + ((~(summation_offset_signed))+1))) );
        //assign subtraction_imag = ( (subtraction_imag_repeat0) + shiftedimag_inter);
        //assign subtraction_real_repeat0 = ( (summation_offset_forreal[28:0] < 512) ? 0 : ((summation_real_signed) + ((~(summation_offset_forreal_signed))+1)));
	//assign subtraction_real = ( (subtraction_real_repeat0) + shiftedreal_inter);

	//seq
	always @(posedge mclk or negedge nrst)	//positive edge to process the ADC output . there is flop in saradc
		begin 
			if (!nrst) begin
				xn_data                  <= 0;
				mult_real                <= 0;
				mult_imag                <= 0;
				summation_real           <= 0;
				summation_imag           <= 0;
				summation_offset         <= 0; 
				shiftedreal_inter        <= 0;
				shiftedimag_inter        <= 0;
				cnt                      <= 0;
				freq_meas_done           <= 0;
				cnt_number_of_repeats    <= 0;	
				sinrom_flag              <= 0;
			        //adc_in_internal          <= 0;
			        cosrom_reg1              <= 0;
			        sinrom_reg1              <= 0;
				mult_offset              <= 0;
				summation_offset_forreal <= 0;
				start_rom                <= 0;
				//rneuka_exp <= 0;

			end
			else begin
				if(adc_enable ) begin
				        //adc_in_internal <= adc_in;
					if(cnt_number_of_repeats < number_of_repeats_decoded) begin //this check is done both here and at adc_sample generation. 
						                                                    //useful to turn off this block earlier than adc_enable control.
						freq_meas_done                       <= 0;	    //data is changing
					        if(adc_eoc_internal) begin
							sinrom_flag                  <= 1;
							sinrom_reg1                  <= sinrom_reg;
							if(cnt < 2) begin //cnt=0:1
					    			shiftedimag_inter    <= 0;     //reset imag value register for fresh value 
					    			summation_imag       <= 0;     
					    			summation_offset     <= 0; 
							end
					    		else if(cnt < `DFT_WIDTH+1) begin //cnt=2:512
					    			mult_imag            <= xn_data*sinrom_reg1;	    
					    		        mult_offset          <= xn_data*`OFFSET_VALUE_511;  
					    			summation_imag       <= summation_imag + mult_imag; 
					    			summation_offset     <= summation_offset + mult_offset; 
					    		end
					    		else if(cnt < `DFT_WIDTH+2) begin  //cnt = 513
					    			mult_imag            <= xn_data*sinrom_reg1;
					    		        mult_offset          <= xn_data*`OFFSET_VALUE_511;  
					    			summation_imag       <= summation_imag + mult_imag;
					    			summation_offset     <= summation_offset + mult_offset; 
							end
							else if(cnt < `DFT_WIDTH+3) begin //cnt = 514
					    			summation_imag       <= summation_imag + mult_imag;
					    			summation_offset     <= summation_offset + mult_offset; 
								if(number_of_repeats_decoded > 1) begin
									mult_imag     <= xn_data * sinrom_reg1;
					    		                mult_offset   <= xn_data*`OFFSET_VALUE_511;  
								end
							end
							else begin //cnt=515
								if(number_of_repeats_decoded > 1) begin
									mult_imag        <= xn_data * sinrom_reg1;
					    		                mult_offset      <= xn_data *`OFFSET_VALUE_511;  
					    			        summation_imag   <= 0 + mult_imag;
					    			        summation_offset <= 0 + mult_offset; 
									if(cnt_number_of_repeats==0) begin
	                                                                        //shiftedimag_inter <= ( subtraction_imag_repeat0);
	                                                                        shiftedimag_inter <= $signed( (summation_offset[28:0] < 512) ? 0 : ((summation_imag_signed) + ((~(summation_offset_signed))+1)));
										//rneuka_exp <= $signed(shiftedimag_inter) >>> 1;
									end
									else begin
	                                                                        shiftedimag_inter <= $signed( $signed((summation_offset[28:0] < 512) ? 0 :((summation_imag_signed) + ((~(summation_offset_signed))+1))) + shiftedimag_inter) >>> 1;
	                                                                        //shiftedimag_inter <= {subtraction_imag[16], subtraction_imag[16:1]};
										//rneuka_exp <= $signed(shiftedimag_inter) >>> 1;
									end
								end
								else begin
	                                                                //shiftedimag_inter <= ( subtraction_imag_repeat0);
	                                                                shiftedimag_inter <= $signed( (summation_offset[28:0] < 512) ? 0 : ((summation_imag_signed) + ((~(summation_offset_signed))+1)));
								end
					    		end // cnt
						end //adc_eoc = 1
						else begin
					    		mult_imag        <= mult_imag;
					    		summation_imag   <= summation_imag;
					    		summation_offset <= summation_offset ; 
					    		shiftedimag_inter      <= shiftedimag_inter;
							if(sinrom_flag == 1) begin //START COSROM CALCULATIONS
									sinrom_flag     <= 0;
									cosrom_reg1     <= cosrom_reg;
									summation_offset_forreal <= summation_offset;
							        if(cnt < 1) begin //0
					    		        	shiftedreal_inter    <= 0;     
					    		        	summation_real       <= 0;  //reset real value register for fresh value 
					                        	cnt                  <= cnt+1;
								        xn_data              <= (sinrom_flag==1'b1)? adc_in_internal : xn_data;    //make xn immune to adc_in changes
									start_rom            <= 1;   //because we are discarding first adc value 17aug
							        end
							        else if(cnt < 2) begin //1: first valid sample out of saradc
					    		        	shiftedreal_inter    <= 0;     
					    		        	summation_real       <= 0;                 
					                        	cnt                  <= cnt+1;
								        xn_data              <= (sinrom_flag==1'b1)? adc_in_internal : xn_data;
							        end
					    		        else if(cnt < `DFT_WIDTH+1) begin //2:512
					    		        	mult_real            <= xn_data*cosrom_reg1;	    
					    		        	summation_real       <= summation_real + mult_real; 
					                        	cnt                  <= cnt+1;
					    			        xn_data              <= (sinrom_flag==1'b1)? adc_in_internal : xn_data;
					    		        end
					    		        else if(cnt < `DFT_WIDTH+2) begin  //513
					    		        	mult_real            <= xn_data*cosrom_reg1;
					    		        	summation_real       <= summation_real + mult_real;
								        if(number_of_repeats_decoded > 1) begin
									        xn_data      <= (sinrom_flag==1'b1)? adc_in_internal : xn_data;
								        end
					                        	cnt                  <= cnt+1;
							        end
							        else if(cnt < `DFT_WIDTH+3) begin //cnt = 514
					    		        	summation_real       <= summation_real + mult_real;
							        	if(number_of_repeats_decoded > 1) begin
									        xn_data      <= (sinrom_flag==1'b1)? adc_in_internal : xn_data;
							        		mult_real    <= xn_data * cosrom_reg1;
							        	end
					                        	cnt                  <= cnt+1;
							        end
							        else begin //cnt=515
							        	if(number_of_repeats_decoded > 1) begin
							        		mult_real      <= xn_data * cosrom_reg1;
									        xn_data        <= (sinrom_flag==1'b1)? adc_in_internal : xn_data;
					    		        	        summation_real <= 0 + mult_real; 
									        cnt <= 4;
							        		if(cnt_number_of_repeats==0) begin
	                                                                                //shiftedreal_inter <= ( subtraction_real_repeat0);
	                                                                                shiftedreal_inter <= $signed( (summation_offset_forreal[28:0] < 512) ? 0 : ((summation_real_signed) + ((~(summation_offset_forreal_signed))+1)));
							        		end
							        		else begin
	                                                                                //shiftedreal_inter <= {subtraction_real[16],subtraction_real[16:1]}  ;//running average of two values: signed shift
	                                                                                shiftedreal_inter <= $signed( $signed((summation_offset_forreal[28:0] < 512) ? 0 :((summation_real_signed) + ((~(summation_offset_forreal_signed))+1))) + shiftedreal_inter) >>> 1;//running average of two values: signed shift
							        		end
							        	end
							        	else begin
	                                                                        //shiftedreal_inter <= ( subtraction_real_repeat0);
	                                                                        shiftedreal_inter <= $signed( (summation_offset_forreal[28:0] < 512) ? 0 : ((summation_real_signed) + ((~(summation_offset_forreal_signed))+1)));
							        	end
						                        cnt_number_of_repeats     <= cnt_number_of_repeats +1;
					    		        end // cnt
							end //cosrom calculation done
							else begin
					    		        mult_real         <= mult_real;
					    		        summation_real    <= summation_real;
					    		        shiftedreal_inter <= shiftedreal_inter;
							end
						end //adc_eoc = 0
					end
					else begin
						freq_meas_done    <= 1;
					    	mult_real         <= 0;
					    	summation_real    <= 0;
					    	mult_imag         <= 0;
					    	mult_offset       <= 0;
					    	summation_imag    <= 0;
					    	summation_offset  <= 0; 
					    	summation_offset_forreal  <= 0; 
					    	shiftedreal_inter <= shiftedreal_inter;
					    	shiftedimag_inter <= shiftedimag_inter;
					end // if number of repeats for DFT window is done
				end //adc_enable
				else begin
					cnt                   <= 0;
					freq_meas_done        <= 0;
					mult_real             <= 0;
					mult_imag             <= 0;
					mult_offset           <= 0;
					summation_real        <= 0;
					summation_imag        <= 0;
					summation_offset      <= 0; 
					summation_offset_forreal      <= 0; 
					shiftedreal_inter     <= shiftedreal_inter;
					shiftedimag_inter     <= shiftedimag_inter;
					cnt_number_of_repeats <= 0;
				        //adc_in_internal       <= 0;
					sinrom_flag           <= 0;  //added to avoid situations where start_calc is interrupted and noop is issued. at that time, if this reamins "1" due to previous start_calc, it results in cnt = cnt+1 as soon as adc_en=1
					start_rom             <= 0;
				end //adc_enable = 0
		        end //nrst
		end //always

	


	//////////////////////////////////////////////// mclk_invert logic //////////////////////
	
	////// adc_eoc pulse to level for adc_interrupt Dt: 26Aug////
	//always @(negedge mclk or negedge nrst) begin
	always @(posedge mclk_invert or negedge nrst) begin
		if(!nrst) begin
			adc_eoc_level <= 0;
		end
		else if (adc_eoc) begin
			adc_eoc_level <= 1;
		end
		else if (adc_sample) begin
			adc_eoc_level <= 0;
		end
		else
			adc_eoc_level <= adc_eoc_level & adc_enable;
	end
	//////////////////////////////////////////////////////////////
	
	
	
	/////////////////////////////sample signals for ADC and ADDRS, CEN generation for ROM///////////////////////////////////
	//what if I use inverted clk. to avoid C6 no use. since even if I use inverter inside zmeas_ctrl, its bypassed outside the block
		//with scanclk and then that gets inverted too..
	//always @(negedge mclk or negedge nrst) begin //negedge to generate adc_sample, CEN and addrs. because rom will work on this clk's posedge and adc data can be captured on posedge
	always @(posedge mclk_invert or negedge nrst) begin 
		if(!nrst) begin
			adc_sample            <= 0;
			cnt_sample            <= 0;		
			cnt_delay             <= 0;
			rom_cen_sineaccess    <= 1;	//CEN is active low for ROM IP
			addrs_rom             <= 0;
			addrs_rom_early       <= 0;
			sinrom_reg            <= 0;
			adc_eoc_internal      <= 0;
			sinrom_reg_ready      <= 0;
		end
		
		else begin 
				//-----------------------------------------------------------------------
				if(adc_enable ) begin
					if(cnt_delay  < `SARADC_SETTLING_TIME) begin    //e.g delay: 1 *0.125 = 125ns but on 30aug: SA needs at least 2us
						cnt_delay             <= cnt_delay + 1;
						rom_cen_sineaccess    <= 1;
					end
					else begin
				                adc_eoc_internal      <= adc_eoc;
						if(cnt_sample < `RATIO_FCLK_TO_ADCDATA) begin  //May 16: get adc sample every 16th cycle because saradc is sending data @250KHz 
							                                       //dds runs at 2mhz and adc/dac/zmeas clk runs at 4mhz 
							adc_sample            <= 0;
							cnt_sample            <= cnt_sample + 1;
						        rom_cen_sineaccess    <= 1;
							sinrom_reg_ready      <= 0;
						end					
						else if(cnt_sample== `RATIO_FCLK_TO_ADCDATA) begin //cnt_sample has reached next 250KHz clk edge
							        cnt_sample         <= cnt_sample+1;
							        adc_sample         <= 1'b1;
						                rom_cen_sineaccess <= (start_rom==1'b1) ?  1'b0 : 1'b1;  //make CEN low only for 62.5ns. this is already long ON time for power  not good
							                                           // Ref: ROM IP PDF for current 0.054mA (read curr) vs 6.688e-03mA (deselected read curr)
							        addrs_rom_early    <= (cnt*freq_phjmpdft_reg) % `MOD_DIVISOR;
							        addrs_rom          <= addrs_rom_early;
							        sinrom_reg_ready   <= 0;
						end						
						else begin //cnt_sample=16
							cnt_sample         <= 0;
							adc_sample         <= 0;
						        rom_cen_sineaccess <= 1; 
							sinrom_reg_ready   <= 1;
						end
						if(sinrom_reg_ready) begin
							sinrom_reg <= sinrom;
						end
						else begin
							sinrom_reg <= sinrom_reg;
						end
					end
				end
				else begin //adc disabled
					cnt_sample         <= 0;
					cnt_delay          <= 0;
					adc_sample         <= 0;
					rom_cen_sineaccess <= 1;
				        adc_eoc_internal   <= 0;
				end
		end//nrst		
	end//always

	// chk for adc_eoc and capture on negedge
	//always @(negedge mclk or negedge nrst) begin
	always @(posedge mclk_invert or negedge nrst) begin
		if(!nrst) begin
			adc_in_internal <= 0;
		end
		else if (adc_eoc) begin
			adc_in_internal <= adc_in;
		end
		else begin
			adc_in_internal <= adc_in_internal;
		end
	end


	///////////////////////////// CEN generation for cos calculation in sinrom///////////////////////////////////
	//always @(negedge mclk or negedge nrst) begin
	always @(posedge mclk_invert or negedge nrst) begin 
		if(!nrst) begin
			rom_cen_cosaccess   <= 1;	
			addrs_rom_cosaccess <= 0;
			rom_busy_with_sine  <= 0;
			cosrom_reg          <= 0;
		end
		else begin 
			if(rom_cen_sineaccess==0) begin
				rom_busy_with_sine  <= 1;
			        addrs_rom_cosaccess <= addrs_rom_cosaccess;
				rom_cen_cosaccess   <= 1;
			end					
			else if (rom_busy_with_sine == 1 && rom_cen_sineaccess==1) begin
				rom_busy_with_sine  <= 0;
				addrs_rom_cosaccess <= (addrs_rom + `COSFOLDOVER_NUMBER) % `MOD_DIVISOR; //sine values are stored in 512 rows ROM. so to get cosine values, add 128 to sine address
				rom_cen_cosaccess   <= 0;
			end
			else begin
				rom_busy_with_sine  <= 0;
			        addrs_rom_cosaccess <= addrs_rom_cosaccess; //leave the value on addrs line and then overwrite in next calculation instead of making 0
				                                            // saves switching to 0 power?
				rom_cen_cosaccess   <= 1;
				cosrom_reg <= sinrom;
			end
		end //nrst
	end //always

endmodule
