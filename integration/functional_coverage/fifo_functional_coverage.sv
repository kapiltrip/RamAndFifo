`timescale 1ns/1ps

// Reusable interface-level coverage for either FIFO implementation in this repo.
// The coverpoints and crosses preserve the model used by the Namaste FPGA V136
// FIFO project; only the surrounding reusable module and corrected comments are new.
module fifo_functional_coverage #(
  parameter integer dw = 8
) (
  input wire clk,
  input wire rst,
  input wire wr_en,
  input wire rd_en,
  input wire [dw-1:0] din,
  input wire [dw-1:0] dout,
  input wire full,
  input wire empty
);

`ifndef NO_FUNCTIONAL_COVERAGE
  covergroup c @(posedge clk);
    option.per_instance = 1;

    coverpoint empty {
      bins empty_low = {0};
      bins empty_high = {1};
    }

    coverpoint full {
      bins full_low = {0};
      bins full_high = {1};
    }

    coverpoint rst {
      bins rst_low = {0};
      bins rst_high = {1};
    }

    coverpoint wr_en {
      bins wr_en_low = {0};
      bins wr_en_high = {1};
    }

    coverpoint rd_en {
      bins rd_en_low = {0};
      bins rd_en_high = {1};
    }

    coverpoint din {
      bins lower_din = {[0:84]};
      bins mid_din = {[85:169]};
      bins high_din = {[170:255]};
    }

    coverpoint dout {
      bins lower_dout = {[0:84]};
      bins mid_dout = {[85:169]};
      bins high_dout = {[170:255]};
    }

    // Relate each request to reset, data, and the FIFO boundary flags.
    cross_wr_en_rst: cross rst, wr_en {
      ignore_bins reset_high = binsof(rst) intersect {1}; // write enable does not matter during reset
      ignore_bins wr_en_low = binsof(wr_en) intersect {0}; // ignore cycles without a write request
    }

    cross_rd_en_rst: cross rst, rd_en {
      ignore_bins reset_high = binsof(rst) intersect {1}; // read enable does not matter during reset
      ignore_bins rd_en_low = binsof(rd_en) intersect {0}; // ignore cycles without a read request
    }

    cross_wr_din: cross rst, wr_en, din {
      ignore_bins reset_high = binsof(rst) intersect {1};
      ignore_bins wr_en_low = binsof(wr_en) intersect {0};
    }

    cross_rd_din: cross rst, rd_en, dout {
      ignore_bins reset_high = binsof(rst) intersect {1};
      ignore_bins rd_en_low = binsof(rd_en) intersect {0};
    }

    cross_full_wr: cross rst, wr_en, full {
      ignore_bins full_wr_en = binsof(full) intersect {1}; // a full FIFO blocks this write policy
      ignore_bins rst_high = binsof(rst) intersect {1};
      ignore_bins wr_en_low = binsof(wr_en) intersect {0};
    }

    cross_empty_rd: cross rst, rd_en, empty {
      ignore_bins empty_rd_en = binsof(empty) intersect {1}; // an empty FIFO blocks the read
      ignore_bins rst_high = binsof(rst) intersect {1};
      ignore_bins rd_en_low = binsof(rd_en) intersect {0};
    }
  endgroup

  c ci;

  initial begin
    ci = new();
  end
`else
  // Icarus Verilog does not implement covergroups. Defining
  // NO_FUNCTIONAL_COVERAGE keeps a wiring/regression smoke test available
  // without pretending that coverage was collected.
  initial begin
    $display("COVERAGE NOTE: collector disabled for non-covergroup smoke run");
  end
`endif

endmodule
