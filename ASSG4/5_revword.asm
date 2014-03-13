section .data
	msg1: db "Enter a string",10
	len1: equ $-msg1
	msg2: db "The string with each word reversed",10
	len2: equ $-msg2
	minus: db "-"
	
section .bss
	temp: resb 1
	sizet: resw 1
	str: resb 500
	stword: resb 30
	sizew: resw 1
	flag: resb 1
	char: resb 1
section .text
	global _start
_start:
   mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

mov byte[flag],0
mov word[sizet],0
	cld
	mov edi, str
	
loop:	
	mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h
	
	cmp byte[temp], 10
		je end_read
	
	inc word[sizet]
	mov al, byte[temp]
	stosb
	jmp loop
	
end_read:
        mov al, byte[temp]
	stosb

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h
	
mov esi,str
cld

loop_read:
mov word[sizew],0

 read_word:
          
         mov eax,0
	 lodsb
	 cmp al, ' '
	 je end_word

	 
	 cmp al, 10
	 je end_prog
	 
	 movzx eax,al
	 push eax
	 inc word[sizew]
	 
	 jmp read_word
	
end_prog:
mov byte[flag],1
	 
    end_word:
     
     print_char:
      pop eax
      mov byte[temp],al
      mov eax, 4
      mov ebx, 1
      mov ecx, temp
      mov edx, 1
      int 80h
      dec word[sizew]
      cmp word[sizew],0
      jne print_char
      
      cmp byte[flag],1
      je exit
      
      mov byte[char],' '
      mov eax, 4
      mov ebx, 1
      mov ecx, char
      mov edx, 1
      int 80h
   
     jmp loop_read
     
     
     
  
 
  
     exit:
     mov byte[char],10
      mov eax, 4
      mov ebx, 1
      mov ecx, char
      mov edx, 1
      int 80h
     mov eax, 1
     mov ebx, 0
     int 80h
	
