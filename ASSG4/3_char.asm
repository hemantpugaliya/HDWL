section .data
	msg1: db "Enter a string",10
	len1: equ $-msg1
	msg2: db "The string with characters only",10
	len2: equ $-msg2
	
section .bss
	temp: resb 1
	size1: resw 1
	string: resb 200
	
section .text
	global _start
_start:
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, len1
	int 80h
	
	call read_string
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, len2
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, string
	mov edx, size1
	int 80h
	
	mov byte[temp],0Ah
	mov eax, 4
	mov ebx, 1
	mov ecx, temp
	mov edx, 1
	int 80h
	call exit
	
read_string:
	pusha
	cld
	mov word[size1], 0
	mov edi, string

loop:	
	mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h
	
	cmp byte[temp], 10
	 je end_read
	
	cmp byte[temp], 'A'
		jb no_count
	cmp byte[temp], 'Z'
		jb count
	cmp byte[temp],'a'
	jb no_count
	
	cmp byte[temp],'z'
	ja no_count
	
	
	count:
	inc word[size1]
	mov al, byte[temp]
	stosb
	
	no_count:
		jmp loop
	
	end_read:
		popa
	ret

exit:
	mov eax, 1
	mov ebx, 0
	int 80h
	
