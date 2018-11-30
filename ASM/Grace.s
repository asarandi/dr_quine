;
; dr_quine [grace], 42 fremont, nov 2018
;

%define OPEN_MODE   644o
%define OPEN_FLAGS  0x601
%define FT          _main

global  FT

extern  _open
extern  _close
extern  _dprintf

bits    64
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
    mov     rdx, r13
    lea     rsi, [rel fmt1]
    mov     rdi, [rel fd]
    call    _dprintf
    inc     r14
    jmp     .loop

.eof:
    mov     byte [r14], 0
    mov     rdx, r13
    lea     rsi, [rel fmt2]
    mov     rdi, [rel fd]
    call    _dprintf

    pop     r14
    pop     r13
    pop     rbp
    ret

FT:
    push    rbp
    mov     rbp, rsp

    mov     rdx, OPEN_MODE
    mov     rsi, OPEN_FLAGS
    lea     rdi, [rel fn]
    call    _open
    cmp     eax, 0
    jle     .end
    mov     [rel fd], eax

    mov     rdi, rax
    lea     rsi, [rel self]
    call    _dprintf

    call    _self_db

    mov     rdi, [rel fd]
    call    _close

.end:
    mov     rax, 0
    pop     rbp
    ret

section .data
    fn      db 'Grace_kid.s',0
    fd      dd 0
    fmt1    db 100,98,32,34,37,115,34,44,49,48,10,0
    fmt2    db 100,98,32,34,37,115,34,44,49,48,44,48,10,0

self:
db ";",10
db "; dr_quine [grace], 42 fremont, nov 2018",10
db ";",10
db "",10
db "%%define OPEN_MODE   644o",10
db "%%define OPEN_FLAGS  0x601",10
db "%%define FT          _main",10
db "",10
db "global  FT",10
db "",10
db "extern  _open",10
db "extern  _close",10
db "extern  _dprintf",10
db "",10
db "bits    64",10
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
db "    mov     rdx, r13",10
db "    lea     rsi, [rel fmt1]",10
db "    mov     rdi, [rel fd]",10
db "    call    _dprintf",10
db "    inc     r14",10
db "    jmp     .loop",10
db "",10
db ".eof:",10
db "    mov     byte [r14], 0",10
db "    mov     rdx, r13",10
db "    lea     rsi, [rel fmt2]",10
db "    mov     rdi, [rel fd]",10
db "    call    _dprintf",10
db "",10
db "    pop     r14",10
db "    pop     r13",10
db "    pop     rbp",10
db "    ret",10
db "",10
db "FT:",10
db "    push    rbp",10
db "    mov     rbp, rsp",10
db "",10
db "    mov     rdx, OPEN_MODE",10
db "    mov     rsi, OPEN_FLAGS",10
db "    lea     rdi, [rel fn]",10
db "    call    _open",10
db "    cmp     eax, 0",10
db "    jle     .end",10
db "    mov     [rel fd], eax",10
db "",10
db "    mov     rdi, rax",10
db "    lea     rsi, [rel self]",10
db "    call    _dprintf",10
db "",10
db "    call    _self_db",10
db "",10
db "    mov     rdi, [rel fd]",10
db "    call    _close",10
db "",10
db ".end:",10
db "    mov     rax, 0",10
db "    pop     rbp",10
db "    ret",10
db "",10
db "section .data",10
db "    fn      db 'Grace_kid.s',0",10
db "    fd      dd 0",10
db "    fmt1    db 100,98,32,34,37,115,34,44,49,48,10,0",10
db "    fmt2    db 100,98,32,34,37,115,34,44,49,48,44,48,10,0",10
db "",10
db "self:",10,0
