*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    MOVE.L #%100,    D0 ;stores the actual binary number 100(4 decimal) in D0
    MOVE.L #$100,    D1 ;stores the actual hexadecimal number in D1
    MOVE.L #100,     D2 ;stores the actual number 100 (64 hexadecimal) in D2
    
    MOVE.L D0,  $3000   ;The value from register D0 is stored at the memory address 3000
    MOVE.L D1,  $3010   ;The value from register D1 is stored at the memory address 3010
    MOVE.L D2,  $3020   ;The value from register D2 is stored at the memory address 3020




    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
