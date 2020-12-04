section     .data
msg db      "Testing testing",0xa,0


section     .text
global      _start

_start:                             ; Entry point
    push    rax
    mov     rax, msg                ; put msg as argument to print
    call    print                   ; call sub routine
    pop     rax
    call    exit                    ; Exit
    
print: 
    call    strlen                  ; get strlen -> edx
    mov     rsi, rax                ; put msg in source reg
    mov     rax, 1                  ; sys_write
    mov     rdi, 1                  ; stdout
    syscall
    ret

strlen:
    push    rcx
    mov     rdi, rax                ; put str in dest reg
    xor     al, al                  ; clread compare reg
    xor     rcx, rcx                ; clear ecx
    not     rcx                     ; -1 = search all
    cld                             ; clear direction flag
    repne   scasb                   ; search string until '\0'
    sub     rdi, rax                ; calc length
    mov     rdx, rdi                ; store result in edx    
    pop     rcx
    ret

exit: 
    mov     rax, 60                 ; sys_exit
    xor     rdi, rdi                ; return 0
    syscall
