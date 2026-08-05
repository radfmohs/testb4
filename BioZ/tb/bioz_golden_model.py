#!/usr/bin/env python3
"""
Bit-exact software golden model of BioZ.sv + dds_sincos_10b_lut128_4m.sv.

This is a line-by-line re-implementation of the always-blocks in
dds_sincos_10b_lut128_4m.sv (PHASE_W=32, DITHER_W=8), used to independently
verify the RTL simulation output logged by tb_bioz_dds.sv on a cycle-by-cycle
basis (see run_check.py).
"""

PHASE_W = 32
LUT_ADDR_W = 7
DITHER_W = 8
MASK32 = (1 << 32) - 1
MASK33 = (1 << 33) - 1
PHASE_90 = 0b01 << (PHASE_W - 2)  # {2'b01, {30{1'b0}}} = 0x4000_0000

# Exact copy of sine_quarter_lut() case table from dds_sincos_10b_lut128_4m.sv
SINE_QUARTER_LUT = [
    0, 6, 13, 19, 25, 32, 38, 44, 50, 57, 63, 69, 76, 82, 88, 94,
    100, 107, 113, 119, 125, 131, 137, 143, 149, 156, 162, 167, 173, 179, 185, 191,
    197, 203, 209, 214, 220, 226, 231, 237, 243, 248, 254, 259, 265, 270, 275, 281,
    286, 291, 296, 301, 306, 311, 316, 321, 326, 331, 336, 341, 345, 350, 355, 359,
    364, 368, 372, 377, 381, 385, 389, 393, 397, 401, 405, 409, 413, 416, 420, 424,
    427, 431, 434, 437, 440, 444, 447, 450, 453, 456, 458, 461, 464, 466, 469, 471,
    474, 476, 478, 481, 483, 485, 487, 489, 490, 492, 494, 495, 497, 498, 500, 501,
    502, 503, 504, 505, 506, 507, 508, 509, 509, 510, 510, 510, 511, 511, 511, 511,
]
assert len(SINE_QUARTER_LUT) == 128


def sine_from_phase(phase):
    """phase: unsigned 32-bit int -> signed 10-bit result (-511..511)."""
    quadrant = (phase >> (PHASE_W - 2)) & 0x3
    addr = (phase >> (PHASE_W - 2 - LUT_ADDR_W)) & 0x7F
    addr_mirror = 0x7F - addr
    if quadrant == 0b00:
        mag = SINE_QUARTER_LUT[addr]
    elif quadrant == 0b01:
        mag = SINE_QUARTER_LUT[addr_mirror]
    elif quadrant == 0b10:
        mag = -SINE_QUARTER_LUT[addr]
    else:
        mag = -SINE_QUARTER_LUT[addr_mirror]
    return mag


def to_unsigned10(signed_val):
    """sin_ext = sign-extend(sin_out,11b); sin_offset = sin_ext+512; sin_unsigned=sin_offset[9:0]."""
    sin_ext = signed_val  # already -511..511, fits in signed 11-bit range trivially
    sin_offset = sin_ext + 512
    return sin_offset & 0x3FF


class DDSState:
    __slots__ = ("phase_acc", "sin_out", "cos_out", "dither_lfsr", "i_square", "q_square")

    def __init__(self):
        self.phase_acc = 0
        self.sin_out = 0
        self.cos_out = 0
        self.dither_lfsr = 0xACE1
        self.i_square = 0
        self.q_square = 0


def step(state: DDSState, resetn, enable, dither_en, dither_seed,
         phase_inc, phase_offset, phase_offset_c):
    """Advance one clock edge; returns dict of the *new* dds_sincos raw outputs
    (sin_out_bak/cos_out_bak equivalents, i_square, q_square, phase_acc)."""
    seed_reload = 0xACE1 if dither_seed == 0 else dither_seed

    if not resetn:
        state.phase_acc = 0
        state.sin_out = 0
        state.cos_out = 0
        state.dither_lfsr = seed_reload
        state.i_square = 0
        state.q_square = 0
    elif enable:
        lfsr = state.dither_lfsr
        feedback = ((lfsr >> 15) ^ (lfsr >> 13) ^ (lfsr >> 12) ^ (lfsr >> 10)) & 1
        dither_unsigned = lfsr & ((1 << DITHER_W) - 1)
        centered = dither_unsigned - (1 << (DITHER_W - 1))  # -128..127

        if dither_en:
            shift = (PHASE_W - (2 + LUT_ADDR_W)) - DITHER_W  # DISCARD_W - DITHER_W = 15
            # Python's bitwise AND on negative ints operates on the infinite
            # two's-complement representation, so masking to 32 bits here
            # reproduces the Verilog signed left-shift + wraparound exactly.
            phase_dither = (centered << shift) & MASK32
        else:
            phase_dither = 0

        sin_phase = (state.phase_acc + phase_dither + phase_offset) & MASK32
        cos_phase = (state.phase_acc + phase_dither + phase_offset_c + PHASE_90) & MASK32

        new_sin_out = sine_from_phase(sin_phase)
        new_cos_out = sine_from_phase(cos_phase)
        new_i_square = (~(sin_phase >> (PHASE_W - 1))) & 1
        new_q_square = (~(cos_phase >> (PHASE_W - 1))) & 1
        new_phase_acc = (state.phase_acc + phase_inc) & MASK33

        state.sin_out = new_sin_out
        state.cos_out = new_cos_out
        state.i_square = new_i_square
        state.q_square = new_q_square
        state.phase_acc = new_phase_acc
        state.dither_lfsr = ((lfsr << 1) & 0xFFFF) | feedback
    else:
        state.phase_acc = 0
        state.sin_out = 0
        state.cos_out = 0
        state.dither_lfsr = seed_reload
        state.i_square = 0
        state.q_square = 0

    return {
        "sin_out": state.sin_out,
        "cos_out": state.cos_out,
        "sin_unsigned_bak": to_unsigned10(state.sin_out),
        "cos_unsigned_bak": to_unsigned10(state.cos_out),
        "i_square": state.i_square,
        "q_square": state.q_square,
        "phase_acc": state.phase_acc,
    }


def bioz_top_select(raw, data_type_sel, dc_data, dc_data_c):
    """Reproduce the data_type_sel mux in BioZ.sv itself (wraps the dds core)."""
    if data_type_sel == 0b00:
        sin_u = raw["sin_unsigned_bak"]
        cos_u = raw["cos_unsigned_bak"]
    elif data_type_sel == 0b01:
        sin_u = dc_data
        cos_u = dc_data_c
    else:
        # NOTE: RTL falls back to the sine wave for 2'b10/2'b11, even though
        # README / top_dig.sv comments describe 2'b10 as "square wave".
        sin_u = raw["sin_unsigned_bak"]
        cos_u = raw["cos_unsigned_bak"]
    return sin_u, cos_u
