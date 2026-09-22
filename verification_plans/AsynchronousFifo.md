# AsynchronousFifo: detailed Verilog verification cases

[Plan index](../VERIFICATION_PLAN.md) · [Excel tracker](../VERIFICATION_CASES.xlsx) · [HDL source map](../VERIFICATION_SOURCE_MAP.md)

**23 cases, 5 HDL files.** Reviewed revision [a60bcd212928](https://github.com/kapiltrip/AsynchronousFifo/commit/a60bcd212928103b2d81d8f2d4eae248ea2e3468). This is a verification *plan*: no new simulation result is claimed.

## Design contract to check

Two clock domains, asynchronous active-high local resets, registered status with synchronization lag. A one-sided reset needs a system-level contract. Follow the exact stimulus and expected timing in each case.

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
| [AF-001](#af-001) | P0 | Asynchronous FIFO | Coordinated reset and idle | Pending |
| [AF-002](#af-002) | P0 | Asynchronous FIFO | First word crosses to read domain | Pending |
| [AF-003](#af-003) | P0 | Asynchronous FIFO | Fill, overflow, drain and underflow | Pending |
| [AF-007](#af-007) | P0 | Asynchronous FIFO | Gray pointers and blocked requests | Pending |
| [AF-008](#af-008) | P0 | Asynchronous FIFO | Synchronizer direction and flag latency | Pending |
| [AF-015](#af-015) | P0 | 1101 sequence detector | Match and overlap | Pending |
| [AF-018](#af-018) | P0 | Build and evidence | Compile isolated tops and record reproducible evidence | Pending |
| [AF-019](#af-019) | P0 | Asynchronous FIFO | First empty release at each destination phase | Pending |
| [AF-020](#af-020) | P0 | Asynchronous FIFO | Full release with continuously asserted write | Pending |
| [AF-023](#af-023) | P0 | 1101 sequence detector | All prefix transitions and reset at each prefix | Pending |
| [AF-004](#af-004) | P1 | Asynchronous FIFO | Fast writer and slow reader | Pending |
| [AF-005](#af-005) | P1 | Asynchronous FIFO | Slow writer and fast reader | Pending |
| [AF-006](#af-006) | P1 | Asynchronous FIFO | Equal rates with phase shifts | Pending |
| [AF-009](#af-009) | P1 | Asynchronous FIFO | Clock stop and restart | Pending |
| [AF-011](#af-011) | P1 | Asynchronous FIFO | Both resets during traffic | Pending |
| [AF-012](#af-012) | P1 | Asynchronous FIFO | One-sided reset contract | Blocked |
| [AF-016](#af-016) | P1 | 1101 sequence detector | Near misses and partial reset | Pending |
| [AF-021](#af-021) | P1 | Asynchronous FIFO | Both extended pointers wrap during overlap | Pending |
| [AF-022](#af-022) | P1 | Asynchronous FIFO | Reset assertion while a local clock is stopped | Pending |
| [AF-010](#af-010) | P2 | Asynchronous FIFO | Many laps and random bursts | Pending |
| [AF-013](#af-013) | P2 | Asynchronous FIFO | Parameter and minimum-depth limits | Pending |
| [AF-014](#af-014) | P2 | Asynchronous FIFO | CDC implementation review | Pending |
| [AF-017](#af-017) | P2 | 1101 sequence detector | Long stream reference window | Pending |

## Detailed test ideas

### AF-001

**Coordinated reset and idle** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run both independent clocks, set wr_en=rd_en=0 and assert wr_rst=rd_rst=1. Release each reset away from its local edge.
- **Expected result:** Local pointers reset, full=0, empty=1 and dout=0 after reset settles. No memory clearing is required.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-002

**First word crosses to read domain** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write A5 once on wr_clk while full=0; keep rd_en=0 and watch empty on successive rd_clk edges. Then request one accepted read.
- **Expected result:** empty deasserts only after synchronized write-pointer visibility. dout=A5 after the accepted rd_clk edge. Flags are registered after the second synchronizer stage; allow the extra flag-register clock.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-003

**Fill, overflow, drain and underflow** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** With reads stopped, write DEPTH words (2^AW (default 8)), attempt extra writes, then drain after empty clears. Attempt extra reads.
- **Expected result:** Exactly DEPTH original words return in order. Full writes and empty reads never move local pointers. Final full=0 and empty=1 after clock-domain propagation.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-007

**Gray pointers and blocked requests** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Observe local binary/Gray pointer pairs through wrap. Hold wr_en=1 at full and rd_en=1 at empty.
- **Expected result:** Local pointer increments only on accepted operations; Gray equals binary XOR (binary shifted right one). Successive LOCAL Gray values differ in one bit, or zero when holding. Destination samples may skip states and differ in multiple bits.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-008

**Synchronizer direction and flag latency** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Apply one remote pointer change while the destination clock runs; trace first and second synchronization stages on each destination edge.
- **Expected result:** Stage 1 samples the remote pointer; stage 2 samples previous stage 1. Flags must use stage 2. Flags are registered after the second synchronizer stage; allow the extra flag-register clock.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-015

**Match and overlap** · 1101 sequence detector · P0 · Pending · Simulation plan

- **Source:** [1. mealy_1101_detector.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/mealy_1101_detector.v)
- **Signals:** clk, reset, data_in, detected
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset and drive 1101101 one bit per cycle away from posedge clk. Inspect detected before the edge consuming each final 1.
- **Expected result:** Matches finish at bit positions 4 and 7. This is a combinational Mealy output and can drop after the edge when state changes.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### AF-018

**Compile isolated tops and record reproducible evidence** · Build and evidence · P0 · Pending · Source review

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-019

**First empty release at each destination phase** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset both domains. Place one accepted write at four phases relative to rd_clk: shortly after, a quarter period after, a half period after, and shortly before an edge. Keep rd_en=1 throughout. Tag the word uniquely.
- **Expected result:** In ideal RTL, if stage 1 captures the new write pointer at E1, stage 2 receives it at E2 and registered empty clears after E3. A read request at E3 still sees old empty=1; the first permitted read is E4 and returns the tag after NBA. Coincident source/destination edges require pre-edge sampling.
- **Coverage target:** Four source/destination phases; rejected reads while visibility propagates; first accepted read.
- **Stop rule:** Allow eight destination edges after a stable remote pointer change; report timeout if settled RTL flags/data do not progress.

### AF-020

**Full release with continuously asserted write** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill to capacity with reads disabled. Keep wr_en=1 and offer a new unique tag on every write clock. Accept one read in the other domain, then stop reading. Record pre-edge full at each wr_clk.
- **Expected result:** All writes while full is high are rejected. Exactly the first write edge that begins with full=0 can consume the released slot. The accepted tag is the one present on that edge; earlier offered tags must not enter the queue.
- **Coverage target:** Remote read to local full release; conservative blocking; first new accepted tag.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-023

**All prefix transitions and reset at each prefix** · 1101 sequence detector · P0 · Pending · Simulation plan

- **Source:** [1. mealy_1101_detector.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/mealy_1101_detector.v)
- **Signals:** clk, reset, data_in, detected
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reach the four prefix states with histories empty,1,11,110. From each prefix try both data_in values on separate runs. Check detected before the consuming edge and then check the resulting prefix. Reset once at each prefix.
- **Expected result:** Transitions are: empty+0->empty, empty+1->1; 1+0->empty, 1+1->11; 11+0->110, 11+1->11; 110+0->empty, 110+1 detects and returns to prefix 1. Reset clears the prefix immediately.
- **Coverage target:** All eight state/input transitions; all four reset locations; pre-edge Mealy detection.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-004

**Fast writer and slow reader** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use write/read periods 10 ns/31 ns, unrelated initial phases, and bursts long enough to reach full.
- **Expected result:** Only locally accepted operations enter the reference queue; no loss/reordering. full may conservatively remain high while a read propagates.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-005

**Slow writer and fast reader** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use write/read periods 29 ns/8 ns, then reverse the rates; repeatedly touch empty.
- **Expected result:** No stale/unwritten word is consumed. empty can remain high while a remote write propagates.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-006

**Equal rates with phase shifts** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use 10 ns/10 ns clocks with offsets 0,2,5 ns. Include coincident edges and continuous traffic at half occupancy.
- **Expected result:** Ordered data with race-free stimulus. Determine each operation from its own pre-edge full/empty; do not order coincident events by testbench process scheduling.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-009

**Clock stop and restart** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pause rd_clk while writing to full, then resume it; repeat by pausing wr_clk during reads.
- **Expected result:** No operation occurs without its local clock; flags converge after the stopped clock resumes. Scoreboard order survives the pause.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-011

**Both resets during traffic** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill, assert both resets during a burst, flush the expected queue, restart clocks and send a fresh known sequence.
- **Expected result:** Reset discards previous queued data; only new writes are considered valid. No assumptions about clearing memory cells.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-012

**One-sided reset contract** · Asynchronous FIFO · P1 · Blocked · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Consider asserting only wr_rst, then only rd_rst, while data is pending. Define whether the whole FIFO is flushed or one domain may continue before executing.
- **Expected result:** Pass criteria require an agreed system reset policy. Current independent pointer resets do not guarantee preservation of unread data after a one-sided reset.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Resolve reset policy first; never mark data preservation proven by ordinary RTL simulation.

### AF-016

**Near misses and partial reset** · 1101 sequence detector · P1 · Pending · Simulation plan

- **Source:** [1. mealy_1101_detector.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/mealy_1101_detector.v)
- **Signals:** clk, reset, data_in, detected
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Send 0000,1111,1100,1011, then reset after prefix 110 and continue with 1.
- **Expected result:** No false match on a near miss or a prefix discarded by reset. Reset is asynchronous active high.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-021

**Both extended pointers wrap during overlap** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill half the queue. Run enough independent reads/writes for at least 4*DEPTH accepted operations in EACH domain. Include 10/31 ns, 29/8 ns and 10/10 ns periods with nonzero phases. Keep an integer transaction ID wider than the DUT data for the reference sequence.
- **Expected result:** Every accepted read matches the oldest accepted write, using the configured data-width truncation. Address bits and the extra wrap bit traverse their full cycles. Equal lower addresses mean full or empty according to the extended pointer relation, not the address alone.
- **Coverage target:** Every memory index; local binary and Gray wrap; remote snapshots that skip intermediate states.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### AF-022

**Reset assertion while a local clock is stopped** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pause one clock with queued data, assert BOTH domain resets, and observe resettable local state without waiting for the stopped clock. Restart both clocks before reset release, release away from edges, and send new tags.
- **Expected result:** The asynchronous reset controls clear their local resettable state even without clock edges. Pre-reset queued data is invalid. A fresh write/read sequence works after restart; memory cell contents need not clear.
- **Coverage target:** Stopped write clock; stopped read clock; coordinated flush; first post-reset transfer.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-010

**Many laps and random bursts** · Asynchronous FIFO · P2 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run at least four complete pointer laps for three recorded seeds and clock ratios. Compare every accepted read with a software reference queue.
- **Expected result:** No duplicates, drops or ordering errors. End with both clocks running and fully drain the reference queue.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### AF-013

**Parameter and minimum-depth limits** · Asynchronous FIFO · P2 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Elaborate legal data widths 1,8,16 and address widths 2,3,4. Separately try address width 1 and non-power-of-two DEPTH if that parameter exists.
- **Expected result:** Supported configurations retain capacity and ordering. Record unsupported values as a documented constraint: slices such as [AW-2:0] or [ADDR-2:0] need special handling below address width 2.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### AF-014

**CDC implementation review** · Asynchronous FIFO · P2 · Pending · Source review

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Inspect the synthesized synchronizer paths, reset release, Gray-bus constraints and memory mapping with the target FPGA/ASIC tools.
- **Expected result:** A CDC report and reviewed timing constraints are separate evidence. Functional simulation cannot establish metastability reliability or physical Gray-bus skew.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** This is a design-review case, not a Verilog simulation pass.

### AF-017

**Long stream reference window** · 1101 sequence detector · P2 · Pending · Simulation plan

- **Source:** [1. mealy_1101_detector.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/mealy_1101_detector.v)
- **Signals:** clk, reset, data_in, detected
- **Setup:** Build the listed RTL in isolation, with source revision a60bcd212928. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Compare 1000 random bits against a four-bit rolling reference window, with recorded seed.
- **Expected result:** detected matches every occurrence of 1101 with overlap and the specified pre-edge sampling.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

