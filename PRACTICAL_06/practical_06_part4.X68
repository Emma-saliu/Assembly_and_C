
    ORG    $1000           ; Start of program memory

START:
    LEA     $4000, SP      ; Initialize Stack Pointer (SP = A7) at memory location $4000

    ; Push values onto the stack (Pre-Decrement Mode)
    MOVE.B  #1, -(SP)      ; Store 1 at (SP - 1), then update SP
    MOVE.B  #2, -(SP)      ; Store 2 at (SP - 1), then update SP
    MOVE.B  #3, -(SP)      ; Store 3 at (SP - 1), then update SP
    MOVE.B  #4, -(SP)      ; Store 4 at (SP - 1), then update SP

    ; Pop values from the stack (Post-Increment Mode)
    MOVE.B  (SP)+, D1      ; Load value at SP into D1, then increment SP
    MOVE.B  (SP)+, D2      ; Load value at SP into D2, then increment SP
    MOVE.B  (SP)+, D3      ; Load value at SP into D3, then increment SP
    MOVE.B  (SP)+, D4      ; Load value at SP into D4, then increment SP

    SIMHALT                ; Halt the program (Stops simulation)

    END    START           ; End of program
    
;REVIEW QUESTIONS   
;What is the purpose of the Stack Pointer SP
;SP is a dedicated register used to manage the stack.
;It grows downward in memory (-(SP) to push, (SP)+ to pop).
;Used for function calls, local variables, and interrupt handling.
;Ensures Last In, First Out (LIFO) execution.

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
