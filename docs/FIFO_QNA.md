# FIFO Q&A

## 1. Why are `do_write` and `do_read` independent in a synchronous FIFO?

Because a FIFO can legally do a write and a read in the same clock cycle.

```verilog
if (do_write) begin
    wr_ptr <= wr_ptr + 1'b1;
end

if (do_read) begin
    rd_ptr <= rd_ptr + 1'b1;
end
```

This is correct because:

- If only `do_write=1`, the write pointer moves forward.
- If only `do_read=1`, the read pointer moves forward.
- If both are `1`, both pointers move forward in the same cycle.
- In the simultaneous read/write case, FIFO occupancy does not change, so `fifo_count` stays the same.

That matches FIFO behavior exactly.

If this were written as `if (...) ... else if (...) ...`, then a simultaneous read and write would update only one pointer, which would be wrong.

## 2. Why reset `wr_ptr`, `rd_ptr`, and `fifo_count`, but not `rd_data`?

Because `wr_ptr`, `rd_ptr`, and `fifo_count` are the FIFO's internal control state.

- `wr_ptr` tells the FIFO where the next write goes.
- `rd_ptr` tells the FIFO where the next read comes from.
- `fifo_count` tells the FIFO how many valid entries currently exist.

After reset, these must be known so the FIFO starts in a correct empty state.

`rd_data` is different. It is only the output data bus. In this design, it comes from RAM:

```verilog
dout <= mem[raddr];
```

The RAM contents are not cleared on reset, so `rd_data` is not guaranteed to become zero after reset. That is usually fine, because when the FIFO is empty, `rd_data` is not valid and should be ignored.

The validity of the output is indicated by `empty`, not by `rd_data == 0`.

## Takeaway

`fifo_count` is not payload data. It is part of the FIFO's internal state, more precisely its control state.

That is why it must be reset.

`rd_data` does not define whether the FIFO is empty or valid. It is just the current RAM output, and it only matters when a read is valid.
