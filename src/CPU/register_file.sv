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
    input wire logic clk,
    input wire logic rst_n,
    input var logic reg_wr,
    input var logic [4:0] reg_wr_addr,
    input var logic [31:0] reg_wr_data,
    input var logic [4:0] reg_a_addr,
    input var logic [4:0] reg_b_addr,
    output var logic [31:0] reg_a_data,
    output var logic [31:0] reg_b_data
);
    var logic [31:0] register_file [31:0];

    // Write operation - occurs on the positive edge of the clock
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) 
            foreach (register_file[i]) register_file[i] <= i;
        
        else if (reg_wr && reg_wr_addr != 0) 
            register_file[reg_wr_addr] <= reg_wr_data;
       
        else if (reg_wr && reg_wr_addr == 0) 
            register_file[reg_wr_addr] <= 0;
    end

    // Read operations
    always_comb begin
        reg_a_data = register_file[reg_a_addr];
        reg_b_data = register_file[reg_b_addr];
    end

endmodule