# Verilog verification plan: selected repositories

The user-selected scope is **nine repositories, 765 cases and 501 reviewed HDL files**. 296 additional directed or corner scenarios extend the earlier plan; the retained case IDs stay stable. Each case gives stimulus, expected result and timing, source, setup, coverage target and a finite stop rule.

Open [VERIFICATION_CASES.xlsx](VERIFICATION_CASES.xlsx) for filters, editable statuses, run evidence and completion totals. Source links and module roles are in [VERIFICATION_SOURCE_MAP.md](VERIFICATION_SOURCE_MAP.md).

## Choose a repository

| Repository | Cases | Blocked | HDL files | Detailed test ideas |
|---|---:|---:|---:|---|
| RamAndFifo | 62 | 0 | 18 | [Open RamAndFifo cases](verification_plans/RamAndFifo.md) |
| AsynchronousFifo | 23 | 1 | 5 | [Open AsynchronousFifo cases](verification_plans/AsynchronousFifo.md) |
| UART- | 53 | 0 | 6 | [Open UART- cases](verification_plans/UART-.md) |
| UART-legacy | 32 | 0 | 5 | [Open UART-legacy cases](verification_plans/UART-legacy.md) |
| VerilogCodesUpdatedDaily | 31 | 1 | 13 | [Open VerilogCodesUpdatedDaily cases](verification_plans/VerilogCodesUpdatedDaily.md) |
| mips-processor | 19 | 0 | 8 | [Open mips-processor cases](verification_plans/mips-processor.md) |
| GoodQuestions | 138 | 1 | 95 | [Open GoodQuestions cases](verification_plans/GoodQuestions.md) |
| hdlBits | 323 | 32 | 186 | [Open hdlBits cases](verification_plans/hdlBits.md) |
| systemverilog-from-beginning | 84 | 3 | 165 | [Open systemverilog-from-beginning cases](verification_plans/systemverilog-from-beginning.md) |

## Start and record a run

1. Select one source file/top and only its matching dependencies. Use the source-linked revision; build duplicate top_module or sync_fifo examples individually.
2. Establish a known reset or initialization. Use each module's actual polarity, clock and power-up behavior. A RAM with no reset needs explicit writes before numeric read checks.
3. Drive signals before the capturing edge. For FIFOs, log accepted operations from the **pre-edge** flags. Compare registered outputs after NBA updates; check Mealy/combinational outputs at their defined pre-edge time.
4. Calculate an independent expected result. Keep a valid-bit array for RAM, an ordered queue for FIFO, an external serial frame decoder for UART, and a separate state/opcode model for FSM or CPU. Use four-state comparisons.
5. Bound each wait and record the first failing cycle with expected/actual values. Record simulator/version, parameterization, source commit, random seed and log/waveform with every executed case. A printed PASS or coverage bin alone is not a newly executed functional case.
6. Mark **Done** only after a passing run and evidence. Mark a mismatch **Failed**. Explain Blocked and N/A. When RTL changes, revisit dependent Done rows and rerun before claiming completion.

## Initial status definitions

| Status | Workbook color | Meaning |
|---|---|---|
| Pending | Amber | Not executed in this campaign |
| In progress | Blue | Being built or run |
| Done | Green | Executed and passed with a run record |
| Failed | Red | Mismatch or timeout observed |
| Blocked | Purple | Missing implementation, tool or agreed contract |
| N/A | Gray | Intentionally excluded with a reason |

The overview computes completion as Done / (all cases minus N/A). Blocked cases remain in the denominator. The Run record check flags Done without result, date or setup. No existing bench is counted as Done just because it exists.

## Source-dependent checks

- **RAM/FIFO:** Internal-memory FIFO blocks write at pre-edge full, even when the same edge reads. GoodQuestions dual-port FIFO instead accepts a replacement push at full with a simultaneous pop. RAM-backed FIFO read output can change while rd_en=0.
- **Async FIFO:** Flag visibility follows each implementation's actual synchronizer/flag logic. Check local Gray transitions; remote sampled pointers can skip values. A functional simulation does not prove physical CDC reliability. The daily FIFO has a reversed synchronizer assignment; q31 has a possible combinational loop.
- **UART:** Sample serialized frames independently. UART- has a TX FIFO and one-byte receiver holding register; UART-legacy has no FIFO and does not reject a low stop bit. Buffered loopback does not by itself prove independent TX and RX accuracy.
- **MIPS:** Memory uses word indices 0..1023, no architectural reset or hazard management. Trace both clock phases and architectural writes.
- **Learning designs:** HDLBits contains empty stubs that need implementation; the SV FIFO part 1 is a constant-output placeholder and one SV ALU repeats opcode 000. Coverage bins do not establish functional pass.

## Completion gate

Complete applicable P0 cases with evidence, then P1 functional boundaries and P2 stress or design reviews. Resolve Failed and Blocked rows, document N/A, and rerun Done cases affected by RTL changes. Multi-file cases must cover every listed implementation. Preserve simulator, seed, parameters, source commit and first mismatch with each result.
