module sync_ram
  #(parameter DW = 8,
    parameter AW = 4)
(
    input      wire             clk,
    input      wire             we,
    // Address ports are AW bits because valid locations are 0..(2^AW - 1).
    // Example AW=4 => address width 4 bits => 16 entries indexed 0..15.
    input      wire [AW-1:0]    waddr,
    input      wire [AW-1:0]    raddr,
    input      wire [DW-1:0]    din,
    output reg [DW-1:0]         dout
);

    // DEPTH is total number of memory entries.
    // AW is a bit-width, so entry count is 2^AW.
    localparam DEPTH = (1 << AW);

    // Synchronous dual-port RAM inference style.
    // mem index range is 0..DEPTH-1, which exactly matches AW-bit address range.
    (* ram_style = "block" *) reg [DW-1:0] mem [0:DEPTH-1];

    always @(posedge clk) begin
        if (we) begin
            mem[waddr] <= din;
        end
        dout <= mem[raddr];
    end

endmodule
