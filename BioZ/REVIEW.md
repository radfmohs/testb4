# BioZ RTL Review

Scope: `BioZ/` as instantiated from the chip hierarchy rooted at
`chip_top/rtl/Nanochap_BAF4P1.v`, cross-checked against `README.md`
(sections *BioZ measurement*, 1.22–1.24, pp. ~75–78) and
`Bioimpedance_IQ_Demod_SysAna.docx`, plus a literature comparison against
commercial single-chip BioZ AFEs (ADI **AD5940/AD5941**, **MAX30001**,
**MAX30009**).

Standalone, self-checking testbenches for the block are in `BioZ/tb/`
(instructions at the end of this document).

---

## 1. Hierarchy trace

```
Nanochap_BAF4P1.v                      (chip_top/rtl/Nanochap_BAF4P1.v:731  u_top_dig)
  └─ top_dig.sv                        (top_dig/top_dig.sv:1138           instance "BioZ")
       └─ BioZ.sv                      (BioZ/BioZ.sv)
            └─ dds_sincos_10b_lut128_4m.sv   (BioZ/dds_sincos_10b_lut128_4m.sv)
```

`BioZ.sv` is a thin wrapper around `dds_sincos_10b_lut128_4m.sv` (the actual
DDS/LUT/commutating-mixer core) that just muxes the DDS output against a
programmable DC value (`data_type_sel`). These two files are the **entire**
RTL required to instantiate and simulate the block — no other file in the
repository is pulled in by this hierarchy (`BioZ.sv` has no other module
instantiations, no includes, no package imports).

The register-level source of BioZ's inputs is `spi_slave/rtl/spi_reg.sv`
(APB/SPI register file) and its digital-side "receiver" companion, meant to
decimate the post-ADC I/Q bitstreams, is `iq_cic/iq_filter_wrapper.v` →
`iq_filter.v` → {`iq_reg.v`, `iq_cdc.v`, `iq_ctrl.v`, `iq_cic.v`} (confirmed
below, §3).

## 2. Extra / unneeded files found and removed

| File | Verdict | Action |
|---|---|---|
| `BioZ/BioZ.v` | Legacy duplicate of `BioZ.sv`. Same module name (`BioZ`), **older** interface with no `DITHER_EN`/`DITHER_SEED` ports. `top_dig.sv` instantiates `BioZ` using the dithering ports, so only `BioZ.sv` is actually usable; `BioZ.v` is unreferenced anywhere in the repo (`grep` for `BioZ.v` finds no filelist/script hits). Keeping both is a landmine: any tool that globs `*.v`/`*.sv` in this directory would hit a duplicate `module BioZ` definition. | **Removed** |
| `BioZ/dds_sincos_10b_lut128_4m.v` | Same situation as above: legacy duplicate of `dds_sincos_10b_lut128_4m.sv` without dithering support, unreferenced anywhere. | **Removed** |

Not removed, but flagged for awareness (outside `BioZ/`, so out of strict
scope for this change, and it's still referenced by an — apparently
stale — synthesis script for an older chip revision):
* `top_dig/top_dig.v` vs `top_dig/top_dig.sv` — `diff` shows `top_dig.v` is an
  **older** revision that predates the BioZ dithering integration and the
  `imeas`/`iq_*` restructuring present in `top_dig.sv`. It is only pulled in
  by `chip_top/imp/scripts/Nanochap_imp_verilog.tcl`, which itself targets a
  different/older top level (`Nanochap_ENS1p4.v`, `spi_reg.v` instead of
  `spi_reg.sv`, no BioZ at all) — i.e. that whole synthesis-script set looks
  stale relative to `Nanochap_BAF4P1.v` and should be revisited separately.

## 3. RTL bug found and fixed

`BioZ/iq_mismatch_correction.sv` (see §5) used `signed({...})` (four
occurrences, lines 83/84/152/153) as a cast. Plain `signed(...)` without `$`
or a `'` cast token is not valid IEEE 1800 SystemVerilog syntax; Icarus
Verilog correctly rejects it (`error: Syntax error in continuous
assignment`). Some proprietary simulators are lenient about this, which is
presumably how it went unnoticed. Fixed by using the standard `$signed(...)`
system-function cast (semantically identical, universally portable):

```diff
- assign i_in_bak = i_in_in_ext + signed({1'b0,1'b1,{(IN_W-1){1'b0}}});
+ assign i_in_bak = i_in_in_ext + $signed({1'b0,1'b1,{(IN_W-1){1'b0}}});
```

applied to all four occurrences (I/Q input and I/Q output offset-binary
conversion).

## 4. "Not fully connected" — confirmed, with specifics

The task description that BioZ is "not fully connected" is accurate. Three
independent pieces of evidence:

1. **TX outputs left dangling in `top_dig.sv`** (`top_dig/top_dig.sv:1138-1159`):
   ```systemverilog
   .sin_unsigned(), //connect to D2A_BIOZ_TX_IDAC_DIN<9:0>
   .cos_unsigned(), // dont need to connect
   .i_square(),     //Connect to D2A_BIOZ_RX_MIXER_SQR0
   .q_square(),     //Connect to D2A_BIOZ_RX_MIXER_SQR90
   .phase_acc()     //incase want to use fout freq
   ```
   All four functional outputs of the DDS (the excitation DAC code and the
   two commutating-mixer square waves) are tied off. The comments name the
   intended analog pins (`D2A_BIOZ_TX_IDAC_DIN`, `D2A_BIOZ_RX_MIXER_SQR0/90`),
   but those pins/wires do not exist anywhere else in `Nanochap_BAF4P1.v` —
   the chip's actual analog TX/RX interface still uses the **older**,
   unrelated `D2A_SW_Z_DDS` / `D2A_Z_*` signal group (a separate legacy
   `zmeas` analog DDS output, see `Nanochap_BAF4P1.v:395-405`). BioZ's DDS
   is generating a waveform that currently drives nothing.

2. **RX decimation chain shares one ADC bitstream for both I and Q**
   (`top_dig.sv:1180-1181`):
   ```systemverilog
   .iq_adc_din_I(imeas_adc_din),  //SDM_OUT, from analog ,should connect to IADC
   .iq_adc_din_Q(imeas_adc_din),  //SDM_OUT, from analog ,should connect to QADC
   ```
   Both channels of the `iq_filter_wrapper` (→ two independent `iq_cic`
   CIC-decimator instances, one per channel — this part of the digital
   receive chain is correctly built for true I/Q) are wired to the **same**
   single-bit ΣΔ ADC input, which is itself the shared `imeas` (bioelectric)
   ADC line, not a dedicated BioZ I/Q ADC pair. This can only ever produce
   `chdata_I == chdata_Q` — i.e. no usable Q channel yet. This matches the
   commented-out `//should connect to IADC`/`QADC` — a known placeholder.

3. **The verification environment's BioZ monitor is entirely commented out**
   (`chip_top/tb/blocks/tb_chip_top_uvm_bioZ.sv`): every `assign
   zmeas_mon_if.*` line that would sample BioZ's internal signals for the UVM
   scoreboard is commented, and the interface is bound but never driven. The
   two BioZ testcases (`chip_top/tc/soc_bioz_base_test.sv`,
   `soc_bioz_ddsfreq_test.sv`) only exercise SPI register read/write
   round-trips; they do not check any DDS output waveform. There is
   currently no functional check of BioZ anywhere in the chip-level
   verification environment — hence the need for the standalone TB added
   here.

## 5. `iq_mismatch_correction.sv` is a fourth, orphaned BioZ file

`BioZ/iq_mismatch_correction.sv` implements exactly the "IQ Mismatch
Mitigation" calibration stage described in
`Bioimpedance_IQ_Demod_SysAna.docx` (§ *IQ Mismatch Mitigation* /
*Calibration Using a Precision Resistor*): a 2×2 gain/phase correction
matrix applied to offset-removed I/Q samples,
`i_corr = a·(i−i_off) + b·(q−q_off)`, `q_corr = c·(i−i_off) + d·(q−q_off)`,
with saturation and an overflow flag. It is a clean, self-contained,
reusable DSP block — **but it is not instantiated anywhere** in `BioZ.sv`,
`top_dig.sv`, or `Nanochap_BAF4P1.v`. Per the document, this is exactly the
stage that should sit right after the `iq_cic`/`iq_filter` decimators and
before a magnitude/phase (√(I²+Q²), atan2) calculation — none of which
exists downstream today (see §7). It is tested standalone in this change
since it is functionally correct and directly relevant to BioZ, even though
it is currently disconnected from the rest of the design.

## 6. README vs. RTL documentation mismatches

Comparing `README.md` §1.24 ("APB BioZ Registers") against the actual
register map in `spi_slave/rtl/spi_reg.sv` turned up real discrepancies that
would mislead firmware bring-up:

| README says | RTL actually implements |
|---|---|
| `BIOZ_CTRL` at offset **0xE8**, bit 0 = `BIOZ_EN`, bits 7:1 reserved | `BIOZ_CTRL` is at offset **0xEC** (`spi_reg.sv:309`). Bit 0 = `Bioz_en` ✓, but **bit 1 = `Bioz_reset_reg`** and **bit 2 = `DITHER_EN`** — both undocumented, not "reserved" |
| — (no mention) | **`PHASE_OFFSET_C_0..3`** at **0xE8–0xEB** (the independent Q-channel phase offset register) is entirely undocumented |
| — (no mention) | **`BIOZ_FILTER_CTRL_0/1/2`** at **0xED–0xEF** drive `iq_reg_ctrl`/`iq_iclk_div`/`iq_adc_clk_inv`, i.e. they configure the CIC decimation rate / input format / clock divider of the receive chain — undocumented |
| — (no mention) | **`DITHER_SEED_L/H`** at **0xF4/0xF5** (LFSR seed for the dithering feature) — undocumented |
| `data_type_sel`: "00 sine, 01 DC, 10 square wave, 11 sine" (comment in `top_dig.sv:1151/1297`) | `BioZ.sv`'s mux only implements `00`→sine and `01`→DC; **`10` and `11` both fall through to the sine branch** (confirmed bit-exact in the standalone TB, scenario `sel_10_undocumented`/`sel_11`). There is no square-wave amplitude mode in the RTL despite the comment. |

These should be reconciled (either implement the missing `data_type_sel=10`
mode, or fix the comment/README; and update README §1.24 with the real
register map) before firmware integration.

## 7. Standalone test benches (`BioZ/tb/`)

Two independent, self-checking testbenches were written. Each drives the
DUT with `iverilog` (Icarus Verilog, installed for this review) and then
replays the *exact same* cycle-by-cycle stimulus through an independent
Python software model to get a bit-exact pass/fail — this is a much stronger
check than the existing UVM tests (which only ever exercised SPI read/write,
never the actual waveform), and it required no analog stub or full-chip
integration.

### 7.1 `tb_bioz_dds.sv` + `bioz_golden_model.py` (DDS / excitation core)

Compiles only `BioZ.sv` + `dds_sincos_10b_lut128_4m.sv`. Drives 13 scenarios:
reset/disable, the exact frequencies from README's example table (1/10/50/
100/400 kHz), independent `phase_offset` vs `phase_offset_c` (I vs Q), the
dithering feature, DC mode, the undocumented `data_type_sel=10/11` codes,
enable toggling mid-run, and the `DITHER_SEED==0` fallback case. Run with:

```bash
cd BioZ/tb && ./run_sim.sh
```

Results (34,673 simulated cycles):

* **Bit-exact equivalence vs. independent Python model: PASS (34673/34673 cycles).**
  This is the strongest available correctness statement for a
  fully-digital, deterministic block: an independently re-derived model of
  every register/LUT/shift in `dds_sincos_10b_lut128_4m.sv` matches the RTL
  on every single clock edge across all scenarios, including the dithering
  LFSR sequence.
* Frequency accuracy: measured (from the `i_square` commutating output
  period) and FFT fundamental match `phase_inc·f_clk/2^32` exactly for
  10/50/100/400 kHz (1 kHz needs a longer capture window than the 4096-cycle
  default to resolve — noted, not a bug).
* I/Q quadrature: cos leads sin by exactly 90.00°, equal amplitude
  (994 codes peak-peak of the available 1023) — confirms the phase-90°
  constant and LUT mirroring logic are correct.
* `phase_offset` (I) vs `phase_offset_c` (Q) are independently steerable:
  applying 90° to `phase_offset` alone shifts only the I output by exactly
  90.00°, Q unaffected — matches the intended per-channel calibration use
  described in the docx.
* Dithering measurably improves spectral purity at 100 kHz using coherent
  (integer-cycle) FFT sampling: **SFDR 53.0 dB → 64.2 dB** with
  `DITHER_EN=1`, i.e. it does exactly what phase dithering is supposed to do
  (spread discrete LUT/quantization spurs into the noise floor). THD is
  small in both cases (0.28–0.35%), consistent with a 10-bit, 128-step
  quarter-wave LUT.
* At 400 kHz the DDS clock (4 MHz, per README) only gives **10
  samples/cycle** — an 8× ratio to the "up to 500 kHz" excitation range
  quoted in the docx. This is a thin margin: the TX reconstruction path
  (DAC + any analog smoothing) needs to adequately reject the LUT images
  around multiples of 4 MHz ± 400 kHz. Worth a note for the analog/DAC
  team, not an RTL defect.
* Confirms the §6 finding: `data_type_sel = 2'b10` and `2'b11` both produce
  a sine wave, not the documented square wave.

### 7.2 `tb_iq_mismatch.sv` + `iq_mismatch_golden_model.py` (IQ calibration, §5)

Compiles only `iq_mismatch_correction.sv` (with the `$signed` fix from §4).
Drives 8 vectors: reset, identity passthrough, DC-offset removal, pure-gain
correction, a **gain+phase mismatch correction numeric example taken
directly from the docx** (true `R=100 Ω, X=2 Ω`; forward-model a 1 % gain
error + 1° phase error the way the doc derives it; verify the inverse 2×2
matrix recovers the original R/X), output saturation/overflow flagging, the
`unsigned_data_input` offset-binary mode, and 500 pseudo-random vectors with
random valid/gap patterns. Run with:

```bash
cd BioZ/tb && ./run_sim_iq_mismatch.sh
```

Results (549 simulated cycles):

* **Bit-exact equivalence vs. independent Python model: PASS (549/549 cycles).**
* Offset removal, pure-gain correction, and saturation/overflow all match
  expected values exactly (e.g. saturation vector clips to exactly
  `±(2^19−1)` with `overflow=1` asserted).
* **Gain+phase mismatch correction**: with an exact-precision correction
  matrix, the block recovers `R=100.0000 Ω, X=2.0000 Ω` from the
  1 %-gain/1°-phase-corrupted measurement with **zero residual error** (to
  the last reported digit) — i.e. the fixed-point (Q2.16, `COEFF_W=18`)
  datapath and rounding are implemented correctly for this use case.
  Practically, real calibration coefficients will have their own estimation
  error, but the *arithmetic* is verified correct.
* Coefficient range note: `COEFF_W=18` with `COEFF_FRAC=16` leaves only 2
  integer bits, i.e. **coefficients must stay within [-2.0, +1.999985]**.
  This is enough headroom for the gain-mismatch corrections discussed in the
  docx (≤ a few %), but firmware/calibration routines must not attempt to
  program a coefficient ≥ 2.0 (it silently wraps — verified during TB
  bring-up, see the saturation-scenario history in `tb_iq_mismatch.sv`).

## 8. Comparison with commercial BioZ AFEs

| Feature | This RTL (`BioZ/` + wiring today) | AD5940/AD5941 | MAX30001 | MAX30009 |
|---|---|---|---|---|
| Excitation generation | Digital DDS, 32-bit phase acc., 10-bit/128-step quarter-wave LUT, dithering | Dual DAC-based excitation loops (DC–200 kHz on the low-power loop) | Programmable current, single channel | Sine-wave + H-bridge current DAC, 16 Hz–806 kHz |
| Excitation range | Formula supports DC–500 kHz (docx target); demonstrated 1 kHz–400 kHz in TB | up to 200 kHz (LP loop) | narrower, resp.-focused | 16 Hz–806 kHz |
| I/Q demod method | Commutating-mixer references generated on-chip (`i_square`/`q_square`) — **not wired to any mixer today** | On-chip DFT engine (computes real/imag directly) — no analog mixer needed | Analog demod, configurable phase (0–168.75° steps) | Analog IQ demod, **two dedicated 20-bit ΣΔ ADCs**, simultaneous I/Q |
| Digital receive chain | `iq_cic`/`iq_filter` CIC decimator exists per-channel, but **both channels tied to one shared ADC bitstream** (§4.2) | N/A (DFT-based) | N/A | Two independent ADCs, real hardware I/Q |
| IQ gain/phase calibration | `iq_mismatch_correction.sv` implements exactly this — **but is not instantiated anywhere** (§5) | Switch matrix + sequencer supports Rcal-based calibration | Firmware-based | Hardware calibration options + **0.2% I/Q gain matching (post-cal, datasheet)** |
| Magnitude/Phase (√(I²+Q²), atan2) | **Not present anywhere in the repo** (`grep` for `atan`/`sqrt`/`cordic`/`magnitude` across all RTL: zero hits) | On-chip DFT gives Re/Im directly | Firmware | Firmware (raw I/Q FIFO) |
| Clock/phase accuracy (IEC 60601-2-47) | 32-bit phase accumulator gives fine frequency resolution, but **no PLL** — README/docx flag oscillator drift as a real accuracy risk at high body-resistance loads | — | — | On-chip **PLL** for clinical-grade timing accuracy |
| Lead-off / lead-on detection | Present in the *bioelectric* (ECG) block (README §"LEADOFF_INT" etc.), not obviously reused for the BioZ excitation/receive path | N/A (general AFE) | AC lead-off detection (BioZ channel) | AC lead-off, DRVN lead-off, low-power lead-on-in-standby |
| Dithering for spurious-tone reduction | **Yes** — phase-accumulator dithering (verified in §7.1 to raise SFDR by ~11 dB) | not documented as a feature | not documented | not documented |
| FIFO for streamed data | Shared 128-entry/18-bit bioelectric FIFO (README §"SPI FIFO") — not clearly BioZ-I/Q-specific | Deep 6 kB command+data FIFO | small internal FIFOs | 256-word FIFO |

**Net assessment:** the excitation/DDS core in `BioZ.sv` is a solid, well
verified building block — arguably *ahead* of some commercial parts in one
respect (phase dithering for spur reduction is not a commonly advertised
feature). The receive-side story is the opposite: a genuine per-channel CIC
decimator (`iq_cic`/`iq_filter`) and a genuine gain/phase calibration block
(`iq_mismatch_correction.sv`) both already exist in the repo and match the
system architecture described in the docx, but **neither is wired to real,
independent I/Q ADC data, and neither the calibration block nor a
magnitude/phase (rectangular→polar) stage is instantiated anywhere**. To
reach parity with MAX30009-class parts the design needs, in order of
priority:

1. Route `BioZ`'s `sin_unsigned`/`i_square`/`q_square` to the actual TX
   DAC/mixer analog pins (currently dangling, §4.1).
2. Give `iq_filter_wrapper` two independent ADC bitstreams instead of the
   duplicated `imeas_adc_din` (§4.2) — this is required before any real Q
   data exists.
3. Instantiate `iq_mismatch_correction.sv` after the two `iq_cic` decimators
   (§5), and hook up its coefficient/offset registers to SPI (it isn't
   presently mapped to any address either).
4. Add a magnitude/phase stage (√(I²+Q²), atan2), even a simple CORDIC or a
   firmware-assisted path with hardware sqrt, since none exists today.
5. Resolve the `data_type_sel=2'b10` "square wave" gap (§6) — either
   implement it or correct the documentation.
6. Reconcile README §1.24 with the real register map (§6) before firmware
   bring-up.
7. Consider a PLL/frequency-accuracy plan for the excitation clock if
   IEC 60601-2-47-class timing accuracy is a project goal (per the docx's
   own oscillator-drift analysis).

## 9. Digital LPF / HPF and magnitude/phase (sqrt) — what's needed, and what depends on monitoring mode

Follow-up review question: *do we need a digital LPF/HPF in the receive path, and is a hardware sqrt/magnitude block needed, given the designer's note that sqrt "maybe necessary [for] continuous monitor[ing], ... not necessary [for] big interval" monitoring?*

**Digital LPF: required, and already present.** The docx (§"Programmable Digital LPF and HPF Specifications") calls for a digital LPF (DLPF) after the ADC, and this isn't optional in any monitoring mode — synchronous (zero-IF) demodulation always produces a wanted DC term plus an unwanted 2×fexc image, which must be filtered out before decimation or it aliases into the baseband I/Q. The 3-stage CIC decimator in `iq_cic/iq_cic.v` (`cic_rate` programmable 8x–2048x) already performs this job. Lower-priority refinement: the docx models the DLPF as an independently *programmable-cutoff* filter (Table 5), whereas today `cic_rate` is the only knob and there's no CIC-droop compensation FIR — worth a look if measured passband flatness ever becomes an issue at the narrow physiological bandwidths involved (<2 Hz for respiration), but not a functional blocker.

**Digital HPF: currently absent from the RTL entirely** — grepped the whole tree for `hpf`/`high-pass`/`dc_remove`/`offset_track`/`baseline`: zero hits anywhere outside this doc. Whether it's needed depends on the same continuous-vs-interval logic the designer applied to sqrt, but with one important difference: it affects upstream datapath bit-width/architecture decisions, so it's worth deciding explicitly rather than deferring:
- **Interval/spot-check measurements** (single BIA reading, bioimpedance-spectroscopy sweep): the DC value from the CIC *is* the desired result. No HPF needed.
- **Continuous monitoring** — the docx names exactly three continuous-monitoring target applications (ICG, respiration/pneumography, GSR/EDA) — the AC ripple of interest (sub-Ω) rides on a static baseline impedance (hundreds of Ω–few kΩ) that also drifts slowly (electrode-gel drying, temperature, motion). Without a baseline-removal HPF (or an adaptive DC tracker), that large static term consumes fixed-point headroom and blocks applying digital gain to the small ripple without saturating. Unlike sqrt, this can't be cleanly deferred to firmware after the fact without revisiting datapath bit widths, so if continuous monitoring is a confirmed product requirement it should be architected now.

**No-regrets action regardless of the above decision:** `iq_mismatch_correction.sv` already exposes `i_offset`/`q_offset` ports for a one-time, SPI-programmed static offset subtraction (calibration-time, not adaptive tracking). Wiring these up is useful in every monitoring mode and costs nothing extra — recommend doing it independent of the LPF/HPF/sqrt decisions.

**Magnitude/phase (sqrt/atan2): the designer's proposed deferral is reasonable.** Since no `atan2`/`sqrt`/`cordic` exists anywhere in the RTL today (§8), and this is a pure downstream, low-rate computation that doesn't affect upstream architecture, doing it in firmware is a sound choice for either monitoring mode; only genuinely high continuous-streaming rates would make a case for a hardware CORDIC, and the physiological bandwidths involved here (≤ a few Hz) are far below that threshold.

## 10. How to reproduce

```bash
# one-time setup (already done in this environment)
sudo apt-get install -y iverilog

cd BioZ/tb
./run_sim.sh                 # BioZ DDS/excitation core
./run_sim_iq_mismatch.sh     # IQ gain/phase mismatch correction block
```

Each script compiles only the RTL required for that block (no stubs, no
full chip-top needed), runs the simulation with Icarus Verilog, and pipes
the resulting per-cycle CSV log through the matching Python golden-model
checker for a bit-exact PASS/FAIL plus the engineering metrics summarized in
§7 above.
