*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

   ; Move data to memory and data registers
    MOVE.B  #100, $3000       ; Store value 100 at memory location $3000
    MOVE.B  #$12, D2          ; Load hexadecimal 12 into D2
    MOVE.B  #$22, D3          ; Load hexadecimal 22 into D3

    ; Logical operations
    AND.B   D2, D3            ; Perform bitwise AND: D3 = D3 AND D2
    OR.B    D2, D3            ; Perform bitwise OR: D3 = D3 OR D2
    EOR.B   D2, D3            ; Perform bitwise XOR: D3 = D3 XOR D2
    NOT.B   D3                ; Perform bitwise NOT: D3 = NOT D3

    ; Address register usage and memory manipulation
    LEA     $3000, A1         ; Load effective address $3000 into A1
    SUB.B   #20, (A1)         ; Subtract 20 from the byte at address $3000
    ADD.B   #10, (A1)         ; Add 10 to the updated byte at address $3000
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source
    
    ;logical instructions manipulate data at the bit level.
    ;Immediate Addressing for constants, Direct Addressing for accessing a specific memory location and Indirect Addressing with an address register (A1) to dynamically access memory 

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
