# RamAndFifo: detailed Verilog verification cases

[Plan index](../VERIFICATION_PLAN.md) · [Excel tracker](../VERIFICATION_CASES.xlsx) · [HDL source map](../VERIFICATION_SOURCE_MAP.md)

**62 cases, 18 HDL files.** Reviewed revision [858ffb35bb31](https://github.com/kapiltrip/RamAndFifo/commit/858ffb35bb31e70051ca25d6cb24e5aa5020bd41). This is a verification *plan*: no new simulation result is claimed.

## Design contract to check

Registered read-first RAM; standalone FIFO updates rd_data on accepted reads. RAM-backed FIFO reads its RAM every edge, so rd_data/dout need not hold. Use old full/empty for accepted requests. Follow the exact stimulus and expected timing in each case.

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
| [RF-001](#rf-001) | P0 | RAM | Registered read timing | Pending |
| [RF-003](#rf-003) | P0 | RAM | All addresses and aliasing | Pending |
| [RF-004](#rf-004) | P0 | RAM | Same-address read/write collision | Pending |
| [RF-009](#rf-009) | P0 | Standalone FIFO | Reset and first usable cycle | Pending |
| [RF-010](#rf-010) | P0 | Standalone FIFO | Single write then single read | Pending |
| [RF-011](#rf-011) | P0 | Standalone FIFO | Ordering and mixed data | Pending |
| [RF-012](#rf-012) | P0 | Standalone FIFO | Fill to capacity and reject overflow | Pending |
| [RF-013](#rf-013) | P0 | Standalone FIFO | Drain to empty and reject underflow | Pending |
| [RF-014](#rf-014) | P0 | Standalone FIFO | Both enables in the middle | Pending |
| [RF-015](#rf-015) | P0 | Standalone FIFO | Both enables when empty | Pending |
| [RF-016](#rf-016) | P0 | Standalone FIFO | Both enables when full | Pending |
| [RF-021](#rf-021) | P0 | RAM-backed FIFO | Reset and first usable cycle | Pending |
| [RF-022](#rf-022) | P0 | RAM-backed FIFO | Single write then single read | Pending |
| [RF-023](#rf-023) | P0 | RAM-backed FIFO | Ordering and mixed data | Pending |
| [RF-024](#rf-024) | P0 | RAM-backed FIFO | Fill to capacity and reject overflow | Pending |
| [RF-025](#rf-025) | P0 | RAM-backed FIFO | Drain to empty and reject underflow | Pending |
| [RF-026](#rf-026) | P0 | RAM-backed FIFO | Both enables in the middle | Pending |
| [RF-027](#rf-027) | P0 | RAM-backed FIFO | Both enables when empty | Pending |
| [RF-028](#rf-028) | P0 | RAM-backed FIFO | Both enables when full | Pending |
| [RF-033](#rf-033) | P0 | Wrapper FIFO | Reset and first usable cycle | Pending |
| [RF-034](#rf-034) | P0 | Wrapper FIFO | Single write then single read | Pending |
| [RF-035](#rf-035) | P0 | Wrapper FIFO | Ordering and mixed data | Pending |
| [RF-036](#rf-036) | P0 | Wrapper FIFO | Fill to capacity and reject overflow | Pending |
| [RF-037](#rf-037) | P0 | Wrapper FIFO | Drain to empty and reject underflow | Pending |
| [RF-038](#rf-038) | P0 | Wrapper FIFO | Both enables in the middle | Pending |
| [RF-039](#rf-039) | P0 | Wrapper FIFO | Both enables when empty | Pending |
| [RF-040](#rf-040) | P0 | Wrapper FIFO | Both enables when full | Pending |
| [RF-047](#rf-047) | P0 | Build and evidence | Compile isolated tops and record reproducible evidence | Pending |
| [RF-048](#rf-048) | P0 | RAM | Separate the write edge from the read check | Pending |
| [RF-051](#rf-051) | P0 | Standalone FIFO | Occupancy and request cross at every boundary | Pending |
| [RF-052](#rf-052) | P0 | Standalone FIFO | Full release does not retroactively accept a write | Pending |
| [RF-053](#rf-053) | P0 | Standalone FIFO | Empty release and smallest queue | Pending |
| [RF-055](#rf-055) | P0 | RAM-backed FIFO | Occupancy and request cross at every boundary | Pending |
| [RF-056](#rf-056) | P0 | RAM-backed FIFO | Full release does not retroactively accept a write | Pending |
| [RF-057](#rf-057) | P0 | RAM-backed FIFO | Empty release and smallest queue | Pending |
| [RF-059](#rf-059) | P0 | RAM-backed FIFO | Occupancy and request cross at every boundary | Pending |
| [RF-060](#rf-060) | P0 | RAM-backed FIFO | Full release does not retroactively accept a write | Pending |
| [RF-061](#rf-061) | P0 | RAM-backed FIFO | Empty release and smallest queue | Pending |
| [RF-002](#rf-002) | P1 | RAM | Write enable protects contents | Pending |
| [RF-005](#rf-005) | P1 | RAM | Different-address concurrent access | Pending |
| [RF-006](#rf-006) | P1 | RAM | Data bit patterns | Pending |
| [RF-007](#rf-007) | P1 | RAM | Uninitialized read and no reset port | Pending |
| [RF-017](#rf-017) | P1 | Standalone FIFO | Idle and output validity | Pending |
| [RF-018](#rf-018) | P1 | Standalone FIFO | Repeated wraparound | Pending |
| [RF-019](#rf-019) | P1 | Standalone FIFO | Reset with queued traffic | Pending |
| [RF-029](#rf-029) | P1 | RAM-backed FIFO | Idle and output validity | Pending |
| [RF-030](#rf-030) | P1 | RAM-backed FIFO | Repeated wraparound | Pending |
| [RF-031](#rf-031) | P1 | RAM-backed FIFO | Reset with queued traffic | Pending |
| [RF-041](#rf-041) | P1 | Wrapper FIFO | Idle and output validity | Pending |
| [RF-042](#rf-042) | P1 | Wrapper FIFO | Repeated wraparound | Pending |
| [RF-043](#rf-043) | P1 | Wrapper FIFO | Reset with queued traffic | Pending |
| [RF-045](#rf-045) | P1 | RAM-backed FIFO | Reset while write remains asserted | Pending |
| [RF-049](#rf-049) | P1 | RAM | March read/write transitions over the whole RAM | Pending |
| [RF-050](#rf-050) | P1 | RAM | Power-of-two address boundary pairs | Pending |
| [RF-054](#rf-054) | P1 | Standalone FIFO | Independent width and capacity sweep | Pending |
| [RF-058](#rf-058) | P1 | RAM-backed FIFO | Independent width and capacity sweep | Pending |
| [RF-062](#rf-062) | P1 | RAM-backed FIFO | Independent width and capacity sweep | Pending |
| [RF-008](#rf-008) | P2 | RAM | Back-to-back overwrite and parameter corners | Pending |
| [RF-020](#rf-020) | P2 | Standalone FIFO | Random bursts with a reference queue | Pending |
| [RF-032](#rf-032) | P2 | RAM-backed FIFO | Random bursts with a reference queue | Pending |
| [RF-044](#rf-044) | P2 | Wrapper FIFO | Random bursts with a reference queue | Pending |
| [RF-046](#rf-046) | P2 | Practice draft | Compile and compare draft contract | Pending |

## Detailed test ideas

### RF-001

**Registered read timing** · RAM · P0 · Pending · Simulation plan

- **Source:** [1. individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write A5 to address 0 on a rising clk. Set we=0 and raddr=0 between edges. Change raddr between later edges.
- **Expected result:** dout changes only after a rising clk, after nonblocking updates. It returns the word selected by the pre-edge raddr. Do not expect combinational read-through.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-003

**All addresses and aliasing** · RAM · P0 · Pending · Simulation plan

- **Source:** [1. individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write a distinct address-derived value to every valid waddr; read every raddr in ascending then descending order. Include 0 and DEPTH-1.
- **Expected result:** Every address returns its own last written value. An update to one address must not corrupt any other address.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-004

**Same-address read/write collision** · RAM · P0 · Pending · Simulation plan

- **Source:** [1. individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Choose legal address A=min(3,DEPTH-1). Initialize A to hex 55. Set waddr=raddr=A, we=1, din=hex AA at the next active edge. Then disable writes and read A again. Truncate patterns to DW bits.
- **Expected result:** On the collision edge dout=hex 55 (old data, truncated to DW). On the following read edge dout=hex AA. This is read-first RTL behavior.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-009

**Reset and first usable cycle** · Standalone FIFO · P0 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Hold wr_en=rd_en=0. Assert rst=1, clock the design, then release reset away from the active edge.
- **Expected result:** After the specified reset event: empty=1 and full=0; pointers/count are reset. rd_data holds the last accepted read while no read is accepted, and resets to zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-010

**Single write then single read** · Standalone FIFO · P0 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write A5 with wr_en=1 while full=0; disable write; request one read with rd_en=1 while empty=0.
- **Expected result:** empty clears after the write and asserts after the read. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer. Exactly one word is transferred.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-011

**Ordering and mixed data** · Standalone FIFO · P0 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write 10,22,35,48 with gaps, then drain using isolated and consecutive rd_en requests.
- **Expected result:** Read values are 10,22,35,48 in that order. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-012

**Fill to capacity and reject overflow** · Standalone FIFO · P0 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** With rd_en=0, issue exactly DEPTH writes (2^AW (default 16)); check one below full and full. Attempt three further writes with distinct data, then drain.
- **Expected result:** full asserts only after the last available slot is used. Extra writes cannot move the write pointer or replace queued data. Draining returns the original DEPTH values.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-013

**Drain to empty and reject underflow** · Standalone FIFO · P0 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill and drain exactly DEPTH accepted reads. Keep rd_en=1 for three additional clocks with wr_en=0.
- **Expected result:** empty asserts on the last accepted pop; extra reads do not advance the read pointer or change occupancy. rd_data holds the last accepted read while no read is accepted, and resets to zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-014

**Both enables in the middle** · Standalone FIFO · P0 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill to half capacity. Keep wr_en=rd_en=1 for at least 2*DEPTH clocks with a changing wr_data.
- **Expected result:** Both operations are accepted on each edge and occupancy stays constant. The stream remains ordered across pointer wraps. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-015

**Both enables when empty** · Standalone FIFO · P0 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset empty, then assert wr_en=rd_en=1 for one edge with wr_data=3C.
- **Expected result:** Only the write is accepted because the pre-edge empty=1. Occupancy becomes one. No same-edge bypass/pop of 3C is allowed.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-016

**Both enables when full** · Standalone FIFO · P0 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill to capacity; assert wr_en=rd_en=1 for one edge with a new wr_data.
- **Expected result:** Only the read is accepted because pre-edge full=1; the write is blocked and occupancy becomes DEPTH-1. Resend the new word later if it must be stored.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-021

**Reset and first usable cycle** · RAM-backed FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Hold wr_en=rd_en=0. Assert rst=1, clock the design, then release reset away from the active edge.
- **Expected result:** After the specified reset event: empty=1 and full=0; pointers/count are reset. rd_data is driven by an always-reading synchronous RAM, so it may change even when rd_en=0 or empty=1. Do not require output hold or reset-to-zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-022

**Single write then single read** · RAM-backed FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write A5 with wr_en=1 while full=0; disable write; request one read with rd_en=1 while empty=0.
- **Expected result:** empty clears after the write and asserts after the read. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer. Exactly one word is transferred.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-023

**Ordering and mixed data** · RAM-backed FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write 10,22,35,48 with gaps, then drain using isolated and consecutive rd_en requests.
- **Expected result:** Read values are 10,22,35,48 in that order. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-024

**Fill to capacity and reject overflow** · RAM-backed FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** With rd_en=0, issue exactly DEPTH writes (2^AW (default 16)); check one below full and full. Attempt three further writes with distinct data, then drain.
- **Expected result:** full asserts only after the last available slot is used. Extra writes cannot move the write pointer or replace queued data. Draining returns the original DEPTH values.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-025

**Drain to empty and reject underflow** · RAM-backed FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill and drain exactly DEPTH accepted reads. Keep rd_en=1 for three additional clocks with wr_en=0.
- **Expected result:** empty asserts on the last accepted pop; extra reads do not advance the read pointer or change occupancy. rd_data is driven by an always-reading synchronous RAM, so it may change even when rd_en=0 or empty=1. Do not require output hold or reset-to-zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-026

**Both enables in the middle** · RAM-backed FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill to half capacity. Keep wr_en=rd_en=1 for at least 2*DEPTH clocks with a changing wr_data.
- **Expected result:** Both operations are accepted on each edge and occupancy stays constant. The stream remains ordered across pointer wraps. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-027

**Both enables when empty** · RAM-backed FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset empty, then assert wr_en=rd_en=1 for one edge with wr_data=3C.
- **Expected result:** Only the write is accepted because the pre-edge empty=1. Occupancy becomes one. No same-edge bypass/pop of 3C is allowed.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-028

**Both enables when full** · RAM-backed FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill to capacity; assert wr_en=rd_en=1 for one edge with a new wr_data.
- **Expected result:** Only the read is accepted because pre-edge full=1; the write is blocked and occupancy becomes DEPTH-1. Resend the new word later if it must be stored.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-033

**Reset and first usable cycle** · Wrapper FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Hold wren=rden=0. Assert rst=1, clock the design, then release reset away from the active edge.
- **Expected result:** After the specified reset event: empty=1 and full=0; pointers/count are reset. dout is driven by an always-reading synchronous RAM, so it may change even when rden=0 or empty=1. Do not require output hold or reset-to-zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-034

**Single write then single read** · Wrapper FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write A5 with wren=1 while full=0; disable write; request one read with rden=1 while empty=0.
- **Expected result:** empty clears after the write and asserts after the read. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer. Exactly one word is transferred.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-035

**Ordering and mixed data** · Wrapper FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write 10,22,35,48 with gaps, then drain using isolated and consecutive rden requests.
- **Expected result:** Read values are 10,22,35,48 in that order. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-036

**Fill to capacity and reject overflow** · Wrapper FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** With rden=0, issue exactly DEPTH writes (2^aw (default 16)); check one below full and full. Attempt three further writes with distinct data, then drain.
- **Expected result:** full asserts only after the last available slot is used. Extra writes cannot move the write pointer or replace queued data. Draining returns the original DEPTH values.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-037

**Drain to empty and reject underflow** · Wrapper FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill and drain exactly DEPTH accepted reads. Keep rden=1 for three additional clocks with wren=0.
- **Expected result:** empty asserts on the last accepted pop; extra reads do not advance the read pointer or change occupancy. dout is driven by an always-reading synchronous RAM, so it may change even when rden=0 or empty=1. Do not require output hold or reset-to-zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-038

**Both enables in the middle** · Wrapper FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill to half capacity. Keep wren=rden=1 for at least 2*DEPTH clocks with a changing din.
- **Expected result:** Both operations are accepted on each edge and occupancy stays constant. The stream remains ordered across pointer wraps. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-039

**Both enables when empty** · Wrapper FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset empty, then assert wren=rden=1 for one edge with din=3C.
- **Expected result:** Only the write is accepted because the pre-edge empty=1. Occupancy becomes one. No same-edge bypass/pop of 3C is allowed.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-040

**Both enables when full** · Wrapper FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill to capacity; assert wren=rden=1 for one edge with a new din.
- **Expected result:** Only the read is accepted because pre-edge full=1; the write is blocked and occupancy becomes DEPTH-1. Resend the new word later if it must be stored.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-047

**Compile isolated tops and record reproducible evidence** · Build and evidence · P0 · Pending · Source review

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-048

**Separate the write edge from the read check** · RAM · P0 · Pending · Simulation plan

- **Source:** [1. individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use default DW=8, AW=4. Before edge E0 set we=1, waddr=raddr=0, din=A5 hex. After E0 set we=0. Check dout after E1, then change raddr between E1 and E2 after initializing that new address to 3C hex.
- **Expected result:** The E0 collision reads unspecified old memory and is not required to return A5. E1 returns A5. Changing raddr alone cannot change dout; E2 returns the newly selected initialized word.
- **Coverage target:** First write/read; registered address response; read-first collision; two independently initialized addresses.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-051

**Occupancy and request cross at every boundary** · Standalone FIFO · P0 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Independently initialize occupancy to 0,1,DEPTH-1,DEPTH, plus a middle value if distinct. At each level issue all four wr_en/rd_en combinations for one edge. Rebuild the starting queue between trials.
- **Expected result:** Use W=wr_en&&!full and R=rd_en&&!empty from BEFORE the edge. New occupancy=old+W-R. Empty/both accepts only W; full/both accepts only R. Compare the accepted read after its clock edge; otherwise the read register holds.
- **Coverage target:** Every distinct occupancy boundary crossed with 00,01,10,11 requests; accepted and rejected operations separately.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-052

**Full release does not retroactively accept a write** · Standalone FIFO · P0 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill with tagged words. At E0 assert wr_en=rd_en=1 and offer X while full=1. At E1 keep both high and offer Y. Then stop writes and drain.
- **Expected result:** E0 reads the old head and rejects X. E1 accepts Y and reads the next old word. X never appears; Y follows the retained older words. full is recomputed from post-edge occupancy.
- **Coverage target:** Full to nonfull; rejected write beside accepted read; next-edge acceptance.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-053

**Empty release and smallest queue** · Standalone FIFO · P0 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Start empty. At E0 assert both requests and offer A5. At E1 deassert write and request a read. Repeat with both requests still high at E1 while offering 3C.
- **Expected result:** E0 has no accepted read. E1 reads A5; when E1 also accepts a write, occupancy stays one and the next accepted read returns 3C. Compare the accepted read after its clock edge; otherwise the read register holds.
- **Coverage target:** Empty->one->empty and empty->one->one; no same-edge bypass.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-055

**Occupancy and request cross at every boundary** · RAM-backed FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Independently initialize occupancy to 0,1,DEPTH-1,DEPTH, plus a middle value if distinct. At each level issue all four wr_en/rd_en combinations for one edge. Rebuild the starting queue between trials.
- **Expected result:** Use W=wr_en&&!full and R=rd_en&&!empty from BEFORE the edge. New occupancy=old+W-R. Empty/both accepts only W; full/both accepts only R. Compare the accepted read after its clock edge. Ignore unaccepted RAM read values.
- **Coverage target:** Every distinct occupancy boundary crossed with 00,01,10,11 requests; accepted and rejected operations separately.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-056

**Full release does not retroactively accept a write** · RAM-backed FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill with tagged words. At E0 assert wr_en=rd_en=1 and offer X while full=1. At E1 keep both high and offer Y. Then stop writes and drain.
- **Expected result:** E0 reads the old head and rejects X. E1 accepts Y and reads the next old word. X never appears; Y follows the retained older words. full is recomputed from post-edge occupancy.
- **Coverage target:** Full to nonfull; rejected write beside accepted read; next-edge acceptance.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-057

**Empty release and smallest queue** · RAM-backed FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Start empty. At E0 assert both requests and offer A5. At E1 deassert write and request a read. Repeat with both requests still high at E1 while offering 3C.
- **Expected result:** E0 has no accepted read. E1 reads A5; when E1 also accepts a write, occupancy stays one and the next accepted read returns 3C. Compare the accepted read after its clock edge. Ignore unaccepted RAM read values.
- **Coverage target:** Empty->one->empty and empty->one->one; no same-edge bypass.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-059

**Occupancy and request cross at every boundary** · RAM-backed FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Independently initialize occupancy to 0,1,DEPTH-1,DEPTH, plus a middle value if distinct. At each level issue all four wren/rden combinations for one edge. Rebuild the starting queue between trials.
- **Expected result:** Use W=wren&&!full and R=rden&&!empty from BEFORE the edge. New occupancy=old+W-R. Empty/both accepts only W; full/both accepts only R. Compare the accepted read after its clock edge. Ignore unaccepted RAM read values.
- **Coverage target:** Every distinct occupancy boundary crossed with 00,01,10,11 requests; accepted and rejected operations separately.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-060

**Full release does not retroactively accept a write** · RAM-backed FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill with tagged words. At E0 assert wren=rden=1 and offer X while full=1. At E1 keep both high and offer Y. Then stop writes and drain.
- **Expected result:** E0 reads the old head and rejects X. E1 accepts Y and reads the next old word. X never appears; Y follows the retained older words. full is recomputed from post-edge occupancy.
- **Coverage target:** Full to nonfull; rejected write beside accepted read; next-edge acceptance.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-061

**Empty release and smallest queue** · RAM-backed FIFO · P0 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Start empty. At E0 assert both requests and offer A5. At E1 deassert write and request a read. Repeat with both requests still high at E1 while offering 3C.
- **Expected result:** E0 has no accepted read. E1 reads A5; when E1 also accepts a write, occupancy stays one and the next accepted read returns 3C. Compare the accepted read after its clock edge. Ignore unaccepted RAM read values.
- **Coverage target:** Empty->one->empty and empty->one->one; no same-edge bypass.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-002

**Write enable protects contents** · RAM · P1 · Pending · Simulation plan

- **Source:** [1. individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize address 0. Hold we=0 while toggling din and waddr; read address 0 again.
- **Expected result:** dout returns the initialized word. No location changes while we=0.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-005

**Different-address concurrent access** · RAM · P1 · Pending · Simulation plan

- **Source:** [1. individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Read an initialized raddr while we=1 writes a different waddr; repeat with both addresses at the range ends.
- **Expected result:** The read returns the old contents of raddr; the independent write is visible on a later read of waddr.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-006

**Data bit patterns** · RAM · P1 · Pending · Simulation plan

- **Source:** [1. individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write/read 00, all ones, alternating 55/AA, walking one and walking zero in each data bit. Fit each pattern to the configured data width.
- **Expected result:** Every bit is preserved without truncation, coupling or unwanted sign extension.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-007

**Uninitialized read and no reset port** · RAM · P1 · Pending · Simulation plan

- **Source:** [1. individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Start a fresh simulation and read a location before writing it. Then initialize that location and read it again.
- **Expected result:** The first value is unspecified/X in this RTL; it is not a required zero. Only the initialized read has a numeric pass criterion. There is no RAM reset input.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-017

**Idle and output validity** · Standalone FIFO · P1 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pause both enables at empty, one word, half-full and full. Toggle wr_data while idle.
- **Expected result:** Pointers/count and flags hold. rd_data holds the last accepted read while no read is accepted, and resets to zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-018

**Repeated wraparound** · Standalone FIFO · P1 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Alternate fill/drain and mixed bursts until each pointer wraps at least four times. Use a sequence number for every accepted write.
- **Expected result:** No duplication, loss or reordering. Counts stay between zero and DEPTH; full and empty cannot both be true.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-019

**Reset with queued traffic** · Standalone FIFO · P1 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill, assert rst during traffic, then hold enables low through reset. Discard the software reference queue; release reset and write fresh values.
- **Expected result:** Old queued values are discarded logically. The first fresh drain returns only post-reset accepted writes. rd_data holds the last accepted read while no read is accepted, and resets to zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-029

**Idle and output validity** · RAM-backed FIFO · P1 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pause both enables at empty, one word, half-full and full. Toggle wr_data while idle.
- **Expected result:** Pointers/count and flags hold. rd_data is driven by an always-reading synchronous RAM, so it may change even when rd_en=0 or empty=1. Do not require output hold or reset-to-zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-030

**Repeated wraparound** · RAM-backed FIFO · P1 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Alternate fill/drain and mixed bursts until each pointer wraps at least four times. Use a sequence number for every accepted write.
- **Expected result:** No duplication, loss or reordering. Counts stay between zero and DEPTH; full and empty cannot both be true.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-031

**Reset with queued traffic** · RAM-backed FIFO · P1 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill, assert rst during traffic, then hold enables low through reset. Discard the software reference queue; release reset and write fresh values.
- **Expected result:** Old queued values are discarded logically. The first fresh drain returns only post-reset accepted writes. rd_data is driven by an always-reading synchronous RAM, so it may change even when rd_en=0 or empty=1. Do not require output hold or reset-to-zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-041

**Idle and output validity** · Wrapper FIFO · P1 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pause both enables at empty, one word, half-full and full. Toggle din while idle.
- **Expected result:** Pointers/count and flags hold. dout is driven by an always-reading synchronous RAM, so it may change even when rden=0 or empty=1. Do not require output hold or reset-to-zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-042

**Repeated wraparound** · Wrapper FIFO · P1 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Alternate fill/drain and mixed bursts until each pointer wraps at least four times. Use a sequence number for every accepted write.
- **Expected result:** No duplication, loss or reordering. Counts stay between zero and DEPTH; full and empty cannot both be true.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-043

**Reset with queued traffic** · Wrapper FIFO · P1 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill, assert rst during traffic, then hold enables low through reset. Discard the software reference queue; release reset and write fresh values.
- **Expected result:** Old queued values are discarded logically. The first fresh drain returns only post-reset accepted writes. dout is driven by an always-reading synchronous RAM, so it may change even when rden=0 or empty=1. Do not require output hold or reset-to-zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-045

**Reset while write remains asserted** · RAM-backed FIFO · P1 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, full, do_write, wr_ptr, fifo_count
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill a known slot; assert rst=1 with wr_en=1 and full=0 at a clock edge. Observe ram_inst.mem and control state separately.
- **Expected result:** Control pointers/count reset, but do_write is not gated by rst, so RAM can still be written at the old wr_ptr. Decide whether reset must suppress physical writes before adding that requirement.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Source-review finding; not a simulated failure. No old data is valid after FIFO reset.

### RF-049

**March read/write transitions over the whole RAM** · RAM · P1 · Pending · Simulation plan

- **Source:** [1. individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize all DEPTH addresses to zero. Ascend through addresses: read 0 on an edge, write all ones on a later edge; repeat read-all-ones/write-zero. Perform the same two phases descending, then read zero everywhere. Keep write and verification read phases distinct.
- **Expected result:** Every check returns the expected pre-existing word after the registered read edge. Report address, phase, bit and expected/actual values. This exercise checks the listed transition/address behaviors; it does not prove every physical SRAM fault model.
- **Coverage target:** Every address; both traversal directions; each bit 0->1 and 1->0.
- **Stop rule:** 6*DEPTH read/write pairs plus initialization/final reads; stop on first mismatch.

### RF-050

**Power-of-two address boundary pairs** · RAM · P1 · Pending · Simulation plan

- **Source:** [1. individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For each address bit k, write complementary words to A=0 and B=2^k, verify both, then exchange the words. Also use A=DEPTH-1 and B=A XOR 2^k.
- **Expected result:** The selected address bit distinguishes both locations in both address backgrounds. No other initialized location changes. Use all valid address bits and legal indices only.
- **Coverage target:** Each address bit independently selects distinct storage; low/high address backgrounds.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-054

**Independent width and capacity sweep** · Standalone FIFO · P1 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run the occupancy cross and wrap test with data widths 1,8,17 and address widths 1,2,4. Use DW/AW for sync_fifo and sync_fifo_ram, dw/aw for syncFifo. Fit all data and indices to each configuration.
- **Expected result:** Capacity is exactly 2^address_width. Wrap does not alter FIFO order, and 17-bit data retains its upper bit. Small depth two gets separate full/empty tests without assuming a distinct half-full state.
- **Coverage target:** Nine parameter combinations; smallest legal depth; non-byte-aligned data width.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-058

**Independent width and capacity sweep** · RAM-backed FIFO · P1 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run the occupancy cross and wrap test with data widths 1,8,17 and address widths 1,2,4. Use DW/AW for sync_fifo and sync_fifo_ram, dw/aw for syncFifo. Fit all data and indices to each configuration.
- **Expected result:** Capacity is exactly 2^address_width. Wrap does not alter FIFO order, and 17-bit data retains its upper bit. Small depth two gets separate full/empty tests without assuming a distinct half-full state.
- **Coverage target:** Nine parameter combinations; smallest legal depth; non-byte-aligned data width.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-062

**Independent width and capacity sweep** · RAM-backed FIFO · P1 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run the occupancy cross and wrap test with data widths 1,8,17 and address widths 1,2,4. Use DW/AW for sync_fifo and sync_fifo_ram, dw/aw for syncFifo. Fit all data and indices to each configuration.
- **Expected result:** Capacity is exactly 2^address_width. Wrap does not alter FIFO order, and 17-bit data retains its upper bit. Small depth two gets separate full/empty tests without assuming a distinct half-full state.
- **Coverage target:** Nine parameter combinations; smallest legal depth; non-byte-aligned data width.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-008

**Back-to-back overwrite and parameter corners** · RAM · P2 · Pending · Simulation plan

- **Source:** [1. individual/ram/sync_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/sync_ram.v)
- **Signals:** clk, we, waddr, raddr, din, dout
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Overwrite the same address on consecutive clocks and verify the last word. Repeat the suite at DW=1,8,16 and AW=1,2,4, using legal address ranges.
- **Expected result:** Last accepted write wins; capacity is 2^AW. Default DW=8, AW=4 means 16 entries. Check parameter names in the source before each build.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### RF-020

**Random bursts with a reference queue** · Standalone FIFO · P2 · Pending · Simulation plan

- **Source:** [1. individual/fifo/sync_fifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/fifo/sync_fifo.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run 1000 or more edges for each of three recorded seeds. Bias requests toward empty/full and one-away states. Queue only writes accepted by pre-edge flags and dequeue only accepted reads.
- **Expected result:** Every accepted read matches the oldest reference word. End by draining and proving the reference queue empty. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### RF-032

**Random bursts with a reference queue** · RAM-backed FIFO · P2 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/sync_fifo_ram.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run 1000 or more edges for each of three recorded seeds. Bias requests toward empty/full and one-away states. Queue only writes accepted by pre-edge flags and dequeue only accepted reads.
- **Expected result:** Every accepted read matches the oldest reference word. End by draining and proving the reference queue empty. Compare rd_data AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### RF-044

**Random bursts with a reference queue** · Wrapper FIFO · P2 · Pending · Simulation plan

- **Source:** [1. integration/ram_and_fifo/rtl/syncFifo.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/integration/ram_and_fifo/rtl/syncFifo.v)
- **Signals:** clk, rst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run 1000 or more edges for each of three recorded seeds. Bias requests toward empty/full and one-away states. Queue only writes accepted by pre-edge flags and dequeue only accepted reads.
- **Expected result:** Every accepted read matches the oldest reference word. End by draining and proving the reference queue empty. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### RF-046

**Compile and compare draft contract** · Practice draft · P2 · Pending · Prerequisite

- **Source:** [1. individual/ram/practice.v](https://github.com/kapiltrip/RamAndFifo/blob/858ffb35bb31e70051ca25d6cb24e5aa5020bd41/individual/ram/practice.v)
- **Signals:** clk, we, din, raddr, waddr, dout
- **Setup:** Build the listed RTL in isolation, with source revision 858ffb35bb31. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Compile this draft alone with an explicit top. Compare its interface and behavior with the active design in the same repository; record missing declarations and output drivers.
- **Expected result:** The draft must elaborate and meet an agreed contract before it can share active-design results. Do not include unfinished drafts in a wildcard compile.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Draft results are separate from active RTL.

