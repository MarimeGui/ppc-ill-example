/* Simple Linker script for the Wii */
/* Inspired by the one found in libogc ! */
/* Main reference: https://interrupt.memfault.com/blog/how-to-write-linker-scripts-for-firmware */
/* Also: https://github.com/rust-embedded/cortex-m-rt/blob/master/link.x.in */

MEM1_ORIGIN = 0x80000000;
MEM1_LENGTH = 0x1800000;

STACK_SIZE = 0x2000; /* 8kB TODO: Tune this */

SECTIONS {
    . = 0x80004000; /* Base Address, stuff before is specific, I think */

    .text : {
        *(.text*);
    }

    .rodata : ALIGN(4) {
        *(.rodata*);
    }

    .data : ALIGN(4) {
        *(.data*);
    }

    .eh_frame : ALIGN(4) {
        *(.eh_frame*);
    }

    .got2 : ALIGN(4) {
        *(.got2);
    }

    .bss (NOLOAD) : ALIGN(4) {
        _bss_start = .;
        *(.bss*);
        _bss_end = .;
    }

    .stack (NOLOAD) : ALIGN(4) {
        _stack_bottom = .;
        . = . + STACK_SIZE;
        _stack_top = .;
    }

    /* Heap over all available memory left in MEM1. Note that MEM2 is not exploited here, and is left to be handled by the library. */
    .m1heap (NOLOAD) : ALIGN(4) {
        _m1heap_bottom = .;
        _m1heap_size = MEM1_LENGTH - (. - MEM1_ORIGIN);
        . = . + _m1heap_size; /* Rest of memory */
        _m1heap_top = .;
    }

}
