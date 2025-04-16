[bits 16]
[org 0x7C00]

start:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Limpa a tela e configura modo vídeo
    mov ax, 0x0003
    int 0x10

    ; Mensagem de status
    mov si, loading_msg
    call print

    ; Carrega kernel em 0x1000:0000
    mov ax, 0x1000
    mov es, ax
    xor bx, bx
    mov ah, 0x02
    mov al, 4       ; 4 setores
    mov ch, 0       ; Cilindro 0
    mov cl, 2       ; Setor 2
    mov dh, 0       ; Cabeçote 0
    int 0x13
    jc error

    ; Pula para o kernel
    mov ax, 0x1000
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0xFFFE

    ; Pula para o kernel COM CONFIGURAÇÃO DE SEGMENTO
    push word 0x1000    ; Segmento
    push word 0x0000    ; Offset
    retf
    jmp 0x1000:0000

error:
    mov si, error_msg  ; Corrigido: usando rótulo direto
    call print
    jmp $

print:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print
.done:
    ret


loading_msg db "Carregando kernel...", 0
error_msg db "Erro de disco!", 0  ; Definido como rótulo direto

times 510-($-$$) db 0
dw 0xAA55
