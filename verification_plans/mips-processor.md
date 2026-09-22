# mips-processor: detailed Verilog verification cases

[Plan index](../VERIFICATION_PLAN.md) · [Excel tracker](../VERIFICATION_CASES.xlsx) · [HDL source map](../VERIFICATION_SOURCE_MAP.md)

**19 cases, 8 HDL files.** Reviewed revision [a6f8a8843b90](https://github.com/kapiltrip/mips-processor/commit/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a). This is a verification *plan*: no new simulation result is claimed.

## Design contract to check

Two nonoverlapping clocks; memory is word addressed; register zero ignores writes. Existing programs initialize pipeline internals, with no reset port and no forwarding/stall hardware. Follow the exact stimulus and expected timing in each case.

## How to turn a case into a test

1. Select one source file/top and only its matching dependencies. Use the source-linked revision; build duplicate top_module or sync_fifo examples individually.
2. Establish a known reset or initialization. Use each module's actual polarity, clock and power-up behavior. A RAM with no reset needs explicit writes before numeric read checks.
3. Drive signals before the capturing edge. For FIFOs, log accepted operations from the **pre-edge** flags. Compare registered outputs after NBA updates; check Mealy/combinational outputs at their defined pre-edge time.
4. Calculate an independent expected result. Keep a valid-bit array for RAM, an ordered queue for FIFO, an external serial frame decoder for UART, and a separate state/opcode model for FSM or CPU. Use four-state comparisons.
5. Bound each wait and record the first failing cycle with expected/actual values. Record simulator/version, parameterization, source commit, random seed and log/waveform with every executed case. A printed PASS or coverage bin alone is not a newly executed functional case.
6. Mark **Done** only after a passing run and evidence. Mark a mismatch **Failed**. Explain Blocked and N/A. When RTL changes, revisit dependent Done rows and rerun before claiming completion.

## Case index

| ID | Priority | Block | Scenario | Initial state |
|---|---|---|---|---|
| [CPU-001](#cpu-001) | P0 | Processor ALU | Every supported operation | Pending |
| [CPU-003](#cpu-003) | P0 | Processor decode | Complete opcode classification | Pending |
| [CPU-004](#cpu-004) | P0 | Register file | Both read ports and write enable | Pending |
| [CPU-006](#cpu-006) | P0 | Processor memory | Word addressing and independent reads | Pending |
| [CPU-008](#cpu-008) | P0 | Processor integration | Existing arithmetic and memory programs | Pending |
| [CPU-009](#cpu-009) | P0 | Processor integration | Branch taken and not taken | Pending |
| [CPU-012](#cpu-012) | P0 | Build and evidence | Compile isolated tops and record reproducible evidence | Pending |
| [CPU-013](#cpu-013) | P0 | Processor ALU | Opcode by operand corner cross | Pending |
| [CPU-014](#cpu-014) | P0 | Processor integration | Trace a single instruction across all pipeline stages | Pending |
| [CPU-015](#cpu-015) | P0 | Processor integration | Signed immediate extension and destination fields | Pending |
| [CPU-016](#cpu-016) | P0 | Processor integration | Branch taken and not taken with visible wrong-path writes | Pending |
| [CPU-018](#cpu-018) | P0 | Processor integration | HALT freezes architectural activity | Pending |
| [CPU-019](#cpu-019) | P0 | Processor integration | Existing program results with bounded run and full evidence | Pending |
| [CPU-002](#cpu-002) | P1 | Processor ALU | Unsupported opcode | Pending |
| [CPU-005](#cpu-005) | P1 | Register file | Zero register and read/write collision | Pending |
| [CPU-007](#cpu-007) | P1 | Processor memory | Out-of-range address policy | Pending |
| [CPU-010](#cpu-010) | P1 | Processor integration | Data dependency and pipeline limits | Pending |
| [CPU-011](#cpu-011) | P1 | Processor integration | Halt and persistent state | Pending |
| [CPU-017](#cpu-017) | P1 | Processor integration | Dependency spacing and missing hazard hardware | Pending |

## Detailed test ideas

### CPU-001

**Every supported operation** · Processor ALU · P0 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/alu.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/alu.v)
- **Signals:** opcode, a, b, result
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise ADD/ADDI, SUB/SUBI, AND, OR, SLT/SLTI, MUL and address/branch additions with 0,1,all ones,80000000 and 7FFFFFFF.
- **Expected result:** Use an independent 32-bit arithmetic model. Add/subtract/multiply truncate to 32 bits. SLT/SLTI use UNSIGNED comparison in this RTL; 80000000 is greater than 7FFFFFFF.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### CPU-003

**Complete opcode classification** · Processor decode · P0 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/control_unit.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/control_unit.v)
- **Signals:** opcode, instr_type
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep all 64 opcode values and compare against the supported instruction list.
- **Expected result:** 0..5 -> RR_ALU=0; 10..12 -> RM_ALU=1; 13 -> LOAD=2; 14 -> STORE=3; 15..16 -> BRANCH=4; 63 and all unsupported values -> HALT=5.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### CPU-004

**Both read ports and write enable** · Register file · P0 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/regfile.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/regfile.v)
- **Signals:** clock, we, ra1, ra2, wa, wd, rd1, rd2
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write distinct values into registers 1..31 on rising clock; independently sweep ra1 and ra2. Repeat updates with we=0.
- **Expected result:** Both read ports are combinational and return the addressed last written value. we=0 leaves all registers unchanged.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### CPU-006

**Word addressing and independent reads** · Processor memory · P0 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/memory_interface.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/memory_interface.v)
- **Signals:** clock, instr_addr, instr_out, data_addr, data_in, data_out, data_we
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write addresses 0,1,1023, then vary instruction/data addresses independently; compare against 1024-word reference memory.
- **Expected result:** Addresses index WORDS directly. No implicit division by four occurs. Reads are combinational; writes occur on posedge clock when data_we=1.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### CPU-008

**Existing arithmetic and memory programs** · Processor integration · P0 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/mips.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/mips.v)
- **Signals:** clock1, clock2, PC, halted, rf_we, mem_we
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run the existing add-three-numbers, factorial and memory-word benches separately with their instruction images. Keep the two clocks non-overlapping as those benches do.
- **Expected result:** Compare final architectural register/memory values to an independent program calculation, not just printed messages. Record the exact instruction image, clock phases and cycle limit.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### CPU-009

**Branch taken and not taken** · Processor integration · P0 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/mips.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/mips.v)
- **Signals:** clock1, clock2, PC, taken_branch, EX_MEM_cond, rf_we, mem_we
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise BEQZ and BNEQZ with zero and nonzero operands, positive/negative offsets and a store/writeback behind a taken branch.
- **Expected result:** Correct target instruction is fetched; side effects suppressed by taken_branch do not update architectural state. Check branch target in word units and sign-extended immediate.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### CPU-012

**Compile isolated tops and record reproducible evidence** · Build and evidence · P0 · Pending · Source review

- **Source:** [1. modellingOftheProcessor/alu.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/alu.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### CPU-013

**Opcode by operand corner cross** · Processor ALU · P0 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/alu.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/alu.v)
- **Signals:** opcode, a, b, result
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Cross every implemented opcode with operands 0,1,7FFFFFFF,80000000,FFFFFFFF hex, equal operands, and complementary masks. Include subtraction 0-1 and multiplication FFFFFFFF*2.
- **Expected result:** ADD-class results wrap modulo 2^32; SUB-class results wrap likewise; MUL retains the low 32 bits. SLT/SLTI use unsigned comparison, so 80000000 < 1 is false. AND/OR compare bitwise. Unsupported ALU opcodes produce X in this RTL.
- **Coverage target:** Every implemented opcode; carry, borrow, multiplication truncation; unsigned sign-boundary contrast.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### CPU-014

**Trace a single instruction across all pipeline stages** · Processor integration · P0 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/mips.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/mips.v)
- **Signals:** clock1, clock2, IF_ID_IR, ID_EX_IR, EX_MEM_IR, MEM_WB_IR, rf_we, rf_wa, rf_wd
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use nonoverlapping clock1 and clock2 pulses. Initialize the simulation as in an existing bench. Place one ADDI using initialized R0 with destination R1 and immediate 10, followed by harmless instructions to R0. Record each stage and writeback edge.
- **Expected result:** The instruction progresses IF on clock1, ID on clock2, EX on the next clock1, MEM on clock2, WB on the following clock1. R1 becomes 10 only on its proper writeback. Later pipeline entries must not reuse or duplicate its architectural write.
- **Coverage target:** One instruction at each of five stages; destination/data/write-enable alignment.
- **Stop rule:** Finish the isolated instruction and drain within 12 clock1/clock2 pairs.

### CPU-015

**Signed immediate extension and destination fields** · Processor integration · P0 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/mips.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/mips.v)
- **Signals:** clock1, clock2, IF_ID_IR, ID_EX_IMM, rf_wa, rf_wd
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use independently spaced ADDI/SUBI instructions with immediates 0000,0001,7FFF,8000,FFFF hex and initialized operands. Also compare an RR instruction with an immediate-format instruction using distinct rd and rt bit fields.
- **Expected result:** ID_EX_IMM sign-extends bit 15: 8000->FFFF8000 and FFFF->FFFFFFFF. Arithmetic remains 32-bit modulo arithmetic. RR writes IR[15:11]; RM/LOAD writes IR[20:16]. R0 remains zero.
- **Coverage target:** Five immediate boundaries; rd versus rt; zero-register destination.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### CPU-016

**Branch taken and not taken with visible wrong-path writes** · Processor integration · P0 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/mips.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/mips.v)
- **Signals:** clock1, clock2, PC, branch_taken, taken_branch, mem_we, rf_we
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prepare BEQZ and BNEQZ with zero and nonzero source operands and forward/backward offsets. Place distinct register writes and a store on the sequential path and tagged writes at the target. Space dependencies explicitly.
- **Expected result:** Branch condition and target must match source semantics: target=next-PC+sign-extended immediate in WORD addresses. Record every architectural write. Verify intended suppression of wrong-path stores/register writes against taken_branch timing; a correct final PC alone is insufficient.
- **Coverage target:** Two branch opcodes x zero/nonzero; positive/negative offsets; wrong-path register and memory effects.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### CPU-018

**HALT freezes architectural activity** · Processor integration · P0 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/mips.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/mips.v)
- **Signals:** clock1, clock2, halted, PC, mem_we, rf_we
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Place HLT after known retired results, followed in memory by instructions that would change a sentinel register and sentinel memory location. Continue both clocks for ten pairs after halted asserts.
- **Expected result:** No younger instruction may modify the sentinels after halt. PC and active pipeline progression stop as defined. Check actual rf_we writes as well as mem_we: rf_we is not explicitly gated by halted in this source, so inspect repeated writeback risk and document any effect.
- **Coverage target:** HALT retirement; ten post-halt pairs; register/memory/PC observations.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### CPU-019

**Existing program results with bounded run and full evidence** · Processor integration · P0 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/mips.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/mips.v)
- **Signals:** clock1, clock2, halted, PC
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run the supplied add-three-numbers, factorial and memory-word programs individually with their existing initialization and clock phasing. Record actual final state plus the first mismatching architectural write if any.
- **Expected result:** Expected examples are R5=55, memory[198]=5040 for 7!, and memory[121]=130. Confirm program completion within each bench budget; a printed PASS is evidence for these programs only, not all hazards or branches.
- **Coverage target:** Three existing programs; arithmetic, loop, load and store.
- **Stop rule:** Use the supplied 50,200,60 clock-pair budgets respectively; treat timeout or noncompletion as a recorded result.

### CPU-002

**Unsupported opcode** · Processor ALU · P1 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/alu.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/alu.v)
- **Signals:** opcode, a, b, result
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep all 64 opcodes, including values absent from the ALU case table.
- **Expected result:** Unimplemented opcodes deliberately produce X. The controller maps unsupported opcodes to HALT; do not silently label unknown ALU results zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### CPU-005

**Zero register and read/write collision** · Register file · P1 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/regfile.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/regfile.v)
- **Signals:** clock, we, ra1, ra2, wa, wd, rd1, rd2
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Attempt to write wa=0 with nonzero wd. Also read a nonzero register while writing the same address at the clock edge.
- **Expected result:** Register zero always reads 0 and ignores writes. A nonzero same-address read changes to the new stored value after the write NBA; it is not an extra-cycle registered read.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### CPU-007

**Out-of-range address policy** · Processor memory · P1 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/memory_interface.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/memory_interface.v)
- **Signals:** instr_addr, instr_out, data_addr, data_out
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Try 1024 and a high 32-bit address in a separate negative run.
- **Expected result:** The array has no address bounds response. Record X/warnings rather than inventing a bus-error output or wrapping addresses. An address restriction is needed for legal programs.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### CPU-010

**Data dependency and pipeline limits** · Processor integration · P1 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/mips.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/mips.v)
- **Signals:** clock1, clock2, ID_EX_A, ID_EX_B, MEM_WB_ALUOut, rf_we
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Compare dependent instruction pairs with zero, one and enough separating no-ops, including load-use and branch-use.
- **Expected result:** There is no explicit hazard/forwarding unit. Use a sequential reference to reveal unsupported schedules; document required software spacing rather than assuming automatic stalls.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### CPU-011

**Halt and persistent state** · Processor integration · P1 · Pending · Simulation plan

- **Source:** [1. modellingOftheProcessor/mips.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/mips.v)
- **Signals:** clock1, clock2, halted, PC, mem_we, rf_we
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Execute HLT after arithmetic, branch and memory operations. Continue both clocks for at least ten cycles.
- **Expected result:** PC and pipeline stop after halt; no extra memory side effects occur. Inspect repeated writeback control as well as data. No reset port exists; each independent program needs a fresh initialized simulation.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### CPU-017

**Dependency spacing and missing hazard hardware** · Processor integration · P1 · Pending · Characterization

- **Source:** [1. modellingOftheProcessor/mips.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/mips.v)
- **Signals:** clock1, clock2, ID_EX_A, ID_EX_B, rf_we, rf_wd
- **Setup:** Build the listed RTL in isolation, with source revision a6f8a8843b90. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run producer-consumer ADD chains and load-use chains with 0,1,2,3 harmless intervening instructions. Repeat the same arithmetic using preinitialized independent registers as the reference.
- **Expected result:** Determine the minimum safe spacing for this pipeline from the register-read/write timeline. Closely spaced dependencies are a characterization of absent forwarding/stalls, not proof of architectural correctness. The explicitly safe schedule must match the mathematical result.
- **Coverage target:** ALU->ALU and LOAD->ALU dependencies at all four spacings; first safe gap documented.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

