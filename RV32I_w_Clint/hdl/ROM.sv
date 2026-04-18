`timescale 1ns/1ps 

module ROM_24kB #(
    localparam XLEN = 32, // data width
    
)(
    input wire [ADDR_WIDTH-1:0] addr, 
    output reg [XLEN-1:0] data
);  

    reg [31:0] rom [ROM_SIZE-1:0]; // 24 kB ROM, byte-addressable 

    // simulation init - load instructions into ROM 
    initial begin 
        $readmemh("rom_init.hex", rom); // load ROM contents from hex file 
    end 

    // asynchronous read - combine 4 bytes to form a 32-bit instruction 
    always @(*) begin 
        data = {rom[addr], rom[addr+1], rom[addr+2], rom[addr+3]}; 
    end
);

endmodule

