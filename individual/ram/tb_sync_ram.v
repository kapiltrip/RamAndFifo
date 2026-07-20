`timescale 1ns/1ps

module tb_sync_ram;

    localparam DW    = 8;
    localparam AW    = 4;
    localparam DEPTH = (1 << AW);

    reg             clk;
    reg             we;
    reg  [AW-1:0]   waddr;
    reg  [AW-1:0]   raddr;
    reg  [DW-1:0]   din;
    wire [DW-1:0]   dout;

    integer i;
    integer error_count;
    reg [DW-1:0] expected;

    sync_ram #(.DW(DW), .AW(AW)) dut (
        .clk(clk), .we(we), .waddr(waddr), .raddr(raddr),
        .din(din), .dout(dout)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        $timeformat(-9, 0, " ns", 8);
        we = 0;
        waddr = 0;
        raddr = 0;
        din = 0;
        error_count = 0;

        $display("TC-RAM-01: write and read every address");
        for (i = 0; i < DEPTH; i = i + 1) begin
            @(negedge clk);
            we    = 1'b1;
            waddr = i;
            din   = 8'hA0 + i;
        end

        @(negedge clk);
        we = 1'b0;

        for (i = 0; i < DEPTH; i = i + 1) begin
            @(negedge clk);
            raddr = i;
            @(posedge clk);
            #1;
            expected = 8'hA0 + i;
            if (dout !== expected) begin
                error_count = error_count + 1;
                $display("  FAIL addr=%0d expected=0x%0h got=0x%0h",
                         i, expected, dout);
            end
        end

        $display("TC-RAM-02: we=0 must protect stored data");
        @(negedge clk);
        we    = 1'b0;
        waddr = 5;
        din   = 8'hFF;
        @(posedge clk);

        @(negedge clk);
        raddr = 5;
        @(posedge clk);
        #1;
        if (dout !== 8'hA5) begin
            error_count = error_count + 1;
            $display("  FAIL: we=0 changed RAM data, got=0x%0h", dout);
        end

        if (error_count == 0) begin
            $display("RAM RESULT: PASS - all addresses and write enable verified");
            $finish;
        end else begin
            $fatal(1, "RAM RESULT: FAIL - %0d errors", error_count);
        end
    end

endmodule
