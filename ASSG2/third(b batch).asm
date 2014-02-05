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
movzx ax,al 
mov bl 2
div 2
cmp ah,0
je l2
jmp for

l2: mov al,byte[num]
add al,30h
mov eax,4
mov ebx,1
mov ecx,num
mov edx,1
int 80h
sub al,31h
jmp for

    
exit: mov eax,1
mov ebx,0
int 80h

section .bss
num: resb 1
