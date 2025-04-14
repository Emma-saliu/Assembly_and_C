global register_adder

section .text
register_adder:
    mov     rax, rdi
    add     rax, rsi
    ret
