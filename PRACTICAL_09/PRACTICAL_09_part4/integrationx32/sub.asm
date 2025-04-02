section .data

section .text
global sub

sub:
    mov eax, [esp+4]

    sub eax, [esp+8]

    ret