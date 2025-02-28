*-----------------------------------------------------------
* Title      : Small World Game
* Written by : Emoshoke Saliu C00297032
* Date       : 23-02-2025
* Description: A text-based "Small World" game that generates missions
*              based on player input, manages resources (Energy & Food), and
*              introduces dynamic random events that affect gameplay. The game
*              features branching storylines (exploration vs. hunting missions)
*              and an endless survival mode where the game ends when either resource
*              reaches zero.
* Known Bugs: None (inputs doesnt work for sudden event)
*-------------------------------------------------------
* STARTING MEMORY ADDRESS FOR THE PROGRAM $1000
*-------------------------------------------------------
        ORG     $1000

*-------------------------------------------------------
* VALIDATION & GAME CONFIGURATION CONSTANTS
*-------------------------------------------------------
EXIT            EQU     0           ; Exit code for replay routine
MIN_MISSION     EQU     1           ; Minimum mission choice
MAX_MISSION     EQU     2           ; Maximum mission choice
EXP_COST        EQU     10          ; Exploration costs 10 Energy
EXP_GAIN        EQU     5           ; Exploration gains 5 Food
HUNT_COST       EQU     5           ; Hunting costs 5 Food
HUNT_GAIN       EQU     10          ; Hunting gains 10 Energy
RAND_THRESHOLD  EQU     50          ; Random event triggers if random value < 50
RAND_PENALTY    EQU     5           ; Random event subtracts 5 from both resources

*-------------------------------------------------------
* START OF GAME (Initialize global resources)
*-------------------------------------------------------
START:
    ; Initialize resources in memory locations $4000 and $4001
    MOVE.W  #100, ENERGY        ; Set initial Energy to 100
    MOVE.W  #100, FOOD          ; Set initial Food to 100
    MOVE.W  #1234, RandomSeed   ; Set initial random seed
    ; (For display purposes, we also store Energy at $4000)
    MOVE.B  #100, $4000         ; Optional: mirror Energy to memory $4000
    LEA     $4000, A3           ; A3 points to a location (if needed for HUD)
    BSR     WELCOME             ; Display welcome message
    BSR     GAME                ; Branch to main game routine

*-------------------------------------------------------
* MAIN CODE AREA (Place code from $3000 onward)
*-------------------------------------------------------
        ORG     $3000

GAME:
    BSR     GAMELOOP            ; Enter the main game loop
    RTS                       ; Return from GAME

END:
    SIMHALT                   ; Halt the simulation
    
  
*-------------------------------------------------------
* WELCOME SUBROUTINE
*-------------------------------------------------------
WELCOME:
    BSR     ENDL                ; Newline before welcome
    LEA     WELCOME_MSG, A1     ; Load address of welcome message
    MOVE.B  #14, D0             ; (Command code for output)
    TRAP    #15                 ; Output the welcome message
    BSR     ENDL                ; Newline after message
    BSR     CONTINUE            ; Prompt user to continue
    RTS

*-------------------------------------------------------
* INPUT SUBROUTINE (Mission Input)
* This routine displays a prompt and reads a single digit.
*-------------------------------------------------------
INPUT:
    BSR     ENDL
    LEA     MISSION_MSG, A1     ; Load mission prompt
    MOVE.B  #14, D0
    TRAP    #15                 ; Display message

    MOVE.B  #2, D0                  
    TRAP    #15           ; Read character into D0


    SUB.B   #'0', D0            ; Convert ASCII to numeric (e.g., '1' -> 1, '2' -> 2)
                            ; This works because ASCII for '0' is 48, and for '1' is 49, so '1' - '0' = 1.

    CMP.W   #MIN_MISSION, D0     ; Compare the input value (now numeric) with MIN_MISSION (which is 1)                     ; This checks if the input is less than 1, which would be invalid.
    BLT     INVALID_INPUT        ; If the input value is less than 1, branch to INVALID_INPUT.
    CMP.W   #MAX_MISSION, D0     ; Compare the input value with MAX_MISSION (which is 2)
                            ; This checks if the input value is greater than 2, which would also be invalid.
    BGT     INVALID_INPUT        ; If the input value is greater than 2, branch to INVALID_INPUT.
    RTS                         ; Return from the subroutine if the input is valid (between 1 and 2 inclusive).

INVALID_INPUT:
    LEA     INVALID_MSG, A1    ; Load the address of the "Invalid input" message into A1.
    MOVE.B  #14, D0           ; Set D0 to 14 (for TRAP #15 to output the message).
    TRAP    #15               ; Display the "Invalid input" message to the user.
    MOVE.W  #1, D0            ; Set D0 to 1 (error flag) to signal an invalid input.

    RTS
*-------------------------------------------------------
* GAME LOOP (Main gameplay loop)
*-------------------------------------------------------
GAMELOOP:
    BSR     INPUT               ; Get mission input
    CMP.W   #1, D1
    BEQ     EXPLORE_MISSION     ; If input is 1, explore
    CMP.W   #2, D1
    BEQ     HUNT_MISSION        ; If input is 2, hunt
    BRA     GAMELOOP            ; Otherwise, repeat (should not occur)
    
EXPLORE_MISSION:
    BSR     ENDL
    LEA     EXPLORE_MSG, A1
    MOVE.B  #14, D0
    TRAP    #15               ; Display exploration mission message
    ; Update resources: Exploration costs Energy, gains Food.
    MOVE.W  ENERGY, D0
    SUB.W   #EXP_COST, D0
    MOVE.W  D0, ENERGY
    MOVE.W  FOOD, D0
    ADD.W   #EXP_GAIN, D0
    MOVE.W  D0, FOOD
    BRA     POST_MISSION

HUNT_MISSION:
    BSR     ENDL
    LEA     HUNT_MSG, A1
    MOVE.B  #14, D0
    TRAP    #15               ; Display hunting mission message
    ; Update resources: Hunting costs Food, gains Energy.
    MOVE.W  FOOD, D0
    SUB.W   #HUNT_COST, D0
    MOVE.W  D0, FOOD
    MOVE.W  ENERGY, D0
    ADD.W   #HUNT_GAIN, D0
    MOVE.W  D0, ENERGY
    BRA     POST_MISSION

*-------------------------------------------------------
* POST-MISSION SUBROUTINE
* Process random events and check for game over.
*-------------------------------------------------------
POST_MISSION:
    BSR     RANDOM_EVENT      ; Possibly trigger a random event
    BSR     CHECK_GAME_OVER   ; Check if game should continue
    CMP.W   #0, D0            ; D0=0 means game continues
    BEQ     GAMELOOP
    BRA     REPLAY            ; Otherwise, ask to replay

*-------------------------------------------------------
* RANDOM EVENT SUBROUTINE
* Generate a random number; if less than RAND_THRESHOLD,
* subtract an additional penalty from both Energy and Food.
*-------------------------------------------------------
*-------------------------------------------------------
* RANDOM EVENT SUBROUTINE
* Generate a random number; if less than RAND_THRESHOLD,
* subtract an additional penalty from both Energy and Food.
*-------------------------------------------------------
RANDOM_EVENT:
    BSR     ENDL
    BSR     DECORATE
    JSR     GENERATE_RANDOM    ; Random number in D0
    CMP.W   #RAND_THRESHOLD, D0
    BGE     NO_EVENT
    LEA     RANDOM_EVENT_MSG, A1
    MOVE.B  #14, D0
    TRAP    #15               ; Display random event message
    ; Apply penalty to Energy and Food.
    MOVE.W  ENERGY, D0
    SUB.W   #RAND_PENALTY, D0
    MOVE.W  D0, ENERGY
    MOVE.W  FOOD, D0
    SUB.W   #RAND_PENALTY, D0
    MOVE.W  D0, FOOD

    ; Prompt player to continue or take action
    BSR     CONTINUE           ; Ask user to press any key to continue

NO_EVENT:
    RTS
*-------------------------------------------------------
* CHECK GAME OVER SUBROUTINE
* If Energy or Food is zero or negative, game over.
*-------------------------------------------------------
CHECK_GAME_OVER:
    MOVE.W  ENERGY, D0
    CMP.W   #0, D0
    BLE     GAME_OVER
    MOVE.W  FOOD, D0
    CMP.W   #0, D0
    BLE     GAME_OVER
    CLR.W   D0               ; Game continues: D0=0
    RTS
GAME_OVER:
    MOVE.W  #1, D0           ; Signal game over: D0 nonzero
    RTS
*-------------------------------------------------------
* GENERATE_RANDOM SUBROUTINE
* Simple linear congruential generator (LCG)
* NewSeed = (OldSeed * 25173 + 13849) mod 65536
* Returns lower 8 bits of the new seed in D0.
*-------------------------------------------------------
GENERATE_RANDOM:
    MOVE.W  RandomSeed, D0
    MULS    #25173, D0         ; Multiply seed by constant
    ADD.L   #13849, D1         ; Add constant (result in D1)
    MOVE.W  D1, RandomSeed     ; Update seed with lower 16 bits
    AND.W   #$00FF, D1         ; Isolate lower 8 bits
    MOVE.W  D1, D0            ; Return random value in D0
    RTS

*-------------------------------------------------------
* HUD SUBROUTINE (Display current resources)
*-------------------------------------------------------
HUD:
     BSR     ENDL            ;BRANCH TO ENDL SUBROUTINE
    BSR     DECORATE        ;BRANCH TO DECORATE SUBROUTINE
    LEA     HUD_MSG,A1      ;ASSIGN MESSAGE TO ADDRESS REGISTER A1
    MOVE.B  #14,D0          ;MOVE LITERAL 14 TO DO
    TRAP    #15             ;TRAP AND INTERPRET VALUE IN D0
    MOVE.B  (A3),D1         ;RETRIEVE THE VALUE A3 POINT TO AND MOVE TO D1
    MOVE.B  #3,D0           ;MOVE LITERAL 3 TO DO    
    TRAP    #15                     ; Display "RESOURCES: "
    ; Display Energy:
    LEA     ENERGY_MSG, A1
    MOVE.B  #14, D0
    TRAP    #15               ; Display "Energy: "
    MOVE.W  ENERGY, D0
    JSR     DISPLAY_NUMBER    ; Convert and display ENERGY (3 digits)
    BSR     ENDL
    ; Display Food:
    LEA     FOOD_MSG, A1
    MOVE.B  #14, D0
    TRAP    #15               ; Display "Food: "
    MOVE.W  FOOD, D0
    JSR     DISPLAY_NUMBER    ; Convert and display FOOD
    BSR     ENDL
    RTS

*-------------------------------------------------------
* REPLAY SUBROUTINE (Ask player to continue or quit)
*-------------------------------------------------------
REPLAY:
    BSR     ENDL
    LEA     REPLAY_MSG, A1
    MOVE.B  #14, D0
    TRAP    #15               ; Display replay prompt
    TRAP    #14               ; Read character into D0
    SUB.B   #'0', D0         ; Convert ASCII to numeric
    CMP.W   #EXIT, D0
    BEQ     END               ; If 0, exit game
    BRA     GAMELOOP          ; Otherwise, continue

*-------------------------------------------------------
* CONTINUE SUBROUTINE (Prompt to continue)
*-------------------------------------------------------
CONTINUE:
    BSR     ENDL
    LEA     CONTINUE_MSG, A1
    MOVE.B  #14, D0
    TRAP    #15         ; Display "Press any key to continue"

    MOVE.B  #2, D0      ; Set up TRAP #2 for input
    TRAP    #15         ; Wait for key press

    RTS                 ; Return once a key is pressed
*-------------------------------------------------------
* ENDL SUBROUTINE (Output a CR/LF)
*-------------------------------------------------------
ENDL:
    MOVEM.L D0/A1, -(A7)      ; Save D0 and A1
    MOVE.B  #14, D0
    LEA     CRLF, A1
    TRAP    #15
    MOVEM.L (A7)+, D0/A1      ; Restore D0 and A1
    RTS

*-------------------------------------------------------
* DISPLAY_NUMBER SUBROUTINE
* Converts a number in D0 (0-999) into three ASCII digits and outputs them.
* Assumes D0 contains a 16-bit number.
*-------------------------------------------------------
DISPLAY_NUMBER:
    ; Divide D0 by 100 to get hundreds digit.
    MOVE.W  D0, D1
    MOVE.W  #100, D2
    DIVU    D2, D1           ; D1 quotient = hundreds, remainder in D1.L
    ADD.B   #'0', D1         ; Convert hundreds to ASCII
    MOVE.B  D1, D3           ; Save hundreds in D3
    ; Output hundreds digit.
    MOVE.B  D3, D0
    TRAP    #15
    ; recalc: subtract (hundreds*100) from original.
    MOVE.W  ENERGY, D4       ; We use ENERGY as a scratch if needed.
    ; store original value in A register.
    ; output two more dummy characters:
    MOVE.B  #'0', D0
    TRAP    #15
    MOVE.B  #'0', D0
    TRAP    #15
    RTS

*-------------------------------------------------------
* DECORATE SUBROUTINE (Screen decoration)
*-------------------------------------------------------
DECORATE:
    MOVE.B  #60, D3
    BSR     ENDL
OUT:
    LEA     LOOP_MSG, A1
    MOVE.B  #14, D0
    TRAP    #15
    SUB     #1, D3
    BNE     OUT
    BSR     ENDL
    RTS
    
    MOVE.B  D0, D1         ; Copy the received character into D1
    ADD.B   #'0', D1       ; Optionally, convert it back to ASCII (for display)
    LEA     DEBUG_CHAR, A1 ; Message to show received character
    MOVE.B  #14, D0        ; Print the message
    TRAP    #15

*-------------------------------------------------------
* CLEAR SCREEN SUBROUTINE
*-------------------------------------------------------
CLEAR_SCREEN:
    MOVE.B  #11, D0
    MOVE.W  #$FF00, D1
    TRAP    #15
    RTS
    
    MOVE.B  D0, D1         ; Copy the received character into D1
    ADD.B   #'0', D1       ; Optionally, convert it back to ASCII (for display)
    LEA     DEBUG_CHAR, A1 ; Message to show received character
    MOVE.B  #14, D0        ; Print the message
    TRAP    #15

*-------------------------------------------------------
* DATA DECLARATIONS (Messages, constants, and resource variables)
*-------------------------------------------------------
CRLF:           DC.B    $0D, $0A, 0
WELCOME_MSG:    DC.B    '************************************************************'
                DC.B    $0D, $0A
                DC.B    'WELCOME TO THE SMALL WORLD!'
                DC.B    $0D, $0A
                DC.B    'CHOOSE YOUR MISSION:'
                DC.B    $0D, $0A
                DC.B    '1. EXPLORE (BRAVE THE UNKNOWN)'
                DC.B    $0D, $0A
                DC.B    '2. HUNT (FOR HUNTING PREY)'
                DC.B    $0D, $0A
                DC.B    '************************************************************' 
                DC.B    $0D, $0A, 0
                
MISSION_MSG:    DC.B    'Enter mission type (1-Explore, 2-Hunt): ',0
INVALID_MSG:    DC.B    'Invalid input. Try again.',$0D, $0A,0
EXPLORE_MSG:    DC.B    'You embark on an exploration mission.',$0D, $0A, 0
HUNT_MSG:       DC.B    'You go on a hunting mission.',$0D, $0A, 0
RANDOM_EVENT_MSG: DC.B  'A sudden event disrupts your journey!',$0D, $0A, 0
HUD_MSG:        DC.B    'RESOURCES: ',0
ENERGY_MSG:     DC.B    'Energy: ',0
FOOD_MSG:       DC.B    'Food: ',0
REPLAY_MSG:     DC.B    'Enter 0 to quit, any other key to continue: ',0
CONTINUE_MSG:   DC.B    'Press any key to continue: ',0
LOOP_MSG:       DC.B    '.',0
DEBUG_MSG_TEXT: DC.B    'Input received: ',0    ; Debug message prefix
DEBUG_CHAR:     DC.B    'Received character: ',0
MISSION_BUFFER: DS.B    10   ; Buffer for user input (max 10 characters)



; Resource variables
ENERGY:         DS.W    1       ; Player's Energy
FOOD:           DS.W    1       ; Player's Food
RandomSeed:     DS.W    1       ; Random number seed

        END     START         ; End of program, entry point is START




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
