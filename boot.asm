;; Assembly Kernel Loader for PyKern

MAGIC_NUMBER equ 0x1BADB002     ; define the magic number constant
FLAGS        equ 0x0            ; multiboot flags
CHECKSUM     equ -MAGIC_NUMBER  ; calculate the checksum
                                ; (magic number + checksum + flags should equal 0)
KERNEL_STACK_SIZE equ 8192      ; size of stack in bytes

section .text                   ; Multiboot spec
        align 4
        dd MAGIC_NUMBER
        dd FLAGS
        dd CHECKSUM

global start                            
extern kmain  

start:                                          
    cli                                         
    mov esp, kernel_stack + KERNEL_STACK_SIZE
    call kmain
    hlt

section .bss
align 4                         
kernel_stack:                   
    resb KERNEL_STACK_SIZE