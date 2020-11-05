`timescale 1ns / 1ps

module top
#
( parameter
    WI = 3, WF = 29,                    // Input Integer and Fraction bits
    WIS = 5, WFS = 11,                  // Scalers Integer and Fraction bits
    WI_coeff = 2, WF_coeff = 8          // Coefficients Integer and Fraction bits
)
    
(
    input CLK
);
    reg [WI + WF - 1 : 0] x_input[0 : 49];                                              // Input values
    reg [5 : 0] counter = 0;                                                            // Counter that counts through input values
    initial $readmemh("x.mem", x_input);                                                // Initialize Inputs
    always @ (posedge CLK) if(counter < 49) counter <= counter + 1;                     // Cycle through inputs
    mult_Fixed # ( .WI1(WI), .WF1(WF), .WI2(WIS), .WF2(WFS), .WIO(3), .WFO() )          // First scalar is 0.004726381845108
    scalar_1( .in1(x_input[counter]), .in2(16'h000a), .out() );                         // First scalar is 0.004726381845108
    
    
    
    sos # ( .WI_in(WI), .WF_in(WF + WFS), .WL(WI + WF + WFS), .WI_coeff(WI_coeff), .WF_coeff(WF_coeff),
        .b0(10'h100), .b1(10'h1df), .b2(10'h100), .a1(10'h133), .a2(10'h392) )
    sos_1( .CLK(CLK), .in(scalar_1.out), .out() );
    
    
    
endmodule
