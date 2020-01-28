`timescale 1ns / 1ps

module Counter(
    input BTN0,
    input BTN1,
    output [3:0] LEDS,
    input CLOCK,
    input RESET
    );
    
    reg [3:0] LEDS = 4'b0;
    reg [26:0] Add = 27'b0;
    
    always @ (posedge CLOCK)
    begin
        // reset the counter LEDs
        if (RESET)
        begin
            Add <= 27'b0;
            LEDS <= 4'b0;
        end
        
        // counter for 1 second
        else
        begin
            if (Add == 27'b111111111111111111111111111)
            begin
                if (BTN0 == 1)
                begin
                    LEDS <= LEDS + 4'b1;
                    Add <= 27'b0;
                end
                else if (BTN1 == 1)
                begin
                    LEDS <= LEDS - 4'b1;
                    Add <= 27'b0;
                end
            end
            else 
            begin
                // increment the counter when any of the two buttons are pressed
                // exclude the reset button
                if (BTN0 || BTN1)
                begin
                    Add <= Add + 27'b1;
                end
                // do not increment if no buttons are pressed
                // exclude the reset button
                else if (!BTN0 || !BTN1)
                begin
                    Add <= 27'b0;
                end
            end	   
        end
    end
                      
endmodule
