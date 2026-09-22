# UART-: detailed Verilog verification cases

[Plan index](../VERIFICATION_PLAN.md) · [Excel tracker](../VERIFICATION_CASES.xlsx) · [HDL source map](../VERIFICATION_SOURCE_MAP.md)

**53 cases, 6 HDL files.** Reviewed revision [5f65f99cf43e](https://github.com/kapiltrip/UART-/commit/5f65f99cf43ed317f18874503046f994d5038c65). This is a verification *plan*: no new simulation result is claimed.

## Design contract to check

TX/RX timing depends on tx_en and rx_en. Receiver has no input synchronizer. Buffered top loops TX to RX internally and does not export TX FIFO full. Follow the exact stimulus and expected timing in each case.

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
| [UART-001](#uart-001) | P0 | UART FIFO | Reset and first usable cycle | Pending |
| [UART-002](#uart-002) | P0 | UART FIFO | Single write then single read | Pending |
| [UART-003](#uart-003) | P0 | UART FIFO | Ordering and mixed data | Pending |
| [UART-004](#uart-004) | P0 | UART FIFO | Fill to capacity and reject overflow | Pending |
| [UART-005](#uart-005) | P0 | UART FIFO | Drain to empty and reject underflow | Pending |
| [UART-006](#uart-006) | P0 | UART FIFO | Both enables in the middle | Pending |
| [UART-007](#uart-007) | P0 | UART FIFO | Both enables when empty | Pending |
| [UART-008](#uart-008) | P0 | UART FIFO | Both enables when full | Pending |
| [UART-013](#uart-013) | P0 | Baud generator | Reset polarity and initial enables | Pending |
| [UART-014](#uart-014) | P0 | Baud generator | Exact tick interval | Pending |
| [UART-017](#uart-017) | P0 | UART transmitter | Reset and idle level | Pending |
| [UART-018](#uart-018) | P0 | UART transmitter | 8N1 frame and bit order | Pending |
| [UART-020](#uart-020) | P0 | UART transmitter | Latched input data | Pending |
| [UART-025](#uart-025) | P0 | UART receiver | Reset and idle-high input | Pending |
| [UART-026](#uart-026) | P0 | UART receiver | Receive 8N1 independently | Pending |
| [UART-028](#uart-028) | P0 | UART receiver | Stop-bit error behavior | Pending |
| [UART-034](#uart-034) | P0 | Buffered UART loopback | One buffered byte end to end | Pending |
| [UART-035](#uart-035) | P0 | Buffered UART loopback | Burst into TX FIFO and ordered RX drain | Pending |
| [UART-036](#uart-036) | P0 | Buffered UART loopback | Busy is not TX backpressure | Pending |
| [UART-037](#uart-037) | P0 | Buffered UART loopback | TX overflow characterization | Pending |
| [UART-038](#uart-038) | P0 | Buffered UART loopback | RX full and receiver-register overrun | Pending |
| [UART-042](#uart-042) | P0 | Build and evidence | Compile isolated tops and record reproducible evidence | Pending |
| [UART-043](#uart-043) | P0 | UART transmitter | Every payload value with independent serial decode | Pending |
| [UART-046](#uart-046) | P0 | UART transmitter | Request on the last data tick and stop interval | Pending |
| [UART-047](#uart-047) | P0 | UART receiver | Every byte under all 16 start phases | Pending |
| [UART-051](#uart-051) | P0 | Buffered UART loopback | TX write admission at full with a simultaneous dequeue | Pending |
| [UART-052](#uart-052) | P0 | Buffered UART loopback | RX front stability under delayed consumption | Pending |
| [UART-009](#uart-009) | P1 | UART FIFO | Idle and output validity | Pending |
| [UART-010](#uart-010) | P1 | UART FIFO | Repeated wraparound | Pending |
| [UART-011](#uart-011) | P1 | UART FIFO | Reset with queued traffic | Pending |
| [UART-016](#uart-016) | P1 | Baud generator | TX/RX rate ratio | Pending |
| [UART-019](#uart-019) | P1 | UART transmitter | Byte patterns and all values | Pending |
| [UART-021](#uart-021) | P1 | UART transmitter | Write request while busy | Pending |
| [UART-022](#uart-022) | P1 | UART transmitter | Missing enable ticks | Pending |
| [UART-023](#uart-023) | P1 | UART transmitter | Reset mid-frame and recovery | Pending |
| [UART-024](#uart-024) | P1 | UART transmitter | Stop-bit duration before next frame | Pending |
| [UART-027](#uart-027) | P1 | UART receiver | Reject a false start | Pending |
| [UART-029](#uart-029) | P1 | UART receiver | Sticky ready and clear race | Pending |
| [UART-030](#uart-030) | P1 | UART receiver | Unread result overwritten | Pending |
| [UART-032](#uart-032) | P1 | UART receiver | Reset while receiving | Pending |
| [UART-033](#uart-033) | P1 | UART receiver | Input synchronization review | Pending |
| [UART-039](#uart-039) | P1 | Buffered UART loopback | One pending RX byte after space opens | Pending |
| [UART-040](#uart-040) | P1 | Buffered UART loopback | Held consume request | Pending |
| [UART-041](#uart-041) | P1 | Buffered UART loopback | Reset aborts TX and RX queues | Pending |
| [UART-044](#uart-044) | P1 | UART transmitter | Pause every frame position independently | Pending |
| [UART-045](#uart-045) | P1 | UART transmitter | Reset at every serial position | Pending |
| [UART-048](#uart-048) | P1 | UART receiver | False-start duration sweep | Pending |
| [UART-049](#uart-049) | P1 | UART receiver | Single-sample glitch at and away from a data sample | Pending |
| [UART-050](#uart-050) | P1 | UART receiver | Stop-low recovery followed by valid traffic | Pending |
| [UART-053](#uart-053) | P1 | Buffered UART loopback | Overload accounting across both FIFO boundaries | Pending |
| [UART-012](#uart-012) | P2 | UART FIFO | Random bursts with a reference queue | Pending |
| [UART-015](#uart-015) | P2 | Baud generator | Divisor corners and restart | Pending |
| [UART-031](#uart-031) | P2 | UART receiver | Phase and rate sweep | Pending |

## Detailed test ideas

### UART-001

**Reset and first usable cycle** · UART FIFO · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Hold wr_en=rd_en=0. Assert reset=1, clock the design, then release reset away from the active edge.
- **Expected result:** After the specified reset event: empty=1 and full=0; pointers/count are reset. rd_data is show-ahead; it can change when the first word is written. It is unspecified while empty.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-002

**Single write then single read** · UART FIFO · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write A5 with wr_en=1 while full=0; disable write; request one read with rd_en=1 while empty=0.
- **Expected result:** empty clears after the write and asserts after the read. Compare rd_data to the expected front BEFORE the pop edge; after the edge it shows the next front when nonempty. Exactly one word is transferred.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-003

**Ordering and mixed data** · UART FIFO · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write 10,22,35,48 with gaps, then drain using isolated and consecutive rd_en requests.
- **Expected result:** Read values are 10,22,35,48 in that order. Compare rd_data to the expected front BEFORE the pop edge; after the edge it shows the next front when nonempty.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-004

**Fill to capacity and reject overflow** · UART FIFO · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** With rd_en=0, issue exactly DEPTH writes (16 fixed entries); check one below full and full. Attempt three further writes with distinct data, then drain.
- **Expected result:** full asserts only after the last available slot is used. Extra writes cannot move the write pointer or replace queued data. Draining returns the original DEPTH values.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-005

**Drain to empty and reject underflow** · UART FIFO · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill and drain exactly DEPTH accepted reads. Keep rd_en=1 for three additional clocks with wr_en=0.
- **Expected result:** empty asserts on the last accepted pop; extra reads do not advance the read pointer or change occupancy. rd_data is show-ahead; it can change when the first word is written. It is unspecified while empty.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-006

**Both enables in the middle** · UART FIFO · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill to half capacity. Keep wr_en=rd_en=1 for at least 2*DEPTH clocks with a changing wr_data.
- **Expected result:** Both operations are accepted on each edge and occupancy stays constant. The stream remains ordered across pointer wraps. Compare rd_data to the expected front BEFORE the pop edge; after the edge it shows the next front when nonempty.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-007

**Both enables when empty** · UART FIFO · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset empty, then assert wr_en=rd_en=1 for one edge with wr_data=3C.
- **Expected result:** Only the write is accepted because the pre-edge empty=1. Occupancy becomes one. No same-edge bypass/pop of 3C is allowed.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-008

**Both enables when full** · UART FIFO · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill to capacity; assert wr_en=rd_en=1 for one edge with a new wr_data.
- **Expected result:** Only the read is accepted because pre-edge full=1; the write is blocked and occupancy becomes DEPTH-1. Resend the new word later if it must be stored.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-013

**Reset polarity and initial enables** · Baud generator · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/baud_rate_generator.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/baud_rate_generator.v)
- **Signals:** clk, reset, tx_en, rx_en
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Assert reset=1 across rising clk edges; inspect the counters and both enables before releasing reset.
- **Expected result:** Counters and registered tx_en/rx_en reset to 0. No enable pulse is emitted while reset is active.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-014

**Exact tick interval** · Baud generator · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/baud_rate_generator.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/baud_rate_generator.v)
- **Signals:** clk, reset, tx_en, rx_en
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Count clk edges between at least ten tx_en pulses and ten rx_en pulses after reset.
- **Expected result:** Periods are TX_DIV=5208 clocks and RX_DIV=325 clocks. Each pulse is one clk period at these defaults.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-017

**Reset and idle level** · UART transmitter · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, rst, wr_en, data_in, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Assert rst; release with wr_en=0. Run several tx_en pulses.
- **Expected result:** After reset tx=1 and busy=0. Idle remains high.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-018

**8N1 frame and bit order** · UART transmitter · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, rst, wr_en, data_in, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pulse wr_en for one clk with data_in=A5 while busy=0. Supply regular tx_en ticks and record tx at each tick.
- **Expected result:** Frame is start 0, data bits 1,0,1,0,0,1,0,1 (LSB first), then stop 1. busy rises on the accepted request and falls when stop is launched.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-020

**Latched input data** · UART transmitter · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Accept 3C, then change data_in every clk while busy=1.
- **Expected result:** The current frame remains 3C; the input is latched at request acceptance.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-025

**Reset and idle-high input** · UART receiver · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Assert rst, then release with rx=1, rdy_clr=0 and periodic rx_en.
- **Expected result:** rdy=0 and data_out=0 after reset; idle-high rx must not create a receive event.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-026

**Receive 8N1 independently** · UART receiver · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive rx from an independent serial source: start 0, eight LSB-first bits for A5, stop 1. Use 16 rx_en samples per bit.
- **Expected result:** One completed frame sets data_out=A5 and rdy=1. Check after the stop sampling edge and nonblocking updates.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-028

**Stop-bit error behavior** · UART receiver · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Clear previous rdy; send a valid start and eight data bits, but keep rx low at the stop sample. Then return idle high and send a valid frame.
- **Expected result:** Current receiver rejects the bad stop: no new rdy and no data_out update. It has no separate framing-error port.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-034

**One buffered byte end to end** · Buffered UART loopback · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, reset, wr_en, data_in, rdy, rdy_clr, data_out, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset, pulse wr_en with 47, wait with a bounded timeout for rdy=1, inspect data_out, then pulse rdy_clr.
- **Expected result:** One byte 47 is visible at the receive FIFO head. rdy_clr pops it; rdy falls when the RX FIFO becomes empty.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-035

**Burst into TX FIFO and ordered RX drain** · Buffered UART loopback · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, wr_en, data_in, rdy, rdy_clr, data_out, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** After reset enqueue 12 distinct bytes on consecutive clk edges. Let serialization finish, then drain using one-cycle rdy_clr pulses.
- **Expected result:** All 12 bytes return once, in order. Capture data_out before each pop edge because the RX FIFO is show-ahead.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-036

**Busy is not TX backpressure** · Buffered UART loopback · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, wr_en, data_in, busy, tx_start, tx_fifo_empty
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Watch busy while adding bytes faster than line rate; compare accepted writes to the internal tx_fifo.full flag.
- **Expected result:** busy reports transmitter activity only. A write can be accepted while busy=1 if FIFO space exists; busy=0 is not a formal FIFO write-ready signal.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-037

**TX overflow characterization** · Buffered UART loopback · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, wr_en, data_in, busy, tx_start
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Stop or greatly slow baud progress; offer more bytes than the 16-entry TX FIFO plus any active transmitter byte can hold. Track tx_fifo.full internally.
- **Expected result:** Writes while tx_fifo.full=1 are dropped. The top does not expose full or an acceptance indication. Record offered versus accepted versus received counts; do not claim lossless arbitrary bursts.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-038

**RX full and receiver-register overrun** · Buffered UART loopback · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, wr_en, data_in, rdy, rdy_clr, data_out, rx_byte_ready, rx_fifo_full
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** With rdy_clr=0, send enough frames to fill RX FIFO, then allow two more frame completions before freeing a slot.
- **Expected result:** RX FIFO protects its stored 16 words, but the receiver holds only one additional result. Later frames can overwrite that pending result. Record the loss boundary and need for flow control.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-042

**Compile isolated tops and record reproducible evidence** · Build and evidence · P0 · Pending · Source review

- **Source:** [1. rtlCode/baud_rate_generator.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/baud_rate_generator.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-043

**Every payload value with independent serial decode** · UART transmitter · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, rst, wr_en, tx_en, data_in, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For each byte 00..FF, wait for the source-defined idle acceptance, pulse wr_en for one clk, then change data_in. Supply a regular tx_en tick train. Decode tx independently at the middle of each transmitted bit.
- **Expected result:** Exactly one start=0, eight LSB-first bits, and stop=1 describe the accepted byte. busy and frame count must not be used as substitutes for decoding the wire. Changing data_in after acceptance cannot corrupt the latched frame.
- **Coverage target:** All 256 byte values; every bit position 0 and 1; 00,FF,55,AA emphasized.
- **Stop rule:** Per isolated byte, 14 enabled TX ticks plus request setup; stop if a frame or return to idle is missing.

### UART-046

**Request on the last data tick and stop interval** · UART transmitter · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, rst, wr_en, tx_en, data_in, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Offer a second-byte one-clock wr_en pulse while the first frame is still in its data state, then in its stop state and once the state is IDLE. Inspect tx and state timing around busy falling.
- **Expected result:** A pulse is accepted only by the RTL IDLE request path. busy falling at stop launch does not prove that a coincident pulse was accepted. Accepted frames retain a full stop interval before the next start; record ignored pulses as interface behavior.
- **Coverage target:** Last data, stop launch, stop interval and first actual IDLE request opportunity.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-047

**Every byte under all 16 start phases** · UART receiver · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive independent ideal 8N1 frames with 16 rx_en samples per bit. Sweep all 256 payload values; for each, shift the falling start edge through all 16 sample-phase positions. Clear rdy between independent checks.
- **Expected result:** Every valid frame produces the intended byte and one completion event. Account for the legacy input synchronizer when locating the sampled start edge. Compare only after the ready-producing NBA update, and record frame count independently of sticky rdy.
- **Coverage target:** 256 bytes x 16 start phases; both polarities at each bit position.
- **Stop rule:** Allow 200 rx_en ticks per isolated frame plus the legacy input synchronizer delay; no unbounded wait for rdy.

### UART-051

**TX write admission at full with a simultaneous dequeue** · Buffered UART loopback · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, reset, wr_en, data_in, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive enough application writes to fill the internal 16-entry TX FIFO. Align a one-cycle extra wr_en request with the serializer dequeue while the FIFO begins full. Observe the internal FIFO flags and enables.
- **Expected result:** The FIFO blocks the extra write based on PRE-edge full even if the same edge frees a slot. busy is serializer activity, not FIFO ready. The reference TX queue records only internal accepted writes.
- **Coverage target:** TX FIFO full plus dequeue/write collision; dropped request identified by tag.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-052

**RX front stability under delayed consumption** · Buffered UART loopback · P0 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, reset, wr_en, data_in, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Send four distinct bytes within TX capacity. Keep rdy_clr=0 while several results accumulate, observe the front data, then pulse rdy_clr for exactly one edge at a time.
- **Expected result:** While rdy=1 and no pop is accepted, data_out remains the current RX FIFO front even as later bytes arrive. Each accepted rdy_clr pop advances exactly one byte. A high rdy_clr held over several clocks consumes one word per eligible clock.
- **Coverage target:** Hold front with later arrivals; single-cycle pop; held pop; final empty.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-009

**Idle and output validity** · UART FIFO · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pause both enables at empty, one word, half-full and full. Toggle wr_data while idle.
- **Expected result:** Pointers/count and flags hold. rd_data is show-ahead; it can change when the first word is written. It is unspecified while empty.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-010

**Repeated wraparound** · UART FIFO · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Alternate fill/drain and mixed bursts until each pointer wraps at least four times. Use a sequence number for every accepted write.
- **Expected result:** No duplication, loss or reordering. Counts stay between zero and DEPTH; full and empty cannot both be true.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-011

**Reset with queued traffic** · UART FIFO · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill, assert reset during traffic, then hold enables low through reset. Discard the software reference queue; release reset and write fresh values.
- **Expected result:** Old queued values are discarded logically. The first fresh drain returns only post-reset accepted writes. rd_data is show-ahead; it can change when the first word is written. It is unspecified while empty.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-016

**TX/RX rate ratio** · Baud generator · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/baud_rate_generator.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/baud_rate_generator.v)
- **Signals:** clk, tx_en, rx_en
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Measure serial-bit duration and receiver sample spacing with the actual defaults, then use a small exact 16:1 setup in isolated tests.
- **Expected result:** Default tick ratios are close to, but not exactly, 16:1. Evaluate complete frames and phase variation; do not assume the parameter names represent the same terminal-count convention.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-019

**Byte patterns and all values** · UART transmitter · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Send 00,FF,55,AA,01,80 then all 256 byte values. Decode the serial line independently.
- **Expected result:** Every decoded byte equals the accepted data_in; exactly eight data bits plus start/stop are emitted.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-021

**Write request while busy** · UART transmitter · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pulse wr_en in START, each DATA position and STOP while busy=1. Then repeat with wr_en held until the next idle cycle.
- **Expected result:** Pulses entirely while busy are ignored by this transmitter. A held request can be accepted in IDLE and send another byte; it is not a one-shot interface.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-022

**Missing enable ticks** · UART transmitter · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, wr_en, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pause tx_en in START, DATA and STOP for several clk periods, then resume.
- **Expected result:** Frame state/bit position holds while waiting; tx and busy do not advance to the next serial bit without tx_en.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-023

**Reset mid-frame and recovery** · UART transmitter · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, rst, wr_en, data_in, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset during start, a data bit and stop; release and transmit a fresh byte.
- **Expected result:** Reset aborts the partial frame, restores idle-high tx and clears busy. A new request produces a complete fresh frame.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-024

**Stop-bit duration before next frame** · UART transmitter · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Submit the next byte at the earliest idle clk after busy falls; measure tx until the next start bit.
- **Expected result:** The stop interval remains a full baud-tick interval even though busy drops when stop is launched. Check timing from tx transitions rather than busy alone.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-027

**Reject a false start** · UART receiver · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a short low pulse that is high again by the middle-of-start validation sample, then a valid frame.
- **Expected result:** No byte is reported for the glitch. The next valid frame is received normally.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-029

**Sticky ready and clear race** · UART receiver · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Receive a byte with rdy_clr=0, wait, clear it, then assert rdy_clr on the same clk edge that another good stop is accepted.
- **Expected result:** rdy holds until clear. On coincident clear and good completion, the later receive assignment wins: rdy=1 with the new data.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-030

**Unread result overwritten** · UART receiver · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Send two frames without clearing rdy in between; record both completion moments.
- **Expected result:** This receiver has one result register. A later good frame replaces data_out even if previous rdy remained high; no overrun indication exists.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-032

**Reset while receiving** · UART receiver · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset during start, each data position and stop. Restore idle high before a fresh frame.
- **Expected result:** Partial frame is discarded; reset clears ready/data and the fresh frame is received once.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-033

**Input synchronization review** · UART receiver · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Trace the rx sampling path and distinguish this loopback demo from an external asynchronous pin.
- **Expected result:** This receiver samples rx directly when rx_en is high. Loopback works synchronously, but using an external asynchronous pin requires an input synchronization/CDC decision.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-039

**One pending RX byte after space opens** · Buffered UART loopback · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, rdy_clr, rdy, data_out, rx_fifo_write, rx_fifo_read
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill RX FIFO, allow exactly one pending received byte, then pop one word and stop further input frames.
- **Expected result:** After full clears, the pending byte enters once and rx_byte_ready is cleared. There is a clock of recovery because acceptance uses pre-edge full.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-040

**Held consume request** · Buffered UART loopback · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Buffer several received bytes and hold rdy_clr=1 across multiple clk edges.
- **Expected result:** One byte is popped per nonempty clk edge, not one per rising edge of rdy_clr. When empty, further requests are ignored.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-041

**Reset aborts TX and RX queues** · Buffered UART loopback · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, reset, wr_en, data_in, rdy, rdy_clr, data_out, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset with queued TX data and unread RX data; release with controls low, then send a fresh known sequence.
- **Expected result:** Both queues flush logically, busy=0 and rdy=0. Only post-reset accepted bytes may be counted; data_out while rdy=0 is not valid.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-044

**Pause every frame position independently** · UART transmitter · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, rst, wr_en, tx_en, data_in, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Transmit A5. On separate runs suppress tx_en for 1,3 and 17 clk edges while in START, at each data bit, and in STOP. Resume regular ticks.
- **Expected result:** The serial bit and transmitter progress hold while tx_en=0 in tick-controlled states. The decoded byte remains A5; bit widths stretch by the intentional pause. Reset remains able to abort the frame.
- **Coverage target:** Ten serial positions crossed with three pause lengths; enable hold/resume.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-045

**Reset at every serial position** · UART transmitter · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_sender.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_sender.v)
- **Signals:** clk, rst, wr_en, tx_en, data_in, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Assert rst during START, each of eight data positions, and STOP, both with tx_en=0 and tx_en=1. Keep wr_en low during reset. Release and request a new 3C frame.
- **Expected result:** After the module reset event, tx is idle high and busy clears. The aborted frame is discarded by the testbench decoder. The new frame starts from its start bit and contains exactly 3C.
- **Coverage target:** All ten frame positions crossed with tick absent/present; clean recovery.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-048

**False-start duration sweep** · UART receiver · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** From idle high, drive low pulses lasting 1..7 receiver sample ticks, then pulses that reach the START validation point. Follow each rejected pulse with a clean A5 frame. Sweep the pulse phase relative to clk.
- **Expected result:** If the sampled input is high at the mid-start validation point, the candidate is rejected and no new byte is reported. A pulse spanning that point enters DATA and needs separate framing evaluation. Thresholds refer to sampled rx, including legacy synchronization delay.
- **Coverage target:** Seven short pulse lengths; pulse straddling validation; valid recovery frame.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-049

**Single-sample glitch at and away from a data sample** · UART receiver · P1 · Pending · Characterization

- **Source:** [1. rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Send 55. In separate runs invert rx for one sample tick immediately before, exactly at, and after the selected data-bit sampling point. Repeat at bit 0 and bit 7.
- **Expected result:** This receiver uses one selected sample, not majority voting. A glitch overlapping that selected sample can change the decoded bit; glitches away from it should not. Record these as robustness characterization unless a stronger noise-rejection requirement is agreed.
- **Coverage target:** Two endpoint bits x three glitch positions; corrupted versus unchanged decoded data.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-050

**Stop-low recovery followed by valid traffic** · UART receiver · P1 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Send a byte with low stop, keep the line low for one more frame duration, restore idle high, clear any ready, then send a valid 3C frame.
- **Expected result:** Current UART- rejects the low stop; UART-legacy accepts the byte without validating stop. In both, characterize sustained-low behavior without treating a break as ordinary valid traffic, then verify recovery to a correctly decoded 3C.
- **Coverage target:** Bad stop; sustained low; return to idle; first valid recovery byte.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-053

**Overload accounting across both FIFO boundaries** · Buffered UART loopback · P1 · Pending · Characterization

- **Source:** [1. rtlCode/uart_top.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_top.v)
- **Signals:** clk, reset, wr_en, data_in, rdy_clr, rdy, busy
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Send a tagged stream while deliberately withholding RX consumption long enough to reach RX FIFO full. Record TX FIFO accepted writes, serializer frames, receiver completions, RX FIFO accepted writes and application pops separately.
- **Expected result:** Locate the first loss at its actual boundary. The receiver has only one holding register beyond a full RX FIFO, so later completions can overwrite unread holding data. Do not require lossless delivery under unbounded overload without an added backpressure/overrun contract.
- **Coverage target:** All five counts reconciled; RX capacity and extra holding result; recovery after draining.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-012

**Random bursts with a reference queue** · UART FIFO · P2 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_fifo.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_fifo.v)
- **Signals:** clk, reset, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run 1000 or more edges for each of three recorded seeds. Bias requests toward empty/full and one-away states. Queue only writes accepted by pre-edge flags and dequeue only accepted reads.
- **Expected result:** Every accepted read matches the oldest reference word. End by draining and proving the reference queue empty. Compare rd_data to the expected front BEFORE the pop edge; after the edge it shows the next front when nonempty.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### UART-015

**Divisor corners and restart** · Baud generator · P2 · Pending · Simulation plan

- **Source:** [1. rtlCode/baud_rate_generator.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/baud_rate_generator.v)
- **Signals:** clk, reset, tx_en, rx_en
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Repeat with small legal terminal values/divisors, reset midway through counting, and measure the restarted interval.
- **Expected result:** Counter widths limit the supported range. Current UART: TX_DIV 1..8192 and RX_DIV 1..1024; DIV=1 makes enable continuously high. Legacy: maximum terminal counts 8191 and 1023; zero makes enable continuously high. Do not silently truncate unsupported overrides.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UART-031

**Phase and rate sweep** · UART receiver · P2 · Pending · Simulation plan

- **Source:** [1. rtlCode/uart_receiver.v](https://github.com/kapiltrip/UART-/blob/5f65f99cf43ed317f18874503046f994d5038c65/rtlCode/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 5f65f99cf43e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Shift frame start through all 16 sample phases; sweep small positive/negative bit-period offsets and include 00,FF,55,AA.
- **Expected result:** All values in the agreed nominal tolerance pass. Record the measured tolerance boundary rather than inventing a guaranteed percentage.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

