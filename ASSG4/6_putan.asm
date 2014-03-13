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
	check: resb 1
	flag: resb 1
section .text
	global _start
_start:
   mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h
mov word[sizew],0
mov byte[check],1
mov edi,str
cld


 read_word:
 
        mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h
	
	cmp byte[check],1
	je check_char
	checked:
	cmp byte[flag],1
	je put_an
	
	cmp byte[temp], ' '
	je set_check

	 cmp byte[temp], 10
	 je output
	 
	 jmp build
	 
	 set_check:
	 mov byte[check],1
	 
	 build:
	 mov al,byte[temp]
	 stosb
	 inc word[sizew]
	 jmp read_word
	 
	 put_an:
	 mov byte[flag],0
	 mov al,'a'
	 stosb
	 inc word[sizew]
	 mov al,'n'
	 stosb
	 inc word[sizew]
	 mov al,' '
	 stosb
	 inc word[sizew]
	 jmp build

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
mov dx, word[sizew]
int 80h
mov byte[temp],10
mov eax, 4
mov ebx, 1
mov ecx, temp
mov dx, 1
int 80h
     
     exit:
     mov eax, 1
     mov ebx, 0
     int 80h
	 
	 
	 
       check_char:
	
	mov byte[flag],0
	mov byte[check],0
	cmp byte[temp],'a'
	je set
	cmp byte[temp],'A'
	je set
	cmp byte[temp],'i'
	je set
	cmp byte[temp],'I'
	je set
	cmp byte[temp],'o'
	je set
	cmp byte[temp],'O'
	je set
	cmp byte[temp],'e'
	je set
	cmp byte[temp],'E'
	je set
	cmp byte[temp],'u'
	je set
	cmp byte[temp],'U'
	je set
	jmp leave
	set:
	mov byte[flag],1
	
	leave:
	jmp checked
	 
