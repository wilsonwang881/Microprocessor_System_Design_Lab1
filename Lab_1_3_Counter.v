`timescale 1ns / 1ps

module Counter(
    input CLOCK,
    input RESET,
    output Signal
    );
    
    reg [26:0] Add = 27'b000000000000000000000000000;
    reg Signal_High = 1'b0;

    
    always @ (posedge CLOCK)
    begin
            if (Add == 27'b111111111111111111111111111)
            begin
                Add <= Add + 27'b000000000000000000000000001;
                Signal_High <= 1'b1;                         
            end
            else 
            begin
                Add <= Add + 27'b000000000000000000000000001;
                Signal_High <= 1'b0;
            end
        end  
        
    assign Signal = Signal_High;
    
endmodule
