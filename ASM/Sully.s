extern _printf
extern _exit

global _main

bits 64
default rel

section .text

_self_db:
    push    rbp
    mov rbp, rsp

    lea r14,[rel self]  ; data

_self_loop:
    mov r13, r14        ; save before increment
_self_db_scan:
    mov al, byte [r14+1]
    test al, al
    jz _self_end_of_data
    mov al, byte [r14]
    cmp al, 10
    jz _self_end_of_line
    inc r14
    jmp _self_db_scan

_self_end_of_line:
    mov byte [r14], 0
    lea rsi, [rel fmt1]
    mov rdi, r13
    call _printf
    inc r14
    jmp _self_loop

_self_end_of_data:
    mov byte [r14], 0
    lea rsi, [rel fmt2]
    mov rdi, r13
    call _printf

    pop rbp
    ret

_main:
    push    rbp
    mov rbp, rsp

    lea rdi, [rel self]
    call _printf

    call _self_db

    mov rdi, 0
    call _exit

    pop rbp
    ret

section .data
fmt1 db 'db "%s",10',10,0
fmt2 db 'db "%s",10,0',10,0
self:
db "extern _printf",10
db "extern _exit",10
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
db "    mov rbp, rsp",10
db "",10
db "    lea r14,[rel self]  ; data",10
db "",10
db "_self_loop:",10
db "    mov r13, r14        ; save before increment",10
db "_self_db_scan:",10
db "    mov al, byte [r14+1]",10
db "    test al, al",10
db "    jz _self_end_of_data",10
db "    mov al, byte [r14]",10
db "    cmp al, 10",10
db "    jz _self_end_of_line",10
db "    inc r14",10
db "    jmp _self_db_scan",10
db "",10
db "_self_end_of_line:",10
db "    mov byte [r14], 0",10
db "    lea rsi, [rel fmt1]",10
db "    mov rdi, r13",10
db "    call _printf",10
db "    inc r14",10
db "    jmp _self_loop",10
db "",10
db "_self_end_of_data:",10
db "    mov byte [r14], 0",10
db "    lea rsi, [rel fmt2]",10
db "    mov rdi, r13",10
db "    call _printf",10
db "",10
db "    pop rbp",10
db "    ret",10
db "",10
db "_main:",10
db "    push    rbp",10
db "    mov rbp, rsp",10
db "",10
db "    lea rdi, [rel self]",10
db "    call _printf",10
db "",10
db "    call _self_db",10
db "",10
db "    mov rdi, 0",10
db "    call _exit",10
db "",10
db "    pop rbp",10
db "    ret",10
db "",10
db "section .data",10
db "fmt1 db 'db "%s",10',10,0",10
db "fmt2 db 'db "%s",10,0',10,0",10
db "self:",10,0
