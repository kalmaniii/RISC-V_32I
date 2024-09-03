`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2024 01:45:46 PM
// Design Name: 
// Module Name: alu_rdx.sv
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


module ALUOperand(
    input var logic reg_b_select,
    input var logic [31:0] reg_data_b,
    input var logic [31:0] imm_value,
    output var logic [31:0] reg_data_x
);
    
    always_comb begin
        if (reg_b_select) reg_data_x <= reg_data_b;
        else reg_data_x <= imm_value;
    end

endmodule