*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
DAMAGE      EQU 10
START:                  ; first instruction of program
    LEA     PLAYER_X, A2
    LEA     ENEMY_POSITIONS, A3
    BRA     GAME_LOOP
    
GAME_LOOP:
    BSR     COUNT_ENEMIES
    MOVE.B  D0, D4
    
    LEA     MSG_GAMELOOP, A1
    BSR     DRAW
    
    BSR     UPDATE
    BRA     GAME_LOOP
    
UPDATE:
    MOVE.B  PLAYER_HEALTH, D1
    
    LEA     MSG_HEALTH, A1
    BSR     DRAW
    
    MOVE.B  #3,D0
    TRAP    #15
    
    LEA     CRLF, A1
    BSR     DRAW
    
    CMP     #0, D1
    BLE     GAME_OVER
    ADD.L   #1, (A2)
    BSR     COLLISION
    RTS
    
DRAW:
    MOVE.B  #13, D0
    TRAP    #15
    RTS
    
COLLISION:
    MOVE.B  #1, D5
    LEA     ENEMY_POSITIONS, A3
    
ITERATE:
    CMP     D5, D4
    ADD.B   #1, D5
    BEQ     GAME_LOOP
    BNE     CHECK_ENEMIES
    
CHECK_ENEMIES:
    MOVE.L  (A3)+, D2
    MOVE.L  (A2),D3
    
    CMP.L   D2, D3
    BEQ     REDUCE_HEALTH
    BNE     ITERATE
    
REDUCE_HEALTH:
    LEA     MSG_COLLISION, A1
    BSR     DRAW
    
    SUB.B   #DAMAGE, PLAYER_HEALTH
    
    LEA     MSG_DAMAGE, A1
    BSR     DRAW
    
    BRA     GAME_LOOP
    
GAME_OVER:
    LEA     MSG_GAMEOVER, A1
    BSR     DRAW
    SIMHALT             ; halt simulator
COUNT_ENEMIES:
    MOVE.B  #0, D0
    LEA     ENEMY_POSITIONS, A0

COUNT_ENEMIES_LOOP:
    TST.L   (AB)+
    BEQ     END_COUNTING

    ADD.B   #1, D0
    BRA     COUNT_ENEMIES_LOOP
END_COUNTING:
    RTS     

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
