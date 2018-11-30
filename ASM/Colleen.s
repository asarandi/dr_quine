;
; comment outside program
;

extern _printf

global _main

bits 64
default rel

section .text

_self_db:
    push    rbp
    mov     rbp, rsp
    push    r13
    push    r14

    lea     r14, [rel self]

.loop:
    mov     r13, r14
.scan:
    mov     ax, word [r14]
    cmp     ax, 0x000a
    jz      .eof
    mov     al, byte [r14]
    cmp     al, 10
    jz      .eol
    inc     r14
    jmp     .scan

.eol:
    mov     byte [r14], 0
    mov     rsi, r13
    lea     rdi, [rel fmt1]
    call    _printf
    inc     r14
    jmp     .loop

.eof:
    mov     byte [r14], 0
    mov     rsi, r13
    lea     rdi, [rel fmt2]
    call    _printf

    pop     r14
    pop     r13
    pop     rbp
    ret

_main:

;
; comment inside main
;
    push    rbp
    mov     rbp, rsp

    lea     rdi, [rel self]
    call    _printf

    call    _self_db

    mov     rax, 0
    pop     rbp
    ret

section .data
    fmt1    db 100,98,32,34,37,115,34,44,49,48,10,0
    fmt2    db 100,98,32,34,37,115,34,44,49,48,44,48,10,0
self:
db ";",10
db "; comment outside program",10
db ";",10
db "",10
db "extern _printf",10
db "",10
db "global _main",10
db "",10
db "bits 64",10
db "default rel",10
db "",10
db "section .text",10
db "",10
db "_self_db:",10
db "    push    rbp",10
db "    mov     rbp, rsp",10
db "    push    r13",10
db "    push    r14",10
db "",10
db "    lea     r14, [rel self]",10
db "",10
db ".loop:",10
db "    mov     r13, r14",10
db ".scan:",10
db "    mov     ax, word [r14]",10
db "    cmp     ax, 0x000a",10
db "    jz      .eof",10
db "    mov     al, byte [r14]",10
db "    cmp     al, 10",10
db "    jz      .eol",10
db "    inc     r14",10
db "    jmp     .scan",10
db "",10
db ".eol:",10
db "    mov     byte [r14], 0",10
db "    mov     rsi, r13",10
db "    lea     rdi, [rel fmt1]",10
db "    call    _printf",10
db "    inc     r14",10
db "    jmp     .loop",10
db "",10
db ".eof:",10
db "    mov     byte [r14], 0",10
db "    mov     rsi, r13",10
db "    lea     rdi, [rel fmt2]",10
db "    call    _printf",10
db "",10
db "    pop     r14",10
db "    pop     r13",10
db "    pop     rbp",10
db "    ret",10
db "",10
db "_main:",10
db "",10
db ";",10
db "; comment inside main",10
db ";",10
db "    push    rbp",10
db "    mov     rbp, rsp",10
db "",10
db "    lea     rdi, [rel self]",10
db "    call    _printf",10
db "",10
db "    call    _self_db",10
db "",10
db "    mov     rax, 0",10
db "    pop     rbp",10
db "    ret",10
db "",10
db "section .data",10
db "    fmt1    db 100,98,32,34,37,115,34,44,49,48,10,0",10
db "    fmt2    db 100,98,32,34,37,115,34,44,49,48,44,48,10,0",10
db "self:",10,0
