# Synchronous FIFO Review and Testing Lessons

This page preserves the useful learning material migrated from the former `SynchronousFifoTesting` repository before that extra repository was retired. Its duplicate RTL files were not copied because the active `ramAndFifo` implementation is better organized and already has self-checking testbenches.

Use this page as:

- a record of the mistakes found while building the first FIFO/RAM draft;
- a review checklist for future Verilog modules;
- a boundary-case and randomized-testing plan for the active implementation.

## Active implementation referenced here

- [Synchronous RAM](../sync_ram.v)
- [RAM-backed FIFO](../sync_fifo_ram.v)
- [RAM-backed FIFO testbench](../tb/sync/tb_sync_fifo_ram.v)
- [RAM questions and answers](../RAM_QNA.md)

## Important behavior difference

The retired testing draft and the active design do not have identical policies. Do not use the old behavior as if it were the current RTL contract.

| Topic | Retired testing draft | Active `ramAndFifo` design |
|---|---|---|
| Reset | Active-high asynchronous reset | Active-high synchronous reset in FIFO control |
| RAM read enable | Explicit `rd_en`; output holds when no read is accepted | No explicit read enable; RAM output samples `mem[raddr]` every rising edge |
| RAM output reset | `data_out` reset to zero | RAM output has no reset |
| Write while full plus simultaneous read | Write accepted because the read frees a slot | Write blocked by `full`; read accepted |
| Operation names | `canWrite`, `canRead` | `do_write`, `do_read` |

The active acceptance equations are:

```verilog
assign do_write = wr_en && !full;
assign do_read  = rd_en && !empty;
```

The retired draft used:

```verilog
assign canRead  = !empty && rd_en;
assign canWrite = (!full || canRead) && wr_en;
```

The second policy improves throughput on a full FIFO when a read and write are requested together. However, when a ring buffer is full, `waddr` and `raddr` can refer to the same physical RAM location. Performing the read and write together therefore depends on the target memory's read-during-write collision behavior. The design must explicitly choose and verify read-first, write-first, or no-change behavior before adopting that policy.

The active conservative policy avoids making that collision behavior part of the FIFO interface.

## Phase 1: debugging findings preserved from the first draft

| No. | Issue found | Why it mattered | Rule to remember |
|---:|---|---|---|
| 1 | `clk` was used but missing from the FIFO port list | The module could not compile or connect a clock correctly | Every externally driven signal used by a module must be declared in its interface |
| 2 | Invalid `case` syntax around `{canRead, canWrite}` | The occupancy-update logic did not compile | Write `case (expression)` and case items such as `2'b01:` without surrounding parentheses |
| 3 | A trailing comma appeared before `);` in a RAM port list | It produced a syntax error | Audit the final port entry when editing ANSI-style module declarations |
| 4 | The instance used `.wen(...)` while the RAM port was named `wr_en` | Named-port binding failed | Named connections must exactly match the child module's port names |
| 5 | Signal declarations did not match their drivers | A procedural assignment needs a variable; a child instance or `assign` drives a net | Determine who drives each signal before choosing `reg` or `wire` |
| 6 | `fifo_count` was not reset | `full` and `empty` could start unknown | Reset every control-state register that determines legal transactions |
| 7 | Pointers advanced on raw `rd_en` and `wr_en` | Reads while empty and writes while full could corrupt the ring state | Advance pointers only on accepted operations |
| 8 | Reset and normal logic were not isolated by a complete `if/else` | Normal updates could occur during reset | Keep all ordinary state transitions inside the reset block's `else` branch |
| 9 | RAM addresses were declared as one bit instead of `[AW-1:0]` | Most memory locations were unreachable | Address width is `AW` bits; depth is $2^{AW}$ words |
| 10 | Parameter override appeared after the instance name | The instance syntax was invalid | Parameter overrides belong between the module name and instance name |
| 11 | Both FIFO and RAM drove `dout` | Multiple drivers can produce errors or unknown values | A signal should have one intentional driver |
| 12 | An `end` closed the FIFO's normal branch before `endcase` | Part of the update logic sat outside its intended scope | Indent and pair `begin`/`end` around the complete state transition |
| 13 | RAM sampled an unwritten location while no valid read existed | `dout` could become `X` in simulation | Either gate the RAM read, provide a valid signal, or require consumers to ignore output without an accepted read |

### Correct parameterized instantiation pattern

```verilog
module_name #(
    .PARAM1(value1),
    .PARAM2(value2)
) instance_name (
    .port1(signal1),
    .port2(signal2)
);
```

For the active RAM-backed FIFO, the same `DW` and `AW` values are deliberately passed to the RAM so that one FIFO entry equals one RAM word and the FIFO pointer range equals the RAM address range.

### Correct reset and normal-operation scope

```verilog
always @(posedge clk) begin
    if (rst) begin
        // Reset all FIFO control state.
    end else begin
        if (do_read) begin
            // Advance the read pointer.
        end

        if (do_write) begin
            // Advance the write pointer.
        end

        case ({do_write, do_read})
            2'b10: fifo_count <= fifo_count + 1'b1;
            2'b01: fifo_count <= fifo_count - 1'b1;
            default: fifo_count <= fifo_count;
        endcase
    end
end
```

The operation order in the `case` expression must match the meaning of its case items. The active code uses `{do_write, do_read}`; reversing the concatenation without reversing the item meanings would invert the count updates.

## Phase 2: self-checking test strategy for the active design

### Transaction model

The testbench must distinguish a request from an accepted transaction:

- `wr_en = 1` requests a write.
- `rd_en = 1` requests a read.
- `do_write = 1` means a write was accepted.
- `do_read = 1` means a read was accepted.

A scoreboard must update only for accepted operations. Using raw enables in the reference model repeats the same mistake that once corrupted the RTL pointers.

### Occupancy model

| `do_write` | `do_read` | Expected occupancy change |
|---:|---:|---:|
| 0 | 0 | 0 |
| 0 | 1 | -1 |
| 1 | 0 | +1 |
| 1 | 1 | 0 |

At every checked clock edge:

$$
0 \leq \text{fifo\_count} \leq \text{DEPTH}
$$

The expected flags are:

$$
\text{empty} = (\text{fifo\_count} = 0)
$$

$$
\text{full} = (\text{fifo\_count} = \text{DEPTH})
$$

### Required directed cases

1. **Reset**
   - `empty` must assert.
   - `full` must deassert.
   - Both pointers and occupancy must return to zero.
   - Do not assume every RAM location was cleared.

2. **Single write and read**
   - Write one recognizable value.
   - Confirm `empty` deasserts.
   - Read it back after the synchronous RAM edge.
   - Confirm the FIFO becomes empty again.

3. **FIFO ordering**
   - Write several distinct values.
   - Read them back in exactly the same order.
   - Compare automatically rather than judging only from a waveform.

4. **Fill and overflow protection**
   - Perform exactly `DEPTH` accepted writes.
   - Confirm `full` asserts.
   - Request one more write without a read.
   - Confirm the write pointer, count, and stored sequence are unchanged.

5. **Drain and underflow protection**
   - Read exactly `DEPTH` entries.
   - Confirm `empty` asserts.
   - Request another read.
   - Confirm the read pointer and count do not change.

6. **Simultaneous read/write while partially filled**
   - Both operations must be accepted.
   - Both pointers advance.
   - Occupancy stays constant.
   - The oldest word is returned and the new word appears at the tail.

7. **Simultaneous read/write while full**
   - Under the current conservative policy, `do_read = 1` and `do_write = 0`.
   - Occupancy falls from `DEPTH` to `DEPTH-1`.
   - `full` deasserts after the edge.
   - The write must be retried on a later cycle if the producer still needs it accepted.

8. **Simultaneous read/write while empty**
   - `do_read = 0` and `do_write = 1`.
   - The cycle behaves as write-only.
   - Occupancy becomes one and `empty` deasserts.

9. **Repeated pointer wrap-around**
   - Perform enough interleaved operations for both pointers to wrap several times.
   - Confirm ordering and occupancy remain correct across every wrap.

10. **Parameter sweep**
    - Repeat tests with multiple valid `DW` and `AW` combinations.
    - This catches fixed-width constants and accidental assumptions about the default configuration.

### Randomized stress testing

After directed tests pass:

1. Randomize `wr_en`, `rd_en`, and `wr_data` for many clock cycles.
2. Maintain a reference queue containing every accepted write.
3. On each accepted read, compare `rd_data` with the oldest reference-queue entry.
4. Track expected occupancy and compare `full` and `empty` every cycle.
5. Use a fixed random seed in reported failures so the sequence is reproducible.
6. Run several seeds and small parameter configurations so full, empty, and wrap boundaries occur frequently.

### Assertions worth adding

- `fifo_count` never exceeds `DEPTH`.
- A blocked write never changes `wr_ptr`.
- A blocked read never changes `rd_ptr`.
- `empty` and `full` are never asserted together for a nonzero depth.
- Simultaneous accepted read/write leaves the occupancy unchanged.
- Every accepted read matches the oldest accepted, unread write.

## Why the duplicate RTL was not migrated

The retired `fifo.v` and `ramandfifo.v` were valuable as learning drafts, but the active repository already provides:

- clearer `DW`, `AW`, `DEPTH`, pointer, and count comments;
- separate individual and integration directories;
- standalone and integrated self-checking testbenches;
- overflow, underflow, ordering, wrap reuse, and simultaneous-operation checks;
- a simpler wrapper and a verification spreadsheet.

Copying the old RTL would create two competing implementations with different reset, read-enable, and full-boundary behavior. Preserving the lessons while keeping one active implementation makes the repository safer and easier to study.

## Points to remember

- A request is not necessarily an accepted transaction.
- Move pointers and update the scoreboard only on accepted operations.
- An `AW`-bit pointer naturally addresses $2^{AW}$ power-of-two locations.
- A FIFO occupancy counter needs to represent both zero and `DEPTH`.
- Registered synchronous RAM data becomes valid after the active clock edge.
- Full-boundary throughput optimizations can introduce same-address RAM collision requirements.
- A self-checking scoreboard proves much more than a waveform viewed by eye.
