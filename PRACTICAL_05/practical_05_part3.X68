*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
            ORG    $1000              ; Set the starting address of the program
DAMAGE  EQU    100               ; Define a constant DAMAGE with a value of 100

START:  
GAME_LOOP:  
        LEA     MSG_GAME_LOOP, A1 ; Load the address of the "Game Loop" message into A1
        MOVE.B  #13, D0           ; Load the system call number for printing into D0
        TRAP    #15               ; Trigger the system call to display the message
        CMP.B   #0, PLAYER_HEALTH ; Compare PLAYER_HEALTH with 0
        BEQ     GAME_OVER         ; If PLAYER_HEALTH is 0, branch to GAME_OVER

        BSR     UPDATE            ; Branch to the UPDATE subroutine
        BSR     COLLISION_CHECK   ; Branch to the COLLISION_CHECK subroutine
        BRA     GAME_LOOP         ; Unconditionally branch back to GAME_LOOP

UPDATE:  
        ADD.B   #1, PLAYER_POSITION ; Increment PLAYER_POSITION by 1
        RTS                       ; Return from the subroutine

COLLISION_CHECK:  
        MOVE.B  PLAYER_POSITION, D1 ; Load PLAYER_POSITION into D1
        CMP.B   ENEMY_POSITION, D1 ; Compare PLAYER_POSITION with ENEMY_POSITION
        BEQ     COLLISION          ; If equal, branch to COLLISION
        RTS                       ; Return from the subroutine

COLLISION:  
        SUB.B   #DAMAGE, PLAYER_HEALTH ; Subtract DAMAGE from PLAYER_HEALTH
        BRA     GAME_LOOP          ; Unconditionally branch back to GAME_LOOP

GAME_OVER:  
        LEA     MSG_GAME_OVER, A1  ; Load the address of the "Game Over" message into A1
        MOVE.B  #13, D0            ; Load the system call number for printing into D0
        TRAP    #15                ; Trigger the system call to display the message
        SIMHALT                    ; Halt the simulator

PLAYER_POSITION: DC.B    10        ; Define PLAYER_POSITION with an initial value of 10
ENEMY_POSITION:  DC.B    50        ; Define ENEMY_POSITION with an initial value of 50
PLAYER_HEALTH:   DC.B    100       ; Define PLAYER_HEALTH with an initial value of 100

MSG_GAME_LOOP:   DC.B    'Game Loop........', 0 ; Define "Game Loop" message (null-terminated)
MSG_GAME_OVER:   DC.B    'Game Over!', 0       ; Define "Game Over!" message (null-terminated)

        END    START              ; Indicate the end of the program and the start address
;Review Questions
;What Are EQU, BEQ, LEA, and TRAP #15 Used For?
;EQU: Defines constants for reuse (e.g., DAMAGE EQU 100).
;BEQ: Branches to a label if two values are equal (Zero Flag = 1).
;LEA: Loads memory addresses into address registers (e.g., LEA MSG_GAME_LOOP, A1).
;TRAP #15: Executes a system call to print messages or perform I/O.

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
