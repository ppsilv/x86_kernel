; stub.asm
segment _TEXT class=CODE


global _main
_main:
    ; O código real está no kernel.c
    ret

global __STK
__STK:
    ; Símbolo dummy para o stack
    ret
