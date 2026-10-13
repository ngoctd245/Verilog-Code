`timescale 1ns / 1ps
module PJ_23(
  //input [7:0] hundreds,
    input toggles,
    
    input clock_n,
    input reset_p,
    input load_n,
    input clock_enable_n,
    
    output reg [7:0] view_hundreds ); //8bit = mode 256 (0-255)
    
    reg [7:0] reg_hundreds;

always @(negedge clock_n or posedge reset_p) begin
    if (reset_p == 1) begin
    reg_hundreds <= 0; end
    
    else if (load_n == 0) begin
        if (toggles == 1) begin
        reg_hundreds <= 255; end
        
        else begin 
        reg_hundreds <= 0; end    
        end
     
     else if (clock_enable_n == 0) begin
     if (toggles == 1) begin
        if (reg_hundreds != 0) begin
        reg_hundreds <= reg_hundreds - 1; end
        
        else begin
        reg_hundreds <= 255; end
     end
     
     else begin
        if (reg_hundreds != 255) begin
            reg_hundreds <= reg_hundreds + 1; end
        else begin 
            reg_hundreds <= 0; end    
     end
        end   
        
    end        
endmodule
