section .data
minus: db "-"
msg1: db "Please enter the no of elements in the array"
msg1_len: equ $-msg1
msg2: db "Please enter the first number whose occuremces is to be found "
msg2_len: equ $-msg2
msg3: db "Number with lesser occurences "
msg3_len: equ $-msg3
msg4: db "Please enter the second number whose occuremces is to be found "
msg4_len: equ $-msg4
msg5: db "Both have equal occurences "
msg5_len: equ $-msg5
newline: db " ",0Ah
space: db "   "

section .bss
    num: resw 1
    nod : resb 1
    temp: resb 1
    sign: resb 1
    occ1: resb 1
    occ2: resb 1
    array: resw 100
    noe:  resb 1
    searched_num1: resw 1
    searched_num2: resw 1
    
  section .txt
 global _start
 
 _start:
 mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, msg1_len
    int 80h
     
   call read_num
   mov ax,word[num]
   mov byte[noe],al
   
   mov ecx,0
   mov cl,byte[noe]
   mov edi,array
   cld
   
   input:
   call read_num
   mov ax,word[num]
   STOSW
   loop input
   
   call print_newline
   mov eax,4
   mov ebx, 1
   mov ecx, msg2
   mov edx, msg2_len
   int 80h
   call read_num
   mov ax,word[num] 
   mov word[searched_num1],ax
   
   call print_newline
   mov eax,4
   mov ebx, 1
   mov ecx, msg4
   mov edx, msg4_len
   int 80h
   call read_num
   mov ax,word[num] 
   mov word[searched_num2],ax
   
   mov byte[occ1],0
   mov byte[occ2],0
   
   mov ecx,0
   mov cl,byte[noe]
   mov esi,array
   cld
    
    search:
    LODSW
    cmp ax,word[searched_num1]
    jne else_if
    inc byte[occ1]
    jmp else
    else_if:
    cmp ax,word[searched_num2]
    jne else
    inc byte[occ2]
    else:
    loop search
    
   
   mov eax,0
   mov al,byte[occ1]
   cmp byte[occ2],al
   je equal
   jl num2
   mov ax,word[searched_num1]
   mov word[num],ax
   jmp show
   
   num2:
   mov ax,word[searched_num2]
   mov word[num],ax
   
   
   
 show:  mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, msg3_len
    int 80h
   call print_num
   call print_newline
   jmp exit
   
   equal:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg5
    mov edx, msg5_len
    int 80h
   
   jmp exit 
   
   
     



read_num:

  pusha
  mov word[num], 0
  mov eax,0
  mov byte[sign],0
  read:
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h
    
    cmp word[num],0
     jne cont
     cmp byte[temp],2dh
     je sign_detect


    
   cont:
     cmp byte[temp], 10
      je end
      
      cmp byte[temp],32
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
   sign_detect:
   mov byte[sign],1
   jmp read
  end:
  cmp byte[sign],1
  je sign_inv
  popa
  ret
  sign_inv:
  mov ax,word[num]
  mov bx,-1
  mul bx
  mov word[num],ax
  popa
  ret




print_num:
  pusha
  cmp word[num],0
  jl negative
  je zero
  resume: mov byte[nod],0
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
    
negative:
 call sign_invert
 jmp resume
 
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
 sign_invert:
  pusha
   mov eax, 4
    mov ebx, 1
    mov ecx, minus
    mov edx, 1
    int 80h
  mov ax,word[num]
  mov bx,-1
  mul bx
  mov word[num],ax
  popa
  ret
  
  print_newline:
  pusha
  mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 80h
  popa 
  ret
  print_space:
  pusha
  mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 3
    int 80h
  popa 
  ret

exit:       mov eax, 1
            mov ebx, 0
            int 80h