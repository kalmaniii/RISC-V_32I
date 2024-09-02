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
    input var logic regfile_wr_en,
    input var logic [31:0]  instruction,
    input var logic [31:0]  reg_wr_data,
    output var logic [31:0] reg_s1_data,
    output var logic [31:0] reg_s2_data
);
    var logic [4:0] reg_wr_addr;
    var logic [4:0] reg_s1_addr;
    var logic [4:0] reg_s2_addr;
    var logic [31:0] register_file [31:0];

    // Update addresses based on instruction
    always_comb begin
        reg_wr_addr = instruction[11:7];
        reg_s1_addr = instruction[19:15];
        reg_s2_addr = instruction[24:20];
    end


    // Write operation 
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) 
            foreach (register_file[i]) register_file[i] <= 0;
        
        else if (regfile_wr_en && reg_wr_addr != 0) 
            register_file[reg_wr_addr] <= reg_wr_data;
       
        else if (regfile_wr_en && reg_wr_addr == 0) 
            register_file[reg_wr_addr] <= 0;
        
        else
            register_file[reg_wr_addr] <= register_file[reg_wr_addr];
    end
    

    // Read operation
    always_comb begin
        reg_s1_data = register_file[reg_s1_addr];
        reg_s2_data = register_file[reg_s2_addr]; 
    end
    

endmodule