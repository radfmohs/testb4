#!/usr/bin/env python3
"""
Bit-exact software golden model of iq_mismatch_correction.sv
(IN_W=20, OUT_W=20, COEFF_W=18, COEFF_FRAC=16 defaults).
"""

IN_W = 20
OUT_W = 20
COEFF_W = 18
COEFF_FRAC = 16

CENTER_W = IN_W + 1
PROD_W = CENTER_W + COEFF_W
SUM_W = PROD_W + 1

OUT_MAX = (1 << (OUT_W - 1)) - 1
OUT_MIN = -(1 << (OUT_W - 1))
ROUND_HALF = 1 << (COEFF_FRAC - 1)


def to_signed(val, width):
    val &= (1 << width) - 1
    if val & (1 << (width - 1)):
        val -= 1 << width
    return val


def offset_binary_flip(val_signed, width):
    """Verilog: {sign,val} + 2^(width-1), truncated back to `width` bits,
    re-interpreted as signed. This is the classic MSB-invert trick used to
    convert offset-binary <-> two's complement; applying it twice is the
    identity (mod 2^width)."""
    ext = val_signed  # sign-extension does not change the integer value
    added = ext + (1 << (width - 1))
    return to_signed(added, width)


class MismatchState:
    __slots__ = ("i_out_out", "q_out_out", "out_valid", "overflow")

    def __init__(self):
        self.i_out_out = 0
        self.q_out_out = 0
        self.out_valid = 0
        self.overflow = 0


def step(state: MismatchState, rst, in_valid, unsigned_data_input,
         i_in_in, q_in_in, i_offset, q_offset, coeff_a, coeff_b, coeff_c, coeff_d):
    """Advance one posedge clk. Inputs are plain Python ints already
    interpreted as signed IN_W/COEFF_W-bit values. Returns dict with the
    *combinational* i_out/q_out (derived from the state AFTER this edge) plus
    out_valid/overflow (registered)."""
    if rst:
        state.i_out_out = 0
        state.q_out_out = 0
        state.out_valid = 0
        state.overflow = 0
    else:
        state.out_valid = 1 if in_valid else 0
        if in_valid:
            i_in = offset_binary_flip(i_in_in, IN_W) if unsigned_data_input else i_in_in
            q_in = offset_binary_flip(q_in_in, IN_W) if unsigned_data_input else q_in_in

            i_centered = i_in - i_offset
            q_centered = q_in - q_offset

            prod_ai = coeff_a * i_centered
            prod_bq = coeff_b * q_centered
            prod_ci = coeff_c * i_centered
            prod_dq = coeff_d * q_centered

            i_sum = prod_ai + prod_bq
            q_sum = prod_ci + prod_dq

            i_rounded = i_sum + ROUND_HALF
            q_rounded = q_sum + ROUND_HALF

            # Verilog >>> on a signed value is an arithmetic shift, i.e.
            # floor division by 2**COEFF_FRAC (rounds toward -infinity).
            i_shifted = i_rounded >> COEFF_FRAC
            q_shifted = q_rounded >> COEFF_FRAC

            i_overflow = i_shifted > OUT_MAX or i_shifted < OUT_MIN
            q_overflow = q_shifted > OUT_MAX or q_shifted < OUT_MIN

            i_sat = OUT_MAX if i_shifted > OUT_MAX else (OUT_MIN if i_shifted < OUT_MIN else i_shifted)
            q_sat = OUT_MAX if q_shifted > OUT_MAX else (OUT_MIN if q_shifted < OUT_MIN else q_shifted)

            state.i_out_out = i_sat
            state.q_out_out = q_sat
            state.overflow = 1 if (i_overflow or q_overflow) else 0
        # else: i_out_out/q_out_out/overflow hold their previous value

    if unsigned_data_input:
        i_out = offset_binary_flip(state.i_out_out, OUT_W)
        q_out = offset_binary_flip(state.q_out_out, OUT_W)
    else:
        i_out = state.i_out_out
        q_out = state.q_out_out

    return {
        "i_out": i_out,
        "q_out": q_out,
        "out_valid": state.out_valid,
        "overflow": state.overflow,
    }
