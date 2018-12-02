; dr_quine [grace], 42 fremont, nov 2018
%define FMT db 'db ',34,37,'s',34,',10'
%define GRC _main
%macro FT 0
GRC:push    r13
    push    r14
    push    r15
    mov     rdx, 644o
    mov     rsi, 0x601
    call    opn
    db      'Grace_kid.s',0
opn:pop     rdi
    call    _open
    cmp     eax, 0
    jle     end
    mov     r15, rax
    mov     rdi, rax
    lea     rsi, [rel self]
    call    _dprintf
    lea     r14, [rel self]
lup:mov     r13, r14
sca:mov     al, byte [r14]
    inc     r14
    cmp     al, 10
    jnz     sca
    mov     byte [r14 - 1], 0
    mov     rdx, r13
    call    fmt
    FMT,10,0
fmt:pop     rsi
    mov     rdi, r15
    call    _dprintf
    mov     al, byte [r14]
    test    al, al
    jnz     lup
    mov     rdi, r15
    call    _close
end:pop     r15
    pop     r14
    pop     r13
    mov     rax, 0
    ret
%endmacro
bits    64
default rel
extern  _open
extern  _close
extern  _dprintf
global  GRC
section .text
    FT
section .data
    self:
db "; dr_quine [grace], 42 fremont, nov 2018",10
db "%%define FMT db 'db ',34,37,'s',34,',10'",10
db "%%define GRC _main",10
db "%%macro FT 0",10
db "GRC:push    r13",10
db "    push    r14",10
db "    push    r15",10
db "    mov     rdx, 644o",10
db "    mov     rsi, 0x601",10
db "    call    opn",10
db "    db      'Grace_kid.s',0",10
db "opn:pop     rdi",10
db "    call    _open",10
db "    cmp     eax, 0",10
db "    jle     end",10
db "    mov     r15, rax",10
db "    mov     rdi, rax",10
db "    lea     rsi, [rel self]",10
db "    call    _dprintf",10
db "    lea     r14, [rel self]",10
db "lup:mov     r13, r14",10
db "sca:mov     al, byte [r14]",10
db "    inc     r14",10
db "    cmp     al, 10",10
db "    jnz     sca",10
db "    mov     byte [r14 - 1], 0",10
db "    mov     rdx, r13",10
db "    call    fmt",10
db "    FMT,10,0",10
db "fmt:pop     rsi",10
db "    mov     rdi, r15",10
db "    call    _dprintf",10
db "    mov     al, byte [r14]",10
db "    test    al, al",10
db "    jnz     lup",10
db "    mov     rdi, r15",10
db "    call    _close",10
db "end:pop     r15",10
db "    pop     r14",10
db "    pop     r13",10
db "    mov     rax, 0",10
db "    ret",10
db "%%endmacro",10
db "bits    64",10
db "default rel",10
db "extern  _open",10
db "extern  _close",10
db "extern  _dprintf",10
db "global  GRC",10
db "section .text",10
db "    FT",10
db "section .data",10
db "    self:",10
