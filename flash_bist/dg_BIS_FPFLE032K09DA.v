
`timescale 1ns/1ns

module data_generator (TCK,RESETb,TDI,STROBE,TESTEN,PDI,ST2IP,TDO,DO,IP2ST,BUSY,OEN,TDI_valid,TDI_en);


  input TCK;
  input RESETb;   
  input STROBE;
  input TESTEN;
  output[39:0] ST2IP; 
  input[39:0] PDI;    
  input TDI_valid; 
  input TDI;
   
  output BUSY;
  output TDO;
  reg TDO;
  output[7:0] DO;     
  input [7:0] IP2ST;

  output OEN;
  output TDI_en;

  //===============================
  // serial to parallel conversion
  //===============================
  reg [49:0] s2p_data;  
  reg [49:0] s2p_sreg;
  reg  [5:0] s2p_cnt;  
  reg  TDI_en; 
  reg  OEN;                        //bidirectional pad control pin,OEN = 0 output enable
  always @(negedge RESETb or posedge TCK)
    begin
      if (!RESETb)
        begin
          TDI_en <= 1'b0;
      	  s2p_cnt  <= 6'b00_0000;
      	  s2p_data <= {{47{1'b0}},{3{1'b1}}};  
	  s2p_sreg <= {{47{1'b0}},{3{1'b1}}};
        end
      else if(STROBE)
        begin 
          s2p_cnt  <= 6'b00_0000;
          TDI_en  <= 1'b1;
      	  s2p_data <= s2p_sreg;
        end 
      else
        begin
          if(TDI_valid ) begin
            if (s2p_cnt <= 6'b11_0001) 
      	    begin 
              TDI_en <= 1'b0;
              s2p_sreg <= {TDI, s2p_sreg[49:1]};
              s2p_cnt <= s2p_cnt + 6'b00_0001;  
      	    end 
            else TDI_en <= 1'b1;
                          end
           else
                TDI_en <=1'b1;
        end
    end
 
  //================
  // data generator
  //================
  // select Timeout counter settings according to TCLK mode
  reg  [6:0] t_nvs;   
  reg  [6:0] t_pgs;
  reg  [7:0] t_prog;
  reg [16:0] t_erase;
  reg  [6:0] t_rcv;
  reg  [9:0] t_rcv_ser;
  reg  [1:0] t_rw;
  wire [2:0] t_ser;  

  assign t_ser   = 3'b101;  
                            
  

  always @(s2p_data[`S_FREQ] or s2p_data[`S_Tprog_conf] or s2p_data[`S_Terase_conf])
    begin
      case (s2p_data[`S_FREQ])
	2'b01:   // 1 MHz
	  begin
	    t_nvs  =                   7'b000_0110;  // 6 us 
	    t_pgs  =                  7'b000_0010;  // 2.5 us
	    t_rcv  =                  7'b000_0101;  // 5 us 
            t_rw   =                        2'b00;  // 100 ns
	    t_rcv_ser =          10'b00_0011_0011;  // 50 us
            case (s2p_data[`S_Tprog_conf])
               2'b00: 
                  begin
                    t_prog =               8'b0000_0100;// 5.4 us // 4
                  end
               2'b01: 
                  begin
                    t_prog =               8'b0000_0110;// 6 us // 5
                  end
               2'b10: 
                  begin
                    t_prog =               8'b0000_0110;// 7.5 us // 6
                  end
               2'b11: 
                  begin
                    t_prog =               8'b0000_0111;// 8.25 us // 7           
                  end
            endcase

            case (s2p_data[`S_Terase_conf])
               2'b11: 
                  begin
                    t_erase = 17'b0_0001_0011_1000_0111; // 5 ms //4999
                  end
               2'b10: 
                  begin
                    t_erase = 17'b0_0000_1111_1001_1111; // 4 ms //3999
                  end
               2'b01: 
                  begin
                    t_erase = 17'b0_0000_0011_1110_0111; // 1 ms //999
                  end
               2'b00: 
                  begin
                    t_erase = 17'b0_0000_0001_1111_0011; // 0.5 ms //499
                  end
            endcase

	  end

	2'b10:   // 10 MHz
	  begin
	    t_nvs  =                    7'b011_1100; // 6 us      
	    t_pgs  =                   7'b001_1001; // 2.5 us 
	    t_rcv  =                  7'b011_0010;  // 5 us 
            t_rw   =                        2'b00;  // 100 ns 
	    t_rcv_ser =          10'b01_1111_0100;  // 50 us 
            case (s2p_data[`S_Tprog_conf])
               2'b00: 
                  begin
                    t_prog =               8'b0011_0101;// 5.4 us // 53
                  end
               2'b01: 
                  begin
                    t_prog =               8'b0011_1100;// 6 us // 59
                  end
               2'b10: 
                  begin
                    t_prog =                8'b0100_1001;// 7.5 us // 74
                  end
               2'b11: 
                  begin
                    t_prog =               8'b0101_0010;// 8.25 us // 82
                  end
            endcase

            case (s2p_data[`S_Terase_conf])
               2'b11: 
                  begin
                  t_erase = 17'b0_1100_0011_0100_0000; // 5 ms
                  end
               2'b10: 
                  begin
                    t_erase = 17'b0_1001_1100_0100_1110; // 4 ms 
                  end
               2'b01: 
                  begin
                    t_erase = 17'b0_0010_0111_0000_1111; // 1 ms 
                  end
               2'b00: 
                  begin
                    t_erase = 17'b0_0001_0011_1000_0111; // 0.5 ms
                  end
            endcase

	  end

	2'b11:   // 20 MHz
	  begin
	    t_nvs  =                    7'b111_0111; // 6 us    
	    t_pgs  =                   7'b011_0001; // 2.5 us  
	    t_rcv  =                   7'b110_0011; // 5 us 
            t_rw   =                         2'b01; // 100 ns 
	    t_rcv_ser =           10'b11_1110_0111; // 50 us
            case (s2p_data[`S_Tprog_conf])
               2'b00: 
                  begin
                    t_prog =               8'b0110_1011;// 5.4 us // 107
                  end
               2'b01: 
                  begin
                    t_prog =               8'b0111_0111;// 6 us // 119 
                  end
               2'b10: 
                  begin
                    t_prog =                8'b1001_0101;// 7.5 us // 149 
                  end
               2'b11: 
                  begin
                    t_prog =               8'b1010_0100;// 8.25 us // 164 
                  end
            endcase

            case (s2p_data[`S_Terase_conf])
               2'b11: 
                  begin
                    t_erase = 17'b1_1000_0110_1001_1111; // 5 ms
                  end
               2'b10: 
                  begin
                    t_erase = 17'b1_0011_1000_0111_1111; // 4 ms
                  end
               2'b01: 
                  begin
                    t_erase = 17'b0_0100_1110_0001_1111; // 1 ms
                  end
               2'b00: 
                  begin
                    t_erase = 17'b0_0010_0111_0000_1111; // 0.5 ms
                  end

            endcase

	  end

	default:
	  begin
	    t_nvs  =     {7{1'b0}};
	    t_pgs  =     {7{1'b0}};
	    t_prog =     {8{1'b0}};	 
	    t_rcv  =     {7{1'b0}};	     
	    t_rw   =     {2{1'b0}};
	    t_erase =   {17{1'b0}};     
	    t_rcv_ser = {10{1'b0}};
	  end
      endcase  
    end

  // array geometry
  reg[15:0] addr_max;   
  reg[11:0] sect_incr;  
  reg[8:0]   y_max;
  reg[7:0]  x_max;   
  reg[7:0]   y_cnt;
  reg[7:0]   y_cnt_inv;
  reg[6:0]  x_cnt; 
  


  always @(s2p_data[`S_NVR] or s2p_data[`S_RDN]or s2p_data[`S_MS])
    begin
      x_max = 8'b0;  //to remove latched
      y_max = 9'b0;
      addr_max = 16'b0;
      sect_incr =12'b0;

      casez ({s2p_data[`S_NVR],s2p_data[`S_RDN]})
	2'b1?:         //NVR
	  begin  
                   if(s2p_data[`S_MS] == `PGM_RD)
                          begin
                                  addr_max = 16'b0000_0011_1111_1111; // 1024 bytes
                         end

                   else if(s2p_data[`S_MS] == `PGM_RDCK)
                          begin
                                  addr_max = 16'b0000_0001_1111_1111; // 512 bytes
                         end

                   else if(s2p_data[`S_MS] == `PGMDIAG_WR||s2p_data[`S_MS] == `PGMCB_WR||s2p_data[`S_MS] == `PGMICB_WR||s2p_data[`S_MS] == `PGM_WR)
	                 begin
                                   x_max = 8'b0000_0001;  //(2-1)th  row, for NVR
                                   y_max = 9'b0_1111_1111;       // *8 mode   
                         end
                    else if(s2p_data[`S_MS] == `PGMCB_WR32||s2p_data[`S_MS] == `PGMICB_WR32||s2p_data[`S_MS] == `PGM_WR32)
	                 begin
                                   x_max = 8'b0000_0001;  //(2-1)th  row, for NVR
                                   y_max = 9'b0_0011_1111;        // *32 mode
                         end
                   else if(s2p_data[`S_MS] == `PGM_BERASE)
	                 begin
                             addr_max = 16'b0111_1111_1111_1111; // (32768-1) bytes,  for main array
                             sect_incr =12'b1000_0000_0000;    //2K bytes, used for block erase only;
                         end

                   else if(s2p_data[`S_MS] == `PGM_SERASE)
	                 begin
                             addr_max = 18'b00_0000_0001_1111_1111; // (512-1) bytes,  for 1st NVR sector
                             sect_incr =12'b0010_0000_0000;    //512 bytes, used for sector erase only;
                         end
                   else  begin
                            x_max = 8'b0;
                            y_max = 9'b0;
                            addr_max = 16'b0;
                            sect_incr =12'b0;
                         end
	  end
	2'b00:        //main array
	  begin
                   if(s2p_data[`S_MS] == `PGM_RD || s2p_data[`S_MS] == `PGM_SERASE || s2p_data[`S_MS] == `PGM_RDCK)
	                 begin
                                   addr_max = 16'b0111_1111_1111_1111; 
                                   sect_incr =12'b0010_0000_0000;
                                   x_max = 8'b0111_1111;  
                                   y_max = 9'b0_1111_1111;    
                         end
                   else if(s2p_data[`S_MS] == `PGMDIAG_WR||s2p_data[`S_MS] == `PGM_WR||s2p_data[`S_MS] == `PGMCB_WR||s2p_data[`S_MS] == `PGMICB_WR)
	                 begin
                                   x_max = 8'b0111_1111;  
                                   y_max = 9'b0_1111_1111;      
                         end
                   else if(s2p_data[`S_MS] == `PGM_WR32||s2p_data[`S_MS] == `PGMCB_WR32||s2p_data[`S_MS] == `PGMICB_WR32)
	                 begin
                                   x_max = 8'b0111_1111;  
                                   y_max = 9'b0_0011_1111;      
                         end
                   else if(s2p_data[`S_MS] == `PGM_BERASE)
	                 begin
                             addr_max = 16'b0111_1111_1111_1111; 
                             sect_incr =12'b1000_0000_0000;    
                         end
                   else  begin
                            x_max = 8'b0;
                            y_max = 9'b0;
                            addr_max = 16'b0;
                            sect_incr =12'b0;
                         end
	  end

	2'b01:        // redundancy
	  begin
                   if(s2p_data[`S_MS] == `PGM_RD || s2p_data[`S_MS] == `PGM_SERASE || s2p_data[`S_MS] == `PGM_RDCK)
	                 begin
                                   addr_max = 16'b0000_0001_1111_1111; 
                                   sect_incr =12'b0010_0000_0000;    
                                   x_max = 8'b0000_0001;   
                                   y_max = 9'b0_1111_1111;       
                         end
                   else if(s2p_data[`S_MS] == `PGMDIAG_WR||s2p_data[`S_MS] == `PGM_WR||s2p_data[`S_MS] == `PGMCB_WR||s2p_data[`S_MS] == `PGMICB_WR)
	                 begin
                                   x_max = 8'b0000_0001;  
                                   y_max = 9'b0_1111_1111;       
                         end
                  else if(s2p_data[`S_MS] == `PGM_WR32||s2p_data[`S_MS] == `PGMCB_WR32||s2p_data[`S_MS] == `PGMICB_WR32)
	                 begin
                                   x_max = 8'b0000_0001;  
                                   y_max = 9'b0_0011_1111;       
                         end

                   else if(s2p_data[`S_MS] == `PGM_BERASE)
	                 begin
                             addr_max = 16'b0111_1111_1111_1111; 
                             sect_incr= 12'b1000_0000_0000;    //2K bytes, used for block erase only;
                         end
                   else  begin
                            x_max = 8'b0;
                            y_max = 9'b0;
                            addr_max = 16'b0;
                            sect_incr =12'b0;
                         end
	  end

      endcase
    end


  // delay strobe
  reg strobe_t0;
  reg strobe_t1;
  reg strobe_t2;


  always @(negedge RESETb or posedge TCK)
    begin
      if (!RESETb)
        strobe_t0  <= 1'b0;
      else
        strobe_t0  <= STROBE;
    end

  always @(negedge RESETb or posedge TCK)
    begin
      if (!RESETb)
        strobe_t1  <= 1'b0;
      else
        strobe_t1  <= strobe_t0;
    end

  always @(negedge RESETb or posedge TCK)
    begin
      if (!RESETb)
        strobe_t2  <= 1'b0;
      else
        strobe_t2  <= strobe_t1;
    end


  // FSM
  reg [15:0] t_cnt;
  reg [14:0] addr_cnt;    
  reg [3:0] w_state;     
  reg [ 2:0] r_state;
  reg [ 2:0] e_state;
  reg [39:0] dg_data;      
  reg        serout; 
  reg [2:0] test_pass;
  reg       compare_enable;
  reg [14:0] add_latch;
  reg [7:0] data_latch;
  reg [14:0] error;
  always @(negedge RESETb or posedge TCK)
    begin
      if (!RESETb)
	begin
	  t_cnt     <= {16{1'b0}};
	  addr_cnt  <= {15{1'b0}};
          x_cnt     <= {7{1'b0}};
          y_cnt     <= {8{1'b0}};
          y_cnt_inv <= 8'b0000_0001;
	  w_state   <= `FSM_WIDLE;
	  r_state   <= `FSM_RIDLE;
	  e_state   <= `FSM_EIDLE;
	  dg_data[`S_CEB]   <= 1'b1;
	  dg_data[`S_OEB]   <= 1'b1;
	  dg_data[`S_WEB]   <= 1'b1;
	  dg_data[`S_PROG]  <= 1'b0;
	  dg_data[`S_PROG2] <= 1'b0;
	  dg_data[`S_ERASE] <= 1'b0;
	  dg_data[`S_BLOCK] <= 1'b0;
	  dg_data[`S_A]     <= {15{1'b0}};
	  dg_data[`S_DIN]   <= {8{1'b0}};
          test_pass         <= 3'b000;
          compare_enable    <= 1'b0;
          error             <= 0;
          add_latch         <= 15'h0;
          data_latch        <= 8'h0;
	  serout            <= 1'b0;
          OEN <= 1'b1;
	end
      else if (!strobe_t0)
	begin
          t_cnt    <= {16{1'b0}};
	  addr_cnt <= {15{1'b0}};
          x_cnt    <= {7{1'b0}};
          y_cnt    <= {8{1'b0}};
          y_cnt_inv <= 8'b0000_0001;
	  w_state  <= `FSM_WNVS;
	  r_state  <= `FSM_RVRS;
	  e_state  <= `FSM_ENVS;
          test_pass <= 3'b000;		  
	  serout   <= 1'b0;
          OEN <= 1'b1;
	end 
      else if (t_cnt > 16'b0000_0000_0000_0000 /*0*/)
	begin
	  t_cnt  <= t_cnt - 16'b0000_0000_0000_0001; // -1
	  serout <= 1'b0;
	end
      else
	begin
	  case (s2p_data[`S_MS])
	    `PGMSER_RD_WR : // serial rd/wr
	      begin
		// forward serial input to parallel output
  		dg_data[`S_CEB]   <= s2p_data[`S_CEB];
		dg_data[`S_OEB]   <= s2p_data[`S_OEB];
		dg_data[`S_WEB]   <= s2p_data[`S_WEB];  
		dg_data[`S_PROG]  <= s2p_data[`S_PROG]; 
		dg_data[`S_PROG2] <= s2p_data[`S_PROG2];
		dg_data[`S_ERASE] <= s2p_data[`S_ERASE];
		dg_data[`S_BLOCK] <= s2p_data[`S_BLOCK];
		dg_data[`S_A]     <= s2p_data[`S_A];
		dg_data[`S_DIN]   <= s2p_data[`S_DIN];
		if(s2p_data[`S_OEB]==1'b0 && strobe_t0 && !strobe_t1)begin //zhen added
                    OEN   <= 1'b0;
                    t_cnt <= 16'b0000_0000_0000_1000;
                end
		else if(t_cnt == 16'b0000_0000_0000_0000) begin
                    OEN   <= 1'b1;
	        end	//end	  		
	      end
	    `PGM_SERASE , `PGM_BERASE : // sector and block erase
	      begin
		case (e_state)
		  `FSM_ENVS   :
		    begin
		      dg_data[`S_ERASE] <= 1'b1;		      
		      dg_data[`S_CEB]   <= 1'b0;
		      dg_data[`S_WEB]   <= 1'b1;
		      dg_data[`S_A]     <= addr_cnt;
		      t_cnt             <= {{9{1'b0}},t_nvs};
		      e_state           <= `FSM_EERASE;
		      if (s2p_data[`S_MS] == `PGM_BERASE) 
			dg_data[`S_BLOCK] <= 1'b1;
		      else
			dg_data[`S_BLOCK] <= 1'b0;
		    end
		  `FSM_EERASE :
		    begin
		      dg_data[`S_WEB]   <= 1'b0;
		      dg_data[`S_A]     <= addr_cnt;
		      t_cnt <={{3{1'b0}}, t_erase};
		      e_state <= `FSM_ERCV;
		    end
		  `FSM_ERCV   :
		    begin
		      dg_data[`S_ERASE] <= 1'b1;
		      dg_data[`S_WEB]   <= 1'b1;
		      e_state <= `FSM_ERW;
		      t_cnt <= {{6{1'b0}}, t_rcv_ser};			  
		    end
		  `FSM_ERW    :
		    begin
		      dg_data[`S_ERASE] <= 1'b0;
		      dg_data[`S_WEB]   <= 1'b1;
		      dg_data[`S_BLOCK] <= 1'b0;
		      if ( (addr_cnt + sect_incr) < addr_max )  
		        begin 
			  addr_cnt <= addr_cnt + sect_incr;
			  e_state <= `FSM_ENVS;
			end
		      else e_state <= `FSM_EIDLE;
		      t_cnt <= {{14{1'b0}}, t_rw};		      
		    end
		  `FSM_EIDLE:
		    begin
		      dg_data[`S_ERASE] <= 1'b0;
		      dg_data[`S_CEB]   <= 1'b1;
		    end
		endcase
	      end
 
	     `PGMCB_WR ,`PGM_WR, `PGMDIAG_WR,`PGM_WR32,`PGMCB_WR32, `PGM_WR_WORD: // write
	      begin
		// set control signals
		case (w_state)
		  `FSM_WNVS :
		    begin
		      // set data signals
		      dg_data[`S_DIN]   <= s2p_data[`S_DIN];
		      dg_data[`S_WEB]   <= 1'b1;
		      dg_data[`S_PROG]  <= 1'b1;
		      dg_data[`S_CEB]   <= 1'b0;
                      dg_data[`S_PROG2] <= 1'b0;
                      if(s2p_data[`S_MS]== `PGM_WR_WORD)
                          dg_data[`S_A]     <= s2p_data[`S_A];
                      else 
		          dg_data[`S_A]     <= {x_cnt,y_cnt};
		      t_cnt <= {{9{1'b0}},t_nvs};		       
		      w_state <= `FSM_WPGS;
		    end
		  `FSM_WPGS :
		    begin                            
		      dg_data[`S_WEB]   <= 1'b0;
		      t_cnt <= {{9{1'b0}},t_pgs};
		      w_state <= `FSM_WPROG;
		    end 
		  `FSM_WADS :  // new star point
   		    begin
		      // set data signals
                      dg_data[`S_PROG2] <= 1'b0;
                      if(s2p_data[`S_MS]== `PGM_WR_WORD)
                          dg_data[`S_A]     <= s2p_data[`S_A];
                      else 
		          dg_data[`S_A]     <= {x_cnt,y_cnt};

		      w_state <= `FSM_WPROG;
		    end 
		  `FSM_WPROG :
		    begin
                      dg_data[`S_PROG2] <= 1'b1;
		      t_cnt <= {{8{1'b0}},t_prog};
		      w_state <= `FSM_WADH;
		    end
		  `FSM_WADH :    
		    begin
                      dg_data[`S_PROG2] <= 1'b0;
                      if( s2p_data[`S_MS] == `PGMDIAG_WR|| s2p_data[`S_MS] == `PGM_WR_WORD)
                           begin
                                  w_state <= `FSM_WRCV;
                           end
                      if( s2p_data[`S_MS] == `PGMCB_WR||s2p_data[`S_MS] == `PGMCB_WR32 )
                            begin 
		             if ( y_cnt + 2 > y_max)  //next row
		                begin 
			           w_state <= `FSM_WRCV;			       
			        end
		             else 
			        begin
			           w_state <= `FSM_WADS;
			           y_cnt <= y_cnt + 2;
                                end
                           end
                      if( s2p_data[`S_MS] == `PGM_WR||s2p_data[`S_MS] == `PGM_WR32)
                            begin 
		             if ( y_cnt + 1 > y_max)  //next row
		                begin 
			           w_state <= `FSM_WRCV;			       
			        end
		             else 
			        begin
			           w_state <= `FSM_WADS;
			           y_cnt <= y_cnt + 1;
                                end
                           end			           
                    end
		  `FSM_WRCV :
		    begin
		      dg_data[`S_WEB]   <= 1'b1;
                      dg_data[`S_PROG2] <= 1'b0;
		      t_cnt <= {{9{1'b0}},t_rcv};
		      w_state <= `FSM_WRW;			    
		    end
		  `FSM_WRW :
		    begin
		      t_cnt <= {{14{1'b0}},t_rw};
                      dg_data[`S_PROG]  <= 1'b0;
                      if (s2p_data[`S_MS] == `PGM_WR_WORD)
                          begin
                          w_state <= `FSM_WIDLE;
                          end
		      else if (x_cnt + 1 <= x_max)
			begin 
			  w_state <= `FSM_WNVS;
                          if( s2p_data[`S_MS] == `PGMDIAG_WR )          
                                begin
                                            x_cnt <= x_cnt + 1;
                                            y_cnt <= y_cnt + 1;
                                end
                         if( s2p_data[`S_MS] == `PGM_WR||s2p_data[`S_MS] == `PGM_WR32)
                                begin
			                    x_cnt  <= x_cnt + 1; //next row
                                            y_cnt  <= 0; // 
                                end
                         if(s2p_data[`S_MS] == `PGMCB_WR||s2p_data[`S_MS] == `PGMCB_WR32)
                                        begin
			                    x_cnt  <= x_cnt + 1; //next row
                                            y_cnt  <= !x_cnt[0];  
                                        end
			end
		      else  
                           w_state <= `FSM_WIDLE;
                  end
		  `FSM_WIDLE :
		    begin
		      dg_data[`S_WEB]   <= 1'b1;
		      dg_data[`S_PROG]  <= 1'b0;
		      dg_data[`S_CEB]   <= 1'b1;
		      dg_data[`S_PROG2] <= 1'b0;		     
		    end
		endcase
	      end

	     `PGMICB_WR ,`PGMICB_WR32: 
	      begin
		// set control signals
		case (w_state)
		  `FSM_WNVS :
		    begin
		      // set data signals
                      dg_data[`S_DIN]   <= s2p_data[`S_DIN];
		      dg_data[`S_WEB]   <= 1'b1;
		      dg_data[`S_PROG]  <= 1'b1;
		      dg_data[`S_CEB]   <= 1'b0;
                      dg_data[`S_PROG2] <= 1'b0;
		      dg_data[`S_A]     <= {x_cnt,y_cnt_inv};
		      t_cnt <= {{9{1'b0}},t_nvs};		       
		      w_state <= `FSM_WPGS;
		    end
		  `FSM_WPGS :
		    begin                            
		      dg_data[`S_WEB]   <= 1'b0;
		      dg_data[`S_A]     <= {x_cnt,y_cnt_inv};
		      t_cnt <= {{9{1'b0}},t_pgs};
		      w_state <= `FSM_WPROG;
		    end 
		  `FSM_WADS :  // new star point
   		    begin
		      // set data signals
		      dg_data[`S_A]     <= {x_cnt,y_cnt_inv};
		      w_state <= `FSM_WPROG;
		    end 
		  `FSM_WPROG :
		    begin
                      dg_data[`S_PROG2] <= 1'b1;
		      dg_data[`S_A]     <= {x_cnt,y_cnt_inv};
		      t_cnt <= {{8{1'b0}},t_prog};
		      w_state <= `FSM_WADH;
		    end
		  `FSM_WADH :  
		    begin
                      dg_data[`S_PROG2] <= 1'b0;
		      dg_data[`S_A]     <= {x_cnt,y_cnt_inv};
		      if ( y_cnt_inv + 2 > y_max)  //next row
		                begin 
			           w_state <= `FSM_WRCV;
			        end
		      else 
			        begin
			           w_state <= `FSM_WADS;
			           y_cnt_inv <= y_cnt_inv + 2;
                                end
		           
                    end
		  `FSM_WRCV :
		    begin
		      dg_data[`S_WEB]   <= 1'b1;
		      t_cnt <= {{9{1'b0}},t_rcv};
		      w_state <= `FSM_WRW;
		    end
		  `FSM_WRW :
		    begin
		      t_cnt <= {{14{1'b0}},t_rw};
                      dg_data[`S_PROG]  <= 1'b0;
		      if (x_cnt + 1 <= x_max)
			begin 
			  w_state <= `FSM_WNVS;
 			  x_cnt  <= x_cnt + 1; 
                          y_cnt_inv  <= x_cnt[0];
			end
		      else w_state <= `FSM_WIDLE;
		    end
		  `FSM_WIDLE :
		    begin
		      dg_data[`S_WEB]   <= 1'b1;
		      dg_data[`S_PROG]  <= 1'b0;
		      dg_data[`S_CEB]   <= 1'b1;
		      dg_data[`S_PROG2] <= 1'b0;
		    end
		endcase
	      end
             `PGM_RDCK: 
                 begin
               	case (r_state)
		  `FSM_RVRS :
		    begin
		      dg_data[`S_CEB]   <= 1'b1;
		      dg_data[`S_OEB]   <= 1'b1;
                      compare_enable <= 0; 
		      addr_cnt    <= 0;
		      serout            <= 1'b0;
                      add_latch         <= 0;
		      r_state <= `FSM_RCMP;
                      OEN <= 1'b0;
		    end
                  `FSM_RCMP:
                        begin
                      dg_data[`S_CEB]   <= 1'b0;
		      dg_data[`S_OEB]   <= 1'b0;
                      error <= 0;
		      dg_data[`S_A]     <= addr_cnt;
                      add_latch         <= addr_cnt;
		      serout            <= 1'b0;
		      r_state <= `FSM_RRC;
                          end
                      `FSM_RRC :
		    begin
		      dg_data[`S_A]     <= addr_cnt;
                      if(addr_cnt <addr_max)
                        addr_cnt <= addr_cnt +1;
                         else
                          addr_cnt <= addr_cnt; 
                     if(add_latch[8:0]< 9'h1ff) 
                          r_state <= `FSM_RRC;
                     else 
                      r_state <= `FSM_RSAMPLE;
		      serout            <= 1'b0;
                      data_latch        <=  IP2ST;
                      add_latch         <=  ST2IP[`S_A];
                      compare_enable    <= 1'b1;
                case(s2p_data[49:46])
                 `PGM_SERASE,`PGM_BERASE,`PGM_WR,`PGM_WR32 : begin
                     if(compare_enable) begin
                      if(data_latch == s2p_data[`S_DIN])
                      error <= error;
                     else
                      error <= error+1;
                              end
                      else  error <= 0;
                                             end
                 `PGMCB_WR,`PGMCB_WR32 : begin
                      if(compare_enable) begin
                         if(add_latch[8] == add_latch[0]) begin
                                   if (data_latch == s2p_data[`S_DIN])
                                           error <= error;
                                   else
                                           error <= error+1;
                                                             end
                         else begin
                                   if (data_latch == 8'hff)
                                           error <= error;
                                   else
                                           error <= error+1;
                                end
                                         end
                      else  error <=0 ;
                       end
                 `PGMICB_WR,`PGMICB_WR32 : begin
                      if(compare_enable) begin
                         if(add_latch[8] == !add_latch[0]) begin
                                   if (data_latch == s2p_data[`S_DIN])
                                           error <= error;
                                   else
                                           error <= error+1;
                                                             end
                         else begin
                                   if (data_latch == 8'hff)
                                           error <= error;
                                   else
                                           error <= error+1;
                                end
                                         end
                      else  error <=0 ;
                       end
                `PGMDIAG_WR : begin
                      if(compare_enable) begin
                         if(add_latch[14:8] == add_latch[7:0]) begin
                                   if (data_latch == s2p_data[`S_DIN])
                                           error <= error;
                                   else
                                           error <= error+1;
                                                             end
                         else begin
                                   if (data_latch == 8'hff)
                                           error <= error;
                                   else
                                           error <= error+1;
                                end
                                         end
                      else  error <=0 ;
                       end
                 default : begin 
                              error <= 0;
                           end

                  endcase            
                
		    end
		  `FSM_RSAMPLE :
		    begin
		      serout            <= 1'b1;
                       if(error == 0)
                           test_pass <= 3'b000;
                          else
                           test_pass <= 3'b010;      
		      if (add_latch < addr_max) 
			begin 
			  r_state <= `FSM_RRC;
                          error <= 0;
			end
		      else r_state <= `FSM_RIDLE;
		    end
		  `FSM_RIDLE :
		    begin
		      dg_data[`S_CEB]   <= 1'b1;
		      dg_data[`S_OEB]   <= 1'b1;
		      serout            <= 1'b0;
                      compare_enable <= 0;
                      t_cnt   <= {{14{1'b0}},2'b11};
                      r_state           <= `FSM_ROVER; 
		    end
                   `FSM_ROVER :
		    begin
                      OEN   <= 1'b1;
		    end
		endcase
	      end	
	    `PGM_RD,`PGM_RD_WORD : // read
	      begin
		// set control signals
		case (r_state)
                   `FSM_RVRS :
		    begin
                      OEN <= 1'b0;
		      dg_data[`S_CEB]   <= 1'b1;
		      dg_data[`S_OEB]   <= 1'b1;
                      if(s2p_data[`S_MS] == `PGM_RD_WORD)
                          begin
		          dg_data[`S_A] <= s2p_data[`S_A];
		          addr_cnt      <= s2p_data[`S_A];
                          end
                      else
		          dg_data[`S_A] <= addr_cnt;
		      serout            <= 1'b0;
		      r_state           <= `FSM_RRC;
		    end
		  `FSM_RRC :
		    begin
		      dg_data[`S_CEB]   <= 1'b0;
		      dg_data[`S_OEB]   <= 1'b0;
		      dg_data[`S_A]     <= addr_cnt;
                      r_state           <= `FSM_RSAMPLE;
		      serout            <= 1'b0;
		      t_cnt             <= {{15{1'b0}},1'b1}; // delay serout strobe by one cycle
		    end
		  `FSM_RSAMPLE :
		    begin
		      dg_data[`S_CEB]   <= 1'b0;
		      dg_data[`S_OEB]   <= 1'b0;
		      dg_data[`S_A]     <= addr_cnt;
		      serout            <= 1'b1;
		      t_cnt             <= {{13{1'b0}},t_ser}; // additional cycles for shift ?
                      if (s2p_data[`S_MS] == `PGM_RD_WORD)
                          r_state <= `FSM_RIDLE;
		      else if (addr_cnt < addr_max) 
			begin 
			  addr_cnt <= addr_cnt + {{14{1'b0}},1'b1}; // +1  
			  r_state <= `FSM_RRC;
			end
		      else r_state <= `FSM_RIDLE;
		    end
                    `FSM_RIDLE :
		    begin
		      dg_data[`S_CEB]   <= 1'b1;
		      dg_data[`S_OEB]   <= 1'b1;
		      serout            <= 1'b0;
                      t_cnt   <= {{14{1'b0}},2'b11};
                      r_state  <= `FSM_ROVER; 
		    end
                  `FSM_ROVER :
		    begin
                      OEN               <= 1'b1;
		    end

		endcase
	      end


	  endcase 
	end
    end

  // infer registers
  always @(negedge RESETb or posedge TCK)   
    begin
      if (!RESETb)
	begin
	  dg_data[`S_CONFEN] <= 1'b0;	   
	  dg_data[`S_NVR]    <= 1'b0;
	  dg_data[`S_RDN]    <= 1'b0;
          dg_data[`S_CHIP]   <= 1'b0;
	  dg_data[`S_TMEN]   <= 1'b0;
	  dg_data[`S_VREAD1] <= 1'b0;
          dg_data[`S_VREAD0] <= 1'b0;
          dg_data[`S_DEEPPD] <= 1'b0;
          dg_data[`S_VMON1]  <= 1'b0;
          dg_data[`S_VMON2]  <= 1'b0;
	end
      else
	begin
	  dg_data[`S_CONFEN] <= s2p_data[`S_CONFEN];	   
	  dg_data[`S_NVR]    <= s2p_data[`S_NVR];
	  dg_data[`S_RDN]    <= s2p_data[`S_RDN];
	  dg_data[`S_TMEN]   <= s2p_data[`S_TMEN];
          dg_data[`S_CHIP]   <= s2p_data[`S_CHIP];
	  dg_data[`S_VREAD1] <= s2p_data[`S_VREAD1];
          dg_data[`S_VREAD0] <= s2p_data[`S_VREAD0];
          dg_data[`S_DEEPPD] <= s2p_data[`S_DEEPPD];
          dg_data[`S_VMON1]  <= s2p_data[`S_VMON1];
          dg_data[`S_VMON2]  <= s2p_data[`S_VMON2];

	end
    end 
		      
  // switch between functional and test input
  assign ST2IP = (TESTEN) ? dg_data : PDI ;
  
  // Generate busy signal
  reg BUSY;
  always @(negedge RESETb or posedge TCK)
   begin
      if(!RESETb)
       BUSY <= 1'b0;
      else if(s2p_cnt==6'b11_0001)
        BUSY <= 1'b1;
      else
        BUSY <= 1'b0;
   end
       
  //===============================
  // parallel to serial conversion
  //===============================
  reg[6:0] din_sr;   
  reg [1:0] din_s;
  always @(negedge RESETb or posedge TCK)     //for serial output
  begin
    if (!RESETb)
      begin
	din_sr <= {7{1'b1}};
        din_s <= 2'b11;
	TDO<=1'b1;
      end
    else
      begin
	casez (s2p_data[`S_MS])
          `PGMSER_RD_WR : // serial rd/wr
	    if (strobe_t1 && !strobe_t2)
	      begin
		din_sr <= IP2ST[7:1];
		TDO <= IP2ST[0];
	      end
	    else
	      begin
		TDO <= din_sr[0];
		din_sr <= {1'b1, din_sr[6:1]}; 
	      end
           `PGM_RDCK :
                if (serout)
	      begin
		din_s <= test_pass[2:1];
		TDO <= test_pass[0]; 
	      end
	    else
	      begin
		TDO <= din_s[0];
		din_s <= {1'b1, din_s[1]}; 
	      end

          `PGM_RD,`PGM_RD_WORD : // read
	    if (serout)
	      begin
		din_sr <= IP2ST[7:1];
		TDO <= IP2ST[0]; 
	      end
	    else
	      begin
		TDO <= din_sr[0];
		din_sr <= {1'b1, din_sr[6:1]}; 
	      end

          default:
	    begin
	      TDO <= din_sr[0];
	      din_sr <= {1'b1, din_sr[6:1]}; 
	    end
	endcase


      end
  end

  assign DO = IP2ST;

endmodule 

