`timescale 1ns/1ps

// Reuse the existing self-checking standalone-FIFO testbench and observe its
// interface with the shared functional-coverage collector.
module tb_internal_fifo_coverage;

  tb_sync_fifo base();

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
