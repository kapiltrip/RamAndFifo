# hdlBits: detailed Verilog verification cases

[Plan index](../VERIFICATION_PLAN.md) · [Excel tracker](../VERIFICATION_CASES.xlsx) · [HDL source map](../VERIFICATION_SOURCE_MAP.md)

**323 cases, 186 HDL files.** Reviewed revision [fc3f2b993a1e](https://github.com/kapiltrip/hdlBits/commit/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a). This is a verification *plan*: no new simulation result is claimed.

## Design contract to check

Many files declare top_module and must compile alone. Empty exercise modules remain Blocked; verify the original problem statement before treating a draft as implemented. Follow the exact stimulus and expected timing in each case.

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
| [HDL-001](#hdl-001) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-002](#hdl-002) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-004](#hdl-004) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-010](#hdl-010) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-014](#hdl-014) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-016](#hdl-016) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-018](#hdl-018) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-020](#hdl-020) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-022](#hdl-022) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-024](#hdl-024) | P0 | Implementation prerequisite | Define and implement top_module, add1 | Blocked |
| [HDL-025](#hdl-025) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-028](#hdl-028) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-029](#hdl-029) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-032](#hdl-032) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-047](#hdl-047) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-049](#hdl-049) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-050](#hdl-050) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-051](#hdl-051) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-059](#hdl-059) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-060](#hdl-060) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-061](#hdl-061) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-062](#hdl-062) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-063](#hdl-063) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-073](#hdl-073) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-078](#hdl-078) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-081](#hdl-081) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-092](#hdl-092) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-095](#hdl-095) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-099](#hdl-099) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-101](#hdl-101) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-102](#hdl-102) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-106](#hdl-106) | P0 | Implementation prerequisite | Define and implement top_module | Blocked |
| [HDL-178](#hdl-178) | P0 | Build and evidence | Compile isolated tops and record reproducible evidence | Pending |
| [HDL-179](#hdl-179) | P0 | BCD clock | Twelve-hour rollovers and enable pause | Pending |
| [HDL-180](#hdl-180) | P0 | Programmable timer | All delay values and exact completion duration | Pending |
| [HDL-182](#hdl-182) | P0 | Three-sample FSM | All triples and consecutive windows | Pending |
| [HDL-183](#hdl-183) | P0 | Shift/count register | Two enables target the same register | Pending |
| [HDL-184](#hdl-184) | P0 | Serial receiver exercise | Byte boundaries, error recovery and all payloads | Pending |
| [HDL-185](#hdl-185) | P0 | Serial receiver exercise | Byte boundaries, error recovery and all payloads | Pending |
| [HDL-186](#hdl-186) | P0 | Serial receiver exercise | Byte boundaries, error recovery and all payloads | Pending |
| [HDL-187](#hdl-187) | P0 | Three-byte packet | Alignment marker only matters for the first byte | Pending |
| [HDL-188](#hdl-188) | P0 | Three-byte packet | Alignment marker only matters for the first byte | Pending |
| [HDL-003](#hdl-003) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-005](#hdl-005) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-006](#hdl-006) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-007](#hdl-007) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-008](#hdl-008) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-009](#hdl-009) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-011](#hdl-011) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-012](#hdl-012) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-013](#hdl-013) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-015](#hdl-015) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-017](#hdl-017) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-019](#hdl-019) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-021](#hdl-021) | P1 | Shift/rotate | Direction, load and boundary bits | Pending |
| [HDL-023](#hdl-023) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-026](#hdl-026) | P1 | Arithmetic | Arithmetic, carry/borrow and width | Pending |
| [HDL-027](#hdl-027) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-030](#hdl-030) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-031](#hdl-031) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-033](#hdl-033) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-034](#hdl-034) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-035](#hdl-035) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-036](#hdl-036) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-037](#hdl-037) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-038](#hdl-038) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-039](#hdl-039) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-040](#hdl-040) | P1 | Arithmetic | Arithmetic, carry/borrow and width | Pending |
| [HDL-041](#hdl-041) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-042](#hdl-042) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-043](#hdl-043) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-044](#hdl-044) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-045](#hdl-045) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-046](#hdl-046) | P1 | Arithmetic | Arithmetic, carry/borrow and width | Pending |
| [HDL-048](#hdl-048) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-052](#hdl-052) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-053](#hdl-053) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-054](#hdl-054) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-055](#hdl-055) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-056](#hdl-056) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-057](#hdl-057) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-058](#hdl-058) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-064](#hdl-064) | P1 | Multiplexer | Every select and unselected-input isolation | Pending |
| [HDL-065](#hdl-065) | P1 | Arithmetic | Arithmetic, carry/borrow and width | Pending |
| [HDL-066](#hdl-066) | P1 | Arithmetic | Arithmetic, carry/borrow and width | Pending |
| [HDL-067](#hdl-067) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-068](#hdl-068) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-069](#hdl-069) | P1 | Arithmetic | Arithmetic, carry/borrow and width | Pending |
| [HDL-070](#hdl-070) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-071](#hdl-071) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-072](#hdl-072) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-074](#hdl-074) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-075](#hdl-075) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-076](#hdl-076) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-077](#hdl-077) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-079](#hdl-079) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-080](#hdl-080) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-082](#hdl-082) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-083](#hdl-083) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-084](#hdl-084) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-085](#hdl-085) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-086](#hdl-086) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-087](#hdl-087) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-088](#hdl-088) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-089](#hdl-089) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-090](#hdl-090) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-091](#hdl-091) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-093](#hdl-093) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-094](#hdl-094) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-096](#hdl-096) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-097](#hdl-097) | P1 | Counter | Reset, rollover and control priority | Pending |
| [HDL-098](#hdl-098) | P1 | Counter | Reset, rollover and control priority | Pending |
| [HDL-100](#hdl-100) | P1 | Counter | Reset, rollover and control priority | Pending |
| [HDL-103](#hdl-103) | P1 | Shift/rotate | Direction, load and boundary bits | Pending |
| [HDL-104](#hdl-104) | P1 | LFSR | Seed, recurrence and repeat period | Pending |
| [HDL-105](#hdl-105) | P1 | LFSR | Seed, recurrence and repeat period | Pending |
| [HDL-107](#hdl-107) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-108](#hdl-108) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-109](#hdl-109) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-110](#hdl-110) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-111](#hdl-111) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-112](#hdl-112) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-113](#hdl-113) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-114](#hdl-114) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-115](#hdl-115) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-116](#hdl-116) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-117](#hdl-117) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-118](#hdl-118) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-119](#hdl-119) | P1 | Lemmings FSM | Direction, priority and fall boundaries | Pending |
| [HDL-120](#hdl-120) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-121](#hdl-121) | P1 | Multiplexer | Every select and unselected-input isolation | Pending |
| [HDL-122](#hdl-122) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-123](#hdl-123) | P1 | Multiplexer | Every select and unselected-input isolation | Pending |
| [HDL-124](#hdl-124) | P1 | Arithmetic | Arithmetic, carry/borrow and width | Pending |
| [HDL-125](#hdl-125) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-126](#hdl-126) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-127](#hdl-127) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-128](#hdl-128) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-129](#hdl-129) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-130](#hdl-130) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-131](#hdl-131) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-132](#hdl-132) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-133](#hdl-133) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-134](#hdl-134) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-135](#hdl-135) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-136](#hdl-136) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-137](#hdl-137) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-138](#hdl-138) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-139](#hdl-139) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-140](#hdl-140) | P1 | Counter | Reset, rollover and control priority | Pending |
| [HDL-141](#hdl-141) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-142](#hdl-142) | P1 | Counter | Reset, rollover and control priority | Pending |
| [HDL-143](#hdl-143) | P1 | Shift/rotate | Direction, load and boundary bits | Pending |
| [HDL-144](#hdl-144) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-145](#hdl-145) | P1 | Shift/rotate | Direction, load and boundary bits | Pending |
| [HDL-146](#hdl-146) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-147](#hdl-147) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-148](#hdl-148) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-149](#hdl-149) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-150](#hdl-150) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-151](#hdl-151) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-152](#hdl-152) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-153](#hdl-153) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-154](#hdl-154) | P1 | Lemmings FSM | Direction, priority and fall boundaries | Pending |
| [HDL-155](#hdl-155) | P1 | Lemmings FSM | Direction, priority and fall boundaries | Pending |
| [HDL-156](#hdl-156) | P1 | Lemmings FSM | Direction, priority and fall boundaries | Pending |
| [HDL-157](#hdl-157) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-158](#hdl-158) | P1 | Serial receiver exercise | Frames, byte order and recovery | Pending |
| [HDL-159](#hdl-159) | P1 | Serial receiver exercise | Frames, byte order and recovery | Pending |
| [HDL-160](#hdl-160) | P1 | Serial receiver exercise | Frames, byte order and recovery | Pending |
| [HDL-161](#hdl-161) | P1 | Three-byte packet | Header alignment and byte assembly | Pending |
| [HDL-162](#hdl-162) | P1 | Three-byte packet | Header alignment and byte assembly | Pending |
| [HDL-163](#hdl-163) | P1 | Serial run-length detector | Stuffed zero, flag and error boundaries | Pending |
| [HDL-164](#hdl-164) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-165](#hdl-165) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-166](#hdl-166) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-167](#hdl-167) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-168](#hdl-168) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-169](#hdl-169) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-170](#hdl-170) | P1 | Cellular automaton | Load, edge cells and simultaneous update | Pending |
| [HDL-171](#hdl-171) | P1 | Cellular automaton | Load, edge cells and simultaneous update | Pending |
| [HDL-172](#hdl-172) | P1 | Sequential logic | Reset, control priority and cycle behavior | Pending |
| [HDL-173](#hdl-173) | P1 | Combinational logic | Input combinations and output mapping | Pending |
| [HDL-174](#hdl-174) | P1 | Game of Life | Still life, oscillator and toroidal edges | Pending |
| [HDL-175](#hdl-175) | P1 | Serial run-length detector | Stuffed zero, flag and error boundaries | Pending |
| [HDL-176](#hdl-176) | P1 | Serial run-length detector | Stuffed zero, flag and error boundaries | Pending |
| [HDL-177](#hdl-177) | P1 | Game of Life | Still life, oscillator and toroidal edges | Pending |
| [HDL-181](#hdl-181) | P1 | Programmable timer | Acknowledge priority and reset during each phase | Pending |
| [HDL-189](#hdl-189) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-190](#hdl-190) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-191](#hdl-191) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-192](#hdl-192) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-193](#hdl-193) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-194](#hdl-194) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-195](#hdl-195) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-196](#hdl-196) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-197](#hdl-197) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-198](#hdl-198) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-199](#hdl-199) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-200](#hdl-200) | P1 | Shift/rotate | Every bit position and simultaneous load/shift controls | Pending |
| [HDL-201](#hdl-201) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-202](#hdl-202) | P1 | Arithmetic | Long carry or borrow and independent operand ordering | Pending |
| [HDL-203](#hdl-203) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-204](#hdl-204) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-205](#hdl-205) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-206](#hdl-206) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-207](#hdl-207) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-208](#hdl-208) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-209](#hdl-209) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-210](#hdl-210) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-211](#hdl-211) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-212](#hdl-212) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-213](#hdl-213) | P1 | Arithmetic | Long carry or borrow and independent operand ordering | Pending |
| [HDL-214](#hdl-214) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-215](#hdl-215) | P1 | Combinational logic | Constant or stimulus-generator behavior over time | Pending |
| [HDL-216](#hdl-216) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-217](#hdl-217) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-218](#hdl-218) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-219](#hdl-219) | P1 | Arithmetic | Long carry or borrow and independent operand ordering | Pending |
| [HDL-220](#hdl-220) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-221](#hdl-221) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-222](#hdl-222) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-223](#hdl-223) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-224](#hdl-224) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-225](#hdl-225) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-226](#hdl-226) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-227](#hdl-227) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-228](#hdl-228) | P1 | Multiplexer | Selected data transition and inactive-input isolation | Pending |
| [HDL-229](#hdl-229) | P1 | Arithmetic | Long carry or borrow and independent operand ordering | Pending |
| [HDL-230](#hdl-230) | P1 | Arithmetic | Long carry or borrow and independent operand ordering | Pending |
| [HDL-231](#hdl-231) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-232](#hdl-232) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-233](#hdl-233) | P1 | Arithmetic | Long carry or borrow and independent operand ordering | Pending |
| [HDL-234](#hdl-234) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-235](#hdl-235) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-236](#hdl-236) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-237](#hdl-237) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-238](#hdl-238) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-239](#hdl-239) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-240](#hdl-240) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-241](#hdl-241) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-242](#hdl-242) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-243](#hdl-243) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-244](#hdl-244) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-245](#hdl-245) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-246](#hdl-246) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-247](#hdl-247) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-248](#hdl-248) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-249](#hdl-249) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-250](#hdl-250) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-251](#hdl-251) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-252](#hdl-252) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-253](#hdl-253) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-254](#hdl-254) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-255](#hdl-255) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-256](#hdl-256) | P1 | Counter | Terminal-count enable/load collisions | Pending |
| [HDL-257](#hdl-257) | P1 | Counter | Terminal-count enable/load collisions | Pending |
| [HDL-258](#hdl-258) | P1 | Counter | Terminal-count enable/load collisions | Pending |
| [HDL-259](#hdl-259) | P1 | Shift/rotate | Every bit position and simultaneous load/shift controls | Pending |
| [HDL-260](#hdl-260) | P1 | LFSR | Bit recurrence and zero-state characterization | Pending |
| [HDL-261](#hdl-261) | P1 | LFSR | Bit recurrence and zero-state characterization | Pending |
| [HDL-262](#hdl-262) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-263](#hdl-263) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-264](#hdl-264) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-265](#hdl-265) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-266](#hdl-266) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-267](#hdl-267) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-268](#hdl-268) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-269](#hdl-269) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-270](#hdl-270) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-271](#hdl-271) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-272](#hdl-272) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-273](#hdl-273) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-274](#hdl-274) | P1 | Lemmings FSM | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-275](#hdl-275) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-276](#hdl-276) | P1 | Multiplexer | Selected data transition and inactive-input isolation | Pending |
| [HDL-277](#hdl-277) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-278](#hdl-278) | P1 | Multiplexer | Selected data transition and inactive-input isolation | Pending |
| [HDL-279](#hdl-279) | P1 | Arithmetic | Long carry or borrow and independent operand ordering | Pending |
| [HDL-280](#hdl-280) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-281](#hdl-281) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-282](#hdl-282) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-283](#hdl-283) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-284](#hdl-284) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-285](#hdl-285) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-286](#hdl-286) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-287](#hdl-287) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-288](#hdl-288) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-289](#hdl-289) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-290](#hdl-290) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-291](#hdl-291) | P1 | Combinational logic | Constant or stimulus-generator behavior over time | Pending |
| [HDL-292](#hdl-292) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-293](#hdl-293) | P1 | Sequential logic | Independent truth table and history-free output checks | Pending |
| [HDL-294](#hdl-294) | P1 | Sequential logic | Independent truth table and history-free output checks | Pending |
| [HDL-295](#hdl-295) | P1 | Counter | Terminal-count enable/load collisions | Pending |
| [HDL-296](#hdl-296) | P1 | Counter | Terminal-count enable/load collisions | Pending |
| [HDL-297](#hdl-297) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-298](#hdl-298) | P1 | Shift/rotate | Every bit position and simultaneous load/shift controls | Pending |
| [HDL-299](#hdl-299) | P1 | Combinational logic | Constant or stimulus-generator behavior over time | Pending |
| [HDL-300](#hdl-300) | P1 | Combinational logic | Constant or stimulus-generator behavior over time | Pending |
| [HDL-301](#hdl-301) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-302](#hdl-302) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-303](#hdl-303) | P1 | Sequential logic | Independent truth table and history-free output checks | Pending |
| [HDL-304](#hdl-304) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-305](#hdl-305) | P1 | Lemmings FSM | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-306](#hdl-306) | P1 | Lemmings FSM | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-307](#hdl-307) | P1 | Lemmings FSM | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-308](#hdl-308) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-309](#hdl-309) | P1 | Serial run-length detector | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-310](#hdl-310) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-311](#hdl-311) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-312](#hdl-312) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-313](#hdl-313) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-314](#hdl-314) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-315](#hdl-315) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-316](#hdl-316) | P1 | Cellular automaton | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-317](#hdl-317) | P1 | Cellular automaton | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-318](#hdl-318) | P1 | Sequential logic | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-319](#hdl-319) | P1 | Combinational logic | Independent truth table and history-free output checks | Pending |
| [HDL-320](#hdl-320) | P1 | Game of Life | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-321](#hdl-321) | P1 | Serial run-length detector | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-322](#hdl-322) | P1 | Serial run-length detector | Repeat state transitions with reset and input-history variations | Pending |
| [HDL-323](#hdl-323) | P1 | Game of Life | Repeat state transitions with reset and input-history variations | Pending |

## Detailed test ideas

### HDL-001

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/001-wire.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/001-wire.sv)
- **Signals:** in, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-002

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/002-wire4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/002-wire4.sv)
- **Signals:** a, b, c, w, x, y, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-004

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/008-7458.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/008-7458.sv)
- **Signals:** p1a, p1b, p1c, p1d, p1e, p1f, p2a, p2b, p2c, p2d, p1y, p2y
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-010

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/014-vector3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/014-vector3.sv)
- **Signals:** a, b, c, d, e, f, w, x, y, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-014

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/005-norgate.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/005-norgate.sv)
- **Signals:** a, b, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-016

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/007-wire_decl.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/007-wire_decl.sv)
- **Signals:** a, b, c, d, out, out_n
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-018

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/018-module.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/018-module.sv)
- **Signals:** a, b, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-020

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/020-module_name.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/020-module_name.sv)
- **Signals:** a, b, c, d, out1, out2
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-022

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/022-module_shift8.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/022-module_shift8.sv)
- **Signals:** clk, d, sel, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-024

**Define and implement top_module, add1** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/024-module_fadd.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/024-module_fadd.sv)
- **Signals:** a, b, sum, cin, cout
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-025

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/025-module_cseladd.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/025-module_cseladd.sv)
- **Signals:** a, b, sum
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-028

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/028-alwaysblock2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/028-alwaysblock2.sv)
- **Signals:** clk, a, b, out_assign, out_always_comb, out_always_ff
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-029

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/029-always_if.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/029-always_if.sv)
- **Signals:** a, b, sel_b1, sel_b2, out_assign, out_always
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-032

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/032-always_case2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/032-always_case2.sv)
- **Signals:** in, pos
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-047

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/041-bcdadd100.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/041-bcdadd100.sv)
- **Signals:** a, b, cin, cout, sum
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-049

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/048-7420.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/048-7420.sv)
- **Signals:** p1a, p1b, p1c, p1d, p2a, p2b, p2c, p2d, p1y, p2y
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-050

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/049-truthtable1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/049-truthtable1.sv)
- **Signals:** x3, x2, x1, f
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-051

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/050-mt2015_eq2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/050-mt2015_eq2.sv)
- **Signals:** A, B, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-059

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/058-gatesv100.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/058-gatesv100.sv)
- **Signals:** in, out_both, out_any, out_different
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-060

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/059-mux2to1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/059-mux2to1.sv)
- **Signals:** a, b, sel, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-061

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/060-mux2to1v.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/060-mux2to1v.sv)
- **Signals:** a, b, sel, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-062

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/061-mux9to1v.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/061-mux9to1v.sv)
- **Signals:** a, b, c, d, e, f, g, h, i, sel, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-063

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/062-mux256to1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/062-mux256to1.sv)
- **Signals:** in, sel, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-073

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/073-kmap3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/073-kmap3.sv)
- **Signals:** a, b, c, d, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-078

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/078-exams__ece241_2014_q3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/078-exams__ece241_2014_q3.sv)
- **Signals:** c, d, mux_in
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-081

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/081-dff8r.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/081-dff8r.sv)
- **Signals:** clk, reset, d, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-092

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/092-exams__ece241_2013_q7.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/092-exams__ece241_2013_q7.sv)
- **Signals:** clk, j, k, Q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-095

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/095-edgecapture.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/095-edgecapture.sv)
- **Signals:** clk, reset, in, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-099

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/099-count1to10.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/099-count1to10.sv)
- **Signals:** clk, reset, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-101

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/101-shift4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/101-shift4.sv)
- **Signals:** clk, areset, load, ena, data, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-102

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/102-rotate100.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/102-rotate100.sv)
- **Signals:** clk, load, ena, data, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-106

**Define and implement top_module** · Implementation prerequisite · P0 · Blocked · Prerequisite

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/106-lfsr32.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/106-lfsr32.sv)
- **Signals:** clk, reset, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Complete the existing module/interface and write the intended port-level contract before attempting functional vectors. This plan does not implement it.
- **Expected result:** A named module elaborates with driven outputs and a defined function. Current source is empty or malformed, so functional pass criteria cannot be inferred safely.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** First resolve the documented missing implementation or contract. Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Existing stub; not a passing design.

### HDL-178

**Compile isolated tops and record reproducible evidence** · Build and evidence · P0 · Pending · Source review

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/003-notgate.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/003-notgate.sv)
- **Signals:** Top/module names and port declarations in the RTL map
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Choose one DUT/top and only its dependencies. Compile with warnings, set a bounded run time, and record simulator/version, source commit, parameters, seed and waveform/log path for every executed case.
- **Expected result:** No unresolved modules, conflicting definitions or unexplained width warnings. A clean compile or an old PASS print does not mark functional cases Done. Do not wildcard-compile all learning exercises together.
- **Coverage target:** Exercise every directed situation in this case, including the stated reset/boundary condition.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-179

**Twelve-hour rollovers and enable pause** · BCD clock · P0 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/146-count_clock.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/146-count_clock.sv)
- **Signals:** clk, reset, ena, pm, hh, mm, ss
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** After reset verify 12:00:00 AM. Run enough enabled edges to inspect 12:59:59->01:00:00 and 11:59:59->12:00:00. Pause ena for three edges immediately before each rollover, then resume.
- **Expected result:** Digits remain BCD, ss/mm wrap 59->00, hour 12->01 does not toggle pm, and hour 11->12 toggles pm. No state advances with ena=0. Observe outputs after NBA.
- **Coverage target:** Second/minute/hour cascades; AM/PM toggle; enable at rollover.
- **Stop rule:** One complete 24-hour cycle is 86,400 enabled edges; allow reset and explicit pause edges in the run budget.

### HDL-180

**All delay values and exact completion duration** · Programmable timer · P0 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/154-exams__review2015_fancytimer.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/154-exams__review2015_fancytimer.sv)
- **Signals:** clk, reset, data, ack, count, counting, done
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For each delay value 0..15, send prefix 1101 and then its four delay bits MSB first. Count only rising edges whose pre-edge counting=1; vary data while counting and keep ack=0.
- **Expected result:** counting lasts exactly (delay+1)*1000 clock periods from entry into COUNT to entry into WAIT. count decrements after each 1000-count block until zero. done then remains high until ack is sampled in WAIT; data changes do not reprogram the active interval.
- **Coverage target:** All 16 delay values; 999/1000 boundary; count zero; ignored data while busy.
- **Stop rule:** Per run, at most 16,020 clocks plus intentional wait-for-ack clocks.

### HDL-182

**All triples and consecutive windows** · Three-sample FSM · P0 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 10/155-exams__2014_q3fsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2010/155-exams__2014_q3fsm.sv)
- **Signals:** clk, reset, s, w, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** After reset, assert s for one edge to enter sampling. Apply all eight three-bit w triples on three successive edges each, with no gap or reset between triples. Repeat a nonmatching triple immediately before a matching triple.
- **Expected result:** z is high only after the third sample of a triple containing exactly two ones: 011,101,110. It is low on the first two samples. The sample and ones counters restart after EVERY triple, including a nonmatch.
- **Coverage target:** Eight triples; all three matching orders; match/nonmatch transition pairs.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-183

**Two enables target the same register** · Shift/count register · P0 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/148-exams__review2015_shiftcount.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/148-exams__review2015_shiftcount.sv)
- **Signals:** clk, shift_ena, count_ena, data, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize q by shifting four known bits with count_ena=0. At q=6, assert both enables with data=1; repeat at q=0. Also test each enable alone and neither.
- **Expected result:** In this source, the later count nonblocking assignment wins when both enables are high. Results are 6->5 and 0->15, not shifted values. Record this priority explicitly; if the exercise requires shift priority, this is a design mismatch.
- **Coverage target:** All four enable combinations; zero wrap; distinction between old-value count and shift.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-184

**Byte boundaries, error recovery and all payloads** · Serial receiver exercise · P0 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 12/163-fsm_serial.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2012/163-fsm_serial.sv)
- **Signals:** clk, reset, in, done
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For every byte 00..FF, send start 0, eight data bits LSB first, and stop 1, one serial bit per clk. Repeat with low stop and with consecutive frames. Reset during a partial frame.
- **Expected result:** A valid frame produces one done cycle. Low stop is rejected and recovery waits for an idle high. This exercise samples one bit per clock; do not apply UART 16x oversampling timing.
- **Coverage target:** 256 bytes; first/last data bit; bad stop; consecutive frames and reset abort.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-185

**Byte boundaries, error recovery and all payloads** · Serial receiver exercise · P0 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 12/164-fsm_serialdata.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2012/164-fsm_serialdata.sv)
- **Signals:** clk, reset, in, done, out_byte
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For every byte 00..FF, send start 0, eight data bits LSB first, and stop 1, one serial bit per clk. Repeat with low stop and with consecutive frames. Reset during a partial frame.
- **Expected result:** A valid frame produces one done cycle with out_byte equal to the accepted payload. Low stop is rejected and recovery waits for an idle high. This exercise samples one bit per clock; do not apply UART 16x oversampling timing.
- **Coverage target:** 256 bytes; first/last data bit; bad stop; consecutive frames and reset abort.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-186

**Byte boundaries, error recovery and all payloads** · Serial receiver exercise · P0 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/165-fsm_serialdp.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/165-fsm_serialdp.sv)
- **Signals:** clk, reset, in, done, out_byte
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For every byte 00..FF, send start 0, eight data bits LSB first, an odd-parity bit, and stop 1, one serial bit per clk. Repeat with low stop and with consecutive frames. Reset during a partial frame.
- **Expected result:** A valid frame produces one done cycle with out_byte equal to the accepted payload. Low stop is rejected and recovery waits for an idle high. Flip only the parity bit: done must not assert for an even total number of ones. This exercise samples one bit per clock; do not apply UART 16x oversampling timing.
- **Coverage target:** 256 bytes; first/last data bit; bad stop; good/bad odd parity; consecutive frames and reset abort.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-187

**Alignment marker only matters for the first byte** · Three-byte packet · P0 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/166-fsm_ps2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/166-fsm_ps2.sv)
- **Signals:** clk, reset, in, done
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Present several candidate first bytes with in[3]=0, then first byte 08, middle byte 00 and last byte FF hex. Repeat with middle/last bytes whose bit 3 is both zero and one, and with the next first byte immediately after completion.
- **Expected result:** A first byte is accepted only when its bit 3 is one. The next two bytes are collected regardless of their bit 3. done marks the third-byte completion; when out_bytes exists it is {first,middle,last}. Bit-3 noise in payload must not restart framing.
- **Coverage target:** Rejected alignment candidates; all four payload bit-3 combinations; adjacent packets.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-188

**Alignment marker only matters for the first byte** · Three-byte packet · P0 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/167-fsm_ps2data.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/167-fsm_ps2data.sv)
- **Signals:** clk, reset, in, done, out_bytes
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Present several candidate first bytes with in[3]=0, then first byte 08, middle byte 00 and last byte FF hex. Repeat with middle/last bytes whose bit 3 is both zero and one, and with the next first byte immediately after completion.
- **Expected result:** A first byte is accepted only when its bit 3 is one. The next two bytes are collected regardless of their bit 3. done marks the third-byte completion; when out_bytes exists it is {first,middle,last}. Bit-3 noise in payload must not restart framing.
- **Coverage target:** Rejected alignment candidates; all four payload bit-3 combinations; adjacent packets.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-003

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/003-notgate.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/003-notgate.sv)
- **Signals:** in, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-005

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/009-vector0.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/009-vector0.sv)
- **Signals:** vec, outv, o2, o1, o0
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive vec through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check outv, o2, o1, o0 against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: outv = vec; o2 = vec[2]; o1 = vec[1]; o0 = vec[0].
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-006

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/010-vector1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/010-vector1.sv)
- **Signals:** in, out_hi, out_lo
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_hi, out_lo against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_hi = in[15:8]; out_lo = in[7:0].
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-007

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/011-vector2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/011-vector2.sv)
- **Signals:** in, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = {d,c,b,a}.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-008

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/012-vectorgates.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/012-vectorgates.sv)
- **Signals:** a, b, out_or_bitwise, out_or_logical, out_not
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_or_bitwise, out_or_logical, out_not against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_or_bitwise = a |b; out_or_logical = a ||b; out_not = {~b,~a}.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-009

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/013-gates4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/013-gates4.sv)
- **Signals:** in, out_and, out_or, out_xor
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_and, out_or, out_xor against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_and = &in; out_or = |in; out_xor = ^in.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-011

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/015-vectorr.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/015-vectorr.sv)
- **Signals:** in, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out[i] = in[7-i].
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-012

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/016-vector4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/016-vector4.sv)
- **Signals:** in, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = {{24{in[7]}},in}.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-013

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/004-andgate.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/004-andgate.sv)
- **Signals:** a, b, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-015

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/006-xnorgate.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/006-xnorgate.sv)
- **Signals:** a, b, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = ~(a ^b).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-017

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/017-vector5.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/017-vector5.sv)
- **Signals:** a, b, c, d, e, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, c, d, e through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = ~(top ^ bottom).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-019

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/019-module_pos.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/019-module_pos.sv)
- **Signals:** a, b, c, d, out1, out2
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out1, out2 against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-021

**Direction, load and boundary bits** · Shift/rotate · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/021-module_shift.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/021-module_shift.sv)
- **Signals:** clk, d, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive clk, d with walking-one patterns at both ends; exercise every shift amount/direction and simultaneous load/enable controls.
- **Expected result:** q preserves the defined bit order and delay. Check zero-fill, sign-fill or rotation separately as specified by this source; load/hold priority and bits shifted out must match the contract.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-023

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/023-module_add.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/023-module_add.sv)
- **Signals:** a, b, sum
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check sum against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: sum = {sum2,sum1}.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-026

**Arithmetic, carry/borrow and width** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/026-module_addsub.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/026-module_addsub.sv)
- **Signals:** a, b, sub, sum
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise a, b, sub at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every sum bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: sum = {sumUpper,sumlower}.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-027

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/027-alwaysblock1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/027-alwaysblock1.sv)
- **Signals:** a, b, out_assign, out_alwaysblock
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_assign, out_alwaysblock against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_assign = a&b.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-030

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/030-always_if2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/030-always_if2.sv)
- **Signals:** cpu_overheated, arrived, gas_tank_empty, shut_off_computer, keep_driving
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive cpu_overheated, arrived, gas_tank_empty through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check shut_off_computer, keep_driving against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-031

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/031-always_case.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/031-always_case.sv)
- **Signals:** sel, data0, data1, data2, data3, data4, data5, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive sel, data0, data1, data2, data3, data4, data5 through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-033

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/033-always_casez.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/033-always_casez.sv)
- **Signals:** in, pos
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check pos against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-034

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/034-always_nolatches.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/034-always_nolatches.sv)
- **Signals:** scancode, left, down, right, up
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive scancode through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check left, down, right, up against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-035

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/035-conditional.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/035-conditional.sv)
- **Signals:** a, b, c, d, min
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check min against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: min = (minAB<minCD)?minAB:minCD.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-036

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/036-reduction.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/036-reduction.sv)
- **Signals:** in, parity
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check parity against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: parity = ^in.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-037

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/037-gates100.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/037-gates100.sv)
- **Signals:** in, out_and, out_or, out_xor
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_and, out_or, out_xor against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_and = &in; out_or = |in; out_xor = ^in.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-038

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/038-vector100r.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/038-vector100r.sv)
- **Signals:** in, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out[i] = in[99-i].
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-039

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/039-popcount255.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/039-popcount255.sv)
- **Signals:** in, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-040

**Arithmetic, carry/borrow and width** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/040-adder100i.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/040-adder100i.sv)
- **Signals:** a, b, cin, cout, sum
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every cout, sum bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: cout = carry[100:1].
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-041

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/042-exams__m2014_q4h.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/042-exams__m2014_q4h.sv)
- **Signals:** in, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = in.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-042

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/043-exams__m2014_q4i.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/043-exams__m2014_q4i.sv)
- **Signals:** out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive the declared controls through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = 1'b0.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-043

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/044-exams__m2014_q4e.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/044-exams__m2014_q4e.sv)
- **Signals:** in1, in2, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in1, in2 through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-044

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/045-exams__m2014_q4f.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/045-exams__m2014_q4f.sv)
- **Signals:** in1, in2, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in1, in2 through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-045

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/046-exams__m2014_q4g.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/046-exams__m2014_q4g.sv)
- **Signals:** in1, in2, in3, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in1, in2, in3 through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-046

**Arithmetic, carry/borrow and width** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/065-fadd.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/065-fadd.sv)
- **Signals:** a, b, cin, cout, sum
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every cout, sum bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different. 
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-048

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/047-gates.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/047-gates.sv)
- **Signals:** a, b, out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_and = a&b; out_or = a|b; out_xor = a^b; out_nand = ~(a&b); out_nor = ~(a|b); out_xnor = ~(a^b); out_anotb = a & ~(b).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-052

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/051-mt2015_q4a.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/051-mt2015_q4a.sv)
- **Signals:** x, y, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive x, y through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check z against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-053

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/052-mt2015_q4b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/052-mt2015_q4b.sv)
- **Signals:** x, y, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive x, y through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check z against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-054

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/053-mt2015_q4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/053-mt2015_q4.sv)
- **Signals:** x, y, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive x, y through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check z against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: z = (x ^ y) & x; z = ~(x ^ y).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-055

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/054-ringer.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/054-ringer.sv)
- **Signals:** ring, vibrate_mode, ringer, motor
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive ring, vibrate_mode through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check ringer, motor against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: ringer = ring & ~vibrate_mode; motor = ring & vibrate_mode.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-056

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/055-thermostat.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/055-thermostat.sv)
- **Signals:** too_cold, too_hot, mode, fan_on, heater, aircon, fan
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive too_cold, too_hot, mode, fan_on through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check heater, aircon, fan against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: heater = mode & too_cold; aircon = ~mode & too_hot; fan = fan_on | heater | aircon.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-057

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/056-popcount3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/056-popcount3.sv)
- **Signals:** in, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-058

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/057-gatesv.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/057-gatesv.sv)
- **Signals:** in, out_both, out_any, out_different
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_both, out_any, out_different against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_both = in[3:1] & in[2:0]; out_any = in[3:1] | in[2:0]; out_different = in^ {in[0],in[3:1]}.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-064

**Every select and unselected-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/063-mux256to1v.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/063-mux256to1v.sv)
- **Signals:** in, sel, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** out equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings. Source mapping: out = in[sel*4+:4].
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-065

**Arithmetic, carry/borrow and width** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/064-hadd.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/064-hadd.sv)
- **Signals:** a, b, cout, sum
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise a, b at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every cout, sum bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: cout = a &b; sum = a^b.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-066

**Arithmetic, carry/borrow and width** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/066-adder3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/066-adder3.sv)
- **Signals:** a, b, cin, cout, sum
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every cout, sum bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: cout = carry[3:1]; sum = a^b^cin; cout = a&b | b&cin | a &cin.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-067

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/067-exams__m2014_q4j.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/067-exams__m2014_q4j.sv)
- **Signals:** x, y, sum, a, b, cin, cout
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive x, y through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check sum against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: sum[4] = carry[4]; sum = a^b^cin.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-068

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/068-exams__ece241_2014_q1c.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/068-exams__ece241_2014_q1c.sv)
- **Signals:** a, b, s, overflow
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check s, overflow against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: s = a+b; overflow = (a[7]==b[7]) && (a[7] != s[7]).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-069

**Arithmetic, carry/borrow and width** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/069-adder100.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/069-adder100.sv)
- **Signals:** a, b, cin, cout, sum
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise a, b, cin at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every cout, sum bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different.  Source mapping: cout = carry [100]; sum = a^b^cin; cout = a&b | b&cin| a&cin.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-070

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/070-bcdadd4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/070-bcdadd4.sv)
- **Signals:** a, b, cin, cout, sum
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, cin through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check cout, sum against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: cout = carry [4].
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-071

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/071-kmap1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/071-kmap1.sv)
- **Signals:** a, b, c, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, c through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = a | b | c.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-072

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/072-kmap2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/072-kmap2.sv)
- **Signals:** a, b, c, d, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = c & d & (a | b ) | ~b & ~c | ~a & ~ d.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-074

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/074-kmap4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/074-kmap4.sv)
- **Signals:** a, b, c, d, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = w1 & w2 & (a ^b) | w1 & d & ~(a ^ b ) | c & d & (a ^b)| c & w2 & ~(a ^ b).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-075

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/075-exams__ece241_2013_q2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/075-exams__ece241_2013_q2.sv)
- **Signals:** a, b, c, d, out_sop, out_pos
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out_sop, out_pos against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out_sop = ~a & ~b & c & (d | ~d) | (a | ~a ) & (b | ~b ) & c&d; out_pos = c & (b | ~a) & (d | ~b).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-076

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/076-exams__m2014_q3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/076-exams__m2014_q3.sv)
- **Signals:** x, f
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive x through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check f against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: f = x[4] & x[2] | x[3] & ~x[1].
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-077

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/077-exams__2012_q1g.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/077-exams__2012_q1g.sv)
- **Signals:** x, f
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive x through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check f against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: f = ~x[1] & x[3] | ~x[2] & ~x[4] | x[3] & x[4] & x[2].
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-079

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/079-dff.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/079-dff.sv)
- **Signals:** clk, d, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-080

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/080-dff8.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/080-dff8.sv)
- **Signals:** clk, d, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-082

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/082-dff8p.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/082-dff8p.sv)
- **Signals:** clk, reset, d, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: negedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-083

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/083-dff8ar.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/083-dff8ar.sv)
- **Signals:** clk, areset, d, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge areset.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-084

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/084-dff16e.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/084-dff16e.sv)
- **Signals:** clk, resetn, byteena, d, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary byteena, d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-085

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/085-exams__m2014_q4a.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/085-exams__m2014_q4a.sv)
- **Signals:** d, ena, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive d, ena through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check q against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-086

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/086-exams__m2014_q4b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/086-exams__m2014_q4b.sv)
- **Signals:** clk, d, ar, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary d, ar before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge ar.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-087

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/087-exams__m2014_q4c.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/087-exams__m2014_q4c.sv)
- **Signals:** clk, d, r, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary d, r before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-088

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/088-exams__m2014_q4d.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/088-exams__m2014_q4d.sv)
- **Signals:** clk, in, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-089

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/089-mt2015_muxdff.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/089-mt2015_muxdff.sv)
- **Signals:** clk, L, r_in, q_in, Q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary L, r_in, q_in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check Q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-090

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/090-exams__2014_q4a.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/090-exams__2014_q4a.sv)
- **Signals:** clk, w, R, E, L, Q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary w, R, E, L before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check Q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-091

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/091-exams__ece241_2014_q4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/091-exams__ece241_2014_q4.sv)
- **Signals:** clk, x, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: z = ~(q1 | q2 | q3).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-093

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/093-edgedetect.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/093-edgedetect.sv)
- **Signals:** clk, in, pedge
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check pedge only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-094

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/094-edgedetect2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/094-edgedetect2.sv)
- **Signals:** clk, in, anyedge
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check anyedge only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-096

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/096-dualedge.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/096-dualedge.sv)
- **Signals:** clk, d, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary d before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, negedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: q = (clk) ? pos:neg.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-097

**Reset, rollover and control priority** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/097-count15.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/097-count15.sv)
- **Signals:** clk, reset, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize top_module; test every enable/load/direction combination in clk, reset. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** q follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs. Source mapping: q = count.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-098

**Reset, rollover and control priority** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/098-count10.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/098-count10.sv)
- **Signals:** clk, reset, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize top_module; test every enable/load/direction combination in clk, reset. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** q follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs. Source mapping: q = count.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-100

**Reset, rollover and control priority** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/100-countslow.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/100-countslow.sv)
- **Signals:** clk, slowena, reset, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize top_module; test every enable/load/direction combination in clk, slowena, reset. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** q follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs. Source mapping: q = count.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-103

**Direction, load and boundary bits** · Shift/rotate · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/103-shift18.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/103-shift18.sv)
- **Signals:** clk, load, ena, amount, data, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive clk, load, ena, amount, data with walking-one patterns at both ends; exercise every shift amount/direction and simultaneous load/enable controls.
- **Expected result:** q preserves the defined bit order and delay. Check zero-fill, sign-fill or rotation separately as specified by this source; load/hold priority and bits shifted out must match the contract.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-104

**Seed, recurrence and repeat period** · LFSR · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/104-lfsr5.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/104-lfsr5.sv)
- **Signals:** clk, reset, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset/load the documented nonzero seed; record q for a complete small-width sequence and repeat after reset. Also test enable holds if present and the zero-seed behavior.
- **Expected result:** The sequence follows the declared tap polynomial and shift direction. A claimed maximal n-bit LFSR visits 2^n-1 distinct nonzero states before repeating; measure the actual period rather than assuming it. Fibonacci and Galois forms need not be bit-for-bit identical.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-105

**Seed, recurrence and repeat period** · LFSR · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/105-mt2015_lfsr.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/105-mt2015_lfsr.sv)
- **Signals:** SW, KEY, LEDR
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Reset/load the documented nonzero seed; record LEDR for a complete small-width sequence and repeat after reset. Also test enable holds if present and the zero-seed behavior.
- **Expected result:** The sequence follows the declared tap polynomial and shift direction. A claimed maximal n-bit LFSR visits 2^n-1 distinct nonzero states before repeating; measure the actual period rather than assuming it. Fibonacci and Galois forms need not be bit-for-bit identical. Source mapping: LEDR = {q2,q1,q0}.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-107

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/107-exams__m2014_q4k.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/107-exams__m2014_q4k.sv)
- **Signals:** clk, resetn, in, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: out = q4.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-108

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/108-exams__2014_q4b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/108-exams__2014_q4b.sv)
- **Signals:** SW, KEY, LEDR, clk, w, R, E, L, Q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, MUXDFF, initialize through its reset/load path, then vary SW, KEY before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check LEDR only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-109

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/109-exams__ece241_2013_q12.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/109-exams__ece241_2013_q12.sv)
- **Signals:** clk, enable, S, A, B, C, Z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary enable, S, A, B, C before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check Z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-110

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/110-fsm1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/110-fsm1.sv)
- **Signals:** clk, areset, in, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge areset.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: out = (state == A).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-111

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/111-fsm1s.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/111-fsm1s.sv)
- **Signals:** clk, reset, in, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: out = (present_state == B).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-112

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/112-fsm2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/112-fsm2.sv)
- **Signals:** clk, areset, j, k, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary j, k before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge areset.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: out = (state == ON).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-113

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/113-fsm2s.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/113-fsm2s.sv)
- **Signals:** clk, reset, j, k, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary j, k before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: out = (state == ON).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-114

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/114-fsm3comb.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/114-fsm3comb.sv)
- **Signals:** in, state, next_state, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in, state through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check next_state, out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: out = (state==D).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-115

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/115-fsm3onehot.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/115-fsm3onehot.sv)
- **Signals:** in, state, next_state, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in, state through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check next_state, out against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: next_state[A] = ~in & (state[A] | state[C]); next_state[B] = in & (state[A] | state[B] | state[D]); next_state[C] = ~in & (state[B] | state[D]); next_state[D] = in & state[C]; out = state[D].
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-116

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/116-fsm3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/116-fsm3.sv)
- **Signals:** clk, in, areset, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge areset.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: out = (state == D).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-117

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/117-fsm3s.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/117-fsm3s.sv)
- **Signals:** clk, in, reset, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary in before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check out only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: out = (state == D).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-118

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/118-exams__ece241_2013_q4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/118-exams__ece241_2013_q4.sv)
- **Signals:** clk, reset, s, fr3, fr2, fr1, dfr
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary s before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check fr3, fr2, fr1, dfr only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-119

**Direction, priority and fall boundaries** · Lemmings FSM · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/119-lemmings1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/119-lemmings1.sv)
- **Signals:** clk, areset, bump_left, bump_right, walk_left, walk_right
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise clk, areset, bump_left, bump_right, walk_left, walk_right: both bumpers, every direction, loss/restoration of ground, digging where present, and reset from every behavior. In lemmings4 use falls of 19,20,21 and more than 32 clocks, including after digging.
- **Expected result:** Reset walks left. Only the bumper in the current direction turns walking. Falling overrides walking; digging has its specified priority. Check mutually exclusive outputs, landing direction and the fatal-fall threshold without counter wrap resurrecting the character. Source mapping: walk_left = (state == left); walk_right = (state == right).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-120

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/121-exams__2013_q2bfsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/121-exams__2013_q2bfsm.sv)
- **Signals:** clk, resetn, x, y, f, g
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary x, y before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check f, g only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: f = (state == B); g = (state == F) || (state == G) || (state == H).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-121

**Every select and unselected-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/122-bugs_mux2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/122-bugs_mux2.sv)
- **Signals:** sel, a, b, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** out equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings. Source mapping: out = sel ? a : b.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-122

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/123-bugs_nand3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/123-bugs_nand3.sv)
- **Signals:** a, b, c, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, c through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-123

**Every select and unselected-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/124-bugs_mux4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/124-bugs_mux4.sv)
- **Signals:** sel, a, b, c, d, out
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Sweep sel through all encodings; set data inputs to distinguishable patterns, then toggle only unselected inputs.
- **Expected result:** out equals the selected input. Exercise selected values 0 and 1 and vector extremes. Unselected changes do not affect the result; verify the default mapping for unused encodings.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-124

**Arithmetic, carry/borrow and width** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/125-bugs_addsubz.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/125-bugs_addsubz.sv)
- **Signals:** do_sub, a, b, out, result_is_zero
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise do_sub, a, b at zero, one, maximum, alternating patterns and long carry/borrow chains. Exhaust all combinations for small widths; include both carry-in/subtract settings when present.
- **Expected result:** Compute the integer arithmetic independently, then apply the declared result width. Check every out, result_is_zero bit including carry, borrow or signed overflow where exposed. Carry-out and signed overflow are different. 
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-125

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/126-bugs_case.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/126-bugs_case.sv)
- **Signals:** code, out, valid
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive code through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check out, valid against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-126

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/127-sim__circuit1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/127-sim__circuit1.sv)
- **Signals:** a, b, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check q against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: q = a & b.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-127

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/128-sim__circuit2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/128-sim__circuit2.sv)
- **Signals:** a, b, c, d, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check q against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: q = ~(a ^ b ^ c ^ d).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-128

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/129-sim__circuit3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/129-sim__circuit3.sv)
- **Signals:** a, b, c, d, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check q against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: q = (d & (a | b)) | (c & (a | b)).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-129

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/130-sim__circuit4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/130-sim__circuit4.sv)
- **Signals:** a, b, c, d, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, c, d through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check q against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: q = b | c.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-130

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/131-sim__circuit5.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/131-sim__circuit5.sv)
- **Signals:** a, b, c, d, e, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a, b, c, d, e through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check q against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-131

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/132-sim__circuit6.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/132-sim__circuit6.sv)
- **Signals:** a, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive a through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check q against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-132

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/133-sim__circuit7.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/133-sim__circuit7.sv)
- **Signals:** clk, a, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary a before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-133

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/134-sim__circuit8.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/134-sim__circuit8.sv)
- **Signals:** clock, a, p, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary a before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: negedge clock.
- **Expected result:** Check p, q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-134

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/135-sim__circuit9.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/135-sim__circuit9.sv)
- **Signals:** clk, a, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary a before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: q = count.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-135

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/136-sim__circuit10.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/136-sim__circuit10.sv)
- **Signals:** clk, a, b, q, state
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary a, b before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check q, state only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: q = a ^ b ^ state.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-136

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/138-tb__tb1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/138-tb__tb1.sv)
- **Signals:** A, B
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive the declared controls through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check A, B against an independently written truth table. Combinational results must settle without a clock or stale retained values.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-137

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 07/142-exams__ece241_2013_q8.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2007/142-exams__ece241_2013_q8.sv)
- **Signals:** clk, aresetn, x, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, negedge aresetn.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: z = (state == S10) && x.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-138

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 08/143-exams__ece241_2014_q7a.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2008/143-exams__ece241_2014_q7a.sv)
- **Signals:** clk, reset, enable, Q, c_enable, c_load, c_d
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary enable before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: inspect the instantiated modules for clock edge and reset polarity.
- **Expected result:** Check Q, c_enable, c_load, c_d only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: c_enable = enable; c_load = reset | (enable & (Q == 4'd12)); c_d = 4'd1.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-139

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/144-exams__ece241_2014_q7b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/144-exams__ece241_2014_q7b.sv)
- **Signals:** clk, reset, OneHertz, c_enable
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary available controls before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: inspect the instantiated modules for clock edge and reset polarity.
- **Expected result:** Check OneHertz, c_enable only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: c_enable[0] = 1'b1; c_enable[1] = (lsb == 4'd9); c_enable[2] = (lsb == 4'd9) && (middle == 4'd9); OneHertz = (msb == 4'd9) && (middle == 4'd9) && (lsb == 4'd9).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-140

**Reset, rollover and control priority** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/145-countbcd.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/145-countbcd.sv)
- **Signals:** clk, reset, ena, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize top_module; test every enable/load/direction combination in clk, reset. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** ena, q follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs. Source mapping: ena[1] = (digit0 == 4'd9); ena[2] = (digit0 == 4'd9) && (digit1 == 4'd9); ena[3] = (digit0 == 4'd9) && (digit1 == 4'd9) && (digit2 == 4'd9); q = {digit3, digit2, digit1, digit0}.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-141

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/146-count_clock.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/146-count_clock.sv)
- **Signals:** clk, reset, ena, pm, hh, mm, ss
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary ena before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check pm, hh, mm, ss only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-142

**Reset, rollover and control priority** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/147-exams__review2015_count1k.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/147-exams__review2015_count1k.sv)
- **Signals:** clk, reset, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Initialize top_module; test every enable/load/direction combination in clk, reset. Run past both wrap boundaries and reassert reset away from and on active clock edges.
- **Expected result:** q follows the stated binary/BCD/modulo range and reset value. Count accepted enabled edges only, verify hold when specified, and check load versus count priority. A source without enable free-runs. Source mapping: q = count.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-143

**Direction, load and boundary bits** · Shift/rotate · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/148-exams__review2015_shiftcount.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/148-exams__review2015_shiftcount.sv)
- **Signals:** clk, shift_ena, count_ena, data, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive clk, shift_ena, count_ena, data with walking-one patterns at both ends; exercise every shift amount/direction and simultaneous load/enable controls.
- **Expected result:** q preserves the defined bit order and delay. Check zero-fill, sign-fill or rotation separately as specified by this source; load/hold priority and bits shifted out must match the contract. Source mapping: q = shift_count.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-144

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/149-exams__review2015_fsmseq.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/149-exams__review2015_fsmseq.sv)
- **Signals:** clk, reset, data, start_shifting
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary data before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check start_shifting only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: start_shifting = (state == DONE).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-145

**Direction, load and boundary bits** · Shift/rotate · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/150-exams__review2015_fsmshift.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/150-exams__review2015_fsmshift.sv)
- **Signals:** clk, reset, shift_ena
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive clk, reset with walking-one patterns at both ends; exercise every shift amount/direction and simultaneous load/enable controls.
- **Expected result:** shift_ena preserves the defined bit order and delay. Check zero-fill, sign-fill or rotation separately as specified by this source; load/hold priority and bits shifted out must match the contract. Source mapping: shift_ena = (count < 3'd4).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-146

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/151-step_one.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/151-step_one.sv)
- **Signals:** one
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive the declared controls through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check one against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: one = 1'b1.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-147

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/152-zero.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/152-zero.sv)
- **Signals:** zero
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive the declared controls through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check zero against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: zero = 1'b0.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-148

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/153-exams__review2015_fsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/153-exams__review2015_fsm.sv)
- **Signals:** clk, reset, data, done_counting, ack, shift_ena, counting, done
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary data, done_counting, ack before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check shift_ena, counting, done only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: shift_ena = (state == B0) || (state == B1) || (state == B2) || (state == B3); counting = (state == COUNT); done = (state == WAIT).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-149

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/154-exams__review2015_fancytimer.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/154-exams__review2015_fancytimer.sv)
- **Signals:** clk, reset, data, ack, count, counting, done
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary data, ack before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check count, counting, done only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: count = count_remaining; counting = (state == COUNT); done = (state == WAIT).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-150

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 10/155-exams__2014_q3fsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2010/155-exams__2014_q3fsm.sv)
- **Signals:** clk, reset, s, w, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary s, w before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-151

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 10/156-exams__2014_q3bfsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2010/156-exams__2014_q3bfsm.sv)
- **Signals:** clk, reset, x, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: z = (state == S3) || (state == S4).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-152

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 10/157-exams__2014_q3c.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2010/157-exams__2014_q3c.sv)
- **Signals:** clk, y, x, Y0, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary y, x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: inspect the instantiated modules for clock edge and reset polarity.
- **Expected result:** Check Y0, z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: Y0 = (~x & (y[0] | y[2])) | ( x & ~y[0] & ~y[2]); z = (y == 3'b011) || (y == 3'b100).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-153

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 10/158-exams__m2014_q6c.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2010/158-exams__m2014_q6c.sv)
- **Signals:** y, w, Y2, Y4
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive y, w through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check Y2, Y4 against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: Y2 = y[1] & ~w; Y4 = w & (y[2] | y[3] | y[5] | y[6]).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-154

**Direction, priority and fall boundaries** · Lemmings FSM · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 11/159-lemmings2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2011/159-lemmings2.sv)
- **Signals:** clk, areset, bump_left, bump_right, ground, walk_left, walk_right, aaah
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise clk, areset, bump_left, bump_right, ground, walk_left, walk_right, aaah: both bumpers, every direction, loss/restoration of ground, digging where present, and reset from every behavior. In lemmings4 use falls of 19,20,21 and more than 32 clocks, including after digging.
- **Expected result:** Reset walks left. Only the bumper in the current direction turns walking. Falling overrides walking; digging has its specified priority. Check mutually exclusive outputs, landing direction and the fatal-fall threshold without counter wrap resurrecting the character. Source mapping: walk_left = (state == left); walk_right = (state == right); aaah = (state == fallRight) || (state == fallLeft).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-155

**Direction, priority and fall boundaries** · Lemmings FSM · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 11/160-lemmings3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2011/160-lemmings3.sv)
- **Signals:** clk, areset, bump_left, bump_right, ground, dig, walk_left, walk_right, aaah, digging
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise clk, areset, bump_left, bump_right, ground, dig, walk_left, walk_right, aaah, digging: both bumpers, every direction, loss/restoration of ground, digging where present, and reset from every behavior. In lemmings4 use falls of 19,20,21 and more than 32 clocks, including after digging.
- **Expected result:** Reset walks left. Only the bumper in the current direction turns walking. Falling overrides walking; digging has its specified priority. Check mutually exclusive outputs, landing direction and the fatal-fall threshold without counter wrap resurrecting the character. Source mapping: walk_left = (state == left); walk_right = (state == right); aaah = (state == digWorkFallLeft) || (state == digWorkFallRight) || (state == fallRight) || (state == fallLeft); digging = (state == digWorkFromLeft) || (state == digWorkFromRight).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-156

**Direction, priority and fall boundaries** · Lemmings FSM · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 12/161-lemmings4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2012/161-lemmings4.sv)
- **Signals:** clk, areset, bump_left, bump_right, ground, dig, walk_left, walk_right, aaah, digging
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Exercise clk, areset, bump_left, bump_right, ground, dig, walk_left, walk_right, aaah, digging: both bumpers, every direction, loss/restoration of ground, digging where present, and reset from every behavior. In lemmings4 use falls of 19,20,21 and more than 32 clocks, including after digging.
- **Expected result:** Reset walks left. Only the bumper in the current direction turns walking. Falling overrides walking; digging has its specified priority. Check mutually exclusive outputs, landing direction and the fatal-fall threshold without counter wrap resurrecting the character. Source mapping: walk_left = (state == left); walk_right = (state == right); aaah = (state == digWorkFallLeft) || (state == digWorkFallRight) || (state == fallRight) || (state == fallLeft); digging = (state == digWorkFromLeft) || (state == digWorkFromRight).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-157

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 12/162-fsm_onehot.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2012/162-fsm_onehot.sv)
- **Signals:** in, state, next_state, out1, out2
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive in, state through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check next_state, out1, out2 against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: next_state[0] = ~in & (S0 | S1 | S2 | S3 | S4 | S7 | S8 | S9); next_state[1] = in & (S0 | S8 | S9); next_state[2] = in & S1; next_state[3] = in & S2; next_state[4] = in & S3; next_state[5] = in & S4; next_state[6] = in & S5; next_state[7] = in & (S6 | S7); next_state[8] = ~in & S5; next_state[9] = ~in & S6; out1 = S8 | S9; out2 = S7 | S9.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-158

**Frames, byte order and recovery** · Serial receiver exercise · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 12/163-fsm_serial.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2012/163-fsm_serial.sv)
- **Signals:** clk, in, reset, done
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use clk, in, reset, done to send start 0, eight LSB-first data bits, and stop 1, then a bad stop and back-to-back frames. For the parity variant include good/bad odd parity.
- **Expected result:** done is asserted only for a complete accepted frame; out_byte, where present, equals the eight data bits. Bad stop requires idle-high recovery. A parity mismatch must suppress done in the parity variant. Source mapping: done = (state == completed).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-159

**Frames, byte order and recovery** · Serial receiver exercise · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 12/164-fsm_serialdata.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2012/164-fsm_serialdata.sv)
- **Signals:** clk, in, reset, out_byte, done
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use clk, in, reset, out_byte, done to send start 0, eight LSB-first data bits, and stop 1, then a bad stop and back-to-back frames. For the parity variant include good/bad odd parity.
- **Expected result:** done is asserted only for a complete accepted frame; out_byte, where present, equals the eight data bits. Bad stop requires idle-high recovery. A parity mismatch must suppress done in the parity variant. Source mapping: done = (state == completed); out_byte = latch.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-160

**Frames, byte order and recovery** · Serial receiver exercise · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/165-fsm_serialdp.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/165-fsm_serialdp.sv)
- **Signals:** clk, in, reset, out_byte, done
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Use clk, in, reset, out_byte, done to send start 0, eight LSB-first data bits, and stop 1, then a bad stop and back-to-back frames. For the parity variant include good/bad odd parity.
- **Expected result:** done is asserted only for a complete accepted frame; out_byte, where present, equals the eight data bits. Bad stop requires idle-high recovery. A parity mismatch must suppress done in the parity variant. Source mapping: done = (state == completed); out_byte = latch.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-161

**Header alignment and byte assembly** · Three-byte packet · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/166-fsm_ps2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/166-fsm_ps2.sv)
- **Signals:** clk, in, reset, done
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive clk, in, reset, done; send nonheader bytes with in[3]=0, then three-byte packets beginning with in[3]=1. Vary bit 3 in payload bytes and send packets back-to-back.
- **Expected result:** done occurs once per accepted three-byte packet. The data variant assembles first byte at [23:16], second [15:8], third [7:0] and outputs zero outside done. Payload bit 3 does not restart a packet. Source mapping: done = (state == donee).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-162

**Header alignment and byte assembly** · Three-byte packet · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/167-fsm_ps2data.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/167-fsm_ps2data.sv)
- **Signals:** clk, in, reset, out_bytes, done
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive clk, in, reset, out_bytes, done; send nonheader bytes with in[3]=0, then three-byte packets beginning with in[3]=1. Vary bit 3 in payload bytes and send packets back-to-back.
- **Expected result:** done occurs once per accepted three-byte packet. The data variant assembles first byte at [23:16], second [15:8], third [7:0] and outputs zero outside done. Payload bit 3 does not restart a packet. Source mapping: done = (state == donee); out_bytes = done ? latching : 24'd0.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-163

**Stuffed zero, flag and error boundaries** · Serial run-length detector · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/168-fsm_hdlc.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/168-fsm_hdlc.sv)
- **Signals:** clk, reset, in, disc, flag, err
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Using clk, reset, in, disc, flag, err, send runs of four, five, six, seven and eight ones followed by zero, separated by idle zeros and reset.
- **Expected result:** A zero after five ones raises disc; a zero after six raises flag; seven consecutive ones enter err, which holds while ones continue. Check the documented Mealy/Moore timing independently for each variant. Source mapping: disc = (state == discc); flag = (state == flagg); err = (state == errr).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-164

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/169-exams__ece241_2014_q5a.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/169-exams__ece241_2014_q5a.sv)
- **Signals:** clk, areset, x, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge areset.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: z = (state == s1).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-165

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/170-exams__ece241_2014_q5b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/170-exams__ece241_2014_q5b.sv)
- **Signals:** clk, areset, x, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary x before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk, posedge areset.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: z = zr.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-166

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/171-exams__m2014_q6b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/171-exams__m2014_q6b.sv)
- **Signals:** y, w, Y2
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive y, w through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check Y2 against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: Y2 = ((~y[2] & y[1]) | (w & y[3]) | (w & y[2] & ~y[1])).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-167

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/172-exams__m2014_q6.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/172-exams__m2014_q6.sv)
- **Signals:** clk, reset, w, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary w before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: z = (state == E) || (state == F).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-168

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/173-exams__2012_q2fsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/173-exams__2012_q2fsm.sv)
- **Signals:** clk, reset, w, z
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary w before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check z only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: z = (state == E) || (state == F).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-169

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/174-exams__2012_q2b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/174-exams__2012_q2b.sv)
- **Signals:** y, w, Y1, Y3
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive y, w through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check Y1, Y3 against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: Y3 = ~w & (y[1] | y[2] | y[4] | y[5]); Y1 = w & y[0].
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-170

**Load, edge cells and simultaneous update** · Cellular automaton · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 14/175-rule90.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2014/175-rule90.sv)
- **Signals:** clk, load, data, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Load data with a single central one, ones at both ends and alternating bits; step clk and check every q bit against a previous-array reference.
- **Expected result:** Rule 90 uses XOR of old left/right neighbors; outside the 512-cell ends is zero. load takes priority.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-171

**Load, edge cells and simultaneous update** · Cellular automaton · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 14/176-rule110.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2014/176-rule110.sv)
- **Signals:** clk, load, data, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Load data with a single central one, ones at both ends and alternating bits; step clk and check every q bit against a previous-array reference.
- **Expected result:** Rule 110 output for neighborhoods 111..000 is 0,1,1,0,1,1,1,0; outside neighbors are zero. All cells use the old array and load takes priority.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-172

**Reset, control priority and cycle behavior** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 14/177-exams__2013_q2afsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2014/177-exams__2013_q2afsm.sv)
- **Signals:** clk, resetn, r, g
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** For top_module, initialize through its reset/load path, then vary r before active edges. Cover each control combination, holds, boundary transitions and reset during activity. Clock/reset events in this source: posedge clk.
- **Expected result:** Check g only at its defined valid time. Compare a cycle-by-cycle reference state/sequence, including reset polarity and priority. Sample registered results after nonblocking updates; combinational Mealy outputs may require a pre-edge check. Source mapping: g[1] = (state == s1); g[2] = (state == s2); g[3] = (state == s3).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-173

**Input combinations and output mapping** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 14/178-exams__review2015_fsmonehot.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2014/178-exams__review2015_fsmonehot.sv)
- **Signals:** d, done_counting, ack, state, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Drive d, done_counting, ack, state through binary combinations when small; for vectors use zero, all ones, alternating bits and walking one/zero. Toggle one input at a time and include rapid changes after a previous nonzero result.
- **Expected result:** Check B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena against an independently written truth table. Combinational results must settle without a clock or stale retained values. Source mapping: B3_next = state[B2]; S_next = (state[S] & ~d) | (state[S1] & ~d) | (state[S110] & ~d) | (state[Wait] & ack); S1_next = state[S] & d; Count_next = state[B3] | (state[Count] & ~done_counting); Wait_next = (state[Count] & done_counting) | (state[Wait] & ~ack); done = state[Wait]; counting = state[Count]; shift_ena = state[B0] | state[B1] | state[B2] | state[B3].
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-174

**Still life, oscillator and toroidal edges** · Game of Life · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 14/179-conwaylife.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2014/179-conwaylife.sv)
- **Signals:** clk, load, data, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Load data with an empty board, a 2x2 block, a blinker and a pattern crossing row/column 15-to-0. Step clk and compare all 256 q bits.
- **Expected result:** Each cell survives with two or three live neighbors; a dead cell is born with three. Neighbors wrap on the 16x16 torus, and every next cell is calculated from the same prior board.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-175

**Stuffed zero, flag and error boundaries** · Serial run-length detector · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 2/internal/Discussion Drafts/fsm_hdlc_discussion.v](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%202/internal/Discussion%20Drafts/fsm_hdlc_discussion.v)
- **Signals:** clk, reset, in, disc, flag, err
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Using clk, reset, in, disc, flag, err, send runs of four, five, six, seven and eight ones followed by zero, separated by idle zeros and reset.
- **Expected result:** A zero after five ones raises disc; a zero after six raises flag; seven consecutive ones enter err, which holds while ones continue. Check the documented Mealy/Moore timing independently for each variant. Source mapping: disc = discReg; flag = flagReg; err = errReg.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-176

**Stuffed zero, flag and error boundaries** · Serial run-length detector · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 2/internal/Discussion Drafts/fsm_hdlc_working_moore.v](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%202/internal/Discussion%20Drafts/fsm_hdlc_working_moore.v)
- **Signals:** clk, reset, in, disc, flag, err
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Using clk, reset, in, disc, flag, err, send runs of four, five, six, seven and eight ones followed by zero, separated by idle zeros and reset.
- **Expected result:** A zero after five ones raises disc; a zero after six raises flag; seven consecutive ones enter err, which holds while ones continue. Check the documented Mealy/Moore timing independently for each variant. Source mapping: disc = (state == discardedFinal); flag = (state == flaggedFinal); err = (state == errorFound).
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-177

**Still life, oscillator and toroidal edges** · Game of Life · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 2/internal/Documentation/conway_reference.v](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%202/internal/Documentation/conway_reference.v)
- **Signals:** clk, load, data, q
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Load data with an empty board, a 2x2 block, a blinker and a pattern crossing row/column 15-to-0. Step clk and compare all 256 q bits.
- **Expected result:** Each cell survives with two or three live neighbors; a dead cell is born with three. Neighbors wrap on the 16x16 torus, and every next cell is calculated from the same prior board.
- **Coverage target:** Exercise every directed situation in this case, including the stated data and control alternatives.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.
- **Review note:** Compile this exercise separately because many files declare top_module. Use the original exercise statement as an independent oracle; helper stubs establish elaboration only.

### HDL-181

**Acknowledge priority and reset during each phase** · Programmable timer · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/154-exams__review2015_fancytimer.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/154-exams__review2015_fancytimer.sv)
- **Signals:** clk, reset, data, ack, count, counting, done
- **Setup:** Build the listed RTL in isolation, with source revision fc3f2b993a1e. Use the source-defined port widths and reset/clock behavior; initialize all observations that require known data.
- **Drive / observe:** Assert ack early during detection, delay shifting and counting, then deassert it before WAIT. Separately reset in each phase and in WAIT. Start a fresh delay-zero transaction after each reset.
- **Expected result:** Early ack is ignored outside WAIT. In WAIT, an asserted ack returns to prefix detection on the next edge. reset cancels progress and clears count/done; the next complete prefix and delay are required.
- **Coverage target:** Early/late/held ack; reset in prefix, load, count and done.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-189

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/009-vector0.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/009-vector0.sv)
- **Signals:** vec, outv, o2, o1, o0
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For vec, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For outv, o2, o1, o0, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-190

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/010-vector1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/010-vector1.sv)
- **Signals:** in, out_hi, out_lo
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out_hi, out_lo, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-191

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/011-vector2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/011-vector2.sv)
- **Signals:** in, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-192

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/012-vectorgates.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/012-vectorgates.sv)
- **Signals:** a, b, out_or_bitwise, out_or_logical, out_not
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out_or_bitwise, out_or_logical, out_not, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-193

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/013-gates4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/013-gates4.sv)
- **Signals:** in, out_and, out_or, out_xor
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out_and, out_or, out_xor, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-194

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/015-vectorr.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/015-vectorr.sv)
- **Signals:** in, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-195

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 01/016-vector4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2001/016-vector4.sv)
- **Signals:** in, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-196

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/004-andgate.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/004-andgate.sv)
- **Signals:** a, b, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-197

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/006-xnorgate.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/006-xnorgate.sv)
- **Signals:** a, b, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-198

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/017-vector5.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/017-vector5.sv)
- **Signals:** a, b, c, d, e, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, c, d, e, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-199

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/019-module_pos.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/019-module_pos.sv)
- **Signals:** a, b, c, d, out1, out2
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, c, d, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out1, out2, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-200

**Every bit position and simultaneous load/shift controls** · Shift/rotate · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/021-module_shift.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/021-module_shift.sv)
- **Signals:** clk, d, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Using clk, d, move a walking one from each endpoint through every legal shift position. Exercise shifts of zero, one and the maximum exposed amount. At a nonzero value, assert every simultaneously legal load/shift/enable combination.
- **Expected result:** q preserves the specified shift direction, fill and rotation. Count delay in accepted enabled edges. Competing controls follow the source's explicit priority, including multiple assignments to the same register.
- **Coverage target:** Every bit position; both endpoints; every exposed amount/direction; control collisions.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-201

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/023-module_add.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/023-module_add.sv)
- **Signals:** a, b, sum
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For sum, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-202

**Long carry or borrow and independent operand ordering** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/026-module_addsub.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/026-module_addsub.sv)
- **Signals:** a, b, sub, sum
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Using a, b, sub, test 0+0, max+1, max+max, 0-1 where subtraction exists, and (2^k-1)+1 for every legal bit k. Repeat with operands exchanged and each exposed carry/borrow control.
- **Expected result:** Calculate the integer result with an extra bit before fitting the declared output width. Check sum including separate carry/borrow/zero indicators. Signed overflow must not be confused with carry; sequential designs use the captured operands.
- **Coverage target:** Carry/borrow chain through every bit; both operand orderings; zero and width overflow.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-203

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/027-alwaysblock1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/027-alwaysblock1.sv)
- **Signals:** a, b, out_assign, out_alwaysblock
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out_assign, out_alwaysblock, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-204

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/030-always_if2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/030-always_if2.sv)
- **Signals:** cpu_overheated, arrived, gas_tank_empty, shut_off_computer, keep_driving
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For cpu_overheated, arrived, gas_tank_empty, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For shut_off_computer, keep_driving, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-205

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/031-always_case.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/031-always_case.sv)
- **Signals:** sel, data0, data1, data2, data3, data4, data5, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For sel, data0, data1, data2, data3, data4, data5, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-206

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/033-always_casez.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/033-always_casez.sv)
- **Signals:** in, pos
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For pos, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-207

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/034-always_nolatches.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/034-always_nolatches.sv)
- **Signals:** scancode, left, down, right, up
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For scancode, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For left, down, right, up, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-208

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/035-conditional.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/035-conditional.sv)
- **Signals:** a, b, c, d, min
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, c, d, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For min, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-209

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/036-reduction.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/036-reduction.sv)
- **Signals:** in, parity
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For parity, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-210

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/037-gates100.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/037-gates100.sv)
- **Signals:** in, out_and, out_or, out_xor
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out_and, out_or, out_xor, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-211

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/038-vector100r.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/038-vector100r.sv)
- **Signals:** in, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-212

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/039-popcount255.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/039-popcount255.sv)
- **Signals:** in, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-213

**Long carry or borrow and independent operand ordering** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/040-adder100i.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/040-adder100i.sv)
- **Signals:** a, b, cin, cout, sum
- **Setup:** Compile top_module, full_adder from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Using a, b, cin, test 0+0, max+1, max+max, 0-1 where subtraction exists, and (2^k-1)+1 for every legal bit k. Repeat with operands exchanged and each exposed carry/borrow control.
- **Expected result:** Calculate the integer result with an extra bit before fitting the declared output width. Check cout, sum including separate carry/borrow/zero indicators. Signed overflow must not be confused with carry; sequential designs use the captured operands.
- **Coverage target:** Carry/borrow chain through every bit; both operand orderings; zero and width overflow.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-214

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/042-exams__m2014_q4h.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/042-exams__m2014_q4h.sv)
- **Signals:** in, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-215

**Constant or stimulus-generator behavior over time** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/043-exams__m2014_q4i.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/043-exams__m2014_q4i.sv)
- **Signals:** out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Observe out from time zero through the full source-defined initial sequence. Re-run from a fresh simulation without force/deposit. Distinguish constant-output exercises from modules containing timed initial stimulus.
- **Expected result:** A constant-output exercise keeps its specified constant. A timed stimulus exercise follows its stated time sequence and must not be mislabeled as a combinational DUT with missing inputs.
- **Coverage target:** Startup and later observation; reproducibility; no invented input/reset interface.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-216

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/044-exams__m2014_q4e.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/044-exams__m2014_q4e.sv)
- **Signals:** in1, in2, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in1, in2, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-217

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/045-exams__m2014_q4f.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/045-exams__m2014_q4f.sv)
- **Signals:** in1, in2, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in1, in2, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-218

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/046-exams__m2014_q4g.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/046-exams__m2014_q4g.sv)
- **Signals:** in1, in2, in3, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in1, in2, in3, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-219

**Long carry or borrow and independent operand ordering** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 02/065-fadd.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2002/065-fadd.sv)
- **Signals:** a, b, cin, cout, sum
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Using a, b, cin, test 0+0, max+1, max+max, 0-1 where subtraction exists, and (2^k-1)+1 for every legal bit k. Repeat with operands exchanged and each exposed carry/borrow control.
- **Expected result:** Calculate the integer result with an extra bit before fitting the declared output width. Check cout, sum including separate carry/borrow/zero indicators. Signed overflow must not be confused with carry; sequential designs use the captured operands.
- **Coverage target:** Carry/borrow chain through every bit; both operand orderings; zero and width overflow.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-220

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/047-gates.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/047-gates.sv)
- **Signals:** a, b, out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-221

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/051-mt2015_q4a.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/051-mt2015_q4a.sv)
- **Signals:** x, y, z
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For x, y, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For z, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-222

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/052-mt2015_q4b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/052-mt2015_q4b.sv)
- **Signals:** x, y, z
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For x, y, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For z, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-223

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/053-mt2015_q4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/053-mt2015_q4.sv)
- **Signals:** x, y, z
- **Setup:** Compile top_module, A, B from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For x, y, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For z, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-224

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/054-ringer.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/054-ringer.sv)
- **Signals:** ring, vibrate_mode, ringer, motor
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For ring, vibrate_mode, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For ringer, motor, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-225

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/055-thermostat.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/055-thermostat.sv)
- **Signals:** too_cold, too_hot, mode, fan_on, heater, aircon, fan
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For too_cold, too_hot, mode, fan_on, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For heater, aircon, fan, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-226

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/056-popcount3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/056-popcount3.sv)
- **Signals:** in, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-227

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/057-gatesv.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/057-gatesv.sv)
- **Signals:** in, out_both, out_any, out_different
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out_both, out_any, out_different, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-228

**Selected data transition and inactive-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/063-mux256to1v.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/063-mux256to1v.sv)
- **Signals:** in, sel, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For each legal select code in in, sel, hold all unselected data at one and toggle the selected bit/value 0->1->0; then hold the selected value constant and toggle every unselected input. Repeat in descending select order.
- **Expected result:** out follows only the selected input with combinational settling. Reversing traversal must not retain an earlier select's result. Check unused select encodings against the explicit default contract.
- **Coverage target:** Each select x both selected data values; each unselected input toggled; reverse traversal.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-229

**Long carry or borrow and independent operand ordering** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/064-hadd.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/064-hadd.sv)
- **Signals:** a, b, cout, sum
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Using a, b, test 0+0, max+1, max+max, 0-1 where subtraction exists, and (2^k-1)+1 for every legal bit k. Repeat with operands exchanged and each exposed carry/borrow control.
- **Expected result:** Calculate the integer result with an extra bit before fitting the declared output width. Check cout, sum including separate carry/borrow/zero indicators. Signed overflow must not be confused with carry; sequential designs use the captured operands.
- **Coverage target:** Carry/borrow chain through every bit; both operand orderings; zero and width overflow.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-230

**Long carry or borrow and independent operand ordering** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/066-adder3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/066-adder3.sv)
- **Signals:** a, b, cin, cout, sum
- **Setup:** Compile top_module, fa from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Using a, b, cin, test 0+0, max+1, max+max, 0-1 where subtraction exists, and (2^k-1)+1 for every legal bit k. Repeat with operands exchanged and each exposed carry/borrow control.
- **Expected result:** Calculate the integer result with an extra bit before fitting the declared output width. Check cout, sum including separate carry/borrow/zero indicators. Signed overflow must not be confused with carry; sequential designs use the captured operands.
- **Coverage target:** Carry/borrow chain through every bit; both operand orderings; zero and width overflow.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-231

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/067-exams__m2014_q4j.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/067-exams__m2014_q4j.sv)
- **Signals:** x, y, sum, a, b, cin, cout
- **Setup:** Compile top_module, fa from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For x, y, a, b, cin, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For sum, cout, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-232

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/068-exams__ece241_2014_q1c.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/068-exams__ece241_2014_q1c.sv)
- **Signals:** a, b, s, overflow
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For s, overflow, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-233

**Long carry or borrow and independent operand ordering** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/069-adder100.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/069-adder100.sv)
- **Signals:** a, b, cin, cout, sum
- **Setup:** Compile top_module, fa from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Using a, b, cin, test 0+0, max+1, max+max, 0-1 where subtraction exists, and (2^k-1)+1 for every legal bit k. Repeat with operands exchanged and each exposed carry/borrow control.
- **Expected result:** Calculate the integer result with an extra bit before fitting the declared output width. Check cout, sum including separate carry/borrow/zero indicators. Signed overflow must not be confused with carry; sequential designs use the captured operands.
- **Coverage target:** Carry/borrow chain through every bit; both operand orderings; zero and width overflow.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-234

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/070-bcdadd4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/070-bcdadd4.sv)
- **Signals:** a, b, cin, cout, sum
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, cin, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For cout, sum, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-235

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/071-kmap1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/071-kmap1.sv)
- **Signals:** a, b, c, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, c, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-236

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/072-kmap2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/072-kmap2.sv)
- **Signals:** a, b, c, d, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, c, d, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-237

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/074-kmap4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/074-kmap4.sv)
- **Signals:** a, b, c, d, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, c, d, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-238

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/075-exams__ece241_2013_q2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/075-exams__ece241_2013_q2.sv)
- **Signals:** a, b, c, d, out_sop, out_pos
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, c, d, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out_sop, out_pos, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-239

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/076-exams__m2014_q3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/076-exams__m2014_q3.sv)
- **Signals:** x, f
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For x, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For f, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-240

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/077-exams__2012_q1g.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/077-exams__2012_q1g.sv)
- **Signals:** x, f
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For x, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For f, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-241

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/079-dff.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/079-dff.sv)
- **Signals:** clk, d, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, d to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-242

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/080-dff8.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/080-dff8.sv)
- **Signals:** clk, d, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, d to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-243

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/082-dff8p.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/082-dff8p.sv)
- **Signals:** clk, reset, d, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, reset, d to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-244

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/083-dff8ar.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/083-dff8ar.sv)
- **Signals:** clk, areset, d, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, areset, d to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-245

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/084-dff16e.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/084-dff16e.sv)
- **Signals:** clk, resetn, byteena, d, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, resetn, byteena, d to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-246

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/085-exams__m2014_q4a.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/085-exams__m2014_q4a.sv)
- **Signals:** d, ena, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For d, ena, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For q, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-247

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/086-exams__m2014_q4b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/086-exams__m2014_q4b.sv)
- **Signals:** clk, d, ar, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, d, ar to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-248

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/087-exams__m2014_q4c.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/087-exams__m2014_q4c.sv)
- **Signals:** clk, d, r, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, d, r to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-249

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 03/088-exams__m2014_q4d.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2003/088-exams__m2014_q4d.sv)
- **Signals:** clk, in, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, in to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare out to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-250

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/089-mt2015_muxdff.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/089-mt2015_muxdff.sv)
- **Signals:** clk, L, r_in, q_in, Q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, L, r_in, q_in to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare Q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-251

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/090-exams__2014_q4a.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/090-exams__2014_q4a.sv)
- **Signals:** clk, w, R, E, L, Q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, w, R, E, L to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare Q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-252

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/091-exams__ece241_2014_q4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/091-exams__ece241_2014_q4.sv)
- **Signals:** clk, x, z
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, x to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare z to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-253

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/093-edgedetect.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/093-edgedetect.sv)
- **Signals:** clk, in, pedge
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, in to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare pedge to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-254

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/094-edgedetect2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/094-edgedetect2.sv)
- **Signals:** clk, in, anyedge
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, in to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare anyedge to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-255

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/096-dualedge.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/096-dualedge.sv)
- **Signals:** clk, d, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, d to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-256

**Terminal-count enable/load collisions** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/097-count15.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/097-count15.sv)
- **Signals:** clk, reset, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Use the normal reset/load/count path to reach the last and first legal values of q. Exercise every present enable, direction and load combination from clk, reset at those boundaries. Include consecutive reloads and reset during rollover.
- **Expected result:** The independently maintained count follows the exact modulus and source control priority. Holds consume no count step when enable exists. Carry/terminal outputs align with the documented pre-/post-edge count. Cover the actual digit modulus, not an assumed binary maximum.
- **Coverage target:** Low/high rollover crossed with each exposed control; reset/load priority; terminal pulse alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-257

**Terminal-count enable/load collisions** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/098-count10.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/098-count10.sv)
- **Signals:** clk, reset, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Use the normal reset/load/count path to reach the last and first legal values of q. Exercise every present enable, direction and load combination from clk, reset at those boundaries. Include consecutive reloads and reset during rollover.
- **Expected result:** The independently maintained count follows the exact modulus and source control priority. Holds consume no count step when enable exists. Carry/terminal outputs align with the documented pre-/post-edge count. Cover the actual digit modulus, not an assumed binary maximum.
- **Coverage target:** Low/high rollover crossed with each exposed control; reset/load priority; terminal pulse alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-258

**Terminal-count enable/load collisions** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/100-countslow.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/100-countslow.sv)
- **Signals:** clk, slowena, reset, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Use the normal reset/load/count path to reach the last and first legal values of q. Exercise every present enable, direction and load combination from clk, slowena, reset at those boundaries. Include consecutive reloads and reset during rollover.
- **Expected result:** The independently maintained count follows the exact modulus and source control priority. Holds consume no count step when enable exists. Carry/terminal outputs align with the documented pre-/post-edge count. Cover the actual digit modulus, not an assumed binary maximum.
- **Coverage target:** Low/high rollover crossed with each exposed control; reset/load priority; terminal pulse alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-259

**Every bit position and simultaneous load/shift controls** · Shift/rotate · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/103-shift18.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/103-shift18.sv)
- **Signals:** clk, load, ena, amount, data, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Using clk, load, ena, amount, data, move a walking one from each endpoint through every legal shift position. Exercise shifts of zero, one and the maximum exposed amount. At a nonzero value, assert every simultaneously legal load/shift/enable combination.
- **Expected result:** q preserves the specified shift direction, fill and rotation. Count delay in accepted enabled edges. Competing controls follow the source's explicit priority, including multiple assignments to the same register.
- **Coverage target:** Every bit position; both endpoints; every exposed amount/direction; control collisions.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-260

**Bit recurrence and zero-state characterization** · LFSR · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/104-lfsr5.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/104-lfsr5.sv)
- **Signals:** clk, reset, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Load or reset the documented seed, then compare at least 64 updates against a bit-vector tap model. Track outgoing bit, feedback bit and q each edge. If zero can be loaded, test it separately without altering DUT state otherwise.
- **Expected result:** Each update uses the prior vector and documented feedback taps. Seed reproducibility and actual repeat period are separate checks. Zero lockup in an XOR-feedback LFSR is a documented behavior, not automatically an error.
- **Coverage target:** Every feedback contributor toggled; seed replay; zero behavior only if reachable.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-261

**Bit recurrence and zero-state characterization** · LFSR · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/105-mt2015_lfsr.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/105-mt2015_lfsr.sv)
- **Signals:** SW, KEY, LEDR
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Load or reset the documented seed, then compare at least 64 updates against a bit-vector tap model. Track outgoing bit, feedback bit and LEDR each edge. If zero can be loaded, test it separately without altering DUT state otherwise.
- **Expected result:** Each update uses the prior vector and documented feedback taps. Seed reproducibility and actual repeat period are separate checks. Zero lockup in an XOR-feedback LFSR is a documented behavior, not automatically an error.
- **Coverage target:** Every feedback contributor toggled; seed replay; zero behavior only if reachable.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-262

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 04/107-exams__m2014_q4k.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2004/107-exams__m2014_q4k.sv)
- **Signals:** clk, resetn, in, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, resetn, in to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare out to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-263

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/108-exams__2014_q4b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/108-exams__2014_q4b.sv)
- **Signals:** SW, KEY, LEDR, clk, w, R, E, L, Q
- **Setup:** Compile top_module, MUXDFF from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, MUXDFF, use legal inputs SW, KEY, clk, w, R, E, L to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare LEDR, Q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-264

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/109-exams__ece241_2013_q12.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/109-exams__ece241_2013_q12.sv)
- **Signals:** clk, enable, S, A, B, C, Z
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, enable, S, A, B, C to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare Z to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-265

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/110-fsm1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/110-fsm1.sv)
- **Signals:** clk, areset, in, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, areset, in to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare out to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-266

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/111-fsm1s.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/111-fsm1s.sv)
- **Signals:** clk, reset, in, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, reset, in to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare out to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-267

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/112-fsm2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/112-fsm2.sv)
- **Signals:** clk, areset, j, k, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, areset, j, k to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare out to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-268

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/113-fsm2s.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/113-fsm2s.sv)
- **Signals:** clk, reset, j, k, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, reset, j, k to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare out to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-269

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/114-fsm3comb.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/114-fsm3comb.sv)
- **Signals:** in, state, next_state, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For in, state, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For next_state, out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-270

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/115-fsm3onehot.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/115-fsm3onehot.sv)
- **Signals:** in, state, next_state, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For in, state, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For next_state, out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-271

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/116-fsm3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/116-fsm3.sv)
- **Signals:** clk, in, areset, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, in, areset to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare out to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-272

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/117-fsm3s.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/117-fsm3s.sv)
- **Signals:** clk, in, reset, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, in, reset to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare out to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-273

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/118-exams__ece241_2013_q4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/118-exams__ece241_2013_q4.sv)
- **Signals:** clk, reset, s, fr3, fr2, fr1, dfr
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, reset, s to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare fr3, fr2, fr1, dfr to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-274

**Repeat state transitions with reset and input-history variations** · Lemmings FSM · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 05/119-lemmings1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2005/119-lemmings1.sv)
- **Signals:** clk, areset, bump_left, bump_right, walk_left, walk_right
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, areset, bump_left, bump_right to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare walk_left, walk_right to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-275

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/121-exams__2013_q2bfsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/121-exams__2013_q2bfsm.sv)
- **Signals:** clk, resetn, x, y, f, g
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, resetn, x, y to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare f, g to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-276

**Selected data transition and inactive-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/122-bugs_mux2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/122-bugs_mux2.sv)
- **Signals:** sel, a, b, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For each legal select code in sel, a, b, hold all unselected data at one and toggle the selected bit/value 0->1->0; then hold the selected value constant and toggle every unselected input. Repeat in descending select order.
- **Expected result:** out follows only the selected input with combinational settling. Reversing traversal must not retain an earlier select's result. Check unused select encodings against the explicit default contract.
- **Coverage target:** Each select x both selected data values; each unselected input toggled; reverse traversal.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-277

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/123-bugs_nand3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/123-bugs_nand3.sv)
- **Signals:** a, b, c, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, c, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-278

**Selected data transition and inactive-input isolation** · Multiplexer · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/124-bugs_mux4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/124-bugs_mux4.sv)
- **Signals:** sel, a, b, c, d, out
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For each legal select code in sel, a, b, c, d, hold all unselected data at one and toggle the selected bit/value 0->1->0; then hold the selected value constant and toggle every unselected input. Repeat in descending select order.
- **Expected result:** out follows only the selected input with combinational settling. Reversing traversal must not retain an earlier select's result. Check unused select encodings against the explicit default contract.
- **Coverage target:** Each select x both selected data values; each unselected input toggled; reverse traversal.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-279

**Long carry or borrow and independent operand ordering** · Arithmetic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/125-bugs_addsubz.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/125-bugs_addsubz.sv)
- **Signals:** do_sub, a, b, out, result_is_zero
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Using do_sub, a, b, test 0+0, max+1, max+max, 0-1 where subtraction exists, and (2^k-1)+1 for every legal bit k. Repeat with operands exchanged and each exposed carry/borrow control.
- **Expected result:** Calculate the integer result with an extra bit before fitting the declared output width. Check out, result_is_zero including separate carry/borrow/zero indicators. Signed overflow must not be confused with carry; sequential designs use the captured operands.
- **Coverage target:** Carry/borrow chain through every bit; both operand orderings; zero and width overflow.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-280

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/126-bugs_case.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/126-bugs_case.sv)
- **Signals:** code, out, valid
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For code, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For out, valid, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-281

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/127-sim__circuit1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/127-sim__circuit1.sv)
- **Signals:** a, b, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For q, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-282

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/128-sim__circuit2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/128-sim__circuit2.sv)
- **Signals:** a, b, c, d, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, c, d, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For q, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-283

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/129-sim__circuit3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/129-sim__circuit3.sv)
- **Signals:** a, b, c, d, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, c, d, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For q, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-284

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/130-sim__circuit4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/130-sim__circuit4.sv)
- **Signals:** a, b, c, d, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, c, d, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For q, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-285

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/131-sim__circuit5.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/131-sim__circuit5.sv)
- **Signals:** a, b, c, d, e, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, b, c, d, e, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For q, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-286

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/132-sim__circuit6.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/132-sim__circuit6.sv)
- **Signals:** a, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For a, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For q, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-287

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/133-sim__circuit7.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/133-sim__circuit7.sv)
- **Signals:** clk, a, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, a to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-288

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/134-sim__circuit8.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/134-sim__circuit8.sv)
- **Signals:** clock, a, p, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clock, a to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare p, q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-289

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/135-sim__circuit9.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/135-sim__circuit9.sv)
- **Signals:** clk, a, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, a to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-290

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/136-sim__circuit10.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/136-sim__circuit10.sv)
- **Signals:** clk, a, b, q, state
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, a, b to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q, state to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-291

**Constant or stimulus-generator behavior over time** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 06/138-tb__tb1.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2006/138-tb__tb1.sv)
- **Signals:** A, B
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Observe A, B from time zero through the full source-defined initial sequence. Re-run from a fresh simulation without force/deposit. Distinguish constant-output exercises from modules containing timed initial stimulus.
- **Expected result:** A constant-output exercise keeps its specified constant. A timed stimulus exercise follows its stated time sequence and must not be mislabeled as a combinational DUT with missing inputs.
- **Coverage target:** Startup and later observation; reproducibility; no invented input/reset interface.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-292

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 07/142-exams__ece241_2013_q8.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2007/142-exams__ece241_2013_q8.sv)
- **Signals:** clk, aresetn, x, z
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, aresetn, x to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare z to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-293

**Independent truth table and history-free output checks** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 08/143-exams__ece241_2014_q7a.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2008/143-exams__ece241_2014_q7a.sv)
- **Signals:** clk, reset, enable, Q, c_enable, c_load, c_d
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For clk, reset, enable, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For Q, c_enable, c_load, c_d, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-294

**Independent truth table and history-free output checks** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/144-exams__ece241_2014_q7b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/144-exams__ece241_2014_q7b.sv)
- **Signals:** clk, reset, OneHertz, c_enable
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For clk, reset, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For OneHertz, c_enable, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-295

**Terminal-count enable/load collisions** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/145-countbcd.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/145-countbcd.sv)
- **Signals:** clk, reset, ena, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Use the normal reset/load/count path to reach the last and first legal values of ena, q. Exercise every present enable, direction and load combination from clk, reset at those boundaries. Include consecutive reloads and reset during rollover.
- **Expected result:** The independently maintained count follows the exact modulus and source control priority. Holds consume no count step when enable exists. Carry/terminal outputs align with the documented pre-/post-edge count. Cover the actual digit modulus, not an assumed binary maximum.
- **Coverage target:** Low/high rollover crossed with each exposed control; reset/load priority; terminal pulse alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-296

**Terminal-count enable/load collisions** · Counter · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/147-exams__review2015_count1k.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/147-exams__review2015_count1k.sv)
- **Signals:** clk, reset, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Use the normal reset/load/count path to reach the last and first legal values of q. Exercise every present enable, direction and load combination from clk, reset at those boundaries. Include consecutive reloads and reset during rollover.
- **Expected result:** The independently maintained count follows the exact modulus and source control priority. Holds consume no count step when enable exists. Carry/terminal outputs align with the documented pre-/post-edge count. Cover the actual digit modulus, not an assumed binary maximum.
- **Coverage target:** Low/high rollover crossed with each exposed control; reset/load priority; terminal pulse alignment.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-297

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/149-exams__review2015_fsmseq.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/149-exams__review2015_fsmseq.sv)
- **Signals:** clk, reset, data, start_shifting
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, reset, data to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare start_shifting to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-298

**Every bit position and simultaneous load/shift controls** · Shift/rotate · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/150-exams__review2015_fsmshift.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/150-exams__review2015_fsmshift.sv)
- **Signals:** clk, reset, shift_ena
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Using clk, reset, move a walking one from each endpoint through every legal shift position. Exercise shifts of zero, one and the maximum exposed amount. At a nonzero value, assert every simultaneously legal load/shift/enable combination.
- **Expected result:** shift_ena preserves the specified shift direction, fill and rotation. Count delay in accepted enabled edges. Competing controls follow the source's explicit priority, including multiple assignments to the same register.
- **Coverage target:** Every bit position; both endpoints; every exposed amount/direction; control collisions.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-299

**Constant or stimulus-generator behavior over time** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/151-step_one.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/151-step_one.sv)
- **Signals:** one
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Observe one from time zero through the full source-defined initial sequence. Re-run from a fresh simulation without force/deposit. Distinguish constant-output exercises from modules containing timed initial stimulus.
- **Expected result:** A constant-output exercise keeps its specified constant. A timed stimulus exercise follows its stated time sequence and must not be mislabeled as a combinational DUT with missing inputs.
- **Coverage target:** Startup and later observation; reproducibility; no invented input/reset interface.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-300

**Constant or stimulus-generator behavior over time** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/152-zero.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/152-zero.sv)
- **Signals:** zero
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** Observe zero from time zero through the full source-defined initial sequence. Re-run from a fresh simulation without force/deposit. Distinguish constant-output exercises from modules containing timed initial stimulus.
- **Expected result:** A constant-output exercise keeps its specified constant. A timed stimulus exercise follows its stated time sequence and must not be mislabeled as a combinational DUT with missing inputs.
- **Coverage target:** Startup and later observation; reproducibility; no invented input/reset interface.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-301

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 09/153-exams__review2015_fsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2009/153-exams__review2015_fsm.sv)
- **Signals:** clk, reset, data, done_counting, ack, shift_ena, counting, done
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, reset, data, done_counting, ack to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare shift_ena, counting, done to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-302

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 10/156-exams__2014_q3bfsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2010/156-exams__2014_q3bfsm.sv)
- **Signals:** clk, reset, x, z
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, reset, x to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare z to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-303

**Independent truth table and history-free output checks** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 10/157-exams__2014_q3c.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2010/157-exams__2014_q3c.sv)
- **Signals:** clk, y, x, Y0, z
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For clk, y, x, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For Y0, z, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-304

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 10/158-exams__m2014_q6c.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2010/158-exams__m2014_q6c.sv)
- **Signals:** y, w, Y2, Y4
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For y, w, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For Y2, Y4, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-305

**Repeat state transitions with reset and input-history variations** · Lemmings FSM · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 11/159-lemmings2.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2011/159-lemmings2.sv)
- **Signals:** clk, areset, bump_left, bump_right, ground, walk_left, walk_right, aaah
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, areset, bump_left, bump_right, ground to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare walk_left, walk_right, aaah to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-306

**Repeat state transitions with reset and input-history variations** · Lemmings FSM · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 11/160-lemmings3.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2011/160-lemmings3.sv)
- **Signals:** clk, areset, bump_left, bump_right, ground, dig, walk_left, walk_right, aaah, digging
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, areset, bump_left, bump_right, ground, dig to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare walk_left, walk_right, aaah, digging to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-307

**Repeat state transitions with reset and input-history variations** · Lemmings FSM · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 12/161-lemmings4.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2012/161-lemmings4.sv)
- **Signals:** clk, areset, bump_left, bump_right, ground, dig, walk_left, walk_right, aaah, digging
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, areset, bump_left, bump_right, ground, dig to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare walk_left, walk_right, aaah, digging to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-308

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 12/162-fsm_onehot.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2012/162-fsm_onehot.sv)
- **Signals:** in, state, next_state, out1, out2
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For in, state, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For next_state, out1, out2, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-309

**Repeat state transitions with reset and input-history variations** · Serial run-length detector · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/168-fsm_hdlc.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/168-fsm_hdlc.sv)
- **Signals:** clk, reset, in, disc, flag, err
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, reset, in to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare disc, flag, err to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-310

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/169-exams__ece241_2014_q5a.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/169-exams__ece241_2014_q5a.sv)
- **Signals:** clk, areset, x, z
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, areset, x to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare z to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-311

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/170-exams__ece241_2014_q5b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/170-exams__ece241_2014_q5b.sv)
- **Signals:** clk, areset, x, z
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, areset, x to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare z to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-312

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/171-exams__m2014_q6b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/171-exams__m2014_q6b.sv)
- **Signals:** y, w, Y2
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For y, w, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For Y2, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-313

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/172-exams__m2014_q6.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/172-exams__m2014_q6.sv)
- **Signals:** clk, reset, w, z
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, reset, w to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare z to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-314

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/173-exams__2012_q2fsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/173-exams__2012_q2fsm.sv)
- **Signals:** clk, reset, w, z
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, reset, w to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare z to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-315

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 13/174-exams__2012_q2b.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2013/174-exams__2012_q2b.sv)
- **Signals:** y, w, Y1, Y3
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For y, w, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For Y1, Y3, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-316

**Repeat state transitions with reset and input-history variations** · Cellular automaton · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 14/175-rule90.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2014/175-rule90.sv)
- **Signals:** clk, load, data, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, load, data to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-317

**Repeat state transitions with reset and input-history variations** · Cellular automaton · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 14/176-rule110.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2014/176-rule110.sv)
- **Signals:** clk, load, data, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, load, data to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-318

**Repeat state transitions with reset and input-history variations** · Sequential logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 14/177-exams__2013_q2afsm.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2014/177-exams__2013_q2afsm.sv)
- **Signals:** clk, resetn, r, g
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, resetn, r to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare g to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-319

**Independent truth table and history-free output checks** · Combinational logic · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 14/178-exams__review2015_fsmonehot.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2014/178-exams__review2015_fsmonehot.sv)
- **Signals:** d, done_counting, ack, state, B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For d, done_counting, ack, state, enumerate every binary input combination when total input width is at most 12 bits. For wider vectors, use zero, all ones, walking one/zero and complementary adjacent-bit patterns. Visit vectors in ascending and descending order, with two different predecessor vectors per checked point.
- **Expected result:** For B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena, use the original exercise truth table or independently simplified Boolean/bit-index mapping. The same input must give the same output regardless of the previous vector. Include every output bit, explicit defaults, and any source-specified don't-care conditions; do not assert a binary value for a declared X/Z case.
- **Coverage target:** Full small binary domain or each wide input/output bit; both polarities; default branch; input-history independence.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-320

**Repeat state transitions with reset and input-history variations** · Game of Life · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 1/study/solutions/Day 14/179-conwaylife.sv](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%201/study/solutions/Day%2014/179-conwaylife.sv)
- **Signals:** clk, load, data, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, load, data to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-321

**Repeat state transitions with reset and input-history variations** · Serial run-length detector · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 2/internal/Discussion Drafts/fsm_hdlc_discussion.v](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%202/internal/Discussion%20Drafts/fsm_hdlc_discussion.v)
- **Signals:** clk, reset, in, disc, flag, err
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, reset, in to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare disc, flag, err to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-322

**Repeat state transitions with reset and input-history variations** · Serial run-length detector · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 2/internal/Discussion Drafts/fsm_hdlc_working_moore.v](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%202/internal/Discussion%20Drafts/fsm_hdlc_working_moore.v)
- **Signals:** clk, reset, in, disc, flag, err
- **Setup:** Compile top_module from this file separately with its actual dependencies. Record all parameter overrides; preserve the declared width and legal index range.
- **Drive / observe:** For top_module, use legal inputs clk, reset, in to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare disc, flag, err to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

### HDL-323

**Repeat state transitions with reset and input-history variations** · Game of Life · P1 · Pending · Simulation plan

- **Source:** [1. HDLBits Attempt 2/internal/Documentation/conway_reference.v](https://github.com/kapiltrip/hdlBits/blob/fc3f2b993a1e202ef42a8e831c29f8f287f85e7a/HDLBits%20Attempt%202/internal/Documentation/conway_reference.v)
- **Signals:** clk, load, data, q
- **Setup:** Compile top_module from this file separately with its actual dependencies. Use the declared fixed interface widths.
- **Drive / observe:** For top_module, use legal inputs clk, load, data to reach every documented state/output branch. Repeat each transition after two different histories. Assert each declared reset during activity and test every simultaneously asserted non-clock control; use load or a defined input sequence when there is no reset.
- **Expected result:** Compare q to an independent state-transition table with one row per legal state/input combination. Registered outputs are sampled after NBA; outputs depending directly on inputs also need pre-edge observation. Returning to the same state and inputs must reproduce the same defined output and next transition.
- **Coverage target:** Every reachable state/input branch; competing controls; reset during activity; replay from different histories.
- **Stop rule:** Finish the directed finite vector list and allow at most ten additional relevant clock edges for a stable response; record any timeout and its pending condition.

