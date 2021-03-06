section .data
	msg1: db "Enter a string",10
	len1: equ $-msg1
	msg2: db "The given string is a palindrome",10
	len2: equ $-msg2
	msg3: db "The given string is not a palindrome",10
	len3: equ $-msg3
	
section .bss
	size: resw 1
	string: resb 100
	temp: resb 1

section .text
	global _start
_start:
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, len1
	int 80h 
	
	mov word[size], 0
	
	call read_string
	
	call palindrome
	
	call exit
	
read_string:
	pusha
	cld
	mov edi, string
	
loop:	
	mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h
	
	cmp byte[temp], 10
		je end_read
	
	inc word[size]
	mov al, byte[temp]
	stosb
	jmp loop
	
end_read:
	popa
ret

palindrome:
	pusha
	cld
	mov esi, string
	mov ebx, string
	mov ecx, 0
	mov cx, word[size]
	dec ecx
	cmp ecx,0
	je p
	
	l:
		LODSB
		cmp al,byte[ebx+ecx]
			jne end_loop
		loop l
	
	end_loop:
		cmp ecx, 0
			je p
		
		mov eax, 4
		mov ebx, 1
		mov ecx, msg3
		mov edx, len3
		int 80h
		popa
		ret
		
		p:
		mov eax, 4
		mov ebx, 1
		mov ecx, msg2
		mov edx, len2
		int 80h
		
	popa
ret

exit:
	mov eax, 1
	mov ebx, 0
	int 80h
	
