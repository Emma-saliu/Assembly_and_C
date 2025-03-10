       ORG    $1000           ; Start of program memory

START:
       ; Clear Screen
       MOVE.W #$FF00, D1      ; Function to clear screen
       TRAP    #15            ; Call Easy68K system

       ; Display message with CR, LF (Trap 13)
       LEA     MESSAGE1, A1
       MOVE.B  #13, D0
       TRAP    #15

       ; Display message without CR, LF (Trap 14)
       LEA     MESSAGE2, A1
       MOVE.B  #14, D0
       TRAP    #15

       ; Read string from keyboard (max 80 chars)
       LEA     BUFFER, A1
       MOVE.W  #80, D1        ; Max 80 chars
       MOVE.B  #2, D0         ; Read string function
       TRAP    #15

       ; Display input string with CR, LF
       LEA     BUFFER, A1
       MOVE.B  #13, D0
       TRAP    #15

       ; Read number from keyboard into D1.L
       MOVE.B  #5, D0
       TRAP    #15

       ; Display the signed number in D1.L
       MOVE.B  #20, D0
       TRAP    #15

       ; Read single character into D1.B
       MOVE.B  #1, D0
       TRAP    #15

       ; Display single character in D1.B
       MOVE.B  #3, D0
       TRAP    #15

       ; Check if keyboard input is pending (D1.B = 1 if key pressed)
       MOVE.B  #5, D0
       TRAP    #15

       ; Position cursor at ROW 5, COL 10
       MOVE.W  #$0A05, D1     ; COL=10 (0x0A), ROW=5 (0x05)
       MOVE.B  #6, D0
       TRAP    #15

       ; Set font color to red (R=255, G=0, B=0)
       MOVE.L  #$000000FF, D1 ; Red color (BBGGRR format)
       MOVE.B  #21, D0
       TRAP    #15

       ; Halt the simulator
       SIMHALT

MESSAGE1: DC.B 'Hello, Easy68K!', 0
MESSAGE2: DC.B 'This is printed without CR/LF', 0
BUFFER:   DS.B 80             ; Reserve 80 bytes for input

       END    START           ; End of program

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
