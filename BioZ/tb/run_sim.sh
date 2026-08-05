#!/usr/bin/env bash
# Standalone BioZ DDS testbench runner.
# Compiles + simulates ONLY the RTL required by the hierarchy rooted at
# Nanochap_BAF4P1.v -> top_dig.sv -> BioZ.sv -> dds_sincos_10b_lut128_4m.sv
# then cross-checks the result against an independent Python golden model.
set -euo pipefail
cd "$(dirname "$0")"

echo "== [1/3] Compiling BioZ.sv + dds_sincos_10b_lut128_4m.sv + tb_bioz_dds.sv with iverilog =="
iverilog -g2012 -o sim_bioz_dds.vvp \
    tb_bioz_dds.sv \
    ../BioZ.sv \
    ../dds_sincos_10b_lut128_4m.sv

echo "== [2/3] Running simulation =="
vvp sim_bioz_dds.vvp

echo "== [3/3] Cross-checking against independent Python golden model =="
python3 run_check.py bioz_samples.csv
