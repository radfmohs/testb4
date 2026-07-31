#!/usr/bin/env bash
# Standalone testbench runner for BioZ/iq_mismatch_correction.sv (an orphaned
# block -- not currently instantiated anywhere in the design, see REVIEW.md).
set -euo pipefail
cd "$(dirname "$0")"

echo "== [1/3] Compiling iq_mismatch_correction.sv + tb_iq_mismatch.sv with iverilog =="
iverilog -g2012 -o sim_iq_mismatch.vvp \
    tb_iq_mismatch.sv \
    ../iq_mismatch_correction.sv

echo "== [2/3] Running simulation =="
vvp sim_iq_mismatch.vvp

echo "== [3/3] Cross-checking against independent Python golden model =="
python3 iq_mismatch_check.py iq_mismatch_samples.csv
