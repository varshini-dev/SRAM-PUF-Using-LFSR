##SRAM-PUF-Using-LFSR Extractor

This project implements a Static Random Access Memory (SRAM) based Physical Unclonable Function (PUF) with a Linear Feedback Shift Register (LFSR) extractor in Verilog.

The design captures the inherent randomness of SRAM power-up states and processes it through an LFSR to improve entropy distribution and reduce bias, generating a stable digital response suitable for lightweight hardware security applications.

#Architecture
SRAM Startup → Raw PUF Bits → LFSR Extractor → Final PUF Response

#Modules

sram_puf:
Simulates SRAM startup behavior.
Generates a 128-bit raw response using uninitialized/randomized values.

main_lfsr:
128-bit LFSR with defined tap positions.
Loads SRAM seed and performs linear mixing.
Prevents zero-lock state and X-propagation in simulation.

top_mod:
Integrates SRAM and LFSR modules.
Adds controlled load timing to avoid race conditions.

Outputs:
puf_response
raw_sram_out (for observation/debug)

Testbench:
Applies reset and enable sequencing.
Verifies seed loading and LFSR operation.
Designed for Vivado simulation.
