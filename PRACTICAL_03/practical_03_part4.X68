*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
    
START:    
     ; Example 1: Increase Player Health by 20
    ADD.L   #$14, (A0)

    ; Example 2: Decrease Boss Health by 50
    SUB.L   #$32, (A4)    
       
    ; Example 3: Player Points after bonus = 300
    MOVE.L  #$12C, (A1)          

    ; Example 4: Update Player X Position to 12
    MOVE.W  #$000C, (A2)         

    ; Example 5: Update Player Y Position to 25
    MOVE.W  #$0019, (A3)         
    ; Example 6: Player Health after taking damage = 80% (hex 0x50)
    MOVE.L  #$50, (A0)          

    ; Example 7: Set Player X Position to 0 (origin)
    MOVE.W  #$0000, (A2)         

    ; Example 8: Set Player Y Position to 0 (origin)
    MOVE.W  #$0000, (A3)         

    ; Example 9: Increase Boss Health by 100
    ADD.L   #$64, (A4)          

    ; Example 10: Boss X Position changes to 40
    MOVE.W  #$0028, (A5)         

    ; Example 11: Decrease Player Points by 50 (penalty)
    SUB.L   #$32, (A1)           

    ; Example 12: Set Boss Health to 0 (Boss is defeated)
    MOVE.L  #$0000, (A4)     
        
SIMHALT             ; halt simulator

   ; Initialize Player Data
    MOVE.L  #$64, (A0)           ; Set Player Health to 100% (hex 0x64)
    MOVE.L  #$FA, (A1)           ; Set Player Points to 250 (hex 0xFA)
    MOVE.W  #$000A, (A2)         ; Set Player X Position to 10 (dec)
    MOVE.W  #$000F, (A3)         ; Set Player Y Position to 15 (dec)

    ; Initialize Boss Data
    MOVE.L  #$1F4, (A4)          ; Set Boss Health to 500 (hex 0x1F4)
    MOVE.W  #$001E, (A5)         ; Set Boss X Position to 30 (dec)
    MOVE.W  #$0028, (A6)         ; Set Boss Y Position to 40 (dec)




    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
