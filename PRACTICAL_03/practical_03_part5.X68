*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    MOVEA.L #ACHIEVEMENT_POINTS, A1  ; Load address of the array into A1
    MOVE.L  #0, D0                  ; Initialize sum accumulator to 0
    MOVE.L  #5, D1                  ; Number of elements in the array
    
LOOP:
    MOVE.L  (A1)+, D2               ; Load next array element into D2
    ADD.L   D2, D0                  ; Add the value in D2 to D0
    SUBQ.L  #1, D1                  ; Decrement the counter (D1)
    BNE     LOOP                    ; Repeat until all elements are processed

END:
    STOP    #$2000                 ; End of program

ACHIEVEMENT_POINTS:
    DC.L 5, 10, 15, 20, 30          ; Array of longword integers
    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
