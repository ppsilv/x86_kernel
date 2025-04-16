
#Compiling.
# 0:     8088 and 8086 instructions.
# d0:    No debugging information.
# ml:    The "large" memory model (big code, big data) is selected.
# s:     Remove stack overflow checks.
# wx:    Set the warning level to its maximum setting.
# zl:    Suppress generation of library file names and references in object file.
# wcc -0 -d0 -ml -s -wx -zl kernel.c

# Linking.
# FILE:      Specify the object files.
# FORMAT:    Specify the format of the executable file.
# NAME:      Name for the executable file.
# OPTION:    Specify options.
# Note startup function (kernel_) implemented in kernel.c.
# wlink FILE kernel.obj FILE stub.obj FORMAT RAW BIN NAME kernel.bin OPTION NODEFAULTLIBS, START=_main



CC = wcc
ASM = nasm
LD = wlink

#CFLAGS = -0 -ms -zl -zq -we -d0 -bt=dos -fo=kernel.obj
CFLAGS = -0 -ms -zl -zq -we -d0 -fo=kernel.obj -zu

all: floppy.img

boot.bin: boot.asm
	$(ASM) -f bin $< -o $@

kernel.obj: kernel.c stub.obj
	$(CC) $(CFLAGS) kernel.c
	$(LD) @linker.lnk

stub.obj: stub.asm
	$(ASM) -f obj stub.asm -o stub.obj

kernel.bin: kernel.obj stub.obj linker.lnk
	$(LD) @linker.lnk
# ou esse linha abaixo
#	wlink FILE kernel.obj FILE stub.obj FORMAT RAW BIN NAME kernel.bin OPTION NODEFAULTLIBS, START=_main

floppy.img: boot.bin kernel.bin
	dd if=/dev/zero of=$@ bs=512 count=2880 status=none
	dd if=boot.bin of=$@ conv=notrunc status=none
	dd if=kernel.bin of=$@ bs=512 seek=1 conv=notrunc status=none

clean:
	rm -f *.o *.bin *.img *.map *.obj

run: floppy.img
	qemu-system-i386 -fda floppy.img
