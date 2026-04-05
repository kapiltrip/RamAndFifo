# RAM + FIFO Learning Workspace

This repository is a learning-focused RTL workspace for synchronous and asynchronous FIFO design, RAM integration, and simulation.

## Repo Layout

- repo root : active synchronous RAM and FIFO RTL
- `tb/sync/` : active synchronous testbenches
- `tb/archive/async/` : archived async testbenches kept for reference
- `docs/` : Q&A notes, TODOs, and project notes
- `docs/reference/` : PDFs and study material
- `build/` : simulation build outputs

## Current FIFO Modules

### Synchronous

- Standard RAM-backed FIFO: `sync_fifo_ram.v`
- Simpler user-style wrapper: `syncFifo.v`
- Shared RAM block: `sync_ram.v`
- Pure synchronous FIFO with internal memory: `sync_fifo.v`

### Archived Reference Material

- Short sync Q&A: `docs/FIFO_QNA.md`
- Long project Q&A: `docs/FIFO_RAM_QA.md`
- Archived async benches: `tb/archive/async/`

## Recommended Build Path (for the current repo)

1. Start with `sync_ram.v`.
2. Then read `sync_fifo_ram.v`.
3. If you want the same simpler naming style, use `syncFifo.v`.
4. Run the synchronous testbench first.
5. Use the archived async testbenches only as old reference material.

## What You Can Build Next (Practical Applications)

If you want to build something now, these are good project targets:

1. UART clock-domain bridge
- Producer: bytes from one clock domain.
- Consumer: UART TX domain.
- Async FIFO decouples bursty producer from serial output rate.

2. Sensor-to-processor stream buffer
- Producer: ADC/sensor sampling clock.
- Consumer: CPU/system clock.
- Async FIFO prevents data loss during burst reads.

3. AXI-Stream clock converter (mini version)
- Wrap your FIFO with `valid/ready` handshake.
- This is directly useful in FPGA data pipelines.

4. Audio pipeline bridge
- Producer: I2S sample clock domain.
- Consumer: DSP/system domain.
- Async FIFO smooths rate mismatch and jitter effects.

## Useful Commands

```powershell
# check the sync RAM-based FIFO and the simpler wrapper
iverilog -t null sync_ram.v sync_fifo_ram.v syncFifo.v

# check the pure sync FIFO with internal memory
iverilog -t null sync_fifo.v

# run the sync RAM FIFO testbench
iverilog -g2005-sv -o build/simv_sync tb/sync/tb_sync_fifo_ram.v sync_fifo_ram.v sync_ram.v
vvp build/simv_sync

# run the simpler naming-style sync wrapper testbench
iverilog -g2005-sv -o build/simv_sync_style tb/sync/tb_syncFifo.v syncFifo.v sync_fifo_ram.v sync_ram.v
vvp build/simv_sync_style

# run the pure sync FIFO testbench
iverilog -g2005-sv -o build/simv_sync_internal tb/sync/tb_sync_fifo.v sync_fifo.v
vvp build/simv_sync_internal
```
