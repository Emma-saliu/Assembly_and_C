; Program: x86_64 Version - Parameter Passing and Sum Loop
; Based on 68000 Assembly Code by Phillip Bourke (March 25, 2025)
; Translated by: Emoshoke Saliu
; Description: Demonstrates parameter passing, integer input/output,
;              arithmetic, and loop control with running sum.

section .data
    prompt1_msg     db 'Enter number 1: ', 0
    prompt2_msg     db 'Enter number 2: ', 0
    final_result    db 'Final sum is: ', 0
    newline         db 10, 0

section .bss
    num1    resb 10
    sum     resq 1
    count   resb 1

section .text
    global _start

_start:
    ; Initialize running sum and loop counter
    mov     qword [sum], 0
    mov     byte [count], 3

game_loop:
    ; Prompt and read first number
    mov     rsi, prompt1_msg
    call    print_prompt
    call    read_number
    mov     rbx, rax  ; store first input

    ; Prompt and read second number
    mov     rsi, prompt2_msg
    call    print_prompt
    call    read_number
    mov     rcx, rax  ; store second input

    ; Add numbers using subroutine
    mov     rdi, rbx
    mov     rsi, rcx
    call    register_adder

    ; Add result to running sum
    add     [sum], rax

    ; Print newline
    call    print_newline

    ; Decrement loop counter
    dec     byte [count]
    cmp     byte [count], 0
    jne     game_loop

    ; Display final result message
    mov     rsi, final_result
    call    print_prompt

    ; Display final sum
    mov     rax, [sum]
    call    print_number
    call    print_newline

    ; Exit program
    mov     rax, 60
    xor     rdi, rdi
    syscall

; -------------------------------------
; Subroutine: register_adder
; Description: Adds two numbers passed via rdi and rsi
; Returns: sum in rax
; -------------------------------------
register_adder:
    mov     rax, rdi
    add     rax, rsi
    ret

; -------------------------------------
; Subroutine: print_prompt
; Description: Writes string in RSI up to null-terminator (no newline)
; -------------------------------------
print_prompt:
    push    rsi
    xor     rcx, rcx
.find_len:
    cmp     byte [rsi + rcx], 0
    je      .got_len
    inc     rcx
    jmp     .find_len
.got_len:
    mov     rax, 1          ; syscall: write
    mov     rdi, 1          ; stdout
    pop     rsi             ; restore RSI
    mov     rdx, rcx        ; length
    syscall
    ret

; -------------------------------------
; Subroutine: print_newline
; -------------------------------------
print_newline:
    mov     rsi, newline
    call    print_prompt
    ret

; -------------------------------------
; Subroutine: read_number
; Description: Reads a number from stdin, converts to int, returns in rax
; -------------------------------------
read_number:
    mov     rax, 0          ; syscall: read
    mov     rdi, 0          ; stdin
    mov     rsi, num1       ; buffer
    mov     rdx, 10         ; bytes to read
    syscall

    xor     rax, rax        ; result
    xor     rcx, rcx        ; index

.convert:
    movzx   rdx, byte [num1 + rcx]
    cmp     dl, 10          ; newline
    je      .done
    sub     dl, '0'
    imul    rax, rax, 10
    add     rax, rdx
    inc     rcx
    jmp     .convert
.done:
    ret

; -------------------------------------
; Subroutine: print_number
; Description: Converts number in rax to ASCII and prints it
; -------------------------------------
print_number:
    mov     rcx, 10             ; divisor
    mov     rbx, rsp            ; store original stack pointer
    sub     rsp, 32             ; reserve space for digits

    lea     rdi, [rsp + 31]     ; pointer to last byte
    mov     byte [rdi], 10      ; newline
    dec     rdi

.print_loop:
    xor     rdx, rdx
    div     rcx                 ; divide rax by 10
    add     dl, '0'
    mov     [rdi], dl
    dec     rdi
    test    rax, rax
    jnz     .print_loop

    inc     rdi                 ; point to first digit
    mov     rax, 1              ; syscall write
    mov     rsi, rdi            ; pointer to digits
    mov     rdi, 1              ; stdout
    mov     rdx, rsp
    lea     rdx, [rsp + 32]
    sub     rdx, rsi            ; length = end - start
    syscall

    mov     rsp, rbx            ; restore stack
    ret
