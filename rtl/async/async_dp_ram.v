module async_fifo_dp_ram
  #(parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4)
(
    // Write port
    input  wire                      wclk,
    input  wire                      we,
    input  wire [ADDR_WIDTH-1:0]     waddr,
    input  wire [DATA_WIDTH-1:0]     din,

    // Read port
    input  wire                      rclk,
    input  wire [ADDR_WIDTH-1:0]     raddr,
    output reg  [DATA_WIDTH-1:0]     dout
);

    (* ram_style = "block" *) reg [DATA_WIDTH-1:0] mem [(1<<ADDR_WIDTH)-1:0];

    // Write port (sync to wclk)
    always @(posedge wclk) begin
        if (we) begin
            mem[waddr] <= din;
        end
    end

    // Read port (sync to rclk)
    always @(posedge rclk) begin
        dout <= mem[raddr];
    end

endmodule
