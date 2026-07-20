module ram #(
    parameter dw=4,
    parameter aw=4
)(
    input wire clk , we,
    input wire [dw-1:0] din,
    output reg [dw-1:0] dout,
    input wire [aw-1:0] raddr , waddr
);

localparam depth = (1<< aw) ;
always @(posedge clk )begin

    if(we)begin
        mem[waddr]<= din ;

    end
    dout <= mem[raddr];
end
endmodule
