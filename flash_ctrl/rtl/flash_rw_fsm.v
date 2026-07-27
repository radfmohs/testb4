//============================================================================== 
// ----------------------------------------------------------------------------- 
//  Nanochap Electronics Copyright (C) 2014. ALL RIGHTS RESERVED. 
// ----------------------------------------------------------------------------- 
// Module name     : flash_rw_fsm.v
// Description     : the FSM of read/write/erase
// ----------------------------------------------------------------------------- 
// Revision History: 
// ----------------------------------------------------------------------------- 
// Revision       Date(xxxx-xx-xx)     Author             Description 
// ----------------------------------------------------------------------------- 
//   1.0          2024-10-22           Zhen Cao           Initial version 
//   1.1          2024-11-19           Daniel Dang        Changed format 
// ----------------------------------------------------------------------------- 
//==============================================================================

module flash_rw_fsm 	#(
 // --------------------------------------------------------------------------
 // Parameter Declarations
 // --------------------------------------------------------------------------
	parameter TIMER_BITS = 23)

    (
 // --------------------------------------------------------------------------
 // Port Definitions
 // --------------------------------------------------------------------------
	input wire clk,
	input wire resetn,       
        input wire ext_clk_sel ,	
        //-------------------------
        // R/W Port Interface
        //-------------------------
        input wire           flash_en,
        input wire           flash_inf_rw,
        input wire           reload_trim,
        input wire           rd_spi,
        input wire           reload_rnd,	
        input wire           flash_ser_en,
        input wire           flash_cer_en,
 //       input wire           write_word,
 //       input wire           write_hword,
 //       input wire           write_u_hword,
 //       input wire           write_l_hword,	
//	input wire           trim_read_en_ack,
        input wire           flash_dslp,
	
        input wire           nvr2_trim_tag,
	input wire           confen_valid,

        output wire          flash_inf_blk_rd_set_en,
        output wire          flash_inf_blk_wd_set_en,
        output wire          flash_inf_blk_ser_set_en,
        output wire          flash_inf_blk_cer_set_en,
//        output wire          flash_inf_blk_ao_rd_set_en,
        output wire          flash_ip_por_resetn,
        output wire          rd_addr_add,
        output wire          flash_dslp_ip,
        //-------------------------
        // Trigger signals to outdrv reg 
        //-------------------------
        output wire	     PGRD_muxselect, 
        output wire	     rd_FLASH_OEb,
        output wire	     rd_FLASH_CEb,
 	// Declared as reg to allow LHS assignment in combi always (*)
	output reg 	     drvh_FLASH_CEb,
	output reg 	     drvh_FLASH_WEb,
	output reg 	     drvh_FLASH_PROG,
	output reg 	     drvh_FLASH_PROG2,
	output reg 	     drvh_FLASH_ERASE,
	output reg 	     drvh_FLASH_CHIP,
//	output reg 	     drvh_FLASH_DPSTB,
	output reg 	     drvh_FLASH_por,
	output reg 	     drvh_FLASH_CONFEN,	

	output reg 	     drvl_FLASH_CONFEN,
	output reg 	     drvl_FLASH_CEb,
	output reg 	     drvl_FLASH_WEb,
	output reg 	     drvl_FLASH_PROG,
	output reg 	     drvl_FLASH_PROG2,
	output reg 	     drvl_FLASH_ERASE,
	output reg 	     drvl_FLASH_CHIP,
//	output reg 	     drvl_FLASH_DPSTB,
	
//	output reg 	     drvh_FLASH_BYTE0,  //drvh for byte[1:0]
//	output reg 	     drvh_FLASH_BYTE1,

//	output reg 	     drvl_FLASH_BYTE0,  //drvl for byte[1:0]
//	output reg 	     drvl_FLASH_BYTE1,

	output reg  	     drvl_pdone_out,
	output reg  	     drvh_pdone_out,

	output reg  	     drvl_pbusy_out,
	output reg  	     drvh_pbusy_out
//        output reg   [31:0]  FLASH_DATA_64m,


        // Drive next_state to be registered on FLASH_STATUS register
          
        // One-cycle pulse to load shadow regs -- combi

    );




//timing

//-------------------------
// Timer Count Constants -- from clockcount block
//-------------------------
// PROGRAM Timer Counts
wire [TIMER_BITS-1:0] PROGRAM_Tnvs;
wire [TIMER_BITS-1:0] PROGRAM_Tpgs;
//wire [TIMER_BITS-1:0] PROGRAM_Tpgh;
wire [TIMER_BITS-1:0] PROGRAM_Tprog;
//wire [TIMER_BITS-1:0] PROGRAM_Tads;
//wire [TIMER_BITS-1:0] PROGRAM_Tadh;
wire [TIMER_BITS-1:0] PROGRAM_Trcv;

// ERASE Sector/Chip Timer Counts
wire [TIMER_BITS-1:0] ERASE_Tnvs;
wire [TIMER_BITS-1:0] ERASE_SECTOR_Terase;
wire [TIMER_BITS-1:0] ERASE_CHIP_Terase;
wire [TIMER_BITS-1:0] ERASE_Trcv;



assign  PROGRAM_Tnvs		=	20'd7;	
assign  PROGRAM_Tpgs		=	20'd3;
//assign  PROGRAM_Tpgh		=	20'd1;
assign  PROGRAM_Tprog		=	20'd7;
//assign  PROGRAM_Tads		=	20'd2;
//assign  PROGRAM_Tadh		=	20'd1;
assign  PROGRAM_Trcv		=	20'd6;


assign  ERASE_Tnvs	        =	ext_clk_sel? 20'd7      : 20'd2;
assign  ERASE_SECTOR_Terase	=       ext_clk_sel? 20'd4500   : 20'd562;
assign  ERASE_CHIP_Terase	=       ext_clk_sel? 20'd35000  : 20'd4375;
assign  ERASE_Trcv		=	ext_clk_sel? 20'd55     : 20'd10;

//-----------------------------------------------------------------
// STATE DEFINES
// Tracked by 8-bit [7:0] state registers - 8h'00 to 8h'ff
//-----------------------------------------------------------------

localparam IDLE           = 8'h00;
localparam DPSLEEP        = 8'h01;
localparam READ           = 8'h80;
localparam READ_CE        = 8'h81;
localparam READ_OE        = 8'h82;
localparam READ_ONE_DONE  = 8'h83;
localparam PREPROG_LOAD   = 8'h4F;	// This state generates shadow_reg load
localparam PROG           = 8'h40;

// PROGRAM States for WORD Program

//localparam WR_PG_HWORD_START       = 8'h50;
localparam WR_PG_HWORD_TNVS  	   = 8'h41;
localparam WR_PG_HWORD_TPGS        = 8'h42;
localparam WR_PG_HWORD_TPROG	   = 8'h43;
localparam WR_PG_HWORD_TADH        = 8'h44;
localparam WR_PG_HWORD_TPGH        = 8'h45;
localparam WR_PG_HWORD_TRCV        = 8'h46;
localparam WR_PG_HWORD_DONE        = 8'h47;


//CONFEN STATE FOR NVR2ND PROGROM
localparam WR_CO_START_CONFEN = 8'h55;
localparam WR_CO_TRIMTAG = 8'h54;
localparam WR_CO_CFS = 8'h50;
localparam WR_CO_CONFEN = 8'h51;
localparam WR_CO_CONFEN1 = 8'h56;
localparam WR_CO_CFH	= 8'h52;
localparam WR_CO_DONE   = 8'h53;

localparam WAIT_IP_RESET  = 8'h5e;

// SECTOR Erase States for Sector Erase
//localparam WR_SER_START  = 8'h60;
localparam WR_SER_TNVS   = 8'h61;
localparam WR_SER_TERASE = 8'h62;
localparam WR_SER_TRCV   = 8'h63;
localparam WR_SER_DONE   = 8'h64;

// CHIP Erase States for Sector Erase
//localparam WR_CER_START  = 8'h70;
localparam WR_CER_TNVS   = 8'h71;
localparam WR_CER_TERASE = 8'h72;
localparam WR_CER_TRCV   = 8'h73;
localparam WR_CER_DONE   = 8'h74;


//-----------------------------------------------------------------
// Registers
//-----------------------------------------------------------------

reg  [7:0] state_reg;		
reg  [7:0] next_state;		// declared as reg to assign in LHS of always
reg [TIMER_BITS-1:0] timer_cnt_reg;	// 20-bit counter
wire flash_inf_wr_en;
//-----------------------------------------------------------------
// Signal to enable Timer
// Enable timer only when in PROG where counts are needed
// Timer doesn't run other wise
//-----------------------------------------------------------------

wire timer_enable = state_reg[6];


//-----------------------------------------------------------------
// Generate RD/WR Mux Select control for Outdrv
//-----------------------------------------------------------------

assign PGRD_muxselect  = state_reg[6];  //state_reg[6] = 1 for PROG/SER/CER
assign flash_inf_blk_wd_set_en  = ( (state_reg == WR_CO_CFS) && (next_state == WR_CO_CONFEN1)) || ((state_reg == WR_PG_HWORD_DONE) && (next_state == IDLE));//clk_wr_asyc;
assign flash_inf_blk_rd_set_en    = (state_reg == READ_ONE_DONE)   && (next_state == IDLE);
assign flash_inf_blk_cer_set_en   = (state_reg == WR_CER_DONE) && (next_state == IDLE);
assign flash_inf_blk_ser_set_en   = (state_reg == WR_SER_DONE) && (next_state == IDLE);
//assign flash_inf_blk_ao_rd_set_en = (state_reg == READ_OE);
assign rd_addr_add             = (state_reg == READ_CE)         && (next_state == READ_OE);


assign flash_inf_wr_en = (flash_en) & flash_inf_rw;

wire start_write_ser;
wire start_write_cer;

assign start_write_ser = flash_ser_en;
assign start_write_cer = flash_cer_en;

//-----------------------------------------------------------------
// Signal assignments
//-----------------------------------------------------------------
reg rdpt_CEb_buf, rdpt_OEb_buf;
assign rd_FLASH_CEb   = rdpt_CEb_buf;    //drive read CEb to outdrv 
assign rd_FLASH_OEb   = rdpt_OEb_buf;    //drive read OEb to outdrv 

//-----------------------------------------------------------------
// Register read addr, CEb and OEb for AHB dataphase read
// Register new address during address phase if it is valid AHB request
// Start read only if it is a READ Operation
//-----------------------------------------------------------------

always @ (posedge clk or negedge resetn)
  begin
    if (~resetn)
      begin
        state_reg <= IDLE;
      end
    else
      begin        
        state_reg <= next_state;
      end
  end

//====================

always @ (posedge clk or negedge resetn)
  begin
    if (~resetn)
      begin
       timer_cnt_reg  <= 20'h00000; 
      end

    else
      begin
        //if (state_reg != next_state)
        if (state_reg != next_state)
          begin
            timer_cnt_reg <= 20'h00000;
          end
      
        else 
          begin
            if (timer_enable)  // Count only when timer_enable = 1
              begin
                timer_cnt_reg <= timer_cnt_reg + 1'b1;
              end
            else
              begin
                timer_cnt_reg <= timer_cnt_reg;	
              end
          end
       end
  end

reg flash_ip_por_tmout;
// flash por delay 14ms, as flash can work after flash por 10us 
always @(posedge clk or negedge resetn) begin
    if (~resetn)
        flash_ip_por_tmout <= 1'b0;
    else if (timer_cnt_reg==20'h14)
        flash_ip_por_tmout <= 1'b1;
    else
        flash_ip_por_tmout <= flash_ip_por_tmout;
end

assign flash_ip_por_resetn =  flash_ip_por_tmout;  

//deep sleep mode
wire flash_dslp_sync;
common_sync_bit u_flash_dslp_sync(
       .clk(clk),
       .rst_(resetn),
       .async_in(flash_dslp),
       .sync_out(flash_dslp_sync)
       );

wire [1:0] flash_dslp_in;
assign flash_dslp_in = {(state_reg==IDLE),(state_reg==DPSLEEP)};
common_reg_cond2 #(
.COND_VALUE(2'b01)
)u_flash_dslp(
.clk(clk),
.rst_(resetn),
.cond_in(flash_dslp_in),
.d_out(flash_dslp_ip)
);         

//-----------------------------------------------------------------
// Next State Logic
// Combi always (*) block
//-----------------------------------------------------------------

always @ (*)	

  begin
  
    next_state = state_reg;
   
    case (state_reg)	

      IDLE : 
        begin
          if(flash_dslp_sync)begin
              next_state = DPSLEEP;
          end		
          else if(!flash_ip_por_tmout)begin
              next_state = WAIT_IP_RESET;
          end
          else if (reload_trim || rd_spi || reload_rnd)		
            begin
              next_state = READ;
            end
   
          else if (flash_inf_wr_en | start_write_ser | start_write_cer)
            begin
              next_state = PREPROG_LOAD;
            end
          else if (nvr2_trim_tag)
	  begin
              next_state = WR_CO_TRIMTAG;
	  end
          else if (confen_valid)
            begin
              next_state = WR_CO_START_CONFEN;
            end          
          else
            begin
              next_state = IDLE;
            end
        end

       DPSLEEP: 
       begin
          if(!flash_dslp_sync)begin
              next_state = IDLE;
          end          
          else
            begin
              next_state = DPSLEEP;
            end	       
       end        
///------------------
/// BRANCHING TO RESET
///------------------
      WAIT_IP_RESET :
        begin
          if (timer_cnt_reg >= 20'h14)
	    begin
              next_state = IDLE;
            end

          else 
            begin
              next_state = WAIT_IP_RESET;
            end
        end

///------------------
/// CONFEN REGISTER PROGRAM BRANCH  
///------------------
      WR_CO_TRIMTAG: begin
          next_state = READ;           
      end
             
      WR_CO_START_CONFEN: begin
          next_state = READ;
      end
      
      WR_CO_CFS :
        begin
	       next_state = WR_CO_CONFEN1;	
        end
       WR_CO_CONFEN1 :
        begin
	if (!confen_valid) begin
	next_state = IDLE;
	end
	else begin
	       next_state = WR_CO_CONFEN;	
        end       
        end
      WR_CO_CONFEN :
        begin
	       next_state = WR_CO_CFH;	
        end
      WR_CO_CFH :
        begin	
	       next_state = WR_CO_DONE;	     
        end

      WR_CO_DONE :
        begin
	       next_state = IDLE;	
        end     

///------------------
/// BRANCHING TO READ 
///------------------
      READ :
        begin 
	if(!reload_trim && !rd_spi && !reload_rnd && !nvr2_trim_tag && !confen_valid)  begin
              next_state = IDLE;
	end
        else begin	
              next_state = READ_CE;
	end
        end

      READ_CE :	      
        begin      
	if(!reload_trim && !rd_spi && !reload_rnd && !nvr2_trim_tag && !confen_valid)  begin
              next_state = IDLE;
	end
        else begin	     	
              next_state = READ_OE;
        end
	end	  
      READ_OE :
        begin
	if(!reload_trim && !rd_spi && !reload_rnd && !nvr2_trim_tag && !confen_valid)  begin
              next_state = IDLE;
	end
        else begin			
              next_state = READ_ONE_DONE;     
        end
        end


      READ_ONE_DONE :
        begin
	if (confen_valid)
                   next_state = WR_CO_CFS;
        else
                    next_state = IDLE;
        end
///------------------
/// BRANCHING TO PROGRAM
///------------------

      PREPROG_LOAD :	// One-cycle to allow shadowing of WRCTL Regs
       begin
         next_state = PROG;	
       end


      PROG :
        begin
          if (flash_inf_wr_en)
	    begin
              next_state = WR_PG_HWORD_TNVS;
            end                    
          else if (start_write_ser)
	    begin
              next_state = WR_SER_TNVS;
            end
          
          else if (start_write_cer)
	    begin
              next_state = WR_CER_TNVS;
            end
          
          else
            begin 
              next_state = PROG;
            end
        end 



/// ------------------------ 
/// HALFWORD PROGRAM BRANCH  
/// ------------------------ 
      
      WR_PG_HWORD_TNVS :
        begin
          if (timer_cnt_reg >= PROGRAM_Tnvs-1)
	    begin
              next_state = WR_PG_HWORD_TPGS;
            end

          else 
            begin
              next_state = WR_PG_HWORD_TNVS;
            end
        end
      
      WR_PG_HWORD_TPGS :
        begin
          if (timer_cnt_reg >= PROGRAM_Tpgs-1)
	    begin
              next_state = WR_PG_HWORD_TPROG;
            end

          else 
            begin
              next_state = WR_PG_HWORD_TPGS;
            end
        end
  
      WR_PG_HWORD_TPROG :
        begin
          if (timer_cnt_reg >= PROGRAM_Tprog-1)
	    begin
              next_state = WR_PG_HWORD_TADH;
            end

          else 
            begin
              next_state = WR_PG_HWORD_TPROG;
            end
        end
      
      WR_PG_HWORD_TADH :
        begin
//          if (timer_cnt_reg >= PROGRAM_Tadh-1)
//	    begin
              next_state = WR_PG_HWORD_TPGH;
//            end

//          else 
//            begin
//              next_state = WR_PG_HWORD_TADH;
//            end
        end

      WR_PG_HWORD_TPGH :
        begin
//          if (timer_cnt_reg >= PROGRAM_Tpgh-1)
//	    begin
              next_state = WR_PG_HWORD_TRCV;
//            end

//          else 
//            begin
//              next_state = WR_PG_HWORD_TPGH;
//            end
         end


      WR_PG_HWORD_TRCV :
        begin
          if (timer_cnt_reg >= PROGRAM_Trcv-1)
	    begin
              next_state = WR_PG_HWORD_DONE;
            end

          else 
            begin
              next_state = WR_PG_HWORD_TRCV;
            end
        end

      WR_PG_HWORD_DONE :
        begin

              next_state = IDLE;

        end





/// --------------------- 
/// SECTOR ERASE BRANCH
/// --------------------- 
     
      WR_SER_TNVS :
        begin
          if (timer_cnt_reg >= ERASE_Tnvs-1)
	    begin
              next_state = WR_SER_TERASE;
            end

          else 
            begin
              next_state = WR_SER_TNVS;
            end
        end

      WR_SER_TERASE :
        begin
          if (timer_cnt_reg >= ERASE_SECTOR_Terase-1)
	    begin
              next_state = WR_SER_TRCV;
            end

          else 
            begin
              next_state = WR_SER_TERASE;
            end
        end
      WR_SER_TRCV :
        begin
          if (timer_cnt_reg >= ERASE_Trcv-1)
	    begin
              next_state = WR_SER_DONE;
            end

          else 
            begin
              next_state = WR_SER_TRCV;
            end
        end
      WR_SER_DONE :
        begin

              next_state = IDLE;

        end

/// --------------------- 
/// CHIP ERASE BRANCH  
/// --------------------- 
     
      WR_CER_TNVS :
        begin
          if (timer_cnt_reg >= ERASE_Tnvs-1)
	    begin
              next_state = WR_CER_TERASE;
            end

          else 
            begin
              next_state = WR_CER_TNVS;
            end
        end

      WR_CER_TERASE :
        begin
          if (timer_cnt_reg >= ERASE_CHIP_Terase-1)
	    begin
              next_state = WR_CER_TRCV;
            end

          else 
            begin
              next_state = WR_CER_TERASE;
            end
        end
      WR_CER_TRCV :
        begin
          if (timer_cnt_reg >= ERASE_Trcv-1)
	    begin
              next_state = WR_CER_DONE;
            end

          else 
            begin
              next_state = WR_CER_TRCV;
            end
        end
      WR_CER_DONE :
        begin

              next_state = IDLE;

        end


/// --------------------- 
/// DEEP SLEEP BRANCH???
/// Work in progress
/// --------------------- 
          
    endcase
  end    

//-----------------------------------------------------------------
// Output Logic 
// FSM Output drives triggerring signals
//-----------------------------------------------------------------

always @ (*)
  begin

     rdpt_OEb_buf   = 1'b1;
     rdpt_CEb_buf   = 1'b1;
    //Default assignments - ensure all inputs are assigned

     drvh_FLASH_por     = 1'b0;     	     
     drvh_FLASH_CEb     = 1'b0;     	
     drvh_FLASH_WEb     = 1'b0;
     drvh_FLASH_PROG    = 1'b0;
     drvh_FLASH_PROG2   = 1'b0;
     drvh_FLASH_ERASE   = 1'b0;
     drvh_FLASH_CHIP    = 1'b0;
     drvh_FLASH_CONFEN  = 1'b0;

//     drvh_FLASH_DPSTB   = 1'b0;
     
     drvl_FLASH_CEb     = 1'b0;
     drvl_FLASH_WEb     = 1'b0;
     drvl_FLASH_PROG    = 1'b0;
     drvl_FLASH_PROG2   = 1'b0;
     drvl_FLASH_ERASE   = 1'b0;
     drvl_FLASH_CHIP    = 1'b0;
     drvl_FLASH_CONFEN  = 1'b0;
//     drvl_FLASH_DPSTB   = 1'b0;

//     drvh_FLASH_BYTE0   = 1'b0;
//     drvh_FLASH_BYTE1   = 1'b0;

//     drvl_FLASH_BYTE0   = 1'b0;
//     drvl_FLASH_BYTE1   = 1'b0;
     
     drvl_pdone_out     = 1'b0;
     drvh_pdone_out     = 1'b0;

     drvl_pbusy_out     = 1'b0;
     drvh_pbusy_out     = 1'b0;


     case(state_reg)

///------------------
/// IDLE - Reset all signals to default
///------------------

       IDLE :
	 begin
           drvl_pdone_out      = 1'b1;   //Reset pdone when idle
         end

///------------------
/// BRANCHING TO READ
///------------------
        
       READ :
         begin
         end




///------------------
/// BRANCHING TO READ
///------------------
 
       READ_CE:
	 begin
         end
       READ_OE:
	 begin
	rdpt_OEb_buf   = 1'b0;
	rdpt_CEb_buf   = 1'b0;
         end
       READ_ONE_DONE:
	 begin
	rdpt_OEb_buf   = 1'b1;
	rdpt_CEb_buf   = 1'b1;
         end	 

///------------------
/// BRANCHING TO PREPROG_LOAD
///------------------
      
       PREPROG_LOAD :
         begin 
         end
  
///------------------
/// BRANCHING TO PROGRAM
///------------------

 
       PROG :
         begin
           drvh_pbusy_out      = 1'b1;
         end

///------------------
/// BRANCHING TO POR
///------------------

       WAIT_IP_RESET :
         begin
           drvh_FLASH_por      = 1'b1;
         end

///------------------
/// BRANCHING TO PROGRAM HWORD
///------------------
       
       WR_PG_HWORD_TNVS : 
         begin
           drvl_FLASH_CEb      = 1'b1;
           drvh_FLASH_PROG     = 1'b1;           
         end  
       WR_PG_HWORD_TPGS :
         begin
           drvl_FLASH_WEb      = 1'b1;
         end
 
       WR_PG_HWORD_TPROG :
         begin
           drvh_FLASH_PROG2    = 1'b1;
         end

       WR_PG_HWORD_TADH :
         begin
           drvl_FLASH_PROG2    = 1'b1;
         end
  
       WR_PG_HWORD_TPGH :
         begin
           drvh_FLASH_WEb      = 1'b1;		            
         end 
 
//       WR_PG_HWORD_TRCV :
//         begin
//           drvh_FLASH_WEb      = 1'b1;
//         end

       WR_PG_HWORD_DONE :
         begin
           drvl_FLASH_PROG     = 1'b1;
           drvh_FLASH_CEb      = 1'b1;
         end
	 


///------------------
/// BRANCHING TO SECTOR ERASE
///------------------

       WR_SER_TNVS :
         begin
           drvl_FLASH_CEb       = 1'b1;
           drvh_FLASH_ERASE     = 1'b1;
           drvl_FLASH_CHIP      = 1'b1;
         end
 
       WR_SER_TERASE :
         begin
           drvl_FLASH_WEb	= 1'b1;
         end
         
    
       WR_SER_TRCV :
         begin
           drvh_FLASH_WEb       = 1'b1;
         end
       
       WR_SER_DONE :
         begin
           drvl_FLASH_ERASE    = 1'b1;
           drvh_FLASH_CEb      = 1'b1;
           drvl_pbusy_out      = 1'b1;
           drvh_pdone_out      = 1'b1;
         end

///------------------
/// BRANCHING TO CHIP ERASE 
///------------------
       
       WR_CER_TNVS :
         begin
           drvl_FLASH_CEb       = 1'b1;
           drvh_FLASH_ERASE     = 1'b1;
           drvh_FLASH_CHIP      = 1'b1;
         end
 
       WR_CER_TERASE :
         begin
           drvl_FLASH_WEb	= 1'b1;
         end
         
    
       WR_CER_TRCV :
         begin
           drvh_FLASH_WEb	= 1'b1;
         end
       
       WR_CER_DONE :
         begin
           drvl_FLASH_ERASE	= 1'b1;
           drvh_FLASH_CEb       = 1'b1;
           drvl_FLASH_CHIP	= 1'b1;
	   drvl_pbusy_out       = 1'b1;
           drvh_pdone_out      = 1'b1;
         end


///------------------
/// CONFEN REGISTER PROGRAM   
///------------------
      WR_CO_CFS :
        begin
           drvl_FLASH_CEb       = 1'b1;
        end	   
      WR_CO_CONFEN :
        begin
          drvh_FLASH_CONFEN   = 1'b1;
        end

      WR_CO_CFH :
        begin
          drvl_FLASH_CONFEN   = 1'b1;
        end

      WR_CO_DONE :
        begin
           drvh_FLASH_CEb       = 1'b1;
        end
     endcase
  end

endmodule
