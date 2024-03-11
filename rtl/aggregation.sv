
module aggregation
#(
  // No default parameter sizes because these must be specified for each
  // individual instantiation since each usage will be different.
  // output_size should be 1 bit larger than input_size since there are 3
  // values being added.
  parameter input_size,
  parameter output_size
)
(
  input signed [input_size-1:0] in1,
  input signed [input_size-1:0] in2,
  input signed [input_size-1:0] in3,
  output signed [output_size-1:0] out
);
  assign out = in1 + in2 + in3;
endmodule
