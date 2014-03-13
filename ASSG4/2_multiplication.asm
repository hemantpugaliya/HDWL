section .data
str1 : dw 'Enter elements of the matrix : ', 0Ah
size1 : equ $-str1
str3 : dw 'Enter the number of rows : ', 0Ah
size3 : equ $-str3
str2 : dw 0Ah
str4 : dw '-'
str5 : dw ' '
str6 : dw 'Enter the number of columns: ', 0Ah
size6 : equ $-str6
str7 : dw 'Multiplication of two Matrix :', 0Ah
size7 : equ $-str7
str31 : dw 'Matrix multiplication is not possible', 0Ah
size31 : equ $-str31

section .bss
var : resd 1
var1 : resd 1
var2 : resd 1
array : resd 100
array1 : resd 100
count : resb 1
row : resd 1
bool : resb 1
pos : resd 1
temp : resd 1
tmp : resd 1
column : resd 1
loose : resd 1
paper : resd 1
go : resd 1
row1 : resd 1
column1 : resd 1
array2 : resd 100
temp1 : resd 1
i : resd 1
j : resd 1
pos1 : resd 1
multi : resd 1
pos2 : resd 1
temp2 : resd 1
temp3 : resd 1

section .text
global _start:
_start:

mov eax, 4   	
mov ebx, 1
mov ecx, str3
mov edx, size3
int 80h

mov byte[bool], 0
mov dword[var2], 0
call func_read
mov eax, dword[var2]
mov dword[row], eax
;mov dword[var1], eax

mov eax, 4   	
mov ebx, 1
mov ecx, str6
mov edx, size6
int 80h

mov byte[bool], 0
mov dword[var2], 0
call func_read
mov eax, dword[var2]
mov dword[column], eax
;mov dword[var1], eax

mov eax, 4   	
mov ebx, 1
mov ecx, str1
mov edx, size1
int 80h

mov ecx, dword[row]
mov dword[pos], 0

input:
    mov dword[loose], ecx
    mov ecx, dword[column]
    for2:
        mov byte[bool], 0
        mov dword[var2], 0
    
        call func_read

        mov edx, dword[pos]
    	mov ebx, array
    	mov eax, dword[var2]
    	mov dword[ebx + 4 * edx], eax
    	inc dword[pos]
    
    loop for2

    mov ecx, dword[loose]

loop input

mov eax, 4   	
mov ebx, 1
mov ecx, str3
mov edx, size3
int 80h

mov byte[bool], 0
mov dword[var2], 0
call func_read
mov eax, dword[var2]
mov dword[row1], eax
;mov dword[var1], eax

mov eax, 4   	
mov ebx, 1
mov ecx, str6
mov edx, size6
int 80h

mov byte[bool], 0
mov dword[var2], 0
call func_read
mov eax, dword[var2]
mov dword[column1], eax
;mov dword[var1], eax

mov eax, 4   	
mov ebx, 1
mov ecx, str1
mov edx, size1
int 80h

mov ecx, dword[row1]
mov dword[pos], 0

input1:
    mov dword[loose], ecx
    mov ecx, dword[column1]
    for21:
        mov byte[bool], 0
        mov dword[var2], 0
    
        call func_read
        mov edx, dword[pos]
    	mov ebx, array1
    	mov eax, dword[var2]
    	mov dword[ebx + 4 * edx], eax
    	inc dword[pos]
    
    loop for21

    mov ecx, dword[loose]

loop input1

mov eax, dword[column]
cmp eax, dword[row1]
jne error

mov ecx, dword[row]
mov dword[pos], 0
mov dword[i], 0

input31:
    mov dword[loose], ecx
    mov ecx, dword[column1]
    mov dword[j], 0
    for41:
        mov byte[bool], 0
        mov dword[var2], 0
    
        call func_multiply

        mov edx, dword[pos]
    	mov ebx, array2
    	mov eax, dword[var2]
    	mov dword[ebx + 4 * edx], eax
    	inc dword[pos]
        inc dword[j]
    
    loop for41

    mov ecx, dword[loose]
    inc dword[i]

loop input31

;mov ecx, dword[size]
;mov dword[pos], 0
;
;input:
;    mov byte[bool], 0
;    mov dword[var2], 0
;    
;    call func_read
;
;    mov edx, dword[pos]
;    mov ebx, array
;    mov eax, dword[var2]
;    mov dword[ebx + 4 * edx], eax
;
;    inc dword[pos]
;    
;    loop input

;mov ecx, dword[size]
;mov dword[pos], 0
;
;output: 
;    mov byte[bool], 0
;    mov byte[count], 0
;    
;    mov edx, dword[pos]
;    mov ebx, array
;    mov eax, dword[ebx + 4 * edx]
;    mov dword[var1], eax
;
;    call func_print
;
;    inc dword[pos]
;    
;    loop output

mov eax, 4   	
mov ebx, 1
mov ecx, str7
mov edx, size7
int 80h

jmp lack

error:
    mov eax, 4   	
    mov ebx, 1
    mov ecx, str7
    mov edx, size7
    int 80h
    mov eax, 4   	
    mov ebx, 1
    mov ecx, str31
    mov edx, size31
    int 80h

    jmp exit

lack:
mov ecx, dword[row]
mov dword[pos], 0
mov dword[paper], 0

output:
    mov dword[loose], ecx
    mov ecx, dword[column1]

    for1:
        mov byte[bool], 0
        mov byte[count], 0
    
        mov edx, dword[paper]
        mov ebx, array2
        mov eax, dword[ebx + 4 * edx]
        mov dword[var1], eax

        call func_print
        mov dword[go], ecx
        call func_space
        mov ecx, dword[go]
        inc dword[paper]
    loop for1
    call func_enter
    mov ecx, dword[loose]
    inc dword[pos]

loop output

jmp exit

func_multiply:
    mov dword[temp1], ecx
    mov eax, dword[i]
    mov edx, 0
    mov ebx, dword[column]
    mul ebx
    mov dword[pos1], eax
    mov eax, dword[j]
    mov dword[pos2], eax
    mov dword[var2], 0
    mov ecx, dword[column]
    for33:
        mov dword[temp2], ecx
        mov ebx, array
        mov eax, dword[pos1]
        mov ecx, dword[ebx + 4 * eax]
        mov ebx, array1
        mov eax, dword[pos2]
        mov edx, dword[ebx + 4 * eax]
        mov eax, edx
        mov edx, 0
        mul ecx
        add dword[var2], eax
        inc dword[pos1]
        mov eax, dword[column1]
        add dword[pos2], eax
        mov ecx, dword[temp2]
        loop for33

    return11:
        mov ecx, dword[temp1]
        ret

func_space:
    mov eax, 4
    mov ebx, 1
    mov ecx, str5
    mov edx, 1
    int 80h

    ret

func_enter:
    mov eax, 4
    mov ebx, 1
    mov ecx, str2
    mov edx, 1
    int 80h

    ret

func_read:

    mov dword[temp], ecx

	mov eax, 3
   	mov ebx, 0
   	mov ecx, var
   	mov edx, 1
   	int 80h
   	
   	cmp dword[var], '-'
   	jne adding
   	mov byte[bool], 1
   	
	subtract:
    	mov eax, 3
    	mov ebx, 0
    	mov ecx, var
    	mov edx, 1
    	int 80h

    	cmp dword[var], 0Ah
    	je  compare
    	
    	cmp dword[var],' '
    	je  compare
    	
        mov eax, dword[var2]
    	mov ebx, 10
    	mov edx, 0
    	mul ebx
    	mov dword[var2], eax
    	
    	adding:
    		mov eax, dword[var]
    		sub eax, 30h
    		add dword[var2], eax
    	
    	jmp subtract
    	
    compare:
    	cmp byte[bool], 1
    	jne return
    	mov edx, 0
    	mov eax, dword[var2]
    	mov ecx, -1
    	mul ecx
    	mov dword[var2], eax
    
    return:
        mov ecx, dword[temp]
    	ret

func_print:    
    mov dword[temp], ecx

    cmp dword[var1], 0
    jl negative

    print:
        mov eax, dword[var1]
        mov edx, 0
        mov ecx, 10
        div ecx
        push dx
        inc byte[count]

        cmp eax, 0
        je dg

        mov dword[var1], eax
        jmp print

    negative:
        mov byte[bool], 1
        neg dword[var1]
        jmp print

    dg:
        cmp byte[bool], 1
        jne eve

	    mov eax, 4
   	    mov ebx, 1
    	mov ecx, str4
   	    mov edx, 1
   	    int 80h

    eve:
        pop dx
        movzx ecx, dx
        mov dword[var1], ecx
        add dword[var1], 30h

	    mov eax, 4
   	    mov ebx, 1
    	mov ecx, var1
   	    mov edx, 1
   	    int 80h

        dec byte[count]
        cmp byte[count], 0
        jne eve

    returns:
	    mov eax, 4
   	    mov ebx, 1
    	mov ecx, str5
   	    mov edx, 1
   	    int 80h

        mov ecx, dword[temp]
        ret

;ent:
;    mov eax, 4
;    mov ebx, 1
;    mov ecx, str2
;    mov edx, 1
;    int 80h

exit:
	mov eax, 1
	mov ebx, 0
	int 80h
