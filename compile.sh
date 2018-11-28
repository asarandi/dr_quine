#!/bin/bash
gcc -g Colleen.c -o Colleen_c
nasm -g -f macho64 Colleen.asm -o Colleen_asm.o
gcc -g Colleen_asm.o -o Colleen_asm

rm -f a.out Grace_kid.c; gcc Grace.c ; ./a.out; ls -ltra Grac* ; md5 Grace.c Grace_kid.c 
