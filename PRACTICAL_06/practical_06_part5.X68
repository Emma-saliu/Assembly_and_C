START:                 ; First instruction of program

    MOVE.L #HEALTH, -(SP)  ; Push the address of the health variable onto the stack
    JSR GAME_LOOP          ; Jump to the GAME_LOOP subroutine
    BSR HEADS_UP_DISPLAY   ; Branch to the HEADS_UP_DISPLAY subroutine
    BRA END                ; Branch to END (program termination)

GAME_LOOP:
    MOVEA.L 4(SP), A1      ; Move the address of the health variable into A1 (from the stack)
    SUB.B #10, (A1)        ; Subtract 10 from the health value (decrement health)
    RTS                     ; Return from subroutine (back to the next instruction in START)

HEADS_UP_DISPLAY:
    LEA MESSAGE, A1        ; Load the address of the MESSAGE string into A1
    MOVE.B #14, D0         ; Set the trap code for displaying the message
    TRAP #15               ; Call the trap for displaying text (prints "Health:")
    MOVE.B #3, D0          ; Set the trap code for printing a new line
    TRAP #15               ; Call the trap to print a line feed (LF)
    RTS                     ; Return from the HEADS_UP_DISPLAY subroutine

HEALTH: DC.B 100          ; Define the initial health value (100)
MESSAGE: DC.B 'Health:', 0 ; Define the message string

END:
    SIMHALT                ; Halt the simulator (ends the program)

* Put variables and constants here

    END    START           ; End of program

;review questions
;Passing Parameters to Subroutines via the Stack
;Pushing Parameters: When calling a subroutine, values or arguments can be pushed onto the stack using instructions like MOVE or PUSH. These values are passed from the caller to the callee.
;Popping Parameters: Inside the subroutine, the parameters are popped from the stack using instructions like MOVE or POP, where they are then used in the function's execution.

;Other Functions Achieved Through the Stack
;Function Return Addresses
;Storing Local Variables

;Observations from Opening VIEW | STACK
;Memory Layout:
;You will see the current contents of the stack and how data is laid out in memory. This will often show you the parameters that have been pushed, return addresses, and possibly saved registers.

;Stack Growth:
;You can observe how the stack grows downward in memory (toward lower addresses) when pushing data onto the stack, and shrinks upward when popping data.

;Debugging the Stack:
;By examining the stack during debugging, you can verify that the right parameters are passed to subroutines and check the return addresses when subroutines return. This helps track the flow of the program and debug issues such as incorrect function calls or stack overflows.
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
