section .text
    global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,string
mov edx,length
int 80h

mov eax,3
mov ebx,0
mov ecx,character
mov edx,1
int 80h

cmp byte[character],65
jl nothing
cmp byte[character],90
jng capson
cmp byte[character],97
jl nothing
cmp byte[character],122
jng capsnot
jmp nothing

nothing:
mov eax,4
mov ebx,1
mov ecx,string1
mov edx,length1
int 80h
jmp exit

capson:
mov eax,4
mov ebx,1
mov ecx,string2
mov edx,length2
int 80h
jmp exit

capsnot:
mov eax,4
mov ebx,1
mov ecx,string3
mov edx,length3
int 80h
jmp exit

exit:
mov eax,1
mov ebx,0
int 80h

section .data
string: db 'enter the character ',0ah
length: equ $-string
string1: db 'Please Enter an English Alphabet',0ah
length1: equ $-string1
string2: db 'capslock is on',0ah
length2: equ $-string2
string3: db 'capslock is off',0ah
length3: equ $-string3

section .bss
character: resb 1 
digit: resb 1
