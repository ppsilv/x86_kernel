/*
 * Para compilar
 * wlink FILE kernel.obj FILE stub.obj FORMAT RAW BIN NAME kernel.bin OPTION NODEFAULTLIBS, START=_main
 *
 */

/* Ponto de entrada */
void _mainc(void);

/* Declaração da função de configuração */
#pragma aux setup_registers = \
    "mov ax, 0x1000" \
    "mov ds, ax"     \
    "mov es, ax"     \
    "mov ss, ax"     \
    "mov sp, 0xFFFE" \
    modify [ax];

/* Declaração da função de impressão */
#pragma aux print_msg = \
    "mov ah, 0x0E"     \
    "xor bh, bh"       \
    "print_loop:"      \
    "lodsb"           \
    "cmp al, 0"       \
    "je print_done"   \
    "int 0x10"        \
    "jmp print_loop"  \
    "print_done:"     \
    parm [si]         \
    modify [ax bh si];

/* Declaração da função halt */
#pragma aux cpu_halt = \
    "hlt"             \
    modify exact [];


void setup_registers();
void print_msg(const char msg[]);
void  cpu_halt();
/* String no mesmo segmento */
static const char msg[] = "\n\rKernel Loaded!";
/* Defina o segmento stack explicitamente */
unsigned short _STACK[16] = {0};
#pragma aux _STACK "*" /* Força o símbolo __STK */

void _mainc(void) {
    /* Configuração dos registradores */
    setup_registers();


    /* Imprime via BIOS */
    print_msg(msg);

    /* Loop infinito */
    print_msg("\n\rCPU halted...");
    while(1) {
        cpu_halt();
    }
}


