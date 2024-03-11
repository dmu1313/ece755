module gnn #(
  parameter input_size = 5,
  parameter agg_input_size=6,
  parameter relu_output_size=13
)
( 
  x0_node0, x1_node0, x2_node0, x3_node0, x0_node1, x1_node1, x2_node1, x3_node1, x0_node2, x1_node2, x2_node2, x3_node2,x0_node3, x1_node3, x2_node3, x3_node3,
  w04, w14, w24, w34, w05, w15, w25, w35, w06, w16, w26, w36, w07, w17, w27, w37, w48, w58, w68, w78, w49, w59, w69, w79,
  out0_node0, out1_node0, out0_node1, out1_node1, out0_node2, out1_node2, out0_node3, out1_node3,
  in_ready,
  out10_ready_node0, out11_ready_node0, out10_ready_node1, out11_ready_node1, out10_ready_node2, out11_ready_node2, out10_ready_node3, out11_ready_node3,
  clk
);
  input [4:0] x0_node0, x1_node0, x2_node0, x3_node0;
  input [4:0] x0_node1, x1_node1, x2_node1, x3_node1;
  input [4:0] x0_node2, x1_node2, x2_node2, x3_node2;
  input [4:0] x0_node3, x1_node3, x2_node3, x3_node3;
  input [4:0] w04, w14, w24, w34;
  input [4:0] w05, w15, w25, w35;
  input [4:0] w06, w16, w26, w36;
  input [4:0] w07, w17, w27, w37;
  input [4:0] w48, w58, w68, w78;
  input [4:0] w49, w59, w69, w79;
  input clk;
  output [20:0] out0_node0, out1_node0;
  output [20:0] out0_node1, out1_node1;
  output [20:0] out0_node2, out1_node2;
  output [20:0] out0_node3, out1_node3;
  output out10_ready_node0, out11_ready_node0;
  output out10_ready_node1, out11_ready_node1;
  output out10_ready_node2, out11_ready_node2;
  output out10_ready_node3, out11_ready_node3;
  input in_ready;

  logic signed [agg_input_size-1:0] aggr_x0_node0, aggr_x0_node1, aggr_x0_node2, aggr_x0_node3, aggr_x1_node0, aggr_x1_node1, aggr_x1_node2, aggr_x1_node3, aggr_x2_node0, aggr_x2_node1, aggr_x2_node2, aggr_x2_node3, aggr_x3_node0, aggr_x3_node1, aggr_x3_node2, aggr_x3_node3;

  logic signed [agg_input_size-1:0] aggr_x0_node0_out, aggr_x1_node0_out, aggr_x2_node0_out, aggr_x3_node0_out;
  logic signed [agg_input_size-1:0] aggr_x0_node1_out, aggr_x1_node1_out, aggr_x2_node1_out, aggr_x3_node1_out;
  logic signed [agg_input_size-1:0] aggr_x0_node2_out, aggr_x1_node2_out, aggr_x2_node2_out, aggr_x3_node2_out;
  logic signed [agg_input_size-1:0] aggr_x0_node3_out, aggr_x1_node3_out, aggr_x2_node3_out, aggr_x3_node3_out;

  logic signed [relu_output_size-1:0] y4_relu_node0, y5_relu_node0, y6_relu_node0, y7_relu_node0;
  logic signed [relu_output_size-1:0] y4_relu_node1, y5_relu_node1, y6_relu_node1, y7_relu_node1;
  logic signed [relu_output_size-1:0] y4_relu_node2, y5_relu_node2, y6_relu_node2, y7_relu_node2;
  logic signed [relu_output_size-1:0] y4_relu_node3, y5_relu_node3, y6_relu_node3, y7_relu_node3;

  logic input_aggr_ready;

  always_ff @(posedge clk) begin
    input_aggr_ready <= in_ready;

    aggr_x0_node0 <= aggr_x0_node0_out;
    aggr_x1_node0 <= aggr_x1_node0_out;
    aggr_x2_node0 <= aggr_x2_node0_out;
    aggr_x3_node0 <= aggr_x3_node0_out;
    
    aggr_x0_node1 <= aggr_x0_node1_out;
    aggr_x1_node1 <= aggr_x1_node1_out;
    aggr_x2_node1 <= aggr_x2_node1_out;
    aggr_x3_node1 <= aggr_x3_node1_out;
    
    aggr_x0_node2 <= aggr_x0_node2_out;
    aggr_x1_node2 <= aggr_x1_node2_out;
    aggr_x2_node2 <= aggr_x2_node2_out;
    aggr_x3_node2 <= aggr_x3_node2_out;
    
    aggr_x0_node3 <= aggr_x0_node3_out;
    aggr_x1_node3 <= aggr_x1_node3_out;
    aggr_x2_node3 <= aggr_x2_node3_out;
    aggr_x3_node3 <= aggr_x3_node3_out;
  end

  node n0 (
    .x0(aggr_x0_node0), .x1(aggr_x1_node0), .x2(aggr_x2_node0), .x3(aggr_x3_node0),
    
    .w04(w04), .w05(w05), .w06(w06), .w07(w07), .w14(w14), .w15(w15), .w16(w16),
    .w17(w17), .w24(w24), .w25(w25), .w26(w26), .w27(w27), .w34(w34), .w35(w35),
    .w36(w36), .w37(w37), .w48(w48), .w58(w58), .w49(w49), .w59(w59), .w68(w68),
    .w69(w69), .w78(w78), .w79(w79),
    
    .out0(out0_node0), .out1(out1_node0),
    .out0_ready(out10_ready_node0), .out1_ready(out11_ready_node0),
    .in_ready(input_aggr_ready),
    .clk(clk),

    .neighbor_1_y4_relu(y4_relu_node_1), .neighbor_2_y4_relu(y4_relu_node_2),
    .neighbor_1_y5_relu(y5_relu_node_1), .neighbor_2_y5_relu(y5_relu_node_2),
    .neighbor_1_y6_relu(y6_relu_node_1), .neighbor_2_y6_relu(y6_relu_node_2),
    .neighbor_1_y7_relu(y7_relu_node_1), .neighbor_2_y7_relu(y7_relu_node_2),

    .relu_out_y4(y4_relu_node0), .relu_out_y5(y5_relu_node0), .relu_out_y6(y6_relu_node0), .relu_out_y7(y7_relu_node0)
  );

  node n1 (
    .x0(aggr_x0_node1), .x1(aggr_x1_node1), .x2(aggr_x2_node1), .x3(aggr_x3_node1),
    
    .w04(w04), .w05(w05), .w06(w06), .w07(w07), .w14(w14), .w15(w15), .w16(w16),
    .w17(w17), .w24(w24), .w25(w25), .w26(w26), .w27(w27), .w34(w34), .w35(w35),
    .w36(w36), .w37(w37), .w48(w48), .w58(w58), .w49(w49), .w59(w59), .w68(w68),
    .w69(w69), .w78(w78), .w79(w79),
    
    .out0(out0_node1), .out1(out1_node1),
    .out0_ready(out10_ready_node1), .out1_ready(out11_ready_node1),
    .in_ready(input_aggr_ready),
    .clk(clk),

    .neighbor_1_y4_relu(y4_relu_node_0), .neighbor_2_y4_relu(y4_relu_node_3),
    .neighbor_1_y5_relu(y5_relu_node_0), .neighbor_2_y5_relu(y5_relu_node_3),
    .neighbor_1_y6_relu(y6_relu_node_0), .neighbor_2_y6_relu(y6_relu_node_3),
    .neighbor_1_y7_relu(y7_relu_node_0), .neighbor_2_y7_relu(y7_relu_node_3),

    .relu_out_y4(y4_relu_node1), .relu_out_y5(y5_relu_node1), .relu_out_y6(y6_relu_node1), .relu_out_y7(y7_relu_node1)
  );

  node n2 (
    .x0(aggr_x0_node2), .x1(aggr_x1_node2), .x2(aggr_x2_node2), .x3(aggr_x3_node2),
    
    .w04(w04), .w05(w05), .w06(w06), .w07(w07), .w14(w14), .w15(w15), .w16(w16),
    .w17(w17), .w24(w24), .w25(w25), .w26(w26), .w27(w27), .w34(w34), .w35(w35),
    .w36(w36), .w37(w37), .w48(w48), .w58(w58), .w49(w49), .w59(w59), .w68(w68),
    .w69(w69), .w78(w78), .w79(w79),
    
    .out0(out0_node2), .out1(out1_node2),
    .out0_ready(out10_ready_node2), .out1_ready(out11_ready_node2),
    .in_ready(input_aggr_ready),
    .clk(clk),

    .neighbor_1_y4_relu(y4_relu_node_0), .neighbor_2_y4_relu(y4_relu_node_3),
    .neighbor_1_y5_relu(y5_relu_node_0), .neighbor_2_y5_relu(y5_relu_node_3),
    .neighbor_1_y6_relu(y6_relu_node_0), .neighbor_2_y6_relu(y6_relu_node_3),
    .neighbor_1_y7_relu(y7_relu_node_0), .neighbor_2_y7_relu(y7_relu_node_3),

    .relu_out_y4(y4_relu_node2), .relu_out_y5(y5_relu_node2), .relu_out_y6(y6_relu_node2), .relu_out_y7(y7_relu_node2)
  );

  node n3 (
    .x0(aggr_x0_node3), .x1(aggr_x1_node3), .x2(aggr_x2_node3), .x3(aggr_x3_node3),
    
    .w04(w04), .w05(w05), .w06(w06), .w07(w07), .w14(w14), .w15(w15), .w16(w16),
    .w17(w17), .w24(w24), .w25(w25), .w26(w26), .w27(w27), .w34(w34), .w35(w35),
    .w36(w36), .w37(w37), .w48(w48), .w58(w58), .w49(w49), .w59(w59), .w68(w68),
    .w69(w69), .w78(w78), .w79(w79),
    
    .out0(out0_node3), .out1(out1_node3),
    .out0_ready(out10_ready_node3), .out1_ready(out11_ready_node3),
    .in_ready(input_aggr_ready),
    .clk(clk),

    .neighbor_1_y4_relu(y4_relu_node_1), .neighbor_2_y4_relu(y4_relu_node_2),
    .neighbor_1_y5_relu(y5_relu_node_1), .neighbor_2_y5_relu(y5_relu_node_2),
    .neighbor_1_y6_relu(y6_relu_node_1), .neighbor_2_y6_relu(y6_relu_node_2),
    .neighbor_1_y7_relu(y7_relu_node_1), .neighbor_2_y7_relu(y7_relu_node_2),

    .relu_out_y4(y4_relu_node3), .relu_out_y5(y5_relu_node3), .relu_out_y6(y6_relu_node3), .relu_out_y7(y7_relu_node3)
  );

  ///////////// Begin NODE 0 Aggregation ////////////////

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x0_node0_aggregated(
    .in1(x0_node0),
    .in2(x0_node1),
    .in3(x0_node2),
    .out(aggr_x0_node0)
  );

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x1_node0_aggregated(
    .in1(x1_node0),
    .in2(x1_node1),
    .in3(x1_node2),
    .out(aggr_x1_node0)
  );

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x2_node0_aggregated(
    .in1(x2_node0),
    .in2(x2_node1),
    .in3(x2_node2),
    .out(aggr_x2_node0)
  );

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x3_node0_aggregated(
    .in1(x3_node0),
    .in2(x3_node1),
    .in3(x3_node2),
    .out(aggr_x3_node0)
  );
  
  ///////////// End NODE 0 Aggregation ////////////////

  ///////////// Begin NODE 1 Aggregation ////////////////

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x0_node1_aggregated(
    .in1(x0_node0),
    .in2(x0_node1),
    .in3(x0_node3),
    .out(aggr_x0_node1)
  );

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x1_node1_aggregated(
    .in1(x1_node0),
    .in2(x1_node1),
    .in3(x1_node3),
    .out(aggr_x1_node1)
  );

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x2_node1_aggregated(
    .in1(x2_node0),
    .in2(x2_node1),
    .in3(x2_node3),
    .out(aggr_x2_node1)
  );

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x3_node1_aggregated(
    .in1(x3_node0),
    .in2(x3_node1),
    .in3(x3_node3),
    .out(aggr_x3_node1)
  );
  
  ///////////// End NODE 1 Aggregation ////////////////

  ///////////// Begin NODE 2 Aggregation ////////////////

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x0_node2_aggregated(
    .in1(x0_node0),
    .in2(x0_node2),
    .in3(x0_node3),
    .out(aggr_x0_node2)
  );

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x1_node2_aggregated(
    .in1(x1_node0),
    .in2(x1_node2),
    .in3(x1_node3),
    .out(aggr_x1_node2)
  );

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x2_node2_aggregated(
    .in1(x2_node0),
    .in2(x2_node2),
    .in3(x2_node3),
    .out(aggr_x2_node2)
  );

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x3_node2_aggregated(
    .in1(x3_node0),
    .in2(x3_node2),
    .in3(x3_node3),
    .out(aggr_x3_node2)
  );
  
  ///////////// End NODE 2 Aggregation ////////////////

  ///////////// Begin NODE 3 Aggregation ////////////////

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x0_node3_aggregated(
    .in1(x0_node1),
    .in2(x0_node2),
    .in3(x0_node3),
    .out(aggr_x0_node3)
  );

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x1_node3_aggregated(
    .in1(x1_node1),
    .in2(x1_node2),
    .in3(x1_node3),
    .out(aggr_x1_node3)
  );

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x2_node3_aggregated(
    .in1(x2_node1),
    .in2(x2_node2),
    .in3(x2_node3),
    .out(aggr_x2_node3)
  );

  aggregation #(
    input_size=input_size,
    output_size=agg_input_size
  ) x3_node3_aggregated(
    .in1(x3_node1),
    .in2(x3_node2),
    .in3(x3_node3),
    .out(aggr_x3_node3)
  );
  
  ///////////// End NODE 0 Aggregation ////////////////
endmodule
