ENTRY(_start)

SECTIONS
{
    . = 0x80000000;

    .text : {
        *(.text.init)
        *(.text*)
        *(.rodata*)
    }

    .data : {
        *(.data*)
        *(.sdata*)
    }

    .bss : {
        *(.bss*)
        *(.sbss*)
        *(COMMON)
    }

    . = ALIGN(16);
    . += 0x1000;
    _stack_top = .;
}
