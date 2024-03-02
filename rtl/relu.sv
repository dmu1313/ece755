// relu activation with parameterized size
module relu(
    input [size-1:0] in,
    output [size-1:0] out
)
    parameter size = 12;
//    assign out = in[size-1] ? 0 : in[size-2:0];
    assign out = in[size-1] ? 0 : {1'b0, in[size-2:0]};
endmodule
