#!/usr/bin/env python3
"""
Replays iq_mismatch_samples.csv through the independent Python golden model
(iq_mismatch_golden_model.py) for a bit-exact equivalence check, then reports
per-scenario engineering results (offset removal, gain correction, the
gain+phase mismatch-correction numerical example from
Bioimpedance_IQ_Demod_SysAna.docx, saturation, unsigned-mode passthrough).
"""
import csv
import sys

from iq_mismatch_golden_model import MismatchState, step


def as_int(row, key):
    return int(row[key])


def load_rows(path):
    with open(path, newline="") as f:
        rows = list(csv.DictReader(f))
    return [r for r in rows if r["rst"] in ("0", "1")]


def group_by_vec(rows):
    groups = {}
    for row in rows:
        groups.setdefault(row["vec_name"], []).append(row)
    return groups


def bit_exact_check(rows):
    state = MismatchState()
    mismatches = []
    for idx, row in enumerate(rows):
        rst = as_int(row, "rst")
        in_valid = as_int(row, "in_valid")
        unsigned_data_input = as_int(row, "unsigned_data_input")
        i_in_in = as_int(row, "i_in_in")
        q_in_in = as_int(row, "q_in_in")
        i_offset = as_int(row, "i_offset")
        q_offset = as_int(row, "q_offset")
        coeff_a = as_int(row, "coeff_a")
        coeff_b = as_int(row, "coeff_b")
        coeff_c = as_int(row, "coeff_c")
        coeff_d = as_int(row, "coeff_d")

        exp = step(state, rst, in_valid, unsigned_data_input,
                   i_in_in, q_in_in, i_offset, q_offset,
                   coeff_a, coeff_b, coeff_c, coeff_d)

        act = {
            "i_out": as_int(row, "i_out"),
            "q_out": as_int(row, "q_out"),
            "out_valid": as_int(row, "out_valid"),
            "overflow": as_int(row, "overflow"),
        }
        if exp != act:
            mismatches.append({"row": idx, "time": row["time"], "vec": row["vec_name"],
                                "expected": exp, "actual": act})
    return mismatches


def main():
    path = sys.argv[1] if len(sys.argv) > 1 else "iq_mismatch_samples.csv"
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
            print(f"  t={m['time']} vec={m['vec']} expected={m['expected']} actual={m['actual']}")

    print()
    print("=" * 78)
    print("2) SCENARIO-LEVEL ENGINEERING RESULTS")
    print("=" * 78)
    groups = group_by_vec(rows)

    g = groups.get("identity")
    if g:
        print("\n-- identity passthrough (a=1,d=1,b=c=0, offsets=0) --")
        errs = []
        for r in g:
            if as_int(r, "out_valid"):
                err_i = as_int(r, "i_out") - as_int(r, "i_in_in")
                err_q = as_int(r, "q_out") - as_int(r, "q_in_in")
                errs.append((err_i, err_q))
        print(f"  max abs error I={max(abs(e[0]) for e in errs)} Q={max(abs(e[1]) for e in errs)} (LSB) over {len(errs)} vectors")

    g = groups.get("offset_removal")
    if g:
        print("\n-- DC offset removal --")
        row = [r for r in g if as_int(r, "out_valid")][0]
        print(f"  i_out={as_int(row,'i_out')} (expect i_in-i_offset = {123456 - 50000})")
        print(f"  q_out={as_int(row,'q_out')} (expect q_in-q_offset = {-98765 - (-20000)})")

    g = groups.get("gain_only")
    if g:
        print("\n-- Pure gain correction (undo +10% gain error with 1/1.1 coeff) --")
        row = [r for r in g if as_int(r, "out_valid")][0]
        print(f"  i_in=110000 -> i_out={as_int(row,'i_out')} (expect ~100000, i.e. gain restored)")
        print(f"  q_in=-55000 -> q_out={as_int(row,'q_out')} (expect ~-50000)")

    g = groups.get("gain_phase_mismatch_correction")
    if g:
        print("\n-- IQ gain+phase mismatch correction (docx numerical example) --")
        row = [r for r in g if as_int(r, "out_valid")][0]
        i_out = as_int(row, "i_out")
        q_out = as_int(row, "q_out")
        true_i, true_q = 100000.0, 2000.0
        err_i = i_out - true_i
        err_q = q_out - true_q
        print(f"  true (I,Q) scaled x1000 for (R=100,X=2) -> (100000, 2000)")
        print(f"  measured (mismatched) i_in_in={as_int(row,'i_in_in')} q_in_in={as_int(row,'q_in_in')}")
        print(f"  corrected i_out={i_out} q_out={q_out}")
        print(f"  residual error after correction: dI={err_i:.1f} dQ={err_q:.1f} "
              f"(i.e. recovered R={i_out/1000.0:.4f}, X={q_out/1000.0:.4f} vs true R=100.0000, X=2.0000)")

    g = groups.get("saturation")
    if g:
        print("\n-- Saturation / overflow flagging --")
        row = [r for r in g if as_int(r, "out_valid")][0]
        print(f"  i_out={as_int(row,'i_out')} q_out={as_int(row,'q_out')} overflow={as_int(row,'overflow')} "
              f"(expect clipped to +/-{(1<<19)-1} and overflow=1)")

    g = groups.get("unsigned_mode")
    if g:
        print("\n-- unsigned_data_input offset-binary passthrough --")
        shown = 0
        for r in g:
            if as_int(r, "out_valid") and shown < 5:
                print(f"  i_in_in={as_int(r,'i_in_in')} -> i_out={as_int(r,'i_out')} (identity in offset-binary domain)")
                shown += 1

    g = groups.get("random_regression")
    if g:
        n_valid = sum(1 for r in g if as_int(r, "out_valid"))
        print(f"\n-- Randomized regression: {n_valid} valid output cycles exercised, all bit-exact-checked above --")

    print()
    return 0 if not mismatches else 1


if __name__ == "__main__":
    sys.exit(main())
