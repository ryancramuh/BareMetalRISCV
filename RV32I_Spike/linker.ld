ENTRY(_start)

MEMORY
{
    RAM (rwx) : ORIGIN = 0x80000000, LENGTH = 128K
}

SECTIONS
{
    . = ORIGIN(RAM);

    .text : ALIGN(4)
    {
        *(.text.init)
        *(.text*)
        *(.rodata*)
    } > RAM

    . = ALIGN(4);
    __data_load_start = LOADADDR(.data);

    .data : ALIGN(4)
    {
        __data_start = .;
        *(.data*)
        *(.sdata*)
        __data_end = .;
    } > RAM

    .bss : ALIGN(4)
    {
        __bss_start = .;
        *(.bss*)
        *(.sbss*)
        *(COMMON)
        __bss_end = .;
    } > RAM

    . = ALIGN(16);
    . += 0x4000;      /* main stack */
    _stack_top = .;
}
