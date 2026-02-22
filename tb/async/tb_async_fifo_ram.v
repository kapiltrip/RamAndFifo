`timescale 1ns/1ps

module tb_async_fifo_ram;

    localparam DW    = 8;
    localparam AW    = 4;
    localparam DEPTH = (1 << AW);

    reg                 wr_clk;
    reg                 rd_clk;
    reg                 rst_n;
    reg                 wr_en;
    reg                 rd_en;
    reg  [DW-1:0]       wr_data;
    wire [DW-1:0]       rd_data;
    wire                full;
    wire                empty;

    reg  [DW-1:0]       model_mem [0:4095];
    reg  [DW-1:0]       expected_rd;

    integer             seed;
    integer             wr_accept_count;
    integer             rd_accept_count;
    integer             model_widx;
    integer             model_ridx;
    integer             wr_start;
    integer             rd_start;

    async_fifo #(
        .DATA_WIDTH(DW),
        .ADDR_WIDTH(AW)
    ) dut (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .wr_rst_n(rst_n),
        .rd_rst_n(rst_n),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .full(full),
        .empty(empty)
    );

    initial begin
        wr_clk = 1'b0;
        forever #4 wr_clk = ~wr_clk; // 125 MHz
    end

    initial begin
        rd_clk = 1'b0;
        forever #7 rd_clk = ~rd_clk; // ~71 MHz
    end

    task fail;
        input [1023:0] message;
        begin
            $display("TEST FAILED: %0s", message);
            $display("State: wacc=%0d racc=%0d mw=%0d mr=%0d full=%b empty=%b",
                     wr_accept_count, rd_accept_count, model_widx, model_ridx, full, empty);
            $finish(1);
        end
    endtask

    // Scoreboard write side: record every accepted write.
    always @(posedge wr_clk) begin
        if (wr_en && !full) begin
            model_mem[model_widx] = wr_data;
            model_widx            = model_widx + 1;
            wr_accept_count       = wr_accept_count + 1;
        end
    end

    // Scoreboard read side: compare every accepted read.
    always @(posedge rd_clk) begin
        if (rd_en && !empty) begin
            expected_rd     = model_mem[model_ridx];
            model_ridx      = model_ridx + 1;
            rd_accept_count = rd_accept_count + 1;
            #1;
            if (rd_data !== expected_rd) begin
                $display("Read mismatch: expected=0x%0h got=0x%0h", expected_rd, rd_data);
                fail("async FIFO data order mismatch");
            end
        end
    end

    initial begin
        rst_n           = 1'b0;
        wr_en           = 1'b0;
        rd_en           = 1'b0;
        wr_data         = {DW{1'b0}};
        seed            = 0;
        wr_accept_count = 0;
        rd_accept_count = 0;
        model_widx      = 0;
        model_ridx      = 0;
        wr_start        = 0;
        rd_start        = 0;

        repeat (4) @(posedge wr_clk);
        repeat (4) @(posedge rd_clk);
        rst_n = 1'b1;

        // Phase 1: fill FIFO to full.
        while (wr_accept_count < DEPTH) begin
            @(negedge wr_clk);
            wr_en   <= 1'b1;
            wr_data <= seed[DW-1:0];
            seed    = seed + 1;
        end
        @(negedge wr_clk);
        wr_en <= 1'b0;
        repeat (2) @(posedge wr_clk);
        if (!full) fail("FIFO should be full after DEPTH writes");

        // Phase 2: drain FIFO to empty.
        while (rd_accept_count < DEPTH) begin
            @(negedge rd_clk);
            rd_en <= 1'b1;
        end
        @(negedge rd_clk);
        rd_en <= 1'b0;
        repeat (2) @(posedge rd_clk);
        if (!empty) fail("FIFO should be empty after DEPTH reads");

        // Phase 3: concurrent async traffic to exercise wrap and CDC logic.
        wr_start = wr_accept_count;
        rd_start = rd_accept_count;

        fork
            begin
                while ((wr_accept_count - wr_start) < (DEPTH * 2)) begin
                    @(negedge wr_clk);
                    wr_en   <= 1'b1;
                    wr_data <= seed[DW-1:0];
                    seed    = seed + 1;
                end
                @(negedge wr_clk);
                wr_en <= 1'b0;
            end
            begin
                repeat (3) @(posedge rd_clk);
                while ((rd_accept_count - rd_start) < (DEPTH * 2)) begin
                    @(negedge rd_clk);
                    rd_en <= 1'b1;
                end
                @(negedge rd_clk);
                rd_en <= 1'b0;
            end
        join

        // Final drain in case any words remain queued.
        while (!empty) begin
            @(negedge rd_clk);
            rd_en <= 1'b1;
        end
        @(negedge rd_clk);
        rd_en <= 1'b0;
        repeat (2) @(posedge rd_clk);

        if (model_ridx != model_widx) fail("Not all written words were read");
        if (!empty) fail("FIFO should be empty at end of test");

        $display("TEST PASSED: async_fifo (internal memory)");
        $finish;
    end

endmodule
