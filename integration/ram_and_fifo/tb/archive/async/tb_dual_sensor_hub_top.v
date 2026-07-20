`timescale 1ns/1ps

module tb_dual_sensor_hub_top;

    localparam DATA_WIDTH = 12;
    localparam ADDR_WIDTH = 5;
    localparam TOTAL0 = 140;
    localparam TOTAL1 = 100;

    reg                    sensor0_clk;
    reg                    sensor1_clk;
    reg                    sys_clk;
    reg                    sensor0_rst_n;
    reg                    sensor1_rst_n;
    reg                    sys_rst_n;
    reg  [DATA_WIDTH-1:0]  sensor0_data;
    reg                    sensor0_valid;
    wire                   sensor0_ready;
    reg  [DATA_WIDTH-1:0]  sensor1_data;
    reg                    sensor1_valid;
    wire                   sensor1_ready;
    wire [DATA_WIDTH:0]    hub_data;
    wire                   hub_valid;
    reg                    hub_ready;
    wire [1:0]             fifo_full;
    wire [1:0]             fifo_empty;

    reg [DATA_WIDTH-1:0] src0_log [0:4095];
    reg [DATA_WIDTH-1:0] src1_log [0:4095];
    integer               seed;
    integer               wr0_count;
    integer               wr1_count;
    integer               rd0_count;
    integer               rd1_count;
    integer               timeout;
    integer               backlog0;
    integer               backlog1;
    integer               fairness_streak;
    reg                   last_src;

    dual_sensor_hub_top #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .sensor0_clk  (sensor0_clk),
        .sensor1_clk  (sensor1_clk),
        .sys_clk      (sys_clk),
        .sensor0_rst_n(sensor0_rst_n),
        .sensor1_rst_n(sensor1_rst_n),
        .sys_rst_n    (sys_rst_n),
        .sensor0_data (sensor0_data),
        .sensor0_valid(sensor0_valid),
        .sensor0_ready(sensor0_ready),
        .sensor1_data (sensor1_data),
        .sensor1_valid(sensor1_valid),
        .sensor1_ready(sensor1_ready),
        .hub_data     (hub_data),
        .hub_valid    (hub_valid),
        .hub_ready    (hub_ready),
        .fifo_full    (fifo_full),
        .fifo_empty   (fifo_empty)
    );

    initial begin
        sensor0_clk = 1'b0;
        forever #3.5 sensor0_clk = ~sensor0_clk; // ~143 MHz
    end

    initial begin
        sensor1_clk = 1'b0;
        forever #5.5 sensor1_clk = ~sensor1_clk; // ~91 MHz
    end

    initial begin
        sys_clk = 1'b0;
        forever #5 sys_clk = ~sys_clk; // 100 MHz
    end

    task fail;
        input [1023:0] message;
        begin
            $display("TEST FAILED: %0s", message);
            $display("State: wr0=%0d wr1=%0d rd0=%0d rd1=%0d full=%b empty=%b",
                     wr0_count, wr1_count, rd0_count, rd1_count, fifo_full, fifo_empty);
            $finish(1);
        end
    endtask

    always @(posedge sensor0_clk) begin
        if (sensor0_rst_n && sensor0_valid && sensor0_ready) begin
            src0_log[wr0_count] = sensor0_data;
            wr0_count = wr0_count + 1;
        end
    end

    always @(posedge sensor1_clk) begin
        if (sensor1_rst_n && sensor1_valid && sensor1_ready) begin
            src1_log[wr1_count] = sensor1_data;
            wr1_count = wr1_count + 1;
        end
    end

    always @(posedge sys_clk) begin
        if (sys_rst_n && hub_valid && hub_ready) begin
            backlog0 = wr0_count - rd0_count;
            backlog1 = wr1_count - rd1_count;

            #1;
            if (hub_data[DATA_WIDTH] == 1'b0) begin
                if (rd0_count >= wr0_count)
                    fail("Read from source0 with no accepted source0 data");
                if (hub_data[DATA_WIDTH-1:0] !== src0_log[rd0_count]) begin
                    $display("SRC0 mismatch idx=%0d expected=0x%0h got=0x%0h",
                             rd0_count, src0_log[rd0_count], hub_data[DATA_WIDTH-1:0]);
                    fail("Per-source ordering failed for source0");
                end
                rd0_count = rd0_count + 1;
            end else begin
                if (rd1_count >= wr1_count)
                    fail("Read from source1 with no accepted source1 data");
                if (hub_data[DATA_WIDTH-1:0] !== src1_log[rd1_count]) begin
                    $display("SRC1 mismatch idx=%0d expected=0x%0h got=0x%0h",
                             rd1_count, src1_log[rd1_count], hub_data[DATA_WIDTH-1:0]);
                    fail("Per-source ordering failed for source1");
                end
                rd1_count = rd1_count + 1;
            end

            if ((backlog0 > 0) && (backlog1 > 0)) begin
                if (hub_data[DATA_WIDTH] == last_src) begin
                    fairness_streak = fairness_streak + 1;
                end else begin
                    fairness_streak = 1;
                    last_src = hub_data[DATA_WIDTH];
                end

                if (fairness_streak > 32)
                    fail("Arbiter starvation risk: long single-source streak while both backlogs were non-zero");
            end else begin
                fairness_streak = 0;
            end
        end
    end

    initial begin
        seed            = 32'h2468ACE1;
        sensor0_rst_n   = 1'b0;
        sensor1_rst_n   = 1'b0;
        sys_rst_n       = 1'b0;
        sensor0_data    = {DATA_WIDTH{1'b0}};
        sensor1_data    = {DATA_WIDTH{1'b0}};
        sensor0_valid   = 1'b0;
        sensor1_valid   = 1'b0;
        hub_ready       = 1'b0;
        wr0_count       = 0;
        wr1_count       = 0;
        rd0_count       = 0;
        rd1_count       = 0;
        timeout         = 0;
        backlog0        = 0;
        backlog1        = 0;
        fairness_streak = 0;
        last_src        = 1'b0;

        repeat (5) @(posedge sys_clk);
        sensor0_rst_n = 1'b1;
        sensor1_rst_n = 1'b1;
        sys_rst_n     = 1'b1;

        fork
            begin : producer0
                while (wr0_count < TOTAL0) begin
                    @(negedge sensor0_clk);
                    if (($random(seed) & 32'h7) == 0) begin
                        sensor0_valid <= 1'b0;
                    end else begin
                        sensor0_valid <= 1'b1;
                        sensor0_data  <= (12'h100 + wr0_count[DATA_WIDTH-1:0]);
                    end
                end
                @(negedge sensor0_clk);
                sensor0_valid <= 1'b0;
            end

            begin : producer1
                while (wr1_count < TOTAL1) begin
                    @(negedge sensor1_clk);
                    if (($random(seed) & 32'h3) == 0) begin
                        sensor1_valid <= 1'b0;
                    end else begin
                        sensor1_valid <= 1'b1;
                        sensor1_data  <= (12'h800 + wr1_count[DATA_WIDTH-1:0]);
                    end
                end
                @(negedge sensor1_clk);
                sensor1_valid <= 1'b0;
            end

            begin : sink_ready_gen
                forever begin
                    @(negedge sys_clk);
                    if (!sys_rst_n) begin
                        hub_ready <= 1'b0;
                    end else begin
                        hub_ready <= (($random(seed) & 32'h3) != 0); // 75% ready
                    end
                end
            end
        join_none

        while ((wr0_count < TOTAL0) || (wr1_count < TOTAL1)) begin
            @(posedge sys_clk);
        end

        disable producer0;
        disable producer1;
        disable sink_ready_gen;

        @(negedge sys_clk);
        hub_ready <= 1'b1;

        while (((rd0_count < wr0_count) || (rd1_count < wr1_count)) && (timeout < 40000)) begin
            @(posedge sys_clk);
            timeout = timeout + 1;
        end

        if (timeout >= 40000)
            fail("Timeout waiting for merged stream drain");

        repeat (8) @(posedge sys_clk);

        if (!fifo_empty[0] || !fifo_empty[1])
            fail("Both FIFOs should be empty at end of test");
        if (rd0_count != wr0_count)
            fail("Source0 accepted data not fully consumed");
        if (rd1_count != wr1_count)
            fail("Source1 accepted data not fully consumed");

        $display("TEST PASSED: dual_sensor_hub_top");
        $finish;
    end

endmodule
