module async_fifo_with_ram
  #(parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4)
(
    input  wire                    wclk,     // write clock
    input  wire                    rclk,     // read clock
    input  wire                    rst,      // async reset
    input  wire                    wr_en,    // write enable
    input  wire                    rd_en,    // read enable
    input  wire [DATA_WIDTH-1:0]   wr_data,  // write data
    output wire [DATA_WIDTH-1:0]   rd_data,  // read data
    output wire                    full,
    output wire                    empty
);

    localparam [ADDR_WIDTH:0] FIFO_DEPTH = {1'b1, {ADDR_WIDTH{1'b0}}};

    //----------------------------------------
    // Binary and Gray pointer registers
    //----------------------------------------
    reg [ADDR_WIDTH:0] wbin, wgray, rbin, rgray;
    reg [ADDR_WIDTH:0] wbin_next, wgray_next;
    reg [ADDR_WIDTH:0] rbin_next, rgray_next;

    // Write address pointer and read address pointer
    wire [ADDR_WIDTH-1:0] waddr = wbin[ADDR_WIDTH-1:0];
    wire [ADDR_WIDTH-1:0] raddr = rbin[ADDR_WIDTH-1:0];

    //----------------------------------------
    // Synchronizer for crossing domains
    //----------------------------------------
    reg [ADDR_WIDTH:0] wq2_rgray, wq1_rgray; // write sees read pointer
    reg [ADDR_WIDTH:0] rq2_wgray, rq1_wgray; // read sees write pointer
    wire [ADDR_WIDTH:0] wq2_rbin;
    wire [ADDR_WIDTH:0] rq2_wbin;

    //----------------------------------------
    // RAM interface
    //----------------------------------------
    wire                    do_write;
    wire                    do_read;
    reg                     full_reg;
    reg                     empty_reg;
    wire                    full_next;
    wire                    empty_next;

    assign do_write = (wr_en && ~full_reg);
    assign do_read  = (rd_en && ~empty_reg);

    //----------------------------------------
    // Helper function
    //----------------------------------------
    function [ADDR_WIDTH:0] bin2gray;
        input [ADDR_WIDTH:0] bin_value;
        begin
            bin2gray = (bin_value >> 1) ^ bin_value;
        end
    endfunction

    function [ADDR_WIDTH:0] gray2bin;
        input [ADDR_WIDTH:0] gray_value;
        integer i;
        begin
            gray2bin[ADDR_WIDTH] = gray_value[ADDR_WIDTH];
            for (i = ADDR_WIDTH-1; i >= 0; i = i - 1) begin
                gray2bin[i] = gray2bin[i+1] ^ gray_value[i];
            end
        end
    endfunction

    assign wq2_rbin = gray2bin(wq2_rgray);
    assign rq2_wbin = gray2bin(rq2_wgray);

    async_fifo_dp_ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) ram_inst (
        .wclk(wclk),
        .we(do_write),
        .waddr(waddr),
        .din(wr_data),
        .rclk(rclk),
        .raddr(raddr),
        .dout(rd_data)
    );

    assign full    = full_reg;
    assign empty   = empty_reg;

    //----------------------------------------
    // Write side logic
    //----------------------------------------
    // Binary to Gray
    always @(*) begin
        wbin_next  = wbin + do_write;
        wgray_next = bin2gray(wbin_next);
    end

    always @(posedge wclk or posedge rst) begin
        if (rst) begin
            wbin   <= 0;
            wgray  <= 0;
            full_reg <= 0;
        end else begin
            wbin   <= wbin_next;
            wgray  <= wgray_next;
            full_reg <= full_next;
        end
    end

    //----------------------------------------
    // Synchronize read pointer into write clock
    //----------------------------------------
    always @(posedge wclk or posedge rst) begin
        if (rst) begin
            wq1_rgray <= 0;
            wq2_rgray <= 0;
        end else begin
            wq1_rgray <= rgray;
            wq2_rgray <= wq1_rgray;
        end
    end

    //----------------------------------------
    // Read side logic
    //----------------------------------------
    // Binary to Gray
    always @(*) begin
        rbin_next  = rbin + do_read;
        rgray_next = bin2gray(rbin_next);
    end

    always @(posedge rclk or posedge rst) begin
        if (rst) begin
            rbin  <= 0;
            rgray <= 0;
            empty_reg <= 1;
        end else begin
            rbin  <= rbin_next;
            rgray <= rgray_next;
            empty_reg <= empty_next;
        end
    end

    //----------------------------------------
    // Synchronize write pointer into read clock
    //----------------------------------------
    always @(posedge rclk or posedge rst) begin
        if (rst) begin
            rq1_wgray <= 0;
            rq2_wgray <= 0;
        end else begin
            rq1_wgray <= wgray;
            rq2_wgray <= rq1_wgray;
        end
    end

    //----------------------------------------
    // EMPTY and FULL logic
    //----------------------------------------
    // Compare synchronized pointers in binary domain.
    assign empty_next = (rbin_next == rq2_wbin);
    assign full_next  = ((wbin_next - wq2_rbin) == FIFO_DEPTH);

endmodule

// Backward-compatible wrapper: old names and parameter style.
module async_fifo_ram
  #(parameter DW = 8,
    parameter AW = 4)
(
    input  wire             wr_clk,
    input  wire             rd_clk,
    input  wire             rst,
    input  wire             wr_en,
    input  wire             rd_en,
    input  wire [DW-1:0]    wr_data,
    output wire [DW-1:0]    rd_data,
    output wire             full,
    output wire             empty
);

    async_fifo_with_ram #(
        .DATA_WIDTH(DW),
        .ADDR_WIDTH(AW)
    ) u_async_fifo_with_ram (
        .wclk(wr_clk),
        .rclk(rd_clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .full(full),
        .empty(empty)
    );

endmodule
