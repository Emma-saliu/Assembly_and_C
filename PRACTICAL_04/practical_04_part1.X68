*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    MOVE.B #100, $3000  ; Store the value 100 at memory location $3000
    
    LEA $3000, A1   ; Load the address $3000 into address register A1
    
    SUB.B   #20, (A1)   ; Subtract 20 from the value at address $3000
    
    ADD.B   #10, (A1)   ; Add 10 to the value at address $3000
    

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source
    
    ;review questions
    ;LEA $3000, A1: The A1 register holds the memory address $3000, allowing subsequent operations to indirectly reference this memory location.
    ;the final value stored in memory at $3000 is 90.
    ;Memory holds data that the program needs to process or modify. Here, $3000 acts as a simple storage location to demonstrate operations.

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
