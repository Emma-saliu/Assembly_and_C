*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    MOVE.L #%100, D0    ;binary value 100 (4 in decimal) is moved into the D0 register.
    MOVE.L #%100, D1    ;binary value 100 (4 in decimal) is moved into the D1 register.
    MOVE.L #%100, D2    ;binary value 100 (4 in decimal) is moved into the D2 register.


    MOVE.L D0, $3000    ;D0 contains the value 4 (binary 100), so 4 is stored at address $3000
    MOVE.L D1, $3010    ;D1 contains the value 4 (binary 100), so 4 is stored at address $3010
    MOVE.L D2, $3020    ;D2 contains the value 4 (binary 100), so 4 is stored at address $3000

    MOVE.W #100, $3020  ;value 100 is stored at memory location $3020. This overwrites part of the value stored in $3020
    MOVE.W #100, $3010  ;value 100 is stored at memory location $3020. This overwrites part of the value stored in $3020
    MOVE.W #%100, $3000 ;binary value 100 (4) is stored as a 16-bit word at memory location $3000, overwriting part of the previous data stored there stored in $3020

    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
