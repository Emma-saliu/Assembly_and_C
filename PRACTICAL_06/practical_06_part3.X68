    ORG    $1000           ; Start of program memory

START:
    LEA     $4000, A7      ; Initialize Stack Pointer (A7) at memory location $4000

    ; Push values onto the stack (Pre-Decrement Mode)
    MOVE.B  #1, -(A7)      ; Store 1 at (A7 - 1), then update A7
    MOVE.B  #2, -(A7)      ; Store 2 at (A7 - 1), then update A7
    MOVE.B  #3, -(A7)      ; Store 3 at (A7 - 1), then update A7
    MOVE.B  #4, -(A7)      ; Store 4 at (A7 - 1), then update A7

    ; Pop values from the stack (Post-Increment Mode)
    MOVE.B  (A7)+, D1      ; Load value at A7 into D1, then increment A7
    MOVE.B  (A7)+, D2      ; Load value at A7 into D2, then increment A7
    MOVE.B  (A7)+, D3      ; Load value at A7 into D3, then increment A7
    MOVE.B  (A7)+, D4      ; Load value at A7 into D4, then increment A7

    SIMHALT                ; Halt the program (Stops simulation)

    END    START           ; End of program

; REVIEW QUESTIONS
;What is the purpose of Address Register A7?

;A7 is the stack pointer, managing function calls and temporary storage.
;The stack grows downward in memory using -(A7) (push) and (A7)+ (pop).
;Used in subroutines and interrupt handling.

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
