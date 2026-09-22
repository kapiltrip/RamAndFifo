# GoodQuestions: detailed Verilog verification cases

[Plan index](../VERIFICATION_PLAN.md) · [Excel tracker](../VERIFICATION_CASES.xlsx) · [HDL source map](../VERIFICATION_SOURCE_MAP.md)

**138 cases, 95 HDL files.** Reviewed revision [a83e5a8a5d72](https://github.com/kapiltrip/GoodQuestions/commit/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701). This is a verification *plan*: no new simulation result is claimed.

## Design contract to check

Each exercise is independent. The synchronous dual-port FIFO accepts a push during a full+pop; the q31 async FIFO has a next-pointer flag feedback risk. Follow the exact stimulus and expected timing in each case.

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
| [GQ-001](#gq-001) | P0 | Asynchronous FIFO | Coordinated reset and idle | Pending |
| [GQ-002](#gq-002) | P0 | Asynchronous FIFO | First word crosses to read domain | Pending |
| [GQ-003](#gq-003) | P0 | Asynchronous FIFO | Fill, overflow, drain and underflow | Pending |
| [GQ-007](#gq-007) | P0 | Asynchronous FIFO | Gray pointers and blocked requests | Pending |
| [GQ-008](#gq-008) | P0 | Asynchronous FIFO | Synchronizer direction and flag latency | Pending |
| [GQ-015](#gq-015) | P0 | Asynchronous FIFO | Flag combinational-loop boundary check | Pending |
| [GQ-016](#gq-016) | P0 | Full-throughput synchronous FIFO | Reset and first usable cycle | Pending |
| [GQ-017](#gq-017) | P0 | Full-throughput synchronous FIFO | Single write then single read | Pending |
| [GQ-018](#gq-018) | P0 | Full-throughput synchronous FIFO | Ordering and mixed data | Pending |
| [GQ-019](#gq-019) | P0 | Full-throughput synchronous FIFO | Fill to capacity and reject overflow | Pending |
| [GQ-020](#gq-020) | P0 | Full-throughput synchronous FIFO | Drain to empty and reject underflow | Pending |
| [GQ-021](#gq-021) | P0 | Full-throughput synchronous FIFO | Both enables in the middle | Pending |
| [GQ-022](#gq-022) | P0 | Full-throughput synchronous FIFO | Both enables when empty | Pending |
| [GQ-023](#gq-023) | P0 | Full-throughput synchronous FIFO | Both enables when full | Pending |
| [GQ-028](#gq-028) | P0 | Two maximum values | Ordering, duplicates and handshake | Pending |
| [GQ-030](#gq-030) | P0 | FIR filter | Impulse, signed data and latency | Pending |
| [GQ-031](#gq-031) | P0 | Remainder FSM | All remainder transitions | Pending |
| [GQ-034](#gq-034) | P0 | Reset synchronizer | Asynchronous assert and two-edge release | Pending |
| [GQ-079](#gq-079) | P0 | Build and evidence | Compile isolated tops and record reproducible evidence | Pending |
| [GQ-080](#gq-080) | P0 | Asynchronous FIFO | First empty release at each destination phase | Pending |
| [GQ-081](#gq-081) | P0 | Asynchronous FIFO | Full release with continuously asserted write | Pending |
| [GQ-084](#gq-084) | P0 | Two maximum values | Sorted order with duplicate maxima and unsigned extremes | Pending |
| [GQ-087](#gq-087) | P0 | FIR filter | Signed impulse, flush and coefficient order | Pending |
| [GQ-090](#gq-090) | P0 | Input qualification | Exact sampled pulse qualification | Pending |
| [GQ-092](#gq-092) | P0 | Input qualification | Exact sampled pulse qualification | Pending |
| [GQ-094](#gq-094) | P0 | Start/chip-select sequencer | Nine-cycle schedule and restart | Pending |
| [GQ-095](#gq-095) | P0 | Start/chip-select sequencer | Nine-cycle schedule and restart | Pending |
| [GQ-096](#gq-096) | P0 | Latch and flip-flop | Transparency versus edge capture | Pending |
| [GQ-099](#gq-099) | P0 | Fibonacci | Enable gaps and modular overflow | Pending |
| [GQ-100](#gq-100) | P0 | Remainder FSM | Exhaustive serial words with leading zeros | Pending |
| [GQ-101](#gq-101) | P0 | Sequence detector | Overlapping and nonoverlapping 10110 contracts | Pending |
| [GQ-102](#gq-102) | P0 | Sequence detector | Overlapping and nonoverlapping 10110 contracts | Pending |
| [GQ-136](#gq-136) | P0 | Clock divider | Even and odd ratios including falling-edge contribution | Pending |
| [GQ-137](#gq-137) | P0 | Clock divider | Duty quantization and zero/full duty | Pending |
| [GQ-004](#gq-004) | P1 | Asynchronous FIFO | Fast writer and slow reader | Pending |
| [GQ-005](#gq-005) | P1 | Asynchronous FIFO | Slow writer and fast reader | Pending |
| [GQ-006](#gq-006) | P1 | Asynchronous FIFO | Equal rates with phase shifts | Pending |
| [GQ-009](#gq-009) | P1 | Asynchronous FIFO | Clock stop and restart | Pending |
| [GQ-011](#gq-011) | P1 | Asynchronous FIFO | Both resets during traffic | Pending |
| [GQ-012](#gq-012) | P1 | Asynchronous FIFO | One-sided reset contract | Blocked |
| [GQ-024](#gq-024) | P1 | Full-throughput synchronous FIFO | Idle and output validity | Pending |
| [GQ-025](#gq-025) | P1 | Full-throughput synchronous FIFO | Repeated wraparound | Pending |
| [GQ-026](#gq-026) | P1 | Full-throughput synchronous FIFO | Reset with queued traffic | Pending |
| [GQ-029](#gq-029) | P1 | Two maximum values | Clear interrupts a comparison | Pending |
| [GQ-032](#gq-032) | P1 | Fibonacci | Enable gaps and overflow | Pending |
| [GQ-033](#gq-033) | P1 | Time pulses | Second/minute/hour rollover | Pending |
| [GQ-035](#gq-035) | P1 | Clock gate | Enable changes in both clock phases | Pending |
| [GQ-036](#gq-036) | P1 | Tri-state bus | Drive, release and contention | Pending |
| [GQ-037](#gq-037) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [GQ-038](#gq-038) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [GQ-039](#gq-039) | P1 | Shift/rotate | Direction, load and boundary bits | Pending |
| [GQ-040](#gq-040) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [GQ-041](#gq-041) | P1 | Multiplexer | Every select and unselected-input isolation | Pending |
| [GQ-042](#gq-042) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [GQ-043](#gq-043) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [GQ-044](#gq-044) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [GQ-045](#gq-045) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [GQ-046](#gq-046) | P1 | Sequence detector | 10110 matches, overlaps and near misses | Pending |
| [GQ-047](#gq-047) | P1 | Sequence detector | 10110 matches, overlaps and near misses | Pending |
| [GQ-048](#gq-048) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [GQ-049](#gq-049) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [GQ-050](#gq-050) | P1 | Gray code | Conversion, wrap and local adjacency | Pending |
| [GQ-051](#gq-051) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [GQ-052](#gq-052) | P1 | Clock divider | Frequency, duty cycle and startup | Pending |
| [GQ-053](#gq-053) | P1 | Clock divider | Frequency, duty cycle and startup | Pending |
| [GQ-054](#gq-054) | P1 | Clock divider | Frequency, duty cycle and startup | Pending |
| [GQ-055](#gq-055) | P1 | Clock divider | Frequency, duty cycle and startup | Pending |
| [GQ-056](#gq-056) | P1 | Counter | Reset, rollover and control priority | Pending |
| [GQ-057](#gq-057) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [GQ-058](#gq-058) | P1 | Encoded divide-by-three FSM | Binary and six-state Gray sequence comparison | Pending |
| [GQ-059](#gq-059) | P1 | Arithmetic | Arithmetic, carry/borrow and width | Pending |
| [GQ-060](#gq-060) | P1 | Multiplexer | Every select and unselected-input isolation | Pending |
| [GQ-061](#gq-061) | P1 | Arithmetic | Arithmetic, carry/borrow and width | Pending |
| [GQ-062](#gq-062) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [GQ-063](#gq-063) | P1 | Multiplexer | Every select and unselected-input isolation | Pending |
| [GQ-064](#gq-064) | P1 | Multiplexer | Every select and unselected-input isolation | Pending |
| [GQ-065](#gq-065) | P1 | Multiplexer | Every select and unselected-input isolation | Pending |
| [GQ-066](#gq-066) | P1 | Multiplexer | Every select and unselected-input isolation | Pending |
| [GQ-067](#gq-067) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [GQ-068](#gq-068) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [GQ-069](#gq-069) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [GQ-070](#gq-070) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [GQ-071](#gq-071) | P1 | Sequence detector | 10110 matches, overlaps and near misses | Pending |
| [GQ-072](#gq-072) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [GQ-073](#gq-073) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [GQ-074](#gq-074) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [GQ-075](#gq-075) | P1 | Gray code | Conversion, wrap and local adjacency | Pending |
| [GQ-082](#gq-082) | P1 | Asynchronous FIFO | Both extended pointers wrap during overlap | Pending |
| [GQ-083](#gq-083) | P1 | Asynchronous FIFO | Reset assertion while a local clock is stopped | Pending |
| [GQ-085](#gq-085) | P1 | Two maximum values | Clear cancels each in-flight compare phase | Pending |
| [GQ-086](#gq-086) | P1 | Two maximum values | Held valid and changing data while busy | Pending |
| [GQ-088](#gq-088) | P1 | FIR filter | Reference convolution with asymmetric coefficients | Pending |
| [GQ-089](#gq-089) | P1 | FIR filter | Output-width truncation is not saturation | Pending |
| [GQ-091](#gq-091) | P1 | Input qualification | Rearm only after low history drains | Pending |
| [GQ-093](#gq-093) | P1 | Input qualification | Rearm only after low history drains | Pending |
| [GQ-097](#gq-097) | P1 | Pulse-width detector | One-sample pulse and wider pulses | Pending |
| [GQ-098](#gq-098) | P1 | Pulse extension | Current input OR one-cycle history | Pending |
| [GQ-103](#gq-103) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [GQ-104](#gq-104) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [GQ-105](#gq-105) | P1 | Shift/rotate | Every bit position and simultaneous load/shift controls | Pending |
| [GQ-106](#gq-106) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [GQ-107](#gq-107) | P1 | Multiplexer | Selected data transition and inactive-input isolation | Pending |
| [GQ-108](#gq-108) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-109](#gq-109) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-110](#gq-110) | P1 | Sequence detector | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-111](#gq-111) | P1 | Gray code | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-112](#gq-112) | P1 | Time pulses | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-113](#gq-113) | P1 | Clock divider | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-114](#gq-114) | P1 | Clock divider | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-115](#gq-115) | P1 | Clock divider | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-116](#gq-116) | P1 | Clock divider | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-117](#gq-117) | P1 | Counter | Terminal-count enable/load collisions | Pending |
| [GQ-118](#gq-118) | P1 | Clock gate | Independent truth table and history-free output checks | Pending |
| [GQ-119](#gq-119) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-120](#gq-120) | P1 | Reset synchronizer | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-121](#gq-121) | P1 | Encoded divide-by-three FSM | Unused encoding recovery in an isolated fault-injection run | Pending |
| [GQ-122](#gq-122) | P1 | Arithmetic | Long carry or borrow and independent operand ordering | Pending |
| [GQ-123](#gq-123) | P1 | Multiplexer | Selected data transition and inactive-input isolation | Pending |
| [GQ-124](#gq-124) | P1 | Arithmetic | Long carry or borrow and independent operand ordering | Pending |
| [GQ-125](#gq-125) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [GQ-126](#gq-126) | P1 | Multiplexer | Selected data transition and inactive-input isolation | Pending |
| [GQ-127](#gq-127) | P1 | Multiplexer | Selected data transition and inactive-input isolation | Pending |
| [GQ-128](#gq-128) | P1 | Multiplexer | Selected data transition and inactive-input isolation | Pending |
| [GQ-129](#gq-129) | P1 | Multiplexer | Selected data transition and inactive-input isolation | Pending |
| [GQ-130](#gq-130) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-131](#gq-131) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-132](#gq-132) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-133](#gq-133) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-134](#gq-134) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-135](#gq-135) | P1 | Gray code | Repeat state transitions with reset and input-history variations | Pending |
| [GQ-138](#gq-138) | P1 | Clock divider | Duty options and reset-dependent output exceptions | Pending |
| [GQ-010](#gq-010) | P2 | Asynchronous FIFO | Many laps and random bursts | Pending |
| [GQ-013](#gq-013) | P2 | Asynchronous FIFO | Parameter and minimum-depth limits | Pending |
| [GQ-014](#gq-014) | P2 | Asynchronous FIFO | CDC implementation review | Pending |
| [GQ-027](#gq-027) | P2 | Full-throughput synchronous FIFO | Random bursts with a reference queue | Pending |
| [GQ-076](#gq-076) | P2 | Practice draft | Compile and compare draft contract | Pending |
| [GQ-077](#gq-077) | P2 | Practice draft | Compile and compare draft contract | Pending |
| [GQ-078](#gq-078) | P2 | Practice draft | Compile and compare draft contract | Pending |

## Detailed test ideas

### GQ-001

**Coordinated reset and idle** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run both independent clocks, set wren=rden=0 and assert wrrst=rdrst=1. Release each reset away from its local edge.
- **Expected result:** Local pointers reset, full=0, empty=1 and dout=0 after reset settles. No memory clearing is required.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-002

**First word crosses to read domain** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write A5 once on wrclk while full=0; keep rden=0 and watch empty on successive rdclk edges. Then request one accepted read.
- **Expected result:** empty deasserts only after synchronized write-pointer visibility. dout=A5 after the accepted rdclk edge. This variant directly computes flags from next pointers. First test the combinational feedback at empty/full.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-003

**Fill, overflow, drain and underflow** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** With reads stopped, write DEPTH words (2^aw (default 16)), attempt extra writes, then drain after empty clears. Attempt extra reads.
- **Expected result:** Exactly DEPTH original words return in order. Full writes and empty reads never move local pointers. Final full=0 and empty=1 after clock-domain propagation.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-007

**Gray pointers and blocked requests** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Observe local binary/Gray pointer pairs through wrap. Hold wren=1 at full and rden=1 at empty.
- **Expected result:** Local pointer increments only on accepted operations; Gray equals binary XOR (binary shifted right one). Successive LOCAL Gray values differ in one bit, or zero when holding. Destination samples may skip states and differ in multiple bits.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-008

**Synchronizer direction and flag latency** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Apply one remote pointer change while the destination clock runs; trace first and second synchronization stages on each destination edge.
- **Expected result:** Stage 1 samples the remote pointer; stage 2 samples previous stage 1. Flags must use stage 2. This variant directly computes flags from next pointers. First test the combinational feedback at empty/full.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-015

**Flag combinational-loop boundary check** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** rden, wren, empty, full, rdptrbin_next, wrptrbin_next, rdptrgray_next, wrptrgray_next
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** At empty assert rden; near full assert wren. Run with a finite simulator watchdog and inspect the combinational dependency path.
- **Expected result:** Flags must settle to a definite value before an edge. Here empty/full depend on next pointers, which themselves depend on empty/full; record oscillation/non-settling or a lint combinational-loop finding as failure.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Source indicates circular flag logic; do not assume the same behavior as AsynchronousFifo/async_fifo.v.

### GQ-016

**Reset and first usable cycle** · Full-throughput synchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Hold push=pop=0. Assert rst_n=0, clock the design, then release reset away from the active edge.
- **Expected result:** After the specified reset event: fifo_empty=1 and fifo_full=0; pointers/count are reset. data_out is driven by an always-reading synchronous RAM, so it may change even when pop=0 or fifo_empty=1. Reset sets the RAM output to zero; after release it resumes reading even without a pop.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-017

**Single write then single read** · Full-throughput synchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write A5 with push=1 while fifo_full=0; disable write; request one read with pop=1 while fifo_empty=0.
- **Expected result:** fifo_empty clears after the write and asserts after the read. Compare data_out AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer. Exactly one word is transferred.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-018

**Ordering and mixed data** · Full-throughput synchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Write 10,22,35,48 with gaps, then drain using isolated and consecutive pop requests.
- **Expected result:** Read values are 10,22,35,48 in that order. Compare data_out AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-019

**Fill to capacity and reject overflow** · Full-throughput synchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** With pop=0, issue exactly DEPTH writes (2^ADDR_W (default 256)); check one below full and full. Attempt three further writes with distinct data, then drain.
- **Expected result:** fifo_full asserts only after the last available slot is used. Extra writes cannot move the write pointer or replace queued data. Draining returns the original DEPTH values.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-020

**Drain to empty and reject underflow** · Full-throughput synchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill and drain exactly DEPTH accepted reads. Keep pop=1 for three additional clocks with push=0.
- **Expected result:** fifo_empty asserts on the last accepted pop; extra reads do not advance the read pointer or change occupancy. data_out is driven by an always-reading synchronous RAM, so it may change even when pop=0 or fifo_empty=1. Reset sets the RAM output to zero; after release it resumes reading even without a pop.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-021

**Both enables in the middle** · Full-throughput synchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill to half capacity. Keep push=pop=1 for at least 2*DEPTH clocks with a changing data_in.
- **Expected result:** Both operations are accepted on each edge and occupancy stays constant. The stream remains ordered across pointer wraps. Compare data_out AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-022

**Both enables when empty** · Full-throughput synchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset empty, then assert push=pop=1 for one edge with data_in=3C.
- **Expected result:** Only the write is accepted because the pre-edge fifo_empty=1. Occupancy becomes one. No same-edge bypass/pop of 3C is allowed.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-023

**Both enables when full** · Full-throughput synchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill to capacity; assert push=pop=1 for one edge with a new data_in.
- **Expected result:** Both operations are accepted: the old head is read, the new word enters the tail, and occupancy stays DEPTH. Check read-first collision behavior.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-028

**Ordering, duplicates and handshake** · Two maximum values · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q21/q21_max_and_second_max_onecmp.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q21/q21_max_and_second_max_onecmp.v)
- **Signals:** clk, rst, clear, in_valid, in_data, in_ready, max1, max2, max1_valid, max2_valid
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Submit 3,9,5,9 only when in_ready=1; wait for processing between submissions. Also test zero samples and one sample after reset.
- **Expected result:** After four accepted values max1=9,max2=9: duplicates are counted. With zero/one samples, validity bits identify which maxima exist. Input while not ready is not accepted.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-030

**Impulse, signed data and latency** · FIR filter · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q24/q24_fir_5tap.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q24/q24_fir_5tap.v)
- **Signals:** clk, rst_n, sample_in, sample_out
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset, send impulse 1 followed by zeros, then constant 1 and signed extreme samples. Repeat with asymmetric and negative coefficients.
- **Expected result:** After each sampling edge the default impulse response is 1,2,3,2,1,0; the constant response settles to 9. Use signed products, widened sums and output-width truncation when computing expected results.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-031

**All remainder transitions** · Remainder FSM · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q19_q20/q19_divisible_by3_fsm.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q19_q20/q19_divisible_by3_fsm.v)
- **Signals:** clk, rst, bit_in, div_by_3
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Feed serial MSB-first streams for 0,1,2,3,6,7 and longer random bit sequences; reset between independent numbers.
- **Expected result:** Update reference remainder as (2*previous+bit_in) mod 3. div_by_3 is high exactly for remainder zero after the clock edge, including reset state.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### GQ-034

**Asynchronous assert and two-edge release** · Reset synchronizer · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q28_q30/q30_reset_synchronizer.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q28_q30/q30_reset_synchronizer.v)
- **Signals:** clk, rst_n, local_reset_n
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Assert rst_n=0 with clk stopped, release to 1, then provide two rising edges. Reassert during the release sequence.
- **Expected result:** local_reset_n asserts low without a clock and deasserts only after two rising edges after release. Reassertion restarts the two-stage release.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-079

**Compile isolated tops and record reproducible evidence** · Build and evidence · P0 · Pending · Source review

- **Source:** [1. qa/bi_buf/bi_buf.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/bi_buf/bi_buf.v)
- **Signals:** Top/module names and port declarations in the RTL map
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-080

**First empty release at each destination phase** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset both domains. Place one accepted write at four phases relative to rdclk: shortly after, a quarter period after, a half period after, and shortly before an edge. Keep rden=1 throughout. Tag the word uniquely.
- **Expected result:** Measure each variant against its actual flag/synchronizer contract. No read is accepted while pre-edge empty is high; the first accepted read returns the tag. The separate CDC/feedback findings remain independent failures even if data ordering works.
- **Coverage target:** Four source/destination phases; rejected reads while visibility propagates; first accepted read.
- **Stop rule:** Allow eight destination edges after a stable remote pointer change; report timeout if settled RTL flags/data do not progress.

### GQ-081

**Full release with continuously asserted write** · Asynchronous FIFO · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Fill to capacity with reads disabled. Keep wren=1 and offer a new unique tag on every write clock. Accept one read in the other domain, then stop reading. Record pre-edge full at each wrclk.
- **Expected result:** All writes while full is high are rejected. Exactly the first write edge that begins with full=0 can consume the released slot. The accepted tag is the one present on that edge; earlier offered tags must not enter the queue.
- **Coverage target:** Remote read to local full release; conservative blocking; first new accepted tag.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-084

**Sorted order with duplicate maxima and unsigned extremes** · Two maximum values · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q21/q21_max_and_second_max_onecmp.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q21/q21_max_and_second_max_onecmp.v)
- **Signals:** clk, rst, clear, in_valid, in_ready, in_data, max1, max2, max1_valid, max2_valid
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Send [0,255,128,255,1,254] at WIDTH=8, changing in_data only for accepted requests. Check results after in_ready returns. Repeat in ascending, descending and repeated-equal order.
- **Expected result:** The largest two accepted values count duplicates: final max1=255 and max2=255. After zero samples both valid bits are 0; after one sample only max1_valid is 1. No signed comparison of 128/255 is intended.
- **Coverage target:** Zero/one/two-plus samples; equal maxima; both comparator paths; unsigned high bit.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-087

**Signed impulse, flush and coefficient order** · FIR filter · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q24/q24_fir_5tap.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q24/q24_fir_5tap.v)
- **Signals:** clk, rst_n, sample_in, sample_out
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** After reset, apply +1 followed by zeros, then -1 followed by zeros using default coefficients 1,2,3,2,1. Wait until the first impulse has drained before starting the second.
- **Expected result:** The five consecutive registered outputs are 1,2,3,2,1 and then zero; the negative impulse gives -1,-2,-3,-2,-1. Check after NBA. Reset during the tail clears the stored samples and output.
- **Coverage target:** All five taps; both signs; return to zero; reset with nonzero history.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-090

**Exact sampled pulse qualification** · Input qualification · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q16_sync_debounce_onepulse.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q16_sync_debounce_onepulse.v)
- **Signals:** clk, rst, async_in, pulse
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset all four stages low. Drive async_in high so it is first captured at E1, and keep it high through E5. Repeat with exactly one sampled high and then exactly two consecutive sampled highs, with several low samples between trials.
- **Expected result:** With sustained high: E1 captures q1, E2 q2, E3 d1; pulse is high after E3 and low after E4. One sampled high does not qualify; two consecutive sampled highs produce one pulse. This is sampled pulse qualification, not a configurable long debounce timer.
- **Coverage target:** Sampled high runs of lengths 1,2,5; phase shift; one output pulse per qualified rise.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-092

**Exact sampled pulse qualification** · Input qualification · P0 · Pending · Simulation plan

- **Source:** [1. qa/q08_sync_debounce_onepulse/sync_debounce_onepulse.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q08_sync_debounce_onepulse/sync_debounce_onepulse.v)
- **Signals:** clk, rst_n, async_in, pulse
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset all four stages low. Drive async_in high so it is first captured at E1, and keep it high through E5. Repeat with exactly one sampled high and then exactly two consecutive sampled highs, with several low samples between trials.
- **Expected result:** With sustained high: E1 captures q1, E2 q2, E3 d1; pulse is high after E3 and low after E4. One sampled high does not qualify; two consecutive sampled highs produce one pulse. This is sampled pulse qualification, not a configurable long debounce timer.
- **Coverage target:** Sampled high runs of lengths 1,2,5; phase shift; one output pulse per qualified rise.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-094

**Nine-cycle schedule and restart** · Start/chip-select sequencer · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q15_start_and_chipselects.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q15_start_and_chipselects.v)
- **Signals:** clk, rst, start, cs1, cs2, cs3
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** After the active reset, number released rising edges E1..E9. Sample outputs after NBA at every edge, then reset in each active chip-select phase and repeat.
- **Expected result:** start is high at E1,E4,E7. cs1 is high at E2, cs2 at E5, cs3 at E8. Remaining edges are inactive gaps. Each pulse lasts one clock, selections are mutually exclusive, and reset restarts at the first selection.
- **Coverage target:** All three chip selects; start-before-select spacing; reset in each phase.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-095

**Nine-cycle schedule and restart** · Start/chip-select sequencer · P0 · Pending · Simulation plan

- **Source:** [1. qa/q07_start_and_chipselects/start_and_chipselects.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q07_start_and_chipselects/start_and_chipselects.v)
- **Signals:** clk, rst_n, start, CS1, CS2, CS3
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** After the active reset, number released rising edges E1..E9. Sample outputs after NBA at every edge, then reset in each active chip-select phase and repeat.
- **Expected result:** start is high at E1,E4,E7. CS1 is high at E2, CS2 at E5, CS3 at E8. Remaining edges are inactive gaps. Each pulse lasts one clock, selections are mutually exclusive, and reset restarts at the first selection.
- **Coverage target:** All three chip selects; start-before-select spacing; reset in each phase.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-096

**Transparency versus edge capture** · Latch and flip-flop · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q07_q11/q10_latch_and_flop.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q07_q11/q10_latch_and_flop.v)
- **Signals:** clk, input_sig, q_latch, q_flop
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive input_sig=0 before a rising clk, then toggle it twice while clk remains high. Hold clk low and toggle it again. Finally issue the next rising edge.
- **Expected result:** q_latch follows input_sig throughout the high level and holds during low. q_flop changes only after a rising edge and holds during both between-edge changes. No reset exists; initialize by an actual high phase/capture.
- **Coverage target:** High transparency; low hold; positive-edge capture; both input polarities.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-099

**Enable gaps and modular overflow** · Fibonacci · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q19_q20/q20_fibonacci_enable.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q19_q20/q20_fibonacci_enable.v)
- **Signals:** clk, rst_n, enable, cur_num, next_num, sum
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use WIDTH=4. After reset verify (cur_num,next_num)=(0,1). Advance 10 enabled edges with alternating 1- and 3-clock pauses; compute both next registers from their OLD values each accepted edge.
- **Expected result:** The state sequence starts (1,1),(1,2),(2,3),(3,5),(5,8),(8,13),(13,5) modulo 16. Pauses preserve both registers. sum is the current combinational sum modulo WIDTH, including during pauses.
- **Coverage target:** Both state registers; enable hold; first wrap; reset during sequence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-100

**Exhaustive serial words with leading zeros** · Remainder FSM · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q19_q20/q19_divisible_by3_fsm.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q19_q20/q19_divisible_by3_fsm.v)
- **Signals:** clk, rst, bit_in, div_by_3
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For all unsigned 8-bit values, reset then send bits MSB first. After every edge update reference remainder=(2*old_remainder+bit_in) mod 3. Repeat several words prefixed with 0,00 and 000.
- **Expected result:** div_by_3 equals remainder==0 after each accepted bit, including zero and prefixes. Leading zeros do not change the final remainder; bit order must be explicit.
- **Coverage target:** All 256 eight-bit words; all three remainders x both bit values; leading zeros.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-101

**Overlapping and nonoverlapping 10110 contracts** · Sequence detector · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q13_seq_10110_fsms_abcd.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q13_seq_10110_fsms_abcd.v)
- **Signals:** clk, rst, x, y
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Send 10110110 with x stable before each edge, then 1011010110. Check each of the four implementations independently. For Mealy check y before the edge consuming the final zero; for Moore check y after that edge.
- **Expected result:** The overlapping implementation recognizes matches ending at positions 5 and 8 in 10110110. A nonoverlapping implementation resets its prefix after the first match and does not recognize the second overlap. All variants recognize separate complete patterns with correct output timing.
- **Coverage target:** Mealy/Moore x overlap/nonoverlap; shared-prefix stream; reset in every partial-match state.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### GQ-102

**Overlapping and nonoverlapping 10110 contracts** · Sequence detector · P0 · Pending · Simulation plan

- **Source:** [1. qa/q05_seq_10110/seq_10110_fsms.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q05_seq_10110/seq_10110_fsms.v)
- **Signals:** clk, rst_n, x, y
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Send 10110110 with x stable before each edge, then 1011010110. Check each of the four implementations independently. For Mealy check y before the edge consuming the final zero; for Moore check y after that edge.
- **Expected result:** The overlapping implementation recognizes matches ending at positions 5 and 8 in 10110110. A nonoverlapping implementation resets its prefix after the first match and does not recognize the second overlap. All variants recognize separate complete patterns with correct output timing.
- **Coverage target:** Mealy/Moore x overlap/nonoverlap; shared-prefix stream; reset in every partial-match state.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### GQ-136

**Even and odd ratios including falling-edge contribution** · Clock divider · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q27/q27_clock_div_n.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q27/q27_clock_div_n.v)
- **Signals:** clk, rst_n, clk_div
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use a 10 ns, 50% duty input. Build N=2,3,4,5,8. After startup measure ten steady output periods and every high/low interval. Separately inspect N=1 before calling it supported.
- **Expected result:** For tested N>=2, period=N*10 ns with 50% high time. Odd N relies on pos|neg and therefore on both input edges. N=1 yields WIDTH=0 and HALF=0; no divide-by-one bypass is implemented.
- **Coverage target:** Even/odd division; both edges; legal parameter endpoints; unsupported N=1 documented.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-137

**Duty quantization and zero/full duty** · Clock divider · P0 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q27/q27_clock_div_n_duty.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q27/q27_clock_div_n_duty.v)
- **Signals:** clk, rst_n, clk_div
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For DIV_BY=10 test DUTY_OPTION=1..8. Select the custom path with an option outside 1..8 and custom percentages 0,25,100. Repeat custom 50 with DIV_BY=3.
- **Expected result:** High clocks per period=floor(DIV_BY*selected_percent/100). For DIV_BY=10, presets give 2..9 high clocks. Custom 25 gives 2/10=20%, not 25%; DIV_BY=3/custom50 gives 1/3. Custom 0 stays low and 100 stays high after reset release. Quantization is part of this implementation.
- **Coverage target:** All eight presets; custom selection; rounding; constant-low/high endpoints.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-004

**Fast writer and slow reader** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use write/read periods 10 ns/31 ns, unrelated initial phases, and bursts long enough to reach full.
- **Expected result:** Only locally accepted operations enter the reference queue; no loss/reordering. full may conservatively remain high while a read propagates.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-005

**Slow writer and fast reader** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use write/read periods 29 ns/8 ns, then reverse the rates; repeatedly touch empty.
- **Expected result:** No stale/unwritten word is consumed. empty can remain high while a remote write propagates.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-006

**Equal rates with phase shifts** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use 10 ns/10 ns clocks with offsets 0,2,5 ns. Include coincident edges and continuous traffic at half occupancy.
- **Expected result:** Ordered data with race-free stimulus. Determine each operation from its own pre-edge full/empty; do not order coincident events by testbench process scheduling.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-009

**Clock stop and restart** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pause rdclk while writing to full, then resume it; repeat by pausing wrclk during reads.
- **Expected result:** No operation occurs without its local clock; flags converge after the stopped clock resumes. Scoreboard order survives the pause.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-011

**Both resets during traffic** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill, assert both resets during a burst, flush the expected queue, restart clocks and send a fresh known sequence.
- **Expected result:** Reset discards previous queued data; only new writes are considered valid. No assumptions about clearing memory cells.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-012

**One-sided reset contract** · Asynchronous FIFO · P1 · Blocked · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Consider asserting only wrrst, then only rdrst, while data is pending. Define whether the whole FIFO is flushed or one domain may continue before executing.
- **Expected result:** Pass criteria require an agreed system reset policy. Current independent pointer resets do not guarantee preservation of unread data after a one-sided reset.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Resolve reset policy first; never mark data preservation proven by ordinary RTL simulation.

### GQ-024

**Idle and output validity** · Full-throughput synchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pause both enables at empty, one word, half-full and full. Toggle data_in while idle.
- **Expected result:** Pointers/count and flags hold. data_out is driven by an always-reading synchronous RAM, so it may change even when pop=0 or fifo_empty=1. Reset sets the RAM output to zero; after release it resumes reading even without a pop.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-025

**Repeated wraparound** · Full-throughput synchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Alternate fill/drain and mixed bursts until each pointer wraps at least four times. Use a sequence number for every accepted write.
- **Expected result:** No duplication, loss or reordering. Counts stay between zero and DEPTH; fifo_full and fifo_empty cannot both be true.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-026

**Reset with queued traffic** · Full-throughput synchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill, assert rst_n during traffic, then hold enables low through reset. Discard the software reference queue; release reset and write fresh values.
- **Expected result:** Old queued values are discarded logically. The first fresh drain returns only post-reset accepted writes. data_out is driven by an always-reading synchronous RAM, so it may change even when pop=0 or fifo_empty=1. Reset sets the RAM output to zero; after release it resumes reading even without a pop.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-029

**Clear interrupts a comparison** · Two maximum values · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q21/q21_max_and_second_max_onecmp.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q21/q21_max_and_second_max_onecmp.v)
- **Signals:** clk, clear, in_valid, in_ready, max1_valid, max2_valid
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Assert clear during each comparison state, with in_valid also high.
- **Expected result:** Clear wins; both valid bits clear and state returns ready. The interrupted sample is discarded.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-032

**Enable gaps and overflow** · Fibonacci · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q19_q20/q20_fibonacci_enable.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q19_q20/q20_fibonacci_enable.v)
- **Signals:** clk, rst_n, enable, cur_num, next_num, sum
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset, pulse enable with gaps, then run long enough to overflow a small WIDTH.
- **Expected result:** Initial pair is 0,1; enabled pairs advance 1,1 then 1,2 then 2,3. Hold both stored terms while enable=0; sum remains their combinational sum modulo 2^WIDTH.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-033

**Second/minute/hour rollover** · Time pulses · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q22_q23/q22_time_ticks.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q22_q23/q22_time_ticks.v)
- **Signals:** clk, rst_n, one_ms_pulse, second, minute, hour
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Count accepted one_ms_pulse events, inserting gaps; check 999/1000, 59999/60000 and 3599999/3600000 events.
- **Expected result:** second every 1000 events, minute every 60000, hour every 3600000. Outputs are combinational qualifiers of pre-edge counters and the input pulse; sample at the accepting edge before counters roll.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### GQ-035

**Enable changes in both clock phases** · Clock gate · P1 · Pending · Simulation and source review

- **Source:** [1. qa/pdf_q28_q30/q28_glitch_free_clock_gate.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q28_q30/q28_glitch_free_clock_gate.v)
- **Signals:** clk_in, enable, gated_clk
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize enable while clk_in is low. Toggle enable in low/high phases and compare every gated pulse width.
- **Expected result:** Enable is captured only while clk_in=0. A high-phase enable change cannot shorten or create a gated pulse; accepted pulses follow clk_in. Initialize the latch before checking.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-036

**Drive, release and contention** · Tri-state bus · P1 · Pending · Simulation plan

- **Source:** [1. qa/bi_buf/bi_buf.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/bi_buf/bi_buf.v)
- **Signals:** c, a, b
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise c, a, b; allow one external driver at a time, test each direction/enable, then release both. Isolate a conflicting-drive negative run.
- **Expected result:** Enabled path forwards the source, disabled path is high impedance, and conflicting equal-strength binary drives resolve to X. Do not replace four-state checks with two-state equality.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-037

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q03_q06/q03_logic_gates.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q03_q06/q03_logic_gates.v)
- **Signals:** a, b, and_y, or_y, xor_y, nand_y, nor_y, xnor_y
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check and_y, or_y, xor_y, nand_y, nor_y, xnor_y against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: and_y = a & b; or_y = a | b; xor_y = a ^ b; nand_y = ~(a & b); nor_y = ~(a | b); xnor_y = ~(a ^ b); and_y = a & b; or_y = a | b; xor_y = a ^ b; nand_y = ~(a & b); nor_y = ~(a | b); xnor_y = ~(a ^ b); and_y = a && b; or_y = a || b; xor_y = a != b; nand_y = !(a && b); nor_y = !(a || b); xnor_y = a == b.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-038

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q03_q06/q04_bitwise_reduction.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q03_q06/q04_bitwise_reduction.v)
- **Signals:** databus, all_ones_detected, is_databus_odd, signal_not_zero
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive databus through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check all_ones_detected, is_databus_odd, signal_not_zero against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: all_ones_detected = &databus; is_databus_odd = ^databus; signal_not_zero = |databus.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-039

**Direction, load and boundary bits** · Shift/rotate · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q03_q06/q05_shift_operations.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q03_q06/q05_shift_operations.v)
- **Signals:** a, mul_by_4, div_by_8
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a with walking-one patterns at both ends; exercise every shift amount/direction and simultaneous load/enable controls.
- **Expected result:** mul_by_4, div_by_8 preserves the defined bit order and delay. Check zero-fill, sign-fill or rotation separately as specified by this source; load/hold priority and bits shifted out must match the contract. Source mapping: mul_by_4 = a << 2; div_by_8 = a >> 3.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-040

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q03_q06/q06_sign_extension.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q03_q06/q06_sign_extension.v)
- **Signals:** a, c
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check c against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: c = {{5{a[4]}}, a}.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-041

**Every select and unselected-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q07_q11/q07_mux4_styles.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q07_q11/q07_mux4_styles.v)
- **Signals:** a, b, c, d, sel, y
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings. Source mapping: y = (sel == 2'b00) ? a : (sel == 2'b01) ? b : (sel == 2'b10) ? c : d.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-042

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q07_q11/q09_ff_reset_styles.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q07_q11/q09_ff_reset_styles.v)
- **Signals:** clk, rst, d, q
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For q09_a, q09_b, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-043

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q07_q11/q10_latch_and_flop.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q07_q11/q10_latch_and_flop.v)
- **Signals:** clk, input_sig, q_latch, q_flop
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For q10, initialize through its reset/load path, then vary input_sig before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q_latch, q_flop only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-044

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q07_q11/q11_edge_detect.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q07_q11/q11_edge_detect.v)
- **Signals:** clk, rst, d, rising, falling, toggle
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For q11, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check rising, falling, toggle only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: toggle = d ^ q_prev; falling = (~d) & q_prev; rising = d & (~q_prev).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-045

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q12_one_cycle_pulse_detect.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q12_one_cycle_pulse_detect.v)
- **Signals:** clk, rst, d, pulse_high, pulse_low
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For q12, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check pulse_high, pulse_low only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: pulse_high = (~d) & q1 & (~q2); pulse_low = d & (~q1) & q2.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-046

**10110 matches, overlaps and near misses** · Sequence detector · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q13_seq_10110_fsms_abcd.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q13_seq_10110_fsms_abcd.v)
- **Signals:** clk, rst, x, y
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive 10110, near misses, repeated matches and an overlapping stream (10110110), one bit per clock using clk, rst, x. Reset midway through a prefix.
- **Expected result:** Check y at each match ending. Overlap variants retain a matching suffix; nonoverlap variants discard it. Use the actual combinational/registered output timing in each module, not the name Mealy/Moore alone.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### GQ-047

**10110 matches, overlaps and near misses** · Sequence detector · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q14_last5_detect_10110.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q14_last5_detect_10110.v)
- **Signals:** clk, rst, din, match
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive 10110, near misses, repeated matches and an overlapping stream (10110110), one bit per clock using clk, rst, din. Reset midway through a prefix.
- **Expected result:** Check match at each match ending. Overlap variants retain a matching suffix; nonoverlap variants discard it. Use the actual combinational/registered output timing in each module, not the name Mealy/Moore alone. Source mapping: match = (window == 5'b10110); match = (window == 5'b01101).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### GQ-048

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q15_start_and_chipselects.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q15_start_and_chipselects.v)
- **Signals:** clk, rst, start, cs1, cs2, cs3
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For q15_start_and_chipselects, initialize through its reset/load path, then vary available controls before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check start, cs1, cs2, cs3 only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: start = (phase == 2'd0); cs1 = (phase == 2'd1) && (sel == 2'd0); cs2 = (phase == 2'd1) && (sel == 2'd1); cs3 = (phase == 2'd1) && (sel == 2'd2).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-049

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q16_sync_debounce_onepulse.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q16_sync_debounce_onepulse.v)
- **Signals:** clk, rst, async_in, pulse
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For q16_sync_debounce_onepulse, initialize through its reset/load path, then vary async_in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check pulse only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: pulse = (q2 & d1) & (~d2).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-050

**Conversion, wrap and local adjacency** · Gray code · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q17_gray_counter_methods.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q17_gray_counter_methods.v)
- **Signals:** clk, rst, gray, bin
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep binary/Gray input or clock the full small-width sequence using clk, rst, gray, bin; compare encoder/decoder round trips if both exist.
- **Expected result:** Binary-to-Gray keeps the MSB and XORs adjacent bits; Gray-to-binary uses cumulative XOR from the MSB. Consecutive local count steps, including wrap, change one Gray bit; no change occurs while held. Source mapping: gray = bin ^ (bin >> 1); gray = bin_counter ^ (bin_counter >> 1).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-051

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q22_q23/q23_timing_b_from_a.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q22_q23/q23_timing_b_from_a.v)
- **Signals:** clk, rst_n, A, B
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For q23_timing_b_from_a, initialize through its reset/load path, then vary A before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, negedge rst_n.
- **Expected result:** Check B only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: B = A | a_delay.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-052

**Frequency, duty cycle and startup** · Clock divider · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q25_q26/q25_clock_div2.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q25_q26/q25_clock_div2.v)
- **Signals:** clk, rst_n, q
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use a known 50% input clock through clk, rst_n; measure steady output period and high time for ten cycles, then reset during both phases and test legal parameter endpoints.
- **Expected result:** Measure q against the named divide ratio and duty setting. Include both edges for half-cycle implementations. Distinguish a one-cycle enable pulse from a square clock; ignore documented startup transients only.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-053

**Frequency, duty cycle and startup** · Clock divider · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q25_q26/q26_clock_div3_duty50.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q25_q26/q26_clock_div3_duty50.v)
- **Signals:** clk, rst_n, clk_div3
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use a known 50% input clock through clk, rst_n; measure steady output period and high time for ten cycles, then reset during both phases and test legal parameter endpoints.
- **Expected result:** Measure clk_div3 against the named divide ratio and duty setting. Include both edges for half-cycle implementations. Distinguish a one-cycle enable pulse from a square clock; ignore documented startup transients only. Source mapping: clk_div3 = (DUTY_CYCLE == 33) ? duty_33 : (DUTY_CYCLE == 50) ? duty_50 : ((DUTY_CYCLE == 66) || (DUTY_CYCLE == 67)) ? duty_66 : (DUTY_CYCLE == 100) ? duty_100 : duty_50.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-054

**Frequency, duty cycle and startup** · Clock divider · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q27/q27_clock_div_n.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q27/q27_clock_div_n.v)
- **Signals:** clk, rst_n, clk_div
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use a known 50% input clock through clk, rst_n; measure steady output period and high time for ten cycles, then reset during both phases and test legal parameter endpoints.
- **Expected result:** Measure clk_div against the named divide ratio and duty setting. Include both edges for half-cycle implementations. Distinguish a one-cycle enable pulse from a square clock; ignore documented startup transients only. Source mapping: clk_div = ((N % 2) == 0) ? duty_even: duty_odd.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-055

**Frequency, duty cycle and startup** · Clock divider · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q27/q27_clock_div_n_duty.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q27/q27_clock_div_n_duty.v)
- **Signals:** clk, rst_n, clk_div
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use a known 50% input clock through clk, rst_n; measure steady output period and high time for ten cycles, then reset during both phases and test legal parameter endpoints.
- **Expected result:** Measure clk_div against the named divide ratio and duty setting. Include both edges for half-cycle implementations. Distinguish a one-cycle enable pulse from a square clock; ignore documented startup transients only.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-056

**Reset, rollover and control priority** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q27/q27_clock_divider_variants.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q27/q27_clock_divider_variants.v)
- **Signals:** clk, rst_n, clk_div2, clk_div4, clk_div8, clk_div3, enable, tick
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize q27_div2_toggle, q27_div4_counter, q27_div8_counter, q27_div3_duty50, q27_divn_tick; test every enable/load/direction combination in clk, rst_n. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** clk_div2 follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-057

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q28_q30/q29_async_rise_detect_when_clocks_off.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q28_q30/q29_async_rise_detect_when_clocks_off.v)
- **Signals:** d_async, clr_n, q
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For q29_async_rise_detect_when_clocks_off, q29_async_any_edge_detect_when_clocks_off, initialize through its reset/load path, then vary d_async, clr_n before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge d_async, negedge clr_n, negedge d_async.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: q = rise_seen | fall_seen.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-058

**Binary and six-state Gray sequence comparison** · Encoded divide-by-three FSM · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q44/q44_div3_gray_fsm.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q44/q44_div3_gray_fsm.v)
- **Signals:** clk, rst_n, state, div3_out
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset low, then run twelve rising edges. Compare binary and Gray variants by their div3_out timing, while checking their state encodings separately. Do not require the binary state bits to equal the Gray bits.
- **Expected result:** Binary state cycle is 00,01,10. Gray variants cycle 000,001,011,111,101,100. Reset state is first in each cycle with div3_out=1. The next outputs repeat 0,0,1, giving period three and one-third duty. Gray transitions including wrap change one bit.
- **Coverage target:** Both complete state cycles; every Gray transition; identical output phase; reset-high output.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-059

**Arithmetic, carry/borrow and width** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q45/q45_adders.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q45/q45_adders.v)
- **Signals:** a, b, sum, carry, cin, cout, diff, borrow, bin, bout
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise a, b at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum, carry bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: sum = a ^ b; carry = a & b; sum = a ^ b ^ cin; sum = a ^ b ^ cin.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-060

**Every select and unselected-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q46/q46_gates_using_mux2.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q46/q46_gates_using_mux2.v)
- **Signals:** d0, d1, s, y, a, b
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep s through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings. Source mapping: y = s ? d1 : d0.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-061

**Arithmetic, carry/borrow and width** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q47/q47_xor_controlled_inverter.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q47/q47_xor_controlled_inverter.v)
- **Signals:** a, control, y, b, subtract, result, cout
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise a, control at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every y bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: y = a ^ control; y = ~(a ^ control).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-062

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q48/q48_gates_using_nand.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q48/q48_gates_using_nand.v)
- **Signals:** a, y, b
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check y against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: y = ~(a & a); y = ~(nand_ab & nand_ab); y = ~(not_a & not_b); y = ~(a_term & b_term); y = ~(or_ab & or_ab).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-063

**Every select and unselected-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q49/q49_mux4_from_mux2.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q49/q49_mux4_from_mux2.v)
- **Signals:** d0, d1, s, y, a, b, c, d, s0, s1
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep s through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings. Source mapping: y = s ? d1 : d0; y = (~s1 & ~s0 & a) | (~s1 & s0 & b) | ( s1 & ~s0 & c) | ( s1 & s0 & d); y = s1 ? high_pair : low_pair.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-064

**Every select and unselected-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. qa/q01_mux/mux2_behavioral.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q01_mux/mux2_behavioral.v)
- **Signals:** a, b, sel, y
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-065

**Every select and unselected-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. qa/q01_mux/mux2_dataflow.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q01_mux/mux2_dataflow.v)
- **Signals:** a, b, sel, y
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings. Source mapping: y = sel ? b : a.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-066

**Every select and unselected-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. qa/q01_mux/mux2_gatelevel.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q01_mux/mux2_gatelevel.v)
- **Signals:** a, b, sel, y
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** y equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-067

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/q02_ff/dff_async_reset.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q02_ff/dff_async_reset.v)
- **Signals:** clk, rst, d, q
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For dff_async_reset, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-068

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/q02_ff/dff_sync_reset.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q02_ff/dff_sync_reset.v)
- **Signals:** clk, rst, d, q
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For dff_sync_reset, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-069

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/q03_edge_detect/edge_detect_both.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q03_edge_detect/edge_detect_both.v)
- **Signals:** clk, rst, d, q
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For edge_detect_both, edge_detect_both_async_d, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge rst.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-070

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/q04_rise_pulse/edge_to_1cycle_pulse.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q04_rise_pulse/edge_to_1cycle_pulse.v)
- **Signals:** clk, rst_n, d, q
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For edge_to_1cycle_pulse, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-071

**10110 matches, overlaps and near misses** · Sequence detector · P1 · Pending · Simulation plan

- **Source:** [1. qa/q05_seq_10110/seq_10110_fsms.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q05_seq_10110/seq_10110_fsms.v)
- **Signals:** clk, rst_n, x, y
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive 10110, near misses, repeated matches and an overlapping stream (10110110), one bit per clock using clk, rst_n, x. Reset midway through a prefix.
- **Expected result:** Check y at each match ending. Overlap variants retain a matching suffix; nonoverlap variants discard it. Use the actual combinational/registered output timing in each module, not the name Mealy/Moore alone.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### GQ-072

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/q06_detect/detect.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q06_detect/detect.v)
- **Signals:** clk, rst_n, din, match
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For detect, initialize through its reset/load path, then vary din before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, negedge rst_n.
- **Expected result:** Check match only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: match = (shreg == 5'b10110).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-073

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/q07_start_and_chipselects/start_and_chipselects.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q07_start_and_chipselects/start_and_chipselects.v)
- **Signals:** clk, rst_n, start, CS1, CS2, CS3
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For start_and_chipselects, initialize through its reset/load path, then vary available controls before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, negedge rst_n.
- **Expected result:** Check start, CS1, CS2, CS3 only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: start = (counter == 2'd1); CS1 = start_d & (sel == 2'd0); CS2 = start_d & (sel == 2'd1); CS3 = start_d & (sel == 2'd2).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-074

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/q08_sync_debounce_onepulse/sync_debounce_onepulse.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q08_sync_debounce_onepulse/sync_debounce_onepulse.v)
- **Signals:** clk, rst_n, async_in, pulse
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For sync_debounce_onepulse, initialize through its reset/load path, then vary async_in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, negedge rst_n.
- **Expected result:** Check pulse only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: pulse = (q2 & d1) & ~d2.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-075

**Conversion, wrap and local adjacency** · Gray code · P1 · Pending · Simulation plan

- **Source:** [1. qa/q09_gray/gray_blocks.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q09_gray/gray_blocks.v)
- **Signals:** clk, rst_n, gray, bin, gray_q, bin_q
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep binary/Gray input or clock the full small-width sequence using clk, rst_n, gray, bin, gray_q, bin_q; compare encoder/decoder round trips if both exist.
- **Expected result:** Binary-to-Gray keeps the MSB and XORs adjacent bits; Gray-to-binary uses cumulative XOR from the MSB. Consecutive local count steps, including wrap, change one Gray bit; no change occurs while held. Source mapping: gray = bin ^ (bin >> 1); gray = bin ^ (bin >> 1).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-082

**Both extended pointers wrap during overlap** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Prefill half the queue. Run enough independent reads/writes for at least 4*DEPTH accepted operations in EACH domain. Include 10/31 ns, 29/8 ns and 10/10 ns periods with nonzero phases. Keep an integer transaction ID wider than the DUT data for the reference sequence.
- **Expected result:** Every accepted read matches the oldest accepted write, using the configured data-width truncation. Address bits and the extra wrap bit traverse their full cycles. Equal lower addresses mean full or empty according to the extended pointer relation, not the address alone.
- **Coverage target:** Every memory index; local binary and Gray wrap; remote snapshots that skip intermediate states.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### GQ-083

**Reset assertion while a local clock is stopped** · Asynchronous FIFO · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Pause one clock with queued data, assert BOTH domain resets, and observe resettable local state without waiting for the stopped clock. Restart both clocks before reset release, release away from edges, and send new tags.
- **Expected result:** The asynchronous reset controls clear their local resettable state even without clock edges. Pre-reset queued data is invalid. A fresh write/read sequence works after restart; memory cell contents need not clear.
- **Coverage target:** Stopped write clock; stopped read clock; coordinated flush; first post-reset transfer.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-085

**Clear cancels each in-flight compare phase** · Two maximum values · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q21/q21_max_and_second_max_onecmp.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q21/q21_max_and_second_max_onecmp.v)
- **Signals:** clk, rst, clear, in_valid, in_ready, in_data, max1, max2, max1_valid, max2_valid
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Establish maxima, accept a sample, and assert clear in the following first-compare cycle. Repeat with a sample that requires the second comparison and clear in that phase. Also assert clear together with a new valid request in idle.
- **Expected result:** clear takes priority, returns to idle, clears both valid flags and discards the in-flight/new sample. A later accepted sample is the first sample of a fresh campaign.
- **Coverage target:** Clear in IDLE, CMP1, CMP2; clear+valid priority.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-086

**Held valid and changing data while busy** · Two maximum values · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q21/q21_max_and_second_max_onecmp.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q21/q21_max_and_second_max_onecmp.v)
- **Signals:** clk, rst, in_valid, in_ready, in_data, max1, max2
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Hold in_valid high while changing in_data every cycle. Separately pulse in_valid only while in_ready=0. Track the pre-edge ready/valid handshake.
- **Expected result:** Only idle ready/valid edges latch samples. Busy-only pulses are ignored. With valid held high, a new sample can be accepted each time idle is reached; it is not a one-shot request.
- **Coverage target:** Busy request rejection; held-valid reacceptance; one- versus two-compare service time.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-088

**Reference convolution with asymmetric coefficients** · FIR filter · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q24/q24_fir_5tap.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q24/q24_fir_5tap.v)
- **Signals:** clk, rst_n, sample_in, sample_out
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Override the coefficients to 1,-2,3,0,4 with enough signed width. Apply [3,-1,0,2,-3] then five zeros. Compute a separate sum of the newest sample and four prior samples for each edge.
- **Expected result:** Each output matches C1*x[n]+C2*x[n-1]+...+C5*x[n-4], signed and truncated only to OUT_W. Asymmetric coefficients reveal reversed tap order; zero coefficient tests ignored history contribution.
- **Coverage target:** Every coefficient position; negative and zero coefficients; positive/negative accumulation.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-089

**Output-width truncation is not saturation** · FIR filter · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q24/q24_fir_5tap.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q24/q24_fir_5tap.v)
- **Signals:** clk, rst_n, sample_in, sample_out
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise maximum positive and minimum negative signed samples with defaults, then use OUT_W=DATA_W+COEFF_W in a separate parameter run. Keep a wider integer reference result. Do not set OUT_W below the product width.
- **Expected result:** Default sizing preserves the intended sum range for these coefficients. A legal narrower output retains low OUT_W two’s-complement bits; the RTL does not promise saturation. OUT_W below DATA_W+COEFF_W is unsupported because the sign-extension replication count would be negative.
- **Coverage target:** Positive/negative extremes; cancellation; legal narrowed result width.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-091

**Rearm only after low history drains** · Input qualification · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q16_sync_debounce_onepulse.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q16_sync_debounce_onepulse.v)
- **Signals:** clk, rst, async_in, pulse
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** After a qualified high, hold the input high for ten clocks, then apply low gaps of one, two and four sampled clocks before a new high. Compare all four internal delay stages or a four-stage reference history.
- **Expected result:** A held high produces no repeated pulse. Re-qualification is determined by pulse=q2 AND d1 AND NOT d2. Compare each sampled history including short low gaps, and record any repeated pulse caused by actual rearming.
- **Coverage target:** Held high; three low-gap lengths; fresh qualified rise.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-093

**Rearm only after low history drains** · Input qualification · P1 · Pending · Simulation plan

- **Source:** [1. qa/q08_sync_debounce_onepulse/sync_debounce_onepulse.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q08_sync_debounce_onepulse/sync_debounce_onepulse.v)
- **Signals:** clk, rst_n, async_in, pulse
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** After a qualified high, hold the input high for ten clocks, then apply low gaps of one, two and four sampled clocks before a new high. Compare all four internal delay stages or a four-stage reference history.
- **Expected result:** A held high produces no repeated pulse. Re-qualification is determined by pulse=q2 AND d1 AND NOT d2. Compare each sampled history including short low gaps, and record any repeated pulse caused by actual rearming.
- **Coverage target:** Held high; three low-gap lengths; fresh qualified rise.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-097

**One-sample pulse and wider pulses** · Pulse-width detector · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q12_one_cycle_pulse_detect.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q12_one_cycle_pulse_detect.v)
- **Signals:** clk, rst, d, pulse_high, pulse_low
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** From a stable low history, raise d for exactly one capturing edge, then lower it before the next edge; inspect between edges and after the next edge. Repeat for 2- and 3-edge highs. Invert the stimulus after establishing a stable high history.
- **Expected result:** pulse_high is combinationally asserted for d=0,q1=1,q2=0, so inspect the interval after d falls and before history advances. pulse_low asserts for d=1,q1=0,q2=1. Wider runs must be checked against these three-sample conditions, not treated as generic rising-edge pulses.
- **Coverage target:** One-, two-, three-sample high and low runs; pre-edge versus post-edge observation.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-098

**Current input OR one-cycle history** · Pulse extension · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q22_q23/q23_timing_b_from_a.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q22_q23/q23_timing_b_from_a.v)
- **Signals:** clk, rst_n, A, B
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset a_delay low. Raise A between edges, sample B immediately, capture A=1, then drop A before the next rising edge. Also try an A pulse entirely between capture edges.
- **Expected result:** B=A OR the previously captured A. It rises immediately with A, remains high after a captured pulse falls, then falls after the next edge captures zero. A pulse not captured is not stretched beyond its own duration.
- **Coverage target:** Captured and uncaptured pulses; immediate path; one-cycle delayed tail.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-103

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q03_q06/q03_logic_gates.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q03_q06/q03_logic_gates.v)
- **Signals:** a, b, and_y, or_y, xor_y, nand_y, nor_y, xnor_y
- **Setup:** Compile q03, q03_bitwise_vector, q03_logical from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For a, b, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For and_y, or_y, xor_y, nand_y, nor_y, xnor_y, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-104

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q03_q06/q04_bitwise_reduction.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q03_q06/q04_bitwise_reduction.v)
- **Signals:** databus, all_ones_detected, is_databus_odd, signal_not_zero
- **Setup:** Compile q04 from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For databus, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For all_ones_detected, is_databus_odd, signal_not_zero, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-105

**Every bit position and simultaneous load/shift controls** · Shift/rotate · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q03_q06/q05_shift_operations.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q03_q06/q05_shift_operations.v)
- **Signals:** a, mul_by_4, div_by_8
- **Setup:** Compile q05 from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Using a, move a walking one from each endpoint through every legal shift position. Exercise shifts of zero, one and the maximum exposed amount. At a nonzero value, assert every simultaneously legal load/shift/enable combination.
- **Expected result:** mul_by_4, div_by_8 preserves the specified shift direction, fill and rotation. Count delay in accepted enabled edges. Competing controls follow the source's explicit priority, including multiple assignments to the same register.
- **Coverage target:** Every bit position; both endpoints; every exposed amount/direction; control collisions.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-106

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q03_q06/q06_sign_extension.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q03_q06/q06_sign_extension.v)
- **Signals:** a, c
- **Setup:** Compile q06 from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For c, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-107

**Selected data transition and inactive-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q07_q11/q07_mux4_styles.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q07_q11/q07_mux4_styles.v)
- **Signals:** a, b, c, d, sel, y
- **Setup:** Compile q07_a, q07_b, q07_c from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For each legal select code in a, b, c, d, sel, hold all unselected data at one and toggle the selected bit/value 0->1->0; then hold the selected value constant and toggle every unselected input. Repeat in descending select order.
- **Expected result:** y follows only the selected input with combinational settling. Reversing traversal must not retain an earlier select's result. Check unused select encodings against the explicit default contract.
- **Coverage target:** Each select x both selected data values; each unselected input toggled; reverse traversal.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-108

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q07_q11/q09_ff_reset_styles.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q07_q11/q09_ff_reset_styles.v)
- **Signals:** clk, rst, d, q
- **Setup:** Compile q09_a, q09_b from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For q09_a, q09_b, use legal inputs clk, rst, d to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-109

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q07_q11/q11_edge_detect.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q07_q11/q11_edge_detect.v)
- **Signals:** clk, rst, d, rising, falling, toggle
- **Setup:** Compile q11 from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For q11, use legal inputs clk, rst, d to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare rising, falling, toggle to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-110

**Repeat state transitions with reset and input-history variations** · Sequence detector · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q14_last5_detect_10110.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q14_last5_detect_10110.v)
- **Signals:** clk, rst, din, match
- **Setup:** Compile q14_last5_detect_10110, q14_last5_detect_10110_msb_insert, tb_q14_last5_detect_10110 from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For q14_last5_detect_10110, q14_last5_detect_10110_msb_insert, tb_q14_last5_detect_10110, use legal inputs clk, rst, din, bit_in to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare match to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-111

**Repeat state transitions with reset and input-history variations** · Gray code · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q17_gray_counter_methods.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q17_gray_counter_methods.v)
- **Signals:** clk, rst, gray, bin
- **Setup:** Compile q17_gray_counter_case_3bit, q17_bin_to_gray, q17_gray_to_bin, q17_gray_counter_xor from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For q17_gray_counter_case_3bit, q17_bin_to_gray, q17_gray_to_bin, q17_gray_counter_xor, use legal inputs clk, rst, bin, gray to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare gray, bin to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-112

**Repeat state transitions with reset and input-history variations** · Time pulses · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q22_q23/q22_time_ticks.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q22_q23/q22_time_ticks.v)
- **Signals:** clk, rst_n, one_ms_pulse, second, minute, hour
- **Setup:** Compile q22_time_ticks from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For q22_time_ticks, use legal inputs clk, rst_n, one_ms_pulse to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare second, minute, hour to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-113

**Repeat state transitions with reset and input-history variations** · Clock divider · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q25_q26/q25_clock_div2.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q25_q26/q25_clock_div2.v)
- **Signals:** clk, rst_n, q
- **Setup:** Compile q25_clock_div2 from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For q25_clock_div2, use legal inputs clk, rst_n to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-114

**Repeat state transitions with reset and input-history variations** · Clock divider · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q25_q26/q26_clock_div3_duty50.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q25_q26/q26_clock_div3_duty50.v)
- **Signals:** clk, rst_n, clk_div3
- **Setup:** Compile q26_clock_div3_duty50 from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For q26_clock_div3_duty50, use legal inputs clk, rst_n to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare clk_div3 to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-115

**Repeat state transitions with reset and input-history variations** · Clock divider · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q27/q27_clock_div_n.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q27/q27_clock_div_n.v)
- **Signals:** clk, rst_n, clk_div
- **Setup:** Compile clk_div_n from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For clk_div_n, use legal inputs clk, rst_n to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare clk_div to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-116

**Repeat state transitions with reset and input-history variations** · Clock divider · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q27/q27_clock_div_n_duty.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q27/q27_clock_div_n_duty.v)
- **Signals:** clk, rst_n, clk_div
- **Setup:** Compile clk_div_n_duty from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For clk_div_n_duty, use legal inputs clk, rst_n to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare clk_div to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-117

**Terminal-count enable/load collisions** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q27/q27_clock_divider_variants.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q27/q27_clock_divider_variants.v)
- **Signals:** clk, rst_n, clk_div2, clk_div4, clk_div8, clk_div3, enable, tick
- **Setup:** Compile q27_div2_toggle, q27_div4_counter, q27_div8_counter, q27_div3_duty50, q27_divn_tick from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** Use the normal reset/load/count path to reach the last and first legal values of clk_div2, clk_div4, clk_div8, clk_div3, tick. Exercise every present enable, direction and load combination from clk, rst_n, enable at those boundaries. Include consecutive reloads and reset during rollover.
- **Expected result:** The independently maintained count follows the exact modulus and source control priority. Holds consume no count step when enable exists. Carry/terminal outputs align with the documented pre-/post-edge count. Cover the actual digit modulus, not an assumed binary maximum.
- **Coverage target:** Low/high rollover crossed with each exposed control; reset/load priority; terminal pulse alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-118

**Independent truth table and history-free output checks** · Clock gate · P1 · Pending · Simulation and source review

- **Source:** [1. qa/pdf_q28_q30/q28_glitch_free_clock_gate.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q28_q30/q28_glitch_free_clock_gate.v)
- **Signals:** clk_in, enable, gated_clk
- **Setup:** Compile q28_glitch_free_clock_gate from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For clk_in, enable, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For gated_clk, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-119

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q28_q30/q29_async_rise_detect_when_clocks_off.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q28_q30/q29_async_rise_detect_when_clocks_off.v)
- **Signals:** d_async, clr_n, q
- **Setup:** Compile q29_async_rise_detect_when_clocks_off, q29_async_any_edge_detect_when_clocks_off from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For q29_async_rise_detect_when_clocks_off, q29_async_any_edge_detect_when_clocks_off, use legal inputs d_async, clr_n to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-120

**Repeat state transitions with reset and input-history variations** · Reset synchronizer · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q28_q30/q30_reset_synchronizer.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q28_q30/q30_reset_synchronizer.v)
- **Signals:** clk, rst_n, local_reset_n
- **Setup:** Compile q30_reset_synchronizer from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For q30_reset_synchronizer, use legal inputs clk, rst_n to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare local_reset_n to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-121

**Unused encoding recovery in an isolated fault-injection run** · Encoded divide-by-three FSM · P1 · Pending · Characterization

- **Source:** [1. qa/pdf_q44/q44_div3_gray_fsm.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q44/q44_div3_gray_fsm.v)
- **Signals:** clk, rst_n, state, div3_out
- **Setup:** Compile q44_div3_fsm_binary, q44_div3_fsm_gray6, q44_div3_fsm_gray6_equations from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** In a separate characterization run, place the binary FSM in state 11 and each Gray FSM in states 010 and 110, then release the injected value before one rising edge. Keep rst_n inactive.
- **Expected result:** The case-based default paths return to the initial high state. The equation-based Gray next-state equations also evaluate to 000 for 010 and 110. div3_out is high after recovery. This is injected-state recovery, not a state reachable during ordinary counting.
- **Coverage target:** One unused binary encoding; both unused Gray encodings; output after recovery.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-122

**Long carry or borrow and independent operand ordering** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q45/q45_adders.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q45/q45_adders.v)
- **Signals:** a, b, sum, carry, cin, cout, diff, borrow, bin, bout
- **Setup:** Compile q45_half_adder, q45_full_adder_two_half_adders, q45_full_adder_boolean, q45_full_adder_majority_carry, q45_ripple_adder4, q45_adder4_behavioral, q45_half_subtractor, q45_full_subtractor_two_half_subtractors, q45_full_subtractor_boolean, q45_ripple_subtractor4, q45_subtractor4_behavioral from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Using a, b, cin, bin, test 0+0, max+1, max+max, 0-1 where subtraction exists, and (2^k-1)+1 for every legal bit k. Repeat with operands exchanged and each exposed carry/borrow control.
- **Expected result:** Calculate the integer result with an extra bit before fitting the declared output width. Check sum, carry, cout, diff, borrow, bout including separate carry/borrow/zero indicators. Signed overflow must not be confused with carry; sequential designs use the captured operands.
- **Coverage target:** Carry/borrow chain through every bit; both operand orderings; zero and width overflow.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-123

**Selected data transition and inactive-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q46/q46_gates_using_mux2.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q46/q46_gates_using_mux2.v)
- **Signals:** d0, d1, s, y, a, b
- **Setup:** Compile q46_mux2, q46_inv_using_mux2, q46_and_using_mux2, q46_or_using_mux2, q46_nand_using_mux2, q46_nor_using_mux2, q46_xor_using_mux2, q46_xnor_using_mux2 from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For each legal select code in d0, d1, s, a, b, hold all unselected data at one and toggle the selected bit/value 0->1->0; then hold the selected value constant and toggle every unselected input. Repeat in descending select order.
- **Expected result:** y follows only the selected input with combinational settling. Reversing traversal must not retain an earlier select's result. Check unused select encodings against the explicit default contract.
- **Coverage target:** Each select x both selected data values; each unselected input toggled; reverse traversal.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-124

**Long carry or borrow and independent operand ordering** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q47/q47_xor_controlled_inverter.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q47/q47_xor_controlled_inverter.v)
- **Signals:** a, control, y, b, subtract, result, cout
- **Setup:** Compile q47_xor_controlled_inverter, q47_xnor_controlled_buffer, q47_add_sub_4bit from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Using a, control, b, subtract, test 0+0, max+1, max+max, 0-1 where subtraction exists, and (2^k-1)+1 for every legal bit k. Repeat with operands exchanged and each exposed carry/borrow control.
- **Expected result:** Calculate the integer result with an extra bit before fitting the declared output width. Check y, result, cout including separate carry/borrow/zero indicators. Signed overflow must not be confused with carry; sequential designs use the captured operands.
- **Coverage target:** Carry/borrow chain through every bit; both operand orderings; zero and width overflow.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-125

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q48/q48_gates_using_nand.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q48/q48_gates_using_nand.v)
- **Signals:** a, y, b
- **Setup:** Compile q48_inv_using_nand, q48_and_using_nand, q48_or_using_nand, q48_xor_using_nand, q48_nor_using_nand from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For y, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-126

**Selected data transition and inactive-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q49/q49_mux4_from_mux2.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q49/q49_mux4_from_mux2.v)
- **Signals:** d0, d1, s, y, a, b, c, d, s0, s1
- **Setup:** Compile q49_mux2, q49_mux4_from_mux2, q49_mux4_boolean, q49_mux4_from_mux2_bus from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For each legal select code in d0, d1, s, a, b, c, d, s0, s1, hold all unselected data at one and toggle the selected bit/value 0->1->0; then hold the selected value constant and toggle every unselected input. Repeat in descending select order.
- **Expected result:** y follows only the selected input with combinational settling. Reversing traversal must not retain an earlier select's result. Check unused select encodings against the explicit default contract.
- **Coverage target:** Each select x both selected data values; each unselected input toggled; reverse traversal.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-127

**Selected data transition and inactive-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. qa/q01_mux/mux2_behavioral.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q01_mux/mux2_behavioral.v)
- **Signals:** a, b, sel, y
- **Setup:** Compile mux2_behavioral from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For each legal select code in a, b, sel, hold all unselected data at one and toggle the selected bit/value 0->1->0; then hold the selected value constant and toggle every unselected input. Repeat in descending select order.
- **Expected result:** y follows only the selected input with combinational settling. Reversing traversal must not retain an earlier select's result. Check unused select encodings against the explicit default contract.
- **Coverage target:** Each select x both selected data values; each unselected input toggled; reverse traversal.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-128

**Selected data transition and inactive-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. qa/q01_mux/mux2_dataflow.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q01_mux/mux2_dataflow.v)
- **Signals:** a, b, sel, y
- **Setup:** Compile mux2_dataflow from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For each legal select code in a, b, sel, hold all unselected data at one and toggle the selected bit/value 0->1->0; then hold the selected value constant and toggle every unselected input. Repeat in descending select order.
- **Expected result:** y follows only the selected input with combinational settling. Reversing traversal must not retain an earlier select's result. Check unused select encodings against the explicit default contract.
- **Coverage target:** Each select x both selected data values; each unselected input toggled; reverse traversal.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-129

**Selected data transition and inactive-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. qa/q01_mux/mux2_gatelevel.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q01_mux/mux2_gatelevel.v)
- **Signals:** a, b, sel, y
- **Setup:** Compile mux2_gatelevel from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For each legal select code in a, b, sel, hold all unselected data at one and toggle the selected bit/value 0->1->0; then hold the selected value constant and toggle every unselected input. Repeat in descending select order.
- **Expected result:** y follows only the selected input with combinational settling. Reversing traversal must not retain an earlier select's result. Check unused select encodings against the explicit default contract.
- **Coverage target:** Each select x both selected data values; each unselected input toggled; reverse traversal.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-130

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/q02_ff/dff_async_reset.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q02_ff/dff_async_reset.v)
- **Signals:** clk, rst, d, q
- **Setup:** Compile dff_async_reset from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For dff_async_reset, use legal inputs clk, rst, d to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-131

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/q02_ff/dff_sync_reset.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q02_ff/dff_sync_reset.v)
- **Signals:** clk, rst, d, q
- **Setup:** Compile dff_sync_reset from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For dff_sync_reset, use legal inputs clk, rst, d to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-132

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/q03_edge_detect/edge_detect_both.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q03_edge_detect/edge_detect_both.v)
- **Signals:** clk, rst, d, q
- **Setup:** Compile edge_detect_both, edge_detect_both_async_d from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For edge_detect_both, edge_detect_both_async_d, use legal inputs clk, rst, d to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-133

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/q04_rise_pulse/edge_to_1cycle_pulse.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q04_rise_pulse/edge_to_1cycle_pulse.v)
- **Signals:** clk, rst_n, d, q
- **Setup:** Compile edge_to_1cycle_pulse from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For edge_to_1cycle_pulse, use legal inputs clk, rst_n, d to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-134

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. qa/q06_detect/detect.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q06_detect/detect.v)
- **Signals:** clk, rst_n, din, match
- **Setup:** Compile detect from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For detect, use legal inputs clk, rst_n, din to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare match to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-135

**Repeat state transitions with reset and input-history variations** · Gray code · P1 · Pending · Simulation plan

- **Source:** [1. qa/q09_gray/gray_blocks.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/q09_gray/gray_blocks.v)
- **Signals:** clk, rst_n, gray, bin, gray_q, bin_q
- **Setup:** Compile bin_counter_gray_out, bin_to_gray, gray_to_bin, gray_counter_store_gray from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For bin_counter_gray_out, bin_to_gray, gray_to_bin, gray_counter_store_gray, use legal inputs clk, rst_n, bin, gray to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare gray, bin, gray_q, bin_q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-138

**Duty options and reset-dependent output exceptions** · Clock divider · P1 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q25_q26/q26_clock_div3_duty50.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q25_q26/q26_clock_div3_duty50.v)
- **Signals:** clk, rst_n, clk_div3
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** With 50% input duty, test DUTY_CYCLE=33,50,66,67,100 and one unrecognized value. Observe output during reset and ten settled periods after release.
- **Expected result:** Periods for 33/50/66/67 are three input cycles with high times 1,1.5,2,2 input cycles respectively. Unrecognized values select the 50% path. DUTY_CYCLE=100 ties the output high even while rst_n=0, so reset-to-zero must not be imposed on that option.
- **Coverage target:** Each supported duty option; default selection; constant-high reset behavior.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-010

**Many laps and random bursts** · Asynchronous FIFO · P2 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run at least four complete pointer laps for three recorded seeds and clock ratios. Compare every accepted read with a software reference queue.
- **Expected result:** No duplicates, drops or ordering errors. End with both clocks running and fully drain the reference queue.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### GQ-013

**Parameter and minimum-depth limits** · Asynchronous FIFO · P2 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Elaborate legal data widths 1,8,16 and address widths 2,3,4. Separately try address width 1 and non-power-of-two DEPTH if that parameter exists.
- **Expected result:** Supported configurations retain capacity and ordering. Record unsupported values as a documented constraint: slices such as [AW-2:0] or [ADDR-2:0] need special handling below address width 2.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### GQ-014

**CDC implementation review** · Asynchronous FIFO · P2 · Pending · Source review

- **Source:** [1. qa/pdf_q31/q31_async_fifo_grayptr.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q31/q31_async_fifo_grayptr.v)
- **Signals:** wrclk, rdclk, wrrst, rdrst, wren, rden, din, dout, full, empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Inspect the synthesized synchronizer paths, reset release, Gray-bus constraints and memory mapping with the target FPGA/ASIC tools.
- **Expected result:** A CDC report and reviewed timing constraints are separate evidence. Functional simulation cannot establish metastability reliability or physical Gray-bus skew.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** This is a design-review case, not a Verilog simulation pass.

### GQ-027

**Random bursts with a reference queue** · Full-throughput synchronous FIFO · P2 · Pending · Simulation plan

- **Source:** [1. qa/pdf_q12_q18/q18_fifo_sync_dualport.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/qa/pdf_q12_q18/q18_fifo_sync_dualport.v)
- **Signals:** clk, rst_n, push, pop, data_in, data_out, fifo_full, fifo_empty
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Run 1000 or more edges for each of three recorded seeds. Bias requests toward empty/full and one-away states. Queue only writes accepted by pre-edge flags and dequeue only accepted reads.
- **Expected result:** Every accepted read matches the oldest reference word. End by draining and proving the reference queue empty. Compare data_out AFTER the accepted clk edge and nonblocking updates, using the word at the pre-edge read pointer.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Bound every producer and consumer wait; end the run after the stated trials plus a bounded drain.

### GQ-076

**Compile and compare draft contract** · Practice draft · P2 · Pending · Prerequisite

- **Source:** [1. study_plan/practice/video_04_gate_level_modeling_practice.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/study_plan/practice/video_04_gate_level_modeling_practice.v)
- **Signals:** a, b, sum, carry, cin, cout
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Compile this draft alone with an explicit top. Compare its interface and behavior with the active design in the same repository; record missing declarations and output drivers.
- **Expected result:** The draft must elaborate and meet an agreed contract before it can share active-design results. Do not include unfinished drafts in a wildcard compile.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Draft results are separate from active RTL.

### GQ-077

**Compile and compare draft contract** · Practice draft · P2 · Pending · Prerequisite

- **Source:** [1. study_plan/practice/video_05_full_adder_using_half_adder_practice.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/study_plan/practice/video_05_full_adder_using_half_adder_practice.v)
- **Signals:** a, b, cin, sum, cout, diff, borrow, bin, bout
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Compile this draft alone with an explicit top. Compare its interface and behavior with the active design in the same repository; record missing declarations and output drivers.
- **Expected result:** The draft must elaborate and meet an agreed contract before it can share active-design results. Do not include unfinished drafts in a wildcard compile.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Draft results are separate from active RTL.

### GQ-078

**Compile and compare draft contract** · Practice draft · P2 · Pending · Prerequisite

- **Source:** [1. study_plan/practice/video_06_bcd_ripple_carry_adder_practice.v](https://github.com/kapiltrip/GoodQuestions/blob/a83e5a8a5d7262dd223ebbf4af2bf4c8434d9701/study_plan/practice/video_06_bcd_ripple_carry_adder_practice.v)
- **Signals:** a, b, cin, sum, cout
- **Setup:** Build the listed RTL in isolation, with source revision a83e5a8a5d72. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Compile this draft alone with an explicit top. Compare its interface and behavior with the active design in the same repository; record missing declarations and output drivers.
- **Expected result:** The draft must elaborate and meet an agreed contract before it can share active-design results. Do not include unfinished drafts in a wildcard compile.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Draft results are separate from active RTL.

