*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
            ORG    $1000        ; Start program at address $1000
START:  
        MOVE.B #3, D0       ; Load 3 into register D0 (loop counter)
        MOVE.B #0, D1       ; Load 0 into register D1 (score accumulator)

GAME_LOOP:
        CMP.B   #1, D0      ; Compare D0 with 1
        BEQ    GAME_OVER    ; If D0 == 1, go to GAME_OVER
         
GAME_POINTS:
        ADD.B   #10, D1     ; Add 10 to D1 (score)
        SUB.B   #1, D0      ; Decrease D0 by 1
        BRA     GAME_LOOP   ; Branch back to GAME_LOOP

GAME_OVER:
        SIMHALT             ; Stop execution in simulator

        END START           ; End of program

;Review questions 

;What is the purpose of CMP, BNE, and BEQ?
;CMP: Compares two values and updates flags, BNE: Branches if values are not equal and BEQ: Branches if values are equal.

;What does the Status Register do?
;Stores flags that control program flow and indicate arithmetic conditions.

;How many times does GAME_LOOP execute?
;2 times before D0 == 1 and the program exits.
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
