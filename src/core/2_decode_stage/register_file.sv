/*
    file: register_file.sv
    brief: The CPU register file which holds the architectural registers.
*/
`timescale 1ns / 1ps

module RegisterFile(
    input wire logic clk,
    input wire logic rst_n,
    input var logic regfile_wr_en,
    input var logic [4:0] rs1_addr,
    input var logic [4:0] rs2_addr,
    input var logic [4:0] wr_addr,
    input var logic [31:0] wr_data,
    output var logic [31:0] reg_data_a,
    output var logic [31:0] reg_data_b
);

    var logic [31:0] register_file [31:0];

    // Write operation 
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) 
            foreach (register_file[i]) register_file[i] <= 0;
        
        else if (regfile_wr_en && wr_addr != 0) 
            register_file[wr_addr] <= wr_data;
       
        else if (regfile_wr_en && wr_addr == 0) 
            register_file[wr_addr] <= 0;
        
        else
            register_file[wr_addr] <= register_file[wr_addr];
    end
    

    // Read operation
    always_comb begin
        reg_data_a = register_file[rs1_addr];
        reg_data_b = register_file[rs2_addr]; 
    end
    

endmodule