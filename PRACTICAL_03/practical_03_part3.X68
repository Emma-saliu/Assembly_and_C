*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    LEA HEALTH, A3      ; Load the address of 'HEALTH' into address register A3
    SUB.B   #10, (A3)   ; Subtract 10 (decimal) from the byte at memory location pointed by A3 (the location of 'HEALTH')
    SIMHALT             ; halt simulator

HEALTH dc.b     $64     ; Define a byte with value 100 (decimal) at the label 'HEALTH'


    END    START        ; last line of source
    
    ;Review questions
    ;HEALTH dc.b $64 means that at the memory location labeled HEALTH, the value 100 (decimal) is stored.
    ;The value 100 is stored in memory at the address corresponding to the label HEALTH. After executing the SUB.B #10, (A3) instruction, the value at the memory address of HEALTH is reduced by 10
    ;it represents some kind of data that we want to track and update
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
