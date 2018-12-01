;
; dr_quine [sully], 42 fremont, nov 2018
;
; main logic:
;
; check source file name, __FILE__
; if fn does not have underscores,
;   that means we are original sully, do not decrement the index,
;   because as per pdf, sully must produce twelve files 5,4,3,2,1,0 src and binaries
;
; if fn does have underscores, decrement index by one
;   if index is equal to zero or less, do nothing; quit, as per pdf and scale
;   next steps are to create a new string with index and new value,
;   create matching file names, write source to file, build and run binary
;
; again, as per correction sheet, if starting index is 5,
;  all together sully should create 12 files
;  they did not account for .o files in the scale,
;  so im including a rm command as well
;

extern _open                        ; open, close, write to files
extern _close
extern _dprintf
extern _strchr                      ; search for underscore in fn
extern _sprintf                     ; print to buffer
extern _system                      ; execute shell command
extern _strstr                      ; to find old index string in data section
extern _asprintf                    ; to concat strings, allocates mem
extern _free                        ; free allocated mem

global _main

bits 64
default rel

section .text

_self_db:
    push    rbp
    mov     rbp, rsp
    push    r13
    push    r14

    mov     r14, [rel new_self]
.loop:
    mov     r13, r14
.scan:
    mov     ax, word [r14]
    cmp     ax, 0x000a              ; is end of data?
    jz      .eof
    mov     al, byte [r14]
    cmp     al, 10                  ; is newline?
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
    mov     byte [r14], 0           ; print line prefixed with: db q
    mov     rdx, r13                ; and suffixed with: q, 10
    lea     rsi, [rel fmt2]
    mov     rdi, [rel fd]
    call    _dprintf

    pop     r14
    pop     r13
    pop     rbp
    ret

;----------------------------------------------------------
_prepare_strings:
    push    rbp
    mov     rbp, rsp

    mov     edx, [rel idx0]
    movsx   rdx, edx
    lea     rsi, [rel idx_fmt]      ; print new idx0 string to buffer
    lea     rdi, [rel idx_str]
    call    _sprintf

    lea     rsi, [rel idx_search]   ;  .. and that is why it has to be first in data section
    lea     rdi, [rel self]         ;
    call    _strstr                 ; find existing idx0 string
    mov     byte [rax], 0           ; place a 0 to cut the string
    lea     rdi, [rax + 1]          ; - we only want everything before
    mov     rsi, 10
    call    _strchr                 ; find the newline after idx0 string,
                                    ; - we want everything after

    mov     r8, rax                 ; tail
    lea     rcx, [rel idx_str]      ; body
    lea     rdx, [rel self]         ; head
    lea     rsi, [rel triples]      ; s s s format
    lea     rdi, [rel new_self]     ; pointer to result
    call    _asprintf

    mov     edx, [rel idx0]
    movsx   rdx, edx
    lea     rsi, [rel src_fmt]      ; source file name
    lea     rdi, [rel src_file]
    call    _sprintf

    xor     rax, rax                ;nasm -f macho64 Sully_X.s && cc -o Sully_X Sully_X.o && rm Sully*.o && ./Sully_X
    mov     eax, [rel idx0]
    mov     r9, rax                 ;arg4
    mov     r8, rax                 ;arg3
    mov     rcx, rax                ;arg2
    mov     rdx, rax                ;arg1
    lea     rsi, [rel exec_fmt]
    lea     rdi, [rel exec_cmd]
    call    _sprintf                ;this will be the execution string

    mov     rax, [rel new_self]
    pop     rbp
    ret

;----------------------------------------------------------
_main:
    push    rbp
    mov     rbp, rsp

    xor     rax, rax                ; set new_rel to zero
    mov     [rel new_self], rax     ; in case something fails we have to go to .end

    mov     eax, [rel idx0]         ; as per correction scale
    cmp     eax, 0                  ; program should not do anything when index is at 0
    jle     .end                    ; i wish the project pdf mentioned it

    mov     rsi, '_'                ; my way of detecting if current program is original Sully
    lea     rdi, [rel self_fn]      ; __file__ should be the name of .s file used for compilation
    call    _strchr                 ; if file has no underscore, then its original Sully.s
    test    eax, eax                ; dont decrement index if original
    jz      .no_decrement           ; yeah .. and use of argv[0] is forbidden

    mov     eax, [rel idx0]         ; decrement index
    dec     eax
    mov     [rel idx0], eax

.no_decrement:
    call    _prepare_strings        ; the printfs and such
    test    rax, rax
    jz      .end

    mov     rdx, open_mode
    mov     rsi, open_flags
    lea     rdi, [rel src_file]
    call    _open                   ; open destination file
    cmp     eax, 0
    jle     .end
    mov     [rel fd], eax           ; save file descriptor

    mov     rdi, rax
    mov     rsi, [rel new_self]
    call    _dprintf                ; put text copy #1 into file

    call    _self_db                ; put text copy #2, prefixed with db and quotes into file

    mov     rdi, [rel fd]           ; close fd
    call    _close

    lea     rdi, [rel exec_cmd]     ; run nasm, cc, remove obj and run executable
    call    _system                 ; its silly to remove the .o, but ..
                                    ; correction sheet explicitly says there must be 13 files :(
.end:
    mov     rdi, [rel new_self]     ; free memory, if any
    test    rdi, rdi
    jz      .no_free

    call    _free

.no_free:
    mov     rax, 0                  ; exit code zero
    pop     rbp
    ret

section .data
    idx0        dd   5
    fd          dd 0
    new_self    dq 0

    idx_fmt     db '    idx0        dd   ',37,'d',0
    idx_search  db '    idx0        dd   ',0
    self_fn     db __FILE__,0
    src_fmt     db 'Sully_',37,'d.s',0
    triples     db 37,'s',37,'s',37,'s',0
    fmt1        db 100,98,32,34,37,115,34,44,49,48,10,0
    fmt2        db 100,98,32,34,37,115,34,44,49,48,44,48,10,0
    exec_fmt    db 'nasm -f macho64 Sully_',37,'d.s && cc -o Sully_',37,'d Sully_',37,'d.o && rm -f Sully*.o && ./Sully_',37,'d',0
    idx_str     times 64 db 0
    src_file    times 64 db 0
    exec_cmd    times 256 db 0
    open_mode   equ 644o
    open_flags  equ 0x601
self:
db ";",10
db "; dr_quine [sully], 42 fremont, nov 2018",10
db ";",10
db "; main logic:",10
db ";",10
db "; check source file name, __FILE__",10
db "; if fn does not have underscores,",10
db ";   that means we are original sully, do not decrement the index,",10
db ";   because as per pdf, sully must produce twelve files 5,4,3,2,1,0 src and binaries",10
db ";",10
db "; if fn does have underscores, decrement index by one",10
db ";   if index is equal to zero or less, do nothing; quit, as per pdf and scale",10
db ";   next steps are to create a new string with index and new value,",10
db ";   create matching file names, write source to file, build and run binary",10
db ";",10
db "; again, as per correction sheet, if starting index is 5,",10
db ";  all together sully should create 12 files",10
db ";  they did not account for .o files in the scale,",10
db ";  so im including a rm command as well",10
db ";",10
db "",10
db "extern _open                        ; open, close, write to files",10
db "extern _close",10
db "extern _dprintf",10
db "extern _strchr                      ; search for underscore in fn",10
db "extern _sprintf                     ; print to buffer",10
db "extern _system                      ; execute shell command",10
db "extern _strstr                      ; to find old index string in data section",10
db "extern _asprintf                    ; to concat strings, allocates mem",10
db "extern _free                        ; free allocated mem",10
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
db "    mov     r14, [rel new_self]",10
db ".loop:",10
db "    mov     r13, r14",10
db ".scan:",10
db "    mov     ax, word [r14]",10
db "    cmp     ax, 0x000a              ; is end of data?",10
db "    jz      .eof",10
db "    mov     al, byte [r14]",10
db "    cmp     al, 10                  ; is newline?",10
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
db "    mov     byte [r14], 0           ; print line prefixed with: db q",10
db "    mov     rdx, r13                ; and suffixed with: q, 10",10
db "    lea     rsi, [rel fmt2]",10
db "    mov     rdi, [rel fd]",10
db "    call    _dprintf",10
db "",10
db "    pop     r14",10
db "    pop     r13",10
db "    pop     rbp",10
db "    ret",10
db "",10
db ";----------------------------------------------------------",10
db "_prepare_strings:",10
db "    push    rbp",10
db "    mov     rbp, rsp",10
db "",10
db "    mov     edx, [rel idx0]",10
db "    movsx   rdx, edx",10
db "    lea     rsi, [rel idx_fmt]      ; print new idx0 string to buffer",10
db "    lea     rdi, [rel idx_str]",10
db "    call    _sprintf",10
db "",10
db "    lea     rsi, [rel idx_search]   ;  .. and that is why it has to be first in data section",10
db "    lea     rdi, [rel self]         ;",10
db "    call    _strstr                 ; find existing idx0 string",10
db "    mov     byte [rax], 0           ; place a 0 to cut the string",10
db "    lea     rdi, [rax + 1]          ; - we only want everything before",10
db "    mov     rsi, 10",10
db "    call    _strchr                 ; find the newline after idx0 string,",10
db "                                    ; - we want everything after",10
db "",10
db "    mov     r8, rax                 ; tail",10
db "    lea     rcx, [rel idx_str]      ; body",10
db "    lea     rdx, [rel self]         ; head",10
db "    lea     rsi, [rel triples]      ; s s s format",10
db "    lea     rdi, [rel new_self]     ; pointer to result",10
db "    call    _asprintf",10
db "",10
db "    mov     edx, [rel idx0]",10
db "    movsx   rdx, edx",10
db "    lea     rsi, [rel src_fmt]      ; source file name",10
db "    lea     rdi, [rel src_file]",10
db "    call    _sprintf",10
db "",10
db "    xor     rax, rax                ;nasm -f macho64 Sully_X.s && cc -o Sully_X Sully_X.o && rm Sully*.o && ./Sully_X",10
db "    mov     eax, [rel idx0]",10
db "    mov     r9, rax                 ;arg4",10
db "    mov     r8, rax                 ;arg3",10
db "    mov     rcx, rax                ;arg2",10
db "    mov     rdx, rax                ;arg1",10
db "    lea     rsi, [rel exec_fmt]",10
db "    lea     rdi, [rel exec_cmd]",10
db "    call    _sprintf                ;this will be the execution string",10
db "",10
db "    mov     rax, [rel new_self]",10
db "    pop     rbp",10
db "    ret",10
db "",10
db ";----------------------------------------------------------",10
db "_main:",10
db "    push    rbp",10
db "    mov     rbp, rsp",10
db "",10
db "    xor     rax, rax                ; set new_rel to zero",10
db "    mov     [rel new_self], rax     ; in case something fails we have to go to .end",10
db "",10
db "    mov     eax, [rel idx0]         ; as per correction scale",10
db "    cmp     eax, 0                  ; program should not do anything when index is at 0",10
db "    jle     .end                    ; i wish the project pdf mentioned it",10
db "",10
db "    mov     rsi, '_'                ; my way of detecting if current program is original Sully",10
db "    lea     rdi, [rel self_fn]      ; __file__ should be the name of .s file used for compilation",10
db "    call    _strchr                 ; if file has no underscore, then its original Sully.s",10
db "    test    eax, eax                ; dont decrement index if original",10
db "    jz      .no_decrement           ; yeah .. and use of argv[0] is forbidden",10
db "",10
db "    mov     eax, [rel idx0]         ; decrement index",10
db "    dec     eax",10
db "    mov     [rel idx0], eax",10
db "",10
db ".no_decrement:",10
db "    call    _prepare_strings        ; the printfs and such",10
db "    test    rax, rax",10
db "    jz      .end",10
db "",10
db "    mov     rdx, open_mode",10
db "    mov     rsi, open_flags",10
db "    lea     rdi, [rel src_file]",10
db "    call    _open                   ; open destination file",10
db "    cmp     eax, 0",10
db "    jle     .end",10
db "    mov     [rel fd], eax           ; save file descriptor",10
db "",10
db "    mov     rdi, rax",10
db "    mov     rsi, [rel new_self]",10
db "    call    _dprintf                ; put text copy #1 into file",10
db "",10
db "    call    _self_db                ; put text copy #2, prefixed with db and quotes into file",10
db "",10
db "    mov     rdi, [rel fd]           ; close fd",10
db "    call    _close",10
db "",10
db "    lea     rdi, [rel exec_cmd]     ; run nasm, cc, remove obj and run executable",10
db "    call    _system                 ; its silly to remove the .o, but ..",10
db "                                    ; correction sheet explicitly says there must be 13 files :(",10
db ".end:",10
db "    mov     rdi, [rel new_self]     ; free memory, if any",10
db "    test    rdi, rdi",10
db "    jz      .no_free",10
db "",10
db "    call    _free",10
db "",10
db ".no_free:",10
db "    mov     rax, 0                  ; exit code zero",10
db "    pop     rbp",10
db "    ret",10
db "",10
db "section .data",10
db "    idx0        dd   5",10
db "    fd          dd 0",10
db "    new_self    dq 0",10
db "",10
db "    idx_fmt     db '    idx0        dd   ',37,'d',0",10
db "    idx_search  db '    idx0        dd   ',0",10
db "    self_fn     db __FILE__,0",10
db "    src_fmt     db 'Sully_',37,'d.s',0",10
db "    triples     db 37,'s',37,'s',37,'s',0",10
db "    fmt1        db 100,98,32,34,37,115,34,44,49,48,10,0",10
db "    fmt2        db 100,98,32,34,37,115,34,44,49,48,44,48,10,0",10
db "    exec_fmt    db 'nasm -f macho64 Sully_',37,'d.s && cc -o Sully_',37,'d Sully_',37,'d.o && rm -f Sully*.o && ./Sully_',37,'d',0",10
db "    idx_str     times 64 db 0",10
db "    src_file    times 64 db 0",10
db "    exec_cmd    times 256 db 0",10
db "    open_mode   equ 644o",10
db "    open_flags  equ 0x601",10
db "self:",10,0
