*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
           ORG    $1000
START:  
        LEA PLAYER_POSITION, A1    ; Load Player Position Address into A1
        LEA ENEMY_POSITION, A2     ; Load Enemy Position Address into A2

        MOVE.B (A1)+, D1           ; Load Player X Position into D1
        MOVE.B (A1), D2            ; Load Player Y Position into D2
        
        MOVE.B (A2)+, D3           ; Load Enemy X Position into D3
        MOVE.B (A2), D4            ; Load Enemy Y Position into D4

COLLISION_CHECK:
        CMP.B D1, D3               ; Compare Player X with Enemy X
        BNE NEXT_MOVE              ; If not equal, move to next
        
        CMP.B D2, D4               ; Compare Player Y with Enemy Y
        BNE NEXT_MOVE              ; If not equal, move to next

        BRA COLLISION              ; If both X and Y match, jump to COLLISION

NEXT_MOVE:
        ADD.B #1, D1               ; Move Player X (simulate movement)
        ADD.B #1, D2               ; Move Player Y (simulate movement)
        BRA COLLISION_CHECK        ; Loop again

COLLISION:
        BRA GAME_OVER              ; Collision detected, end game

GAME_OVER:
        SIMHALT                    ; Halt simulator

PLAYER_POSITION: DC.B 50, 50        ; Player starts at (50,50)
ENEMY_POSITION:  DC.B 55, 55        ; Enemy is at (55,55)

        END    START
        
;Review questions

;What does BEQ mean?
;BEQ (Branch if Equal) jumps if the Zero (Z) flag is set.This means the values being compared are equal.

;What Addressing Modes Are Used?
;LEA (Load Effective Address)
;LEA PLAYER_POSITION, A1 ? Addressing Mode: Immediate Addressing
;Loads the address (not the value) into A1.

;(A1)+ (Post-Increment Addressing)
;MOVE.B (A1)+, D1, Loads PLAYER_POSITION X, then increments A1 to point to Y.

;Direct Addressing
;CMP.B D1, D3, Compares the values stored in registers.




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
