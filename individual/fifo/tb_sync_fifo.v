`timescale 1ns/1ps

module tb_sync_fifo;

    localparam DW    = 8;
    localparam AW    = 4;
    localparam DEPTH = (1 << AW);

    reg               clk;
    reg               rst;
    reg               wr_en;
    reg               rd_en;
    reg  [DW-1:0]     wr_data;
    wire [DW-1:0]     rd_data;
    wire              full;
    wire              empty;

    integer           i;
    reg  [DW-1:0]     expected;

    sync_fifo #(
        .DW(DW),
        .AW(AW)
    ) dut (
        .clk    (clk),
        .rst    (rst),
        .wr_en  (wr_en),
        .rd_en  (rd_en),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .full   (full),
        .empty  (empty)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task fail;
        input [1023:0] message;
        begin
            $fatal(1, "FIFO UNIT FAIL: %0s", message);
        end
    endtask

    initial begin
        $timeformat(-9, 0, " ns", 8);
        rst     = 1'b1;
        wr_en   = 1'b0;
        rd_en   = 1'b0;
        wr_data = {DW{1'b0}};

        $display("TC-FIFO-01: reset flags");
        repeat (2) @(posedge clk);
        rst = 1'b0;

        @(posedge clk);
        #1;
        if (!empty) fail("FIFO should be empty after reset");
        if (full)   fail("FIFO should not be full after reset");

        $display("TC-FIFO-02: fill to full");
        for (i = 0; i < DEPTH; i = i + 1) begin
            @(negedge clk);
            wr_en   <= 1'b1;
            wr_data <= i[DW-1:0];
            @(posedge clk);
        end
        $display("TC-FIFO-03: block overflow");
        @(negedge clk);
        wr_en <= 1'b0;
        #1;

        if (!full) fail("FIFO should be full after DEPTH writes");

        @(negedge clk);
        wr_en   <= 1'b1;
        wr_data <= 8'hA5;
        @(posedge clk);
        @(negedge clk);
        wr_en <= 1'b0;
        #1;
        if (!full) fail("FIFO should remain full after blocked overflow write");

        $display("TC-FIFO-04: FIFO order and empty flag");
        for (i = 0; i < DEPTH; i = i + 1) begin
            @(negedge clk);
            rd_en <= 1'b1;
            @(posedge clk);
            expected = i[DW-1:0];
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

        $display("TC-FIFO-05: block underflow");
        @(negedge clk);
        rd_en <= 1'b1;
        @(posedge clk);
        @(negedge clk);
        rd_en <= 1'b0;
        #1;
        if (!empty) fail("FIFO should remain empty after underflow attempt");

        $display("FIFO UNIT RESULT: PASS - 5 basic cases verified");
        $finish;
    end

endmodule
