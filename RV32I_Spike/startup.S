.section .text.init
.globl _start
_start:
    la  sp, _stack_top

    /* Zero .bss */
    la  t0, __bss_start
    la  t1, __bss_end
1:
    bgeu t0, t1, 2f
    sw   zero, 0(t0)
    addi t0, t0, 4
    j    1b

    /* Copy .data */
2:
    la  t0, __data_load_start
    la  t1, __data_start
    la  t2, __data_end
3:
    bgeu t1, t2, 4f
    lw   t3, 0(t0)
    sw   t3, 0(t1)
    addi t0, t0, 4
    addi t1, t1, 4
    j    3b

    /* Set trap vector to FreeRTOS trap handler */
4:
    la   t0, freertos_risc_v_trap_handler
    csrw mtvec, t0

    call main

hang:
    j hang
