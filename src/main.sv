`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2024 01:29:46 PM
// Design Name: 
// Module Name: main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main(
    input wire clk,
    input wire rst_n,
    output wire [7:0] AN,
    output wire [7:0] CT
);
    //    [num of rows][num of bits (cols) / row]
    var logic [2:0][7:0] segment_value  = {8, 9, 10, 11, 12, 13, 14, 15};
    
    SevenSegDisplay seg_inst(
        .clk(clk),
        .rst_n(rst_n),
        .value(segment_value),
        .AN(AN),
        .CT(CT)
    );
    
endmodule
