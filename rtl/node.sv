
module node #(
  parameter weight_size = 5,
  parameter input_size = 6,
  parameter hidden_layer_input_size = 13,
  parameter hidden_layer_output_size = 13,
  parameter relu_aggregation_output_size = 14,
  parameter output_size = 21
)
(
  x0, x1, x2, x3,
  w04, w05, w06, w07, w14, w15, w16, w17, w24, w25, w26, w27, w34, w35, w36,
  w37, w48, w58, w49, w59, w68, w69, w78, w79,
  out0, out1,
  in_ready,
  out0_ready, out1_ready,
  clk,

  neighbor_1_y4_relu, neighbor_2_y4_relu,
  neighbor_1_y5_relu, neighbor_2_y5_relu,
  neighbor_1_y6_relu, neighbor_2_y6_relu,
  neighbor_1_y7_relu, neighbor_2_y7_relu,

  relu_out_y4, relu_out_y5, relu_out_y6, relu_out_y7
);
  input signed [input_size-1:0] x0, x1, x2, x3;
  input signed [weight_size-1:0] w04, w05, w06, w07, w14, w15, w16, w17, w24, w25, w26, w27, w34, w35, w36, w37,
    w48, w58, w49, w59, w68, w69, w78, w79;
  input in_ready;
  input clk;
  output [output_size-1:0] out0, out1;
  output out0_ready, out1_ready;  

  input signed [hidden_layer_output_size-1:0] neighbor_1_y4_relu, neighbor_2_y4_relu;
  input signed [hidden_layer_output_size-1:0] neighbor_1_y5_relu, neighbor_2_y5_relu;
  input signed [hidden_layer_output_size-1:0] neighbor_1_y6_relu, neighbor_2_y6_relu;
  input signed [hidden_layer_output_size-1:0] neighbor_1_y7_relu, neighbor_2_y7_relu;
  output signed [hidden_layer_output_size-1:0] relu_out_y4, relu_out_y5, relu_out_y6, relu_out_y7;

  logic signed [input_size-1:0] y0, y1, y2, y3;
  logic signed [hidden_layer_input_size-1:0] y4, y5, y6, y7;
  logic signed [hidden_layer_output_size-1:0] y4_relu, y5_relu, y6_relu, y7_relu;
  logic signed [relu_aggregation_output_size-1:0] y4_relu_aggregation, y5_relu_aggregation, y6_relu_aggregation, y7_relu_aggregation;
  logic signed [relu_aggregation_output_size-1:0] y4_relu_aggregation_out, y5_relu_aggregation_out, y6_relu_aggregation_out, y7_relu_aggregation_out;
  logic signed [output_size-1:0] y8, y9;

  logic ready_hidden_layer, ready_relu_layer, ready_relu_aggregation_layer, ready_output_layer;

  assign y0 = x0;
  assign y1 = x1;
  assign y2 = x2;
  assign y3 = x3;

  assign out0_ready = ready_output_layer;
  assign out1_ready = ready_output_layer;

  always_ff @(posedge clk) begin
    ready_hidden_layer <= in_ready;
    ready_relu_layer <= ready_hidden_layer;
    ready_relu_aggregation_layer <= ready_relu_layer;
    ready_output_layer <= ready_relu_aggregation_layer;

    if (in_ready) begin
      y4 <= (y0 * w04) + (y1 * w14) + (y2 * w24) + (y3 * w34);
      y5 <= (y0 * w05) + (y1 * w15) + (y2 * w25) + (y3 * w35);
      y6 <= (y0 * w06) + (y1 * w16) + (y2 * w26) + (y3 * w36);
      y7 <= (y0 * w07) + (y1 * w17) + (y2 * w27) + (y3 * w37);
    end
    else begin
      y4 <= y4;
      y5 <= y5;
      y6 <= y6;
      y7 <= y7;
    end

    if (ready_hidden_layer) begin
      y4_relu <= relu_out_y4;
      y5_relu <= relu_out_y5;
      y6_relu <= relu_out_y6;
      y7_relu <= relu_out_y7;
    end
    else begin
      y4_relu <= y4_relu;
      y5_relu <= y5_relu;
      y6_relu <= y6_relu;
      y7_relu <= y7_relu;
    end

    if (ready_relu_layer) begin
      y4_relu_aggregation <= y4_relu_aggregation_out;
      y5_relu_aggregation <= y5_relu_aggregation_out;
      y6_relu_aggregation <= y6_relu_aggregation_out;
      y7_relu_aggregation <= y7_relu_aggregation_out;
    end
    else begin
      y4_relu_aggregation <= y4_relu_aggregation;
      y5_relu_aggregation <= y5_relu_aggregation;
      y6_relu_aggregation <= y6_relu_aggregation;
      y7_relu_aggregation <= y7_relu_aggregation;
    end

    if (ready_relu_aggregation_layer) begin
      y8 = (y4_relu_aggregation * w48) + (y5_relu_aggregation * w58) + (y6_relu_aggregation * w68) + (y7_relu_aggregation * w78);
      y9 = (y4_relu_aggregation * w49) + (y5_relu_aggregation * w59) + (y6_relu_aggregation * w69) + (y7_relu_aggregation * w79);
    end
    else begin
      y8 <= y8;
      y9 <= y9;
    end
  end

  assign out0 = y8[output_size-1:0];
  assign out1 = y9[output_size-1:0];

  relu #(.size(hidden_layer_output_size)) r4(
    .in(y4),
    .out(relu_out_y4)
  );

  relu #(.size(hidden_layer_output_size)) r5(
    .in(y5),
    .out(relu_out_y5)
  );

  relu #(.size(hidden_layer_output_size)) r6(
    .in(y6),
    .out(relu_out_y6)
  );

  relu #(.size(hidden_layer_output_size)) r7(
    .in(y7),
    .out(relu_out_y7)
  );

  aggregation #(
    .input_size(hidden_layer_output_size),
    .output_size(relu_aggregation_output_size)
  ) agg4(
    .in1(y4_relu),
    .in2(neighbor_1_y4_relu),
    .in3(neighbor_2_y4_relu),
    .out(y4_relu_aggregation_out)
  );

  aggregation #(
    .input_size(hidden_layer_output_size),
    .output_size(relu_aggregation_output_size)
  ) agg5(
    .in1(y5_relu),
    .in2(neighbor_1_y5_relu),
    .in3(neighbor_2_y5_relu),
    .out(y5_relu_aggregation_out)
  );

  aggregation #(
    .input_size(hidden_layer_output_size),
    .output_size(relu_aggregation_output_size)
  ) agg6(
    .in1(y6_relu),
    .in2(neighbor_1_y6_relu),
    .in3(neighbor_2_y6_relu),
    .out(y6_relu_aggregation_out)
  );

  aggregation #(
    .input_size(hidden_layer_output_size),
    .output_size(relu_aggregation_output_size)
  ) agg7(
    .in1(y7_relu),
    .in2(neighbor_1_y7_relu),
    .in3(neighbor_2_y7_relu),
    .out(y7_relu_aggregation_out)
  );

endmodule
