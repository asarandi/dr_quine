extern _open
extern _close
extern _dprintf
extern _exit
extern _strrchr
extern _strchr
extern _sprintf
extern _system
extern _strncmp
extern _strncpy

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
    mov ax, word [r14]
    cmp ax, 0x000a
    jz _self_end_of_data
    mov al, byte [r14]
    cmp al, 10
    jz _self_end_of_line
    inc r14
    jmp _self_db_scan

_self_end_of_line:
    mov byte [r14], 0
    mov rdx, r13
    cmp dword [rdx], 0x30786469
    jnz _self_eol_continue
    lea rdx, [rel + idx_str]    ;awesome sauce
_self_eol_continue:
    lea rsi, [rel fmt1]
    mov rdi, [rel fd]
    call _dprintf
    inc r14
    jmp _self_loop

_self_end_of_data:
    mov byte [r14], 0
    mov rdx, r13
    lea rsi, [rel fmt2]
    mov rdi, [rel fd]
    call _dprintf

    pop rbp
    ret

;----------------------------------------------------------
_is_original_sully:
    push rbp
    mov rbp, rsp
    mov r13, rax
    mov rdi, rax
    mov rsi, '/'
    call _strrchr
    test rax, rax
    jz _is_original_slash
    inc rax
    mov r13, rax
_is_original_slash:
    mov rdi, r13
    mov rsi, '_'
    call _strchr
    test rax, rax
    jz _is_original_true
    xor rax, rax
    jmp _is_original_return
_is_original_true:
    mov rax, 1
_is_original_return:
    pop rbp
    ret

;----------------------------------------------------------
_prepare_strings:
    push rbp
    mov rbp, rsp

    mov edx, [rel idx0]
    movsx rdx, edx
    lea rsi, [rel idx_fmt]
    lea rdi, [rel idx_str]
    call _sprintf

    mov r13, rax
    mov r14, 0xc00

_find_self_ref:
    inc r14
    mov rdx, 13
    lea rsi, [rel self]
    add rsi, r14
    lea rdi, [rel idx_str]
    call _strncmp
    cmp rax, 0
    jnz _find_self_ref

    mov rdx, r13
    lea rsi, [rel idx_str]
    lea rdi, [rel self]
    add rdi, r14
    call _strncpy

    mov edx, [rel idx0]
    movsx rdx, edx
    lea rsi, [rel src_fmt]
    lea rdi, [rel src_file]
    call _sprintf

    mov edx, [rel idx0]
    movsx rdx, edx
    lea rsi, [rel obj_fmt]
    lea rdi, [rel obj_file]
    call _sprintf

    mov edx, [rel idx0]
    movsx rdx, edx
    lea rsi, [rel bin_fmt]
    lea rdi, [rel bin_file]
    call _sprintf

    lea r8,  [rel obj_file]
    lea rcx, [rel bin_file]
    lea rdx, [rel src_file]
    lea rsi, [rel compile_fmt]
    lea rdi, [rel compile_cmd]
    call _sprintf

    lea rdx, [rel bin_file]
    lea rsi, [rel run_fmt]
    lea rdi, [rel run_cmd]
    call _sprintf

    pop rbp
    ret

;----------------------------------------------------------
_main:
    push    rbp
    mov rbp, rsp

    mov rax, qword [rsi]        ;argv[0]
    call _is_original_sully
    test rax, rax
    jnz _sully_no_decrement

    mov eax, [rel idx0]
    dec eax
    mov [rel idx0], eax

_sully_no_decrement:
    call _prepare_strings

    mov rdx, open_mode
    mov rsi, open_flags
    lea rdi, [rel src_file]
    call _open
    cmp eax, 0
    jle _end
    mov [rel fd], eax

    mov rdi, rax
    lea rsi, [rel self]
    call _dprintf

    call _self_db

    mov rdi, [rel fd]
    call _close

    lea rdi, [rel compile_cmd]
    call _system

    mov eax, [rel idx0]
    cmp eax, 0
    jle _end

    lea rdi, [rel run_cmd]
    call _system

_end:
    mov rdi, 0
    call _exit

    pop rbp
    ret

section .data
idx0    dd    5                
padding0    times 64 db 0
idx_fmt     db 'idx0    dd    ',37,'d                ',0
idx_str     times 128 db 0
src_fmt     db 'Sully_',37,'d.s',0
src_file    times 128 db 0
obj_fmt     db 'Sully_',37,'d.o',0
obj_file    times 128 db 0
bin_fmt     db 'Sully_',37,'d',0
bin_file    times 128 db 0
compile_fmt db 'nasm -f macho64 ',37,'s && cc -Wall -Werror -Wextra -o ',37,'s ',37,'s',0
compile_cmd times 256 db 0
run_fmt     db './',37,'s',0
run_cmd     times 128 db 0
original    dq 0
fd          dd 0
open_mode   equ 644o
open_flags  equ 0x601
fmt1        db 100,98,32,34,37,115,34,44,49,48,10,0
fmt2        db 100,98,32,34,37,115,34,44,49,48,44,48,10,0
self:
db "extern _open",10
db "extern _close",10
db "extern _dprintf",10
db "extern _exit",10
db "extern _strrchr",10
db "extern _strchr",10
db "extern _sprintf",10
db "extern _system",10
db "extern _strncmp",10
db "extern _strncpy",10
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
db "    mov ax, word [r14]",10
db "    cmp ax, 0x000a",10
db "    jz _self_end_of_data",10
db "    mov al, byte [r14]",10
db "    cmp al, 10",10
db "    jz _self_end_of_line",10
db "    inc r14",10
db "    jmp _self_db_scan",10
db "",10
db "_self_end_of_line:",10
db "    mov byte [r14], 0",10
db "    mov rdx, r13",10
db "    cmp dword [rdx], 0x30786469",10
db "    jnz _self_eol_continue",10
db "    lea rdx, [rel + idx_str]    ;awesome sauce",10
db "_self_eol_continue:",10
db "    lea rsi, [rel fmt1]",10
db "    mov rdi, [rel fd]",10
db "    call _dprintf",10
db "    inc r14",10
db "    jmp _self_loop",10
db "",10
db "_self_end_of_data:",10
db "    mov byte [r14], 0",10
db "    mov rdx, r13",10
db "    lea rsi, [rel fmt2]",10
db "    mov rdi, [rel fd]",10
db "    call _dprintf",10
db "",10
db "    pop rbp",10
db "    ret",10
db "",10
db ";----------------------------------------------------------",10
db "_is_original_sully:",10
db "    push rbp",10
db "    mov rbp, rsp",10
db "    mov r13, rax",10
db "    mov rdi, rax",10
db "    mov rsi, '/'",10
db "    call _strrchr",10
db "    test rax, rax",10
db "    jz _is_original_slash",10
db "    inc rax",10
db "    mov r13, rax",10
db "_is_original_slash:",10
db "    mov rdi, r13",10
db "    mov rsi, '_'",10
db "    call _strchr",10
db "    test rax, rax",10
db "    jz _is_original_true",10
db "    xor rax, rax",10
db "    jmp _is_original_return",10
db "_is_original_true:",10
db "    mov rax, 1",10
db "_is_original_return:",10
db "    pop rbp",10
db "    ret",10
db "",10
db ";----------------------------------------------------------",10
db "_prepare_strings:",10
db "    push rbp",10
db "    mov rbp, rsp",10
db "",10
db "    mov edx, [rel idx0]",10
db "    movsx rdx, edx",10
db "    lea rsi, [rel idx_fmt]",10
db "    lea rdi, [rel idx_str]",10
db "    call _sprintf",10
db "",10
db "    mov r13, rax",10
db "    mov r14, 0xc00",10
db "",10
db "_find_self_ref:",10
db "    inc r14",10
db "    mov rdx, 13",10
db "    lea rsi, [rel self]",10
db "    add rsi, r14",10
db "    lea rdi, [rel idx_str]",10
db "    call _strncmp",10
db "    cmp rax, 0",10
db "    jnz _find_self_ref",10
db "",10
db "    mov rdx, r13",10
db "    lea rsi, [rel idx_str]",10
db "    lea rdi, [rel self]",10
db "    add rdi, r14",10
db "    call _strncpy",10
db "",10
db "    mov edx, [rel idx0]",10
db "    movsx rdx, edx",10
db "    lea rsi, [rel src_fmt]",10
db "    lea rdi, [rel src_file]",10
db "    call _sprintf",10
db "",10
db "    mov edx, [rel idx0]",10
db "    movsx rdx, edx",10
db "    lea rsi, [rel obj_fmt]",10
db "    lea rdi, [rel obj_file]",10
db "    call _sprintf",10
db "",10
db "    mov edx, [rel idx0]",10
db "    movsx rdx, edx",10
db "    lea rsi, [rel bin_fmt]",10
db "    lea rdi, [rel bin_file]",10
db "    call _sprintf",10
db "",10
db "    lea r8,  [rel obj_file]",10
db "    lea rcx, [rel bin_file]",10
db "    lea rdx, [rel src_file]",10
db "    lea rsi, [rel compile_fmt]",10
db "    lea rdi, [rel compile_cmd]",10
db "    call _sprintf",10
db "",10
db "    lea rdx, [rel bin_file]",10
db "    lea rsi, [rel run_fmt]",10
db "    lea rdi, [rel run_cmd]",10
db "    call _sprintf",10
db "",10
db "    pop rbp",10
db "    ret",10
db "",10
db ";----------------------------------------------------------",10
db "_main:",10
db "    push    rbp",10
db "    mov rbp, rsp",10
db "",10
db "    mov rax, qword [rsi]        ;argv[0]",10
db "    call _is_original_sully",10
db "    test rax, rax",10
db "    jnz _sully_no_decrement",10
db "",10
db "    mov eax, [rel idx0]",10
db "    dec eax",10
db "    mov [rel idx0], eax",10
db "",10
db "_sully_no_decrement:",10
db "    call _prepare_strings",10
db "",10
db "    mov rdx, open_mode",10
db "    mov rsi, open_flags",10
db "    lea rdi, [rel src_file]",10
db "    call _open",10
db "    cmp eax, 0",10
db "    jle _end",10
db "    mov [rel fd], eax",10
db "",10
db "    mov rdi, rax",10
db "    lea rsi, [rel self]",10
db "    call _dprintf",10
db "",10
db "    call _self_db",10
db "",10
db "    mov rdi, [rel fd]",10
db "    call _close",10
db "",10
db "    lea rdi, [rel compile_cmd]",10
db "    call _system",10
db "",10
db "    mov eax, [rel idx0]",10
db "    cmp eax, 0",10
db "    jle _end",10
db "",10
db "    lea rdi, [rel run_cmd]",10
db "    call _system",10
db "",10
db "_end:",10
db "    mov rdi, 0",10
db "    call _exit",10
db "",10
db "    pop rbp",10
db "    ret",10
db "",10
db "section .data",10
db "idx0    dd    5                ",10
db "padding0    times 64 db 0",10
db "idx_fmt     db 'idx0    dd    ',37,'d                ',0",10
db "idx_str     times 128 db 0",10
db "src_fmt     db 'Sully_',37,'d.s',0",10
db "src_file    times 128 db 0",10
db "obj_fmt     db 'Sully_',37,'d.o',0",10
db "obj_file    times 128 db 0",10
db "bin_fmt     db 'Sully_',37,'d',0",10
db "bin_file    times 128 db 0",10
db "compile_fmt db 'nasm -f macho64 ',37,'s && cc -Wall -Werror -Wextra -o ',37,'s ',37,'s',0",10
db "compile_cmd times 256 db 0",10
db "run_fmt     db './',37,'s',0",10
db "run_cmd     times 128 db 0",10
db "original    dq 0",10
db "fd          dd 0",10
db "open_mode   equ 644o",10
db "open_flags  equ 0x601",10
db "fmt1        db 100,98,32,34,37,115,34,44,49,48,10,0",10
db "fmt2        db 100,98,32,34,37,115,34,44,49,48,44,48,10,0",10
db "self:",10,0
