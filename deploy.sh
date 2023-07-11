#!/bin/bash

# Remove old bin file
rm -rf boot.bin

# Create bin file
nasm -f bin -o boot.bin boot.asm

# Remove old floppy.img
rm -rf floppy.img

# Create floppy img
dd if=/dev/zero of=floppy.img bs=1024 count=1440
dd if=boot.bin of=floppy.img seek=0 count=1 conv=notrunc

# Remove dir iso
rm -rf iso/

# Remove myos.iso
rm -rf myos.iso

# Create iso
mkdir iso
cp floppy.img iso/
genisoimage -quiet -V 'MYOS' -input-charset iso8859-1 -o myos.iso -b floppy.img \
    -hide floppy.img iso/
