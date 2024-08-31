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
    input wire logic clk,
    input wire logic rst_n,
    output wire logic [7:0] AN,
    output wire logic [7:0] CT
);
    //    [num of rows][num of bits (cols) / row]
    var logic [3:0] segment_value [7:0]  = {4'd15, 4'd15, 4'd15, 4'd15, 4'd15, 4'd15, 4'd15, 4'd15};
    var logic [31:0] reg_result;
    
    SevenSegDisplay seg_inst(
        .clk(clk),
        .rst_n(rst_n),
        .value(segment_value),
        .AN(AN),
        .CT(CT)
    );

    RV_CPU cpu(
        .clk(clk),
        .rst_n(rst_n),
        .reg_result(reg_result)
    );

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) segment_value[0] <= 4'd15;
        else segment_value[0] <= reg_result[7:0];
    end
    
endmodule
