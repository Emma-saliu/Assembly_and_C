*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

; Data Section
PLAYER_POINTS   DC.W    $0000     ; Player points (initialized to 0)
PLAYER_HEALTH   DC.B    $64       ; Player health (100% = $64)
PLAYER_X_POS    DC.W    $0000     ; Player X position (initial position = 0)
PLAYER_Y_POS    DC.W    $0000     ; Player Y position (initial position = 0)

BOSS_HEALTH     DC.B    $64       ; Boss health (100% = $64)
BOSS_X_POS      DC.W    $0200     ; Boss X position
BOSS_Y_POS      DC.W    $0100     ; Boss Y position

        ORG    $2000       
        ; Initialize data registers
        MOVE.B  PLAYER_HEALTH, D0   ; Load player's health into D0 (100% health = $64)
        MOVE.W  PLAYER_X_POS, D1   ; Load player X position into D1 (initial position = 0)

        ; Perform arithmetic operation: Subtract 10 from player health
        SUB.B   #$0A, D0           ; Subtract 10 from player's health in D0

        ; Store the result back into the memory (PLAYER_HEALTH)
        MOVE.B  D0, PLAYER_HEALTH  ; Store updated health back into the memory

        ; Perform another operation: Add 20 points to the player's score
        ADD.W   #$14, PLAYER_POINTS  ; Player points += 20 ($14 in hex = 20 in decimal)

        ; Logical Operation: Set the least significant bit of the player points
        OR.B    #$01, PLAYER_POINTS  ; Set the least significant bit of PLAYER_POINTS

        ; Check if player health is below 80% (i.e., less than $50)
        CMP.B   #$50, PLAYER_HEALTH   ; Compare player health with 80% health ($50)
        BLO     LOW_HEALTH        ; If less than 80%, branch to LOW_HEALTH

        ; Normal operation if health is okay
        BRA     CONTINUE

LOW_HEALTH:
        ; Handle low health scenario
        ; For instance, set the player's points to 0 and display a message (optional in debug)
        MOVE.W  #$0000, PLAYER_POINTS   ; Set player points to 0 (lose all points)
        BRA     CONTINUE

CONTINUE:
        ; Code continues, update player position
        ADD.W   #$02, D1          ; Increment player X position by 2 (move right)
        MOVE.W  D1, PLAYER_X_POS  ; Store updated X position back into memory

        ; Boss behavior: Subtract 5 from boss health
        SUB.B   #$05, BOSS_HEALTH  ; Boss health -= 5

        ; Update Boss position: Increment Y position by 3
        ADD.W   #$03, BOSS_Y_POS  ; Increment Boss Y position by 3
        MOVE.W  BOSS_Y_POS, D2    ; Store updated Y position in D2 (for display or further use)

        ; Branch to a loop (or end of game)
        BRA     END

END:
        ; End of program - halt or loop forever (you can modify as needed)
        BRA     END               ; Infinite loop to stop execution here (debugging point)
        
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source
    
    ;review questions
    ;Immediate Addressing: Used for constants like #10 or #$0A (e.g., SUB.B #$0A, D0).
    ;Direct Addressing: Used to refer to memory locations directly (e.g., MOVE.B PLAYER_HEALTH, D0).
    ;Register Indirect Addressing: Not explicitly shown in this example, but it would involve using address registers (e.g., MOVE.B (A0), D0).
   
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
