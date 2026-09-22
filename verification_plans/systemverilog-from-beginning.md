# systemverilog-from-beginning: detailed Verilog verification cases

[Plan index](../VERIFICATION_PLAN.md) · [Excel tracker](../VERIFICATION_CASES.xlsx) · [HDL source map](../VERIFICATION_SOURCE_MAP.md)

**84 cases, 165 HDL files.** Reviewed revision [318bd495dee2](https://github.com/kapiltrip/systemverilog-from-beginning/commit/318bd495dee245f946d7c72127cb698bcf6e6680). This is a verification *plan*: no new simulation result is claimed.

## Design contract to check

Some sources are teaching stubs or deliberately faulty designs. Covergroups, assertions and class benches require suitable SystemVerilog tools; a covered bin is not a functional check. Follow the exact stimulus and expected timing in each case.

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
| [SV-001](#sv-001) | P0 | Coverage FIFO | Reset and first usable cycle | Pending |
| [SV-002](#sv-002) | P0 | Coverage FIFO | Single write then single read | Pending |
| [SV-003](#sv-003) | P0 | Coverage FIFO | Ordering and mixed data | Pending |
| [SV-004](#sv-004) | P0 | Coverage FIFO | Fill to capacity and reject overflow | Pending |
| [SV-005](#sv-005) | P0 | Coverage FIFO | Drain to empty and reject underflow | Pending |
| [SV-006](#sv-006) | P0 | Coverage FIFO | Both enables in the middle | Pending |
| [SV-007](#sv-007) | P0 | Coverage FIFO | Both enables when empty | Pending |
| [SV-008](#sv-008) | P0 | Coverage FIFO | Both enables when full | Pending |
| [SV-013](#sv-013) | P0 | Counter | Reset/load/direction priority and unused input | Pending |
| [SV-014](#sv-014) | P0 | Priority encoder | One-hot and multiple-request priority | Pending |
| [SV-015](#sv-015) | P0 | SPI DAC | Startup and frame capture | Blocked |
| [SV-048](#sv-048) | P0 | Build and evidence | Compile isolated tops and record reproducible evidence | Pending |
| [SV-049](#sv-049) | P0 | Coverage FIFO | Every occupancy boundary and accepted request combination | Pending |
| [SV-051](#sv-051) | P0 | Coverage FIFO | Every occupancy boundary and accepted request combination | Pending |
| [SV-053](#sv-053) | P0 | Coverage ALU | Exhaust all eight operations and operand pairs | Pending |
| [SV-054](#sv-054) | P0 | Coverage ALU | Expose duplicate opcode branches in the teaching draft | Pending |
| [SV-055](#sv-055) | P0 | Clocked adder | All operand pairs with transaction alignment | Pending |
| [SV-056](#sv-056) | P0 | Clocked adder | All operand pairs with transaction alignment | Pending |
| [SV-057](#sv-057) | P0 | Clocked adder | All operand pairs with transaction alignment | Pending |
| [SV-058](#sv-058) | P0 | Clocked adder | All operand pairs with transaction alignment | Pending |
| [SV-059](#sv-059) | P0 | Clocked adder | All operand pairs with transaction alignment | Pending |
| [SV-060](#sv-060) | P0 | Verification infrastructure | Confirm that scoreboard messages are actually checked | Pending |
| [SV-061](#sv-061) | P0 | SPI state controller | Exact state dwell and busy sequence | Pending |
| [SV-009](#sv-009) | P1 | Coverage FIFO | Idle and output validity | Pending |
| [SV-010](#sv-010) | P1 | Coverage FIFO | Repeated wraparound | Pending |
| [SV-011](#sv-011) | P1 | Coverage FIFO | Reset with queued traffic | Pending |
| [SV-016](#sv-016) | P1 | Multiplexer | Every select and unselected-input isolation | Pending |
| [SV-017](#sv-017) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [SV-018](#sv-018) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [SV-019](#sv-019) | P1 | Counter | Reset, rollover and control priority | Pending |
| [SV-020](#sv-020) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [SV-021](#sv-021) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [SV-022](#sv-022) | P1 | Arithmetic | Arithmetic, carry/borrow and width | Pending |
| [SV-023](#sv-023) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [SV-024](#sv-024) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [SV-025](#sv-025) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [SV-026](#sv-026) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [SV-027](#sv-027) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [SV-028](#sv-028) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [SV-029](#sv-029) | P1 | Priority encoder | Every request, priorities and zero input | Pending |
| [SV-030](#sv-030) | P1 | Priority encoder | Every request, priorities and zero input | Pending |
| [SV-031](#sv-031) | P1 | Counter | Reset, rollover and control priority | Pending |
| [SV-032](#sv-032) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [SV-033](#sv-033) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [SV-034](#sv-034) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [SV-035](#sv-035) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [SV-036](#sv-036) | P1 | Multiplexer | Every select and unselected-input isolation | Pending |
| [SV-037](#sv-037) | P1 | Multiplexer | Every select and unselected-input isolation | Pending |
| [SV-038](#sv-038) | P1 | Multiplexer | Every select and unselected-input isolation | Pending |
| [SV-039](#sv-039) | P1 | Multiplexer | Every select and unselected-input isolation | Pending |
| [SV-040](#sv-040) | P1 | Priority encoder | Every request, priorities and zero input | Pending |
| [SV-041](#sv-041) | P1 | Implementation prerequisite | Implement the FIFO behind the constant-output lesson | Blocked |
| [SV-042](#sv-042) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [SV-043](#sv-043) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [SV-044](#sv-044) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [SV-045](#sv-045) | P1 | Counter | Reset, rollover and control priority | Pending |
| [SV-046](#sv-046) | P1 | Counter | Reset, rollover and control priority | Pending |
| [SV-047](#sv-047) | P1 | Counter | Reset, rollover and control priority | Pending |
| [SV-050](#sv-050) | P1 | Coverage FIFO | Natural pointer wrap versus non-power-of-two depth | Pending |
| [SV-052](#sv-052) | P1 | Coverage FIFO | Natural pointer wrap versus non-power-of-two depth | Pending |
| [SV-062](#sv-062) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [SV-063](#sv-063) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [SV-064](#sv-064) | P1 | Counter | Terminal-count enable/load collisions | Pending |
| [SV-065](#sv-065) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [SV-066](#sv-066) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [SV-067](#sv-067) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [SV-068](#sv-068) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [SV-069](#sv-069) | P1 | Priority encoder | Every pair of simultaneous requests and no request | Pending |
| [SV-070](#sv-070) | P1 | Priority encoder | Every pair of simultaneous requests and no request | Pending |
| [SV-071](#sv-071) | P1 | Counter | Terminal-count enable/load collisions | Pending |
| [SV-072](#sv-072) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [SV-073](#sv-073) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [SV-074](#sv-074) | P1 | Counter | Terminal-count enable/load collisions | Pending |
| [SV-075](#sv-075) | P1 | Multiplexer | Selected data transition and inactive-input isolation | Pending |
| [SV-076](#sv-076) | P1 | Priority encoder | Every pair of simultaneous requests and no request | Pending |
| [SV-077](#sv-077) | P1 | Multiplexer | Selected data transition and inactive-input isolation | Pending |
| [SV-078](#sv-078) | P1 | Multiplexer | Selected data transition and inactive-input isolation | Pending |
| [SV-079](#sv-079) | P1 | Multiplexer | Selected data transition and inactive-input isolation | Pending |
| [SV-080](#sv-080) | P1 | Priority encoder | Every pair of simultaneous requests and no request | Pending |
| [SV-081](#sv-081) | P1 | Counter | Terminal-count enable/load collisions | Pending |
| [SV-082](#sv-082) | P1 | Counter | Terminal-count enable/load collisions | Pending |
| [SV-083](#sv-083) | P1 | Counter | Terminal-count enable/load collisions | Pending |
| [SV-084](#sv-084) | P1 | SPI DAC | Setup word and data word framing after startup is defined | Blocked |
| [SV-012](#sv-012) | P2 | Coverage FIFO | Random bursts with a reference queue | Pending |

## Detailed test ideas

### SV-001

**Reset and first usable cycle** · Coverage FIFO · P0 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Hold wr_en=rd_en=0. Assert rst=1, clock the design, then release reset away from the active edge.
- **Expected result:** After the specified reset event: empty=1 and full=0; pointers/count are reset. dout holds the last accepted read while no read is accepted, and resets to zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-002

**Single write then single read** · Coverage FIFO · P0 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write A5 with wr_en=1 while full=0; disable write; request one read with rd_en=1 while empty=0.
- **Expected result:** empty clears after the write and asserts after the read. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer. Exactly one word is transferred.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-003

**Ordering and mixed data** · Coverage FIFO · P0 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write 10,22,35,48 with gaps, then drain using isolated and consecutive rd_en requests.
- **Expected result:** Read values are 10,22,35,48 in that order. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-004

**Fill to capacity and reject overflow** · Coverage FIFO · P0 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** With rd_en=0, issue exactly DEPTH writes (2^aw (default 256)); check one below full and full. Attempt three further writes with distinct data, then drain.
- **Expected result:** full asserts only after the last available slot is used. Extra writes cannot move the write pointer or replace queued data. Draining returns the original DEPTH values.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-005

**Drain to empty and reject underflow** · Coverage FIFO · P0 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill and drain exactly DEPTH accepted reads. Keep rd_en=1 for three additional clocks with wr_en=0.
- **Expected result:** empty asserts on the last accepted pop; extra reads do not advance the read pointer or change occupancy. dout holds the last accepted read while no read is accepted, and resets to zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-006

**Both enables in the middle** · Coverage FIFO · P0 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill to half capacity. Keep wr_en=rd_en=1 for at least 2*DEPTH clocks with a changing din.
- **Expected result:** Both operations are accepted on each edge and occupancy stays constant. The stream remains ordered across pointer wraps. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-007

**Both enables when empty** · Coverage FIFO · P0 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset empty, then assert wr_en=rd_en=1 for one edge with din=3C.
- **Expected result:** Only the write is accepted because the pre-edge empty=1. Occupancy becomes one. No same-edge bypass/pop of 3C is allowed.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-008

**Both enables when full** · Coverage FIFO · P0 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill to capacity; assert wr_en=rd_en=1 for one edge with a new din.
- **Expected result:** Only the read is accepted because pre-edge full=1; the write is blocked and occupancy becomes DEPTH-1. Resend the new word later if it must be stored.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-013

**Reset/load/direction priority and unused input** · Counter · P0 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/02-counter-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/02-counter-functional-coverage/design.sv)
- **Signals:** clk, rst, up, load, loadIn, x, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Set rst and load together; then load with either up value; traverse 255->0 and 0->255. Toggle x independently.
- **Expected result:** Priority is rst then load then up/down. y wraps modulo 256. x is unused in this RTL and must not influence y.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-014

**One-hot and multiple-request priority** · Priority encoder · P0 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/04-priority-encoder-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/04-priority-encoder-functional-coverage/design.sv)
- **Signals:** x, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive x=01,02,04,08,10,20,40,80, then simultaneous requests and x=0.
- **Expected result:** Intended y is the highest asserted x bit. The current RTL cases on y instead of x, so this directed test should expose the error. Define the zero-input convention separately (current default is Z).
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Static source defect; no simulation run claimed.

### SV-015

**Startup and frame capture** · SPI DAC · P0 · Blocked · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/05-spi-transition-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/05-spi-transition-coverage/design.sv)
- **Signals:** clk, start, din, cs, mosi
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Start a fresh simulation, hold start low, then request din=ABC and observe the two 32-bit transfers under cs.
- **Expected result:** Expected setup stream is 08000001, then payload 030ABC00, both MSB first. However state has no reset/initialization and can remain unknown; establish startup before claiming frame success.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** No reset port and uninitialized enum state. Existing bench forcing/initialization must be explicit.

### SV-048

**Compile isolated tops and record reproducible evidence** · Build and evidence · P0 · Pending · Source review

- **Source:** [1. SV Assertions/Codes/02-immediate-assertions-in-a-mux/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Assertions/Codes/02-immediate-assertions-in-a-mux/design.sv)
- **Signals:** Top/module names and port declarations in the RTL map
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-049

**Every occupancy boundary and accepted request combination** · Coverage FIFO · P0 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/137-fifo-p2/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/137-fifo-p2/design.sv)
- **Signals:** clk, reset, write_enable, read_enable, data_in, data_out, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** At WIDTH=8, DEPTH=8, separately establish occupancies 0,1,4,7,8 and issue all four write_enable/read_enable combinations for one clock. Use pre-edge flags and a reference queue.
- **Expected result:** W=write_enable&&!full and R=read_enable&&!empty. New count=old+W-R. Registered data_out changes only for an accepted read, except reset clears it. Full/both rejects write; empty/both rejects read.
- **Coverage target:** Five occupancies x four request combinations; full and empty transitions.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-051

**Every occupancy boundary and accepted request combination** · Coverage FIFO · P0 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/138-fifo-p3/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/138-fifo-p3/design.sv)
- **Signals:** clk, reset, write_enable, read_enable, data_in, data_out, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** At WIDTH=8, DEPTH=8, separately establish occupancies 0,1,4,7,8 and issue all four write_enable/read_enable combinations for one clock. Use pre-edge flags and a reference queue.
- **Expected result:** W=write_enable&&!full and R=read_enable&&!empty. New count=old+W-R. Registered data_out changes only for an accepted read, except reset clears it. Full/both rejects write; empty/both rejects read.
- **Coverage target:** Five occupancies x four request combinations; full and empty transitions.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-053

**Exhaust all eight operations and operand pairs** · Coverage ALU · P0 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/20-reusable-covergroup-alu-use-case/verified-design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/20-reusable-covergroup-alu-use-case/verified-design.sv)
- **Signals:** a, b, opcode, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive all 8 opcodes x 16 values of a x 16 values of b. Compare after combinational settling against a separate integer/bitwise model.
- **Expected result:** Opcode 0 adds; 1 subtracts modulo 32; 2 computes a+1; 3 b+1; 4 AND; 5 OR; 6 XOR; 7 gives the four-bit complement of a zero-extended to five bits. Thus 0-1 gives 31 and NOT 0 gives 15.
- **Coverage target:** All 2048 binary input combinations; five-bit carry/borrow; width of complement.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-054

**Expose duplicate opcode branches in the teaching draft** · Coverage ALU · P0 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/20-reusable-covergroup-alu-use-case/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/20-reusable-covergroup-alu-use-case/design.sv)
- **Signals:** a, b, opcode, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use a=3,b=5 and sweep opcode 0..7, then cross operand extremes. Compare against the distinct eight-operation lesson contract and inspect compile/lint diagnostics.
- **Expected result:** All eight source case labels are 000. At that label the first matching addition branch takes effect; other binary opcodes use the default zero. This cannot satisfy the eight-operation contract even if opcode coverage reaches every bin.
- **Coverage target:** All opcode encodings; duplicated labels; functional checking independent of coverage.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-055

**All operand pairs with transaction alignment** · Clocked adder · P0 · Pending · Simulation plan

- **Source:** [1. SV Basics/Codes/40-interface-modport-and-virtual-interface/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/40-interface-modport-and-virtual-interface/design.sv)
- **Signals:** clk, a, b, sum
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive all 256 pairs of four-bit a,b on falling clk edges. Save operands for each subsequent rising edge, then compare sum after NBA. Send a different pair on every edge, including 0+0,15+0,0+15,15+15.
- **Expected result:** sum equals the five-bit sum of the captured operands, including 15+15=30. The monitor must associate each result with the correct input pair and send immutable transaction snapshots to its scoreboard.
- **Coverage target:** All 256 pairs; back-to-back input change; carry into bit 4; monitor/scoreboard sample alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-056

**All operand pairs with transaction alignment** · Clocked adder · P0 · Pending · Simulation plan

- **Source:** [1. SV Basics/Codes/41-layered-adder-testbench-and-object-copies/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/41-layered-adder-testbench-and-object-copies/design.sv)
- **Signals:** clk, a, b, sum
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive all 256 pairs of four-bit a,b on falling clk edges. Save operands for each subsequent rising edge, then compare sum after NBA. Send a different pair on every edge, including 0+0,15+0,0+15,15+15.
- **Expected result:** sum equals the five-bit sum of the captured operands, including 15+15=30. The monitor must associate each result with the correct input pair and send immutable transaction snapshots to its scoreboard.
- **Coverage target:** All 256 pairs; back-to-back input change; carry into bit 4; monitor/scoreboard sample alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-057

**All operand pairs with transaction alignment** · Clocked adder · P0 · Pending · Simulation plan

- **Source:** [1. SV Basics/Codes/42-error-injection-with-inheritance/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/42-error-injection-with-inheritance/design.sv)
- **Signals:** clk, a, b, sum
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive all 256 pairs of four-bit a,b on falling clk edges. Save operands for each subsequent rising edge, then compare sum after NBA. Send a different pair on every edge, including 0+0,15+0,0+15,15+15.
- **Expected result:** sum equals the five-bit sum of the captured operands, including 15+15=30. The monitor must associate each result with the correct input pair and send immutable transaction snapshots to its scoreboard.
- **Coverage target:** All 256 pairs; back-to-back input change; carry into bit 4; monitor/scoreboard sample alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-058

**All operand pairs with transaction alignment** · Clocked adder · P0 · Pending · Simulation plan

- **Source:** [1. SV Basics/Codes/43-polymorphic-copy-error-injection/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/43-polymorphic-copy-error-injection/design.sv)
- **Signals:** clk, a, b, sum
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive all 256 pairs of four-bit a,b on falling clk edges. Save operands for each subsequent rising edge, then compare sum after NBA. Send a different pair on every edge, including 0+0,15+0,0+15,15+15.
- **Expected result:** sum equals the five-bit sum of the captured operands, including 15+15=30. The monitor must associate each result with the correct input pair and send immutable transaction snapshots to its scoreboard.
- **Coverage target:** All 256 pairs; back-to-back input change; carry into bit 4; monitor/scoreboard sample alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-059

**All operand pairs with transaction alignment** · Clocked adder · P0 · Pending · Simulation plan

- **Source:** [1. SV Basics/Codes/44-monitor-scoreboard-separate-mailboxes/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/44-monitor-scoreboard-separate-mailboxes/design.sv)
- **Signals:** clk, a, b, sum
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive all 256 pairs of four-bit a,b on falling clk edges. Save operands for each subsequent rising edge, then compare sum after NBA. Send a different pair on every edge, including 0+0,15+0,0+15,15+15.
- **Expected result:** sum equals the five-bit sum of the captured operands, including 15+15=30. The monitor must associate each result with the correct input pair and send immutable transaction snapshots to its scoreboard.
- **Coverage target:** All 256 pairs; back-to-back input change; carry into bit 4; monitor/scoreboard sample alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-060

**Confirm that scoreboard messages are actually checked** · Verification infrastructure · P0 · Pending · Source review

- **Source:** [1. SV Functional Coverage/Projects/02-counter-functional-coverage/testbench.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/02-counter-functional-coverage/testbench.sv)
- **Signals:** clk, rst, up, load, loadIn, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Audit the scoreboard run task, then plan one deliberately wrong expected result in a disposable testbench run. Exercise load followed by up/down counts and count mismatches independently of covergroup hits.
- **Expected result:** The existing scoreboard only consumes mailbox entries and performs no comparison. A meaningful checker must compare the observed y against reset/load/count behavior and fail on the deliberately wrong result. Until such a check exists, an error-free run is not a functional pass.
- **Coverage target:** A real comparison exists; one known mismatch is detected; correct data passes after removing the injected mismatch.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-061

**Exact state dwell and busy sequence** · SPI state controller · P0 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/140-spi-transition-bins/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/140-spi-transition-bins/design.sv)
- **Signals:** clk, reset, start, state, busy
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** After reset, pulse start for one clock. Observe state after every NBA until idle returns; then hold start high through completion in a separate run.
- **Expected result:** The accepted start enters LOAD, then TRANSFER. TRANSFER is observed for eight consecutive cycles, then DONE for one, then IDLE. busy is 1 in every non-IDLE state. A held start can launch another transaction on a later IDLE edge.
- **Coverage target:** IDLE->LOAD->TRANSFER eight cycles->DONE->IDLE; held-start restart.
- **Stop rule:** At most 12 rising edges from accepted start to return to IDLE.

### SV-009

**Idle and output validity** · Coverage FIFO · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pause both enables at empty, one word, half-full and full. Toggle din while idle.
- **Expected result:** Pointers/count and flags hold. dout holds the last accepted read while no read is accepted, and resets to zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-010

**Repeated wraparound** · Coverage FIFO · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Alternate fill/drain and mixed bursts until each pointer wraps at least four times. Use a sequence number for every accepted write.
- **Expected result:** No duplication, loss or reordering. Counts stay between zero and DEPTH; full and empty cannot both be true.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-011

**Reset with queued traffic** · Coverage FIFO · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill, assert rst during traffic, then hold enables low through reset. Discard the software reference queue; release reset and write fresh values.
- **Expected result:** Old queued values are discarded logically. The first fresh drain returns only post-reset accepted writes. dout holds the last accepted read while no read is accepted, and resets to zero.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-016

**Every select and unselected-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. SV Assertions/Codes/02-immediate-assertions-in-a-mux/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Assertions/Codes/02-immediate-assertions-in-a-mux/design.sv)
- **Signals:** a, b, c, d, sel, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-017

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Assertions/Codes/03-clocked-immediate-assertion-and-nba-timing/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Assertions/Codes/03-clocked-immediate-assertion-and-nba-timing/design.sv)
- **Signals:** d, rstn, clk, q, qbar
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For dff, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q, qbar only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: q = temp_q; qbar = temp_qbar.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-018

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Assertions/Projects/01-fsm-verification-with-sva/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Assertions/Projects/01-fsm-verification-with-sva/design.sv)
- **Signals:** clk, rst, x, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For fsm, initialize through its reset/load path, then vary x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check y only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-019

**Reset, rollover and control priority** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. SV Assertions/Projects/02-counter-assertions-with-bind/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Assertions/Projects/02-counter-assertions-with-bind/design.sv)
- **Signals:** clk, rst, up, dout
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize counter; test every enable/load/direction combination in clk, rst, up. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** dout follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-020

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Basics/Codes/30-fifo-transaction-and-weighted-constraints/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/30-fifo-transaction-and-weighted-constraints/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For sync_fifo, initialize through its reset/load path, then vary wr_en, rd_en, wr_data before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check rd_data, full, empty only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: full = (fifo_count == DEPTH); empty = (fifo_count == 0).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-021

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Basics/Codes/40-interface-modport-and-virtual-interface/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/40-interface-modport-and-virtual-interface/design.sv)
- **Signals:** a, b, clk, sum
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For add, initialize through its reset/load path, then vary a, b before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check sum only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-022

**Arithmetic, carry/borrow and width** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. SV Basics/Codes/41-layered-adder-testbench-and-object-copies/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/41-layered-adder-testbench-and-object-copies/design.sv)
- **Signals:** a, b, clk, sum
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise a, b, clk at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different. Respect the clocked latency and load/enable priorities.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-023

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Basics/Codes/42-error-injection-with-inheritance/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/42-error-injection-with-inheritance/design.sv)
- **Signals:** a, b, clk, sum
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For add, initialize through its reset/load path, then vary a, b before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check sum only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-024

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Basics/Codes/43-polymorphic-copy-error-injection/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/43-polymorphic-copy-error-injection/design.sv)
- **Signals:** a, b, clk, sum
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For add, initialize through its reset/load path, then vary a, b before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check sum only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-025

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Basics/Codes/44-monitor-scoreboard-separate-mailboxes/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/44-monitor-scoreboard-separate-mailboxes/design.sv)
- **Signals:** a, b, clk, sum
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For add, initialize through its reset/load path, then vary a, b before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check sum only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-026

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/01-basic-coverpoints/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/01-basic-coverpoints/design.sv)
- **Signals:** a, b
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check b against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: b = a.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-027

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/07-multiplexer-signal-coverpoints/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/07-multiplexer-signal-coverpoints/design.sv)
- **Signals:** a, b, c, d, sel, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, c, d, sel through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-028

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/09-fsm-state-coverage-and-report-timing/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/09-fsm-state-coverage-and-report-timing/design.sv)
- **Signals:** x, clk, rst, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For fsm, initialize through its reset/load path, then vary x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check y only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-029

**Every request, priorities and zero input** · Priority encoder · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/14-wildcard-bins-casez-and-casex/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/14-wildcard-bins-casez-and-casex/design.sv)
- **Signals:** x, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Apply each one-hot bit to x, then adjacent pairs, all ones and all zeros; sweep small input spaces.
- **Expected result:** y identifies the source-defined highest/lowest-priority active input; verify the direction explicitly. Check any valid output, and treat a specified X/Z zero-input result separately from valid binary encoding.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-030

**Every request, priorities and zero input** · Priority encoder · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/14-wildcard-bins-casez-and-casex/verified-design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/14-wildcard-bins-casez-and-casex/verified-design.sv)
- **Signals:** x, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Apply each one-hot bit to x, then adjacent pairs, all ones and all zeros; sweep small input spaces.
- **Expected result:** y identifies the source-defined highest/lowest-priority active input; verify the direction explicitly. Check any valid output, and treat a specified X/Z zero-input result separately from valid binary encoding.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-031

**Reset, rollover and control priority** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/15-counter-wildcard-bins-and-finite-reporting/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/15-counter-wildcard-bins-and-finite-reporting/design.sv)
- **Signals:** clk, en, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize counter; test every enable/load/direction combination in clk, en. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** y follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-032

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/20-reusable-covergroup-alu-use-case/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/20-reusable-covergroup-alu-use-case/design.sv)
- **Signals:** a, b, opcode, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, opcode through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-033

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/20-reusable-covergroup-alu-use-case/verified-design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/20-reusable-covergroup-alu-use-case/verified-design.sv)
- **Signals:** a, b, opcode, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, opcode through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-034

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/30-simple-transition-coverage-p1/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/30-simple-transition-coverage-p1/design.sv)
- **Signals:** clk, reset, d, d_out
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For two_state_fsm, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge reset.
- **Expected result:** Check d_out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-035

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/31-simple-transition-coverage-p2/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/31-simple-transition-coverage-p2/design.sv)
- **Signals:** clk, reset, d, d_out
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For two_state_fsm, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge reset.
- **Expected result:** Check d_out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-036

**Every select and unselected-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/03-mux-8-to-1-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/03-mux-8-to-1-functional-coverage/design.sv)
- **Signals:** a, b, c, d, e, f, g, h, sel, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-037

**Every select and unselected-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/130-mux-8-to-1-p1/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/130-mux-8-to-1-p1/design.sv)
- **Signals:** data, select, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep select through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-038

**Every select and unselected-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/131-mux-8-to-1-p2/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/131-mux-8-to-1-p2/design.sv)
- **Signals:** data, select, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep select through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-039

**Every select and unselected-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/132-mux-8-to-1-p3/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/132-mux-8-to-1-p3/design.sv)
- **Signals:** data, select, y
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep select through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-040

**Every request, priorities and zero input** · Priority encoder · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/134-priority-encoder/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/134-priority-encoder/design.sv)
- **Signals:** request, code, valid
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Apply each one-hot bit to request, then adjacent pairs, all ones and all zeros; sweep small input spaces.
- **Expected result:** code, valid identifies the source-defined highest/lowest-priority active input; verify the direction explicitly. Check any valid output, and treat a specified X/Z zero-input result separately from valid binary encoding.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-041

**Implement the FIFO behind the constant-output lesson** · Implementation prerequisite · P1 · Blocked · Prerequisite

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/136-fifo-p1/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/136-fifo-p1/design.sv)
- **Signals:** clk, reset, write_enable, read_enable, data_in, data_out, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Record the intended FIFO capacity, reset and acceptance policy before writing functional tests. Current data_out is tied to 0, full to 0 and empty to 1 regardless of requests.
- **Expected result:** A real storage implementation is required before ordering, occupancy or overflow tests can pass. Covergroup activity around constant outputs is not a functional FIFO pass.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Coverage-only placeholder, not a working FIFO.

### SV-042

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/137-fifo-p2/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/137-fifo-p2/design.sv)
- **Signals:** clk, reset, write_enable, read_enable, data_in, data_out, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For sync_fifo, initialize through its reset/load path, then vary write_enable, read_enable, data_in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check data_out, full, empty only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: full = (count == DEPTH); empty = (count == 0).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-043

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/138-fifo-p3/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/138-fifo-p3/design.sv)
- **Signals:** clk, reset, write_enable, read_enable, data_in, data_out, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For sync_fifo, initialize through its reset/load path, then vary write_enable, read_enable, data_in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check data_out, full, empty only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: full = (count == DEPTH); empty = (count == 0).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-044

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/140-spi-transition-bins/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/140-spi-transition-bins/design.sv)
- **Signals:** clk, reset, start, state, busy
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For spi_controller, initialize through its reset/load path, then vary start before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check state, busy only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: busy = (state != IDLE).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-045

**Reset, rollover and control priority** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/142-counter-p1/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/142-counter-p1/design.sv)
- **Signals:** clk, reset, enable, load, load_value, count
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize counter; test every enable/load/direction combination in clk, reset, enable, load, load_value. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** count follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-046

**Reset, rollover and control priority** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/143-counter-p2/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/143-counter-p2/design.sv)
- **Signals:** clk, reset, enable, load, load_value, count
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize counter; test every enable/load/direction combination in clk, reset, enable, load, load_value. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** count follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-047

**Reset, rollover and control priority** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/144-counter-p3/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/144-counter-p3/design.sv)
- **Signals:** clk, reset, enable, load, load_value, count
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize counter; test every enable/load/direction combination in clk, reset, enable, load, load_value. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** count follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-050

**Natural pointer wrap versus non-power-of-two depth** · Coverage FIFO · P1 · Pending · Simulation and source review

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/137-fifo-p2/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/137-fifo-p2/design.sv)
- **Signals:** clk, reset, write_enable, read_enable, data_in, data_out, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Repeat ordering through four complete laps at DEPTH=2,4,8,16. Separately inspect/elaborate DEPTH=3 and DEPTH=1 as unsupported-parameter investigations.
- **Expected result:** Power-of-two configurations wrap naturally and preserve order. DEPTH=3 needs explicit wrap instead of a two-bit natural rollover; DEPTH=1 produces zero-width PTR_W declarations. Record these as limits or defects, not supported configurations by assumption.
- **Coverage target:** Four legal depths; width corner; unsupported parameter behavior.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### SV-052

**Natural pointer wrap versus non-power-of-two depth** · Coverage FIFO · P1 · Pending · Simulation and source review

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/138-fifo-p3/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/138-fifo-p3/design.sv)
- **Signals:** clk, reset, write_enable, read_enable, data_in, data_out, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Repeat ordering through four complete laps at DEPTH=2,4,8,16. Separately inspect/elaborate DEPTH=3 and DEPTH=1 as unsupported-parameter investigations.
- **Expected result:** Power-of-two configurations wrap naturally and preserve order. DEPTH=3 needs explicit wrap instead of a two-bit natural rollover; DEPTH=1 produces zero-width PTR_W declarations. Record these as limits or defects, not supported configurations by assumption.
- **Coverage target:** Four legal depths; width corner; unsupported parameter behavior.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### SV-062

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Assertions/Codes/03-clocked-immediate-assertion-and-nba-timing/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Assertions/Codes/03-clocked-immediate-assertion-and-nba-timing/design.sv)
- **Signals:** d, rstn, clk, q, qbar
- **Setup:** Compile dff from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For dff, use legal inputs d, rstn, clk to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q, qbar to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-063

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Assertions/Projects/01-fsm-verification-with-sva/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Assertions/Projects/01-fsm-verification-with-sva/design.sv)
- **Signals:** clk, rst, x, y
- **Setup:** Compile fsm from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For fsm, use legal inputs clk, rst, x to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare y to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-064

**Terminal-count enable/load collisions** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. SV Assertions/Projects/02-counter-assertions-with-bind/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Assertions/Projects/02-counter-assertions-with-bind/design.sv)
- **Signals:** clk, rst, up, dout
- **Setup:** Compile counter from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Use the normal reset/load/count path to reach the last and first legal values of dout. Exercise every present enable, direction and load combination from clk, rst, up at those boundaries. Include consecutive reloads and reset during rollover.
- **Expected result:** The independently maintained count follows the exact modulus and source control priority. Holds consume no count step when enable exists. Carry/terminal outputs align with the documented pre-/post-edge count. Cover the actual digit modulus, not an assumed binary maximum.
- **Coverage target:** Low/high rollover crossed with each exposed control; reset/load priority; terminal pulse alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-065

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Basics/Codes/30-fifo-transaction-and-weighted-constraints/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Basics/Codes/30-fifo-transaction-and-weighted-constraints/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, wr_data, rd_data, full, empty
- **Setup:** Compile sync_fifo from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For sync_fifo, use legal inputs clk, rst, wr_en, rd_en, wr_data to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare rd_data, full, empty to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-066

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/01-basic-coverpoints/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/01-basic-coverpoints/design.sv)
- **Signals:** a, b
- **Setup:** Compile top from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For b, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-067

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/07-multiplexer-signal-coverpoints/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/07-multiplexer-signal-coverpoints/design.sv)
- **Signals:** a, b, c, d, sel, y
- **Setup:** Compile top from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, c, d, sel, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For y, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-068

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/09-fsm-state-coverage-and-report-timing/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/09-fsm-state-coverage-and-report-timing/design.sv)
- **Signals:** x, clk, rst, y
- **Setup:** Compile fsm from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For fsm, use legal inputs x, clk, rst to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare y to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-069

**Every pair of simultaneous requests and no request** · Priority encoder · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/14-wildcard-bins-casez-and-casex/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/14-wildcard-bins-casez-and-casex/design.sv)
- **Signals:** x, y
- **Setup:** Compile priorityEncoder from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Apply all one-hot requests, every pair of set request bits, all requests and no requests through x. Start each trial after a different prior winning request.
- **Expected result:** y selects the source-defined highest-priority bit, independently of the previous winner. Check valid separately where present; where no valid exists, record the documented zero-input code or Z result rather than inventing validity.
- **Coverage target:** Each winning bit; every pairwise priority conflict; all-zero/default output; prior-winner independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-070

**Every pair of simultaneous requests and no request** · Priority encoder · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/14-wildcard-bins-casez-and-casex/verified-design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/14-wildcard-bins-casez-and-casex/verified-design.sv)
- **Signals:** x, y
- **Setup:** Compile priority_encoder from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Apply all one-hot requests, every pair of set request bits, all requests and no requests through x. Start each trial after a different prior winning request.
- **Expected result:** y selects the source-defined highest-priority bit, independently of the previous winner. Check valid separately where present; where no valid exists, record the documented zero-input code or Z result rather than inventing validity.
- **Coverage target:** Each winning bit; every pairwise priority conflict; all-zero/default output; prior-winner independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-071

**Terminal-count enable/load collisions** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/15-counter-wildcard-bins-and-finite-reporting/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/15-counter-wildcard-bins-and-finite-reporting/design.sv)
- **Signals:** clk, en, y
- **Setup:** Compile counter from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Use the normal reset/load/count path to reach the last and first legal values of y. Exercise every present enable, direction and load combination from clk, en at those boundaries. Include consecutive reloads and reset during rollover.
- **Expected result:** The independently maintained count follows the exact modulus and source control priority. Holds consume no count step when enable exists. Carry/terminal outputs align with the documented pre-/post-edge count. Cover the actual digit modulus, not an assumed binary maximum.
- **Coverage target:** Low/high rollover crossed with each exposed control; reset/load priority; terminal pulse alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-072

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/30-simple-transition-coverage-p1/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/30-simple-transition-coverage-p1/design.sv)
- **Signals:** clk, reset, d, d_out
- **Setup:** Compile two_state_fsm from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For two_state_fsm, use legal inputs clk, reset, d to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare d_out to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-073

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Codes/31-simple-transition-coverage-p2/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Codes/31-simple-transition-coverage-p2/design.sv)
- **Signals:** clk, reset, d, d_out
- **Setup:** Compile two_state_fsm from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For two_state_fsm, use legal inputs clk, reset, d to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare d_out to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-074

**Terminal-count enable/load collisions** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/02-counter-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/02-counter-functional-coverage/design.sv)
- **Signals:** clk, rst, up, load, loadIn, x, y
- **Setup:** Compile counter from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Use the normal reset/load/count path to reach the last and first legal values of y. Exercise every present enable, direction and load combination from clk, rst, up, load, loadIn, x at those boundaries. Include consecutive reloads and reset during rollover.
- **Expected result:** The independently maintained count follows the exact modulus and source control priority. Holds consume no count step when enable exists. Carry/terminal outputs align with the documented pre-/post-edge count. Cover the actual digit modulus, not an assumed binary maximum.
- **Coverage target:** Low/high rollover crossed with each exposed control; reset/load priority; terminal pulse alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-075

**Selected data transition and inactive-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/03-mux-8-to-1-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/03-mux-8-to-1-functional-coverage/design.sv)
- **Signals:** a, b, c, d, e, f, g, h, sel, y
- **Setup:** Compile mux from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For each legal select code in a, b, c, d, e, f, g, h, sel, hold all unselected data at one and toggle the selected bit/value 0->1->0; then hold the selected value constant and toggle every unselected input. Repeat in descending select order.
- **Expected result:** y follows only the selected input with combinational settling. Reversing traversal must not retain an earlier select's result. Check unused select encodings against the explicit default contract.
- **Coverage target:** Each select x both selected data values; each unselected input toggled; reverse traversal.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-076

**Every pair of simultaneous requests and no request** · Priority encoder · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/04-priority-encoder-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/04-priority-encoder-functional-coverage/design.sv)
- **Signals:** x, y
- **Setup:** Compile penc from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Apply all one-hot requests, every pair of set request bits, all requests and no requests through x. Start each trial after a different prior winning request.
- **Expected result:** y selects the source-defined highest-priority bit, independently of the previous winner. Check valid separately where present; where no valid exists, record the documented zero-input code or Z result rather than inventing validity.
- **Coverage target:** Each winning bit; every pairwise priority conflict; all-zero/default output; prior-winner independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-077

**Selected data transition and inactive-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/130-mux-8-to-1-p1/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/130-mux-8-to-1-p1/design.sv)
- **Signals:** data, select, y
- **Setup:** Compile mux8to1 from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For each legal select code in data, select, hold all unselected data at one and toggle the selected bit/value 0->1->0; then hold the selected value constant and toggle every unselected input. Repeat in descending select order.
- **Expected result:** y follows only the selected input with combinational settling. Reversing traversal must not retain an earlier select's result. Check unused select encodings against the explicit default contract.
- **Coverage target:** Each select x both selected data values; each unselected input toggled; reverse traversal.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-078

**Selected data transition and inactive-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/131-mux-8-to-1-p2/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/131-mux-8-to-1-p2/design.sv)
- **Signals:** data, select, y
- **Setup:** Compile mux8to1 from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For each legal select code in data, select, hold all unselected data at one and toggle the selected bit/value 0->1->0; then hold the selected value constant and toggle every unselected input. Repeat in descending select order.
- **Expected result:** y follows only the selected input with combinational settling. Reversing traversal must not retain an earlier select's result. Check unused select encodings against the explicit default contract.
- **Coverage target:** Each select x both selected data values; each unselected input toggled; reverse traversal.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-079

**Selected data transition and inactive-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/132-mux-8-to-1-p3/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/132-mux-8-to-1-p3/design.sv)
- **Signals:** data, select, y
- **Setup:** Compile mux8to1 from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For each legal select code in data, select, hold all unselected data at one and toggle the selected bit/value 0->1->0; then hold the selected value constant and toggle every unselected input. Repeat in descending select order.
- **Expected result:** y follows only the selected input with combinational settling. Reversing traversal must not retain an earlier select's result. Check unused select encodings against the explicit default contract.
- **Coverage target:** Each select x both selected data values; each unselected input toggled; reverse traversal.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-080

**Every pair of simultaneous requests and no request** · Priority encoder · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/134-priority-encoder/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/134-priority-encoder/design.sv)
- **Signals:** request, code, valid
- **Setup:** Compile priority_encoder from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Apply all one-hot requests, every pair of set request bits, all requests and no requests through request. Start each trial after a different prior winning request.
- **Expected result:** code, valid selects the source-defined highest-priority bit, independently of the previous winner. Check valid separately where present; where no valid exists, record the documented zero-input code or Z result rather than inventing validity.
- **Coverage target:** Each winning bit; every pairwise priority conflict; all-zero/default output; prior-winner independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-081

**Terminal-count enable/load collisions** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/142-counter-p1/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/142-counter-p1/design.sv)
- **Signals:** clk, reset, enable, load, load_value, count
- **Setup:** Compile counter from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Use the normal reset/load/count path to reach the last and first legal values of count. Exercise every present enable, direction and load combination from clk, reset, enable, load, load_value at those boundaries. Include consecutive reloads and reset during rollover.
- **Expected result:** The independently maintained count follows the exact modulus and source control priority. Holds consume no count step when enable exists. Carry/terminal outputs align with the documented pre-/post-edge count. Cover the actual digit modulus, not an assumed binary maximum.
- **Coverage target:** Low/high rollover crossed with each exposed control; reset/load priority; terminal pulse alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-082

**Terminal-count enable/load collisions** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/143-counter-p2/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/143-counter-p2/design.sv)
- **Signals:** clk, reset, enable, load, load_value, count
- **Setup:** Compile counter from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Use the normal reset/load/count path to reach the last and first legal values of count. Exercise every present enable, direction and load combination from clk, reset, enable, load, load_value at those boundaries. Include consecutive reloads and reset during rollover.
- **Expected result:** The independently maintained count follows the exact modulus and source control priority. Holds consume no count step when enable exists. Carry/terminal outputs align with the documented pre-/post-edge count. Cover the actual digit modulus, not an assumed binary maximum.
- **Coverage target:** Low/high rollover crossed with each exposed control; reset/load priority; terminal pulse alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-083

**Terminal-count enable/load collisions** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/plates/section-10-projects/144-counter-p3/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/plates/section-10-projects/144-counter-p3/design.sv)
- **Signals:** clk, reset, enable, load, load_value, count
- **Setup:** Compile counter from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Use the normal reset/load/count path to reach the last and first legal values of count. Exercise every present enable, direction and load combination from clk, reset, enable, load, load_value at those boundaries. Include consecutive reloads and reset during rollover.
- **Expected result:** The independently maintained count follows the exact modulus and source control priority. Holds consume no count step when enable exists. Carry/terminal outputs align with the documented pre-/post-edge count. Cover the actual digit modulus, not an assumed binary maximum.
- **Coverage target:** Low/high rollover crossed with each exposed control; reset/load priority; terminal pulse alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### SV-084

**Setup word and data word framing after startup is defined** · SPI DAC · P1 · Blocked · Prerequisite

- **Source:** [1. SV Functional Coverage/Projects/05-spi-transition-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/05-spi-transition-coverage/design.sv)
- **Signals:** clk, din, start, mosi, cs
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Once a legal startup/reset contract is implemented or explicitly agreed, pulse start with din=ABC hex and capture mosi on each clock where the transmitter drives cs low. Keep a separate bit count per cs-low interval.
- **Expected result:** The first 32-bit MSB-first word is 08000001 hex. The data word is {030,ABC,00}=030ABC00 hex. Each word has exactly 32 driven bits, with cs high between words. Current source has no defined initial state, so this case remains blocked.
- **Coverage target:** Setup payload; all 32 bit positions; data packing; chip-select boundaries.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Resolve startup state first; forcing internal state is a separate characterization, not a power-up pass.

### SV-012

**Random bursts with a reference queue** · Coverage FIFO · P2 · Pending · Simulation plan

- **Source:** [1. SV Functional Coverage/Projects/01-fifo-functional-coverage/design.sv](https://github.com/kapiltrip/systemverilog-from-beginning/blob/318bd495dee245f946d7c72127cb698bcf6e6680/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage/design.sv)
- **Signals:** clk, rst, wr_en, rd_en, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision 318bd495dee2. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run 1000 or more edges for each of three recorded seeds. Bias requests toward empty/full and one-away states. Queue only writes accepted by pre-edge flags and dequeue only accepted reads.
- **Expected result:** Every accepted read matches the oldest reference word. End by draining and proving the reference queue empty. Compare dout AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

