section .data
message:  db "Input number(0<num<32767):"
msg_len equ $-message
even:  db "Given number is divisible by 2"
even_len equ $-even
odd:  db "Given number is not divisible by 2"
odd_len: equ $-odd

section .bss
  num: resw 1 
  temp: resb 2

section .txt

global _start
_start:

mov eax,4
mov ebx,1
mov ecx,message
mov edx,msg_len
int 80h
call read_num
call even_odd
exit:
  mov eax, 1
  mov ebx, 0
  int 80h



read_num:

  pusha
  mov word[num], 0
  
  read:
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h
    
    cmp byte[temp], 10
      je end
    
    mov ax, word[num]
    mov bx, 10
    mul bx
    mov bl, byte[temp]
    sub bl, 30h
    mov bh, 0
    add ax, bx
    mov word[num], ax
    jmp read 
  end:
  popa
ret

even_odd:
pusha
mov ax,word[num]
and ax,1h
cmp ax,0
je if_even
mov eax, 4
mov ebx, 1
mov ecx,odd
mov edx,odd_len
int 80h
jmp leave
if_even:
mov eax, 4
mov ebx, 1
mov ecx,even
mov edx,even_len
int 80h
jmp leave
leave: popa
       ret
