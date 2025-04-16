## kernel.c

It was a challenge to develop this because I have never used C

since I learned from assembler code by calling a main function in C.

I have only used pure C or assembler.

This code are totaly funcional and was tested with qemu.

make clean
make
make run

This will genereate a floppy disk image, floppy.img, to be loaded by qemu.
This image has boot.bin in sector 0, the bootstrap, it load kernel.bin a file that is
recorded into disk.

and you will see messages on the screen.

