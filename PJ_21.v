`timescale 1ns / 1ps
module PJ_21 (
    input [3:0] ones,                     
    input [2:0] tens,                        
    
    input clock_p,
    input reset_p,
    input load_p,
    input clock_enable_p,
    
    output reg [6:0] led_ones,
    output reg [6:0] led_tens );           
    
    reg [3:0] reg_ones;
    reg [2:0] reg_tens;
    
always @(posedge clock_p) begin
    if (reset_p == 1) begin
        reg_tens <= 0;
        reg_ones <= 0; end
        
    else if (load_p == 1) begin
        reg_tens <= 5;
        reg_ones <= 9; end
    
    else if (clock_enable_p == 1) begin
        if (reg_ones != 0) begin
            reg_ones <= reg_ones - 1; end
        
        else if (reg_ones == 0 && reg_tens != 0) begin
            reg_tens <= reg_tens - 1;
            reg_ones <= 9; end
        
        else if (reg_ones == 0 && reg_tens == 0) begin
            reg_tens <= 5;
            reg_ones <= 9; end
        end       
end    
    
always @(*) begin                       
    case (reg_ones) 
         4'd0: led_ones = 7'b1111110;
         4'd1: led_ones = 7'b0110000;
         4'd2: led_ones = 7'b1101101;
         4'd3: led_ones = 7'b1111001;
         4'd4: led_ones = 7'b0110011;
            5: led_ones = 7'b1011011;
            6: led_ones = 7'b1011111;
            7: led_ones = 7'b1110000;
            8: led_ones = 7'b1111111;
            9: led_ones = 7'b1111011;
      default: led_ones = 7'b0000000;
    endcase
end
       
always @(*) begin
    case(reg_tens) 
            0: led_tens = 7'b1111110;
            1: led_tens = 7'b0110000;
            2: led_tens = 7'b1101101;
            3: led_tens = 7'b1111001;
            4: led_tens = 7'b0110011;
            5: led_tens = 7'b1011011;
      default: led_tens = 7'b0000000;  
    endcase
end

endmodule
