#!/usr/bin/env bash
# Compile and run the DDS -> analog model -> iq_cic integration testbench,
# then cross-check the results.
set -euo pipefail
cd "$(dirname "$0")"

echo "== [1/3] Compiling BioZ + iq_cic receive chain + analog-loop testbench with iverilog =="
iverilog -g2012 -o sim_bioz_iq_loop.vvp \
    tb_bioz_iq_loop.sv \
    ../BioZ.sv \
    ../dds_sincos_10b_lut128_4m.sv \
    ../../iq_cic/iq_filter_wrapper.v \
    ../../iq_cic/iq_filter.v \
    ../../iq_cic/iq_reg.v \
    ../../iq_cic/iq_cdc.v \
    ../../iq_cic/iq_ctrl.v \
    ../../iq_cic/iq_cic.v \
    ../../common/common_sync_bit.v \
    ../../common/common_rst_sync.v \
    ../../common/common_pulse_rising.v

echo "== [2/3] Running simulation =="
vvp sim_bioz_iq_loop.vvp

echo "== [3/3] Bit-exact + engineering cross-check against independent Python models =="
python3 loop_check.py iq_bits.csv iq_chdata.csv
