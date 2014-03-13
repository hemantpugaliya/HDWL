section .data
	msg1: db "Enter the  string:",10
	len1: equ $-msg1
	msg2: db "Enter the word:",10
	len2: equ $-msg2
	msg3: db "the string with all substrings removed:",10
	len3: equ $-msg3
	
	section .bss

temp: resb 1
sent: resb 500
str: resb 35
sizet: resw 1
sizew: resw 1
add1: resd 1
add2: resd 1
flag: resb 1
i:  resb 1
j: resb 1


section .text

global _start

_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

mov word[sizet],0
mov edi, sent
cld
	
	
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
        mov al, 0
	stosb

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h

mov word[sizew],0
mov edi, str
cld
	
	
loop1:	
	mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h
	
	cmp byte[temp], 10
		je end_read1
	
	inc word[sizew]
	mov al, byte[temp]
	stosb
	jmp loop1
	
end_read1:
        mov al, 0
	stosb

mov eax,0
mov esi,sent
cld

comp:
    lodsb
    cmp al,byte[str]
    je find_str
    jmp print
    
    find_str:
    mov dword[add1],esi
    dec dword[add1]
    call compare
    cmp byte[flag],1
    je addition
    jmp print
    
    addition:
    movzx ebx,word[sizew]
    dec ebx
    add esi,ebx
    jmp leave_check
    
    print:
        mov byte[temp],al
        push eax
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
pop eax

leave_check:
  cmp al,0
  jne comp
    
	
exit:	
mov eax, 1
mov ebx, 0
int 80h
	

compare:
pusha
mov eax,dword[add1]
mov ebx,str
mov byte[flag],0
movzx ecx,word[sizew]

check:

mov dl,byte[eax]
cmp dl,byte[ebx]
jne leave

inc eax
inc ebx

loop check

leave:
 cmp ecx,0
 je set
 jmp end_cmp
set:
mov byte[flag],1

end_cmp:
popa
ret
	
