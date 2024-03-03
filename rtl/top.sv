module top #(
  parameter input_size = 5,
  parameter hidden_layer_input_size = 12,
  parameter hidden_layer_output_size = 12,
  parameter output_size = 18
)
(
  x0, x1, x2, x3,
  w04, w05, w06, w07, w14, w15, w16, w17, w24, w25, w26, w27, w34, w35, w36,
  w37, w48, w58, w49, w59, w68, w69, w78, w79,
  out0, out1,
  in_ready,
  out0_ready, out1_ready,
  clk
);
  input signed [4:0] x0, x1, x2, x3, w04, w05, w06, w07, w14, w15, w16, w17, w24, w25, w26, w27, w34, w35, w36, w37,
    w48, w58, w49, w59, w68, w69, w78, w79;
  input in_ready;
  input clk;
  output [16:0] out0, out1;
  output out0_ready, out1_ready;
  
  logic signed [input_size-1:0] y0, y1, y2, y3;
  logic signed [hidden_layer_input_size-1:0] y4, y5, y6, y7;
  logic signed [hidden_layer_output_size-1:0] relu_out_y4, relu_out_y5, relu_out_y6, relu_out_y7;
  logic signed [hidden_layer_output_size-1:0] y4_relu, y5_relu, y6_relu, y7_relu;
  logic signed [output_size-1:0] y8, y9;

//  logic out0_ff, out1_ff;
  logic ready_input, ready_hidden_layer, ready_relu_layer, ready_output_layer;

  assign out0_ready = ready_relu_layer;
  assign out1_ready = ready_relu_layer;

  always_ff @(posedge clk) begin
    ready_input <= in_ready;
    ready_hidden_layer <= ready_input;
    ready_relu_layer <= ready_hidden_layer;
    ready_output_layer <= ready_relu_layer;

    if (in_ready) begin
      y0 <= x0;
      y1 <= x1;
      y2 <= x2;
      y3 <= x3;
    end
    else begin
      y0 <= y0;
      y1 <= y1;
      y2 <= y2;
      y3 <= y3;
    end

    if (ready_input) begin
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
      y8 = (y4_relu * w48) + (y5_relu * w58) + (y6_relu * w68) + (y7_relu * w78);
      y9 = (y4_relu * w49) + (y5_relu * w59) + (y6_relu * w69) + (y7_relu * w79);
    end
    else begin
      y8 <= y8;
      y9 <= y9;
    end
  end

//  always_comb begin
//    y4 = (y0 * w04) + (y1 * w14) + (y2 * w24) + (y3 * w34);
//    y5 = (y0 * w05) + (y1 * w15) + (y2 * w25) + (y3 * w35);
//    y6 = (y0 * w06) + (y1 * w16) + (y2 * w26) + (y3 * w36);
//    y7 = (y0 * w07) + (y1 * w17) + (y2 * w27) + (y3 * w37);
//
//    y8 = (y4_relu * w48) + (y5_relu * w58) + (y6_relu * w68) + (y7_relu * w78);
//    y9 = (y4_relu * w49) + (y5_relu * w59) + (y6_relu * w69) + (y7_relu * w79);
//  end 

  assign out0 = y8[output_size-2:0];
  assign out1 = y9[output_size-2:0];

  relu r4(
    .in(y4),
    .out(relu_out_y4)
  );

  relu r5(
    .in(y5),
    .out(relu_out_y5)
  );

  relu r6(
    .in(y6),
    .out(relu_out_y6)
  );

  relu r7(
    .in(y7),
    .out(relu_out_y7)
  );

endmodule
