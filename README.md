# SRAM PUF Using LFSR Extractor

This project implements a **Static Random Access Memory (SRAM) based Physical Unclonable Function (PUF)** with a **Linear Feedback Shift Register (LFSR) extractor** in Verilog.

The design captures the inherent randomness of SRAM power-up states and processes it through an LFSR to improve entropy distribution and reduce bias, generating a stable digital response suitable for lightweight hardware security applications.

##  Architecture

```
SRAM Startup → Raw PUF Bits → LFSR Extractor → Final PUF Response
```

### Flow Description
1. **SRAM Startup**
   Exploits the random power-up behavior of SRAM cells.

2. **Raw PUF Bits**
   Captures 128-bit uninitialized startup values.

3. **LFSR Extractor**
   Performs linear mixing to:

   * Improve entropy distribution
   * Reduce bias
   * Prevent zero-lock condition
   * Avoid X-propagation during simulation

4. **Final PUF Response**
   Produces a stable 128-bit processed PUF output.

## Modules

### `sram_puf`

* Simulates SRAM startup behavior
* Generates a **128-bit raw response**
* Uses uninitialized/randomized values to emulate silicon randomness

### `main_lfsr`

* 128-bit Linear Feedback Shift Register
* Defined tap positions for feedback polynomial
* Loads SRAM seed
* Performs linear mixing operation
* Prevents:

  * Zero-lock state
  * X-propagation in simulation


### `top_mod`

* Integrates `sram_puf` and `main_lfsr`
* Controls seed loading timing
* Avoids race conditions between SRAM output and LFSR load


##  Outputs

| Signal Name    | Description                                             |
| -------------- | ------------------------------------------------------- |
| `puf_response` | Final processed 128-bit PUF output                      |
| `raw_sram_out` | Raw 128-bit SRAM startup value (for debugging/analysis) |

---

## Testbench

The testbench performs:
* Reset sequencing
* Enable control
* Seed loading verification
* LFSR operation verification
* Output observation for stability and randomness
