// 10-bit signed-output sine/cosine DDS for IQ demodulation references.
// 
// LUT resolution:
// quarter wave = 128 stored steps
// full wave    = 512 phase steps after quadrant mirroring
// Frequency control:
// //   f_out = phase_inc * f_clk / 2^PHASE_W
// For f_clk = 4_000_000 Hz and PHASE_W = 32:
// //   phase_inc = round(f_out * 2^32 / 4_000_000)
//
// Examples at 4 MHz:
// //   DC      : phase_inc = 32'h0000_0000
// //   50 kHz  : phase_inc = 32'h0333_3333
// //   100 kHz : phase_inc = 32'h0666_6666
// //   400 kHz : phase_inc = 32'h1999_999A





module dds_sincos_10b_lut128_4m #(
    parameter integer PHASE_W = 32
) (
    input  wire                    clk,
    input  wire                    rstn,
    input  wire                    enable,
    input  wire [PHASE_W-1:0]      phase_inc,
    input  wire [PHASE_W-1:0]      phase_offset,  //if don't start from 0
    input  wire [PHASE_W-1:0]      phase_offset_c,  //if don't start from 0
    output wire unsigned [9:0]     sin_unsigned,
    output wire unsigned [9:0]     cos_unsigned,
    output reg  		   i_square,
    output reg  		   q_square,
    //output reg  [PHASE_W-1:0]      phase_acc
    output reg  [PHASE_W:0]      phase_acc    //incase want to use this fout
);

    localparam integer LUT_ADDR_W = 7;
    localparam [PHASE_W-1:0] PHASE_90 = {2'b01, {(PHASE_W-2){1'b0}}};

    reg  signed [9:0]       sin_out;
    reg  signed [9:0]       cos_out;
    wire [PHASE_W-1:0] sin_phase = phase_acc[PHASE_W-1:0] + phase_offset;
    wire [PHASE_W-1:0] cos_phase = phase_acc[PHASE_W-1:0] + phase_offset_c + PHASE_90;

    function signed [9:0] sine_quarter_lut;
        input [LUT_ADDR_W-1:0] addr;
        begin
            case (addr)
                7'd0  : sine_quarter_lut = 10'sd0;
                7'd1  : sine_quarter_lut = 10'sd6;
                7'd2  : sine_quarter_lut = 10'sd13;
                7'd3  : sine_quarter_lut = 10'sd19;
                7'd4  : sine_quarter_lut = 10'sd25;
                7'd5  : sine_quarter_lut = 10'sd32;
                7'd6  : sine_quarter_lut = 10'sd38;
                7'd7  : sine_quarter_lut = 10'sd44;
                7'd8  : sine_quarter_lut = 10'sd50;
                7'd9  : sine_quarter_lut = 10'sd57;
                7'd10 : sine_quarter_lut = 10'sd63;
                7'd11 : sine_quarter_lut = 10'sd69;
                7'd12 : sine_quarter_lut = 10'sd76;
                7'd13 : sine_quarter_lut = 10'sd82;
                7'd14 : sine_quarter_lut = 10'sd88;
                7'd15 : sine_quarter_lut = 10'sd94;
                7'd16 : sine_quarter_lut = 10'sd100;
                7'd17 : sine_quarter_lut = 10'sd107;
                7'd18 : sine_quarter_lut = 10'sd113;
                7'd19 : sine_quarter_lut = 10'sd119;
                7'd20 : sine_quarter_lut = 10'sd125;
                7'd21 : sine_quarter_lut = 10'sd131;
                7'd22 : sine_quarter_lut = 10'sd137;
                7'd23 : sine_quarter_lut = 10'sd143;
                7'd24 : sine_quarter_lut = 10'sd149;
                7'd25 : sine_quarter_lut = 10'sd156;
                7'd26 : sine_quarter_lut = 10'sd162;
                7'd27 : sine_quarter_lut = 10'sd167;
                7'd28 : sine_quarter_lut = 10'sd173;
                7'd29 : sine_quarter_lut = 10'sd179;
                7'd30 : sine_quarter_lut = 10'sd185;
                7'd31 : sine_quarter_lut = 10'sd191;
                7'd32 : sine_quarter_lut = 10'sd197;
                7'd33 : sine_quarter_lut = 10'sd203;
                7'd34 : sine_quarter_lut = 10'sd209;
                7'd35 : sine_quarter_lut = 10'sd214;
                7'd36 : sine_quarter_lut = 10'sd220;
                7'd37 : sine_quarter_lut = 10'sd226;
                7'd38 : sine_quarter_lut = 10'sd231;
                7'd39 : sine_quarter_lut = 10'sd237;
                7'd40 : sine_quarter_lut = 10'sd243;
                7'd41 : sine_quarter_lut = 10'sd248;
                7'd42 : sine_quarter_lut = 10'sd254;
                7'd43 : sine_quarter_lut = 10'sd259;
                7'd44 : sine_quarter_lut = 10'sd265;
                7'd45 : sine_quarter_lut = 10'sd270;
                7'd46 : sine_quarter_lut = 10'sd275;
                7'd47 : sine_quarter_lut = 10'sd281;
                7'd48 : sine_quarter_lut = 10'sd286;
                7'd49 : sine_quarter_lut = 10'sd291;
                7'd50 : sine_quarter_lut = 10'sd296;
                7'd51 : sine_quarter_lut = 10'sd301;
                7'd52 : sine_quarter_lut = 10'sd306;
                7'd53 : sine_quarter_lut = 10'sd311;
                7'd54 : sine_quarter_lut = 10'sd316;
                7'd55 : sine_quarter_lut = 10'sd321;
                7'd56 : sine_quarter_lut = 10'sd326;
                7'd57 : sine_quarter_lut = 10'sd331;
                7'd58 : sine_quarter_lut = 10'sd336;
                7'd59 : sine_quarter_lut = 10'sd341;
                7'd60 : sine_quarter_lut = 10'sd345;
                7'd61 : sine_quarter_lut = 10'sd350;
                7'd62 : sine_quarter_lut = 10'sd355;
                7'd63 : sine_quarter_lut = 10'sd359;
                7'd64 : sine_quarter_lut = 10'sd364;
                7'd65 : sine_quarter_lut = 10'sd368;
                7'd66 : sine_quarter_lut = 10'sd372;
                7'd67 : sine_quarter_lut = 10'sd377;
                7'd68 : sine_quarter_lut = 10'sd381;
                7'd69 : sine_quarter_lut = 10'sd385;
                7'd70 : sine_quarter_lut = 10'sd389;
                7'd71 : sine_quarter_lut = 10'sd393;
                7'd72 : sine_quarter_lut = 10'sd397;
                7'd73 : sine_quarter_lut = 10'sd401;
                7'd74 : sine_quarter_lut = 10'sd405;
                7'd75 : sine_quarter_lut = 10'sd409;
                7'd76 : sine_quarter_lut = 10'sd413;
                7'd77 : sine_quarter_lut = 10'sd416;
                7'd78 : sine_quarter_lut = 10'sd420;
                7'd79 : sine_quarter_lut = 10'sd424;
                7'd80 : sine_quarter_lut = 10'sd427;
                7'd81 : sine_quarter_lut = 10'sd431;
                7'd82 : sine_quarter_lut = 10'sd434;
                7'd83 : sine_quarter_lut = 10'sd437;
                7'd84 : sine_quarter_lut = 10'sd440;
                7'd85 : sine_quarter_lut = 10'sd444;
                7'd86 : sine_quarter_lut = 10'sd447;
                7'd87 : sine_quarter_lut = 10'sd450;
                7'd88 : sine_quarter_lut = 10'sd453;
                7'd89 : sine_quarter_lut = 10'sd456;
                7'd90 : sine_quarter_lut = 10'sd458;
                7'd91 : sine_quarter_lut = 10'sd461;
                7'd92 : sine_quarter_lut = 10'sd464;
                7'd93 : sine_quarter_lut = 10'sd466;
                7'd94 : sine_quarter_lut = 10'sd469;
                7'd95 : sine_quarter_lut = 10'sd471;
                7'd96 : sine_quarter_lut = 10'sd474;
                7'd97 : sine_quarter_lut = 10'sd476;
                7'd98 : sine_quarter_lut = 10'sd478;
                7'd99 : sine_quarter_lut = 10'sd481;
                7'd100: sine_quarter_lut = 10'sd483;
                7'd101: sine_quarter_lut = 10'sd485;
                7'd102: sine_quarter_lut = 10'sd487;
                7'd103: sine_quarter_lut = 10'sd489;
                7'd104: sine_quarter_lut = 10'sd490;
                7'd105: sine_quarter_lut = 10'sd492;
                7'd106: sine_quarter_lut = 10'sd494;
                7'd107: sine_quarter_lut = 10'sd495;
                7'd108: sine_quarter_lut = 10'sd497;
                7'd109: sine_quarter_lut = 10'sd498;
                7'd110: sine_quarter_lut = 10'sd500;
                7'd111: sine_quarter_lut = 10'sd501;
                7'd112: sine_quarter_lut = 10'sd502;
                7'd113: sine_quarter_lut = 10'sd503;
                7'd114: sine_quarter_lut = 10'sd504;
                7'd115: sine_quarter_lut = 10'sd505;
                7'd116: sine_quarter_lut = 10'sd506;
                7'd117: sine_quarter_lut = 10'sd507;
                7'd118: sine_quarter_lut = 10'sd508;
                7'd119: sine_quarter_lut = 10'sd509;
                7'd120: sine_quarter_lut = 10'sd509;
                7'd121: sine_quarter_lut = 10'sd510;
                7'd122: sine_quarter_lut = 10'sd510;
                7'd123: sine_quarter_lut = 10'sd510;
                7'd124: sine_quarter_lut = 10'sd511;
                7'd125: sine_quarter_lut = 10'sd511;
                7'd126: sine_quarter_lut = 10'sd511;
                7'd127: sine_quarter_lut = 10'sd511;
                default: sine_quarter_lut = 10'sd0;
            endcase
        end
    endfunction

    function signed [9:0] sine_from_phase;
        input [PHASE_W-1:0] phase;
        reg [1:0] quadrant;
        reg [LUT_ADDR_W-1:0] addr;
        reg [LUT_ADDR_W-1:0] addr_mirror;
        reg signed [9:0] mag;
        begin
            quadrant = phase[PHASE_W-1:PHASE_W-2];
            addr = phase[PHASE_W-3 -: LUT_ADDR_W];
            addr_mirror = {LUT_ADDR_W{1'b1}} - addr;

            case (quadrant)
                2'b00: mag = sine_quarter_lut(addr);
                2'b01: mag = sine_quarter_lut(addr_mirror);
                2'b10: mag = -sine_quarter_lut(addr);
                2'b11: mag = -sine_quarter_lut(addr_mirror);
                default: mag = 10'sd0;
            endcase

            sine_from_phase = mag;
        end
    endfunction

    always @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            phase_acc <= {(PHASE_W+1'b1){1'b0}};
            sin_out   <= 10'sd0;
            cos_out   <= 10'sd0;
        end else if (enable) begin
            sin_out   <= sine_from_phase(sin_phase);
            cos_out   <= sine_from_phase(cos_phase);
            phase_acc <= phase_acc + phase_inc;
        end else begin
            phase_acc <= {(PHASE_W+1'b1){1'b0}};
            sin_out   <= 10'sd0;
            cos_out   <= 10'sd0;
 	end
    end

wire signed [10:0] sin_ext = {sin_out[9], sin_out};
wire signed [10:0] cos_ext = {cos_out[9], cos_out};

wire [10:0] sin_offset = sin_ext + 11'sd512;
wire [10:0] cos_offset = cos_ext + 11'sd512;

assign sin_unsigned = sin_offset[9:0];
assign cos_unsigned = cos_offset[9:0];

//wire [1:0] quadrant = phase_acc[PHASE_W-1:PHASE_W-2];

wire[PHASE_W-1:0]   i_square_inv;
//assign i_square_inv = ~phase_acc;
assign i_square_inv = ~sin_phase;
//assign i_square = i_square_inv[PHASE_W-1]; 
    always @(posedge clk or negedge rstn) begin
        if (~rstn)
		i_square <= 1'b0;
	else if(enable) 
		i_square <=  i_square_inv[PHASE_W-1];
	else 
		i_square <= 1'b0;

    end
// 0~180 deg = 1, 180~360 deg = 0

wire[PHASE_W-1:0]   q_square_inv;
//assign q_square_inv = ~(phase_acc + PHASE_90);
assign q_square_inv = ~cos_phase;
//assign q_square = q_square_inv[PHASE_W-1];
    always @(posedge clk or negedge rstn) begin
        if (~rstn)
		q_square <= 1'b0;
	else if(enable)
		q_square <= q_square_inv[PHASE_W-1];
	else 
		q_square <= 1'b0;

    end
 // shift 90 square wave

endmodule

