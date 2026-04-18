.section .text.init
.globl _start
_start:
    la sp, _stack_top
    j main

hang:
    j hang
