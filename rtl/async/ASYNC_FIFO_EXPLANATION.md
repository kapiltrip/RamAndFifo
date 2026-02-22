# Asynchronous FIFO — Deep Code + Meaning + Why

This guide explains `rtl/async/async_fifo.v` in a **design-review style**:
- what each code block does,
- why each signal exists,
- why this specific architecture is used for asynchronous clock domains,
- and what practical behavior you should expect in real hardware.

---

## 0) First principles: what problem this FIFO solves

An asynchronous FIFO is used when:
- producer logic runs on `wr_clk`,
- consumer logic runs on `rd_clk`,
- and there is **no guaranteed phase/frequency relationship** between those clocks.

So we need three things simultaneously:
1. Correct storage ordering (FIFO behavior),
2. Safe cross-domain state sharing (CDC-safe),
3. Overflow/underflow prevention (`full`, `empty`).

This implementation is the standard robust solution:
- local arithmetic in **binary pointers**,
- cross-domain transfer in **Gray pointers**,
- two-flop synchronizers for CDC,
- full/empty from synchronized pointer comparisons.

---

## 1) Module boundary (the contract)

### Code part
```verilog
module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4   // FIFO depth = 2^ADDR_WIDTH
)(
    input  wire                   wr_clk,
    input  wire                   rd_clk,
    input  wire                   wr_rst_n,
    input  wire                   rd_rst_n,

    input  wire                   wr_en,
    input  wire [DATA_WIDTH-1:0]  wr_data,
    output wire                   full,

    input  wire                   rd_en,
    output reg  [DATA_WIDTH-1:0]  rd_data,
    output wire                   empty
);
```

### Meaning
- `wr_clk` / `rd_clk`: independent timing universes.
- `wr_en` + `full`: write handshake (`wr_en` is request, `!full` is acceptance).
- `rd_en` + `empty`: read handshake (`rd_en` is request, `!empty` is acceptance).
- `wr_rst_n` / `rd_rst_n`: per-domain reset control.

### Why only these I/O signals?
This is the **minimal complete interface** for a safe decoupling queue:
- Producer only needs backpressure (`full`).
- Consumer only needs data-availability (`empty`).
- No global count is required for correctness and often avoided in CDC designs.

---

## 2) FIFO depth and storage array

### Code part
```verilog
localparam DEPTH = (1 << ADDR_WIDTH);
reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
```

### Meaning
- `DEPTH = 2^ADDR_WIDTH`, classic power-of-2 ring buffer.
- `mem` is the circular storage.

### Why ring-buffer style?
A FIFO is naturally modeled as two walking pointers into a circular memory:
- write pointer marks next free slot,
- read pointer marks next unread slot.

This removes expensive shifting and gives O(1) enqueue/dequeue behavior in hardware.

---

## 3) Why pointers are `ADDR_WIDTH+1` bits (not only `ADDR_WIDTH`)

### Code part
```verilog
reg [ADDR_WIDTH:0] wr_ptr_bin, wr_ptr_bin_next;
reg [ADDR_WIDTH:0] wr_ptr_gray, wr_ptr_gray_next;

reg [ADDR_WIDTH:0] rd_ptr_bin, rd_ptr_bin_next;
reg [ADDR_WIDTH:0] rd_ptr_gray, rd_ptr_gray_next;
```

### Meaning
Each pointer has:
- lower `ADDR_WIDTH` bits = memory index,
- top extra bit = wrap/phase information.

### Why this extra bit is mandatory
If you only compare index bits:
- same index could mean either **empty** or **full** (ambiguous).

With an extra wrap bit:
- same index + same wrap => empty,
- same index + opposite wrap phase => full (after mapping in Gray form).

This is the key disambiguation trick in ring FIFOs.

---

## 4) Binary + Gray dual representation

### Code part
```verilog
reg [ADDR_WIDTH:0] wr_ptr_bin, wr_ptr_bin_next;
reg [ADDR_WIDTH:0] wr_ptr_gray, wr_ptr_gray_next;

reg [ADDR_WIDTH:0] rd_ptr_bin, rd_ptr_bin_next;
reg [ADDR_WIDTH:0] rd_ptr_gray, rd_ptr_gray_next;
```

### Meaning
Two pointer forms per side:
- Binary for local arithmetic and addressing.
- Gray for cross-domain transport.

### Why not keep everything binary?
Binary can change many bits at once (e.g., `0111 -> 1000`), and if sampled asynchronously, receiver may observe a mixed intermediate value.

Gray code changes one bit per increment, drastically lowering invalid-sample risk when crossing domains.

---

## 5) CDC synchronizer registers

### Code part
```verilog
reg [ADDR_WIDTH:0] rd_ptr_gray_sync1, rd_ptr_gray_sync2;
reg [ADDR_WIDTH:0] wr_ptr_gray_sync1, wr_ptr_gray_sync2;
```

### Meaning
- `rd_ptr_gray_sync*`: read pointer safely enters write domain.
- `wr_ptr_gray_sync*`: write pointer safely enters read domain.

### Why two flops (`sync1`, `sync2`)?
The first flop may become metastable if sampling near transition.
Second flop provides an extra cycle for metastability to settle, improving MTBF significantly.

### Why synchronize pointers, not data bus?
Data payload remains in memory; domains do not bitwise-synchronize `wr_data`/`rd_data` directly. What must cross safely is **state** (where read/write are).

---

## 6) Binary-to-Gray conversion utility

### Code part
```verilog
function [ADDR_WIDTH:0] bin2gray;
    input [ADDR_WIDTH:0] bin;
    begin
        bin2gray = (bin >> 1) ^ bin;
    end
endfunction
```

### Meaning
Classic `Gray = bin ^ (bin >> 1)`.

### Why it matters here
This guarantees adjacent count values differ by one bit, enabling safer async sampling of moving pointers.

---

## 7) Write-domain next pointer logic

### Code part
```verilog
always @(*) begin
    wr_ptr_bin_next = wr_ptr_bin;
    if (wr_en && !full)
        wr_ptr_bin_next = wr_ptr_bin + 1'b1;
end

assign wr_ptr_gray_next = bin2gray(wr_ptr_bin_next);
```

### Meaning
- Default hold pointer.
- Increment only on accepted writes.
- Compute Gray form of next value for flag logic.

### Why `wr_en && !full`
- `wr_en`: producer requests write.
- `!full`: FIFO grants write.
- Increment only on grant keeps pointer/data aligned.

### Why full uses “next write pointer” later
Using `wr_ptr_gray_next` in full compare is proactive: it blocks the exact write that would overflow.

---

## 8) Write-domain state registers

### Code part
```verilog
always @(posedge wr_clk or negedge wr_rst_n) begin
    if (!wr_rst_n) begin
        wr_ptr_bin  <= {(ADDR_WIDTH+1){1'b0}};
        wr_ptr_gray <= {(ADDR_WIDTH+1){1'b0}};
    end else begin
        wr_ptr_bin  <= wr_ptr_bin_next;
        wr_ptr_gray <= wr_ptr_gray_next;
    end
end
```

### Meaning
This block is the **single source of truth** for write-domain pointer state.
- `wr_ptr_bin` is the committed write pointer in binary (used for arithmetic + memory index).
- `wr_ptr_gray` is the committed write pointer in Gray code (used for CDC export to read side).

Combinational logic (`wr_ptr_*_next`) decides what should happen this cycle; this sequential block is where that decision becomes architecturally real on the clock edge.

### Why these assignments exist at all
Without this register stage, pointers would be purely combinational and could glitch within a cycle. That would be dangerous because:
- Memory write address must be stable at the active clock edge.
- `full` logic depends on a coherent pointer value.
- Cross-domain synchronization expects a clean, clocked Gray pointer, not a transient combinational value.

So this block enforces the normal synchronous pattern:
1. Compute next state combinationally.
2. Commit next state synchronously.
3. Use committed state as the official FIFO state.

### Why assign `wr_ptr_bin <= wr_ptr_bin_next`
`wr_ptr_bin` is the pointer that directly represents write progress in the local domain.
- It must update only on `wr_clk` edges so write-side behavior is deterministic.
- It must be held when write is not accepted (`!wr_en` or `full`) so no phantom advance occurs.
- It must increment exactly once per accepted write so each write consumes one slot.

In other words, this assignment preserves the FIFO invariant:
`number_of_committed_writes` advances only when a real write handshake occurs.

### Why assign `wr_ptr_gray <= wr_ptr_gray_next`
`wr_ptr_gray` is not "extra"; it is the CDC-safe representation of the same pointer state.
- The read domain never sees `wr_ptr_bin` directly.
- The read domain's empty logic compares synchronized Gray pointers.
- Therefore `wr_ptr_gray` must be updated in lockstep with `wr_ptr_bin` every cycle.

If Gray were derived later from an already-synchronized binary pointer, CDC safety would be broken (multi-bit async sampling risk). The design is correct because conversion is done in write domain first, then Gray crosses domains.

### Why reset sets both to all zeros
```verilog
wr_ptr_bin  <= {(ADDR_WIDTH+1){1'b0}};
wr_ptr_gray <= {(ADDR_WIDTH+1){1'b0}};
```
Reset must establish a mathematically consistent state:
- Binary zero corresponds to Gray zero.
- Both domains start from known equal pointers.
- Equal pointers represent empty FIFO after synchronization latency.

If only one encoding were reset or values differed, the two domains could temporarily disagree on occupancy and generate false `full`/`empty`.

### Why the reset is asynchronous (`or negedge wr_rst_n`)
The write domain must be forceable to a safe pointer state even if `wr_clk` is not currently toggling.
That helps guarantee deterministic startup/bring-up and avoids relying on "wait for first clock" behavior to clear stale state.

### Why non-blocking assignments (`<=`) are mandatory here
These are state registers, so non-blocking updates ensure all sequential signals sample old values and update together at the edge.
That avoids simulation race behavior and matches real flip-flop hardware semantics.

### Practical consequence
This block gives you a robust contract:
- Before edge: `wr_ptr_*_next` expresses intent.
- At edge: intent is committed.
- After edge: committed pointer state is stable for memory write indexing, full detection pipeline, and CDC export.

---

## 9) Write operation into memory

### Code part
```verilog
always @(posedge wr_clk) begin
    if (wr_en && !full)
        mem[wr_ptr_bin[ADDR_WIDTH-1:0]] <= wr_data;
end
```

### Meaning
- On accepted write, store payload at current write index.
- Index uses only lower bits (MSB is phase, not address).

### Why current pointer indexes memory
Current pointer identifies slot being written **this cycle**; pointer increment represents next free slot **after** write acceptance.

---

## 10) Bring read pointer into write domain

### Code part
```verilog
always @(posedge wr_clk or negedge wr_rst_n) begin
    if (!wr_rst_n) begin
        rd_ptr_gray_sync1 <= {(ADDR_WIDTH+1){1'b0}};
        rd_ptr_gray_sync2 <= {(ADDR_WIDTH+1){1'b0}};
    end else begin
        rd_ptr_gray_sync1 <= rd_ptr_gray;
        rd_ptr_gray_sync2 <= rd_ptr_gray_sync1;
    end
end
```

### Meaning
Write side receives delayed but safe read position.

### Why delay is acceptable
Async flags are intentionally conservative. Slight lag may keep `full` asserted a bit longer, but never allows overflow.

---

## 11) Full flag equation (most important line)

### Code part
```verilog
assign full = (wr_ptr_gray_next == 
              {~rd_ptr_gray_sync2[ADDR_WIDTH:ADDR_WIDTH-1],
                rd_ptr_gray_sync2[ADDR_WIDTH-2:0]});
```

### Meaning
FIFO is full when advancing write pointer would place it one full-buffer lap ahead of read pointer.

### Why invert top two Gray bits?
For Gray-coded ring pointers, full condition corresponds to:
- same lower bits,
- inverted upper phase-related bits.

This transformation is the Gray-domain equivalent of “binary pointers differ by DEPTH”.

### Why this prevents overflow
Because check is against `wr_ptr_gray_next`, the write that would collide with unread data is blocked before commit.

---

## 12) Read-domain next pointer logic

### Code part
```verilog
always @(*) begin
    rd_ptr_bin_next = rd_ptr_bin;
    if (rd_en && !empty)
        rd_ptr_bin_next = rd_ptr_bin + 1'b1;
end

always @(*) begin
    rd_ptr_gray_next = (rd_ptr_bin_next >> 1) ^ rd_ptr_bin_next;
end
```

### Meaning
Read pointer advances only on accepted reads.

### Why symmetric to write side
FIFO correctness depends on independent but analogous producer/consumer state machines.

---

## 13) Read-domain state registers

### Code part
```verilog
always @(posedge rd_clk or negedge rd_rst_n) begin
    if (!rd_rst_n) begin
        rd_ptr_bin  <= {(ADDR_WIDTH+1){1'b0}};
        rd_ptr_gray <= {(ADDR_WIDTH+1){1'b0}};
    end else begin
        rd_ptr_bin  <= rd_ptr_bin_next;
        rd_ptr_gray <= rd_ptr_gray_next;
    end
end
```

### Meaning
Owns consumer-side progression through queue.

### Why separate reset from write side
If consumer domain restarts independently, local pointer/synchronizers must recover safely without relying on write clock timing.

---

## 14) Read operation from memory

### Code part
```verilog
always @(posedge rd_clk) begin
    if (rd_en && !empty)
        rd_data <= mem[rd_ptr_bin[ADDR_WIDTH-1:0]];
end
```

### Meaning
On successful read, capture memory word into `rd_data`.

### Why `rd_data` is `reg`
Output is registered in read domain for stable timing and clean consumer interface.

---

## 15) Bring write pointer into read domain

### Code part
```verilog
always @(posedge rd_clk or negedge rd_rst_n) begin
    if (!rd_rst_n) begin
        wr_ptr_gray_sync1 <= {(ADDR_WIDTH+1){1'b0}};
        wr_ptr_gray_sync2 <= {(ADDR_WIDTH+1){1'b0}};
    end else begin
        wr_ptr_gray_sync1 <= wr_ptr_gray;
        wr_ptr_gray_sync2 <= wr_ptr_gray_sync1;
    end
end
```

### Meaning
Read side obtains safe, delayed write position for empty detection.

---

## 16) Empty flag equation

### Code part
```verilog
assign empty = (rd_ptr_gray == wr_ptr_gray_sync2);
```

### Meaning
If current read pointer equals synchronized write pointer, no unread entries remain.

### Why this prevents underflow
Consumer can assert `rd_en`, but pointer/data only advance when `!empty`. So stale/invalid read is blocked.

---

## 17) Lifecycle examples (intuitive timing)

### After reset
- Pointers all 0.
- `empty = 1`, `full = 0`.
- First accepted write clears empty after CDC latency into read domain.

### Continuous writes, slow reader
- Write pointer advances faster.
- Full eventually asserts when unread occupancy reaches capacity.
- Producer is backpressured until reader drains entries.

### Continuous reads, slow writer
- Read pointer catches write pointer.
- Empty asserts and blocks further reads until new writes arrive and cross sync.

---

## 18) Important CDC consequences you should expect

1. **Flag latency is normal**
   - `full`/`empty` use synchronized remote pointers.
   - They can assert/deassert a few local cycles after true occupancy changes.

2. **Safety over immediacy**
   - This design prefers conservative flags to guarantee no overflow/underflow.

3. **No exact instant cross-domain occupancy**
   - Exact count visible simultaneously in both domains is not trivial/safe without extra CDC machinery.

---

## 19) Signal glossary (why each exists)

- `wr_clk`, `rd_clk`: independent timing references.
- `wr_rst_n`, `rd_rst_n`: independent domain initialization.
- `wr_en`, `rd_en`: local operation requests.
- `full`, `empty`: local safety gates.
- `wr_data`, `rd_data`: payload ingress/egress.
- `mem`: shared storage array.
- `*_ptr_bin`: local pointer arithmetic and memory indexing.
- `*_ptr_gray`: CDC-transport pointer form.
- `*_ptr_*_next`: combinational next-state prediction.
- `*_sync1/*_sync2`: metastability mitigation pipeline.

---

## 20) Why this architecture is used in real designs

This exact structure (binary local + Gray CDC + 2FF sync + pointer compare flags) is common in FPGA/ASIC FIFOs because it provides:
- simple logic,
- synthesis-friendly implementation,
- strong practical CDC robustness,
- and predictable behavior across unrelated clocks.

In short: these are not arbitrary signals; each one exists to solve a specific asynchronous safety or flow-control requirement.

---

## 21) One subtle implementation detail in this file

In this code:
- Write side computes Gray via `bin2gray(...)` function.
- Read side computes Gray inline via expression `(bin >> 1) ^ bin`.

Functionally these are equivalent. If you want style consistency only, you could use the same function in both places, but behavior is already correct.
