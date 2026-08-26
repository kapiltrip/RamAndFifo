`timescale 1ns/1ps

// Reuse the existing self-checking RAM-backed FIFO integration testbench and
// attach the same interface-level collector used by the standalone FIFO.
module tb_ram_backed_fifo_coverage;

  tb_sync_fifo_ram base();

  fifo_functional_coverage #(
    .dw(8)
  ) coverage (
    .clk(base.clk),
    .rst(base.rst),
    .wr_en(base.wr_en),
    .rd_en(base.rd_en),
    .din(base.wr_data),
    .dout(base.rd_data),
    .full(base.full),
    .empty(base.empty)
  );

endmodule
