# RAM Questions and Answers

This page answers the handwritten questions with respect to the active RAM and RAM-backed FIFO code in this repository:

- [`individual/ram/sync_ram.v`](individual/ram/sync_ram.v)
- [`integration/ram_and_fifo/rtl/sync_fifo_ram.v`](integration/ram_and_fifo/rtl/sync_fifo_ram.v)
- [`integration/ram_and_fifo/rtl/syncFifo.v`](integration/ram_and_fifo/rtl/syncFifo.v)
- [`integration/ram_and_fifo/tb/tb_sync_fifo_ram.v`](integration/ram_and_fifo/tb/tb_sync_fifo_ram.v)

## Original handwritten questions

![Handwritten RAM questions](RAM_questions.jpg)

## Quick timing picture

For an accepted FIFO read, the important sequence is:

```text
Before rising edge: rd_en=1, empty=0, rd_ptr points to the oldest word
At rising edge:     RAM schedules dout <= mem[rd_ptr]
                    FIFO schedules rd_ptr <= rd_ptr + 1
After rising edge:  dout contains the word from the old rd_ptr
```

Both blocks use nonblocking assignments (`<=`), so the RAM sees the old `rd_ptr` at that edge. This is why the pointer can advance at the same edge without skipping the word being read.

## Q1. Do we need a wait or not?

We do **not** need a multi-cycle `wait` signal for the current on-chip synchronous RAM model, but the consumer must respect its clocked read timing.

In `sync_ram.v`, the read is:

```verilog
always @(posedge clk) begin
    if (we) begin
        mem[waddr] <= din;
    end
    dout <= mem[raddr];
end
```

`dout` changes only after a rising clock edge; it is not a combinational result that changes immediately with `raddr`. In the integration testbench, this is why the check is made after `@(posedge clk); #1;`: the small delay lets the nonblocking assignment update `dout` before it is sampled.

Therefore:

- Present `raddr` (indirectly, the current `rd_ptr`) and assert `rd_en` before the rising edge.
- Treat the data as available just after that rising edge.
- Do not add an arbitrary delay in synthesizable RTL. Use clock edges and, if another module needs an explicit indication, add a registered `rd_valid` signal.

A `wait`, `ready`, or `busy` handshake becomes necessary only when the memory can take a variable number of cycles—for example, an external memory controller—not for this fixed-latency inferred RAM.

## Q2. What happens if `AW` is different in the RAM and FIFO modules?

In the active integration, it is deliberately kept the same:

```verilog
sync_ram #(
    .DW(DW),
    .AW(AW)
) ram_inst (...);
```

The FIFO's `AW` is passed directly to the RAM's `AW`. With `AW = 4`:

- RAM address width = 4 bits.
- RAM depth = $2^4 = 16$ words.
- `wr_ptr` and `rd_ptr` each address locations 0 through 15.
- `fifo_count` is 5 bits so it can represent every occupancy from 0 through 16.

If the FIFO and RAM use different address widths, the design no longer describes the same storage capacity:

- **RAM `AW` smaller than FIFO `AW`:** upper FIFO address bits are lost at the RAM port. Different FIFO positions can alias the same RAM location, overwriting unread data.
- **RAM `AW` larger than FIFO `AW`:** only part of the RAM is reachable, while the FIFO's `full` calculation still uses its own smaller depth.
- Tools normally issue a port-width warning, but a warning does not make the behavior safe.

For this design, use one top-level `AW` and pass it unchanged to both modules. Separate address-width parameters are needed only when deliberate address translation or banking logic exists between the FIFO and RAM.

## Q3. What happens if `DW` is different? Do we need separate parameters?

The same rule applies to `DW`. The integration passes one FIFO data width directly into the RAM:

```verilog
.DW(DW)
```

So with `DW = 8`, `wr_data`, the RAM's `din`, every memory word, the RAM's `dout`, and `rd_data` are all 8 bits wide.

If the widths are different, Verilog connects unequal-width ports by truncating bits or extending the narrower value. That may compile with a warning, but it can silently corrupt data. For example, writing a 16-bit FIFO word into an 8-bit RAM port loses eight bits unless explicit packing logic is provided.

No separate FIFO and RAM `DW` parameters are needed here because one FIFO entry is exactly one RAM word. Separate widths make sense only for an intentional width-conversion FIFO, which would also require packing/unpacking logic, extra counters, and clearly defined byte or word order.

## Q4. Why is the RAM output declared `reg`?

`dout` is declared as an `output reg` because `sync_ram.v` assigns it inside a procedural clocked `always` block:

```verilog
output reg [DW-1:0] dout;
...
dout <= mem[raddr];
```

In Verilog, a signal assigned inside an `always` block must be a variable type such as `reg`. Here it also represents a real output register: the value is captured on the rising edge and held until a later edge updates it.

This does **not** mean every signal connected to it must also be declared `reg`. In `sync_fifo_ram.v`, the parent module declares `rd_data` as `output wire` because that parent does not procedurally assign it; the child RAM instance drives the connection.

In SystemVerilog, `logic` is normally used instead of `reg`, and `always_ff` can make the clocked intent clearer.

## Q5. Why is `DEPTH` a parameter?

In the current active code, `DEPTH` is actually a **local parameter derived from `AW`**, not an independently adjustable module parameter:

```verilog
localparam DEPTH = (1 << AW);       // sync_ram.v
localparam [AW:0] DEPTH = (1 << AW); // sync_fifo_ram.v
```

The relationship is:

$$
\text{DEPTH} = 2^{AW}
$$

Keeping it as a named constant makes memory declarations and full detection readable, while deriving it from `AW` prevents contradictory settings such as `AW = 4` with `DEPTH = 10`.

The FIFO version uses `[AW:0]` for the constant because `DEPTH` itself must hold $2^{AW}$. When `AW = 4`, the value 16 needs 5 bits. This matches `fifo_count`, which must represent the inclusive range 0 through 16. Addresses still need only 4 bits because their range is 0 through 15.

The current pointer-wrap technique works naturally because the depth is a power of two. Supporting a non-power-of-two depth would require an independent `DEPTH` parameter plus explicit pointer wrap and parameter-validity checks.

## Q6. How can `do_read` be connected to the RAM?

Currently, the RAM has no read-enable input. Its output reads `mem[raddr]` at **every** rising edge. `do_read` is used only to decide whether the FIFO may advance `rd_ptr`:

```verilog
assign do_read = rd_en && !empty;
...
if (do_read) begin
    rd_ptr <= rd_ptr + 1'b1;
end
```

This is functionally valid: when a read is not accepted, `rd_ptr` stays still, and the RAM simply reloads the same addressed word into `dout`.

If the goal is for `dout` to update only on a legal FIFO read, add a read-enable port to the RAM:

```verilog
input wire re;

always @(posedge clk) begin
    if (we) begin
        mem[waddr] <= din;
    end
    if (re) begin
        dout <= mem[raddr];
    end
end
```

Then connect it in the FIFO instance:

```verilog
.we   (do_write),
.re   (do_read),
.waddr(wr_ptr),
.raddr(rd_ptr)
```

This adds a synchronous **read enable**; it does not by itself turn the block into a true dual-port RAM. The current RAM is already a single-clock simple dual-port style: one write address/port and one read address/port. A true dual-port RAM would give both ports independent read/write capability, and it may also use separate clocks.

One timing detail remains: on an accepted read edge, `dout` receives `mem[old rd_ptr]` while `rd_ptr` advances for the next read. That is the intended behavior.

## Q7. What can be added to make the design better and safer, and why?

### 1. Add a read enable and optionally `rd_valid`

Connecting `do_read` as described above prevents meaningless output updates. A registered `rd_valid` tells downstream logic exactly when a newly requested word is available, avoiding assumptions about RAM latency.

### 2. Define reset behavior for the output

The FIFO resets pointers and `fifo_count`, but the RAM has no reset. Therefore `rd_data` may be unknown (`X`) until a real RAM read occurs. This is harmless while `empty = 1` if the consumer obeys `empty`, but an explicit validity contract or reset value for the output is safer. Resetting every RAM location is usually avoided because it can prevent block-RAM inference; resetting only an output register is much cheaper, subject to the target FPGA's inference rules.

### 3. Add elaboration-time parameter checks

Reject illegal widths early, for example `AW < 1` or `DW < 1`. If a separately configurable `DEPTH` is added later, verify that it matches the address range or add explicit non-power-of-two wrap logic.

### 4. State the read-during-write collision policy

If `waddr == raddr` and a read and write occur on the same edge, FPGA families can implement read-first, write-first, or no-change behavior differently. The current FIFO normally prevents harmful same-location access through `full`/`empty` control, but the intended collision behavior should still be documented and tested.

### 5. Decide boundary-cycle policy explicitly

The current acceptance rules are conservative:

```verilog
assign do_write = wr_en && !full;
assign do_read  = rd_en && !empty;
```

Consequently, a write requested while `full` is blocked even if a read is requested in that same cycle, and a read requested while `empty` is blocked even if a write is also requested. This is safe and simple. A higher-throughput FIFO may permit selected simultaneous boundary operations, but doing so requires carefully defined fall-through/bypass behavior.

### 6. Add assertions and stronger tests

Useful checks include:

- Never let `fifo_count` exceed `DEPTH`.
- Never decrement when empty or increment when full.
- Verify data ordering across repeated pointer wraps.
- Test simultaneous read/write at ordinary and boundary occupancies.
- Test multiple values of `AW` and `DW`, not only 4 and 8.

The existing integration testbench already covers fill/full, overflow blocking, FIFO order, underflow blocking, pointer reuse after wrap, and simultaneous read/write. Assertions and parameter sweeps would catch more corner cases automatically.

### 7. Tighten RTL style

For new SystemVerilog code, prefer `logic`, `always_ff`, and `always_comb`. Adding `` `default_nettype none `` can also catch misspelled signal names that would otherwise create unintended implicit wires. Keep the current single source of truth for `AW` and `DW`; that is already an important safety feature.

### 8. Fix the incomplete practice draft before simulating it

[`individual/ram/practice.v`](individual/ram/practice.v) uses `mem[waddr]` and `mem[raddr]`, but it does not currently declare `mem`. The active [`individual/ram/sync_ram.v`](individual/ram/sync_ram.v) contains the required declaration:

```verilog
reg [DW-1:0] mem [0:DEPTH-1];
```

The practice draft needs the equivalent declaration, using its lowercase names (`dw` and `depth`), before it can be treated as a complete RAM module. This page bases its timing and integration answers on the complete active `sync_ram.v` implementation.

### 9. Use a consistent simulation time unit

The testbenches declare `` `timescale 1ns/1ps ``, but the active RTL modules do not. The code compiles, although Icarus Verilog warns that those RTL modules inherit their time scale from another file. The current synthesizable modules contain no `#` delays, so this does not change their hardware behavior, but adding a consistent time-unit declaration (or using SystemVerilog `timeunit`/`timeprecision`) removes file-order dependence and compiler warnings.

## Points to remember

- `AW` is a bit width; `DEPTH` is a number of words.
- With a power-of-two depth, $\text{DEPTH} = 2^{AW}$.
- `[AW-1:0]` contains exactly `AW` bits.
- The occupancy count needs `AW+1` bits because it must represent both empty (0) and full (`DEPTH`).
- `DW` must match across the FIFO data ports and RAM word width unless explicit width-conversion logic exists.
- `output reg` is required here because `dout` is assigned in a clocked procedural block.
- The present RAM read is synchronous and always enabled; `do_read` currently controls only pointer movement.
- `empty` and `full` are part of the data-validity contract: never consume `rd_data` when a read was not accepted.
