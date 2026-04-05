module syncFifo #(
    parameter dw = 8,
    parameter aw = 4
) (
    input  wire          clk,
    input  wire          rst,
    input  wire          wren,
    input  wire          rden,
    input  wire [dw-1:0] din,
    output wire [dw-1:0] dout,
    output wire          empty,
    output wire          full
);

    // Keep the user-facing naming simple while reusing the verified RAM FIFO core.
    sync_fifo_ram #(
        .DW(dw),
        .AW(aw)
    ) u_sync_fifo_ram (
        .clk    (clk),
        .rst    (rst),
        .wr_en  (wren),
        .rd_en  (rden),
        .wr_data(din),
        .rd_data(dout),
        .full   (full),
        .empty  (empty)
    );

endmodule
