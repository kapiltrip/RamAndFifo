# FIFO + RAM Q&A Reference

This page captures all your questions so far and the answers, in one place.

## Quick Links
- Sync RAM: [`../rtl/sync/sync_ram.v`](../rtl/sync/sync_ram.v)
- Sync FIFO: [`../rtl/sync/sync_fifo_ram.v`](../rtl/sync/sync_fifo_ram.v)a
- Async RAM: [`../rtl/async/async_dp_ram.v`](../rtl/async/async_dp_ram.v)
- Async FIFO: [`../rtl/async/async_fifo_ram.v`](../rtl/async/async_fifo_ram.v)
- Sync TB: [`../tb/sync/tb_sync_fifo_ram.v`](../tb/sync/tb_sync_fifo_ram.v)
- Async TB: [`../tb/async/tb_async_fifo_ram.v`](../tb/async/tb_async_fifo_ram.v)
- TODO: [`TODO.md`](TODO.md)

## 1) "i need some standard code, for ram and fifo ... integrate it for me"
**Answer:**  
Integrated a standard synchronous FIFO using an instantiated synchronous RAM:
- [`rtl/sync/sync_ram.v`](../rtl/sync/sync_ram.v) (RAM block)
- [`rtl/sync/sync_fifo_ram.v`](../rtl/sync/sync_fifo_ram.v) (FIFO controller using RAM)
- [`tb/sync/tb_sync_fifo_ram.v`](../tb/sync/tb_sync_fifo_ram.v) (testbench)

The design was validated with simulation and passed.

## 2) "also lets call them aw and dw"
**Answer:**  
Renamed parameters across design and testbench:
- `DATA_WIDTH` -> `DW`
- `ADDR_WIDTH` -> `AW`

Simulation was rerun and still passed.

## 3) "ok from where to start, tell me"
**Answer:**  
Start in this order:
1. Run testbench to confirm baseline.
2. Understand FIFO interface (`wr_en`, `rd_en`, `full`, `empty`, `wr_data`, `rd_data`).
3. Understand synchronous RAM timing.
4. Instantiate FIFO in top module with `.DW(...)` and `.AW(...)`.

## 4) "if i wanna learn this all, how and where from start the code"
**Answer:**  
Recommended learning path:
1. [`rtl/sync/sync_ram.v`](../rtl/sync/sync_ram.v) first (RAM behavior and timing).
2. FIFO interface in [`rtl/sync/sync_fifo_ram.v`](../rtl/sync/sync_fifo_ram.v).
3. Handshake logic (`do_write`, `do_read`).
4. Count/flags logic (`fifo_count`, `full`, `empty`).
5. Pointer movement and wrap behavior.
6. Testbench flow in [`tb/sync/tb_sync_fifo_ram.v`](../tb/sync/tb_sync_fifo_ram.v).

## 5) "cant i open these in vivado"
**Answer:**  
Yes, you can use them in Vivado:
- Add [`rtl/sync/sync_ram.v`](../rtl/sync/sync_ram.v) and [`rtl/sync/sync_fifo_ram.v`](../rtl/sync/sync_fifo_ram.v) as design sources.
- Add [`tb/sync/tb_sync_fifo_ram.v`](../tb/sync/tb_sync_fifo_ram.v) as simulation source.
- Do not add `simv` (it is an Icarus simulation executable, not RTL source).

## 6) "how to select top modules?"
**Answer:**  
In Vivado:
- Design top: set `sync_fifo_ram` as top under **Design Sources**.
- Simulation top: set `tb_sync_fifo_ram` as top under **Simulation Sources**.

## 7) "wr_ptr is AW-1 somewhere and AW somewhere ... tell reason in comments"
**Answer:**  
Detailed comments were added in code to explain:
- Address/pointer buses use `[AW-1:0]` (AW bits total).
- Depth/count uses `[AW:0]` (AW+1 bits) so it can represent `0..2^AW`.

## 8) "wr_ptr <= {AW{1'b0}} but ptr is AW-1, why?"
**Answer:**  
`[AW-1:0]` means signal width is **AW bits**.  
So `{AW{1'b0}}` is the correct AW-bit zero vector.  
Equivalent shorter reset style is `wr_ptr <= '0;`.

## 9) "in do_read/do_write case, pointers always increase; how does that make sense?"
**Answer:**  
FIFO is a ring buffer:
- `wr_ptr` moves forward on writes.
- `rd_ptr` moves forward on reads.
- Occupancy is tracked by `fifo_count`, not pointer direction.
- On simultaneous read+write, both pointers advance, count stays same.

## 10) "i didnt make wrap logic, is code still correct?"
**Answer:**  
Yes, for depth `2^AW` it is correct.  
Pointers are fixed-width (`[AW-1:0]`), so overflow wraps automatically in Verilog.

## 11) "make a page of question and answer ... save for reference"
**Answer:**  
This file is that saved reference page.

## 12) "in ram, there is an en signal and i only give it do_write, why not do_read?"
**Answer:**  
In the current [`rtl/sync/sync_ram.v`](../rtl/sync/sync_ram.v), there is no explicit read-enable port (`re`/`en` for read).  
Read path is always active on clock (`dout <= mem[raddr]`), so only write side needs `we = do_write`.  
`do_read` is used in FIFO controller to advance `rd_ptr`.

## 13) "so the ram is not dual port ram?"
**Answer:**  
It is a simple dual-port single-clock RAM:
- One write port (`we`, `waddr`, `din`)
- One read port (`raddr`, `dout`)
- Shared clock

It is not "true dual-port" (two fully independent read/write ports).

## 14) "make another page TODO ... true dual-port ram so i can put do_read too"
**Answer:**  
Created [`docs/TODO.md`](TODO.md) with:
- Implement true dual-port RAM
- Update interface so `do_read` is used as explicit RAM read control signal

## 15) "all the questions should already be there for context of my learning"
**Answer:**  
Q&A page updated to include all recent questions so your learning context stays complete in one place.

## 16) "if anything is a wire, write it explicitly"
**Answer:**  
Updated module port declarations to explicitly mark wire-type ports:
- [`rtl/sync/sync_fifo_ram.v`](../rtl/sync/sync_fifo_ram.v): `input wire ...`, `output wire ...`
- [`rtl/sync/sync_ram.v`](../rtl/sync/sync_ram.v): `input wire ...`

Functionality was re-verified with simulation after this style update.

## 17) "i wanna see asynchronous fifo and working, how to do it"
**Answer:**  
Added a working asynchronous FIFO example with validation:
- [`rtl/async/async_dp_ram.v`](../rtl/async/async_dp_ram.v): dual-clock RAM (`wr_clk` and `rd_clk`)
- [`rtl/async/async_fifo_ram.v`](../rtl/async/async_fifo_ram.v): async FIFO using Gray-code pointers + 2-flop pointer synchronizers
- [`tb/async/tb_async_fifo_ram.v`](../tb/async/tb_async_fifo_ram.v): testbench with different write/read clock rates and data-order checks

Simulation command:
`iverilog -g2005-sv -o build/simv_async tb/async/tb_async_fifo_ram.v rtl/async/async_fifo_ram.v rtl/async/async_dp_ram.v`
`vvp build/simv_async`

Result: test passed.

## 18) "use this standard async fifo + external dual-port RAM style"
**Answer:**  
Yes, that architecture is standard and was applied explicitly:
- RAM module name/style aligned to: `async_fifo_dp_ram`
- FIFO top module name/style aligned to: `async_fifo_with_ram`
- External RAM is instantiated by FIFO controller
- Gray pointers + 2-flop synchronizers are used for CDC-safe full/empty logic

Also kept a backward-compatible wrapper module `async_fifo_ram` so older references still work.

## 19) "use this exact notation and writing style in integration"
**Answer:**  
Refactored async integration to match your preferred notation style:
- Sectioned blocks and naming pattern like your template (`wbin/wgray`, `rbin/rgray`, `wq1/wq2`, `rq1/rq2`)
- `always @(*)` blocks for `wbin_next/wgray_next` and `rbin_next/rgray_next`
- External RAM integration preserved through `async_fifo_dp_ram`

Final integrated modules:
- `async_fifo_with_ram` (main style-aligned async FIFO)
- `async_fifo_dp_ram` (external dual-port RAM)
- `async_fifo_ram` wrapper kept for compatibility

## 20) "make separate directories so files are easy to see"
**Answer:**  
Project was reorganized into folders:
- `rtl/sync` for synchronous design RTL
- `rtl/async` for asynchronous design RTL
- `tb/sync` and `tb/async` for testbenches
- `docs` for notes and TODOs
- `build` for simulation outputs

Both sync and async simulations were rerun from new paths and passed.

## 21) "empty and full logic should be outside and separate"
**Answer:**  
Refactored async FIFO so full/empty decision logic is in its own combinational section:
- Added `full_next` and `empty_next` wires
- Moved full/empty equations into the dedicated `EMPTY and FULL logic` section
- Clocked blocks now only register `full_reg <= full_next` and `empty_reg <= empty_next`

Async simulation was rerun and passed after this change.

## 22) "integrate async RAM same way as synchronous FIFO style"
**Answer:**  
Adjusted async integration to mirror sync style more closely:
- Added `do_write` and `do_read` control wires
- Connected RAM write enable directly as `.we(do_write)`
- Connected RAM output directly as `.dout(rd_data)` (no extra RAM data wire)
- Used `do_write`/`do_read` directly in next-pointer logic

Behavior stayed the same and async simulation passed.

## 23) "apply tutorial-style async FIFO flow (Gray sync + conversion + simple standard code)"
**Answer:**  
Updated async FIFO to match that flow more directly:
- Added explicit Gray-to-binary conversion function: `gray2bin`
- Converted synchronized pointers back to binary:
  - `wq2_rbin = gray2bin(wq2_rgray)`
  - `rq2_wbin = gray2bin(rq2_wgray)`
- Updated flag logic to compare synchronized binary pointers:
  - `empty_next = (rbin_next == rq2_wbin)`
  - `full_next  = ((wbin_next - wq2_rbin) == FIFO_DEPTH)`

Result remained correct; async and sync testbenches both passed.

## 24) "is this async FIFO optimal? if yes update existing, if not make it"
**Answer:**  
Improved the existing async FIFO to a simpler standard form:
- Removed extra Gray-to-binary conversion path
- Kept binary pointers for address progression
- Used direct Gray-code comparisons for flags:
  - `empty_next = (rgray_next == rq2_wgray)`
  - `full_next  = (wgray_next == {~wq2_rgray[ADDR_WIDTH:ADDR_WIDTH-1], wq2_rgray[ADDR_WIDTH-2:0]})`

This is cleaner and commonly used in production async FIFO implementations.  
Both async and sync testbenches passed after the update.

## 25) "remove RAM integration from async FIFO"
**Answer:**  
Updated async FIFO to use internal memory array instead of external RAM instantiation:
- Removed `async_fifo_dp_ram` instance from `rtl/async/async_fifo_ram.v`
- Added internal FIFO memory (`mem`) and internal read data register
- Kept pointer/flag CDC logic unchanged

This is a good choice for learning and smaller FIFOs.  
For larger/deeper hardware FIFOs, external/inferred block RAM integration is still often preferred.
