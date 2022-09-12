// processor
`timescale 1ns/1ps
module processor(a,b,instruction,clk,rst,y);
    input [31:0] a,b;
    input [31:0] instruction;
    input clk, rst;
    wire [31:0] rs1, rs2;
    output [31:0] y;
    wire [31:0] rd;
    wire [4:0] rs1_address, rs2_address, rd_address;
    wire [6:0] opcode, p;
    wire [2:0] func;
    wire [3:0] cs;

    instruction_decoder id(instruction,opcode,clk,p,func,rs1_address,rs2_address,rd_address);
    register_bank rg(a,b,rs1_address,rs2_address,rd_address,rd,rs1,rs2,rst,clk);
    controller cn(p,func,cs);
    alu ar(rs1,rs2,cs,rd,y);
endmodule

//instruction decoder
`timescale 1ns/1ps
module instruction_decoder(instruction,opcode,clk,p,func,rs1_address,rs2_address,rd_address);
    input [31:0] instruction;
    input clk;
    output reg [6:0] opcode, p;
    output reg [2:0] func;
    output reg [4:0] rs1_address, rs2_address, rd_address;


    always@(instruction) begin
        opcode = instruction[6:0];
        p = instruction[31:25];
        func = instruction[14:12];
        rs1_address = instruction[19:15];
        rs2_address = instruction[24:20];
        rd_address = instruction[11:7];
    end
endmodule

//register bank
`timescale 1ns/1ps
module register_bank (a,b,rs1_address,rs2_address,rd_address,rd,rs1,rs2,rst,clk);
    input [31:0] a,b,rd;
    input [4:0] rs1_address,rs2_address,rd_address;
    input rst,clk;
    integer k;
    output reg [31:0] rs1,rs2;
    reg [31:0] rb [0:31];

    always@(posedge clk) begin
        if(rst==1) begin
            for(k=0;k<32;k=k+1)
                rb[k]=0;
        end
        else begin
            rb[rs1_address]=a;
            rb[rs2_address]=b;
            rs1=rb[rs1_address];
            rs2=rb[rs2_address];
            rb[rd_address]=rd;
        end
    end
endmodule

//controller
`timescale 1ns/1ps
module controller(p,func,cs);
    input [2:0] func;
    input [6:0] p;
    output reg [3:0] cs;

    always@(func,p) begin
        cs = {p[5],func};
    end
endmodule


//alu
`timescale 1ns/1ps
module alu(rs1,rs2,cs,rd,y);
    input [3:0] cs;
    output reg [31:0] y;
    input [31:0] rs1, rs2;
    output reg [31:0] rd;
    // For signed arithmetic
    wire signed [31:0] sA = rs1;
    wire signed [31:0] sB = rs2;

    parameter
      ADD = 4'b0000,
      SUB = 4'b1000,
      SLL = 4'b0001,
      SLT = 4'b0010,
      SLTU = 4'b0011,
      XOR = 4'b0100,
      SRL = 4'b0101,
      SRA = 4'b1101,
      OR = 4'b0110,
      AND = 4'b0111;

    always@(cs,rs1,rs2) begin
    case(cs)

        ADD: begin
            rd = rs1+rs2;
            y=rd;
        end

        SUB: begin
            rd = rs1-rs2;
            y=rd;
        end

        SLL:begin
            rd = rs1 << rs2[4:0];
            y=rd;
        end

        SLT: begin
            rd = {31'd0,(sA < sB)};
            y=rd;
        end

        SLTU: begin
            rd = {31'd0,(rs1 < rs2)};
            y=rd;
        end

        XOR: begin
            rd = rs1 ^ rs2;
            y=rd;
        end

        SRL: begin
            rd = rs1 >> rs2[4:0];
            y=rd;
        end

        SRA: begin
            rd = sA >>> rs2[4:0];
            y=rd;
        end

        OR: begin
            rd = rs1 | rs2;
            y=rd;
        end

        AND: begin
            rd = rs1 & rs2;
            y=rd;
        end

        default: begin
            rd = 0; y=rd;
        end

    endcase
    end

endmodule
