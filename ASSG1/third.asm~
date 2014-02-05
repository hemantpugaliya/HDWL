section .text
 global _start:
 
_start:
mov eax,3
mov ebx,0
mov ecx,num
mov edx,1
int 80h
mov al,byte[num]
sub al,31h


for: cmp al,0
je exit
jmp l1

l1: mov byte[num],al
    add byte[num],30h
    mov eax,4
    mov ebx,1
    mov ecx,num
    mov edx,1
    int 80h

    mov eax,4
    mov ebx,1
    mov ecx,space
    mov edx,3
    int 80h
    
    mov al,byte[num]
    sub al,31h
    jmp for
    
exit: mov eax,1
mov ebx,0
int 80h
section .data
messg: db "Please input a number(0<n<10):"
msg_len: equ $-messg
space: db "   "
section .bss
num: resb 1
