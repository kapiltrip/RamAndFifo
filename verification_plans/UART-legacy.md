# UART-legacy: detailed Verilog verification cases

[Plan index](../VERIFICATION_PLAN.md) · [Excel tracker](../VERIFICATION_CASES.xlsx) · [HDL source map](../VERIFICATION_SOURCE_MAP.md)

**32 cases, 5 HDL files.** Reviewed revision [28d439c91eca](https://github.com/kapiltrip/UART-legacy/commit/28d439c91eca72edba0ce269ba01812ad02c2900). This is a verification *plan*: no new simulation result is claimed.

## Design contract to check

No FIFO at top. RX has a two-flop input synchronizer, accepts a low stop bit in source, and exposes sticky ready. Follow the exact stimulus and expected timing in each case.

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
| [UL-001](#ul-001) | P0 | Baud generator | Reset polarity and initial enables | Pending |
| [UL-002](#ul-002) | P0 | Baud generator | Exact tick interval | Pending |
| [UL-005](#ul-005) | P0 | UART transmitter | Reset and idle level | Pending |
| [UL-006](#ul-006) | P0 | UART transmitter | 8N1 frame and bit order | Pending |
| [UL-008](#ul-008) | P0 | UART transmitter | Latched input data | Pending |
| [UL-013](#ul-013) | P0 | UART receiver | Reset and idle-high input | Pending |
| [UL-014](#ul-014) | P0 | UART receiver | Receive 8N1 independently | Pending |
| [UL-016](#ul-016) | P0 | UART receiver | Stop-bit error behavior | Pending |
| [UL-022](#ul-022) | P0 | Legacy UART loopback | Loopback and explicit ready clear | Pending |
| [UL-024](#ul-024) | P0 | Build and evidence | Compile isolated tops and record reproducible evidence | Pending |
| [UL-025](#ul-025) | P0 | UART transmitter | Every payload value with independent serial decode | Pending |
| [UL-028](#ul-028) | P0 | UART transmitter | Request on the last data tick and stop interval | Pending |
| [UL-029](#ul-029) | P0 | UART receiver | Every byte under all 16 start phases | Pending |
| [UL-004](#ul-004) | P1 | Baud generator | TX/RX rate ratio | Pending |
| [UL-007](#ul-007) | P1 | UART transmitter | Byte patterns and all values | Pending |
| [UL-009](#ul-009) | P1 | UART transmitter | Write request while busy | Pending |
| [UL-010](#ul-010) | P1 | UART transmitter | Missing enable ticks | Pending |
| [UL-011](#ul-011) | P1 | UART transmitter | Reset mid-frame and recovery | Pending |
| [UL-012](#ul-012) | P1 | UART transmitter | Stop-bit duration before next frame | Pending |
| [UL-015](#ul-015) | P1 | UART receiver | Reject a false start | Pending |
| [UL-017](#ul-017) | P1 | UART receiver | Sticky ready and clear race | Pending |
| [UL-018](#ul-018) | P1 | UART receiver | Unread result overwritten | Pending |
| [UL-020](#ul-020) | P1 | UART receiver | Reset while receiving | Pending |
| [UL-021](#ul-021) | P1 | UART receiver | Input synchronization review | Pending |
| [UL-023](#ul-023) | P1 | Legacy UART loopback | No implicit transmit queue | Pending |
| [UL-026](#ul-026) | P1 | UART transmitter | Pause every frame position independently | Pending |
| [UL-027](#ul-027) | P1 | UART transmitter | Reset at every serial position | Pending |
| [UL-030](#ul-030) | P1 | UART receiver | False-start duration sweep | Pending |
| [UL-031](#ul-031) | P1 | UART receiver | Single-sample glitch at and away from a data sample | Pending |
| [UL-032](#ul-032) | P1 | UART receiver | Stop-low recovery followed by valid traffic | Pending |
| [UL-003](#ul-003) | P2 | Baud generator | Divisor corners and restart | Pending |
| [UL-019](#ul-019) | P2 | UART receiver | Phase and rate sweep | Pending |

## Detailed test ideas

### UL-001

**Reset polarity and initial enables** · Baud generator · P0 · Pending · Simulation plan

- **Source:** [1. baud_rate_generator.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/baud_rate_generator.v)
- **Signals:** clk, rst, tx_en, rx_en
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Assert rst=1 across rising clk edges; inspect the counters and both enables before releasing reset.
- **Expected result:** Counters reset to 0, so combinational tx_en and rx_en are HIGH during reset. Receiver/transmitter reset must take priority.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-002

**Exact tick interval** · Baud generator · P0 · Pending · Simulation plan

- **Source:** [1. baud_rate_generator.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/baud_rate_generator.v)
- **Signals:** clk, rst, tx_en, rx_en
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Count clk edges between at least ten tx_en pulses and ten rx_en pulses after reset.
- **Expected result:** Periods are TX_COUNT_MAX+1=5209 clocks and RX_COUNT_MAX+1=326 clocks, not 5208/325.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-005

**Reset and idle level** · UART transmitter · P0 · Pending · Simulation plan

- **Source:** [1. transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, rst, wr_en, data_in, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Assert rst; release with wr_en=0. Run several tx_en pulses.
- **Expected result:** After reset tx=1 and busy=0. Idle remains high.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-006

**8N1 frame and bit order** · UART transmitter · P0 · Pending · Simulation plan

- **Source:** [1. transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, rst, wr_en, data_in, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pulse wr_en for one clk with data_in=A5 while busy=0. Supply regular tx_en ticks and record tx at each tick.
- **Expected result:** Frame is start 0, data bits 1,0,1,0,0,1,0,1 (LSB first), then stop 1. busy rises on the accepted request and falls when stop is launched.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-008

**Latched input data** · UART transmitter · P0 · Pending · Simulation plan

- **Source:** [1. transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Accept 3C, then change data_in every clk while busy=1.
- **Expected result:** The current frame remains 3C; the input is latched at request acceptance.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-013

**Reset and idle-high input** · UART receiver · P0 · Pending · Simulation plan

- **Source:** [1. uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Assert rst, then release with rx=1, rdy_clr=0 and periodic rx_en.
- **Expected result:** rdy=0 and data_out=0 after reset; idle-high rx must not create a receive event.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-014

**Receive 8N1 independently** · UART receiver · P0 · Pending · Simulation plan

- **Source:** [1. uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive rx from an independent serial source: start 0, eight LSB-first bits for A5, stop 1. Use 16 rx_en samples per bit.
- **Expected result:** One completed frame sets data_out=A5 and rdy=1. Check after the stop sampling edge and nonblocking updates.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-016

**Stop-bit error behavior** · UART receiver · P0 · Pending · Simulation plan

- **Source:** [1. uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Clear previous rdy; send a valid start and eight data bits, but keep rx low at the stop sample. Then return idle high and send a valid frame.
- **Expected result:** Current legacy RTL accepts the byte without validating the stop bit. Record that limitation; do not claim framing-error protection.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-022

**Loopback and explicit ready clear** · Legacy UART loopback · P0 · Pending · Simulation plan

- **Source:** [1. uart_top_tb.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_top_tb.v)
- **Signals:** clk, rst, wr_en, data_in, ready, rdy_clr, data_out, busy
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset, send 47 only while busy=0, wait for ready, compare data_out, clear ready, then repeat with 55.
- **Expected result:** 47 then 55 are received. ready remains high until rdy_clr. Use a watchdog; the existing print-only bench is not proof of equality.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-024

**Compile isolated tops and record reproducible evidence** · Build and evidence · P0 · Pending · Source review

- **Source:** [1. baud_rate_generator.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/baud_rate_generator.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-025

**Every payload value with independent serial decode** · UART transmitter · P0 · Pending · Simulation plan

- **Source:** [1. transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, rst, wr_en, tx_en, data_in, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For each byte 00..FF, wait for the source-defined idle acceptance, pulse wr_en for one clk, then change data_in. Supply a regular tx_en tick train. Decode tx independently at the middle of each transmitted bit.
- **Expected result:** Exactly one start=0, eight LSB-first bits, and stop=1 describe the accepted byte. busy and frame count must not be used as substitutes for decoding the wire. Changing data_in after acceptance cannot corrupt the latched frame.
- **Coverage target:** All 256 byte values; every bit position 0 and 1; 00,FF,55,AA emphasized.
- **Stop rule:** Per isolated byte, 14 enabled TX ticks plus request setup; stop if a frame or return to idle is missing.

### UL-028

**Request on the last data tick and stop interval** · UART transmitter · P0 · Pending · Simulation plan

- **Source:** [1. transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, rst, wr_en, tx_en, data_in, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Offer a second-byte one-clock wr_en pulse while the first frame is still in its data state, then in its stop state and once the state is IDLE. Inspect tx and state timing around busy falling.
- **Expected result:** A pulse is accepted only by the RTL IDLE request path. busy falling at stop launch does not prove that a coincident pulse was accepted. Accepted frames retain a full stop interval before the next start; record ignored pulses as interface behavior.
- **Coverage target:** Last data, stop launch, stop interval and first actual IDLE request opportunity.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-029

**Every byte under all 16 start phases** · UART receiver · P0 · Pending · Simulation plan

- **Source:** [1. uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive independent ideal 8N1 frames with 16 rx_en samples per bit. Sweep all 256 payload values; for each, shift the falling start edge through all 16 sample-phase positions. Clear rdy between independent checks.
- **Expected result:** Every valid frame produces the intended byte and one completion event. Account for the legacy input synchronizer when locating the sampled start edge. Compare only after the ready-producing NBA update, and record frame count independently of sticky rdy.
- **Coverage target:** 256 bytes x 16 start phases; both polarities at each bit position.
- **Stop rule:** Allow 200 rx_en ticks per isolated frame plus the legacy input synchronizer delay; no unbounded wait for rdy.

### UL-004

**TX/RX rate ratio** · Baud generator · P1 · Pending · Simulation plan

- **Source:** [1. baud_rate_generator.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/baud_rate_generator.v)
- **Signals:** clk, tx_en, rx_en
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Measure serial-bit duration and receiver sample spacing with the actual defaults, then use a small exact 16:1 setup in isolated tests.
- **Expected result:** Default tick ratios are close to, but not exactly, 16:1. Evaluate complete frames and phase variation; do not assume the parameter names represent the same terminal-count convention.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-007

**Byte patterns and all values** · UART transmitter · P1 · Pending · Simulation plan

- **Source:** [1. transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Send 00,FF,55,AA,01,80 then all 256 byte values. Decode the serial line independently.
- **Expected result:** Every decoded byte equals the accepted data_in; exactly eight data bits plus start/stop are emitted.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-009

**Write request while busy** · UART transmitter · P1 · Pending · Simulation plan

- **Source:** [1. transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pulse wr_en in START, each DATA position and STOP while busy=1. Then repeat with wr_en held until the next idle cycle.
- **Expected result:** Pulses entirely while busy are ignored by this transmitter. A held request can be accepted in IDLE and send another byte; it is not a one-shot interface.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-010

**Missing enable ticks** · UART transmitter · P1 · Pending · Simulation plan

- **Source:** [1. transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, wr_en, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pause tx_en in START, DATA and STOP for several clk periods, then resume.
- **Expected result:** Frame state/bit position holds while waiting; tx and busy do not advance to the next serial bit without tx_en.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-011

**Reset mid-frame and recovery** · UART transmitter · P1 · Pending · Simulation plan

- **Source:** [1. transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, rst, wr_en, data_in, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset during start, a data bit and stop; release and transmit a fresh byte.
- **Expected result:** Reset aborts the partial frame, restores idle-high tx and clears busy. A new request produces a complete fresh frame.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-012

**Stop-bit duration before next frame** · UART transmitter · P1 · Pending · Simulation plan

- **Source:** [1. transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, wr_en, data_in, tx_en, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Submit the next byte at the earliest idle clk after busy falls; measure tx until the next start bit.
- **Expected result:** The stop interval remains a full baud-tick interval even though busy drops when stop is launched. Check timing from tx transitions rather than busy alone.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-015

**Reject a false start** · UART receiver · P1 · Pending · Simulation plan

- **Source:** [1. uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a short low pulse that is high again by the middle-of-start validation sample, then a valid frame.
- **Expected result:** No byte is reported for the glitch. The next valid frame is received normally.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-017

**Sticky ready and clear race** · UART receiver · P1 · Pending · Simulation plan

- **Source:** [1. uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Receive a byte with rdy_clr=0, wait, clear it, then assert rdy_clr on the same clk edge that another good stop is accepted.
- **Expected result:** rdy holds until clear. On coincident clear and good completion, the later receive assignment wins: rdy=1 with the new data.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-018

**Unread result overwritten** · UART receiver · P1 · Pending · Simulation plan

- **Source:** [1. uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Send two frames without clearing rdy in between; record both completion moments.
- **Expected result:** This receiver has one result register. A later good frame replaces data_out even if previous rdy remained high; no overrun indication exists.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-020

**Reset while receiving** · UART receiver · P1 · Pending · Simulation plan

- **Source:** [1. uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset during start, each data position and stop. Restore idle high before a fresh frame.
- **Expected result:** Partial frame is discarded; reset clears ready/data and the fresh frame is received once.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-021

**Input synchronization review** · UART receiver · P1 · Pending · Simulation plan

- **Source:** [1. uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Trace the rx sampling path and distinguish this loopback demo from an external asynchronous pin.
- **Expected result:** rx passes through rx_meta then rx_sync on clk. Account for the two clk stages in phase tests; physical CDC still needs implementation review.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-023

**No implicit transmit queue** · Legacy UART loopback · P1 · Pending · Simulation plan

- **Source:** [1. uart_top_tb.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_top_tb.v)
- **Signals:** clk, wr_en, data_in, busy, ready
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pulse wr_en several times while busy=1 and compare how many frames complete.
- **Expected result:** There is no TX FIFO in this version; only a request accepted in transmitter IDLE is sent. Busy-time one-cycle requests are ignored.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-026

**Pause every frame position independently** · UART transmitter · P1 · Pending · Simulation plan

- **Source:** [1. transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, rst, wr_en, tx_en, data_in, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Transmit A5. On separate runs suppress tx_en for 1,3 and 17 clk edges while in START, at each data bit, and in STOP. Resume regular ticks.
- **Expected result:** The serial bit and transmitter progress hold while tx_en=0 in tick-controlled states. The decoded byte remains A5; bit widths stretch by the intentional pause. Reset remains able to abort the frame.
- **Coverage target:** Ten serial positions crossed with three pause lengths; enable hold/resume.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-027

**Reset at every serial position** · UART transmitter · P1 · Pending · Simulation plan

- **Source:** [1. transmitter.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/transmitter.v)
- **Signals:** clk, rst, wr_en, tx_en, data_in, tx, busy
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Assert rst during START, each of eight data positions, and STOP, both with tx_en=0 and tx_en=1. Keep wr_en low during reset. Release and request a new 3C frame.
- **Expected result:** After the module reset event, tx is idle high and busy clears. The aborted frame is discarded by the testbench decoder. The new frame starts from its start bit and contains exactly 3C.
- **Coverage target:** All ten frame positions crossed with tick absent/present; clean recovery.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-030

**False-start duration sweep** · UART receiver · P1 · Pending · Simulation plan

- **Source:** [1. uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** From idle high, drive low pulses lasting 1..7 receiver sample ticks, then pulses that reach the START validation point. Follow each rejected pulse with a clean A5 frame. Sweep the pulse phase relative to clk.
- **Expected result:** If the sampled input is high at the mid-start validation point, the candidate is rejected and no new byte is reported. A pulse spanning that point enters DATA and needs separate framing evaluation. Thresholds refer to sampled rx, including legacy synchronization delay.
- **Coverage target:** Seven short pulse lengths; pulse straddling validation; valid recovery frame.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-031

**Single-sample glitch at and away from a data sample** · UART receiver · P1 · Pending · Characterization

- **Source:** [1. uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Send 55. In separate runs invert rx for one sample tick immediately before, exactly at, and after the selected data-bit sampling point. Repeat at bit 0 and bit 7.
- **Expected result:** This receiver uses one selected sample, not majority voting. A glitch overlapping that selected sample can change the decoded bit; glitches away from it should not. Record these as robustness characterization unless a stronger noise-rejection requirement is agreed.
- **Coverage target:** Two endpoint bits x three glitch positions; corrupted versus unchanged decoded data.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-032

**Stop-low recovery followed by valid traffic** · UART receiver · P1 · Pending · Simulation plan

- **Source:** [1. uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rst, rx, rx_en, rdy_clr, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Send a byte with low stop, keep the line low for one more frame duration, restore idle high, clear any ready, then send a valid 3C frame.
- **Expected result:** Current UART- rejects the low stop; UART-legacy accepts the byte without validating stop. In both, characterize sustained-low behavior without treating a break as ordinary valid traffic, then verify recovery to a correctly decoded 3C.
- **Coverage target:** Bad stop; sustained low; return to idle; first valid recovery byte.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-003

**Divisor corners and restart** · Baud generator · P2 · Pending · Simulation plan

- **Source:** [1. baud_rate_generator.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/baud_rate_generator.v)
- **Signals:** clk, rst, tx_en, rx_en
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Repeat with small legal terminal values/divisors, reset midway through counting, and measure the restarted interval.
- **Expected result:** Counter widths limit the supported range. Current UART: TX_DIV 1..8192 and RX_DIV 1..1024; DIV=1 makes enable continuously high. Legacy: maximum terminal counts 8191 and 1023; zero makes enable continuously high. Do not silently truncate unsupported overrides.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### UL-019

**Phase and rate sweep** · UART receiver · P2 · Pending · Simulation plan

- **Source:** [1. uart_receiver.v](https://github.com/kapiltrip/UART-legacy/blob/28d439c91eca72edba0ce269ba01812ad02c2900/uart_receiver.v)
- **Signals:** clk, rx, rx_en, rdy, data_out
- **Setup:** Build the listed RTL in isolation, with source revision 28d439c91eca. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Shift frame start through all 16 sample phases; sweep small positive/negative bit-period offsets and include 00,FF,55,AA.
- **Expected result:** All values in the agreed nominal tolerance pass. Record the measured tolerance boundary rather than inventing a guaranteed percentage.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

