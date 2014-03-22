[bits 64]

SECTION .text
global _start           ; the program entry point
extern printHexln
extern printDecln

_start:

    mov    rax, 0xFFFFFFFFFFFFFFFF      ; number for treatment
    call printDecln


    ; sys_exit(return_code)

    mov    rax, 60        ; sys_exit
    mov    rdi, 0        ; return 0 (success)
    syscall




