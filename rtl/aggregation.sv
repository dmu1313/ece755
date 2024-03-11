
module aggregation
#(
  // No default parameter sizes because these must be specified for each
  // individual instantiation since each usage will be different.
  // output_size should be 2 bits larger than input_size since there are 3
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
  logic signed [output_size-1:0] sign_extended_in1;
  logic signed [output_size-1:0] sign_extended_in2;
  logic signed [output_size-1:0] sign_extended_in3;

  assign sign_extended_in1 = { { 2{in1[input_size-1]} }, in1 };
  assign sign_extended_in2 = { { 2{in2[input_size-1]} }, in2 };
  assign sign_extended_in3 = { { 2{in3[input_size-1]} }, in3 };

  assign out = sign_extended_in1 + sign_extended_in2 + sign_extended_in3;
endmodule
