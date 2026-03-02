# Reconfigurable Forward & Reverse Carry Propagate Adder (R-FRCPA)

A hardware-efficient, runtime-reconfigurable 32-bit adder designed in Verilog. This architecture allows dynamic switching between an **Exact Ripple Carry** mode (for precision) and an **Approximate Tri-Split Hybrid (TSHA)** mode (for speed and power efficiency).

## Architecture Overview

The design segments the N-bit adder into three distinct parts to optimize the critical path:
* **LSP (Least Significant Part):** RA5 Logic (Aggressive Approximation)
* **MESP (Middle Significant Part):** RA3 Logic (Balanced Approximation)
* **MSP (Most Significant Part):** Exact Full Adder Logic

### Reconfigurable Cell Design
To minimize area overhead, the architecture utilizes a **Propagate & Generate (P&G) Logic Sharing** strategy. The Exact and Approximate modes share the fundamental `A & B` and `A ^ B` gates at the bit level. A control signal (`sel`) acts as the runtime switch:
* `sel = 0`: Forward exact carry propagation.
* `sel = 1`: Reverse approximate carry propagation (TSHA Mode).

## Synthesis & Implementation Results (Xilinx Vivado)

Synthesized for the `xc7a12ticsg325-1L` FPGA, the optimized logic sharing resulted in near-zero area overhead for the approximate mode while preserving exact timing constraints.

### 1. Area Utilization
| Architecture | Slice LUTs | Logic Primitive Highlight |
| :--- | :--- | :--- |
| **32-bit Full Adder (Baseline)** | 56 | Heavy reliance on LUT5 |
| **32-bit Reverse Adder (Approx)** | 31 | Reliance on LUT3 |
| **32-bit Reconfigurable TSHA** | **59** | Heavy reliance on LUT6 (High packing efficiency) |

*The reconfigurable design achieves dual-mode functionality with only a ~5.3% area overhead (3 additional LUTs) compared to the baseline exact adder.*

### 2. Timing Comparison (Worst-Case Data Path Delay)
| Architecture | Logic Levels | Delay (ns) |
| :--- | :--- | :--- |
| **32-bit Full Adder (Baseline)** | 15 | ~12.19 ns |
| **32-bit Reverse Adder (Approx)** | 8 | ~8.19 ns |
| **32-bit Reconfigurable TSHA** | 19 | ~12.17 ns |

*The approximate reverse path significantly reduces logic depth, while the reconfigurable design successfully preserves the baseline exact timing despite the added multiplexing complexity.*

## Repository Structure
* `/rtl`: Core Verilog source files including the 4-bit base blocks (`fa_4b.v`, `ra3_4b.v`, `ra5_4b.v`), the N-bit reverse adder, and the top-level reconfigurable design (`reconfig_tsha_top.v`).
* `/sim`: Testbenches for boundary stress testing and exactness verification.
* `/syn`: Raw utilization and timing reports from Vivado showcasing the optimization data.
* `/docs`: Project preview and final evaluation reports.

## Toolchain
* **Simulation:** Icarus Verilog (`iverilog`) & GTKWave
* **Synthesis:** Xilinx Vivado v.2025.2
