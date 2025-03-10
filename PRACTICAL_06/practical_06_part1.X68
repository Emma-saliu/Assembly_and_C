       ORG    $1000         ; Start of program memory

START:                      ; First instruction of the program

       ; Move trap task number to D0
       MOVE.B #2, D0        
       TRAP    #15          ; Execute trap task

       ; Load message address into A1
       LEA     MESSAGE, A1  
       MOVE.B  #13, D0      ; Function 13 - Print string
       TRAP    #15          ; Execute trap to print message

END_PROG:

MESSAGE: DC.B 'Trap task test', 0  ; Null-terminated string

       SIMHALT              ; Halt the simulator

       END    START         ; End of the program

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
