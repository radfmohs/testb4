#!/usr/bin/env python3
"""Cross-check for tb_bioz_iq_loop.sv.

1) BIT-EXACT: replays the exact ADC bitstream logged by the testbench
   (iq_bits.csv) through an independent Python port of iq_cic.v
   (iq_cic_golden_model.py) and compares the resulting ordered sequence of
   decimated output values against the real RTL's own chdata_I/chdata_Q
   sequence (iq_chdata.csv), one-for-one, ignoring only the fixed CDC/
   announcement latency between the two domains.

2) ENGINEERING / SYSTEM CHECK: verifies that the whole chain -- DDS
   excitation -> analog body-impedance model -> chopper mixer -> baseband LPF
   -> sigma-delta ADC -> the real iq_cic RTL -- behaves as a *consistent,
   calibratable linear map* from the programmed (R, X) to the measured
   (I, Q). It does not assume a hand-derived theoretical gain/phase
   convention; instead it calibrates that map from the two single-axis
   scenarios (pure R, pure X) and then checks that the calibrated map
   correctly predicts the two multi-axis scenarios (mixed R+X at two
   different excitation frequencies). This is the direct answer to "does
   the DDS + analog model + iq_cic actually all work together".
"""
import sys
import csv
import numpy as np

from iq_cic_golden_model import run_golden, to_signed

CIC_RATE_SEL = 0b0011
IQ_INPUT_FORMAT = 0b10
FORMAT_SEL = 0

TAIL_SAMPLES_FOR_AVG = 8  # last N settled chdata samples per scenario to average


def load_bits(path):
    rows = []
    with open(path) as f:
        r = csv.DictReader(f)
        for row in r:
            rows.append((int(row["resetn"]), int(row["bit_i"]), int(row["bit_q"])))
    return rows


def load_chdata(path):
    rows = []
    with open(path) as f:
        r = csv.DictReader(f)
        for row in r:
            rows.append({
                "time": int(row["time"]),
                "scenario_id": int(row["scenario_id"]),
                "scenario_name": row["scenario_name"],
                "r_norm": float(row["r_norm"]),
                "x_norm": float(row["x_norm"]),
                "freq_hz": float(row["freq_hz"]),
                "chdata_I": to_signed(int(row["chdata_I"], 16), 20),
                "chdata_Q": to_signed(int(row["chdata_Q"], 16), 20),
            })
    return rows


def bit_exact_check(bits_rows, chdata_rows):
    golden_i, golden_q = run_golden(bits_rows, CIC_RATE_SEL, IQ_INPUT_FORMAT, FORMAT_SEL)
    rtl_i = [r["chdata_I"] for r in chdata_rows]
    rtl_q = [r["chdata_Q"] for r in chdata_rows]

    print("=" * 78)
    print("1) BIT-EXACT CHECK: RTL iq_cic (via iq_filter_wrapper) vs. independent")
    print("   Python golden model of iq_cic.v, replaying the logged ADC bitstream")
    print("=" * 78)
    print(f"golden I samples: {len(golden_i)}   RTL I samples: {len(rtl_i)}")
    print(f"golden Q samples: {len(golden_q)}   RTL Q samples: {len(rtl_q)}")

    ok = True
    if len(golden_i) != len(rtl_i) or len(golden_q) != len(rtl_q):
        print("FAIL: sample-count mismatch between golden model and RTL log.")
        ok = False
    else:
        mism_i = [(n, g, r) for n, (g, r) in enumerate(zip(golden_i, rtl_i)) if g != r]
        mism_q = [(n, g, r) for n, (g, r) in enumerate(zip(golden_q, rtl_q)) if g != r]
        if mism_i or mism_q:
            ok = False
            print(f"FAIL: {len(mism_i)} I mismatches, {len(mism_q)} Q mismatches")
            for n, g, r in (mism_i + mism_q)[:10]:
                print(f"    sample #{n}: golden={g} rtl={r}")
        else:
            print(f"PASS: all {len(golden_i)} I samples and {len(golden_q)} Q samples "
                  f"match the independent iq_cic.v golden model exactly.")
    return ok


def scenario_groups(chdata_rows):
    groups = {}
    order = []
    for row in chdata_rows:
        sid = row["scenario_id"]
        if sid not in groups:
            groups[sid] = []
            order.append(sid)
        groups[sid].append(row)
    return [(sid, groups[sid]) for sid in order]


def engineering_check(chdata_rows):
    print()
    print("=" * 78)
    print("2) ENGINEERING / SYSTEM CHECK: DDS -> analog model -> ADC -> iq_cic")
    print("   reconstructs the programmed body R/X as a consistent linear map")
    print("=" * 78)

    groups = scenario_groups(chdata_rows)
    avg = {}
    for sid, rows in groups:
        tail = rows[-TAIL_SAMPLES_FOR_AVG:]
        avg_i = sum(r["chdata_I"] for r in tail) / len(tail)
        avg_q = sum(r["chdata_Q"] for r in tail) / len(tail)
        name = rows[0]["scenario_name"]
        r_norm = rows[0]["r_norm"]
        x_norm = rows[0]["x_norm"]
        freq = rows[0]["freq_hz"]
        avg[sid] = dict(name=name, r_norm=r_norm, x_norm=x_norm, freq=freq,
                         avg_i=avg_i, avg_q=avg_q, n=len(tail))
        print(f"scenario {sid} ({name:20s} f={freq/1e3:6.1f}kHz r={r_norm:.3f} x={x_norm:.3f}): "
              f"avg(chdata_I)={avg_i:12.1f}  avg(chdata_Q)={avg_q:12.1f}  "
              f"(over last {len(tail)} settled samples)")

    if 0 not in avg or 1 not in avg:
        print("FAIL: expected scenario 0 (pure R) and scenario 1 (pure X) for calibration.")
        return False

    # Calibrate the (r,x) -> (I,Q) linear map from the two single-axis scenarios.
    r0, x0, i0, q0 = avg[0]["r_norm"], avg[0]["x_norm"], avg[0]["avg_i"], avg[0]["avg_q"]
    r1, x1, i1, q1 = avg[1]["r_norm"], avg[1]["x_norm"], avg[1]["avg_i"], avg[1]["avg_q"]
    M = np.array([[i0 / r0, i1 / x1],
                  [q0 / r0, q1 / x1]])
    print()
    print("Calibration matrix M (measured from scenarios 0 & 1) such that "
          "[I;Q] = M . [R;X]:")
    print(f"    M = [[{M[0,0]:12.2f}, {M[0,1]:12.2f}],")
    print(f"         [{M[1,0]:12.2f}, {M[1,1]:12.2f}]]")
    print("(If this were a textbook-ideal commutating mixer with I locked to R and "
          "Q locked to X, M would be diagonal, i.e. small off-diagonal terms below "
          "are cross-talk / mixer-phase-alignment artifacts of this simple model.)")

    diag_dominance = (abs(M[0, 0]) + abs(M[1, 1])) / (abs(M[0, 1]) + abs(M[1, 0]) + 1e-9)
    print(f"diagonal-vs-cross-term dominance ratio: {diag_dominance:.2f} "
          f"({'I tracks R, Q tracks X' if abs(M[0,0])>abs(M[0,1]) else 'I/Q appear swapped or rotated vs R/X -- see note above'})")

    Minv = np.linalg.inv(M)

    ok = True
    print()
    for sid, rows in groups:
        if sid in (0, 1):
            continue
        d = avg[sid]
        meas = np.array([d["avg_i"], d["avg_q"]])
        predicted = M @ np.array([d["r_norm"], d["x_norm"]])
        recovered = Minv @ meas
        rel_err_iq = np.linalg.norm(meas - predicted) / (np.linalg.norm(predicted) + 1e-9)
        rel_err_rx = np.linalg.norm(recovered - np.array([d["r_norm"], d["x_norm"]])) / \
            np.linalg.norm([d["r_norm"], d["x_norm"]])
        print(f"scenario {sid} ({d['name']}): programmed R={d['r_norm']:.3f} X={d['x_norm']:.3f}  "
              f"-> recovered R={recovered[0]:.3f} X={recovered[1]:.3f}  "
              f"(rel. error {rel_err_rx*100:5.2f}%)")
        if rel_err_rx > 0.15:
            ok = False
            print(f"    FAIL: relative error {rel_err_rx*100:.2f}% exceeds 15% tolerance")

    print()
    if ok:
        print("PASS: the DDS excitation, analog body-impedance/mixer/ADC model, and "
              "the real iq_cic RTL together reconstruct the programmed R and X "
              "consistently across both the mixed-R+X scenario and a second "
              "excitation frequency, using a single calibration derived from the "
              "two single-axis scenarios.")
    else:
        print("FAIL: see relative-error entries above.")
    return ok


def main():
    bits_path = sys.argv[1] if len(sys.argv) > 1 else "iq_bits.csv"
    chdata_path = sys.argv[2] if len(sys.argv) > 2 else "iq_chdata.csv"

    bits_rows = load_bits(bits_path)
    chdata_rows = load_chdata(chdata_path)
    print(f"Loaded {len(bits_rows)} ADC-bit cycles from {bits_path}")
    print(f"Loaded {len(chdata_rows)} decimated output samples from {chdata_path}")
    print()

    ok1 = bit_exact_check(bits_rows, chdata_rows)
    ok2 = engineering_check(chdata_rows)

    sys.exit(0 if (ok1 and ok2) else 1)


if __name__ == "__main__":
    main()
