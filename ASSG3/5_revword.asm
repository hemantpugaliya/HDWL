section .data
	msg1: db "Enter a string",10
	len1: equ $-msg1
	msg2: db "The string with each word reversed",10
	len2: equ $-msg2
	
section .bss
	temp: resb 1
	sizet: resw 1
	str: resb 500
	stword: resb 30
	sizew: resw 1
section .text
	global _start
_start:
   mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h
mov word[sizet],0

loop_read:
mov edi,stword
cld
mov word[sizew],0
 read_word:
 
        mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h
	
	cmp byte[temp], ' '
	 je end_word

	 
	 cmp byte[temp], 10
	 je end_word
	 
	 mov al,byte[temp]
	 stosb
	 inc word[sizew]
	 jmp read_word
	 
    end_word:
     mov edi,str
     movzx eax,word[sizet]
     add edi,eax
     mov esi,stword
     movzx eax,word[sizew]
     add esi,eax
     sub esi,1
     movzx ecx,word[sizew]
     
     copy:
     mov al,byte[esi]
     mov byte[edi],al
     dec esi
     inc edi
     loop copy
    
     mov ax,word[sizew]
     add word[sizet],ax
     cmp byte[temp],10
     je output
     
     mov byte[edi],' '
     inc word[sizet]
     jmp loop_read
     
     output:
 mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h

mov edx,0
     
mov eax, 4
mov ebx, 1
mov ecx, str
mov dx, word[sizet]
int 80h
     
     exit:
     mov eax, 1
     mov ebx, 0
     int 80h
	
