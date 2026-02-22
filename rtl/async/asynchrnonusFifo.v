module asyncFifo #(
    parameter dw=2,
    parameter aw=4
)(
    input wire rdclk,wrclk,
    input wire rdrst,wrrst,
    input wire rden,wren,
    input wire [dw-1:0] din,
    output reg [dw-1:0] dout,
    output wire empty,
    output wire full
);
localparam depth = (1<<aw);
reg [dw-1:0] mem [0:aw-1];

//to make pointers 
//read and write, binary pointers 
reg [aw:0] rdptrbin,rdptrbin_next , wrptrbin,wrptrbin_next;
//read and write, gray pointers 
reg [aw:0] rdptrgray,rdptrgray_next,wrptrgray,wrptrgray_next;
//synchronized pointers 
reg [aw:0] rdptrgray1,rdptrgray2;
reg [aw:0] wrptrgray1,wrptrgray2;
//next state logic
always @(*)begin
    rdptrbin_next=rdptrbin;
    if(rden && !empty) begin
        rdptrbin_next<= rdptrbin+1'b1; // 1'b or aw'b 

    end
end
always @(*)begin
    wrptrbin_next=wrptrbin;
    if(rden && !empty) begin
        wrptrbin_next<= wrptrbin+1'b1; // 1'b or aw'b 

    end
end
//write, domain logic
always @(posedge wclk or posedge wrrst)begin
    if(wrrst)begin
        wrptrbin<={(aw+1){1'b0}};
        wrptrgray={(aw+1){1'b0}};
end else begin
    wrptrbin<=wrptrbin_next;
    wrptrgray<=wrptrgray_next;

end
assign wrptrgray_next = binarytogray(wrptrbin_next); 
end
function [aw+1:0] binary2gray;
    input wire [aw+1:0] bin;
    begin
        binary2gray=bin^(bin>>1);
    end

endfunction
//read domain logic 
always @(posedge rclk or negedge rdrst)begin
    if(rdrst)begin
        rdptrbin <= {(aw+1){1'b0}};
        rdptrgray <= {(aw+1){1'b0}};
end else begin
    rdptrbin <= rdptrbin_next;
    rdptrgray <= rdptrgray_next;

end
end
assign rdptrgray_next= binary2gray(rdptrbin_next);

//memory write and read 
always @(wrclk && wren) begin
    mem[wrptrbin[aw-1:0]]<=din;

end
//memory read operation 
always @(rdclk && rden) begin
    dout<= mem[rdptrbin[aw-1:0]];

end
//synchronizing write and read doimain logic 
always @(podedge wclk or podedge wrrst )begin
    if(wrrst)begin
        rdptrgray1<={(aw+1){1'b0}};
        rdptrgray2<= {(aw+1){1'b0}};
end else begin
        rdptrgray1<=rdptrgray;
        rdptrgray2<= rdptrgray1;
end
end 
always @(rdclk or rdrst)begin
    if(rdrst)begin
        wrptrgray1<={(aw+1){1'b0}};
        wrptrgray2<={(aw+1){1'b0}};
end else begin
        wrptrgray1<=wrptrgray;
        wrptrgray2<=wrptrgray1;
end
end
assign full = wrptrgray==(!{wrptrgray2[aw:aw-1]} , wrptrgray2[aw-2:0]);
assign empty = (rdptrgray ==rdptrgray2);




endendmodule

// ============================================================
// LEARNING NOTES: WHAT IS WRONG IN THIS FILE (AND HOW TO FIX)
// ============================================================
//
// 1) Module ending typo:
//    - You wrote: endendmodule
//    - Correct: endmodule
//
// 2) Memory depth declaration is wrong:
//    - You computed: localparam depth = (1<<aw);
//    - But declared: reg [dw-1:0] mem [0:aw-1];
//    - Correct memory array should use depth:
//      reg [dw-1:0] mem [0:depth-1];
//
// 3) In combinational always @(*) blocks, use blocking '=' not '<=':
//    - rdptrbin_next<= ... and wrptrbin_next<= ... should be '='.
//    - Rule of thumb:
//      combinational -> '='
//      sequential    -> '<='
//
// 4) Write next-state condition is wrong signal:
//    - In write logic, you used if (rden && !empty).
//    - Should be if (wren && !full).
//
// 5) Clock/reset signal name mismatch:
//    - Ports are wrclk/rdclk, but blocks use wclk/rclk.
//    - Use one consistent naming everywhere.
//
// 6) Async reset edge polarity and condition mismatch:
//    - Example: always @(posedge rclk or negedge rdrst) with if (rdrst)
//    - If reset is active-low, condition should be if (!rdrst).
//    - If active-high, sensitivity should be posedge rdrst.
//    - Pick one convention and keep it consistent.
//
// 7) assign statement placed inside always block:
//    - assign wrptrgray_next = ... is inside always block.
//    - Continuous assign must be outside always blocks.
//
// 8) Function naming/type errors:
//    - Called as binarytogray(), defined as binary2gray().
//    - Return/input widths should be [aw:0], not [aw+1:0].
//      (Pointer width is aw+1 bits total, indexed aw down to 0.)
//
// 9) Read-domain reset check is inverted:
//    - You wrote if (rdrst) under negedge-sensitive reset.
//    - Usually this should be if (!rdrst) for active-low reset.
//
// 10) Memory read/write always sensitivity is invalid:
//     - always @(wrclk && wren) and always @(rdclk && rden) are not
//       valid clocked sequential style.
//     - Use:
//       always @(posedge wrclk) begin
//           if (wren && !full) ...
//       end
//       always @(posedge rdclk) begin
//           if (rden && !empty) ...
//       end
//
// 11) Typo in synchronizer always block keywords:
//     - podedge is invalid; should be posedge.
//
// 12) Missing posedge in one always block:
//     - always @(rdclk or rdrst) should be
//       always @(posedge rdclk or <reset_edge> rdrst)
//
// 13) Full flag equation has syntax + signal-source issues:
//     - You used !{...} and comma with parentheses incorrectly.
//     - Correct Gray full check shape is:
//       wrptrgray_next == {~rdptrgray2[aw:aw-1], rdptrgray2[aw-2:0]}
//     - Compare against synchronized READ pointer in write domain.
//
// 14) Empty flag compares wrong synchronized signal:
//     - You used rdptrgray2 (read pointer synchronized into write domain).
//     - Empty must be checked in read domain against synchronized write ptr:
//       empty = (rdptrgray_next == wrptrgray2)   // or rdptrgray == wrptrgray2
//
// 15) Small style issue: no spaces around commas/operators in many places.
//     - Not a functional bug, but cleaner style prevents mistakes.
//
// Suggested learning order:
//   A) Fix compile/syntax errors first (endmodule, posedge typos, sensitivities)
//   B) Fix clock/reset consistency (wrclk/rdclk names and reset polarity)
//   C) Fix CDC logic (which synchronized pointer is used in full/empty)
//   D) Then verify with a testbench (write burst, read burst, full/empty edges)
//
// ------------------------------------------------------------
// QUICK TABLE: SYNTAX VS LOGIC ISSUES
// ------------------------------------------------------------
// | #  | Type                 | Problem in file                               | Correct direction |
// |----|----------------------|-----------------------------------------------|-------------------|
// | 1  | Syntax/Spelling      | endendmodule                                  | endmodule         |
// | 2  | Syntax/Calling       | binarytogray() called, binary2gray() defined | Use one same name |
// | 3  | Syntax               | podedge keyword typo                          | posedge           |
// | 4  | Syntax               | always @(wrclk && wren) style                 | always @(posedge wrclk) + if (...) |
// | 5  | Syntax               | assign placed inside always block             | Keep assign outside always |
// | 6  | Calling/Name mismatch| wclk/rclk used but ports are wrclk/rdclk     | Use consistent signal names |
// | 7  | Logic                | write next-state uses (rden && !empty)       | use (wren && !full) |
// | 8  | Logic                | mem declared [0:aw-1] not [0:depth-1]         | use depth entries  |
// | 9  | Logic                | reset edge/polarity inconsistent              | pick active-high or active-low and keep consistent |
// | 10 | Logic/CDC            | empty compares wrong synchronized pointer     | compare rd ptr vs synced wr ptr in read domain |
// | 11 | Logic/CDC            | full equation uses wrong form/signals         | compare wr_ptr_gray_next with inverted MSBs of synced rd ptr |
// | 12 | Logic/Modeling       | '<=' used in combinational next-state blocks  | use '=' in always @(*) |
