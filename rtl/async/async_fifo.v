`timescale 1ns / 1ps

module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4   // FIFO depth = 2^ADDR_WIDTH
)(
    input  wire                   wr_clk,
    input  wire                   rd_clk,
    input  wire                   wr_rst_n,
    input  wire                   rd_rst_n,

    input  wire                   wr_en,
    input  wire [DATA_WIDTH-1:0]  wr_data,
    output wire                   full,

    input  wire                   rd_en,
    output reg  [DATA_WIDTH-1:0]  rd_data,
    output wire                   empty
);

    // ============================================================
    // Parameters and Local Constants
    // ============================================================
    localparam DEPTH = (1 << ADDR_WIDTH);

    // ============================================================
    // Memory Declaration (True Dual-Port Style Inference)
    // ============================================================
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // ============================================================
    // Write Pointer (Binary and Gray)
    // ============================================================
    reg [ADDR_WIDTH:0] wr_ptr_bin, wr_ptr_bin_next;
    reg [ADDR_WIDTH:0] wr_ptr_gray, wr_ptr_gray_next;

    // ============================================================
    // Read Pointer (Binary and Gray)
    // ============================================================
    reg [ADDR_WIDTH:0] rd_ptr_bin, rd_ptr_bin_next;
    reg [ADDR_WIDTH:0] rd_ptr_gray, rd_ptr_gray_next;

    // ============================================================
    // Synchronizers
    // ============================================================
    reg [ADDR_WIDTH:0] rd_ptr_gray_sync1, rd_ptr_gray_sync2;
    reg [ADDR_WIDTH:0] wr_ptr_gray_sync1, wr_ptr_gray_sync2;

    // ============================================================
    // Utility Functions
    // ============================================================
    function [ADDR_WIDTH:0] bin2gray;
        input [ADDR_WIDTH:0] bin;
        begin
            bin2gray = (bin >> 1) ^ bin;
        end
    endfunction

    // ============================================================
    // WRITE DOMAIN LOGIC
    // ============================================================

    // Next-state binary write pointer
    always @(*) begin
        wr_ptr_bin_next = wr_ptr_bin;
        if (wr_en && !full)
            wr_ptr_bin_next = wr_ptr_bin + 1'b1;
    end

    // Binary to Gray conversion using function
    assign wr_ptr_gray_next = bin2gray(wr_ptr_bin_next);

    // Write pointer registers
    always @(posedge wr_clk or negedge wr_rst_n) begin
        if (!wr_rst_n) begin
            wr_ptr_bin  <= {(ADDR_WIDTH+1){1'b0}};
            wr_ptr_gray <= {(ADDR_WIDTH+1){1'b0}};
        end else begin
            wr_ptr_bin  <= wr_ptr_bin_next;
            wr_ptr_gray <= wr_ptr_gray_next;
        end
    end

    // Memory write operation
    always @(posedge wr_clk) begin
        if (wr_en && !full)
            mem[wr_ptr_bin[ADDR_WIDTH-1:0]] <= wr_data;
    end

    // Synchronize read pointer into write clock domain
    always @(posedge wr_clk or negedge wr_rst_n) begin
        if (!wr_rst_n) begin
            rd_ptr_gray_sync1 <= {(ADDR_WIDTH+1){1'b0}};
            rd_ptr_gray_sync2 <= {(ADDR_WIDTH+1){1'b0}};
        end else begin
            rd_ptr_gray_sync1 <= rd_ptr_gray;
            rd_ptr_gray_sync2 <= rd_ptr_gray_sync1;
        end
    end

    // Full condition detection
    assign full = (wr_ptr_gray_next == 
                  {~rd_ptr_gray_sync2[ADDR_WIDTH:ADDR_WIDTH-1],
                    rd_ptr_gray_sync2[ADDR_WIDTH-2:0]});

    // ============================================================
    // READ DOMAIN LOGIC
    // ============================================================

    // Next-state binary read pointer
    always @(*) begin
        rd_ptr_bin_next = rd_ptr_bin;
        if (rd_en && !empty)
            rd_ptr_bin_next = rd_ptr_bin + 1'b1;
    end

    // Binary to Gray conversion
    always @(*) begin
        rd_ptr_gray_next = (rd_ptr_bin_next >> 1) ^ rd_ptr_bin_next;
    end

    // Read pointer registers
    always @(posedge rd_clk or negedge rd_rst_n) begin
        if (!rd_rst_n) begin
            rd_ptr_bin  <= {(ADDR_WIDTH+1){1'b0}};
            rd_ptr_gray <= {(ADDR_WIDTH+1){1'b0}};
        end else begin
            rd_ptr_bin  <= rd_ptr_bin_next;
            rd_ptr_gray <= rd_ptr_gray_next;
        end
    end

    // Memory read operation
    always @(posedge rd_clk) begin
        if (rd_en && !empty)
            rd_data <= mem[rd_ptr_bin[ADDR_WIDTH-1:0]];
    end

    // Synchronize write pointer into read clock domain
    always @(posedge rd_clk or negedge rd_rst_n) begin
        if (!rd_rst_n) begin
            wr_ptr_gray_sync1 <= {(ADDR_WIDTH+1){1'b0}};
            wr_ptr_gray_sync2 <= {(ADDR_WIDTH+1){1'b0}};
        end else begin
            wr_ptr_gray_sync1 <= wr_ptr_gray;
            wr_ptr_gray_sync2 <= wr_ptr_gray_sync1;
        end
    end

    // Empty condition detection
    assign empty = (rd_ptr_gray == wr_ptr_gray_sync2);

endmodule
