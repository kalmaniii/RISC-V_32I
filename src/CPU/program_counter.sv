`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2024 01:45:46 PM
// Design Name: 
// Module Name: program_counter.sv
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

module ProgramCounter(
    input wire logic clk,
    input wire logic rst_n,
    input var logic pc_src,
    input var logic [31:0] branch_address,
    output var logic [31:0] pc
);

    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) pc <= 0;
        else begin
            if (pc_src) pc <= (branch_address << 2);
            else pc <= pc + 4;
        end
    end

endmodule