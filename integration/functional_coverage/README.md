# FIFO Functional-Coverage Integration

[Repository home](../../README.md) · [FIFO/RAM Q&A](../../docs/FIFO_RAM_QA.md) · [Internal-memory FIFO](../../individual/fifo/sync_fifo.v) · [RAM-backed FIFO](../ram_and_fifo/rtl/sync_fifo_ram.v)

This directory applies one SystemVerilog functional-coverage model to both
active synchronous FIFO implementations without copying or replacing their
RTL:

- the standalone FIFO stores data in its own `mem` array;
- the RAM-backed FIFO instantiates the separate `sync_ram` module;
- both expose the same behavioral interface concepts: reset, read/write
  requests, input/output data, `full`, and `empty`.

The covergroup model comes from the completed Namaste FPGA V136 FIFO project
archived in the separate
[`systemverilog-from-beginning` repository](https://github.com/kapiltrip/systemverilog-from-beginning/tree/main/SV%20Functional%20Coverage/Projects/01-fifo-functional-coverage).
Its saved [EDA Playground page](https://edaplayground.com/x/Au83) compiled with
zero source errors and reported 17 of 26 scored bins (64.10%). That percentage
belongs to the original finite V136 stimulus; the two wrappers here reuse this
repository's stronger self-checking testbenches, so their coverage result is a
separate experiment.

## File map

| File | Purpose |
|---|---|
| [`fifo_functional_coverage.sv`](fifo_functional_coverage.sv) | Single reusable covergroup source shared by both implementations |
| [`tb_internal_fifo_coverage.sv`](tb_internal_fifo_coverage.sv) | Wraps the existing standalone-FIFO testbench and attaches the collector |
| [`tb_ram_backed_fifo_coverage.sv`](tb_ram_backed_fifo_coverage.sv) | Wraps the existing RAM/FIFO integration testbench and attaches the same collector |
| [`run.do`](run.do) | Runs to `$finish`, prints detailed covergroup results, and exits Questa |

The wrappers deliberately instantiate the existing self-checking testbenches.
They contain no second stimulus sequence and no second DUT implementation. A
fix to either active testbench is therefore exercised automatically by its
coverage wrapper.

## Verification status

- The coverpoint, bin, cross, and `ignore_bins` declarations match the archived
  V136 model after comments and whitespace are removed; the copied misleading
  comments were corrected without changing the declarations.
- The internal-memory wrapper passes its Icarus smoke regression with all five
  existing FIFO unit cases passing.
- The RAM-backed wrapper passes its Icarus smoke regression with all seven
  existing integration cases passing.
- Questa is not installed in the local review environment, so no new numeric
  covergroup percentage is claimed for these wrappers. The real-coverage
  commands below are ready for a covergroup-capable simulator.

## Discussion

### Why can one coverage model observe both FIFO implementations?

Functional coverage measures visible behavior, not the physical storage
implementation. The collector receives only the common FIFO interface signals.
It does not reach into `mem`, `sync_ram`, or either pointer implementation.
Consequently, the same model can ask whether both FIFOs saw reset, read/write
requests, full/empty states, and the three input/output data ranges.

This reuse is valid only while both DUTs keep the same interface meaning. If
one design later changes its accepted-operation policy, latency, or data-valid
contract, the coverage specification must be reviewed rather than reused
blindly.

### What do `parameter` and `localparam` mean here beyond configurable and constant?

They are elaboration-time values. SystemVerilog decides them while constructing
the design hierarchy, before runtime simulation begins, so they can define
hardware widths and memory depth.

For the FIFO and RAM:

```systemverilog
parameter AW = 4;
parameter DW = 8;
localparam DEPTH = (1 << AW);
```

`AW` and `DW` are configurable design settings. `DEPTH` is a derived internal
fact. With `AW = 4`, elaboration builds 4-bit addresses and 16 storage entries;
the occupancy counter needs `AW+1` bits so it can represent every value from 0
through 16. These parameters describe how the circuit is built—they are not
runtime data travelling through the FIFO.

The collector has its own `dw` parameter because its `din` and `dout` ports
must be elaborated to the same width as the observed FIFO. Both current
testbenches use 8 bits, so each wrapper passes `.dw(8)` explicitly.

### Where is the coverage code?

The complete shared model is in
[`fifo_functional_coverage.sv`](fifo_functional_coverage.sv). It contains seven
coverpoints (`empty`, `full`, `rst`, `wr_en`, `rd_en`, `din`, and `dout`) plus
six crosses relating requests to reset, data ranges, and boundary flags. The
coverage logic is kept out of the synthesizable `.v` files, so ordinary Icarus
regressions and hardware synthesis remain unaffected.

### Does this model prove FIFO correctness?

No. Coverpoints report whether planned situations were observed; they do not
compare read data with the oldest accepted write. Correctness still comes from
the existing self-checking testbenches and their FIFO-order comparisons.

Also, the inherited `cross_wr_din` and `cross_rd_din` crosses use raw request
signals. They show requested write/read data ranges, but they do not by
themselves prove that every request was accepted. The separate `full`/write and
`empty`/read crosses provide boundary context. A future coverage-closure model
could pass `do_write` and `do_read` into the collector and cross data directly
with accepted operations.

### Why is there a `NO_FUNCTIONAL_COVERAGE` branch?

Icarus Verilog can run the repository's ordinary RTL tests but does not
implement SystemVerilog covergroups. Defining `NO_FUNCTIONAL_COVERAGE` removes
only the covergroup during a smoke run, allowing the wrapper connections and
the original self-checks to compile and execute. The console explicitly says
the collector is disabled, so that run must never be reported as a coverage
result. Use Questa or another covergroup-capable simulator for real coverage.

## Run the wiring/regression smoke tests with Icarus

These commands verify that each wrapper still reaches the intended testbench
signals and that the underlying self-checking test passes. They do not collect
functional coverage.

```powershell
# Internal-memory FIFO wrapper
iverilog -Wall -g2012 -DNO_FUNCTIONAL_COVERAGE -s tb_internal_fifo_coverage -o minimal/build/simv_fifo_coverage_smoke integration/functional_coverage/tb_internal_fifo_coverage.sv integration/functional_coverage/fifo_functional_coverage.sv individual/fifo/tb_sync_fifo.v individual/fifo/sync_fifo.v
vvp minimal/build/simv_fifo_coverage_smoke

# Separate RAM-backed FIFO integration wrapper
iverilog -Wall -g2012 -DNO_FUNCTIONAL_COVERAGE -s tb_ram_backed_fifo_coverage -o minimal/build/simv_ram_fifo_coverage_smoke integration/functional_coverage/tb_ram_backed_fifo_coverage.sv integration/functional_coverage/fifo_functional_coverage.sv integration/ram_and_fifo/tb/tb_sync_fifo_ram.v integration/ram_and_fifo/rtl/sync_fifo_ram.v individual/ram/sync_ram.v
vvp minimal/build/simv_ram_fifo_coverage_smoke
```

## Collect real coverage with Questa

Compile exactly one wrapper as the simulation top, enable coverage in `vsim`,
and use the shared report script:

```tcl
# Internal-memory FIFO
vlib work
vlog -sv individual/fifo/sync_fifo.v individual/fifo/tb_sync_fifo.v integration/functional_coverage/fifo_functional_coverage.sv integration/functional_coverage/tb_internal_fifo_coverage.sv
vsim -c -coverage tb_internal_fifo_coverage -do "do integration/functional_coverage/run.do"

# RAM-backed FIFO integration (use a fresh work library or restart Questa)
vlib work
vlog -sv individual/ram/sync_ram.v integration/ram_and_fifo/rtl/sync_fifo_ram.v integration/ram_and_fifo/tb/tb_sync_fifo_ram.v integration/functional_coverage/fifo_functional_coverage.sv integration/functional_coverage/tb_ram_backed_fifo_coverage.sv
vsim -c -coverage tb_ram_backed_fifo_coverage -do "do integration/functional_coverage/run.do"
```

## Revision checks

1. Why can the same interface-level collector observe both storage styles?
2. Why does `DEPTH` belong at elaboration time rather than runtime?
3. Which result proves data ordering: a covergroup percentage or the
   self-checking scoreboard?
4. Why must an Icarus smoke run never be described as functional coverage?
5. What accepted-operation signals should a later closure model add?
