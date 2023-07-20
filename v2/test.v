`timescale 1ns/1ps
module tb();
    reg clk,rst;
    reg [31:0] instruction, a, b;
    wire [31:0] y;

    processor dut(a,b,instruction,clk,rst,y);
    always #5 clk=~clk;
    initial begin
        clk=1;
    end
    initial begin
    rst=1; #5 rst=0;
    // rs2=R1, rs1=R0, rd=R2
    //                32'b0000000-00001-00000-000-00010-0110011;
    #5  instruction = 32'b00000000000100000000000100110011;
    a = 32'h0000000F; b = 32'h0000000C;
    #20 instruction = 32'b01000000000100000000000100110011;
    a = 32'h0000000F; b = 32'h0000000C;
    #20 instruction = 32'b00000000000100000001000100110011;
    a = 32'hFF0000FF; b = 32'h00000004;
    #20 instruction = 32'b00000000000100000010000100110011;
    a = 32'h70000000; b = 32'hF0000000;
    #20 instruction = 32'b00000000000100000011000100110011;
    a = 32'h70000000; b = 32'hF0000000;
    #20 instruction = 32'b00000000000100000100000100110011;
    a = 32'h0000000F; b = 32'h0000000C;
    #20 instruction = 32'b00000000000100000101000100110011;
    a = 32'hFF0000FF; b = 32'h00000004;
    #20 instruction = 32'b01000000000100000101000100110011;
    a = 32'hFF0000FF; b = 32'h00000004;
    #20 instruction = 32'b00000000000100000110000100110011;
    a = 32'h0000000F; b = 32'h0000000C;
    #20 instruction = 32'b00000000000100000111000100110011;
    a = 32'h0000000F; b = 32'h0000000C;
    #50 $finish;
    end
endmodule


