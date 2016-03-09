hello: hello.o
	ld -g -o $@ $<

%.o:%.nasm
	nasm -g -f elf64 $< -o $@
