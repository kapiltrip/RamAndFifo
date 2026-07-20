`timescale 1ns/1ps

module tb_sensor_event_logger_top;

    localparam DATA_WIDTH = 12;
    localparam ADDR_WIDTH = 5;
    localparam TOTAL_ACCEPTED = 96; // multiple of 16 for clean packet accounting

    reg                    sensor_clk;
    reg                    sys_clk;
    reg                    sensor_rst_n;
    reg                    sys_rst_n;
    reg  [DATA_WIDTH-1:0]  sensor_data;
    reg                    sensor_valid;
    wire                   sensor_ready;
    reg                    mem_ready;
    wire                   mem_wr_en;
    wire [15:0]            mem_addr;
    wire [15:0]            mem_wdata;
    wire                   fifo_full;
    wire                   fifo_empty;

    reg [DATA_WIDTH-1:0] src_log [0:4095];
    integer               seed;
    integer               wr_accept_count;
    integer               payload_read_count;
    integer               frame_id;
    integer               payload_in_frame;
    integer               write_count;
    integer               timeout;
    reg                   expecting_header;
    reg [15:0]            expected_word;

    sensor_event_logger_top #(
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
        .mem_ready   (mem_ready),
        .mem_wr_en   (mem_wr_en),
        .mem_addr    (mem_addr),
        .mem_wdata   (mem_wdata),
        .fifo_full   (fifo_full),
        .fifo_empty  (fifo_empty)
    );

    initial begin
        sensor_clk = 1'b0;
        forever #3 sensor_clk = ~sensor_clk; // ~166.7 MHz
    end

    initial begin
        sys_clk = 1'b0;
        forever #5 sys_clk = ~sys_clk; // 100 MHz
    end

    task fail;
        input [1023:0] message;
        begin
            $display("TEST FAILED: %0s", message);
            $display("State: wr=%0d payload_rd=%0d frame=%0d payload_idx=%0d writes=%0d full=%b empty=%b",
                     wr_accept_count, payload_read_count, frame_id, payload_in_frame, write_count, fifo_full, fifo_empty);
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
        if (sys_rst_n && mem_wr_en) begin
            if (!mem_ready)
                fail("mem_wr_en asserted when mem_ready is low");
            if (mem_addr !== write_count[15:0])
                fail("Memory address did not increment sequentially");

            #1;
            if (expecting_header) begin
                expected_word = {8'hA5, frame_id[7:0]};
                if (mem_wdata !== expected_word) begin
                    $display("Header mismatch frame=%0d expected=0x%0h got=0x%0h",
                             frame_id, expected_word, mem_wdata);
                    fail("Packet header mismatch");
                end
                expecting_header = 1'b0;
                payload_in_frame = 0;
            end else begin
                if (payload_read_count >= wr_accept_count)
                    fail("Payload write observed before corresponding source sample accepted");

                expected_word = {4'b0000, src_log[payload_read_count]};
                if (mem_wdata !== expected_word) begin
                    $display("Payload mismatch idx=%0d expected=0x%0h got=0x%0h",
                             payload_read_count, expected_word, mem_wdata);
                    fail("Packet payload mismatch");
                end

                payload_read_count = payload_read_count + 1;
                payload_in_frame   = payload_in_frame + 1;
                if (payload_in_frame == 16) begin
                    payload_in_frame = 0;
                    frame_id         = frame_id + 1;
                    expecting_header = 1'b1;
                end
            end
            write_count = write_count + 1;
        end
    end

    initial begin
        seed               = 32'h0BADF00D;
        sensor_rst_n       = 1'b0;
        sys_rst_n          = 1'b0;
        sensor_data        = {DATA_WIDTH{1'b0}};
        sensor_valid       = 1'b0;
        mem_ready          = 1'b0;
        wr_accept_count    = 0;
        payload_read_count = 0;
        frame_id           = 0;
        payload_in_frame   = 0;
        write_count        = 0;
        timeout            = 0;
        expecting_header   = 1'b1;
        expected_word      = 16'd0;

        repeat (5) @(posedge sys_clk);
        sensor_rst_n = 1'b1;
        sys_rst_n    = 1'b1;

        fork
            begin : producer
                while (wr_accept_count < TOTAL_ACCEPTED) begin
                    @(negedge sensor_clk);
                    if (($random(seed) & 32'h7) == 0) begin
                        sensor_valid <= 1'b0;
                    end else begin
                        sensor_valid <= 1'b1;
                        sensor_data  <= (12'h200 + wr_accept_count[DATA_WIDTH-1:0]);
                    end
                end
                @(negedge sensor_clk);
                sensor_valid <= 1'b0;
            end

            begin : mem_ready_gen
                forever begin
                    @(negedge sys_clk);
                    if (!sys_rst_n) begin
                        mem_ready <= 1'b0;
                    end else begin
                        mem_ready <= (($random(seed) & 32'h3) != 0); // 75% ready
                    end
                end
            end
        join_none

        while (wr_accept_count < TOTAL_ACCEPTED) begin
            @(posedge sensor_clk);
        end

        disable producer;
        disable mem_ready_gen;

        @(negedge sys_clk);
        mem_ready <= 1'b1;

        while ((payload_read_count < TOTAL_ACCEPTED) && (timeout < 40000)) begin
            @(posedge sys_clk);
            timeout = timeout + 1;
        end

        if (timeout >= 40000)
            fail("Timeout waiting for packetized payload drain");

        repeat (8) @(posedge sys_clk);

        if (payload_read_count != TOTAL_ACCEPTED)
            fail("Not all accepted samples reached packet payload stream");
        if (!fifo_empty)
            fail("FIFO should be empty at end of logger test");

        $display("TEST PASSED: sensor_event_logger_top");
        $finish;
    end

endmodule
