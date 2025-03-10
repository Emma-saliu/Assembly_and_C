    ORG    $1000         ; Set starting address for the program

START:                  
    ; Push address of HEALTH onto the stack using alternative method (move and decrement SP)
    SUBQ.L #4, SP        ; Reserve space for 4 bytes on the stack
    MOVE.L #HEALTH, (SP) ; Move address of HEALTH into the stack

    ; Initialize D0 and D1 with 14 (possible health values)
    MOVE.B #14, D0
    MOVE.B #14, D1

    ; Push D0 and D1 onto the stack
    SUBQ.L #4, SP        ; Prepare space for D0
    MOVE.L D0, (SP)      ; Store D0 on the stack

    SUBQ.L #4, SP        ; Prepare space for D1
    MOVE.L D1, (SP)      ; Store D1 on the stack

    ; Jump to the game loop to process the logic
    JSR GAME_LOOP

    ; Call heads up display to show the health
    JSR HEADS_UP_DISPLAY
    
    ; Jump to the end of the game
    BRA END_GAME

GAME_LOOP:
    ; Load values from the stack into D1 and D0
    MOVE.L 4(SP), D1     ; Load value from 4 bytes above SP into D1
    MOVE.L 8(SP), D0     ; Load value from 8 bytes above SP into D0

    ; Compare the values in D0 and D1
    CMP D0, D1
    BEQ DAMAGE            ; If equal, jump to DAMAGE

    BRA NO_DAMAGE         ; If not equal, jump to NO_DAMAGE

DAMAGE:
    ; Simulate damage if condition is met
    MOVEA.L 12(SP), A1   ; Load address of HEALTH into A1
    SUB.B #10, (A1)      ; Subtract 10 from the value of HEALTH (damage)

NO_DAMAGE:
    RTS                   ; Return from the subroutine

HEADS_UP_DISPLAY:
    ; Show the current health on the screen or display
    MOVE.B HEALTH, D1    ; Load HEALTH into D1
    MOVE.B #3, D0        ; Set D0 to 3 (likely for displaying on screen)
    TRAP    #15          ; Call system function to display the health
    RTS                   ; Return from the subroutine

END_GAME:
    ; Halt the simulation or program
    SIMHALT              ; Stop execution of the program

HEALTH: 
    DC.B 100             ; Define a byte for health, initialized to 100

    END START            ; End the program and specify the entry point
    
;review questions
;Stack Pointer Mismanagement
;The most significant risk when manually adjusting the stack pointer (SP) is mismanagement. If you forget to adjust the stack pointer correctly (either by forgetting to decrement it before writing data or failing to increment it afterward), you can overwrite or access incorrect data, leading to stack corruption
;Stack Overflow or Underflow:
;If you reserve more space on the stack than is available (stack overflow) or attempt to access data that is beyond the stack (stack underflow), your program may crash or exhibit unpredictable behavior.

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
