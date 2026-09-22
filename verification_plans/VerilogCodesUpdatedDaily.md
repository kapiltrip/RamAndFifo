# VerilogCodesUpdatedDaily: detailed Verilog verification cases

[Plan index](../VERIFICATION_PLAN.md) · [Excel tracker](../VERIFICATION_CASES.xlsx) · [HDL source map](../VERIFICATION_SOURCE_MAP.md)

**31 cases, 13 HDL files.** Reviewed revision [16ce5086bdde](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/commit/16ce5086bddef41aa977a31440509a0c4219d3c0). This is a verification *plan*: no new simulation result is claimed.

## Design contract to check

Async FIFO uses active-low resets, a write-domain count and combinational flags; its two-stage Gray sync assignment needs structural review. Follow the exact stimulus and expected timing in each case.

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
| [VD-001](#vd-001) | P0 | Asynchronous FIFO | Coordinated reset and idle | Pending |
| [VD-002](#vd-002) | P0 | Asynchronous FIFO | First word crosses to read domain | Pending |
| [VD-003](#vd-003) | P0 | Asynchronous FIFO | Fill, overflow, drain and underflow | Pending |
| [VD-007](#vd-007) | P0 | Asynchronous FIFO | Gray pointers and blocked requests | Pending |
| [VD-008](#vd-008) | P0 | Asynchronous FIFO | Synchronizer direction and flag latency | Pending |
| [VD-015](#vd-015) | P0 | Asynchronous FIFO | Detect reversed synchronizer assignments | Pending |
| [VD-016](#vd-016) | P0 | Counter styles | Up/down wraps and style equivalence | Pending |
| [VD-018](#vd-018) | P0 | Array read styles | Read timing differs between styles | Pending |
| [VD-020](#vd-020) | P0 | Binary to Gray | Complete conversion and adjacency | Pending |
| [VD-021](#vd-021) | P0 | Build and evidence | Compile isolated tops and record reproducible evidence | Pending |
| [VD-022](#vd-022) | P0 | Asynchronous FIFO | First empty release at each destination phase | Pending |
| [VD-023](#vd-023) | P0 | Asynchronous FIFO | Full release with continuously asserted write | Pending |
| [VD-026](#vd-026) | P0 | Asynchronous FIFO | count is a delayed write-domain occupancy view | Pending |
| [VD-027](#vd-027) | P0 | Array read styles | Initialization differs in structural RAM | Pending |
| [VD-028](#vd-028) | P0 | Array read styles | Write collision across registered and combinational reads | Pending |
| [VD-029](#vd-029) | P0 | Counter styles | Direction changes at both modulo boundaries | Pending |
| [VD-030](#vd-030) | P0 | Counter styles | Direction changes at both modulo boundaries | Pending |
| [VD-031](#vd-031) | P0 | Counter styles | Direction changes at both modulo boundaries | Pending |
| [VD-004](#vd-004) | P1 | Asynchronous FIFO | Fast writer and slow reader | Pending |
| [VD-005](#vd-005) | P1 | Asynchronous FIFO | Slow writer and fast reader | Pending |
| [VD-006](#vd-006) | P1 | Asynchronous FIFO | Equal rates with phase shifts | Pending |
| [VD-009](#vd-009) | P1 | Asynchronous FIFO | Clock stop and restart | Pending |
| [VD-011](#vd-011) | P1 | Asynchronous FIFO | Both resets during traffic | Pending |
| [VD-012](#vd-012) | P1 | Asynchronous FIFO | One-sided reset contract | Blocked |
| [VD-017](#vd-017) | P1 | Counter styles | Mid-count reset and direction change | Pending |
| [VD-019](#vd-019) | P1 | Array read styles | Depth, initialization and write protection | Pending |
| [VD-024](#vd-024) | P1 | Asynchronous FIFO | Both extended pointers wrap during overlap | Pending |
| [VD-025](#vd-025) | P1 | Asynchronous FIFO | Reset assertion while a local clock is stopped | Pending |
| [VD-010](#vd-010) | P2 | Asynchronous FIFO | Many laps and random bursts | Pending |
| [VD-013](#vd-013) | P2 | Asynchronous FIFO | Parameter and minimum-depth limits | Pending |
| [VD-014](#vd-014) | P2 | Asynchronous FIFO | CDC implementation review | Pending |

## Detailed test ideas

### VD-001

**Coordinated reset and idle** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run both independent clocks, set write_en=read_en=0 and assert write_reset_n=read_reset_n=0. Release each reset away from its local edge.
- **Expected result:** Local pointers reset, full=0, empty=1 and read_data=0 after reset settles. No memory clearing is required.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-002

**First word crosses to read domain** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write A5 once on write_clk while full=0; keep read_en=0 and watch empty on successive read_clk edges. Then request one accepted read.
- **Expected result:** empty deasserts only after synchronized write-pointer visibility. read_data=A5 after the accepted read_clk edge. Flags are combinational from current pointers and sync2. Inspect the actual synchronizer wiring before trusting the expected two-stage delay.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-003

**Fill, overflow, drain and underflow** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** With reads stopped, write DEPTH words (DEPTH (default 8)), attempt extra writes, then drain after empty clears. Attempt extra reads.
- **Expected result:** Exactly DEPTH original words return in order. Full writes and empty reads never move local pointers. Final full=0 and empty=1 after clock-domain propagation.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-007

**Gray pointers and blocked requests** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Observe local binary/Gray pointer pairs through wrap. Hold write_en=1 at full and read_en=1 at empty.
- **Expected result:** Local pointer increments only on accepted operations; Gray equals binary XOR (binary shifted right one). Successive LOCAL Gray values differ in one bit, or zero when holding. Destination samples may skip states and differ in multiple bits.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-008

**Synchronizer direction and flag latency** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Apply one remote pointer change while the destination clock runs; trace first and second synchronization stages on each destination edge.
- **Expected result:** Stage 1 samples the remote pointer; stage 2 samples previous stage 1. Flags must use stage 2. Flags are combinational from current pointers and sync2. Inspect the actual synchronizer wiring before trusting the expected two-stage delay.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-015

**Detect reversed synchronizer assignments** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_ptr_gray, write_ptr_gray_sync1, write_ptr_gray_sync2, read_ptr_gray, read_ptr_gray_sync1, read_ptr_gray_sync2
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Change one source Gray pointer; inspect the concatenated nonblocking assignment at each destination edge.
- **Expected result:** Required two-stage topology is sync1 <- remote and sync2 <- old sync1. The current concatenations instead feed sync2 directly from remote and sync1 from old sync2. Record this as a CDC structural defect, independently of data-loopback results.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Static source finding; no CDC or simulation run claimed.

### VD-016

**Up/down wraps and style equivalence** · Counter styles · P0 · Pending · Simulation plan

- **Source:** [1. up_down_counter_behavioral.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/up_down_counter_behavioral.v); [2. up_down_counter_dataflow.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/up_down_counter_dataflow.v); [3. up_down_counter_structural.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/up_down_counter_structural.v)
- **Signals:** clk, reset, up, count
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset all three versions together; count up through 15->0 and down through 0->15; change up away from posedge clk.
- **Expected result:** All three count outputs agree after each edge. Arithmetic is modulo 16; active-high reset is asynchronous.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-018

**Read timing differs between styles** · Array read styles · P0 · Pending · Simulation plan

- **Source:** [1. array_all.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/array_all.v); [2. array_db.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/array_db.v)
- **Signals:** clk, write_data, write_addr, write_en, read_addr, read_data
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize every location, then change read_addr between edges in array_behavioral, array_behavioral_simple, array_dataflow and array_structural.
- **Expected result:** Behavioral outputs update at posedge clk and are read-first on collisions. Dataflow/structural outputs follow address asynchronously. Compare at each design’s valid time, not cycle-for-cycle blindly.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-020

**Complete conversion and adjacency** · Binary to Gray · P0 · Pending · Simulation plan

- **Source:** [1. bin2gray.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/bin2gray.v); [2. bin2gray_all.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/bin2gray_all.v)
- **Signals:** bin, gray
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep bin through all 256 values at WIDTH=8; repeat WIDTH=1 and 4. Check conversion using a bitwise truth-table reference.
- **Expected result:** MSB is unchanged; each lower Gray bit is XOR of adjacent binary bits. Consecutive binary values including wrap produce one changed Gray bit. Compile only one definition of bin2gray at a time.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-021

**Compile isolated tops and record reproducible evidence** · Build and evidence · P0 · Pending · Source review

- **Source:** [1. array_all.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/array_all.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-022

**First empty release at each destination phase** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset both domains. Place one accepted write at four phases relative to read_clk: shortly after, a quarter period after, a half period after, and shortly before an edge. Keep read_en=1 throughout. Tag the word uniquely.
- **Expected result:** Measure each variant against its actual flag/synchronizer contract. No read is accepted while pre-edge empty is high; the first accepted read returns the tag. The separate CDC/feedback findings remain independent failures even if data ordering works.
- **Coverage target:** Four source/destination phases; rejected reads while visibility propagates; first accepted read.
- **Stop rule:** Allow eight destination edges after a stable remote pointer change; report timeout if settled RTL flags/data do not progress.

### VD-023

**Full release with continuously asserted write** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill to capacity with reads disabled. Keep write_en=1 and offer a new unique tag on every write clock. Accept one read in the other domain, then stop reading. Record pre-edge full at each write_clk.
- **Expected result:** All writes while full is high are rejected. Exactly the first write edge that begins with full=0 can consume the released slot. The accepted tag is the one present on that edge; earlier offered tags must not enter the queue.
- **Coverage target:** Remote read to local full release; conservative blocking; first new accepted tag.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-026

**count is a delayed write-domain occupancy view** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_en, read_en, count, write_ptr_bin, read_ptr_bin_sync
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write three tagged words without reads and check count=3 once local updates settle. Read two words while write_clk is paused, then resume write_clk without further writes. Trace the synchronized read pointer.
- **Expected result:** count remains based on the stale synchronized read pointer while write_clk is paused. It converges to 1 as the read pointer reaches the sampled sync2. It is not an instantaneous cross-domain queue depth; compare against write_ptr_bin-read_ptr_bin_sync, including modular pointer wrap.
- **Coverage target:** Local increment; delayed remote decrement; wrap; stalled destination clock.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-027

**Initialization differs in structural RAM** · Array read styles · P0 · Pending · Simulation plan

- **Source:** [1. array_all.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/array_all.v)
- **Signals:** clk, write_data, write_addr, write_en, read_addr, read_data
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Before any write, read every address in array_behavioral and array_dataflow and all four words in array_structural. Then initialize all four structural words and read them again.
- **Expected result:** The behavioral/dataflow memories have initial zero-fill. Structural dff storage has no reset/initial value, so pre-write reads are unspecified; initialized words must match. Do not apply one power-up-zero assumption to all styles.
- **Coverage target:** Initialized and uninitialized architectures; every structural word.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-028

**Write collision across registered and combinational reads** · Array read styles · P0 · Pending · Simulation plan

- **Source:** [1. array_all.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/array_all.v)
- **Signals:** clk, write_data, write_addr, write_en, read_addr, read_data
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize address 1 to 55, select it for reading, and overwrite it with AA on a rising clk. Observe outputs just before and after the edge, then after a second edge with write_en=0.
- **Expected result:** array_behavioral returns old 55 on the collision edge and AA on the next edge. array_dataflow/array_structural follow the newly written AA after NBA at the collision edge. All values are hexadecimal and width-truncated.
- **Coverage target:** Same address; pre-/post-edge values; one-cycle versus asynchronous read latency.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-029

**Direction changes at both modulo boundaries** · Counter styles · P0 · Pending · Simulation plan

- **Source:** [1. up_down_counter_behavioral.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/up_down_counter_behavioral.v)
- **Signals:** clk, reset, up, count
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset to 0. Request down for one edge, up for one edge, then count up through 15 and continue one edge. Reverse direction on every subsequent edge for ten edges.
- **Expected result:** At width four, down from 0 gives 15 and up from 15 gives 0. Each edge uses that edge’s up value, with reset taking priority. Compare to a separate integer modulo-16 count, not another RTL style alone.
- **Coverage target:** Both wraps; every count value; alternating direction; independent oracle per implementation.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-030

**Direction changes at both modulo boundaries** · Counter styles · P0 · Pending · Simulation plan

- **Source:** [1. up_down_counter_dataflow.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/up_down_counter_dataflow.v)
- **Signals:** clk, reset, up, count
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset to 0. Request down for one edge, up for one edge, then count up through 15 and continue one edge. Reverse direction on every subsequent edge for ten edges.
- **Expected result:** At width four, down from 0 gives 15 and up from 15 gives 0. Each edge uses that edge’s up value, with reset taking priority. Compare to a separate integer modulo-16 count, not another RTL style alone.
- **Coverage target:** Both wraps; every count value; alternating direction; independent oracle per implementation.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-031

**Direction changes at both modulo boundaries** · Counter styles · P0 · Pending · Simulation plan

- **Source:** [1. up_down_counter_structural.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/up_down_counter_structural.v)
- **Signals:** clk, reset, up, count
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset to 0. Request down for one edge, up for one edge, then count up through 15 and continue one edge. Reverse direction on every subsequent edge for ten edges.
- **Expected result:** At width four, down from 0 gives 15 and up from 15 gives 0. Each edge uses that edge’s up value, with reset taking priority. Compare to a separate integer modulo-16 count, not another RTL style alone.
- **Coverage target:** Both wraps; every count value; alternating direction; independent oracle per implementation.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-004

**Fast writer and slow reader** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use write/read periods 10 ns/31 ns, unrelated initial phases, and bursts long enough to reach full.
- **Expected result:** Only locally accepted operations enter the reference queue; no loss/reordering. full may conservatively remain high while a read propagates.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-005

**Slow writer and fast reader** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use write/read periods 29 ns/8 ns, then reverse the rates; repeatedly touch empty.
- **Expected result:** No stale/unwritten word is consumed. empty can remain high while a remote write propagates.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-006

**Equal rates with phase shifts** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use 10 ns/10 ns clocks with offsets 0,2,5 ns. Include coincident edges and continuous traffic at half occupancy.
- **Expected result:** Ordered data with race-free stimulus. Determine each operation from its own pre-edge full/empty; do not order coincident events by testbench process scheduling.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-009

**Clock stop and restart** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pause read_clk while writing to full, then resume it; repeat by pausing write_clk during reads.
- **Expected result:** No operation occurs without its local clock; flags converge after the stopped clock resumes. Scoreboard order survives the pause.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-011

**Both resets during traffic** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill, assert both resets during a burst, flush the expected queue, restart clocks and send a fresh known sequence.
- **Expected result:** Reset discards previous queued data; only new writes are considered valid. No assumptions about clearing memory cells.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-012

**One-sided reset contract** · Asynchronous FIFO · P1 · Blocked · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Consider asserting only write_reset_n, then only read_reset_n, while data is pending. Define whether the whole FIFO is flushed or one domain may continue before executing.
- **Expected result:** Pass criteria require an agreed system reset policy. Current independent pointer resets do not guarantee preservation of unread data after a one-sided reset.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Resolve reset policy first; never mark data preservation proven by ordinary RTL simulation.

### VD-017

**Mid-count reset and direction change** · Counter styles · P1 · Pending · Simulation plan

- **Source:** [1. up_down_counter_behavioral.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/up_down_counter_behavioral.v); [2. up_down_counter_dataflow.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/up_down_counter_dataflow.v); [3. up_down_counter_structural.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/up_down_counter_structural.v)
- **Signals:** clk, reset, up, count
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset between clock edges after a nonzero count; release and alternate up on successive cycles.
- **Expected result:** count immediately resets to zero and advances by exactly +1 or -1 on each later rising edge.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-019

**Depth, initialization and write protection** · Array read styles · P1 · Pending · Simulation plan

- **Source:** [1. array_all.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/array_all.v); [2. array_db.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/array_db.v)
- **Signals:** clk, write_data, write_addr, write_en, read_addr, read_data
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write a walking-one pattern to every legal location, then hold write_en=0 while changing addresses/data. Check a fresh simulation too.
- **Expected result:** Behavioral/dataflow memories have simulation initialization to zero; structural DFF storage has no reset/init and begins unknown. Structural array is fixed at four words, irrespective of other array DEPTH overrides.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-024

**Both extended pointers wrap during overlap** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill half the queue. Run enough independent reads/writes for at least 4*DEPTH accepted operations in EACH domain. Include 10/31 ns, 29/8 ns and 10/10 ns periods with nonzero phases. Keep an integer transaction ID wider than the DUT data for the reference sequence.
- **Expected result:** Every accepted read matches the oldest accepted write, using the configured data-width truncation. Address bits and the extra wrap bit traverse their full cycles. Equal lower addresses mean full or empty according to the extended pointer relation, not the address alone.
- **Coverage target:** Every memory index; local binary and Gray wrap; remote snapshots that skip intermediate states.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### VD-025

**Reset assertion while a local clock is stopped** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pause one clock with queued data, assert BOTH domain resets, and observe resettable local state without waiting for the stopped clock. Restart both clocks before reset release, release away from edges, and send new tags.
- **Expected result:** The asynchronous reset controls clear their local resettable state even without clock edges. Pre-reset queued data is invalid. A fresh write/read sequence works after restart; memory cell contents need not clear.
- **Coverage target:** Stopped write clock; stopped read clock; coordinated flush; first post-reset transfer.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-010

**Many laps and random bursts** · Asynchronous FIFO · P2 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run at least four complete pointer laps for three recorded seeds and clock ratios. Compare every accepted read with a software reference queue.
- **Expected result:** No duplicates, drops or ordering errors. End with both clocks running and fully drain the reference queue.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### VD-013

**Parameter and minimum-depth limits** · Asynchronous FIFO · P2 · Pending · Simulation plan

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Elaborate legal data widths 1,8,16 and address widths 2,3,4. Separately try address width 1 and non-power-of-two DEPTH if that parameter exists.
- **Expected result:** Supported configurations retain capacity and ordering. Record unsupported values as a documented constraint: slices such as [AW-2:0] or [ADDR-2:0] need special handling below address width 2.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### VD-014

**CDC implementation review** · Asynchronous FIFO · P2 · Pending · Source review

- **Source:** [1. async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 16ce5086bdde. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Inspect the synthesized synchronizer paths, reset release, Gray-bus constraints and memory mapping with the target FPGA/ASIC tools.
- **Expected result:** A CDC report and reviewed timing constraints are separate evidence. Functional simulation cannot establish metastability reliability or physical Gray-bus skew.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** This is a design-review case, not a Verilog simulation pass.

