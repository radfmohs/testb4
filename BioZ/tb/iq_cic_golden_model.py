#!/usr/bin/env python3
"""Bit-exact, cycle-accurate Python port of iq_cic/iq_cic.v.

Ports every register and every combinational expression in iq_cic.v 1:1 so
that, given the exact same per-ADC-clock-cycle bitstream (`filter_in`) and
control settings (`cic_rate`, `iq_input_format`, `format_sel`) the RTL was
driven with, this model produces the exact same ordered sequence of decimated
output values.

Rather than also reproducing iq_ctrl.v's 2-adc-clock cont_dely/eoc_out
announcement pipeline (which only adds a *fixed* extra latency and never
changes which values get announced or their order), this model instead
reproduces the equivalent value-level effect directly: iq_ctrl.v silently
discards the first three CIC decimation events after reset (the CIC's own
group-delay warm-up, gated by its `cont_dely` counter) and announces every one
after that. See BioZ/REVIEW.md for the full derivation of this equivalence.
"""

MASK6 = (1 << 6) - 1
MASK12 = (1 << 12) - 1
MASK20 = (1 << 20) - 1
MASK21 = (1 << 21) - 1
MASK35 = (1 << 35) - 1

# cic_rate -> down_rate (iq_cic.v `down_rate` case statement)
_DOWN_RATE_TABLE = {
    0b0000: 0x1F,
    0b0001: 0x3F,
    0b0010: 0x7F,
    0b0011: 0xFF,
    0b0100: 0x1FF,
    0b0101: 0x3FF,
    0b0110: 0x7FF,
    0b1000: 0xF,
    0b1001: 0x7,
}
_DOWN_RATE_DEFAULT = 0x7FF

# cic_rate -> (bits of din_use taken from the LSB side, left-shift amount)
# (iq_cic.v `din_use1` case statement)
_SHIFT_TABLE = {
    0b0000: (17, 18),
    0b0001: (20, 15),
    0b0010: (23, 12),
    0b0011: (26, 9),
    0b0100: (29, 6),
    0b0101: (32, 3),
    0b0110: (35, 0),
    0b1000: (14, 21),
    0b1001: (11, 24),
}
_SHIFT_DEFAULT = (35, 0)


def _down_rate_of(cic_rate):
    return _DOWN_RATE_TABLE.get(cic_rate, _DOWN_RATE_DEFAULT)


def _din_use_of(filter_in_bit, iq_input_format):
    if iq_input_format == 0b00:
        return 1 if filter_in_bit else 0
    elif iq_input_format == 0b01:
        return MASK35 if filter_in_bit else 1
    else:  # 0b10, 0b11
        return 1 if filter_in_bit else MASK35


def _din_use1_of(din_use_35, cic_rate):
    bits, shift = _SHIFT_TABLE.get(cic_rate, _SHIFT_DEFAULT)
    low = din_use_35 & ((1 << bits) - 1)
    return (low << shift) & MASK35


def _saturate(cic_out_0, iq_input_format):
    if iq_input_format == 0b00:
        return cic_out_0 & MASK20
    top2 = (cic_out_0 >> 19) & 0x3
    if top2 == 0b10:
        return 0x80000
    elif top2 == 0b01:
        return 0x7FFFF
    return cic_out_0 & MASK20


def _cic_out_sel(cic_out_0, iq_input_format, format_sel):
    cic_out_1 = _saturate(cic_out_0, iq_input_format)
    if not format_sel:
        return cic_out_1
    sign_bit = (cic_out_1 >> 19) & 1
    ext21 = (sign_bit << 20) | cic_out_1
    cic_unsign = (ext21 + 0x80000) & MASK21
    return cic_unsign & MASK20


def to_signed(val, bits):
    val &= (1 << bits) - 1
    if val & (1 << (bits - 1)):
        val -= (1 << bits)
    return val


class RstSync:
    """Port of common/common_rst_sync.v with RSTBYPASS=0, RSTREQ=0 (exactly how
    iq_cdc.v instantiates it): RSTOUTn asserts (goes low) asynchronously the
    instant RSTINn goes low, but only deasserts (goes high) synchronously,
    3 clock edges after RSTINn goes high (a 3-flop shift register filling
    with 1s). iq_cic's actual `resetn` port is this synchronized cic_rst_n,
    not the raw testbench resetn -- the two differ by this fixed 3-cycle
    deassertion delay, which shifts the phase of every later decimation
    event and must be reproduced exactly for a bit-exact, sample-count-exact
    comparison against the RTL log."""

    def __init__(self):
        self.s0 = 0
        self.s1 = 0
        self.s2 = 0

    def step(self, rstin_n):
        if not rstin_n:
            self.s0 = self.s1 = self.s2 = 0
        else:
            self.s0, self.s1, self.s2 = 1, self.s0, self.s1
        return self.s2


class CicState:
    """Cycle-accurate port of the registers in iq_cic.v."""

    def __init__(self):
        self.reset()

    def reset(self):
        self.count = 0xFFF
        self.integ1 = 0
        self.integ2 = 0
        self.integ3 = 0
        self.comb1 = 0
        self.comb2 = 0
        self.comb3 = 0
        self.cic_out_0 = 0
        self.sample_tmp_d1 = 0
        self.cont_dely = 0
        self.announced_values = []

    def step(self, resetn, filter_in_bit, cic_rate, iq_input_format, format_sel):
        """Advance by one adc_clk edge. Appends to self.announced_values
        whenever this cycle's decimation event is the 4th (or later) one
        since the last reset -- matching iq_ctrl.v's cont_dely>=3 gating."""
        if not resetn:
            self.reset()
            return

        down_rate = _down_rate_of(cic_rate)
        din_use = _din_use_of(filter_in_bit, iq_input_format)
        din_use1 = _din_use1_of(din_use, cic_rate)

        sample_tmp = 1 if self.count >= down_rate else 0
        sample = 1 if (sample_tmp and not self.sample_tmp_d1) else 0

        comb1_dec = (self.integ3 - self.comb1) & MASK35
        comb2_dec = (comb1_dec - self.comb2) & MASK35
        comb3_dec = (comb2_dec - self.comb3) & MASK35

        cont_dely_en = 1 if (self.cont_dely < 3 and sample) else 0

        next_count = 0 if sample else ((self.count + 1) & MASK12)
        next_integ1 = (self.integ1 + din_use1) & MASK35
        next_integ2 = (self.integ1 + self.integ2) & MASK35
        next_integ3 = (self.integ2 + self.integ3) & MASK35

        if sample:
            next_comb1 = self.integ3
            next_comb2 = comb1_dec
            next_comb3 = comb2_dec
            next_cic_out_0 = (comb3_dec >> 14) & MASK21
        else:
            next_comb1, next_comb2, next_comb3 = self.comb1, self.comb2, self.comb3
            next_cic_out_0 = self.cic_out_0

        next_cont_dely = ((self.cont_dely + 1) & 0x7) if cont_dely_en else self.cont_dely

        if sample:
            # equivalent to iq_ctrl.v's cont_dely>=3 announcement gating,
            # collapsed to skip exactly the first 3 decimation events after reset
            already_past_warmup = self.cont_dely >= 3
            if already_past_warmup:
                self.announced_values.append(
                    _cic_out_sel(next_cic_out_0, iq_input_format, format_sel)
                )

        self.count = next_count
        self.integ1, self.integ2, self.integ3 = next_integ1, next_integ2, next_integ3
        self.comb1, self.comb2, self.comb3 = next_comb1, next_comb2, next_comb3
        self.cic_out_0 = next_cic_out_0
        self.sample_tmp_d1 = sample_tmp
        self.cont_dely = next_cont_dely


def run_golden(rows, cic_rate, iq_input_format, format_sel):
    """rows: iterable of (resetn, bit_i, bit_q) in adc_clk cycle order, using
    the raw testbench resetn (i.e. presetn, NOT the internal cic_rst_n).
    Returns (i_sequence, q_sequence) of announced, signed 20-bit chdata values."""
    st_i = CicState()
    st_q = CicState()
    rst_sync = RstSync()  # shared: both channels see the same cic_rst_n

    # iq_cic's `resetn` port (cic_rst_n) and its `filter_in` port (bit_i /
    # bit_q) are both produced by *other* processes in this testbench that
    # are themselves triggered by the exact same adc_clk posedge that
    # iq_cic's own always block reacts to (the reset synchronizer's output
    # register, and this testbench's sigma-delta modulator bit register).
    # Per Verilog NBA semantics, a block cannot see another same-edge
    # process's nonblocking update until the *next* time step -- so on any
    # given adc_clk edge, iq_cic actually consumes the *previous* cycle's
    # already-settled resetn/filter_in values, not the ones just computed on
    # that same edge. Reproduced here by uniformly delaying all three by one
    # row before feeding them into CicState.step().
    prev_cic_rst_n = 0
    prev_bit_i = 0
    prev_bit_q = 0
    for resetn, bit_i, bit_q in rows:
        st_i.step(prev_cic_rst_n, prev_bit_i, cic_rate, iq_input_format, format_sel)
        st_q.step(prev_cic_rst_n, prev_bit_q, cic_rate, iq_input_format, format_sel)
        prev_cic_rst_n = rst_sync.step(resetn)
        prev_bit_i = bit_i
        prev_bit_q = bit_q
    i_seq = [to_signed(v, 20) for v in st_i.announced_values]
    q_seq = [to_signed(v, 20) for v in st_q.announced_values]
    return i_seq, q_seq
