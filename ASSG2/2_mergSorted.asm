section .data
minus: db "-"
msg1: db "Please enter the no of elements in the array1(0<n<50):"
msg1_len: equ $-msg1
msg2: db "Please enter the no of elements in the array2(0<n<50):"
msg2_len: equ $-msg2
msg3: db "The Merged Array is: "
msg3_len: equ $-msg3
newline: db " ",0Ah
space: db "   "

section .bss
    num: resw 1
    nod : resb 1
    temp: resb 1
    sign: resb 1
    array1: resw 50
    noe1:  resb 1
    array2: resw 50
    noe2:  resb 1
    arrayf: resw 100
    ctrf: resw 1
    ind1:resb 1
    ind2:resb 1
    indf:resb 1
    
    
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
   mov byte[noe1],al
   
   mov ecx,0
   mov cl,byte[noe1]
   mov edi,array1
   cld
   
   input1:
   call read_num
   mov ax,word[num]
   STOSW
   loop input1
   
   call print_newline
   
   mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, msg2_len
    int 80h
     
   call read_num
   mov ax,word[num]
   mov byte[noe2],al
   
   mov ecx,0
   mov cl,byte[noe2]
   mov edi,array2
   cld
   
   input2:
   call read_num
   mov ax,word[num]
   STOSW
   loop input2
   
   mov ecx,array1
   mov edx,array2
   mov byte[ind1],0
   mov byte[ind2],0
   mov byte[indf],0
   mov edi,arrayf
   cld
  merge:
  mov ax,word[ecx]
  mov bx,word[edx]
  cmp ax,bx
  jl copy_first
   mov ax,bx
   STOSW
   add edx,2
   inc byte[indf]
   inc byte[ind2]
   jmp end_m
   
   copy_first:
   STOSW
   add ecx,2
   inc byte[indf]
   inc byte[ind1]
  
  end_m:
  mov al,byte[noe1]
  mov bl,byte[noe2]
  cmp al,byte[ind1]
  je first_comp
  cmp bl,byte[ind2]
  je sec_comp
  jmp merge
  
  first_comp:
  mov ax,word[edx]
  STOSW
  add edx,2
  inc byte[indf]
  inc byte[ind2]
  mov al,byte[noe2]
  cmp al,byte[ind2]
  jne first_comp
  jmp print
  
 sec_comp:
  mov ax,word[ecx]
  STOSW
  add ecx,2
  inc byte[indf]
  inc byte[ind1]
  mov al,byte[noe1]
  cmp al,byte[ind2]
  jne sec_comp
  jmp print
  
 print: 
  mov eax,4
   mov ebx, 1
   mov ecx, msg3
   mov edx, msg3_len
   int 80h
   call print_newline
   
   mov eax,0
   mov ecx,0
   mov cl,byte[indf]
   mov esi,arrayf
   cld
   
   output:
    LODSW
    mov word[num],ax
    call print_num
    call print_space
   loop output
   
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
     cmp byte[temp],0Ah
      je end
      cmp byte[temp],20h
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
