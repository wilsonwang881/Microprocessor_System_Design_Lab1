`timescale 1ns / 1ps

module Jackpot(
    input [3:0] SWITCHES,
    output [3:0] LEDS,
    input CLOCK,
    input RESET
    );
    
    reg [3:0] LEDS = 4'b1;
    wire Signal_High1;
    
    reg [26:0] Add = 27'b000000000000000000000000000;
    reg succ = 1'b0;
    reg blink = 1'b0;
    reg [3:0] key_value = 4'b0;
    
    wire Signal_High;
    
    // Timer module
    Counter counter (CLOCK, RESET, Signal_High);
    
    always @ (posedge Signal_High)
    begin
        // ensure flipping the right switch at the right time
        // exclude condition that a user flips the switch in advance
        // and wait for the LED to turn on
        key_value <= SWITCHES;
        
        // reset operation
        if (RESET)
            begin
                succ <= 1'b0;
                LEDS <= 4'b1;
            end
            
        // blink when the user wins
        else if (succ==1'b1)
        begin
            if (blink == 1'b1)
            begin
                LEDS <= 4'b1111;
                blink <= 1'b0;
            end
            else
            begin
                LEDS <= 4'b0000;
                blink <= 1'b1;
            end
        end
        
        // normal operation
        // wait for the user to flip on the right switch
        // at the right time
        else
        begin
            if (LEDS == 4'b1000)
            begin
                LEDS <= 4'b1;
                if (SWITCHES == LEDS && SWITCHES != key_value)
                    succ <= 1'b1;
                else
                    succ <= 1'b0;
            end
            else
            begin
                if (SWITCHES == LEDS  && SWITCHES != key_value)
                    succ <= 1'b1;
                else
                begin
                    succ <= 1'b0;
                    LEDS <= LEDS << 4'b1;
                end
            end
        end        
    end  
    
endmodule
