[bits 64]

SECTION .data
digit   db "0123456789ABCDEF",0x0A
digitlen     equ $ - digit
printend  equ 21 ; maximum of possible hex digit for 64-bit number + prefix'0x' + '\n'

SECTION .bss
printstring: times printend resb 1 ; bufer for place hex digit
SECTION .text

global printHexlnRegUnsafe
global printHexln
global printDeclnRegUnsafe
global printDecln

printHexlnRegUnsafe:
    ; @fn unsafe version of hex print, semantic is the same as in follow D code
    ; writefln("%X",a); // where a is input parameter of type ulong
    ;
    ; @param rax is input parameter

    ;
    ; rax for current hex digit
    ; rbx for start point of printstring
    ; rcx for current rest of number to print
    ; rdx for current digit code

    ; init rcx by input
    mov rcx, rax

    ;put '\n' to the end of printstring
    mov rbx, printend
    dec rbx
    mov rdx, 0xA
    mov byte [printstring +rbx], dl



L1: ; digit loop
    dec rbx
    mov rax, rcx
    shr rcx, 4
    and rax, 0xF ; curent digit by mask
    mov rdx, [digit + rax] ; calculate symbol for current digit
    mov byte [printstring+rbx], dl ; put low byte of rdx to printstring
    jrcxz L2 ; exit from loop when number in rcx == 0
    jmp L1

L2: ; end of loop
    ; generate prefix "0x"
    dec rbx
    mov rdx, 'x'
    mov byte [printstring+rbx], dl
    dec rbx
    mov rdx, '0'
    mov byte [printstring+rbx], dl

    ; print string to stdout
    mov    rax, 1        ; sys_write
    mov    rdi, 1        ; stdout
    mov    rsi, printstring    ; message address
    add    rsi, rbx  ; shift of begin
    mov    rdx, printend ; calculate of printlen = printend - rbx
    sub    rdx, rbx
    syscall

    ret


printHexln:
    ; @fn safe version of hex print, semantic is the same as in follow D code
    ; writefln("%X",a); // where a is input parameter of type ulong
    ;
    ; @param rax is input parameter

    ; save state of GPR
    push rax
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi
    push rbp
    push rsp
    push r8
    push r9
    push r10
    push r11

    call printHexlnRegUnsafe

    ; restore state of GPR
    pop r11
    pop r10
    pop r9
    pop r8
    pop rsp
    pop rbp
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rax

    ret

printDeclnRegUnsafe:
    ; @fn unsafe version of dec print, semantic is the same as in follow D code
    ; writefln("%d",a); // where a is input parameter of type ulong
    ;
    ; @param rax is input parameter

    ; init rcx by input ??
    mov rcx, rax

    ;put '\n' to the end of printstring
    mov rbx, printend
    dec rbx
    mov rdx, 0xA
    mov byte [printstring +rbx], dl

L3: ; digit loop
    dec rbx
    mov rax, rcx
    xor rdx, rdx
    mov rdi, 10
    div rdi
    mov rcx, rax
    mov rax, [digit + rdx] ; calculate symbol for current digit
    mov byte [printstring+rbx], al ; put low byte of rdx to printstring
    jrcxz L4 ; exit from loop when number in rcx == 0
    jmp L3

L4: ; end of loop

    ; print string to stdout
    mov    rax, 1        ; sys_write
    mov    rdi, 1        ; stdout
    mov    rsi, printstring    ; message address
    add    rsi, rbx  ; shift of begin
    mov    rdx, printend ; calculate of printlen = printend - rbx
    sub    rdx, rbx
    syscall

    ret

printDecln:
    ; @fn safe version of dec print, semantic is the same as in follow D code
    ; writefln("%d",a); // where a is input parameter of type ulong
    ;
    ; @param rax is input parameter

    ; save state of GPR
    push rax
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi
    push rbp
    push rsp
    push r8
    push r9
    push r10
    push r11

    call printDeclnRegUnsafe

    ; restore state of GPR
    pop r11
    pop r10
    pop r9
    pop r8
    pop rsp
    pop rbp
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rax

    ret







