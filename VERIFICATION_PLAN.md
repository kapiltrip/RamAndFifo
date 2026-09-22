# Verilog verification plan

Use this plan to write your own Verilog tests or run suitable existing benches. It contains **644 cases** across **14 repositories** and a source map of **695 HDL files**. The source review is pinned to the revisions below. No RTL or testbench implementation was added, and no simulations were run for this plan.

Open [VERIFICATION_CASES.xlsx](VERIFICATION_CASES.xlsx) to filter by repository, block, priority or status.

## How to start

1. Start with P0 cases for RAM, standalone FIFO, RAM-backed FIFO, asynchronous FIFO and UART in that order. Then run P1 functional/boundary cases, followed by P2 stress and implementation reviews.
2. A test case says what to drive, when an operation is accepted, what to observe and what result is required. Write a small independent reference model: an array for RAM, an ordered reference queue for FIFO, and a bit/frame decoder for UART. No UVM is required.
3. Drive inputs away from the capturing edge, usually on the opposite edge. Record acceptance using **pre-edge** enables/flags. Sample registered outputs **after nonblocking assignments settle**. For a combinational Mealy output, also check before the edge consuming the final input.
4. Start every independent run with the correct reset or initialization. A signal named resetn/rst_n is generally active low, but the source and each case decide. Never invent a reset port for a RAM or the processor.
5. Give waits a finite timeout. Save the first mismatch with time, input, expected value, actual value and occupancy/state. Use four-state comparisons so X is visible.
6. Change Status only after recording the actual result, run setup/source revision, date and log/waveform evidence. If RTL changes, return affected completed cases to Pending and rerun.

## Tracker status

| Status | Color | Meaning |
|---|---|---|
| Pending | Amber | Not executed in this campaign |
| In progress | Blue | Being implemented or run |
| Done | Green | Executed and passed, with run evidence |
| Failed | Red | Executed and mismatched or timed out |
| Blocked | Purple | Missing implementation, tool, or a defined requirement |
| N/A | Gray | Intentionally excluded, with a written reason |

All new executable cases begin Pending. Missing implementations and unresolved contracts begin Blocked. Historical PASS claims and existing testbenches are references only. **Done means this case passed; it does not mean its testbench merely exists.** The overview calculates completion as Done / (all cases minus N/A); Blocked cases remain in that denominator.

## Source revisions and scope

| Repository | Revision reviewed | Cases | HDL files |
|---|---|---:|---:|
| [RamAndFifo](https://github.com/kapiltrip/RamAndFifo) | [858ffb35bb31](https://github.com/kapiltrip/RamAndFifo/commit/858ffb35bb31e70051ca25d6cb24e5aa5020bd41) | 47 | 18 |
| [AsynchronousFifo](https://github.com/kapiltrip/AsynchronousFifo) | [a60bcd212928](https://github.com/kapiltrip/AsynchronousFifo/commit/a60bcd212928103b2d81d8f2d4eae248ea2e3468) | 18 | 5 |
| [UART-](https://github.com/kapiltrip/UART-) | [5f65f99cf43e](https://github.com/kapiltrip/UART-/commit/5f65f99cf43ed317f18874503046f994d5038c65) | 42 | 6 |
| [UART-legacy](https://github.com/kapiltrip/UART-legacy) | [28d439c91eca](https://github.com/kapiltrip/UART-legacy/commit/28d439c91eca72edba0ce269ba01812ad02c2900) | 24 | 5 |
| [DesignProject](https://github.com/kapiltrip/DesignProject) | [445e9ecfeab6](https://github.com/kapiltrip/DesignProject/commit/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4) | 39 | 20 |
| [VerilogCodesUpdatedDaily](https://github.com/kapiltrip/VerilogCodesUpdatedDaily) | [16ce5086bdde](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/commit/16ce5086bddef41aa977a31440509a0c4219d3c0) | 21 | 13 |
| [mips-processor](https://github.com/kapiltrip/mips-processor) | [a6f8a8843b90](https://github.com/kapiltrip/mips-processor/commit/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a) | 12 | 8 |
| [VerificationLab](https://github.com/kapiltrip/VerificationLab) | [0c649a2cbbee](https://github.com/kapiltrip/VerificationLab/commit/0c649a2cbbeef29a88717dda465b6cf958a1bc15) | 36 | 65 |
| [PlacementPrep](https://github.com/kapiltrip/PlacementPrep) | [4aeb1a1555f5](https://github.com/kapiltrip/PlacementPrep/commit/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194) | 48 | 52 |
| [GoodQuestions](https://github.com/kapiltrip/GoodQuestions) | [a83e5a8a5d72](https://github.com/kapiltrip/GoodQuestions/commit/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701) | 79 | 95 |
| [MorrisManoDE](https://github.com/kapiltrip/MorrisManoDE) | [46c904529575](https://github.com/kapiltrip/MorrisManoDE/commit/46c9045295755c84efdd9a8e2324004ff0b7d163) | 2 | 1 |
| [hdlBits](https://github.com/kapiltrip/hdlBits) | [fc3f2b993a1e](https://github.com/kapiltrip/hdlBits/commit/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a) | 178 | 186 |
| [systemverilog-from-beginning](https://github.com/kapiltrip/systemverilog-from-beginning) | [318bd495dee2](https://github.com/kapiltrip/systemverilog-from-beginning/commit/318bd495dee245f946d7c72127cb698bcf6e6680) | 48 | 165 |
| [RevisionAtlas](https://github.com/kapiltrip/RevisionAtlas) | [2f827008d725](https://github.com/kapiltrip/RevisionAtlas/commit/2f827008d725333643a78e6c31935ab24cb4e6b7) | 50 | 56 |

The HDL-file count includes RTL, existing benches, support code, intentional fault fixtures, archives and practice drafts. These roles are separated in the RTL map; their presence is not evidence that a design is complete. Repositories with notes/software only have no RTL-level cases here. Generated simulator glbl.v and package dependencies are excluded. For private repositories, the plan stays in that repository.

## Important interface differences

| Design | Accepted operations | Read timing / reset expectation |
|---|---|---|
| RamAndFifo standalone sync_fifo | wr_en && !full; rd_en && !empty | Registered rd_data only on an accepted read; reset clears rd_data |
| RamAndFifo sync_fifo_ram | Same pre-edge rules | RAM updates rd_data each clock, even without rd_en; no defined zero output on reset |
| RamAndFifo syncFifo wrapper | wren/rden with the same full/empty rules | din/dout are wrapper names for wr_data/rd_data; parameters dw/aw |
| UART- uart_fifo | wr_en && !full; rd_en && !empty | Show-ahead rd_data; compare before the pop edge; invalid when empty |
| GoodQuestions fifo_sync_dualport | pop && !fifo_empty; push && (!fifo_full || pop_ok) | Unlike the other sync FIFOs, a full FIFO accepts a simultaneous pop and replacement push |
| AsynchronousFifo async_fifo | wr_en && !full on wr_clk; rd_en && !empty on rd_clk | Registered dout on accepted read; local flags lag remote activity through synchronizers |
| UART- uart_top | TX writes accepted internally only when TX FIFO has space | rdy means RX FIFO nonempty; rdy_clr pops each asserted clock; data_out is show-ahead; busy is transmitter activity |
| UART-legacy uart_top_tb | wr_en accepted only while transmitter idle | ready is sticky receiver status, not buffered RX occupancy |

For AsynchronousFifo, a remote pointer transition captured by synchronization stage 1 at destination edge E1 reaches stage 2 at E2 and the registered flag at E3 in ideal RTL simulation. Clock phase changes the elapsed time. This is not a hardware metastability-latency guarantee. The GoodQuestions and VerilogCodesUpdatedDaily variants have different flag/synchronizer code and require their own checks.

## Run order and known review findings

Start with the core RAM/FIFO/UART P0 cases. The plan deliberately tests the following source risks; none is labeled a newly observed simulation failure:

- GoodQuestions q31 asynchronous FIFO feeds next-pointer flag logic back into pointer acceptance; check boundary settling with a watchdog.
- VerilogCodesUpdatedDaily asynchronous FIFO assigns the destination sync2 directly from the remote Gray pointer. A passing functional queue test does not prove two-stage CDC protection.
- UART- hides TX FIFO full, and its receiver has only one holding register beyond a full RX FIFO. Stress tests must count accepted operations and characterize data loss under overload.
- UART-legacy does not reject a low stop bit. UART- does check stop high.
- PlacementPrep parity checker appears inverted relative to its own generator's error convention.
- The SystemVerilog coverage priority-encoder project cases on y instead of x; the SPI DAC project lacks a defined initial state.
- RevisionAtlas AXI Stream FIFO examples have capacity, pointer-width, missing input-ready and concurrent-transfer risks. Verify each variant independently.
- Empty or malformed practice files are marked Blocked. HDLBits helper stubs are build aids and cannot prove exercise correctness.

## Plain Verilog testbench ideas

- **RAM:** maintain an expected array plus a valid bit per address. For read-first collision, compare the read with the old expected word before applying the write to the reference array.
- **FIFO:** maintain a reference array and integer head/tail/count. Update it only for accepted operations, using the old flags. Distinguish the full replacement policy in GoodQuestions from the blocked-write policy in RamAndFifo.
- **Asynchronous FIFO:** monitor each clock domain separately. Keep simultaneous-edge bookkeeping deterministic and treat reset as an agreed queue flush. Compare local Gray steps, not arbitrarily separated synchronized samples.
- **UART:** use an independent source/decoder for each direction. Loopback alone can hide two blocks sharing the same timing or bit-order error.
- **FSM/counter:** track an independent mathematical sequence or state table. Check legal transitions, output latency, reset, overlap, holds and rollover.
- **Coverage:** in plain Verilog use integer hit counters for the scenarios you actually exercise. Covergroups, SVA, classes and some existing .sv benches require compatible SystemVerilog tools. Reaching a bin is not the same as checking its expected result.

## Completion criteria

All applicable P0 cases pass; all planned legal functional/boundary scenarios have evidence; failed cases are resolved and rerun; every Blocked/N/A row has a reason; random tests record seeds; reference queues drain cleanly; and CDC/physical checks are separately reviewed when hardware readiness matters. Do not claim complete protocol, timing, analog metastability or fault-model coverage from these simulation ideas alone.

## Detailed cases

Each section uses the same case IDs as the Excel tracker. Status in this document is the initial planning state; update the workbook during execution. Source links pin the reviewed code.

### RamAndFifo

#### RF-001 — Registered read timing

- **Block / priority / initial status:** RAM / P0 / Pending
- **Source:** [individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Write A5 to address 0 on a rising clk. Set we=0 and raddr=0 between edges. Change raddr between later edges.
- **Expected result:** dout changes only after a rising clk, after nonblocking updates. It returns the word selected by the pre-edge raddr. Do not expect combinational read-through.

#### RF-002 — Write enable protects contents

- **Block / priority / initial status:** RAM / P1 / Pending
- **Source:** [individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Initialize address 0. Hold we=0 while toggling din and waddr; read address 0 again.
- **Expected result:** dout returns the initialized word. No location changes while we=0.

#### RF-003 — All addresses and aliasing

- **Block / priority / initial status:** RAM / P0 / Pending
- **Source:** [individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Write a distinct address-derived value to every valid waddr; read every raddr in ascending then descending order. Include 0 and DEPTH-1.
- **Expected result:** Every address returns its own last written value. An update to one address must not corrupt any other address.

#### RF-004 — Same-address read/write collision

- **Block / priority / initial status:** RAM / P0 / Pending
- **Source:** [individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Choose legal address A=min(3,DEPTH-1). Initialize A to hex 55. Set waddr=raddr=A, we=1, din=hex AA at the next active edge. Then disable writes and read A again. Truncate patterns to DW bits.
- **Expected result:** On the collision edge dout=hex 55 (old data, truncated to DW). On the following read edge dout=hex AA. This is read-first RTL behavior.

#### RF-005 — Different-address concurrent access

- **Block / priority / initial status:** RAM / P1 / Pending
- **Source:** [individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Read an initialized raddr while we=1 writes a different waddr; repeat with both addresses at the range ends.
- **Expected result:** The read returns the old contents of raddr; the independent write is visible on a later read of waddr.

#### RF-006 — Data bit patterns

- **Block / priority / initial status:** RAM / P1 / Pending
- **Source:** [individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Write/read 00, all ones, alternating 55/AA, walking one and walking zero in each data bit. Fit each pattern to the configured data width.
- **Expected result:** Every bit is preserved without truncation, coupling or unwanted sign extension.

#### RF-007 — Uninitialized read and no reset port

- **Block / priority / initial status:** RAM / P1 / Pending
- **Source:** [individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Start a fresh simulation and read a location before writing it. Then initialize that location and read it again.
- **Expected result:** The first value is unspecified/X in this RTL; it is not a required zero. Only the initialized read has a numeric pass criterion. There is no RAM reset input.

#### RF-008 — Back-to-back overwrite and parameter corners

- **Block / priority / initial status:** RAM / P2 / Pending
- **Source:** [individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Overwrite the same address on consecutive clocks and verify the last word. Repeat the suite at DW=1,8,16 and AW=1,2,4, using legal address ranges.
- **Expected result:** Last accepted write wins; capacity is 2^AW. Default DW=8, AW=4 means 16 entries. Check parameter names in the source before each build.

#### RF-009 — Reset and first usable cycle

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Hold wr_en=rd_en=0. Assert rst=1, clock the design, then release reset away from the active edge.
- **Expected result:** After the specified reset event: empty=1 and full=0; pointers/count are reset. rd_data holds the last accepted read while no read is accepted, and resets to zero.

#### RF-010 — Single write then single read

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Write A5 with wr_en=1 while full=0; disable write; request one read with rd_en=1 while empty=0.
- **Expected result:** empty clears after the write and asserts after the read. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer. Exactly one word is transferred.

#### RF-011 — Ordering and mixed data

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Write 10,22,35,48 with gaps, then drain using isolated and consecutive rd_en requests.
- **Expected result:** Read values are 10,22,35,48 in that order. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### RF-012 — Fill to capacity and reject overflow

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** With rd_en=0, issue exactly DEPTH writes (2^AW (default 16)); check one below full and full. Attempt three further writes with distinct data, then drain.
- **Expected result:** full asserts only after the last available slot is used. Extra writes cannot move the write pointer or replace queued data. Draining returns the original DEPTH values.

#### RF-013 — Drain to empty and reject underflow

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Fill and drain exactly DEPTH accepted reads. Keep rd_en=1 for three additional clocks with wr_en=0.
- **Expected result:** empty asserts on the last accepted pop; extra reads do not advance the read pointer or change occupancy. rd_data holds the last accepted read while no read is accepted, and resets to zero.

#### RF-014 — Both enables in the middle

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Prefill to half capacity. Keep wr_en=rd_en=1 for at least 2*DEPTH clocks with a changing wr_data.
- **Expected result:** Both operations are accepted on each edge and occupancy stays constant. The stream remains ordered across pointer wraps. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### RF-015 — Both enables when empty

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Reset empty, then assert wr_en=rd_en=1 for one edge with wr_data=3C.
- **Expected result:** Only the write is accepted because the pre-edge empty=1. Occupancy becomes one. No same-edge bypass/pop of 3C is allowed.

#### RF-016 — Both enables when full

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Fill to capacity; assert wr_en=rd_en=1 for one edge with a new wr_data.
- **Expected result:** Only the read is accepted because pre-edge full=1; the write is blocked and occupancy becomes DEPTH-1. Resend the new word later if it must be stored.

#### RF-017 — Idle and output validity

- **Block / priority / initial status:** Standalone FIFO / P1 / Pending
- **Source:** [individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Pause both enables at empty, one word, half-full and full. Toggle wr_data while idle.
- **Expected result:** Pointers/count and flags hold. rd_data holds the last accepted read while no read is accepted, and resets to zero.

#### RF-018 — Repeated wraparound

- **Block / priority / initial status:** Standalone FIFO / P1 / Pending
- **Source:** [individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Alternate fill/drain and mixed bursts until each pointer wraps at least four times. Use a sequence number for every accepted write.
- **Expected result:** No duplication, loss or reordering. Counts stay between zero and DEPTH; full and empty cannot both be true.

#### RF-019 — Reset with queued traffic

- **Block / priority / initial status:** Standalone FIFO / P1 / Pending
- **Source:** [individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Prefill, assert rst during traffic, then hold enables low through reset. Discard the software reference queue; release reset and write fresh values.
- **Expected result:** Old queued values are discarded logically. The first fresh drain returns only post-reset accepted writes. rd_data holds the last accepted read while no read is accepted, and resets to zero.

#### RF-020 — Random bursts with a reference queue

- **Block / priority / initial status:** Standalone FIFO / P2 / Pending
- **Source:** [individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Run 1000 or more edges for each of three recorded seeds. Bias requests toward empty/full and one-away states. Queue only writes accepted by pre-edge flags and dequeue only accepted reads.
- **Expected result:** Every accepted read matches the oldest reference word. End by draining and proving the reference queue empty. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### RF-021 — Reset and first usable cycle

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Hold wr_en=rd_en=0. Assert rst=1, clock the design, then release reset away from the active edge.
- **Expected result:** After the specified reset event: empty=1 and full=0; pointers/count are reset. rd_data is driven by an always-reading synchronous RAM, so it may change even when rd_en=0 or empty=1. Do not require output hold or reset-to-zero.

#### RF-022 — Single write then single read

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Write A5 with wr_en=1 while full=0; disable write; request one read with rd_en=1 while empty=0.
- **Expected result:** empty clears after the write and asserts after the read. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer. Exactly one word is transferred.

#### RF-023 — Ordering and mixed data

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Write 10,22,35,48 with gaps, then drain using isolated and consecutive rd_en requests.
- **Expected result:** Read values are 10,22,35,48 in that order. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### RF-024 — Fill to capacity and reject overflow

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** With rd_en=0, issue exactly DEPTH writes (2^AW (default 16)); check one below full and full. Attempt three further writes with distinct data, then drain.
- **Expected result:** full asserts only after the last available slot is used. Extra writes cannot move the write pointer or replace queued data. Draining returns the original DEPTH values.

#### RF-025 — Drain to empty and reject underflow

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Fill and drain exactly DEPTH accepted reads. Keep rd_en=1 for three additional clocks with wr_en=0.
- **Expected result:** empty asserts on the last accepted pop; extra reads do not advance the read pointer or change occupancy. rd_data is driven by an always-reading synchronous RAM, so it may change even when rd_en=0 or empty=1. Do not require output hold or reset-to-zero.

#### RF-026 — Both enables in the middle

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Prefill to half capacity. Keep wr_en=rd_en=1 for at least 2*DEPTH clocks with a changing wr_data.
- **Expected result:** Both operations are accepted on each edge and occupancy stays constant. The stream remains ordered across pointer wraps. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### RF-027 — Both enables when empty

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Reset empty, then assert wr_en=rd_en=1 for one edge with wr_data=3C.
- **Expected result:** Only the write is accepted because the pre-edge empty=1. Occupancy becomes one. No same-edge bypass/pop of 3C is allowed.

#### RF-028 — Both enables when full

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Fill to capacity; assert wr_en=rd_en=1 for one edge with a new wr_data.
- **Expected result:** Only the read is accepted because pre-edge full=1; the write is blocked and occupancy becomes DEPTH-1. Resend the new word later if it must be stored.

#### RF-029 — Idle and output validity

- **Block / priority / initial status:** RAM-backed FIFO / P1 / Pending
- **Source:** [integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Pause both enables at empty, one word, half-full and full. Toggle wr_data while idle.
- **Expected result:** Pointers/count and flags hold. rd_data is driven by an always-reading synchronous RAM, so it may change even when rd_en=0 or empty=1. Do not require output hold or reset-to-zero.

#### RF-030 — Repeated wraparound

- **Block / priority / initial status:** RAM-backed FIFO / P1 / Pending
- **Source:** [integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Alternate fill/drain and mixed bursts until each pointer wraps at least four times. Use a sequence number for every accepted write.
- **Expected result:** No duplication, loss or reordering. Counts stay between zero and DEPTH; full and empty cannot both be true.

#### RF-031 — Reset with queued traffic

- **Block / priority / initial status:** RAM-backed FIFO / P1 / Pending
- **Source:** [integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Prefill, assert rst during traffic, then hold enables low through reset. Discard the software reference queue; release reset and write fresh values.
- **Expected result:** Old queued values are discarded logically. The first fresh drain returns only post-reset accepted writes. rd_data is driven by an always-reading synchronous RAM, so it may change even when rd_en=0 or empty=1. Do not require output hold or reset-to-zero.

#### RF-032 — Random bursts with a reference queue

- **Block / priority / initial status:** RAM-backed FIFO / P2 / Pending
- **Source:** [integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Run 1000 or more edges for each of three recorded seeds. Bias requests toward empty/full and one-away states. Queue only writes accepted by pre-edge flags and dequeue only accepted reads.
- **Expected result:** Every accepted read matches the oldest reference word. End by draining and proving the reference queue empty. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### RF-033 — Reset and first usable cycle

- **Block / priority / initial status:** Wrapper FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Test idea:** Hold wren=rden=0. Assert rst=1, clock the design, then release reset away from the active edge.
- **Expected result:** After the specified reset event: empty=1 and full=0; pointers/count are reset. dout is driven by an always-reading synchronous RAM, so it may change even when rden=0 or empty=1. Do not require output hold or reset-to-zero.

#### RF-034 — Single write then single read

- **Block / priority / initial status:** Wrapper FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Test idea:** Write A5 with wren=1 while full=0; disable write; request one read with rden=1 while empty=0.
- **Expected result:** empty clears after the write and asserts after the read. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer. Exactly one word is transferred.

#### RF-035 — Ordering and mixed data

- **Block / priority / initial status:** Wrapper FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Test idea:** Write 10,22,35,48 with gaps, then drain using isolated and consecutive rden requests.
- **Expected result:** Read values are 10,22,35,48 in that order. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### RF-036 — Fill to capacity and reject overflow

- **Block / priority / initial status:** Wrapper FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Test idea:** With rden=0, issue exactly DEPTH writes (2^aw (default 16)); check one below full and full. Attempt three further writes with distinct data, then drain.
- **Expected result:** full asserts only after the last available slot is used. Extra writes cannot move the write pointer or replace queued data. Draining returns the original DEPTH values.

#### RF-037 — Drain to empty and reject underflow

- **Block / priority / initial status:** Wrapper FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Test idea:** Fill and drain exactly DEPTH accepted reads. Keep rden=1 for three additional clocks with wren=0.
- **Expected result:** empty asserts on the last accepted pop; extra reads do not advance the read pointer or change occupancy. dout is driven by an always-reading synchronous RAM, so it may change even when rden=0 or empty=1. Do not require output hold or reset-to-zero.

#### RF-038 — Both enables in the middle

- **Block / priority / initial status:** Wrapper FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Test idea:** Prefill to half capacity. Keep wren=rden=1 for at least 2*DEPTH clocks with a changing din.
- **Expected result:** Both operations are accepted on each edge and occupancy stays constant. The stream remains ordered across pointer wraps. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### RF-039 — Both enables when empty

- **Block / priority / initial status:** Wrapper FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Test idea:** Reset empty, then assert wren=rden=1 for one edge with din=3C.
- **Expected result:** Only the write is accepted because the pre-edge empty=1. Occupancy becomes one. No same-edge bypass/pop of 3C is allowed.

#### RF-040 — Both enables when full

- **Block / priority / initial status:** Wrapper FIFO / P0 / Pending
- **Source:** [integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Test idea:** Fill to capacity; assert wren=rden=1 for one edge with a new din.
- **Expected result:** Only the read is accepted because pre-edge full=1; the write is blocked and occupancy becomes DEPTH-1. Resend the new word later if it must be stored.

#### RF-041 — Idle and output validity

- **Block / priority / initial status:** Wrapper FIFO / P1 / Pending
- **Source:** [integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Test idea:** Pause both enables at empty, one word, half-full and full. Toggle din while idle.
- **Expected result:** Pointers/count and flags hold. dout is driven by an always-reading synchronous RAM, so it may change even when rden=0 or empty=1. Do not require output hold or reset-to-zero.

#### RF-042 — Repeated wraparound

- **Block / priority / initial status:** Wrapper FIFO / P1 / Pending
- **Source:** [integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Test idea:** Alternate fill/drain and mixed bursts until each pointer wraps at least four times. Use a sequence number for every accepted write.
- **Expected result:** No duplication, loss or reordering. Counts stay between zero and DEPTH; full and empty cannot both be true.

#### RF-043 — Reset with queued traffic

- **Block / priority / initial status:** Wrapper FIFO / P1 / Pending
- **Source:** [integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Test idea:** Prefill, assert rst during traffic, then hold enables low through reset. Discard the software reference queue; release reset and write fresh values.
- **Expected result:** Old queued values are discarded logically. The first fresh drain returns only post-reset accepted writes. dout is driven by an always-reading synchronous RAM, so it may change even when rden=0 or empty=1. Do not require output hold or reset-to-zero.

#### RF-044 — Random bursts with a reference queue

- **Block / priority / initial status:** Wrapper FIFO / P2 / Pending
- **Source:** [integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Test idea:** Run 1000 or more edges for each of three recorded seeds. Bias requests toward empty/full and one-away states. Queue only writes accepted by pre-edge flags and dequeue only accepted reads.
- **Expected result:** Every accepted read matches the oldest reference word. End by draining and proving the reference queue empty. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### RF-045 — Reset while write remains asserted

- **Block / priority / initial status:** RAM-backed FIFO / P1 / Pending
- **Source:** [integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, full, do_write, wr_ptr, fifo_count
- **Test idea:** Prefill a known slot; assert rst=1 with wr_en=1 and full=0 at a clock edge. Observe ram_inst.mem and control state separately.
- **Expected result:** Control pointers/count reset, but do_write is not gated by rst, so RAM can still be written at the old wr_ptr. Decide whether reset must suppress physical writes before adding that requirement.
- **Note:** Source-review finding; not a simulated failure. No old data is valid after FIFO reset.

#### RF-046 — Compile and compare draft contract

- **Block / priority / initial status:** Practice draft / P2 / Pending
- **Source:** [individual/ram/practice.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/practice.v)
- **Signals:** clk, we, din, raddr, waddr, dout
- **Test idea:** Compile this draft alone with an explicit top. Compare its interface and behavior with the active design in the same repository; record missing declarations and output drivers.
- **Expected result:** The draft must elaborate and meet an agreed contract before it can share active-design results. Do not include unfinished drafts in a wildcard compile.
- **Note:** Draft results are separate from active RTL.

#### RF-047 — Compile isolated tops and record reproducible evidence

- **Block / priority / initial status:** Build and evidence / P0 / Pending
- **Source:** [individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Test idea:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.

### AsynchronousFifo

#### AF-001 — Coordinated reset and idle

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Run both independent clocks, set wr_en=rd_en=0 and assert wr_rst=rd_rst=1. Release each reset away from its local edge.
- **Expected result:** Local pointers reset, full=0, empty=1 and dout=0 after reset settles. No memory clearing is required.

#### AF-002 — First word crosses to read domain

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Write A5 once on wr_clk while full=0; keep rd_en=0 and watch empty on successive rd_clk edges. Then request one accepted read.
- **Expected result:** empty deasserts only after synchronized write-pointer visibility. dout=A5 after the accepted rd_clk edge. Flags are registered after the second synchronizer stage; allow the extra flag-register clock.

#### AF-003 — Fill, overflow, drain and underflow

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** With reads stopped, write DEPTH words (2^AW (default 8)), attempt extra writes, then drain after empty clears. Attempt extra reads.
- **Expected result:** Exactly DEPTH original words return in order. Full writes and empty reads never move local pointers. Final full=0 and empty=1 after clock-domain propagation.

#### AF-004 — Fast writer and slow reader

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Use write/read periods 10 ns/31 ns, unrelated initial phases, and bursts long enough to reach full.
- **Expected result:** Only locally accepted operations enter the reference queue; no loss/reordering. full may conservatively remain high while a read propagates.

#### AF-005 — Slow writer and fast reader

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Use write/read periods 29 ns/8 ns, then reverse the rates; repeatedly touch empty.
- **Expected result:** No stale/unwritten word is consumed. empty can remain high while a remote write propagates.

#### AF-006 — Equal rates with phase shifts

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Use 10 ns/10 ns clocks with offsets 0,2,5 ns. Include coincident edges and continuous traffic at half occupancy.
- **Expected result:** Ordered data with race-free stimulus. Determine each operation from its own pre-edge full/empty; do not order coincident events by testbench process scheduling.

#### AF-007 — Gray pointers and blocked requests

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Observe local binary/Gray pointer pairs through wrap. Hold wr_en=1 at full and rd_en=1 at empty.
- **Expected result:** Local pointer increments only on accepted operations; Gray equals binary XOR (binary shifted right one). Successive LOCAL Gray values differ in one bit, or zero when holding. Destination samples may skip states and differ in multiple bits.

#### AF-008 — Synchronizer direction and flag latency

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Apply one remote pointer change while the destination clock runs; trace first and second synchronization stages on each destination edge.
- **Expected result:** Stage 1 samples the remote pointer; stage 2 samples previous stage 1. Flags must use stage 2. Flags are registered after the second synchronizer stage; allow the extra flag-register clock.

#### AF-009 — Clock stop and restart

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Pause rd_clk while writing to full, then resume it; repeat by pausing wr_clk during reads.
- **Expected result:** No operation occurs without its local clock; flags converge after the stopped clock resumes. Scoreboard order survives the pause.

#### AF-010 — Many laps and random bursts

- **Block / priority / initial status:** Asynchronous FIFO / P2 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Run at least four complete pointer laps for three recorded seeds and clock ratios. Compare every accepted read with a software reference queue.
- **Expected result:** No duplicates, drops or ordering errors. End with both clocks running and fully drain the reference queue.

#### AF-011 — Both resets during traffic

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Prefill, assert both resets during a burst, flush the expected queue, restart clocks and send a fresh known sequence.
- **Expected result:** Reset discards previous queued data; only new writes are considered valid. No assumptions about clearing memory cells.

#### AF-012 — One-sided reset contract

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Blocked
- **Source:** [async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Consider asserting only wr_rst, then only rd_rst, while data is pending. Define whether the whole FIFO is flushed or one domain may continue before executing.
- **Expected result:** Pass criteria require an agreed system reset policy. Current independent pointer resets do not guarantee preservation of unread data after a one-sided reset.
- **Note:** Resolve reset policy first; never mark data preservation proven by ordinary RTL simulation.

#### AF-013 — Parameter and minimum-depth limits

- **Block / priority / initial status:** Asynchronous FIFO / P2 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Elaborate legal data widths 1,8,16 and address widths 2,3,4. Separately try address width 1 and non-power-of-two DEPTH if that parameter exists.
- **Expected result:** Supported configurations retain capacity and ordering. Record unsupported values as a documented constraint: slices such as [AW-2:0] or [ADDR-2:0] need special handling below address width 2.

#### AF-014 — CDC implementation review

- **Block / priority / initial status:** Asynchronous FIFO / P2 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Inspect the synthesized synchronizer paths, reset release, Gray-bus constraints and memory mapping with the target FPGA/ASIC tools.
- **Expected result:** A CDC report and reviewed timing constraints are separate evidence. Functional simulation cannot establish metastability reliability or physical Gray-bus skew.
- **Note:** This is a design-review case, not a Verilog simulation pass.

#### AF-015 — Match and overlap

- **Block / priority / initial status:** 1101 sequence detector / P0 / Pending
- **Source:** [mealy_1101_detector.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/mealy_1101_detector.v)
- **Signals:** clk, reset, data_in, detected
- **Test idea:** Reset and drive 1101101 one bit per cycle away from posedge clk. Inspect detected before the edge consuming each final 1.
- **Expected result:** Matches finish at bit positions 4 and 7. This is a combinational Mealy output and can drop after the edge when state changes.

#### AF-016 — Near misses and partial reset

- **Block / priority / initial status:** 1101 sequence detector / P1 / Pending
- **Source:** [mealy_1101_detector.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/mealy_1101_detector.v)
- **Signals:** clk, reset, data_in, detected
- **Test idea:** Send 0000,1111,1100,1011, then reset after prefix 110 and continue with 1.
- **Expected result:** No false match on a near miss or a prefix discarded by reset. Reset is asynchronous active high.

#### AF-017 — Long stream reference window

- **Block / priority / initial status:** 1101 sequence detector / P2 / Pending
- **Source:** [mealy_1101_detector.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/mealy_1101_detector.v)
- **Signals:** clk, reset, data_in, detected
- **Test idea:** Compare 1000 random bits against a four-bit rolling reference window, with recorded seed.
- **Expected result:** detected matches every occurrence of 1101 with overlap and the specified pre-edge sampling.

#### AF-018 — Compile isolated tops and record reproducible evidence

- **Block / priority / initial status:** Build and evidence / P0 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/AsynchronousFifo/blob/a60bcd212928103b2d81d8f2d4eae248ea2e3468/async_fifo.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Test idea:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.

### UART-

#### UART-001 — Reset and first usable cycle

- **Block / priority / initial status:** UART FIFO / P0 / Pending
- **Source:** [rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Hold wr_en=rd_en=0. Assert reset=1, clock the design, then release reset away from the active edge.
- **Expected result:** After the specified reset event: empty=1 and full=0; pointers/count are reset. rd_data is show-ahead; it can change when the first word is written. It is unspecified while empty.

#### UART-002 — Single write then single read

- **Block / priority / initial status:** UART FIFO / P0 / Pending
- **Source:** [rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Write A5 with wr_en=1 while full=0; disable write; request one read with rd_en=1 while empty=0.
- **Expected result:** empty clears after the write and asserts after the read. Compare rd_data to the expected front BEFORE the pop edge; after the edge it shows the next front when nonempty. Exactly one word is transferred.

#### UART-003 — Ordering and mixed data

- **Block / priority / initial status:** UART FIFO / P0 / Pending
- **Source:** [rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Write 10,22,35,48 with gaps, then drain using isolated and consecutive rd_en requests.
- **Expected result:** Read values are 10,22,35,48 in that order. Compare rd_data to the expected front BEFORE the pop edge; after the edge it shows the next front when nonempty.

#### UART-004 — Fill to capacity and reject overflow

- **Block / priority / initial status:** UART FIFO / P0 / Pending
- **Source:** [rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** With rd_en=0, issue exactly DEPTH writes (16 fixed entries); check one below full and full. Attempt three further writes with distinct data, then drain.
- **Expected result:** full asserts only after the last available slot is used. Extra writes cannot move the write pointer or replace queued data. Draining returns the original DEPTH values.

#### UART-005 — Drain to empty and reject underflow

- **Block / priority / initial status:** UART FIFO / P0 / Pending
- **Source:** [rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Fill and drain exactly DEPTH accepted reads. Keep rd_en=1 for three additional clocks with wr_en=0.
- **Expected result:** empty asserts on the last accepted pop; extra reads do not advance the read pointer or change occupancy. rd_data is show-ahead; it can change when the first word is written. It is unspecified while empty.

#### UART-006 — Both enables in the middle

- **Block / priority / initial status:** UART FIFO / P0 / Pending
- **Source:** [rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Prefill to half capacity. Keep wr_en=rd_en=1 for at least 2*DEPTH clocks with a changing wr_data.
- **Expected result:** Both operations are accepted on each edge and occupancy stays constant. The stream remains ordered across pointer wraps. Compare rd_data to the expected front BEFORE the pop edge; after the edge it shows the next front when nonempty.

#### UART-007 — Both enables when empty

- **Block / priority / initial status:** UART FIFO / P0 / Pending
- **Source:** [rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Reset empty, then assert wr_en=rd_en=1 for one edge with wr_data=3C.
- **Expected result:** Only the write is accepted because the pre-edge empty=1. Occupancy becomes one. No same-edge bypass/pop of 3C is allowed.

#### UART-008 — Both enables when full

- **Block / priority / initial status:** UART FIFO / P0 / Pending
- **Source:** [rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Fill to capacity; assert wr_en=rd_en=1 for one edge with a new wr_data.
- **Expected result:** Only the read is accepted because pre-edge full=1; the write is blocked and occupancy becomes DEPTH-1. Resend the new word later if it must be stored.

#### UART-009 — Idle and output validity

- **Block / priority / initial status:** UART FIFO / P1 / Pending
- **Source:** [rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Pause both enables at empty, one word, half-full and full. Toggle wr_data while idle.
- **Expected result:** Pointers/count and flags hold. rd_data is show-ahead; it can change when the first word is written. It is unspecified while empty.

#### UART-010 — Repeated wraparound

- **Block / priority / initial status:** UART FIFO / P1 / Pending
- **Source:** [rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Alternate fill/drain and mixed bursts until each pointer wraps at least four times. Use a sequence number for every accepted write.
- **Expected result:** No duplication, loss or reordering. Counts stay between zero and DEPTH; full and empty cannot both be true.

#### UART-011 — Reset with queued traffic

- **Block / priority / initial status:** UART FIFO / P1 / Pending
- **Source:** [rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Prefill, assert reset during traffic, then hold enables low through reset. Discard the software reference queue; release reset and write fresh values.
- **Expected result:** Old queued values are discarded logically. The first fresh drain returns only post-reset accepted writes. rd_data is show-ahead; it can change when the first word is written. It is unspecified while empty.

#### UART-012 — Random bursts with a reference queue

- **Block / priority / initial status:** UART FIFO / P2 / Pending
- **Source:** [rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Run 1000 or more edges for each of three recorded seeds. Bias requests toward empty/full and one-away states. Queue only writes accepted by pre-edge flags and dequeue only accepted reads.
- **Expected result:** Every accepted read matches the oldest reference word. End by draining and proving the reference queue empty. Compare rd_data to the expected front BEFORE the pop edge; after the edge it shows the next front when nonempty.

#### UART-013 — Reset polarity and initial enables

- **Block / priority / initial status:** Baud generator / P0 / Pending
- **Source:** [rtlCode/baud_rate_generator.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/baud_rate_generator.v)
- **Signals:** clk, reset, tx_en, rx_en
- **Test idea:** Assert reset=1 across rising clk edges; inspect the counters and both enables before releasing reset.
- **Expected result:** Counters and registered tx_en/rx_en reset to 0. No enable pulse is emitted while reset is active.

#### UART-014 — Exact tick interval

- **Block / priority / initial status:** Baud generator / P0 / Pending
- **Source:** [rtlCode/baud_rate_generator.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/baud_rate_generator.v)
- **Signals:** clk, reset, tx_en, rx_en
- **Test idea:** Count clk edges between at least ten tx_en pulses and ten rx_en pulses after reset.
- **Expected result:** Periods are TX_DIV=5208 clocks and RX_DIV=325 clocks. Each pulse is one clk period at these defaults.

#### UART-015 — Divisor corners and restart

- **Block / priority / initial status:** Baud generator / P2 / Pending
- **Source:** [rtlCode/baud_rate_generator.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/baud_rate_generator.v)
- **Signals:** clk, reset, tx_en, rx_en
- **Test idea:** Repeat with small legal terminal values/divisors, reset midway through counting, and measure the restarted interval.
- **Expected result:** Counter widths limit the supported range. Current UART: TX_DIV 1..8192 and RX_DIV 1..1024; DIV=1 makes enable continuously high. Legacy: maximum terminal counts 8191 and 1023; zero makes enable continuously high. Do not silently truncate unsupported overrides.

#### UART-016 — TX/RX rate ratio

- **Block / priority / initial status:** Baud generator / P1 / Pending
- **Source:** [rtlCode/baud_rate_generator.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/baud_rate_generator.v)
- **Signals:** clk, tx_en, rx_en
- **Test idea:** Measure serial-bit duration and receiver sample spacing with the actual defaults, then use a small exact 16:1 setup in isolated tests.
- **Expected result:** Default tick ratios are close to, but not exactly, 16:1. Evaluate complete frames and phase variation; do not assume the parameter names represent the same terminal-count convention.

#### UART-017 — Reset and idle level

- **Block / priority / initial status:** UART transmitter / P0 / Pending
- **Source:** [rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, rst, wr_en, data_in, tx_en, tx, busy
- **Test idea:** Assert rst; release with wr_en=0. Run several tx_en pulses.
- **Expected result:** After reset tx=1 and busy=0. Idle remains high.

#### UART-018 — 8N1 frame and bit order

- **Block / priority / initial status:** UART transmitter / P0 / Pending
- **Source:** [rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, rst, wr_en, data_in, tx_en, tx, busy
- **Test idea:** Pulse wr_en for one clk with data_in=A5 while busy=0. Supply regular tx_en ticks and record tx at each tick.
- **Expected result:** Frame is start 0, data bits 1,0,1,0,0,1,0,1 (LSB first), then stop 1. busy rises on the accepted request and falls when stop is launched.

#### UART-019 — Byte patterns and all values

- **Block / priority / initial status:** UART transmitter / P1 / Pending
- **Source:** [rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Test idea:** Send 00,FF,55,AA,01,80 then all 256 byte values. Decode the serial line independently.
- **Expected result:** Every decoded byte equals the accepted data_in; exactly eight data bits plus start/stop are emitted.

#### UART-020 — Latched input data

- **Block / priority / initial status:** UART transmitter / P0 / Pending
- **Source:** [rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Test idea:** Accept 3C, then change data_in every clk while busy=1.
- **Expected result:** The current frame remains 3C; the input is latched at request acceptance.

#### UART-021 — Write request while busy

- **Block / priority / initial status:** UART transmitter / P1 / Pending
- **Source:** [rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Test idea:** Pulse wr_en in START, each DATA position and STOP while busy=1. Then repeat with wr_en held until the next idle cycle.
- **Expected result:** Pulses entirely while busy are ignored by this transmitter. A held request can be accepted in IDLE and send another byte; it is not a one-shot interface.

#### UART-022 — Missing enable ticks

- **Block / priority / initial status:** UART transmitter / P1 / Pending
- **Source:** [rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, wr_en, tx_en, tx, busy
- **Test idea:** Pause tx_en in START, DATA and STOP for several clk periods, then resume.
- **Expected result:** Frame state/bit position holds while waiting; tx and busy do not advance to the next serial bit without tx_en.

#### UART-023 — Reset mid-frame and recovery

- **Block / priority / initial status:** UART transmitter / P1 / Pending
- **Source:** [rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, rst, wr_en, data_in, tx_en, tx, busy
- **Test idea:** Reset during start, a data bit and stop; release and transmit a fresh byte.
- **Expected result:** Reset aborts the partial frame, restores idle-high tx and clears busy. A new request produces a complete fresh frame.

#### UART-024 — Stop-bit duration before next frame

- **Block / priority / initial status:** UART transmitter / P1 / Pending
- **Source:** [rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Test idea:** Submit the next byte at the earliest idle clk after busy falls; measure tx until the next start bit.
- **Expected result:** The stop interval remains a full baud-tick interval even though busy drops when stop is launched. Check timing from tx transitions rather than busy alone.

#### UART-025 — Reset and idle-high input

- **Block / priority / initial status:** UART receiver / P0 / Pending
- **Source:** [rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy_clr, rdy, data_out
- **Test idea:** Assert rst, then release with rx=1, rdy_clr=0 and periodic rx_en.
- **Expected result:** rdy=0 and data_out=0 after reset; idle-high rx must not create a receive event.

#### UART-026 — Receive 8N1 independently

- **Block / priority / initial status:** UART receiver / P0 / Pending
- **Source:** [rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Test idea:** Drive rx from an independent serial source: start 0, eight LSB-first bits for A5, stop 1. Use 16 rx_en samples per bit.
- **Expected result:** One completed frame sets data_out=A5 and rdy=1. Check after the stop sampling edge and nonblocking updates.

#### UART-027 — Reject a false start

- **Block / priority / initial status:** UART receiver / P1 / Pending
- **Source:** [rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy, data_out
- **Test idea:** Drive a short low pulse that is high again by the middle-of-start validation sample, then a valid frame.
- **Expected result:** No byte is reported for the glitch. The next valid frame is received normally.

#### UART-028 — Stop-bit error behavior

- **Block / priority / initial status:** UART receiver / P0 / Pending
- **Source:** [rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Test idea:** Clear previous rdy; send a valid start and eight data bits, but keep rx low at the stop sample. Then return idle high and send a valid frame.
- **Expected result:** Current receiver rejects the bad stop: no new rdy and no data_out update. It has no separate framing-error port.

#### UART-029 — Sticky ready and clear race

- **Block / priority / initial status:** UART receiver / P1 / Pending
- **Source:** [rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Test idea:** Receive a byte with rdy_clr=0, wait, clear it, then assert rdy_clr on the same clk edge that another good stop is accepted.
- **Expected result:** rdy holds until clear. On coincident clear and good completion, the later receive assignment wins: rdy=1 with the new data.

#### UART-030 — Unread result overwritten

- **Block / priority / initial status:** UART receiver / P1 / Pending
- **Source:** [rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Test idea:** Send two frames without clearing rdy in between; record both completion moments.
- **Expected result:** This receiver has one result register. A later good frame replaces data_out even if previous rdy remained high; no overrun indication exists.

#### UART-031 — Phase and rate sweep

- **Block / priority / initial status:** UART receiver / P2 / Pending
- **Source:** [rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy, data_out
- **Test idea:** Shift frame start through all 16 sample phases; sweep small positive/negative bit-period offsets and include 00,FF,55,AA.
- **Expected result:** All values in the agreed nominal tolerance pass. Record the measured tolerance boundary rather than inventing a guaranteed percentage.

#### UART-032 — Reset while receiving

- **Block / priority / initial status:** UART receiver / P1 / Pending
- **Source:** [rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy, data_out
- **Test idea:** Reset during start, each data position and stop. Restore idle high before a fresh frame.
- **Expected result:** Partial frame is discarded; reset clears ready/data and the fresh frame is received once.

#### UART-033 — Input synchronization review

- **Block / priority / initial status:** UART receiver / P1 / Pending
- **Source:** [rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy, data_out
- **Test idea:** Trace the rx sampling path and distinguish this loopback demo from an external asynchronous pin.
- **Expected result:** This receiver samples rx directly when rx_en is high. Loopback works synchronously, but using an external asynchronous pin requires an input synchronization/CDC decision.

#### UART-034 — One buffered byte end to end

- **Block / priority / initial status:** Buffered UART loopback / P0 / Pending
- **Source:** [rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, reset, wr_en, data_in, rdy, rdy_clr, data_out, busy
- **Test idea:** Reset, pulse wr_en with 47, wait with a bounded timeout for rdy=1, inspect data_out, then pulse rdy_clr.
- **Expected result:** One byte 47 is visible at the receive FIFO head. rdy_clr pops it; rdy falls when the RX FIFO becomes empty.

#### UART-035 — Burst into TX FIFO and ordered RX drain

- **Block / priority / initial status:** Buffered UART loopback / P0 / Pending
- **Source:** [rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, wr_en, data_in, rdy, rdy_clr, data_out, busy
- **Test idea:** After reset enqueue 12 distinct bytes on consecutive clk edges. Let serialization finish, then drain using one-cycle rdy_clr pulses.
- **Expected result:** All 12 bytes return once, in order. Capture data_out before each pop edge because the RX FIFO is show-ahead.

#### UART-036 — Busy is not TX backpressure

- **Block / priority / initial status:** Buffered UART loopback / P0 / Pending
- **Source:** [rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, wr_en, data_in, busy, tx_start, tx_fifo_empty
- **Test idea:** Watch busy while adding bytes faster than line rate; compare accepted writes to the internal tx_fifo.full flag.
- **Expected result:** busy reports transmitter activity only. A write can be accepted while busy=1 if FIFO space exists; busy=0 is not a formal FIFO write-ready signal.

#### UART-037 — TX overflow characterization

- **Block / priority / initial status:** Buffered UART loopback / P0 / Pending
- **Source:** [rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, wr_en, data_in, busy, tx_start
- **Test idea:** Stop or greatly slow baud progress; offer more bytes than the 16-entry TX FIFO plus any active transmitter byte can hold. Track tx_fifo.full internally.
- **Expected result:** Writes while tx_fifo.full=1 are dropped. The top does not expose full or an acceptance indication. Record offered versus accepted versus received counts; do not claim lossless arbitrary bursts.

#### UART-038 — RX full and receiver-register overrun

- **Block / priority / initial status:** Buffered UART loopback / P0 / Pending
- **Source:** [rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, wr_en, data_in, rdy, rdy_clr, data_out, rx_byte_ready, rx_fifo_full
- **Test idea:** With rdy_clr=0, send enough frames to fill RX FIFO, then allow two more frame completions before freeing a slot.
- **Expected result:** RX FIFO protects its stored 16 words, but the receiver holds only one additional result. Later frames can overwrite that pending result. Record the loss boundary and need for flow control.

#### UART-039 — One pending RX byte after space opens

- **Block / priority / initial status:** Buffered UART loopback / P1 / Pending
- **Source:** [rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, rdy_clr, rdy, data_out, rx_fifo_write, rx_fifo_read
- **Test idea:** Fill RX FIFO, allow exactly one pending received byte, then pop one word and stop further input frames.
- **Expected result:** After full clears, the pending byte enters once and rx_byte_ready is cleared. There is a clock of recovery because acceptance uses pre-edge full.

#### UART-040 — Held consume request

- **Block / priority / initial status:** Buffered UART loopback / P1 / Pending
- **Source:** [rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, rdy_clr, rdy, data_out
- **Test idea:** Buffer several received bytes and hold rdy_clr=1 across multiple clk edges.
- **Expected result:** One byte is popped per nonempty clk edge, not one per rising edge of rdy_clr. When empty, further requests are ignored.

#### UART-041 — Reset aborts TX and RX queues

- **Block / priority / initial status:** Buffered UART loopback / P1 / Pending
- **Source:** [rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, reset, wr_en, data_in, rdy, rdy_clr, data_out, busy
- **Test idea:** Reset with queued TX data and unread RX data; release with controls low, then send a fresh known sequence.
- **Expected result:** Both queues flush logically, busy=0 and rdy=0. Only post-reset accepted bytes may be counted; data_out while rdy=0 is not valid.

#### UART-042 — Compile isolated tops and record reproducible evidence

- **Block / priority / initial status:** Build and evidence / P0 / Pending
- **Source:** [rtlCode/baud_rate_generator.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/baud_rate_generator.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Test idea:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.

### UART-legacy

#### UL-001 — Reset polarity and initial enables

- **Block / priority / initial status:** Baud generator / P0 / Pending
- **Source:** [baud_rate_generator.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/baud_rate_generator.v)
- **Signals:** clk, rst, tx_en, rx_en
- **Test idea:** Assert rst=1 across rising clk edges; inspect the counters and both enables before releasing reset.
- **Expected result:** Counters reset to 0, so combinational tx_en and rx_en are HIGH during reset. Receiver/transmitter reset must take priority.

#### UL-002 — Exact tick interval

- **Block / priority / initial status:** Baud generator / P0 / Pending
- **Source:** [baud_rate_generator.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/baud_rate_generator.v)
- **Signals:** clk, rst, tx_en, rx_en
- **Test idea:** Count clk edges between at least ten tx_en pulses and ten rx_en pulses after reset.
- **Expected result:** Periods are TX_COUNT_MAX+1=5209 clocks and RX_COUNT_MAX+1=326 clocks, not 5208/325.

#### UL-003 — Divisor corners and restart

- **Block / priority / initial status:** Baud generator / P2 / Pending
- **Source:** [baud_rate_generator.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/baud_rate_generator.v)
- **Signals:** clk, rst, tx_en, rx_en
- **Test idea:** Repeat with small legal terminal values/divisors, reset midway through counting, and measure the restarted interval.
- **Expected result:** Counter widths limit the supported range. Current UART: TX_DIV 1..8192 and RX_DIV 1..1024; DIV=1 makes enable continuously high. Legacy: maximum terminal counts 8191 and 1023; zero makes enable continuously high. Do not silently truncate unsupported overrides.

#### UL-004 — TX/RX rate ratio

- **Block / priority / initial status:** Baud generator / P1 / Pending
- **Source:** [baud_rate_generator.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/baud_rate_generator.v)
- **Signals:** clk, tx_en, rx_en
- **Test idea:** Measure serial-bit duration and receiver sample spacing with the actual defaults, then use a small exact 16:1 setup in isolated tests.
- **Expected result:** Default tick ratios are close to, but not exactly, 16:1. Evaluate complete frames and phase variation; do not assume the parameter names represent the same terminal-count convention.

#### UL-005 — Reset and idle level

- **Block / priority / initial status:** UART transmitter / P0 / Pending
- **Source:** [transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, rst, wr_en, data_in, tx_en, tx, busy
- **Test idea:** Assert rst; release with wr_en=0. Run several tx_en pulses.
- **Expected result:** After reset tx=1 and busy=0. Idle remains high.

#### UL-006 — 8N1 frame and bit order

- **Block / priority / initial status:** UART transmitter / P0 / Pending
- **Source:** [transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, rst, wr_en, data_in, tx_en, tx, busy
- **Test idea:** Pulse wr_en for one clk with data_in=A5 while busy=0. Supply regular tx_en ticks and record tx at each tick.
- **Expected result:** Frame is start 0, data bits 1,0,1,0,0,1,0,1 (LSB first), then stop 1. busy rises on the accepted request and falls when stop is launched.

#### UL-007 — Byte patterns and all values

- **Block / priority / initial status:** UART transmitter / P1 / Pending
- **Source:** [transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Test idea:** Send 00,FF,55,AA,01,80 then all 256 byte values. Decode the serial line independently.
- **Expected result:** Every decoded byte equals the accepted data_in; exactly eight data bits plus start/stop are emitted.

#### UL-008 — Latched input data

- **Block / priority / initial status:** UART transmitter / P0 / Pending
- **Source:** [transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Test idea:** Accept 3C, then change data_in every clk while busy=1.
- **Expected result:** The current frame remains 3C; the input is latched at request acceptance.

#### UL-009 — Write request while busy

- **Block / priority / initial status:** UART transmitter / P1 / Pending
- **Source:** [transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Test idea:** Pulse wr_en in START, each DATA position and STOP while busy=1. Then repeat with wr_en held until the next idle cycle.
- **Expected result:** Pulses entirely while busy are ignored by this transmitter. A held request can be accepted in IDLE and send another byte; it is not a one-shot interface.

#### UL-010 — Missing enable ticks

- **Block / priority / initial status:** UART transmitter / P1 / Pending
- **Source:** [transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, wr_en, tx_en, tx, busy
- **Test idea:** Pause tx_en in START, DATA and STOP for several clk periods, then resume.
- **Expected result:** Frame state/bit position holds while waiting; tx and busy do not advance to the next serial bit without tx_en.

#### UL-011 — Reset mid-frame and recovery

- **Block / priority / initial status:** UART transmitter / P1 / Pending
- **Source:** [transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, rst, wr_en, data_in, tx_en, tx, busy
- **Test idea:** Reset during start, a data bit and stop; release and transmit a fresh byte.
- **Expected result:** Reset aborts the partial frame, restores idle-high tx and clears busy. A new request produces a complete fresh frame.

#### UL-012 — Stop-bit duration before next frame

- **Block / priority / initial status:** UART transmitter / P1 / Pending
- **Source:** [transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Test idea:** Submit the next byte at the earliest idle clk after busy falls; measure tx until the next start bit.
- **Expected result:** The stop interval remains a full baud-tick interval even though busy drops when stop is launched. Check timing from tx transitions rather than busy alone.

#### UL-013 — Reset and idle-high input

- **Block / priority / initial status:** UART receiver / P0 / Pending
- **Source:** [uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy_clr, rdy, data_out
- **Test idea:** Assert rst, then release with rx=1, rdy_clr=0 and periodic rx_en.
- **Expected result:** rdy=0 and data_out=0 after reset; idle-high rx must not create a receive event.

#### UL-014 — Receive 8N1 independently

- **Block / priority / initial status:** UART receiver / P0 / Pending
- **Source:** [uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Test idea:** Drive rx from an independent serial source: start 0, eight LSB-first bits for A5, stop 1. Use 16 rx_en samples per bit.
- **Expected result:** One completed frame sets data_out=A5 and rdy=1. Check after the stop sampling edge and nonblocking updates.

#### UL-015 — Reject a false start

- **Block / priority / initial status:** UART receiver / P1 / Pending
- **Source:** [uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy, data_out
- **Test idea:** Drive a short low pulse that is high again by the middle-of-start validation sample, then a valid frame.
- **Expected result:** No byte is reported for the glitch. The next valid frame is received normally.

#### UL-016 — Stop-bit error behavior

- **Block / priority / initial status:** UART receiver / P0 / Pending
- **Source:** [uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Test idea:** Clear previous rdy; send a valid start and eight data bits, but keep rx low at the stop sample. Then return idle high and send a valid frame.
- **Expected result:** Current legacy RTL accepts the byte without validating the stop bit. Record that limitation; do not claim framing-error protection.

#### UL-017 — Sticky ready and clear race

- **Block / priority / initial status:** UART receiver / P1 / Pending
- **Source:** [uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Test idea:** Receive a byte with rdy_clr=0, wait, clear it, then assert rdy_clr on the same clk edge that another good stop is accepted.
- **Expected result:** rdy holds until clear. On coincident clear and good completion, the later receive assignment wins: rdy=1 with the new data.

#### UL-018 — Unread result overwritten

- **Block / priority / initial status:** UART receiver / P1 / Pending
- **Source:** [uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Test idea:** Send two frames without clearing rdy in between; record both completion moments.
- **Expected result:** This receiver has one result register. A later good frame replaces data_out even if previous rdy remained high; no overrun indication exists.

#### UL-019 — Phase and rate sweep

- **Block / priority / initial status:** UART receiver / P2 / Pending
- **Source:** [uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy, data_out
- **Test idea:** Shift frame start through all 16 sample phases; sweep small positive/negative bit-period offsets and include 00,FF,55,AA.
- **Expected result:** All values in the agreed nominal tolerance pass. Record the measured tolerance boundary rather than inventing a guaranteed percentage.

#### UL-020 — Reset while receiving

- **Block / priority / initial status:** UART receiver / P1 / Pending
- **Source:** [uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy, data_out
- **Test idea:** Reset during start, each data position and stop. Restore idle high before a fresh frame.
- **Expected result:** Partial frame is discarded; reset clears ready/data and the fresh frame is received once.

#### UL-021 — Input synchronization review

- **Block / priority / initial status:** UART receiver / P1 / Pending
- **Source:** [uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy, data_out
- **Test idea:** Trace the rx sampling path and distinguish this loopback demo from an external asynchronous pin.
- **Expected result:** rx passes through rx_meta then rx_sync on clk. Account for the two clk stages in phase tests; physical CDC still needs implementation review.

#### UL-022 — Loopback and explicit ready clear

- **Block / priority / initial status:** Legacy UART loopback / P0 / Pending
- **Source:** [uart_top_tb.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_top_tb.v)
- **Signals:** clk, rst, wr_en, data_in, ready, rdy_clr, data_out, busy
- **Test idea:** Reset, send 47 only while busy=0, wait for ready, compare data_out, clear ready, then repeat with 55.
- **Expected result:** 47 then 55 are received. ready remains high until rdy_clr. Use a watchdog; the existing print-only bench is not proof of equality.

#### UL-023 — No implicit transmit queue

- **Block / priority / initial status:** Legacy UART loopback / P1 / Pending
- **Source:** [uart_top_tb.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_top_tb.v)
- **Signals:** clk, wr_en, data_in, busy, ready
- **Test idea:** Pulse wr_en several times while busy=1 and compare how many frames complete.
- **Expected result:** There is no TX FIFO in this version; only a request accepted in transmitter IDLE is sent. Busy-time one-cycle requests are ignored.

#### UL-024 — Compile isolated tops and record reproducible evidence

- **Block / priority / initial status:** Build and evidence / P0 / Pending
- **Source:** [baud_rate_generator.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/baud_rate_generator.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Test idea:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.

### DesignProject

#### DP-001 — Registered read timing

- **Block / priority / initial status:** RAM / P0 / Pending
- **Source:** [rtl/sync_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_ram.sv)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Write A5 to address 0 on a rising clk. Set we=0 and raddr=0 between edges. Change raddr between later edges.
- **Expected result:** dout changes only after a rising clk, after nonblocking updates. It returns the word selected by the pre-edge raddr. Do not expect combinational read-through.

#### DP-002 — Write enable protects contents

- **Block / priority / initial status:** RAM / P1 / Pending
- **Source:** [rtl/sync_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_ram.sv)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Initialize address 0. Hold we=0 while toggling din and waddr; read address 0 again.
- **Expected result:** dout returns the initialized word. No location changes while we=0.

#### DP-003 — All addresses and aliasing

- **Block / priority / initial status:** RAM / P0 / Pending
- **Source:** [rtl/sync_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_ram.sv)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Write a distinct address-derived value to every valid waddr; read every raddr in ascending then descending order. Include 0 and DEPTH-1.
- **Expected result:** Every address returns its own last written value. An update to one address must not corrupt any other address.

#### DP-004 — Same-address read/write collision

- **Block / priority / initial status:** RAM / P0 / Pending
- **Source:** [rtl/sync_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_ram.sv)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Choose legal address A=min(3,DEPTH-1). Initialize A to hex 55. Set waddr=raddr=A, we=1, din=hex AA at the next active edge. Then disable writes and read A again. Truncate patterns to DW bits.
- **Expected result:** On the collision edge dout=hex 55 (old data, truncated to DW). On the following read edge dout=hex AA. This is read-first RTL behavior.

#### DP-005 — Different-address concurrent access

- **Block / priority / initial status:** RAM / P1 / Pending
- **Source:** [rtl/sync_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_ram.sv)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Read an initialized raddr while we=1 writes a different waddr; repeat with both addresses at the range ends.
- **Expected result:** The read returns the old contents of raddr; the independent write is visible on a later read of waddr.

#### DP-006 — Data bit patterns

- **Block / priority / initial status:** RAM / P1 / Pending
- **Source:** [rtl/sync_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_ram.sv)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Write/read 00, all ones, alternating 55/AA, walking one and walking zero in each data bit. Fit each pattern to the configured data width.
- **Expected result:** Every bit is preserved without truncation, coupling or unwanted sign extension.

#### DP-007 — Uninitialized read and no reset port

- **Block / priority / initial status:** RAM / P1 / Pending
- **Source:** [rtl/sync_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_ram.sv)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Start a fresh simulation and read a location before writing it. Then initialize that location and read it again.
- **Expected result:** The first value is unspecified/X in this RTL; it is not a required zero. Only the initialized read has a numeric pass criterion. There is no RAM reset input.

#### DP-008 — Back-to-back overwrite and parameter corners

- **Block / priority / initial status:** RAM / P2 / Pending
- **Source:** [rtl/sync_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_ram.sv)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Test idea:** Overwrite the same address on consecutive clocks and verify the last word. Repeat the suite at DW=1,8,16 and AW=1,2,4, using legal address ranges.
- **Expected result:** Last accepted write wins; capacity is 2^AW. Default DW=8, AW=4 means 16 entries. Check parameter names in the source before each build.

#### DP-009 — Reset and first usable cycle

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Hold wr_en=rd_en=0. Assert rst=1, clock the design, then release reset away from the active edge.
- **Expected result:** After the specified reset event: empty=1 and full=0; pointers/count are reset. rd_data holds the last accepted read while no read is accepted, and resets to zero.

#### DP-010 — Single write then single read

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Write A5 with wr_en=1 while full=0; disable write; request one read with rd_en=1 while empty=0.
- **Expected result:** empty clears after the write and asserts after the read. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer. Exactly one word is transferred.

#### DP-011 — Ordering and mixed data

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Write 10,22,35,48 with gaps, then drain using isolated and consecutive rd_en requests.
- **Expected result:** Read values are 10,22,35,48 in that order. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### DP-012 — Fill to capacity and reject overflow

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** With rd_en=0, issue exactly DEPTH writes (2^AW (default 16)); check one below full and full. Attempt three further writes with distinct data, then drain.
- **Expected result:** full asserts only after the last available slot is used. Extra writes cannot move the write pointer or replace queued data. Draining returns the original DEPTH values.

#### DP-013 — Drain to empty and reject underflow

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Fill and drain exactly DEPTH accepted reads. Keep rd_en=1 for three additional clocks with wr_en=0.
- **Expected result:** empty asserts on the last accepted pop; extra reads do not advance the read pointer or change occupancy. rd_data holds the last accepted read while no read is accepted, and resets to zero.

#### DP-014 — Both enables in the middle

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Prefill to half capacity. Keep wr_en=rd_en=1 for at least 2*DEPTH clocks with a changing wr_data.
- **Expected result:** Both operations are accepted on each edge and occupancy stays constant. The stream remains ordered across pointer wraps. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### DP-015 — Both enables when empty

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Reset empty, then assert wr_en=rd_en=1 for one edge with wr_data=3C.
- **Expected result:** Only the write is accepted because the pre-edge empty=1. Occupancy becomes one. No same-edge bypass/pop of 3C is allowed.

#### DP-016 — Both enables when full

- **Block / priority / initial status:** Standalone FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Fill to capacity; assert wr_en=rd_en=1 for one edge with a new wr_data.
- **Expected result:** Only the read is accepted because pre-edge full=1; the write is blocked and occupancy becomes DEPTH-1. Resend the new word later if it must be stored.

#### DP-017 — Idle and output validity

- **Block / priority / initial status:** Standalone FIFO / P1 / Pending
- **Source:** [rtl/sync_fifo.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Pause both enables at empty, one word, half-full and full. Toggle wr_data while idle.
- **Expected result:** Pointers/count and flags hold. rd_data holds the last accepted read while no read is accepted, and resets to zero.

#### DP-018 — Repeated wraparound

- **Block / priority / initial status:** Standalone FIFO / P1 / Pending
- **Source:** [rtl/sync_fifo.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Alternate fill/drain and mixed bursts until each pointer wraps at least four times. Use a sequence number for every accepted write.
- **Expected result:** No duplication, loss or reordering. Counts stay between zero and DEPTH; full and empty cannot both be true.

#### DP-019 — Reset with queued traffic

- **Block / priority / initial status:** Standalone FIFO / P1 / Pending
- **Source:** [rtl/sync_fifo.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Prefill, assert rst during traffic, then hold enables low through reset. Discard the software reference queue; release reset and write fresh values.
- **Expected result:** Old queued values are discarded logically. The first fresh drain returns only post-reset accepted writes. rd_data holds the last accepted read while no read is accepted, and resets to zero.

#### DP-020 — Random bursts with a reference queue

- **Block / priority / initial status:** Standalone FIFO / P2 / Pending
- **Source:** [rtl/sync_fifo.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Run 1000 or more edges for each of three recorded seeds. Bias requests toward empty/full and one-away states. Queue only writes accepted by pre-edge flags and dequeue only accepted reads.
- **Expected result:** Every accepted read matches the oldest reference word. End by draining and proving the reference queue empty. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### DP-021 — Reset and first usable cycle

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo_ram.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Hold wr_en=rd_en=0. Assert rst=1, clock the design, then release reset away from the active edge.
- **Expected result:** After the specified reset event: empty=1 and full=0; pointers/count are reset. rd_data is driven by an always-reading synchronous RAM, so it may change even when rd_en=0 or empty=1. Do not require output hold or reset-to-zero.

#### DP-022 — Single write then single read

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo_ram.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Write A5 with wr_en=1 while full=0; disable write; request one read with rd_en=1 while empty=0.
- **Expected result:** empty clears after the write and asserts after the read. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer. Exactly one word is transferred.

#### DP-023 — Ordering and mixed data

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo_ram.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Write 10,22,35,48 with gaps, then drain using isolated and consecutive rd_en requests.
- **Expected result:** Read values are 10,22,35,48 in that order. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### DP-024 — Fill to capacity and reject overflow

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo_ram.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** With rd_en=0, issue exactly DEPTH writes (2^AW (default 16)); check one below full and full. Attempt three further writes with distinct data, then drain.
- **Expected result:** full asserts only after the last available slot is used. Extra writes cannot move the write pointer or replace queued data. Draining returns the original DEPTH values.

#### DP-025 — Drain to empty and reject underflow

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo_ram.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Fill and drain exactly DEPTH accepted reads. Keep rd_en=1 for three additional clocks with wr_en=0.
- **Expected result:** empty asserts on the last accepted pop; extra reads do not advance the read pointer or change occupancy. rd_data is driven by an always-reading synchronous RAM, so it may change even when rd_en=0 or empty=1. Do not require output hold or reset-to-zero.

#### DP-026 — Both enables in the middle

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo_ram.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Prefill to half capacity. Keep wr_en=rd_en=1 for at least 2*DEPTH clocks with a changing wr_data.
- **Expected result:** Both operations are accepted on each edge and occupancy stays constant. The stream remains ordered across pointer wraps. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### DP-027 — Both enables when empty

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo_ram.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Reset empty, then assert wr_en=rd_en=1 for one edge with wr_data=3C.
- **Expected result:** Only the write is accepted because the pre-edge empty=1. Occupancy becomes one. No same-edge bypass/pop of 3C is allowed.

#### DP-028 — Both enables when full

- **Block / priority / initial status:** RAM-backed FIFO / P0 / Pending
- **Source:** [rtl/sync_fifo_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo_ram.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Fill to capacity; assert wr_en=rd_en=1 for one edge with a new wr_data.
- **Expected result:** Only the read is accepted because pre-edge full=1; the write is blocked and occupancy becomes DEPTH-1. Resend the new word later if it must be stored.

#### DP-029 — Idle and output validity

- **Block / priority / initial status:** RAM-backed FIFO / P1 / Pending
- **Source:** [rtl/sync_fifo_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo_ram.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Pause both enables at empty, one word, half-full and full. Toggle wr_data while idle.
- **Expected result:** Pointers/count and flags hold. rd_data is driven by an always-reading synchronous RAM, so it may change even when rd_en=0 or empty=1. Do not require output hold or reset-to-zero.

#### DP-030 — Repeated wraparound

- **Block / priority / initial status:** RAM-backed FIFO / P1 / Pending
- **Source:** [rtl/sync_fifo_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo_ram.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Alternate fill/drain and mixed bursts until each pointer wraps at least four times. Use a sequence number for every accepted write.
- **Expected result:** No duplication, loss or reordering. Counts stay between zero and DEPTH; full and empty cannot both be true.

#### DP-031 — Reset with queued traffic

- **Block / priority / initial status:** RAM-backed FIFO / P1 / Pending
- **Source:** [rtl/sync_fifo_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo_ram.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Prefill, assert rst during traffic, then hold enables low through reset. Discard the software reference queue; release reset and write fresh values.
- **Expected result:** Old queued values are discarded logically. The first fresh drain returns only post-reset accepted writes. rd_data is driven by an always-reading synchronous RAM, so it may change even when rd_en=0 or empty=1. Do not require output hold or reset-to-zero.

#### DP-032 — Random bursts with a reference queue

- **Block / priority / initial status:** RAM-backed FIFO / P2 / Pending
- **Source:** [rtl/sync_fifo_ram.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/rtl/sync_fifo_ram.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Run 1000 or more edges for each of three recorded seeds. Bias requests toward empty/full and one-away states. Queue only writes accepted by pre-edge flags and dequeue only accepted reads.
- **Expected result:** Every accepted read matches the oldest reference word. End by draining and proving the reference queue empty. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### DP-033 — Detect reset count not cleared

- **Block / priority / initial status:** Checker negative test / P1 / Pending
- **Source:** [eda_playground/buggy_designs/design_issue1_reset_count_not_cleared.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/eda_playground/buggy_designs/design_issue1_reset_count_not_cleared.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Fill several words, then assert rst mid-stream and verify the empty state before sending fresh data. Compile this fixture in isolation with the existing checker, separately from the good implementation.
- **Expected result:** The checker reports the intended mismatch with a useful cycle/value diagnostic. This negative case is Done only when the injected defect is detected and the same stimulus passes against the good implementation. A broken DUT running without a complaint is a failed checker test.
- **Note:** Intentional fault fixture; never include it alongside the active DUT under the same module name.

#### DP-034 — Detect read while empty

- **Block / priority / initial status:** Checker negative test / P1 / Pending
- **Source:** [eda_playground/buggy_designs/design_issue2_read_while_empty.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/eda_playground/buggy_designs/design_issue2_read_while_empty.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Assert rd_en repeatedly while empty, then write and drain distinct words. Compile this fixture in isolation with the existing checker, separately from the good implementation.
- **Expected result:** The checker reports the intended mismatch with a useful cycle/value diagnostic. This negative case is Done only when the injected defect is detected and the same stimulus passes against the good implementation. A broken DUT running without a complaint is a failed checker test.
- **Note:** Intentional fault fixture; never include it alongside the active DUT under the same module name.

#### DP-035 — Detect full flag early

- **Block / priority / initial status:** Checker negative test / P1 / Pending
- **Source:** [eda_playground/buggy_designs/design_issue3_full_flag_early.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/eda_playground/buggy_designs/design_issue3_full_flag_early.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Write exactly DEPTH distinct words without reading; check full only at capacity. Compile this fixture in isolation with the existing checker, separately from the good implementation.
- **Expected result:** The checker reports the intended mismatch with a useful cycle/value diagnostic. This negative case is Done only when the injected defect is detected and the same stimulus passes against the good implementation. A broken DUT running without a complaint is a failed checker test.
- **Note:** Intentional fault fixture; never include it alongside the active DUT under the same module name.

#### DP-036 — Detect empty flag early

- **Block / priority / initial status:** Checker negative test / P1 / Pending
- **Source:** [eda_playground/buggy_designs/design_issue4_empty_flag_early.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/eda_playground/buggy_designs/design_issue4_empty_flag_early.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Write several words and drain to one remaining entry, then consume that final entry. Compile this fixture in isolation with the existing checker, separately from the good implementation.
- **Expected result:** The checker reports the intended mismatch with a useful cycle/value diagnostic. This negative case is Done only when the injected defect is detected and the same stimulus passes against the good implementation. A broken DUT running without a complaint is a failed checker test.
- **Note:** Intentional fault fixture; never include it alongside the active DUT under the same module name.

#### DP-037 — Detect read pointer stuck

- **Block / priority / initial status:** Checker negative test / P1 / Pending
- **Source:** [eda_playground/buggy_designs/design_issue5_read_pointer_stuck.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/eda_playground/buggy_designs/design_issue5_read_pointer_stuck.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** Write three distinct words and perform three accepted reads; compare their order. Compile this fixture in isolation with the existing checker, separately from the good implementation.
- **Expected result:** The checker reports the intended mismatch with a useful cycle/value diagnostic. This negative case is Done only when the injected defect is detected and the same stimulus passes against the good implementation. A broken DUT running without a complaint is a failed checker test.
- **Note:** Intentional fault fixture; never include it alongside the active DUT under the same module name.

#### DP-038 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [eda_playground/design.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/eda_playground/design.sv)
- **Signals:** clk, we, waddr, raddr, din, dout, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** For sync_ram, sync_fifo, sync_fifo_ram, initialize through its reset/load path, then vary we, waddr, raddr, din before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check dout only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### DP-039 — Compile isolated tops and record reproducible evidence

- **Block / priority / initial status:** Build and evidence / P0 / Pending
- **Source:** [eda_playground/design.sv](https://github.com/kapiltrip/DesignProject/blob/445e9ecfeab646f3c08a43b2e9bdc5fcb89950f4/eda_playground/design.sv)
- **Signals:** Top/module names and port declarations in the RTL map
- **Test idea:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.

### VerilogCodesUpdatedDaily

#### VD-001 — Coordinated reset and idle

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Test idea:** Run both independent clocks, set write_en=read_en=0 and assert write_reset_n=read_reset_n=0. Release each reset away from its local edge.
- **Expected result:** Local pointers reset, full=0, empty=1 and read_data=0 after reset settles. No memory clearing is required.

#### VD-002 — First word crosses to read domain

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Test idea:** Write A5 once on write_clk while full=0; keep read_en=0 and watch empty on successive read_clk edges. Then request one accepted read.
- **Expected result:** empty deasserts only after synchronized write-pointer visibility. read_data=A5 after the accepted read_clk edge. Flags are combinational from current pointers and sync2. Inspect the actual synchronizer wiring before trusting the expected two-stage delay.

#### VD-003 — Fill, overflow, drain and underflow

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Test idea:** With reads stopped, write DEPTH words (DEPTH (default 8)), attempt extra writes, then drain after empty clears. Attempt extra reads.
- **Expected result:** Exactly DEPTH original words return in order. Full writes and empty reads never move local pointers. Final full=0 and empty=1 after clock-domain propagation.

#### VD-004 — Fast writer and slow reader

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Test idea:** Use write/read periods 10 ns/31 ns, unrelated initial phases, and bursts long enough to reach full.
- **Expected result:** Only locally accepted operations enter the reference queue; no loss/reordering. full may conservatively remain high while a read propagates.

#### VD-005 — Slow writer and fast reader

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Test idea:** Use write/read periods 29 ns/8 ns, then reverse the rates; repeatedly touch empty.
- **Expected result:** No stale/unwritten word is consumed. empty can remain high while a remote write propagates.

#### VD-006 — Equal rates with phase shifts

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Test idea:** Use 10 ns/10 ns clocks with offsets 0,2,5 ns. Include coincident edges and continuous traffic at half occupancy.
- **Expected result:** Ordered data with race-free stimulus. Determine each operation from its own pre-edge full/empty; do not order coincident events by testbench process scheduling.

#### VD-007 — Gray pointers and blocked requests

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Test idea:** Observe local binary/Gray pointer pairs through wrap. Hold write_en=1 at full and read_en=1 at empty.
- **Expected result:** Local pointer increments only on accepted operations; Gray equals binary XOR (binary shifted right one). Successive LOCAL Gray values differ in one bit, or zero when holding. Destination samples may skip states and differ in multiple bits.

#### VD-008 — Synchronizer direction and flag latency

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Test idea:** Apply one remote pointer change while the destination clock runs; trace first and second synchronization stages on each destination edge.
- **Expected result:** Stage 1 samples the remote pointer; stage 2 samples previous stage 1. Flags must use stage 2. Flags are combinational from current pointers and sync2. Inspect the actual synchronizer wiring before trusting the expected two-stage delay.

#### VD-009 — Clock stop and restart

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Test idea:** Pause read_clk while writing to full, then resume it; repeat by pausing write_clk during reads.
- **Expected result:** No operation occurs without its local clock; flags converge after the stopped clock resumes. Scoreboard order survives the pause.

#### VD-010 — Many laps and random bursts

- **Block / priority / initial status:** Asynchronous FIFO / P2 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Test idea:** Run at least four complete pointer laps for three recorded seeds and clock ratios. Compare every accepted read with a software reference queue.
- **Expected result:** No duplicates, drops or ordering errors. End with both clocks running and fully drain the reference queue.

#### VD-011 — Both resets during traffic

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Test idea:** Prefill, assert both resets during a burst, flush the expected queue, restart clocks and send a fresh known sequence.
- **Expected result:** Reset discards previous queued data; only new writes are considered valid. No assumptions about clearing memory cells.

#### VD-012 — One-sided reset contract

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Blocked
- **Source:** [async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Test idea:** Consider asserting only write_reset_n, then only read_reset_n, while data is pending. Define whether the whole FIFO is flushed or one domain may continue before executing.
- **Expected result:** Pass criteria require an agreed system reset policy. Current independent pointer resets do not guarantee preservation of unread data after a one-sided reset.
- **Note:** Resolve reset policy first; never mark data preservation proven by ordinary RTL simulation.

#### VD-013 — Parameter and minimum-depth limits

- **Block / priority / initial status:** Asynchronous FIFO / P2 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Test idea:** Elaborate legal data widths 1,8,16 and address widths 2,3,4. Separately try address width 1 and non-power-of-two DEPTH if that parameter exists.
- **Expected result:** Supported configurations retain capacity and ordering. Record unsupported values as a documented constraint: slices such as [AW-2:0] or [ADDR-2:0] need special handling below address width 2.

#### VD-014 — CDC implementation review

- **Block / priority / initial status:** Asynchronous FIFO / P2 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_reset_n, read_reset_n, write_en, read_en, write_data, read_data, full, empty
- **Test idea:** Inspect the synthesized synchronizer paths, reset release, Gray-bus constraints and memory mapping with the target FPGA/ASIC tools.
- **Expected result:** A CDC report and reviewed timing constraints are separate evidence. Functional simulation cannot establish metastability reliability or physical Gray-bus skew.
- **Note:** This is a design-review case, not a Verilog simulation pass.

#### VD-015 — Detect reversed synchronizer assignments

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [async_fifo.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/async_fifo.v)
- **Signals:** write_clk, read_clk, write_ptr_gray, write_ptr_gray_sync1, write_ptr_gray_sync2, read_ptr_gray, read_ptr_gray_sync1, read_ptr_gray_sync2
- **Test idea:** Change one source Gray pointer; inspect the concatenated nonblocking assignment at each destination edge.
- **Expected result:** Required two-stage topology is sync1 <- remote and sync2 <- old sync1. The current concatenations instead feed sync2 directly from remote and sync1 from old sync2. Record this as a CDC structural defect, independently of data-loopback results.
- **Note:** Static source finding; no CDC or simulation run claimed.

#### VD-016 — Up/down wraps and style equivalence

- **Block / priority / initial status:** Counter styles / P0 / Pending
- **Source:** [up_down_counter_behavioral.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/up_down_counter_behavioral.v) (also: `up_down_counter_dataflow.v`, `up_down_counter_structural.v`)
- **Signals:** clk, reset, up, count
- **Test idea:** Reset all three versions together; count up through 15->0 and down through 0->15; change up away from posedge clk.
- **Expected result:** All three count outputs agree after each edge. Arithmetic is modulo 16; active-high reset is asynchronous.

#### VD-017 — Mid-count reset and direction change

- **Block / priority / initial status:** Counter styles / P1 / Pending
- **Source:** [up_down_counter_behavioral.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/up_down_counter_behavioral.v) (also: `up_down_counter_dataflow.v`, `up_down_counter_structural.v`)
- **Signals:** clk, reset, up, count
- **Test idea:** Reset between clock edges after a nonzero count; release and alternate up on successive cycles.
- **Expected result:** count immediately resets to zero and advances by exactly +1 or -1 on each later rising edge.

#### VD-018 — Read timing differs between styles

- **Block / priority / initial status:** Array read styles / P0 / Pending
- **Source:** [array_all.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/array_all.v) (also: `array_db.v`)
- **Signals:** clk, write_data, write_addr, write_en, read_addr, read_data
- **Test idea:** Initialize every location, then change read_addr between edges in array_behavioral, array_behavioral_simple, array_dataflow and array_structural.
- **Expected result:** Behavioral outputs update at posedge clk and are read-first on collisions. Dataflow/structural outputs follow address asynchronously. Compare at each design’s valid time, not cycle-for-cycle blindly.

#### VD-019 — Depth, initialization and write protection

- **Block / priority / initial status:** Array read styles / P1 / Pending
- **Source:** [array_all.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/array_all.v) (also: `array_db.v`)
- **Signals:** clk, write_data, write_addr, write_en, read_addr, read_data
- **Test idea:** Write a walking-one pattern to every legal location, then hold write_en=0 while changing addresses/data. Check a fresh simulation too.
- **Expected result:** Behavioral/dataflow memories have simulation initialization to zero; structural DFF storage has no reset/init and begins unknown. Structural array is fixed at four words, irrespective of other array DEPTH overrides.

#### VD-020 — Complete conversion and adjacency

- **Block / priority / initial status:** Binary to Gray / P0 / Pending
- **Source:** [bin2gray.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/bin2gray.v) (also: `bin2gray_all.v`)
- **Signals:** bin, gray
- **Test idea:** Sweep bin through all 256 values at WIDTH=8; repeat WIDTH=1 and 4. Check conversion using a bitwise truth-table reference.
- **Expected result:** MSB is unchanged; each lower Gray bit is XOR of adjacent binary bits. Consecutive binary values including wrap produce one changed Gray bit. Compile only one definition of bin2gray at a time.

#### VD-021 — Compile isolated tops and record reproducible evidence

- **Block / priority / initial status:** Build and evidence / P0 / Pending
- **Source:** [array_all.v](https://github.com/kapiltrip/VerilogCodesUpdatedDaily/blob/16ce5086bddef41aa977a31440509a0c4219d3c0/array_all.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Test idea:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.

### mips-processor

#### CPU-001 — Every supported operation

- **Block / priority / initial status:** Processor ALU / P0 / Pending
- **Source:** [modellingOftheProcessor/alu.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/alu.v)
- **Signals:** opcode, a, b, result
- **Test idea:** Exercise ADD/ADDI, SUB/SUBI, AND, OR, SLT/SLTI, MUL and address/branch additions with 0,1,all ones,80000000 and 7FFFFFFF.
- **Expected result:** Use an independent 32-bit arithmetic model. Add/subtract/multiply truncate to 32 bits. SLT/SLTI use UNSIGNED comparison in this RTL; 80000000 is greater than 7FFFFFFF.

#### CPU-002 — Unsupported opcode

- **Block / priority / initial status:** Processor ALU / P1 / Pending
- **Source:** [modellingOftheProcessor/alu.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/alu.v)
- **Signals:** opcode, a, b, result
- **Test idea:** Sweep all 64 opcodes, including values absent from the ALU case table.
- **Expected result:** Unimplemented opcodes deliberately produce X. The controller maps unsupported opcodes to HALT; do not silently label unknown ALU results zero.

#### CPU-003 — Complete opcode classification

- **Block / priority / initial status:** Processor decode / P0 / Pending
- **Source:** [modellingOftheProcessor/control_unit.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/control_unit.v)
- **Signals:** opcode, instr_type
- **Test idea:** Sweep all 64 opcode values and compare against the supported instruction list.
- **Expected result:** 0..5 -> RR_ALU=0; 10..12 -> RM_ALU=1; 13 -> LOAD=2; 14 -> STORE=3; 15..16 -> BRANCH=4; 63 and all unsupported values -> HALT=5.

#### CPU-004 — Both read ports and write enable

- **Block / priority / initial status:** Register file / P0 / Pending
- **Source:** [modellingOftheProcessor/regfile.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/regfile.v)
- **Signals:** clock, we, ra1, ra2, wa, wd, rd1, rd2
- **Test idea:** Write distinct values into registers 1..31 on rising clock; independently sweep ra1 and ra2. Repeat updates with we=0.
- **Expected result:** Both read ports are combinational and return the addressed last written value. we=0 leaves all registers unchanged.

#### CPU-005 — Zero register and read/write collision

- **Block / priority / initial status:** Register file / P1 / Pending
- **Source:** [modellingOftheProcessor/regfile.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/regfile.v)
- **Signals:** clock, we, ra1, ra2, wa, wd, rd1, rd2
- **Test idea:** Attempt to write wa=0 with nonzero wd. Also read a nonzero register while writing the same address at the clock edge.
- **Expected result:** Register zero always reads 0 and ignores writes. A nonzero same-address read changes to the new stored value after the write NBA; it is not an extra-cycle registered read.

#### CPU-006 — Word addressing and independent reads

- **Block / priority / initial status:** Processor memory / P0 / Pending
- **Source:** [modellingOftheProcessor/memory_interface.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/memory_interface.v)
- **Signals:** clock, instr_addr, instr_out, data_addr, data_in, data_out, data_we
- **Test idea:** Write addresses 0,1,1023, then vary instruction/data addresses independently; compare against 1024-word reference memory.
- **Expected result:** Addresses index WORDS directly. No implicit division by four occurs. Reads are combinational; writes occur on posedge clock when data_we=1.

#### CPU-007 — Out-of-range address policy

- **Block / priority / initial status:** Processor memory / P1 / Pending
- **Source:** [modellingOftheProcessor/memory_interface.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/memory_interface.v)
- **Signals:** instr_addr, instr_out, data_addr, data_out
- **Test idea:** Try 1024 and a high 32-bit address in a separate negative run.
- **Expected result:** The array has no address bounds response. Record X/warnings rather than inventing a bus-error output or wrapping addresses. An address restriction is needed for legal programs.

#### CPU-008 — Existing arithmetic and memory programs

- **Block / priority / initial status:** Processor integration / P0 / Pending
- **Source:** [modellingOftheProcessor/mips.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/mips.v)
- **Signals:** clock1, clock2, PC, halted, rf_we, mem_we
- **Test idea:** Run the existing add-three-numbers, factorial and memory-word benches separately with their instruction images. Keep the two clocks non-overlapping as those benches do.
- **Expected result:** Compare final architectural register/memory values to an independent program calculation, not just printed messages. Record the exact instruction image, clock phases and cycle limit.

#### CPU-009 — Branch taken and not taken

- **Block / priority / initial status:** Processor integration / P0 / Pending
- **Source:** [modellingOftheProcessor/mips.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/mips.v)
- **Signals:** clock1, clock2, PC, taken_branch, EX_MEM_cond, rf_we, mem_we
- **Test idea:** Exercise BEQZ and BNEQZ with zero and nonzero operands, positive/negative offsets and a store/writeback behind a taken branch.
- **Expected result:** Correct target instruction is fetched; side effects suppressed by taken_branch do not update architectural state. Check branch target in word units and sign-extended immediate.

#### CPU-010 — Data dependency and pipeline limits

- **Block / priority / initial status:** Processor integration / P1 / Pending
- **Source:** [modellingOftheProcessor/mips.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/mips.v)
- **Signals:** clock1, clock2, ID_EX_A, ID_EX_B, MEM_WB_ALUOut, rf_we
- **Test idea:** Compare dependent instruction pairs with zero, one and enough separating no-ops, including load-use and branch-use.
- **Expected result:** There is no explicit hazard/forwarding unit. Use a sequential reference to reveal unsupported schedules; document required software spacing rather than assuming automatic stalls.

#### CPU-011 — Halt and persistent state

- **Block / priority / initial status:** Processor integration / P1 / Pending
- **Source:** [modellingOftheProcessor/mips.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/mips.v)
- **Signals:** clock1, clock2, halted, PC, mem_we, rf_we
- **Test idea:** Execute HLT after arithmetic, branch and memory operations. Continue both clocks for at least ten cycles.
- **Expected result:** PC and pipeline stop after halt; no extra memory side effects occur. Inspect repeated writeback control as well as data. No reset port exists; each independent program needs a fresh initialized simulation.

#### CPU-012 — Compile isolated tops and record reproducible evidence

- **Block / priority / initial status:** Build and evidence / P0 / Pending
- **Source:** [modellingOftheProcessor/alu.v](https://github.com/kapiltrip/mips-processor/blob/a6f8a8843b90f68ce59dfabafdfd47f6e3331f8a/modellingOftheProcessor/alu.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Test idea:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.

### VerificationLab

#### LAB-001 — March sequence with clocked read

- **Block / priority / initial status:** March memory / P0 / Pending
- **Source:** [simplified/exp8_march_mem16x8/code/mem16x8.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/simplified/exp8_march_mem16x8/code/mem16x8.sv)
- **Signals:** clk, we, addr, din, dout
- **Test idea:** Initialize all 16 addresses to 00. In ascending order read 00 then write FF; read FF then write 00. Repeat those two read/write phases descending, then read 00 everywhere.
- **Expected result:** Check each read after a posedge with we=0. Write cycles do not update dout. All addresses and both 0->1 and 1->0 transitions are checked; store mismatch address and phase.

#### LAB-002 — Truth table and detecting vectors

- **Block / priority / initial status:** PLA fault / P0 / Pending
- **Source:** [simplified/exp9_pla_p2_b7_growth_fault/code/pla_p2_b7.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/simplified/exp9_pla_p2_b7_growth_fault/code/pla_p2_b7.sv)
- **Signals:** x1, x2, x3, x4, f1
- **Test idea:** Compare pla_good and pla_faulty over all 16 input combinations.
- **Expected result:** For f1, exactly 1010 and 1110 detect the missing p2-b7 literal; other inputs match. Separately verify the good truth table so equivalence alone cannot hide a shared mistake.

#### LAB-003 — Fault-free arithmetic and stuck-at matrix

- **Block / priority / initial status:** Fault injection / P0 / Pending
- **Source:** [simplified/exp2_full_adder_fault/code/full_adder_fault.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/simplified/exp2_full_adder_fault/code/full_adder_fault.sv)
- **Signals:** a, b, cin, fault_en, fault_node, stuck_val, sum, cout
- **Test idea:** First sweep all eight patterns with fault_en=0. Then repeat for each fault_node 0..4 and stuck_val 0/1; record which patterns detect each fault.
- **Expected result:** Fault-free {cout,sum}=a+b+cin. Detection means a mismatch versus the independently calculated good output for that same vector. Nodes 5..7 are unmapped in this version; do not count them as additional modeled faults.

#### LAB-004 — Compare complete detection sets

- **Block / priority / initial status:** Fault equivalence / P1 / Pending
- **Source:** [simplified/exp3_xor_fault_equiv/code/xor_fault_equiv.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/simplified/exp3_xor_fault_equiv/code/xor_fault_equiv.sv)
- **Signals:** a, b, fault_en, fault_id, stuck_val, y
- **Test idea:** Run all four inputs for the good XOR and for each fault_id 0..3 with both stuck values; build an eight-column detection matrix.
- **Expected result:** Good y=a XOR b. Claim equivalence only when full output behavior/detection sets agree across the entire input space, not from one common detecting vector.

#### LAB-005 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [exp1/exp1_mux4to1.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp1/exp1_mux4to1.sv)
- **Signals:** d, sel, y
- **Test idea:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.

#### LAB-006 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [exp2/exp2_full_adder.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp2/exp2_full_adder.sv)
- **Signals:** a, b, cin, sum, cout
- **Test idea:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum, cout bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different. 

#### LAB-007 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [exp2/exp2_full_adder_fault_inject.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp2/exp2_full_adder_fault_inject.sv)
- **Signals:** a, b, cin, fault_en, fault_node, fault_stuck_val, sum, cout
- **Test idea:** Exercise a, b, cin, fault_en, fault_node, fault_stuck_val at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum, cout bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different. 

#### LAB-008 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [exp2/exp2_simple_exam_version.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp2/exp2_simple_exam_version.sv)
- **Signals:** a, b, cin, sum, cout, fault_en, fault_node, stuck_val
- **Test idea:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum, cout bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different. 

#### LAB-009 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [exp3/exp3_simple_exam_version.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp3/exp3_simple_exam_version.sv)
- **Signals:** a, b, fault_en, fault_id, stuck_val, y
- **Test idea:** Drive a, b, fault_en, fault_id, stuck_val through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### LAB-010 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [exp3/exp3_xor_fault_equiv.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp3/exp3_xor_fault_equiv.sv)
- **Signals:** a, b, fault_en, fault_id, fault_stuck_val, y
- **Test idea:** Drive a, b, fault_en, fault_id, fault_stuck_val through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### LAB-011 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [exp4/exp4_cla4.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp4/exp4_cla4.sv)
- **Signals:** a, b, cin, sum, cout
- **Test idea:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum, cout bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: sum[0] = p[0] ^ cin; sum[1] = p[1] ^ c1; sum[2] = p[2] ^ c2; sum[3] = p[3] ^ c3; cout = c4.

#### LAB-012 — 1001 matches, overlaps and near misses

- **Block / priority / initial status:** Sequence detector / P1 / Pending
- **Source:** [exp5/exp5_seq_det_1001_nonoverlap.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp5/exp5_seq_det_1001_nonoverlap.sv)
- **Signals:** clk, rst_n, din, dout
- **Test idea:** Drive 1001, near misses, repeated matches and an overlapping stream (1001001), one bit per clock using clk, rst_n, din. Reset midway through a prefix.
- **Expected result:** Check dout at each match ending. Overlap variants retain a matching suffix; nonoverlap variants discard it. Use the actual combinational/registered output timing in each module, not the name Mealy/Moore alone.

#### LAB-013 — 1001 matches, overlaps and near misses

- **Block / priority / initial status:** Sequence detector / P1 / Pending
- **Source:** [exp5/exp5_seq_det_1001_overlap.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp5/exp5_seq_det_1001_overlap.sv)
- **Signals:** clk, rst_n, din, dout
- **Test idea:** Drive 1001, near misses, repeated matches and an overlapping stream (1001001), one bit per clock using clk, rst_n, din. Reset midway through a prefix.
- **Expected result:** Check dout at each match ending. Overlap variants retain a matching suffix; nonoverlap variants discard it. Use the actual combinational/registered output timing in each module, not the name Mealy/Moore alone.

#### LAB-014 — 1001 matches, overlaps and near misses

- **Block / priority / initial status:** Sequence detector / P1 / Pending
- **Source:** [exp6/exp6_seq_det_1001_nonoverlap.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp6/exp6_seq_det_1001_nonoverlap.sv)
- **Signals:** clk, rst_n, din, dout
- **Test idea:** Drive 1001, near misses, repeated matches and an overlapping stream (1001001), one bit per clock using clk, rst_n, din. Reset midway through a prefix.
- **Expected result:** Check dout at each match ending. Overlap variants retain a matching suffix; nonoverlap variants discard it. Use the actual combinational/registered output timing in each module, not the name Mealy/Moore alone.

#### LAB-015 — 1001 matches, overlaps and near misses

- **Block / priority / initial status:** Sequence detector / P1 / Pending
- **Source:** [exp6/exp6_seq_det_1001_overlap.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp6/exp6_seq_det_1001_overlap.sv)
- **Signals:** clk, rst_n, din, dout
- **Test idea:** Drive 1001, near misses, repeated matches and an overlapping stream (1001001), one bit per clock using clk, rst_n, din. Reset midway through a prefix.
- **Expected result:** Check dout at each match ending. Overlap variants retain a matching suffix; nonoverlap variants discard it. Use the actual combinational/registered output timing in each module, not the name Mealy/Moore alone.

#### LAB-016 — Seed, recurrence and repeat period

- **Block / priority / initial status:** LFSR / P1 / Pending
- **Source:** [exp7/exp7_lfsr_parta_many_to_one.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp7/exp7_lfsr_parta_many_to_one.sv)
- **Signals:** clk, rst_n, en, q
- **Test idea:** Reset/load the documented nonzero seed; record q for a complete small-width sequence and repeat after reset. Also test enable holds if present and the zero-seed behavior.
- **Expected result:** The sequence follows the declared tap polynomial and shift direction. A claimed maximal n-bit LFSR visits 2^n-1 distinct nonzero states before repeating; measure the actual period rather than assuming it. Fibonacci and Galois forms need not be bit-for-bit identical.

#### LAB-017 — Seed, recurrence and repeat period

- **Block / priority / initial status:** LFSR / P1 / Pending
- **Source:** [exp7/exp7_lfsr_partb_one_to_many.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp7/exp7_lfsr_partb_one_to_many.sv)
- **Signals:** clk, rst_n, en, q
- **Test idea:** Reset/load the documented nonzero seed; record q for a complete small-width sequence and repeat after reset. Also test enable holds if present and the zero-seed behavior.
- **Expected result:** The sequence follows the declared tap polynomial and shift direction. A claimed maximal n-bit LFSR visits 2^n-1 distinct nonzero states before repeating; measure the actual period rather than assuming it. Fibonacci and Galois forms need not be bit-for-bit identical.

#### LAB-018 — Seed, recurrence and repeat period

- **Block / priority / initial status:** LFSR / P1 / Pending
- **Source:** [exp7/exp7_simple_exam_version.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp7/exp7_simple_exam_version.sv)
- **Signals:** clk, rst, q
- **Test idea:** Reset/load the documented nonzero seed; record q for a complete small-width sequence and repeat after reset. Also test enable holds if present and the zero-seed behavior.
- **Expected result:** The sequence follows the declared tap polynomial and shift direction. A claimed maximal n-bit LFSR visits 2^n-1 distinct nonzero states before repeating; measure the actual period rather than assuming it. Fibonacci and Galois forms need not be bit-for-bit identical.

#### LAB-019 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [exp9/exp9_cut_logic.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp9/exp9_cut_logic.sv)
- **Signals:** x, y
- **Test idea:** Drive x through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: y[0] = (x[0] & x[1]) | x[2]; y[1] = (x[1] ^ x[2]) & x[3].

#### LAB-020 — Seed, recurrence and repeat period

- **Block / priority / initial status:** LFSR / P1 / Pending
- **Source:** [exp9/exp9_lfsr4.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp9/exp9_lfsr4.sv)
- **Signals:** clk, rst_n, en, q
- **Test idea:** Reset/load the documented nonzero seed; record q for a complete small-width sequence and repeat after reset. Also test enable holds if present and the zero-seed behavior.
- **Expected result:** The sequence follows the declared tap polynomial and shift direction. A claimed maximal n-bit LFSR visits 2^n-1 distinct nonzero states before repeating; measure the actual period rather than assuming it. Fibonacci and Galois forms need not be bit-for-bit identical.

#### LAB-021 — Seed, recurrence and repeat period

- **Block / priority / initial status:** LFSR / P1 / Pending
- **Source:** [exp9/exp9_lfsr8.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp9/exp9_lfsr8.sv)
- **Signals:** clk, rst_n, en, q
- **Test idea:** Reset/load the documented nonzero seed; record q for a complete small-width sequence and repeat after reset. Also test enable holds if present and the zero-seed behavior.
- **Expected result:** The sequence follows the declared tap polynomial and shift direction. A claimed maximal n-bit LFSR visits 2^n-1 distinct nonzero states before repeating; measure the actual period rather than assuming it. Fibonacci and Galois forms need not be bit-for-bit identical.

#### LAB-022 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [q1_mux4/mux4to1.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/q1_mux4/mux4to1.sv)
- **Signals:** d, sel, y
- **Test idea:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.

#### LAB-023 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [q2_full_adder/full_adder.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/q2_full_adder/full_adder.sv)
- **Signals:** a, b, cin, sum, cout
- **Test idea:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum, cout bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different. 

#### LAB-024 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [q3_cla4/cla4.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/q3_cla4/cla4.sv)
- **Signals:** a, b, cin, sum, cout
- **Test idea:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum, cout bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: sum[0] = p[0] ^ cin; sum[1] = p[1] ^ c1; sum[2] = p[2] ^ c2; sum[3] = p[3] ^ c3; cout = c4.

#### LAB-025 — 1001 matches, overlaps and near misses

- **Block / priority / initial status:** Sequence detector / P1 / Pending
- **Source:** [q5_sequence_detector/seq_det_1001_mealy_overlap.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/q5_sequence_detector/seq_det_1001_mealy_overlap.sv)
- **Signals:** clk, rst_n, din, dout
- **Test idea:** Drive 1001, near misses, repeated matches and an overlapping stream (1001001), one bit per clock using clk, rst_n, din. Reset midway through a prefix.
- **Expected result:** Check dout at each match ending. Overlap variants retain a matching suffix; nonoverlap variants discard it. Use the actual combinational/registered output timing in each module, not the name Mealy/Moore alone.

#### LAB-026 — 1001 matches, overlaps and near misses

- **Block / priority / initial status:** Sequence detector / P1 / Pending
- **Source:** [q5_sequence_detector/seq_det_1001_moore_overlap.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/q5_sequence_detector/seq_det_1001_moore_overlap.sv)
- **Signals:** clk, rst_n, din, dout
- **Test idea:** Drive 1001, near misses, repeated matches and an overlapping stream (1001001), one bit per clock using clk, rst_n, din. Reset midway through a prefix.
- **Expected result:** Check dout at each match ending. Overlap variants retain a matching suffix; nonoverlap variants discard it. Use the actual combinational/registered output timing in each module, not the name Mealy/Moore alone.

#### LAB-027 — Seed, recurrence and repeat period

- **Block / priority / initial status:** LFSR / P1 / Pending
- **Source:** [q9_lfsr_fault_coverage/cut_logic.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/q9_lfsr_fault_coverage/cut_logic.sv)
- **Signals:** x, y
- **Test idea:** Reset/load the documented nonzero seed; record y for a complete small-width sequence and repeat after reset. Also test enable holds if present and the zero-seed behavior.
- **Expected result:** The sequence follows the declared tap polynomial and shift direction. A claimed maximal n-bit LFSR visits 2^n-1 distinct nonzero states before repeating; measure the actual period rather than assuming it. Fibonacci and Galois forms need not be bit-for-bit identical. Source mapping: y[0] = (x[0] & x[1]) | x[2]; y[1] = (x[1] ^ x[2]) & x[3].

#### LAB-028 — Seed, recurrence and repeat period

- **Block / priority / initial status:** LFSR / P1 / Pending
- **Source:** [q9_lfsr_fault_coverage/lfsr4.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/q9_lfsr_fault_coverage/lfsr4.sv)
- **Signals:** clk, rst_n, en, q
- **Test idea:** Reset/load the documented nonzero seed; record q for a complete small-width sequence and repeat after reset. Also test enable holds if present and the zero-seed behavior.
- **Expected result:** The sequence follows the declared tap polynomial and shift direction. A claimed maximal n-bit LFSR visits 2^n-1 distinct nonzero states before repeating; measure the actual period rather than assuming it. Fibonacci and Galois forms need not be bit-for-bit identical.

#### LAB-029 — Seed, recurrence and repeat period

- **Block / priority / initial status:** LFSR / P1 / Pending
- **Source:** [q9_lfsr_fault_coverage/lfsr8.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/q9_lfsr_fault_coverage/lfsr8.sv)
- **Signals:** clk, rst_n, en, q
- **Test idea:** Reset/load the documented nonzero seed; record q for a complete small-width sequence and repeat after reset. Also test enable holds if present and the zero-seed behavior.
- **Expected result:** The sequence follows the declared tap polynomial and shift direction. A claimed maximal n-bit LFSR visits 2^n-1 distinct nonzero states before repeating; measure the actual period rather than assuming it. Fibonacci and Galois forms need not be bit-for-bit identical.

#### LAB-030 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [simplified/exp1_mux4to1/code/mux4to1.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/simplified/exp1_mux4to1/code/mux4to1.sv)
- **Signals:** d, sel, y
- **Test idea:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings. Source mapping: y = d[sel].

#### LAB-031 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [simplified/exp4_cla4/code/cla4.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/simplified/exp4_cla4/code/cla4.sv)
- **Signals:** a, b, cin, sum, cout
- **Test idea:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum, cout bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: sum = p ^ {c3, c2, c1, cin}; cout = c4.

#### LAB-032 — 1001 matches, overlaps and near misses

- **Block / priority / initial status:** Sequence detector / P1 / Pending
- **Source:** [simplified/exp5_seq_detector_mealy/code/seq_det_1001_mealy.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/simplified/exp5_seq_detector_mealy/code/seq_det_1001_mealy.sv)
- **Signals:** clk, rst, din, dout
- **Test idea:** Drive 1001, near misses, repeated matches and an overlapping stream (1001001), one bit per clock using clk, rst, din. Reset midway through a prefix.
- **Expected result:** Check dout at each match ending. Overlap variants retain a matching suffix; nonoverlap variants discard it. Use the actual combinational/registered output timing in each module, not the name Mealy/Moore alone.

#### LAB-033 — 1001 matches, overlaps and near misses

- **Block / priority / initial status:** Sequence detector / P1 / Pending
- **Source:** [simplified/exp6_seq_detector_moore/code/seq_det_1001_moore.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/simplified/exp6_seq_detector_moore/code/seq_det_1001_moore.sv)
- **Signals:** clk, rst, din, dout
- **Test idea:** Drive 1001, near misses, repeated matches and an overlapping stream (1001001), one bit per clock using clk, rst, din. Reset midway through a prefix.
- **Expected result:** Check dout at each match ending. Overlap variants retain a matching suffix; nonoverlap variants discard it. Use the actual combinational/registered output timing in each module, not the name Mealy/Moore alone. Source mapping: dout = (state == S4); dout = (state == S4).

#### LAB-034 — Seed, recurrence and repeat period

- **Block / priority / initial status:** LFSR / P1 / Pending
- **Source:** [simplified/exp7_lfsr/code/lfsr_fibonacci.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/simplified/exp7_lfsr/code/lfsr_fibonacci.sv)
- **Signals:** clk, rst, q
- **Test idea:** Reset/load the documented nonzero seed; record q for a complete small-width sequence and repeat after reset. Also test enable holds if present and the zero-seed behavior.
- **Expected result:** The sequence follows the declared tap polynomial and shift direction. A claimed maximal n-bit LFSR visits 2^n-1 distinct nonzero states before repeating; measure the actual period rather than assuming it. Fibonacci and Galois forms need not be bit-for-bit identical.

#### LAB-035 — Seed, recurrence and repeat period

- **Block / priority / initial status:** LFSR / P1 / Pending
- **Source:** [simplified/exp7_lfsr/code/lfsr_galois.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/simplified/exp7_lfsr/code/lfsr_galois.sv)
- **Signals:** clk, rst, q
- **Test idea:** Reset/load the documented nonzero seed; record q for a complete small-width sequence and repeat after reset. Also test enable holds if present and the zero-seed behavior.
- **Expected result:** The sequence follows the declared tap polynomial and shift direction. A claimed maximal n-bit LFSR visits 2^n-1 distinct nonzero states before repeating; measure the actual period rather than assuming it. Fibonacci and Galois forms need not be bit-for-bit identical.

#### LAB-036 — Compile isolated tops and record reproducible evidence

- **Block / priority / initial status:** Build and evidence / P0 / Pending
- **Source:** [exp1/exp1_mux4to1.sv](https://github.com/kapiltrip/VerificationLab/blob/0c649a2cbbeef29a88717dda465b6cf958a1bc15/exp1/exp1_mux4to1.sv)
- **Signals:** Top/module names and port declarations in the RTL map
- **Test idea:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.

### PlacementPrep

#### PP-001 — Load, enabled cycles and final carry

- **Block / priority / initial status:** Serial adder / P0 / Pending
- **Source:** [src/combinational/arithmetic/serial_adder.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/arithmetic/serial_adder.v)
- **Signals:** clk, rst_n, load, enable, a_in, b_in, sum_out, carry_out, done
- **Test idea:** Load 15+1 at WIDTH=4; insert enable gaps and change input operands after load. Repeat with load asserted mid-operation.
- **Expected result:** After four enabled compute edges, {carry_out,sum_out}=16 and done=1; pauses do not consume bits. Load clears progress and takes priority over enable.

#### PP-002 — Generated parity and single-bit corruption

- **Block / priority / initial status:** Parity pair / P0 / Pending
- **Source:** [src/combinational/parity/parity_generator.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/parity/parity_generator.v) (also: `src/combinational/parity/parity_checker.v`)
- **Signals:** data_in, parity_bit, error
- **Test idea:** Connect generator output to checker for ODD=0 and ODD=1. Sweep data, then flip one data bit or parity bit.
- **Expected result:** Intended error=0 for a valid codeword and 1 after a single-bit flip. Current checker returns the inverse of that meaning relative to the generator; this should be caught before reusing the pair.
- **Note:** Static source finding; confirm whether error was intended to mean valid.

#### PP-003 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/additions/gate/and2_g.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/additions/gate/and2_g.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### PP-004 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [src/additions/gate/mux2_g.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/additions/gate/mux2_g.v)
- **Signals:** a, b, sel, y
- **Test idea:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.

#### PP-005 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/additions/gate/not1_g.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/additions/gate/not1_g.v)
- **Signals:** a, y
- **Test idea:** Drive a through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### PP-006 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/additions/gate/or2_g.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/additions/gate/or2_g.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### PP-007 — Drive, release and contention

- **Block / priority / initial status:** Tri-state bus / P1 / Pending
- **Source:** [src/additions/gate/tri_buf_g.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/additions/gate/tri_buf_g.v)
- **Signals:** en, a, y
- **Test idea:** Exercise en, a, y; allow one external driver at a time, test each direction/enable, then release both. Isolate a conflicting-drive negative run.
- **Expected result:** Enabled path forwards the source, disabled path is high impedance, and conflicting equal-strength binary drives resolve to X. Do not replace four-state checks with two-state equality.

#### PP-008 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/additions/gate/xnor2_from_nand_g.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/additions/gate/xnor2_from_nand_g.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### PP-009 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/additions/gate/xnor2_from_nor_g.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/additions/gate/xnor2_from_nor_g.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### PP-010 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/additions/gate/xnor2_g.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/additions/gate/xnor2_g.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### PP-011 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/additions/gate/xor2_from_nand_g.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/additions/gate/xor2_from_nand_g.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### PP-012 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/additions/gate/xor2_from_nor_g.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/additions/gate/xor2_from_nor_g.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### PP-013 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/additions/gate/xor2_g.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/additions/gate/xor2_g.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### PP-014 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/behavioral/and2_b.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/behavioral/and2_b.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### PP-015 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [src/behavioral/mux2_b.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/behavioral/mux2_b.v)
- **Signals:** a, b, sel, y
- **Test idea:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.

#### PP-016 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/behavioral/not1_b.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/behavioral/not1_b.v)
- **Signals:** a, y
- **Test idea:** Drive a through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### PP-017 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/behavioral/or2_b.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/behavioral/or2_b.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### PP-018 — Drive, release and contention

- **Block / priority / initial status:** Tri-state bus / P1 / Pending
- **Source:** [src/behavioral/tri_buf_b.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/behavioral/tri_buf_b.v)
- **Signals:** en, a, y
- **Test idea:** Exercise en, a, y; allow one external driver at a time, test each direction/enable, then release both. Isolate a conflicting-drive negative run.
- **Expected result:** Enabled path forwards the source, disabled path is high impedance, and conflicting equal-strength binary drives resolve to X. Do not replace four-state checks with two-state equality.

#### PP-019 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/behavioral/xnor2_b.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/behavioral/xnor2_b.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### PP-020 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/behavioral/xor2_b.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/behavioral/xor2_b.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### PP-021 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [src/combinational/arithmetic/carry_lookahead_adder4.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/arithmetic/carry_lookahead_adder4.v)
- **Signals:** a, b, cin, sum, cout, carry
- **Test idea:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum, cout, carry bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: carry[0] = cin; carry[1] = g[0] | (p[0] & carry[0]); carry[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & carry[0]); carry[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & carry[0]); cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & carry[0]); sum = p ^ carry.

#### PP-022 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [src/combinational/arithmetic/full_adder.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/arithmetic/full_adder.v)
- **Signals:** a, b, cin, sum, cout, propagate, generate
- **Test idea:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum, cout, propagate, generate bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: propagate = a ^ b; generate = a & b; sum = propagate ^ cin; cout = generate | (propagate & cin).

#### PP-023 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [src/combinational/arithmetic/full_adder_from_half.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/arithmetic/full_adder_from_half.v)
- **Signals:** a, b, cin, sum, cout
- **Test idea:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum, cout bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: cout = c1 | c2.

#### PP-024 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [src/combinational/arithmetic/full_subtractor.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/arithmetic/full_subtractor.v)
- **Signals:** a, b, bin, diff, bout
- **Test idea:** Exercise a, b, bin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every diff, bout bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: diff = a ^ b ^ bin; bout = (~a & b) | ((~a ^ b) & bin).

#### PP-025 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [src/combinational/arithmetic/full_subtractor_from_half.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/arithmetic/full_subtractor_from_half.v)
- **Signals:** a, b, bin, diff, bout
- **Test idea:** Exercise a, b, bin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every diff, bout bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: bout = b1 | b2.

#### PP-026 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [src/combinational/arithmetic/half_adder.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/arithmetic/half_adder.v)
- **Signals:** a, b, sum, carry
- **Test idea:** Exercise a, b at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum, carry bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: sum = a ^ b; carry = a & b.

#### PP-027 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [src/combinational/arithmetic/half_subtractor.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/arithmetic/half_subtractor.v)
- **Signals:** a, b, diff, borrow
- **Test idea:** Exercise a, b at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every diff, borrow bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: diff = a ^ b; borrow = (~a) & b.

#### PP-028 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [src/combinational/arithmetic/ripple_carry_adder.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/arithmetic/ripple_carry_adder.v)
- **Signals:** a, b, cin, sum, cout
- **Test idea:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum, cout bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: cout = carry[WIDTH].

#### PP-029 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [src/combinational/arithmetic/twos_complement_add_sub.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/arithmetic/twos_complement_add_sub.v)
- **Signals:** a, b, mode, result, cout
- **Test idea:** Exercise a, b, mode at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every result, cout bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different. 

#### PP-030 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/combinational/comparators/magnitude_comparator.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/comparators/magnitude_comparator.v)
- **Signals:** a, b, a_gt_b, a_eq_b, a_lt_b
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check a_gt_b, a_eq_b, a_lt_b against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: a_gt_b = (a > b); a_eq_b = (a == b); a_lt_b = (a < b).

#### PP-031 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/combinational/detectors/invalid_bcd_detector.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/detectors/invalid_bcd_detector.v)
- **Signals:** bcd, invalid
- **Test idea:** Drive bcd through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check invalid against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: invalid = (b3 & b2) | (b3 & b1) | (b2 & b1).

#### PP-032 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/combinational/detectors/majority_detector_3.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/detectors/majority_detector_3.v)
- **Signals:** a, b, c, majority
- **Test idea:** Drive a, b, c through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check majority against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: majority = (a & b) | (a & c) | (b & c).

#### PP-033 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/combinational/detectors/minority_detector_3.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/detectors/minority_detector_3.v)
- **Signals:** a, b, c, minority
- **Test idea:** Drive a, b, c through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check minority against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: minority = (~a & ~b) | (~a & ~c) | (~b & ~c).

#### PP-034 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/combinational/encoders/bcd_to_excess3.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/encoders/bcd_to_excess3.v)
- **Signals:** bcd, excess3
- **Test idea:** Drive bcd through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check excess3 against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### PP-035 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/combinational/encoders/binary_to_bcd_digit.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/encoders/binary_to_bcd_digit.v)
- **Signals:** binary_in, bcd_out, d4, invalid
- **Test idea:** Drive binary_in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check bcd_out, d4, invalid against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: invalid = d4.

#### PP-036 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/combinational/logic/xor_from_nand.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/logic/xor_from_nand.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: y = ~(n2 & n3).

#### PP-037 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/combinational/misc/automobile_alarm.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/combinational/misc/automobile_alarm.v)
- **Signals:** door_open, ignition_on, headlight_on, alarm_n
- **Test idea:** Drive door_open, ignition_on, headlight_on through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check alarm_n against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: alarm_n = ~ (hazard_light | hazard_door).

#### PP-038 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/dataflow/and2_d.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/dataflow/and2_d.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: y = a & b.

#### PP-039 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [src/dataflow/mux2_d.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/dataflow/mux2_d.v)
- **Signals:** a, b, sel, y
- **Test idea:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings. Source mapping: y = sel ? b : a.

#### PP-040 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/dataflow/not1_d.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/dataflow/not1_d.v)
- **Signals:** a, y
- **Test idea:** Drive a through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: y = ~a.

#### PP-041 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/dataflow/or2_d.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/dataflow/or2_d.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: y = a | b.

#### PP-042 — Drive, release and contention

- **Block / priority / initial status:** Tri-state bus / P1 / Pending
- **Source:** [src/dataflow/tri_buf_d.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/dataflow/tri_buf_d.v)
- **Signals:** en, a, y
- **Test idea:** Exercise en, a, y; allow one external driver at a time, test each direction/enable, then release both. Isolate a conflicting-drive negative run.
- **Expected result:** Enabled path forwards the source, disabled path is high impedance, and conflicting equal-strength binary drives resolve to X. Do not replace four-state checks with two-state equality. Source mapping: y = en ? a : 1'bz.

#### PP-043 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/dataflow/xnor2_d.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/dataflow/xnor2_d.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: y = ~(a ^ b).

#### PP-044 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/dataflow/xnor_n_d.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/dataflow/xnor_n_d.v)
- **Signals:** a, y
- **Test idea:** Drive a through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: y = ~^a.

#### PP-045 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/dataflow/xor2_d.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/dataflow/xor2_d.v)
- **Signals:** a, b, y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: y = a ^ b.

#### PP-046 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [src/dataflow/xor_n_d.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/dataflow/xor_n_d.v)
- **Signals:** a, y
- **Test idea:** Drive a through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: y = ^a.

#### PP-047 — Compile and compare draft contract

- **Block / priority / initial status:** Practice draft / P2 / Pending
- **Source:** [todo.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/todo.v)
- **Signals:** a, b, y, sel, en, enable
- **Test idea:** Compile this draft alone with an explicit top. Compare its interface and behavior with the active design in the same repository; record missing declarations and output drivers.
- **Expected result:** The draft must elaborate and meet an agreed contract before it can share active-design results. Do not include unfinished drafts in a wildcard compile.
- **Note:** Draft results are separate from active RTL.

#### PP-048 — Compile isolated tops and record reproducible evidence

- **Block / priority / initial status:** Build and evidence / P0 / Pending
- **Source:** [src/additions/gate/and2_g.v](https://github.com/kapiltrip/PlacementPrep/blob/4aeb1a1555f5051ec06a4cc3fc5ae866fcc13194/src/additions/gate/and2_g.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Test idea:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.

### GoodQuestions

#### GQ-001 — Coordinated reset and idle

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Test idea:** Run both independent clocks, set wren=rden=0 and assert wrrst=rdrst=1. Release each reset away from its local edge.
- **Expected result:** Local pointers reset, full=0, empty=1 and dout=0 after reset settles. No memory clearing is required.

#### GQ-002 — First word crosses to read domain

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Test idea:** Write A5 once on wrclk while full=0; keep rden=0 and watch empty on successive rdclk edges. Then request one accepted read.
- **Expected result:** empty deasserts only after synchronized write-pointer visibility. dout=A5 after the accepted rdclk edge. This variant directly computes flags from next pointers. First test the combinational feedback at empty/full.

#### GQ-003 — Fill, overflow, drain and underflow

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Test idea:** With reads stopped, write DEPTH words (2^aw (default 16)), attempt extra writes, then drain after empty clears. Attempt extra reads.
- **Expected result:** Exactly DEPTH original words return in order. Full writes and empty reads never move local pointers. Final full=0 and empty=1 after clock-domain propagation.

#### GQ-004 — Fast writer and slow reader

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Pending
- **Source:** [qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Test idea:** Use write/read periods 10 ns/31 ns, unrelated initial phases, and bursts long enough to reach full.
- **Expected result:** Only locally accepted operations enter the reference queue; no loss/reordering. full may conservatively remain high while a read propagates.

#### GQ-005 — Slow writer and fast reader

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Pending
- **Source:** [qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Test idea:** Use write/read periods 29 ns/8 ns, then reverse the rates; repeatedly touch empty.
- **Expected result:** No stale/unwritten word is consumed. empty can remain high while a remote write propagates.

#### GQ-006 — Equal rates with phase shifts

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Pending
- **Source:** [qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Test idea:** Use 10 ns/10 ns clocks with offsets 0,2,5 ns. Include coincident edges and continuous traffic at half occupancy.
- **Expected result:** Ordered data with race-free stimulus. Determine each operation from its own pre-edge full/empty; do not order coincident events by testbench process scheduling.

#### GQ-007 — Gray pointers and blocked requests

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Test idea:** Observe local binary/Gray pointer pairs through wrap. Hold wren=1 at full and rden=1 at empty.
- **Expected result:** Local pointer increments only on accepted operations; Gray equals binary XOR (binary shifted right one). Successive LOCAL Gray values differ in one bit, or zero when holding. Destination samples may skip states and differ in multiple bits.

#### GQ-008 — Synchronizer direction and flag latency

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Test idea:** Apply one remote pointer change while the destination clock runs; trace first and second synchronization stages on each destination edge.
- **Expected result:** Stage 1 samples the remote pointer; stage 2 samples previous stage 1. Flags must use stage 2. This variant directly computes flags from next pointers. First test the combinational feedback at empty/full.

#### GQ-009 — Clock stop and restart

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Pending
- **Source:** [qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Test idea:** Pause rdclk while writing to full, then resume it; repeat by pausing wrclk during reads.
- **Expected result:** No operation occurs without its local clock; flags converge after the stopped clock resumes. Scoreboard order survives the pause.

#### GQ-010 — Many laps and random bursts

- **Block / priority / initial status:** Asynchronous FIFO / P2 / Pending
- **Source:** [qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Test idea:** Run at least four complete pointer laps for three recorded seeds and clock ratios. Compare every accepted read with a software reference queue.
- **Expected result:** No duplicates, drops or ordering errors. End with both clocks running and fully drain the reference queue.

#### GQ-011 — Both resets during traffic

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Pending
- **Source:** [qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Test idea:** Prefill, assert both resets during a burst, flush the expected queue, restart clocks and send a fresh known sequence.
- **Expected result:** Reset discards previous queued data; only new writes are considered valid. No assumptions about clearing memory cells.

#### GQ-012 — One-sided reset contract

- **Block / priority / initial status:** Asynchronous FIFO / P1 / Blocked
- **Source:** [qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Test idea:** Consider asserting only wrrst, then only rdrst, while data is pending. Define whether the whole FIFO is flushed or one domain may continue before executing.
- **Expected result:** Pass criteria require an agreed system reset policy. Current independent pointer resets do not guarantee preservation of unread data after a one-sided reset.
- **Note:** Resolve reset policy first; never mark data preservation proven by ordinary RTL simulation.

#### GQ-013 — Parameter and minimum-depth limits

- **Block / priority / initial status:** Asynchronous FIFO / P2 / Pending
- **Source:** [qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Test idea:** Elaborate legal data widths 1,8,16 and address widths 2,3,4. Separately try address width 1 and non-power-of-two DEPTH if that parameter exists.
- **Expected result:** Supported configurations retain capacity and ordering. Record unsupported values as a documented constraint: slices such as [AW-2:0] or [ADDR-2:0] need special handling below address width 2.

#### GQ-014 — CDC implementation review

- **Block / priority / initial status:** Asynchronous FIFO / P2 / Pending
- **Source:** [qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Test idea:** Inspect the synthesized synchronizer paths, reset release, Gray-bus constraints and memory mapping with the target FPGA/ASIC tools.
- **Expected result:** A CDC report and reviewed timing constraints are separate evidence. Functional simulation cannot establish metastability reliability or physical Gray-bus skew.
- **Note:** This is a design-review case, not a Verilog simulation pass.

#### GQ-015 — Flag combinational-loop boundary check

- **Block / priority / initial status:** Asynchronous FIFO / P0 / Pending
- **Source:** [qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** rden, wren, empty, full, rdptrbin_next, wrptrbin_next, rdptrgray_next, wrptrgray_next
- **Test idea:** At empty assert rden; near full assert wren. Run with a finite simulator watchdog and inspect the combinational dependency path.
- **Expected result:** Flags must settle to a definite value before an edge. Here empty/full depend on next pointers, which themselves depend on empty/full; record oscillation/non-settling or a lint combinational-loop finding as failure.
- **Note:** Source indicates circular flag logic; do not assume the same behavior as AsynchronousFifo/async_fifo.v.

#### GQ-016 — Reset and first usable cycle

- **Block / priority / initial status:** Full-throughput synchronous FIFO / P0 / Pending
- **Source:** [qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Test idea:** Hold push=pop=0. Assert rst_n=0, clock the design, then release reset away from the active edge.
- **Expected result:** After the specified reset event: fifo_empty=1 and fifo_full=0; pointers/count are reset. data_out is driven by an always-reading synchronous RAM, so it may change even when pop=0 or fifo_empty=1. Reset sets the RAM output to zero; after release it resumes reading even without a pop.

#### GQ-017 — Single write then single read

- **Block / priority / initial status:** Full-throughput synchronous FIFO / P0 / Pending
- **Source:** [qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Test idea:** Write A5 with push=1 while fifo_full=0; disable write; request one read with pop=1 while fifo_empty=0.
- **Expected result:** fifo_empty clears after the write and asserts after the read. Compare data_out AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer. Exactly one word is transferred.

#### GQ-018 — Ordering and mixed data

- **Block / priority / initial status:** Full-throughput synchronous FIFO / P0 / Pending
- **Source:** [qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Test idea:** Write 10,22,35,48 with gaps, then drain using isolated and consecutive pop requests.
- **Expected result:** Read values are 10,22,35,48 in that order. Compare data_out AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### GQ-019 — Fill to capacity and reject overflow

- **Block / priority / initial status:** Full-throughput synchronous FIFO / P0 / Pending
- **Source:** [qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Test idea:** With pop=0, issue exactly DEPTH writes (2^ADDR_W (default 256)); check one below full and full. Attempt three further writes with distinct data, then drain.
- **Expected result:** fifo_full asserts only after the last available slot is used. Extra writes cannot move the write pointer or replace queued data. Draining returns the original DEPTH values.

#### GQ-020 — Drain to empty and reject underflow

- **Block / priority / initial status:** Full-throughput synchronous FIFO / P0 / Pending
- **Source:** [qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Test idea:** Fill and drain exactly DEPTH accepted reads. Keep pop=1 for three additional clocks with push=0.
- **Expected result:** fifo_empty asserts on the last accepted pop; extra reads do not advance the read pointer or change occupancy. data_out is driven by an always-reading synchronous RAM, so it may change even when pop=0 or fifo_empty=1. Reset sets the RAM output to zero; after release it resumes reading even without a pop.

#### GQ-021 — Both enables in the middle

- **Block / priority / initial status:** Full-throughput synchronous FIFO / P0 / Pending
- **Source:** [qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Test idea:** Prefill to half capacity. Keep push=pop=1 for at least 2*DEPTH clocks with a changing data_in.
- **Expected result:** Both operations are accepted on each edge and occupancy stays constant. The stream remains ordered across pointer wraps. Compare data_out AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### GQ-022 — Both enables when empty

- **Block / priority / initial status:** Full-throughput synchronous FIFO / P0 / Pending
- **Source:** [qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Test idea:** Reset empty, then assert push=pop=1 for one edge with data_in=3C.
- **Expected result:** Only the write is accepted because the pre-edge fifo_empty=1. Occupancy becomes one. No same-edge bypass/pop of 3C is allowed.

#### GQ-023 — Both enables when full

- **Block / priority / initial status:** Full-throughput synchronous FIFO / P0 / Pending
- **Source:** [qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Test idea:** Fill to capacity; assert push=pop=1 for one edge with a new data_in.
- **Expected result:** Both operations are accepted: the old head is read, the new word enters the tail, and occupancy stays DEPTH. Check read-first collision behavior.

#### GQ-024 — Idle and output validity

- **Block / priority / initial status:** Full-throughput synchronous FIFO / P1 / Pending
- **Source:** [qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Test idea:** Pause both enables at empty, one word, half-full and full. Toggle data_in while idle.
- **Expected result:** Pointers/count and flags hold. data_out is driven by an always-reading synchronous RAM, so it may change even when pop=0 or fifo_empty=1. Reset sets the RAM output to zero; after release it resumes reading even without a pop.

#### GQ-025 — Repeated wraparound

- **Block / priority / initial status:** Full-throughput synchronous FIFO / P1 / Pending
- **Source:** [qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Test idea:** Alternate fill/drain and mixed bursts until each pointer wraps at least four times. Use a sequence number for every accepted write.
- **Expected result:** No duplication, loss or reordering. Counts stay between zero and DEPTH; fifo_full and fifo_empty cannot both be true.

#### GQ-026 — Reset with queued traffic

- **Block / priority / initial status:** Full-throughput synchronous FIFO / P1 / Pending
- **Source:** [qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Test idea:** Prefill, assert rst_n during traffic, then hold enables low through reset. Discard the software reference queue; release reset and write fresh values.
- **Expected result:** Old queued values are discarded logically. The first fresh drain returns only post-reset accepted writes. data_out is driven by an always-reading synchronous RAM, so it may change even when pop=0 or fifo_empty=1. Reset sets the RAM output to zero; after release it resumes reading even without a pop.

#### GQ-027 — Random bursts with a reference queue

- **Block / priority / initial status:** Full-throughput synchronous FIFO / P2 / Pending
- **Source:** [qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Test idea:** Run 1000 or more edges for each of three recorded seeds. Bias requests toward empty/full and one-away states. Queue only writes accepted by pre-edge flags and dequeue only accepted reads.
- **Expected result:** Every accepted read matches the oldest reference word. End by draining and proving the reference queue empty. Compare data_out AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### GQ-028 — Ordering, duplicates and handshake

- **Block / priority / initial status:** Two maximum values / P0 / Pending
- **Source:** [qa/pdf_q21/q21_max_and_second_max_onecmp.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q21/q21_max_and_second_max_onecmp.v)
- **Signals:** clk, rst, clear, in_valid, in_data, in_ready, max1, max2, max1_valid, max2_valid
- **Test idea:** Submit 3,9,5,9 only when in_ready=1; wait for processing between submissions. Also test zero samples and one sample after reset.
- **Expected result:** After four accepted values max1=9,max2=9: duplicates are counted. With zero/one samples, validity bits identify which maxima exist. Input while not ready is not accepted.

#### GQ-029 — Clear interrupts a comparison

- **Block / priority / initial status:** Two maximum values / P1 / Pending
- **Source:** [qa/pdf_q21/q21_max_and_second_max_onecmp.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q21/q21_max_and_second_max_onecmp.v)
- **Signals:** clk, clear, in_valid, in_ready, max1_valid, max2_valid
- **Test idea:** Assert clear during each comparison state, with in_valid also high.
- **Expected result:** Clear wins; both valid bits clear and state returns ready. The interrupted sample is discarded.

#### GQ-030 — Impulse, signed data and latency

- **Block / priority / initial status:** FIR filter / P0 / Pending
- **Source:** [qa/pdf_q24/q24_fir_5tap.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q24/q24_fir_5tap.v)
- **Signals:** clk, rst_n, sample_in, sample_out
- **Test idea:** Reset, send impulse 1 followed by zeros, then constant 1 and signed extreme samples. Repeat with asymmetric and negative coefficients.
- **Expected result:** After each sampling edge the default impulse response is 1,2,3,2,1,0; the constant response settles to 9. Use signed products, widened sums and output-width truncation when computing expected results.

#### GQ-031 — All remainder transitions

- **Block / priority / initial status:** Remainder FSM / P0 / Pending
- **Source:** [qa/pdf_q19_q20/q19_divisible_by3_fsm.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q19_q20/q19_divisible_by3_fsm.v)
- **Signals:** clk, rst, bit_in, div_by_3
- **Test idea:** Feed serial MSB-first streams for 0,1,2,3,6,7 and longer random bit sequences; reset between independent numbers.
- **Expected result:** Update reference remainder as (2*previous+bit_in) mod 3. div_by_3 is high exactly for remainder zero after the clock edge, including reset state.

#### GQ-032 — Enable gaps and overflow

- **Block / priority / initial status:** Fibonacci / P1 / Pending
- **Source:** [qa/pdf_q19_q20/q20_fibonacci_enable.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q19_q20/q20_fibonacci_enable.v)
- **Signals:** clk, rst_n, enable, cur_num, next_num, sum
- **Test idea:** Reset, pulse enable with gaps, then run long enough to overflow a small WIDTH.
- **Expected result:** Initial pair is 0,1; enabled pairs advance 1,1 then 1,2 then 2,3. Hold both stored terms while enable=0; sum remains their combinational sum modulo 2^WIDTH.

#### GQ-033 — Second/minute/hour rollover

- **Block / priority / initial status:** Time pulses / P1 / Pending
- **Source:** [qa/pdf_q22_q23/q22_time_ticks.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q22_q23/q22_time_ticks.v)
- **Signals:** clk, rst_n, one_ms_pulse, second, minute, hour
- **Test idea:** Count accepted one_ms_pulse events, inserting gaps; check 999/1000, 59999/60000 and 3599999/3600000 events.
- **Expected result:** second every 1000 events, minute every 60000, hour every 3600000. Outputs are combinational qualifiers of pre-edge counters and the input pulse; sample at the accepting edge before counters roll.

#### GQ-034 — Asynchronous assert and two-edge release

- **Block / priority / initial status:** Reset synchronizer / P0 / Pending
- **Source:** [qa/pdf_q28_q30/q30_reset_synchronizer.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q28_q30/q30_reset_synchronizer.v)
- **Signals:** clk, rst_n, local_reset_n
- **Test idea:** Assert rst_n=0 with clk stopped, release to 1, then provide two rising edges. Reassert during the release sequence.
- **Expected result:** local_reset_n asserts low without a clock and deasserts only after two rising edges after release. Reassertion restarts the two-stage release.

#### GQ-035 — Enable changes in both clock phases

- **Block / priority / initial status:** Clock gate / P1 / Pending
- **Source:** [qa/pdf_q28_q30/q28_glitch_free_clock_gate.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q28_q30/q28_glitch_free_clock_gate.v)
- **Signals:** clk_in, enable, gated_clk
- **Test idea:** Initialize enable while clk_in is low. Toggle enable in low/high phases and compare every gated pulse width.
- **Expected result:** Enable is captured only while clk_in=0. A high-phase enable change cannot shorten or create a gated pulse; accepted pulses follow clk_in. Initialize the latch before checking.

#### GQ-036 — Drive, release and contention

- **Block / priority / initial status:** Tri-state bus / P1 / Pending
- **Source:** [qa/bi_buf/bi_buf.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/bi_buf/bi_buf.v)
- **Signals:** c, a, b
- **Test idea:** Exercise c, a, b; allow one external driver at a time, test each direction/enable, then release both. Isolate a conflicting-drive negative run.
- **Expected result:** Enabled path forwards the source, disabled path is high impedance, and conflicting equal-strength binary drives resolve to X. Do not replace four-state checks with two-state equality.

#### GQ-037 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [qa/pdf_q03_q06/q03_logic_gates.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q03_q06/q03_logic_gates.v)
- **Signals:** a, b, and_y, or_y, xor_y, nand_y, nor_y, xnor_y
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check and_y, or_y, xor_y, nand_y, nor_y, xnor_y against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: and_y = a & b; or_y = a | b; xor_y = a ^ b; nand_y = ~(a & b); nor_y = ~(a | b); xnor_y = ~(a ^ b); and_y = a & b; or_y = a | b; xor_y = a ^ b; nand_y = ~(a & b); nor_y = ~(a | b); xnor_y = ~(a ^ b); and_y = a && b; or_y = a || b; xor_y = a != b; nand_y = !(a && b); nor_y = !(a || b); xnor_y = a == b.

#### GQ-038 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [qa/pdf_q03_q06/q04_bitwise_reduction.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q03_q06/q04_bitwise_reduction.v)
- **Signals:** databus, all_ones_detected, is_databus_odd, signal_not_zero
- **Test idea:** Drive databus through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check all_ones_detected, is_databus_odd, signal_not_zero against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: all_ones_detected = &databus; is_databus_odd = ^databus; signal_not_zero = |databus.

#### GQ-039 — Direction, load and boundary bits

- **Block / priority / initial status:** Shift/rotate / P1 / Pending
- **Source:** [qa/pdf_q03_q06/q05_shift_operations.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q03_q06/q05_shift_operations.v)
- **Signals:** a, mul_by_4, div_by_8
- **Test idea:** Drive a with walking-one patterns at both ends; exercise every shift amount/direction and simultaneous load/enable controls.
- **Expected result:** mul_by_4, div_by_8 preserves the defined bit order and delay. Check zero-fill, sign-fill or rotation separately as specified by this source; load/hold priority and bits shifted out must match the contract. Source mapping: mul_by_4 = a << 2; div_by_8 = a >> 3.

#### GQ-040 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [qa/pdf_q03_q06/q06_sign_extension.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q03_q06/q06_sign_extension.v)
- **Signals:** a, c
- **Test idea:** Drive a through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check c against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: c = {{5{a[4]}}, a}.

#### GQ-041 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [qa/pdf_q07_q11/q07_mux4_styles.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q07_q11/q07_mux4_styles.v)
- **Signals:** a, b, c, d, sel, y
- **Test idea:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings. Source mapping: y = (sel == 2'b00) ? a : (sel == 2'b01) ? b : (sel == 2'b10) ? c : d.

#### GQ-042 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [qa/pdf_q07_q11/q09_ff_reset_styles.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q07_q11/q09_ff_reset_styles.v)
- **Signals:** clk, rst, d, q
- **Test idea:** For q09_a, q09_b, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### GQ-043 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [qa/pdf_q07_q11/q10_latch_and_flop.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q07_q11/q10_latch_and_flop.v)
- **Signals:** clk, input_sig, q_latch, q_flop
- **Test idea:** For q10, initialize through its reset/load path, then vary input_sig before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q_latch, q_flop only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### GQ-044 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [qa/pdf_q07_q11/q11_edge_detect.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q07_q11/q11_edge_detect.v)
- **Signals:** clk, rst, d, rising, falling, toggle
- **Test idea:** For q11, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check rising, falling, toggle only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: toggle = d ^ q_prev; falling = (~d) & q_prev; rising = d & (~q_prev).

#### GQ-045 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [qa/pdf_q12_q18/q12_one_cycle_pulse_detect.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q12_one_cycle_pulse_detect.v)
- **Signals:** clk, rst, d, pulse_high, pulse_low
- **Test idea:** For q12, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check pulse_high, pulse_low only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: pulse_high = (~d) & q1 & (~q2); pulse_low = d & (~q1) & q2.

#### GQ-046 — 10110 matches, overlaps and near misses

- **Block / priority / initial status:** Sequence detector / P1 / Pending
- **Source:** [qa/pdf_q12_q18/q13_seq_10110_fsms_abcd.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q13_seq_10110_fsms_abcd.v)
- **Signals:** clk, rst, x, y
- **Test idea:** Drive 10110, near misses, repeated matches and an overlapping stream (10110110), one bit per clock using clk, rst, x. Reset midway through a prefix.
- **Expected result:** Check y at each match ending. Overlap variants retain a matching suffix; nonoverlap variants discard it. Use the actual combinational/registered output timing in each module, not the name Mealy/Moore alone.

#### GQ-047 — 10110 matches, overlaps and near misses

- **Block / priority / initial status:** Sequence detector / P1 / Pending
- **Source:** [qa/pdf_q12_q18/q14_last5_detect_10110.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q14_last5_detect_10110.v)
- **Signals:** clk, rst, din, match
- **Test idea:** Drive 10110, near misses, repeated matches and an overlapping stream (10110110), one bit per clock using clk, rst, din. Reset midway through a prefix.
- **Expected result:** Check match at each match ending. Overlap variants retain a matching suffix; nonoverlap variants discard it. Use the actual combinational/registered output timing in each module, not the name Mealy/Moore alone. Source mapping: match = (window == 5'b10110); match = (window == 5'b01101).

#### GQ-048 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [qa/pdf_q12_q18/q15_start_and_chipselects.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q15_start_and_chipselects.v)
- **Signals:** clk, rst, start, cs1, cs2, cs3
- **Test idea:** For q15_start_and_chipselects, initialize through its reset/load path, then vary available controls before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check start, cs1, cs2, cs3 only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: start = (phase == 2'd0); cs1 = (phase == 2'd1) && (sel == 2'd0); cs2 = (phase == 2'd1) && (sel == 2'd1); cs3 = (phase == 2'd1) && (sel == 2'd2).

#### GQ-049 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [qa/pdf_q12_q18/q16_sync_debounce_onepulse.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q16_sync_debounce_onepulse.v)
- **Signals:** clk, rst, async_in, pulse
- **Test idea:** For q16_sync_debounce_onepulse, initialize through its reset/load path, then vary async_in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check pulse only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: pulse = (q2 & d1) & (~d2).

#### GQ-050 — Conversion, wrap and local adjacency

- **Block / priority / initial status:** Gray code / P1 / Pending
- **Source:** [qa/pdf_q12_q18/q17_gray_counter_methods.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q17_gray_counter_methods.v)
- **Signals:** clk, rst, gray, bin
- **Test idea:** Sweep binary/Gray input or clock the full small-width sequence using clk, rst, gray, bin; compare encoder/decoder round trips if both exist.
- **Expected result:** Binary-to-Gray keeps the MSB and XORs adjacent bits; Gray-to-binary uses cumulative XOR from the MSB. Consecutive local count steps, including wrap, change one Gray bit; no change occurs while held. Source mapping: gray = bin ^ (bin >> 1); gray = bin_counter ^ (bin_counter >> 1).

#### GQ-051 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [qa/pdf_q22_q23/q23_timing_b_from_a.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q22_q23/q23_timing_b_from_a.v)
- **Signals:** clk, rst_n, A, B
- **Test idea:** For q23_timing_b_from_a, initialize through its reset/load path, then vary A before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, negedge rst_n.
- **Expected result:** Check B only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: B = A | a_delay.

#### GQ-052 — Frequency, duty cycle and startup

- **Block / priority / initial status:** Clock divider / P1 / Pending
- **Source:** [qa/pdf_q25_q26/q25_clock_div2.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q25_q26/q25_clock_div2.v)
- **Signals:** clk, rst_n, q
- **Test idea:** Use a known 50% input clock through clk, rst_n; measure steady output period and high time for ten cycles, then reset during both phases and test legal parameter endpoints.
- **Expected result:** Measure q against the named divide ratio and duty setting. Include both edges for half-cycle implementations. Distinguish a one-cycle enable pulse from a square clock; ignore documented startup transients only.

#### GQ-053 — Frequency, duty cycle and startup

- **Block / priority / initial status:** Clock divider / P1 / Pending
- **Source:** [qa/pdf_q25_q26/q26_clock_div3_duty50.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q25_q26/q26_clock_div3_duty50.v)
- **Signals:** clk, rst_n, clk_div3
- **Test idea:** Use a known 50% input clock through clk, rst_n; measure steady output period and high time for ten cycles, then reset during both phases and test legal parameter endpoints.
- **Expected result:** Measure clk_div3 against the named divide ratio and duty setting. Include both edges for half-cycle implementations. Distinguish a one-cycle enable pulse from a square clock; ignore documented startup transients only. Source mapping: clk_div3 = (DUTY_CYCLE == 33) ? duty_33 : (DUTY_CYCLE == 50) ? duty_50 : ((DUTY_CYCLE == 66) || (DUTY_CYCLE == 67)) ? duty_66 : (DUTY_CYCLE == 100) ? duty_100 : duty_50.

#### GQ-054 — Frequency, duty cycle and startup

- **Block / priority / initial status:** Clock divider / P1 / Pending
- **Source:** [qa/pdf_q27/q27_clock_div_n.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q27/q27_clock_div_n.v)
- **Signals:** clk, rst_n, clk_div
- **Test idea:** Use a known 50% input clock through clk, rst_n; measure steady output period and high time for ten cycles, then reset during both phases and test legal parameter endpoints.
- **Expected result:** Measure clk_div against the named divide ratio and duty setting. Include both edges for half-cycle implementations. Distinguish a one-cycle enable pulse from a square clock; ignore documented startup transients only. Source mapping: clk_div = ((N % 2) == 0) ? duty_even: duty_odd.

#### GQ-055 — Frequency, duty cycle and startup

- **Block / priority / initial status:** Clock divider / P1 / Pending
- **Source:** [qa/pdf_q27/q27_clock_div_n_duty.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q27/q27_clock_div_n_duty.v)
- **Signals:** clk, rst_n, clk_div
- **Test idea:** Use a known 50% input clock through clk, rst_n; measure steady output period and high time for ten cycles, then reset during both phases and test legal parameter endpoints.
- **Expected result:** Measure clk_div against the named divide ratio and duty setting. Include both edges for half-cycle implementations. Distinguish a one-cycle enable pulse from a square clock; ignore documented startup transients only.

#### GQ-056 — Reset, rollover and control priority

- **Block / priority / initial status:** Counter / P1 / Pending
- **Source:** [qa/pdf_q27/q27_clock_divider_variants.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q27/q27_clock_divider_variants.v)
- **Signals:** clk, rst_n, clk_div2, clk_div4, clk_div8, clk_div3, enable, tick
- **Test idea:** Initialize q27_div2_toggle, q27_div4_counter, q27_div8_counter, q27_div3_duty50, q27_divn_tick; test every enable/load/direction combination in clk, rst_n. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** clk_div2 follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs.

#### GQ-057 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [qa/pdf_q28_q30/q29_async_rise_detect_when_clocks_off.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q28_q30/q29_async_rise_detect_when_clocks_off.v)
- **Signals:** d_async, clr_n, q
- **Test idea:** For q29_async_rise_detect_when_clocks_off, q29_async_any_edge_detect_when_clocks_off, initialize through its reset/load path, then vary d_async, clr_n before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge d_async, negedge clr_n, negedge d_async.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: q = rise_seen | fall_seen.

#### GQ-058 — Conversion, wrap and local adjacency

- **Block / priority / initial status:** Gray code / P1 / Pending
- **Source:** [qa/pdf_q44/q44_div3_gray_fsm.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q44/q44_div3_gray_fsm.v)
- **Signals:** clk, rst_n, div3_out, state
- **Test idea:** Sweep binary/Gray input or clock the full small-width sequence using clk, rst_n, div3_out, state; compare encoder/decoder round trips if both exist.
- **Expected result:** Binary-to-Gray keeps the MSB and XORs adjacent bits; Gray-to-binary uses cumulative XOR from the MSB. Consecutive local count steps, including wrap, change one Gray bit; no change occurs while held.

#### GQ-059 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [qa/pdf_q45/q45_adders.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q45/q45_adders.v)
- **Signals:** a, b, sum, carry, cin, cout, diff, borrow, bin, bout
- **Test idea:** Exercise a, b at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum, carry bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: sum = a ^ b; carry = a & b; sum = a ^ b ^ cin; sum = a ^ b ^ cin.

#### GQ-060 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [qa/pdf_q46/q46_gates_using_mux2.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q46/q46_gates_using_mux2.v)
- **Signals:** d0, d1, s, y, a, b
- **Test idea:** Sweep s through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings. Source mapping: y = s ? d1 : d0.

#### GQ-061 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [qa/pdf_q47/q47_xor_controlled_inverter.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q47/q47_xor_controlled_inverter.v)
- **Signals:** a, control, y, b, subtract, result, cout
- **Test idea:** Exercise a, control at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every y bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: y = a ^ control; y = ~(a ^ control).

#### GQ-062 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [qa/pdf_q48/q48_gates_using_nand.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q48/q48_gates_using_nand.v)
- **Signals:** a, y, b
- **Test idea:** Drive a through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: y = ~(a & a); y = ~(nand_ab & nand_ab); y = ~(not_a & not_b); y = ~(a_term & b_term); y = ~(or_ab & or_ab).

#### GQ-063 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [qa/pdf_q49/q49_mux4_from_mux2.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q49/q49_mux4_from_mux2.v)
- **Signals:** d0, d1, s, y, a, b, c, d, s0, s1
- **Test idea:** Sweep s through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings. Source mapping: y = s ? d1 : d0; y = (~s1 & ~s0 & a) | (~s1 & s0 & b) | ( s1 & ~s0 & c) | ( s1 & s0 & d); y = s1 ? high_pair : low_pair.

#### GQ-064 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [qa/q01_mux/mux2_behavioral.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q01_mux/mux2_behavioral.v)
- **Signals:** a, b, sel, y
- **Test idea:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.

#### GQ-065 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [qa/q01_mux/mux2_dataflow.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q01_mux/mux2_dataflow.v)
- **Signals:** a, b, sel, y
- **Test idea:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings. Source mapping: y = sel ? b : a.

#### GQ-066 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [qa/q01_mux/mux2_gatelevel.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q01_mux/mux2_gatelevel.v)
- **Signals:** a, b, sel, y
- **Test idea:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.

#### GQ-067 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [qa/q02_ff/dff_async_reset.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q02_ff/dff_async_reset.v)
- **Signals:** clk, rst, d, q
- **Test idea:** For dff_async_reset, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### GQ-068 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [qa/q02_ff/dff_sync_reset.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q02_ff/dff_sync_reset.v)
- **Signals:** clk, rst, d, q
- **Test idea:** For dff_sync_reset, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### GQ-069 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [qa/q03_edge_detect/edge_detect_both.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q03_edge_detect/edge_detect_both.v)
- **Signals:** clk, rst, d, q
- **Test idea:** For edge_detect_both, edge_detect_both_async_d, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### GQ-070 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [qa/q04_rise_pulse/edge_to_1cycle_pulse.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q04_rise_pulse/edge_to_1cycle_pulse.v)
- **Signals:** clk, rst_n, d, q
- **Test idea:** For edge_to_1cycle_pulse, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### GQ-071 — 10110 matches, overlaps and near misses

- **Block / priority / initial status:** Sequence detector / P1 / Pending
- **Source:** [qa/q05_seq_10110/seq_10110_fsms.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q05_seq_10110/seq_10110_fsms.v)
- **Signals:** clk, rst_n, x, y
- **Test idea:** Drive 10110, near misses, repeated matches and an overlapping stream (10110110), one bit per clock using clk, rst_n, x. Reset midway through a prefix.
- **Expected result:** Check y at each match ending. Overlap variants retain a matching suffix; nonoverlap variants discard it. Use the actual combinational/registered output timing in each module, not the name Mealy/Moore alone.

#### GQ-072 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [qa/q06_detect/detect.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q06_detect/detect.v)
- **Signals:** clk, rst_n, din, match
- **Test idea:** For detect, initialize through its reset/load path, then vary din before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, negedge rst_n.
- **Expected result:** Check match only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: match = (shreg == 5'b10110).

#### GQ-073 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [qa/q07_start_and_chipselects/start_and_chipselects.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q07_start_and_chipselects/start_and_chipselects.v)
- **Signals:** clk, rst_n, start, CS1, CS2, CS3
- **Test idea:** For start_and_chipselects, initialize through its reset/load path, then vary available controls before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, negedge rst_n.
- **Expected result:** Check start, CS1, CS2, CS3 only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: start = (counter == 2'd1); CS1 = start_d & (sel == 2'd0); CS2 = start_d & (sel == 2'd1); CS3 = start_d & (sel == 2'd2).

#### GQ-074 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [qa/q08_sync_debounce_onepulse/sync_debounce_onepulse.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q08_sync_debounce_onepulse/sync_debounce_onepulse.v)
- **Signals:** clk, rst_n, async_in, pulse
- **Test idea:** For sync_debounce_onepulse, initialize through its reset/load path, then vary async_in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, negedge rst_n.
- **Expected result:** Check pulse only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: pulse = (q2 & d1) & ~d2.

#### GQ-075 — Conversion, wrap and local adjacency

- **Block / priority / initial status:** Gray code / P1 / Pending
- **Source:** [qa/q09_gray/gray_blocks.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q09_gray/gray_blocks.v)
- **Signals:** clk, rst_n, gray, bin, gray_q, bin_q
- **Test idea:** Sweep binary/Gray input or clock the full small-width sequence using clk, rst_n, gray, bin, gray_q, bin_q; compare encoder/decoder round trips if both exist.
- **Expected result:** Binary-to-Gray keeps the MSB and XORs adjacent bits; Gray-to-binary uses cumulative XOR from the MSB. Consecutive local count steps, including wrap, change one Gray bit; no change occurs while held. Source mapping: gray = bin ^ (bin >> 1); gray = bin ^ (bin >> 1).

#### GQ-076 — Compile and compare draft contract

- **Block / priority / initial status:** Practice draft / P2 / Pending
- **Source:** [study_plan/practice/video_04_gate_level_modeling_practice.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/study_plan/practice/video_04_gate_level_modeling_practice.v)
- **Signals:** a, b, sum, carry, cin, cout
- **Test idea:** Compile this draft alone with an explicit top. Compare its interface and behavior with the active design in the same repository; record missing declarations and output drivers.
- **Expected result:** The draft must elaborate and meet an agreed contract before it can share active-design results. Do not include unfinished drafts in a wildcard compile.
- **Note:** Draft results are separate from active RTL.

#### GQ-077 — Compile and compare draft contract

- **Block / priority / initial status:** Practice draft / P2 / Pending
- **Source:** [study_plan/practice/video_05_full_adder_using_half_adder_practice.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/study_plan/practice/video_05_full_adder_using_half_adder_practice.v)
- **Signals:** a, b, cin, sum, cout, diff, borrow, bin, bout
- **Test idea:** Compile this draft alone with an explicit top. Compare its interface and behavior with the active design in the same repository; record missing declarations and output drivers.
- **Expected result:** The draft must elaborate and meet an agreed contract before it can share active-design results. Do not include unfinished drafts in a wildcard compile.
- **Note:** Draft results are separate from active RTL.

#### GQ-078 — Compile and compare draft contract

- **Block / priority / initial status:** Practice draft / P2 / Pending
- **Source:** [study_plan/practice/video_06_bcd_ripple_carry_adder_practice.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/study_plan/practice/video_06_bcd_ripple_carry_adder_practice.v)
- **Signals:** a, b, cin, sum, cout
- **Test idea:** Compile this draft alone with an explicit top. Compare its interface and behavior with the active design in the same repository; record missing declarations and output drivers.
- **Expected result:** The draft must elaborate and meet an agreed contract before it can share active-design results. Do not include unfinished drafts in a wildcard compile.
- **Note:** Draft results are separate from active RTL.

#### GQ-079 — Compile isolated tops and record reproducible evidence

- **Block / priority / initial status:** Build and evidence / P0 / Pending
- **Source:** [qa/bi_buf/bi_buf.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/bi_buf/bi_buf.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Test idea:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.

### MorrisManoDE

#### MM-001 — Define and implement code0.v

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [code0.v](https://github.com/kapiltrip/MorrisManoDE/blob/46c9045295755c84efdd9a8e2324004ff0b7d163/code0.v)
- **Signals:** No complete module interface
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### MM-002 — Compile isolated tops and record reproducible evidence

- **Block / priority / initial status:** Build and evidence / P0 / Pending
- **Source:** [code0.v](https://github.com/kapiltrip/MorrisManoDE/blob/46c9045295755c84efdd9a8e2324004ff0b7d163/code0.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Test idea:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.

### hdlBits

#### HDL-001 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 01/001-wire.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/001-wire.sv)
- **Signals:** in, out
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-002 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 01/002-wire4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/002-wire4.sv)
- **Signals:** a, b, c, w, x, y, z
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-003 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 01/003-notgate.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/003-notgate.sv)
- **Signals:** in, out
- **Test idea:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-004 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 01/008-7458.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/008-7458.sv)
- **Signals:** p1a, p1b, p1c, p1d, p1e, p1f, p2a, p2b, p2c, p2d, p1y, p2y
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-005 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 01/009-vector0.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/009-vector0.sv)
- **Signals:** vec, outv, o2, o1, o0
- **Test idea:** Drive vec through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check outv, o2, o1, o0 against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: outv = vec; o2 = vec[2]; o1 = vec[1]; o0 = vec[0].
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-006 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 01/010-vector1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/010-vector1.sv)
- **Signals:** in, out_hi, out_lo
- **Test idea:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_hi, out_lo against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_hi = in[15:8]; out_lo = in[7:0].
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-007 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 01/011-vector2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/011-vector2.sv)
- **Signals:** in, out
- **Test idea:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = {d,c,b,a}.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-008 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 01/012-vectorgates.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/012-vectorgates.sv)
- **Signals:** a, b, out_or_bitwise, out_or_logical, out_not
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_or_bitwise, out_or_logical, out_not against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_or_bitwise = a |b; out_or_logical = a ||b; out_not = {~b,~a}.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-009 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 01/013-gates4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/013-gates4.sv)
- **Signals:** in, out_and, out_or, out_xor
- **Test idea:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_and, out_or, out_xor against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_and = &in; out_or = |in; out_xor = ^in.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-010 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 01/014-vector3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/014-vector3.sv)
- **Signals:** a, b, c, d, e, f, w, x, y, z
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-011 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 01/015-vectorr.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/015-vectorr.sv)
- **Signals:** in, out
- **Test idea:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out[i] = in[7-i].
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-012 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 01/016-vector4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/016-vector4.sv)
- **Signals:** in, out
- **Test idea:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = {{24{in[7]}},in}.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-013 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/004-andgate.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/004-andgate.sv)
- **Signals:** a, b, out
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-014 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/005-norgate.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/005-norgate.sv)
- **Signals:** a, b, out
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-015 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/006-xnorgate.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/006-xnorgate.sv)
- **Signals:** a, b, out
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = ~(a ^b).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-016 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/007-wire_decl.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/007-wire_decl.sv)
- **Signals:** a, b, c, d, out, out_n
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-017 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/017-vector5.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/017-vector5.sv)
- **Signals:** a, b, c, d, e, out
- **Test idea:** Drive a, b, c, d, e through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = ~(top ^ bottom).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-018 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/018-module.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/018-module.sv)
- **Signals:** a, b, out
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-019 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/019-module_pos.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/019-module_pos.sv)
- **Signals:** a, b, c, d, out1, out2
- **Test idea:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out1, out2 against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-020 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/020-module_name.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/020-module_name.sv)
- **Signals:** a, b, c, d, out1, out2
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-021 — Direction, load and boundary bits

- **Block / priority / initial status:** Shift/rotate / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/021-module_shift.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/021-module_shift.sv)
- **Signals:** clk, d, q
- **Test idea:** Drive clk, d with walking-one patterns at both ends; exercise every shift amount/direction and simultaneous load/enable controls.
- **Expected result:** q preserves the defined bit order and delay. Check zero-fill, sign-fill or rotation separately as specified by this source; load/hold priority and bits shifted out must match the contract.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-022 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/022-module_shift8.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/022-module_shift8.sv)
- **Signals:** clk, d, sel, q
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-023 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/023-module_add.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/023-module_add.sv)
- **Signals:** a, b, sum
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check sum against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: sum = {sum2,sum1}.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-024 — Define and implement top_module, add1

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/024-module_fadd.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/024-module_fadd.sv)
- **Signals:** a, b, sum, cin, cout
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-025 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/025-module_cseladd.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/025-module_cseladd.sv)
- **Signals:** a, b, sum
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-026 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/026-module_addsub.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/026-module_addsub.sv)
- **Signals:** a, b, sub, sum
- **Test idea:** Exercise a, b, sub at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: sum = {sumUpper,sumlower}.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-027 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/027-alwaysblock1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/027-alwaysblock1.sv)
- **Signals:** a, b, out_assign, out_alwaysblock
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_assign, out_alwaysblock against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_assign = a&b.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-028 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/028-alwaysblock2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/028-alwaysblock2.sv)
- **Signals:** clk, a, b, out_assign, out_always_comb, out_always_ff
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-029 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/029-always_if.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/029-always_if.sv)
- **Signals:** a, b, sel_b1, sel_b2, out_assign, out_always
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-030 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/030-always_if2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/030-always_if2.sv)
- **Signals:** cpu_overheated, arrived, gas_tank_empty, shut_off_computer, keep_driving
- **Test idea:** Drive cpu_overheated, arrived, gas_tank_empty through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check shut_off_computer, keep_driving against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-031 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/031-always_case.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/031-always_case.sv)
- **Signals:** sel, data0, data1, data2, data3, data4, data5, out
- **Test idea:** Drive sel, data0, data1, data2, data3, data4, data5 through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-032 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/032-always_case2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/032-always_case2.sv)
- **Signals:** in, pos
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-033 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/033-always_casez.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/033-always_casez.sv)
- **Signals:** in, pos
- **Test idea:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check pos against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-034 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/034-always_nolatches.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/034-always_nolatches.sv)
- **Signals:** scancode, left, down, right, up
- **Test idea:** Drive scancode through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check left, down, right, up against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-035 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/035-conditional.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/035-conditional.sv)
- **Signals:** a, b, c, d, min
- **Test idea:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check min against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: min = (minAB<minCD)?minAB:minCD.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-036 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/036-reduction.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/036-reduction.sv)
- **Signals:** in, parity
- **Test idea:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check parity against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: parity = ^in.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-037 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/037-gates100.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/037-gates100.sv)
- **Signals:** in, out_and, out_or, out_xor
- **Test idea:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_and, out_or, out_xor against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_and = &in; out_or = |in; out_xor = ^in.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-038 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/038-vector100r.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/038-vector100r.sv)
- **Signals:** in, out
- **Test idea:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out[i] = in[99-i].
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-039 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/039-popcount255.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/039-popcount255.sv)
- **Signals:** in, out
- **Test idea:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-040 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/040-adder100i.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/040-adder100i.sv)
- **Signals:** a, b, cin, cout, sum
- **Test idea:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every cout, sum bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: cout = carry[100:1].
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-041 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/042-exams__m2014_q4h.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/042-exams__m2014_q4h.sv)
- **Signals:** in, out
- **Test idea:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = in.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-042 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/043-exams__m2014_q4i.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/043-exams__m2014_q4i.sv)
- **Signals:** out
- **Test idea:** Drive the declared controls through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = 1'b0.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-043 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/044-exams__m2014_q4e.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/044-exams__m2014_q4e.sv)
- **Signals:** in1, in2, out
- **Test idea:** Drive in1, in2 through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-044 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/045-exams__m2014_q4f.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/045-exams__m2014_q4f.sv)
- **Signals:** in1, in2, out
- **Test idea:** Drive in1, in2 through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-045 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/046-exams__m2014_q4g.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/046-exams__m2014_q4g.sv)
- **Signals:** in1, in2, in3, out
- **Test idea:** Drive in1, in2, in3 through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-046 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 02/065-fadd.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/065-fadd.sv)
- **Signals:** a, b, cin, cout, sum
- **Test idea:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every cout, sum bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different. 
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-047 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/041-bcdadd100.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/041-bcdadd100.sv)
- **Signals:** a, b, cin, cout, sum
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-048 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/047-gates.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/047-gates.sv)
- **Signals:** a, b, out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_and = a&b; out_or = a|b; out_xor = a^b; out_nand = ~(a&b); out_nor = ~(a|b); out_xnor = ~(a^b); out_anotb = a & ~(b).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-049 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/048-7420.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/048-7420.sv)
- **Signals:** p1a, p1b, p1c, p1d, p2a, p2b, p2c, p2d, p1y, p2y
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-050 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/049-truthtable1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/049-truthtable1.sv)
- **Signals:** x3, x2, x1, f
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-051 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/050-mt2015_eq2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/050-mt2015_eq2.sv)
- **Signals:** A, B, z
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-052 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/051-mt2015_q4a.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/051-mt2015_q4a.sv)
- **Signals:** x, y, z
- **Test idea:** Drive x, y through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check z against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-053 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/052-mt2015_q4b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/052-mt2015_q4b.sv)
- **Signals:** x, y, z
- **Test idea:** Drive x, y through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check z against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-054 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/053-mt2015_q4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/053-mt2015_q4.sv)
- **Signals:** x, y, z
- **Test idea:** Drive x, y through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check z against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: z = (x ^ y) & x; z = ~(x ^ y).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-055 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/054-ringer.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/054-ringer.sv)
- **Signals:** ring, vibrate_mode, ringer, motor
- **Test idea:** Drive ring, vibrate_mode through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check ringer, motor against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: ringer = ring & ~vibrate_mode; motor = ring & vibrate_mode.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-056 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/055-thermostat.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/055-thermostat.sv)
- **Signals:** too_cold, too_hot, mode, fan_on, heater, aircon, fan
- **Test idea:** Drive too_cold, too_hot, mode, fan_on through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check heater, aircon, fan against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: heater = mode & too_cold; aircon = ~mode & too_hot; fan = fan_on | heater | aircon.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-057 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/056-popcount3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/056-popcount3.sv)
- **Signals:** in, out
- **Test idea:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-058 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/057-gatesv.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/057-gatesv.sv)
- **Signals:** in, out_both, out_any, out_different
- **Test idea:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_both, out_any, out_different against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_both = in[3:1] & in[2:0]; out_any = in[3:1] | in[2:0]; out_different = in^ {in[0],in[3:1]}.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-059 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/058-gatesv100.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/058-gatesv100.sv)
- **Signals:** in, out_both, out_any, out_different
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-060 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/059-mux2to1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/059-mux2to1.sv)
- **Signals:** a, b, sel, out
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-061 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/060-mux2to1v.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/060-mux2to1v.sv)
- **Signals:** a, b, sel, out
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-062 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/061-mux9to1v.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/061-mux9to1v.sv)
- **Signals:** a, b, c, d, e, f, g, h, i, sel, out
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-063 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/062-mux256to1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/062-mux256to1.sv)
- **Signals:** in, sel, out
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-064 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/063-mux256to1v.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/063-mux256to1v.sv)
- **Signals:** in, sel, out
- **Test idea:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** out equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings. Source mapping: out = in[sel*4+:4].
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-065 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/064-hadd.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/064-hadd.sv)
- **Signals:** a, b, cout, sum
- **Test idea:** Exercise a, b at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every cout, sum bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: cout = a &b; sum = a^b.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-066 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/066-adder3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/066-adder3.sv)
- **Signals:** a, b, cin, cout, sum
- **Test idea:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every cout, sum bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: cout = carry[3:1]; sum = a^b^cin; cout = a&b | b&cin | a &cin.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-067 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/067-exams__m2014_q4j.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/067-exams__m2014_q4j.sv)
- **Signals:** x, y, sum, a, b, cin, cout
- **Test idea:** Drive x, y through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check sum against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: sum[4] = carry[4]; sum = a^b^cin.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-068 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/068-exams__ece241_2014_q1c.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/068-exams__ece241_2014_q1c.sv)
- **Signals:** a, b, s, overflow
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check s, overflow against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: s = a+b; overflow = (a[7]==b[7]) && (a[7] != s[7]).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-069 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/069-adder100.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/069-adder100.sv)
- **Signals:** a, b, cin, cout, sum
- **Test idea:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every cout, sum bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: cout = carry [100]; sum = a^b^cin; cout = a&b | b&cin| a&cin.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-070 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/070-bcdadd4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/070-bcdadd4.sv)
- **Signals:** a, b, cin, cout, sum
- **Test idea:** Drive a, b, cin through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check cout, sum against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: cout = carry [4].
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-071 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/071-kmap1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/071-kmap1.sv)
- **Signals:** a, b, c, out
- **Test idea:** Drive a, b, c through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = a | b | c.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-072 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/072-kmap2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/072-kmap2.sv)
- **Signals:** a, b, c, d, out
- **Test idea:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = c & d & (a | b ) | ~b & ~c | ~a & ~ d.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-073 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/073-kmap3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/073-kmap3.sv)
- **Signals:** a, b, c, d, out
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-074 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/074-kmap4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/074-kmap4.sv)
- **Signals:** a, b, c, d, out
- **Test idea:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = w1 & w2 & (a ^b) | w1 & d & ~(a ^ b ) | c & d & (a ^b)| c & w2 & ~(a ^ b).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-075 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/075-exams__ece241_2013_q2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/075-exams__ece241_2013_q2.sv)
- **Signals:** a, b, c, d, out_sop, out_pos
- **Test idea:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_sop, out_pos against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_sop = ~a & ~b & c & (d | ~d) | (a | ~a ) & (b | ~b ) & c&d; out_pos = c & (b | ~a) & (d | ~b).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-076 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/076-exams__m2014_q3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/076-exams__m2014_q3.sv)
- **Signals:** x, f
- **Test idea:** Drive x through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check f against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: f = x[4] & x[2] | x[3] & ~x[1].
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-077 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/077-exams__2012_q1g.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/077-exams__2012_q1g.sv)
- **Signals:** x, f
- **Test idea:** Drive x through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check f against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: f = ~x[1] & x[3] | ~x[2] & ~x[4] | x[3] & x[4] & x[2].
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-078 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/078-exams__ece241_2014_q3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/078-exams__ece241_2014_q3.sv)
- **Signals:** c, d, mux_in
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-079 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/079-dff.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/079-dff.sv)
- **Signals:** clk, d, q
- **Test idea:** For top_module, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-080 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/080-dff8.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/080-dff8.sv)
- **Signals:** clk, d, q
- **Test idea:** For top_module, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-081 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/081-dff8r.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/081-dff8r.sv)
- **Signals:** clk, reset, d, q
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-082 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/082-dff8p.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/082-dff8p.sv)
- **Signals:** clk, reset, d, q
- **Test idea:** For top_module, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: negedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-083 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/083-dff8ar.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/083-dff8ar.sv)
- **Signals:** clk, areset, d, q
- **Test idea:** For top_module, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge areset.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-084 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/084-dff16e.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/084-dff16e.sv)
- **Signals:** clk, resetn, byteena, d, q
- **Test idea:** For top_module, initialize through its reset/load path, then vary byteena, d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-085 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/085-exams__m2014_q4a.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/085-exams__m2014_q4a.sv)
- **Signals:** d, ena, q
- **Test idea:** Drive d, ena through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check q against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-086 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/086-exams__m2014_q4b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/086-exams__m2014_q4b.sv)
- **Signals:** clk, d, ar, q
- **Test idea:** For top_module, initialize through its reset/load path, then vary d, ar before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge ar.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-087 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/087-exams__m2014_q4c.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/087-exams__m2014_q4c.sv)
- **Signals:** clk, d, r, q
- **Test idea:** For top_module, initialize through its reset/load path, then vary d, r before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-088 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 03/088-exams__m2014_q4d.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/088-exams__m2014_q4d.sv)
- **Signals:** clk, in, out
- **Test idea:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-089 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/089-mt2015_muxdff.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/089-mt2015_muxdff.sv)
- **Signals:** clk, L, r_in, q_in, Q
- **Test idea:** For top_module, initialize through its reset/load path, then vary L, r_in, q_in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check Q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-090 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/090-exams__2014_q4a.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/090-exams__2014_q4a.sv)
- **Signals:** clk, w, R, E, L, Q
- **Test idea:** For top_module, initialize through its reset/load path, then vary w, R, E, L before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check Q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-091 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/091-exams__ece241_2014_q4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/091-exams__ece241_2014_q4.sv)
- **Signals:** clk, x, z
- **Test idea:** For top_module, initialize through its reset/load path, then vary x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: z = ~(q1 | q2 | q3).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-092 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/092-exams__ece241_2013_q7.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/092-exams__ece241_2013_q7.sv)
- **Signals:** clk, j, k, Q
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-093 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/093-edgedetect.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/093-edgedetect.sv)
- **Signals:** clk, in, pedge
- **Test idea:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check pedge only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-094 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/094-edgedetect2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/094-edgedetect2.sv)
- **Signals:** clk, in, anyedge
- **Test idea:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check anyedge only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-095 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/095-edgecapture.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/095-edgecapture.sv)
- **Signals:** clk, reset, in, out
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-096 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/096-dualedge.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/096-dualedge.sv)
- **Signals:** clk, d, q
- **Test idea:** For top_module, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, negedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: q = (clk) ? pos:neg.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-097 — Reset, rollover and control priority

- **Block / priority / initial status:** Counter / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/097-count15.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/097-count15.sv)
- **Signals:** clk, reset, q
- **Test idea:** Initialize top_module; test every enable/load/direction combination in clk, reset. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** q follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs. Source mapping: q = count.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-098 — Reset, rollover and control priority

- **Block / priority / initial status:** Counter / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/098-count10.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/098-count10.sv)
- **Signals:** clk, reset, q
- **Test idea:** Initialize top_module; test every enable/load/direction combination in clk, reset. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** q follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs. Source mapping: q = count.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-099 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/099-count1to10.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/099-count1to10.sv)
- **Signals:** clk, reset, q
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-100 — Reset, rollover and control priority

- **Block / priority / initial status:** Counter / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/100-countslow.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/100-countslow.sv)
- **Signals:** clk, slowena, reset, q
- **Test idea:** Initialize top_module; test every enable/load/direction combination in clk, slowena, reset. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** q follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs. Source mapping: q = count.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-101 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/101-shift4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/101-shift4.sv)
- **Signals:** clk, areset, load, ena, data, q
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-102 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/102-rotate100.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/102-rotate100.sv)
- **Signals:** clk, load, ena, data, q
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-103 — Direction, load and boundary bits

- **Block / priority / initial status:** Shift/rotate / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/103-shift18.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/103-shift18.sv)
- **Signals:** clk, load, ena, amount, data, q
- **Test idea:** Drive clk, load, ena, amount, data with walking-one patterns at both ends; exercise every shift amount/direction and simultaneous load/enable controls.
- **Expected result:** q preserves the defined bit order and delay. Check zero-fill, sign-fill or rotation separately as specified by this source; load/hold priority and bits shifted out must match the contract.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-104 — Seed, recurrence and repeat period

- **Block / priority / initial status:** LFSR / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/104-lfsr5.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/104-lfsr5.sv)
- **Signals:** clk, reset, q
- **Test idea:** Reset/load the documented nonzero seed; record q for a complete small-width sequence and repeat after reset. Also test enable holds if present and the zero-seed behavior.
- **Expected result:** The sequence follows the declared tap polynomial and shift direction. A claimed maximal n-bit LFSR visits 2^n-1 distinct nonzero states before repeating; measure the actual period rather than assuming it. Fibonacci and Galois forms need not be bit-for-bit identical.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-105 — Seed, recurrence and repeat period

- **Block / priority / initial status:** LFSR / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/105-mt2015_lfsr.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/105-mt2015_lfsr.sv)
- **Signals:** SW, KEY, LEDR
- **Test idea:** Reset/load the documented nonzero seed; record LEDR for a complete small-width sequence and repeat after reset. Also test enable holds if present and the zero-seed behavior.
- **Expected result:** The sequence follows the declared tap polynomial and shift direction. A claimed maximal n-bit LFSR visits 2^n-1 distinct nonzero states before repeating; measure the actual period rather than assuming it. Fibonacci and Galois forms need not be bit-for-bit identical. Source mapping: LEDR = {q2,q1,q0}.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-106 — Define and implement top_module

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/106-lfsr32.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/106-lfsr32.sv)
- **Signals:** clk, reset, q
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### HDL-107 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 04/107-exams__m2014_q4k.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/107-exams__m2014_q4k.sv)
- **Signals:** clk, resetn, in, out
- **Test idea:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: out = q4.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-108 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 05/108-exams__2014_q4b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/108-exams__2014_q4b.sv)
- **Signals:** SW, KEY, LEDR, clk, w, R, E, L, Q
- **Test idea:** For top_module, MUXDFF, initialize through its reset/load path, then vary SW, KEY before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check LEDR only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-109 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 05/109-exams__ece241_2013_q12.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/109-exams__ece241_2013_q12.sv)
- **Signals:** clk, enable, S, A, B, C, Z
- **Test idea:** For top_module, initialize through its reset/load path, then vary enable, S, A, B, C before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check Z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-110 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 05/110-fsm1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/110-fsm1.sv)
- **Signals:** clk, areset, in, out
- **Test idea:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge areset.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: out = (state == A).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-111 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 05/111-fsm1s.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/111-fsm1s.sv)
- **Signals:** clk, reset, in, out
- **Test idea:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: out = (present_state == B).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-112 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 05/112-fsm2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/112-fsm2.sv)
- **Signals:** clk, areset, j, k, out
- **Test idea:** For top_module, initialize through its reset/load path, then vary j, k before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge areset.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: out = (state == ON).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-113 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 05/113-fsm2s.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/113-fsm2s.sv)
- **Signals:** clk, reset, j, k, out
- **Test idea:** For top_module, initialize through its reset/load path, then vary j, k before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: out = (state == ON).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-114 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 05/114-fsm3comb.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/114-fsm3comb.sv)
- **Signals:** in, state, next_state, out
- **Test idea:** Drive in, state through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check next_state, out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = (state==D).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-115 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 05/115-fsm3onehot.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/115-fsm3onehot.sv)
- **Signals:** in, state, next_state, out
- **Test idea:** Drive in, state through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check next_state, out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: next_state[A] = ~in & (state[A] | state[C]); next_state[B] = in & (state[A] | state[B] | state[D]); next_state[C] = ~in & (state[B] | state[D]); next_state[D] = in & state[C]; out = state[D].
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-116 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 05/116-fsm3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/116-fsm3.sv)
- **Signals:** clk, in, areset, out
- **Test idea:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge areset.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: out = (state == D).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-117 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 05/117-fsm3s.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/117-fsm3s.sv)
- **Signals:** clk, in, reset, out
- **Test idea:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: out = (state == D).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-118 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 05/118-exams__ece241_2013_q4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/118-exams__ece241_2013_q4.sv)
- **Signals:** clk, reset, s, fr3, fr2, fr1, dfr
- **Test idea:** For top_module, initialize through its reset/load path, then vary s before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check fr3, fr2, fr1, dfr only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-119 — Direction, priority and fall boundaries

- **Block / priority / initial status:** Lemmings FSM / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 05/119-lemmings1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/119-lemmings1.sv)
- **Signals:** clk, areset, bump_left, bump_right, walk_left, walk_right
- **Test idea:** Exercise clk, areset, bump_left, bump_right, walk_left, walk_right: both bumpers, every direction, loss/restoration of ground, digging where present, and reset from every behavior. In lemmings4 use falls of 19,20,21 and more than 32 clocks, including after digging.
- **Expected result:** Reset walks left. Only the bumper in the current direction turns walking. Falling overrides walking; digging has its specified priority. Check mutually exclusive outputs, landing direction and the fatal-fall threshold without counter wrap resurrecting the character. Source mapping: walk_left = (state == left); walk_right = (state == right).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-120 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/121-exams__2013_q2bfsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/121-exams__2013_q2bfsm.sv)
- **Signals:** clk, resetn, x, y, f, g
- **Test idea:** For top_module, initialize through its reset/load path, then vary x, y before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check f, g only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: f = (state == B); g = (state == F) || (state == G) || (state == H).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-121 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/122-bugs_mux2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/122-bugs_mux2.sv)
- **Signals:** sel, a, b, out
- **Test idea:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** out equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings. Source mapping: out = sel ? a : b.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-122 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/123-bugs_nand3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/123-bugs_nand3.sv)
- **Signals:** a, b, c, out
- **Test idea:** Drive a, b, c through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-123 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/124-bugs_mux4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/124-bugs_mux4.sv)
- **Signals:** sel, a, b, c, d, out
- **Test idea:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** out equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-124 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/125-bugs_addsubz.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/125-bugs_addsubz.sv)
- **Signals:** do_sub, a, b, out, result_is_zero
- **Test idea:** Exercise do_sub, a, b at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every out, result_is_zero bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different. 
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-125 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/126-bugs_case.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/126-bugs_case.sv)
- **Signals:** code, out, valid
- **Test idea:** Drive code through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out, valid against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-126 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/127-sim__circuit1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/127-sim__circuit1.sv)
- **Signals:** a, b, q
- **Test idea:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check q against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: q = a & b.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-127 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/128-sim__circuit2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/128-sim__circuit2.sv)
- **Signals:** a, b, c, d, q
- **Test idea:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check q against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: q = ~(a ^ b ^ c ^ d).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-128 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/129-sim__circuit3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/129-sim__circuit3.sv)
- **Signals:** a, b, c, d, q
- **Test idea:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check q against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: q = (d & (a | b)) | (c & (a | b)).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-129 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/130-sim__circuit4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/130-sim__circuit4.sv)
- **Signals:** a, b, c, d, q
- **Test idea:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check q against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: q = b | c.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-130 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/131-sim__circuit5.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/131-sim__circuit5.sv)
- **Signals:** a, b, c, d, e, q
- **Test idea:** Drive a, b, c, d, e through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check q against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-131 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/132-sim__circuit6.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/132-sim__circuit6.sv)
- **Signals:** a, q
- **Test idea:** Drive a through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check q against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-132 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/133-sim__circuit7.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/133-sim__circuit7.sv)
- **Signals:** clk, a, q
- **Test idea:** For top_module, initialize through its reset/load path, then vary a before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-133 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/134-sim__circuit8.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/134-sim__circuit8.sv)
- **Signals:** clock, a, p, q
- **Test idea:** For top_module, initialize through its reset/load path, then vary a before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: negedge clock.
- **Expected result:** Check p, q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-134 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/135-sim__circuit9.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/135-sim__circuit9.sv)
- **Signals:** clk, a, q
- **Test idea:** For top_module, initialize through its reset/load path, then vary a before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: q = count.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-135 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/136-sim__circuit10.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/136-sim__circuit10.sv)
- **Signals:** clk, a, b, q, state
- **Test idea:** For top_module, initialize through its reset/load path, then vary a, b before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q, state only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: q = a ^ b ^ state.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-136 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 06/138-tb__tb1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/138-tb__tb1.sv)
- **Signals:** A, B
- **Test idea:** Drive the declared controls through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check A, B against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-137 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 07/142-exams__ece241_2013_q8.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2007/142-exams__ece241_2013_q8.sv)
- **Signals:** clk, aresetn, x, z
- **Test idea:** For top_module, initialize through its reset/load path, then vary x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, negedge aresetn.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: z = (state == S10) && x.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-138 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 08/143-exams__ece241_2014_q7a.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2008/143-exams__ece241_2014_q7a.sv)
- **Signals:** clk, reset, enable, Q, c_enable, c_load, c_d
- **Test idea:** For top_module, initialize through its reset/load path, then vary enable before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: inspect the instantiated modules for clock edge and reset polarity.
- **Expected result:** Check Q, c_enable, c_load, c_d only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: c_enable = enable; c_load = reset | (enable & (Q == 4'd12)); c_d = 4'd1.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-139 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 09/144-exams__ece241_2014_q7b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/144-exams__ece241_2014_q7b.sv)
- **Signals:** clk, reset, OneHertz, c_enable
- **Test idea:** For top_module, initialize through its reset/load path, then vary available controls before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: inspect the instantiated modules for clock edge and reset polarity.
- **Expected result:** Check OneHertz, c_enable only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: c_enable[0] = 1'b1; c_enable[1] = (lsb == 4'd9); c_enable[2] = (lsb == 4'd9) && (middle == 4'd9); OneHertz = (msb == 4'd9) && (middle == 4'd9) && (lsb == 4'd9).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-140 — Reset, rollover and control priority

- **Block / priority / initial status:** Counter / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 09/145-countbcd.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/145-countbcd.sv)
- **Signals:** clk, reset, ena, q
- **Test idea:** Initialize top_module; test every enable/load/direction combination in clk, reset. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** ena, q follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs. Source mapping: ena[1] = (digit0 == 4'd9); ena[2] = (digit0 == 4'd9) && (digit1 == 4'd9); ena[3] = (digit0 == 4'd9) && (digit1 == 4'd9) && (digit2 == 4'd9); q = {digit3, digit2, digit1, digit0}.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-141 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 09/146-count_clock.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/146-count_clock.sv)
- **Signals:** clk, reset, ena, pm, hh, mm, ss
- **Test idea:** For top_module, initialize through its reset/load path, then vary ena before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check pm, hh, mm, ss only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-142 — Reset, rollover and control priority

- **Block / priority / initial status:** Counter / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 09/147-exams__review2015_count1k.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/147-exams__review2015_count1k.sv)
- **Signals:** clk, reset, q
- **Test idea:** Initialize top_module; test every enable/load/direction combination in clk, reset. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** q follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs. Source mapping: q = count.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-143 — Direction, load and boundary bits

- **Block / priority / initial status:** Shift/rotate / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 09/148-exams__review2015_shiftcount.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/148-exams__review2015_shiftcount.sv)
- **Signals:** clk, shift_ena, count_ena, data, q
- **Test idea:** Drive clk, shift_ena, count_ena, data with walking-one patterns at both ends; exercise every shift amount/direction and simultaneous load/enable controls.
- **Expected result:** q preserves the defined bit order and delay. Check zero-fill, sign-fill or rotation separately as specified by this source; load/hold priority and bits shifted out must match the contract. Source mapping: q = shift_count.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-144 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 09/149-exams__review2015_fsmseq.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/149-exams__review2015_fsmseq.sv)
- **Signals:** clk, reset, data, start_shifting
- **Test idea:** For top_module, initialize through its reset/load path, then vary data before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check start_shifting only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: start_shifting = (state == DONE).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-145 — Direction, load and boundary bits

- **Block / priority / initial status:** Shift/rotate / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 09/150-exams__review2015_fsmshift.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/150-exams__review2015_fsmshift.sv)
- **Signals:** clk, reset, shift_ena
- **Test idea:** Drive clk, reset with walking-one patterns at both ends; exercise every shift amount/direction and simultaneous load/enable controls.
- **Expected result:** shift_ena preserves the defined bit order and delay. Check zero-fill, sign-fill or rotation separately as specified by this source; load/hold priority and bits shifted out must match the contract. Source mapping: shift_ena = (count < 3'd4).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-146 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 09/151-step_one.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/151-step_one.sv)
- **Signals:** one
- **Test idea:** Drive the declared controls through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check one against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: one = 1'b1.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-147 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 09/152-zero.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/152-zero.sv)
- **Signals:** zero
- **Test idea:** Drive the declared controls through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check zero against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: zero = 1'b0.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-148 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 09/153-exams__review2015_fsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/153-exams__review2015_fsm.sv)
- **Signals:** clk, reset, data, done_counting, ack, shift_ena, counting, done
- **Test idea:** For top_module, initialize through its reset/load path, then vary data, done_counting, ack before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check shift_ena, counting, done only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: shift_ena = (state == B0) || (state == B1) || (state == B2) || (state == B3); counting = (state == COUNT); done = (state == WAIT).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-149 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 09/154-exams__review2015_fancytimer.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/154-exams__review2015_fancytimer.sv)
- **Signals:** clk, reset, data, ack, count, counting, done
- **Test idea:** For top_module, initialize through its reset/load path, then vary data, ack before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check count, counting, done only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: count = count_remaining; counting = (state == COUNT); done = (state == WAIT).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-150 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 10/155-exams__2014_q3fsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2010/155-exams__2014_q3fsm.sv)
- **Signals:** clk, reset, s, w, z
- **Test idea:** For top_module, initialize through its reset/load path, then vary s, w before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-151 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 10/156-exams__2014_q3bfsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2010/156-exams__2014_q3bfsm.sv)
- **Signals:** clk, reset, x, z
- **Test idea:** For top_module, initialize through its reset/load path, then vary x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: z = (state == S3) || (state == S4).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-152 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 10/157-exams__2014_q3c.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2010/157-exams__2014_q3c.sv)
- **Signals:** clk, y, x, Y0, z
- **Test idea:** For top_module, initialize through its reset/load path, then vary y, x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: inspect the instantiated modules for clock edge and reset polarity.
- **Expected result:** Check Y0, z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: Y0 = (~x & (y[0] | y[2])) | ( x & ~y[0] & ~y[2]); z = (y == 3'b011) || (y == 3'b100).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-153 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 10/158-exams__m2014_q6c.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2010/158-exams__m2014_q6c.sv)
- **Signals:** y, w, Y2, Y4
- **Test idea:** Drive y, w through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check Y2, Y4 against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: Y2 = y[1] & ~w; Y4 = w & (y[2] | y[3] | y[5] | y[6]).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-154 — Direction, priority and fall boundaries

- **Block / priority / initial status:** Lemmings FSM / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 11/159-lemmings2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2011/159-lemmings2.sv)
- **Signals:** clk, areset, bump_left, bump_right, ground, walk_left, walk_right, aaah
- **Test idea:** Exercise clk, areset, bump_left, bump_right, ground, walk_left, walk_right, aaah: both bumpers, every direction, loss/restoration of ground, digging where present, and reset from every behavior. In lemmings4 use falls of 19,20,21 and more than 32 clocks, including after digging.
- **Expected result:** Reset walks left. Only the bumper in the current direction turns walking. Falling overrides walking; digging has its specified priority. Check mutually exclusive outputs, landing direction and the fatal-fall threshold without counter wrap resurrecting the character. Source mapping: walk_left = (state == left); walk_right = (state == right); aaah = (state == fallRight) || (state == fallLeft).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-155 — Direction, priority and fall boundaries

- **Block / priority / initial status:** Lemmings FSM / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 11/160-lemmings3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2011/160-lemmings3.sv)
- **Signals:** clk, areset, bump_left, bump_right, ground, dig, walk_left, walk_right, aaah, digging
- **Test idea:** Exercise clk, areset, bump_left, bump_right, ground, dig, walk_left, walk_right, aaah, digging: both bumpers, every direction, loss/restoration of ground, digging where present, and reset from every behavior. In lemmings4 use falls of 19,20,21 and more than 32 clocks, including after digging.
- **Expected result:** Reset walks left. Only the bumper in the current direction turns walking. Falling overrides walking; digging has its specified priority. Check mutually exclusive outputs, landing direction and the fatal-fall threshold without counter wrap resurrecting the character. Source mapping: walk_left = (state == left); walk_right = (state == right); aaah = (state == digWorkFallLeft) || (state == digWorkFallRight) || (state == fallRight) || (state == fallLeft); digging = (state == digWorkFromLeft) || (state == digWorkFromRight).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-156 — Direction, priority and fall boundaries

- **Block / priority / initial status:** Lemmings FSM / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 12/161-lemmings4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2012/161-lemmings4.sv)
- **Signals:** clk, areset, bump_left, bump_right, ground, dig, walk_left, walk_right, aaah, digging
- **Test idea:** Exercise clk, areset, bump_left, bump_right, ground, dig, walk_left, walk_right, aaah, digging: both bumpers, every direction, loss/restoration of ground, digging where present, and reset from every behavior. In lemmings4 use falls of 19,20,21 and more than 32 clocks, including after digging.
- **Expected result:** Reset walks left. Only the bumper in the current direction turns walking. Falling overrides walking; digging has its specified priority. Check mutually exclusive outputs, landing direction and the fatal-fall threshold without counter wrap resurrecting the character. Source mapping: walk_left = (state == left); walk_right = (state == right); aaah = (state == digWorkFallLeft) || (state == digWorkFallRight) || (state == fallRight) || (state == fallLeft); digging = (state == digWorkFromLeft) || (state == digWorkFromRight).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-157 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 12/162-fsm_onehot.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2012/162-fsm_onehot.sv)
- **Signals:** in, state, next_state, out1, out2
- **Test idea:** Drive in, state through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check next_state, out1, out2 against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: next_state[0] = ~in & (S0 | S1 | S2 | S3 | S4 | S7 | S8 | S9); next_state[1] = in & (S0 | S8 | S9); next_state[2] = in & S1; next_state[3] = in & S2; next_state[4] = in & S3; next_state[5] = in & S4; next_state[6] = in & S5; next_state[7] = in & (S6 | S7); next_state[8] = ~in & S5; next_state[9] = ~in & S6; out1 = S8 | S9; out2 = S7 | S9.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-158 — Frames, byte order and recovery

- **Block / priority / initial status:** Serial receiver exercise / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 12/163-fsm_serial.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2012/163-fsm_serial.sv)
- **Signals:** clk, in, reset, done
- **Test idea:** Use clk, in, reset, done to send start 0, eight LSB-first data bits, and stop 1, then a bad stop and back-to-back frames. For the parity variant include good/bad odd parity.
- **Expected result:** done is asserted only for a complete accepted frame; out_byte, where present, equals the eight data bits. Bad stop requires idle-high recovery. A parity mismatch must suppress done in the parity variant. Source mapping: done = (state == completed).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-159 — Frames, byte order and recovery

- **Block / priority / initial status:** Serial receiver exercise / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 12/164-fsm_serialdata.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2012/164-fsm_serialdata.sv)
- **Signals:** clk, in, reset, out_byte, done
- **Test idea:** Use clk, in, reset, out_byte, done to send start 0, eight LSB-first data bits, and stop 1, then a bad stop and back-to-back frames. For the parity variant include good/bad odd parity.
- **Expected result:** done is asserted only for a complete accepted frame; out_byte, where present, equals the eight data bits. Bad stop requires idle-high recovery. A parity mismatch must suppress done in the parity variant. Source mapping: done = (state == completed); out_byte = latch.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-160 — Frames, byte order and recovery

- **Block / priority / initial status:** Serial receiver exercise / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 13/165-fsm_serialdp.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/165-fsm_serialdp.sv)
- **Signals:** clk, in, reset, out_byte, done
- **Test idea:** Use clk, in, reset, out_byte, done to send start 0, eight LSB-first data bits, and stop 1, then a bad stop and back-to-back frames. For the parity variant include good/bad odd parity.
- **Expected result:** done is asserted only for a complete accepted frame; out_byte, where present, equals the eight data bits. Bad stop requires idle-high recovery. A parity mismatch must suppress done in the parity variant. Source mapping: done = (state == completed); out_byte = latch.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-161 — Header alignment and byte assembly

- **Block / priority / initial status:** Three-byte packet / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 13/166-fsm_ps2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/166-fsm_ps2.sv)
- **Signals:** clk, in, reset, done
- **Test idea:** Drive clk, in, reset, done; send nonheader bytes with in[3]=0, then three-byte packets beginning with in[3]=1. Vary bit 3 in payload bytes and send packets back-to-back.
- **Expected result:** done occurs once per accepted three-byte packet. The data variant assembles first byte at [23:16], second [15:8], third [7:0] and outputs zero outside done. Payload bit 3 does not restart a packet. Source mapping: done = (state == donee).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-162 — Header alignment and byte assembly

- **Block / priority / initial status:** Three-byte packet / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 13/167-fsm_ps2data.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/167-fsm_ps2data.sv)
- **Signals:** clk, in, reset, out_bytes, done
- **Test idea:** Drive clk, in, reset, out_bytes, done; send nonheader bytes with in[3]=0, then three-byte packets beginning with in[3]=1. Vary bit 3 in payload bytes and send packets back-to-back.
- **Expected result:** done occurs once per accepted three-byte packet. The data variant assembles first byte at [23:16], second [15:8], third [7:0] and outputs zero outside done. Payload bit 3 does not restart a packet. Source mapping: done = (state == donee); out_bytes = done ? latching : 24'd0.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-163 — Stuffed zero, flag and error boundaries

- **Block / priority / initial status:** Serial run-length detector / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 13/168-fsm_hdlc.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/168-fsm_hdlc.sv)
- **Signals:** clk, reset, in, disc, flag, err
- **Test idea:** Using clk, reset, in, disc, flag, err, send runs of four, five, six, seven and eight ones followed by zero, separated by idle zeros and reset.
- **Expected result:** A zero after five ones raises disc; a zero after six raises flag; seven consecutive ones enter err, which holds while ones continue. Check the documented Mealy/Moore timing independently for each variant. Source mapping: disc = (state == discc); flag = (state == flagg); err = (state == errr).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-164 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 13/169-exams__ece241_2014_q5a.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/169-exams__ece241_2014_q5a.sv)
- **Signals:** clk, areset, x, z
- **Test idea:** For top_module, initialize through its reset/load path, then vary x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge areset.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: z = (state == s1).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-165 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 13/170-exams__ece241_2014_q5b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/170-exams__ece241_2014_q5b.sv)
- **Signals:** clk, areset, x, z
- **Test idea:** For top_module, initialize through its reset/load path, then vary x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge areset.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: z = zr.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-166 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 13/171-exams__m2014_q6b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/171-exams__m2014_q6b.sv)
- **Signals:** y, w, Y2
- **Test idea:** Drive y, w through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check Y2 against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: Y2 = ((~y[2] & y[1]) | (w & y[3]) | (w & y[2] & ~y[1])).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-167 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 13/172-exams__m2014_q6.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/172-exams__m2014_q6.sv)
- **Signals:** clk, reset, w, z
- **Test idea:** For top_module, initialize through its reset/load path, then vary w before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: z = (state == E) || (state == F).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-168 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 13/173-exams__2012_q2fsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/173-exams__2012_q2fsm.sv)
- **Signals:** clk, reset, w, z
- **Test idea:** For top_module, initialize through its reset/load path, then vary w before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: z = (state == E) || (state == F).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-169 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 13/174-exams__2012_q2b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/174-exams__2012_q2b.sv)
- **Signals:** y, w, Y1, Y3
- **Test idea:** Drive y, w through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check Y1, Y3 against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: Y3 = ~w & (y[1] | y[2] | y[4] | y[5]); Y1 = w & y[0].
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-170 — Load, edge cells and simultaneous update

- **Block / priority / initial status:** Cellular automaton / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 14/175-rule90.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2014/175-rule90.sv)
- **Signals:** clk, load, data, q
- **Test idea:** Load data with a single central one, ones at both ends and alternating bits; step clk and check every q bit against a previous-array reference.
- **Expected result:** Rule 90 uses XOR of old left/right neighbors; outside the 512-cell ends is zero. load takes priority.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-171 — Load, edge cells and simultaneous update

- **Block / priority / initial status:** Cellular automaton / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 14/176-rule110.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2014/176-rule110.sv)
- **Signals:** clk, load, data, q
- **Test idea:** Load data with a single central one, ones at both ends and alternating bits; step clk and check every q bit against a previous-array reference.
- **Expected result:** Rule 110 output for neighborhoods 111..000 is 0,1,1,0,1,1,1,0; outside neighbors are zero. All cells use the old array and load takes priority.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-172 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 14/177-exams__2013_q2afsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2014/177-exams__2013_q2afsm.sv)
- **Signals:** clk, resetn, r, g
- **Test idea:** For top_module, initialize through its reset/load path, then vary r before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check g only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: g[1] = (state == s1); g[2] = (state == s2); g[3] = (state == s3).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-173 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 14/178-exams__review2015_fsmonehot.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2014/178-exams__review2015_fsmonehot.sv)
- **Signals:** d, done_counting, ack, state, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena
- **Test idea:** Drive d, done_counting, ack, state through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: B3_next = state[B2]; S_next = (state[S] & ~d) | (state[S1] & ~d) | (state[S110] & ~d) | (state[Wait] & ack); S1_next = state[S] & d; Count_next = state[B3] | (state[Count] & ~done_counting); Wait_next = (state[Count] & done_counting) | (state[Wait] & ~ack); done = state[Wait]; counting = state[Count]; shift_ena = state[B0] | state[B1] | state[B2] | state[B3].
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-174 — Still life, oscillator and toroidal edges

- **Block / priority / initial status:** Game of Life / P1 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 14/179-conwaylife.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2014/179-conwaylife.sv)
- **Signals:** clk, load, data, q
- **Test idea:** Load data with an empty board, a 2x2 block, a blinker and a pattern crossing row/column 15-to-0. Step clk and compare all 256 q bits.
- **Expected result:** Each cell survives with two or three live neighbors; a dead cell is born with three. Neighbors wrap on the 16x16 torus, and every next cell is calculated from the same prior board.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-175 — Stuffed zero, flag and error boundaries

- **Block / priority / initial status:** Serial run-length detector / P1 / Pending
- **Source:** [HDLBits Attempt 2/internal/Discussion Drafts/fsm_hdlc_discussion.v](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%202/internal/Discussion%20Drafts/fsm_hdlc_discussion.v)
- **Signals:** clk, reset, in, disc, flag, err
- **Test idea:** Using clk, reset, in, disc, flag, err, send runs of four, five, six, seven and eight ones followed by zero, separated by idle zeros and reset.
- **Expected result:** A zero after five ones raises disc; a zero after six raises flag; seven consecutive ones enter err, which holds while ones continue. Check the documented Mealy/Moore timing independently for each variant. Source mapping: disc = discReg; flag = flagReg; err = errReg.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-176 — Stuffed zero, flag and error boundaries

- **Block / priority / initial status:** Serial run-length detector / P1 / Pending
- **Source:** [HDLBits Attempt 2/internal/Discussion Drafts/fsm_hdlc_working_moore.v](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%202/internal/Discussion%20Drafts/fsm_hdlc_working_moore.v)
- **Signals:** clk, reset, in, disc, flag, err
- **Test idea:** Using clk, reset, in, disc, flag, err, send runs of four, five, six, seven and eight ones followed by zero, separated by idle zeros and reset.
- **Expected result:** A zero after five ones raises disc; a zero after six raises flag; seven consecutive ones enter err, which holds while ones continue. Check the documented Mealy/Moore timing independently for each variant. Source mapping: disc = (state == discardedFinal); flag = (state == flaggedFinal); err = (state == errorFound).
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-177 — Still life, oscillator and toroidal edges

- **Block / priority / initial status:** Game of Life / P1 / Pending
- **Source:** [HDLBits Attempt 2/internal/Documentation/conway_reference.v](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%202/internal/Documentation/conway_reference.v)
- **Signals:** clk, load, data, q
- **Test idea:** Load data with an empty board, a 2x2 block, a blinker and a pattern crossing row/column 15-to-0. Step clk and compare all 256 q bits.
- **Expected result:** Each cell survives with two or three live neighbors; a dead cell is born with three. Neighbors wrap on the 16x16 torus, and every next cell is calculated from the same prior board.
- **Note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

#### HDL-178 — Compile isolated tops and record reproducible evidence

- **Block / priority / initial status:** Build and evidence / P0 / Pending
- **Source:** [HDLBits Attempt 1/study/solutions/Day 01/003-notgate.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/003-notgate.sv)
- **Signals:** Top/module names and port declarations in the RTL map
- **Test idea:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.

### systemverilog-from-beginning

#### SV-001 — Reset and first usable cycle

- **Block / priority / initial status:** Coverage FIFO / P0 / Pending
- **Source:** [SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Hold wr_en=rd_en=0. Assert rst=1, clock the design, then release reset away from the active edge.
- **Expected result:** After the specified reset event: empty=1 and full=0; pointers/count are reset. dout holds the last accepted read while no read is accepted, and resets to zero.

#### SV-002 — Single write then single read

- **Block / priority / initial status:** Coverage FIFO / P0 / Pending
- **Source:** [SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Write A5 with wr_en=1 while full=0; disable write; request one read with rd_en=1 while empty=0.
- **Expected result:** empty clears after the write and asserts after the read. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer. Exactly one word is transferred.

#### SV-003 — Ordering and mixed data

- **Block / priority / initial status:** Coverage FIFO / P0 / Pending
- **Source:** [SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Write 10,22,35,48 with gaps, then drain using isolated and consecutive rd_en requests.
- **Expected result:** Read values are 10,22,35,48 in that order. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### SV-004 — Fill to capacity and reject overflow

- **Block / priority / initial status:** Coverage FIFO / P0 / Pending
- **Source:** [SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** With rd_en=0, issue exactly DEPTH writes (2^aw (default 256)); check one below full and full. Attempt three further writes with distinct data, then drain.
- **Expected result:** full asserts only after the last available slot is used. Extra writes cannot move the write pointer or replace queued data. Draining returns the original DEPTH values.

#### SV-005 — Drain to empty and reject underflow

- **Block / priority / initial status:** Coverage FIFO / P0 / Pending
- **Source:** [SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Fill and drain exactly DEPTH accepted reads. Keep rd_en=1 for three additional clocks with wr_en=0.
- **Expected result:** empty asserts on the last accepted pop; extra reads do not advance the read pointer or change occupancy. dout holds the last accepted read while no read is accepted, and resets to zero.

#### SV-006 — Both enables in the middle

- **Block / priority / initial status:** Coverage FIFO / P0 / Pending
- **Source:** [SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Prefill to half capacity. Keep wr_en=rd_en=1 for at least 2*DEPTH clocks with a changing din.
- **Expected result:** Both operations are accepted on each edge and occupancy stays constant. The stream remains ordered across pointer wraps. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### SV-007 — Both enables when empty

- **Block / priority / initial status:** Coverage FIFO / P0 / Pending
- **Source:** [SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Reset empty, then assert wr_en=rd_en=1 for one edge with din=3C.
- **Expected result:** Only the write is accepted because the pre-edge empty=1. Occupancy becomes one. No same-edge bypass/pop of 3C is allowed.

#### SV-008 — Both enables when full

- **Block / priority / initial status:** Coverage FIFO / P0 / Pending
- **Source:** [SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Fill to capacity; assert wr_en=rd_en=1 for one edge with a new din.
- **Expected result:** Only the read is accepted because pre-edge full=1; the write is blocked and occupancy becomes DEPTH-1. Resend the new word later if it must be stored.

#### SV-009 — Idle and output validity

- **Block / priority / initial status:** Coverage FIFO / P1 / Pending
- **Source:** [SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Pause both enables at empty, one word, half-full and full. Toggle din while idle.
- **Expected result:** Pointers/count and flags hold. dout holds the last accepted read while no read is accepted, and resets to zero.

#### SV-010 — Repeated wraparound

- **Block / priority / initial status:** Coverage FIFO / P1 / Pending
- **Source:** [SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Alternate fill/drain and mixed bursts until each pointer wraps at least four times. Use a sequence number for every accepted write.
- **Expected result:** No duplication, loss or reordering. Counts stay between zero and DEPTH; full and empty cannot both be true.

#### SV-011 — Reset with queued traffic

- **Block / priority / initial status:** Coverage FIFO / P1 / Pending
- **Source:** [SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Prefill, assert rst during traffic, then hold enables low through reset. Discard the software reference queue; release reset and write fresh values.
- **Expected result:** Old queued values are discarded logically. The first fresh drain returns only post-reset accepted writes. dout holds the last accepted read while no read is accepted, and resets to zero.

#### SV-012 — Random bursts with a reference queue

- **Block / priority / initial status:** Coverage FIFO / P2 / Pending
- **Source:** [SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Test idea:** Run 1000 or more edges for each of three recorded seeds. Bias requests toward empty/full and one-away states. Queue only writes accepted by pre-edge flags and dequeue only accepted reads.
- **Expected result:** Every accepted read matches the oldest reference word. End by draining and proving the reference queue empty. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.

#### SV-013 — Reset/load/direction priority and unused input

- **Block / priority / initial status:** Counter / P0 / Pending
- **Source:** [SV Functional Coverage/Projects/02-counter-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/02-counter-functional-coverage/design.sv)
- **Signals:** clk, rst, up, load, loadIn, x, y
- **Test idea:** Set rst and load together; then load with either up value; traverse 255->0 and 0->255. Toggle x independently.
- **Expected result:** Priority is rst then load then up/down. y wraps modulo 256. x is unused in this RTL and must not influence y.

#### SV-014 — One-hot and multiple-request priority

- **Block / priority / initial status:** Priority encoder / P0 / Pending
- **Source:** [SV Functional Coverage/Projects/04-priority-encoder-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/04-priority-encoder-functional-coverage/design.sv)
- **Signals:** x, y
- **Test idea:** Drive x=01,02,04,08,10,20,40,80, then simultaneous requests and x=0.
- **Expected result:** Intended y is the highest asserted x bit. The current RTL cases on y instead of x, so this directed test should expose the error. Define the zero-input convention separately (current default is Z).
- **Note:** Static source defect; no simulation run claimed.

#### SV-015 — Startup and frame capture

- **Block / priority / initial status:** SPI DAC / P0 / Blocked
- **Source:** [SV Functional Coverage/Projects/05-spi-transition-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/05-spi-transition-coverage/design.sv)
- **Signals:** clk, start, din, cs, mosi
- **Test idea:** Start a fresh simulation, hold start low, then request din=ABC and observe the two 32-bit transfers under cs.
- **Expected result:** Expected setup stream is 08000001, then payload 030ABC00, both MSB first. However state has no reset/initialization and can remain unknown; establish startup before claiming frame success.
- **Note:** No reset port and uninitialized enum state. Existing bench forcing/initialization must be explicit.

#### SV-016 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [SV Assertions/Codes/02-immediate-assertions-in-a-mux/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Assertions/Codes/02-immediate-assertions-in-a-mux/design.sv)
- **Signals:** a, b, c, d, sel, y
- **Test idea:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.

#### SV-017 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [SV Assertions/Codes/03-clocked-immediate-assertion-and-nba-timing/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Assertions/Codes/03-clocked-immediate-assertion-and-nba-timing/design.sv)
- **Signals:** d, rstn, clk, q, qbar
- **Test idea:** For dff, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q, qbar only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: q = temp_q; qbar = temp_qbar.

#### SV-018 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [SV Assertions/Projects/01-fsm-verification-with-sva/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Assertions/Projects/01-fsm-verification-with-sva/design.sv)
- **Signals:** clk, rst, x, y
- **Test idea:** For fsm, initialize through its reset/load path, then vary x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check y only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### SV-019 — Reset, rollover and control priority

- **Block / priority / initial status:** Counter / P1 / Pending
- **Source:** [SV Assertions/Projects/02-counter-assertions-with-bind/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Assertions/Projects/02-counter-assertions-with-bind/design.sv)
- **Signals:** clk, rst, up, dout
- **Test idea:** Initialize counter; test every enable/load/direction combination in clk, rst, up. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** dout follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs.

#### SV-020 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [SV Basics/Codes/30-fifo-transaction-and-weighted-constraints/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/30-fifo-transaction-and-weighted-constraints/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Test idea:** For sync_fifo, initialize through its reset/load path, then vary wr_en, rd_en, wr_data before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check rd_data, full, empty only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: full = (fifo_count == DEPTH); empty = (fifo_count == 0).

#### SV-021 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [SV Basics/Codes/40-interface-modport-and-virtual-interface/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/40-interface-modport-and-virtual-interface/design.sv)
- **Signals:** a, b, clk, sum
- **Test idea:** For add, initialize through its reset/load path, then vary a, b before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check sum only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### SV-022 — Arithmetic, carry/borrow and width

- **Block / priority / initial status:** Arithmetic / P1 / Pending
- **Source:** [SV Basics/Codes/41-layered-adder-testbench-and-object-copies/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/41-layered-adder-testbench-and-object-copies/design.sv)
- **Signals:** a, b, clk, sum
- **Test idea:** Exercise a, b, clk at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different. Respect the clocked latency and load/enable priorities.

#### SV-023 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [SV Basics/Codes/42-error-injection-with-inheritance/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/42-error-injection-with-inheritance/design.sv)
- **Signals:** a, b, clk, sum
- **Test idea:** For add, initialize through its reset/load path, then vary a, b before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check sum only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### SV-024 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [SV Basics/Codes/43-polymorphic-copy-error-injection/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/43-polymorphic-copy-error-injection/design.sv)
- **Signals:** a, b, clk, sum
- **Test idea:** For add, initialize through its reset/load path, then vary a, b before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check sum only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### SV-025 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [SV Basics/Codes/44-monitor-scoreboard-separate-mailboxes/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/44-monitor-scoreboard-separate-mailboxes/design.sv)
- **Signals:** a, b, clk, sum
- **Test idea:** For add, initialize through its reset/load path, then vary a, b before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check sum only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### SV-026 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [SV Functional Coverage/Codes/01-basic-coverpoints/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/01-basic-coverpoints/design.sv)
- **Signals:** a, b
- **Test idea:** Drive a through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check b against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: b = a.

#### SV-027 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [SV Functional Coverage/Codes/07-multiplexer-signal-coverpoints/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/07-multiplexer-signal-coverpoints/design.sv)
- **Signals:** a, b, c, d, sel, y
- **Test idea:** Drive a, b, c, d, sel through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### SV-028 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [SV Functional Coverage/Codes/09-fsm-state-coverage-and-report-timing/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/09-fsm-state-coverage-and-report-timing/design.sv)
- **Signals:** x, clk, rst, y
- **Test idea:** For fsm, initialize through its reset/load path, then vary x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check y only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### SV-029 — Every request, priorities and zero input

- **Block / priority / initial status:** Priority encoder / P1 / Pending
- **Source:** [SV Functional Coverage/Codes/14-wildcard-bins-casez-and-casex/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/14-wildcard-bins-casez-and-casex/design.sv)
- **Signals:** x, y
- **Test idea:** Apply each one-hot bit to x, then adjacent pairs, all ones and all zeros; sweep small input spaces.
- **Expected result:** y identifies the source-defined highest/lowest-priority active input; verify the direction explicitly. Check any valid output, and treat a specified X/Z zero-input result separately from valid binary encoding.

#### SV-030 — Every request, priorities and zero input

- **Block / priority / initial status:** Priority encoder / P1 / Pending
- **Source:** [SV Functional Coverage/Codes/14-wildcard-bins-casez-and-casex/verified-design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/14-wildcard-bins-casez-and-casex/verified-design.sv)
- **Signals:** x, y
- **Test idea:** Apply each one-hot bit to x, then adjacent pairs, all ones and all zeros; sweep small input spaces.
- **Expected result:** y identifies the source-defined highest/lowest-priority active input; verify the direction explicitly. Check any valid output, and treat a specified X/Z zero-input result separately from valid binary encoding.

#### SV-031 — Reset, rollover and control priority

- **Block / priority / initial status:** Counter / P1 / Pending
- **Source:** [SV Functional Coverage/Codes/15-counter-wildcard-bins-and-finite-reporting/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/15-counter-wildcard-bins-and-finite-reporting/design.sv)
- **Signals:** clk, en, y
- **Test idea:** Initialize counter; test every enable/load/direction combination in clk, en. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** y follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs.

#### SV-032 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [SV Functional Coverage/Codes/20-reusable-covergroup-alu-use-case/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/20-reusable-covergroup-alu-use-case/design.sv)
- **Signals:** a, b, opcode, y
- **Test idea:** Drive a, b, opcode through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### SV-033 — Input combinations and output mapping

- **Block / priority / initial status:** Combinational logic / P1 / Pending
- **Source:** [SV Functional Coverage/Codes/20-reusable-covergroup-alu-use-case/verified-design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/20-reusable-covergroup-alu-use-case/verified-design.sv)
- **Signals:** a, b, opcode, y
- **Test idea:** Drive a, b, opcode through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.

#### SV-034 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [SV Functional Coverage/Codes/30-simple-transition-coverage-p1/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/30-simple-transition-coverage-p1/design.sv)
- **Signals:** clk, reset, d, d_out
- **Test idea:** For two_state_fsm, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge reset.
- **Expected result:** Check d_out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### SV-035 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [SV Functional Coverage/Codes/31-simple-transition-coverage-p2/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/31-simple-transition-coverage-p2/design.sv)
- **Signals:** clk, reset, d, d_out
- **Test idea:** For two_state_fsm, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge reset.
- **Expected result:** Check d_out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### SV-036 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [SV Functional Coverage/Projects/03-mux-8-to-1-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/03-mux-8-to-1-functional-coverage/design.sv)
- **Signals:** a, b, c, d, e, f, g, h, sel, y
- **Test idea:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.

#### SV-037 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [SV Functional Coverage/plates/section-10-projects/130-mux-8-to-1-p1/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/130-mux-8-to-1-p1/design.sv)
- **Signals:** data, select, y
- **Test idea:** Sweep select through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.

#### SV-038 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [SV Functional Coverage/plates/section-10-projects/131-mux-8-to-1-p2/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/131-mux-8-to-1-p2/design.sv)
- **Signals:** data, select, y
- **Test idea:** Sweep select through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.

#### SV-039 — Every select and unselected-input isolation

- **Block / priority / initial status:** Multiplexer / P1 / Pending
- **Source:** [SV Functional Coverage/plates/section-10-projects/132-mux-8-to-1-p3/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/132-mux-8-to-1-p3/design.sv)
- **Signals:** data, select, y
- **Test idea:** Sweep select through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.

#### SV-040 — Every request, priorities and zero input

- **Block / priority / initial status:** Priority encoder / P1 / Pending
- **Source:** [SV Functional Coverage/plates/section-10-projects/134-priority-encoder/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/134-priority-encoder/design.sv)
- **Signals:** request, code, valid
- **Test idea:** Apply each one-hot bit to request, then adjacent pairs, all ones and all zeros; sweep small input spaces.
- **Expected result:** code, valid identifies the source-defined highest/lowest-priority active input; verify the direction explicitly. Check any valid output, and treat a specified X/Z zero-input result separately from valid binary encoding.

#### SV-041 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [SV Functional Coverage/plates/section-10-projects/136-fifo-p1/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/136-fifo-p1/design.sv)
- **Signals:** clk, reset, write_enable, read_enable, data_in, data_out, full, empty
- **Test idea:** For sync_fifo, initialize through its reset/load path, then vary write_enable, read_enable, data_in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: inspect the instantiated modules for clock edge and reset polarity.
- **Expected result:** Check data_out, full, empty only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: data_out = '0; full = 1'b0; empty = 1'b1.

#### SV-042 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [SV Functional Coverage/plates/section-10-projects/137-fifo-p2/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/137-fifo-p2/design.sv)
- **Signals:** clk, reset, write_enable, read_enable, data_in, data_out, full, empty
- **Test idea:** For sync_fifo, initialize through its reset/load path, then vary write_enable, read_enable, data_in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check data_out, full, empty only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: full = (count == DEPTH); empty = (count == 0).

#### SV-043 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [SV Functional Coverage/plates/section-10-projects/138-fifo-p3/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/138-fifo-p3/design.sv)
- **Signals:** clk, reset, write_enable, read_enable, data_in, data_out, full, empty
- **Test idea:** For sync_fifo, initialize through its reset/load path, then vary write_enable, read_enable, data_in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check data_out, full, empty only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: full = (count == DEPTH); empty = (count == 0).

#### SV-044 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [SV Functional Coverage/plates/section-10-projects/140-spi-transition-bins/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/140-spi-transition-bins/design.sv)
- **Signals:** clk, reset, start, state, busy
- **Test idea:** For spi_controller, initialize through its reset/load path, then vary start before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check state, busy only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: busy = (state != IDLE).

#### SV-045 — Reset, rollover and control priority

- **Block / priority / initial status:** Counter / P1 / Pending
- **Source:** [SV Functional Coverage/plates/section-10-projects/142-counter-p1/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/142-counter-p1/design.sv)
- **Signals:** clk, reset, enable, load, load_value, count
- **Test idea:** Initialize counter; test every enable/load/direction combination in clk, reset, enable, load, load_value. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** count follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs.

#### SV-046 — Reset, rollover and control priority

- **Block / priority / initial status:** Counter / P1 / Pending
- **Source:** [SV Functional Coverage/plates/section-10-projects/143-counter-p2/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/143-counter-p2/design.sv)
- **Signals:** clk, reset, enable, load, load_value, count
- **Test idea:** Initialize counter; test every enable/load/direction combination in clk, reset, enable, load, load_value. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** count follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs.

#### SV-047 — Reset, rollover and control priority

- **Block / priority / initial status:** Counter / P1 / Pending
- **Source:** [SV Functional Coverage/plates/section-10-projects/144-counter-p3/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/144-counter-p3/design.sv)
- **Signals:** clk, reset, enable, load, load_value, count
- **Test idea:** Initialize counter; test every enable/load/direction combination in clk, reset, enable, load, load_value. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** count follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs.

#### SV-048 — Compile isolated tops and record reproducible evidence

- **Block / priority / initial status:** Build and evidence / P0 / Pending
- **Source:** [SV Assertions/Codes/02-immediate-assertions-in-a-mux/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Assertions/Codes/02-immediate-assertions-in-a-mux/design.sv)
- **Signals:** Top/module names and port declarations in the RTL map
- **Test idea:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.

### RevisionAtlas

#### RA-001 — Single transfer and data phase

- **Block / priority / initial status:** AHB-Lite manager / P0 / Pending
- **Source:** [Protocols/04 AMBA/01 AHB/code/rtl/ahb_lite_manager.v](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/01%20AHB/code/rtl/ahb_lite_manager.v)
- **Signals:** HCLK, HRESETn, req_valid, req_ready, req_write, req_addr, req_wdata, HADDR, HTRANS, HWDATA, HRDATA, HREADY, done, rsp_rdata
- **Test idea:** Accept an aligned single read and write; return/read distinct words, first without waits then with waits.
- **Expected result:** One accepted address phase is followed by its data phase. done pulses only when the final data phase completes; rsp_rdata[31:0] contains the single read word.

#### RA-002 — INCR4 and WRAP4 address sequence

- **Block / priority / initial status:** AHB-Lite manager / P0 / Pending
- **Source:** [Protocols/04 AMBA/01 AHB/code/rtl/ahb_lite_manager.v](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/01%20AHB/code/rtl/ahb_lite_manager.v)
- **Signals:** HCLK, req_burst, req_addr, HADDR, HBURST, HTRANS, HREADY
- **Test idea:** At req_addr=0x1C, issue req_burst=01 then 10 with all four data beats distinct.
- **Expected result:** INCR4 addresses are 1C,20,24,28. WRAP4 addresses are 1C,10,14,18. First HTRANS is NONSEQ, later active beats SEQ; capture four read words in increasing 32-bit slices.

#### RA-003 — Wait states and stable payload

- **Block / priority / initial status:** AHB-Lite manager / P0 / Pending
- **Source:** [Protocols/04 AMBA/01 AHB/code/rtl/ahb_lite_manager.v](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/01%20AHB/code/rtl/ahb_lite_manager.v)
- **Signals:** HCLK, HREADY, HRESP, HADDR, HTRANS, HWRITE, HWDATA
- **Test idea:** Insert HREADY=0 waits on every address/data position without asserting HRESP.
- **Expected result:** Address/control and active data remain stable during ordinary waits; counters do not double-count accepted transfers. Test two-cycle error handling separately because HTRANS may change during an error response.

#### RA-004 — Invalid local request and bus error

- **Block / priority / initial status:** AHB-Lite manager / P0 / Pending
- **Source:** [Protocols/04 AMBA/01 AHB/code/rtl/ahb_lite_manager.v](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/01%20AHB/code/rtl/ahb_lite_manager.v)
- **Signals:** HCLK, HRESETn, req_valid, req_addr, req_burst, HREADY, HRESP, done, error
- **Test idea:** Try misaligned address and req_burst=11. Separately inject two-cycle HRESP error during each data beat.
- **Expected result:** Invalid requests produce done/error without launching a valid bus transfer. Bus errors terminate once, report error and permit the next legal request.

#### RA-005 — Reset during an active transfer

- **Block / priority / initial status:** AHB-Lite manager / P0 / Pending
- **Source:** [Protocols/04 AMBA/01 AHB/code/rtl/ahb_lite_manager.v](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/01%20AHB/code/rtl/ahb_lite_manager.v)
- **Signals:** HCLK, HRESETn, req_ready, HTRANS, done, error
- **Test idea:** Reset with HREADY low during a burst, release and submit a new single transfer.
- **Expected result:** State returns idle, HTRANS=IDLE, completion/error clear, and the new request starts cleanly. Discard pre-reset reference transactions.

#### RA-006 — Four accepted beats and TLAST

- **Block / priority / initial status:** AXI Stream master / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 02 - AXI-Stream Interface Fundamentals/Lessons 020-022 - AXIS Master/rtl/axis_m.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2002%20-%20AXI-Stream%20Interface%20Fundamentals/Lessons%20020-022%20-%20AXIS%20Master/rtl/axis_m.sv)
- **Signals:** m_axis_aclk, m_axis_aresetn, newd, din, m_axis_tvalid, m_axis_tready, m_axis_tdata, m_axis_tlast
- **Test idea:** Pulse newd with din=7 held constant; vary m_axis_tready to insert stalls.
- **Expected result:** Accepted data beats are 0,7,14,21 (8-bit truncated arithmetic); m_axis_tlast is true only on the fourth beat. Count transfers only when valid and ready are both high.

#### RA-007 — Payload stability under stall

- **Block / priority / initial status:** AXI Stream master / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 02 - AXI-Stream Interface Fundamentals/Lessons 020-022 - AXIS Master/rtl/axis_m.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2002%20-%20AXI-Stream%20Interface%20Fundamentals/Lessons%20020-022%20-%20AXIS%20Master/rtl/axis_m.sv)
- **Signals:** m_axis_aclk, din, m_axis_tvalid, m_axis_tready, m_axis_tdata, m_axis_tlast
- **Test idea:** Stall a nonzero-count beat with m_axis_tready=0; change din while watching output data.
- **Expected result:** A pending stream beat must remain stable through acceptance. Current m_axis_tdata depends directly on din, so varying din exposes a stability problem unless the application explicitly holds din for the entire packet.
- **Note:** Document input-hold contract or record a design issue.

#### RA-008 — Valid gaps and last beat

- **Block / priority / initial status:** AXI Stream receiver / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 02 - AXI-Stream Interface Fundamentals/Lessons 023-026 - AXIS Slave/rtl/axis_s.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2002%20-%20AXI-Stream%20Interface%20Fundamentals/Lessons%20023-026%20-%20AXIS%20Slave/rtl/axis_s.sv)
- **Signals:** s_axis_aclk, s_axis_aresetn, s_axis_tvalid, s_axis_tready, s_axis_tdata, s_axis_tlast, dout
- **Test idea:** Send one-beat and four-beat packets with valid gaps; hold the first beat until ready.
- **Expected result:** Observe a byte only on a valid-and-ready edge. dout is a combinational view in the store state, not a latched last value. Packet gaps must not create duplicate acceptance.

#### RA-009 — Mutual exclusion and sustained fairness

- **Block / priority / initial status:** Round-robin arbiter / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 03 - AXI-Stream IPs/Lessons 030-033 - Round Robin Arbiter/rtl/robin.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2003%20-%20AXI-Stream%20IPs/Lessons%20030-033%20-%20Round%20Robin%20Arbiter/rtl/robin.sv)
- **Signals:** clk, rst, req1, req2, gnt1, gnt2
- **Test idea:** Test neither, either and both requests. Hold both requests for at least ten cycles, then release each independently.
- **Expected result:** Never grant both together. Both sustained requests alternate grants after the initial priority to req1; a sole sustained requester keeps its grant.

#### RA-010 — Fill limit and pointer wrap

- **Block / priority / initial status:** AXI Stream FIFO / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 03 - AXI-Stream IPs/Lessons 039-042 - AXIS FIFO/rtl/axis_fifo.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2003%20-%20AXI-Stream%20IPs/Lessons%20039-042%20-%20AXIS%20FIFO/rtl/axis_fifo.sv)
- **Signals:** aclk, aresetn, s_axis_tvalid, s_axis_tdata, s_axis_tkeep, s_axis_tlast, m_axis_tvalid, m_axis_tready, m_axis_tdata
- **Test idea:** Send/drain tagged data repeatedly beyond 32 total accepted writes; include the 15th and 16th queued items.
- **Expected result:** Track data, keep and last together. The current full threshold is 15, pointers are 5 bits for a 16-entry memory, and no input ready is exported. Detect out-of-range indexing and document actual input acceptance.
- **Note:** Known source risks; this is not a generic lossless AXI Stream FIFO.

#### RA-011 — Concurrent input/output and stalled output

- **Block / priority / initial status:** AXI Stream FIFO / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 03 - AXI-Stream IPs/Lessons 039-042 - AXIS FIFO/rtl/axis_fifo.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2003%20-%20AXI-Stream%20IPs/Lessons%20039-042%20-%20AXIS%20FIFO/rtl/axis_fifo.sv)
- **Signals:** aclk, s_axis_tvalid, m_axis_tvalid, m_axis_tready, m_axis_tdata, m_axis_tkeep, m_axis_tlast
- **Test idea:** Keep input valid and output ready together, then stall output in the middle of a packet. Use a reference queue updated only for true accepted operations.
- **Expected result:** Pending output data and sidebands must stay stable. Current else-if control gives writes priority over reads, so check advertised output handshakes against actual pointer movement and duplicate/dropped beats.

#### RA-012 — Fill limit and pointer wrap

- **Block / priority / initial status:** AXI Stream FIFO / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 03 - AXI-Stream IPs/Lessons 043-044 - AXIS FIFO Alternate/rtl/axis_fifo.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2003%20-%20AXI-Stream%20IPs/Lessons%20043-044%20-%20AXIS%20FIFO%20Alternate/rtl/axis_fifo.sv)
- **Signals:** aclk, aresetn, s_axis_tvalid, s_axis_tdata, s_axis_tkeep, s_axis_tlast, m_axis_tvalid, m_axis_tready, m_axis_tdata
- **Test idea:** Send/drain tagged data repeatedly beyond 32 total accepted writes; include the 15th and 16th queued items.
- **Expected result:** Track data, keep and last together. The current full threshold is 15, pointers are 5 bits for a 16-entry memory, and no input ready is exported. Detect out-of-range indexing and document actual input acceptance.
- **Note:** Known source risks; this is not a generic lossless AXI Stream FIFO.

#### RA-013 — Concurrent input/output and stalled output

- **Block / priority / initial status:** AXI Stream FIFO / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 03 - AXI-Stream IPs/Lessons 043-044 - AXIS FIFO Alternate/rtl/axis_fifo.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2003%20-%20AXI-Stream%20IPs/Lessons%20043-044%20-%20AXIS%20FIFO%20Alternate/rtl/axis_fifo.sv)
- **Signals:** aclk, s_axis_tvalid, m_axis_tvalid, m_axis_tready, m_axis_tdata, m_axis_tkeep, m_axis_tlast
- **Test idea:** Keep input valid and output ready together, then stall output in the middle of a packet. Use a reference queue updated only for true accepted operations.
- **Expected result:** Pending output data and sidebands must stay stable. Current else-if control gives writes priority over reads, so check advertised output handshakes against actual pointer movement and duplicate/dropped beats.

#### RA-014 — Independent write channels and byte lanes

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 05 - AXI-Lite Single Beat without Pipeline/Lessons 060-067 - AXIL Write Only Master and Slave/rtl/m_axi.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2005%20-%20AXI-Lite%20Single%20Beat%20without%20Pipeline/Lessons%20060-067%20-%20AXIL%20Write%20Only%20Master%20and%20Slave/rtl/m_axi.sv)
- **Signals:** i_clk, i_resetn, m_axi_awready, m_axi_wready, m_axi_bvalid, m_axi_bresp, m_axi_awvalid, m_axi_awaddr, m_axi_wvalid, m_axi_wdata, m_axi_wstrb, m_axi_bready
- **Test idea:** Try address before data, data before address and simultaneous arrival. Stall address, data and response independently. Exercise each byte strobe and all-zero strobes.
- **Expected result:** A transaction completes once, after both address and all required data transfers. Hold each valid/payload until its handshake. Only selected byte lanes change; response remains pending until accepted. Compare source memory mapping before choosing legal addresses.

#### RA-015 — Independent write channels and byte lanes

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 05 - AXI-Lite Single Beat without Pipeline/Lessons 060-067 - AXIL Write Only Master and Slave/rtl/s_axi.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2005%20-%20AXI-Lite%20Single%20Beat%20without%20Pipeline/Lessons%20060-067%20-%20AXIL%20Write%20Only%20Master%20and%20Slave/rtl/s_axi.sv)
- **Signals:** i_clk, i_resetn, s_axi_awvalid, s_axi_awaddr, s_axi_wvalid, s_axi_wdata, s_axi_wstrb, s_axi_bready, s_axi_awready, s_axi_wready, s_axi_bvalid, s_axi_bresp
- **Test idea:** Try address before data, data before address and simultaneous arrival. Stall address, data and response independently. Exercise each byte strobe and all-zero strobes.
- **Expected result:** A transaction completes once, after both address and all required data transfers. Hold each valid/payload until its handshake. Only selected byte lanes change; response remains pending until accepted. Compare source memory mapping before choosing legal addresses.

#### RA-016 — Independent write channels and byte lanes

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 05 - AXI-Lite Single Beat without Pipeline/Lessons 068-072 - AXI Protocol Checker/rtl/p_m_axi.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2005%20-%20AXI-Lite%20Single%20Beat%20without%20Pipeline/Lessons%20068-072%20-%20AXI%20Protocol%20Checker/rtl/p_m_axi.sv)
- **Signals:** m_axi_aclk, m_axi_aresetn, m_axi_awready, m_axi_wready, m_axi_bvalid, m_axi_bresp, m_axi_awvalid, m_axi_awaddr, m_axi_wvalid, m_axi_wdata, m_axi_wstrb, m_axi_bready
- **Test idea:** Try address before data, data before address and simultaneous arrival. Stall address, data and response independently. Exercise each byte strobe and all-zero strobes.
- **Expected result:** A transaction completes once, after both address and all required data transfers. Hold each valid/payload until its handshake. Only selected byte lanes change; response remains pending until accepted. Compare source memory mapping before choosing legal addresses.

#### RA-017 — Independent write channels and byte lanes

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 05 - AXI-Lite Single Beat without Pipeline/Lessons 068-072 - AXI Protocol Checker/rtl/p_s_axi.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2005%20-%20AXI-Lite%20Single%20Beat%20without%20Pipeline/Lessons%20068-072%20-%20AXI%20Protocol%20Checker/rtl/p_s_axi.sv)
- **Signals:** s_axi_aclk, s_axi_aresetn, s_axi_awvalid, s_axi_awaddr, s_axi_wvalid, s_axi_wdata, s_axi_wstrb, s_axi_bready, s_axi_awready, s_axi_wready, s_axi_bvalid, s_axi_bresp
- **Test idea:** Try address before data, data before address and simultaneous arrival. Stall address, data and response independently. Exercise each byte strobe and all-zero strobes.
- **Expected result:** A transaction completes once, after both address and all required data transfers. Hold each valid/payload until its handshake. Only selected byte lanes change; response remains pending until accepted. Compare source memory mapping before choosing legal addresses.

#### RA-018 — Read address/data stalls and response propagation

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 05 - AXI-Lite Single Beat without Pipeline/Lessons 073-081 - AXIL Read Only Master and Slave/rtl/p_m_axi.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2005%20-%20AXI-Lite%20Single%20Beat%20without%20Pipeline/Lessons%20073-081%20-%20AXIL%20Read%20Only%20Master%20and%20Slave/rtl/p_m_axi.sv)
- **Signals:** m_axi_aclk, m_axi_aresetn, m_axi_arready, m_axi_rvalid, m_axi_rdata, m_axi_rresp, m_axi_arvalid, m_axi_araddr, m_axi_rready, o_rdata
- **Test idea:** Read distinct mapped words; insert address stalls and response backpressure. Inject success and error responses when testing a master.
- **Expected result:** Each accepted read returns exactly one response for AXI-Lite, or the requested beats for burst AXI. Pending read data/response/last remain stable until accepted; errors must reach the application result.

#### RA-019 — Read address/data stalls and response propagation

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 05 - AXI-Lite Single Beat without Pipeline/Lessons 073-081 - AXIL Read Only Master and Slave/rtl/p_s_axi.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2005%20-%20AXI-Lite%20Single%20Beat%20without%20Pipeline/Lessons%20073-081%20-%20AXIL%20Read%20Only%20Master%20and%20Slave/rtl/p_s_axi.sv)
- **Signals:** s_axi_aclk, s_axi_aresetn, s_axi_arvalid, s_axi_araddr, s_axi_rready, s_axi_arready, s_axi_rvalid, s_axi_rdata, s_axi_rresp
- **Test idea:** Read distinct mapped words; insert address stalls and response backpressure. Inject success and error responses when testing a master.
- **Expected result:** Each accepted read returns exactly one response for AXI-Lite, or the requested beats for burst AXI. Pending read data/response/last remain stable until accepted; errors must reach the application result.

#### RA-020 — Independent write channels and byte lanes

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 06 - AXI-Lite Combined Read and Write/Lessons 086-093 - AXIL Read Write Master/rtl/axilite_m.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2006%20-%20AXI-Lite%20Combined%20Read%20and%20Write/Lessons%20086-093%20-%20AXIL%20Read%20Write%20Master/rtl/axilite_m.sv)
- **Signals:** m_axi_aclk, m_axi_aresetn, m_axi_awready, m_axi_wready, m_axi_bvalid, m_axi_bresp, m_axi_awvalid, m_axi_awaddr, m_axi_wvalid, m_axi_wdata, m_axi_wstrb, m_axi_bready
- **Test idea:** Try address before data, data before address and simultaneous arrival. Stall address, data and response independently. Exercise each byte strobe and all-zero strobes.
- **Expected result:** A transaction completes once, after both address and all required data transfers. Hold each valid/payload until its handshake. Only selected byte lanes change; response remains pending until accepted. Compare source memory mapping before choosing legal addresses.

#### RA-021 — Read address/data stalls and response propagation

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 06 - AXI-Lite Combined Read and Write/Lessons 086-093 - AXIL Read Write Master/rtl/axilite_m.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2006%20-%20AXI-Lite%20Combined%20Read%20and%20Write/Lessons%20086-093%20-%20AXIL%20Read%20Write%20Master/rtl/axilite_m.sv)
- **Signals:** m_axi_aclk, m_axi_aresetn, m_axi_arready, m_axi_rvalid, m_axi_rdata, m_axi_rresp, m_axi_arvalid, m_axi_araddr, m_axi_rready
- **Test idea:** Read distinct mapped words; insert address stalls and response backpressure. Inject success and error responses when testing a master.
- **Expected result:** Each accepted read returns exactly one response for AXI-Lite, or the requested beats for burst AXI. Pending read data/response/last remain stable until accepted; errors must reach the application result.

#### RA-022 — Independent write channels and byte lanes

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 07 - AXI-Lite GPIO/Lessons 095-100 - AXIL GPIO/rtl/axilite_s.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2007%20-%20AXI-Lite%20GPIO/Lessons%20095-100%20-%20AXIL%20GPIO/rtl/axilite_s.sv)
- **Signals:** s_axi_aclk, s_axi_aresetn, s_axi_awvalid, s_axi_awaddr, s_axi_wvalid, s_axi_wdata, s_axi_wstrb, s_axi_bready, s_axi_awready, s_axi_wready, s_axi_bvalid, s_axi_bresp
- **Test idea:** Try address before data, data before address and simultaneous arrival. Stall address, data and response independently. Exercise each byte strobe and all-zero strobes.
- **Expected result:** A transaction completes once, after both address and all required data transfers. Hold each valid/payload until its handshake. Only selected byte lanes change; response remains pending until accepted. Compare source memory mapping before choosing legal addresses.

#### RA-023 — Read address/data stalls and response propagation

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 07 - AXI-Lite GPIO/Lessons 095-100 - AXIL GPIO/rtl/axilite_s.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2007%20-%20AXI-Lite%20GPIO/Lessons%20095-100%20-%20AXIL%20GPIO/rtl/axilite_s.sv)
- **Signals:** s_axi_aclk, s_axi_aresetn, s_axi_arvalid, s_axi_araddr, s_axi_rready, s_axi_arready, s_axi_rvalid, s_axi_rdata, s_axi_rresp
- **Test idea:** Read distinct mapped words; insert address stalls and response backpressure. Inject success and error responses when testing a master.
- **Expected result:** Each accepted read returns exactly one response for AXI-Lite, or the requested beats for burst AXI. Pending read data/response/last remain stable until accepted; errors must reach the application result.

#### RA-024 — Independent write channels and byte lanes

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 08 - AXI4 Single Beat/Lessons 103-112 - AXI4 Single Beat Master and Slave/rtl/axi4_slave.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2008%20-%20AXI4%20Single%20Beat/Lessons%20103-112%20-%20AXI4%20Single%20Beat%20Master%20and%20Slave/rtl/axi4_slave.sv)
- **Signals:** s_axi_aclk, s_axi_aresetn, s_axi_awvalid, s_axi_awaddr, s_axi_awlen, s_axi_wvalid, s_axi_wdata, s_axi_wstrb, s_axi_wlast, s_axi_bready, s_axi_awready, s_axi_wready, s_axi_bvalid, s_axi_bresp
- **Test idea:** Try address before data, data before address and simultaneous arrival. Stall address, data and response independently. Exercise each byte strobe and all-zero strobes.
- **Expected result:** A transaction completes once, after both address and all required data transfers. Hold each valid/payload until its handshake. Only selected byte lanes change; response remains pending until accepted. Compare source memory mapping before choosing legal addresses.

#### RA-025 — Read address/data stalls and response propagation

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 08 - AXI4 Single Beat/Lessons 103-112 - AXI4 Single Beat Master and Slave/rtl/axi4_slave.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2008%20-%20AXI4%20Single%20Beat/Lessons%20103-112%20-%20AXI4%20Single%20Beat%20Master%20and%20Slave/rtl/axi4_slave.sv)
- **Signals:** s_axi_aclk, s_axi_aresetn, s_axi_arvalid, s_axi_araddr, s_axi_arlen, s_axi_rready, s_axi_arready, s_axi_rvalid, s_axi_rdata, s_axi_rlast, s_axi_rresp
- **Test idea:** Read distinct mapped words; insert address stalls and response backpressure. Inject success and error responses when testing a master.
- **Expected result:** Each accepted read returns exactly one response for AXI-Lite, or the requested beats for burst AXI. Pending read data/response/last remain stable until accepted; errors must reach the application result.

#### RA-026 — Length, address progression and final beat

- **Block / priority / initial status:** AXI bursts / P1 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 08 - AXI4 Single Beat/Lessons 103-112 - AXI4 Single Beat Master and Slave/rtl/axi4_slave.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2008%20-%20AXI4%20Single%20Beat/Lessons%20103-112%20-%20AXI4%20Single%20Beat%20Master%20and%20Slave/rtl/axi4_slave.sv)
- **Signals:** s_axi_aclk, s_axi_awid, s_axi_awaddr, s_axi_awlen, s_axi_awsize, s_axi_awburst, s_axi_wid, s_axi_wlast, s_axi_arid, s_axi_araddr, s_axi_arlen, s_axi_arsize, s_axi_arburst, s_axi_bid, s_axi_rid, s_axi_rlast
- **Test idea:** Within the supported design subset, test length fields 0,1,3,15; fixed/increment/wrap modes; delayed final beats and addresses near boundaries.
- **Expected result:** Length field N requests N+1 beats. Check bytes-per-beat, wrap region, ID widths and exactly one final-beat marker. Clarify unsupported modes before declaring conformance; single-beat lessons must not be assumed to support every burst.

#### RA-027 — Independent write channels and byte lanes

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 08 - AXI4 Single Beat/Lessons 103-112 - AXI4 Single Beat Master and Slave/rtl/axi_master.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2008%20-%20AXI4%20Single%20Beat/Lessons%20103-112%20-%20AXI4%20Single%20Beat%20Master%20and%20Slave/rtl/axi_master.sv)
- **Signals:** m_axi_aclk, m_axi_aresetn, m_axi_awready, m_axi_wready, m_axi_bresp, m_axi_bvalid, m_axi_awaddr, m_axi_awlen, m_axi_awvalid, m_axi_wdata, m_axi_wstrb, m_axi_wlast, m_axi_wvalid, m_axi_bready
- **Test idea:** Try address before data, data before address and simultaneous arrival. Stall address, data and response independently. Exercise each byte strobe and all-zero strobes.
- **Expected result:** A transaction completes once, after both address and all required data transfers. Hold each valid/payload until its handshake. Only selected byte lanes change; response remains pending until accepted. Compare source memory mapping before choosing legal addresses.

#### RA-028 — Read address/data stalls and response propagation

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 08 - AXI4 Single Beat/Lessons 103-112 - AXI4 Single Beat Master and Slave/rtl/axi_master.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2008%20-%20AXI4%20Single%20Beat/Lessons%20103-112%20-%20AXI4%20Single%20Beat%20Master%20and%20Slave/rtl/axi_master.sv)
- **Signals:** m_axi_aclk, m_axi_aresetn, m_axi_arready, m_axi_rdata, m_axi_rresp, m_axi_rlast, m_axi_rvalid, m_axi_araddr, m_axi_arlen, m_axi_arvalid, m_axi_rready
- **Test idea:** Read distinct mapped words; insert address stalls and response backpressure. Inject success and error responses when testing a master.
- **Expected result:** Each accepted read returns exactly one response for AXI-Lite, or the requested beats for burst AXI. Pending read data/response/last remain stable until accepted; errors must reach the application result.

#### RA-029 — Length, address progression and final beat

- **Block / priority / initial status:** AXI bursts / P1 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 08 - AXI4 Single Beat/Lessons 103-112 - AXI4 Single Beat Master and Slave/rtl/axi_master.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2008%20-%20AXI4%20Single%20Beat/Lessons%20103-112%20-%20AXI4%20Single%20Beat%20Master%20and%20Slave/rtl/axi_master.sv)
- **Signals:** m_axi_aclk, m_axi_bid, m_axi_rid, m_axi_rlast, m_axi_awid, m_axi_awaddr, m_axi_awsize, m_axi_awburst, m_axi_awlen, m_axi_wid, m_axi_wlast, m_axi_arid, m_axi_araddr, m_axi_arlen, m_axi_arsize, m_axi_arburst
- **Test idea:** Within the supported design subset, test length fields 0,1,3,15; fixed/increment/wrap modes; delayed final beats and addresses near boundaries.
- **Expected result:** Length field N requests N+1 beats. Check bytes-per-beat, wrap region, ID widths and exactly one final-beat marker. Clarify unsupported modes before declaring conformance; single-beat lessons must not be assumed to support every burst.

#### RA-030 — Independent write channels and byte lanes

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 09 - AXI4 Burst Modes/Lessons 115-128 - AXI4 Burst Master and Slave/rtl/axi4_slave.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2009%20-%20AXI4%20Burst%20Modes/Lessons%20115-128%20-%20AXI4%20Burst%20Master%20and%20Slave/rtl/axi4_slave.sv)
- **Signals:** s_axi_aclk, s_axi_aresetn, s_axi_awvalid, s_axi_awaddr, s_axi_awlen, s_axi_wvalid, s_axi_wdata, s_axi_wstrb, s_axi_wlast, s_axi_bready, s_axi_awready, s_axi_wready, s_axi_bvalid, s_axi_bresp
- **Test idea:** Try address before data, data before address and simultaneous arrival. Stall address, data and response independently. Exercise each byte strobe and all-zero strobes.
- **Expected result:** A transaction completes once, after both address and all required data transfers. Hold each valid/payload until its handshake. Only selected byte lanes change; response remains pending until accepted. Compare source memory mapping before choosing legal addresses.

#### RA-031 — Read address/data stalls and response propagation

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 09 - AXI4 Burst Modes/Lessons 115-128 - AXI4 Burst Master and Slave/rtl/axi4_slave.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2009%20-%20AXI4%20Burst%20Modes/Lessons%20115-128%20-%20AXI4%20Burst%20Master%20and%20Slave/rtl/axi4_slave.sv)
- **Signals:** s_axi_aclk, s_axi_aresetn, s_axi_arvalid, s_axi_araddr, s_axi_arlen, s_axi_rready, s_axi_arready, s_axi_rvalid, s_axi_rdata, s_axi_rlast, s_axi_rresp
- **Test idea:** Read distinct mapped words; insert address stalls and response backpressure. Inject success and error responses when testing a master.
- **Expected result:** Each accepted read returns exactly one response for AXI-Lite, or the requested beats for burst AXI. Pending read data/response/last remain stable until accepted; errors must reach the application result.

#### RA-032 — Length, address progression and final beat

- **Block / priority / initial status:** AXI bursts / P1 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 09 - AXI4 Burst Modes/Lessons 115-128 - AXI4 Burst Master and Slave/rtl/axi4_slave.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2009%20-%20AXI4%20Burst%20Modes/Lessons%20115-128%20-%20AXI4%20Burst%20Master%20and%20Slave/rtl/axi4_slave.sv)
- **Signals:** s_axi_aclk, s_axi_awid, s_axi_awaddr, s_axi_awlen, s_axi_awsize, s_axi_awburst, s_axi_wid, s_axi_wlast, s_axi_arid, s_axi_araddr, s_axi_arlen, s_axi_arsize, s_axi_arburst, s_axi_bid, s_axi_rid, s_axi_rlast
- **Test idea:** Within the supported design subset, test length fields 0,1,3,15; fixed/increment/wrap modes; delayed final beats and addresses near boundaries.
- **Expected result:** Length field N requests N+1 beats. Check bytes-per-beat, wrap region, ID widths and exactly one final-beat marker. Clarify unsupported modes before declaring conformance; single-beat lessons must not be assumed to support every burst.

#### RA-033 — Independent write channels and byte lanes

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 09 - AXI4 Burst Modes/Lessons 115-128 - AXI4 Burst Master and Slave/rtl/axi_master.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2009%20-%20AXI4%20Burst%20Modes/Lessons%20115-128%20-%20AXI4%20Burst%20Master%20and%20Slave/rtl/axi_master.sv)
- **Signals:** m_axi_aclk, m_axi_aresetn, m_axi_awready, m_axi_wready, m_axi_bresp, m_axi_bvalid, m_axi_awaddr, m_axi_awlen, m_axi_awvalid, m_axi_wdata, m_axi_wstrb, m_axi_wlast, m_axi_wvalid, m_axi_bready
- **Test idea:** Try address before data, data before address and simultaneous arrival. Stall address, data and response independently. Exercise each byte strobe and all-zero strobes.
- **Expected result:** A transaction completes once, after both address and all required data transfers. Hold each valid/payload until its handshake. Only selected byte lanes change; response remains pending until accepted. Compare source memory mapping before choosing legal addresses.

#### RA-034 — Read address/data stalls and response propagation

- **Block / priority / initial status:** AXI memory-mapped / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 09 - AXI4 Burst Modes/Lessons 115-128 - AXI4 Burst Master and Slave/rtl/axi_master.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2009%20-%20AXI4%20Burst%20Modes/Lessons%20115-128%20-%20AXI4%20Burst%20Master%20and%20Slave/rtl/axi_master.sv)
- **Signals:** m_axi_aclk, m_axi_aresetn, m_axi_arready, m_axi_rdata, m_axi_rresp, m_axi_rlast, m_axi_rvalid, m_axi_araddr, m_axi_arlen, m_axi_arvalid, m_axi_rready
- **Test idea:** Read distinct mapped words; insert address stalls and response backpressure. Inject success and error responses when testing a master.
- **Expected result:** Each accepted read returns exactly one response for AXI-Lite, or the requested beats for burst AXI. Pending read data/response/last remain stable until accepted; errors must reach the application result.

#### RA-035 — Length, address progression and final beat

- **Block / priority / initial status:** AXI bursts / P1 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 09 - AXI4 Burst Modes/Lessons 115-128 - AXI4 Burst Master and Slave/rtl/axi_master.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2009%20-%20AXI4%20Burst%20Modes/Lessons%20115-128%20-%20AXI4%20Burst%20Master%20and%20Slave/rtl/axi_master.sv)
- **Signals:** m_axi_aclk, m_axi_bid, m_axi_rid, m_axi_rlast, m_axi_awid, m_axi_awaddr, m_axi_awsize, m_axi_awburst, m_axi_awlen, m_axi_wid, m_axi_wlast, m_axi_arid, m_axi_araddr, m_axi_arlen, m_axi_arsize, m_axi_arburst
- **Test idea:** Within the supported design subset, test length fields 0,1,3,15; fixed/increment/wrap modes; delayed final beats and addresses near boundaries.
- **Expected result:** Length field N requests N+1 beats. Check bytes-per-beat, wrap region, ID widths and exactly one final-beat marker. Clarify unsupported modes before declaring conformance; single-beat lessons must not be assumed to support every burst.

#### RA-036 — Write/read round trip and protocol monitor

- **Block / priority / initial status:** AXI integration / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 08 - AXI4 Single Beat/Lessons 103-112 - AXI4 Single Beat Master and Slave/rtl/connect_m_s.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2008%20-%20AXI4%20Single%20Beat/Lessons%20103-112%20-%20AXI4%20Single%20Beat%20Master%20and%20Slave/rtl/connect_m_s.sv)
- **Signals:** clk, resetn, wr, wr_addr, wr_burst_len, wr_burst_type, wr_din, wr_strbin, rd_addr, rd_burst_len, rd_burst_type, rout, resp, pc_status, pc_asserted
- **Test idea:** Compile this wrapper with its matching lesson master/slave and the actual axi_protocol_checker_0 simulation model. Reset low, write distinct mapped words with individual byte strobes, then read them back. Start with length=0; exercise supported bursts separately. Observe internal valid/ready acceptance and set a timeout.
- **Expected result:** Accepted reads return the previously written selected bytes and a valid response after the clocked transaction completes. For legal monitored traffic, pc_asserted stays 0; decode pc_status on a violation. Verify checker connections first: some fields are constants, so a quiet checker alone cannot certify every bus signal.
- **Note:** Requires the vendor checker model. If unavailable, mark this case Blocked; a dummy checker is not a protocol test.

#### RA-037 — Write/read round trip and protocol monitor

- **Block / priority / initial status:** AXI integration / P0 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 09 - AXI4 Burst Modes/Lessons 115-128 - AXI4 Burst Master and Slave/rtl/connect_m_s.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2009%20-%20AXI4%20Burst%20Modes/Lessons%20115-128%20-%20AXI4%20Burst%20Master%20and%20Slave/rtl/connect_m_s.sv)
- **Signals:** clk, resetn, wr, wr_addr, wr_burst_len, wr_burst_type, wr_din, wr_strbin, rd_addr, rd_burst_len, rd_burst_type, rout, resp, pc_status, pc_asserted
- **Test idea:** Compile this wrapper with its matching lesson master/slave and the actual axi_protocol_checker_0 simulation model. Reset low, write distinct mapped words with individual byte strobes, then read them back. Start with length=0; exercise supported bursts separately. Observe internal valid/ready acceptance and set a timeout.
- **Expected result:** Accepted reads return the previously written selected bytes and a valid response after the clocked transaction completes. For legal monitored traffic, pc_asserted stays 0; decode pc_status on a violation. Verify checker connections first: some fields are constants, so a quiet checker alone cannot certify every bus signal.
- **Note:** Requires the vendor checker model. If unavailable, mark this case Blocked; a dummy checker is not a protocol test.

#### RA-038 — Define and implement fifo

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [FIFO/src/fifo.v](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/FIFO/src/fifo.v)
- **Signals:** No complete module interface
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### RA-039 — Define and implement ram

- **Block / priority / initial status:** Implementation prerequisite / P0 / Blocked
- **Source:** [FIFO/vivado/fifo_vivado/fifo_vivado.srcs/sources_1/new/ram.v](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/FIFO/vivado/fifo_vivado/fifo_vivado.srcs/sources_1/new/ram.v)
- **Signals:** No complete module interface
- **Test idea:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Note:** Existing stub; not a passing design.

#### RA-040 — Reset, rollover and control priority

- **Block / priority / initial status:** Counter / P1 / Pending
- **Source:** [Frequency Dividers/examples/counter_75_98.v](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Frequency%20Dividers/examples/counter_75_98.v)
- **Signals:** clk, rst, count
- **Test idea:** Initialize counter_75_98; test every enable/load/direction combination in clk, rst. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** count follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs. Source mapping: count = state ? 7'd98 : 7'd75.

#### RA-041 — Frequency, duty cycle and startup

- **Block / priority / initial status:** Clock divider / P1 / Pending
- **Source:** [Programmable Frequency Divider/src/custom_duty_divider.v](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Programmable%20Frequency%20Divider/src/custom_duty_divider.v)
- **Signals:** clk_fast, reset, clk_out
- **Test idea:** Use a known 50% input clock through clk_fast, reset; measure steady output period and high time for ten cycles, then reset during both phases and test legal parameter endpoints.
- **Expected result:** Measure clk_out against the named divide ratio and duty setting. Include both edges for half-cycle implementations. Distinguish a one-cycle enable pulse from a square clock; ignore documented startup transients only. Source mapping: clk_out = reset ? 1'b0 : (count < HIGH_COUNTS).

#### RA-042 — Frequency, duty cycle and startup

- **Block / priority / initial status:** Clock divider / P1 / Pending
- **Source:** [Programmable Frequency Divider/src/divide_by_2.v](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Programmable%20Frequency%20Divider/src/divide_by_2.v)
- **Signals:** clk, reset, clk_out_25, clk_out_50, clk_out_75
- **Test idea:** Use a known 50% input clock through clk, reset; measure steady output period and high time for ten cycles, then reset during both phases and test legal parameter endpoints.
- **Expected result:** Measure clk_out_25, clk_out_50, clk_out_75 against the named divide ratio and duty setting. Include both edges for half-cycle implementations. Distinguish a one-cycle enable pulse from a square clock; ignore documented startup transients only. Source mapping: clk_out_25 = reset ? 1'b0 : posphase & ~negphase; clk_out_50 = reset ? 1'b0 : posphase; clk_out_75 = reset ? 1'b0 : posphase | negphase.

#### RA-043 — Frequency, duty cycle and startup

- **Block / priority / initial status:** Clock divider / P1 / Pending
- **Source:** [Programmable Frequency Divider/src/divide_by_3.v](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Programmable%20Frequency%20Divider/src/divide_by_3.v)
- **Signals:** clk, reset, clk_out_16_67, clk_out_33_33, clk_out_50, clk_out_66_67, clk_out_83_33
- **Test idea:** Use a known 50% input clock through clk, reset; measure steady output period and high time for ten cycles, then reset during both phases and test legal parameter endpoints.
- **Expected result:** Measure clk_out_16_67, clk_out_33_33, clk_out_50, clk_out_66_67, clk_out_83_33 against the named divide ratio and duty setting. Include both edges for half-cycle implementations. Distinguish a one-cycle enable pulse from a square clock; ignore documented startup transients only. Source mapping: clk_out_16_67 = reset ? 1'b0 : one_cycle_posphase & ~one_cycle_negphase; clk_out_33_33 = reset ? 1'b0 : one_cycle_posphase; clk_out_50 = reset ? 1'b0 : one_cycle_posphase | one_cycle_negphase; clk_out_66_67 = reset ? 1'b0 : two_cycles_posphase; clk_out_83_33 = reset ? 1'b0 : two_cycles_posphase | two_cycles_negphase.

#### RA-044 — Frequency, duty cycle and startup

- **Block / priority / initial status:** Clock divider / P1 / Pending
- **Source:** [Programmable Frequency Divider/src/divide_by_4.v](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Programmable%20Frequency%20Divider/src/divide_by_4.v)
- **Signals:** clk, reset, clk_out_12_5, clk_out_25, clk_out_37_5, clk_out_50, clk_out_62_5, clk_out_75, clk_out_87_5
- **Test idea:** Use a known 50% input clock through clk, reset; measure steady output period and high time for ten cycles, then reset during both phases and test legal parameter endpoints.
- **Expected result:** Measure clk_out_12_5, clk_out_25, clk_out_37_5, clk_out_50, clk_out_62_5, clk_out_75, clk_out_87_5 against the named divide ratio and duty setting. Include both edges for half-cycle implementations. Distinguish a one-cycle enable pulse from a square clock; ignore documented startup transients only. Source mapping: clk_out_12_5 = reset ? 1'b0 : one_cycle_posphase & ~one_cycle_negphase; clk_out_25 = reset ? 1'b0 : one_cycle_posphase; clk_out_37_5 = reset ? 1'b0 : one_cycle_posphase | one_cycle_negphase; clk_out_50 = reset ? 1'b0 : two_cycles_posphase; clk_out_62_5 = reset ? 1'b0 : two_cycles_posphase | two_cycles_negphase; clk_out_75 = reset ? 1'b0 : three_cycles_posphase; clk_out_87_5 = reset ? 1'b0 : three_cycles_posphase | three_cycles_negphase.

#### RA-045 — Frequency, duty cycle and startup

- **Block / priority / initial status:** Clock divider / P1 / Pending
- **Source:** [Programmable Frequency Divider/src/divide_by_5.v](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Programmable%20Frequency%20Divider/src/divide_by_5.v)
- **Signals:** clk, reset, clk_out_10, clk_out_20, clk_out_30, clk_out_40, clk_out_50, clk_out_60, clk_out_70, clk_out_80, clk_out_90
- **Test idea:** Use a known 50% input clock through clk, reset; measure steady output period and high time for ten cycles, then reset during both phases and test legal parameter endpoints.
- **Expected result:** Measure clk_out_10, clk_out_20, clk_out_30, clk_out_40, clk_out_50, clk_out_60, clk_out_70, clk_out_80, clk_out_90 against the named divide ratio and duty setting. Include both edges for half-cycle implementations. Distinguish a one-cycle enable pulse from a square clock; ignore documented startup transients only.

#### RA-046 — Frequency, duty cycle and startup

- **Block / priority / initial status:** Clock divider / P1 / Pending
- **Source:** [Programmable Frequency Divider/src/fractional_pulse_divider.v](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Programmable%20Frequency%20Divider/src/fractional_pulse_divider.v)
- **Signals:** clk_2x, reset, pulse_out
- **Test idea:** Use a known 50% input clock through clk_2x, reset; measure steady output period and high time for ten cycles, then reset during both phases and test legal parameter endpoints.
- **Expected result:** Measure pulse_out against the named divide ratio and duty setting. Include both edges for half-cycle implementations. Distinguish a one-cycle enable pulse from a square clock; ignore documented startup transients only. Source mapping: pulse_out = reset ? 1'b0 : (count == 0).

#### RA-047 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 02 - AXI-Stream Interface Fundamentals/Lessons 027-028 - Master Slave Integration/rtl/top.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2002%20-%20AXI-Stream%20Interface%20Fundamentals/Lessons%20027-028%20-%20Master%20Slave%20Integration/rtl/top.sv)
- **Signals:** clk, rst, newd, din, dout, last
- **Test idea:** For top, initialize through its reset/load path, then vary newd, din before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: inspect the instantiated modules for clock edge and reset polarity.
- **Expected result:** Check dout, last only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: last = last_t.

#### RA-048 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 03 - AXI-Stream IPs/Lessons 034-038 - AXIS Arbiter/rtl/axis_arb.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2003%20-%20AXI-Stream%20IPs/Lessons%20034-038%20-%20AXIS%20Arbiter/rtl/axis_arb.sv)
- **Signals:** aclk, aresetn, s_axis_tvalid1, s_axis_tvalid2, s_axis_tdata1, s_axis_tdata2, s_axis_tlast1, s_axis_tlast2, m_axis_tready, s_axis_tready1, s_axis_tready2, m_axis_tvalid, m_axis_tdata, m_axis_tlast
- **Test idea:** For axis_arb, initialize through its reset/load path, then vary s_axis_tvalid1, s_axis_tvalid2, s_axis_tdata1, s_axis_tdata2, s_axis_tlast1, s_axis_tlast2, m_axis_tready before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge aclk.
- **Expected result:** Check s_axis_tready1, s_axis_tready2, m_axis_tvalid, m_axis_tdata, m_axis_tlast only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: s_axis_tready1 = 1'b1; s_axis_tready2 = 1'b1; m_axis_tdata = ((s_axis_tvalid1 && s_axis_tready1)||(s_axis_tvalid2 && s_axis_tready2)) ? reg_tdata : 8'h00; m_axis_tlast = ((s_axis_tvalid1 && s_axis_tready1)||(s_axis_tvalid2 && s_axis_tready2)) ? reg_tlast : 1'b0; m_axis_tvalid = ((s_axis_tvalid1 && s_axis_tready1)||(s_axis_tvalid2 && s_axis_tready2)) ? 1'b1 : 1'b0.

#### RA-049 — Reset, control priority and cycle behavior

- **Block / priority / initial status:** Sequential logic / P1 / Pending
- **Source:** [Protocols/04 AMBA/03 AXI/Code/Section 05 - AXI-Lite Single Beat without Pipeline/Lessons 073-081 - AXIL Read Only Master and Slave/rtl/top.sv](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Protocols/04%20AMBA/03%20AXI/Code/Section%2005%20-%20AXI-Lite%20Single%20Beat%20without%20Pipeline/Lessons%20073-081%20-%20AXIL%20Read%20Only%20Master%20and%20Slave/rtl/top.sv)
- **Signals:** i_addrin, i_wr, m_axi_aclk, m_axi_aresetn, o_rdata, o_resp
- **Test idea:** For top, initialize through its reset/load path, then vary i_addrin, i_wr before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: inspect the instantiated modules for clock edge and reset polarity.
- **Expected result:** Check o_rdata, o_resp only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.

#### RA-050 — Compile isolated tops and record reproducible evidence

- **Block / priority / initial status:** Build and evidence / P0 / Pending
- **Source:** [Frequency Dividers/examples/counter_75_98.v](https://github.com/kapiltrip/RevisionAtlas/blob/2f827008d725333643a78e6c31935ab24cb4e6b7/Frequency%20Dividers/examples/counter_75_98.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Test idea:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.
