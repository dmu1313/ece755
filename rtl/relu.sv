// relu activation with parameterized size
module relu
#(
    parameter size = 12
)
(
    input [size-1:0] in,
    output [size-1:0] out
);
    assign out = in[size-1] ? 0 : {1'b0, in[size-2:0]};
endmodule
