`timescale 1ns/1ps

module tb_syncFifo;

    localparam dw    = 8;
    localparam aw    = 4;
    localparam depth = (1 << aw);

    reg            clk;
    reg            rst;
    reg            wren;
    reg            rden;
    reg  [dw-1:0]  din;
    wire [dw-1:0]  dout;
    wire           empty;
    wire           full;

    integer        i;
    reg  [dw-1:0]  expected;

    syncFifo #(
        .dw(dw),
        .aw(aw)
    ) dut (
        .clk  (clk),
        .rst  (rst),
        .wren (wren),
        .rden (rden),
        .din  (din),
        .dout (dout),
        .empty(empty),
        .full (full)
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
        rst  = 1'b1;
        wren = 1'b0;
        rden = 1'b0;
        din  = {dw{1'b0}};

        repeat (2) @(posedge clk);
        rst = 1'b0;

        @(posedge clk);
        #1;
        if (!empty) fail("FIFO should be empty after reset");
        if (full)   fail("FIFO should not be full after reset");

        for (i = 0; i < depth; i = i + 1) begin
            @(negedge clk);
            wren <= 1'b1;
            din  <= i[dw-1:0];
            @(posedge clk);
        end
        @(negedge clk);
        wren <= 1'b0;
        #1;

        if (!full) fail("FIFO should be full after depth writes");

        @(negedge clk);
        wren <= 1'b1;
        din  <= 8'h5A;
        @(posedge clk);
        @(negedge clk);
        wren <= 1'b0;
        #1;
        if (!full) fail("FIFO should stay full after blocked overflow write");

        for (i = 0; i < depth; i = i + 1) begin
            @(negedge clk);
            rden <= 1'b1;
            @(posedge clk);
            expected = i[dw-1:0];
            #1;
            if (dout !== expected) begin
                $display("Read mismatch at index %0d: expected=0x%0h got=0x%0h", i, expected, dout);
                fail("FIFO read order mismatch");
            end
        end

        @(negedge clk);
        rden <= 1'b0;
        #1;

        if (!empty) fail("FIFO should be empty after depth reads");
        if (full)   fail("FIFO should not be full after all reads");

        $display("TEST PASSED: syncFifo wrapper + sync_fifo_ram + sync_ram");
        $finish;
    end

endmodule
