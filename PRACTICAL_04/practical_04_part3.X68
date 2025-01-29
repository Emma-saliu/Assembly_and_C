*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    MOVE.B  #100, $3000       ; Initialize memory location $3000 with 100 (initial health)
    LEA     $3000, A1         ; Load address of $3000 into A1 (pointer to health value)

    BSR     TAKING_DAMAGE     ; Call subroutine to simulate taking damage

BACK_IN_THE_GAME:
    BSR     HEALTH_PICKUP     ; Call subroutine to simulate picking up health
    BRA     GAME_END          ; Unconditional branch to end the game

TAKING_DAMAGE:
    SUB.B   #20, (A1)         ; Decrease health by 20
    BRA     BACK_IN_THE_GAME  ; Unconditional branch back to main game flow

HEALTH_PICKUP:
    ADD.B   #10, (A1)         ; Increase health by 10
    RTS                      ; Return from subroutine

GAME_END:
    MOVE.B  #$00, (A1)        ; Set health to 0 (end state)
    SIMHALT                  ; Halt simulator for debugging

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source
    
    ;REVIEW QUESTIONS
    ;BRA: Simplifies flow control with unconditional jumps AND BSR: Allows calling subroutines, enabling code reuse and better organization.
    ;Immediate Addressing: For constants, direct Addressing: For fixed memory locations and indirect Addressing: For memory locations pointed to by an address register.

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
