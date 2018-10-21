#!/bin/bash
gcc -g Colleen.c -o Colleen_c
nasm -g -f macho64 Colleen.asm -o Colleen_asm.o
gcc -g Colleen_asm.o -o Colleen_asm
