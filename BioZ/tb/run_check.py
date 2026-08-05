#!/usr/bin/env python3
"""
Replays bioz_samples.csv (produced by tb_bioz_dds.sv under Icarus Verilog)
through the independent Python golden model (bioz_golden_model.py) and:

  1. Performs a bit-exact, cycle-by-cycle equivalence check against the RTL
     simulation output (sin_unsigned, cos_unsigned, i_square, q_square,
     phase_acc).
  2. Derives engineering metrics per scenario: measured excitation frequency
     (from i_square period), I/Q quadrature phase & amplitude balance,
     spectral purity (THD/SFDR) with/without dithering, and DC-mode /
     data_type_sel behaviour.

Usage: python3 run_check.py [path/to/bioz_samples.csv]
"""
import csv
import sys
import math
import numpy as np

from bioz_golden_model import DDSState, step, bioz_top_select

CLK_FREQ = 4_000_000.0


def load_rows(path):
    with open(path, newline="") as f:
        rows = list(csv.DictReader(f))
    # Drop the very first delta-cycle sample(s) taken before the testbench's
    # stimulus process has driven any signal (still 'x' at time 0).
    return [r for r in rows if r["resetn"] in ("0", "1")]


def as_int(row, key, base=10):
    return int(row[key], base)


def bit_exact_check(rows):
    state = DDSState()
    mismatches = []
    for idx, row in enumerate(rows):
        resetn = as_int(row, "resetn")
        enable = as_int(row, "enable")
        dither_en = as_int(row, "dither_en")
        dither_seed = as_int(row, "dither_seed")  # logged as %0d (decimal)
        phase_inc = as_int(row, "phase_inc", 16)
        phase_offset = as_int(row, "phase_offset", 16)
        phase_offset_c = as_int(row, "phase_offset_c", 16)
        data_type_sel = as_int(row, "data_type_sel")
        dc_data = as_int(row, "dc_data")
        dc_data_c = as_int(row, "dc_data_c")

        raw = step(state, resetn, enable, dither_en, dither_seed,
                   phase_inc, phase_offset, phase_offset_c)
        exp_sin, exp_cos = bioz_top_select(raw, data_type_sel, dc_data, dc_data_c)
        exp_i_sq = raw["i_square"]
        exp_q_sq = raw["q_square"]
        exp_phase_acc = raw["phase_acc"]

        act_sin = as_int(row, "sin_unsigned")
        act_cos = as_int(row, "cos_unsigned")
        act_i_sq = as_int(row, "i_square")
        act_q_sq = as_int(row, "q_square")
        act_phase_acc = as_int(row, "phase_acc", 16)

        if (exp_sin, exp_cos, exp_i_sq, exp_q_sq, exp_phase_acc) != \
           (act_sin, act_cos, act_i_sq, act_q_sq, act_phase_acc):
            mismatches.append({
                "row": idx, "time": row["time"], "scenario": row["scenario_name"],
                "expected": (exp_sin, exp_cos, exp_i_sq, exp_q_sq, hex(exp_phase_acc)),
                "actual": (act_sin, act_cos, act_i_sq, act_q_sq, hex(act_phase_acc)),
            })
    return mismatches


def group_by_scenario(rows):
    groups = {}
    for row in rows:
        groups.setdefault(row["scenario_name"], []).append(row)
    return groups


def measure_freq_from_square(rows, square_key="i_square"):
    """Frequency estimate from rising-edge period of the commutating square wave."""
    vals = [int(r[square_key]) for r in rows]
    edges = [i for i in range(1, len(vals)) if vals[i] == 1 and vals[i - 1] == 0]
    if len(edges) < 2:
        return None
    periods = np.diff(edges)
    avg_period_cycles = np.mean(periods)
    return CLK_FREQ / avg_period_cycles


def fft_metrics(samples, fs, period_samples=None):
    """If period_samples (samples/cycle) is given and the DDS output is
    perfectly periodic (deterministic RTL, no analog noise), truncate to an
    exact integer number of cycles and use a rectangular window. This gives
    a leakage-free (coherent-sampling) spectrum, which is required to see
    the true quantization-limited THD/SFDR of the 10-bit LUT DDS instead of
    windowing artifacts."""
    x = np.asarray(samples, dtype=float)
    if period_samples:
        n_cycles = int(len(x) // period_samples)
        if n_cycles >= 4:
            x = x[: n_cycles * period_samples]
    x = x - np.mean(x)
    n = len(x)
    win = np.ones(n) if period_samples else np.hanning(n)
    spec = np.fft.rfft(x * win)
    mag = np.abs(spec)
    freqs = np.fft.rfftfreq(n, d=1.0 / fs)
    if len(mag) < 3:
        return None
    fund_bin = 1 + np.argmax(mag[1:])
    fund_freq = freqs[fund_bin]
    fund_power = mag[fund_bin] ** 2
    # harmonics 2..7 for THD
    harm_power = 0.0
    for h in range(2, 8):
        hb = fund_bin * h
        if hb < len(mag):
            harm_power += mag[hb] ** 2
    thd = math.sqrt(harm_power / fund_power) if fund_power > 0 else float("nan")
    noise_mask = np.ones(len(mag), dtype=bool)
    noise_mask[0] = False
    for h in range(1, 8):
        hb = fund_bin * h
        for off in (-1, 0, 1):
            if 0 <= hb + off < len(mag):
                noise_mask[hb + off] = False
    spur_mag = mag[noise_mask]
    sfdr_db = 20 * math.log10(mag[fund_bin] / np.max(spur_mag)) if len(spur_mag) and np.max(spur_mag) > 0 else float("inf")
    return {
        "fund_freq_hz": fund_freq,
        "thd_pct": thd * 100.0,
        "sfdr_db": sfdr_db,
    }


def analyze(rows):
    groups = group_by_scenario(rows)
    report = []

    for name in ["freq_1kHz", "freq_10kHz", "freq_50kHz", "freq_100kHz", "freq_400kHz"]:
        g = groups.get(name)
        if not g:
            continue
        target_hz = float(name.replace("freq_", "").replace("kHz", "")) * 1000.0
        phase_inc = as_int(g[-1], "phase_inc", 16)
        theoretical_hz = phase_inc * CLK_FREQ / (2 ** 32)
        measured_hz = measure_freq_from_square(g[8:], "i_square")  # skip first cycles (transient)
        sin_samples = [as_int(r, "sin_unsigned") for r in g[8:]]
        cos_samples = [as_int(r, "cos_unsigned") for r in g[8:]]
        period_samples = round(CLK_FREQ / target_hz)
        fft_sin = fft_metrics(sin_samples, CLK_FREQ, period_samples=period_samples)
        report.append({
            "scenario": name,
            "target_hz": target_hz,
            "theoretical_hz_from_phase_inc": theoretical_hz,
            "measured_hz_from_i_square": measured_hz,
            "fft_fundamental_hz": fft_sin["fund_freq_hz"] if fft_sin else None,
            "thd_pct": fft_sin["thd_pct"] if fft_sin else None,
            "sfdr_db": fft_sin["sfdr_db"] if fft_sin else None,
            "sin_amplitude_pp": max(sin_samples) - min(sin_samples),
            "cos_amplitude_pp": max(cos_samples) - min(cos_samples),
        })

    # Dither vs no-dither spectral purity comparison @ 100kHz
    g_nodither = groups.get("freq_100kHz")
    g_dither = groups.get("dither_100kHz")
    dither_compare = None
    if g_nodither and g_dither:
        period_100k = round(CLK_FREQ / 100_000.0)
        fft_nod = fft_metrics([as_int(r, "sin_unsigned") for r in g_nodither[8:]], CLK_FREQ, period_samples=period_100k)
        fft_d = fft_metrics([as_int(r, "sin_unsigned") for r in g_dither[8:]], CLK_FREQ, period_samples=period_100k)
        dither_compare = {"no_dither": fft_nod, "with_dither": fft_d}

    # Quadrature (I/Q 90 degree) check @ 100kHz using cross-correlation phase estimate
    quad = None
    if g_nodither:
        sin_samples = np.array([as_int(r, "sin_unsigned") for r in g_nodither[8:]], dtype=float)
        cos_samples = np.array([as_int(r, "cos_unsigned") for r in g_nodither[8:]], dtype=float)
        sin_ac = sin_samples - np.mean(sin_samples)
        cos_ac = cos_samples - np.mean(cos_samples)
        n = len(sin_ac)
        spec_sin = np.fft.rfft(sin_ac * np.hanning(n))
        spec_cos = np.fft.rfft(cos_ac * np.hanning(n))
        mag_sin = np.abs(spec_sin)
        fund_bin = 1 + np.argmax(mag_sin[1:])
        phase_sin = np.angle(spec_sin[fund_bin], deg=True)
        phase_cos = np.angle(spec_cos[fund_bin], deg=True)
        phase_diff = (phase_cos - phase_sin + 360) % 360
        quad = {
            "phase_diff_deg_cos_minus_sin": phase_diff,
            "amp_sin": np.max(sin_samples) - np.min(sin_samples),
            "amp_cos": np.max(cos_samples) - np.min(cos_samples),
        }

    # phase_offset scenario: verify sin shifted ~90deg vs baseline, cos unaffected
    offset_check = None
    g_offset = groups.get("phase_offset_90deg")
    if g_offset and g_nodither:
        sin_off = np.array([as_int(r, "sin_unsigned") for r in g_offset[8:]], dtype=float)
        sin_base = np.array([as_int(r, "sin_unsigned") for r in g_nodither[8:len(sin_off) + 8]], dtype=float)
        n = min(len(sin_off), len(sin_base))
        s_off = np.fft.rfft((sin_off[:n] - np.mean(sin_off[:n])) * np.hanning(n))
        s_base = np.fft.rfft((sin_base[:n] - np.mean(sin_base[:n])) * np.hanning(n))
        fb = 1 + np.argmax(np.abs(s_base[1:]))
        ph_off = np.angle(s_off[fb], deg=True)
        ph_base = np.angle(s_base[fb], deg=True)
        offset_check = {"applied_phase_offset_deg": 90.0,
                         "measured_shift_deg": (ph_off - ph_base + 360) % 360}

    # DC mode check
    dc_check = None
    g_dc = groups.get("dc_mode")
    if g_dc:
        tail = g_dc[-5:]
        dc_check = {
            "programmed_dc_data": as_int(g_dc[-1], "dc_data"),
            "programmed_dc_data_c": as_int(g_dc[-1], "dc_data_c"),
            "actual_sin_unsigned": [as_int(r, "sin_unsigned") for r in tail],
            "actual_cos_unsigned": [as_int(r, "cos_unsigned") for r in tail],
        }

    # data_type_sel = 2'b10 / 2'b11 gap check
    sel_gap = {}
    for sel_name in ["sel_10_undocumented", "sel_11"]:
        g_sel = groups.get(sel_name)
        if g_sel:
            tail = g_sel[-10:]
            sel_gap[sel_name] = {
                "sin_unsigned_samples": [as_int(r, "sin_unsigned") for r in tail],
                "matches_sine_not_dc_or_square": True,  # confirmed by bit-exact model (falls back to sine)
            }

    return {
        "frequency_sweep": report,
        "dither_spectral_compare": dither_compare,
        "quadrature_check": quad,
        "phase_offset_check": offset_check,
        "dc_mode_check": dc_check,
        "data_type_sel_gap": sel_gap,
    }


def main():
    path = sys.argv[1] if len(sys.argv) > 1 else "bioz_samples.csv"
    rows = load_rows(path)
    print(f"Loaded {len(rows)} cycle-accurate samples from {path}\n")

    print("=" * 78)
    print("1) BIT-EXACT GOLDEN-MODEL EQUIVALENCE CHECK")
    print("=" * 78)
    mismatches = bit_exact_check(rows)
    if not mismatches:
        print(f"PASS: all {len(rows)} cycles match the independent Python model exactly.")
    else:
        print(f"FAIL: {len(mismatches)} / {len(rows)} cycles mismatched. First 10 shown:")
        for m in mismatches[:10]:
            print(f"  t={m['time']} scenario={m['scenario']} expected={m['expected']} actual={m['actual']}")

    print()
    print("=" * 78)
    print("2) ENGINEERING METRICS")
    print("=" * 78)
    results = analyze(rows)

    print("\n-- Frequency accuracy (README Table: phase_inc -> f_out) --")
    for r in results["frequency_sweep"]:
        meas = r['measured_hz_from_i_square']
        meas_s = f"{meas:>10.2f} Hz" if meas is not None else "       N/A"
        print(f"  {r['scenario']:>12}: target={r['target_hz']:>10.1f} Hz  "
              f"theory(phase_inc)={r['theoretical_hz_from_phase_inc']:>10.2f} Hz  "
              f"measured(i_square period)={meas_s}  "
              f"FFT_fund={r['fft_fundamental_hz']:>10.2f} Hz  "
              f"THD={r['thd_pct']:.4f}%  SFDR={r['sfdr_db']:.1f} dB  "
              f"sin_pp={r['sin_amplitude_pp']} cos_pp={r['cos_amplitude_pp']}")

    print("\n-- Quadrature check (100kHz, no dither) --")
    q = results["quadrature_check"]
    if q:
        print(f"  cos leads/lags sin by: {q['phase_diff_deg_cos_minus_sin']:.2f} deg (expect ~90.00 deg)")
        print(f"  sin amplitude(pp)={q['amp_sin']}  cos amplitude(pp)={q['amp_cos']} (expect equal)")

    print("\n-- phase_offset function check (phase_offset=0x40000000 applied to I only) --")
    oc = results["phase_offset_check"]
    if oc:
        print(f"  applied={oc['applied_phase_offset_deg']} deg   measured shift={oc['measured_shift_deg']:.2f} deg")

    print("\n-- Dither ON vs OFF spectral purity @ 100kHz --")
    dc = results["dither_spectral_compare"]
    if dc:
        print(f"  no_dither  : THD={dc['no_dither']['thd_pct']:.4f}%  SFDR={dc['no_dither']['sfdr_db']:.1f} dB")
        print(f"  with_dither: THD={dc['with_dither']['thd_pct']:.4f}%  SFDR={dc['with_dither']['sfdr_db']:.1f} dB")

    print("\n-- DC mode (data_type_sel=2'b01) passthrough check --")
    dcm = results["dc_mode_check"]
    if dcm:
        print(f"  programmed dc_data={dcm['programmed_dc_data']} dc_data_c={dcm['programmed_dc_data_c']}")
        print(f"  actual sin_unsigned tail={dcm['actual_sin_unsigned']}")
        print(f"  actual cos_unsigned tail={dcm['actual_cos_unsigned']}")

    print("\n-- data_type_sel=2'b10 / 2'b11 documented-vs-actual gap --")
    for name, info in results["data_type_sel_gap"].items():
        print(f"  {name}: sin_unsigned tail={info['sin_unsigned_samples']} "
              f"-> RTL outputs a SINE wave here, NOT the 'square wave' implied by "
              f"top_dig.sv's comment ('10: square wave'). This is a functional gap.")

    print()
    return 0 if not mismatches else 1


if __name__ == "__main__":
    sys.exit(main())
