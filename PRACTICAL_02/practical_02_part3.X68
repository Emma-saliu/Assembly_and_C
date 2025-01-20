*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    MOVE.L #%100, D0    ;moves the value 4 into the D0 register.
    MOVE.L #%100, D1    ;moves the value 4 into the D1 register.
    MOVE.L #%100, D2    ;moves the value 4 into the D2 register.


    MOVE.L D0, $3000    ;Moves the 32-bit value from the D0 register ( 4) into memory location $3000
    MOVE.L D1, $3010    ;Moves the 32-bit value from the D1 register (4) into memory location $3010
    MOVE.L D2, $3020    ;Moves the 32-bit value from the D2 register (4) into memory location $3020


    MOVE.W #100, $3020  ;partially overwrites the 32-bit data previously stored at $3020
    MOVE.W #100, $3010  ;partially overwrites the 32-bit data previously stored at $3010
    MOVE.W #%100, $3000 ;value 4 is moved to memory location $3000 as a 16-bit word, overwriting part of the data there.

    MOVE.B #100, $3020  ;value 100 (in decimal) is stored in the least significant byte of memory location $3020
    MOVE.B #$64, $3010  ;value 100 is moved into the least significant byte of memory location $3010
    MOVE.B #%10001111, $3000    ;value 143 is stored in the least significant byte of memory location $3000

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
