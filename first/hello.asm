[64 bits]

SECTION .data
msg     db "Hello, world!",0xa
len     equ $ - msg
SECTION .text
global _start           ; the program entry point
_start:
        mov rax, 1      ; 'write' syscall
        mov rdi, 1      ; file descr. 1 (stdout)
        mov rsi, msg    ; pointer to the data
        mov rdx, len    ; amount of data
        syscall        ; call to the kernel

        mov rax, 60      ; '_exit' syscall
        mov rbx, 0      ; zero exit code (success)
        syscall        ; call to the kernel
