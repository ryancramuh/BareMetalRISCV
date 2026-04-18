// `timescale <time_unit>/<time_precision>
// time_unit defends unit of 1 pound delay (#1) 
// time_precision rounds the delay to the nearest multiple of time_precision 

`timescale 1ns/1ps 

module REG_FILE #(
    localparam XLEN = 32, // register width
    localparam XWID = 5// number of registers
)
(
    input wire clk, 
    input wire [XWID-1:0] rs1_addr, 
    input wire [XWID-1:0] rs2_addr, 
    input wire [XWID-1:0] rd_addr, 
    input wire [XLEN-1:0] rd_data, 
    input wire reg_write_en, 
    output reg [XLEN-1:0] rs1_data, 
    output reg [XLEN-1:0] rs2_data
);  

    reg [XLEN-1:0] reg_file [2**XWID-1:0]; // 32 registers, each XLEN bits wide 

    // simulation init
    initial begin
        reg_file[0] = XLEN'b0; // x0 is always zero
        reg_file[2] = XLEN'h0001_0000; // x2 (sp) initialized to 0x10000 
    end 

    // asynchronous read 
    always @(*) begin 
        rs1_data = reg_file[rs1_addr]; 
        rs2_data = reg_file[rs2_addr]; 
    end 

    // synchronous write 
    always @(posedge clk) begin 
        if (reg_write_en && rd_addr != 0) begin 
            reg_file[rd_addr] <= rd_data; 
        end 
    end

endmodule

