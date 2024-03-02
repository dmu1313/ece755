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
  input [4:0] x0, x1, x2, x3, w04, w05, w06, w07, w14, w15, w16, w17, w24, w25, w26, w27, w34, w35, w36, w37,
    w48, w58, w49, w59, w68, w69, w78, w79;
  input in_ready;
  input clk;
  output [16:0] out0, out1;
  output out0_ready, out1_ready;
  
  logic signed [input_size-1:0] y0, y1, y2, y3;
  logic signed [hidden_layer_input_size-1:0] y4, y5, y6, y7;
  logic [hidden_layer_output_size-1:0] y4_relu, y5_relu, y6_relu, y7_relu;
  logic signed [output_size-1:0] y8, y9;

  always_ff @(posedge clk) begin
    out0_ready <= in_ready;
    out1_ready <= in_ready;

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
  end

//  assign y0 = x0;
//  assign y1 = x1;
//  assign y2 = x2;
//  assign y3 = x3;

  always_comb begin
    y4 = (y0 * w04) + (y1 * w14) + (y2 * w24) + (y3 * w34);
    y5 = (y0 * w05) + (y1 * w15) + (y2 * w25) + (y3 * w35);
    y6 = (y0 * w06) + (y1 * w16) + (y2 * w26) + (y3 * w36);
    y7 = (y0 * w07) + (y1 * w17) + (y2 * w27) + (y3 * w37);

    y8 = (y4_relu * w48) + (y5_relu * w58) + (y6_relu * w68) + (y7_relu * w78);
    y9 = (y4_relu * w49) + (y5_relu * w59) + (y6_relu * w69) + (y7_relu * w79);
  
    out0 = y8[output_size-2:0];
    out1 = y9[output_size-2:0];
  end

  relu r4(
    .input(y4),
    .output(y4_relu)
  );

  relu r5(
    .input(y5),
    .output(y5_relu)
  );

  relu r6(
    .input(y6),
    .output(y6_relu)
  );

  relu r7(
    .input(y7),
    .output(y7_relu)
  );

endmodule
