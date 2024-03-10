module top #(
  parameter input_size = 5,
  /*parameter hidden_layer_input_size = 12,
  parameter hidden_layer_output_size = 12,
  parameter output_size = 18*/
)
( 
    x0_node0, x1_node0, x2_node0, x3_node0, x0_node1, x1_node1, x2_node1, x3_node1, x0_node2, x1_node2, x2_node2, x3_node2,x0_node3, x1_node3, x2_node3, x3_node3,
    w04, w14, w24, w34, w05, w15, w25, w35, w06, w16, w26, w36, w07, w17, w27, w37, w48, w58, w68, w78, w49, w59, w69, w79,
    out0_node0, out1_node0, out0_node1, out1_node1, out0_node2, out1_node2, out0_node3, out1_node3, in_ready, out10_ready_node0,
    out11_ready_node0,mout10_ready_node1, out11_ready_node1,nout10_ready_node2, out11_ready_node2, out10_ready_node3, out11_ready_node3,
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

logic signed [input_size-1:0] aggr_x0_node0, aggr_x0_node1, aggr_x0_node2, aggr_x0_node3, aggr_x1_node0, aggr_x1_node1, aggr_x1_node2, aggr_x1_node3, aggr_x2_node0, aggr_x2_node1, aggr_x2_node2, aggr_x2_node3, aggr_x3_node0, aggr_x3_node1, aggr_x3_node2, aggr_x3_node3;

/*
logic signed [input_size-1:0] y0, y1, y2, y3;
logic signed [hidden_layer_input_size-1:0] y4, y5, y6, y7;
logic signed [hidden_layer_output_size-1:0] relu_out_y4, relu_out_y5, relu_out_y6, relu_out_y7;
logic signed [hidden_layer_output_size-1:0] y4_relu, y5_relu, y6_relu, y7_relu;
logic signed [output_size-1:0] y8, y9;*/

logic ready_layer0, ready_aggr0, ready_layer1, ready_aggr1, ready_layer2, ready_aggr2, ready_layer3, ready_aggr3, ready_output_layer;
/*
assign y0 = x0;
assign y1 = x1;
assign y2 = x2;
assign y3 = x3;*/

assign out010_ready_node0 = ready_output_layer;
assign out11_ready_node0 = ready_output_layer;
assign out10_ready_node1 = ready_output_layer;
assign out11_ready_node1 = ready_output_layer;
assign out10_ready_node2 = ready_output_layer;
assign out11_ready_node2 = ready_output_layer;
assign out10_ready_node3 = ready_output_layer;
assign out11_ready_node3 = ready_output_layer;

// Calculation of aggr. features


always_ff @(posedge clk) begin 

    ready_aggr0 <= in_ready;
    ready_layer0 <= ready_aggr0;
    ready_aggr1 <= ready_layer0;
    ready_layer1 <= ready_aggr1;
    ready_aggr2 <= ready_layer1;
    ready_layer2 <= ready_aggr2;
    ready_aggr3 <= ready_layer2;
    ready_layer2 <= ready_aggr2;
    ready_output_layer <= ready_layer3;

    if (in_ready) begin 
        aggr_x0_node0 <= x0_node0 + x0_node1 + x0_node2;
        aggr_x1_node0 <= x1_node0 + x1_node1 + x1_node2;
        aggr_x2_node0 <= x2_node0 + x2_node1 + x2_node2;
        aggr_x3_node0 <= x3_node0 + x3_node1 + x3_node2;
    end 
    else if (in_ready) begin 
        aggr_x0_node0 <= x0_node0 + x0_node1 + x0_node2;
        aggr_x1_node0 <= x1_node0 + x1_node1 + x1_node2;
        aggr_x2_node0 <= x2_node0 + x2_node1 + x2_node2;
        aggr_x3_node0 <= x3_node0 + x3_node1 + x3_node2;
    end 


end

endmodule


