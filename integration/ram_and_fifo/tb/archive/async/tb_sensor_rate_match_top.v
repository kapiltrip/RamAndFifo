`timescale 1ns/1ps

module tb_sensor_rate_match_top;

    localparam DATA_WIDTH = 12;
    localparam ADDR_WIDTH = 5;
    localparam TOTAL_ACCEPTED = 120;

    reg                    sensor_clk;
    reg                    sys_clk;
    reg                    sensor_rst_n;
    reg                    sys_rst_n;
    reg  [DATA_WIDTH-1:0]  sensor_data;
    reg                    sensor_valid;
    wire                   sensor_ready;
    wire [DATA_WIDTH-1:0]  proc_data;
    wire                   proc_valid;
    reg                    proc_ready;
    wire                   fifo_full;
    wire                   fifo_empty;

    reg [DATA_WIDTH-1:0] src_log [0:4095];
    integer               seed;
    integer               wr_accept_count;
    integer               out_count;
    integer               timeout;
    reg [DATA_WIDTH+1:0]  expected_sum;
    reg [DATA_WIDTH-1:0]  expected_avg;

    sensor_rate_match_top #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .sensor_clk  (sensor_clk),
        .sys_clk     (sys_clk),
        .sensor_rst_n(sensor_rst_n),
        .sys_rst_n   (sys_rst_n),
        .sensor_data (sensor_data),
        .sensor_valid(sensor_valid),
        .sensor_ready(sensor_ready),
        .proc_data   (proc_data),
        .proc_valid  (proc_valid),
        .proc_ready  (proc_ready),
        .fifo_full   (fifo_full),
        .fifo_empty  (fifo_empty)
    );

    initial begin
        sensor_clk = 1'b0;
        forever #4 sensor_clk = ~sensor_clk; // 125 MHz
    end

    initial begin
        sys_clk = 1'b0;
        forever #6.5 sys_clk = ~sys_clk; // ~76.9 MHz
    end

    task fail;
        input [1023:0] message;
        begin
            $display("TEST FAILED: %0s", message);
            $display("State: wr=%0d out=%0d full=%b empty=%b",
                     wr_accept_count, out_count, fifo_full, fifo_empty);
            $finish(1);
        end
    endtask

    always @(posedge sensor_clk) begin
        if (sensor_rst_n && sensor_valid && sensor_ready) begin
            src_log[wr_accept_count] = sensor_data;
            wr_accept_count = wr_accept_count + 1;
        end
    end

    always @(posedge sys_clk) begin
        if (sys_rst_n && proc_valid && proc_ready) begin
            if ((out_count + 3) >= wr_accept_count)
                fail("Output observed before enough accepted input samples");

            expected_sum = src_log[out_count] + src_log[out_count+1] +
                           src_log[out_count+2] + src_log[out_count+3];
            expected_avg = expected_sum[DATA_WIDTH+1:2];
            #1;
            if (proc_data !== expected_avg) begin
                $display("Mismatch at out_idx=%0d expected=0x%0h got=0x%0h",
                         out_count, expected_avg, proc_data);
                fail("Moving-average output mismatch");
            end
            out_count = out_count + 1;
        end
    end

    initial begin
        seed            = 32'h13579BDF;
        sensor_rst_n    = 1'b0;
        sys_rst_n       = 1'b0;
        sensor_valid    = 1'b0;
        sensor_data     = {DATA_WIDTH{1'b0}};
        proc_ready      = 1'b0;
        wr_accept_count = 0;
        out_count       = 0;
        timeout         = 0;

        repeat (4) @(posedge sensor_clk);
        repeat (4) @(posedge sys_clk);
        sensor_rst_n = 1'b1;
        sys_rst_n    = 1'b1;

        fork
            begin : producer
                while (wr_accept_count < TOTAL_ACCEPTED) begin
                    @(negedge sensor_clk);
                    if (($random(seed) & 32'h3) == 0) begin
                        sensor_valid <= 1'b0;
                    end else begin
                        sensor_valid <= 1'b1;
                        sensor_data  <= wr_accept_count[DATA_WIDTH-1:0];
                    end
                end
                @(negedge sensor_clk);
                sensor_valid <= 1'b0;
            end

            begin : ready_gen
                forever begin
                    @(negedge sys_clk);
                    if (!sys_rst_n) begin
                        proc_ready <= 1'b0;
                    end else begin
                        proc_ready <= (($random(seed) & 32'h3) != 0); // 75% ready
                    end
                end
            end
        join_none

        while (wr_accept_count < TOTAL_ACCEPTED) begin
            @(posedge sensor_clk);
        end

        disable producer;
        disable ready_gen;

        @(negedge sys_clk);
        proc_ready <= 1'b1;

        while (out_count < (TOTAL_ACCEPTED - 3) && timeout < 20000) begin
            @(posedge sys_clk);
            timeout = timeout + 1;
        end

        if (timeout >= 20000)
            fail("Timeout waiting for processor output drain");

        repeat (8) @(posedge sys_clk);

        if (!fifo_empty)
            fail("FIFO should be empty at end of test");
        if (out_count != (TOTAL_ACCEPTED - 3))
            fail("Unexpected output sample count");

        $display("TEST PASSED: sensor_rate_match_top");
        $finish;
    end

endmodule
