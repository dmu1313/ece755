module tb_top();

reg [4:0] x0, x1, x2, x3;
reg [4:0] w04, w14, w24, w34;
reg [4:0] w05, w15, w25, w35;
reg [4:0] w06, w16, w26, w36;
reg [4:0] w07, w17, w27, w37;
reg [4:0] w48, w58, w68, w78;
reg [4:0] w49, w59, w69, w79;

reg clk;

wire [16:0] out0, out1;
wire out10_ready, out11_ready;

reg in_ready;
// Top module
// Instantiation of top module
// Please replace the instantiation with the top module of your gate level model
// Look for 'test failed' in the message. If there is no such message then your output matches the golden outputs. 


top top(.x0(x0), .x1(x1), .x2(x2), .x3(x3), 
        .w04(w04), .w14(w14), .w24(w24), .w34(w34), 
        .w05(w05), .w15(w15), .w25(w25), .w35(w35),
        .w06(w06), .w16(w16), .w26(w26), .w36(w36),
        .w07(w07), .w17(w17), .w27(w27), .w37(w37),
        .w48(w48), .w58(w58), .w68(w68), .w78(w78),
        .w49(w49), .w59(w59), .w69(w69), .w79(w79),
        .out0(out0), .out1(out1),
        .in_ready(in_ready), .out0_ready(out10_ready), .out1_ready(out11_ready),
        .clk(clk));

initial begin


  // Test case 1

    clk = 0;
    in_ready = 1; 
    
    x0 = 5'b00100;
    x1 = 5'b00010;
    x2 = 5'b00100;
    x3 = 5'b00001;
    
    w04 = 5'b00011;
    w14 = 5'b00010;
    w24 = 5'b01101;
    w34 = 5'b11010;
    w05 = 5'b10111;
    w15 = 5'b00001;
    w25 = 5'b11100;
    w35 = 5'b01110;
    w06 = 5'b00011;
    w16 = 5'b00110;
    w26 = 5'b10001;
    w36 = 5'b01111;
    w07 = 5'b01001;
    w17 = 5'b10110;
    w27 = 5'b01111;
    w37 = 5'b10110;
    w48 = 5'b00000;
    w58 = 5'b11111;
    w68 = 5'b00011;
    w78 = 5'b10101;
    w49 = 5'b10100;
    w59 = 5'b10001;
    w69 = 5'b10001;
    w79 = 5'b00110;


    #40
    if (out0 == -17'd726)
            $display("-----------out0 is correct for testcase 1-----------------");
    else
            $display("-----------out0 is incorrect for testcase 1-----------");

    if (out1 == -17'd348)
            $display("-----------out1 is correct for testcase 1-----------");
    else
            $display("-----------out1 is incorrect for testcase 1-----------");


    if (out0 == -17'd726 && out1 == -17'd348)
            $display("*********** PASSED TEST 1 *********");
    else
            $display("*********** FAILED TEST 1 *********");

 #40

 // Test case 2

    clk = 0;
    in_ready = 1; 
    
    x0 = 5'b00100;
    x1 = 5'b00010;
    x2 = 5'b00100;
    x3 = 5'b00001;
    
    w04 = 5'b00011;
    w14 = 5'b00010;
    w24 = 5'b01101;
    w34 = 5'b00000;
    w05 = 5'b00000;
    w15 = 5'b00000;
    w25 = 5'b00000;
    w35 = 5'b01110;
    w06 = 5'b00011;
    w16 = 5'b00110;
    w26 = 5'b00000;
    w36 = 5'b01111;
    w07 = 5'b01001;
    w17 = 5'b00000;
    w27 = 5'b01111;
    w37 = 5'b00000;
    w48 = 5'b00000;
    w58 = 5'b00000;
    w68 = 5'b00011;
    w78 = 5'b01011;
    w49 = 5'b01100;
    w59 = 5'b00000;
    w69 = 5'b00000;
    w79 = 5'b00110;


    #40
    if (out0 == 17'd1173)
            $display("-----------out0 is correct for testcase 2-----------------");
    else
            $display("-----------out0 is incorrect for testcase 2-----------");

    if (out1 == 17'd1392)
            $display("-----------out1 is correct for testcase 2-----------");
    else
            $display("-----------out1 is incorrect for testcase 2-----------");


    if (out0 == 17'd1173 && out1 == 17'd1392)
            $display("*********** PASSED TEST 2 *********");
    else
            $display("*********** FAILED TEST 2 *********");

 #40

 // Test case 3

    clk = 0;
    in_ready = 1;

    x0 = 5'b10000;
    x1 = 5'b10000;
    x2 = 5'b10000;
    x3 = 5'b10000;

    w04 = 5'b10000;
    w14 = 5'b10000;
    w24 = 5'b10000;
    w34 = 5'b10000;
    w05 = 5'b10000;
    w15 = 5'b10000;
    w25 = 5'b10000;
    w35 = 5'b10000;
    w06 = 5'b10000;
    w16 = 5'b10000;
    w26 = 5'b10000;
    w36 = 5'b10000;
    w07 = 5'b10000;
    w17 = 5'b10000;
    w27 = 5'b10000;
    w37 = 5'b10000;
    w48 = 5'b10000;
    w58 = 5'b10000;
    w68 = 5'b10000;
    w78 = 5'b10000;
    w49 = 5'b10000;
    w59 = 5'b10000;
    w69 = 5'b10000;
    w79 = 5'b10000;


    #40
    if (out0 == -17'd65536)
            $display("-----------out0 is correct for testcase 3-----------------");
    else
            $display("-----------out0 is incorrect for testcase 3-----------");

    if (out1 == -17'd65536)
            $display("-----------out1 is correct for testcase 3-----------");
    else
            $display("-----------out1 is incorrect for testcase 3-----------");


    if (out0 == -17'd65536 && out1 == -17'd65536)
            $display("*********** PASSED TEST 3 *********");
    else
            $display("*********** FAILED TEST 3 *********");

 #40
   
 // Test case 4

    clk = 0;
    in_ready = 1; 
    
    x0 = 5'b01111;
    x1 = 5'b01111;
    x2 = 5'b01111;
    x3 = 5'b01111;
    
    w04 = 5'b01111;
    w14 = 5'b01111;
    w24 = 5'b01111;
    w34 = 5'b01111;
    w05 = 5'b01111;
    w15 = 5'b01111;
    w25 = 5'b01111;
    w35 = 5'b01111;
    w06 = 5'b01111;
    w16 = 5'b01111;
    w26 = 5'b01111;
    w36 = 5'b01111;
    w07 = 5'b01111;
    w17 = 5'b01111;
    w27 = 5'b01111;
    w37 = 5'b01111;
    w48 = 5'b01111;
    w58 = 5'b01111;
    w68 = 5'b01111;
    w78 = 5'b01111;
    w49 = 5'b01111;
    w59 = 5'b01111;
    w69 = 5'b01111;
    w79 = 5'b01111;


    #40
    if (out0 == 17'd54000)
            $display("-----------out0 is correct for testcase 4-----------------");
    else
            $display("-----------out0 is incorrect for testcase 4-----------");

    if (out1 == 17'd54000)
            $display("-----------out1 is correct for testcase 4-----------");
    else
            $display("-----------out1 is incorrect for testcase 4-----------");


    if (out0 == 17'd54000 && out1 == 17'd54000)
            $display("*********** PASSED TEST 4 *********");
    else
            $display("*********** FAILED TEST 4 *********");

end


always
    #1 clk = !clk;


initial
    #400 $finish;


endmodule

