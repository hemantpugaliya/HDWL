section .data
	msg1: db "Enter a string",10
	len1: equ $-msg1
	msg2: db "The number of spaces in the string are: "
	len2: equ $-msg2
	minus: db '-'
	
section .bss
	temp: resb 1
	size1: resw 1
	string: resb 200
	count: resw 1
	num: resw 1
	flag: resb 1
	sign: resb 1
	nod: resb 1
	
section .text
	global _start
_start:
	
	mov word[count], 0
	mov word[size1], 0
	
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
	
	mov ax, word[count]
	mov word[num], ax
	
	call print_num
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
	mov edi, string
	loop:
	mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h
	
	cmp byte[temp], 10
		je end_read
	inc word[size1]
	cmp byte[temp], ' '
		jne not_space
	inc word[count]
not_space:
	mov al, byte[temp]
	stosb
	jmp loop
	
	end_read:
		popa
ret
	
print_num:
  pusha
  cmp word[num],0
  je zero
 mov byte[nod],0
  extract_no:
    cmp word[num], 0
    je print_no
    inc byte[nod]
    mov edx, 0
    mov ebx,0
    mov ax, word[num]
    mov bx, 10
    div bx
    push dx
    mov word[num], ax
  jmp extract_no


  print_no:
    
    cmp byte[nod], 0
    je end_print
    dec byte[nod]
    pop dx
    mov byte[temp],dl
    add byte[temp], 30h


    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
    
    jmp print_no
    
 
 zero:
 mov byte[temp],30h
    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
end_print:   
  popa
  ret 

exit:
	mov eax, 1
	mov ebx, 0
	int 80h
	
