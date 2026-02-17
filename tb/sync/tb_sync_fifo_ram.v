`timescale 1ns/1ps

module tb_sync_fifo_ram;

    localparam DW    = 8;
    localparam AW    = 4;
    localparam DEPTH = (1 << AW);

    reg                   clk;
    reg                   rst;
    reg                   wr_en;
    reg                   rd_en;
    reg  [DW-1:0] wr_data;
    wire [DW-1:0] rd_data;
    wire                  full;
    wire                  empty;

    integer i;
    reg [DW-1:0] expected;

    sync_fifo_ram #(
        .DW(DW),
        .AW(AW)
    ) dut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .full(full),
        .empty(empty)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task fail;
        input [1023:0] message;
        begin
            $display("TEST FAILED: %0s", message);
            $finish(1);
        end
    endtask

    initial begin
        rst     = 1'b1;
        wr_en   = 1'b0;
        rd_en   = 1'b0;
        wr_data = {DW{1'b0}};

        repeat (2) @(posedge clk);
        rst = 1'b0;

        @(posedge clk);
        #1;
        if (!empty) fail("FIFO should be empty after reset");
        if (full)   fail("FIFO should not be full after reset");

        for (i = 0; i < DEPTH; i = i + 1) begin
            @(negedge clk);
            wr_en   <= 1'b1;
            wr_data <= i[DW-1:0];
            @(posedge clk);
        end
        @(negedge clk);
        wr_en <= 1'b0;
        #1;

        if (!full) fail("FIFO should be full after DEPTH writes");

        @(negedge clk);
        wr_en   <= 1'b1;
        wr_data <= 8'hAA;
        @(posedge clk);
        @(negedge clk);
        wr_en <= 1'b0;
        #1;
        if (!full) fail("FIFO must remain full after blocked overflow write");

        for (i = 0; i < DEPTH; i = i + 1) begin
            @(negedge clk);
            rd_en <= 1'b1;
            @(posedge clk);
            expected  = i[DW-1:0];
            #1;
            if (rd_data !== expected) begin
                $display("Read mismatch at index %0d: expected=0x%0h got=0x%0h", i, expected, rd_data);
                fail("FIFO read order mismatch");
            end
        end

        @(negedge clk);
        rd_en <= 1'b0;
        #1;

        if (!empty) fail("FIFO should be empty after DEPTH reads");
        if (full)   fail("FIFO should not be full after all reads");

        $display("TEST PASSED: sync_fifo_ram + sync_ram");
        $finish;
    end

endmodule
