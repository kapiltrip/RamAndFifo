`timescale 1ns/1ps

// Integration test: FIFO control storing data through the separate sync_ram block.
module tb_sync_fifo_ram;

    localparam DW    = 8;
    localparam AW    = 4;
    localparam DEPTH = (1 << AW);

    reg              clk;
    reg              rst;
    reg              wr_en;
    reg              rd_en;
    reg  [DW-1:0]    wr_data;
    wire [DW-1:0]    rd_data;
    wire             full;
    wire             empty;

    integer i;
    integer error_count;

    sync_fifo_ram #(.DW(DW), .AW(AW)) dut (
        .clk(clk), .rst(rst), .wr_en(wr_en), .rd_en(rd_en),
        .wr_data(wr_data), .rd_data(rd_data), .full(full), .empty(empty)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task check;
        input condition;
        input [8*80-1:0] message;
        begin
            if (condition !== 1'b1) begin
                error_count = error_count + 1;
                $display("  FAIL: %0s", message);
            end
        end
    endtask

    task write_word;
        input [DW-1:0] data;
        begin
            @(negedge clk);
            wr_en   = 1'b1;
            rd_en   = 1'b0;
            wr_data = data;
            @(posedge clk);
            #1 wr_en = 1'b0;
        end
    endtask

    task read_word;
        input [DW-1:0] expected;
        begin
            @(negedge clk);
            wr_en = 1'b0;
            rd_en = 1'b1;
            @(posedge clk);
            #1;
            if (rd_data !== expected)
                $display("       expected=0x%0h got=0x%0h", expected, rd_data);
            check(rd_data === expected, "FIFO output order is incorrect");
            rd_en = 1'b0;
        end
    endtask

    initial begin
        $timeformat(-9, 0, " ns", 8);
        rst = 1'b1;
        wr_en = 1'b0;
        rd_en = 1'b0;
        wr_data = 0;
        error_count = 0;

        $display("TC-INT-01: integrated reset behavior");
        repeat (2) @(posedge clk);
        #1;
        check(empty === 1'b1, "empty must be 1 after reset");
        check(full  === 1'b0, "full must be 0 after reset");
        @(negedge clk);
        rst = 1'b0;

        $display("TC-INT-02: fill RAM-backed FIFO and check full");
        for (i = 0; i < DEPTH; i = i + 1)
            write_word(8'h20 + i);
        check(full === 1'b1, "full must assert after DEPTH writes");

        $display("TC-INT-03: overflow write must be blocked");
        write_word(8'hEE);
        check(full === 1'b1, "FIFO must remain full after overflow attempt");

        $display("TC-INT-04: read data back from RAM in FIFO order");
        for (i = 0; i < DEPTH; i = i + 1)
            read_word(8'h20 + i);
        check(empty === 1'b1, "empty must assert after all words are read");

        $display("TC-INT-05: underflow read must be blocked");
        @(negedge clk);
        rd_en = 1'b1;
        @(posedge clk);
        #1 rd_en = 1'b0;
        check(empty === 1'b1, "FIFO must remain empty after underflow attempt");

        $display("TC-INT-06: RAM addresses work after pointer wrap");
        write_word(8'h5A);
        read_word(8'h5A);
        check(empty === 1'b1, "FIFO must be reusable after pointer wrap");

        $display("TC-INT-07: simultaneous RAM read and write");
        write_word(8'hA1);
        write_word(8'hA2);
        @(negedge clk);
        wr_en   = 1'b1;
        rd_en   = 1'b1;
        wr_data = 8'hA3;
        @(posedge clk);
        #1;
        check(rd_data === 8'hA1, "simultaneous operation must read the oldest word");
        wr_en = 1'b0;
        rd_en = 1'b0;
        read_word(8'hA2);
        read_word(8'hA3);
        check(empty === 1'b1, "simultaneous operation must preserve FIFO order");

        if (error_count == 0) begin
            $display("INTEGRATION RESULT: PASS - RAM and FIFO work together");
            $finish;
        end else begin
            $fatal(1, "INTEGRATION RESULT: FAIL - %0d errors", error_count);
        end
    end

endmodule
