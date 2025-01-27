*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    LEA $4000, A1 ;A1 holds adress $4000
    MOVE.B #100, (A1) ; memory at $4000 will contain the byte 100 (decimal), which is 0x64 in hexadecimal.

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source
    
    ;review questions:
    ;Address registers (like A1) hold memory addresses. 
    ;These registers don’t store the data themselves but point to where data is stored in memory.
    ;Tthe value 100 is stored at address $4000 in memory. This is done because the MOVE.B instruction tells the program to place this byte (the value 100) into the memory location pointed to by A1 (which is $4000).


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
