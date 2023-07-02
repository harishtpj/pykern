OBJECTS = boot.o kernel.o
PYC = bin/pycer
PYFLAGS =  -m32 -fno-builtin -fno-stack-protector \
			 -Wall -Wextra -Werror -c
PYEXTRAFLAGS = -nostdlib -nostdinc -nostartfiles -nodefaultlibs 
LDFLAGS = -N -T linker.ld -melf_i386
AS = nasm
ASFLAGS = -f elf32

all: kernel os.iso

dev: kernel.cpp


kernel: $(OBJECTS)
	@ld $(LDFLAGS) $(OBJECTS) -o iso/boot/kernel
	@echo "--> Compiled Kernel"

os.iso: kernel
	@echo "--> Generating os.iso file"
	@genisoimage -R                              \
				-b boot/grub/stage2_eltorito    \
				-no-emul-boot                   \
				-boot-load-size 4               \
				-A pykern                       \
				-boot-info-table                \
				-o os.iso                       \
				iso
	@echo "--> Completed building OS"

%.o: %.py
	@$(PYC) $< $(PYFLAGS) -o $@
	@echo "--> Compiled $<"

%.cpp: %.py
	@$(PYC) -S $<
	@echo "--> Compiled $<"

%.o: %.asm
	@$(AS) $(ASFLAGS) $<
	@echo "--> Compiled $<"

clean:
	@rm -rf *.o iso/boot/kernel os.iso *.cpp