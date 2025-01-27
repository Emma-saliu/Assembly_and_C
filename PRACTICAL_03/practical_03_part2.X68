*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    LEA $4000, A2 ; Load address $4000 into address register A2
    MOVE.B #100, (A2) ; Move the value 100 (decimal) into the memory address pointed by A2 ($4000)
    SUB.B  #10, (A2) ; Subtract 10 (decimal) from the byte at memory location $4000

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source
    
    ;review questions
    ;Address registers (like A2) hold addresses specific locations in memory.
    ;the memory at $4000 holds the value 100 (decimal), t he program stores data in memory so that it can be used or modified later

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
