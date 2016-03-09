base: base.o
	ld -g -o $@ $<

%.o:%.nasm
	nasm -g -f elf64 -F dwarf $< -o $@
