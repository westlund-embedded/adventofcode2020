section     .data
msg db      "Test",0xa


section     .text
global      _start

_start:                             ; Entry point
    mov     eax, msg                ; sys_write
    call    print
    call    exit


print: 
    mov     esi, eax
    mov     eax, 1
    mov     edi, 1
    call    strlen
    syscall
    ret

strlen:
    push    rbx
    mov     ebx, esi

next_char:
    cmp     byte[ebx], 0
    inc     ebx
    jnz     next_char
    dec     ebx
    sub     ebx, esi
    mov     edx, ebx
    pop     rbx
    ret


exit: 
    mov     eax, 60                 ; sys_exit
    xor     edi, edi                ; return 0
    syscall