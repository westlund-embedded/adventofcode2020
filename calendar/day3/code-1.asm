bits        64
section     .data
    input   db      "input.txt",0
    
section     .bss
    text    resb    12000           ; file text

section     .text
global      _start

_start:                             ; Entry point
    call    read                    ; read file

    

    mov     rax, text
    call    print

    call    exit                    ; Exit
    
read:                               ; read input file to RAM
    mov     rax, 2                  ; sys_open
    mov     rdi, input              ; filename
    mov     rsi, 0                  ; O_RDONLY
    mov     rdx, 0                  ; no file permission
    syscall

    push    rax                     ; put fd on stack
    mov     rdi, rax                ; use fd for read
    mov     rax, 0                  ; sys_read
    mov     rsi, text               ; read to RAM
    mov     rdx, 12000              ; read 10 bytes
    syscall

    mov     rax, 3                  ; sys_close
    pop     rdi                     ; pop fd
    syscall

    ret

print:                              ; msg in rax
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
