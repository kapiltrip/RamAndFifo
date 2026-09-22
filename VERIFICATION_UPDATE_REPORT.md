# Verification plan update report

## Scope selected

The active plan covers only these nine repositories. Existing case IDs were retained, and newly added IDs follow each repository's previous sequence.

| Repository | Earlier cases | Current cases | New scenarios | HDL files |
|---|---:|---:|---:|---:|
| RamAndFifo | 47 | 62 | 15 | 18 |
| AsynchronousFifo | 18 | 23 | 5 | 5 |
| UART- | 42 | 53 | 11 | 6 |
| UART-legacy | 24 | 32 | 8 | 5 |
| VerilogCodesUpdatedDaily | 21 | 31 | 10 | 13 |
| mips-processor | 12 | 19 | 7 | 8 |
| GoodQuestions | 79 | 138 | 59 | 95 |
| hdlBits | 178 | 323 | 145 | 186 |
| systemverilog-from-beginning | 48 | 84 | 36 | 165 |

**Total:** 469 retained IDs, 296 new cases, 765 cases and 501 mapped files. All cases are initially Pending or Blocked because no new functional runs were made.

## Coverage removed

Removed the five excluded public repositories from the combined plan and Excel tracker: DesignProject, VerificationLab, PlacementPrep, MorrisManoDE and RevisionAtlas. The two excluded private repositories' verification documents and tracker added in the previous pass were removed from their own roots, with their original READMEs restored. No RTL or pre-existing project content is part of this removal.

## Depth added

- RAM/FIFO: full/empty simultaneous operation matrix, wrap, data-width and address-width combinations, read-first collision, March-style transitions and reset effects.
- Async FIFO: pointer-visibility phases, synchronized flag delay, stalled clocks, remote full release, one-sided reset contract and separate source-specific CDC risks.
- UART: 256 payloads and start-phase decoding, short false starts, data glitches, tick pauses, bad stop recovery, buffering, queue admission and overload accounting.
- MIPS: instruction stage/phase trace, sign extension and destination fields, branches, hazard spacing, word addresses, HALT and existing bounded programs.
- Learning modules: FIR signed impulse/tap order, max/second-max handshakes, counters, pulse logic, FSM overlap, shift/priority encoders and documented teaching stubs.
- Each detailed row states source, signals, setup, stimulus, expected timing, coverage target and finite stop condition.

## Validation and limits

- 765 unique case IDs; 0 unrecognized signal references; zero cases from excluded repositories.
- Excel checked for 765 populated cases, dynamic status totals, dropdowns, color rules, freeze panes and blank run records.
- Source map checked for 501 selected HDL files and correct case IDs.
- Source inspection and spreadsheet calculations do not execute any RTL tests. Hardware CDC timing/metastability, protocol integration and tool-specific coverage remain separate execution evidence.
