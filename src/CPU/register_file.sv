`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2024 01:45:46 PM
// Design Name: 
// Module Name: register_file.sv
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

module RegisterFile(
    input wire register_wr,
    input logic [4:0] register_a,
    input logic [4:0] register_b,
    input logic [4:0] write_register_addr,
    input logic [31:0] write_register_data,
    output logic [31:0] read_register_a,
    output logic [31:0] read_register_b
);



endmodule